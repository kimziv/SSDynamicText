//
//  SSDynamicTextField.m
//  SSDynamicText
//
//  Created by Jonathan Hersh on 10/6/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSDynamicText.h"

@interface SSDynamicTextField ()

- (void) setup;

@end

@implementation SSDynamicTextField

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

+ (instancetype)textFieldWithFont:(NSString *)fontName baseSize:(CGFloat)size {
    SSDynamicTextField *textField = [SSDynamicTextField new];
    textField.defaultFontDescriptor = [UIFontDescriptor fontDescriptorWithName:fontName
                                                                          size:size];
    
    return textField;
}

+ (instancetype)textFieldWithFontDescriptor:(UIFontDescriptor *)descriptor {
    SSDynamicTextField *textField = [SSDynamicTextField new];
    textField.defaultFontDescriptor = descriptor;
    
    return textField;
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
