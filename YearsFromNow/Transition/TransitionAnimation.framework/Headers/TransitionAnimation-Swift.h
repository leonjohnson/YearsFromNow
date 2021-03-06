// Generated by Apple Swift version 3.1 (swiftlang-802.0.53 clang-802.0.42)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if defined(__has_attribute) && __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if defined(__has_attribute) && __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import UIKit;
@import CoreGraphics;
@import Foundation;
@import QuartzCore;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIView;
@protocol UIViewControllerContextTransitioning;
@class UIPercentDrivenInteractiveTransition;

SWIFT_CLASS("_TtC19TransitionAnimation24BlixtTransitionAnimation")
@interface BlixtTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) UIView * _Nonnull keyView;
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
@property (nonatomic, readonly) CGRect toFrame;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


@interface CABasicAnimation (SWIFT_EXTENSION(TransitionAnimation))
@end


/// Apple Default Push Transition
SWIFT_CLASS("_TtC19TransitionAnimation30DefaultPushTransitionAnimation")
@interface DefaultPushTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Like Elevate
SWIFT_CLASS("_TtC19TransitionAnimation26ElevateTransitionAnimation")
@interface ElevateTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, readonly, strong) UIView * _Nonnull maskView;
@property (nonatomic, readonly) CGPoint toPosition;
@property (nonatomic, readonly, strong) UIView * _Nonnull maskViewCopy;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class CAAnimation;

@interface ElevateTransitionAnimation (SWIFT_EXTENSION(TransitionAnimation)) <CAAnimationDelegate>
- (void)animationDidStop:(CAAnimation * _Nonnull)anim finished:(BOOL)flag;
@end


/// Fade Out In Animation
SWIFT_CLASS("_TtC19TransitionAnimation23FadeTransitionAnimation")
@interface FadeTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Like IBanTang, View Move
SWIFT_CLASS("_TtC19TransitionAnimation27IBanTangTransitionAnimation")
@interface IBanTangTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, readonly, strong) UIView * _Nonnull keyView;
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
@property (nonatomic, readonly, strong) UIView * _Nonnull keyViewCopy;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// OmniFocus app push transition implement.
SWIFT_CLASS("_TtC19TransitionAnimation23OMNITransitionAnimation")
@interface OMNITransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic, strong) UIView * _Nonnull bottomView;
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
@property (nonatomic, readonly, strong) UIView * _Nonnull keyView;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Page Motion
SWIFT_CLASS("_TtC19TransitionAnimation23PageTransitionAnimation")
@interface PageTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Pop Your Tip ViewController.
SWIFT_CLASS("_TtC19TransitionAnimation25PopTipTransitionAnimation")
@interface PopTipTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
@property (nonatomic, readonly) CGFloat visibleHeight;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIPanGestureRecognizer;

/// Like Scanbot present.
SWIFT_CLASS("_TtC19TransitionAnimation26ScanbotTransitionAnimation")
@interface ScanbotTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nullable percentTransition;
@property (nonatomic) BOOL cancelPop;
@property (nonatomic) BOOL interacting;
@property (nonatomic) BOOL edgeSlidePop;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (void)slideTransition:(UIPanGestureRecognizer * _Nonnull)sender;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end

@class UIGestureRecognizer;

SWIFT_CLASS("_TtC19TransitionAnimation24SlideTransitionAnimation")
@interface SlideTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, copy) void (^ _Nullable completion)(void);
@property (nonatomic, strong) UIGestureRecognizer * _Nullable gestureRecognizer;
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * _Nonnull percentTransition;
@property (nonatomic) CGFloat interactivePrecent;
@property (nonatomic) BOOL interacting;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (void)interactiveTransition:(UIPanGestureRecognizer * _Nonnull)sender;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


SWIFT_CLASS("_TtC19TransitionAnimation29TaaskyFlipTransitionAnimation")
@interface TaaskyFlipTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
@property (nonatomic, readonly) BOOL blurEffect;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


/// Like Twitter Present.
SWIFT_CLASS("_TtC19TransitionAnimation26TwitterTransitionAnimation")
@interface TwitterTransitionAnimation : NSObject <UIViewControllerAnimatedTransitioning>
@property (nonatomic, strong) id <UIViewControllerContextTransitioning> _Nullable transitionContext;
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning> _Nullable)transitionContext SWIFT_WARN_UNUSED_RESULT;
- (void)animateTransition:(id <UIViewControllerContextTransitioning> _Nonnull)transitionContext;
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
@end


@interface UIScreen (SWIFT_EXTENSION(TransitionAnimation))
/// Get screen center.
@property (nonatomic, readonly) CGPoint tr_center;
@end


@interface UIView (SWIFT_EXTENSION(TransitionAnimation))
/// Create copy contents view.
- (UIView * _Nonnull)tr_copyWithContents SWIFT_WARN_UNUSED_RESULT;
/// Create copy snapshot view.
- (UIView * _Nonnull)tr_copyWithSnapshot SWIFT_WARN_UNUSED_RESULT;
/// Add view with convert point.
- (void)tr_addSubview:(UIView * _Nonnull)view convertFrom:(UIView * _Nonnull)fromView;
@end

#pragma clang diagnostic pop
