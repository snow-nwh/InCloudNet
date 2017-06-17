//
//  ImageModel.h
//  InCloudNet
//
//  Created by 聂文辉 on 2017/6/16.
//  Copyright © 2017年 snow_nwh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageModel : NSObject

@property (nonatomic,copy) NSString *_thumb;
@property (nonatomic,copy) NSString *_thumb_bak;
@property (nonatomic,copy) NSString *downurl;
@property (nonatomic,copy) NSString *dspurl;
@property (nonatomic,copy) NSString *thumbWidth;
@property (nonatomic,copy) NSString *thumbHeight;


@end

/*
 "_thumb" = "http://p3.so.qhmsg.com/sdr/_240_/t010822b5c997f73de8.jpg";
 "_thumb_bak" = "http://p3.so.qhmsg.com/sdr/_240_/t010822b5c997f73de8.jpg";
 downurl = 0;
 dsptime = "";
 dspurl = "mt.sohu.com";
 fixedSize = 0;
 grpcnt = 1;
 grpmd5 = 0;
 height = 685;
 id = 1c7da19bb02d58c1fc92b335fb2850ee;
 img = "http://n1.itc.cn/img8/wb/recom/2016/04/22/146131460970003292.JPEG";
 imgsize = 144KB;
 imgtype = JPEG;
 index = 0;
 key = 6c6afcbbaa;
 link = "http://mt.sohu.com/20160422/n445678948.shtml";
 litetitle = "";
 "qqface_down_url" = 0;
 source = 2;
 src = 1;
 thumb = "http://p3.so.qhmsg.com/t010822b5c997f73de8.jpg";
 thumbHeight = 240;
 thumbWidth = 359;
 "thumb_bak" = "http://p3.so.qhmsg.com/t010822b5c997f73de8.jpg";
 title = "emond\U7684\U65b9\U5f0f\U6539\U53d8\U81ea\U884c\U8f66\U7684\U4f7f\U7528\U573a\U666f,<em>mobike</em>\U60f3";
 type = 0;
 width = 1024;
 */
