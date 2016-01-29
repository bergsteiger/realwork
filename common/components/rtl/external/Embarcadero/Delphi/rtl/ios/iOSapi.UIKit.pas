{**********************************************************}
{                                                          }
{           CodeGear Delphi Runtime Library                }
{                                                          }
{ Delphi-Objective-C Bridge                                }
{ Interfaces for Cocoa framework UIKit                     }
{                                                          }
{ Copyright (c) 2005-2011, Apple Inc. All rights reserved. }
{                                                          }
{ Translator: Embarcadero Technologies, Inc.               }
{   Copyright(c) 2012-2013 Embarcadero Technologies, Inc.  }
{                                                          }
{**********************************************************}

unit iOSapi.UIKit;

interface

uses Macapi.ObjCRuntime, Macapi.ObjectiveC, iOSapi.Cocoatypes, Macapi.CoreFoundation,
 iOSapi.Foundation, iOSapi.CoreImage, iOSapi.QuartzCore, iOSapi.CoreData,
 iOSapi.CoreGraphics;
//  iOSapi.ObjCRuntime,
//  iOSapi.ObjectiveC,
//  iOSapi.CocoaTypes,
//  iOSapi.IOKit;

const
  UIAccessibilityScrollDirectionDown = 4;
  UIAccessibilityScrollDirectionLeft = 2;
  UIAccessibilityScrollDirectionRight = 1;
  UIAccessibilityScrollDirectionUp = 3;
  UIActionSheetStyleAutomatic = -1;
  UIActionSheetStyleBlackOpaque = 1;
  UIActionSheetStyleBlackTranslucent = 2;
  UIActionSheetStyleDefault = 0;
  UIActivityIndicatorViewStyleGray = 2;
  UIActivityIndicatorViewStyleWhite = 1;
  UIActivityIndicatorViewStyleWhiteLarge = 0;
  UIAlertViewStyleDefault = 0;
  UIAlertViewStyleLoginAndPasswordInput = 3;
  UIAlertViewStylePlainTextInput = 2;
  UIAlertViewStyleSecureTextInput = 1;
  UIBarButtonItemStyleBordered = 1;
  UIBarButtonItemStyleDone = 2;
  UIBarButtonItemStylePlain = 0;
  UIBarButtonSystemItemAction = 9;
  UIBarButtonSystemItemAdd = 4;
  UIBarButtonSystemItemBookmarks = 11;
  UIBarButtonSystemItemCamera = 15;
  UIBarButtonSystemItemCancel = 1;
  UIBarButtonSystemItemCompose = 7;
  UIBarButtonSystemItemDone = 0;
  UIBarButtonSystemItemEdit = 2;
  UIBarButtonSystemItemFastForward = 20;
  UIBarButtonSystemItemFixedSpace = 6;
  UIBarButtonSystemItemFlexibleSpace = 5;
  UIBarButtonSystemItemOrganize = 10;
  UIBarButtonSystemItemPause = 18;
  UIBarButtonSystemItemPlay = 17;
  UIBarButtonSystemItemRefresh = 13;
  UIBarButtonSystemItemReply = 8;
  UIBarButtonSystemItemRewind = 19;
  UIBarButtonSystemItemSave = 3;
  UIBarButtonSystemItemSearch = 12;
  UIBarButtonSystemItemStop = 14;
  UIBarButtonSystemItemTrash = 16;
  UIBarMetricsDefault = 0;
  UIBarMetricsLandscapePhone = 1;
  UIBarStyleBlack = 1;
  UIBarStyleBlackOpaque = 1;
  UIBarStyleBlackTranslucent = 2;
  UIBarStyleDefault = 0;
  UIBaselineAdjustmentAlignBaselines = 0;
  UIBaselineAdjustmentAlignCenters = 1;
  UIBaselineAdjustmentNone = 2;
  UIButtonTypeContactAdd = 5;
  UIButtonTypeCustom = 0;
  UIButtonTypeDetailDisclosure = 2;
  UIButtonTypeInfoDark = 4;
  UIButtonTypeInfoLight = 3;
  UIButtonTypeRoundedRect = 1;
  UIControlContentHorizontalAlignmentCenter = 0;
  UIControlContentHorizontalAlignmentFill = 3;
  UIControlContentHorizontalAlignmentLeft = 1;
  UIControlContentHorizontalAlignmentRight = 2;
  UIControlContentVerticalAlignmentBottom = 2;
  UIControlContentVerticalAlignmentCenter = 0;
  UIControlContentVerticalAlignmentFill = 3;
  UIControlContentVerticalAlignmentTop = 1;
  UIControlEventAllEditingEvents = 983040;
  UIControlEventAllEvents = 4294967295;
  UIControlEventAllTouchEvents = 4095;
  UIControlEventApplicationReserved = 251658240;
  UIControlEventEditingChanged = 131072;
  UIControlEventEditingDidBegin = 65536;
  UIControlEventEditingDidEnd = 262144;
  UIControlEventEditingDidEndOnExit = 524288;
  UIControlEventSystemReserved = 4026531840;
  UIControlEventTouchCancel = 256;
  UIControlEventTouchDown = 1;
  UIControlEventTouchDownRepeat = 2;
  UIControlEventTouchDragEnter = 16;
  UIControlEventTouchDragExit = 32;
  UIControlEventTouchDragInside = 4;
  UIControlEventTouchDragOutside = 8;
  UIControlEventTouchUpInside = 64;
  UIControlEventTouchUpOutside = 128;
  UIControlEventValueChanged = 4096;
  UIControlStateApplication = 16711680;
  UIControlStateDisabled = 2;
  UIControlStateHighlighted = 1;
  UIControlStateNormal = 0;
  UIControlStateReserved = 4278190080;
  UIControlStateSelected = 4;
  UIDataDetectorTypeAll = 1;
  UIDataDetectorTypeLink = 2;
  UIDataDetectorTypeNone = 0;
  UIDataDetectorTypePhoneNumber = 1;
  UIDatePickerModeCountDownTimer = 3;
  UIDatePickerModeDate = 1;
  UIDatePickerModeDateAndTime = 2;
  UIDatePickerModeTime = 0;
  UIDeviceBatteryStateCharging = 2;
  UIDeviceBatteryStateFull = 3;
  UIDeviceBatteryStateUnknown = 0;
  UIDeviceBatteryStateUnplugged = 1;
  UIDeviceOrientationFaceDown = 6;
  UIDeviceOrientationFaceUp = 5;
  UIDeviceOrientationLandscapeLeft = 3;
  UIDeviceOrientationLandscapeRight = 4;
  UIDeviceOrientationPortrait = 1;
  UIDeviceOrientationPortraitUpsideDown = 2;
  UIDeviceOrientationUnknown = 0;
  UIDocumentChangeCleared = 3;
  UIDocumentChangeDone = 0;
  UIDocumentChangeRedone = 2;
  UIDocumentChangeUndone = 1;
  UIDocumentSaveForCreating = 0;
  UIDocumentSaveForOverwriting = 1;
  UIDocumentStateClosed = 1;
  UIDocumentStateEditingDisabled = 8;
  UIDocumentStateInConflict = 2;
  UIDocumentStateNormal = 0;
  UIDocumentStateSavingError = 4;
  UIEventSubtypeMotionShake = 1;
  UIEventSubtypeNone = 0;
  UIEventSubtypeRemoteControlBeginSeekingBackward = 106;
  UIEventSubtypeRemoteControlBeginSeekingForward = 108;
  UIEventSubtypeRemoteControlEndSeekingBackward = 107;
  UIEventSubtypeRemoteControlEndSeekingForward = 109;
  UIEventSubtypeRemoteControlNextTrack = 104;
  UIEventSubtypeRemoteControlPause = 101;
  UIEventSubtypeRemoteControlPlay = 100;
  UIEventSubtypeRemoteControlPreviousTrack = 105;
  UIEventSubtypeRemoteControlStop = 102;
  UIEventSubtypeRemoteControlTogglePlayPause = 103;
  UIEventTypeMotion = 1;
  UIEventTypeRemoteControl = 2;
  UIEventTypeTouches = 0;
  UIGestureRecognizerStateBegan = 1;
  UIGestureRecognizerStateCancelled = 4;
  UIGestureRecognizerStateChanged = 2;
  UIGestureRecognizerStateEnded = 3;
  UIGestureRecognizerStateFailed = 5;
  UIGestureRecognizerStatePossible = 0;
  UIGestureRecognizerStateRecognized = 3;
  UIImageOrientationDown = 1;
  UIImageOrientationDownMirrored = 5;
  UIImageOrientationLeft = 2;
  UIImageOrientationLeftMirrored = 6;
  UIImageOrientationRight = 3;
  UIImageOrientationRightMirrored = 7;
  UIImageOrientationUp = 0;
  UIImageOrientationUpMirrored = 4;
  UIImagePickerControllerCameraCaptureModePhoto = 0;
  UIImagePickerControllerCameraCaptureModeVideo = 1;
  UIImagePickerControllerCameraDeviceFront = 1;
  UIImagePickerControllerCameraDeviceRear = 0;
  UIImagePickerControllerCameraFlashModeAuto = 0;
  UIImagePickerControllerCameraFlashModeOff = -1;
  UIImagePickerControllerCameraFlashModeOn = 1;
  UIImagePickerControllerQualityTypeHigh = 0;
  UIImagePickerControllerQualityTypeLow = 2;
  UIImagePickerControllerQualityTypeMedium = 1;
  UIImagePickerControllerSourceTypeCamera = 1;
  UIImagePickerControllerSourceTypePhotoLibrary = 0;
  UIImagePickerControllerSourceTypeSavedPhotosAlbum = 2;
  UIInterfaceOrientationLandscapeLeft = 4;
  UIInterfaceOrientationLandscapeRight = 3;
  UIInterfaceOrientationPortrait = 1;
  UIInterfaceOrientationPortraitUpsideDown = 2;
  UIInterfaceOrientationMaskPortrait = 1 shl UIInterfaceOrientationPortrait;
  UIInterfaceOrientationMaskLandscapeLeft = 1 shl UIInterfaceOrientationLandscapeLeft;
  UIInterfaceOrientationMaskLandscapeRight = 1 shl UIInterfaceOrientationLandscapeRight;
  UIInterfaceOrientationMaskPortraitUpsideDown = 1 shl UIInterfaceOrientationPortraitUpsideDown;
  UIInterfaceOrientationMaskLandscape =
    UIInterfaceOrientationMaskLandscapeLeft or UIInterfaceOrientationMaskLandscapeRight;
  UIInterfaceOrientationMaskAll =
    UIInterfaceOrientationMaskPortrait or UIInterfaceOrientationMaskLandscapeLeft or
    UIInterfaceOrientationMaskLandscapeRight or UIInterfaceOrientationMaskPortraitUpsideDown;
  UIInterfaceOrientationMaskAllButUpsideDown =
    UIInterfaceOrientationMaskPortrait or UIInterfaceOrientationMaskLandscapeLeft or
    UIInterfaceOrientationMaskLandscapeRight;
  UIKeyboardAppearanceAlert = 1;
  UIKeyboardAppearanceDefault = 0;
  UIKeyboardTypeASCIICapable = 1;
  UIKeyboardTypeAlphabet = 1;
  UIKeyboardTypeDefault = 0;
  UIKeyboardTypeEmailAddress = 7;
  UIKeyboardTypeNamePhonePad = 6;
  UIKeyboardTypeNumberPad = 4;
  UIKeyboardTypeNumbersAndPunctuation = 2;
  UIKeyboardTypePhonePad = 5;
  UIKeyboardTypeURL = 3;
  UILineBreakModeCharacterWrap = 1;
  UILineBreakModeClip = 2;
  UILineBreakModeHeadTruncation = 3;
  UILineBreakModeMiddleTruncation = 5;
  UILineBreakModeTailTruncation = 4;
  UILineBreakModeWordWrap = 0;
  UIMenuControllerArrowDefault = 0;
  UIModalPresentationFullScreen = 0;
  UIModalTransitionStyleCoverVertical = 0;
  UIModalTransitionStyleCrossDissolve = 2;
  UIModalTransitionStyleFlipHorizontal = 1;
  UIPageViewControllerNavigationDirectionForward = 0;
  UIPageViewControllerNavigationDirectionReverse = 1;
  UIPageViewControllerNavigationOrientationHorizontal = 0;
  UIPageViewControllerNavigationOrientationVertical = 1;
  UIPageViewControllerSpineLocationMax = 3;
  UIPageViewControllerSpineLocationMid = 2;
  UIPageViewControllerSpineLocationMin = 1;
  UIPageViewControllerSpineLocationNone = 0;
  UIPageViewControllerTransitionStylePageCurl = 0;
  UIPopoverArrowDirectionAny = 15;
  UIPopoverArrowDirectionDown = 2;
  UIPopoverArrowDirectionLeft = 4;
  UIPopoverArrowDirectionRight = 8;
  UIPopoverArrowDirectionUnknown = 16;
  UIPopoverArrowDirectionUp = 1;
  UIPrintInfoDuplexLongEdge = 1;
  UIPrintInfoDuplexNone = 0;
  UIPrintInfoDuplexShortEdge = 2;
  UIPrintInfoOrientationLandscape = 1;
  UIPrintInfoOrientationPortrait = 0;
  UIPrintInfoOutputGeneral = 0;
  UIPrintInfoOutputGrayscale = 2;
  UIPrintInfoOutputPhoto = 1;
  UIPrintJobFailedError = 4;
  UIPrintNoContentError = 2;
  UIPrintUnknownImageFormatError = 3;
  UIPrintingNotAvailableError = 1;
  UIProgressViewStyleBar = 1;
  UIProgressViewStyleDefault = 0;
  UIRectCornerAllCorners = -1;
  UIRectCornerBottomLeft = 4;
  UIRectCornerBottomRight = 8;
  UIRectCornerTopLeft = 1;
  UIRectCornerTopRight = 2;
  UIReturnKeyDefault = 0;
  UIReturnKeyDone = 9;
  UIReturnKeyEmergencyCall = 10;
  UIReturnKeyGo = 1;
  UIReturnKeyGoogle = 2;
  UIReturnKeyJoin = 3;
  UIReturnKeyNext = 4;
  UIReturnKeyRoute = 5;
  UIReturnKeySearch = 6;
  UIReturnKeySend = 7;
  UIReturnKeyYahoo = 8;
  UIScreenOverscanCompensationInsetApplicationFrame = 2;
  UIScreenOverscanCompensationInsetBounds = 1;
  UIScreenOverscanCompensationScale = 0;
  UIScrollViewIndicatorStyleBlack = 1;
  UIScrollViewIndicatorStyleDefault = 0;
  UIScrollViewIndicatorStyleWhite = 2;
  UISearchBarIconBookmark = 2;
  UISearchBarIconClear = 1;
  UISearchBarIconResultsList = 3;
  UISearchBarIconSearch = 0;
  UISegmentedControlNoSegment = -1;
  UISegmentedControlSegmentAlone = 4;
  UISegmentedControlSegmentAny = 0;
  UISegmentedControlSegmentCenter = 2;
  UISegmentedControlSegmentLeft = 1;
  UISegmentedControlSegmentRight = 3;
  UISegmentedControlStyleBar = 2;
  UISegmentedControlStyleBezeled = 3;
  UISegmentedControlStyleBordered = 1;
  UISegmentedControlStylePlain = 0;
  UIStatusBarAnimationNone = 0;
  UIStatusBarStyleBlackOpaque = 2;
  UIStatusBarStyleBlackTranslucent = 1;
  UIStatusBarStyleDefault = 0;
  UISwipeGestureRecognizerDirectionDown = 8;
  UISwipeGestureRecognizerDirectionLeft = 2;
  UISwipeGestureRecognizerDirectionRight = 1;
  UISwipeGestureRecognizerDirectionUp = 4;
  UITabBarSystemItemBookmarks = 7;
  UITabBarSystemItemContacts = 5;
  UITabBarSystemItemDownloads = 9;
  UITabBarSystemItemFavorites = 1;
  UITabBarSystemItemFeatured = 2;
  UITabBarSystemItemHistory = 6;
  UITabBarSystemItemMore = 0;
  UITabBarSystemItemMostRecent = 10;
  UITabBarSystemItemMostViewed = 11;
  UITabBarSystemItemRecents = 4;
  UITabBarSystemItemSearch = 8;
  UITabBarSystemItemTopRated = 3;
  UITableViewCellAccessoryCheckmark = 3;
  UITableViewCellAccessoryDetailDisclosureButton = 2;
  UITableViewCellAccessoryDisclosureIndicator = 1;
  UITableViewCellAccessoryNone = 0;
  UITableViewCellEditingStyleDelete = 1;
  UITableViewCellEditingStyleInsert = 2;
  UITableViewCellEditingStyleNone = 0;
  UITableViewCellSelectionStyleBlue = 1;
  UITableViewCellSelectionStyleGray = 2;
  UITableViewCellSelectionStyleNone = 0;
  UITableViewCellSeparatorStyleNone = 0;
  UITableViewCellSeparatorStyleSingleLine = 1;
  UITableViewCellSeparatorStyleSingleLineEtched = 2;
  UITableViewCellStateDefaultMask = 0;
  UITableViewCellStateEditingMask = 1;
  UITableViewCellStateShowingDeleteConfirmationMask = 2;
  UITableViewCellStateShowingEditControlMask = 1;
  UITableViewCellStyleDefault = 0;
  UITableViewCellStyleSubtitle = 3;
  UITableViewCellStyleValue1 = 1;
  UITableViewCellStyleValue2 = 2;
  UITableViewRowAnimationAutomatic = 100;
  UITableViewRowAnimationBottom = 4;
  UITableViewRowAnimationFade = 0;
  UITableViewRowAnimationLeft = 2;
  UITableViewRowAnimationMiddle = 6;
  UITableViewRowAnimationNone = 5;
  UITableViewRowAnimationRight = 1;
  UITableViewRowAnimationTop = 3;
  UITableViewScrollPositionBottom = 3;
  UITableViewScrollPositionMiddle = 2;
  UITableViewScrollPositionNone = 0;
  UITableViewScrollPositionTop = 1;
  UITableViewStyleGrouped = 1;
  UITableViewStylePlain = 0;
  UITextAlignmentCenter = 1;
  UITextAlignmentLeft = 0;
  UITextAlignmentRight = 2;
  UITextAutocapitalizationTypeAllCharacters = 3;
  UITextAutocapitalizationTypeNone = 0;
  UITextAutocapitalizationTypeSentences = 2;
  UITextAutocapitalizationTypeWords = 1;
  UITextAutocorrectionTypeDefault = 0;
  UITextAutocorrectionTypeNo = 1;
  UITextAutocorrectionTypeYes = 2;
  UITextBorderStyleBezel = 2;
  UITextBorderStyleLine = 1;
  UITextBorderStyleNone = 0;
  UITextBorderStyleRoundedRect = 3;
  UITextFieldViewModeAlways = 3;
  UITextFieldViewModeNever = 0;
  UITextFieldViewModeUnlessEditing = 2;
  UITextFieldViewModeWhileEditing = 1;
  UITextGranularityCharacter = 0;
  UITextGranularityDocument = 5;
  UITextGranularityLine = 4;
  UITextGranularityParagraph = 3;
  UITextGranularitySentence = 2;
  UITextGranularityWord = 1;
  UITextLayoutDirectionDown = 5;
  UITextLayoutDirectionLeft = 3;
  UITextLayoutDirectionRight = 2;
  UITextLayoutDirectionUp = 4;
  UITextStorageDirectionBackward = 1;
  UITextStorageDirectionForward = 0;
  UITextWritingDirectionLeftToRight = 0;
  UITextWritingDirectionNatural = -1;
  UITextWritingDirectionRightToLeft = 1;
  UIToolbarPositionAny = 0;
  UIToolbarPositionBottom = 1;
  UIToolbarPositionTop = 2;
  UITouchPhaseBegan = 0;
  UITouchPhaseCancelled = 4;
  UITouchPhaseEnded = 3;
  UITouchPhaseMoved = 1;
  UITouchPhaseStationary = 2;
  UIUserInterfaceIdiomPhone = 0;
  UIUserInterfaceIdiomPad = 1;
  UIViewAnimationCurveEaseIn = 1;
  UIViewAnimationCurveEaseInOut = 0;
  UIViewAnimationCurveEaseOut = 2;
  UIViewAnimationCurveLinear = 3;
  UIViewAnimationTransitionCurlDown = 4;
  UIViewAnimationTransitionCurlUp = 3;
  UIViewAnimationTransitionFlipFromLeft = 1;
  UIViewAnimationTransitionFlipFromRight = 2;
  UIViewAnimationTransitionNone = 0;
  UIViewAutoresizingFlexibleBottomMargin = 32;
  UIViewAutoresizingFlexibleHeight = 16;
  UIViewAutoresizingFlexibleLeftMargin = 1;
  UIViewAutoresizingFlexibleRightMargin = 4;
  UIViewAutoresizingFlexibleTopMargin = 8;
  UIViewAutoresizingFlexibleWidth = 2;
  UIViewAutoresizingNone = 0;
  UIViewContentModeBottom = 6;
  UIViewContentModeBottomLeft = 11;
  UIViewContentModeBottomRight = 12;
  UIViewContentModeCenter = 4;
  UIViewContentModeLeft = 7;
  UIViewContentModeRedraw = 3;
  UIViewContentModeRight = 8;
  UIViewContentModeScaleAspectFill = 2;
  UIViewContentModeScaleAspectFit = 1;
  UIViewContentModeScaleToFill = 0;
  UIViewContentModeTop = 5;
  UIViewContentModeTopLeft = 9;
  UIViewContentModeTopRight = 10;
  UIWebViewNavigationTypeBackForward = 2;
  UIWebViewNavigationTypeFormResubmitted = 4;
  UIWebViewNavigationTypeFormSubmitted = 1;
  UIWebViewNavigationTypeLinkClicked = 0;
  UIWebViewNavigationTypeOther = 5;
  UIWebViewNavigationTypeReload = 3;

// ===== UIKit typedefs and structs =====
{$M+}
type
  UIAccelerationValue = Double;
  UIAccessibilityNotifications = NSUInteger;
  UIAccessibilityTraits = UInt64;
  UIAccessibilityZoomType = NSUInteger;
  UIActionSheetStyle = NSInteger;
  UIActivityIndicatorViewStyle = NSUInteger;
  UIActivityViewControllerCompletionHandler = NSUInteger;
  UIAlertViewStyle = NSUInteger;
  UIApplicationState = NSUInteger;
  UIBackgroundTaskIdentifier = NSUInteger;
  UIBarButtonItemStyle = NSUInteger;
  UIBarButtonSystemItem = NSUInteger;
  UIBarMetrics = NSUInteger;
  UIBarStyle = NSUInteger;
  UIBaselineAdjustment = NSUInteger;
  UIButtonType = NSUInteger;
  UIControlContentHorizontalAlignment = NSUInteger;
  UIControlContentVerticalAlignment = NSUInteger;
  UIControlEvents = NSUInteger;
  UIControlState = NSUInteger;
  UIDataDetectorTypes = NSUInteger;
  UIDatePickerMode = NSUInteger;
  UIDeviceBatteryState = NSUInteger;
  UIDeviceOrientation = NSUInteger;
  UIDocumentChangeKind = NSInteger;
  UIDocumentSaveOperation = NSInteger;
  UIDocumentState = NSInteger;
  UIEventSubtype = NSUInteger;
  UIEventType = NSUInteger;
  UIGestureRecognizerState = NSUInteger;
  UIImageOrientation = NSUInteger;
  UIImagePickerControllerCameraCaptureMode = NSUInteger;
  UIImagePickerControllerCameraDevice = NSUInteger;
  UIImagePickerControllerCameraFlashMode = NSInteger;
  UIImagePickerControllerQualityType = NSUInteger;
  UIImagePickerControllerSourceType = NSUInteger;
  UIInterfaceOrientation = NSUInteger;
  UIKeyboardAppearance = NSUInteger;
  UIKeyboardType = NSUInteger;
  UILineBreakMode = NSUInteger;
  UIMenuControllerArrowDirection = NSUInteger;
  UIModalPresentationStyle = NSUInteger;
  UIModalTransitionStyle = NSUInteger;
  UIPageViewControllerNavigationDirection = NSInteger;
  UIPageViewControllerNavigationOrientation = NSInteger;
  UIPageViewControllerSpineLocation = NSInteger;
  UIPageViewControllerTransitionStyle = NSInteger;
  UIPopoverArrowDirection = NSUInteger;
  UIPrintInfoDuplex = NSUInteger;
  UIPrintInfoOrientation = NSUInteger;
  UIPrintInfoOutputType = NSUInteger;
  UIProgressViewStyle = NSUInteger;
  UIRectCorner = NSUInteger;
  UIRemoteNotificationType = NSUInteger;
  UIReturnKeyType = NSUInteger;
  UIScreenOverscanCompensation = NSUInteger;
  UIScrollViewIndicatorStyle = NSUInteger;
  UISearchBarIcon = NSUInteger;
  UISegmentedControlSegment = NSUInteger;
  UISegmentedControlStyle = NSUInteger;
  UIStatusBarAnimation = NSUInteger;
  UIStatusBarStyle = NSUInteger;
  UISwipeGestureRecognizerDirection = NSUInteger;
  UITabBarSystemItem = NSUInteger;
  UITableViewCellAccessoryType = NSUInteger;
  UITableViewCellEditingStyle = NSUInteger;
  UITableViewCellSelectionStyle = NSUInteger;
  UITableViewCellSeparatorStyle = NSUInteger;
  UITableViewCellStateMask = NSUInteger;
  UITableViewCellStyle = NSUInteger;
  UITableViewRowAnimation = NSUInteger;
  UITableViewStyle = NSUInteger;
  UITableViewScrollPosition = NSUInteger;
  UITextAlignment = NSUInteger;
  UITextAutocapitalizationType = NSUInteger;
  UITextAutocorrectionType = NSUInteger;
  UITextBorderStyle = NSUInteger;
  UITextFieldViewMode = NSUInteger;
  UITextLayoutDirection = NSUInteger;
  UITextSpellCheckingType = NSUInteger;
  UITextStorageDirection = NSUInteger;
  UITextWritingDirection = NSInteger;
  UIToolbarPosition = NSUInteger;
  UITouchPhase = NSUInteger;
  UIUserInterfaceIdiom = NSUInteger;
  UIUserInterfaceLayoutDirection = NSUInteger;
  UIViewAnimationCurve = NSUInteger;
  UIViewAnimationOptions = NSUInteger;
  UIViewAnimationTransition = NSUInteger;
  UIViewAutoresizing = NSUInteger;
  UIViewContentMode = NSUInteger;
  UIWebViewNavigationType = NSUInteger;
  UIWindowLevel = CGFloat;

  PUIImage = Pointer;
  PNSData = Pointer;

  UIEdgeInsets = record
    top: CGFloat;
    left: CGFloat;
    bottom: CGFloat;
    right: CGFloat;
  end;

  UIOffset = record
    horizontal: CGFloat;
    vertical: CGFloat;
  end;

// ===== External functions =====

