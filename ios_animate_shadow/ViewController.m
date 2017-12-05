
#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CAShapeLayer *layer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    const CGFloat width = 6;
    const CGFloat inset = 2;
    
    CGSize size = CGSizeMake(width*9+2*inset, width*9+2*inset);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(inset, inset, size.width-2*inset, size.height-2*inset)];
    
    [path moveToPoint:CGPointMake(width+inset, width+inset)];
    [path addLineToPoint:CGPointMake(width+inset, width*4+inset)];
    [path addLineToPoint:CGPointMake(width*4+inset, width*4+inset)];
    [path addLineToPoint:CGPointMake(width*4+inset, width+inset)];
    [path closePath];
    
    [path moveToPoint:CGPointMake(width*5+inset, width+inset)];
    [path addLineToPoint:CGPointMake(width*5+inset, width*4+inset)];
    [path addLineToPoint:CGPointMake(width*8+inset, width*4+inset)];
    [path addLineToPoint:CGPointMake(width*8+inset, width+inset)];
    [path closePath];
    
    [path moveToPoint:CGPointMake(width+inset, width*5+inset)];
    [path addLineToPoint:CGPointMake(width+inset, width*8+inset)];
    [path addLineToPoint:CGPointMake(width*8+inset, width*8+inset)];
    [path addLineToPoint:CGPointMake(width*8+inset, width*5+inset)];
    [path closePath];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = UIColor.blackColor.CGColor;
    layer.fillColor = UIColor.redColor.CGColor;
    layer.frame = CGRectMake(100, 100, size.width, size.height);
    layer.path = path.CGPath;
    layer.shadowColor = UIColor.darkGrayColor.CGColor;
    layer.shadowOpacity = 1;
    layer.shadowOffset = CGSizeMake(10, 10);
    layer.shadowRadius = 2;
    layer.shadowPath = path.CGPath;
    [self.view.layer addSublayer:layer];
    
    self.layer = layer;
    
    [self performSelector:@selector(animate) withObject:nil afterDelay:1];
}

- (void)update:(CADisplayLink *)link {
    [UIView performWithoutAnimation:^{
        CGFloat x = 10;
        CGFloat y = 10;
        CGFloat angle = [[self.layer.presentationLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
        CGAffineTransform transform = CGAffineTransformMakeRotation(-angle);
        CGFloat newx = x*transform.a+y*transform.c;
        CGFloat newy = x*transform.b+y*transform.d;
        CGSize size = CGSizeMake(newx, newy);
        self.layer.shadowOffset = size;
    }];
}

- (void)animate {
    
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    [link addToRunLoop:NSRunLoop.mainRunLoop forMode:NSDefaultRunLoopMode];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @0.f;
    animation.toValue = @(2*M_PI);
    animation.repeatCount = HUGE_VALF;
    animation.duration = 8;
    
    [self.layer addAnimation:animation forKey:@"rotate"];
}

@end

