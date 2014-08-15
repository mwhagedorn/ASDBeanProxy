//
//  ASDBeanProxy.h
//  ASDBeanProxy
//
//  Created by Mike Hagedorn on 8/14/14.
//  Copyright (c) 2014 appsdynamic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTDBean.h"
#import "PTDBeanManager.h"

extern NSString *const ASDBeanFoundNotification;

@interface ASDBeanProxy : NSObject <PTDBeanManagerDelegate>

@property(weak, nonatomic) id delegate;
@property(nonatomic, readonly) NSArray *connectedBeans;
@property(nonatomic, readonly) NSArray *discoveredBeans;

+ (ASDBeanProxy *)sharedASDBeanProxy;

- (BOOL)isConnectedToBean:(PTDBean *)bean;

- (BOOL)isConnectedToBeanWithIdentifier:(NSUUID *)identifier;

- (void)connectToBean:(PTDBean *)bean;

- (BOOL)connectToBeanWithIdentifier:(NSUUID *)identifier;

- (void)disconnectFromBean:(PTDBean *)bean;

- (void)startScanningForBeans;

- (void)stopScanningForBeans;

@end


@protocol ASDBeanProxyDelegate

@optional
- (void)didUpdateDiscoveredBeans:(NSArray *)discoveredBeans withBean:(PTDBean *)newBean;

@optional
- (void)didConnectToBean:(PTDBean *)bean;

@optional
- (void)didDisconnectFromBean:(PTDBean *)bean;

@end