const
  libUIKit = '/System/Library/Frameworks/UIKit.framework/UIKit';
{
function CGAffineTransformFromString(string_: PNSString): CGAffineTransform; cdecl; external libUIKit name _PU + 'CGAffineTransformFromString';
function CGPointFromString(string_: PNSString): CGPoint; cdecl; external libUIKit name _PU + 'CGPointFromString';
function CGRectFromString(string_: PNSString): CGRect; cdecl; external libUIKit name _PU + 'CGRectFromString';
function CGSizeFromString(string_: PNSString): CGSize; cdecl; external libUIKit name _PU + 'CGSizeFromString';
function NSStringFromCGAffineTransform(transform: CGAffineTransform): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromCGAffineTransform';
function NSStringFromCGPoint(point: CGPoint): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromCGPoint';
function NSStringFromCGRect(rect: CGRect): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromCGRect';
function NSStringFromCGSize(size: CGSize): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromCGSize';
function NSStringFromUIEdgeInsets(insets: UIEdgeInsets): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromUIEdgeInsets';
function NSStringFromUIOffset(offset: UIOffset): PNSString; cdecl; external libUIKit name _PU + 'NSStringFromUIOffset';
function UIAccessibilityIsClosedCaptioningEnabled: Boolean; cdecl; external libUIKit name _PU + 'UIAccessibilityIsClosedCaptioningEnabled';
function UIAccessibilityIsMonoAudioEnabled: Boolean; cdecl; external libUIKit name _PU + 'UIAccessibilityIsMonoAudioEnabled';
function UIAccessibilityIsVoiceOverRunning: Boolean; cdecl; external libUIKit name _PU + 'UIAccessibilityIsVoiceOverRunning';
procedure UIAccessibilityPostNotification(notification: UIAccessibilityNotifications; argument: Pointer); cdecl; external libUIKit name _PU + 'UIAccessibilityPostNotification';
procedure UIAccessibilityRegisterGestureConflictWithZoom; cdecl; external libUIKit name _PU + 'UIAccessibilityRegisterGestureConflictWithZoom';
procedure UIAccessibilityZoomFocusChanged(type_: Integer; frame: CGRect; view: PUIView); cdecl; external libUIKit name _PU + 'UIAccessibilityZoomFocusChanged';
}
function UIApplicationMain(argc: Integer; argv: PMarshaledAString; principalClassName: Pointer; delegateClassName: Pointer): Integer; cdecl; external libUIKit name _PU + 'UIApplicationMain';
{
function UIEdgeInsetsEqualToEdgeInsets(insets1: UIEdgeInsets; insets2: UIEdgeInsets): Boolean; cdecl; external libUIKit name _PU + 'UIEdgeInsetsEqualToEdgeInsets';
function UIEdgeInsetsFromString(string_: PNSString): UIEdgeInsets; cdecl; external libUIKit name _PU + 'UIEdgeInsetsFromString';
function UIEdgeInsetsInsetRect(rect: CGRect; insets: UIEdgeInsets): CGRect; cdecl; external libUIKit name _PU + 'UIEdgeInsetsInsetRect';
function UIEdgeInsetsMake(top: Single; left: Single; bottom: Single; right: Single): UIEdgeInsets; cdecl; external libUIKit name _PU + 'UIEdgeInsetsMake';
procedure UIGraphicsAddPDFContextDestinationAtPoint(name: PNSString; point: CGPoint); cdecl; external libUIKit name _PU + 'UIGraphicsAddPDFContextDestinationAtPoint';
procedure UIGraphicsBeginImageContext(size: CGSize); cdecl; external libUIKit name _PU + 'UIGraphicsBeginImageContext';
}
procedure UIGraphicsBeginImageContextWithOptions(size: CGSize; opaque: Boolean; scale: Single); cdecl; external libUIKit name _PU + 'UIGraphicsBeginImageContextWithOptions';
{
procedure UIGraphicsBeginPDFContextToData(data: PNSMutableData; bounds: CGRect; documentInfo: PNSDictionary); cdecl; external libUIKit name _PU + 'UIGraphicsBeginPDFContextToData';
function UIGraphicsBeginPDFContextToFile(path: PNSString; bounds: CGRect; documentInfo: PNSDictionary): Boolean; cdecl; external libUIKit name _PU + 'UIGraphicsBeginPDFContextToFile';
procedure UIGraphicsBeginPDFPage; cdecl; external libUIKit name _PU + 'UIGraphicsBeginPDFPage';
procedure UIGraphicsBeginPDFPageWithInfo(bounds: CGRect; pageInfo: PNSDictionary); cdecl; external libUIKit name _PU + 'UIGraphicsBeginPDFPageWithInfo';
procedure UIGraphicsEndPDFContext; cdecl; external libUIKit name _PU + 'UIGraphicsEndPDFContext';
}
procedure UIGraphicsEndImageContext; cdecl; external libUIKit name _PU + 'UIGraphicsEndImageContext';
function UIGraphicsGetCurrentContext: CGContextRef; cdecl; external libUIKit name _PU + 'UIGraphicsGetCurrentContext';
function UIGraphicsGetImageFromCurrentImageContext: PUIImage; cdecl; external libUIKit name _PU + 'UIGraphicsGetImageFromCurrentImageContext';
{
function UIGraphicsGetPDFContextBounds: CGRect; cdecl; external libUIKit name _PU + 'UIGraphicsGetPDFContextBounds';
procedure UIGraphicsPopContext; cdecl; external libUIKit name _PU + 'UIGraphicsPopContext';
procedure UIGraphicsPushContext(context: CGContextRef); cdecl; external libUIKit name _PU + 'UIGraphicsPushContext';
procedure UIGraphicsSetPDFContextDestinationForRect(name: PNSString; rect: CGRect); cdecl; external libUIKit name _PU + 'UIGraphicsSetPDFContextDestinationForRect';
procedure UIGraphicsSetPDFContextURLForRect(url: PNSURL; rect: CGRect); cdecl; external libUIKit name _PU + 'UIGraphicsSetPDFContextURLForRect';
}
function UIImageJPEGRepresentation(image: PUIImage; compressionQuality: Single): PNSData; cdecl; external libUIKit name _PU + 'UIImageJPEGRepresentation';
function UIImagePNGRepresentation(image: PUIImage): PNSData; cdecl; external libUIKit name _PU + 'UIImagePNGRepresentation';
procedure UIImageWriteToSavedPhotosAlbum(image: PUIImage; completionTarget: Pointer; completionSelector: SEL; contextInfo: Pointer); cdecl; external libUIKit name _PU + 'UIImageWriteToSavedPhotosAlbum';
{
function UIOffsetEqualToOffset(offset1: UIOffset; offset2: UIOffset): Boolean; cdecl; external libUIKit name _PU + 'UIOffsetEqualToOffset';
function UIOffsetFromString(string_: PNSString): UIOffset; cdecl; external libUIKit name _PU + 'UIOffsetFromString';
function UIOffsetMake(horizontal: Single; vertical: Single): UIOffset; cdecl; external libUIKit name _PU + 'UIOffsetMake';
procedure UIRectClip(rect: CGRect); cdecl; external libUIKit name _PU + 'UIRectClip';
procedure UIRectFill(rect: CGRect); cdecl; external libUIKit name _PU + 'UIRectFill';
procedure UIRectFillUsingBlendMode(rect: CGRect; blendMode: CGBlendMode); cdecl; external libUIKit name _PU + 'UIRectFillUsingBlendMode';
procedure UIRectFrame(rect: CGRect); cdecl; external libUIKit name _PU + 'UIRectFrame';
procedure UIRectFrameUsingBlendMode(rect: CGRect; blendMode: CGBlendMode); cdecl; external libUIKit name _PU + 'UIRectFrameUsingBlendMode';
procedure UISaveVideoAtPathToSavedPhotosAlbum(videoPath: PNSString; completionTarget: Pointer; completionSelector: SEL; contextInfo: Pointer); cdecl; external libUIKit name _PU + 'UISaveVideoAtPathToSavedPhotosAlbum';
function UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(videoPath: PNSString): Boolean; cdecl; external libUIKit name _PU + 'UIVideoAtPathIsCompatibleWithSavedPhotosAlbum';
}

type
{$M+}
// ===== Forward declarations =====

  NSValue = interface;
  UITextInputMode = interface;
  UIMenuItem = interface;
  UIMenuController = interface;
  UINib = interface;
  UINavigationItem = interface;
  UITextChecker = interface;
  UILocalizedIndexedCollation = interface;
  UIImage = interface;
  UIGestureRecognizer = interface;
  UIFont = interface;
  UILocalNotification = interface;
  UITextInputStringTokenizer = interface;
  UITextRange = interface;
  UIScreenMode = interface;
  UIScreen = interface;
  UIResponder = interface;
  UIStoryboard = interface;
  UISearchDisplayController = interface;
  UIStoryboardSegue = interface;
  UIPrintPaper = interface;
  UIPrintFormatter = interface;
  UIPopoverController = interface;
  UIPasteboard = interface;
  UIPrintPageRenderer = interface;
  UIPrintInteractionController = interface;
  UIPrintInfo = interface;
  UIBarItem = interface;
  UIBezierPath = interface;
  UIAccessibilityElement = interface;
  UIAcceleration = interface;
  UIAccelerometer = interface;
  UIDevice = interface;
  UIDocument = interface;
  UIEvent = interface;
  UIDocumentInteractionController = interface;
  UITouch = interface;
  UIColor = interface;
  UITabBarItem = interface;
  UIRotationGestureRecognizer = interface;
  UISwipeGestureRecognizer = interface;
  UIPinchGestureRecognizer = interface;
  UIMarkupTextPrintFormatter = interface;
  UIViewController = interface;
  UIBarButtonItem = interface;
  UIView = interface;
  UILongPressGestureRecognizer = interface;
  UIManagedDocument = interface;
  UISimpleTextPrintFormatter = interface;
  UIPanGestureRecognizer = interface;
  UIStoryboardPopoverSegue = interface;
  UIApplication = interface;
  UIViewPrintFormatter = interface;
  UITapGestureRecognizer = interface;
  UIWebView = interface;
  UITableViewController = interface;
  UIToolbar = interface;
  UITableViewCell = interface;
  UITabBar = interface;
  UITabBarController = interface;
  UIWindow = interface;
  UISplitViewController = interface;
  UINavigationBar = interface;
  UILabel = interface;
  UINavigationController = interface;
  UIPickerView = interface;
  UIPageViewController = interface;
  UIActivityIndicatorView = interface;
  UIActionSheet = interface;
  UIAlertView = interface;
  UIImageView = interface;
  UIControl = interface;
  UIProgressView = interface;
  UIScrollView = interface;
  UIReferenceLibraryViewController = interface;
  UIPopoverBackgroundView = interface;
  UISearchBar = interface;
  UIVideoEditorController = interface;
  UIButton = interface;
  UIStepper = interface;
  UISlider = interface;
  UISegmentedControl = interface;
  UIDatePicker = interface;
  UITextField = interface;
  UIPageControl = interface;
  UITableView = interface;
  UIImagePickerController = interface;
  UITextView = interface;
  UISwitch = interface;
  UIActivityViewController = interface;

// protocols

//  UIAccelerometerDelegate = interface;
//  UIAccessibilityIdentification = interface;
  UIActionSheetDelegate = interface;
//  UIAlertViewDelegate = interface;
//  UIAppearance = interface;
  UIApplicationDelegate = interface;
//  UIDocumentInteractionControllerDelegate = interface;
  UIGestureRecognizerDelegate = interface;
//  UIImagePickerControllerDelegate = interface;
//  UIInputViewAudioFeedback = interface;
  UIKeyInput = interface;
//  UINavigationBarDelegate = interface;
//  UINavigationControllerDelegate = interface;
//  UIPageViewControllerDataSource = interface;
//  UIPageViewControllerDelegate = interface;
//  UIPickerViewAccessibilityDelegate = interface;
  UIPickerViewDataSource = interface;
  UIPickerViewDelegate = interface;
  UIPopoverControllerDelegate = interface;
//  UIPrintInteractionControllerDelegate = interface;
//  UIScrollViewDelegate = interface;
//  UISearchBarDelegate = interface;
//  UISearchDisplayDelegate = interface;
//  UITabBarControllerDelegate = interface;
//  UITabBarDelegate = interface;
//  UITableViewDataSource = interface;
//  UITableViewDelegate = interface;
//  UITextFieldDelegate = interface;
  UITextInput = interface;
//  UITextInputDelegate = interface;
//  UITextInputTokenizer = interface;
  UITextInputTraits = interface;
//  UITextViewDelegate = interface;
//  UIVideoEditorControllerDelegate = interface;
  UIWebViewDelegate = interface;

