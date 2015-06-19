//
//  ViewController.m
//  Calc
//
//  Created by kunren10 on 2014/04/01.
//  Copyright (c) 2014年 Takahide Baba. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    int _tempNum; // 退避（値）
    int _tempMark; // 退避（符号）+-x
    BOOL _frgPushMark; // フラグ（符号ボタン押した直後）
}

@property (weak, nonatomic) IBOutlet UILabel *lbCalc;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // クリア処理
    [self pushKeyClear:nil]; // nil 空っぽ
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 数字キー押下
- (IBAction)pushKeyNumber:(UIButton *)sender {
	
	NSString *str = [NSString stringWithFormat:
						@"%ld", (long)sender.tag];
	
	if ([self.lbCalc.text isEqualToString:@"0"] == YES ||  _frgPushMark == YES) {
		
		// 文字列の上書
		self.lbCalc.text = str;
		
	} else {
		
		// 文字列の追記
		self.lbCalc.text =
			[self.lbCalc.text stringByAppendingString:str];
	}
	
    // フラグ（符号ボタン押した直後）OFF
	_frgPushMark = NO;
}

// 符号キー押下
- (IBAction)pushKeyMark:(UIButton *)sender {
    
    NSLog(@"符号：%d, 符号退避：%d, 表示画面：%@", _tempMark, _frgPushMark,self.lbCalc.text);
    
    if (_frgPushMark == YES) {
        // 符号の退避
        _tempMark = sender.tag;
        
        return;
    }
    
    // 符号の判定
    switch (_tempMark) {
        case 1:
            _tempNum += [self.lbCalc.text intValue]; // +
            break;
        case 2:
            _tempNum -= [self.lbCalc.text intValue]; // -
            break;
        case 3:
            _tempNum *= [self.lbCalc.text intValue]; // *
            break;
        case 4:
            _tempNum /= [self.lbCalc.text intValue]; // /
            break;
        case 9:
            _tempNum = [self.lbCalc.text intValue]; // =
            break;
            
        default:
            break;
    }
    // 結果表示
    self.lbCalc.text = [NSString stringWithFormat:@"%d", _tempNum];
    
    // 符号の退避
    _tempMark = sender.tag;
    
    // フラグ（符号ボタン押した直後）ON
	_frgPushMark = YES;
    
}

// [AC]キー押下
- (IBAction)pushKeyClear:(id)sender {
    
    // 初期化
    _tempNum  = 0;      // 退避（値）
    _tempMark = 1;      // 退避（符号）+-x
    
    _frgPushMark = YES; // フラグ（符号ボタン押した直後）

    // ラベルクリア
    self.lbCalc.text = @"0";
}

@end
