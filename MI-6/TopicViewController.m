//
//  TopicViewController.m
//  MI-6
//
//  Created by Влад Мазур on 29.09.13.
//  Copyright (c) 2013 Vlad Mazur. All rights reserved.
//

#import "TopicViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuView.h"

@interface TopicViewController ()

@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIView *coverView;

@property NSUInteger firstTouch;
@property NSUInteger secondTouch;
@property Boolean isDrawingMenuView;

@property (strong, nonatomic) MenuView * menuView;

@end

@implementation TopicViewController

@synthesize menuView = _menuView;

-(UIView *)menuView
{
    if(!_menuView)
    {
        self.menuView = [[MenuView alloc] init];
        [self.coverView addSubview:self.menuView];
        [self.coverView bringSubviewToFront:self.menuView];
        
        self.menuView.box = [self.box SubjectBoxWithoutOneSubject:self.subject];
        self.menuView.father = self;
    }
    
    return _menuView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

// webView
    _webView = [[UIWebView alloc] initWithFrame:
                CGRectMake(0, 60, self.view.bounds.size.width,self.view.bounds.size.height)];
    _webView.userInteractionEnabled = NO;
    
//    NSURLRequest *req = [NSURLRequest requestWithURL:
//                         [[NSBundle mainBundle] URLForResource:self.subject.file
//                                                 withExtension:@"html"]];
//    [_webView loadRequest:req];
    [self loadSubject:self.subject];
    
// coverView
    _coverView = [[UIView alloc] initWithFrame:self.view.frame];
    _coverView.opaque = NO;
    _coverView.backgroundColor = [UIColor clearColor];
    _coverView.userInteractionEnabled = YES;
    _coverView.multipleTouchEnabled = YES;
    
// adding to main view
    [self.view addSubview:_webView];
    [self.view addSubview:_coverView];
    [self.view bringSubviewToFront:_coverView];
    
// "gestures" init
    self.firstTouch = 0;
    self.secondTouch = 0;
    self.isDrawingMenuView = NO;
}

-(void)drawTouchMenu:(CGPoint)location
{
    [self drawTouchMenu:location Animated:NO];
}

-(void)drawTouchMenu:(CGPoint)location Animated:(Boolean)animated
{
#define OPACITY 0.9
#define ANIMATIONTIME 0.4

    if(location.x > 220)
        location.x = 219;
    if(location.y < 65)
        location.y = 65;
    if(location.y > 480 - self.menuView.count * 25)
        location.y = 479 - self.menuView.count * 25;
    
    
    if(self.isDrawingMenuView) // уже рисуем, что тут визулизировать?
        animated = NO;
    
    CGFloat height = self.menuView.count * 25;
    [self.menuView setFrame:CGRectMake(location.x, location.y, 100, height)];
    
    self.menuView.alpha = animated ? 0.0 : OPACITY;
    
    if (animated)
        [UIView animateWithDuration:ANIMATIONTIME animations:^{
            [self.menuView setAlpha:OPACITY];
            self.navigationController.navigationBarHidden = NO;
            self.webView.frame = CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height);
        } completion:^(BOOL finished) {}];
    
    self.isDrawingMenuView = YES;
    }

-(UITouch *)leftTouchFromSet:(NSSet *)touches
{
    UITouch * leftTouch = [touches anyObject];
    for (UITouch * t in touches) {
        if ([t locationInView:_coverView].x < [leftTouch locationInView:_coverView].x)
            leftTouch = t;
    }
    return leftTouch;
}

-(UITouch *)findTouchWithHash:(NSInteger)hash InSet:(NSSet *)touches
{
    for (UITouch * t in touches) {
        if ([t hash] == hash)
            return t;
    }
    return nil; // not found
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.firstTouch == 0)
    {
        UITouch * leftTouch = [self leftTouchFromSet:touches];
        self.firstTouch = [leftTouch hash];
        if (self.navigationController.navigationBarHidden)
            [self turnOn];
        return;// а потому что не надо сразу рисовать меню, даже если два пальца на экране (сходу)
    }
    
    if (self.firstTouch && !self.secondTouch && [[event allTouches] count] > 1)
    {
        UITouch * leftTouch = [self leftTouchFromSet:touches];
        self.secondTouch = [leftTouch hash];
        [self drawTouchMenu:[[self findTouchWithHash:self.firstTouch InSet:touches]
                             locationInView:_coverView] Animated:YES];
//        self.isDrawingMenuView = YES;
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!self.isDrawingMenuView)
        return;
    for (UITouch * t in touches)
    {
        if(t.hash == self.firstTouch) {
            [self drawTouchMenu:[t locationInView:self.coverView]];
            break;
        }
    }
}

-(void)turnOff
{
    self.coverView.backgroundColor = [UIColor blackColor];
    self.menuView.alpha = 0;
    self.firstTouch = 0;
    self.secondTouch = 0;
    self.isDrawingMenuView = NO;
    self.navigationController.navigationBarHidden = YES;
}

-(void)turnOn
{
    _coverView.backgroundColor = [UIColor clearColor];
    self.webView.frame = CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//    может следует тут изменить поведение
//    потому что не понятно удобно ли переключать управление положением меню на другогй палец
//    или лучше его выключить
//    не могу проверить на симуляторе
    
    for (UITouch * t in touches)
    {
        if(t.hash == self.firstTouch)
        { // убрали первый палец, теперь новым первым будет самый левый
            if ( [[event allTouches] count] - [touches count] == 0) { // никого не осталось
                [self turnOff];
            }
             else { // остались другие
                 NSMutableSet * they = [[event allTouches] mutableCopy];
                 [they minusSet:touches]; // минус те, кого сейчас убрали
                 UITouch * left = [self leftTouchFromSet:they];
                 self.firstTouch = [left hash];
                 [self drawTouchMenu:[left locationInView:_coverView]];
            }
        }
        if(t.hash == self.secondTouch) {
            self.secondTouch = 0;
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
//shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

-(void)cellClicked:(NSIndexPath *)indexPath
{
    
}

-(void)loadSubject:(Subject *)subject
{
//    self.subject = subject;
    
    NSURLRequest *req = [NSURLRequest requestWithURL:
                         [[NSBundle mainBundle] URLForResource:subject.file
                                                 withExtension:@"html"]];
    [_webView loadRequest:req];
    
    self.title = subject.name;
}

@end
