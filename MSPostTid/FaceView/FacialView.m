
#import "FacialView.h"
#import "Emoji.h"

@interface FacialView ()
@end

@implementation FacialView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _faces = [Emoji allEmoji];
    }
    return self;
}

//给faces设置位置
-(void)loadFacialView:(int)page size:(CGSize)size
{
	int maxRow = 5;
    int maxCol = 8;
    CGFloat itemWidth = self.frame.size.width / maxCol;
    CGFloat itemHeight = self.frame.size.height / maxRow;
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundColor:[UIColor clearColor]];
    [deleteButton setFrame:CGRectMake((maxCol - 1) * itemWidth, (maxRow - 1) * itemHeight, itemWidth, itemHeight)];
    [deleteButton setImage:[UIImage imageNamed:@"faceDelete"] forState:UIControlStateNormal];
    deleteButton.tag = 10000;
    [deleteButton addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.clipsToBounds = YES;
    sendButton.layer.cornerRadius = 3;
    sendButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
//    [sendButton setTitle:unitized(@"send") forState:UIControlStateNormal];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setFrame:CGRectMake((maxCol - 2) * itemWidth , (maxRow - 1) * itemHeight + 10, itemWidth , itemHeight - 15)];
    [sendButton addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
    [sendButton setBackgroundColor:[UIColor colorWithRed:0.6 green:0.5 blue:0.4 alpha:1.0]];
    [self addSubview:sendButton];
    
    for (int row = 0; row < maxRow; row++) {
        for (int col = 0; col < maxCol; col++) {
            int index = row * maxCol + col;
            if (index < [_faces count]) {
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setBackgroundColor:[UIColor clearColor]];
                [button setFrame:CGRectMake(col * itemWidth, row * itemHeight, itemWidth, itemHeight)];
                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                [button setTitle: [_faces objectAtIndex:(row * maxCol + col)] forState:UIControlStateNormal];
                button.tag = row * maxCol + col;
                [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:button];
            }
            else{
                break;
            }
        }
    }
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag == 10000 && _delegate) {
        [_delegate deleteSelected:nil];
    }else{
        NSString *str = [_faces objectAtIndex:bt.tag];
        if (_delegate) {
            [_delegate selectedFacialView:str];
        }
    }
}

- (void)sendAction:(id)sender
{
    if (_delegate) {
        [_delegate sendFace];
    }
}
@end
