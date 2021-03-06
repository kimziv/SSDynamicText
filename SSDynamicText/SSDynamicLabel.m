//
//  SSDynamicLabel.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/4/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicLabel ()

- (void) setup;

@end

@implementation SSDynamicLabel

- (id)init {
    if( ( self = [super init] ) ) {
        [self setup];
    }
  
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if( ( self = [super initWithFrame:frame] ) ) {
        [self setup];
    }
  
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if( ( self = [super initWithCoder:aDecoder] ) ) {
        [self setup];
    }
  
    return self;
}

+ (instancetype) labelWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    SSDynamicLabel *label = [SSDynamicLabel new];
    label.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName size:size];

    return label;
}

+ (instancetype)labelWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicLabel *label = [SSDynamicLabel new];
    label.defaultFontDescriptor = descriptor;
  
    return label;
}

- (void)dealloc {
    [self ss_stopObservingTextSizeChanges];
}

- (void)setup {
    __weak typeof (self) weakSelf = self;
    
    SSTextSizeChangedBlock changeHandler = ^(NSInteger newDelta) {
        CGFloat preferredSize = [weakSelf.defaultFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute] floatValue];
        preferredSize += newDelta;
        
        weakSelf.font = [UIFont fontWithDescriptor:weakSelf.defaultFontDescriptor
                                              size:preferredSize];
    };
    
    [self ss_startObservingTextSizeChangesWithBlock:changeHandler];
}

@end