// ===== Interface declarations =====

  NSValueClass = interface(NSObjectClass)
    ['{32347938-7927-4C6F-8687-47D76753B5E7}']
    {class} function valueWithCGPoint(point: CGPoint): Pointer; cdecl;
    {class} function valueWithCGRect(rect: CGRect): Pointer; cdecl;
    {class} function valueWithCGSize(size: CGSize): Pointer; cdecl;
    {class} function valueWithUIEdgeInsets(insets: UIEdgeInsets): Pointer; cdecl;
    {class} function valueWithUIOffset(insets: UIOffset): Pointer; cdecl;
  end;
  NSValue = interface(NSObject)
    ['{0539B6F1-D277-4BCA-95B2-A283B46CB248}']
    function CGPointValue: CGPoint; cdecl;
    function CGRectValue: CGRect; cdecl;
    function CGSizeValue: CGSize; cdecl;
    function CGAffineTransformValue: CGAffineTransform; cdecl;
    function UIEdgeInsetsValue: UIEdgeInsets; cdecl;
    function UIOffsetValue: UIOffset; cdecl;
  end;
  TNSValue = class(TOCGenericImport<NSValueClass, NSValue>)  end;

  UITextPositionclass = interface(NSObjectClass)
    ['{07080A25-F6EF-4E15-B90A-20A218C894F0}']
  end;
  UITextPosition = interface(NSObject)
    ['{6670C9FB-9723-4807-B8D3-0EE7C84CDE14}']
  end;
  TUITextPosition = class(TOCGenericImport<UITextPositionClass, UITextPosition>)  end;

  UITextInputModeClass = interface(NSObjectClass)
    ['{231F5CCE-09F7-44E8-8B17-EB987D428BA9}']
    {class} function activeInputModes: NSArray; cdecl;
    {class} function currentInputMode: Pointer; cdecl;
  end;
  UITextInputMode = interface(NSObject)
    ['{223FED6C-FFF2-46FE-B401-A87AD479EE49}']
    function primaryLanguage: NSString; cdecl;
  end;
  TUITextInputMode = class(TOCGenericImport<UITextInputModeClass, UITextInputMode>)  end;

  UIMenuItemClass = interface(NSObjectClass)
    ['{6456BA57-C3C4-45EF-BF6B-A970C8CCD7C0}']
  end;
  UIMenuItem = interface(NSObject)
    ['{8A757229-EB63-4B02-9B98-97D88C9E25E9}']
    function action: SEL; cdecl;
    function initWithTitle(title: NSString; action: SEL): Pointer; cdecl;
    procedure setAction(action: SEL); cdecl;
    procedure setTitle(title: NSString); cdecl;
    function title: NSString; cdecl;
  end;
  TUIMenuItem = class(TOCGenericImport<UIMenuItemClass, UIMenuItem>)  end;

  UIMenuControllerClass = interface(NSObjectClass)
    ['{52CB7F2E-CB26-4121-979D-5020E934B090}']
    {class} function sharedMenuController: Pointer; cdecl;
  end;
  UIMenuController = interface(NSObject)
    ['{AC1666FB-0C58-483E-94AD-99F949FABAA8}']
    function arrowDirection: UIMenuControllerArrowDirection; cdecl;
    function isMenuVisible: Boolean; cdecl;
    function menuFrame: CGRect; cdecl;
    function menuItems: NSArray; cdecl;
    procedure setArrowDirection(arrowDirection: UIMenuControllerArrowDirection); cdecl;
    procedure setMenuItems(menuItems: NSArray); cdecl;
    procedure setMenuVisible(menuVisible: Boolean); cdecl; overload;
    procedure setMenuVisible(menuVisible: Boolean; animated: Boolean); cdecl; overload;
    procedure setTargetRect(targetRect: CGRect; inView: UIView); cdecl;
    procedure update; cdecl;
  end;
  TUIMenuController = class(TOCGenericImport<UIMenuControllerClass, UIMenuController>)  end;

  UINibClass = interface(NSObjectClass)
    ['{4073F6E2-6B97-4FE1-9573-89C8869CD29D}']
    {class} function nibWithData(data: NSData; bundle: NSBundle): Pointer; cdecl;
    {class} function nibWithNibName(name: NSString; bundle: NSBundle): Pointer; cdecl;
  end;
  UINib = interface(NSObject)
    ['{985317B5-E3E7-4FCD-A93A-B30242802B57}']
    function instantiateWithOwner(ownerOrNil: Pointer; options: NSDictionary): NSArray; cdecl;
  end;
  TUINib = class(TOCGenericImport<UINibClass, UINib>)  end;

  UINavigationItemClass = interface(NSObjectClass)
    ['{D15EAEB1-8D7B-42A0-94BF-CAC9B71B1D4F}']
  end;
  UINavigationItem = interface(NSObject)
    ['{8F5F3832-12EC-4BD4-A271-E4CD6B2A8C7B}']
    function backBarButtonItem: UIBarButtonItem; cdecl;
    function hidesBackButton: Boolean; cdecl;
    function initWithTitle(title: NSString): Pointer; cdecl;
    function leftBarButtonItem: UIBarButtonItem; cdecl;
    function leftBarButtonItems: NSArray; cdecl;
    function leftItemsSupplementBackButton: Boolean; cdecl;
    function prompt: NSString; cdecl;
    function rightBarButtonItem: UIBarButtonItem; cdecl;
    function rightBarButtonItems: NSArray; cdecl;
    procedure setBackBarButtonItem(backBarButtonItem: UIBarButtonItem); cdecl;
    procedure setHidesBackButton(hidesBackButton: Boolean); cdecl; overload;
    procedure setHidesBackButton(hidesBackButton: Boolean; animated: Boolean); cdecl; overload;
    procedure setLeftBarButtonItem(leftBarButtonItem: UIBarButtonItem); cdecl; overload;
    procedure setLeftBarButtonItem(item: UIBarButtonItem; animated: Boolean); cdecl; overload;
    procedure setLeftBarButtonItems(leftBarButtonItems: NSArray); cdecl; overload;
    procedure setLeftBarButtonItems(items: NSArray; animated: Boolean); cdecl; overload;
    procedure setLeftItemsSupplementBackButton(leftItemsSupplementBackButton: Boolean); cdecl;
    procedure setPrompt(prompt: NSString); cdecl;
    procedure setRightBarButtonItem(rightBarButtonItem: UIBarButtonItem); cdecl; overload;
    procedure setRightBarButtonItem(item: UIBarButtonItem; animated: Boolean); cdecl; overload;
    procedure setRightBarButtonItems(rightBarButtonItems: NSArray); cdecl; overload;
    procedure setRightBarButtonItems(items: NSArray; animated: Boolean); cdecl; overload;
    procedure setTitle(title: NSString); cdecl;
    procedure setTitleView(titleView: UIView); cdecl;
    function title: NSString; cdecl;
    function titleView: UIView; cdecl;
  end;
  TUINavigationItem = class(TOCGenericImport<UINavigationItemClass, UINavigationItem>)  end;

  UITextCheckerClass = interface(NSObjectClass)
    ['{23C837B5-AFD9-4F1D-AD84-B5FA47F543D7}']
    {class} function availableLanguages: NSArray; cdecl;
    {class} function hasLearnedWord(word: NSString): Boolean; cdecl;
    {class} procedure learnWord(word: NSString); cdecl;
    {class} procedure unlearnWord(word: NSString); cdecl;
  end;
  UITextChecker = interface(NSObject)
    ['{044966BA-33AD-48D8-BB77-6B1416C0F262}']
    function completionsForPartialWordRange(range: NSRange; inString: NSString; language: NSString): NSArray; cdecl;
    function guessesForWordRange(range: NSRange; inString: NSString; language: NSString): NSArray; cdecl;
    procedure ignoreWord(wordToIgnore: NSString); cdecl;
    function ignoredWords: NSArray; cdecl;
    function rangeOfMisspelledWordInString(stringToCheck: NSString; range: NSRange; startingAt: NSInteger; wrap: Boolean; language: NSString): NSRange; cdecl;
    procedure setIgnoredWords(words: NSArray); cdecl;
  end;
  TUITextChecker = class(TOCGenericImport<UITextCheckerClass, UITextChecker>)  end;

  UILocalizedIndexedCollationClass = interface(NSObjectClass)
    ['{CB8A0C1F-B8D9-4C16-A24C-6B12A2CA66C2}']
    {class} function currentCollation: Pointer; cdecl;
  end;
  UILocalizedIndexedCollation = interface(NSObject)
    ['{DAFD770B-86B8-4B35-8E08-C1BA4CB16584}']
    function sectionForObject(object_: Pointer; collationStringSelector: SEL): NSInteger; cdecl;
    function sectionForSectionIndexTitleAtIndex(indexTitleIndex: NSInteger): NSInteger; cdecl;
    function sectionIndexTitles: NSArray; cdecl;
    function sectionTitles: NSArray; cdecl;
    function sortedArrayFromArray(array_: NSArray; collationStringSelector: SEL): NSArray; cdecl;
  end;
  TUILocalizedIndexedCollation = class(TOCGenericImport<UILocalizedIndexedCollationClass, UILocalizedIndexedCollation>)  end;

  UIImageClass = interface(NSObjectClass)
    ['{87E75615-9F27-4276-B747-7D5C8F3BAB5A}']
    {class} function animatedImageNamed(name: NSString; duration: NSTimeInterval): Pointer; cdecl;
    {class} function animatedImageWithImages(images: NSArray; duration: NSTimeInterval): Pointer; cdecl;
    {class} function animatedResizableImageNamed(name: NSString; capInsets: UIEdgeInsets; duration: NSTimeInterval): Pointer; cdecl;
    {class} function imageNamed(name: NSString): Pointer; cdecl;
    {class} function imageWithCGImage(cgImage: CGImageRef): Pointer; cdecl; overload;
    {class} function imageWithCGImage(cgImage: CGImageRef; scale: Single; orientation: UIImageOrientation): Pointer; cdecl; overload;
    {class} function imageWithCIImage(ciImage: CIImage): Pointer; cdecl;
    {class} function imageWithContentsOfFile(path: NSString): Pointer; cdecl;
    {class} function imageWithData(data: NSData): Pointer; cdecl;
  end;
  UIImage = interface(NSObject)
    ['{65BCAAA8-4DB4-4884-B05E-B09DC6D271A9}']
    function CGImage: CGImageRef; cdecl;
    function CIImage: CIImage; cdecl;
    function capInsets: UIEdgeInsets; cdecl;
    procedure drawAsPatternInRect(rect: CGRect); cdecl;
    procedure drawAtPoint(point: CGPoint); cdecl; overload;
    procedure drawAtPoint(point: CGPoint; blendMode: CGBlendMode; alpha: Single); cdecl; overload;
    procedure drawInRect(rect: CGRect); cdecl; overload;
    procedure drawInRect(rect: CGRect; blendMode: CGBlendMode; alpha: Single); cdecl; overload;
    function duration: NSTimeInterval; cdecl;
    function imageOrientation: UIImageOrientation; cdecl;
    function images: NSArray; cdecl;
    function initWithCGImage(cgImage: CGImageRef): Pointer; cdecl; overload;
    function initWithCGImage(cgImage: CGImageRef; scale: Single; orientation: UIImageOrientation): Pointer; cdecl; overload;
    function initWithCIImage(ciImage: CIImage): Pointer; cdecl;
    function initWithContentsOfFile(path: NSString): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function leftCapWidth: NSInteger; cdecl;
    function resizableImageWithCapInsets(capInsets: UIEdgeInsets): UIImage; cdecl;
    function scale: Single; cdecl;
    function size: CGSize; cdecl;
    function stretchableImageWithLeftCapWidth(leftCapWidth: NSInteger; topCapHeight: NSInteger): UIImage; cdecl;
    function topCapHeight: NSInteger; cdecl;
  end;
  TUIImage = class(TOCGenericImport<UIImageClass, UIImage>)  end;

  UIGestureRecognizerClass = interface(NSObjectClass)
    ['{EA6310B2-4446-44A2-9C1D-C37902A6FEC2}']
  end;
  UIGestureRecognizer = interface(NSObject)
    ['{3384D59C-6A05-4AEC-AAE2-8B5CABBAD157}']
    procedure addTarget(target: Pointer; action: SEL); cdecl;
    function canBePreventedByGestureRecognizer(preventingGestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
    function canPreventGestureRecognizer(preventedGestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
    function cancelsTouchesInView: Boolean; cdecl;
    function delaysTouchesBegan: Boolean; cdecl;
    function delaysTouchesEnded: Boolean; cdecl;
    function delegate: Pointer; cdecl;
    procedure ignoreTouch(touch: UITouch; forEvent: UIEvent); cdecl;
    function initWithTarget(target: Pointer; action: SEL): Pointer; cdecl;
    function isEnabled: Boolean; cdecl;
    function locationInView(view: UIView): CGPoint; cdecl;
    function locationOfTouch(touchIndex: NSUInteger; inView: UIView): CGPoint; cdecl;
    function numberOfTouches: NSUInteger; cdecl;
    procedure removeTarget(target: Pointer; action: SEL); cdecl;
    procedure requireGestureRecognizerToFail(otherGestureRecognizer: UIGestureRecognizer); cdecl;
    procedure reset; cdecl;
    procedure setCancelsTouchesInView(cancelsTouchesInView: Boolean); cdecl;
    procedure setDelaysTouchesBegan(delaysTouchesBegan: Boolean); cdecl;
    procedure setDelaysTouchesEnded(delaysTouchesEnded: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setState(state: UIGestureRecognizerState); cdecl;
    function state: UIGestureRecognizerState; cdecl;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function view: UIView; cdecl;
  end;
  TUIGestureRecognizer = class(TOCGenericImport<UIGestureRecognizerClass, UIGestureRecognizer>)  end;

  UIFontClass = interface(NSObjectClass)
    ['{EB22D6EF-BAAB-4448-8657-1FACB5BAD2B8}']
    {class} function boldSystemFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function buttonFontSize: Single; cdecl;
    {class} function familyNames: NSArray; cdecl;
    {class} function fontNamesForFamilyName(familyName: NSString): NSArray; cdecl;
    {class} function fontWithName(fontName: NSString; size: Single): Pointer; cdecl;
    {class} function italicSystemFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function labelFontSize: Single; cdecl;
    {class} function smallSystemFontSize: Single; cdecl;
    {class} function systemFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function systemFontSize: Single; cdecl;
  end;
  UIFont = interface(NSObject)
    ['{B064BB36-A2A7-41B3-8BC8-A34E9401EDD6}']
    function ascender: Single; cdecl;
    function capHeight: Single; cdecl;
    function descender: Single; cdecl;
    function familyName: NSString; cdecl;
    function fontName: NSString; cdecl;
    function fontWithSize(fontSize: Single): UIFont; cdecl;
    function leading: Single; cdecl;
    function lineHeight: Single; cdecl;
    function pointSize: Single; cdecl;
    function xHeight: Single; cdecl;
  end;
  TUIFont = class(TOCGenericImport<UIFontClass, UIFont>)  end;

  UILocalNotificationClass = interface(NSObjectClass)
    ['{BD63AA5F-BF1C-442A-B72A-526358F5E448}']
  end;
  UILocalNotification = interface(NSObject)
    ['{5289169B-7A4F-46BE-8716-C10A780CBD0E}']
    function alertAction: NSString; cdecl;
    function alertBody: NSString; cdecl;
    function alertLaunchImage: NSString; cdecl;
    function applicationIconBadgeNumber: NSInteger; cdecl;
    function fireDate: NSDate; cdecl;
    function hasAction: Boolean; cdecl;
    function repeatCalendar: NSCalendar; cdecl;
    function repeatInterval: NSCalendarUnit; cdecl;
    procedure setAlertAction(alertAction: NSString); cdecl;
    procedure setAlertBody(alertBody: NSString); cdecl;
    procedure setAlertLaunchImage(alertLaunchImage: NSString); cdecl;
    procedure setApplicationIconBadgeNumber(applicationIconBadgeNumber: NSInteger); cdecl;
    procedure setFireDate(fireDate: NSDate); cdecl;
    procedure setHasAction(hasAction: Boolean); cdecl;
    procedure setRepeatCalendar(repeatCalendar: NSCalendar); cdecl;
    procedure setRepeatInterval(repeatInterval: NSCalendarUnit); cdecl;
    procedure setSoundName(soundName: NSString); cdecl;
    procedure setTimeZone(timeZone: NSTimeZone); cdecl;
    procedure setUserInfo(userInfo: NSDictionary); cdecl;
    function soundName: NSString; cdecl;
    function timeZone: NSTimeZone; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TUILocalNotification = class(TOCGenericImport<UILocalNotificationClass, UILocalNotification>)  end;

  UITextInputStringTokenizerClass = interface(NSObjectClass)
    ['{8B90E087-EC9A-484C-9015-BE777FF3F861}']
  end;
  UITextInputStringTokenizer = interface(NSObject)
    ['{A5A33069-7715-4E1B-AD69-F71C9294CDD3}']
    function initWithTextInput(textInput: UIResponder): Pointer; cdecl;
  end;
  TUITextInputStringTokenizer = class(TOCGenericImport<UITextInputStringTokenizerClass, UITextInputStringTokenizer>)  end;

  UITextRangeClass = interface(NSObjectClass)
    ['{DABB3555-5B7F-4A3B-BF97-F43DAD3D5B42}']
  end;
  UITextRange = interface(NSObject)
    ['{DD81F81D-99CB-4537-8245-13E633C1B8C0}']
    function isEmpty: Boolean; cdecl;
    function start: UITextPosition; cdecl;
    function &end: UITextPosition; cdecl;
  end;
  TUITextRange = class(TOCGenericImport<UITextRangeClass, UITextRange>)  end;

  UIScreenModeClass = interface(NSObjectClass)
    ['{0CF607E1-7E08-4D61-AC23-656163E5D9B0}']
  end;
  UIScreenMode = interface(NSObject)
    ['{C9AB92D8-C120-40CB-B3B4-F2FA1DC9C9B0}']
    function pixelAspectRatio: Single; cdecl;
    function size: CGSize; cdecl;
  end;
  TUIScreenMode = class(TOCGenericImport<UIScreenModeClass, UIScreenMode>)  end;

  UIScreenClass = interface(NSObjectClass)
    ['{E3A65960-2A9F-4A4A-BACE-E00E491F6AB0}']
    {class} function mainScreen: Pointer; cdecl;
    {class} function screens: NSArray; cdecl;
  end;
  UIScreen = interface(NSObject)
    ['{9D84B3DC-E2BC-49A3-B311-C0E55FD780B9}']
    function applicationFrame: CGRect; cdecl;
    function availableModes: NSArray; cdecl;
    function bounds: CGRect; cdecl;
    function brightness: Single; cdecl;
    function currentMode: UIScreenMode; cdecl;
    function displayLinkWithTarget(target: Pointer; selector: SEL): CADisplayLink; cdecl;
    function mirroredScreen: UIScreen; cdecl;
    function overscanCompensation: UIScreenOverscanCompensation; cdecl;
    function preferredMode: UIScreenMode; cdecl;
    function scale: Single; cdecl;
    procedure setBrightness(brightness: Single); cdecl;
    procedure setCurrentMode(currentMode: UIScreenMode); cdecl;
    procedure setOverscanCompensation(overscanCompensation: UIScreenOverscanCompensation); cdecl;
    procedure setWantsSoftwareDimming(wantsSoftwareDimming: Boolean); cdecl;
    function wantsSoftwareDimming: Boolean; cdecl;
  end;
  TUIScreen = class(TOCGenericImport<UIScreenClass, UIScreen>)  end;

  UIResponderClass = interface(NSObjectClass)
    ['{71125106-1FF5-44BD-BC31-72D31D04CF53}']
  end;
  UIResponder = interface(NSObject)
    ['{3294BC42-563A-4D5A-BE0D-391D08B4346D}']
    function becomeFirstResponder: Boolean; cdecl;
    function canBecomeFirstResponder: Boolean; cdecl;
    function canPerformAction(action: SEL; withSender: Pointer): Boolean; cdecl;
    function canResignFirstResponder: Boolean; cdecl;
    function inputAccessoryView: UIView; cdecl;
    function inputView: UIView; cdecl;
    function isFirstResponder: Boolean; cdecl;
    procedure motionBegan(motion: UIEventSubtype; withEvent: UIEvent); cdecl;
    procedure motionCancelled(motion: UIEventSubtype; withEvent: UIEvent); cdecl;
    procedure motionEnded(motion: UIEventSubtype; withEvent: UIEvent); cdecl;
    function nextResponder: UIResponder; cdecl;
    procedure reloadInputViews; cdecl;
    procedure remoteControlReceivedWithEvent(event: UIEvent); cdecl;
    function resignFirstResponder: Boolean; cdecl;
    procedure touchesBegan(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesCancelled(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesEnded(touches: NSSet; withEvent: UIEvent); cdecl;
    procedure touchesMoved(touches: NSSet; withEvent: UIEvent); cdecl;
    function undoManager: NSUndoManager; cdecl;
  end;
  TUIResponder = class(TOCGenericImport<UIResponderClass, UIResponder>)  end;

  UIStoryboardClass = interface(NSObjectClass)
    ['{D99EC40A-1C3D-48E3-9C1E-5421C2AB4D2C}']
    {class} function storyboardWithName(name: NSString; bundle: NSBundle): Pointer; cdecl;
  end;
  UIStoryboard = interface(NSObject)
    ['{500AA1D9-5EDF-4AA4-90B8-66FB67F49B9D}']
    function instantiateInitialViewController: Pointer; cdecl;
    function instantiateViewControllerWithIdentifier(identifier: NSString): Pointer; cdecl;
  end;
  TUIStoryboard = class(TOCGenericImport<UIStoryboardClass, UIStoryboard>)  end;

  UISearchDisplayControllerClass = interface(NSObjectClass)
    ['{E80D1477-C651-41AD-B825-97125D6D3D43}']
  end;
  UISearchDisplayController = interface(NSObject)
    ['{C2D8D1A0-0EF0-4417-A5FC-1962B858410F}']
    function delegate: Pointer; cdecl;
    function initWithSearchBar(searchBar: UISearchBar; contentsController: UIViewController): Pointer; cdecl;
    function isActive: Boolean; cdecl;
    function searchBar: UISearchBar; cdecl;
    function searchContentsController: UIViewController; cdecl;
    function searchResultsDataSource: Pointer; cdecl;
    function searchResultsDelegate: Pointer; cdecl;
    function searchResultsTableView: UITableView; cdecl;
    function searchResultsTitle: NSString; cdecl;
    procedure setActive(active: Boolean); cdecl; overload;
    procedure setActive(visible: Boolean; animated: Boolean); cdecl; overload;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setSearchResultsDataSource(searchResultsDataSource: Pointer); cdecl;
    procedure setSearchResultsDelegate(searchResultsDelegate: Pointer); cdecl;
    procedure setSearchResultsTitle(searchResultsTitle: NSString); cdecl;
  end;
  TUISearchDisplayController = class(TOCGenericImport<UISearchDisplayControllerClass, UISearchDisplayController>)  end;

  UIStoryboardSegueClass = interface(NSObjectClass)
    ['{E0D7DDAF-F418-4884-8A9E-09A43DE685CD}']
  end;
  UIStoryboardSegue = interface(NSObject)
    ['{38CD90EC-09B6-4A61-8FD5-59B08A111320}']
    function destinationViewController: Pointer; cdecl;
    function identifier: NSString; cdecl;
    function initWithIdentifier(identifier: NSString; source: UIViewController; destination: UIViewController): Pointer; cdecl;
    procedure perform; cdecl;
    function sourceViewController: Pointer; cdecl;
  end;
  TUIStoryboardSegue = class(TOCGenericImport<UIStoryboardSegueClass, UIStoryboardSegue>)  end;

  UIPrintPaperClass = interface(NSObjectClass)
    ['{957ECB39-51E4-4BD4-9BC1-79312E8D168A}']
    {class} function bestPaperForPageSize(contentSize: CGSize; withPapersFromArray: NSArray): Pointer; cdecl;
  end;
  UIPrintPaper = interface(NSObject)
    ['{9B023BF3-6850-4469-A902-CFDEAEA60EAB}']
    function paperSize: CGSize; cdecl;
    function printRect: CGRect; cdecl;
    function printableRect: CGRect; cdecl;
  end;
  TUIPrintPaper = class(TOCGenericImport<UIPrintPaperClass, UIPrintPaper>)  end;

  UIPrintFormatterClass = interface(NSObjectClass)
    ['{6D99085E-03D8-44DC-BDDD-2678A709CFD5}']
  end;
  UIPrintFormatter = interface(NSObject)
    ['{6F423EB0-4080-4B9F-AEFE-47E3CD5C6037}']
    function contentInsets: UIEdgeInsets; cdecl;
    procedure drawInRect(rect: CGRect; forPageAtIndex: NSInteger); cdecl;
    function maximumContentHeight: Single; cdecl;
    function maximumContentWidth: Single; cdecl;
    function pageCount: NSInteger; cdecl;
    function printPageRenderer: UIPrintPageRenderer; cdecl;
    function rectForPageAtIndex(pageIndex: NSInteger): CGRect; cdecl;
    procedure removeFromPrintPageRenderer; cdecl;
    procedure setContentInsets(contentInsets: UIEdgeInsets); cdecl;
    procedure setMaximumContentHeight(maximumContentHeight: Single); cdecl;
    procedure setMaximumContentWidth(maximumContentWidth: Single); cdecl;
    procedure setStartPage(startPage: NSInteger); cdecl;
    function startPage: NSInteger; cdecl;
  end;
  TUIPrintFormatter = class(TOCGenericImport<UIPrintFormatterClass, UIPrintFormatter>)  end;

  UIPopoverControllerClass = interface(NSObjectClass)
    ['{3ACDC1A9-123A-4BD7-A9D1-16E559B0F0AF}']
  end;
  UIPopoverController = interface(NSObject)
    ['{576C3F52-A469-434C-9BB0-01429C74E258}']
    function contentViewController: UIViewController; cdecl;
    function delegate: Pointer; cdecl;
    procedure dismissPopoverAnimated(animated: Boolean); cdecl;
    function initWithContentViewController(viewController: UIViewController): Pointer; cdecl;
    function isPopoverVisible: Boolean; cdecl;
    function passthroughViews: NSArray; cdecl;
    function popoverArrowDirection: UIPopoverArrowDirection; cdecl;
    function popoverContentSize: CGSize; cdecl;
    function popoverLayoutMargins: UIEdgeInsets; cdecl;
    procedure presentPopoverFromBarButtonItem(item: UIBarButtonItem; permittedArrowDirections: UIPopoverArrowDirection; animated: Boolean); cdecl;
    procedure presentPopoverFromRect(rect: CGRect; inView: UIView; permittedArrowDirections: UIPopoverArrowDirection; animated: Boolean); cdecl;
    procedure setContentViewController(contentViewController: UIViewController); cdecl; overload;
    procedure setContentViewController(viewController: UIViewController; animated: Boolean); cdecl; overload;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setPassthroughViews(passthroughViews: NSArray); cdecl;
    procedure setPopoverBackgroundViewClass(popoverBackgroundViewClass: Pointer); cdecl;
    procedure setPopoverContentSize(popoverContentSize: CGSize); cdecl; overload;
    procedure setPopoverContentSize(size: CGSize; animated: Boolean); cdecl; overload;
    procedure setPopoverLayoutMargins(popoverLayoutMargins: UIEdgeInsets); cdecl;
  end;
  TUIPopoverController = class(TOCGenericImport<UIPopoverControllerClass, UIPopoverController>)  end;

  UIPasteboardClass = interface(NSObjectClass)
    ['{C8C6F374-BE00-4141-9E05-5E9ABA81D828}']
    {class} function generalPasteboard: Pointer; cdecl;
    {class} function pasteboardWithName(pasteboardName: NSString; create: Boolean): Pointer; cdecl;
    {class} function pasteboardWithUniqueName: Pointer; cdecl;
    {class} procedure removePasteboardWithName(pasteboardName: NSString); cdecl;
  end;
  UIPasteboard = interface(NSObject)
    ['{9B817EE3-BC7F-48BA-92E2-DA35D69F09CD}']
    function URL: NSURL; cdecl;
    function URLs: NSArray; cdecl;
    procedure addItems(items: NSArray); cdecl;
    function changeCount: NSInteger; cdecl;
    function color: UIColor; cdecl;
    function colors: NSArray; cdecl;
    function containsPasteboardTypes(pasteboardTypes: NSArray): Boolean; cdecl; overload;
    function containsPasteboardTypes(pasteboardTypes: NSArray; inItemSet: NSIndexSet): Boolean; cdecl; overload;
    function dataForPasteboardType(pasteboardType: NSString): NSData; cdecl; overload;
    function dataForPasteboardType(pasteboardType: NSString; inItemSet: NSIndexSet): NSArray; cdecl; overload;
    function image: UIImage; cdecl;
    function images: NSArray; cdecl;
    function isPersistent: Boolean; cdecl;
    function itemSetWithPasteboardTypes(pasteboardTypes: NSArray): NSIndexSet; cdecl;
    function items: NSArray; cdecl;
    function name: NSString; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function pasteboardTypes: NSArray; cdecl;
    function pasteboardTypesForItemSet(itemSet: NSIndexSet): NSArray; cdecl;
    procedure setColor(color: UIColor); cdecl;
    procedure setColors(colors: NSArray); cdecl;
    procedure setData(data: NSData; forPasteboardType: NSString); cdecl;
    procedure setImage(image: UIImage); cdecl;
    procedure setImages(images: NSArray); cdecl;
    procedure setItems(items: NSArray); cdecl;
    procedure setPersistent(persistent: Boolean); cdecl;
    procedure setString(string_: NSString); cdecl;
    procedure setStrings(strings: NSArray); cdecl;
    procedure setURL(URL: NSURL); cdecl;
    procedure setURLs(URLs: NSArray); cdecl;
    procedure setValue(value: Pointer; forPasteboardType: NSString); cdecl;
    function strings: Pointer; cdecl; 
    function valueForPasteboardType(pasteboardType: NSString): Pointer; cdecl;
    function valuesForPasteboardType(pasteboardType: NSString; inItemSet: NSIndexSet): NSArray; cdecl;
  end;
  TUIPasteboard = class(TOCGenericImport<UIPasteboardClass, UIPasteboard>)  end;

  UIPrintPageRendererClass = interface(NSObjectClass)
    ['{96A50B8F-2F32-4D42-AAF1-29DE9C2F98CD}']
  end;
  UIPrintPageRenderer = interface(NSObject)
    ['{4E75D23D-3D4E-44B3-BF58-CCB68F0AD584}']
    procedure addPrintFormatter(formatter: UIPrintFormatter; startingAtPageAtIndex: NSInteger); cdecl;
    procedure drawContentForPageAtIndex(pageIndex: NSInteger; inRect: CGRect); cdecl;
    procedure drawFooterForPageAtIndex(pageIndex: NSInteger; inRect: CGRect); cdecl;
    procedure drawHeaderForPageAtIndex(pageIndex: NSInteger; inRect: CGRect); cdecl;
    procedure drawPageAtIndex(pageIndex: NSInteger; inRect: CGRect); cdecl;
    procedure drawPrintFormatter(printFormatter: UIPrintFormatter; forPageAtIndex: NSInteger); cdecl;
    function footerHeight: Single; cdecl;
    function headerHeight: Single; cdecl;
    function numberOfPages: NSInteger; cdecl;
    function paperRect: CGRect; cdecl;
    procedure prepareForDrawingPages(range: NSRange); cdecl;
    function printFormatters: NSArray; cdecl;
    function printFormattersForPageAtIndex(pageIndex: NSInteger): NSArray; cdecl;
    function printableRect: CGRect; cdecl;
    procedure setFooterHeight(footerHeight: Single); cdecl;
    procedure setHeaderHeight(headerHeight: Single); cdecl;
    procedure setPrintFormatters(printFormatters: NSArray); cdecl;
  end;
  TUIPrintPageRenderer = class(TOCGenericImport<UIPrintPageRendererClass, UIPrintPageRenderer>)  end;

  UIPrintInteractionControllerClass = interface(NSObjectClass)
    ['{D3566B82-3014-40C6-B7E3-DFC22AF39319}']
    {class} function canPrintData(data: NSData): Boolean; cdecl;
    {class} function canPrintURL(url: NSURL): Boolean; cdecl;
    {class} function isPrintingAvailable: Boolean; cdecl;
    {class} function printableUTIs: NSSet; cdecl;
    {class} function sharedPrintController: Pointer; cdecl;
  end;
  UIPrintInteractionController = interface(NSObject)
    ['{0FEF6AA7-132B-41C8-BB12-045C43027D4B}']
    function delegate: Pointer; cdecl;
    procedure dismissAnimated(animated: Boolean); cdecl;
    function printFormatter: UIPrintFormatter; cdecl;
    function printInfo: UIPrintInfo; cdecl;
    function printPageRenderer: UIPrintPageRenderer; cdecl;
    function printPaper: UIPrintPaper; cdecl;
    function printingItem: Pointer; cdecl;
    function printingItems: NSArray; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setPrintFormatter(printFormatter: UIPrintFormatter); cdecl;
    procedure setPrintInfo(printInfo: UIPrintInfo); cdecl;
    procedure setPrintPageRenderer(printPageRenderer: UIPrintPageRenderer); cdecl;
    procedure setPrintingItem(printingItem: Pointer); cdecl;
    procedure setPrintingItems(printingItems: NSArray); cdecl;
    procedure setShowsPageRange(showsPageRange: Boolean); cdecl;
    function showsPageRange: Boolean; cdecl;
  end;
  TUIPrintInteractionController = class(TOCGenericImport<UIPrintInteractionControllerClass, UIPrintInteractionController>)  end;

  UIPrintInfoClass = interface(NSObjectClass)
    ['{876A42C5-4D35-4DB0-BAC8-588C41A607A2}']
    {class} function printInfo: Pointer; cdecl;
    {class} function printInfoWithDictionary(dictionary: NSDictionary): Pointer; cdecl;
  end;
  UIPrintInfo = interface(NSObject)
    ['{8628D24C-6D8D-4AA1-AF59-EE0C648DC9EF}']
    function dictionaryRepresentation: NSDictionary; cdecl;
    function duplex: UIPrintInfoDuplex; cdecl;
    function jobName: NSString; cdecl;
    function orientation: UIPrintInfoOrientation; cdecl;
    function outputType: UIPrintInfoOutputType; cdecl;
    function printerID: NSString; cdecl;
    procedure setDuplex(duplex: UIPrintInfoDuplex); cdecl;
    procedure setJobName(jobName: NSString); cdecl;
    procedure setOrientation(orientation: UIPrintInfoOrientation); cdecl;
    procedure setOutputType(outputType: UIPrintInfoOutputType); cdecl;
    procedure setPrinterID(printerID: NSString); cdecl;
  end;
  TUIPrintInfo = class(TOCGenericImport<UIPrintInfoClass, UIPrintInfo>)  end;

  UIBarItemClass = interface(NSObjectClass)
    ['{B56F6316-68B0-4B43-9A83-9D440AB07D83}']
  end;
  UIBarItem = interface(NSObject)
    ['{D2F7FB4F-12F3-41E4-8051-4252C65443D7}']
    function image: UIImage; cdecl;
    function imageInsets: UIEdgeInsets; cdecl;
    function isEnabled: Boolean; cdecl;
    function landscapeImagePhone: UIImage; cdecl;
    function landscapeImagePhoneInsets: UIEdgeInsets; cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setImage(image: UIImage); cdecl;
    procedure setImageInsets(imageInsets: UIEdgeInsets); cdecl;
    procedure setLandscapeImagePhone(landscapeImagePhone: UIImage); cdecl;
    procedure setLandscapeImagePhoneInsets(landscapeImagePhoneInsets: UIEdgeInsets); cdecl;
    procedure setTag(tag: NSInteger); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure setTitleTextAttributes(attributes: NSDictionary; forState: UIControlState); cdecl;
    function tag: NSInteger; cdecl;
    function title: NSString; cdecl;
    function titleTextAttributesForState(state: UIControlState): NSDictionary; cdecl;
  end;
  TUIBarItem = class(TOCGenericImport<UIBarItemClass, UIBarItem>)  end;

  UIBezierPathClass = interface(NSObjectClass)
    ['{471808BD-D532-44FE-9FAE-2F271EDBF91C}']
    {class} function bezierPath: Pointer; cdecl;
    {class} function bezierPathWithArcCenter(center: CGPoint; radius: Single; startAngle: Single; endAngle: Single; clockwise: Boolean): Pointer; cdecl;
    {class} function bezierPathWithCGPath(CGPath: CGPathRef): Pointer; cdecl;
    {class} function bezierPathWithOvalInRect(rect: CGRect): Pointer; cdecl;
    {class} function bezierPathWithRect(rect: CGRect): Pointer; cdecl;
    {class} function bezierPathWithRoundedRect(rect: CGRect; byRoundingCorners: UIRectCorner; cornerRadii: CGSize): Pointer; cdecl; overload;
    {class} function bezierPathWithRoundedRect(rect: CGRect; cornerRadius: Single): Pointer; cdecl; overload;
  end;
  UIBezierPath = interface(NSObject)
    ['{1C09BF52-8B2B-4EAE-8F63-3C88754FB694}']
    function CGPath: CGPathRef; cdecl;
    procedure addArcWithCenter(center: CGPoint; radius: Single; startAngle: Single; endAngle: Single; clockwise: Boolean); cdecl;
    procedure addClip; cdecl;
    procedure addCurveToPoint(endPoint: CGPoint; controlPoint1: CGPoint; controlPoint2: CGPoint); cdecl;
    procedure addLineToPoint(point: CGPoint); cdecl;
    procedure addQuadCurveToPoint(endPoint: CGPoint; controlPoint: CGPoint); cdecl;
    procedure appendPath(bezierPath: UIBezierPath); cdecl;
    procedure applyTransform(transform: CGAffineTransform); cdecl;
    function bounds: CGRect; cdecl;
    procedure closePath; cdecl;
    function containsPoint(point: CGPoint): Boolean; cdecl;
    function currentPoint: CGPoint; cdecl;
    procedure fill; cdecl;
    procedure fillWithBlendMode(blendMode: CGBlendMode; alpha: Single); cdecl;
    function flatness: Single; cdecl;
    procedure getLineDash(pattern: PSingle; count: NSInteger; phase: PSingle); cdecl;
    function isEmpty: Boolean; cdecl;
    function lineCapStyle: CGLineCap; cdecl;
    function lineJoinStyle: CGLineJoin; cdecl;
    function lineWidth: Single; cdecl;
    function miterLimit: Single; cdecl;
    procedure moveToPoint(point: CGPoint); cdecl;
    procedure removeAllPoints; cdecl;
    procedure setCGPath(CGPath: CGPathRef); cdecl;
    procedure setFlatness(flatness: Single); cdecl;
    procedure setLineCapStyle(lineCapStyle: CGLineCap); cdecl;
    procedure setLineDash(pattern: PSingle; count: NSInteger; phase: Single); cdecl;
    procedure setLineJoinStyle(lineJoinStyle: CGLineJoin); cdecl;
    procedure setLineWidth(lineWidth: Single); cdecl;
    procedure setMiterLimit(miterLimit: Single); cdecl;
    procedure setUsesEvenOddFillRule(usesEvenOddFillRule: Boolean); cdecl;
    procedure stroke; cdecl;
    procedure strokeWithBlendMode(blendMode: CGBlendMode; alpha: Single); cdecl;
    function usesEvenOddFillRule: Boolean; cdecl;
  end;
  TUIBezierPath = class(TOCGenericImport<UIBezierPathClass, UIBezierPath>)  end;

  UIAccessibilityElementClass = interface(NSObjectClass)
    ['{AC93733E-E033-4450-BC5D-8FDF69EFECA8}']
  end;
  UIAccessibilityElement = interface(NSObject)
    ['{EE478997-636B-41A8-85EB-C3076B37D01B}']
    function accessibilityContainer: Pointer; cdecl;
    function accessibilityFrame: CGRect; cdecl;
    function accessibilityHint: NSString; cdecl;
    function accessibilityLabel: NSString; cdecl;
    function accessibilityTraits: UIAccessibilityTraits; cdecl;
    function accessibilityValue: NSString; cdecl;
    function initWithAccessibilityContainer(container: Pointer): Pointer; cdecl;
    function isAccessibilityElement: Boolean; cdecl;
    procedure setAccessibilityContainer(accessibilityContainer: Pointer); cdecl;
    procedure setAccessibilityFrame(accessibilityFrame: CGRect); cdecl;
    procedure setAccessibilityHint(accessibilityHint: NSString); cdecl;
    procedure setAccessibilityLabel(accessibilityLabel: NSString); cdecl;
    procedure setAccessibilityTraits(accessibilityTraits: UIAccessibilityTraits); cdecl;
    procedure setAccessibilityValue(accessibilityValue: NSString); cdecl;
    procedure setIsAccessibilityElement(isAccessibilityElement: Boolean); cdecl;
  end;
  TUIAccessibilityElement = class(TOCGenericImport<UIAccessibilityElementClass, UIAccessibilityElement>)  end;

  UIAccelerationClass = interface(NSObjectClass)
    ['{88FA2AAF-47F1-44E6-AE56-E2D172B76C7F}']
  end;
  UIAcceleration = interface(NSObject)
    ['{707BFB31-03FF-4258-912B-D963C644225C}']
    function timestamp: NSTimeInterval; cdecl;
    function x: UIAccelerationValue; cdecl;
    function y: UIAccelerationValue; cdecl;
    function z: UIAccelerationValue; cdecl;
  end;
  TUIAcceleration = class(TOCGenericImport<UIAccelerationClass, UIAcceleration>)  end;

  UIAccelerometerClass = interface(NSObjectClass)
    ['{D63171CF-FA0D-452B-801B-90B217F442B2}']
    {class} function sharedAccelerometer: Pointer; cdecl;
  end;
  UIAccelerometer = interface(NSObject)
    ['{87EEFC83-5AE2-451E-AC08-3E2E675A8073}']
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setUpdateInterval(updateInterval: NSTimeInterval); cdecl;
    function updateInterval: NSTimeInterval; cdecl;
  end;
  TUIAccelerometer = class(TOCGenericImport<UIAccelerometerClass, UIAccelerometer>)  end;

  UIDeviceClass = interface(NSObjectClass)
    ['{874EBFF8-FF0E-4298-8E11-EAC567414FAB}']
    {class} function currentDevice: Pointer; cdecl;
  end;
  UIDevice = interface(NSObject)
    ['{94056B60-4607-4AB2-B515-545041F12526}']
    function batteryLevel: Single; cdecl;
    function batteryState: UIDeviceBatteryState; cdecl;
    procedure beginGeneratingDeviceOrientationNotifications; cdecl;
    procedure endGeneratingDeviceOrientationNotifications; cdecl;
    function isBatteryMonitoringEnabled: Boolean; cdecl;
    function isGeneratingDeviceOrientationNotifications: Boolean; cdecl;
    function isMultitaskingSupported: Boolean; cdecl;
    function isProximityMonitoringEnabled: Boolean; cdecl;
    function localizedModel: NSString; cdecl;
    function model: NSString; cdecl;
    function name: NSString; cdecl;
    function orientation: UIDeviceOrientation; cdecl;
    procedure playInputClick; cdecl;
    function proximityState: Boolean; cdecl;
    procedure setBatteryMonitoringEnabled(batteryMonitoringEnabled: Boolean); cdecl;
    procedure setProximityMonitoringEnabled(proximityMonitoringEnabled: Boolean); cdecl;
    function systemName: NSString; cdecl;
    function systemVersion: NSString; cdecl;
    function uniqueIdentifier: NSString; cdecl;
    function userInterfaceIdiom: UIUserInterfaceIdiom; cdecl;
  end;
  TUIDevice = class(TOCGenericImport<UIDeviceClass, UIDevice>)  end;

  UIDocumentClass = interface(NSObjectClass)
    ['{59DB4449-CE47-4FBE-8DBC-D979ADEA4832}']
  end;
  UIDocument = interface(NSObject)
    ['{FF4EE4EC-E153-426F-A000-30DD3297CC55}']
    function changeCountTokenForSaveOperation(saveOperation: UIDocumentSaveOperation): Pointer; cdecl;
    function contentsForType(typeName: NSString; error: NSError): Pointer; cdecl;
    procedure disableEditing; cdecl;
    function documentState: UIDocumentState; cdecl;
    procedure enableEditing; cdecl;
    function fileAttributesToWriteToURL(url: NSURL; forSaveOperation: UIDocumentSaveOperation; error: NSError): NSDictionary; cdecl;
    function fileModificationDate: NSDate; cdecl;
    function fileNameExtensionForType(typeName: NSString; saveOperation: UIDocumentSaveOperation): NSString; cdecl;
    function fileType: NSString; cdecl;
    function fileURL: NSURL; cdecl;
    procedure finishedHandlingError(error: NSError; recovered: Boolean); cdecl;
    procedure handleError(error: NSError; userInteractionPermitted: Boolean); cdecl;
    function hasUnsavedChanges: Boolean; cdecl;
    function initWithFileURL(url: NSURL): Pointer; cdecl;
    function loadFromContents(contents: Pointer; ofType: NSString; error: NSError): Boolean; cdecl;
    function localizedName: NSString; cdecl;
    function readFromURL(url: NSURL; error: NSError): Boolean; cdecl;
    function savingFileType: NSString; cdecl;
    procedure setFileModificationDate(fileModificationDate: NSDate); cdecl;
    procedure setUndoManager(undoManager: NSUndoManager); cdecl;
    function undoManager: NSUndoManager; cdecl;
    procedure updateChangeCount(change: UIDocumentChangeKind); cdecl;
    procedure updateChangeCountWithToken(changeCountToken: Pointer; forSaveOperation: UIDocumentSaveOperation); cdecl;
    procedure userInteractionNoLongerPermittedForError(error: NSError); cdecl;
    function writeContents(contents: Pointer; andAttributes: NSDictionary; safelyToURL: NSURL; forSaveOperation: UIDocumentSaveOperation; error: NSError): Boolean; cdecl; overload;
    function writeContents(contents: Pointer; toURL: NSURL; forSaveOperation: UIDocumentSaveOperation; originalContentsURL: NSURL; error: NSError): Boolean; cdecl; overload;
  end;
  TUIDocument = class(TOCGenericImport<UIDocumentClass, UIDocument>)  end;

  UIEventClass = interface(NSObjectClass)
    ['{880C5B3F-C073-42B1-8C9D-8A6B70945125}']
  end;
  UIEvent = interface(NSObject)
    ['{EEA6BDEF-5C24-4E2A-A1C7-9206864D0B2F}']
    function allTouches: NSSet; cdecl;
    function subtype: UIEventSubtype; cdecl;
    function timestamp: NSTimeInterval; cdecl;
    function touchesForGestureRecognizer(gesture: UIGestureRecognizer): NSSet; cdecl;
    function touchesForView(view: UIView): NSSet; cdecl;
    function touchesForWindow(window: UIWindow): NSSet; cdecl;
  end;
  TUIEvent = class(TOCGenericImport<UIEventClass, UIEvent>)  end;

  UIDocumentInteractionControllerClass = interface(NSObjectClass)
    ['{1AEC1ED2-F0F1-4D18-8044-F7529842F28A}']
    {class} function interactionControllerWithURL(url: NSURL): Pointer; cdecl;
  end;
  UIDocumentInteractionController = interface(NSObject)
    ['{CCDBD0CE-D6B9-4D2B-A2F3-66F6F722B8D4}']
    function URL: NSURL; cdecl;
    function UTI: NSString; cdecl;
    function annotation: Pointer; cdecl;
    function delegate: Pointer; cdecl;
    procedure dismissMenuAnimated(animated: Boolean); cdecl;
    procedure dismissPreviewAnimated(animated: Boolean); cdecl;
    function gestureRecognizers: NSArray; cdecl;
    function icons: NSArray; cdecl;
    function name: NSString; cdecl;
    function presentOpenInMenuFromBarButtonItem(item: UIBarButtonItem; animated: Boolean): Boolean; cdecl;
    function presentOpenInMenuFromRect(rect: CGRect; inView: UIView; animated: Boolean): Boolean; cdecl;
    function presentOptionsMenuFromBarButtonItem(item: UIBarButtonItem; animated: Boolean): Boolean; cdecl;
    function presentOptionsMenuFromRect(rect: CGRect; inView: UIView; animated: Boolean): Boolean; cdecl;
    function presentPreviewAnimated(animated: Boolean): Boolean; cdecl;
    procedure setAnnotation(annotation: Pointer); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setName(name: NSString); cdecl;
    procedure setURL(URL: NSURL); cdecl;
    procedure setUTI(UTI: NSString); cdecl;
  end;
  TUIDocumentInteractionController = class(TOCGenericImport<UIDocumentInteractionControllerClass, UIDocumentInteractionController>)  end;

  UITouchClass = interface(NSObjectClass)
    ['{E0AE4AE6-6490-450C-87AB-9F2BCE1A6F45}']
  end;
  UITouch = interface(NSObject)
    ['{990DEAF7-4A0D-4AEE-9D91-BA9EAC3331AD}']
    function gestureRecognizers: NSArray; cdecl;
    function locationInView(view: UIView): CGPoint; cdecl;
    function phase: UITouchPhase; cdecl;
    function previousLocationInView(view: UIView): CGPoint; cdecl;
    function tapCount: NSUInteger; cdecl;
    function timestamp: NSTimeInterval; cdecl;
    function view: UIView; cdecl;
    function window: UIWindow; cdecl;
  end;
  TUITouch = class(TOCGenericImport<UITouchClass, UITouch>)  end;

  UIColorClass = interface(NSObjectClass)
    ['{B2BBD854-5CA8-47C3-8CB5-8A1E016E9914}']
    {class} function blackColor: Pointer; cdecl;
    {class} function blueColor: Pointer; cdecl;
    {class} function brownColor: Pointer; cdecl;
    {class} function clearColor: Pointer; cdecl;
    {class} function colorWithCGColor(cgColor: CGColorRef): Pointer; cdecl;
    {class} function colorWithCIColor(ciColor: CIColor): Pointer; cdecl;
    {class} function colorWithHue(hue: Single; saturation: Single; brightness: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithPatternImage(image: UIImage): Pointer; cdecl;
    {class} function colorWithRed(red: Single; green: Single; blue: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithWhite(white: Single; alpha: Single): Pointer; cdecl;
    {class} function cyanColor: Pointer; cdecl;
    {class} function darkGrayColor: Pointer; cdecl;
    {class} function darkTextColor: Pointer; cdecl;
    {class} function grayColor: Pointer; cdecl;
    {class} function greenColor: Pointer; cdecl;
    {class} function groupTableViewBackgroundColor: Pointer; cdecl;
    {class} function lightGrayColor: Pointer; cdecl;
    {class} function lightTextColor: Pointer; cdecl;
    {class} function magentaColor: Pointer; cdecl;
    {class} function orangeColor: Pointer; cdecl;
    {class} function purpleColor: Pointer; cdecl;
    {class} function redColor: Pointer; cdecl;
    {class} function scrollViewTexturedBackgroundColor: Pointer; cdecl;
    {class} function underPageBackgroundColor: Pointer; cdecl;
    {class} function viewFlipsideBackgroundColor: Pointer; cdecl;
    {class} function whiteColor: Pointer; cdecl;
    {class} function yellowColor: Pointer; cdecl;
  end;
  UIColor = interface(NSObject)
    ['{34723B19-45A7-43C6-9587-D091CF58F602}']
    function CGColor: CGColorRef; cdecl;
    function CIColor: CIColor; cdecl;
    function colorWithAlphaComponent(alpha: Single): UIColor; cdecl;
    function getHue(hue: PSingle; saturation: PSingle; brightness: PSingle; alpha: PSingle): Boolean; cdecl;
    function getRed(red: PSingle; green: PSingle; blue: PSingle; alpha: PSingle): Boolean; cdecl;
    function getWhite(white: PSingle; alpha: PSingle): Boolean; cdecl;
    function initWithCGColor(cgColor: CGColorRef): UIColor; cdecl;
    function initWithCIColor(ciColor: CIColor): UIColor; cdecl;
    function initWithHue(hue: Single; saturation: Single; brightness: Single; alpha: Single): UIColor; cdecl;
    function initWithPatternImage(image: UIImage): UIColor; cdecl;
    function initWithRed(red: Single; green: Single; blue: Single; alpha: Single): UIColor; cdecl;
    function initWithWhite(white: Single; alpha: Single): UIColor; cdecl;
    procedure setFill; cdecl;
    procedure setStroke; cdecl;
  end;
  TUIColor = class(TOCGenericImport<UIColorClass, UIColor>)  end;

  UITabBarItemClass = interface(UIBarItemClass)
    ['{01229171-8B2E-4A8C-B3B3-BDF2B4F318A0}']
  end;
  UITabBarItem = interface(UIBarItem)
    ['{3F568C31-B6AC-4A32-964A-45E1115CD86E}']
    function badgeValue: NSString; cdecl;
    function finishedSelectedImage: UIImage; cdecl;
    function finishedUnselectedImage: UIImage; cdecl;
    function initWithTabBarSystemItem(systemItem: UITabBarSystemItem; tag: NSInteger): Pointer; cdecl;
    function initWithTitle(title: NSString; image: UIImage; tag: NSInteger): Pointer; cdecl;
    procedure setBadgeValue(badgeValue: NSString); cdecl;
    procedure setFinishedSelectedImage(selectedImage: UIImage; withFinishedUnselectedImage: UIImage); cdecl;
    procedure setTitlePositionAdjustment(adjustment: UIOffset); cdecl;
    function titlePositionAdjustment: UIOffset; cdecl;
  end;
  TUITabBarItem = class(TOCGenericImport<UITabBarItemClass, UITabBarItem>)  end;

  UIRotationGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{7BA89951-9958-438A-96FD-31AE70FDDC69}']
  end;
  UIRotationGestureRecognizer = interface(UIGestureRecognizer)
    ['{7F1A0138-65D3-4D00-BDD0-193A7F68123C}']
    function rotation: Single; cdecl;
    procedure setRotation(rotation: Single); cdecl;
    function velocity: Single; cdecl;
  end;
  TUIRotationGestureRecognizer = class(TOCGenericImport<UIRotationGestureRecognizerClass, UIRotationGestureRecognizer>)  end;

  UISwipeGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{CB16C222-B625-48D9-8710-3EE9789C06E0}']
  end;
  UISwipeGestureRecognizer = interface(UIGestureRecognizer)
    ['{6ABB9B3E-CEB2-40A0-BCDD-EBA3BDE457CB}']
    function direction: UISwipeGestureRecognizerDirection; cdecl;
    function numberOfTouchesRequired: NSUInteger; cdecl;
    procedure setDirection(direction: UISwipeGestureRecognizerDirection); cdecl;
    procedure setNumberOfTouchesRequired(numberOfTouchesRequired: NSUInteger); cdecl;
  end;
  TUISwipeGestureRecognizer = class(TOCGenericImport<UISwipeGestureRecognizerClass, UISwipeGestureRecognizer>)  end;

  UIPinchGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{24405DD9-36FB-4E69-A18C-ED2C0BBBEBE9}']
  end;
  UIPinchGestureRecognizer = interface(UIGestureRecognizer)
    ['{54C67364-172A-48EC-8BF4-976954CB7815}']
    function scale: Single; cdecl;
    procedure setScale(scale: Single); cdecl;
    function velocity: Single; cdecl;
  end;
  TUIPinchGestureRecognizer = class(TOCGenericImport<UIPinchGestureRecognizerClass, UIPinchGestureRecognizer>)  end;

  UIMarkupTextPrintFormatterClass = interface(UIPrintFormatterClass)
    ['{CC233A69-E4E8-4D9D-BA7E-70B778B9C0DE}']
  end;
  UIMarkupTextPrintFormatter = interface(UIPrintFormatter)
    ['{DD819284-024F-4002-90CF-649F63E9A5D5}']
    function initWithMarkupText(markupText: NSString): Pointer; cdecl;
    function markupText: NSString; cdecl;
    procedure setMarkupText(markupText: NSString); cdecl;
  end;
  TUIMarkupTextPrintFormatter = class(TOCGenericImport<UIMarkupTextPrintFormatterClass, UIMarkupTextPrintFormatter>)  end;

  TOnUIViewControllerCompletion = procedure of object;
  UIViewControllerClass = interface(UIResponderClass)
    ['{87E0A407-94C1-4DC4-AA14-FB3C3BC619D1}']
    {class} procedure attemptRotationToDeviceOrientation; cdecl;
  end;
  UIViewController = interface(UIResponder)
    ['{F7A5E372-3F4A-4F25-A2F9-C91D7CB5FC09}']
    procedure addChildViewController(childController: UIViewController); cdecl;
    function automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers: Boolean; cdecl;
    function childViewControllers: NSArray; cdecl;
    function contentSizeForViewInPopover: CGSize; cdecl;
    function definesPresentationContext: Boolean; cdecl;
    procedure didAnimateFirstHalfOfRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation); cdecl;
    procedure didMoveToParentViewController(parent: UIViewController); cdecl;
    procedure didReceiveMemoryWarning; cdecl;
    procedure didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation); cdecl;
    function disablesAutomaticKeyboardDismissal: Boolean; cdecl;
    procedure dismissModalViewControllerAnimated(animated: Boolean); cdecl;
    function editButtonItem: UIBarButtonItem; cdecl;
    function hidesBottomBarWhenPushed: Boolean; cdecl;
    function initWithNibName(nibNameOrNil: NSString; bundle: NSBundle): Pointer; cdecl;
    function interfaceOrientation: UIInterfaceOrientation; cdecl;
    function isBeingDismissed: Boolean; cdecl;
    function isBeingPresented: Boolean; cdecl;
    function isEditing: Boolean; cdecl;
    function isModalInPopover: Boolean; cdecl;
    function isMovingFromParentViewController: Boolean; cdecl;
    function isMovingToParentViewController: Boolean; cdecl;
    function isViewLoaded: Boolean; cdecl;
    procedure loadView; cdecl;
    function modalPresentationStyle: UIModalPresentationStyle; cdecl;
    function modalTransitionStyle: UIModalTransitionStyle; cdecl;
    function modalViewController: UIViewController; cdecl;
    function navigationController: UINavigationController; cdecl;
    function navigationItem: UINavigationItem; cdecl;
    function nibBundle: NSBundle; cdecl;
    function nibName: NSString; cdecl;
    function parentViewController: UIViewController; cdecl;
    procedure performSegueWithIdentifier(identifier: NSString; sender: Pointer); cdecl;
    procedure prepareForSegue(segue: UIStoryboardSegue; sender: Pointer); cdecl;
    procedure presentModalViewController(modalViewController: UIViewController; animated: Boolean); cdecl;
    procedure presentViewController(viewControllerToPresent: UIViewController; animated: Boolean; completion: TOnUIViewControllerCompletion); cdecl; // Version >= IOS 5.0
    procedure dismissViewControllerAnimated(flag: Boolean; completion: TOnUIViewControllerCompletion); cdecl;
    function presentedViewController: UIViewController; cdecl;
    function presentingViewController: UIViewController; cdecl;
    function providesPresentationContextTransitionStyle: Boolean; cdecl;
    procedure removeFromParentViewController; cdecl;
    function rotatingFooterView: UIView; cdecl;
    function rotatingHeaderView: UIView; cdecl;
    function searchDisplayController: UISearchDisplayController; cdecl;
    procedure setContentSizeForViewInPopover(contentSizeForViewInPopover: CGSize); cdecl;
    procedure setDefinesPresentationContext(definesPresentationContext: Boolean); cdecl;
    procedure setEditing(editing: Boolean); cdecl; overload;
    procedure setEditing(editing: Boolean; animated: Boolean); cdecl; overload;
    procedure setHidesBottomBarWhenPushed(hidesBottomBarWhenPushed: Boolean); cdecl;
    procedure setModalInPopover(modalInPopover: Boolean); cdecl;
    procedure setModalPresentationStyle(modalPresentationStyle: UIModalPresentationStyle); cdecl;
    procedure setModalTransitionStyle(modalTransitionStyle: UIModalTransitionStyle); cdecl;
    procedure setProvidesPresentationContextTransitionStyle(providesPresentationContextTransitionStyle: Boolean); cdecl;
    procedure setTabBarItem(tabBarItem: UITabBarItem); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure setToolbarItems(toolbarItems: NSArray); cdecl; overload;
    procedure setToolbarItems(toolbarItems: NSArray; animated: Boolean); cdecl; overload;
    procedure setView(view: UIView); cdecl;
    procedure setWantsFullScreenLayout(wantsFullScreenLayout: Boolean); cdecl;
    function shouldAutorotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation): Boolean; cdecl;
    function splitViewController: UISplitViewController; cdecl;
    function storyboard: UIStoryboard; cdecl;
    function tabBarController: UITabBarController; cdecl;
    function tabBarItem: UITabBarItem; cdecl;
    function title: NSString; cdecl;
    function toolbarItems: NSArray; cdecl;
    function view: UIView; cdecl;
    procedure viewDidAppear(animated: Boolean); cdecl;
    procedure viewDidDisappear(animated: Boolean); cdecl;
    procedure viewDidLayoutSubviews; cdecl;
    procedure viewDidLoad; cdecl;
    procedure viewDidUnload; cdecl;
    procedure viewWillAppear(animated: Boolean); cdecl;
    procedure viewWillDisappear(animated: Boolean); cdecl;
    procedure viewWillLayoutSubviews; cdecl;
    procedure viewWillUnload; cdecl;
    function wantsFullScreenLayout: Boolean; cdecl;
    procedure willAnimateFirstHalfOfRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
    procedure willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
    procedure willAnimateSecondHalfOfRotationFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
    procedure willMoveToParentViewController(parent: UIViewController); cdecl;
    procedure willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl;
  end;
  TUIViewController = class(TOCGenericImport<UIViewControllerClass, UIViewController>)  end;

  UIBarButtonItemClass = interface(UIBarItemClass)
    ['{287CC128-E9B5-4B76-A63F-9D6632EF6950}']
  end;
  UIBarButtonItem = interface(UIBarItem)
    ['{3C056056-41D4-44E8-A3B1-D16DA7666333}']
    function action: SEL; cdecl;
    function backButtonBackgroundImageForState(state: UIControlState; barMetrics: UIBarMetrics): UIImage; cdecl;
    function backButtonBackgroundVerticalPositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics): Single; cdecl;
    function backButtonTitlePositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics): UIOffset; cdecl;
    function backgroundImageForState(state: UIControlState; barMetrics: UIBarMetrics): UIImage; cdecl;
    function backgroundVerticalPositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics): Single; cdecl;
    function customView: UIView; cdecl;
    function initWithBarButtonSystemItem(systemItem: UIBarButtonSystemItem; target: Pointer; action: SEL): Pointer; cdecl;
    function initWithCustomView(customView: UIView): Pointer; cdecl;
    function initWithImage(image: UIImage; landscapeImagePhone: UIImage; style: UIBarButtonItemStyle; target: Pointer; action: SEL): Pointer; cdecl; overload;
    function initWithImage(image: UIImage; style: UIBarButtonItemStyle; target: Pointer; action: SEL): Pointer; cdecl; overload;
    function initWithTitle(title: NSString; style: UIBarButtonItemStyle; target: Pointer; action: SEL): Pointer; cdecl;
    function possibleTitles: NSSet; cdecl;
    procedure setAction(action: SEL); cdecl;
    procedure setBackButtonBackgroundImage(backgroundImage: UIImage; forState: UIControlState; barMetrics: UIBarMetrics); cdecl;
    procedure setBackButtonBackgroundVerticalPositionAdjustment(adjustment: Single; forBarMetrics: UIBarMetrics); cdecl;
    procedure setBackButtonTitlePositionAdjustment(adjustment: UIOffset; forBarMetrics: UIBarMetrics); cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage; forState: UIControlState; barMetrics: UIBarMetrics); cdecl;
    procedure setBackgroundVerticalPositionAdjustment(adjustment: Single; forBarMetrics: UIBarMetrics); cdecl;
    procedure setCustomView(customView: UIView); cdecl;
    procedure setPossibleTitles(possibleTitles: NSSet); cdecl;
    procedure setStyle(style: UIBarButtonItemStyle); cdecl;
    procedure setTarget(target: Pointer); cdecl;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTitlePositionAdjustment(adjustment: UIOffset; forBarMetrics: UIBarMetrics); cdecl;
    procedure setWidth(width: Single); cdecl;
    function style: UIBarButtonItemStyle; cdecl;
    function target: Pointer; cdecl;
    function tintColor: UIColor; cdecl;
    function titlePositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics): UIOffset; cdecl;
    function width: Single; cdecl;
  end;
  TUIBarButtonItem = class(TOCGenericImport<UIBarButtonItemClass, UIBarButtonItem>)  end;

  UIViewClass = interface(UIResponderClass)
    ['{BC6ED940-E934-477F-AF6A-0249A5095935}']
    {class} function areAnimationsEnabled: Boolean; cdecl;
    {class} procedure beginAnimations(animationID: Pointer; context: Pointer); cdecl;
    {class} procedure commitAnimations; cdecl;
    {class} procedure setAnimationBeginsFromCurrentState(fromCurrentState: Boolean); cdecl;
    {class} procedure setAnimationCurve(curve: UIViewAnimationCurve); cdecl;
    {class} procedure setAnimationDelay(delay: NSTimeInterval); cdecl;
    {class} procedure setAnimationDelegate(delegate: Pointer); cdecl;
    {class} procedure setAnimationDidStopSelector(selector: SEL); cdecl;
    {class} procedure setAnimationDuration(duration: NSTimeInterval); cdecl;
    {class} procedure setAnimationRepeatAutoreverses(repeatAutoreverses: Boolean); cdecl;
    {class} procedure setAnimationRepeatCount(repeatCount: Single); cdecl;
    {class} procedure setAnimationStartDate(startDate: NSDate); cdecl;
    {class} procedure setAnimationTransition(transition: UIViewAnimationTransition; forView: UIView; cache: Boolean); cdecl;
    {class} procedure setAnimationWillStartSelector(selector: SEL); cdecl;
    {class} procedure setAnimationsEnabled(enabled: Boolean); cdecl;
  end;
  UIView = interface(UIResponder)
    ['{2DD827CB-85D2-4EE5-AA42-87941019F4B3}']
    procedure addGestureRecognizer(gestureRecognizer: UIGestureRecognizer); cdecl;
    procedure addSubview(view: UIView); cdecl;
    function alpha: Single; cdecl;
    function autoresizesSubviews: Boolean; cdecl;
    function autoresizingMask: UIViewAutoresizing; cdecl;
    function backgroundColor: UIColor; cdecl;
    function bounds: CGRect; cdecl;
    procedure bringSubviewToFront(view: UIView); cdecl;
    function center: CGPoint; cdecl;
    function clearsContextBeforeDrawing: Boolean; cdecl;
    function clipsToBounds: Boolean; cdecl;
    function contentMode: UIViewContentMode; cdecl;
    function contentScaleFactor: Single; cdecl;
    function contentStretch: CGRect; cdecl;
    function convertPoint(point: CGPoint; fromView: UIView): CGPoint; cdecl; overload;
