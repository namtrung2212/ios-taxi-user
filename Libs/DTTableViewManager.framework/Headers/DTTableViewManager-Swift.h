// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.8 clang-703.0.31)
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
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
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
#if defined(__has_feature) && __has_feature(modules)
@import ObjectiveC;
@import UIKit;
@import CoreGraphics;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class NSBundle;
@class MemoryStorage;


/// DTTableViewManager manages some of UITableView datasource and delegate methods and provides API for managing your data models in the table. Any method, that is not implemented by DTTableViewManager, will be forwarded to delegate.\See 
///
/// <code>startManagingWithDelegate:
/// </code>
SWIFT_CLASS("_TtC18DTTableViewManager18DTTableViewManager")
@interface DTTableViewManager : NSObject

/// Bundle to search your xib's in. This can sometimes be useful for unit-testing. Defaults to NSBundle.mainBundle()
@property (nonatomic, strong) NSBundle * _Nonnull viewBundle;

/// Implicitly unwrap storage property to MemoryStorage.\Warning 
///
/// if storage is not MemoryStorage, will throw an exception.
@property (nonatomic, readonly, strong) MemoryStorage * _Null_unspecified memoryStorage;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager))

/// Any UITableViewDatasource and UITableViewDelegate method, that is not implemented by DTTableViewManager will be redirected to delegate, if it implements it.
///
/// \param aSelector selector to forward
///
/// \returns  <code>DTTableViewManageable
/// </code> delegate
- (id _Nullable)forwardingTargetForSelector:(SEL _Null_unspecified)aSelector;

/// Any UITableViewDatasource and UITableViewDelegate method, that is not implemented by DTTableViewManager will be redirected to delegate, if it implements it.
///
/// \param aSelector selector to respond to
///
/// \returns  whether delegate will respond to selector
- (BOOL)respondsToSelector:(SEL _Null_unspecified)aSelector;
@end


@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager))

/// Call this method, if you want UITableView to be reloaded, and beforeContentUpdate: and afterContentUpdate: closures to be called.
- (void)storageNeedsReloading;
@end

@class UITableView;
@class UITableViewCell;
@class NSIndexPath;
@class UIView;

@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager)) <UITableViewDelegate, UIScrollViewDelegate>
- (void)tableView:(UITableView * _Nonnull)tableView willDisplayCell:(UITableViewCell * _Nonnull)cell forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (UIView * _Nullable)tableView:(UITableView * _Nonnull)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView * _Nullable)tableView:(UITableView * _Nonnull)tableView viewForFooterInSection:(NSInteger)section;

/// You can implement this method on a DTTableViewManageable delegate, and then it will be called to determine header height\Note 
///
/// In most cases, it's enough to set sectionHeaderHeight property on UITableView and overriding this method is not actually needed\Note 
///
/// If you override this method on a delegate, displayHeaderOnEmptySection property is ignored
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForHeaderInSection:(NSInteger)section;

/// You can implement this method on a DTTableViewManageable delegate, and then it will be called to determine footer height\Note 
///
/// In most cases, it's enough to set sectionFooterHeight property on UITableView and overriding this method is not actually needed\Note 
///
/// If you override this method on a delegate, displayFooterOnEmptySection property is ignored
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForFooterInSection:(NSInteger)section;
- (void)tableView:(UITableView * _Nonnull)tableView didSelectRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end


@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager)) <UITableViewDataSource>
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (NSString * _Nullable)tableView:(UITableView * _Nonnull)tableView titleForHeaderInSection:(NSInteger)section;
- (NSString * _Nullable)tableView:(UITableView * _Nonnull)tableView titleForFooterInSection:(NSInteger)section;

/// DTTableViewManager automatically moves data models from source indexPath to destination indexPath, there's no need to implement this method on UITableViewDataSource
- (void)tableView:(UITableView * _Nonnull)tableView moveRowAtIndexPath:(NSIndexPath * _Nonnull)sourceIndexPath toIndexPath:(NSIndexPath * _Nonnull)destinationIndexPath;
@end


@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager))
@end


@interface DTTableViewManager (SWIFT_EXTENSION(DTTableViewManager))
@end


@interface UIView (SWIFT_EXTENSION(DTTableViewManager))
@end

#pragma clang diagnostic pop
