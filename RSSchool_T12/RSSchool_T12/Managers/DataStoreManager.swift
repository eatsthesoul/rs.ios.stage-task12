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
    func fetchWallet(with id: NSManagedObjectID) -> Wallet?
    func createNewWallet(from walletData: WalletSettingsViewModel)
    func deleteWallet(_ wallet: Wallet)
    func updateWallet(_ wallet: Wallet, with newWallet: WalletSettingsViewModel)
    func doesWalletTitleExists(_ title: String) -> Bool
    func lastChangeDate(for wallet: Wallet) -> Date?
}

class DataStoreManager: DataStoreProtocol {
    
    // MARK: - Nested types
    
    private enum Constants {
        static let walletEntityName = "Wallet"
    }
    
    // MARK: Properties

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RSSchool_T12")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    // MARK: - DataStoreProtocol
    
    func fetchWallets() -> [Wallet] {
        let fetchRequest = Wallet.fetchRequest()
        let wallets = try? viewContext.fetch(fetchRequest)
        return wallets ?? []
    }
    
    func fetchWallet(with id: NSManagedObjectID) -> Wallet? {
        let context = viewContext
        guard let wallet = try? context.existingObject(with: id) as? Wallet else { return nil }
        return wallet
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
    
    func deleteWallet(_ wallet: Wallet) {
        let context = viewContext
        let object = viewContext.object(with: wallet.objectID)
        context.delete(object)
        context.saveContext()
    }
    
    func updateWallet(_ wallet: Wallet, with newWallet: WalletSettingsViewModel) {
        let context = viewContext
        let wallet = try? context.existingObject(with: wallet.objectID) as? Wallet
        wallet?.colorTheme = newWallet.colorTheme
        wallet?.currencyCode = newWallet.currencyCode
        wallet?.title = newWallet.title
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
        guard let wallet = try? context.existingObject(with: wallet.objectID) as? Wallet else { return nil }
        guard let transactions = wallet.transactions else { return nil }
        
        var date: Date? = nil
        transactions.forEach { transaction in
            guard let transaction = transaction as? Transaction else { return }
            let newDate = transaction.date
            date = date == nil || date! > newDate ? newDate : date
        }
        
        return date
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
