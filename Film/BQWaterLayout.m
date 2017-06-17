//
//  BQWaterLayout.m
//  瀑布流测试
//
//  Created by baiqiang on 15/9/22.
//  Copyright (c) 2015年 baiqiang. All rights reserved.
//

#import "BQWaterLayout.h"

@interface BQWaterLayout()
/** 存放每列高度字典*/
@property (nonatomic,assign) CGFloat maxHeight;
/** 存放所有item的attrubutes属性*/
@property (nonatomic, strong) NSMutableArray *array;
/** 计算每个item高度的block，必须实现*/
@property (nonatomic, copy) HeightBlock block;

@property (nonatomic,copy) SizeBlock blockSize;

@property (nonatomic,assign) CGFloat leastRowWidth;

@property (nonatomic,assign) CGFloat maxWidth;
@end

@implementation BQWaterLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        //对默认属性进行设置
        /** 
         默认行数 3行
         默认行间距 10.0f
         默认列间距 10.0f
         默认内边距 top:10 left:10 bottom:10 right:10
         */
        self.lineNumber = 1;
        self.rowSpacing = 10.0f;
        self.lineSpacing = 10.0f;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _array = [NSMutableArray array];
        
        
    }
    return self;
}

/**
 *  准备好布局时调用
 */
- (void)prepareLayout{
    [super prepareLayout];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    //初始化好每列的高度
    _maxHeight = self.sectionInset.top;
    _maxWidth = fabs(self.collectionView.frame.size.width - self.sectionInset.left-self.sectionInset.right);

    [self calculateLayotAttributes:count];

    return;
}

- (void)calculateLayotAttributes:(NSInteger )count {
    for (NSInteger i = 0 ; i < count; ) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        CGSize cellSize ;
        if (self.blockSize != nil) {
            cellSize = self.blockSize(indexPath);
        }
        else {
            NSAssert(cellSize.height != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
        }
        
        //每一行高度是固定的
        static CGFloat currentRowHeight = 0;
        
        if ( 1) {
            currentRowHeight = cellSize.height;
            self.leastRowWidth = _maxWidth;
            
            //当图片宽度大于collectionView时,只放一张图
            if (cellSize.width > _maxWidth ) {
                //当图片宽度大于collectionView时,单独占一行
                cellSize = CGSizeMake(_maxWidth, cellSize.height * _maxWidth / cellSize.width);
                
                //计算item的frame
                CGRect frame;
                frame.size = cellSize;
                
                
                //找出最短行后，计算item位置
                frame.origin = CGPointMake(self.sectionInset.left + _maxWidth - self.leastRowWidth,
                                           _maxHeight);
                
                self.lineNumber = 1;
                _maxHeight = frame.size.height + self.rowSpacing + _maxHeight;
                
                attr.frame = frame;
                [_array addObject:attr];
                ++i;
                continue;
            }
            else {
                //当图片宽度不足时，取出下一个图片计算再计算所需宽度，仍不足继续取下一个
                if (i < count - 1) {
                    ++i;
                    NSIndexPath *indexPath1 = [NSIndexPath indexPathForItem:i inSection:0];
                    UICollectionViewLayoutAttributes *attr1 = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath1];
                    
                    CGSize cellSize1 ;
                    if (self.blockSize != nil) {
                        cellSize1 = self.blockSize(indexPath1);
                    }
                    else {
                        NSAssert(cellSize1.height != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
                    }
                    if (cellSize.width +cellSize1.width +self.rowSpacing> _maxWidth) {
                        cellSize = CGSizeMake((_maxWidth - self.rowSpacing)*(cellSize.width/(cellSize.width + cellSize1.width)),
                                              (_maxWidth - self.rowSpacing)*(cellSize.width/(cellSize.width + cellSize1.width))*cellSize.height/cellSize.width);
                        //计算item的frame
                        CGRect frame;
                        frame.size = cellSize;
                        
                        frame.origin = CGPointMake(self.sectionInset.left + _maxWidth - self.leastRowWidth,
                                                   _maxHeight);
                        
                        attr.frame = frame;
                        
                        //计算item1的frame
                        CGRect frame1;
                        cellSize1 = CGSizeMake(_maxWidth - cellSize.width - self.rowSpacing,
                                               (_maxWidth - cellSize.width - self.rowSpacing)*cellSize1.height/cellSize1.width);
                        frame1.size = cellSize1;
                        
                        frame1.origin = CGPointMake(self.sectionInset.left + cellSize.width+self.rowSpacing,
                                                   _maxHeight);
                        
                        
                        _maxHeight= frame.size.height + self.lineSpacing + _maxHeight;
                        
                        attr1.frame = frame1;
                        
                        [_array addObject:attr];
                        [_array addObject:attr1];
                        ++i;
                        continue;
                    }
                    else {
                        ++i;
                    }
                    
                }
                else {
                    cellSize = CGSizeMake(_maxWidth, cellSize.height * _maxWidth / cellSize.width);
                    
                    //计算item的frame
                    CGRect frame;
                    frame.size = cellSize;
                    
                    
                    //找出最短行后，计算item位置
                    frame.origin = CGPointMake(self.sectionInset.left + _maxWidth - self.leastRowWidth,
                                               _maxHeight);
                    
                    self.lineNumber = 1;
                    _maxHeight = frame.size.height + self.rowSpacing + _maxHeight;
                    
                    attr.frame = frame;
                    [_array addObject:attr];
                    ++i;
                    continue;
                }
            }
        }
        else {
            
        }
        
    }
}

