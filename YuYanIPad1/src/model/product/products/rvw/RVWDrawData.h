//
//  RVWDrawData.h
//  RadarIPad
//
//  Created by Yachen Dai on 12/6/13.
//  Copyright (c) 2013 Yachen Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductRadialModel.h"
#import "ProductDefine.h"

@protocol ProductDrawDataProtocol;

@interface RVWDrawData : ProductRadialModel<ProductDrawDataProtocol>{
    
}

-(id)initWithProductType:(int) _productType;

@end
