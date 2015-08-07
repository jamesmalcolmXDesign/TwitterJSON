//
//  TJTweet.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
Object that deals with sending requets to the Twitter api to do with retrieving Tweets.
When methods are called they return an array of TJTweet objects to the completion handler.
*/
public class TJTweets {
    
    /**
    Object that performs the final network requests.
    */
    public let twitterJSON: TwitterJSON!
    
    /**
    Initialize with api and api secret keys from twitter.
    */
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
    }
    
    /**
    Gets the most recent tweets of the user specified in the parameter. An array of TJTweet objects are
    passed into the completion handler.
    
    :param: String Screen name of the users whos timeline to retrieve.
    :param: completion The code to be executed once the request has finished.
    */
    public func getTimelineForUser(screenName: String, completion: (tweets: [TJTweet]?, error: NSError?) -> Void) {
            let apiURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + screenName
        twitterJSON.performDataRequestForURL(apiURL, completion: { (data, error) -> Void in
            if error == nil {
                var tweets = [TJTweet]()
                for item in data! {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets, error: nil)
            } else {
                completion(tweets: nil, error: error)
            }
        })
    }
    
    /**
    Gets the most recent favorited tweets of the user specified in the parameter. An array of TJTweet objects are
    passed into the completion handler.
    
    :param: String Screen name of the users whos favorites to retrieve.
    :param: Completion The code to be executed once the request has finished.
    */
    public func getFavorites(screenName: String, completion: (tweets: [TJTweet]?, error: NSError?) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/favorites/list.json?screen_name=" + screenName
        twitterJSON.performDataRequestForURL(apiURL, completion: { (data, error) -> Void in
            if error == nil {
                var tweets = [TJTweet]()
                for item in data! {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets, error: nil)
            } else {
                completion(tweets: nil, error: error)
            }
        })
    }
    
    /**
    //Get the most recent tweets containing the given search term. An array of TJTweet objects are passed
    into the completion handler.
    
    :param: String Search term
    :param: Completion The code to be executed once the request has finished.
    */
    public func searchForTweets(searchQuery: String, completion: (tweets: [TJTweet]?, error: NSError?) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/search/tweets.json?q=" + searchQuery.urlEncode()
        twitterJSON.performDataRequestForURL(apiURL, completion: { (data, error) -> Void in
            if error == nil {
                var tweets = [TJTweet]()
                for item in data!["statuses"] {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets, error: nil)
            } else {
            
            }
        })
    }
    
    /**
    //Get the most recent tweets containing the given search term. An array of TJTweet objects are passed
    into the completion handler.
    
    :param: String Search term
    :param: Completion The code to be executed once the request has finished.
    */
    public func getTweetsForList(listSlug: String, fromUser user: String, completion: (tweets: [TJTweet]?, error: NSError?) -> Void) {
        let query = "slug=" + listSlug.urlEncode() + "&owner_screen_name=" + user.urlEncode() + "&count=20"
        let apiURL = "https://api.twitter.com/1.1/lists/statuses.json?" + query
        twitterJSON.performDataRequestForURL(apiURL, completion: { (data, error) -> Void in
            if error == nil {
                var tweets = [TJTweet]()
                for item in data! {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets, error: nil)
            } else {
                completion(tweets: nil, error: error)
            }
        })
    }
    
}