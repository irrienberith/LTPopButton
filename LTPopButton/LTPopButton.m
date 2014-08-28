//
//  LTPopButton.m
//  LTPopButton
//
//  Created by ltebean on 14-8-28.
//  Copyright (c) 2014年 ltebean. All rights reserved.
//

#import "LTPopButton.h"
#import "POP.h"

#define lineHeight 2.0

@interface LTPopButton()
@property(nonatomic,strong) CALayer *topLayer;
@property(nonatomic,strong) CALayer *middleLayer;
@property(nonatomic,strong) CALayer *bottomLayer;
@end

@implementation LTPopButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

-(void)setup
{
    CGFloat height = lineHeight;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius =  1.f;
    CGColorRef color = [[UIColor blackColor]CGColor];
    
    self.topLayer = [CALayer layer];
    self.topLayer.frame = CGRectMake(0, 0, width, height);
    self.topLayer.cornerRadius = cornerRadius;
    self.topLayer.backgroundColor = color;
    
    self.middleLayer = [CALayer layer];
    self.middleLayer.frame = CGRectMake(0, CGRectGetMidY(self.bounds)-(height/2), width, height);
    self.middleLayer.cornerRadius = cornerRadius;
    self.middleLayer.backgroundColor = color;
    
    self.bottomLayer = [CALayer layer];
    self.bottomLayer.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-height, width, height);
    self.bottomLayer.cornerRadius = cornerRadius;
    self.bottomLayer.backgroundColor = color;
    
    [self.layer addSublayer:self.topLayer];
    [self.layer addSublayer:self.middleLayer];
    [self.layer addSublayer:self.bottomLayer];
    
}

-(void) animateToType:(LTPopButtonType) type;
{
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    switch (type) {
        case plusType:
            [self rotateLayer:self.topLayer to:M_PI_2];
            [self moveLayer:self.topLayer to:center];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];

            [self fadeLayer:self.middleLayer to:0];
            
            [self moveLayer:self.bottomLayer to:center];
            [self rotateLayer:self.bottomLayer to:0];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            
            break;
            
        case minusType:
            [self rotateLayer:self.topLayer to:0];
            [self moveLayer:self.topLayer to:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            
            [self fadeLayer:self.middleLayer to:1];
            
            
            [self rotateLayer:self.bottomLayer to:0];
            [self moveLayer:self.bottomLayer to:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds)-CGRectGetMidY(self.bounds))];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            break;
            
        case closeType:
            [self moveLayer:self.topLayer to:center];
            [self rotateLayer:self.topLayer to:M_PI_4];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            [self fadeLayer:self.middleLayer to:0];
            
            [self moveLayer:self.bottomLayer to:center];
            [self rotateLayer:self.bottomLayer to:-M_PI_4];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            break;
            
        case menuType:
            [self rotateLayer:self.topLayer to:0];
            [self moveLayer:self.topLayer to:CGPointMake(CGRectGetMidX(self.bounds), lineHeight/2)];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            [self fadeLayer:self.middleLayer to:1];
            
            [self rotateLayer:self.bottomLayer to:0];
            [self moveLayer:self.bottomLayer to:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds)-lineHeight/2)];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds), lineHeight)];
            break;
            
        case backType:
            
            [self rotateLayer:self.topLayer to:-M_PI_4];
            [self moveLayer:self.topLayer to:CGPointMake(CGRectGetMidX(self.bounds)/2+lineHeight/2, CGRectGetMidY(self.bounds)/2-lineHeight)];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds)*1.414/2, lineHeight)];
            
            [self fadeLayer:self.middleLayer to:1];
            
            [self moveLayer:self.bottomLayer to:CGPointMake(CGRectGetMidX(self.bounds)/2+lineHeight/2, CGRectGetHeight(self.bounds)-  CGRectGetMidY(self.bounds)/2+lineHeight)];
            [self rotateLayer:self.bottomLayer to:M_PI_4];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds)*1.414/2, lineHeight)];
            break;

        case forwardType:
            [self rotateLayer:self.topLayer to:M_PI_4];
            [self moveLayer:self.topLayer to:CGPointMake(CGRectGetMidX(self.bounds)/2*3-lineHeight/2, CGRectGetMidY(self.bounds)/2-lineHeight)];
            [self resizeLayer:self.topLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds)*1.414/2, lineHeight)];
            
            [self fadeLayer:self.middleLayer to:1];
            
            [self moveLayer:self.bottomLayer to:CGPointMake(CGRectGetMidX(self.bounds)/2*3-lineHeight/2, CGRectGetHeight(self.bounds)-  CGRectGetMidY(self.bounds)/2+lineHeight)];
            [self rotateLayer:self.bottomLayer to:-M_PI_4];
            [self resizeLayer:self.bottomLayer to:CGRectMake(0, 0, CGRectGetWidth(self.bounds)*1.414/2, lineHeight)];
            break;
        default:
            break;
    }
}


- (void) rotateLayer:(CALayer *)layer to:(CGFloat)toValue {
    
    POPSpringAnimation *anim = [layer pop_animationForKey:@"springRotation"];
    if (anim) {
        anim.toValue = @(toValue);
    } else {
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
        anim.springBounciness = 20.f;
        anim.springSpeed = 20;
        anim.dynamicsTension = 800;
        
        anim.toValue = @(toValue);
        anim.name = @"rotationToState";
        [layer pop_addAnimation:anim forKey:@"springRotation"];
    }
}

- (void) moveLayer:(CALayer *)layer to:(CGPoint)toValue {
    POPSpringAnimation *anim = [layer pop_animationForKey:@"positionTranslation"];
    if (anim) {
        anim.toValue = [NSValue valueWithCGPoint:toValue];
    } else {
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
        
        anim.toValue = [NSValue valueWithCGPoint:toValue];
        [layer pop_addAnimation:anim forKey:@"positionTranslation"];
    }
}

- (void) resizeLayer:(CALayer *)layer to:(CGRect)toValue {
    POPSpringAnimation *anim = [layer pop_animationForKey:@"boundsTranslation"];
    if (anim) {
        anim.toValue = [NSValue valueWithCGRect:toValue];
    } else {
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
        
        anim.toValue = [NSValue valueWithCGRect:toValue];
        [layer pop_addAnimation:anim forKey:@"boundsTranslation"];
    }
}

- (void) fadeLayer:(CALayer *)layer to:(CGFloat)toValue {
    POPSpringAnimation *anim = [layer pop_animationForKey:@"opacityTranslation"];
    if (anim) {
        anim.toValue = @(toValue);
    } else {
        anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
        anim.toValue = @(toValue);
        [layer pop_addAnimation:anim forKey:@"opacityTranslation"];
    }
}


@end
