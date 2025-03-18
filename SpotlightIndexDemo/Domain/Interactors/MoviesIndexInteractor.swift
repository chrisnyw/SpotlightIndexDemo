//
//  MoviesIndexInteractor.swift
//  SpotlightIndexDemo
//
//  Created by Chris Ng on 2025-03-11.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

struct SpotlightModel {
    let id: String
    var title: String
    var content: String
    var keywords: [String]
}


//
//  UserItemSearch.swift
//  ArkSpace
//
//  Created by Chris Ng on 3/4/2017.
//  Copyright © 2017 Ark Space. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices


protocol IndexingProtocol {
    static var indexingUniqueIdentifierPrefix: String { get }
    var indexingUniqueIdentifier: String { get }
    var searchableItem: CSSearchableItem { get }
}

extension Movie: IndexingProtocol {
    public static let domainIdentifier = "com.chris.indexingDemo.movie"
    
    static var indexingUniqueIdentifierPrefix: String {
        return "movie"
    }
    
    var indexingUniqueIdentifier: String {
        return "\(Self.indexingUniqueIdentifierPrefix)|\(self.id)"
    }
    
    var searchableItem: CSSearchableItem {
        return CSSearchableItem(uniqueIdentifier: self.indexingUniqueIdentifier, domainIdentifier: Self.domainIdentifier, attributeSet: self.attributeSet)
    }
    
    
//    var userActivity: NSUserActivity {
//        let activity = NSUserActivity(activityType: UserItem.domainIdentifier)
//        activity.title = title
//        activity.userInfo = userActivityUserInfo
////        activity.keywords = [email, department]
//        activity.contentAttributeSet = attributeSet
//        
//        activity.isEligibleForSearch = true
//        activity.isEligibleForHandoff = false
//        
//        return activity
//    }
//
    
    private var attributeSet: CSSearchableItemAttributeSet {
        let attributeSet = CSSearchableItemAttributeSet(contentType: .content)
        attributeSet.title = self.title
        attributeSet.contentDescription = self.description
        attributeSet.relatedUniqueIdentifier = self.id.uuidString
        
//        attributeSet.keywords
        attributeSet.thumbnailURL = URL(string: self.image)
        
        return attributeSet
    }
}

protocol SpotlightIndexServiceProtocol {
    func indexSearchableItems(_ anyItems: [IndexingProtocol]) async throws
    func deleteSearchableItems(_ anyItems: [IndexingProtocol]) async throws
    func deleteSearchableItems(withDomainIdentifiers domainIdentifiers: [String]) async throws
    func deleteAllIndexing() async
}
    

class SpotlightIndexService: SpotlightIndexServiceProtocol {
    private let searchableIndex = CSSearchableIndex.default()
    
    private func indexSearchableItems(_ searchableItems: [CSSearchableItem]) async throws {
        do {
            try await self.searchableIndex.indexSearchableItems(searchableItems)
            debugPrint("Items indexed with ids: \(searchableItems.map(\.uniqueIdentifier))")
        } catch {
            debugPrint("error in indexing item: \(error.localizedDescription)")
            throw error
        }
    }
    
    private func deleteSearchableItems(withIdentifiers identifiers: [String]) async {
        do {
            try await self.searchableIndex.deleteSearchableItems(withIdentifiers: identifiers)
            debugPrint("Search item successfully removed! with ids: \(identifiers)")
        } catch {
            debugPrint("Deindexing error: \(error.localizedDescription), for ids: \(identifiers)")
        }
    }
    
    func indexSearchableItems(_ anyItems: [IndexingProtocol]) async throws {
        try await self.indexSearchableItems(anyItems.map { $0.searchableItem })
    }
    
    func deleteSearchableItems(_ anyItems: [IndexingProtocol]) async {
        await self.deleteSearchableItems(withIdentifiers: anyItems.map { $0.indexingUniqueIdentifier })
    }
    
    func deleteSearchableItems(withDomainIdentifiers domainIdentifiers: [String]) async throws {
        do {
            try await self.searchableIndex.deleteSearchableItems(withDomainIdentifiers: domainIdentifiers)
            debugPrint("Search item successfully removed! with domain ids: \(domainIdentifiers)")
        } catch {
            debugPrint("Deindexing error: \(error.localizedDescription), for domain ids: \(domainIdentifiers)")
            throw error
        }
    }
    
    func deleteAllIndexing() async {
        do  {
            try await self.searchableIndex.deleteAllSearchableItems()
            debugPrint("Search item all successfully removed!")
        } catch {
            debugPrint("Deindexing all error: \(error.localizedDescription)")
        }
    }
}