/**
 *  设置可滚动区域范围
 */
- (CGSize)collectionViewContentSize{
//    __block NSString *maxHeightline = @"0";
//    [_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
//        if ([_dicOfheight[maxHeightline] floatValue] < [obj floatValue] ) {
//            maxHeightline = key;
//        }
//    }];
    return CGSizeMake(self.collectionView.bounds.size.width, _maxHeight + self.sectionInset.bottom);
}
/**
 *  计算indexPath下item的属性的方法
 *
 *  @return item的属性
 */
/*
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //通过indexPath创建一个item属性attr
    UICollectionViewLayoutAttributes *attr = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGSize cellSize ;
    if (self.blockSize != nil) {
        cellSize = self.blockSize(indexPath);
    }
    else {
        NSAssert(cellSize.height != 0,@"Please implement computeIndexCellHeightWithWidthBlock Method");
    }
    
    //每一行高度是固定的
    static CGFloat currentRowHeight = 0;
    
    
    if (self.lineNumber == 1) {
        currentRowHeight = cellSize.height;
        self.leastRowWidth = _maxWidth;
//        NSLog(@"第一列最大宽度%f 剩余宽度%f",_maxWidth,self.leastRowWidth);

        //当图片宽度大于collectionView时
        if (cellSize.width > _maxWidth && self.lineNumber) {
            //当图片宽度大于collectionView时,单独占一行
            cellSize = CGSizeMake(_maxWidth, cellSize.height * _maxWidth / cellSize.width);
        }
    }
    else {
        cellSize = CGSizeMake(cellSize.width * currentRowHeight/cellSize.height,currentRowHeight);
    }
    
    
    
    //计算item的frame
    CGRect frame;
    frame.size = cellSize;//CGSizeMake(itemW, itemH);
    //循环遍历找出高度最短行
    __block NSString *lineMinHeight = @"0";
    [_dicOfheight enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {//key行0 - obj列高10
        if ([_dicOfheight[lineMinHeight] floatValue] > [obj floatValue]) {
            lineMinHeight = key;
        }
    }];
//    int line = [lineMinHeight intValue];
    
    //找出最短行后，计算item位置
//    NSLog(@"最大宽度%f 剩余宽度%f",_maxWidth,self.leastRowWidth);
    frame.origin = CGPointMake(self.sectionInset.left + _maxWidth - self.leastRowWidth+(self.lineNumber -1 )*self.rowSpacing,
                               [_dicOfheight[lineMinHeight] floatValue]);
    
    self.leastRowWidth = self.leastRowWidth - cellSize.width - (self.lineNumber-1)*self.rowSpacing;
    if (self.leastRowWidth > 0) {
        self.lineNumber++;
    }
    else {
        self.lineNumber = 1;
        _dicOfheight[lineMinHeight] = @(frame.size.height + self.rowSpacing + [_dicOfheight[lineMinHeight] floatValue]);
    }
    
    
    attr.frame = frame;
    return attr;
}
 */
/**
 *  返回视图框内item的属性，可以直接返回所有item属性
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _array;
}
/**
 *  设置计算高度block方法
 *
 *  @param block 计算item高度的block
 */
- (void)computeIndexCellHeightWithWidthBlock:(CGFloat (^)(NSIndexPath *, CGFloat))block{
    if (self.block != block) {
        self.block = block;
    }
}

- (void)computeIndexCellSizeWithWidthBlock:(CGSize (^)(NSIndexPath *))block {
    if (self.blockSize != block) {
        self.blockSize = block;
    }
}
@end