//    function convertPoint(point: CGPoint; toView: UIView): CGPoint; cdecl; overload;
    function convertRect(rect: CGRect; fromView: UIView): CGRect; cdecl; overload;
//    function convertRect(rect: CGRect; toView: UIView): CGRect; cdecl; overload;
    procedure didAddSubview(subview: UIView); cdecl;
    procedure didMoveToSuperview; cdecl;
    procedure didMoveToWindow; cdecl;
    procedure drawRect(rect: CGRect); cdecl; overload;
    procedure drawRect(rect: CGRect; forViewPrintFormatter: UIViewPrintFormatter); cdecl; overload;
    function endEditing(force: Boolean): Boolean; cdecl;
    procedure exchangeSubviewAtIndex(index1: NSInteger; withSubviewAtIndex: NSInteger); cdecl;
    function frame: CGRect; cdecl;
    function gestureRecognizers: NSArray; cdecl;
    function hitTest(point: CGPoint; withEvent: UIEvent): UIView; cdecl;
    function initWithFrame(frame: CGRect): Pointer; cdecl;
    procedure insertSubview(view: UIView; aboveSubview: UIView); cdecl; overload;
    procedure insertSubview(view: UIView; atIndex: NSInteger); cdecl; overload;
//    procedure insertSubview(view: UIView; belowSubview: UIView); cdecl; overload;
    function isDescendantOfView(view: UIView): Boolean; cdecl;
    function isExclusiveTouch: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isMultipleTouchEnabled: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isUserInteractionEnabled: Boolean; cdecl;
    function layer: CALayer; cdecl;
    procedure layoutIfNeeded; cdecl;
    procedure layoutSubviews; cdecl;
    function pointInside(point: CGPoint; withEvent: UIEvent): Boolean; cdecl;
    procedure removeFromSuperview; cdecl;
    procedure removeGestureRecognizer(gestureRecognizer: UIGestureRecognizer); cdecl;
    procedure sendSubviewToBack(view: UIView); cdecl;
    procedure setAlpha(alpha: Single); cdecl;
    procedure setAutoresizesSubviews(autoresizesSubviews: Boolean); cdecl;
    procedure setAutoresizingMask(autoresizingMask: UIViewAutoresizing); cdecl;
    procedure setBackgroundColor(backgroundColor: UIColor); cdecl;
    procedure setBounds(bounds: CGRect); cdecl;
    procedure setCenter(center: CGPoint); cdecl;
    procedure setClearsContextBeforeDrawing(clearsContextBeforeDrawing: Boolean); cdecl;
    procedure setClipsToBounds(clipsToBounds: Boolean); cdecl;
    procedure setContentMode(contentMode: UIViewContentMode); cdecl;
    procedure setContentScaleFactor(contentScaleFactor: Single); cdecl;
    procedure setContentStretch(contentStretch: CGRect); cdecl;
    procedure setExclusiveTouch(exclusiveTouch: Boolean); cdecl;
    procedure setFrame(frame: CGRect); cdecl;
    procedure setGestureRecognizers(gestureRecognizers: NSArray); cdecl;
    procedure setHidden(hidden: Boolean); cdecl;
    procedure setMultipleTouchEnabled(multipleTouchEnabled: Boolean); cdecl;
    procedure setNeedsDisplay; cdecl;
    procedure setNeedsDisplayInRect(rect: CGRect); cdecl;
    procedure setNeedsLayout; cdecl;
    procedure setOpaque(opaque: Boolean); cdecl;
    procedure setTag(tag: NSInteger); cdecl;
    procedure setTransform(transform: CGAffineTransform); cdecl;
    procedure setUserInteractionEnabled(userInteractionEnabled: Boolean); cdecl;
    function sizeThatFits(size: CGSize): CGSize; cdecl;
    procedure sizeToFit; cdecl;
    function subviews: NSArray; cdecl;
    function superview: Pointer; cdecl;
    function tag: NSInteger; cdecl;
    function transform: CGAffineTransform; cdecl;
    function viewPrintFormatter: UIViewPrintFormatter; cdecl;
    function viewWithTag(tag: NSInteger): UIView; cdecl;
    procedure willMoveToSuperview(newSuperview: UIView); cdecl;
    procedure willMoveToWindow(newWindow: UIWindow); cdecl;
    procedure willRemoveSubview(subview: UIView); cdecl;
    function window: UIWindow; cdecl;
  end;
  TUIView = class(TOCGenericImport<UIViewClass, UIView>)  end;

  UILongPressGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{30C71FB1-FDCB-4BA7-A838-84E65721AA6F}']
  end;
  UILongPressGestureRecognizer = interface(UIGestureRecognizer)
    ['{9A7D268A-9CE3-4FB7-9593-A1A3E9D26C58}']
    function allowableMovement: Single; cdecl;
    function minimumPressDuration: CFTimeInterval; cdecl;
    function numberOfTapsRequired: NSInteger; cdecl;
    function numberOfTouchesRequired: NSInteger; cdecl;
    procedure setAllowableMovement(allowableMovement: Single); cdecl;
    procedure setMinimumPressDuration(minimumPressDuration: CFTimeInterval); cdecl;
    procedure setNumberOfTapsRequired(numberOfTapsRequired: NSInteger); cdecl;
    procedure setNumberOfTouchesRequired(numberOfTouchesRequired: NSInteger); cdecl;
  end;
  TUILongPressGestureRecognizer = class(TOCGenericImport<UILongPressGestureRecognizerClass, UILongPressGestureRecognizer>)  end;

  UIManagedDocumentClass = interface(UIDocumentClass)
    ['{1711C743-A68F-4EC3-B47C-6C92F317095F}']
    {class} function persistentStoreName: NSString; cdecl;
  end;
  UIManagedDocument = interface(UIDocument)
    ['{CB729C37-3C01-48CB-8CA8-50FFEB780ABB}']
    function additionalContentForURL(absoluteURL: NSURL; error: NSError): Pointer; cdecl;
    function configurePersistentStoreCoordinatorForURL(storeURL: NSURL; ofType: NSString; modelConfiguration: NSString; storeOptions: NSDictionary; error: NSError): Boolean; cdecl;
    function managedObjectContext: NSManagedObjectContext; cdecl;
    function managedObjectModel: NSManagedObjectModel; cdecl;
    function modelConfiguration: NSString; cdecl;
    function persistentStoreOptions: NSDictionary; cdecl;
    function persistentStoreTypeForFileType(fileType: NSString): NSString; cdecl;
    function readAdditionalContentFromURL(absoluteURL: NSURL; error: NSError): Boolean; cdecl;
    procedure setModelConfiguration(modelConfiguration: NSString); cdecl;
    procedure setPersistentStoreOptions(persistentStoreOptions: NSDictionary); cdecl;
    function writeAdditionalContent(content: Pointer; toURL: NSURL; originalContentsURL: NSURL; error: NSError): Boolean; cdecl;
  end;
  TUIManagedDocument = class(TOCGenericImport<UIManagedDocumentClass, UIManagedDocument>)  end;

  UISimpleTextPrintFormatterClass = interface(UIPrintFormatterClass)
    ['{23C73E69-9AF1-4080-93DA-E405E08B6FDD}']
  end;
  UISimpleTextPrintFormatter = interface(UIPrintFormatter)
    ['{C0D1AFC9-347B-400B-B1F2-8F2420C4B41C}']
    function color: UIColor; cdecl;
    function font: UIFont; cdecl;
    function initWithText(text: NSString): Pointer; cdecl;
    procedure setColor(color: UIColor); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTextAlignment(textAlignment: UITextAlignment); cdecl;
    function text: NSString; cdecl;
    function textAlignment: UITextAlignment; cdecl;
  end;
  TUISimpleTextPrintFormatter = class(TOCGenericImport<UISimpleTextPrintFormatterClass, UISimpleTextPrintFormatter>)  end;

  UIPanGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{04F97651-346C-4F06-A92E-15FC47E9FB1A}']
  end;
  UIPanGestureRecognizer = interface(UIGestureRecognizer)
    ['{AE52DAD1-5A76-41DF-8043-6A54236B4459}']
    function maximumNumberOfTouches: NSUInteger; cdecl;
    function minimumNumberOfTouches: NSUInteger; cdecl;
    procedure setMaximumNumberOfTouches(maximumNumberOfTouches: NSUInteger); cdecl;
    procedure setMinimumNumberOfTouches(minimumNumberOfTouches: NSUInteger); cdecl;
    procedure setTranslation(translation: CGPoint; inView: UIView); cdecl;
    function translationInView(view: UIView): CGPoint; cdecl;
    function velocityInView(view: UIView): CGPoint; cdecl;
  end;
  TUIPanGestureRecognizer = class(TOCGenericImport<UIPanGestureRecognizerClass, UIPanGestureRecognizer>)  end;

  UIStoryboardPopoverSegueClass = interface(UIStoryboardSegueClass)
    ['{E2E1985B-A9CC-4313-A4DA-40365CAA63E8}']
  end;
  UIStoryboardPopoverSegue = interface(UIStoryboardSegue)
    ['{D20BB5C9-6212-47B3-9ABF-2C8FEA565230}']
    function popoverController: UIPopoverController; cdecl;
  end;
  TUIStoryboardPopoverSegue = class(TOCGenericImport<UIStoryboardPopoverSegueClass, UIStoryboardPopoverSegue>)  end;

  UIApplicationClass = interface(UIResponderClass)
    ['{EB8D5CD5-75CA-469F-B1B9-3A32D640B450}']
    {class} function sharedApplication: Pointer; cdecl;
  end;
  UIApplication = interface(UIResponder)
    ['{BD1002BE-B8C1-45BE-9AB8-9720A9EB1102}']
    function applicationIconBadgeNumber: NSInteger; cdecl;
    function applicationState: Integer; cdecl;
    function applicationSupportsShakeToEdit: Boolean; cdecl;
    function backgroundTimeRemaining: NSTimeInterval; cdecl;
    procedure beginIgnoringInteractionEvents; cdecl;
    procedure beginReceivingRemoteControlEvents; cdecl;
    function canOpenURL(url: NSURL): Boolean; cdecl;
    procedure cancelAllLocalNotifications; cdecl;
    procedure cancelLocalNotification(notification: UILocalNotification); cdecl;
    procedure clearKeepAliveTimeout; cdecl;
    function delegate: UIApplicationDelegate; cdecl;
    function enabledRemoteNotificationTypes: Pointer; cdecl;
    procedure endBackgroundTask(identifier: Pointer); cdecl;
    procedure endIgnoringInteractionEvents; cdecl;
    procedure endReceivingRemoteControlEvents; cdecl;
    function isIdleTimerDisabled: Boolean; cdecl;
    function isIgnoringInteractionEvents: Boolean; cdecl;
    function isNetworkActivityIndicatorVisible: Boolean; cdecl;
    function isProtectedDataAvailable: Boolean; cdecl;
    function isStatusBarHidden: Boolean; cdecl;
    function keyWindow: UIWindow; cdecl;
    function openURL(url: NSURL): Boolean; cdecl;
    procedure presentLocalNotificationNow(notification: UILocalNotification); cdecl;
    procedure registerForRemoteNotificationTypes(types: Pointer); cdecl;
    procedure scheduleLocalNotification(notification: UILocalNotification); cdecl;
    function scheduledLocalNotifications: NSArray; cdecl;
    procedure sendEvent(event: UIEvent); cdecl;
    procedure setApplicationIconBadgeNumber(applicationIconBadgeNumber: NSInteger); cdecl;
    procedure setApplicationSupportsShakeToEdit(applicationSupportsShakeToEdit: Boolean); cdecl;
    procedure setDelegate(delegate: UIApplicationDelegate); cdecl;
    procedure setIdleTimerDisabled(idleTimerDisabled: Boolean); cdecl;
    procedure setNetworkActivityIndicatorVisible(networkActivityIndicatorVisible: Boolean); cdecl;
    procedure setNewsstandIconImage(image: UIImage); cdecl;
    procedure setScheduledLocalNotifications(scheduledLocalNotifications: NSArray); cdecl;
    procedure setStatusBarHidden(statusBarHidden: Boolean); cdecl; overload;
    procedure setStatusBarHidden(hidden: Boolean; withAnimation: UIStatusBarAnimation); cdecl; overload;
    procedure setStatusBarOrientation(statusBarOrientation: UIInterfaceOrientation); cdecl; overload;
    procedure setStatusBarOrientation(interfaceOrientation: UIInterfaceOrientation; animated: Boolean); cdecl; overload;
    procedure setStatusBarStyle(statusBarStyle: UIStatusBarStyle); cdecl; overload;
    procedure setStatusBarStyle(statusBarStyle: UIStatusBarStyle; animated: Boolean); cdecl; overload;
    function statusBarFrame: CGRect; cdecl;
    function statusBarOrientation: UIInterfaceOrientation; cdecl;
    function statusBarOrientationAnimationDuration: NSTimeInterval; cdecl;
    function statusBarStyle: UIStatusBarStyle; cdecl;
    procedure unregisterForRemoteNotifications; cdecl;
    function userInterfaceLayoutDirection: Integer; cdecl;
    function windows: NSArray; cdecl;
  end;
  TUIApplication = class(TOCGenericImport<UIApplicationClass, UIApplication>)  end;

  UIViewPrintFormatterClass = interface(UIPrintFormatterClass)
    ['{7D474AB7-6437-4258-9DA9-51BE7473D0AD}']
  end;
  UIViewPrintFormatter = interface(UIPrintFormatter)
    ['{595E8B80-CC94-41BC-8B94-41BE7DF984A6}']
    function view: UIView; cdecl;
  end;
  TUIViewPrintFormatter = class(TOCGenericImport<UIViewPrintFormatterClass, UIViewPrintFormatter>)  end;

  UITapGestureRecognizerClass = interface(UIGestureRecognizerClass)
    ['{B998245A-B96F-4BF8-B8D7-0FFC35E31DCA}']
  end;
  UITapGestureRecognizer = interface(UIGestureRecognizer)
    ['{00DE2AD5-8E72-4513-BAEC-FD6E95D0B7AD}']
    function numberOfTapsRequired: NSUInteger; cdecl;
    function numberOfTouchesRequired: NSUInteger; cdecl;
    procedure setNumberOfTapsRequired(numberOfTapsRequired: NSUInteger); cdecl;
    procedure setNumberOfTouchesRequired(numberOfTouchesRequired: NSUInteger); cdecl;
  end;
  TUITapGestureRecognizer = class(TOCGenericImport<UITapGestureRecognizerClass, UITapGestureRecognizer>)  end;

  UIWebViewClass = interface(UIViewClass)
    ['{7A6BE447-0282-4E37-9DC8-64BC2417A6E9}']
  end;
  UIWebView = interface(UIView)
    ['{787E0C18-F4B5-4A96-850F-B47D9122C74E}']
    function allowsInlineMediaPlayback: Boolean; cdecl;
    function canGoBack: Boolean; cdecl;
    function canGoForward: Boolean; cdecl;
    function dataDetectorTypes: UIDataDetectorTypes; cdecl;
    function delegate: Pointer; cdecl;
    function detectsPhoneNumbers: Boolean; cdecl;
    procedure goBack; cdecl;
    procedure goForward; cdecl;
    function isLoading: Boolean; cdecl;
    procedure loadData(data: NSData; MIMEType: NSString; textEncodingName: NSString; baseURL: NSURL); cdecl;
    procedure loadHTMLString(string_: NSString; baseURL: NSURL); cdecl;
    procedure loadRequest(request: NSURLRequest); cdecl;
    function mediaPlaybackAllowsAirPlay: Boolean; cdecl;
    function mediaPlaybackRequiresUserAction: Boolean; cdecl;
    procedure reload; cdecl;
    function request: NSURLRequest; cdecl;
    function scalesPageToFit: Boolean; cdecl;
    function scrollView: UIScrollView; cdecl;
    procedure setAllowsInlineMediaPlayback(allowsInlineMediaPlayback: Boolean); cdecl;
    procedure setDataDetectorTypes(dataDetectorTypes: UIDataDetectorTypes); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDetectsPhoneNumbers(detectsPhoneNumbers: Boolean); cdecl;
    procedure setMediaPlaybackAllowsAirPlay(mediaPlaybackAllowsAirPlay: Boolean); cdecl;
    procedure setMediaPlaybackRequiresUserAction(mediaPlaybackRequiresUserAction: Boolean); cdecl;
    procedure setScalesPageToFit(scalesPageToFit: Boolean); cdecl;
    procedure stopLoading; cdecl;
    function stringByEvaluatingJavaScriptFromString(script: NSString): NSString; cdecl;
  end;
  TUIWebView = class(TOCGenericImport<UIWebViewClass, UIWebView>)  end;

  UITableViewControllerClass = interface(UIViewControllerClass)
    ['{B81F488C-3A18-4EAC-9CA5-2901848AE908}']
  end;
  UITableViewController = interface(UIViewController)
    ['{73CE7B2D-0C95-4D75-89CE-1330AD98D89C}']
    function clearsSelectionOnViewWillAppear: Boolean; cdecl;
    function initWithStyle(style: UITableViewStyle): Pointer; cdecl;
    procedure setClearsSelectionOnViewWillAppear(clearsSelectionOnViewWillAppear: Boolean); cdecl;
    procedure setTableView(tableView: UITableView); cdecl;
    function tableView: UITableView; cdecl;
  end;
  TUITableViewController = class(TOCGenericImport<UITableViewControllerClass, UITableViewController>)  end;

  UIToolbarClass = interface(UIViewClass)
    ['{094FD093-09E3-4D09-BF6B-7CF1452750AB}']
  end;
  UIToolbar = interface(UIView)
    ['{90062BBC-88E7-4427-B3A5-8BB14FA23677}']
    function backgroundImageForToolbarPosition(topOrBottom: UIToolbarPosition; barMetrics: UIBarMetrics): UIImage; cdecl;
    function barStyle: UIBarStyle; cdecl;
    function isTranslucent: Boolean; cdecl;
    function items: NSArray; cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage; forToolbarPosition: UIToolbarPosition; barMetrics: UIBarMetrics); cdecl;
    procedure setBarStyle(barStyle: UIBarStyle); cdecl;
    procedure setItems(items: NSArray); cdecl; overload;
    procedure setItems(items: NSArray; animated: Boolean); cdecl; overload;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTranslucent(translucent: Boolean); cdecl;
    function tintColor: UIColor; cdecl;
  end;
  TUIToolbar = class(TOCGenericImport<UIToolbarClass, UIToolbar>)  end;

  UITableViewCellClass = interface(UIViewClass)
    ['{E2845766-9E8B-48BA-A3F7-E4CBB58506D2}']
  end;
  UITableViewCell = interface(UIView)
    ['{60DA2C8C-9FDF-4EAB-92ED-0925A7789C59}']
    function accessoryAction: SEL; cdecl;
    function accessoryType: UITableViewCellAccessoryType; cdecl;
    function accessoryView: UIView; cdecl;
    function backgroundView: UIView; cdecl;
    function contentView: UIView; cdecl;
    function detailTextLabel: UILabel; cdecl;
    procedure didTransitionToState(state: UITableViewCellStateMask); cdecl;
    function editAction: SEL; cdecl;
    function editingAccessoryType: UITableViewCellAccessoryType; cdecl;
    function editingAccessoryView: UIView; cdecl;
    function editingStyle: UITableViewCellEditingStyle; cdecl;
    function font: UIFont; cdecl;
    function hidesAccessoryWhenEditing: Boolean; cdecl;
    function image: UIImage; cdecl;
    function imageView: UIImageView; cdecl;
    function indentationLevel: NSInteger; cdecl;
    function indentationWidth: Single; cdecl;
    function initWithFrame(frame: CGRect; reuseIdentifier: NSString): Pointer; cdecl;
    function initWithStyle(style: UITableViewCellStyle; reuseIdentifier: NSString): Pointer; cdecl;
    function isEditing: Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isSelected: Boolean; cdecl;
    function lineBreakMode: UILineBreakMode; cdecl;
    function multipleSelectionBackgroundView: UIView; cdecl;
    procedure prepareForReuse; cdecl;
    function reuseIdentifier: NSString; cdecl;
    function selectedBackgroundView: UIView; cdecl;
    function selectedImage: UIImage; cdecl;
    function selectedTextColor: UIColor; cdecl;
    function selectionStyle: UITableViewCellSelectionStyle; cdecl;
    procedure setAccessoryAction(accessoryAction: SEL); cdecl;
    procedure setAccessoryType(accessoryType: UITableViewCellAccessoryType); cdecl;
    procedure setAccessoryView(accessoryView: UIView); cdecl;
    procedure setBackgroundView(backgroundView: UIView); cdecl;
    procedure setEditAction(editAction: SEL); cdecl;
    procedure setEditing(editing: Boolean); cdecl; overload;
    procedure setEditing(editing: Boolean; animated: Boolean); cdecl; overload;
    procedure setEditingAccessoryType(editingAccessoryType: UITableViewCellAccessoryType); cdecl;
    procedure setEditingAccessoryView(editingAccessoryView: UIView); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setHidesAccessoryWhenEditing(hidesAccessoryWhenEditing: Boolean); cdecl;
    procedure setHighlighted(highlighted: Boolean); cdecl; overload;
    procedure setHighlighted(highlighted: Boolean; animated: Boolean); cdecl; overload;
    procedure setImage(image: UIImage); cdecl;
    procedure setIndentationLevel(indentationLevel: NSInteger); cdecl;
    procedure setIndentationWidth(indentationWidth: Single); cdecl;
    procedure setLineBreakMode(lineBreakMode: UILineBreakMode); cdecl;
    procedure setMultipleSelectionBackgroundView(multipleSelectionBackgroundView: UIView); cdecl;
    procedure setSelected(selected: Boolean); cdecl; overload;
    procedure setSelected(selected: Boolean; animated: Boolean); cdecl; overload;
    procedure setSelectedBackgroundView(selectedBackgroundView: UIView); cdecl;
    procedure setSelectedImage(selectedImage: UIImage); cdecl;
    procedure setSelectedTextColor(selectedTextColor: UIColor); cdecl;
    procedure setSelectionStyle(selectionStyle: UITableViewCellSelectionStyle); cdecl;
    procedure setShouldIndentWhileEditing(shouldIndentWhileEditing: Boolean); cdecl;
    procedure setShowsReorderControl(showsReorderControl: Boolean); cdecl;
    procedure setTarget(target: Pointer); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTextAlignment(textAlignment: UITextAlignment); cdecl;
    procedure setTextColor(textColor: UIColor); cdecl;
    function shouldIndentWhileEditing: Boolean; cdecl;
    function showingDeleteConfirmation: Boolean; cdecl;
    function showsReorderControl: Boolean; cdecl;
    function target: Pointer; cdecl;
    function text: NSString; cdecl;
    function textAlignment: UITextAlignment; cdecl;
    function textColor: UIColor; cdecl;
    function textLabel: UILabel; cdecl;
    procedure willTransitionToState(state: UITableViewCellStateMask); cdecl;
  end;
  TUITableViewCell = class(TOCGenericImport<UITableViewCellClass, UITableViewCell>)  end;

  UITabBarClass = interface(UIViewClass)
    ['{945AF986-A933-4C6C-AA37-D742F8FDBB9C}']
  end;
  UITabBar = interface(UIView)
    ['{661BB52C-5607-48EF-A161-B1EE22B45A2D}']
    function backgroundImage: UIImage; cdecl;
    procedure beginCustomizingItems(items: NSArray); cdecl;
    function delegate: Pointer; cdecl;
    function endCustomizingAnimated(animated: Boolean): Boolean; cdecl;
    function isCustomizing: Boolean; cdecl;
    function items: NSArray; cdecl;
    function selectedImageTintColor: UIColor; cdecl;
    function selectedItem: UITabBarItem; cdecl;
    function selectionIndicatorImage: UIImage; cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setItems(items: NSArray); cdecl; overload;
    procedure setItems(items: NSArray; animated: Boolean); cdecl; overload;
    procedure setSelectedImageTintColor(selectedImageTintColor: UIColor); cdecl;
    procedure setSelectedItem(selectedItem: UITabBarItem); cdecl;
    procedure setSelectionIndicatorImage(selectionIndicatorImage: UIImage); cdecl;
    procedure setTintColor(tintColor: UIColor); cdecl;
    function tintColor: UIColor; cdecl;
  end;
  TUITabBar = class(TOCGenericImport<UITabBarClass, UITabBar>)  end;

  UITabBarControllerClass = interface(UIViewControllerClass)
    ['{22ABB2F0-7BB4-47BB-95F5-FC3F2FDEC1A8}']
  end;
  UITabBarController = interface(UIViewController)
    ['{C0FB9778-5DE5-4D8E-811E-D27566531604}']
    function customizableViewControllers: NSArray; cdecl;
    function delegate: Pointer; cdecl;
    function moreNavigationController: UINavigationController; cdecl;
    function selectedIndex: NSUInteger; cdecl;
    function selectedViewController: UIViewController; cdecl;
    procedure setCustomizableViewControllers(customizableViewControllers: NSArray); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setSelectedIndex(selectedIndex: NSUInteger); cdecl;
    procedure setSelectedViewController(selectedViewController: UIViewController); cdecl;
    procedure setViewControllers(viewControllers: NSArray); cdecl; overload;
    procedure setViewControllers(viewControllers: NSArray; animated: Boolean); cdecl; overload;
    function tabBar: UITabBar; cdecl;
    function viewControllers: NSArray; cdecl;
  end;
  TUITabBarController = class(TOCGenericImport<UITabBarControllerClass, UITabBarController>)  end;

  UIWindowClass = interface(UIViewClass)
    ['{60E6214D-C7C2-43EE-BC3D-B3BA51DDA9C0}']
  end;
  UIWindow = interface(UIView)
    ['{B2310880-6213-441B-913E-23711AA89558}']
    procedure becomeKeyWindow; cdecl;
    function convertPoint(point: CGPoint; fromWindow: UIWindow): CGPoint; cdecl; overload;
