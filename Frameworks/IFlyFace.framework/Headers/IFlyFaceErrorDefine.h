//
//  IFlyFaceErrorDefine.h
//  MSC
//
//  Created by ypzhao on 12-11-28.
//  Copyright (c) 2014年 iflytek. All rights reserved.
//

#ifndef MSC_IFlyFaceErrorDefine_h
#define MSC_IFlyFaceErrorDefine_h


/**
 *  人脸识别错误类型
 */
typedef NS_ENUM(NSInteger,IFlyFaceErrorType){
    
    /**
     *  内核错误
     */
    ERROR_FACE_KERNEL_CASE_1             = -1,
    /**
     *  内核错误
     */
    ERROR_FACE_KERNEL_CASE_2             = -2,
    /**
     *  内核错误
     */
    ERROR_FACE_KERNEL_CASE_3             = -3,
    /**
     *  内核错误
     */
    ERROR_FACE_KERNEL_CASE_4             = -4,
    /**
     *  引擎一般错误
     */
    ERROR_FACE_KERNEL_CASE_NORMO         = 10100,
    /**
     *  参数错误
     */
    ERROR_FACE_PARAM                     = 10106,
    /**
     *  网络超时
     */
    ERROR_FACE_NET_TIMEOUT               = 10114,
    /**
     *  没有找到模型
     */
    ERROR_FACE_GID                       = 10116,
    /**
     *  传入的图片为空
     */
    ERROR_FACE_IMAGE_NULL                = 10118,
    /**
     *  用户注册图片授权满
     */
    ERROR_FACE_AUTH_IMGAGE_FULL          = 10121,
    /**
     *  用户信息有问题
     */
    ERROR_FACE_USERINFO                  = 10404,
    /**
     *  pmacs向数据库插入数据有问题，反应在注册图片时和获取用户信息时返回。
     */
    ERROR_FACE_PMACS                     = 10400,
    /**
     *  传输入的图片有问题，导致引擎处理超时。
     */
    ERROR_FACE_IMAGE_INVALID             = 10700,
    /**
     *  用户的使用授权满
     */
    ERROR_FACE_AUTH_FULL                 = 11201,
    /**
     *  未找到模型
     */
    ERROR_FACE_NO_MODEL                  = 11610,
    /**
     *  无人脸，对应的引擎错误码是20200
     */
    ERROR_FACE_NOT_FACE_IMAGE			 = 11700,
    /**
     *  人脸向左，对应的引擎错误码是20201
     */
    ERROR_FACE_IMAGE_FULL_LEFT			 = 11701,
    /**
     *  人脸向右，对应的引擎错误码是20202
     */
    ERROR_FACE_IMAGE_FULL_RIGHT			 = 11702,
    /**
     *  顺时针旋转，对应的引擎错误码是20203
     */
    ERROR_FACE_CLOCKWISE_WHIRL			 = 11703,
    /**
     *  逆时针旋转，对应的引擎错误码是20204
     */
    ERROR_FACE_COUNTET_CLOCKWISE_WHIRL	 = 11704,
    /**
     *  图片大小异常 ，对应的引擎错误码是20205
     */
    ERROR_FACE_VALID_IMAGE_SIZE			 = 11705,
    /**
     *  光照异常，对应的引擎错误码是20206
     */
    ERROR_FACE_ILLUMINATION				 = 11706,
    /**
     *  人脸被遮挡，对应的引擎错误码是20207
     */
    ERROR_FACE_OCCULTATION				 = 11707,
    /**
     *  非法模型数据，对应的引擎错误码是20208
     */
    ERROR_FACE_INVALID_MODEL			 = 11708,
    /**
     *  输入数据类型非法，对应的引擎错误码是20300
     */
    ERROR_FACE_FUSION_INVALID_INPUT_TYPE = 11709,
    /**
     *  输入的数据不完整，对应的引擎错误码是20301
     */
    ERROR_FACE_FUSION_NO_ENOUGH_DATA	 = 11710,
    /**
     *  输入的数据过多，对应的引擎错误码是20302
     */
    ERROR_FACE_FUSION_ENOUGH_DATA		 = 11711
    
};

#endif /*MSC_IFlyFaceErrorDefine_h*/



