//
//  ASDBeanProxy.m
//  ASDBeanProxy
//
//  Created by Mike Hagedorn on 8/14/14.
//  Copyright (c) 2014 appsdynamic. All rights reserved.
//

#import "ASDBeanProxy.h"

NSString * const ASDBeanFoundNotification = @"ASDBeanFound";

@interface ASDBeanProxy ()

@property (strong,nonatomic) PTDBeanManager *beanManager;
@property (strong,nonatomic) NSMutableDictionary *discoveredBeansDict;
@property (strong,nonatomic) NSMutableString *receivedData;
@property (strong,nonatomic) NSMutableDictionary *theConnectedBeans;

@end

@implementation ASDBeanProxy



- (void)connectToBean:(PTDBean *)bean {
  if (![self isConnectedToBean:bean]) {
    [self.beanManager connectToBean:bean error:nil];
  }

}

- (BOOL)connectToBeanWithIdentifier:(NSUUID *)identifier {
  return NO;
}

- (void)disconnectFromBean:(PTDBean *)bean {
  if ([self isConnectedToBean:bean]) {
    [self.beanManager disconnectBean:bean error:nil];
  }

}

- (void)startScanningForBeans {
  [self.discoveredBeansDict removeAllObjects];
  [self.beanManager startScanningForBeans_error:nil];
}

- (void)stopScanningForBeans {
  [self.beanManager stopScanningForBeans_error:nil];
}

+ (ASDBeanProxy *)sharedASDBeanProxy {
  static ASDBeanProxy *sharedASDBeanProxy = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      sharedASDBeanProxy = [[self alloc] init];
  });
  return sharedASDBeanProxy;
}

- (id)init {
  if (self = [super init]) {

    self.beanManager=[[PTDBeanManager alloc] init];
    self.beanManager.delegate=self;
    self.discoveredBeansDict=[NSMutableDictionary new];
    self.receivedData=[NSMutableString new];
    self.theConnectedBeans=[NSMutableDictionary new];
  }
  return self;
}

-(NSArray *)discoveredBeans {
  return [self.discoveredBeansDict allValues];
}

-(NSArray *)connectedBeans {
  return [self.theConnectedBeans allValues];
}

-(BOOL)isConnectedToBean:(PTDBean *)bean {
  return ([self.theConnectedBeans allKeysForObject:bean].count !=0);
}

-(BOOL)isConnectedToBeanWithIdentifier:(NSUUID *)identifier {
  return [self theConnectedBeans][identifier] != nil;
}

- (void)beanManagerDidUpdateState:(PTDBeanManager *)beanManager {
  if(self.beanManager.state == BeanManagerState_PoweredOn){
    // if we're on, scan for advertisting beans
    NSLog(@"Starting to scan for Beans");
    [self.beanManager startScanningForBeans_error:nil];
  }
  else if (self.beanManager.state == BeanManagerState_PoweredOff) {
    NSLog(@"Bean Manager is powered off");
  }

}

- (void)BeanManager:(PTDBeanManager *)beanManager didDiscoverBean:(PTDBean *)bean error:(NSError *)error {
  if (error) {
    NSLog(@"Error in didDiscoverBean: %@", [error localizedDescription]);
    return;
  }
  else {
    NSLog(@"Discovered Bean %@ (%@)",bean.name,bean.identifier);
    self.discoveredBeansDict[bean.identifier] = bean;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didUpdateDiscoveredBeans:withBean:)]) {
      [self.delegate didUpdateDiscoveredBeans:[self discoveredBeans] withBean:bean];
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:ASDBeanFoundNotification object:bean];

  }

}

- (void)BeanManager:(PTDBeanManager *)beanManager didConnectToBean:(PTDBean *)bean error:(NSError *)error {
  if (error) {
    NSLog(@"Error in didConnectToBean: %@", [error localizedDescription]);
    return;
  }

  self.theConnectedBeans[bean.identifier] = bean;

  if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didConnectToBean:)]) {
    [self.delegate didConnectToBean:bean];
  }

}

- (void)BeanManager:(PTDBeanManager *)beanManager didDisconnectBean:(PTDBean *)bean error:(NSError *)error {
  if (error) {
    NSLog(@"Error in didDisconnectBean: %@", [error localizedDescription]);;
  }

  [self.theConnectedBeans removeObjectForKey:bean.identifier];
  if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didDisconnectFromBean:)]) {
    [self.delegate didDisconnectFromBean:bean];
  }
}


@end
