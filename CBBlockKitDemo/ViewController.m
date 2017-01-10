//
//  ViewController.m
//  CBKitDemo
//
//  Created by 陈超邦 on 2016/7/31.
//  Copyright © 2016年 陈超邦. All rights reserved.
//

#import "ViewController.h"
#import "CBColorMacros.h"
#import "CBCategory.h"

@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    
    [UITextField cb_makeTextFieldWithHolder:@"Clip here to start editing ..."
                                  addToView:self.view
                                  attribute:^(UITextField *f, CBTextFieldDelegate *d) {
                                      [f setValue:[UIFont systemFontOfSize:15.f] forKeyPath:@"_placeholderLabel.font"];
                                      [f setValue:cb_whiteColor forKeyPath:@"_placeholderLabel.textColor"];

                                      f.backgroundColor = cb_darkGrayColor;
                                      f.layer.cornerRadius = 3.f;
                                      f.textColor = cb_whiteColor;
                                  } constraint:^(MASConstraintMaker *make) {
                                      make.top.equalTo(self.mas_topLayoutGuideTop).offset(5.f);
                                      make.left.equalTo(self.view).offset(10.f);
                                      make.right.equalTo(self.view).offset(-10.f);
                                      make.height.mas_equalTo(35.f);
                                  }];
    
    [UITableView cb_makeTableViewWithStyle:UITableViewStylePlain
                            cellIdentifier:@"SimpleTableView"
                                  delegate:self
                                 addToView:self.view
                                 attribute:^(UITableView *t, CBTableViewDelegate *d, CBTableViewDataSourse *s) {
                                     t.backgroundColor = [UIColor groupTableViewBackgroundColor];
                                     
                                     s.cb_titleForHeaderInSectionBlock = ^NSString *(UITableView *t, NSInteger section) {
                                         return @"TableView Hearder";
                                     };
                                     s.cb_titleForFooterInSectionBlock = ^NSString *(UITableView *t, NSInteger section) {
                                         return @"TableView Footer";
                                     };
                                     d.cb_heightForRowBlock = ^CGFloat(UITableView *t, NSIndexPath *indexPath) {
                                         return 45.f;
                                     };
                                     
                                     t.cb_eventMonitor = ^(UITableView *t, NSString *signal) {
                                         if ([signal isEqualToString:@"1111"]) {
                                             d.cb_didSelectRowAtIndexPathBlock = ^(UITableView *t, UITableViewCell *cell, NSIndexPath *indexPath) {
                                                 cell.textLabel.text = [NSString stringWithFormat:@"oop, you got me ------- index : %ld", indexPath.row];
                                                 
                                                 cell.textLabel.textColor = cb_greenColor;
                                             };
                                         }
                                         
                                         if ([signal isEqualToString:@"2222"]) {
                                             d.cb_didSelectRowAtIndexPathBlock = ^(UITableView *t, UITableViewCell *cell, NSIndexPath *indexPath) {
                                                 cell.textLabel.text = [NSString stringWithFormat:@"oop, you got me again ------- index : %ld", indexPath.row];
                                                 
                                                 cell.textLabel.textColor = cb_blueColor;
                                             };
                                         }
                                     };
                                 } constraint:^(MASConstraintMaker *make) {
                                     make.top.equalTo(self.mas_topLayoutGuideTop).offset(40.f);
                                     
                                     make.left.and.and.right.equalTo(self.view);
                                     
                                     make.bottom.equalTo(self.view.mas_centerY);
                                 } numberOfRows:^NSInteger(UITableView *t, NSInteger section) {
                                     return 100;
                                 } configureCell:^(UITableViewCell *cell, NSIndexPath *indexPath) {
                                     cell.textLabel.textAlignment = NSTextAlignmentCenter;
                                     
                                     cell.textLabel.text = [NSString stringWithFormat:@"Index - %ld", (long)indexPath.row];
                                     
                                     cell.textLabel.textColor = cb_blackColor;
                                 }];
    
    [UILabel cb_makeLabelWithText:@"UIButton"
                        addToView:self.view
                        attribute:^(UILabel *l) {
                            l.font = [UIFont boldSystemFontOfSize:9.f];
                            
                            l.textAlignment = NSTextAlignmentCenter;
                        } constraint:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.view.mas_centerY);
                            
                            make.left.equalTo(self.view).offset(10.f);
                            
                            make.width.mas_equalTo(self.view).multipliedBy(0.5).offset(-15.f);
                            
                            make.height.mas_equalTo(self.view).multipliedBy(0.05);
                        }];
    
    [UIButton cb_makeButtonWithTitle:@"点击按钮"
                          titleColor:cb_whiteColor
                     backgroundColor:cb_darkGrayColor
                           addToView:self.view
                           attribute:^(UIButton *b) {
                               b.layer.cornerRadius = 5.f;
                               
                               b.titleLabel.numberOfLines = 0;
                               
                               b.titleLabel.font = [UIFont boldSystemFontOfSize:13.f];
                               
                               b.cb_eventMonitor = ^(UIButton *b, NSString *signal) {
                                   if ([signal isEqualToString:@"3333"]) {
                                       [b setTitle:@"opp, you sent a message to me ??" forState:UIControlStateNormal];
                                   }
                               };
                           } constraint:^(MASConstraintMaker *make) {
                               make.top.equalTo(self.view.mas_centerY).offset(20.f);
                               
                               make.left.equalTo(self.view).offset(10.f);
                               
                               make.width.mas_equalTo(self.view).multipliedBy(0.5).offset(-15.f);
                               
                               make.height.mas_equalTo(50.f);
                           } touchUpInside:^(UIButton *b) {
                               [b setTitle:@"opp, you touched me... (*☻-☻*)" forState:UIControlStateNormal];
                               
                               [b setTitleColor:cb_yellowColor forState:UIControlStateNormal];
                           }];
    
    [UILabel cb_makeLabelWithText:@"UIImageView"
                        addToView:self.view
                        attribute:^(UILabel *l) {
                            l.font = [UIFont boldSystemFontOfSize:9.f];
                            
                            l.textAlignment = NSTextAlignmentCenter;
                        } constraint:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.view.mas_centerY);
                            
                            make.right.equalTo(self.view).offset(-10.f);
                            
                            make.width.mas_equalTo(self.view).multipliedBy(0.5).offset(-15.f);
                            
                            make.height.mas_equalTo(self.view).multipliedBy(0.05);
                        }];
    
    [UIImageView cb_makeImageViewWithImage:@"wbq_0"
                                 addToView:self.view
                                 attribute:^(UIImageView *m) {
                                     m.layer.cornerRadius = 5.f;
                                     
                                     __block int tap_num = 1;
                                     
                                     m.cb_singleTapBlock = ^(UIImageView *m){
                                         tap_num = tap_num >= 12 ? 0 : tap_num;
                                    
                                         m.image = [UIImage imageNamed:[NSString stringWithFormat:@"wbq_%d", tap_num]];
                                         
                                         tap_num += 1;
                                     };
                                     
                                     m.cb_eventMonitor = ^(UIImageView *m, NSString *signal) {
                                         if ([signal isEqualToString:@"4444"]) {
                                              m.image = [UIImage imageNamed:@"wbq_100"];
                                         }
                                     };
                                 } constraint:^(MASConstraintMaker *make) {
                                     make.top.equalTo(self.view.mas_centerY).offset(20.f);
                                     
                                     make.right.equalTo(self.view).offset(-10.f);
                                     
                                     make.width.mas_equalTo(self.view).multipliedBy(0.5).offset(-15.f);
                                     
                                     make.height.mas_equalTo(50.f);
                                 }];
    
    [UILabel cb_makeLabelWithText:@"UITextView"
                        addToView:self.view
                        attribute:^(UILabel *l) {
                            l.font = [UIFont boldSystemFontOfSize:9.f];
                            
                            l.textAlignment = NSTextAlignmentCenter;
                        } constraint:^(MASConstraintMaker *make) {
                            make.top.equalTo(self.view.mas_centerY).offset(75.f);
                            
                            make.left.equalTo(self.view).offset(10.f);
                            
                            make.right.equalTo(self.view).offset(-10.f);
                            
                            make.height.mas_equalTo(10.f);
                        }];
    
    [UITextView cb_makeTextViewWithDelegate:self
                                  addToView:self.view
                                  attribute:^(UITextView *x, CBTextViewDelegate *d) {
                                      x.layer.cornerRadius = 5.f;
                                      
                                      x.text = @"汉皇重色思倾国，御宇多年求不得。杨家有女初长成，养在深闺人未识。天生丽质难自弃，一朝选在君王侧。回眸一笑百媚生，六宫粉黛无颜色。春寒赐浴华清池，温泉水滑洗凝脂。侍儿扶起娇无力，始是新承恩泽时。云鬓花颜金步摇，芙蓉帐暖度春宵。春宵苦短日高起，从此君王不早朝。承欢侍宴无闲暇，春从春游夜专夜。后宫佳丽三千人，三千宠爱在一身。金屋妆成娇侍夜，玉楼宴罢醉和春。 姊妹弟兄皆列土，可怜光彩生门户。遂令天下父母心，不重生男重生女。骊宫高处入青云，仙乐风飘处处闻。缓歌谩舞凝丝竹，尽日君王看不足。渔阳鼙鼓动地来，惊破霓裳羽衣曲。 九重城阙烟尘生，千乘万骑西南行。翠华摇摇行复止，西出都门百余里。六军不发无奈何，宛转蛾眉马前死。花钿委地无人收，翠翘金雀玉搔头。君王掩面救不得，回看血泪相和流。黄埃散漫风萧索，云栈萦纡登剑阁。峨嵋山下少人行，旌旗无光日色薄。蜀江水碧蜀山青，圣主朝朝暮暮情。行宫见月伤心色，夜雨闻铃肠断声。天旋地转回龙驭，到此踌躇不能去。马嵬坡下泥土中，不见玉颜空死处。君臣相顾尽沾衣，东望都门信马归。归来池苑皆依旧，太液芙蓉未央柳。芙蓉如面柳如眉，对此如何不泪垂。春风桃李花开日，秋雨梧桐叶落时。西宫南内多秋草，落叶满阶红不扫。梨园弟子白发新，椒房阿监青娥老。夕殿萤飞思悄然，孤灯挑尽未成眠。迟迟钟鼓初长夜，耿耿星河欲曙天。鸳鸯瓦冷霜华重，翡翠衾寒谁与共。悠悠生死别经年，魂魄不曾来入梦。临邛道士鸿都客，能以精诚致魂魄。为感君王辗转思，遂教方士殷勤觅。排空驭气奔如电，升天入地求之遍。上穷碧落下黄泉，两处茫茫皆不见。忽闻海上有仙山，山在虚无缥渺间。楼阁玲珑五云起，其中绰约多仙子。中有一人字太真，雪肤花貌参差是。金阙西厢叩玉扃，转教小玉报双成。闻道汉家天子使，九华帐里梦魂惊。揽衣推枕起徘徊，珠箔银屏迤逦开。云鬓半偏新睡觉，花冠不整下堂来。风吹仙袂飘飘举，犹似霓裳羽衣舞。玉容寂寞泪阑干，梨花一枝春带雨。含情凝睇谢君王，一别音容两渺茫。昭阳殿里恩爱绝，蓬莱宫中日月长。回头下望人寰处，不见长安见尘雾。惟将旧物表深情，钿合金钗寄将去。钗留一股合一扇，钗擘黄金合分钿。但教心似金钿坚，天上人间会相见。临别殷勤重寄词，词中有誓两心知。七月七日长生殿，夜半无人私语时。在天愿作比翼鸟，在地愿为连理枝。天长地久有时尽，此恨绵绵无绝期。";
                                  } constraint:^(MASConstraintMaker *make) {
                                      make.top.equalTo(self.view.mas_centerY).offset(90.f);
                                      
                                      make.left.equalTo(self.view).offset(10.f);
                                      
                                      make.right.equalTo(self.view).offset(-10.f);

                                      make.bottom.equalTo(self.view).offset(-10.f);
                                  }];
}

- (void)injected {
    NSLog(@"InjectedForXcode work well.");
    
//    [self sendSignal:@"1111" class:[UITableView class] superView:self.view];

//    [self sendSignal:@"2222" class:[UITableView class] superView:self.view];
//
//    [self sendSignal:@"3333" class:[UIButton class] superView:self.view];
//
    [self sendSignal:@"4444" class:[UIImageView class] superView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