//    function convertPoint(point: CGPoint; toWindow: UIWindow): CGPoint; cdecl; overload;
    function convertRect(rect: CGRect; fromWindow: UIWindow): CGRect; cdecl; overload;
//    function convertRect(rect: CGRect; toWindow: UIWindow): CGRect; cdecl; overload;
    function isKeyWindow: Boolean; cdecl;
    procedure makeKeyAndVisible; cdecl;
    procedure makeKeyWindow; cdecl;
    procedure resignKeyWindow; cdecl;
    function rootViewController: UIViewController; cdecl;
    function screen: UIScreen; cdecl;
    procedure sendEvent(event: UIEvent); cdecl;
    procedure setRootViewController(rootViewController: UIViewController); cdecl;
    procedure setScreen(screen: UIScreen); cdecl;
    procedure setWindowLevel(windowLevel: UIWindowLevel); cdecl;
    function windowLevel: UIWindowLevel; cdecl;
  end;
  TUIWindow = class(TOCGenericImport<UIWindowClass, UIWindow>)  end;

  UISplitViewControllerClass = interface(UIViewControllerClass)
    ['{A0AD8EC5-25E9-46F4-9FA0-CF78BF8EA5C7}']
  end;
  UISplitViewController = interface(UIViewController)
    ['{20EC4A04-B6DE-45A9-96E4-EAAAB5BAE28D}']
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setViewControllers(viewControllers: NSArray); cdecl;
    function viewControllers: NSArray; cdecl;
  end;
  TUISplitViewController = class(TOCGenericImport<UISplitViewControllerClass, UISplitViewController>)  end;

  UINavigationBarClass = interface(UIViewClass)
    ['{6BA964FE-C70D-4E0E-A53C-0C56E1A41084}']
  end;
  UINavigationBar = interface(UIView)
    ['{107EA22D-E942-41DF-8B38-EFD0E6E832A2}']
    function backItem: UINavigationItem; cdecl;
    function backgroundImageForBarMetrics(barMetrics: UIBarMetrics): UIImage; cdecl;
    function barStyle: UIBarStyle; cdecl;
    function delegate: Pointer; cdecl;
    function isTranslucent: Boolean; cdecl;
    function items: NSArray; cdecl;
    function popNavigationItemAnimated(animated: Boolean): UINavigationItem; cdecl;
    procedure pushNavigationItem(item: UINavigationItem; animated: Boolean); cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage; forBarMetrics: UIBarMetrics); cdecl;
    procedure setBarStyle(barStyle: UIBarStyle); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setItems(items: NSArray); cdecl; overload;
    procedure setItems(items: NSArray; animated: Boolean); cdecl; overload;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTitleTextAttributes(titleTextAttributes: NSDictionary); cdecl;
    procedure setTitleVerticalPositionAdjustment(adjustment: Single; forBarMetrics: UIBarMetrics); cdecl;
    procedure setTranslucent(translucent: Boolean); cdecl;
    function tintColor: UIColor; cdecl;
    function titleTextAttributes: NSDictionary; cdecl;
    function titleVerticalPositionAdjustmentForBarMetrics(barMetrics: UIBarMetrics): Single; cdecl;
    function topItem: UINavigationItem; cdecl;
  end;
  TUINavigationBar = class(TOCGenericImport<UINavigationBarClass, UINavigationBar>)  end;

  UILabelClass = interface(UIViewClass)
    ['{5E45EE6D-06A9-4392-9832-9570A05E2620}']
  end;
  UILabel = interface(UIView)
    ['{28363ECE-382C-4450-AEA0-D4E3A7D71CFD}']
    function adjustsFontSizeToFitWidth: Boolean; cdecl;
    function baselineAdjustment: UIBaselineAdjustment; cdecl;
    procedure drawTextInRect(rect: CGRect); cdecl;
    function font: UIFont; cdecl;
    function highlightedTextColor: UIColor; cdecl;
    function isEnabled: Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isUserInteractionEnabled: Boolean; cdecl;
    function lineBreakMode: UILineBreakMode; cdecl;
    function minimumFontSize: Single; cdecl;
    function numberOfLines: NSInteger; cdecl;
    procedure setAdjustsFontSizeToFitWidth(adjustsFontSizeToFitWidth: Boolean); cdecl;
    procedure setBaselineAdjustment(baselineAdjustment: UIBaselineAdjustment); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setHighlighted(highlighted: Boolean); cdecl;
    procedure setHighlightedTextColor(highlightedTextColor: UIColor); cdecl;
    procedure setLineBreakMode(lineBreakMode: UILineBreakMode); cdecl;
    procedure setMinimumFontSize(minimumFontSize: Single); cdecl;
    procedure setNumberOfLines(numberOfLines: NSInteger); cdecl;
    procedure setShadowColor(shadowColor: UIColor); cdecl;
    procedure setShadowOffset(shadowOffset: CGSize); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTextAlignment(textAlignment: UITextAlignment); cdecl;
    procedure setTextColor(textColor: UIColor); cdecl;
    procedure setUserInteractionEnabled(userInteractionEnabled: Boolean); cdecl;
    function shadowColor: UIColor; cdecl;
    function shadowOffset: CGSize; cdecl;
    function text: NSString; cdecl;
    function textAlignment: UITextAlignment; cdecl;
    function textColor: UIColor; cdecl;
    function textRectForBounds(bounds: CGRect; limitedToNumberOfLines: NSInteger): CGRect; cdecl;
  end;
  TUILabel = class(TOCGenericImport<UILabelClass, UILabel>)  end;

  UINavigationControllerClass = interface(UIViewControllerClass)
    ['{144258EB-46EF-4CE3-8399-26B585EE5D51}']
  end;
  UINavigationController = interface(UIViewController)
    ['{BC0A62FD-B83A-4313-AABC-797C7BD64366}']
    function delegate: Pointer; cdecl;
    function initWithRootViewController(rootViewController: UIViewController): Pointer; cdecl;
    function isNavigationBarHidden: Boolean; cdecl;
    function isToolbarHidden: Boolean; cdecl;
    function navigationBar: UINavigationBar; cdecl;
    function popToRootViewControllerAnimated(animated: Boolean): NSArray; cdecl;
    function popToViewController(viewController: UIViewController; animated: Boolean): NSArray; cdecl;
    function popViewControllerAnimated(animated: Boolean): UIViewController; cdecl;
    procedure pushViewController(viewController: UIViewController; animated: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setNavigationBarHidden(navigationBarHidden: Boolean); cdecl; overload;
    procedure setNavigationBarHidden(hidden: Boolean; animated: Boolean); cdecl; overload;
    procedure setToolbarHidden(toolbarHidden: Boolean); cdecl; overload;
    procedure setToolbarHidden(hidden: Boolean; animated: Boolean); cdecl; overload;
    procedure setViewControllers(viewControllers: NSArray); cdecl; overload;
    procedure setViewControllers(viewControllers: NSArray; animated: Boolean); cdecl; overload;
    function toolbar: UIToolbar; cdecl;
    function topViewController: UIViewController; cdecl;
    function viewControllers: NSArray; cdecl;
    function visibleViewController: UIViewController; cdecl;
  end;
  TUINavigationController = class(TOCGenericImport<UINavigationControllerClass, UINavigationController>)  end;

  UIPickerViewClass = interface(UIViewClass)
    ['{216F1E88-1CF4-470A-8AFB-45077FE5A750}']
  end;
  UIPickerView = interface(UIView)
    ['{1CBB77B4-19C1-4D9F-9164-4EFCA630CBA8}']
    function dataSource: Pointer; cdecl;
    function delegate: Pointer; cdecl;
    function numberOfComponents: NSInteger; cdecl;
    function numberOfRowsInComponent(component: NSInteger): NSInteger; cdecl;
    procedure reloadAllComponents; cdecl;
    procedure reloadComponent(component: NSInteger); cdecl;
    function rowSizeForComponent(component: NSInteger): CGSize; cdecl;
    procedure selectRow(row: NSInteger; inComponent: NSInteger; animated: Boolean); cdecl;
    function selectedRowInComponent(component: NSInteger): NSInteger; cdecl;
    procedure setDataSource(dataSource: Pointer); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setShowsSelectionIndicator(showsSelectionIndicator: Boolean); cdecl;
    function showsSelectionIndicator: Boolean; cdecl;
    function viewForRow(row: NSInteger; forComponent: NSInteger): UIView; cdecl;
  end;
  TUIPickerView = class(TOCGenericImport<UIPickerViewClass, UIPickerView>)  end;

  UIPageViewControllerClass = interface(UIViewControllerClass)
    ['{02715341-10EC-43AA-8980-06D16913D9A0}']
  end;
  UIPageViewController = interface(UIViewController)
    ['{BD8F4370-A8C4-4B5D-9001-CCAB87C3E446}']
    function dataSource: Pointer; cdecl;
    function delegate: Pointer; cdecl;
    function gestureRecognizers: NSArray; cdecl;
    function initWithTransitionStyle(style: UIPageViewControllerTransitionStyle; navigationOrientation: UIPageViewControllerNavigationOrientation; options: NSDictionary): Pointer; cdecl;
    function isDoubleSided: Boolean; cdecl;
    function navigationOrientation: UIPageViewControllerNavigationOrientation; cdecl;
    procedure setDataSource(dataSource: Pointer); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDoubleSided(doubleSided: Boolean); cdecl;
    function spineLocation: UIPageViewControllerSpineLocation; cdecl;
    function transitionStyle: UIPageViewControllerTransitionStyle; cdecl;
    function viewControllers: NSArray; cdecl;
  end;
  TUIPageViewController = class(TOCGenericImport<UIPageViewControllerClass, UIPageViewController>)  end;

  UIActivityIndicatorViewClass = interface(UIViewClass)
    ['{653F48F6-391E-4456-8BEA-619D3DABF160}']
  end;
  UIActivityIndicatorView = interface(UIView)
    ['{740BF207-534C-49E0-ACC7-842794A03DF8}']
    function activityIndicatorViewStyle: UIActivityIndicatorViewStyle; cdecl;
    function color: UIColor; cdecl;
    function hidesWhenStopped: Boolean; cdecl;
    function initWithActivityIndicatorStyle(style: UIActivityIndicatorViewStyle): Pointer; cdecl;
    function isAnimating: Boolean; cdecl;
    procedure setActivityIndicatorViewStyle(activityIndicatorViewStyle: UIActivityIndicatorViewStyle); cdecl;
    procedure setColor(color: UIColor); cdecl;
    procedure setHidesWhenStopped(hidesWhenStopped: Boolean); cdecl;
    procedure startAnimating; cdecl;
    procedure stopAnimating; cdecl;
  end;
  TUIActivityIndicatorView = class(TOCGenericImport<UIActivityIndicatorViewClass, UIActivityIndicatorView>)  end;

  UIActionSheetClass = interface(UIViewClass)
    ['{97C3C5FB-0D28-4DAB-B06C-41BF18F1667C}']
  end;
  UIActionSheet = interface(UIView)
    ['{C59B1FB7-4258-4158-B4AE-24D5915FF901}']
    function actionSheetStyle: UIActionSheetStyle; cdecl;
    function addButtonWithTitle(title: NSString): NSInteger; cdecl;
    function buttonTitleAtIndex(buttonIndex: NSInteger): NSString; cdecl;
    function cancelButtonIndex: NSInteger; cdecl;
    function delegate: Pointer; cdecl;
    function destructiveButtonIndex: NSInteger; cdecl;
    procedure dismissWithClickedButtonIndex(buttonIndex: NSInteger; animated: Boolean); cdecl;
    function firstOtherButtonIndex: NSInteger; cdecl;
    function initWithTitle(title: NSString; delegate: Pointer; cancelButtonTitle: NSString; destructiveButtonTitle: NSString; otherButtonTitles: NSString): Pointer; cdecl;
    function isVisible: Boolean; cdecl;
    function numberOfButtons: NSInteger; cdecl;
    procedure setActionSheetStyle(actionSheetStyle: UIActionSheetStyle); cdecl;
    procedure setCancelButtonIndex(cancelButtonIndex: NSInteger); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDestructiveButtonIndex(destructiveButtonIndex: NSInteger); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure showFromBarButtonItem(item: UIBarButtonItem; animated: Boolean); cdecl;
    procedure showFromRect(rect: CGRect; inView: UIView; animated: Boolean); cdecl;
    procedure showFromTabBar(view: UITabBar); cdecl;
    procedure showFromToolbar(view: UIToolbar); cdecl;
    procedure showInView(view: UIView); cdecl;
    function title: NSString; cdecl;
  end;
  TUIActionSheet = class(TOCGenericImport<UIActionSheetClass, UIActionSheet>)  end;

  UIActivityViewControllerClass = interface(UIViewControllerClass)
    ['{B1BB6463-CC09-487B-9340-607FD6D0863B}']
  end;
  UIActivityViewController = interface(UIViewController)
    ['{68BE3AE8-E14B-4086-B066-F90C5C527E32}']
    function initWithActivityItems(activityItems: NSArray; applicationActivities: NSArray): Pointer; cdecl;
    function completionHandler: UIActivityViewControllerCompletionHandler; cdecl;
    procedure setCompletionHandler(completionHandler: UIActivityViewControllerCompletionHandler); cdecl;
  end;
  TUIActivityViewController = class(TOCGenericImport<UIActivityViewControllerClass, UIActivityViewController>)  end;

  UIAlertViewClass = interface(UIViewClass)
    ['{9B52F0F9-605B-46B0-A237-F309ECB3E7E7}']
  end;
  UIAlertView = interface(UIView)
    ['{733868C3-9497-4A2E-8BE6-2A764EE2EFFD}']
    function addButtonWithTitle(title: NSString): NSInteger; cdecl;
    function alertViewStyle: UIAlertViewStyle; cdecl;
    function buttonTitleAtIndex(buttonIndex: NSInteger): NSString; cdecl;
    function cancelButtonIndex: NSInteger; cdecl;
    function delegate: Pointer; cdecl;
    procedure dismissWithClickedButtonIndex(buttonIndex: NSInteger; animated: Boolean); cdecl;
    function firstOtherButtonIndex: NSInteger; cdecl;
    function initWithTitle(title: NSString; message: NSString; delegate: Pointer; cancelButtonTitle: NSString; otherButtonTitles: NSString): Pointer; cdecl;
    function isVisible: Boolean; cdecl;
    function message: NSString; cdecl;
    function numberOfButtons: NSInteger; cdecl;
    procedure setAlertViewStyle(alertViewStyle: UIAlertViewStyle); cdecl;
    procedure setCancelButtonIndex(cancelButtonIndex: NSInteger); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMessage(message: NSString); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure show; cdecl;
    function textFieldAtIndex(textFieldIndex: NSInteger): Pointer; cdecl;
    function title: NSString; cdecl;
  end;
  TUIAlertView = class(TOCGenericImport<UIAlertViewClass, UIAlertView>)  end;

  UIImageViewClass = interface(UIViewClass)
    ['{8AC2E4BA-C422-4312-AAB8-BAEE2F78D837}']
  end;
  UIImageView = interface(UIView)
    ['{3C37E7BA-5B35-4AB5-B48B-B308F45EE3C2}']
    function animationDuration: NSTimeInterval; cdecl;
    function animationImages: NSArray; cdecl;
    function animationRepeatCount: NSInteger; cdecl;
    function highlightedAnimationImages: NSArray; cdecl;
    function highlightedImage: UIImage; cdecl;
    function image: UIImage; cdecl;
    function initWithImage(image: UIImage): Pointer; cdecl; overload;
    function initWithImage(image: UIImage; highlightedImage: UIImage): Pointer; cdecl; overload;
    function isAnimating: Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isUserInteractionEnabled: Boolean; cdecl;
    procedure setAnimationDuration(animationDuration: NSTimeInterval); cdecl;
    procedure setAnimationImages(animationImages: NSArray); cdecl;
    procedure setAnimationRepeatCount(animationRepeatCount: NSInteger); cdecl;
    procedure setHighlighted(highlighted: Boolean); cdecl;
    procedure setHighlightedAnimationImages(highlightedAnimationImages: NSArray); cdecl;
    procedure setHighlightedImage(highlightedImage: UIImage); cdecl;
    procedure setImage(image: UIImage); cdecl;
    procedure setUserInteractionEnabled(userInteractionEnabled: Boolean); cdecl;
    procedure startAnimating; cdecl;
    procedure stopAnimating; cdecl;
  end;
  TUIImageView = class(TOCGenericImport<UIImageViewClass, UIImageView>)  end;

  UIControlClass = interface(UIViewClass)
    ['{D6494AFD-75F0-4E86-BD61-A28EF623EFE9}']
  end;
  UIControl = interface(UIView)
    ['{3577D075-1A6B-4614-A590-F4ACB559BDF3}']
    function actionsForTarget(target: Pointer; forControlEvent: UIControlEvents): NSArray; cdecl;
    procedure addTarget(target: Pointer; action: SEL; forControlEvents: UIControlEvents); cdecl;
    function allControlEvents: UIControlEvents; cdecl;
    function allTargets: NSSet; cdecl;
    function beginTrackingWithTouch(touch: UITouch; withEvent: UIEvent): Boolean; cdecl;
    procedure cancelTrackingWithEvent(event: UIEvent); cdecl;
    function contentHorizontalAlignment: UIControlContentHorizontalAlignment; cdecl;
    function contentVerticalAlignment: UIControlContentVerticalAlignment; cdecl;
    function continueTrackingWithTouch(touch: UITouch; withEvent: UIEvent): Boolean; cdecl;
    procedure endTrackingWithTouch(touch: UITouch; withEvent: UIEvent); cdecl;
    function isEnabled: Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isSelected: Boolean; cdecl;
    function isTouchInside: Boolean; cdecl;
    function isTracking: Boolean; cdecl;
    procedure removeTarget(target: Pointer; action: SEL; forControlEvents: UIControlEvents); cdecl;
    procedure sendActionsForControlEvents(controlEvents: UIControlEvents); cdecl;
    procedure setContentHorizontalAlignment(contentHorizontalAlignment: UIControlContentHorizontalAlignment); cdecl;
    procedure setContentVerticalAlignment(contentVerticalAlignment: UIControlContentVerticalAlignment); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setHighlighted(highlighted: Boolean); cdecl;
    procedure setSelected(selected: Boolean); cdecl;
    function state: UIControlState; cdecl;
  end;
  TUIControl = class(TOCGenericImport<UIControlClass, UIControl>)  end;

  UIProgressViewClass = interface(UIViewClass)
    ['{77B96B73-6425-4D5D-B318-77EB1A22F8B9}']
  end;
  UIProgressView = interface(UIView)
    ['{6106703C-52EE-46CE-A99F-1F3CDE1E5906}']
    function initWithProgressViewStyle(style: UIProgressViewStyle): Pointer; cdecl;
    function progress: Single; cdecl;
    function progressImage: UIImage; cdecl;
    function progressTintColor: UIColor; cdecl;
    function progressViewStyle: UIProgressViewStyle; cdecl;
    procedure setProgress(progress: Single); cdecl; overload;
    procedure setProgress(progress: Single; animated: Boolean); cdecl; overload;
    procedure setProgressImage(progressImage: UIImage); cdecl;
    procedure setProgressTintColor(progressTintColor: UIColor); cdecl;
    procedure setProgressViewStyle(progressViewStyle: UIProgressViewStyle); cdecl;
    procedure setTrackImage(trackImage: UIImage); cdecl;
    procedure setTrackTintColor(trackTintColor: UIColor); cdecl;
    function trackImage: UIImage; cdecl;
    function trackTintColor: UIColor; cdecl;
  end;
  TUIProgressView = class(TOCGenericImport<UIProgressViewClass, UIProgressView>)  end;

  UIScrollViewClass = interface(UIViewClass)
    ['{9580E8CE-CF16-4AA4-A3AC-57E4BA6E7A30}']
  end;
  UIScrollView = interface(UIView)
    ['{AC832A34-44A4-4269-8C3C-47F9F08BC243}']
    function alwaysBounceHorizontal: Boolean; cdecl;
    function alwaysBounceVertical: Boolean; cdecl;
    function bounces: Boolean; cdecl;
    function bouncesZoom: Boolean; cdecl;
    function canCancelContentTouches: Boolean; cdecl;
    function contentInset: UIEdgeInsets; cdecl;
    function contentOffset: CGPoint; cdecl;
    function contentSize: CGSize; cdecl;
    function decelerationRate: Single; cdecl;
    function delaysContentTouches: Boolean; cdecl;
    function delegate: Pointer; cdecl;
    procedure flashScrollIndicators; cdecl;
    function indicatorStyle: UIScrollViewIndicatorStyle; cdecl;
    function isDecelerating: Boolean; cdecl;
    function isDirectionalLockEnabled: Boolean; cdecl;
    function isDragging: Boolean; cdecl;
    function isPagingEnabled: Boolean; cdecl;
    function isScrollEnabled: Boolean; cdecl;
    function isTracking: Boolean; cdecl;
    function isZoomBouncing: Boolean; cdecl;
    function isZooming: Boolean; cdecl;
    function maximumZoomScale: Single; cdecl;
    function minimumZoomScale: Single; cdecl;
    function panGestureRecognizer: UIPanGestureRecognizer; cdecl;
    function pinchGestureRecognizer: UIPinchGestureRecognizer; cdecl;
    function scrollIndicatorInsets: UIEdgeInsets; cdecl;
    procedure scrollRectToVisible(rect: CGRect; animated: Boolean); cdecl;
    function scrollsToTop: Boolean; cdecl;
    procedure setAlwaysBounceHorizontal(alwaysBounceHorizontal: Boolean); cdecl;
    procedure setAlwaysBounceVertical(alwaysBounceVertical: Boolean); cdecl;
    procedure setBounces(bounces: Boolean); cdecl;
    procedure setBouncesZoom(bouncesZoom: Boolean); cdecl;
    procedure setCanCancelContentTouches(canCancelContentTouches: Boolean); cdecl;
    procedure setContentInset(contentInset: UIEdgeInsets); cdecl;
    procedure setContentOffset(contentOffset: CGPoint); cdecl; overload;
    procedure setContentOffset(contentOffset: CGPoint; animated: Boolean); cdecl; overload;
    procedure setContentSize(contentSize: CGSize); cdecl;
    procedure setDecelerationRate(decelerationRate: Single); cdecl;
    procedure setDelaysContentTouches(delaysContentTouches: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDirectionalLockEnabled(directionalLockEnabled: Boolean); cdecl;
    procedure setIndicatorStyle(indicatorStyle: UIScrollViewIndicatorStyle); cdecl;
    procedure setMaximumZoomScale(maximumZoomScale: Single); cdecl;
    procedure setMinimumZoomScale(minimumZoomScale: Single); cdecl;
    procedure setPagingEnabled(pagingEnabled: Boolean); cdecl;
    procedure setScrollEnabled(scrollEnabled: Boolean); cdecl;
    procedure setScrollIndicatorInsets(scrollIndicatorInsets: UIEdgeInsets); cdecl;
    procedure setScrollsToTop(scrollsToTop: Boolean); cdecl;
    procedure setShowsHorizontalScrollIndicator(showsHorizontalScrollIndicator: Boolean); cdecl;
    procedure setShowsVerticalScrollIndicator(showsVerticalScrollIndicator: Boolean); cdecl;
    procedure setZoomScale(zoomScale: Single); cdecl; overload;
    procedure setZoomScale(scale: Single; animated: Boolean); cdecl; overload;
    function showsHorizontalScrollIndicator: Boolean; cdecl;
    function showsVerticalScrollIndicator: Boolean; cdecl;
    function touchesShouldBegin(touches: NSSet; withEvent: UIEvent; inContentView: UIView): Boolean; cdecl;
    function touchesShouldCancelInContentView(view: UIView): Boolean; cdecl;
    function zoomScale: Single; cdecl;
    procedure zoomToRect(rect: CGRect; animated: Boolean); cdecl;
  end;
  TUIScrollView = class(TOCGenericImport<UIScrollViewClass, UIScrollView>)  end;

  UIReferenceLibraryViewControllerClass = interface(UIViewControllerClass)
    ['{7BBEFE7F-28B1-4240-AC66-6AE2492E8B44}']
    {class} function dictionaryHasDefinitionForTerm(term: NSString): Boolean; cdecl;
  end;
  UIReferenceLibraryViewController = interface(UIViewController)
    ['{0FCD276F-73FF-4182-92A3-85525608FA41}']
    function initWithTerm(term: NSString): Pointer; cdecl;
  end;
  TUIReferenceLibraryViewController = class(TOCGenericImport<UIReferenceLibraryViewControllerClass, UIReferenceLibraryViewController>)  end;

  UIPopoverBackgroundViewClass = interface(UIViewClass)
    ['{AFE7DCBF-E3C2-4F71-B5B7-2226161B21B6}']
    {class} function arrowBase: Single; cdecl;
    {class} function arrowHeight: Single; cdecl;
    {class} function contentViewInsets: UIEdgeInsets; cdecl;
  end;
  UIPopoverBackgroundView = interface(UIView)
    ['{8D894AFF-0033-476E-A2ED-74102DF91BBB}']
    function arrowDirection: UIPopoverArrowDirection; cdecl;
    function arrowOffset: Single; cdecl;
    procedure setArrowDirection(arrowDirection: UIPopoverArrowDirection); cdecl;
    procedure setArrowOffset(arrowOffset: Single); cdecl;
  end;
  TUIPopoverBackgroundView = class(TOCGenericImport<UIPopoverBackgroundViewClass, UIPopoverBackgroundView>)  end;

  UISearchBarClass = interface(UIViewClass)
    ['{E1BF33AF-6961-436C-BD4B-0E510228697D}']
  end;
  UISearchBar = interface(UIView)
    ['{62830DEE-15CB-4560-858F-30E62B885A90}']
    function autocapitalizationType: UITextAutocapitalizationType; cdecl;
    function autocorrectionType: UITextAutocorrectionType; cdecl;
    function backgroundImage: UIImage; cdecl;
    function barStyle: UIBarStyle; cdecl;
    function delegate: Pointer; cdecl;
    function imageForSearchBarIcon(icon: UISearchBarIcon; state: UIControlState): UIImage; cdecl;
    function isSearchResultsButtonSelected: Boolean; cdecl;
    function isTranslucent: Boolean; cdecl;
    function keyboardType: UIKeyboardType; cdecl;
    function placeholder: NSString; cdecl;
    function positionAdjustmentForSearchBarIcon(icon: UISearchBarIcon): UIOffset; cdecl;
    function prompt: NSString; cdecl;
    function scopeBarBackgroundImage: UIImage; cdecl;
    function scopeBarButtonBackgroundImageForState(state: UIControlState): UIImage; cdecl;
    function scopeBarButtonDividerImageForLeftSegmentState(leftState: UIControlState; rightSegmentState: UIControlState): UIImage; cdecl;
    function scopeBarButtonTitleTextAttributesForState(state: UIControlState): NSDictionary; cdecl;
    function scopeButtonTitles: NSArray; cdecl;
    function searchFieldBackgroundImageForState(state: UIControlState): UIImage; cdecl;
    function searchFieldBackgroundPositionAdjustment: UIOffset; cdecl;
    function searchTextPositionAdjustment: UIOffset; cdecl;
    function selectedScopeButtonIndex: NSInteger; cdecl;
    procedure setAutocapitalizationType(autocapitalizationType: UITextAutocapitalizationType); cdecl;
    procedure setAutocorrectionType(autocorrectionType: UITextAutocorrectionType); cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage); cdecl;
    procedure setBarStyle(barStyle: UIBarStyle); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setImage(iconImage: UIImage; forSearchBarIcon: UISearchBarIcon; state: UIControlState); cdecl;
    procedure setKeyboardType(keyboardType: UIKeyboardType); cdecl;
    procedure setPlaceholder(placeholder: NSString); cdecl;
    procedure setPositionAdjustment(adjustment: UIOffset; forSearchBarIcon: UISearchBarIcon); cdecl;
    procedure setPrompt(prompt: NSString); cdecl;
    procedure setScopeBarBackgroundImage(scopeBarBackgroundImage: UIImage); cdecl;
    procedure setScopeBarButtonBackgroundImage(backgroundImage: UIImage; forState: UIControlState); cdecl;
    procedure setScopeBarButtonDividerImage(dividerImage: UIImage; forLeftSegmentState: UIControlState; rightSegmentState: UIControlState); cdecl;
    procedure setScopeBarButtonTitleTextAttributes(attributes: NSDictionary; forState: UIControlState); cdecl;
    procedure setScopeButtonTitles(scopeButtonTitles: NSArray); cdecl;
    procedure setSearchFieldBackgroundImage(backgroundImage: UIImage; forState: UIControlState); cdecl;
    procedure setSearchFieldBackgroundPositionAdjustment(searchFieldBackgroundPositionAdjustment: UIOffset); cdecl;
    procedure setSearchResultsButtonSelected(searchResultsButtonSelected: Boolean); cdecl;
    procedure setSearchTextPositionAdjustment(searchTextPositionAdjustment: UIOffset); cdecl;
    procedure setSelectedScopeButtonIndex(selectedScopeButtonIndex: NSInteger); cdecl;
    procedure setShowsBookmarkButton(showsBookmarkButton: Boolean); cdecl;
    procedure setShowsCancelButton(showsCancelButton: Boolean); cdecl; overload;
    procedure setShowsCancelButton(showsCancelButton: Boolean; animated: Boolean); cdecl; overload;
    procedure setShowsScopeBar(showsScopeBar: Boolean); cdecl;
    procedure setShowsSearchResultsButton(showsSearchResultsButton: Boolean); cdecl;
    procedure setSpellCheckingType(spellCheckingType: Integer); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTranslucent(translucent: Boolean); cdecl;
    function showsBookmarkButton: Boolean; cdecl;
    function showsCancelButton: Boolean; cdecl;
    function showsScopeBar: Boolean; cdecl;
    function showsSearchResultsButton: Boolean; cdecl;
    function spellCheckingType: Integer; cdecl;
    function text: NSString; cdecl;
    function tintColor: UIColor; cdecl;
  end;
  TUISearchBar = class(TOCGenericImport<UISearchBarClass, UISearchBar>)  end;

  UIVideoEditorControllerClass = interface(UINavigationControllerClass)
    ['{8C745044-2178-423C-9799-8933FFC7526B}']
    {class} function canEditVideoAtPath(videoPath: NSString): Boolean; cdecl;
  end;
  UIVideoEditorController = interface(UINavigationController)
    ['{6098EB7F-17EF-4E74-84AC-5434AAB6CE1F}']
    function delegate: Pointer; cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setVideoMaximumDuration(videoMaximumDuration: NSTimeInterval); cdecl;
    procedure setVideoPath(videoPath: NSString); cdecl;
    procedure setVideoQuality(videoQuality: UIImagePickerControllerQualityType); cdecl;
    function videoMaximumDuration: NSTimeInterval; cdecl;
    function videoPath: NSString; cdecl;
    function videoQuality: UIImagePickerControllerQualityType; cdecl;
  end;
  TUIVideoEditorController = class(TOCGenericImport<UIVideoEditorControllerClass, UIVideoEditorController>)  end;

  UIButtonClass = interface(UIControlClass)
    ['{183E87F4-3D08-43E6-911A-219EE6D46166}']
    {class} function buttonWithType(buttonType: UIButtonType): Pointer; cdecl;
  end;
  UIButton = interface(UIControl)
    ['{73F43D61-2EAC-4902-834E-11BBC2B84102}']
    function adjustsImageWhenDisabled: Boolean; cdecl;
    function adjustsImageWhenHighlighted: Boolean; cdecl;
    function backgroundImageForState(state: UIControlState): UIImage; cdecl;
    function backgroundRectForBounds(bounds: CGRect): CGRect; cdecl;
    function buttonType: UIButtonType; cdecl;
    function contentEdgeInsets: UIEdgeInsets; cdecl;
    function contentRectForBounds(bounds: CGRect): CGRect; cdecl;
    function currentBackgroundImage: UIImage; cdecl;
    function currentImage: UIImage; cdecl;
    function currentTitle: NSString; cdecl;
    function currentTitleColor: UIColor; cdecl;
    function currentTitleShadowColor: UIColor; cdecl;
    function font: UIFont; cdecl;
    function imageEdgeInsets: UIEdgeInsets; cdecl;
    function imageForState(state: UIControlState): UIImage; cdecl;
    function imageRectForContentRect(contentRect: CGRect): CGRect; cdecl;
    function imageView: UIImageView; cdecl;
    function lineBreakMode: UILineBreakMode; cdecl;
    function reversesTitleShadowWhenHighlighted: Boolean; cdecl;
    procedure setAdjustsImageWhenDisabled(adjustsImageWhenDisabled: Boolean); cdecl;
    procedure setAdjustsImageWhenHighlighted(adjustsImageWhenHighlighted: Boolean); cdecl;
    procedure setBackgroundImage(image: UIImage; forState: UIControlState); cdecl;
    procedure setContentEdgeInsets(contentEdgeInsets: UIEdgeInsets); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setImage(image: UIImage; forState: UIControlState); cdecl;
    procedure setImageEdgeInsets(imageEdgeInsets: UIEdgeInsets); cdecl;
    procedure setLineBreakMode(lineBreakMode: UILineBreakMode); cdecl;
    procedure setReversesTitleShadowWhenHighlighted(reversesTitleShadowWhenHighlighted: Boolean); cdecl;
    procedure setShowsTouchWhenHighlighted(showsTouchWhenHighlighted: Boolean); cdecl;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTitle(title: NSString; forState: UIControlState); cdecl;
    procedure setTitleColor(color: UIColor; forState: UIControlState); cdecl;
    procedure setTitleEdgeInsets(titleEdgeInsets: UIEdgeInsets); cdecl;
    procedure setTitleShadowColor(color: UIColor; forState: UIControlState); cdecl;
    procedure setTitleShadowOffset(titleShadowOffset: CGSize); cdecl;
    function showsTouchWhenHighlighted: Boolean; cdecl;
    function tintColor: UIColor; cdecl;
    function titleColorForState(state: UIControlState): UIColor; cdecl;
    function titleEdgeInsets: UIEdgeInsets; cdecl;
    function titleForState(state: UIControlState): NSString; cdecl;
    function titleLabel: UILabel; cdecl;
    function titleRectForContentRect(contentRect: CGRect): CGRect; cdecl;
    function titleShadowColorForState(state: UIControlState): UIColor; cdecl;
    function titleShadowOffset: CGSize; cdecl;
  end;
  TUIButton = class(TOCGenericImport<UIButtonClass, UIButton>)  end;

  UIStepperClass = interface(UIControlClass)
    ['{98CFAF41-6DE2-458A-AD1C-3159198C8ABF}']
  end;
  UIStepper = interface(UIControl)
    ['{C6CE3399-B896-4E50-8663-61637BFD791D}']
    function autorepeat: Boolean; cdecl;
    function isContinuous: Boolean; cdecl;
    function maximumValue: double; cdecl;
    function minimumValue: double; cdecl;
    procedure setAutorepeat(autorepeat: Boolean); cdecl;
    procedure setContinuous(continuous: Boolean); cdecl;
    procedure setMaximumValue(maximumValue: double); cdecl;
    procedure setMinimumValue(minimumValue: double); cdecl;
    procedure setStepValue(stepValue: double); cdecl;
    procedure setValue(value: double); cdecl;
    procedure setWraps(wraps: Boolean); cdecl;
    function stepValue: double; cdecl;
    function value: double; cdecl;
    function wraps: Boolean; cdecl;
  end;
  TUIStepper = class(TOCGenericImport<UIStepperClass, UIStepper>)  end;

  UISliderClass = interface(UIControlClass)
    ['{8F6BB419-10A7-4B89-88D8-A9CD27D427FE}']
  end;
  UISlider = interface(UIControl)
    ['{50F62B14-EA25-41F4-BCC8-00587E789C15}']
    function currentMaximumTrackImage: UIImage; cdecl;
    function currentMinimumTrackImage: UIImage; cdecl;
    function currentThumbImage: UIImage; cdecl;
    function isContinuous: Boolean; cdecl;
    function maximumTrackImageForState(state: UIControlState): UIImage; cdecl;
    function maximumTrackTintColor: UIColor; cdecl;
    function maximumValue: Single; cdecl;
    function maximumValueImage: UIImage; cdecl;
    function maximumValueImageRectForBounds(bounds: CGRect): CGRect; cdecl;
    function minimumTrackImageForState(state: UIControlState): UIImage; cdecl;
    function minimumTrackTintColor: UIColor; cdecl;
    function minimumValue: Single; cdecl;
    function minimumValueImage: UIImage; cdecl;
    function minimumValueImageRectForBounds(bounds: CGRect): CGRect; cdecl;
    procedure setContinuous(continuous: Boolean); cdecl;
    procedure setMaximumTrackImage(image: UIImage; forState: UIControlState); cdecl;
    procedure setMaximumTrackTintColor(maximumTrackTintColor: UIColor); cdecl;
    procedure setMaximumValue(maximumValue: Single); cdecl;
    procedure setMaximumValueImage(maximumValueImage: UIImage); cdecl;
    procedure setMinimumTrackImage(image: UIImage; forState: UIControlState); cdecl;
    procedure setMinimumTrackTintColor(minimumTrackTintColor: UIColor); cdecl;
    procedure setMinimumValue(minimumValue: Single); cdecl;
    procedure setMinimumValueImage(minimumValueImage: UIImage); cdecl;
    procedure setThumbImage(image: UIImage; forState: UIControlState); cdecl;
    procedure setThumbTintColor(thumbTintColor: UIColor); cdecl;
    procedure setValue(value: Single); cdecl; overload;
    procedure setValue(value: Single; animated: Boolean); cdecl; overload;
    function thumbImageForState(state: UIControlState): UIImage; cdecl;
    function thumbRectForBounds(bounds: CGRect; trackRect: CGRect; value: Single): CGRect; cdecl;
    function thumbTintColor: UIColor; cdecl;
    function trackRectForBounds(bounds: CGRect): CGRect; cdecl;
    function value: Single; cdecl;
  end;
  TUISlider = class(TOCGenericImport<UISliderClass, UISlider>)  end;

  UISegmentedControlClass = interface(UIControlClass)
    ['{60EAB276-F080-4A4B-85CF-3877FADB5459}']
  end;
  UISegmentedControl = interface(UIControl)
    ['{F8025182-9CC0-45A4-BF23-92D349F14062}']
    function apportionsSegmentWidthsByContent: Boolean; cdecl;
    function backgroundImageForState(state: UIControlState; barMetrics: UIBarMetrics): UIImage; cdecl;
    function contentOffsetForSegmentAtIndex(segment: NSUInteger): CGSize; cdecl;
    function contentPositionAdjustmentForSegmentType(leftCenterRightOrAlone: UISegmentedControlSegment; barMetrics: UIBarMetrics): UIOffset; cdecl;
    function dividerImageForLeftSegmentState(leftState: UIControlState; rightSegmentState: UIControlState; barMetrics: UIBarMetrics): UIImage; cdecl;
    function imageForSegmentAtIndex(segment: NSUInteger): UIImage; cdecl;
    function initWithItems(items: NSArray): Pointer; cdecl;
    procedure insertSegmentWithImage(image: UIImage; atIndex: NSUInteger; animated: Boolean); cdecl;
    procedure insertSegmentWithTitle(title: NSString; atIndex: NSUInteger; animated: Boolean); cdecl;
    function isEnabledForSegmentAtIndex(segment: NSUInteger): Boolean; cdecl;
    function isMomentary: Boolean; cdecl;
    function numberOfSegments: NSUInteger; cdecl;
    procedure removeAllSegments; cdecl;
    procedure removeSegmentAtIndex(segment: NSUInteger; animated: Boolean); cdecl;
    function segmentedControlStyle: UISegmentedControlStyle; cdecl;
    function selectedSegmentIndex: NSInteger; cdecl;
    procedure setApportionsSegmentWidthsByContent(apportionsSegmentWidthsByContent: Boolean); cdecl;
    procedure setBackgroundImage(backgroundImage: UIImage; forState: UIControlState; barMetrics: UIBarMetrics); cdecl;
    procedure setContentOffset(offset: CGSize; forSegmentAtIndex: NSUInteger); cdecl;
    procedure setContentPositionAdjustment(adjustment: UIOffset; forSegmentType: UISegmentedControlSegment; barMetrics: UIBarMetrics); cdecl;
    procedure setDividerImage(dividerImage: UIImage; forLeftSegmentState: UIControlState; rightSegmentState: UIControlState; barMetrics: UIBarMetrics); cdecl;
    procedure setEnabled(enabled: Boolean; forSegmentAtIndex: NSUInteger); cdecl;
    procedure setImage(image: UIImage; forSegmentAtIndex: NSUInteger); cdecl;
    procedure setMomentary(momentary: Boolean); cdecl;
    procedure setSegmentedControlStyle(segmentedControlStyle: UISegmentedControlStyle); cdecl;
    procedure setSelectedSegmentIndex(selectedSegmentIndex: NSInteger); cdecl;
    procedure setTintColor(tintColor: UIColor); cdecl;
    procedure setTitle(title: NSString; forSegmentAtIndex: NSUInteger); cdecl;
    procedure setTitleTextAttributes(attributes: NSDictionary; forState: UIControlState); cdecl;
    procedure setWidth(width: Single; forSegmentAtIndex: NSUInteger); cdecl;
    function tintColor: UIColor; cdecl;
    function titleForSegmentAtIndex(segment: NSUInteger): NSString; cdecl;
    function titleTextAttributesForState(state: UIControlState): NSDictionary; cdecl;
    function widthForSegmentAtIndex(segment: NSUInteger): Single; cdecl;
  end;
  TUISegmentedControl = class(TOCGenericImport<UISegmentedControlClass, UISegmentedControl>)  end;

  UIDatePickerClass = interface(UIControlClass)
    ['{FC89C5F2-AEFA-4D4E-AFEC-483F443A167B}']
  end;
  UIDatePicker = interface(UIControl)
    ['{58D30B69-5CB3-4CB1-ABDB-CAC1783256FA}']
    function calendar: NSCalendar; cdecl;
    function countDownDuration: NSTimeInterval; cdecl;
    function date: NSDate; cdecl;
    function datePickerMode: UIDatePickerMode; cdecl;
    function locale: NSLocale; cdecl;
    function maximumDate: NSDate; cdecl;
    function minimumDate: NSDate; cdecl;
    function minuteInterval: NSInteger; cdecl;
    procedure setCalendar(calendar: NSCalendar); cdecl;
    procedure setCountDownDuration(countDownDuration: NSTimeInterval); cdecl;
    procedure setDate(date: NSDate); cdecl; overload;
    procedure setDate(date: NSDate; animated: Boolean); cdecl; overload;
    procedure setDatePickerMode(datePickerMode: UIDatePickerMode); cdecl;
    procedure setLocale(locale: NSLocale); cdecl;
    procedure setMaximumDate(maximumDate: NSDate); cdecl;
    procedure setMinimumDate(minimumDate: NSDate); cdecl;
    procedure setMinuteInterval(minuteInterval: NSInteger); cdecl;
    procedure setTimeZone(timeZone: NSTimeZone); cdecl;
    function timeZone: NSTimeZone; cdecl;
  end;
  TUIDatePicker = class(TOCGenericImport<UIDatePickerClass, UIDatePicker>)  end;

  UITextFieldClass = interface(UIControlClass)
    ['{EF7B089F-A484-44E2-85A1-B0BAFCB31DAC}']
  end;
  UITextField = interface(UIControl)
    ['{1BCFFC8A-8744-4A3F-A441-DB7B2124AB52}']
    function adjustsFontSizeToFitWidth: Boolean; cdecl;
    function background: UIImage; cdecl;
    function borderRectForBounds(bounds: CGRect): CGRect; cdecl;
    function borderStyle: UITextBorderStyle; cdecl;
    function clearButtonMode: UITextFieldViewMode; cdecl;
    function clearButtonRectForBounds(bounds: CGRect): CGRect; cdecl;
    function clearsOnBeginEditing: Boolean; cdecl;
    function delegate: Pointer; cdecl;
    function disabledBackground: UIImage; cdecl;
    procedure drawPlaceholderInRect(rect: CGRect); cdecl;
    procedure drawTextInRect(rect: CGRect); cdecl;
    function editingRectForBounds(bounds: CGRect): CGRect; cdecl;
    function font: UIFont; cdecl;
    function inputAccessoryView: UIView; cdecl;
    function inputView: UIView; cdecl;
    function isEditing: Boolean; cdecl;
    function leftView: UIView; cdecl;
    function leftViewMode: UITextFieldViewMode; cdecl;
    function leftViewRectForBounds(bounds: CGRect): CGRect; cdecl;
    function minimumFontSize: Single; cdecl;
    function placeholder: NSString; cdecl;
    function placeholderRectForBounds(bounds: CGRect): CGRect; cdecl;
    function rightView: UIView; cdecl;
    function rightViewMode: UITextFieldViewMode; cdecl;
    function rightViewRectForBounds(bounds: CGRect): CGRect; cdecl;
    procedure setAdjustsFontSizeToFitWidth(adjustsFontSizeToFitWidth: Boolean); cdecl;
    procedure setBackground(background: UIImage); cdecl;
    procedure setBorderStyle(borderStyle: UITextBorderStyle); cdecl;
    procedure setClearButtonMode(clearButtonMode: UITextFieldViewMode); cdecl;
    procedure setClearsOnBeginEditing(clearsOnBeginEditing: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDisabledBackground(disabledBackground: UIImage); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setInputAccessoryView(inputAccessoryView: UIView); cdecl;
    procedure setInputView(inputView: UIView); cdecl;
    procedure setLeftView(leftView: UIView); cdecl;
    procedure setLeftViewMode(leftViewMode: UITextFieldViewMode); cdecl;
    procedure setMinimumFontSize(minimumFontSize: Single); cdecl;
    procedure setPlaceholder(placeholder: NSString); cdecl;
    procedure setRightView(rightView: UIView); cdecl;
    procedure setRightViewMode(rightViewMode: UITextFieldViewMode); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTextAlignment(textAlignment: UITextAlignment); cdecl;
    procedure setTextColor(textColor: UIColor); cdecl;
    function text: Pointer; cdecl;
    function textAlignment: UITextAlignment; cdecl;
    function textColor: UIColor; cdecl;
    function textRectForBounds(bounds: CGRect): CGRect; cdecl;
  end;
  TUITextField = class(TOCGenericImport<UITextFieldClass, UITextField>)  end;

  UIPageControlClass = interface(UIControlClass)
    ['{2D02A274-7CE8-409C-85F5-6E6EDA6A5C92}']
  end;
  UIPageControl = interface(UIControl)
    ['{E99DE502-9B21-4E38-B1F1-A85B357D0E65}']
    function currentPage: NSInteger; cdecl;
    function defersCurrentPageDisplay: Boolean; cdecl;
    function hidesForSinglePage: Boolean; cdecl;
    function numberOfPages: NSInteger; cdecl;
    procedure setCurrentPage(currentPage: NSInteger); cdecl;
    procedure setDefersCurrentPageDisplay(defersCurrentPageDisplay: Boolean); cdecl;
    procedure setHidesForSinglePage(hidesForSinglePage: Boolean); cdecl;
    procedure setNumberOfPages(numberOfPages: NSInteger); cdecl;
    function sizeForNumberOfPages(pageCount: NSInteger): CGSize; cdecl;
    procedure updateCurrentPageDisplay; cdecl;
  end;
  TUIPageControl = class(TOCGenericImport<UIPageControlClass, UIPageControl>)  end;

  UITableViewClass = interface(UIScrollViewClass)
    ['{4C2A0FA6-BE38-45BB-90EB-D338737EB74A}']
  end;
  UITableView = interface(UIScrollView)
    ['{C1A9608D-1D18-41E9-9B51-E5DFF12C6651}']
    function allowsMultipleSelection: Boolean; cdecl;
    function allowsMultipleSelectionDuringEditing: Boolean; cdecl;
    function allowsSelection: Boolean; cdecl;
    function allowsSelectionDuringEditing: Boolean; cdecl;
    function backgroundView: UIView; cdecl;
    procedure beginUpdates; cdecl;
    function cellForRowAtIndexPath(indexPath: NSIndexPath): UITableViewCell; cdecl;
    function dataSource: Pointer; cdecl;
    function delegate: Pointer; cdecl;
    procedure deleteRowsAtIndexPaths(indexPaths: NSArray; withRowAnimation: UITableViewRowAnimation); cdecl;
    procedure deleteSections(sections: NSIndexSet; withRowAnimation: UITableViewRowAnimation); cdecl;
    function dequeueReusableCellWithIdentifier(identifier: NSString): Pointer; cdecl;
    procedure deselectRowAtIndexPath(indexPath: NSIndexPath; animated: Boolean); cdecl;
    procedure endUpdates; cdecl;
    function indexPathForCell(cell: UITableViewCell): NSIndexPath; cdecl;
    function indexPathForRowAtPoint(point: CGPoint): NSIndexPath; cdecl;
    function indexPathForSelectedRow: NSIndexPath; cdecl;
    function indexPathsForRowsInRect(rect: CGRect): NSArray; cdecl;
    function indexPathsForSelectedRows: NSArray; cdecl;
    function indexPathsForVisibleRows: NSArray; cdecl;
    function initWithFrame(frame: CGRect; style: UITableViewStyle): Pointer; cdecl;
    procedure insertRowsAtIndexPaths(indexPaths: NSArray; withRowAnimation: UITableViewRowAnimation); cdecl;
    procedure insertSections(sections: NSIndexSet; withRowAnimation: UITableViewRowAnimation); cdecl;
    function isEditing: Boolean; cdecl;
    procedure moveRowAtIndexPath(indexPath: NSIndexPath; toIndexPath: NSIndexPath); cdecl;
    procedure moveSection(section: NSInteger; toSection: NSInteger); cdecl;
    function numberOfRowsInSection(section: NSInteger): NSInteger; cdecl;
    function numberOfSections: NSInteger; cdecl;
    function rectForFooterInSection(section: NSInteger): CGRect; cdecl;
    function rectForHeaderInSection(section: NSInteger): CGRect; cdecl;
    function rectForRowAtIndexPath(indexPath: NSIndexPath): CGRect; cdecl;
    function rectForSection(section: NSInteger): CGRect; cdecl;
    procedure registerNib(nib: UINib; forCellReuseIdentifier: NSString); cdecl;
    procedure reloadData; cdecl;
    procedure reloadRowsAtIndexPaths(indexPaths: NSArray; withRowAnimation: UITableViewRowAnimation); cdecl;
    procedure reloadSectionIndexTitles; cdecl;
    procedure reloadSections(sections: NSIndexSet; withRowAnimation: UITableViewRowAnimation); cdecl;
    function rowHeight: Single; cdecl;
    procedure scrollToNearestSelectedRowAtScrollPosition(scrollPosition: UITableViewScrollPosition; animated: Boolean); cdecl;
    procedure scrollToRowAtIndexPath(indexPath: NSIndexPath; atScrollPosition: UITableViewScrollPosition; animated: Boolean); cdecl;
    function sectionFooterHeight: Single; cdecl;
    function sectionHeaderHeight: Single; cdecl;
    function sectionIndexMinimumDisplayRowCount: NSInteger; cdecl;
    procedure selectRowAtIndexPath(indexPath: NSIndexPath; animated: Boolean; scrollPosition: UITableViewScrollPosition); cdecl;
    function separatorColor: UIColor; cdecl;
    function separatorStyle: UITableViewCellSeparatorStyle; cdecl;
    procedure setAllowsMultipleSelection(allowsMultipleSelection: Boolean); cdecl;
    procedure setAllowsMultipleSelectionDuringEditing(allowsMultipleSelectionDuringEditing: Boolean); cdecl;
    procedure setAllowsSelection(allowsSelection: Boolean); cdecl;
    procedure setAllowsSelectionDuringEditing(allowsSelectionDuringEditing: Boolean); cdecl;
    procedure setBackgroundView(backgroundView: UIView); cdecl;
    procedure setDataSource(dataSource: Pointer); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setEditing(editing: Boolean); cdecl; overload;
    procedure setEditing(editing: Boolean; animated: Boolean); cdecl; overload;
    procedure setRowHeight(rowHeight: Single); cdecl;
    procedure setSectionFooterHeight(sectionFooterHeight: Single); cdecl;
    procedure setSectionHeaderHeight(sectionHeaderHeight: Single); cdecl;
    procedure setSectionIndexMinimumDisplayRowCount(sectionIndexMinimumDisplayRowCount: NSInteger); cdecl;
    procedure setSeparatorColor(separatorColor: UIColor); cdecl;
    procedure setSeparatorStyle(separatorStyle: UITableViewCellSeparatorStyle); cdecl;
    procedure setTableFooterView(tableFooterView: UIView); cdecl;
    procedure setTableHeaderView(tableHeaderView: UIView); cdecl;
    function style: UITableViewStyle; cdecl;
    function tableFooterView: UIView; cdecl;
    function tableHeaderView: UIView; cdecl;
    function visibleCells: NSArray; cdecl;
  end;
  TUITableView = class(TOCGenericImport<UITableViewClass, UITableView>)  end;

  UIImagePickerControllerClass = interface(UINavigationControllerClass)
    ['{995609A0-E3FC-4083-AD2C-73EBB6DD2686}']
    {class} function availableCaptureModesForCameraDevice(cameraDevice: UIImagePickerControllerCameraDevice): NSArray; cdecl;
    {class} function availableMediaTypesForSourceType(sourceType: UIImagePickerControllerSourceType): NSArray; cdecl;
    {class} function isCameraDeviceAvailable(cameraDevice: UIImagePickerControllerCameraDevice): Boolean; cdecl;
    {class} function isFlashAvailableForCameraDevice(cameraDevice: UIImagePickerControllerCameraDevice): Boolean; cdecl;
    {class} function isSourceTypeAvailable(sourceType: UIImagePickerControllerSourceType): Boolean; cdecl;
  end;
  UIImagePickerController = interface(UINavigationController)
    ['{D53CD2AC-4FB2-454C-9BDB-BC4858778909}']
    function allowsEditing: Boolean; cdecl;
    function allowsImageEditing: Boolean; cdecl;
    function cameraCaptureMode: UIImagePickerControllerCameraCaptureMode; cdecl;
    function cameraDevice: UIImagePickerControllerCameraDevice; cdecl;
    function cameraFlashMode: UIImagePickerControllerCameraFlashMode; cdecl;
    function cameraOverlayView: UIView; cdecl;
    function cameraViewTransform: CGAffineTransform; cdecl;
    function delegate: Pointer; cdecl;
    function mediaTypes: NSArray; cdecl;
    procedure setAllowsEditing(allowsEditing: Boolean); cdecl;
    procedure setAllowsImageEditing(allowsImageEditing: Boolean); cdecl;
    procedure setCameraCaptureMode(cameraCaptureMode: UIImagePickerControllerCameraCaptureMode); cdecl;
    procedure setCameraDevice(cameraDevice: UIImagePickerControllerCameraDevice); cdecl;
    procedure setCameraFlashMode(cameraFlashMode: UIImagePickerControllerCameraFlashMode); cdecl;
    procedure setCameraOverlayView(cameraOverlayView: UIView); cdecl;
    procedure setCameraViewTransform(cameraViewTransform: CGAffineTransform); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setMediaTypes(mediaTypes: NSArray); cdecl;
    procedure setShowsCameraControls(showsCameraControls: Boolean); cdecl;
    procedure setSourceType(sourceType: UIImagePickerControllerSourceType); cdecl;
    procedure setVideoMaximumDuration(videoMaximumDuration: NSTimeInterval); cdecl;
    procedure setVideoQuality(videoQuality: UIImagePickerControllerQualityType); cdecl;
    function showsCameraControls: Boolean; cdecl;
    function sourceType: UIImagePickerControllerSourceType; cdecl;
    function startVideoCapture: Boolean; cdecl;
    procedure stopVideoCapture; cdecl;
    procedure takePicture; cdecl;
    function videoMaximumDuration: NSTimeInterval; cdecl;
    function videoQuality: UIImagePickerControllerQualityType; cdecl;
  end;
  TUIImagePickerController = class(TOCGenericImport<UIImagePickerControllerClass, UIImagePickerController>)  end;

  UITextViewClass = interface(UIScrollViewClass)
    ['{9D221886-49F8-4614-A1DF-6EAACB1EDE92}']
  end;
  UITextView = interface(UIScrollView)
    ['{1FAC7927-055D-4132-A7D3-913E303A4D6E}']
    function dataDetectorTypes: UIDataDetectorTypes; cdecl;
    function delegate: Pointer; cdecl;
    function font: UIFont; cdecl;
    function hasText: Boolean; cdecl;
    function inputAccessoryView: UIView; cdecl;
    function inputView: UIView; cdecl;
    function isEditable: Boolean; cdecl;
    procedure scrollRangeToVisible(range: NSRange); cdecl;
    function selectedRange: NSRange; cdecl;
    procedure setDataDetectorTypes(dataDetectorTypes: UIDataDetectorTypes); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    procedure setFont(font: UIFont); cdecl;
    procedure setInputAccessoryView(inputAccessoryView: UIView); cdecl;
    procedure setInputView(inputView: UIView); cdecl;
    procedure setSelectedRange(selectedRange: NSRange); cdecl;
    procedure setText(text: NSString); cdecl;
    procedure setTextAlignment(textAlignment: UITextAlignment); cdecl;
    procedure setTextColor(textColor: UIColor); cdecl;
    function text: NSString; cdecl;
    function textAlignment: UITextAlignment; cdecl;
    function textColor: UIColor; cdecl;
  end;
  TUITextView = class(TOCGenericImport<UITextViewClass, UITextView>)  end;

  UISwitchClass = interface(UIControlClass)
    ['{BF60A5F6-0765-4BDF-9328-072D3CB9C92B}']
  end;
  UISwitch = interface(UIControl)
    ['{CC5A762A-FE08-46A3-B994-444FC01C936D}']
    function initWithFrame(frame: CGRect): Pointer; cdecl;
    function isOn: Boolean; cdecl;
    function onTintColor: UIColor; cdecl;
    procedure setOn(on: Boolean); cdecl; overload;
    procedure setOn(on: Boolean; animated: Boolean); cdecl; overload;
    procedure setOnTintColor(onTintColor: UIColor); cdecl;
  end;
  TUISwitch = class(TOCGenericImport<UISwitchClass, UISwitch>)  end;

// ===== Protocol declarations =====
(*
  UIAccelerometerDelegate = interface(IObjectiveC)
    ['{F822102F-36A8-4871-B6B4-7A54F7730044}']
    procedure accelerometer(accelerometer: UIAccelerometer; didAccelerate: UIAcceleration); cdecl;
  end;
  UIAccessibilityIdentification = interface(IObjectiveC)
    ['{31ADC052-6F10-4851-B247-56147EB64CD5}']
    function accessibilityIdentifier: NSString; cdecl;
    procedure setAccessibilityIdentifier(accessibilityIdentifier: NSString); cdecl;
  end;
  UIAccessibilityReadingContent = interface
    ['{AADB593A-6DE4-442C-8138-5D86CF72CF06}']
    function accessibilityContentForLineNumber(lineNumber: NSInteger): NSString; cdecl;
    function accessibilityFrameForLineNumber(lineNumber: NSInteger): CGRect; cdecl;
    function accessibilityLineNumberForPoint(point: CGPoint): NSInteger; cdecl;
    function accessibilityPageContent: NSString; cdecl;
  end;
*)
  UIActionSheetDelegate = interface(IObjectiveC)
    ['{EEFD40E4-3A92-4775-BF34-728C122AF10F}']
    procedure actionSheet(actionSheet: UIActionSheet; clickedButtonAtIndex: NSInteger); cdecl; //overload;
//    procedure actionSheet(actionSheet: UIActionSheet; didDismissWithButtonIndex: NSInteger); cdecl; overload;
//    procedure actionSheet(actionSheet: UIActionSheet; willDismissWithButtonIndex: NSInteger); cdecl; overload;
    procedure actionSheetCancel(actionSheet: UIActionSheet); cdecl;
    procedure didPresentActionSheet(actionSheet: UIActionSheet); cdecl;
    procedure willPresentActionSheet(actionSheet: UIActionSheet); cdecl;
  end;
(*
  UIAppearance = interface(IObjectiveC)
    ['{3FEA26F4-372E-4875-92EB-445D3D59366F}']
  end;
*)
  UIAlertViewDelegate = interface(IObjectiveC)
    ['{A52A64A0-AA7E-422E-B7A4-8EFCF2C20A49}']
    procedure alertView(alertView: UIAlertView; clickedButtonAtIndex: NSInteger); cdecl; overload;
    procedure alertViewCancel(alertView: UIAlertView); cdecl;
{    procedure alertView(alertView: UIAlertView; didDismissWithButtonIndex: NSInteger); cdecl; overload;
    procedure alertView(alertView: UIAlertView; willDismissWithButtonIndex: NSInteger); cdecl; overload;
    function alertViewShouldEnableFirstOtherButton(alertView: UIAlertView): Boolean; cdecl;
    procedure didPresentAlertView(alertView: UIAlertView); cdecl;
    procedure willPresentAlertView(alertView: UIAlertView); cdecl;}
  end;
  UIApplicationDelegate = interface(IObjectiveC)
    ['{C0474DD7-D5B4-462D-9A32-577497307259}']
    procedure application(Sender: UIApplication; didChangeStatusBarFrame: CGRect); cdecl; overload;
    procedure application(Sender: UIApplication; didChangeStatusBarOrientation: UIInterfaceOrientation); cdecl; overload;
    procedure application(Sender: UIApplication; didFailToRegisterForRemoteNotificationsWithError: NSError); cdecl; overload;
    function application(Sender: UIApplication; didFinishLaunchingWithOptions: NSDictionary): Boolean; cdecl; overload;
    procedure application(Sender: UIApplication; didReceiveLocalNotification: UILocalNotification); cdecl; overload;
//    procedure application(Sender: UIApplication; didReceiveRemoteNotification: NSDictionary); cdecl; overload;
    procedure application(Sender: UIApplication; didRegisterForRemoteNotificationsWithDeviceToken: NSData); cdecl; overload;
    function application(Sender: UIApplication; handleOpenURL: NSURL): Boolean; cdecl; overload;
    function application(Sender: UIApplication; openURL: NSURL; sourceApplication: NSString; annotation: Pointer): Boolean; cdecl; overload;
//    procedure application(Sender: UIApplication; willChangeStatusBarFrame: CGRect); cdecl; overload;
    procedure application(Sender: UIApplication; willChangeStatusBarOrientation: UIInterfaceOrientation; duration: NSTimeInterval); cdecl; overload;
    procedure applicationDidBecomeActive(Sender: UIApplication); cdecl;
    procedure applicationDidEnterBackground(Sender: UIApplication); cdecl;
//    procedure applicationDidFinishLaunching(Sender: UIApplication); cdecl; // deprecated
    procedure applicationDidReceiveMemoryWarning(Sender: UIApplication); cdecl;
    procedure applicationProtectedDataDidBecomeAvailable(Sender: UIApplication); cdecl;
    procedure applicationProtectedDataWillBecomeUnavailable(Sender: UIApplication); cdecl;
    procedure applicationSignificantTimeChange(Sender: UIApplication); cdecl;
    procedure applicationWillEnterForeground(Sender: UIApplication); cdecl;
    procedure applicationWillResignActive(Sender: UIApplication); cdecl;
    procedure applicationWillTerminate(Sender: UIApplication); cdecl;
    procedure setWindow(window: UIWindow); cdecl;
    function window: UIWindow; cdecl;
  end;
(*
  UIDocumentInteractionControllerDelegate = interface(IObjectiveC)
    ['{0FCE1916-CD2C-4141-8188-3F914747B57B}']
    function documentInteractionController(controller: UIDocumentInteractionController; canPerformAction: SEL): Boolean; cdecl; overload;
    procedure documentInteractionController(controller: UIDocumentInteractionController; didEndSendingToApplication: NSString); cdecl; overload;
    function documentInteractionController(controller: UIDocumentInteractionController; performAction: SEL): Boolean; cdecl; overload;
    procedure documentInteractionController(controller: UIDocumentInteractionController; willBeginSendingToApplication: NSString); cdecl; overload;
    procedure documentInteractionControllerDidDismissOpenInMenu(controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerDidDismissOptionsMenu(controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerDidEndPreview(controller: UIDocumentInteractionController); cdecl;
    function documentInteractionControllerRectForPreview(controller: UIDocumentInteractionController): CGRect; cdecl;
    function documentInteractionControllerViewControllerForPreview(controller: UIDocumentInteractionController): UIViewController; cdecl;
    function documentInteractionControllerViewForPreview(controller: UIDocumentInteractionController): UIView; cdecl;
    procedure documentInteractionControllerWillBeginPreview(controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerWillPresentOpenInMenu(controller: UIDocumentInteractionController); cdecl;
    procedure documentInteractionControllerWillPresentOptionsMenu(controller: UIDocumentInteractionController); cdecl;
  end;
  *)
  UIGestureRecognizerDelegate = interface(IObjectiveC)
    ['{96522BE4-CA33-4F69-9581-494DFD050D01}']
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldReceiveTouch: UITouch): Boolean; cdecl; overload;
    function gestureRecognizer(gestureRecognizer: UIGestureRecognizer; shouldRecognizeSimultaneouslyWithGestureRecognizer: UIGestureRecognizer): Boolean; cdecl; overload;
    function gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer): Boolean; cdecl;
  end;

  UIImagePickerControllerDelegate = interface(IObjectiveC)
    ['{EF6254E7-276D-41B4-8374-7C68142C4613}']
    procedure imagePickerController(picker: UIImagePickerController; didFinishPickingImage: UIImage; editingInfo: NSDictionary); cdecl; overload;
    procedure imagePickerController(picker: UIImagePickerController; didFinishPickingMediaWithInfo: NSDictionary); cdecl; overload;
    procedure imagePickerControllerDidCancel(picker: UIImagePickerController); cdecl;
  end;
(*
  UIInputViewAudioFeedback = interface(IObjectiveC)
    ['{996ED900-274B-4CEC-A799-9F771F699BC2}']
    function enableInputClicksWhenVisible: Boolean; cdecl;
  end;
  UINavigationBarDelegate = interface(IObjectiveC)
    ['{1CE611B4-FE30-42CE-8F64-3A891E6606A8}']
    procedure navigationBar(navigationBar: UINavigationBar; didPopItem: UINavigationItem); cdecl; overload;
    procedure navigationBar(navigationBar: UINavigationBar; didPushItem: UINavigationItem); cdecl; overload;
    function navigationBar(navigationBar: UINavigationBar; shouldPopItem: UINavigationItem): Boolean; cdecl; overload;
    function navigationBar(navigationBar: UINavigationBar; shouldPushItem: UINavigationItem): Boolean; cdecl; overload;
  end;
  UINavigationControllerDelegate = interface(IObjectiveC)
    ['{BD454860-A5DE-47B3-BAC5-37972373032C}']
    procedure navigationController(navigationController: UINavigationController; didShowViewController: UIViewController; animated: Boolean); cdecl; overload;
    procedure navigationController(navigationController: UINavigationController; willShowViewController: UIViewController; animated: Boolean); cdecl; overload;
  end;
  UIPageViewControllerDataSource = interface(IObjectiveC)
    ['{B252DA20-9B72-4AC0-ACC0-AE1C207FD2B1}']
    function pageViewController(pageViewController: UIPageViewController; viewControllerAfterViewController: UIViewController): UIViewController; cdecl; overload;
    function pageViewController(pageViewController: UIPageViewController; viewControllerBeforeViewController: UIViewController): UIViewController; cdecl; overload;
  end;
  UIPageViewControllerDelegate = interface(IObjectiveC)
    ['{64115974-BA9C-40F5-9D7C-4D55E72C6E21}']
    procedure pageViewController(pageViewController: UIPageViewController; didFinishAnimating: Boolean; previousViewControllers: NSArray; transitionCompleted: Boolean); cdecl; overload;
    function pageViewController(pageViewController: UIPageViewController; spineLocationForInterfaceOrientation: UIInterfaceOrientation): UIPageViewControllerSpineLocation; cdecl; overload;
  end;
  UIPickerViewAccessibilityDelegate = interface(UIPickerViewDelegate)
    ['{7D9376A1-B37F-45B4-AD14-232554543E24}']
    function pickerView(pickerView: UIPickerView; accessibilityHintForComponent: NSInteger): NSString; cdecl; overload;
    function pickerView(pickerView: UIPickerView; accessibilityLabelForComponent: NSInteger): NSString; cdecl; overload;
  end;
*)
  UIPickerViewDataSource = interface(IObjectiveC)
    ['{0FA66D5F-4FE4-47A6-B326-3E5AC9D191B0}']
    function numberOfComponentsInPickerView(pickerView: UIPickerView): NSInteger; cdecl;
    function pickerView(pickerView: UIPickerView; numberOfRowsInComponent: NSInteger): NSInteger; cdecl;
  end;
  UIPickerViewDelegate = interface(IObjectiveC)
    ['{FAB79BDD-7094-41B0-B4C6-AF6C261EED91}']
//    procedure pickerView(pickerView: UIPickerView; didSelectRow: NSInteger; inComponent: NSInteger); cdecl; overload;
//    function pickerView(pickerView: UIPickerView; rowHeightForComponent: NSInteger): Single; cdecl; overload;
    function pickerView(pickerView: UIPickerView; titleForRow: NSInteger; forComponent: NSInteger): NSString; cdecl; overload;
//    function pickerView(pickerView: UIPickerView; viewForRow: NSInteger; forComponent: NSInteger; reusingView: UIView): UIView; cdecl; overload;
//    function pickerView(pickerView: UIPickerView; widthForComponent: NSInteger): Single; cdecl; overload;
  end;

  UIPopoverControllerDelegate = interface(IObjectiveC)
    ['{AA90B09A-9499-44CF-8B0E-31608EB2C548}']
    procedure popoverControllerDidDismissPopover(popoverController: UIPopoverController); cdecl;
    function popoverControllerShouldDismissPopover(popoverController: UIPopoverController): Boolean; cdecl;
  end;
(*
  UIPrintInteractionControllerDelegate = interface(IObjectiveC)
    ['{7A604276-87C2-46CB-99B9-4C43C58C29C5}']
    function printInteractionController(printInteractionController: UIPrintInteractionController; choosePaper: NSArray): UIPrintPaper; cdecl;
    procedure printInteractionControllerDidDismissPrinterOptions(printInteractionController: UIPrintInteractionController); cdecl;
    procedure printInteractionControllerDidFinishJob(printInteractionController: UIPrintInteractionController); cdecl;
    procedure printInteractionControllerDidPresentPrinterOptions(printInteractionController: UIPrintInteractionController); cdecl;
    function printInteractionControllerParentViewController(printInteractionController: UIPrintInteractionController): UIViewController; cdecl;
    procedure printInteractionControllerWillDismissPrinterOptions(printInteractionController: UIPrintInteractionController); cdecl;
    procedure printInteractionControllerWillPresentPrinterOptions(printInteractionController: UIPrintInteractionController); cdecl;
    procedure printInteractionControllerWillStartJob(printInteractionController: UIPrintInteractionController); cdecl;
  end;
  UIScrollViewDelegate = interface(IObjectiveC)
    ['{7B4EC524-1ECA-4D9F-9824-42B8C9C47FB2}']
    procedure scrollViewDidEndDecelerating(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidEndDragging(scrollView: UIScrollView; willDecelerate: Boolean); cdecl;
    procedure scrollViewDidEndScrollingAnimation(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidEndZooming(scrollView: UIScrollView; withView: UIView; atScale: Single); cdecl;
    procedure scrollViewDidScroll(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidScrollToTop(scrollView: UIScrollView); cdecl;
    procedure scrollViewDidZoom(scrollView: UIScrollView); cdecl;
    function scrollViewShouldScrollToTop(scrollView: UIScrollView): Boolean; cdecl;
    procedure scrollViewWillBeginDecelerating(scrollView: UIScrollView); cdecl;
    procedure scrollViewWillBeginDragging(scrollView: UIScrollView); cdecl;
    procedure scrollViewWillBeginZooming(scrollView: UIScrollView; withView: UIView); cdecl;
    procedure scrollViewWillEndDragging(scrollView: UIScrollView; withVelocity: CGPoint; targetContentOffset: CGPoint); cdecl;
    function viewForZoomingInScrollView(scrollView: UIScrollView): UIView; cdecl;
  end;
  UISearchBarDelegate = interface(IObjectiveC)
    ['{1F54F3B5-0697-4730-A402-46718BC11207}']
    procedure searchBar(searchBar: UISearchBar; selectedScopeButtonIndexDidChange: NSInteger); cdecl; overload;
    function searchBar(searchBar: UISearchBar; shouldChangeTextInRange: NSRange; replacementText: NSString): Boolean; cdecl; overload;
    procedure searchBar(searchBar: UISearchBar; textDidChange: NSString); cdecl; overload;
    procedure searchBarBookmarkButtonClicked(searchBar: UISearchBar); cdecl;
    procedure searchBarCancelButtonClicked(searchBar: UISearchBar); cdecl;
    procedure searchBarResultsListButtonClicked(searchBar: UISearchBar); cdecl;
    procedure searchBarSearchButtonClicked(searchBar: UISearchBar); cdecl;
    function searchBarShouldBeginEditing(searchBar: UISearchBar): Boolean; cdecl;
    function searchBarShouldEndEditing(searchBar: UISearchBar): Boolean; cdecl;
    procedure searchBarTextDidBeginEditing(searchBar: UISearchBar); cdecl;
    procedure searchBarTextDidEndEditing(searchBar: UISearchBar); cdecl;
  end;
  UISearchDisplayDelegate = interface(IObjectiveC)
    ['{44499C38-4EE4-4880-AC4B-7DEF5EC2723F}']
    procedure searchDisplayController(controller: UISearchDisplayController; didHideSearchResultsTableView: UITableView); cdecl; overload;
    procedure searchDisplayController(controller: UISearchDisplayController; didLoadSearchResultsTableView: UITableView); cdecl; overload;
    procedure searchDisplayController(controller: UISearchDisplayController; didShowSearchResultsTableView: UITableView); cdecl; overload;
    function searchDisplayController(controller: UISearchDisplayController; shouldReloadTableForSearchScope: NSInteger): Boolean; cdecl; overload;
    function searchDisplayController(controller: UISearchDisplayController; shouldReloadTableForSearchString: NSString): Boolean; cdecl; overload;
    procedure searchDisplayController(controller: UISearchDisplayController; willHideSearchResultsTableView: UITableView); cdecl; overload;
    procedure searchDisplayController(controller: UISearchDisplayController; willShowSearchResultsTableView: UITableView); cdecl; overload;
    procedure searchDisplayController(controller: UISearchDisplayController; willUnloadSearchResultsTableView: UITableView); cdecl; overload;
    procedure searchDisplayControllerDidBeginSearch(controller: UISearchDisplayController); cdecl;
    procedure searchDisplayControllerDidEndSearch(controller: UISearchDisplayController); cdecl;
    procedure searchDisplayControllerWillBeginSearch(controller: UISearchDisplayController); cdecl;
    procedure searchDisplayControllerWillEndSearch(controller: UISearchDisplayController); cdecl;
  end;
  UISplitViewControllerDelegate = interface
    ['{55630392-EF83-4138-8C7A-B555804CD0F5}']
    procedure splitViewController(svc: UISplitViewController; popoverController: UIPopoverController; willPresentViewController: UIViewController); cdecl; overload;
    function splitViewController(svc: UISplitViewController; shouldHideViewController: UIViewController; inOrientation: UIInterfaceOrientation): Boolean; cdecl; overload;
    procedure splitViewController(svc: UISplitViewController; willHideViewController: UIViewController; withBarButtonItem: UIBarButtonItem; forPopoverController: UIPopoverController); cdecl; overload;
    procedure splitViewController(svc: UISplitViewController; willShowViewController: UIViewController; invalidatingBarButtonItem: UIBarButtonItem); cdecl; overload;
  end;
  UITabBarControllerDelegate = interface(IObjectiveC)
    ['{26250A75-176B-4574-B7FC-A7B0DC3F3D13}']
    procedure tabBarController(tabBarController: UITabBarController; didEndCustomizingViewControllers: NSArray; changed: Boolean); cdecl; overload;
    procedure tabBarController(tabBarController: UITabBarController; didSelectViewController: UIViewController); cdecl; overload;
    function tabBarController(tabBarController: UITabBarController; shouldSelectViewController: UIViewController): Boolean; cdecl; overload;
    procedure tabBarController(tabBarController: UITabBarController; willBeginCustomizingViewControllers: NSArray); cdecl; overload;
    procedure tabBarController(tabBarController: UITabBarController; willEndCustomizingViewControllers: NSArray; changed: Boolean); cdecl; overload;
  end;
  UITabBarDelegate = interface(IObjectiveC)
    ['{FF7F7746-0F85-49F4-BA59-81D2D5A934BD}']
    procedure tabBar(tabBar: UITabBar; didBeginCustomizingItems: NSArray); cdecl; overload;
    procedure tabBar(tabBar: UITabBar; didEndCustomizingItems: NSArray; changed: Boolean); cdecl; overload;
    procedure tabBar(tabBar: UITabBar; didSelectItem: UITabBarItem); cdecl; overload;
    procedure tabBar(tabBar: UITabBar; willBeginCustomizingItems: NSArray); cdecl; overload;
    procedure tabBar(tabBar: UITabBar; willEndCustomizingItems: NSArray; changed: Boolean); cdecl; overload;
  end;
  UITableViewDataSource = interface(IObjectiveC)
    ['{7125C7B2-890F-4DA0-A20A-03EE1A8D8384}']
    function numberOfSectionsInTableView(tableView: UITableView): NSInteger; cdecl;
    function sectionIndexTitlesForTableView(tableView: UITableView): NSArray; cdecl;
    function tableView(tableView: UITableView; canEditRowAtIndexPath: NSIndexPath): Boolean; cdecl; overload;
    function tableView(tableView: UITableView; canMoveRowAtIndexPath: NSIndexPath): Boolean; cdecl; overload;
    function tableView(tableView: UITableView; cellForRowAtIndexPath: NSIndexPath): UITableViewCell; cdecl; overload;
    procedure tableView(tableView: UITableView; commitEditingStyle: UITableViewCellEditingStyle; forRowAtIndexPath: NSIndexPath); cdecl; overload;
    procedure tableView(tableView: UITableView; moveRowAtIndexPath: NSIndexPath; toIndexPath: NSIndexPath); cdecl; overload;
    function tableView(tableView: UITableView; numberOfRowsInSection: NSInteger): NSInteger; cdecl; overload;
    function tableView(tableView: UITableView; sectionForSectionIndexTitle: NSString; atIndex: NSInteger): NSInteger; cdecl; overload;
    function tableView(tableView: UITableView; titleForFooterInSection: NSInteger): NSString; cdecl; overload;
    function tableView(tableView: UITableView; titleForHeaderInSection: NSInteger): NSString; cdecl; overload;
  end;
  UITableViewDelegate = interface(UIScrollViewDelegate,NSObject)
    ['{2ED63E1B-0FD7-40CE-85A8-BCA6C44E941E}']
    procedure tableView(tableView: UITableView; accessoryButtonTappedForRowWithIndexPath: NSIndexPath); cdecl; overload;
    function tableView(tableView: UITableView; accessoryTypeForRowWithIndexPath: NSIndexPath): UITableViewCellAccessoryType; cdecl; overload;
    function tableView(tableView: UITableView; canPerformAction: SEL; forRowAtIndexPath: NSIndexPath; withSender: Pointer): Boolean; cdecl; overload;
    procedure tableView(tableView: UITableView; didDeselectRowAtIndexPath: NSIndexPath); cdecl; overload;
    procedure tableView(tableView: UITableView; didEndEditingRowAtIndexPath: NSIndexPath); cdecl; overload;
    procedure tableView(tableView: UITableView; didSelectRowAtIndexPath: NSIndexPath); cdecl; overload;
    function tableView(tableView: UITableView; editingStyleForRowAtIndexPath: NSIndexPath): UITableViewCellEditingStyle; cdecl; overload;
    function tableView(tableView: UITableView; heightForFooterInSection: NSInteger): Single; cdecl; overload;
    function tableView(tableView: UITableView; heightForHeaderInSection: NSInteger): Single; cdecl; overload;
    function tableView(tableView: UITableView; heightForRowAtIndexPath: NSIndexPath): Single; cdecl; overload;
    function tableView(tableView: UITableView; indentationLevelForRowAtIndexPath: NSIndexPath): NSInteger; cdecl; overload;
    procedure tableView(tableView: UITableView; performAction: SEL; forRowAtIndexPath: NSIndexPath; withSender: Pointer); cdecl; overload;
    function tableView(tableView: UITableView; shouldIndentWhileEditingRowAtIndexPath: NSIndexPath): Boolean; cdecl; overload;
    function tableView(tableView: UITableView; shouldShowMenuForRowAtIndexPath: NSIndexPath): Boolean; cdecl; overload;
    function tableView(tableView: UITableView; targetIndexPathForMoveFromRowAtIndexPath: NSIndexPath; toProposedIndexPath: NSIndexPath): NSIndexPath; cdecl; overload;
    function tableView(tableView: UITableView; titleForDeleteConfirmationButtonForRowAtIndexPath: NSIndexPath): NSString; cdecl; overload;
    function tableView(tableView: UITableView; viewForFooterInSection: NSInteger): UIView; cdecl; overload;
    function tableView(tableView: UITableView; viewForHeaderInSection: NSInteger): UIView; cdecl; overload;
    procedure tableView(tableView: UITableView; willBeginEditingRowAtIndexPath: NSIndexPath); cdecl; overload;
    function tableView(tableView: UITableView; willDeselectRowAtIndexPath: NSIndexPath): NSIndexPath; cdecl; overload;
    procedure tableView(tableView: UITableView; willDisplayCell: UITableViewCell; forRowAtIndexPath: NSIndexPath); cdecl; overload;
    function tableView(tableView: UITableView; willSelectRowAtIndexPath: NSIndexPath): NSIndexPath; cdecl; overload;
  end;
  UITextFieldDelegate = interface(IObjectiveC)
    ['{B76C73F8-2740-4580-9987-A040C245441A}']
    function textField(textField: UITextField; shouldChangeCharactersInRange: NSRange; replacementString: NSString): Boolean; cdecl;
    procedure textFieldDidBeginEditing(textField: UITextField); cdecl;
    procedure textFieldDidEndEditing(textField: UITextField); cdecl;
    function textFieldShouldBeginEditing(textField: UITextField): Boolean; cdecl;
    function textFieldShouldClear(textField: UITextField): Boolean; cdecl;
    function textFieldShouldEndEditing(textField: UITextField): Boolean; cdecl;
    function textFieldShouldReturn(textField: UITextField): Boolean; cdecl;
  end;
  UITextInputDelegate = interface(IObjectiveC)
    ['{7BD0942A-25FE-4482-844E-0DC97F1E1DD2}']
    procedure selectionDidChange(textInput: Pointer); cdecl;
    procedure selectionWillChange(textInput: Pointer); cdecl;
    procedure textDidChange(textInput: Pointer); cdecl;
    procedure textWillChange(textInput: Pointer); cdecl;
  end;
  UITextInputTokenizer = interface(IObjectiveC)
    ['{6990C1A9-4599-4326-94A6-607C59E9BA14}']
    function isPosition(position: UITextPosition; atBoundary: UITextGranularity; inDirection: UITextDirection): Boolean; cdecl; overload;
    function isPosition(position: UITextPosition; withinTextUnit: UITextGranularity; inDirection: UITextDirection): Boolean; cdecl; overload;
    function positionFromPosition(position: UITextPosition; toBoundary: UITextGranularity; inDirection: UITextDirection): UITextPosition; cdecl;
    function rangeEnclosingPosition(position: UITextPosition; withGranularity: UITextGranularity; inDirection: UITextDirection): UITextRange; cdecl;
  end;
*)
  UITextInputTraits = interface(IObjectiveC)
    ['{339F9183-3915-4915-88F4-1C0BAD43DEA8}']
    function autocapitalizationType: UITextAutocapitalizationType; cdecl;
    function autocorrectionType: UITextAutocorrectionType; cdecl;
    function enablesReturnKeyAutomatically: Boolean; cdecl;
    function isSecureTextEntry: Boolean; cdecl;
    function keyboardAppearance: UIKeyboardAppearance; cdecl;
    function keyboardType: UIKeyboardType; cdecl;
    function returnKeyType: UIReturnKeyType; cdecl;
    procedure setAutocapitalizationType(autocapitalizationType: UITextAutocapitalizationType); cdecl;
    procedure setAutocorrectionType(autocorrectionType: UITextAutocorrectionType); cdecl;
    procedure setEnablesReturnKeyAutomatically(enablesReturnKeyAutomatically: Boolean); cdecl;
    procedure setKeyboardAppearance(keyboardAppearance: UIKeyboardAppearance); cdecl;
    procedure setKeyboardType(keyboardType: UIKeyboardType); cdecl;
    procedure setReturnKeyType(returnKeyType: UIReturnKeyType); cdecl;
    procedure setSecureTextEntry(secureTextEntry: Boolean); cdecl;
    procedure setSpellCheckingType(spellCheckingType: Integer); cdecl;
    function spellCheckingType: Integer; cdecl;
  end;
  UIKeyInput = interface(UITextInputTraits)
    ['{EC035971-A21F-43C6-ABF7-DB5973705897}']
    procedure deleteBackward; cdecl;
    function hasText: Boolean; cdecl;
    procedure insertText(text: NSString); cdecl;
  end;
  UITextInput = interface(UIKeyInput)
    ['{2DF76AA7-B045-44A4-8476-894BA616585C}']
    function baseWritingDirectionForPosition(position: UITextPosition; inDirection: UITextStorageDirection): UITextWritingDirection; cdecl;
    function beginningOfDocument: UITextPosition; cdecl;
    function caretRectForPosition(position: UITextPosition): CGRect; cdecl;
//    function characterOffsetOfPosition(position: UITextPosition; withinRange: UITextRange): NSInteger; cdecl;
    function characterRangeAtPoint(point: CGPoint): UITextRange; cdecl;
    function characterRangeByExtendingPosition(position: UITextPosition; inDirection: UITextLayoutDirection): UITextRange; cdecl;
    function closestPositionToPoint(point: CGPoint): UITextPosition; cdecl; overload;
    function closestPositionToPoint(point: CGPoint; withinRange: UITextRange): UITextPosition; cdecl; overload;
    function comparePosition(position: UITextPosition; toPosition: UITextPosition): NSComparisonResult; cdecl;
    function endOfDocument: UITextPosition; cdecl;
    function firstRectForRange(range: UITextRange): CGRect; cdecl;
    function inputDelegate: Pointer; cdecl;
    function markedTextRange: UITextRange; cdecl;
    function markedTextStyle: NSDictionary; cdecl;
    function offsetFromPosition(from: UITextPosition; toPosition: UITextPosition): NSInteger; cdecl;
    function positionFromPosition(position: UITextPosition; inDirection: UITextLayoutDirection; offset: NSInteger): UITextPosition; cdecl; overload;
    function positionFromPosition(position: UITextPosition; offset: NSInteger): UITextPosition; cdecl; overload;
//    function positionWithinRange(range: UITextRange; atCharacterOffset: NSInteger): UITextPosition; cdecl; overload;
    function positionWithinRange(range: UITextRange; farthestInDirection: UITextLayoutDirection): UITextPosition; cdecl; //overload;
    procedure replaceRange(range: UITextRange; withText: NSString); cdecl;
    function selectedTextRange: UITextRange; cdecl;
//    function selectionAffinity: UITextStorageDirection; cdecl;
    procedure setBaseWritingDirection(writingDirection: UITextWritingDirection; forRange: UITextRange); cdecl;
    procedure setInputDelegate(inputDelegate: Pointer); cdecl;
    procedure setMarkedText(markedText: NSString; selectedRange: NSRange); cdecl;
    procedure setMarkedTextStyle(markedTextStyle: NSDictionary); cdecl;
    procedure setSelectedTextRange(selectedTextRange: UITextRange); cdecl;
//    procedure setSelectionAffinity(selectionAffinity: UITextStorageDirection); cdecl;
    function textInRange(range: UITextRange): NSString; cdecl;
//    function textInputView: UIView; cdecl;
    function textRangeFromPosition(fromPosition: UITextPosition; toPosition: UITextPosition): UITextRange; cdecl;
//    function textStylingAtPosition(position: UITextPosition; inDirection: UITextStorageDirection): NSDictionary; cdecl;
    function tokenizer: Pointer; cdecl;
    procedure unmarkText; cdecl;
  end;
(*
  UITextViewDelegate = interface(UIScrollViewDelegate,NSObject)
    ['{69F7810B-0CC5-434F-A751-8EC9DE0B96AA}']
    function textView(textView: UITextView; shouldChangeTextInRange: NSRange; replacementText: NSString): Boolean; cdecl;
    procedure textViewDidBeginEditing(textView: UITextView); cdecl;
    procedure textViewDidChange(textView: UITextView); cdecl;
    procedure textViewDidChangeSelection(textView: UITextView); cdecl;
    procedure textViewDidEndEditing(textView: UITextView); cdecl;
    function textViewShouldBeginEditing(textView: UITextView): Boolean; cdecl;
    function textViewShouldEndEditing(textView: UITextView): Boolean; cdecl;
  end;
  UIVideoEditorControllerDelegate = interface(IObjectiveC)
    ['{63DAF69C-1AB4-423B-99FC-1B5654C3C796}']
    procedure videoEditorController(editor: UIVideoEditorController; didFailWithError: NSError); cdecl; overload;
    procedure videoEditorController(editor: UIVideoEditorController; didSaveEditedVideoToPath: NSString); cdecl; overload;
    procedure videoEditorControllerDidCancel(editor: UIVideoEditorController); cdecl;
  end;
*)
  UIWebViewDelegate = interface(IObjectiveC)
    ['{25E7C20B-68A2-4011-9D7F-B97647BD48C0}']
    procedure webView(webView: UIWebView; didFailLoadWithError: NSError); cdecl; overload;
    function webView(webView: UIWebView; shouldStartLoadWithRequest: NSURLRequest; navigationType: UIWebViewNavigationType): Boolean; cdecl; overload;
    procedure webViewDidFinishLoad(webView: UIWebView); cdecl;
    procedure webViewDidStartLoad(webView: UIWebView); cdecl;
  end;

// exported string consts

  function UILocalNotificationDefaultSoundName: NSString;

  function UIImagePickerControllerOriginalImage: NSString;

  function UITrackingRunLoopMode: NSString;

implementation

{$IF defined(IOS) and NOT defined(CPUARM)}
uses
  Posix.Dlfcn;

var
  UIKModule: THandle;
{$ENDIF IOS}

const
  UIKitFwk: string = '/System/Library/Frameworks/UIKit.framework/UIKit';

function UILocalNotificationDefaultSoundName: NSString;
begin
  Result := CocoaNSStringConst(UIKitFwk, 'UILocalNotificationDefaultSoundName');
end;

function UIImagePickerControllerOriginalImage: NSString;
begin
  Result := CocoaNSStringConst(UIKitFwk, 'UIImagePickerControllerOriginalImage');
end;

function UITrackingRunLoopMode: NSString;
begin
  Result := CocoaNSStringConst(UIKitFwk, 'UITrackingRunLoopMode');
end;

{$IF defined(IOS) and NOT defined(CPUARM)}
initialization
  UIKModule := dlopen(MarshaledAString(libUIKit), RTLD_LAZY);

finalization
  dlclose(UIKModule);
{$ENDIF IOS}

end.
