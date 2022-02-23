//
//  DataStoreManager.swift
//  RSSchool_T12
//
//  Created by Evgeniy Petlitskiy on 4.02.22.
//

import Foundation
import CoreData

protocol DataStoreProtocol {
    func fetchWallets() -> [Wallet]
    func fetchTransactions(for wallet: Wallet) -> [Transaction]
    func fetchTransaction(with id: NSManagedObjectID) -> Transaction?
    
    func createNewWallet(from walletData: WalletSettingsViewModel)
    func createNewTransaction(_ transaction: TransactionSettingsViewModel, for wallet: Wallet)
    
    func updateWallet(_ wallet: Wallet, with newWallet: WalletSettingsViewModel)
    func updateTransaction(_ transaction: Transaction, with newTransaction: TransactionSettingsViewModel)
    
    func deleteWallet(_ wallet: Wallet)
    func deleteTransaction(_ transaction: Transaction, from wallet: Wallet)
    
    func doesWalletTitleExists(_ title: String) -> Bool
    
    func lastChangeDate(for wallet: Wallet) -> Date?
    
    func totalBalance(for wallet: Wallet) -> Decimal
}

class DataStoreManager: DataStoreProtocol {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let walletEntityName = "Wallet"
    }
    
    // MARK: - Properties
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RSSchool_T12")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    // MARK: - Singleton
    
    static let shared = DataStoreManager()
    
    // MARK: - Initialization and deinitialization
    
    private init() {

    }
    
    // MARK: - DataStoreProtocol
    
    func fetchWallets() -> [Wallet] {
        let fetchRequest = Wallet.fetchRequest()
        let wallets = try? viewContext.fetch(fetchRequest)
        return wallets ?? []
    }
    
    func fetchTransactions(for wallet: Wallet) -> [Transaction] {
        
        let context = viewContext
        guard let wallet = context.object(with: wallet.objectID) as? Wallet else { return [] }
        guard let transactions = wallet.transactions?.array as? [Transaction] else { return [] }
        
        return transactions.sorted { $0.date > $1.date }
    }
    
    func fetchTransaction(with id: NSManagedObjectID) -> Transaction? {
        let context = viewContext
        guard let transaction = context.object(with: id) as? Transaction else { return nil }
        return transaction
    }
    
    func createNewWallet(from walletData: WalletSettingsViewModel) {
        
        let context = viewContext
        
        let wallet = Wallet(context: context)
        wallet.currencyCode = walletData.currencyCode
        wallet.colorTheme = walletData.colorTheme
        wallet.title = walletData.title
        wallet.transactions = []
        
        context.saveContext()
    }
    
    func createNewTransaction(_ transaction: TransactionSettingsViewModel, for wallet: Wallet) {
        
        let context = viewContext
        guard let wallet = context.object(with: wallet.objectID) as? Wallet else { return }
        
        let newTransaction = Transaction(context: viewContext)
        newTransaction.wallet = wallet
        newTransaction.date = Date() //setup current date
        newTransaction.isOutcome = transaction.isOutcome
        newTransaction.note = transaction.note
        newTransaction.sum = NSDecimalNumber(string: transaction.change)
        newTransaction.title = transaction.title
        newTransaction.type = transaction.type
        
        wallet.addToTransactions(newTransaction)
        context.saveContext()
    }
    
    func updateWallet(_ wallet: Wallet, with newWallet: WalletSettingsViewModel) {
        
        let context = viewContext
        
        let wallet = context.object(with: wallet.objectID) as? Wallet
        wallet?.colorTheme = newWallet.colorTheme
        wallet?.currencyCode = newWallet.currencyCode
        wallet?.title = newWallet.title
        
        context.saveContext()
    }
    
    func updateTransaction(_ transaction: Transaction, with newTransaction: TransactionSettingsViewModel) {
        
        let context = viewContext
        let transaction = context.object(with: transaction.objectID) as? Transaction
        
        transaction?.isOutcome = newTransaction.isOutcome
        transaction?.note = newTransaction.note
        transaction?.sum = NSDecimalNumber(string: newTransaction.change)
        transaction?.title = newTransaction.title
        transaction?.type = newTransaction.type
        
        context.saveContext()
    }
    
    func deleteWallet(_ wallet: Wallet) {
        let context = viewContext
        let object = context.object(with: wallet.objectID)
        context.delete(object)
        context.saveContext()
    }
    
    func deleteTransaction(_ transaction: Transaction, from wallet: Wallet) {
        let context = viewContext
        let wallet = context.object(with: wallet.objectID) as? Wallet
        wallet?.removeFromTransactions(transaction)
        context.saveContext()
    }
    
    func doesWalletTitleExists(_ title: String) -> Bool {
        
        let fetchRequest = NSFetchRequest<Wallet>(entityName: Constants.walletEntityName)
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        
        let context = viewContext
        guard let wallets = try? context.fetch(fetchRequest) else { return false }
        
        return wallets.count > 0
    }
    
    func lastChangeDate(for wallet: Wallet) -> Date? {
        
        let context = viewContext
        
        guard let wallet = context.object(with: wallet.objectID) as? Wallet else { return nil }
        guard let transactions = wallet.transactions else { return nil }
        
        var date: Date? = nil
        transactions.forEach { transaction in
            guard let transaction = transaction as? Transaction else { return }
            let newDate = transaction.date
            date = date == nil || date! > newDate ? newDate : date
        }
        
        return date
    }
    
    func totalBalance(for wallet: Wallet) -> Decimal {
        
        let context = viewContext
        
        guard let wallet = context.object(with: wallet.objectID) as? Wallet else { return 0 }
        guard let transactions = wallet.transactions?.array as? [Transaction] else { return 0 }
        
        var balance: Decimal = 0
        transactions.forEach { transaction in
            switch transaction.isOutcome {
            case true:
                balance -= transaction.sum.decimalValue
            case false:
                balance += transaction.sum.decimalValue
            }
        }
        
        return balance
    }
    
}

extension NSManagedObjectContext {
    
    func saveContext() {
        do {
            try save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
