//
//  Deck.h
//  Matchismo
//
//  Created by Jin Chung on 9/18/14.
//  Copyright (c) 2014 jrumlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;
@end
