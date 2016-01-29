{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{*******************************************************}
{   Delphi-Objective-C Bridge                           }
{   Interfaces for Cocoa framework AppKit               }
{*******************************************************}
unit Macapi.AppKit;

interface

uses
  Macapi.ObjCRuntime,
  Macapi.ObjectiveC,
  Macapi.CocoaTypes,
//  Macapi.ApplicationServices,
//  Macapi.AudioToolbox,
//  Macapi.AudioUnit,
//  Macapi.CoreData,
  Macapi.Foundation,
//  Macapi.HIToolbox,
//  Macapi.IOKit,
  Macapi.QuartzCore,
  Macapi.Security,
//  Macapi.SpeechRecognition,
//  Macapi.CoreAudio,
//  Macapi.DiskArbitration,
  Macapi.CoreServices,
  Macapi.CoreFoundation;


const
  NSAWTEventType = 16;
  NSAboveBottom = 4;
  NSAboveTop = 1;
  NSAddTraitFontAction = 2;
  NSAdobeCNS1CharacterCollection = 1;
  NSAdobeGB1CharacterCollection = 2;
  NSAdobeJapan1CharacterCollection = 3;
  NSAdobeJapan2CharacterCollection = 4;
  NSAdobeKorea1CharacterCollection = 5;
  NSAlertAlternateReturn = 0;
  NSAlertDefaultReturn = 1;
  NSAlertErrorReturn = -2;
  NSAlertFirstButtonReturn = 1000;
  NSAlertOtherReturn = -1;
  NSAlertSecondButtonReturn = 1001;
  NSAlertThirdButtonReturn = 1002;
  NSAllScrollerParts = 2;
  NSAlphaFirstBitmapFormat = 1;
  NSAlphaNonpremultipliedBitmapFormat = 2;
  NSAlphaShiftKeyMask = 65536;
  NSAlternateKeyMask = 524288;
  NSAnimationBlocking = 0;
  NSAnimationEaseIn = 1;
  NSAnimationEaseInOut = 0;
  NSAnimationEaseOut = 2;
  NSAnimationEffectDisappearingItemDefault = 0;
  NSAnimationEffectPoof = 10;
  NSAnimationLinear = 3;
  NSAnimationNonblocking = 1;
  NSAnimationNonblockingThreaded = 2;
  NSAnyEventMask = -1;
  NSAnyType = 0;
  NSAppKitDefined = 13;
  NSAppKitDefinedMask = 8192;
  NSAppKitVersionNumber10_0 = 577;
  NSAppKitVersionNumber10_1 = 620;
  NSAppKitVersionNumber10_2 = 663;
  NSAppKitVersionNumber10_2_3 = 663.60000000000002;
  NSAppKitVersionNumber10_3 = 743;
  NSAppKitVersionNumber10_3_2 = 743.13999999999999;
  NSAppKitVersionNumber10_3_3 = 743.20000000000005;
  NSAppKitVersionNumber10_3_5 = 743.24000000000001;
  NSAppKitVersionNumber10_3_7 = 743.33000000000004;
  NSAppKitVersionNumber10_3_9 = 743.36000000000001;
  NSAppKitVersionNumber10_4 = 824;
  NSAppKitVersionNumber10_4_1 = 824.10000000000002;
  NSAppKitVersionNumber10_4_3 = 824.23000000000002;
  NSAppKitVersionNumber10_4_4 = 824.33000000000004;
  NSAppKitVersionNumber10_4_7 = 824.40999999999997;
  NSAppKitVersionNumber10_5 = 949;
  NSAppKitVersionNumber10_5_2 = 949.26999999999998;
  NSAppKitVersionNumber10_5_3 = 949.33000000000004;
  NSAppKitVersionNumberWithColumnResizingBrowser = 685.00000000000000;
  NSAppKitVersionNumberWithContinuousScrollingBrowser = 680.00000000000000;
  NSAppKitVersionNumberWithCursorSizeSupport = 682.00000000000000;
  NSAppKitVersionNumberWithCustomSheetPosition = 686.00000000000000;
  NSAppKitVersionNumberWithDeferredWindowDisplaySupport = 1019.0000000000000;
  NSAppKitVersionNumberWithDirectionalTabs = 631.00000000000000;
  NSAppKitVersionNumberWithDockTilePlugInSupport = 1001.0000000000000;
  NSAppKitVersionNumberWithPatternColorLeakFix = 641.00000000000000;
  NSApplicationActivateAllWindows = 1;
  NSApplicationActivateIgnoringOtherApps = 2;
  NSApplicationActivatedEventType = 1;
  NSApplicationActivationPolicyAccessory = 1;
  NSApplicationActivationPolicyProhibited = 2;
  NSApplicationActivationPolicyRegular = 0;
  NSApplicationDeactivatedEventType = 2;
  NSApplicationDefined = 15;
  NSApplicationDefinedMask = 32768;
  NSApplicationDelegateReplyCancel = 1;
  NSApplicationDelegateReplyFailure = 2;
  NSApplicationDelegateReplySuccess = 0;
  NSApplicationPresentationAutoHideDock = 1;
  NSApplicationPresentationAutoHideMenuBar = 4;
  NSApplicationPresentationDefault = 0;
  NSApplicationPresentationDisableAppleMenu = 16;
  NSApplicationPresentationDisableForceQuit = 64;
  NSApplicationPresentationDisableHideApplication = 256;
  NSApplicationPresentationDisableMenuBarTransparency = 512;
  NSApplicationPresentationDisableProcessSwitching = 32;
  NSApplicationPresentationDisableSessionTermination = 128;
  NSApplicationPresentationHideDock = 2;
  NSApplicationPresentationHideMenuBar = 8;
  NSAscendingPageOrder = 1;
  NSAtBottom = 5;
  NSAtTop = 2;
  NSAttachmentCharacter = 65532;
  NSAttributedStringEnumerationLongestEffectiveRangeNotRequired = 1048576;
  NSAttributedStringEnumerationReverse = 2;
  NSAutoPagination = 0;
  NSAutosaveOperation = 3;
  NSBMPFileType = 1;
  NSBackTabCharacter = 25;
  NSBackgroundStyleDark = 1;
  NSBackgroundStyleLight = 0;
  NSBackgroundStyleLowered = 3;
  NSBackgroundStyleRaised = 2;
  NSBackgroundTab = 1;
  NSBackingStoreBuffered = 2;
  NSBackingStoreNonretained = 1;
  NSBackingStoreRetained = 0;
  NSBackspaceCharacter = 8;
  NSBacktabTextMovement = 18;
  NSBeginFunctionKey = 63274;
  NSBelowBottom = 6;
  NSBelowTop = 3;
  NSBevelLineJoinStyle = 2;
  NSBezelBorder = 2;
  NSBlueControlTint = 1;
  NSBoldFontMask = 2;
  NSBorderlessWindowMask = 0;
  NSBottomTabsBezelBorder = 2;
  NSBoxCustom = 4;
  NSBoxOldStyle = 3;
  NSBoxPrimary = 0;
  NSBoxSecondary = 1;
  NSBoxSeparator = 2;
  NSBreakFunctionKey = 63282;
  NSBrowserAutoColumnResizing = 1;
  NSBrowserDropAbove = 1;
  NSBrowserDropOn = 0;
  NSBrowserNoColumnResizing = 0;
  NSBrowserUserColumnResizing = 2;
  NSButtLineCapStyle = 0;
  NSCMYKColorSpaceModel = 2;
  NSCMYKModeColorPanel = 2;
  NSCancelButton = 0;
  NSCancelTextMovement = 23;
  NSCarriageReturnCharacter = 13;
  NSCellAllowsMixedState = 16;
  NSCellChangesContents = 14;
  NSCellDisabled = 0;
  NSCellEditable = 3;
  NSCellHasImageHorizontal = 12;
  NSCellHasImageOnLeftOrBottom = 13;
  NSCellHasOverlappingImage = 11;
  NSCellHighlighted = 5;
  NSCellHitContentArea = 1;
  NSCellHitEditableTextArea = 2;
  NSCellHitNone = 0;
  NSCellHitTrackableArea = 4;
  NSCellIsBordered = 10;
  NSCellIsInsetButton = 15;
  NSCellLightsByBackground = 9;
  NSCellLightsByContents = 6;
  NSCellLightsByGray = 7;
  NSCellState = 1;
  NSCenterTabStopType = 2;
  NSCenterTextAlignment = 2;
  NSChangeAutosaved = 4;
  NSChangeBackgroundCell = 8;
  NSChangeBackgroundCellMask = 8;
  NSChangeCleared = 2;
  NSChangeDone = 0;
  NSChangeGrayCell = 4;
  NSChangeGrayCellMask = 4;
  NSChangeReadOtherContents = 3;
  NSChangeRedone = 5;
  NSChangeUndone = 1;
  NSCircularBezelStyle = 7;
  NSCircularSlider = 1;
  NSClearControlTint = 7;
  NSClearDisplayFunctionKey = 63290;
  NSClearLineFunctionKey = 63289;
  NSClipPagination = 2;
  NSClockAndCalendarDatePickerStyle = 1;
  NSClosableWindowMask = 2;
  NSClosePathBezierPathElement = 3;
  NSCollectionViewDropBefore = 1;
  NSCollectionViewDropOn = 0;
  NSColorListModeColorPanel = 5;
  NSColorPanelAllModesMask = 65535;
  NSColorPanelCMYKModeMask = 4;
  NSColorPanelColorListModeMask = 32;
  NSColorPanelCrayonModeMask = 128;
  NSColorPanelCustomPaletteModeMask = 16;
  NSColorPanelGrayModeMask = 1;
  NSColorPanelHSBModeMask = 8;
  NSColorPanelRGBModeMask = 2;
  NSColorPanelWheelModeMask = 64;
  NSColorRenderingIntentAbsoluteColorimetric = 1;
  NSColorRenderingIntentDefault = 0;
  NSColorRenderingIntentPerceptual = 3;
  NSColorRenderingIntentRelativeColorimetric = 2;
  NSColorRenderingIntentSaturation = 4;
  NSCommandKeyMask = 1048576;
  NSCompositeClear = 0;
  NSCompositeCopy = 1;
  NSCompositeDestinationAtop = 9;
  NSCompositeDestinationIn = 7;
  NSCompositeDestinationOut = 8;
  NSCompositeDestinationOver = 6;
  NSCompositeHighlight = 12;
  NSCompositePlusDarker = 11;
  NSCompositePlusLighter = 13;
  NSCompositeSourceAtop = 5;
  NSCompositeSourceIn = 3;
  NSCompositeSourceOut = 4;
  NSCompositeSourceOver = 2;
  NSCompositeXOR = 10;
  NSCompressedFontMask = 512;
  NSCondensedFontMask = 64;
  NSContentsCellMask = 1;
  NSContinuousCapacityLevelIndicatorStyle = 1;
  NSControlGlyph = 16777215;
  NSControlKeyMask = 262144;
  NSCrayonModeColorPanel = 7;
  NSCriticalAlertStyle = 2;
  NSCriticalRequest = 0;
  NSCursorPointingDevice = 2;
  NSCursorUpdate = 17;
  NSCursorUpdateMask = 131072;
  NSCurveToBezierPathElement = 2;
  NSCustomPaletteModeColorPanel = 4;
  NSDecimalTabStopType = 3;
  NSDefaultControlTint = 0;
  NSDefaultTokenStyle = 0;
  NSDeleteCharFunctionKey = 63294;
  NSDeleteCharacter = 127;
  NSDeleteFunctionKey = 63272;
  NSDeleteLineFunctionKey = 63292;
  NSDescendingPageOrder = -1;
  NSDeviceIndependentModifierFlagsMask = -65536;
  NSDeviceNColorSpaceModel = 4;
  NSDirectSelection = 0;
  NSDisclosureBezelStyle = 5;
  NSDiscreteCapacityLevelIndicatorStyle = 2;
  NSDisplayWindowRunLoopOrdering = 600000;
  NSDocModalWindowMask = 64;
  NSDockWindowLevel = 20;
  NSDoubleType = 6;
  NSDownArrowFunctionKey = 63233;
  NSDownTextMovement = 22;
  NSDragOperationAll = 15;
  NSDragOperationAll_Obsolete = 15;
  NSDragOperationCopy = 1;
  NSDragOperationDelete = 32;
  NSDragOperationEvery = -1;
  NSDragOperationGeneric = 4;
  NSDragOperationLink = 2;
  NSDragOperationMove = 16;
  NSDragOperationNone = 0;
  NSDragOperationPrivate = 8;
  NSDrawerClosedState = 0;
  NSDrawerClosingState = 3;
  NSDrawerOpenState = 2;
  NSDrawerOpeningState = 1;
  NSEndFunctionKey = 63275;
  NSEnterCharacter = 3;
  NSEraDatePickerElementFlag = 256;
  NSEraserPointingDevice = 3;
  NSEvenOddWindingRule = 1;
  NSEventMaskBeginGesture = 524288;
  NSEventMaskEndGesture = 1048576;
  NSEventMaskGesture = 536870912;
  NSEventMaskMagnify = 1073741824;
  NSEventMaskRotate = 262144;
  NSEventMaskSwipe = -2147483648;
  NSEventTypeBeginGesture = 19;
  NSEventTypeEndGesture = 20;
  NSEventTypeGesture = 29;
  NSEventTypeMagnify = 30;
  NSEventTypeRotate = 18;
  NSEventTypeSwipe = 31;
  NSExclude10_4ElementsIconCreationOption = 4;
  NSExcludeQuickDrawElementsIconCreationOption = 2;
  NSExecuteFunctionKey = 63298;
  NSExpandedFontMask = 32;
  NSF10FunctionKey = 63245;
  NSF11FunctionKey = 63246;
  NSF12FunctionKey = 63247;
  NSF13FunctionKey = 63248;
  NSF14FunctionKey = 63249;
  NSF15FunctionKey = 63250;
  NSF16FunctionKey = 63251;
  NSF17FunctionKey = 63252;
  NSF18FunctionKey = 63253;
  NSF19FunctionKey = 63254;
  NSF1FunctionKey = 63236;
  NSF20FunctionKey = 63255;
  NSF21FunctionKey = 63256;
  NSF22FunctionKey = 63257;
  NSF23FunctionKey = 63258;
  NSF24FunctionKey = 63259;
  NSF25FunctionKey = 63260;
  NSF26FunctionKey = 63261;
  NSF27FunctionKey = 63262;
  NSF28FunctionKey = 63263;
  NSF29FunctionKey = 63264;
  NSF2FunctionKey = 63237;
  NSF30FunctionKey = 63265;
  NSF31FunctionKey = 63266;
  NSF32FunctionKey = 63267;
  NSF33FunctionKey = 63268;
  NSF34FunctionKey = 63269;
  NSF35FunctionKey = 63270;
  NSF3FunctionKey = 63238;
  NSF4FunctionKey = 63239;
  NSF5FunctionKey = 63240;
  NSF6FunctionKey = 63241;
  NSF7FunctionKey = 63242;
  NSF8FunctionKey = 63243;
  NSF9FunctionKey = 63244;
  NSFPCurrentField = 134;
  NSFPPreviewButton = 131;
  NSFPPreviewField = 128;
  NSFPRevertButton = 130;
  NSFPSetButton = 132;
  NSFPSizeField = 129;
  NSFPSizeTitle = 133;
  NSFileHandlingPanelCancelButton = 0;
  NSFileHandlingPanelOKButton = 1;
  NSFileWrapperReadingImmediate = 1;
  NSFileWrapperReadingWithoutMapping = 2;
  NSFileWrapperWritingAtomic = 1;
  NSFileWrapperWritingWithNameUpdating = 2;
  NSFindFunctionKey = 63301;
  NSFindPanelActionNext = 2;
  NSFindPanelActionPrevious = 3;
  NSFindPanelActionReplace = 5;
  NSFindPanelActionReplaceAll = 4;
  NSFindPanelActionReplaceAllInSelection = 8;
  NSFindPanelActionReplaceAndFind = 6;
  NSFindPanelActionSelectAll = 9;
  NSFindPanelActionSelectAllInSelection = 10;
  NSFindPanelActionSetFindString = 7;
  NSFindPanelActionShowFindPanel = 1;
  NSFindPanelSubstringMatchTypeContains = 0;
  NSFindPanelSubstringMatchTypeEndsWith = 3;
  NSFindPanelSubstringMatchTypeFullWord = 2;
  NSFindPanelSubstringMatchTypeStartsWith = 1;
  NSFitPagination = 1;
  NSFixedPitchFontMask = 1024;
  NSFlagsChanged = 12;
  NSFlagsChangedMask = 4096;
  NSFloatType = 3;
  NSFloatingPointSamplesBitmapFormat = 4;
  NSFloatingWindowLevel = 3;
  NSFocusRingAbove = 2;
  NSFocusRingBelow = 1;
  NSFocusRingOnly = 0;
  NSFocusRingTypeDefault = 0;
  NSFocusRingTypeExterior = 2;
  NSFocusRingTypeNone = 1;
  NSFontAntialiasedIntegerAdvancementsRenderingMode = 3;
  NSFontAntialiasedRenderingMode = 1;
  NSFontBoldTrait = 2;
  NSFontClarendonSerifsClass = 1073741824;
  NSFontCollectionApplicationOnlyMask = 1;
  NSFontCondensedTrait = 64;
  NSFontDefaultRenderingMode = 0;
  NSFontExpandedTrait = 32;
  NSFontFamilyClassMask = -268435456;
  NSFontFreeformSerifsClass = 1879048192;
  NSFontIntegerAdvancementsRenderingMode = 2;
  NSFontItalicTrait = 1;
  NSFontModernSerifsClass = 805306368;
  NSFontMonoSpaceTrait = 1024;
  NSFontOldStyleSerifsClass = 268435456;
  NSFontOrnamentalsClass = -1879048192;
  NSFontPanelAllEffectsModeMask = 1048320;
  NSFontPanelAllModesMask = -1;
  NSFontPanelCollectionModeMask = 4;
  NSFontPanelDocumentColorEffectModeMask = 2048;
  NSFontPanelFaceModeMask = 1;
  NSFontPanelShadowEffectModeMask = 4096;
  NSFontPanelSizeModeMask = 2;
  NSFontPanelStandardModesMask = 65535;
  NSFontPanelStrikethroughEffectModeMask = 512;
  NSFontPanelTextColorEffectModeMask = 1024;
  NSFontPanelUnderlineEffectModeMask = 256;
  NSFontSansSerifClass = -2147483648;
  NSFontScriptsClass = -1610612736;
  NSFontSlabSerifsClass = 1342177280;
  NSFontSymbolicClass = -1073741824;
  NSFontTransitionalSerifsClass = 536870912;
  NSFontUIOptimizedTrait = 4096;
  NSFontUnknownClass = 0;
  NSFontVerticalTrait = 2048;
  NSFormFeedCharacter = 12;
  NSFullScreenWindowMask = 1 shl 14;
  NSFunctionKeyMask = 8388608;
  NSGIFFileType = 2;
  NSGlyphAttributeBidiLevel = 2;
  NSGlyphAttributeElastic = 1;
  NSGlyphAttributeInscribe = 5;
  NSGlyphAttributeSoft = 0;
  NSGlyphInscribeAbove = 2;
  NSGlyphInscribeBase = 0;
  NSGlyphInscribeBelow = 1;
  NSGlyphInscribeOverBelow = 4;
  NSGlyphInscribeOverstrike = 3;
  NSGradientConcaveStrong = 2;
  NSGradientConcaveWeak = 1;
  NSGradientConvexStrong = 4;
  NSGradientConvexWeak = 3;
  NSGradientDrawsAfterEndingLocation = 2;
  NSGradientDrawsBeforeStartingLocation = 1;
  NSGradientNone = 0;
  NSGraphiteControlTint = 6;
  NSGrayColorSpaceModel = 0;
  NSGrayModeColorPanel = 0;
  NSGrooveBorder = 3;
  NSHSBModeColorPanel = 3;
  NSHUDWindowMask = 8192;
  NSHeavierFontAction = 5;
  NSHelpButtonBezelStyle = 9;
  NSHelpFunctionKey = 63302;
  NSHelpKeyMask = 4194304;
  NSHighlightModeMatrix = 1;
  NSHomeFunctionKey = 63273;
  NSHorizontalRuler = 0;
  NSHourMinuteDatePickerElementFlag = 12;
  NSHourMinuteSecondDatePickerElementFlag = 14;
  NSIdentityMappingCharacterCollection = 0;
  NSIllegalTextMovement = 0;
  NSImageAbove = 5;
  NSImageAlignBottom = 5;
  NSImageAlignBottomLeft = 6;
  NSImageAlignBottomRight = 7;
  NSImageAlignCenter = 0;
  NSImageAlignLeft = 4;
  NSImageAlignRight = 8;
  NSImageAlignTop = 1;
  NSImageAlignTopLeft = 2;
  NSImageAlignTopRight = 3;
  NSImageBelow = 4;
  NSImageCacheAlways = 1;
  NSImageCacheBySize = 2;
  NSImageCacheDefault = 0;
  NSImageCacheNever = 3;
  NSImageCellType = 2;
  NSImageFrameButton = 4;
  NSImageFrameGrayBezel = 2;
  NSImageFrameGroove = 3;
  NSImageFrameNone = 0;
  NSImageFramePhoto = 1;
  NSImageInterpolationDefault = 0;
  NSImageInterpolationHigh = 3;
  NSImageInterpolationLow = 2;
  NSImageInterpolationMedium = 4;
  NSImageInterpolationNone = 1;
  NSImageLeft = 2;
  NSImageLoadStatusCancelled = 1;
  NSImageLoadStatusCompleted = 0;
  NSImageLoadStatusInvalidData = 2;
  NSImageLoadStatusReadError = 4;
  NSImageLoadStatusUnexpectedEOF = 3;
  NSImageOnly = 1;
  NSImageOverlaps = 6;
  NSImageRepLoadStatusCompleted = -6;
  NSImageRepLoadStatusInvalidData = -4;
  NSImageRepLoadStatusReadingHeader = -2;
  NSImageRepLoadStatusUnexpectedEOF = -5;
  NSImageRepLoadStatusUnknownType = -1;
  NSImageRepLoadStatusWillNeedAllData = -3;
  NSImageRepMatchesDevice = 0;
  NSImageRight = 3;
  NSImageScaleAxesIndependently = 1;
  NSImageScaleNone = 2;
  NSImageScaleProportionallyDown = 0;
  NSImageScaleProportionallyUpOrDown = 3;
  NSIndexedColorSpaceModel = 5;
  NSInformationalAlertStyle = 1;
  NSInformationalRequest = 10;
  NSInsertCharFunctionKey = 63293;
  NSInsertFunctionKey = 63271;
  NSInsertLineFunctionKey = 63291;
  NSIntType = 1;
  NSItalicFontMask = 1;
  NSJPEG2000FileType = 5;
  NSJPEGFileType = 3;
  NSJustifiedTextAlignment = 3;
  NSKeyDown = 10;
  NSKeyDownMask = 1024;
  NSKeyUp = 11;
  NSKeyUpMask = 2048;
  NSLABColorSpaceModel = 3;
  NSLandscapeOrientation = 1;
  NSLeftArrowFunctionKey = 63234;
  NSLeftMouseDown = 1;
  NSLeftMouseDownMask = 2;
  NSLeftMouseDragged = 6;
  NSLeftMouseDraggedMask = 64;
  NSLeftMouseUp = 2;
  NSLeftMouseUpMask = 4;
  NSLeftTabStopType = 0;
  NSLeftTabsBezelBorder = 1;
  NSLeftTextAlignment = 0;
  NSLeftTextMovement = 19;
  NSLighterFontAction = 6;
  NSLineBorder = 1;
  NSLineBreakByCharWrapping = 1;
  NSLineBreakByClipping = 2;
  NSLineBreakByTruncatingHead = 3;
  NSLineBreakByTruncatingMiddle = 5;
  NSLineBreakByTruncatingTail = 4;
  NSLineBreakByWordWrapping = 0;
  NSLineDoesntMove = 0;
  NSLineMovesDown = 3;
  NSLineMovesLeft = 1;
  NSLineMovesRight = 2;
  NSLineMovesUp = 4;
  NSLineSeparatorCharacter = 8232;
  NSLineSweepDown = 2;
  NSLineSweepLeft = 0;
  NSLineSweepRight = 1;
  NSLineSweepUp = 3;
  NSLineToBezierPathElement = 1;
  NSLinearSlider = 0;
  NSListModeMatrix = 2;
  NSMacintoshInterfaceStyle = 3;
  NSMainMenuWindowLevel = 24;
  NSMenuFunctionKey = 63285;
  NSMenuPropertyItemAccessibilityDescription = 32;
  NSMenuPropertyItemAttributedTitle = 2;
  NSMenuPropertyItemEnabled = 16;
  NSMenuPropertyItemImage = 8;
  NSMenuPropertyItemKeyEquivalent = 4;
  NSMenuPropertyItemTitle = 1;
  NSMiniControlSize = 2;
  NSMiniaturizableWindowMask = 4;
  NSMiterLineJoinStyle = 0;
  NSMixedState = -1;
  NSModalPanelWindowLevel = 8;
  NSModeSwitchFunctionKey = 63303;
  NSMomentaryChangeButton = 5;
  NSMomentaryLight = 7;
  NSMomentaryLightButton = 0;
  NSMomentaryPushButton = 0;
  NSMomentaryPushInButton = 7;
  NSMouseEntered = 8;
  NSMouseEnteredMask = 256;
  NSMouseEventSubtype = 0;
  NSMouseExited = 9;
  NSMouseExitedMask = 512;
  NSMouseMoved = 5;
  NSMouseMovedMask = 32;
  NSMoveToBezierPathElement = 0;
  NSNarrowFontMask = 16;
  NSNativeShortGlyphPacking = 5;
  NSNaturalTextAlignment = 4;
  NSNewlineCharacter = 10;
  NSNextFunctionKey = 63296;
  NSNextStepInterfaceStyle = 1;
  NSNoBorder = 0;
  NSNoCellMask = 0;
  NSNoFontChangeAction = 0;
  NSNoImage = 0;
  NSNoInterfaceStyle = 0;
  NSNoModeColorPanel = -1;
  NSNoScrollerParts = 0;
  NSNoTabsBezelBorder = 4;
  NSNoTabsLineBorder = 5;
  NSNoTabsNoBorder = 6;
  NSNoTitle = 0;
  NSNoUnderlineStyle = 0;
  NSNonStandardCharacterSetFontMask = 8;
  NSNonZeroWindingRule = 0;
  NSNonactivatingPanelMask = 128;
  NSNormalWindowLevel = 0;
  NSNullCellType = 0;
  NSNullGlyph = 0;
  NSNumericPadKeyMask = 2097152;
  NSOKButton = 1;
  NSOPENGL_CURRENT_VERSION = 1;
  NSOffState = 0;
  NSOnOffButton = 6;
  NSOnState = 1;
  NSOnlyScrollerArrows = 1;
  NSOpenGLCPRasterizationEnable = 221;
  NSOpenGLCPStateValidation = 301;
  NSOpenGLCPSurfaceOpacity = 236;
  NSOpenGLCPSurfaceOrder = 235;
  NSOpenGLCPSwapInterval = 222;
  NSOpenGLCPSwapRectangle = 200;
  NSOpenGLCPSwapRectangleEnable = 201;
  NSOpenGLGOClearFormatCache = 502;
  NSOpenGLGOFormatCacheSize = 501;
  NSOpenGLGOResetLibrary = 504;
  NSOpenGLGORetainRenderers = 503;
  NSOpenGLPFAAccelerated = 73;
  NSOpenGLPFAAcceleratedCompute = 97;
  NSOpenGLPFAAccumSize = 14;
  NSOpenGLPFAAllRenderers = 1;
  NSOpenGLPFAAllowOfflineRenderers = 96;
  NSOpenGLPFAAlphaSize = 11;
  NSOpenGLPFAAuxBuffers = 7;
  NSOpenGLPFAAuxDepthStencil = 57;
  NSOpenGLPFABackingStore = 76;
  NSOpenGLPFAClosestPolicy = 74;
  NSOpenGLPFAColorFloat = 58;
  NSOpenGLPFAColorSize = 8;
  NSOpenGLPFACompliant = 83;
  NSOpenGLPFADepthSize = 12;
  NSOpenGLPFADoubleBuffer = 5;
  NSOpenGLPFAFullScreen = 54;
  NSOpenGLPFAMPSafe = 78;
  NSOpenGLPFAMaximumPolicy = 52;
  NSOpenGLPFAMinimumPolicy = 51;
  NSOpenGLPFAMultiScreen = 81;
  NSOpenGLPFAMultisample = 59;
  NSOpenGLPFANoRecovery = 72;
  NSOpenGLPFAOffScreen = 53;
  NSOpenGLPFAPixelBuffer = 90;
  NSOpenGLPFARemotePixelBuffer = 91;
  NSOpenGLPFARendererID = 70;
  NSOpenGLPFARobust = 75;
  NSOpenGLPFASampleAlpha = 61;
  NSOpenGLPFASampleBuffers = 55;
  NSOpenGLPFASamples = 56;
  NSOpenGLPFAScreenMask = 84;
  NSOpenGLPFASingleRenderer = 71;
  NSOpenGLPFAStencilSize = 13;
  NSOpenGLPFAStereo = 6;
  NSOpenGLPFASupersample = 60;
  NSOpenGLPFAVirtualScreenCount = 128;
  NSOpenGLPFAWindow = 80;
  NSOtherMouseDown = 25;
  NSOtherMouseDownMask = 33554432;
  NSOtherMouseDragged = 27;
  NSOtherMouseDraggedMask = 134217728;
  NSOtherMouseUp = 26;
  NSOtherMouseUpMask = 67108864;
  NSOtherTextMovement = 0;
  NSOutlineViewDropOnItemIndex = -1;
  NSPNGFileType = 4;
  NSPageDownFunctionKey = 63277;
  NSPageUpFunctionKey = 63276;
  NSParagraphSeparatorCharacter = 8233;
  NSPasteboardReadingAsData = 0;
  NSPasteboardReadingAsKeyedArchive = 4;
  NSPasteboardReadingAsPropertyList = 2;
  NSPasteboardReadingAsString = 1;
  NSPasteboardWritingPromised = 512;
  NSPathStyleNavigationBar = 1;
  NSPathStylePopUp = 2;
  NSPathStyleStandard = 0;
  NSPatternColorSpaceModel = 6;
  NSPauseFunctionKey = 63280;
  NSPenLowerSideMask = 2;
  NSPenPointingDevice = 1;
  NSPenTipMask = 1;
  NSPenUpperSideMask = 4;
  NSPeriodic = 16;
  NSPeriodicMask = 65536;
  NSPlainTextTokenStyle = 1;
  NSPopUpArrowAtBottom = 2;
  NSPopUpArrowAtCenter = 1;
  NSPopUpMenuWindowLevel = 101;
  NSPopUpNoArrow = 0;
  NSPortraitOrientation = 0;
  NSPositiveDoubleType = 7;
  NSPositiveFloatType = 4;
  NSPositiveIntType = 2;
  NSPosterFontMask = 256;
  NSPowerOffEventType = 1;
  NSPressedTab = 2;
  NSPrevFunctionKey = 63295;
  NSPrintFunctionKey = 63288;
  NSPrintPanelShowsCopies = 1;
  NSPrintPanelShowsOrientation = 8;
  NSPrintPanelShowsPageRange = 2;
  NSPrintPanelShowsPageSetupAccessory = 256;
  NSPrintPanelShowsPaperSize = 4;
  NSPrintPanelShowsPreview = 131072;
  NSPrintPanelShowsPrintSelection = 32;
  NSPrintPanelShowsScaling = 16;
  NSPrintScreenFunctionKey = 63278;
  NSPrinterTableError = 2;
  NSPrinterTableNotFound = 1;
  NSPrinterTableOK = 0;
  NSPrintingCancelled = 0;
  NSPrintingFailure = 3;
  NSPrintingReplyLater = 2;
  NSPrintingSuccess = 1;
  NSProgressIndicatorBarStyle = 0;
  NSProgressIndicatorPreferredAquaThickness = 12;
  NSProgressIndicatorPreferredLargeThickness = 18;
  NSProgressIndicatorPreferredSmallThickness = 10;
  NSProgressIndicatorPreferredThickness = 14;
  NSProgressIndicatorSpinningStyle = 1;
  NSPushInCell = 2;
  NSPushInCellMask = 2;
  NSPushOnPushOffButton = 1;
  NSRGBColorSpaceModel = 1;
  NSRGBModeColorPanel = 1;
  NSRadioButton = 4;
  NSRadioModeMatrix = 0;
  NSRangeDateMode = 1;
  NSRatingLevelIndicatorStyle = 3;
  NSRecessedBezelStyle = 13;
  NSRedoFunctionKey = 63300;
  NSRegularControlSize = 0;
  NSRegularSquareBezelStyle = 2;
  NSRelevancyLevelIndicatorStyle = 0;
  NSRemoveTraitFontAction = 7;
  NSResetCursorRectsRunLoopOrdering = 700000;
  NSResetFunctionKey = 63283;
  NSResizableWindowMask = 8;
  NSReturnTextMovement = 16;
  NSRightArrowFunctionKey = 63235;
  NSRightMouseDown = 3;
  NSRightMouseDownMask = 8;
  NSRightMouseDragged = 7;
  NSRightMouseDraggedMask = 128;
  NSRightMouseUp = 4;
  NSRightMouseUpMask = 16;
  NSRightTabStopType = 1;
  NSRightTabsBezelBorder = 3;
  NSRightTextAlignment = 1;
  NSRightTextMovement = 20;
  NSRoundLineCapStyle = 1;
  NSRoundLineJoinStyle = 1;
  NSRoundRectBezelStyle = 12;
  NSRoundedBezelStyle = 1;
  NSRoundedDisclosureBezelStyle = 14;
  NSRoundedTokenStyle = 2;
  NSRuleEditorNestingModeCompound = 2;
  NSRuleEditorNestingModeList = 1;
  NSRuleEditorNestingModeSimple = 3;
  NSRuleEditorNestingModeSingle = 0;
  NSRuleEditorRowTypeCompound = 1;
  NSRuleEditorRowTypeSimple = 0;
  NSRunAbortedResponse = -1001;
  NSRunContinuesResponse = -1002;
  NSRunStoppedResponse = -1000;
  NSSaveAsOperation = 1;
  NSSaveOperation = 0;
  NSSaveToOperation = 2;
  NSScaleNone = 2;
  NSScaleProportionally = 0;
  NSScaleToFit = 1;
  NSScreenChangedEventType = 8;
  NSScreenSaverWindowLevel = 1000;
  NSScrollLockFunctionKey = 63279;
  NSScrollWheel = 22;
  NSScrollWheelMask = 4194304;
  NSScrollerArrowsDefaultSetting = 0;
  NSScrollerArrowsMaxEnd = 0;
  NSScrollerArrowsMinEnd = 1;
  NSScrollerArrowsNone = 2;
  NSScrollerDecrementArrow = 1;
  NSScrollerDecrementLine = 4;
  NSScrollerDecrementPage = 1;
  NSScrollerIncrementArrow = 0;
  NSScrollerIncrementLine = 5;
  NSScrollerIncrementPage = 3;
  NSScrollerKnob = 2;
  NSScrollerKnobSlot = 6;
  NSScrollerNoPart = 0;
  NSSearchFieldClearRecentsMenuItemTag = 1002;
  NSSearchFieldNoRecentsMenuItemTag = 1003;
  NSSearchFieldRecentsMenuItemTag = 1001;
  NSSearchFieldRecentsTitleMenuItemTag = 1000;
  NSSegmentStyleAutomatic = 0;
  NSSegmentStyleCapsule = 5;
  NSSegmentStyleRoundRect = 3;
  NSSegmentStyleRounded = 1;
  NSSegmentStyleSmallSquare = 6;
  NSSegmentStyleTexturedRounded = 2;
  NSSegmentStyleTexturedSquare = 4;
  NSSegmentSwitchTrackingMomentary = 2;
  NSSegmentSwitchTrackingSelectAny = 1;
  NSSegmentSwitchTrackingSelectOne = 0;
  NSSelectByCharacter = 0;
  NSSelectByParagraph = 2;
  NSSelectByWord = 1;
  NSSelectFunctionKey = 63297;
  NSSelectedTab = 0;
  NSSelectingNext = 1;
  NSSelectingPrevious = 2;
  NSSelectionAffinityDownstream = 1;
  NSSelectionAffinityUpstream = 0;
  NSServiceApplicationLaunchFailedError = 66561;
  NSServiceApplicationNotFoundError = 66560;
  NSServiceErrorMaximum = 66817;
  NSServiceErrorMinimum = 66560;
  NSServiceInvalidPasteboardDataError = 66563;
  NSServiceMalformedServiceDictionaryError = 66564;
  NSServiceMiscellaneousError = 66800;
  NSServiceRequestTimedOutError = 66562;
  NSShadowlessSquareBezelStyle = 6;
  NSShiftKeyMask = 131072;
  NSShowControlGlyphs = 1;
  NSShowInvisibleGlyphs = 2;
  NSSingleDateMode = 0;
  NSSingleUnderlineStyle = 1;
  NSSizeDownFontAction = 4;
  NSSizeUpFontAction = 3;
  NSSmallCapsFontMask = 128;
  NSSmallControlSize = 1;
  NSSmallIconButtonBezelStyle = 2;
  NSSmallSquareBezelStyle = 10;
  NSSpecialPageOrder = 0;
  NSSpeechImmediateBoundary = 0;
  NSSpeechSentenceBoundary = 2;
  NSSpeechWordBoundary = 1;
  NSSpellingStateGrammarFlag = 2;
  NSSpellingStateSpellingFlag = 1;
  NSSplitViewDividerStylePaneSplitter = 3;
  NSSplitViewDividerStyleThick = 1;
  NSSplitViewDividerStyleThin = 2;
  NSSquareLineCapStyle = 2;
  NSSquareStatusItemLength = -2;
  NSStatusWindowLevel = 25;
  NSStopFunctionKey = 63284;
  NSStringDrawingDisableScreenFontSubstitution = 4;
  NSStringDrawingOneShot = 16;
  NSStringDrawingTruncatesLastVisibleLine = 32;
  NSStringDrawingUsesDeviceMetrics = 8;
  NSStringDrawingUsesFontLeading = 2;
  NSStringDrawingUsesLineFragmentOrigin = 1;
  NSSubmenuWindowLevel = 3;
  NSSwitchButton = 3;
  NSSysReqFunctionKey = 63281;
  NSSystemDefined = 14;
  NSSystemDefinedMask = 16384;
  NSSystemFunctionKey = 63287;
  NSTIFFCompressionCCITTFAX3 = 3;
  NSTIFFCompressionCCITTFAX4 = 4;
  NSTIFFCompressionJPEG = 6;
  NSTIFFCompressionLZW = 5;
  NSTIFFCompressionNEXT = 32766;
  NSTIFFCompressionNone = 1;
  NSTIFFCompressionOldJPEG = 32865;
  NSTIFFCompressionPackBits = 32773;
  NSTIFFFileType = 0;
  NSTabCharacter = 9;
  NSTabTextMovement = 17;
  NSTableColumnAutoresizingMask = 1;
  NSTableColumnNoResizing = 0;
  NSTableColumnUserResizingMask = 2;
  NSTableViewDraggingDestinationFeedbackStyleNone = -1;
  NSTableViewDraggingDestinationFeedbackStyleRegular = 0;
  NSTableViewDraggingDestinationFeedbackStyleSourceList = 1;
  NSTableViewDropAbove = 1;
  NSTableViewDropOn = 0;
  NSTableViewFirstColumnOnlyAutoresizingStyle = 5;
  NSTableViewGridNone = 0;
  NSTableViewLastColumnOnlyAutoresizingStyle = 4;
  NSTableViewNoColumnAutoresizing = 0;
  NSTableViewReverseSequentialColumnAutoresizingStyle = 3;
  NSTableViewSelectionHighlightStyleNone = -1;
  NSTableViewSelectionHighlightStyleRegular = 0;
  NSTableViewSelectionHighlightStyleSourceList = 1;
  NSTableViewSequentialColumnAutoresizingStyle = 2;
  NSTableViewSolidHorizontalGridLineMask = 2;
  NSTableViewSolidVerticalGridLineMask = 1;
  NSTableViewUniformColumnAutoresizingStyle = 1;
  NSTabletPoint = 23;
  NSTabletPointEventSubtype = 1;
  NSTabletPointMask = 8388608;
  NSTabletProximity = 24;
  NSTabletProximityEventSubtype = 2;
  NSTabletProximityMask = 16777216;
  NSTerminateCancel = 0;
  NSTerminateLater = 2;
  NSTerminateNow = 1;
  NSTextBlockAbsoluteValueType = 0;
  NSTextBlockBaselineAlignment = 3;
  NSTextBlockBorder = 0;
  NSTextBlockBottomAlignment = 2;
  NSTextBlockHeight = 4;
  NSTextBlockMargin = 1;
  NSTextBlockMaximumHeight = 6;
  NSTextBlockMaximumWidth = 2;
  NSTextBlockMiddleAlignment = 1;
  NSTextBlockMinimumHeight = 5;
  NSTextBlockMinimumWidth = 1;
  NSTextBlockPadding = -1;
  NSTextBlockPercentageValueType = 1;
  NSTextBlockTopAlignment = 0;
  NSTextBlockWidth = 0;
  NSTextCellType = 1;
  NSTextFieldAndStepperDatePickerStyle = 0;
  NSTextFieldDatePickerStyle = 2;
  NSTextFieldRoundedBezel = 1;
  NSTextFieldSquareBezel = 0;
  NSTextListPrependEnclosingMarker = 1;
  NSTextReadInapplicableDocumentTypeError = 65806;
  NSTextReadWriteErrorMaximum = 66303;
  NSTextReadWriteErrorMinimum = 65792;
  NSTextStorageEditedAttributes = 1;
  NSTextStorageEditedCharacters = 2;
  NSTextTableAutomaticLayoutAlgorithm = 0;
  NSTextTableFixedLayoutAlgorithm = 1;
  NSTextWriteInapplicableDocumentTypeError = 66062;
  NSTextWritingDirectionEmbedding = 0;
  NSTextWritingDirectionOverride = 2;
  NSTexturedBackgroundWindowMask = 256;
  NSTexturedRoundedBezelStyle = 11;
  NSTexturedSquareBezelStyle = 8;
  NSThickSquareBezelStyle = 3;
  NSThickerSquareBezelStyle = 4;
  NSTickMarkAbove = 1;
  NSTickMarkBelow = 0;
  NSTickMarkLeft = 1;
  NSTickMarkRight = 0;
  NSTimeZoneDatePickerElementFlag = 16;
  NSTitledWindowMask = 1;
  NSToggleButton = 2;
  NSToolbarDisplayModeDefault = 0;
  NSToolbarDisplayModeIconAndLabel = 1;
  NSToolbarDisplayModeIconOnly = 2;
  NSToolbarDisplayModeLabelOnly = 3;
  NSToolbarItemVisibilityPriorityHigh = 1000;
  NSToolbarItemVisibilityPriorityLow = -1000;
  NSToolbarItemVisibilityPriorityStandard = 0;
  NSToolbarItemVisibilityPriorityUser = 2000;
  NSToolbarSizeModeDefault = 0;
  NSToolbarSizeModeRegular = 1;
  NSToolbarSizeModeSmall = 2;
  NSTopTabsBezelBorder = 0;
  NSTornOffMenuWindowLevel = 3;
  NSTouchEventSubtype = 3;
  NSTouchPhaseAny = -1;
  NSTouchPhaseBegan = 1;
  NSTouchPhaseCancelled = 16;
  NSTouchPhaseEnded = 8;
  NSTouchPhaseMoved = 2;
  NSTouchPhaseStationary = 4;
  NSTouchPhaseTouching = 7;
  NSTrackModeMatrix = 3;
  NSTrackingActiveAlways = 128;
  NSTrackingActiveInActiveApp = 64;
  NSTrackingActiveInKeyWindow = 32;
  NSTrackingActiveWhenFirstResponder = 16;
  NSTrackingAssumeInside = 256;
  NSTrackingCursorUpdate = 4;
  NSTrackingEnabledDuringMouseDrag = 1024;
  NSTrackingInVisibleRect = 512;
  NSTrackingMouseEnteredAndExited = 1;
  NSTrackingMouseMoved = 2;
  NSTypesetterBehavior_10_2 = 2;
  NSTypesetterBehavior_10_2_WithCompatibility = 1;
  NSTypesetterBehavior_10_3 = 3;
  NSTypesetterBehavior_10_4 = 4;
  NSTypesetterContainerBreakAction = 32;
  NSTypesetterHorizontalTabAction = 4;
  NSTypesetterLatestBehavior = -1;
  NSTypesetterLineBreakAction = 8;
  NSTypesetterOriginalBehavior = 0;
  NSTypesetterParagraphBreakAction = 16;
  NSTypesetterWhitespaceAction = 2;
  NSTypesetterZeroAdvancementAction = 1;
  NSUnboldFontMask = 4;
  NSUnderlinePatternDash = 512;
  NSUnderlinePatternDashDot = 768;
  NSUnderlinePatternDashDotDot = 1024;
  NSUnderlinePatternDot = 256;
  NSUnderlinePatternSolid = 0;
  NSUnderlineStyleDouble = 9;
  NSUnderlineStyleNone = 0;
  NSUnderlineStyleSingle = 1;
  NSUnderlineStyleThick = 2;
  NSUndoFunctionKey = 63299;
  NSUnifiedTitleAndToolbarWindowMask = 4096;
  NSUnitalicFontMask = 16777216;
  NSUnknownColorSpaceModel = -1;
  NSUnknownPageOrder = 2;
  NSUnknownPointingDevice = 0;
  NSUnscaledWindowMask = 2048;
  NSUpArrowFunctionKey = 63232;
  NSUpTextMovement = 21;
  NSUpdateWindowsRunLoopOrdering = 500000;
  NSUserFunctionKey = 63286;
  NSUserInterfaceLayoutDirectionLeftToRight = 0;
  NSUserInterfaceLayoutDirectionRightToLeft = 1;
  NSUtilityWindowMask = 16;
  NSVariableStatusItemLength = -1;
  NSVerticalRuler = 1;
  NSViaPanelFontAction = 1;
  NSViewHeightSizable = 16;
  NSViewLayerContentsPlacementBottom = 8;
  NSViewLayerContentsPlacementBottomLeft = 9;
  NSViewLayerContentsPlacementBottomRight = 7;
  NSViewLayerContentsPlacementCenter = 3;
  NSViewLayerContentsPlacementLeft = 10;
  NSViewLayerContentsPlacementRight = 6;
  NSViewLayerContentsPlacementScaleAxesIndependently = 0;
  NSViewLayerContentsPlacementScaleProportionallyToFill = 2;
  NSViewLayerContentsPlacementScaleProportionallyToFit = 1;
  NSViewLayerContentsPlacementTop = 4;
  NSViewLayerContentsPlacementTopLeft = 11;
  NSViewLayerContentsPlacementTopRight = 5;
  NSViewLayerContentsRedrawBeforeViewResize = 3;
  NSViewLayerContentsRedrawDuringViewResize = 2;
  NSViewLayerContentsRedrawNever = 0;
  NSViewLayerContentsRedrawOnSetNeedsDisplay = 1;
  NSViewMaxXMargin = 4;
  NSViewMaxYMargin = 32;
  NSViewMinXMargin = 1;
  NSViewMinYMargin = 8;
  NSViewNotSizable = 0;
  NSViewWidthSizable = 2;
  NSWantsBidiLevels = 4;
  NSWarningAlertStyle = 0;
  NSWheelModeColorPanel = 6;
  NSWindowAbove = 1;
  NSWindowBackingLocationDefault = 0;
  NSWindowBackingLocationMainMemory = 2;
  NSWindowBackingLocationVideoMemory = 1;
  NSWindowBelow = -1;
  NSWindowCloseButton = 0;
  NSWindowCollectionBehaviorCanJoinAllSpaces = 1;
  NSWindowCollectionBehaviorDefault = 0;
  NSWindowCollectionBehaviorIgnoresCycle = 64;
  NSWindowCollectionBehaviorManaged = 4;
  NSWindowCollectionBehaviorMoveToActiveSpace = 2;
  NSWindowCollectionBehaviorParticipatesInCycle = 32;
  NSWindowCollectionBehaviorStationary = 16;
  NSWindowCollectionBehaviorTransient = 8;
  NSWindowCollectionBehaviorFullScreenPrimary = 128;
  NSWindowCollectionBehaviorFullScreenAuxiliary = 256;
  NSWindowDepthOnehundredtwentyeightBitRGB = 544;
  NSWindowDepthSixtyfourBitRGB = 528;
  NSWindowDepthTwentyfourBitRGB = 520;
  NSWindowDocumentIconButton = 4;
  NSWindowExposedEventType = 0;
  NSWindowMiniaturizeButton = 1;
  NSWindowMovedEventType = 4;
  NSWindowNumberListAllApplications = 1;
  NSWindowNumberListAllSpaces = 16;
  NSWindowOut = 0;
  NSWindowSharingNone = 0;
  NSWindowSharingReadOnly = 1;
  NSWindowSharingReadWrite = 2;
  NSWindowToolbarButton = 3;
  NSWindowZoomButton = 2;
  NSWindows95InterfaceStyle = 2;
  NSWorkspaceLaunchAllowingClassicStartup = 131072;
  NSWorkspaceLaunchAndHide = 1048576;
  NSWorkspaceLaunchAndHideOthers = 2097152;
  NSWorkspaceLaunchAndPrint = 2;
  NSWorkspaceLaunchAsync = 65536;
  NSWorkspaceLaunchDefault = 196608;
  NSWorkspaceLaunchInhibitingBackgroundOnly = 128;
  NSWorkspaceLaunchNewInstance = 524288;
  NSWorkspaceLaunchPreferringClassic = 262144;
  NSWorkspaceLaunchWithoutActivation = 512;
  NSWorkspaceLaunchWithoutAddingToRecents = 256;
  NSWritingDirectionLeftToRight = 0;
  NSWritingDirectionNatural = -1;
  NSWritingDirectionRightToLeft = 1;
  NSYearMonthDatePickerElementFlag = 192;
  NSYearMonthDayDatePickerElementFlag = 224;

type
{$M+}
// ===== Forward declarations =====

  NSMenuItem = interface;
  NSTextContainer = interface;
  NSMovie = interface;
  NSTextList = interface;
  NSTextInputContext = interface;
  NSMenu = interface;
  NSOpenGLLayer = interface;
  NSOpenGLPixelBuffer = interface;
  NSOpenGLPixelFormat = interface;
  NSNib = interface;
  NSNibConnector = interface;
  NSOpenGLContext = interface;
  NSLayoutManager = interface;
  NSGlyphGenerator = interface;
  NSGlyphInfo = interface;
  NSGradient = interface;
  NSFontDescriptor = interface;
  NSFontManager = interface;
  NSTextTab = interface;
  NSImageRep = interface;
  NSInputManager = interface;
  NSInputServer = interface;
  NSGraphicsContext = interface;
  NSHelpManager = interface;
  NSImage = interface;
  NSResponder = interface;
  NSRulerMarker = interface;
  NSSpellChecker = interface;
  NSPrintPanel = interface;
  NSPrinter = interface;
  NSStatusBar = interface;
  NSSpeechRecognizer = interface;
  NSSound = interface;
  NSShadow = interface;
  NSRunningApplication = interface;
  NSSpeechSynthesizer = interface;
  NSScreen = interface;
  NSPrintOperation = interface;
  NSParagraphStyle = interface;
  NSPasteboard = interface;
  NSPasteboardItem = interface;
  NSTextBlock = interface;
  NSTextAttachment = interface;
  NSPageLayout = interface;
  NSStatusItem = interface;
  NSPredicateEditorRowTemplate = interface;
  NSPrintInfo = interface;
  NSTableColumn = interface;
  NSTabViewItem = interface;
  NSTreeNode = interface;
  NSCell = interface;
  NSWorkspace = interface;
  NSColorSpace = interface;
  NSTouch = interface;
  NSController = interface;
  NSTrackingArea = interface;
  NSColor = interface;
  NSColorList = interface;
  NSTypesetter = interface;
  NSColorPicker = interface;
  NSBezierPath = interface;
  NSEvent = interface;
  NSDocumentController = interface;
  NSDocument = interface;
  NSFont = interface;
  NSFileWrapper = interface;
  NSDockTile = interface;
  NSAlert = interface;
  NSToolbarItem = interface;
  NSAnimation = interface;
  NSCursor = interface;
  NSAnimationContext = interface;
  NSAffineTransform = interface;
  NSToolbar = interface;
  NSPersistentDocument = interface;
  NSViewController = interface;
  NSCIImageRep = interface;
  NSViewAnimation = interface;
  NSBrowserCell = interface;
  NSApplication = interface;
  NSActionCell = interface;
  NSATSTypesetter = interface;
  NSWindow = interface;
  NSWindowController = interface;
  NSBitmapImageRep = interface;
  NSCustomImageRep = interface;
  NSToolbarItemGroup = interface;
  NSNibControlConnector = interface;
  NSMutableParagraphStyle = interface;
  NSTextTable = interface;
  NSTextTableBlock = interface;
  NSEPSImageRep = interface;
  NSImageCell = interface;
  NSDrawer = interface;
  NSNibOutletConnector = interface;
  NSCachedImageRep = interface;
  NSPICTImageRep = interface;
  NSView = interface;
  NSObjectController = interface;
  NSUserDefaultsController = interface;
  NSPDFImageRep = interface;
  NSSegmentedCell = interface;
  NSSliderCell = interface;
  NSTableHeaderView = interface;
  NSTabView = interface;
  NSTextFieldCell = interface;
  NSTreeController = interface;
  NSStepperCell = interface;
  NSTextStorage = interface;
  NSText = interface;
  NSSplitView = interface;
  NSFormCell = interface;
  NSOpenGLView = interface;
  NSCollectionViewItem = interface;
  NSProgressIndicator = interface;
  NSPathCell = interface;
  NSPanel = interface;
  NSControl = interface;
  NSDatePickerCell = interface;
  NSRulerView = interface;
  NSButtonCell = interface;
  NSBox = interface;
  NSLevelIndicatorCell = interface;
  NSClipView = interface;
  NSScrollView = interface;
  NSCollectionView = interface;
  NSArrayController = interface;
  NSTextView = interface;
  NSImageView = interface;
  NSLevelIndicator = interface;
  NSFontPanel = interface;
  NSTokenFieldCell = interface;
  NSColorPanel = interface;
  NSButton = interface;
  NSBrowser = interface;
  NSColorWell = interface;
  NSDictionaryController = interface;
  NSDatePicker = interface;
  NSComboBoxCell = interface;
  NSPathControl = interface;
  NSPathComponentCell = interface;
  NSTableHeaderCell = interface;
  NSScroller = interface;
  NSRuleEditor = interface;
  NSStepper = interface;
  NSSavePanel = interface;
  NSTableView = interface;
  NSSecureTextFieldCell = interface;
  NSMenuItemCell = interface;
  NSTextField = interface;
  NSMatrix = interface;
  NSSlider = interface;
  NSSearchFieldCell = interface;
  NSSegmentedControl = interface;
  NSSearchField = interface;
  NSOutlineView = interface;
  NSTokenField = interface;
  NSForm = interface;
  NSOpenPanel = interface;
  NSComboBox = interface;
  NSPredicateEditor = interface;
  NSPopUpButton = interface;
  NSPopUpButtonCell = interface;

// ==== Protocols ====

  NSAlertDelegate = interface(IObjectiveC)
    ['{78730931-F085-4942-867B-D60DBF95695B}']

  end;

  NSAnimationDelegate = interface(IObjectiveC)
    ['{3DCE2AFC-AEF5-4F64-A71E-C1916182DB79}']
  end;

  NSApplicationDelegate = interface(IObjectiveC)
    ['{D969EDA7-24F6-4F20-A202-D4D2734CB103}']
    procedure applicationWillTerminate(Notification: Pointer); cdecl;
    procedure applicationDidFinishLaunching(Notification: Pointer); cdecl;
  end;

  NSBrowserDelegate = interface(IObjectiveC)
    ['{CECED08C-A792-45DC-990A-E18481331D14}']
  end;

  NSCollectionViewDelegate = interface(IObjectiveC)
    ['{89EE1398-9136-461B-8789-9AE68EBAD6B1}']
  end;

  NSComboBoxCellDataSource = interface(IObjectiveC)
    ['{302ED6EC-0CCD-47E4-B34F-22E968B730B9}']
  end;

  NSComboBoxDataSource = interface(IObjectiveC)
    ['{5657827A-78E0-4105-BD6B-AE547BC2ECE2}']
  end;

  NSComboBoxDelegate = interface(IObjectiveC)
    ['{A6891F91-B186-4332-983F-7FEEA72D4ED0}']
  end;

  NSCopying = interface(IObjectiveC)
    ['{D827BCCB-7610-4188-B5DB-81361C52669D}']
  end;

  NSDatePickerCellDelegate = interface(IObjectiveC)
    ['{96077376-EBB8-4B70-A1A6-D628B4B86FEC}']
  end;

  // NSDraggingInfo is really a protocol, not a class. It is represented here as
  // a class as a temporary workaround. Do not try to instantiate this.
  NSDraggingInfoClass = interface(NSObjectClass)
    ['{691D6FAA-2420-4E7A-BE64-5DCEBF95D855}']
  end;
  NSDraggingInfo = interface(IObjectiveCInstance)
    ['{44E96ED5-AB53-4DA7-BDC2-CE6EFFB49CD6}']
    function draggingPasteboard: NSPasteboard; cdecl;
    function draggingLocation: NSPoint; cdecl;
  end;
  TNSDraggingInfo = class(TOCGenericImport<NSDraggingInfoClass, NSDraggingInfo>)  end;

  NSDrawerDelegate = interface(IObjectiveC)
    ['{7F0ED3B1-6EFD-4EBA-9EB0-D01DE12F2505}']
  end;

  NSGlyphStorage = interface(IObjectiveC)
    ['{34E2AA38-A632-424D-A838-C81FB5954C09}']
  end;

  NSImageDelegate = interface(IObjectiveC)
    ['{26769406-B992-4119-A8D6-14782A1FE19B}']
  end;

  NSLayoutManagerDelegate = interface(IObjectiveC)
    ['{F82B6219-0757-4AA3-89B2-A60DF0792BDD}']
  end;

  NSMatrixDelegate = interface(IObjectiveC)
    ['{E0252E75-4968-43A3-956A-7C16CA89A176}']
  end;

  NSMenuDelegate = interface(IObjectiveC)
    ['{E06A67CB-3A9C-4AFD-AA57-51D146E13621}']
  end;

  NSOpenSavePanelDelegate = interface(IObjectiveC)
    ['{F3C00D17-2CEF-4B9C-ACE9-72D8AA6225E3}']
  end;

  NSOutlineViewDataSource = interface(IObjectiveC)
    ['{51966186-6B63-4E05-897C-3AF1B957AED7}']
  end;

  NSOutlineViewDelegate = interface(IObjectiveC)
    ['{EBAF64B7-8CE3-4670-B579-7C3E05EBB140}']
  end;

  NSPasteboardItemDataProvider = interface(IObjectiveC)
    ['{BD2BDE4E-3D39-4FB3-8582-C6D7893E0CAC}']
  end;

  NSPathCellDelegate = interface(IObjectiveC)
    ['{01C3AEDE-C6DC-4E26-8124-743657C95F42}']
  end;

  NSPathControlDelegate = interface(IObjectiveC)
    ['{F22E8638-518A-47B0-A044-5E960695613A}']
  end;

  NSRuleEditorDelegate = interface(IObjectiveC)
    ['{42F7EB15-8536-4B93-A1BB-FEA54E4CE238}']
  end;

  NSSoundDelegate = interface(IObjectiveC)
    ['{D2929362-E82A-4BCA-AA79-34D9760DCDEF}']
  end;

  NSSpeechRecognizerDelegate = interface(IObjectiveC)
    ['{4F1C5755-F489-43A3-B2BD-4618EFED1E95}']
  end;

  NSSpeechSynthesizerDelegate = interface(IObjectiveC)
    ['{F6F2FF53-8E33-4F53-B333-79C2123A49D2}']
  end;

  NSSplitViewDelegate = interface(IObjectiveC)
    ['{E229ECBF-49C5-494E-9D66-3BE99FD1FF56}']
  end;

  NSTabViewDelegate = interface(IObjectiveC)
    ['{B4A2AC31-102E-4BF9-8340-D0622EE3F418}']
  end;

  NSTableViewDataSource = interface(IObjectiveC)
    ['{901A6CC5-283B-43BA-872F-D72CEDAD5F97}']
  end;

  NSTableViewDelegate = interface(IObjectiveC)
    ['{2E9785AC-B8F0-4511-B534-3D9680D2BD6E}']
  end;

  NSTextAttachmentCell = interface(IObjectiveC)
    ['{6661DB32-43CB-412C-8ED3-033E2B28B0EF}']
  end;

  NSTextDelegate = interface(IObjectiveC)
    ['{D8399FC4-C15B-4769-9AC5-4053CAFDE004}']
  end;

  NSTextFieldDelegate = interface(IObjectiveC)
    ['{9AF2B672-26E6-4B85-8E21-B727BCAFAB14}']
  end;

  NSTextInputClient = interface(IObjectiveC)
    ['{A5B51DB0-28AF-4C30-B563-69246EC88BB2}']
    procedure insertText(text: Pointer {NSString}; replacementRange: NSRange); cdecl;
    procedure doCommandBySelector(selector: SEL); cdecl;
    procedure setMarkedText(text: Pointer {NSString}; selectedRange: NSRange; replacementRange: NSRange); cdecl;
    procedure unMarkText; cdecl;
    function selectedRange: NSRange; cdecl;
    function markedRange: NSRange; cdecl;
    function hasMarkedText: Boolean; cdecl;
    function attributedSubstringForProposedRange(aRange: NSRange; actualRange: PNSRange): NSAttributedString; cdecl;
    function validAttributesForMarkedText: Pointer {NSArray}; cdecl;
    function firstRectForCharacterRange(aRange: NSRange; actualRange: PNSRange): NSRect; cdecl;
    function characterIndexForPoint(aPoint: NSPoint): NSUInteger; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function fractionOfDistanceThroughGlyphForPoint(aPoint: NSPoint): CGFloat; cdecl;
    function baselineDeltaForCharacterAtIndex(anIndex: NSUInteger): CGFloat; cdecl;
    function windowLevel: NSInteger; cdecl;
    function drawsVerticallyForCharacterAtIndex(charIndex: NSUInteger): Boolean; cdecl;
  end;

  NSTextStorageDelegate = interface(IObjectiveC)
    ['{A535EC7E-1A5B-4056-9761-AE6AFE4CDC34}']
  end;

  NSTextViewDelegate = interface(IObjectiveC)
    ['{75A57C63-5A88-495B-A4E4-C64C6C0B55D8}']
  end;

  NSTokenFieldCellDelegate = interface(IObjectiveC)
    ['{B05E2732-7245-4E3B-861F-92ED37D5EDF7}']
  end;

  NSTokenFieldDelegate = interface(IObjectiveC)
    ['{6E7494BD-9B5B-486E-81CD-75E061E289CD}']
  end;

  NSToolbarDelegate = interface(IObjectiveC)
    ['{6685EA2E-26C1-48DE-B57E-761A34EBBD26}']
  end;

  NSValidatedUserInterfaceItem = interface(IObjectiveC)
    ['{3618EFA3-999A-4416-BFF3-E258BB2A8667}']
  end;

  NSWindowDelegate = interface(IObjectiveC)
    ['{C5A86D0B-B835-4CC3-B7D8-478C73BA1472}']
    function windowShouldClose(Sender: Pointer {id}): Boolean; cdecl;
    procedure windowWillClose(notification: NSNotification); cdecl;
    procedure windowDidBecomeKey(notification: NSNotification); cdecl;
    procedure windowDidResignKey(notification: NSNotification); cdecl;
    procedure windowDidResize(notification: NSNotification); cdecl;
    procedure windowDidMove(notification: NSNotification); cdecl;
    procedure windowDidChangeBackingProperties(notification: NSNotification); cdecl; // OS X 10.7+
  end;

// ===== Interface declarations =====

  NSMenuItemClass = interface(NSObjectClass)
    ['{29EAC351-981B-40F1-B0FB-B5F0136B5CF9}']
    {class} function separatorItem: Pointer; cdecl;
    {class} procedure setUsesUserKeyEquivalents(flag: Boolean); cdecl;
    {class} function usesUserKeyEquivalents: Boolean; cdecl;
  end;
  NSMenuItem = interface(NSObject)
    ['{0811DAFB-297C-452B-B90E-13A7BF7B2506}']
    function action: SEL; cdecl;
    function attributedTitle: NSAttributedString; cdecl;
    function hasSubmenu: Boolean; cdecl;
    function image: NSImage; cdecl;
    function indentationLevel: NSInteger; cdecl;
    function initWithTitle(aString: NSString; action: SEL; keyEquivalent: NSString): Pointer; cdecl;
    function isAlternate: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isHiddenOrHasHiddenAncestor: Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isSeparatorItem: Boolean; cdecl;
    function keyEquivalent: NSString; cdecl;
    function keyEquivalentModifierMask: NSUInteger; cdecl;
    function menu: NSMenu; cdecl;
    function mixedStateImage: NSImage; cdecl;
    function mnemonic: NSString; cdecl;
    function mnemonicLocation: NSUInteger; cdecl;
    function offStateImage: NSImage; cdecl;
    function onStateImage: NSImage; cdecl;
    function parentItem: NSMenuItem; cdecl;
    function representedObject: Pointer; cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setAlternate(isAlternate: Boolean); cdecl;
    procedure setAttributedTitle(string_: NSAttributedString); cdecl;
    procedure setEnabled(flag: Boolean); cdecl;
    procedure setHidden(hidden: Boolean); cdecl;
    procedure setImage(menuImage: NSImage); cdecl;
    procedure setIndentationLevel(indentationLevel: NSInteger); cdecl;
    procedure setKeyEquivalent(aKeyEquivalent: NSString); cdecl;
    procedure setKeyEquivalentModifierMask(mask: NSUInteger); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setMixedStateImage(image: NSImage); cdecl;
    procedure setMnemonicLocation(location: NSUInteger); cdecl;
    procedure setOffStateImage(image: NSImage); cdecl;
    procedure setOnStateImage(image: NSImage); cdecl;
    procedure setRepresentedObject(anObject: Pointer); cdecl;
    procedure setState(state: NSInteger); cdecl;
    procedure setSubmenu(submenu: NSMenu); cdecl;
    procedure setTag(anInt: NSInteger); cdecl;
    procedure setTarget(anObject: Pointer); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setToolTip(toolTip: NSString); cdecl;
    procedure setView(view: NSView); cdecl;
    function state: NSInteger; cdecl;
    function submenu: NSMenu; cdecl;
    function tag: NSInteger; cdecl;
    function target: Pointer; cdecl;
    function title: NSString; cdecl;
    function toolTip: NSString; cdecl;
    function userKeyEquivalent: NSString; cdecl;
    function view: NSView; cdecl;
  end;
  TNSMenuItem = class(TOCGenericImport<NSMenuItemClass, NSMenuItem>)  end;

  NSTextContainerClass = interface(NSObjectClass)
    ['{76FC0807-D297-4A5C-A439-C9D881EC83B5}']
  end;
  NSTextContainer = interface(NSObject)
    ['{B2A0C26E-E652-405C-984D-0445CCA979FD}']
    function containerSize: NSSize; cdecl;
    function containsPoint(point: NSPoint): Boolean; cdecl;
    function heightTracksTextView: Boolean; cdecl;
    function initWithContainerSize(size: NSSize): Pointer; cdecl;
    function isSimpleRectangularTextContainer: Boolean; cdecl;
    function layoutManager: NSLayoutManager; cdecl;
    function lineFragmentPadding: Single; cdecl;
    function lineFragmentRectForProposedRect(proposedRect: NSRect; sweepDirection: NSLineSweepDirection; movementDirection: NSLineMovementDirection; remainingRect: NSRectPointer): NSRect; cdecl;
    procedure replaceLayoutManager(newLayoutManager: NSLayoutManager); cdecl;
    procedure setContainerSize(size: NSSize); cdecl;
    procedure setHeightTracksTextView(flag: Boolean); cdecl;
    procedure setLayoutManager(layoutManager: NSLayoutManager); cdecl;
    procedure setLineFragmentPadding(pad: Single); cdecl;
    procedure setTextView(textView: NSTextView); cdecl;
    procedure setWidthTracksTextView(flag: Boolean); cdecl;
    function textView: NSTextView; cdecl;
    function widthTracksTextView: Boolean; cdecl;
  end;
  TNSTextContainer = class(TOCGenericImport<NSTextContainerClass, NSTextContainer>)  end;

  NSMovieClass = interface(NSObjectClass)
    ['{06210D69-3580-47E3-9B59-6C0B61271155}']
  end;
  NSMovie = interface(NSObject)
    ['{83D3E92A-B905-448F-9DAB-EA780F84FBCC}']
  end;
  TNSMovie = class(TOCGenericImport<NSMovieClass, NSMovie>)  end;

  NSTextListClass = interface(NSObjectClass)
    ['{620AD146-F296-456A-B7F5-0EF61D1641DE}']
  end;
  NSTextList = interface(NSObject)
    ['{C94DFD07-8598-4709-9C3C-18FD7DF144C0}']
    function initWithMarkerFormat(format: NSString; options: NSUInteger): Pointer; cdecl;
    function listOptions: NSUInteger; cdecl;
    function markerForItemNumber(itemNum: NSInteger): NSString; cdecl;
    function markerFormat: NSString; cdecl;
    procedure setStartingItemNumber(itemNum: NSInteger); cdecl;
    function startingItemNumber: NSInteger; cdecl;
  end;
  TNSTextList = class(TOCGenericImport<NSTextListClass, NSTextList>)  end;

  NSTextInputContextClass = interface(NSObjectClass)
    ['{A1D5C119-172E-4796-BAA1-3ADF11F28D03}']
    {class} function currentInputContext: Pointer; cdecl;
    {class} function localizedNameForInputSource(inputSourceIdentifier: NSString): NSString; cdecl;
  end;
  NSTextInputContext = interface(NSObject)
    ['{B8F2B38F-1F98-4D1B-8D91-7F023BA0C81D}']
    function acceptsGlyphInfo: Boolean; cdecl;
    procedure activate; cdecl;
    function client: NSTextInputClient; cdecl;
    procedure deactivate; cdecl;
    procedure discardMarkedText; cdecl;
    function handleEvent(theEvent: NSEvent): Boolean; cdecl;
    function initWithClient(theClient: NSTextInputClient): Pointer; cdecl;
    procedure invalidateCharacterCoordinates; cdecl;
  end;
  TNSTextInputContext = class(TOCGenericImport<NSTextInputContextClass, NSTextInputContext>)  end;

  NSMenuClass = interface(NSObjectClass)
    ['{3AB7BB99-1356-431E-B8C1-6E484A7ED2B9}']
    {class} function menuBarVisible: Boolean; cdecl;
    {class} function menuZone: Pointer; cdecl;
    {class} procedure popUpContextMenu(menu: NSMenu; withEvent: NSEvent; forView: NSView); cdecl; overload;
    {class} procedure popUpContextMenu(menu: NSMenu; withEvent: NSEvent; forView: NSView; withFont: NSFont); cdecl; overload;
    {class} procedure setMenuBarVisible(visible: Boolean); cdecl;
    {class} procedure setMenuZone(aZone: Pointer); cdecl;
  end;
  NSMenu = interface(NSObject)
    ['{167E3330-5BBF-42A9-8EB1-80CE9F3A3C32}']
    procedure addItem(newItem: NSMenuItem); cdecl;
    function addItemWithTitle(aString: NSString; action: SEL; keyEquivalent: NSString): NSMenuItem; cdecl;
    function allowsContextMenuPlugIns: Boolean; cdecl;
    function attachedMenu: NSMenu; cdecl;
    function autoenablesItems: Boolean; cdecl;
    procedure cancelTracking; cdecl;
    procedure cancelTrackingWithoutAnimation; cdecl;
    function contextMenuRepresentation: Pointer; cdecl;
    function delegate: NSMenuDelegate; cdecl;
    function font: NSFont; cdecl;
    procedure helpRequested(eventPtr: NSEvent); cdecl;
    function highlightedItem: NSMenuItem; cdecl;
    function indexOfItem(index: NSMenuItem): NSInteger; cdecl;
    function indexOfItemWithRepresentedObject(object_: Pointer): NSInteger; cdecl;
    function indexOfItemWithSubmenu(submenu: NSMenu): NSInteger; cdecl;
    function indexOfItemWithTag(aTag: NSInteger): NSInteger; cdecl;
    function indexOfItemWithTarget(target: Pointer; andAction: SEL): NSInteger; cdecl;
    function indexOfItemWithTitle(aTitle: NSString): NSInteger; cdecl;
    function initWithTitle(aTitle: NSString): Pointer; cdecl;
    procedure insertItem(newItem: NSMenuItem; atIndex: NSInteger); cdecl;
    function insertItemWithTitle(aString: NSString; action: SEL; keyEquivalent: NSString; atIndex: NSInteger): NSMenuItem; cdecl;
    function isAttached: Boolean; cdecl;
    function isTornOff: Boolean; cdecl;
    function itemArray: NSArray; cdecl;
    function itemAtIndex(index: NSInteger): NSMenuItem; cdecl;
    procedure itemChanged(item: NSMenuItem); cdecl;
    function itemWithTag(tag: NSInteger): NSMenuItem; cdecl;
    function itemWithTitle(aTitle: NSString): NSMenuItem; cdecl;
    function locationForSubmenu(aSubmenu: NSMenu): NSPoint; cdecl;
    function menuBarHeight: Single; cdecl;
    function menuChangedMessagesEnabled: Boolean; cdecl;
    function menuRepresentation: Pointer; cdecl;
    function minimumWidth: Single; cdecl;
    function numberOfItems: NSInteger; cdecl;
    procedure performActionForItemAtIndex(index: NSInteger); cdecl;
    function performKeyEquivalent(theEvent: NSEvent): Boolean; cdecl;
    function popUpMenuPositioningItem(item: NSMenuItem; atLocation: NSPoint; inView: NSView): Boolean; cdecl;
    function propertiesToUpdate: NSMenuProperties; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItem(item: NSMenuItem); cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure setAllowsContextMenuPlugIns(allows: Boolean); cdecl;
    procedure setAutoenablesItems(flag: Boolean); cdecl;
    procedure setContextMenuRepresentation(menuRep: Pointer); cdecl;
    procedure setDelegate(anObject: NSMenuDelegate); cdecl;
    procedure setFont(font: NSFont); cdecl;
    procedure setMenuChangedMessagesEnabled(flag: Boolean); cdecl;
    procedure setMenuRepresentation(menuRep: Pointer); cdecl;
    procedure setMinimumWidth(width: Single); cdecl;
    procedure setShowsStateColumn(showsState: Boolean); cdecl;
    procedure setSubmenu(aMenu: NSMenu; forItem: NSMenuItem); cdecl;
    procedure setSupermenu(supermenu: NSMenu); cdecl;
    procedure setTearOffMenuRepresentation(menuRep: Pointer); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    function showsStateColumn: Boolean; cdecl;
    function size: NSSize; cdecl;
    procedure sizeToFit; cdecl;
    procedure submenuAction(sender: Pointer); cdecl;
    function supermenu: NSMenu; cdecl;
    function tearOffMenuRepresentation: Pointer; cdecl;
    function title: NSString; cdecl;
    procedure update; cdecl;
  end;
  TNSMenu = class(TOCGenericImport<NSMenuClass, NSMenu>)  end;

  NSOpenGLLayerClass = interface(CAOpenGLLayerClass)
    ['{D816C26F-FDBE-4F93-9CDD-C261F8F36E07}']
  end;
  NSOpenGLLayer = interface(CAOpenGLLayer)
    ['{637882CB-EB7C-43FF-92DA-901199F456B9}']
    function canDrawInOpenGLContext(context: NSOpenGLContext; pixelFormat: NSOpenGLPixelFormat; forLayerTime: CFTimeInterval; displayTime: CVTimeStamp): Boolean; cdecl;
    procedure drawInOpenGLContext(context: NSOpenGLContext; pixelFormat: NSOpenGLPixelFormat; forLayerTime: CFTimeInterval; displayTime: CVTimeStamp); cdecl;
    function openGLContextForPixelFormat(pixelFormat: NSOpenGLPixelFormat): NSOpenGLContext; cdecl;
    function openGLPixelFormatForDisplayMask(mask: Longword): NSOpenGLPixelFormat; cdecl;
  end;
  TNSOpenGLLayer = class(TOCGenericImport<NSOpenGLLayerClass, NSOpenGLLayer>)  end;

  NSOpenGLPixelBufferClass = interface(NSObjectClass)
    ['{92D1C83D-098F-4911-86CE-A1CF87FBA755}']
  end;
  NSOpenGLPixelBuffer = interface(NSObject)
    ['{E5FAAAD7-58FB-4F9D-AFA7-9466053F2AE5}']
    function CGLPBufferObj: Pointer; cdecl;
    function initWithCGLPBufferObj(pbuffer: Pointer): Pointer; cdecl;
    function initWithTextureTarget(target: GLenum; textureInternalFormat: GLenum; textureMaxMipMapLevel: GLint; pixelsWide: GLsizei; pixelsHigh: GLsizei): Pointer; cdecl;
    function pixelsHigh: GLsizei; cdecl;
    function pixelsWide: GLsizei; cdecl;
    function textureInternalFormat: GLenum; cdecl;
    function textureMaxMipMapLevel: GLint; cdecl;
    function textureTarget: GLenum; cdecl;
  end;
  TNSOpenGLPixelBuffer = class(TOCGenericImport<NSOpenGLPixelBufferClass, NSOpenGLPixelBuffer>)  end;

  NSOpenGLPixelFormatClass = interface(NSObjectClass)
    ['{1EDD9810-0BDF-4533-9786-4C3E61719DFF}']
  end;
  NSOpenGLPixelFormat = interface(NSObject)
    ['{FF9FAE2C-37E2-47E6-8815-4526EA3151A3}']
    function CGLPixelFormatObj: Pointer; cdecl;
    function attributes: NSData; cdecl;
    procedure getValues(vals: PGLint; forAttribute: NSOpenGLPixelFormatAttribute; forVirtualScreen: GLint); cdecl;
    function initWithAttributes(attribs: PNSOpenGLPixelFormatAttribute): Pointer; cdecl;
    function initWithCGLPixelFormatObj(format: Pointer): Pointer; cdecl;
    function initWithData(attribs: NSData): Pointer; cdecl;
    function numberOfVirtualScreens: GLint; cdecl;
    procedure setAttributes(attribs: NSData); cdecl;
  end;
  TNSOpenGLPixelFormat = class(TOCGenericImport<NSOpenGLPixelFormatClass, NSOpenGLPixelFormat>)  end;

  NSNibClass = interface(NSObjectClass)
    ['{8C977425-44B9-41F6-A5C0-0DAC936C849B}']
  end;
  NSNib = interface(NSObject)
    ['{70A97857-2798-41FC-A768-13D071C668BC}']
    function initWithContentsOfURL(nibFileURL: NSURL): Pointer; cdecl;
    function initWithNibNamed(nibName: NSString; bundle: NSBundle): Pointer; cdecl;
    function instantiateNibWithExternalNameTable(externalNameTable: NSDictionary): Boolean; cdecl;
    function instantiateNibWithOwner(owner: Pointer; topLevelObjects: NSArray): Boolean; cdecl;
  end;
  TNSNib = class(TOCGenericImport<NSNibClass, NSNib>)  end;

  NSNibConnectorClass = interface(NSObjectClass)
    ['{54ACB6F9-FDE5-47BC-8F76-5B1D37089BCC}']
  end;
  NSNibConnector = interface(NSObject)
    ['{32DC6437-DC71-4BC3-A4B1-F4C48547B70F}']
    function destination: Pointer; cdecl;
    procedure establishConnection; cdecl;
    procedure replaceObject(oldObject: Pointer; withObject: Pointer); cdecl;
    procedure setDestination(destination: Pointer); cdecl;
    procedure setLabel(label_: NSString); cdecl;
    procedure setSource(source: Pointer); cdecl;
    function source: Pointer; cdecl;
  end;
  TNSNibConnector = class(TOCGenericImport<NSNibConnectorClass, NSNibConnector>)  end;

  NSOpenGLContextClass = interface(NSObjectClass)
    ['{1448BDAA-E2CB-461F-9180-8C0585EA3EC8}']
    {class} procedure clearCurrentContext; cdecl;
    {class} function currentContext: Pointer; cdecl;
  end;
  NSOpenGLContext = interface(NSObject)
    ['{8E4A8955-0BEB-4F0D-AE5E-24E53823D8D7}']
    function CGLContextObj: Pointer; cdecl;
    procedure clearDrawable; cdecl;
    procedure copyAttributesFromContext(context: NSOpenGLContext; withMask: GLbitfield); cdecl;
    procedure createTexture(target: GLenum; fromView: NSView; internalFormat: GLenum); cdecl;
    function currentVirtualScreen: GLint; cdecl;
    procedure flushBuffer; cdecl;
    procedure getValues(vals: PGLint; forParameter: NSOpenGLContextParameter); cdecl;
    function initWithCGLContextObj(context: Pointer): Pointer; cdecl;
    function initWithFormat(format: NSOpenGLPixelFormat; shareContext: NSOpenGLContext): Pointer; cdecl;
    procedure makeCurrentContext; cdecl;
    function pixelBuffer: NSOpenGLPixelBuffer; cdecl;
    function pixelBufferCubeMapFace: GLenum; cdecl;
    function pixelBufferMipMapLevel: GLint; cdecl;
    procedure setCurrentVirtualScreen(screen: GLint); cdecl;
    procedure setFullScreen; cdecl;
    procedure setOffScreen(baseaddr: Pointer; width: GLsizei; height: GLsizei; rowbytes: GLint); cdecl;
    procedure setPixelBuffer(pixelBuffer: NSOpenGLPixelBuffer; cubeMapFace: GLenum; mipMapLevel: GLint; currentVirtualScreen: GLint); cdecl;
    procedure setTextureImageToPixelBuffer(pixelBuffer: NSOpenGLPixelBuffer; colorBuffer: GLenum); cdecl;
    procedure setValues(vals: PGLint; forParameter: NSOpenGLContextParameter); cdecl;
    procedure setView(view: NSView); cdecl;
    procedure update; cdecl;
    function view: NSView; cdecl;
  end;
  TNSOpenGLContext = class(TOCGenericImport<NSOpenGLContextClass, NSOpenGLContext>)  end;

  NSLayoutManagerClass = interface(NSObjectClass)
    ['{6BA8AC5B-7B26-42B5-90C5-7FB194F2F306}']
  end;
  NSLayoutManager = interface(NSObject)
    ['{4084A21D-7F14-4732-A33E-D0ADA49B4D59}']
    procedure addTemporaryAttribute(attrName: NSString; value: Pointer; forCharacterRange: NSRange); cdecl;
    procedure addTemporaryAttributes(attrs: NSDictionary; forCharacterRange: NSRange); cdecl;
    procedure addTextContainer(container: NSTextContainer); cdecl;
    function allowsNonContiguousLayout: Boolean; cdecl;
    function attachmentSizeForGlyphAtIndex(glyphIndex: NSUInteger): NSSize; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function backgroundLayoutEnabled: Boolean; cdecl;
    function boundingRectForGlyphRange(glyphRange: NSRange; inTextContainer: NSTextContainer): NSRect; cdecl;
    function boundsRectForTextBlock(block: NSTextBlock; atIndex: NSUInteger; effectiveRange: PNSRange): NSRect; cdecl; overload;
    function boundsRectForTextBlock(block: NSTextBlock; glyphRange: NSRange): NSRect; cdecl; overload;
    function characterIndexForGlyphAtIndex(glyphIndex: NSUInteger): NSUInteger; cdecl;
    function characterIndexForPoint(point: NSPoint; inTextContainer: NSTextContainer; fractionOfDistanceBetweenInsertionPoints: PSingle): NSUInteger; cdecl;
    function characterRangeForGlyphRange(glyphRange: NSRange; actualGlyphRange: PNSRange): NSRange; cdecl;
    function defaultAttachmentScaling: NSImageScaling; cdecl;
    function defaultBaselineOffsetForFont(theFont: NSFont): Single; cdecl;
    function defaultLineHeightForFont(theFont: NSFont): Single; cdecl;
    function delegate: NSLayoutManagerDelegate; cdecl;
    procedure deleteGlyphsInRange(glyphRange: NSRange); cdecl;
    procedure drawBackgroundForGlyphRange(glyphsToShow: NSRange; atPoint: NSPoint); cdecl;
    procedure drawGlyphsForGlyphRange(glyphsToShow: NSRange; atPoint: NSPoint); cdecl;
    procedure drawStrikethroughForGlyphRange(glyphRange: NSRange; strikethroughType: NSInteger; baselineOffset: Single; lineFragmentRect: NSRect; lineFragmentGlyphRange: NSRange; containerOrigin: NSPoint); cdecl;
    procedure drawUnderlineForGlyphRange(glyphRange: NSRange; underlineType: NSInteger; baselineOffset: Single; lineFragmentRect: NSRect; lineFragmentGlyphRange: NSRange; containerOrigin: NSPoint); cdecl;
    function drawsOutsideLineFragmentForGlyphAtIndex(glyphIndex: NSUInteger): Boolean; cdecl;
    procedure ensureGlyphsForCharacterRange(charRange: NSRange); cdecl;
    procedure ensureGlyphsForGlyphRange(glyphRange: NSRange); cdecl;
    procedure ensureLayoutForBoundingRect(bounds: NSRect; inTextContainer: NSTextContainer); cdecl;
    procedure ensureLayoutForCharacterRange(charRange: NSRange); cdecl;
    procedure ensureLayoutForGlyphRange(glyphRange: NSRange); cdecl;
    procedure ensureLayoutForTextContainer(container: NSTextContainer); cdecl;
    function extraLineFragmentRect: NSRect; cdecl;
    function extraLineFragmentTextContainer: NSTextContainer; cdecl;
    function extraLineFragmentUsedRect: NSRect; cdecl;
    procedure fillBackgroundRectArray(rectArray: NSRectArray; count: NSUInteger; forCharacterRange: NSRange; color: NSColor); cdecl;
    function firstTextView: NSTextView; cdecl;
    function firstUnlaidCharacterIndex: NSUInteger; cdecl;
    function firstUnlaidGlyphIndex: NSUInteger; cdecl;
    function fractionOfDistanceThroughGlyphForPoint(point: NSPoint; inTextContainer: NSTextContainer): Single; cdecl;
    procedure getFirstUnlaidCharacterIndex(charIndex: NSUInteger; glyphIndex: NSUInteger); cdecl;
    function getGlyphs(glyphArray: PNSGlyph; range: NSRange): NSUInteger; cdecl;
    function getGlyphsInRange(glyphRange: NSRange; glyphs: PNSGlyph; characterIndexes: NSUInteger; glyphInscriptions: PNSGlyphInscription; elasticBits: PBoolean): NSUInteger; cdecl; overload;
    function getGlyphsInRange(glyphRange: NSRange; glyphs: PNSGlyph; characterIndexes: NSUInteger; glyphInscriptions: PNSGlyphInscription; elasticBits: PBoolean; bidiLevels: PByte): NSUInteger; cdecl; overload;
    function getLineFragmentInsertionPointsForCharacterAtIndex(charIndex: NSUInteger; alternatePositions: Boolean; inDisplayOrder: Boolean; positions: PSingle; characterIndexes: NSUInteger): NSUInteger; cdecl;
    function glyphAtIndex(glyphIndex: NSUInteger): NSGlyph; cdecl; overload;
    function glyphAtIndex(glyphIndex: NSUInteger; isValidIndex: PBoolean): NSGlyph; cdecl; overload;
    function glyphGenerator: NSGlyphGenerator; cdecl;
    function glyphIndexForCharacterAtIndex(charIndex: NSUInteger): NSUInteger; cdecl;
    function glyphIndexForPoint(point: NSPoint; inTextContainer: NSTextContainer): NSUInteger; cdecl; overload;
    function glyphIndexForPoint(point: NSPoint; inTextContainer: NSTextContainer; fractionOfDistanceThroughGlyph: PSingle): NSUInteger; cdecl; overload;
    function glyphRangeForBoundingRect(bounds: NSRect; inTextContainer: NSTextContainer): NSRange; cdecl;
    function glyphRangeForBoundingRectWithoutAdditionalLayout(bounds: NSRect; inTextContainer: NSTextContainer): NSRange; cdecl;
    function glyphRangeForCharacterRange(charRange: NSRange; actualCharacterRange: PNSRange): NSRange; cdecl;
    function glyphRangeForTextContainer(container: NSTextContainer): NSRange; cdecl;
    function hasNonContiguousLayout: Boolean; cdecl;
    function hyphenationFactor: Single; cdecl;
    function init: Pointer; cdecl;
    procedure insertGlyph(glyph: NSGlyph; atGlyphIndex: NSUInteger; characterIndex: NSUInteger); cdecl;
    procedure insertGlyphs(glyphs: PNSGlyph; length: NSUInteger; forStartingGlyphAtIndex: NSUInteger; characterIndex: NSUInteger); cdecl;
    procedure insertTextContainer(container: NSTextContainer; atIndex: NSUInteger); cdecl;
    function intAttribute(attributeTag: NSInteger; forGlyphAtIndex: NSUInteger): NSInteger; cdecl;
    procedure invalidateDisplayForCharacterRange(charRange: NSRange); cdecl;
    procedure invalidateDisplayForGlyphRange(glyphRange: NSRange); cdecl;
    procedure invalidateGlyphsForCharacterRange(charRange: NSRange; changeInLength: NSInteger; actualCharacterRange: PNSRange); cdecl;
    procedure invalidateGlyphsOnLayoutInvalidationForGlyphRange(glyphRange: NSRange); cdecl;
    procedure invalidateLayoutForCharacterRange(charRange: NSRange; actualCharacterRange: PNSRange); cdecl; overload;
    procedure invalidateLayoutForCharacterRange(charRange: NSRange; isSoft: Boolean; actualCharacterRange: PNSRange); cdecl; overload;
    function isValidGlyphIndex(glyphIndex: NSUInteger): Boolean; cdecl;
    function layoutManagerOwnsFirstResponderInWindow(window: NSWindow): Boolean; cdecl;
    function layoutOptions: NSUInteger; cdecl;
    function layoutRectForTextBlock(block: NSTextBlock; atIndex: NSUInteger; effectiveRange: PNSRange): NSRect; cdecl; overload;
    function layoutRectForTextBlock(block: NSTextBlock; glyphRange: NSRange): NSRect; cdecl; overload;
    function lineFragmentRectForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange): NSRect; cdecl; overload;
    function lineFragmentRectForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange; withoutAdditionalLayout: Boolean): NSRect; cdecl; overload;
    function lineFragmentUsedRectForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange): NSRect; cdecl; overload;
    function lineFragmentUsedRectForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange; withoutAdditionalLayout: Boolean): NSRect; cdecl; overload;
    function locationForGlyphAtIndex(glyphIndex: NSUInteger): NSPoint; cdecl;
    function notShownAttributeForGlyphAtIndex(glyphIndex: NSUInteger): Boolean; cdecl;
    function numberOfGlyphs: NSUInteger; cdecl;
    function rangeOfNominallySpacedGlyphsContainingIndex(glyphIndex: NSUInteger): NSRange; cdecl;
    function rectArrayForCharacterRange(charRange: NSRange; withinSelectedCharacterRange: NSRange; inTextContainer: NSTextContainer; rectCount: NSUInteger): NSRectArray; cdecl;
    function rectArrayForGlyphRange(glyphRange: NSRange; withinSelectedGlyphRange: NSRange; inTextContainer: NSTextContainer; rectCount: NSUInteger): NSRectArray; cdecl;
    procedure removeTemporaryAttribute(attrName: NSString; forCharacterRange: NSRange); cdecl;
    procedure removeTextContainerAtIndex(index: NSUInteger); cdecl;
    procedure replaceGlyphAtIndex(glyphIndex: NSUInteger; withGlyph: NSGlyph); cdecl;
    procedure replaceTextStorage(newTextStorage: NSTextStorage); cdecl;
    function rulerAccessoryViewForTextView(view: NSTextView; paragraphStyle: NSParagraphStyle; ruler: NSRulerView; enabled: Boolean): NSView; cdecl;
    function rulerMarkersForTextView(view: NSTextView; paragraphStyle: NSParagraphStyle; ruler: NSRulerView): NSArray; cdecl;
    procedure setAllowsNonContiguousLayout(flag: Boolean); cdecl;
    procedure setAttachmentSize(attachmentSize: NSSize; forGlyphRange: NSRange); cdecl;
    procedure setBackgroundLayoutEnabled(flag: Boolean); cdecl;
    procedure setBoundsRect(rect: NSRect; forTextBlock: NSTextBlock; glyphRange: NSRange); cdecl;
    procedure setCharacterIndex(charIndex: NSUInteger; forGlyphAtIndex: NSUInteger); cdecl;
    procedure setDefaultAttachmentScaling(scaling: NSImageScaling); cdecl;
    procedure setDelegate(delegate: NSLayoutManagerDelegate); cdecl;
    procedure setDrawsOutsideLineFragment(flag: Boolean; forGlyphAtIndex: NSUInteger); cdecl;
    procedure setExtraLineFragmentRect(fragmentRect: NSRect; usedRect: NSRect; textContainer: NSTextContainer); cdecl;
    procedure setGlyphGenerator(glyphGenerator: NSGlyphGenerator); cdecl;
    procedure setHyphenationFactor(factor: Single); cdecl;
    procedure setIntAttribute(attributeTag: NSInteger; value: NSInteger; forGlyphAtIndex: NSUInteger); cdecl;
    procedure setLayoutRect(rect: NSRect; forTextBlock: NSTextBlock; glyphRange: NSRange); cdecl;
    procedure setLineFragmentRect(fragmentRect: NSRect; forGlyphRange: NSRange; usedRect: NSRect); cdecl;
    procedure setLocation(location: NSPoint; forStartOfGlyphRange: NSRange); cdecl;
    procedure setLocations(locations: NSPointArray; startingGlyphIndexes: NSUInteger; count: NSUInteger; forGlyphRange: NSRange); cdecl;
    procedure setNotShownAttribute(flag: Boolean; forGlyphAtIndex: NSUInteger); cdecl;
    procedure setShowsControlCharacters(flag: Boolean); cdecl;
    procedure setShowsInvisibleCharacters(flag: Boolean); cdecl;
    procedure setTemporaryAttributes(attrs: NSDictionary; forCharacterRange: NSRange); cdecl;
    procedure setTextContainer(container: NSTextContainer; forGlyphRange: NSRange); cdecl;
    procedure setTextStorage(textStorage: NSTextStorage); cdecl;
    procedure setTypesetter(typesetter: NSTypesetter); cdecl;
    procedure setTypesetterBehavior(theBehavior: NSTypesetterBehavior); cdecl;
    procedure setUsesFontLeading(flag: Boolean); cdecl;
    procedure setUsesScreenFonts(flag: Boolean); cdecl;
    procedure showAttachmentCell(cell: NSCell; inRect: NSRect; characterIndex: NSUInteger); cdecl;
    procedure showPackedGlyphs(glyphs: MarshaledAString; length: NSUInteger; glyphRange: NSRange; atPoint: NSPoint; font: NSFont; color: NSColor; printingAdjustment: NSSize); cdecl;
    function showsControlCharacters: Boolean; cdecl;
    function showsInvisibleCharacters: Boolean; cdecl;
    procedure strikethroughGlyphRange(glyphRange: NSRange; strikethroughType: NSInteger; lineFragmentRect: NSRect; lineFragmentGlyphRange: NSRange; containerOrigin: NSPoint); cdecl;
    function substituteFontForFont(originalFont: NSFont): NSFont; cdecl;
    function temporaryAttribute(attrName: NSString; atCharacterIndex: NSUInteger; effectiveRange: PNSRange): Pointer; cdecl; overload;
    function temporaryAttribute(attrName: NSString; atCharacterIndex: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): Pointer; cdecl; overload;
    function temporaryAttributesAtCharacterIndex(charIndex: NSUInteger; effectiveRange: PNSRange): NSDictionary; cdecl; overload;
    function temporaryAttributesAtCharacterIndex(location: NSUInteger; longestEffectiveRange: PNSRange; inRange: NSRange): NSDictionary; cdecl; overload;
    procedure textContainerChangedGeometry(container: NSTextContainer); cdecl;
    procedure textContainerChangedTextView(container: NSTextContainer); cdecl;
    function textContainerForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange): NSTextContainer; cdecl; overload;
    function textContainerForGlyphAtIndex(glyphIndex: NSUInteger; effectiveRange: PNSRange; withoutAdditionalLayout: Boolean): NSTextContainer; cdecl; overload;
    function textContainers: NSArray; cdecl;
    function textStorage: NSTextStorage; cdecl; overload;
    procedure textStorage(str: NSTextStorage; edited: NSUInteger; range: NSRange; changeInLength: NSInteger; invalidatedRange: NSRange); cdecl; overload;
    function textViewForBeginningOfSelection: NSTextView; cdecl;
    function typesetter: NSTypesetter; cdecl;
    function typesetterBehavior: NSTypesetterBehavior; cdecl;
    procedure underlineGlyphRange(glyphRange: NSRange; underlineType: NSInteger; lineFragmentRect: NSRect; lineFragmentGlyphRange: NSRange; containerOrigin: NSPoint); cdecl;
    function usedRectForTextContainer(container: NSTextContainer): NSRect; cdecl;
    function usesFontLeading: Boolean; cdecl;
    function usesScreenFonts: Boolean; cdecl;
  end;
  TNSLayoutManager = class(TOCGenericImport<NSLayoutManagerClass, NSLayoutManager>)  end;

  NSGlyphGeneratorClass = interface(NSObjectClass)
    ['{10BF6A97-7CA0-4F61-8F6E-D13EFAF8E07A}']
    {class} function sharedGlyphGenerator: Pointer; cdecl;
  end;
  NSGlyphGenerator = interface(NSObject)
    ['{19FF3812-999F-4008-A734-C29B94A3D390}']
    procedure generateGlyphsForGlyphStorage(glyphStorage: NSGlyphStorage; desiredNumberOfCharacters: NSUInteger; glyphIndex: NSUInteger; characterIndex: NSUInteger); cdecl;
  end;
  TNSGlyphGenerator = class(TOCGenericImport<NSGlyphGeneratorClass, NSGlyphGenerator>)  end;

  NSGlyphInfoClass = interface(NSObjectClass)
    ['{2674DCE4-2DCC-4D11-BF68-5F1262AA99B9}']
    {class} function glyphInfoWithCharacterIdentifier(cid: NSUInteger; collection: NSCharacterCollection; baseString: NSString): Pointer; cdecl;
    {class} function glyphInfoWithGlyph(glyph: NSGlyph; forFont: NSFont; baseString: NSString): Pointer; cdecl;
    {class} function glyphInfoWithGlyphName(glyphName: NSString; forFont: NSFont; baseString: NSString): Pointer; cdecl;
  end;
  NSGlyphInfo = interface(NSObject)
    ['{FBE55946-6B09-4F38-B870-C66B68739B7B}']
    function characterCollection: NSCharacterCollection; cdecl;
    function characterIdentifier: NSUInteger; cdecl;
    function glyphName: NSString; cdecl;
  end;
  TNSGlyphInfo = class(TOCGenericImport<NSGlyphInfoClass, NSGlyphInfo>)  end;

  NSGradientClass = interface(NSObjectClass)
    ['{E327F42A-D39B-42CE-AC7B-6F0D41431936}']
  end;
  NSGradient = interface(NSObject)
    ['{658ED614-E8EB-4A1C-B153-6C52D54F9DF1}']
    function colorSpace: NSColorSpace; cdecl;
    procedure drawFromPoint(startingPoint: NSPoint; toPoint: NSPoint; options: NSGradientDrawingOptions); cdecl;
    procedure drawInBezierPath(path: NSBezierPath; angle: Single); cdecl; overload;
    procedure drawInBezierPath(path: NSBezierPath; relativeCenterPosition: NSPoint); cdecl; overload;
    procedure drawInRect(rect: NSRect; angle: Single); cdecl; overload;
    procedure drawInRect(rect: NSRect; relativeCenterPosition: NSPoint); cdecl; overload;
    procedure getColor(color: NSColor; location: PSingle; atIndex: NSInteger); cdecl;
    function initWithColors(colorArray: NSArray): Pointer; cdecl; overload;
    function initWithColors(colorArray: NSArray; atLocations: PSingle; colorSpace: NSColorSpace): Pointer; cdecl; overload;
    function initWithColorsAndLocations(initWithColorsAndLocations: NSColor): Pointer; cdecl;
    function initWithStartingColor(startingColor: NSColor; endingColor: NSColor): Pointer; cdecl;
    function interpolatedColorAtLocation(location: Single): NSColor; cdecl;
    function numberOfColorStops: NSInteger; cdecl;
  end;
  TNSGradient = class(TOCGenericImport<NSGradientClass, NSGradient>)  end;

  NSFontDescriptorClass = interface(NSObjectClass)
    ['{A82908EB-1459-4F23-857E-17426AEA0F5C}']
    {class} function fontDescriptorWithFontAttributes(attributes: NSDictionary): Pointer; cdecl;
    {class} function fontDescriptorWithName(fontName: NSString; matrix: NSAffineTransform): Pointer; cdecl; overload;
    {class} function fontDescriptorWithName(fontName: NSString; size: Single): Pointer; cdecl; overload;
  end;
  NSFontDescriptor = interface(NSObject)
    ['{CF43BFA8-6ED8-4809-9594-E4D4F09A4FD1}']
    function fontAttributes: NSDictionary; cdecl;
    function fontDescriptorByAddingAttributes(attributes: NSDictionary): NSFontDescriptor; cdecl;
    function fontDescriptorWithFace(newFace: NSString): NSFontDescriptor; cdecl;
    function fontDescriptorWithFamily(newFamily: NSString): NSFontDescriptor; cdecl;
    function fontDescriptorWithMatrix(matrix: NSAffineTransform): NSFontDescriptor; cdecl;
    function fontDescriptorWithSize(newPointSize: Single): NSFontDescriptor; cdecl;
    function fontDescriptorWithSymbolicTraits(symbolicTraits: NSFontSymbolicTraits): NSFontDescriptor; cdecl;
    function initWithFontAttributes(attributes: NSDictionary): Pointer; cdecl;
    function matchingFontDescriptorWithMandatoryKeys(mandatoryKeys: NSSet): NSFontDescriptor; cdecl;
    function matchingFontDescriptorsWithMandatoryKeys(mandatoryKeys: NSSet): NSArray; cdecl;
    function matrix: NSAffineTransform; cdecl;
    function objectForKey(anAttribute: NSString): Pointer; cdecl;
    function pointSize: Single; cdecl;
    function postscriptName: NSString; cdecl;
    function symbolicTraits: NSFontSymbolicTraits; cdecl;
  end;
  TNSFontDescriptor = class(TOCGenericImport<NSFontDescriptorClass, NSFontDescriptor>)  end;

  NSFontManagerClass = interface(NSObjectClass)
    ['{970EB5A2-9C59-438E-9D8A-37267CFCCDAD}']
    {class} procedure setFontManagerFactory(factoryId: Pointer); cdecl;
    {class} procedure setFontPanelFactory(factoryId: Pointer); cdecl;
    {class} function sharedFontManager: Pointer; cdecl;
  end;
  NSFontManager = interface(NSObject)
    ['{1BCD1EC2-E2D9-4092-AB21-93E1637B80A3}']
    function action: SEL; cdecl;
    function addCollection(collectionName: NSString; options: NSInteger): Boolean; cdecl;
    procedure addFontDescriptors(descriptors: NSArray; toCollection: NSString); cdecl;
    procedure addFontTrait(sender: Pointer); cdecl;
    function availableFontFamilies: NSArray; cdecl;
    function availableFontNamesMatchingFontDescriptor(descriptor: NSFontDescriptor): NSArray; cdecl;
    function availableFontNamesWithTraits(someTraits: NSFontTraitMask): NSArray; cdecl;
    function availableFonts: NSArray; cdecl;
    function availableMembersOfFontFamily(fam: NSString): NSArray; cdecl;
    function collectionNames: NSArray; cdecl;
    function convertAttributes(attributes: NSDictionary): NSDictionary; cdecl;
    function convertFont(fontObj: NSFont): NSFont; cdecl; overload;
    function convertFont(fontObj: NSFont; toFace: NSString): NSFont; cdecl; overload;
//    function convertFont(fontObj: NSFont; toFamily: NSString): NSFont; cdecl; overload;
    function convertFont(fontObj: NSFont; toHaveTrait: NSFontTraitMask): NSFont; cdecl; overload;
//    function convertFont(fontObj: NSFont; toNotHaveTrait: NSFontTraitMask): NSFont; cdecl; overload;
    function convertFont(fontObj: NSFont; toSize: Single): NSFont; cdecl; overload;
    function convertFontTraits(traits: NSFontTraitMask): NSFontTraitMask; cdecl;
    function convertWeight(upFlag: Boolean; ofFont: NSFont): NSFont; cdecl;
    function currentFontAction: NSFontAction; cdecl;
    function delegate: Pointer; cdecl;
    function fontDescriptorsInCollection(collectionNames: NSString): NSArray; cdecl;
    function fontMenu(create: Boolean): NSMenu; cdecl;
    function fontNamed(fName: NSString; hasTraits: NSFontTraitMask): Boolean; cdecl;
    function fontPanel(create: Boolean): NSFontPanel; cdecl;
    function fontWithFamily(family: NSString; traits: NSFontTraitMask; weight: NSInteger; size: Single): NSFont; cdecl;
    function isEnabled: Boolean; cdecl;
    function isMultiple: Boolean; cdecl;
    function localizedNameForFamily(family: NSString; face: NSString): NSString; cdecl;
    procedure modifyFont(sender: Pointer); cdecl;
    procedure modifyFontViaPanel(sender: Pointer); cdecl;
    procedure orderFrontFontPanel(sender: Pointer); cdecl;
    procedure orderFrontStylesPanel(sender: Pointer); cdecl;
    function removeCollection(collectionName: NSString): Boolean; cdecl;
    procedure removeFontDescriptor(descriptor: NSFontDescriptor; fromCollection: NSString); cdecl;
    procedure removeFontTrait(sender: Pointer); cdecl;
    function selectedFont: NSFont; cdecl;
    function sendAction: Boolean; cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setDelegate(anObject: Pointer); cdecl;
    procedure setEnabled(flag: Boolean); cdecl;
    procedure setFontMenu(newMenu: NSMenu); cdecl;
    procedure setSelectedAttributes(attributes: NSDictionary; isMultiple: Boolean); cdecl;
    procedure setSelectedFont(fontObj: NSFont; isMultiple: Boolean); cdecl;
    procedure setTarget(aTarget: Pointer); cdecl;
    function target: Pointer; cdecl;
    function traitsOfFont(fontObj: NSFont): NSFontTraitMask; cdecl;
    function weightOfFont(fontObj: NSFont): NSInteger; cdecl;
  end;
  TNSFontManager = class(TOCGenericImport<NSFontManagerClass, NSFontManager>)  end;

  NSTextTabClass = interface(NSObjectClass)
    ['{C28DA801-38F0-4472-8E48-0BCD3D4433B2}']
  end;
  NSTextTab = interface(NSObject)
    ['{C0CD789D-6C63-41C5-8E90-8BE701F304E9}']
    function alignment: NSTextAlignment; cdecl;
    function initWithTextAlignment(alignment: NSTextAlignment; location: Single; options: NSDictionary): Pointer; cdecl;
    function initWithType(type_: NSTextTabType; location: Single): Pointer; cdecl;
    function location: Single; cdecl;
    function options: NSDictionary; cdecl;
    function tabStopType: NSTextTabType; cdecl;
  end;
  TNSTextTab = class(TOCGenericImport<NSTextTabClass, NSTextTab>)  end;

  NSImageRepClass = interface(NSObjectClass)
    ['{2A56C2C5-B61D-4CF1-8554-F3AB664321C7}']
    {class} function canInitWithData(data: NSData): Boolean; cdecl;
    {class} function canInitWithPasteboard(pasteboard: NSPasteboard): Boolean; cdecl;
    {class} function imageFileTypes: NSArray; cdecl;
    {class} function imagePasteboardTypes: NSArray; cdecl;
    {class} function imageRepWithContentsOfFile(filename: NSString): Pointer; cdecl;
    {class} function imageRepWithContentsOfURL(url: NSURL): Pointer; cdecl;
    {class} function imageRepWithPasteboard(pasteboard: NSPasteboard): Pointer; cdecl;
    {class} function imageRepsWithContentsOfFile(filename: NSString): NSArray; cdecl;
    {class} function imageRepsWithContentsOfURL(url: NSURL): NSArray; cdecl;
    {class} function imageRepsWithPasteboard(pasteboard: NSPasteboard): NSArray; cdecl;
    {class} function imageTypes: NSArray; cdecl;
    {class} function imageUnfilteredFileTypes: NSArray; cdecl;
    {class} function imageUnfilteredPasteboardTypes: NSArray; cdecl;
    {class} function imageUnfilteredTypes: NSArray; cdecl;
    {class} procedure registerImageRepClass(imageRepClass: Pointer); cdecl;
    {class} function registeredImageRepClasses: NSArray; cdecl;
    {class} procedure unregisterImageRepClass(imageRepClass: Pointer); cdecl;
  end;
  NSImageRep = interface(NSObject)
    ['{ABFB462A-77BE-4A8F-8FF0-289E0DB43609}']
    function CGImageForProposedRect(proposedDestRect: PNSRect; context: NSGraphicsContext; hints: NSDictionary): CGImageRef; cdecl;
    function bitsPerSample: NSInteger; cdecl;
    function colorSpaceName: NSString; cdecl;
    function draw: Boolean; cdecl;
    function drawAtPoint(point: NSPoint): Boolean; cdecl;
    function drawInRect(rect: NSRect): Boolean; cdecl; overload;
    function drawInRect(dstSpacePortionRect: NSRect; fromRect: NSRect; operation: NSCompositingOperation; fraction: Single; respectFlipped: Boolean; hints: NSDictionary): Boolean; cdecl; overload;
    function hasAlpha: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function pixelsHigh: NSInteger; cdecl;
    function pixelsWide: NSInteger; cdecl;
    procedure setAlpha(flag: Boolean); cdecl;
    procedure setBitsPerSample(anInt: NSInteger); cdecl;
    procedure setColorSpaceName(string_: NSString); cdecl;
    procedure setOpaque(flag: Boolean); cdecl;
    procedure setPixelsHigh(anInt: NSInteger); cdecl;
    procedure setPixelsWide(anInt: NSInteger); cdecl;
    procedure setSize(aSize: NSSize); cdecl;
    function size: NSSize; cdecl;
  end;
  TNSImageRep = class(TOCGenericImport<NSImageRepClass, NSImageRep>)  end;

  NSInputManagerClass = interface(NSObjectClass)
    ['{4022FFD0-B70A-4D2D-8CBC-FBC7F32533CD}']
    {class} function currentInputManager: Pointer; cdecl;
    {class} procedure cycleToNextInputLanguage(sender: Pointer); cdecl;
    {class} procedure cycleToNextInputServerInLanguage(sender: Pointer); cdecl;
  end;
  NSInputManager = interface(NSObject)
    ['{3B2244A2-D12E-4B2C-B5B6-A226D7649E7B}']
    function handleMouseEvent(theMouseEvent: NSEvent): Boolean; cdecl;
    function image: NSImage; cdecl;
    function initWithName(inputServerName: NSString; host: NSString): NSInputManager; cdecl;
    function language: NSString; cdecl;
    function localizedInputManagerName: NSString; cdecl;
    procedure markedTextAbandoned(cli: Pointer); cdecl;
    procedure markedTextSelectionChanged(newSel: NSRange; client: Pointer); cdecl;
    function server: NSInputServer; cdecl;
    function wantsToDelayTextChangeNotifications: Boolean; cdecl;
    function wantsToHandleMouseEvents: Boolean; cdecl;
    function wantsToInterpretAllKeystrokes: Boolean; cdecl;
  end;
  TNSInputManager = class(TOCGenericImport<NSInputManagerClass, NSInputManager>)  end;

  NSInputServerClass = interface(NSObjectClass)
    ['{4DE7D736-242F-4248-B511-A365F1F1D4EE}']
  end;
  NSInputServer = interface(NSObject)
    ['{47EFD4EC-95A8-4336-8176-539634BC0BB7}']
    function initWithDelegate(aDelegate: Pointer; name: NSString): Pointer; cdecl;
  end;
  TNSInputServer = class(TOCGenericImport<NSInputServerClass, NSInputServer>)  end;

  NSGraphicsContextClass = interface(NSObjectClass)
    ['{4C649637-C16F-4C57-8686-BF5C5E3053E9}']
    {class} function currentContext: Pointer; cdecl;
    {class} function currentContextDrawingToScreen: Boolean; cdecl;
    {class} function graphicsContextWithAttributes(attributes: NSDictionary): Pointer; cdecl;
    {class} function graphicsContextWithBitmapImageRep(bitmapRep: NSBitmapImageRep): Pointer; cdecl;
    {class} function graphicsContextWithGraphicsPort(graphicsPort: Pointer; flipped: Boolean): Pointer; cdecl;
    {class} function graphicsContextWithWindow(window: NSWindow): Pointer; cdecl;
    {class} procedure restoreGraphicsState; cdecl; overload;
    {class} procedure saveGraphicsState; cdecl; overload;
    {class} procedure setCurrentContext(context: NSGraphicsContext); cdecl;
    {class} procedure setGraphicsState(gState: NSInteger); cdecl;
  end;
  NSGraphicsContext = interface(NSObject)
    ['{25EBB1E1-0A1B-469E-A24E-122C076ACBF0}']
    function CIContext: CIContext; cdecl;
    function attributes: NSDictionary; cdecl;
    function colorRenderingIntent: NSColorRenderingIntent; cdecl;
    function compositingOperation: NSCompositingOperation; cdecl;
    procedure flushGraphics; cdecl;
    function graphicsPort: Pointer; cdecl;
    function imageInterpolation: NSImageInterpolation; cdecl;
    function isDrawingToScreen: Boolean; cdecl;
    function isFlipped: Boolean; cdecl;
    function patternPhase: NSPoint; cdecl;
    procedure restoreGraphicsState; cdecl; overload;
    procedure saveGraphicsState; cdecl; overload;
    procedure setColorRenderingIntent(renderingIntent: NSColorRenderingIntent); cdecl;
    procedure setCompositingOperation(operation: NSCompositingOperation); cdecl;
    procedure setImageInterpolation(interpolation: NSImageInterpolation); cdecl;
    procedure setPatternPhase(phase: NSPoint); cdecl;
    procedure setShouldAntialias(antialias: Boolean); cdecl;
    function shouldAntialias: Boolean; cdecl;
  end;
  TNSGraphicsContext = class(TOCGenericImport<NSGraphicsContextClass, NSGraphicsContext>)  end;

  NSHelpManagerClass = interface(NSObjectClass)
    ['{48F3BEF0-261B-4A42-AC3F-BED565A6A59F}']
    {class} function isContextHelpModeActive: Boolean; cdecl;
    {class} procedure setContextHelpModeActive(active: Boolean); cdecl;
    {class} function sharedHelpManager: Pointer; cdecl;
  end;
  NSHelpManager = interface(NSObject)
    ['{B2B416F1-6EE0-438F-B267-3F355F368B2E}']
    function contextHelpForObject(object_: Pointer): NSAttributedString; cdecl;
    procedure findString(query: NSString; inBook: NSString); cdecl;
    procedure openHelpAnchor(anchor: NSString; inBook: NSString); cdecl;
    function registerBooksInBundle(bundle: NSBundle): Boolean; cdecl;
    procedure removeContextHelpForObject(object_: Pointer); cdecl;
    procedure setContextHelp(attrString: NSAttributedString; forObject: Pointer); cdecl;
    function showContextHelpForObject(object_: Pointer; locationHint: NSPoint): Boolean; cdecl;
  end;
  TNSHelpManager = class(TOCGenericImport<NSHelpManagerClass, NSHelpManager>)  end;

  NSImageClass = interface(NSObjectClass)
    ['{D3938E2F-6A3C-465A-866D-5B0EC7D13DB3}']
    {class} function canInitWithPasteboard(pasteboard: NSPasteboard): Boolean; cdecl;
    {class} function imageFileTypes: NSArray; cdecl;
    {class} function imageNamed(name: NSString): Pointer; cdecl;
    {class} function imagePasteboardTypes: NSArray; cdecl;
    {class} function imageTypes: NSArray; cdecl;
    {class} function imageUnfilteredFileTypes: NSArray; cdecl;
    {class} function imageUnfilteredPasteboardTypes: NSArray; cdecl;
    {class} function imageUnfilteredTypes: NSArray; cdecl;
  end;
  NSImage = interface(NSObject)
    ['{D39B2515-517A-4EA4-BA74-729198211680}']
    function CGImageForProposedRect(proposedDestRect: PNSRect; context: NSGraphicsContext; hints: NSDictionary): CGImageRef; cdecl;
    function TIFFRepresentation: NSData; cdecl;
    function TIFFRepresentationUsingCompression(comp: NSTIFFCompression; factor: Single): NSData; cdecl;
    function accessibilityDescription: NSString; cdecl;
    procedure addRepresentation(imageRep: NSImageRep); cdecl;
    procedure addRepresentations(imageReps: NSArray); cdecl;
    function alignmentRect: NSRect; cdecl;
    function backgroundColor: NSColor; cdecl;
    function bestRepresentationForDevice(deviceDescription: NSDictionary): NSImageRep; cdecl;
    function bestRepresentationForRect(rect: NSRect; context: NSGraphicsContext; hints: NSDictionary): NSImageRep; cdecl;
    function cacheDepthMatchesImageDepth: Boolean; cdecl;
    function cacheMode: NSImageCacheMode; cdecl;
    procedure cancelIncrementalLoad; cdecl;
    procedure compositeToPoint(point: NSPoint; fromRect: NSRect; operation: NSCompositingOperation); cdecl; overload;
    procedure compositeToPoint(point: NSPoint; fromRect: NSRect; operation: NSCompositingOperation; fraction: Single); cdecl; overload;
    procedure compositeToPoint(point: NSPoint; operation: NSCompositingOperation); cdecl; overload;
    procedure compositeToPoint(point: NSPoint; operation: NSCompositingOperation; fraction: Single); cdecl; overload;
    function delegate: NSImageDelegate; cdecl;
    procedure dissolveToPoint(point: NSPoint; fraction: Single); cdecl; overload;
    procedure dissolveToPoint(point: NSPoint; fromRect: NSRect; fraction: Single); cdecl; overload;
    procedure drawAtPoint(point: NSPoint; fromRect: NSRect; operation: NSCompositingOperation; fraction: Single); cdecl;
    procedure drawInRect(rect: NSRect; fromRect: NSRect; operation: NSCompositingOperation; fraction: Single); cdecl; overload;
    procedure drawInRect(dstSpacePortionRect: NSRect; fromRect: NSRect; operation: NSCompositingOperation; fraction: Single; respectFlipped: Boolean; hints: NSDictionary); cdecl; overload;
    function drawRepresentation(imageRep: NSImageRep; inRect: NSRect): Boolean; cdecl;
    function hitTestRect(testRectDestSpace: NSRect; withImageDestinationRect: NSRect; context: NSGraphicsContext; hints: NSDictionary; flipped: Boolean): Boolean; cdecl;
    function initByReferencingFile(fileName: NSString): Pointer; cdecl;
    function initByReferencingURL(url: NSURL): Pointer; cdecl;
    function initWithCGImage(cgImage: CGImageRef; size: NSSize): Pointer; cdecl;
    function initWithContentsOfFile(fileName: NSString): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithDataIgnoringOrientation(data: NSData): Pointer; cdecl;
    function initWithIconRef(iconRef: IconRef): Pointer; cdecl;
    function initWithPasteboard(pasteboard: NSPasteboard): Pointer; cdecl;
    function initWithSize(aSize: NSSize): Pointer; cdecl;
    function isCachedSeparately: Boolean; cdecl;
    function isDataRetained: Boolean; cdecl;
    function isFlipped: Boolean; cdecl;
    function isTemplate: Boolean; cdecl;
    function isValid: Boolean; cdecl;
    procedure lockFocus; cdecl;
    procedure lockFocusFlipped(flipped: Boolean); cdecl;
    procedure lockFocusOnRepresentation(imageRepresentation: NSImageRep); cdecl;
    function matchesOnMultipleResolution: Boolean; cdecl;
    function name: NSString; cdecl;
    function prefersColorMatch: Boolean; cdecl;
    procedure recache; cdecl;
    procedure removeRepresentation(imageRep: NSImageRep); cdecl;
    function representations: NSArray; cdecl;
    function scalesWhenResized: Boolean; cdecl;
    procedure setAccessibilityDescription(description: NSString); cdecl;
    procedure setAlignmentRect(rect: NSRect); cdecl;
    procedure setBackgroundColor(aColor: NSColor); cdecl;
    procedure setCacheDepthMatchesImageDepth(flag: Boolean); cdecl;
    procedure setCacheMode(mode: NSImageCacheMode); cdecl;
    procedure setCachedSeparately(flag: Boolean); cdecl;
    procedure setDataRetained(flag: Boolean); cdecl;
    procedure setDelegate(anObject: NSImageDelegate); cdecl;
    procedure setFlipped(flag: Boolean); cdecl;
    procedure setMatchesOnMultipleResolution(flag: Boolean); cdecl;
    function setName(string_: NSString): Boolean; cdecl;
    procedure setPrefersColorMatch(flag: Boolean); cdecl;
    procedure setScalesWhenResized(flag: Boolean); cdecl;
    procedure setSize(aSize: NSSize); cdecl;
    procedure setTemplate(isTemplate: Boolean); cdecl;
    procedure setUsesEPSOnResolutionMismatch(flag: Boolean); cdecl;
    function size: NSSize; cdecl;
    procedure unlockFocus; cdecl;
    function usesEPSOnResolutionMismatch: Boolean; cdecl;
  end;
  TNSImage = class(TOCGenericImport<NSImageClass, NSImage>)  end;

  NSResponderClass = interface(NSObjectClass)
    ['{7875EF0D-3F6D-4905-96A7-031778E0C768}']
  end;
  NSResponder = interface(NSObject)
    ['{68796E3E-CE7C-4264-BBFE-10F2BB99FD88}']
    function acceptsFirstResponder: Boolean; cdecl;
    function becomeFirstResponder: Boolean; cdecl;
    procedure beginGestureWithEvent(event: NSEvent); cdecl;
    procedure cancelOperation(sender: Pointer); cdecl;
    procedure capitalizeWord(sender: Pointer); cdecl;
    procedure centerSelectionInVisibleArea(sender: Pointer); cdecl;
    procedure changeCaseOfLetter(sender: Pointer); cdecl;
    procedure complete(sender: Pointer); cdecl;
    procedure cursorUpdate(event: NSEvent); cdecl;
    procedure deleteBackward(sender: Pointer); cdecl;
    procedure deleteBackwardByDecomposingPreviousCharacter(sender: Pointer); cdecl;
    procedure deleteForward(sender: Pointer); cdecl;
    procedure deleteToBeginningOfLine(sender: Pointer); cdecl;
    procedure deleteToBeginningOfParagraph(sender: Pointer); cdecl;
    procedure deleteToEndOfLine(sender: Pointer); cdecl;
    procedure deleteToEndOfParagraph(sender: Pointer); cdecl;
    procedure deleteToMark(sender: Pointer); cdecl;
    procedure deleteWordBackward(sender: Pointer); cdecl;
    procedure deleteWordForward(sender: Pointer); cdecl;
    procedure doCommandBySelector(aSelector: SEL); cdecl;
    procedure endGestureWithEvent(event: NSEvent); cdecl;
    procedure flagsChanged(theEvent: NSEvent); cdecl;
    procedure flushBufferedKeyEvents; cdecl;
    procedure helpRequested(eventPtr: NSEvent); cdecl;
    procedure indent(sender: Pointer); cdecl;
    procedure insertBacktab(sender: Pointer); cdecl;
    procedure insertContainerBreak(sender: Pointer); cdecl;
    procedure insertDoubleQuoteIgnoringSubstitution(sender: Pointer); cdecl;
    procedure insertLineBreak(sender: Pointer); cdecl;
    procedure insertNewline(sender: Pointer); cdecl;
    procedure insertNewlineIgnoringFieldEditor(sender: Pointer); cdecl;
    procedure insertParagraphSeparator(sender: Pointer); cdecl;
    procedure insertSingleQuoteIgnoringSubstitution(sender: Pointer); cdecl;
    procedure insertTab(sender: Pointer); cdecl;
    procedure insertTabIgnoringFieldEditor(sender: Pointer); cdecl;
    procedure insertText(insertString: Pointer); cdecl;
    function interfaceStyle: NSInterfaceStyle; cdecl;
    procedure interpretKeyEvents(eventArray: NSArray); cdecl;
    procedure keyDown(theEvent: NSEvent); cdecl;
    procedure keyUp(theEvent: NSEvent); cdecl;
    procedure lowercaseWord(sender: Pointer); cdecl;
    procedure magnifyWithEvent(event: NSEvent); cdecl;
    procedure makeBaseWritingDirectionLeftToRight(sender: Pointer); cdecl;
    procedure makeBaseWritingDirectionNatural(sender: Pointer); cdecl;
    procedure makeBaseWritingDirectionRightToLeft(sender: Pointer); cdecl;
    procedure makeTextWritingDirectionLeftToRight(sender: Pointer); cdecl;
    procedure makeTextWritingDirectionNatural(sender: Pointer); cdecl;
    procedure makeTextWritingDirectionRightToLeft(sender: Pointer); cdecl;
    function menu: NSMenu; cdecl;
    procedure mouseDown(theEvent: NSEvent); cdecl;
    procedure mouseDragged(theEvent: NSEvent); cdecl;
    procedure mouseEntered(theEvent: NSEvent); cdecl;
    procedure mouseExited(theEvent: NSEvent); cdecl;
    procedure mouseMoved(theEvent: NSEvent); cdecl;
    procedure mouseUp(theEvent: NSEvent); cdecl;
    procedure moveBackward(sender: Pointer); cdecl;
    procedure moveBackwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveDown(sender: Pointer); cdecl;
    procedure moveDownAndModifySelection(sender: Pointer); cdecl;
    procedure moveForward(sender: Pointer); cdecl;
    procedure moveForwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveLeft(sender: Pointer); cdecl;
    procedure moveLeftAndModifySelection(sender: Pointer); cdecl;
    procedure moveParagraphBackwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveParagraphForwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveRight(sender: Pointer); cdecl;
    procedure moveRightAndModifySelection(sender: Pointer); cdecl;
    procedure moveToBeginningOfDocument(sender: Pointer); cdecl;
    procedure moveToBeginningOfDocumentAndModifySelection(sender: Pointer); cdecl;
    procedure moveToBeginningOfLine(sender: Pointer); cdecl;
    procedure moveToBeginningOfLineAndModifySelection(sender: Pointer); cdecl;
    procedure moveToBeginningOfParagraph(sender: Pointer); cdecl;
    procedure moveToBeginningOfParagraphAndModifySelection(sender: Pointer); cdecl;
    procedure moveToEndOfDocument(sender: Pointer); cdecl;
    procedure moveToEndOfDocumentAndModifySelection(sender: Pointer); cdecl;
    procedure moveToEndOfLine(sender: Pointer); cdecl;
    procedure moveToEndOfLineAndModifySelection(sender: Pointer); cdecl;
    procedure moveToEndOfParagraph(sender: Pointer); cdecl;
    procedure moveToEndOfParagraphAndModifySelection(sender: Pointer); cdecl;
    procedure moveToLeftEndOfLine(sender: Pointer); cdecl;
    procedure moveToLeftEndOfLineAndModifySelection(sender: Pointer); cdecl;
    procedure moveToRightEndOfLine(sender: Pointer); cdecl;
    procedure moveToRightEndOfLineAndModifySelection(sender: Pointer); cdecl;
    procedure moveUp(sender: Pointer); cdecl;
    procedure moveUpAndModifySelection(sender: Pointer); cdecl;
    procedure moveWordBackward(sender: Pointer); cdecl;
    procedure moveWordBackwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveWordForward(sender: Pointer); cdecl;
    procedure moveWordForwardAndModifySelection(sender: Pointer); cdecl;
    procedure moveWordLeft(sender: Pointer); cdecl;
    procedure moveWordLeftAndModifySelection(sender: Pointer); cdecl;
    procedure moveWordRight(sender: Pointer); cdecl;
    procedure moveWordRightAndModifySelection(sender: Pointer); cdecl;
    function nextResponder: NSResponder; cdecl;
    procedure noResponderFor(eventSelector: SEL); cdecl;
    procedure otherMouseDown(theEvent: NSEvent); cdecl;
    procedure otherMouseDragged(theEvent: NSEvent); cdecl;
    procedure otherMouseUp(theEvent: NSEvent); cdecl;
    procedure pageDown(sender: Pointer); cdecl;
    procedure pageDownAndModifySelection(sender: Pointer); cdecl;
    procedure pageUp(sender: Pointer); cdecl;
    procedure pageUpAndModifySelection(sender: Pointer); cdecl;
    function performKeyEquivalent(theEvent: NSEvent): Boolean; cdecl;
    function performMnemonic(theString: NSString): Boolean; cdecl;
    function presentError(error: NSError): Boolean; cdecl; overload;
    procedure presentError(error: NSError; modalForWindow: NSWindow; delegate: Pointer; didPresentSelector: SEL; contextInfo: Pointer); cdecl; overload;
    function resignFirstResponder: Boolean; cdecl;
    procedure rightMouseDown(theEvent: NSEvent); cdecl;
    procedure rightMouseDragged(theEvent: NSEvent); cdecl;
    procedure rightMouseUp(theEvent: NSEvent); cdecl;
    procedure rotateWithEvent(event: NSEvent); cdecl;
    procedure scrollLineDown(sender: Pointer); cdecl;
    procedure scrollLineUp(sender: Pointer); cdecl;
    procedure scrollPageDown(sender: Pointer); cdecl;
    procedure scrollPageUp(sender: Pointer); cdecl;
    procedure scrollToBeginningOfDocument(sender: Pointer); cdecl;
    procedure scrollToEndOfDocument(sender: Pointer); cdecl;
    procedure scrollWheel(theEvent: NSEvent); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure selectLine(sender: Pointer); cdecl;
    procedure selectParagraph(sender: Pointer); cdecl;
    procedure selectToMark(sender: Pointer); cdecl;
    procedure selectWord(sender: Pointer); cdecl;
    procedure setInterfaceStyle(interfaceStyle: NSInterfaceStyle); cdecl;
    procedure setMark(sender: Pointer); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setNextResponder(aResponder: NSResponder); cdecl;
    function shouldBeTreatedAsInkEvent(theEvent: NSEvent): Boolean; cdecl;
    procedure showContextHelp(sender: Pointer); cdecl;
    procedure swapWithMark(sender: Pointer); cdecl;
    procedure swipeWithEvent(event: NSEvent); cdecl;
    procedure tabletPoint(theEvent: NSEvent); cdecl;
    procedure tabletProximity(theEvent: NSEvent); cdecl;
    procedure touchesBeganWithEvent(event: NSEvent); cdecl;
    procedure touchesCancelledWithEvent(event: NSEvent); cdecl;
    procedure touchesEndedWithEvent(event: NSEvent); cdecl;
    procedure touchesMovedWithEvent(event: NSEvent); cdecl;
    procedure transpose(sender: Pointer); cdecl;
    procedure transposeWords(sender: Pointer); cdecl;
    function undoManager: NSUndoManager; cdecl;
    procedure uppercaseWord(sender: Pointer); cdecl;
    function validRequestorForSendType(sendType: NSString; returnType: NSString): Pointer; cdecl;
    function willPresentError(error: NSError): NSError; cdecl;
    procedure yank(sender: Pointer); cdecl;
  end;
  TNSResponder = class(TOCGenericImport<NSResponderClass, NSResponder>)  end;

  NSRulerMarkerClass = interface(NSObjectClass)
    ['{0C8A0A68-CCDA-4BBF-8A53-55E68C92602E}']
  end;
  NSRulerMarker = interface(NSObject)
    ['{BE2223D8-E34B-498F-B730-0522C81EB857}']
    procedure drawRect(rect: NSRect); cdecl;
    function image: NSImage; cdecl;
    function imageOrigin: NSPoint; cdecl;
    function imageRectInRuler: NSRect; cdecl;
    function initWithRulerView(ruler: NSRulerView; markerLocation: Single; image: NSImage; imageOrigin: NSPoint): Pointer; cdecl;
    function isDragging: Boolean; cdecl;
    function isMovable: Boolean; cdecl;
    function isRemovable: Boolean; cdecl;
    function markerLocation: Single; cdecl;
    function representedObject: NSCopying; cdecl;
    function ruler: NSRulerView; cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setImageOrigin(imageOrigin: NSPoint); cdecl;
    procedure setMarkerLocation(location: Single); cdecl;
    procedure setMovable(flag: Boolean); cdecl;
    procedure setRemovable(flag: Boolean); cdecl;
    procedure setRepresentedObject(representedObject: NSCopying); cdecl;
    function thicknessRequiredInRuler: Single; cdecl;
    function trackMouse(mouseDownEvent: NSEvent; adding: Boolean): Boolean; cdecl;
  end;
  TNSRulerMarker = class(TOCGenericImport<NSRulerMarkerClass, NSRulerMarker>)  end;

  NSSpellCheckerClass = interface(NSObjectClass)
    ['{44ED506C-2D7B-4919-9071-0A0AC2CF619D}']
    {class} function sharedSpellChecker: Pointer; cdecl;
    {class} function sharedSpellCheckerExists: Boolean; cdecl;
    {class} function uniqueSpellDocumentTag: NSInteger; cdecl;
  end;
  NSSpellChecker = interface(NSObject)
    ['{70C821F1-29BE-4256-A315-9D8120575AB0}']
    function accessoryView: NSView; cdecl;
    function automaticallyIdentifiesLanguages: Boolean; cdecl;
    function availableLanguages: NSArray; cdecl;
    function checkGrammarOfString(stringToCheck: NSString; startingAt: NSInteger; language: NSString; wrap: Boolean; inSpellDocumentWithTag: NSInteger; details: NSArray): NSRange; cdecl;
    function checkSpellingOfString(stringToCheck: NSString; startingAt: NSInteger): NSRange; cdecl; overload;
    function checkSpellingOfString(stringToCheck: NSString; startingAt: NSInteger; language: NSString; wrap: Boolean; inSpellDocumentWithTag: NSInteger; wordCount: NSInteger): NSRange; cdecl; overload;
    function checkString(stringToCheck: NSString; range: NSRange; types: NSTextCheckingTypes; options: NSDictionary; inSpellDocumentWithTag: NSInteger; orthography: NSOrthography; wordCount: NSInteger): NSArray; cdecl;
    procedure closeSpellDocumentWithTag(tag: NSInteger); cdecl;
    function completionsForPartialWordRange(range: NSRange; inString: NSString; language: NSString; inSpellDocumentWithTag: NSInteger): NSArray; cdecl;
    function countWordsInString(stringToCount: NSString; language: NSString): NSInteger; cdecl;
    procedure forgetWord(word: NSString); cdecl;
    function guessesForWord(word: NSString): NSArray; cdecl;
    function guessesForWordRange(range: NSRange; inString: NSString; language: NSString; inSpellDocumentWithTag: NSInteger): NSArray; cdecl;
    function hasLearnedWord(word: NSString): Boolean; cdecl;
    procedure ignoreWord(wordToIgnore: NSString; inSpellDocumentWithTag: NSInteger); cdecl;
    function ignoredWordsInSpellDocumentWithTag(tag: NSInteger): NSArray; cdecl;
    function language: NSString; cdecl;
    procedure learnWord(word: NSString); cdecl;
    procedure setAccessoryView(aView: NSView); cdecl;
    procedure setAutomaticallyIdentifiesLanguages(flag: Boolean); cdecl;
    procedure setIgnoredWords(words: NSArray; inSpellDocumentWithTag: NSInteger); cdecl;
    function setLanguage(language: NSString): Boolean; cdecl;
    procedure setSubstitutionsPanelAccessoryViewController(accessoryController: NSViewController); cdecl;
    procedure setWordFieldStringValue(aString: NSString); cdecl;
    function spellingPanel: NSPanel; cdecl;
    function substitutionsPanel: NSPanel; cdecl;
    function substitutionsPanelAccessoryViewController: NSViewController; cdecl;
    procedure unlearnWord(word: NSString); cdecl;
    procedure updatePanels; cdecl;
    procedure updateSpellingPanelWithGrammarString(string_: NSString; detail: NSDictionary); cdecl;
    procedure updateSpellingPanelWithMisspelledWord(word: NSString); cdecl;
    function userPreferredLanguages: NSArray; cdecl;
    function userQuotesArrayForLanguage(language: NSString): NSArray; cdecl;
    function userReplacementsDictionary: NSDictionary; cdecl;
  end;
  TNSSpellChecker = class(TOCGenericImport<NSSpellCheckerClass, NSSpellChecker>)  end;

  NSPrintPanelClass = interface(NSObjectClass)
    ['{31CBE0AA-B000-4869-8392-80C8882B44A4}']
    {class} function printPanel: Pointer; cdecl;
  end;
  NSPrintPanel = interface(NSObject)
    ['{7426E681-609D-45C3-A718-8E2B3A4B9C6B}']
    function accessoryControllers: NSArray; cdecl;
    function accessoryView: NSView; cdecl;
    procedure addAccessoryController(accessoryController: Pointer); cdecl;
    procedure beginSheetWithPrintInfo(printInfo: NSPrintInfo; modalForWindow: NSWindow; delegate: Pointer; didEndSelector: SEL; contextInfo: Pointer); cdecl;
    function defaultButtonTitle: NSString; cdecl;
    procedure finalWritePrintInfo; cdecl;
    function helpAnchor: NSString; cdecl;
    function jobStyleHint: NSString; cdecl;
    function options: NSPrintPanelOptions; cdecl;
    function printInfo: NSPrintInfo; cdecl;
    procedure removeAccessoryController(accessoryController: Pointer); cdecl;
    function runModal: NSInteger; cdecl;
    function runModalWithPrintInfo(printInfo: NSPrintInfo): NSInteger; cdecl;
    procedure setAccessoryView(accessoryView: NSView); cdecl;
    procedure setDefaultButtonTitle(defaultButtonTitle: NSString); cdecl;
    procedure setHelpAnchor(helpAnchor: NSString); cdecl;
    procedure setJobStyleHint(hint: NSString); cdecl;
    procedure setOptions(options: NSPrintPanelOptions); cdecl;
    procedure updateFromPrintInfo; cdecl;
  end;
  TNSPrintPanel = class(TOCGenericImport<NSPrintPanelClass, NSPrintPanel>)  end;

  NSPrinterClass = interface(NSObjectClass)
    ['{FAF2D212-3AE3-4856-8D06-B8612F2EBB83}']
    {class} function printerNames: NSArray; cdecl;
    {class} function printerTypes: NSArray; cdecl;
    {class} function printerWithName(name: NSString): Pointer; cdecl; overload;
    {class} function printerWithName(name: NSString; domain: NSString; includeUnavailable: Boolean): Pointer; cdecl; overload;
    {class} function printerWithType(type_: NSString): Pointer; cdecl;
  end;
  NSPrinter = interface(NSObject)
    ['{9AE38EA4-D4F9-42EE-AAE4-4C4C8530E393}']
    function acceptsBinary: Boolean; cdecl;
    function booleanForKey(key: NSString; inTable: NSString): Boolean; cdecl;
    function deviceDescription: NSDictionary; cdecl;
    function domain: NSString; cdecl;
    function floatForKey(key: NSString; inTable: NSString): Single; cdecl;
    function host: NSString; cdecl;
    function imageRectForPaper(paperName: NSString): NSRect; cdecl;
    function intForKey(key: NSString; inTable: NSString): Integer; cdecl;
    function isColor: Boolean; cdecl;
    function isFontAvailable(faceName: NSString): Boolean; cdecl;
    function isKey(key: NSString; inTable: NSString): Boolean; cdecl;
    function isOutputStackInReverseOrder: Boolean; cdecl;
    function languageLevel: NSInteger; cdecl;
    function name: NSString; cdecl;
    function note: NSString; cdecl;
    function pageSizeForPaper(paperName: NSString): NSSize; cdecl;
    function rectForKey(key: NSString; inTable: NSString): NSRect; cdecl;
    function sizeForKey(key: NSString; inTable: NSString): NSSize; cdecl;
    function statusForTable(tableName: NSString): NSPrinterTableStatus; cdecl;
    function stringForKey(key: NSString; inTable: NSString): NSString; cdecl;
    function stringListForKey(key: NSString; inTable: NSString): NSArray; cdecl;
  end;
  TNSPrinter = class(TOCGenericImport<NSPrinterClass, NSPrinter>)  end;

  NSStatusBarClass = interface(NSObjectClass)
    ['{93EA825A-21B9-4600-B7BF-3EA2E9CFCB52}']
    {class} function systemStatusBar: Pointer; cdecl;
  end;
  NSStatusBar = interface(NSObject)
    ['{45BEB77D-382C-47C4-8AEF-8C58AAF0426A}']
    function isVertical: Boolean; cdecl;
    procedure removeStatusItem(item: NSStatusItem); cdecl;
    function statusItemWithLength(length: Single): NSStatusItem; cdecl;
    function thickness: Single; cdecl;
  end;
  TNSStatusBar = class(TOCGenericImport<NSStatusBarClass, NSStatusBar>)  end;

  NSSpeechRecognizerClass = interface(NSObjectClass)
    ['{08830BE3-6DD5-4716-B8FB-BA04CF110137}']
  end;
  NSSpeechRecognizer = interface(NSObject)
    ['{2B5954F3-E2D7-4982-A3E2-0F37B3CE9C90}']
    function blocksOtherRecognizers: Boolean; cdecl;
    function commands: NSArray; cdecl;
    function delegate: NSSpeechRecognizerDelegate; cdecl;
    function displayedCommandsTitle: NSString; cdecl;
    function init: Pointer; cdecl;
    function listensInForegroundOnly: Boolean; cdecl;
    procedure setBlocksOtherRecognizers(flag: Boolean); cdecl;
    procedure setCommands(commands: NSArray); cdecl;
    procedure setDelegate(anObject: NSSpeechRecognizerDelegate); cdecl;
    procedure setDisplayedCommandsTitle(title: NSString); cdecl;
    procedure setListensInForegroundOnly(flag: Boolean); cdecl;
    procedure startListening; cdecl;
    procedure stopListening; cdecl;
  end;
  TNSSpeechRecognizer = class(TOCGenericImport<NSSpeechRecognizerClass, NSSpeechRecognizer>)  end;

  NSSoundClass = interface(NSObjectClass)
    ['{43FA5CFD-D9A0-42B1-95D4-52D80CF3FFEE}']
    {class} function canInitWithPasteboard(pasteboard: NSPasteboard): Boolean; cdecl;
    {class} function soundNamed(name: NSString): Pointer; cdecl;
    {class} function soundUnfilteredFileTypes: NSArray; cdecl;
    {class} function soundUnfilteredPasteboardTypes: NSArray; cdecl;
    {class} function soundUnfilteredTypes: NSArray; cdecl;
  end;
  NSSound = interface(NSObject)
    ['{B1FD8017-92ED-4826-8F71-E535ED8602A9}']
    function channelMapping: NSArray; cdecl;
    function currentTime: NSTimeInterval; cdecl;
    function delegate: NSSoundDelegate; cdecl;
    function duration: NSTimeInterval; cdecl;
    function initWithContentsOfFile(path: NSString; byReference: Boolean): Pointer; cdecl;
    function initWithContentsOfURL(url: NSURL; byReference: Boolean): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithPasteboard(pasteboard: NSPasteboard): Pointer; cdecl;
    function isPlaying: Boolean; cdecl;
    function loops: Boolean; cdecl;
    function name: NSString; cdecl;
    function pause: Boolean; cdecl;
    function play: Boolean; cdecl;
    function playbackDeviceIdentifier: NSString; cdecl;
    function resume: Boolean; cdecl;
    procedure setChannelMapping(channelMapping: NSArray); cdecl;
    procedure setCurrentTime(seconds: NSTimeInterval); cdecl;
    procedure setDelegate(aDelegate: NSSoundDelegate); cdecl;
    procedure setLoops(val: Boolean); cdecl;
    function setName(string_: NSString): Boolean; cdecl;
    procedure setPlaybackDeviceIdentifier(deviceUID: NSString); cdecl;
    procedure setVolume(volume: Single); cdecl;
    function stop: Boolean; cdecl;
    function volume: Single; cdecl;
    procedure writeToPasteboard(pasteboard: NSPasteboard); cdecl;
  end;
  TNSSound = class(TOCGenericImport<NSSoundClass, NSSound>)  end;

  NSShadowClass = interface(NSObjectClass)
    ['{A76B6922-6710-4669-97D2-31235439AD7A}']
  end;
  NSShadow = interface(NSObject)
    ['{6E25F056-73C1-41CD-86AE-9C44A1CAD0CE}']
    function init: Pointer; cdecl;
    procedure setShadowBlurRadius(val: Single); cdecl;
    procedure setShadowColor(color: NSColor); cdecl;
    procedure setShadowOffset(offset: NSSize); cdecl;
    function shadowBlurRadius: Single; cdecl;
    function shadowColor: NSColor; cdecl;
    function shadowOffset: NSSize; cdecl;
  end;
  TNSShadow = class(TOCGenericImport<NSShadowClass, NSShadow>)  end;

  NSRunningApplicationClass = interface(NSObjectClass)
    ['{AADD2BBA-A243-4C4B-B205-CD111178251D}']
    {class} function currentApplication: Pointer; cdecl;
    {class} function runningApplicationWithProcessIdentifier(pid: Integer): Pointer; cdecl;
    {class} function runningApplicationsWithBundleIdentifier(bundleIdentifier: NSString): NSArray; cdecl;
  end;
  NSRunningApplication = interface(NSObject)
    ['{96F4D9CA-0732-4557-BA1F-177958903B8F}']
    function activateWithOptions(options: NSApplicationActivationOptions): Boolean; cdecl;
    function activationPolicy: NSApplicationActivationPolicy; cdecl;
    function executableArchitecture: NSInteger; cdecl;
    function forceTerminate: Boolean; cdecl;
    function hide: Boolean; cdecl;
    function isActive: Boolean; cdecl;
    function isFinishedLaunching: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isTerminated: Boolean; cdecl;
    function processIdentifier: Integer; cdecl;
    function terminate: Boolean; cdecl;
    function unhide: Boolean; cdecl;
  end;
  TNSRunningApplication = class(TOCGenericImport<NSRunningApplicationClass, NSRunningApplication>)  end;

  NSSpeechSynthesizerClass = interface(NSObjectClass)
    ['{10BB1567-0104-461E-AF48-FD4DA9838F48}']
    {class} function attributesForVoice(voice: NSString): NSDictionary; cdecl;
    {class} function availableVoices: NSArray; cdecl;
    {class} function defaultVoice: NSString; cdecl;
    {class} function isAnyApplicationSpeaking: Boolean; cdecl;
  end;
  NSSpeechSynthesizer = interface(NSObject)
    ['{5E845558-A856-4A72-B346-0D7AEFF167C5}']
    procedure addSpeechDictionary(speechDictionary: NSDictionary); cdecl;
    procedure continueSpeaking; cdecl;
    function delegate: NSSpeechSynthesizerDelegate; cdecl;
    function initWithVoice(voice: NSString): Pointer; cdecl;
    function isSpeaking: Boolean; cdecl;
    function objectForProperty(property_: NSString; error: PPointer): Pointer; cdecl;
    procedure pauseSpeakingAtBoundary(boundary: NSSpeechBoundary); cdecl;
    function phonemesFromText(text: NSString): NSString; cdecl;
    function rate: Single; cdecl;
    procedure setDelegate(anObject: NSSpeechSynthesizerDelegate); cdecl;
    function setObject(object_: Pointer; forProperty: NSString; error: PPointer): Boolean; cdecl;
    procedure setRate(rate: Single); cdecl;
    procedure setUsesFeedbackWindow(flag: Boolean); cdecl;
    function setVoice(voice: NSString): Boolean; cdecl;
    procedure setVolume(volume: Single); cdecl;
    function startSpeakingString(string_: NSString): Boolean; cdecl; overload;
    function startSpeakingString(string_: NSString; toURL: NSURL): Boolean; cdecl; overload;
    procedure stopSpeaking; cdecl;
    procedure stopSpeakingAtBoundary(boundary: NSSpeechBoundary); cdecl;
    function usesFeedbackWindow: Boolean; cdecl;
    function voice: NSString; cdecl;
    function volume: Single; cdecl;
  end;
  TNSSpeechSynthesizer = class(TOCGenericImport<NSSpeechSynthesizerClass, NSSpeechSynthesizer>)  end;

  NSScreenClass = interface(NSObjectClass)
    ['{42D1323B-1E55-4145-9CA4-3D31206435DD}']
    {class} function deepestScreen: Pointer; cdecl;
    {class} function mainScreen: Pointer; cdecl;
    {class} function screens: NSArray; cdecl;
  end;
  NSScreen = interface(NSObject)
    ['{B028399B-E028-47BF-94D1-3B5F12C83773}']
    function colorSpace: NSColorSpace; cdecl;
    function depth: NSWindowDepth; cdecl;
    function deviceDescription: NSDictionary; cdecl;
    function frame: NSRect; cdecl;
    function supportedWindowDepths: NSWindowDepth; cdecl;
    function userSpaceScaleFactor: Single; cdecl;
    function visibleFrame: NSRect; cdecl;
    function backingScaleFactor: CGFloat; cdecl; // OS X 10.7+
  end;
  TNSScreen = class(TOCGenericImport<NSScreenClass, NSScreen>)  end;

  NSPrintOperationClass = interface(NSObjectClass)
    ['{4A0A9B2E-ED0B-4248-AA3B-8364D56812F3}']
    {class} function EPSOperationWithView(view: NSView; insideRect: NSRect; toData: NSMutableData): Pointer; cdecl; overload;
    {class} function EPSOperationWithView(view: NSView; insideRect: NSRect; toData: NSMutableData; printInfo: NSPrintInfo): Pointer; cdecl; overload;
    {class} function EPSOperationWithView(view: NSView; insideRect: NSRect; toPath: NSString; printInfo: NSPrintInfo): Pointer; cdecl; overload;
    {class} function PDFOperationWithView(view: NSView; insideRect: NSRect; toData: NSMutableData): Pointer; cdecl; overload;
    {class} function PDFOperationWithView(view: NSView; insideRect: NSRect; toData: NSMutableData; printInfo: NSPrintInfo): Pointer; cdecl; overload;
    {class} function PDFOperationWithView(view: NSView; insideRect: NSRect; toPath: NSString; printInfo: NSPrintInfo): Pointer; cdecl; overload;
    {class} function currentOperation: Pointer; cdecl;
    {class} function printOperationWithView(view: NSView): Pointer; cdecl; overload;
    {class} function printOperationWithView(view: NSView; printInfo: NSPrintInfo): Pointer; cdecl; overload;
    {class} procedure setCurrentOperation(operation: NSPrintOperation); cdecl;
  end;
  NSPrintOperation = interface(NSObject)
    ['{8F7CBF9F-F339-4D2F-97CD-778093CC855C}']
    function accessoryView: NSView; cdecl;
    function canSpawnSeparateThread: Boolean; cdecl;
    procedure cleanUpOperation; cdecl;
    function context: NSGraphicsContext; cdecl;
    function createContext: NSGraphicsContext; cdecl;
    function currentPage: NSInteger; cdecl;
    function deliverResult: Boolean; cdecl;
    procedure destroyContext; cdecl;
    function isCopyingOperation: Boolean; cdecl;
    function jobStyleHint: NSString; cdecl;
    function jobTitle: NSString; cdecl;
    function pageOrder: NSPrintingPageOrder; cdecl;
    function pageRange: NSRange; cdecl;
    function printInfo: NSPrintInfo; cdecl;
    function printPanel: NSPrintPanel; cdecl;
    function runOperation: Boolean; cdecl;
    procedure runOperationModalForWindow(docWindow: NSWindow; delegate: Pointer; didRunSelector: SEL; contextInfo: Pointer); cdecl;
    procedure setAccessoryView(view: NSView); cdecl;
    procedure setCanSpawnSeparateThread(canSpawnSeparateThread: Boolean); cdecl;
    procedure setJobStyleHint(hint: NSString); cdecl;
    procedure setJobTitle(jobTitle: NSString); cdecl;
    procedure setPageOrder(pageOrder: NSPrintingPageOrder); cdecl;
    procedure setPrintInfo(printInfo: NSPrintInfo); cdecl;
    procedure setPrintPanel(panel: NSPrintPanel); cdecl;
    procedure setShowPanels(flag: Boolean); cdecl;
    procedure setShowsPrintPanel(flag: Boolean); cdecl;
    procedure setShowsProgressPanel(flag: Boolean); cdecl;
    function showPanels: Boolean; cdecl;
    function showsPrintPanel: Boolean; cdecl;
    function showsProgressPanel: Boolean; cdecl;
    function view: NSView; cdecl;
  end;
  TNSPrintOperation = class(TOCGenericImport<NSPrintOperationClass, NSPrintOperation>)  end;

  NSParagraphStyleClass = interface(NSObjectClass)
    ['{B57C05DD-D7AC-43C2-A87F-9767B674ACAF}']
    {class} function defaultParagraphStyle: Pointer; cdecl;
    {class} function defaultWritingDirectionForLanguage(languageName: NSString): NSWritingDirection; cdecl;
  end;
  NSParagraphStyle = interface(NSObject)
    ['{0AA0D566-996F-4B07-9B73-AFA8B3343E78}']
    function alignment: NSTextAlignment; cdecl;
    function baseWritingDirection: NSWritingDirection; cdecl;
    function defaultTabInterval: Single; cdecl;
    function firstLineHeadIndent: Single; cdecl;
    function headIndent: Single; cdecl;
    function headerLevel: NSInteger; cdecl;
    function hyphenationFactor: Single; cdecl;
    function lineBreakMode: NSLineBreakMode; cdecl;
    function lineHeightMultiple: Single; cdecl;
    function lineSpacing: Single; cdecl;
    function maximumLineHeight: Single; cdecl;
    function minimumLineHeight: Single; cdecl;
    function paragraphSpacing: Single; cdecl;
    function paragraphSpacingBefore: Single; cdecl;
    function tabStops: NSArray; cdecl;
    function tailIndent: Single; cdecl;
    function textBlocks: NSArray; cdecl;
    function textLists: NSArray; cdecl;
    function tighteningFactorForTruncation: Single; cdecl;
  end;
  TNSParagraphStyle = class(TOCGenericImport<NSParagraphStyleClass, NSParagraphStyle>)  end;

  NSPasteboardClass = interface(NSObjectClass)
    ['{3B34E88C-AA32-4309-B097-197F3E02BEC8}']
    {class} function generalPasteboard: Pointer; cdecl;
    {class} function pasteboardByFilteringData(data: NSData; ofType: NSString): Pointer; cdecl;
    {class} function pasteboardByFilteringFile(filename: NSString): Pointer; cdecl;
    {class} function pasteboardByFilteringTypesInPasteboard(pboard: NSPasteboard): Pointer; cdecl;
    {class} function pasteboardWithName(name: NSString): Pointer; cdecl;
    {class} function pasteboardWithUniqueName: Pointer; cdecl;
    {class} function typesFilterableTo(type_: NSString): NSArray; cdecl;
  end;
  NSPasteboard = interface(NSObject)
    ['{1236EC3F-367E-4F35-BCF3-5C9853B7EED9}']
    function addTypes(newTypes: NSArray; owner: Pointer): NSInteger; cdecl;
    function availableTypeFromArray(types: NSArray): NSString; cdecl;
    function canReadItemWithDataConformingToTypes(types: NSArray): Boolean; cdecl;
    function canReadObjectForClasses(classArray: NSArray; options: NSDictionary): Boolean; cdecl;
    function changeCount: NSInteger; cdecl;
    function clearContents: NSInteger; cdecl;
    function dataForType(dataType: NSString): NSData; cdecl;
    function declareTypes(newTypes: NSArray; owner: Pointer): NSInteger; cdecl;
    function indexOfPasteboardItem(pasteboardItem: NSPasteboardItem): NSUInteger; cdecl;
    function name: NSString; cdecl;
    function pasteboardItems: NSArray; cdecl;
    function propertyListForType(dataType: NSString): Pointer; cdecl;
    function readFileContentsType(type_: NSString; toFile: NSString): NSString; cdecl;
    function readFileWrapper: NSFileWrapper; cdecl;
    function readObjectsForClasses(classArray: NSArray; options: NSDictionary): NSArray; cdecl;
    procedure releaseGlobally; cdecl;
    function setData(data: NSData; forType: NSString): Boolean; cdecl;
    function setPropertyList(plist: Pointer; forType: NSString): Boolean; cdecl;
    function setString(string_: NSString; forType: NSString): Boolean; cdecl;
    function stringForType(dataType: NSString): NSString; cdecl;
    function types: NSArray; cdecl;
    function writeFileContents(filename: NSString): Boolean; cdecl;
    function writeFileWrapper(wrapper: NSFileWrapper): Boolean; cdecl;
    function writeObjects(objects: NSArray): Boolean; cdecl;
  end;
  TNSPasteboard = class(TOCGenericImport<NSPasteboardClass, NSPasteboard>)  end;

  NSPasteboardItemClass = interface(NSObjectClass)
    ['{86C0318B-4DAA-45D3-9D6E-446950462747}']
  end;
  NSPasteboardItem = interface(NSObject)
    ['{EC7DC485-0151-48DC-91B8-7FDF8F6E63CE}']
    function availableTypeFromArray(types: NSArray): NSString; cdecl;
    function dataForType(type_: NSString): NSData; cdecl;
    function propertyListForType(type_: NSString): Pointer; cdecl;
    function setData(data: NSData; forType: NSString): Boolean; cdecl;
    function setDataProvider(dataProvider: NSPasteboardItemDataProvider; forTypes: NSArray): Boolean; cdecl;
    function setPropertyList(propertyList: Pointer; forType: NSString): Boolean; cdecl;
    function setString(string_: NSString; forType: NSString): Boolean; cdecl;
    function stringForType(type_: NSString): NSString; cdecl;
    function types: NSArray; cdecl;
  end;
  TNSPasteboardItem = class(TOCGenericImport<NSPasteboardItemClass, NSPasteboardItem>)  end;

  NSTextBlockClass = interface(NSObjectClass)
    ['{03F035C2-08A1-4328-96D3-1F4CC07EC88D}']
  end;
  NSTextBlock = interface(NSObject)
    ['{4C599561-7B86-4D89-86F1-1E7A7BDC4488}']
    function backgroundColor: NSColor; cdecl;
    function borderColorForEdge(edge: NSRectEdge): NSColor; cdecl;
    function boundsRectForContentRect(contentRect: NSRect; inRect: NSRect; textContainer: NSTextContainer; characterRange: NSRange): NSRect; cdecl;
    function contentWidth: Single; cdecl;
    function contentWidthValueType: NSTextBlockValueType; cdecl;
    procedure drawBackgroundWithFrame(frameRect: NSRect; inView: NSView; characterRange: NSRange; layoutManager: NSLayoutManager); cdecl;
    function init: Pointer; cdecl;
    function rectForLayoutAtPoint(startingPoint: NSPoint; inRect: NSRect; textContainer: NSTextContainer; characterRange: NSRange): NSRect; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBorderColor(color: NSColor); cdecl; overload;
    procedure setBorderColor(color: NSColor; forEdge: NSRectEdge); cdecl; overload;
    procedure setVerticalAlignment(alignment: NSTextBlockVerticalAlignment); cdecl;
    function valueForDimension(dimension: NSTextBlockDimension): Single; cdecl;
    function valueTypeForDimension(dimension: NSTextBlockDimension): NSTextBlockValueType; cdecl;
    function verticalAlignment: NSTextBlockVerticalAlignment; cdecl;
    function widthForLayer(layer: NSTextBlockLayer; edge: NSRectEdge): Single; cdecl;
    function widthValueTypeForLayer(layer: NSTextBlockLayer; edge: NSRectEdge): NSTextBlockValueType; cdecl;
  end;
  TNSTextBlock = class(TOCGenericImport<NSTextBlockClass, NSTextBlock>)  end;

  NSTextAttachmentClass = interface(NSObjectClass)
    ['{A5718B19-F915-4D36-935F-358FA4457980}']
  end;
  NSTextAttachment = interface(NSObject)
    ['{0A367809-B06D-4671-809D-1ABB4DF1D7ED}']
    function attachmentCell: NSTextAttachmentCell; cdecl;
    function fileWrapper: NSFileWrapper; cdecl;
    function initWithFileWrapper(fileWrapper: NSFileWrapper): Pointer; cdecl;
    procedure setAttachmentCell(cell: NSTextAttachmentCell); cdecl;
    procedure setFileWrapper(fileWrapper: NSFileWrapper); cdecl;
  end;
  TNSTextAttachment = class(TOCGenericImport<NSTextAttachmentClass, NSTextAttachment>)  end;

  NSPageLayoutClass = interface(NSObjectClass)
    ['{DF9F30DD-ABCB-4C28-8E0B-4AA7E6B4F616}']
    {class} function pageLayout: Pointer; cdecl;
  end;
  NSPageLayout = interface(NSObject)
    ['{5DD0F395-1E87-4AA2-A7E2-62F51DB80D32}']
    function accessoryControllers: NSArray; cdecl;
    function accessoryView: NSView; cdecl;
    procedure addAccessoryController(accessoryController: NSViewController); cdecl;
    procedure beginSheetWithPrintInfo(printInfo: NSPrintInfo; modalForWindow: NSWindow; delegate: Pointer; didEndSelector: SEL; contextInfo: Pointer); cdecl;
    function printInfo: NSPrintInfo; cdecl;
    procedure readPrintInfo; cdecl;
    procedure removeAccessoryController(accessoryController: NSViewController); cdecl;
    function runModal: NSInteger; cdecl;
    function runModalWithPrintInfo(printInfo: NSPrintInfo): NSInteger; cdecl;
    procedure setAccessoryView(accessoryView: NSView); cdecl;
    procedure writePrintInfo; cdecl;
  end;
  TNSPageLayout = class(TOCGenericImport<NSPageLayoutClass, NSPageLayout>)  end;

  NSStatusItemClass = interface(NSObjectClass)
    ['{0C77D900-133B-49AC-B2C2-7252BA4D8FA9}']
  end;
  NSStatusItem = interface(NSObject)
    ['{737C08A3-4247-4E6A-8428-829577CAF768}']
    function action: SEL; cdecl;
    function alternateImage: NSImage; cdecl;
    function attributedTitle: NSAttributedString; cdecl;
    function doubleAction: SEL; cdecl;
    procedure drawStatusBarBackgroundInRect(rect: NSRect; withHighlight: Boolean); cdecl;
    function highlightMode: Boolean; cdecl;
    function image: NSImage; cdecl;
    function isEnabled: Boolean; cdecl;
    function length: Single; cdecl;
    function menu: NSMenu; cdecl;
    procedure popUpStatusItemMenu(menu: NSMenu); cdecl;
    function sendActionOn(mask: NSInteger): NSInteger; cdecl;
    procedure setAction(action: SEL); cdecl;
    procedure setAlternateImage(image: NSImage); cdecl;
    procedure setAttributedTitle(title: NSAttributedString); cdecl;
    procedure setDoubleAction(action: SEL); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setHighlightMode(highlightMode: Boolean); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setLength(length: Single); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setTarget(target: Pointer); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure setToolTip(toolTip: NSString); cdecl;
    procedure setView(view: NSView); cdecl;
    function statusBar: NSStatusBar; cdecl;
    function target: Pointer; cdecl;
    function title: NSString; cdecl;
    function toolTip: NSString; cdecl;
    function view: NSView; cdecl;
  end;
  TNSStatusItem = class(TOCGenericImport<NSStatusItemClass, NSStatusItem>)  end;

  NSPredicateEditorRowTemplateClass = interface(NSObjectClass)
    ['{259521B7-972A-47D5-BA87-FC3C18ED0887}']
//    {class} function templatesWithAttributeKeyPaths(keyPaths: NSArray; inEntityDescription: NSEntityDescription): NSArray; cdecl;
  end;
  NSPredicateEditorRowTemplate = interface(NSObject)
    ['{04A5381A-9085-4128-A16A-E9A62669D03B}']
    function compoundTypes: NSArray; cdecl;
    function displayableSubpredicatesOfPredicate(predicate: NSPredicate): NSArray; cdecl;
    function initWithCompoundTypes(compoundTypes: NSArray): Pointer; cdecl;
    function initWithLeftExpressions(leftExpressions: NSArray; rightExpressionAttributeType: NSAttributeType; modifier: NSComparisonPredicateModifier; operators: NSArray; options: NSUInteger): Pointer; cdecl; overload;
    function initWithLeftExpressions(leftExpressions: NSArray; rightExpressions: NSArray; modifier: NSComparisonPredicateModifier; operators: NSArray; options: NSUInteger): Pointer; cdecl; overload;
    function leftExpressions: NSArray; cdecl;
    function matchForPredicate(predicate: NSPredicate): double; cdecl;
    function modifier: NSComparisonPredicateModifier; cdecl;
    function operators: NSArray; cdecl;
    function options: NSUInteger; cdecl;
    function predicateWithSubpredicates(subpredicates: NSArray): NSPredicate; cdecl;
    function rightExpressionAttributeType: NSAttributeType; cdecl;
    function rightExpressions: NSArray; cdecl;
    procedure setPredicate(predicate: NSPredicate); cdecl;
    function templateViews: NSArray; cdecl;
  end;
  TNSPredicateEditorRowTemplate = class(TOCGenericImport<NSPredicateEditorRowTemplateClass, NSPredicateEditorRowTemplate>)  end;

  NSPrintInfoClass = interface(NSObjectClass)
    ['{6D7E07FC-4FAF-4EA1-BBB8-DA237324E9E2}']
    {class} function defaultPrinter: NSPrinter; cdecl;
    {class} procedure setDefaultPrinter(printer: NSPrinter); cdecl;
    {class} procedure setSharedPrintInfo(printInfo: NSPrintInfo); cdecl;
    {class} function sharedPrintInfo: Pointer; cdecl;
    {class} function sizeForPaperName(name: NSString): NSSize; cdecl;
  end;
  NSPrintInfo = interface(NSObject)
    ['{3546D2C9-ADFD-44DB-8193-472CB6BA9750}']
    function PMPageFormat: Pointer; cdecl;
    function PMPrintSession: Pointer; cdecl;
    function PMPrintSettings: Pointer; cdecl;
    function bottomMargin: Single; cdecl;
    function dictionary: NSMutableDictionary; cdecl;
    function horizontalPagination: NSPrintingPaginationMode; cdecl;
    function imageablePageBounds: NSRect; cdecl;
    function initWithDictionary(attributes: NSDictionary): Pointer; cdecl;
    function isHorizontallyCentered: Boolean; cdecl;
    function isSelectionOnly: Boolean; cdecl;
    function isVerticallyCentered: Boolean; cdecl;
    function jobDisposition: NSString; cdecl;
    function leftMargin: Single; cdecl;
    function localizedPaperName: NSString; cdecl;
    function orientation: NSPrintingOrientation; cdecl;
    function paperName: NSString; cdecl;
    function paperSize: NSSize; cdecl;
    function printSettings: NSMutableDictionary; cdecl;
    function printer: NSPrinter; cdecl;
    function rightMargin: Single; cdecl;
    function scalingFactor: Single; cdecl;
    procedure setBottomMargin(margin: Single); cdecl;
    procedure setHorizontalPagination(mode: NSPrintingPaginationMode); cdecl;
    procedure setHorizontallyCentered(flag: Boolean); cdecl;
    procedure setJobDisposition(disposition: NSString); cdecl;
    procedure setLeftMargin(margin: Single); cdecl;
    procedure setOrientation(orientation: NSPrintingOrientation); cdecl;
    procedure setPaperName(name: NSString); cdecl;
    procedure setPaperSize(size: NSSize); cdecl;
    procedure setPrinter(printer: NSPrinter); cdecl;
    procedure setRightMargin(margin: Single); cdecl;
    procedure setScalingFactor(scalingFactor: Single); cdecl;
    procedure setSelectionOnly(selectionOnly: Boolean); cdecl;
    procedure setTopMargin(margin: Single); cdecl;
    procedure setUpPrintOperationDefaultValues; cdecl;
    procedure setVerticalPagination(mode: NSPrintingPaginationMode); cdecl;
    procedure setVerticallyCentered(flag: Boolean); cdecl;
    function topMargin: Single; cdecl;
    procedure updateFromPMPageFormat; cdecl;
    procedure updateFromPMPrintSettings; cdecl;
    function verticalPagination: NSPrintingPaginationMode; cdecl;
  end;
  TNSPrintInfo = class(TOCGenericImport<NSPrintInfoClass, NSPrintInfo>)  end;

  NSTableColumnClass = interface(NSObjectClass)
    ['{7FC0B615-94AA-4C21-BCC8-10C979712532}']
  end;
  NSTableColumn = interface(NSObject)
    ['{6A4EAEFE-74A4-4287-BE99-4FA726C5C3B2}']
    function dataCell: Pointer; cdecl;
    function dataCellForRow(row: NSInteger): Pointer; cdecl;
    function headerCell: Pointer; cdecl;
    function headerToolTip: NSString; cdecl;
    function identifier: Pointer; cdecl;
    function initWithIdentifier(identifier: Pointer): Pointer; cdecl;
    function isEditable: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isResizable: Boolean; cdecl;
    function maxWidth: Single; cdecl;
    function minWidth: Single; cdecl;
    function resizingMask: NSUInteger; cdecl;
    procedure setDataCell(cell: NSCell); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setHeaderCell(cell: NSCell); cdecl;
    procedure setHeaderToolTip(string_: NSString); cdecl;
    procedure setHidden(hidden: Boolean); cdecl;
    procedure setIdentifier(identifier: Pointer); cdecl;
    procedure setMaxWidth(maxWidth: Single); cdecl;
    procedure setMinWidth(minWidth: Single); cdecl;
    procedure setResizable(flag: Boolean); cdecl;
    procedure setResizingMask(resizingMask: NSUInteger); cdecl;
    procedure setSortDescriptorPrototype(sortDescriptor: NSSortDescriptor); cdecl;
    procedure setTableView(tableView: NSTableView); cdecl;
    procedure setWidth(width: Single); cdecl;
    procedure sizeToFit; cdecl;
    function sortDescriptorPrototype: NSSortDescriptor; cdecl;
    function tableView: NSTableView; cdecl;
    function width: Single; cdecl;
  end;
  TNSTableColumn = class(TOCGenericImport<NSTableColumnClass, NSTableColumn>)  end;

  NSTabViewItemClass = interface(NSObjectClass)
    ['{65EA26C9-30D7-4DBB-A92C-EB8C8066F4FC}']
  end;
  NSTabViewItem = interface(NSObject)
    ['{AB46BA7D-3FD3-4056-931F-A3A3667429C6}']
    function color: NSColor; cdecl;
    procedure drawLabel(shouldTruncateLabel: Boolean; inRect: NSRect); cdecl;
    function identifier: Pointer; cdecl;
    function initWithIdentifier(identifier: Pointer): Pointer; cdecl;
    function initialFirstResponder: Pointer; cdecl;
    procedure setColor(color: NSColor); cdecl;
    procedure setIdentifier(identifier: Pointer); cdecl;
    procedure setInitialFirstResponder(view: NSView); cdecl;
    procedure setLabel(label_: NSString); cdecl;
    procedure setToolTip(toolTip: NSString); cdecl;
    procedure setView(view: NSView); cdecl;
    function sizeOfLabel(computeMin: Boolean): NSSize; cdecl;
    function tabState: NSTabState; cdecl;
    function tabView: NSTabView; cdecl;
    function toolTip: NSString; cdecl;
    function view: Pointer; cdecl;
  end;
  TNSTabViewItem = class(TOCGenericImport<NSTabViewItemClass, NSTabViewItem>)  end;

  NSTreeNodeClass = interface(NSObjectClass)
    ['{7F6EB420-2546-4693-B327-B4413708F9CD}']
    {class} function treeNodeWithRepresentedObject(modelObject: Pointer): Pointer; cdecl;
  end;
  NSTreeNode = interface(NSObject)
    ['{62BC83B8-4840-4E7C-AB1C-A4143CB23557}']
    function childNodes: NSArray; cdecl;
    function descendantNodeAtIndexPath(indexPath: NSIndexPath): NSTreeNode; cdecl;
    function indexPath: NSIndexPath; cdecl;
    function initWithRepresentedObject(modelObject: Pointer): Pointer; cdecl;
    function isLeaf: Boolean; cdecl;
    function mutableChildNodes: NSMutableArray; cdecl;
    function parentNode: NSTreeNode; cdecl;
    function representedObject: Pointer; cdecl;
    procedure sortWithSortDescriptors(sortDescriptors: NSArray; recursively: Boolean); cdecl;
  end;
  TNSTreeNode = class(TOCGenericImport<NSTreeNodeClass, NSTreeNode>)  end;

  NSCellClass = interface(NSObjectClass)
    ['{B05B9DDB-45A2-4977-A9CB-F0DBC0873B2A}']
    {class} function defaultFocusRingType: NSFocusRingType; cdecl;
    {class} function defaultMenu: NSMenu; cdecl;
    {class} function prefersTrackingUntilMouseUp: Boolean; cdecl;
  end;
  NSCell = interface(NSObject)
    ['{C3F95C6E-92BB-46E9-BEE3-0731D9297606}']
    function acceptsFirstResponder: Boolean; cdecl;
    function action: SEL; cdecl;
    function alignment: NSTextAlignment; cdecl;
    function allowsEditingTextAttributes: Boolean; cdecl;
    function allowsMixedState: Boolean; cdecl;
    function allowsUndo: Boolean; cdecl;
    function attributedStringValue: NSAttributedString; cdecl;
    function backgroundStyle: NSBackgroundStyle; cdecl;
    function baseWritingDirection: NSWritingDirection; cdecl;
    procedure calcDrawInfo(aRect: NSRect); cdecl;
    function cellAttribute(aParameter: NSCellAttribute): NSInteger; cdecl;
    function cellSize: NSSize; cdecl;
    function cellSizeForBounds(aRect: NSRect): NSSize; cdecl;
    function compare(otherCell: Pointer): NSComparisonResult; cdecl;
    function continueTracking(lastPoint: NSPoint; at: NSPoint; inView: NSView): Boolean; cdecl;
    function controlSize: NSControlSize; cdecl;
    function controlTint: NSControlTint; cdecl;
    function controlView: NSView; cdecl;
    function doubleValue: double; cdecl;
    procedure drawInteriorWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawWithExpansionFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    function drawingRectForBounds(theRect: NSRect): NSRect; cdecl;
    procedure editWithFrame(aRect: NSRect; inView: NSView; editor: NSText; delegate: Pointer; event: NSEvent); cdecl;
    procedure endEditing(textObj: NSText); cdecl;
    function entryType: NSInteger; cdecl;
    function expansionFrameWithFrame(cellFrame: NSRect; inView: NSView): NSRect; cdecl;
    function fieldEditorForView(aControlView: NSView): NSTextView; cdecl;
    function floatValue: Single; cdecl;
    function focusRingType: NSFocusRingType; cdecl;
    function font: NSFont; cdecl;
    function formatter: Pointer; cdecl;
    procedure getPeriodicDelay(delay: PSingle; interval: PSingle); cdecl;
    function hasValidObjectValue: Boolean; cdecl;
    procedure highlight(flag: Boolean; withFrame: NSRect; inView: NSView); cdecl;
    function highlightColorWithFrame(cellFrame: NSRect; inView: NSView): NSColor; cdecl;
    function hitTestForEvent(event: NSEvent; inRect: NSRect; ofView: NSView): NSUInteger; cdecl;
    function image: NSImage; cdecl;
    function imageRectForBounds(theRect: NSRect): NSRect; cdecl;
    function importsGraphics: Boolean; cdecl;
    function initImageCell(image: NSImage): Pointer; cdecl;
    function initTextCell(aString: NSString): Pointer; cdecl;
    function intValue: Integer; cdecl;
    function integerValue: NSInteger; cdecl;
    function interiorBackgroundStyle: NSBackgroundStyle; cdecl;
    function isBezeled: Boolean; cdecl;
    function isBordered: Boolean; cdecl;
    function isContinuous: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    function isEntryAcceptable(aString: NSString): Boolean; cdecl;
    function isHighlighted: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isScrollable: Boolean; cdecl;
    function isSelectable: Boolean; cdecl;
    function keyEquivalent: NSString; cdecl;
    function lineBreakMode: NSLineBreakMode; cdecl;
    function menu: NSMenu; cdecl;
    function menuForEvent(event: NSEvent; inRect: NSRect; ofView: NSView): NSMenu; cdecl;
    function mnemonic: NSString; cdecl;
    function mnemonicLocation: NSUInteger; cdecl;
    function mouseDownFlags: NSInteger; cdecl;
    function nextState: NSInteger; cdecl;
    function objectValue: Pointer; cdecl;
    procedure performClick(sender: Pointer); cdecl;
    function refusesFirstResponder: Boolean; cdecl;
    function representedObject: Pointer; cdecl;
    procedure resetCursorRect(cellFrame: NSRect; inView: NSView); cdecl;
    procedure selectWithFrame(aRect: NSRect; inView: NSView; editor: NSText; delegate: Pointer; start: NSInteger; length: NSInteger); cdecl;
    function sendActionOn(mask: NSInteger): NSInteger; cdecl;
    function sendsActionOnEndEditing: Boolean; cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setAlignment(mode: NSTextAlignment); cdecl;
    procedure setAllowsEditingTextAttributes(flag: Boolean); cdecl;
    procedure setAllowsMixedState(flag: Boolean); cdecl;
    procedure setAllowsUndo(allowsUndo: Boolean); cdecl;
    procedure setAttributedStringValue(obj: NSAttributedString); cdecl;
    procedure setBackgroundStyle(style: NSBackgroundStyle); cdecl;
    procedure setBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setBezeled(flag: Boolean); cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setContinuous(flag: Boolean); cdecl;
    procedure setControlSize(size: NSControlSize); cdecl;
    procedure setControlTint(controlTint: NSControlTint); cdecl;
    procedure setControlView(view: NSView); cdecl;
    procedure setDoubleValue(aDouble: double); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setEnabled(flag: Boolean); cdecl;
    procedure setEntryType(aType: NSInteger); cdecl;
    procedure setFloatValue(aFloat: Single); cdecl;
    procedure setFloatingPointFormat(autoRange: Boolean; left: NSUInteger; right: NSUInteger); cdecl;
    procedure setFocusRingType(focusRingType: NSFocusRingType); cdecl;
    procedure setFont(fontObj: NSFont); cdecl;
    procedure setFormatter(newFormatter: NSFormatter); cdecl;
    procedure setHighlighted(flag: Boolean); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setImportsGraphics(flag: Boolean); cdecl;
    procedure setIntValue(anInt: Integer); cdecl;
    procedure setIntegerValue(anInteger: NSInteger); cdecl;
    procedure setLineBreakMode(mode: NSLineBreakMode); cdecl;
    procedure setMenu(aMenu: NSMenu); cdecl;
    procedure setMnemonicLocation(location: NSUInteger); cdecl;
    procedure setNextState; cdecl;
    procedure setObjectValue(obj: NSCopying); cdecl;
    procedure setRefusesFirstResponder(flag: Boolean); cdecl;
    procedure setRepresentedObject(anObject: Pointer); cdecl;
    procedure setScrollable(flag: Boolean); cdecl;
    procedure setSelectable(flag: Boolean); cdecl;
    procedure setSendsActionOnEndEditing(flag: Boolean); cdecl;
    procedure setShowsFirstResponder(showFR: Boolean); cdecl;
    procedure setState(value: NSInteger); cdecl;
    procedure setStringValue(aString: NSString); cdecl;
    procedure setTag(anInt: NSInteger); cdecl;
    procedure setTarget(anObject: Pointer); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setTruncatesLastVisibleLine(flag: Boolean); cdecl;
    procedure setType(aType: NSCellType); cdecl;
    function setUpFieldEditorAttributes(textObj: NSText): NSText; cdecl;
    procedure setUserInterfaceLayoutDirection(layoutDirection: NSUserInterfaceLayoutDirection); cdecl;
    procedure setUsesSingleLineMode(flag: Boolean); cdecl;
    procedure setWraps(flag: Boolean); cdecl;
    function showsFirstResponder: Boolean; cdecl;
    function startTrackingAt(startPoint: NSPoint; inView: NSView): Boolean; cdecl;
    function state: NSInteger; cdecl;
    procedure stopTracking(lastPoint: NSPoint; at: NSPoint; inView: NSView; mouseIsUp: Boolean); cdecl;
    function stringValue: NSString; cdecl;
    function tag: NSInteger; cdecl;
    procedure takeDoubleValueFrom(sender: Pointer); cdecl;
    procedure takeFloatValueFrom(sender: Pointer); cdecl;
    procedure takeIntValueFrom(sender: Pointer); cdecl;
    procedure takeIntegerValueFrom(sender: Pointer); cdecl;
    procedure takeObjectValueFrom(sender: Pointer); cdecl;
    procedure takeStringValueFrom(sender: Pointer); cdecl;
    function target: Pointer; cdecl;
    function title: NSString; cdecl;
    function titleRectForBounds(theRect: NSRect): NSRect; cdecl;
    function trackMouse(theEvent: NSEvent; inRect: NSRect; ofView: NSView; untilMouseUp: Boolean): Boolean; cdecl;
    function truncatesLastVisibleLine: Boolean; cdecl;
    function userInterfaceLayoutDirection: NSUserInterfaceLayoutDirection; cdecl;
    function usesSingleLineMode: Boolean; cdecl;
    function wantsNotificationForMarkedText: Boolean; cdecl;
    function wraps: Boolean; cdecl;
  end;
  TNSCell = class(TOCGenericImport<NSCellClass, NSCell>)  end;

  NSWorkspaceClass = interface(NSObjectClass)
    ['{860887F0-539A-428F-A20A-47C4935C9574}']
    {class} function sharedWorkspace: Pointer; cdecl;
  end;
  NSWorkspace = interface(NSObject)
    ['{C29CBFC3-2AD2-4796-B9C4-907E4E0D4967}']
    function URLForApplicationToOpenURL(url: NSURL): NSURL; cdecl;
    function URLForApplicationWithBundleIdentifier(bundleIdentifier: NSString): NSURL; cdecl;
    function absolutePathForAppBundleWithIdentifier(bundleIdentifier: NSString): NSString; cdecl;
    procedure activateFileViewerSelectingURLs(fileURLs: NSArray); cdecl;
    function activeApplication: NSDictionary; cdecl;
    procedure checkForRemovableMedia; cdecl;
    function desktopImageOptionsForScreen(screen: NSScreen): NSDictionary; cdecl;
    function desktopImageURLForScreen(screen: NSScreen): NSURL; cdecl;
    function extendPowerOffBy(requested: NSInteger): NSInteger; cdecl;
    function fileLabelColors: NSArray; cdecl;
    function fileLabels: NSArray; cdecl;
    function fileSystemChanged: Boolean; cdecl;
    function filenameExtension(filenameExtension: NSString; isValidForType: NSString): Boolean; cdecl;
    procedure findApplications; cdecl;
    function fullPathForApplication(appName: NSString): NSString; cdecl;
    procedure hideOtherApplications; cdecl;
    function iconForFile(fullPath: NSString): NSImage; cdecl;
    function iconForFileType(fileType: NSString): NSImage; cdecl;
    function iconForFiles(fullPaths: NSArray): NSImage; cdecl;
    function isFilePackageAtPath(fullPath: NSString): Boolean; cdecl;
    function launchAppWithBundleIdentifier(bundleIdentifier: NSString; options: NSWorkspaceLaunchOptions; additionalEventParamDescriptor: NSAppleEventDescriptor; launchIdentifier: NSNumber): Boolean; cdecl;
    function launchApplication(appName: NSString): Boolean; cdecl; overload;
    function launchApplication(appName: NSString; showIcon: Boolean; autolaunch: Boolean): Boolean; cdecl; overload;
    function launchApplicationAtURL(url: NSURL; options: NSWorkspaceLaunchOptions; configuration: NSDictionary; error: PPointer): NSRunningApplication; cdecl;
    function launchedApplications: NSArray; cdecl;
    function localizedDescriptionForType(typeName: NSString): NSString; cdecl;
    function mountNewRemovableMedia: NSArray; cdecl;
    function mountedLocalVolumePaths: NSArray; cdecl;
    function mountedRemovableMedia: NSArray; cdecl;
    procedure noteFileSystemChanged; cdecl; overload;
    procedure noteFileSystemChanged(path: NSString); cdecl; overload;
    procedure noteUserDefaultsChanged; cdecl;
    function notificationCenter: NSNotificationCenter; cdecl;
    function openFile(fullPath: NSString): Boolean; cdecl; overload;
    function openFile(fullPath: NSString; fromImage: NSImage; at: NSPoint; inView: NSView): Boolean; cdecl; overload;
    function openFile(fullPath: NSString; withApplication: NSString): Boolean; cdecl; overload;
    function openFile(fullPath: NSString; withApplication: NSString; andDeactivate: Boolean): Boolean; cdecl; overload;
    function openTempFile(fullPath: NSString): Boolean; cdecl;
    function openURL(url: NSURL): Boolean; cdecl;
    function openURLs(urls: NSArray; withAppBundleIdentifier: NSString; options: NSWorkspaceLaunchOptions; additionalEventParamDescriptor: NSAppleEventDescriptor; launchIdentifiers: NSArray): Boolean; cdecl;
    function performFileOperation(operation: NSString; source: NSString; destination: NSString; files: NSArray; tag: NSInteger): Boolean; cdecl;
    function preferredFilenameExtensionForType(typeName: NSString): NSString; cdecl;
    function runningApplications: NSArray; cdecl;
    function selectFile(fullPath: NSString; inFileViewerRootedAtPath: NSString): Boolean; cdecl;
    function setDesktopImageURL(url: NSURL; forScreen: NSScreen; options: NSDictionary; error: PPointer): Boolean; cdecl;
    function setIcon(image: NSImage; forFile: NSString; options: NSWorkspaceIconCreationOptions): Boolean; cdecl;
    function showSearchResultsForQueryString(queryString: NSString): Boolean; cdecl;
    function typeOfFile(absoluteFilePath: NSString; error: PPointer): NSString; cdecl;
    function unmountAndEjectDeviceAtPath(path: NSString): Boolean; cdecl;
    function unmountAndEjectDeviceAtURL(url: NSURL; error: PPointer): Boolean; cdecl;
    function userDefaultsChanged: Boolean; cdecl;
  end;
  TNSWorkspace = class(TOCGenericImport<NSWorkspaceClass, NSWorkspace>)  end;

  NSColorSpaceClass = interface(NSObjectClass)
    ['{20ADB9C3-13AC-4862-A0A5-6EC9325254E5}']
    {class} function adobeRGB1998ColorSpace: Pointer; cdecl;
    {class} function availableColorSpacesWithModel(model: NSColorSpaceModel): NSArray; cdecl;
    {class} function deviceCMYKColorSpace: Pointer; cdecl;
    {class} function deviceGrayColorSpace: Pointer; cdecl;
    {class} function deviceRGBColorSpace: Pointer; cdecl;
    {class} function genericCMYKColorSpace: Pointer; cdecl;
    {class} function genericGamma22GrayColorSpace: Pointer; cdecl;
    {class} function genericGrayColorSpace: Pointer; cdecl;
    {class} function genericRGBColorSpace: Pointer; cdecl;
    {class} function sRGBColorSpace: Pointer; cdecl;
  end;
  NSColorSpace = interface(NSObject)
    ['{947362D2-2843-45FA-8C05-D72ACC59B6BF}']
    function CGColorSpace: CGColorSpaceRef; cdecl;
    function ICCProfileData: NSData; cdecl;
    function colorSpaceModel: NSColorSpaceModel; cdecl;
    function colorSyncProfile: Pointer; cdecl;
    function initWithCGColorSpace(cgColorSpace: CGColorSpaceRef): Pointer; cdecl;
    function initWithColorSyncProfile(prof: Pointer): Pointer; cdecl;
    function initWithICCProfileData(iccData: NSData): Pointer; cdecl;
    function localizedName: NSString; cdecl;
    function numberOfColorComponents: NSInteger; cdecl;
  end;
  TNSColorSpace = class(TOCGenericImport<NSColorSpaceClass, NSColorSpace>)  end;

  NSTouchClass = interface(NSObjectClass)
    ['{BBE72D59-2A55-4793-97A5-22940B174A84}']
  end;
  NSTouch = interface(NSObject)
    ['{F7A4556D-FD31-438A-B744-1441FB6AC9AB}']
    function device: Pointer; cdecl;
    function deviceSize: NSSize; cdecl;
    function isResting: Boolean; cdecl;
    function normalizedPosition: NSPoint; cdecl;
    function phase: NSTouchPhase; cdecl;
  end;
  TNSTouch = class(TOCGenericImport<NSTouchClass, NSTouch>)  end;

  NSControllerClass = interface(NSObjectClass)
    ['{8E4D8559-9E04-4902-BC98-4096CBE293D3}']
  end;
  NSController = interface(NSObject)
    ['{A6CB8992-942D-44F0-B08C-7061625EE65B}']
    function commitEditing: Boolean; cdecl;
    procedure commitEditingWithDelegate(delegate: Pointer; didCommitSelector: SEL; contextInfo: Pointer); cdecl;
    procedure discardEditing; cdecl;
    function isEditing: Boolean; cdecl;
    procedure objectDidBeginEditing(editor: Pointer); cdecl;
    procedure objectDidEndEditing(editor: Pointer); cdecl;
  end;
  TNSController = class(TOCGenericImport<NSControllerClass, NSController>)  end;

  NSTrackingAreaClass = interface(NSObjectClass)
    ['{85490771-22D4-4B57-A7A2-4D382A7FDFA8}']
  end;
  NSTrackingArea = interface(NSObject)
    ['{69D782B1-1E59-45DC-9810-C35BF9786AF5}']
    function initWithRect(rect: NSRect; options: NSTrackingAreaOptions; owner: Pointer; userInfo: NSDictionary): Pointer; cdecl;
    function options: NSTrackingAreaOptions; cdecl;
    function owner: Pointer; cdecl;
    function rect: NSRect; cdecl;
    function userInfo: NSDictionary; cdecl;
  end;
  TNSTrackingArea = class(TOCGenericImport<NSTrackingAreaClass, NSTrackingArea>)  end;
 
  NSColorClass = interface(NSObjectClass)
    ['{8633BB87-6911-4601-B185-440FEF312FB5}']
    {class} function alternateSelectedControlColor: Pointer; cdecl;
    {class} function alternateSelectedControlTextColor: Pointer; cdecl;
    {class} function blackColor: Pointer; cdecl;
    {class} function blueColor: Pointer; cdecl;
    {class} function brownColor: Pointer; cdecl;
    {class} function clearColor: Pointer; cdecl;
    {class} function colorForControlTint(controlTint: NSControlTint): Pointer; cdecl;
    {class} function colorFromPasteboard(pasteBoard: NSPasteboard): Pointer; cdecl;
    {class} function colorWithCIColor(color: CIColor): Pointer; cdecl;
    {class} function colorWithCalibratedHue(hue: Single; saturation: Single; brightness: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithCalibratedRed(red: Single; green: Single; blue: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithCalibratedWhite(white: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithCatalogName(listName: NSString; colorName: NSString): Pointer; cdecl;
    {class} function colorWithColorSpace(space: NSColorSpace; components: PSingle; count: NSInteger): Pointer; cdecl;
    {class} function colorWithDeviceCyan(cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithDeviceHue(hue: Single; saturation: Single; brightness: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithDeviceRed(red: Single; green: Single; blue: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithDeviceWhite(white: Single; alpha: Single): Pointer; cdecl;
    {class} function colorWithPatternImage(image: NSImage): Pointer; cdecl;
    {class} function controlAlternatingRowBackgroundColors: NSArray; cdecl;
    {class} function controlBackgroundColor: Pointer; cdecl;
    {class} function controlColor: Pointer; cdecl;
    {class} function controlDarkShadowColor: Pointer; cdecl;
    {class} function controlHighlightColor: Pointer; cdecl;
    {class} function controlLightHighlightColor: Pointer; cdecl;
    {class} function controlShadowColor: Pointer; cdecl;
    {class} function controlTextColor: Pointer; cdecl;
    {class} function currentControlTint: NSControlTint; cdecl;
    {class} function cyanColor: Pointer; cdecl;
    {class} function darkGrayColor: Pointer; cdecl;
    {class} function disabledControlTextColor: Pointer; cdecl;
    {class} function grayColor: Pointer; cdecl;
    {class} function greenColor: Pointer; cdecl;
    {class} function gridColor: Pointer; cdecl;
    {class} function headerColor: Pointer; cdecl;
    {class} function headerTextColor: Pointer; cdecl;
    {class} function highlightColor: Pointer; cdecl;
    {class} function ignoresAlpha: Boolean; cdecl;
    {class} function keyboardFocusIndicatorColor: Pointer; cdecl;
    {class} function knobColor: Pointer; cdecl;
    {class} function lightGrayColor: Pointer; cdecl;
    {class} function magentaColor: Pointer; cdecl;
    {class} function orangeColor: Pointer; cdecl;
    {class} function purpleColor: Pointer; cdecl;
    {class} function redColor: Pointer; cdecl;
    {class} function scrollBarColor: Pointer; cdecl;
    {class} function secondarySelectedControlColor: Pointer; cdecl;
    {class} function selectedControlColor: Pointer; cdecl;
    {class} function selectedControlTextColor: Pointer; cdecl;
    {class} function selectedKnobColor: Pointer; cdecl;
    {class} function selectedMenuItemColor: Pointer; cdecl;
    {class} function selectedMenuItemTextColor: Pointer; cdecl;
    {class} function selectedTextBackgroundColor: Pointer; cdecl;
    {class} function selectedTextColor: Pointer; cdecl;
    {class} procedure setIgnoresAlpha(flag: Boolean); cdecl;
    {class} function shadowColor: Pointer; cdecl;
    {class} function textBackgroundColor: Pointer; cdecl;
    {class} function textColor: Pointer; cdecl;
    {class} function whiteColor: Pointer; cdecl;
    {class} function windowBackgroundColor: Pointer; cdecl;
    {class} function windowFrameColor: Pointer; cdecl;
    {class} function windowFrameTextColor: Pointer; cdecl;
    {class} function yellowColor: Pointer; cdecl;
  end;
  NSColor = interface(NSObject)
    ['{6C3EC909-91C8-44A2-86D8-A774DB5FF565}']
    function alphaComponent: Single; cdecl;
    function blackComponent: Single; cdecl;
    function blendedColorWithFraction(fraction: Single; ofColor: NSColor): NSColor; cdecl;
    function blueComponent: Single; cdecl;
    function brightnessComponent: Single; cdecl;
    function catalogNameComponent: NSString; cdecl;
    function colorNameComponent: NSString; cdecl;
    function colorSpace: NSColorSpace; cdecl;
    function colorSpaceName: NSString; cdecl;
    function colorUsingColorSpace(space: NSColorSpace): NSColor; cdecl;
    function colorUsingColorSpaceName(colorSpace: NSString): NSColor; cdecl; overload;
    function colorUsingColorSpaceName(colorSpace: NSString; device: NSDictionary): NSColor; cdecl; overload;
    function colorWithAlphaComponent(alpha: Single): NSColor; cdecl;
    function cyanComponent: Single; cdecl;
    procedure drawSwatchInRect(rect: NSRect); cdecl;
    procedure getComponents(components: PSingle); cdecl;
    procedure getCyan(cyan: PSingle; magenta: PSingle; yellow: PSingle; black: PSingle; alpha: PSingle); cdecl;
    procedure getHue(hue: PSingle; saturation: PSingle; brightness: PSingle; alpha: PSingle); cdecl;
    procedure getRed(red: PSingle; green: PSingle; blue: PSingle; alpha: PSingle); cdecl;
    procedure getWhite(white: PSingle; alpha: PSingle); cdecl;
    function greenComponent: Single; cdecl;
    function highlightWithLevel(val: Single): NSColor; cdecl;
    function hueComponent: Single; cdecl;
    function localizedCatalogNameComponent: NSString; cdecl;
    function localizedColorNameComponent: NSString; cdecl;
    function magentaComponent: Single; cdecl;
    function numberOfComponents: NSInteger; cdecl;
    function patternImage: NSImage; cdecl;
    function redComponent: Single; cdecl;
    function saturationComponent: Single; cdecl;
    procedure setFill; cdecl;
    procedure setStroke; cdecl;
    function shadowWithLevel(val: Single): NSColor; cdecl;
    function whiteComponent: Single; cdecl;
    procedure writeToPasteboard(pasteBoard: NSPasteboard); cdecl;
    function yellowComponent: Single; cdecl;
  end;
  TNSColor = class(TOCGenericImport<NSColorClass, NSColor>)  end;

  NSColorListClass = interface(NSObjectClass)
    ['{66023349-E32C-4582-A956-AE6317705E95}']
    {class} function availableColorLists: NSArray; cdecl;
    {class} function colorListNamed(name: NSString): Pointer; cdecl;
  end;
  NSColorList = interface(NSObject)
    ['{6751773E-3995-4EED-A70C-C2E4B34DD91A}']
    function allKeys: NSArray; cdecl;
    function colorWithKey(key: NSString): NSColor; cdecl;
    function initWithName(name: NSString): Pointer; cdecl; overload;
    function initWithName(name: NSString; fromFile: NSString): Pointer; cdecl; overload;
    procedure insertColor(color: NSColor; key: NSString; atIndex: NSUInteger); cdecl;
    function isEditable: Boolean; cdecl;
    function name: NSString; cdecl;
    procedure removeColorWithKey(key: NSString); cdecl;
    procedure removeFile; cdecl;
    procedure setColor(color: NSColor; forKey: NSString); cdecl;
    function writeToFile(path: NSString): Boolean; cdecl;
  end;
  TNSColorList = class(TOCGenericImport<NSColorListClass, NSColorList>)  end;

  NSTypesetterClass = interface(NSObjectClass)
    ['{5F4BF6A2-F0F2-47DD-8F21-73ECD2178474}']
    {class} function defaultTypesetterBehavior: NSTypesetterBehavior; cdecl;
    {class} function printingAdjustmentInLayoutManager(layoutMgr: NSLayoutManager; forNominallySpacedGlyphRange: NSRange; packedGlyphs: PByte; count: NSUInteger): NSSize; cdecl;
    {class} function sharedSystemTypesetter: Pointer; cdecl;
    {class} function sharedSystemTypesetterForBehavior(theBehavior: NSTypesetterBehavior): Pointer; cdecl;
  end;
  NSTypesetter = interface(NSObject)
    ['{7359C3CD-616F-4F68-8122-6F8ACC147D13}']
    function actionForControlCharacterAtIndex(charIndex: NSUInteger): NSTypesetterControlCharacterAction; cdecl;
    function attributedString: NSAttributedString; cdecl;
    function attributesForExtraLineFragment: NSDictionary; cdecl;
    function baselineOffsetInLayoutManager(layoutMgr: NSLayoutManager; glyphIndex: NSUInteger): Single; cdecl;
    procedure beginLineWithGlyphAtIndex(glyphIndex: NSUInteger); cdecl;
    procedure beginParagraph; cdecl;
    function bidiProcessingEnabled: Boolean; cdecl;
    function boundingBoxForControlGlyphAtIndex(glyphIndex: NSUInteger; forTextContainer: NSTextContainer; proposedLineFragment: NSRect; glyphPosition: NSPoint; characterIndex: NSUInteger): NSRect; cdecl;
    function characterRangeForGlyphRange(glyphRange: NSRange; actualGlyphRange: PNSRange): NSRange; cdecl;
    function currentParagraphStyle: NSParagraphStyle; cdecl;
    function currentTextContainer: NSTextContainer; cdecl;
    procedure deleteGlyphsInRange(glyphRange: NSRange); cdecl;
    procedure endLineWithGlyphRange(lineGlyphRange: NSRange); cdecl;
    procedure endParagraph; cdecl;
    function getGlyphsInRange(glyphsRange: NSRange; glyphs: PNSGlyph; characterIndexes: NSUInteger; glyphInscriptions: PNSGlyphInscription; elasticBits: PBoolean; bidiLevels: PByte): NSUInteger; cdecl;
    procedure getLineFragmentRect(lineFragmentRect: NSRectPointer; usedRect: NSRectPointer; forParagraphSeparatorGlyphRange: NSRange; atProposedOrigin: NSPoint); cdecl; overload;
    procedure getLineFragmentRect(lineFragmentRect: NSRectPointer; usedRect: NSRectPointer; remainingRect: NSRectPointer; forStartingGlyphAtIndex: NSUInteger; proposedRect: NSRect; lineSpacing: Single; paragraphSpacingBefore: Single; paragraphSpacingAfter: Single); cdecl; overload;
    function glyphRangeForCharacterRange(charRange: NSRange; actualCharacterRange: PNSRange): NSRange; cdecl;
    function hyphenCharacterForGlyphAtIndex(glyphIndex: NSUInteger): UTF32Char; cdecl;
    function hyphenationFactor: Single; cdecl;
    function hyphenationFactorForGlyphAtIndex(glyphIndex: NSUInteger): Single; cdecl;
    procedure insertGlyph(glyph: NSGlyph; atGlyphIndex: NSUInteger; characterIndex: NSUInteger); cdecl;
    function layoutCharactersInRange(characterRange: NSRange; forLayoutManager: NSLayoutManager; maximumNumberOfLineFragments: NSUInteger): NSRange; cdecl;
    procedure layoutGlyphsInLayoutManager(layoutManager: NSLayoutManager; startingAtGlyphIndex: NSUInteger; maxNumberOfLineFragments: NSUInteger; nextGlyphIndex: NSUInteger); cdecl;
    function layoutManager: NSLayoutManager; cdecl;
    function layoutParagraphAtPoint(lineFragmentOrigin: NSPointPointer): NSUInteger; cdecl;
    function lineFragmentPadding: Single; cdecl;
    function lineSpacingAfterGlyphAtIndex(glyphIndex: NSUInteger; withProposedLineFragmentRect: NSRect): Single; cdecl;
    function paragraphCharacterRange: NSRange; cdecl;
    function paragraphGlyphRange: NSRange; cdecl;
    function paragraphSeparatorCharacterRange: NSRange; cdecl;
    function paragraphSeparatorGlyphRange: NSRange; cdecl;
    function paragraphSpacingAfterGlyphAtIndex(glyphIndex: NSUInteger; withProposedLineFragmentRect: NSRect): Single; cdecl;
    function paragraphSpacingBeforeGlyphAtIndex(glyphIndex: NSUInteger; withProposedLineFragmentRect: NSRect): Single; cdecl;
    procedure setAttachmentSize(attachmentSize: NSSize; forGlyphRange: NSRange); cdecl;
    procedure setAttributedString(attrString: NSAttributedString); cdecl;
    procedure setBidiLevels(levels: PByte; forGlyphRange: NSRange); cdecl;
    procedure setBidiProcessingEnabled(flag: Boolean); cdecl;
    procedure setDrawsOutsideLineFragment(flag: Boolean; forGlyphRange: NSRange); cdecl;
    procedure setHardInvalidation(flag: Boolean; forGlyphRange: NSRange); cdecl;
    procedure setHyphenationFactor(factor: Single); cdecl;
    procedure setLineFragmentPadding(padding: Single); cdecl;
    procedure setLineFragmentRect(fragmentRect: NSRect; forGlyphRange: NSRange; usedRect: NSRect; baselineOffset: Single); cdecl;
    procedure setLocation(location: NSPoint; withAdvancements: PSingle; forStartOfGlyphRange: NSRange); cdecl;
    procedure setNotShownAttribute(flag: Boolean; forGlyphRange: NSRange); cdecl;
    procedure setParagraphGlyphRange(paragraphRange: NSRange; separatorGlyphRange: NSRange); cdecl;
    procedure setTypesetterBehavior(behavior: NSTypesetterBehavior); cdecl;
    procedure setUsesFontLeading(flag: Boolean); cdecl;
    function shouldBreakLineByHyphenatingBeforeCharacterAtIndex(charIndex: NSUInteger): Boolean; cdecl;
    function shouldBreakLineByWordBeforeCharacterAtIndex(charIndex: NSUInteger): Boolean; cdecl;
    function substituteFontForFont(originalFont: NSFont): NSFont; cdecl;
    procedure substituteGlyphsInRange(glyphRange: NSRange; withGlyphs: PNSGlyph); cdecl;
    function textContainers: NSArray; cdecl;
    function textTabForGlyphLocation(glyphLocation: Single; writingDirection: NSWritingDirection; maxLocation: Single): NSTextTab; cdecl;
    function typesetterBehavior: NSTypesetterBehavior; cdecl;
    function usesFontLeading: Boolean; cdecl;
    procedure willSetLineFragmentRect(lineRect: NSRectPointer; forGlyphRange: NSRange; usedRect: NSRectPointer; baselineOffset: PSingle); cdecl;
  end;
  TNSTypesetter = class(TOCGenericImport<NSTypesetterClass, NSTypesetter>)  end;

  NSColorPickerClass = interface(NSObjectClass)
    ['{A49BC371-4FA4-4F78-9B20-5BDE2AC97E3A}']
  end;
  NSColorPicker = interface(NSObject)
    ['{6EB6E650-E107-40DC-A05C-6A49A25FA070}']
    procedure attachColorList(colorList: NSColorList); cdecl;
    function buttonToolTip: NSString; cdecl;
    function colorPanel: NSColorPanel; cdecl;
    procedure detachColorList(colorList: NSColorList); cdecl;
    function initWithPickerMask(mask: NSUInteger; colorPanel: NSColorPanel): Pointer; cdecl;
    function minContentSize: NSSize; cdecl;
    function provideNewButtonImage: NSImage; cdecl;
    procedure setMode(mode: NSColorPanelMode); cdecl;
    procedure viewSizeChanged(sender: Pointer); cdecl;
  end;
  TNSColorPicker = class(TOCGenericImport<NSColorPickerClass, NSColorPicker>)  end;

  NSBezierPathClass = interface(NSObjectClass)
    ['{2C08E4CD-274A-42FC-8E80-95ED00C761A2}']
    {class} function bezierPath: Pointer; cdecl;
    {class} function bezierPathWithOvalInRect(rect: NSRect): Pointer; cdecl;
    {class} function bezierPathWithRect(rect: NSRect): Pointer; cdecl;
    {class} function bezierPathWithRoundedRect(rect: NSRect; xRadius: Single; yRadius: Single): Pointer; cdecl;
    {class} procedure clipRect(rect: NSRect); cdecl;
    {class} function defaultFlatness: Single; cdecl;
    {class} function defaultLineCapStyle: NSLineCapStyle; cdecl;
    {class} function defaultLineJoinStyle: NSLineJoinStyle; cdecl;
    {class} function defaultLineWidth: Single; cdecl;
    {class} function defaultMiterLimit: Single; cdecl;
    {class} function defaultWindingRule: NSWindingRule; cdecl;
    {class} procedure drawPackedGlyphs(packedGlyphs: MarshaledAString; atPoint: NSPoint); cdecl;
    {class} procedure fillRect(rect: NSRect); cdecl;
    {class} procedure setDefaultFlatness(flatness: Single); cdecl;
    {class} procedure setDefaultLineCapStyle(lineCapStyle: NSLineCapStyle); cdecl;
    {class} procedure setDefaultLineJoinStyle(lineJoinStyle: NSLineJoinStyle); cdecl;
    {class} procedure setDefaultLineWidth(lineWidth: Single); cdecl;
    {class} procedure setDefaultMiterLimit(limit: Single); cdecl;
    {class} procedure setDefaultWindingRule(windingRule: NSWindingRule); cdecl;
    {class} procedure strokeLineFromPoint(point1: NSPoint; toPoint: NSPoint); cdecl;
    {class} procedure strokeRect(rect: NSRect); cdecl;
  end;
  NSBezierPath = interface(NSObject)
    ['{CA5AEE95-DED0-4BAA-A527-2AF7F60BDBC6}']
    procedure addClip; cdecl;
    procedure appendBezierPath(path: NSBezierPath); cdecl;
    procedure appendBezierPathWithArcFromPoint(point1: NSPoint; toPoint: NSPoint; radius: Single); cdecl;
    procedure appendBezierPathWithArcWithCenter(center: NSPoint; radius: Single; startAngle: Single; endAngle: Single); cdecl; overload;
    procedure appendBezierPathWithArcWithCenter(center: NSPoint; radius: Single; startAngle: Single; endAngle: Single; clockwise: Boolean); cdecl; overload;
    procedure appendBezierPathWithGlyph(glyph: NSGlyph; inFont: NSFont); cdecl;
    procedure appendBezierPathWithGlyphs(glyphs: PNSGlyph; count: NSInteger; inFont: NSFont); cdecl;
    procedure appendBezierPathWithOvalInRect(rect: NSRect); cdecl;
    procedure appendBezierPathWithPackedGlyphs(packedGlyphs: MarshaledAString); cdecl;
    procedure appendBezierPathWithPoints(points: NSPointArray; count: NSInteger); cdecl;
    procedure appendBezierPathWithRect(rect: NSRect); cdecl;
    procedure appendBezierPathWithRoundedRect(rect: NSRect; xRadius: Single; yRadius: Single); cdecl;
    function bezierPathByFlatteningPath: NSBezierPath; cdecl;
    function bezierPathByReversingPath: NSBezierPath; cdecl;
    function bounds: NSRect; cdecl;
    function cachesBezierPath: Boolean; cdecl;
    procedure closePath; cdecl;
    function containsPoint(point: NSPoint): Boolean; cdecl;
    function controlPointBounds: NSRect; cdecl;
    function currentPoint: NSPoint; cdecl;
    procedure curveToPoint(endPoint: NSPoint; controlPoint1: NSPoint; controlPoint2: NSPoint); cdecl;
    function elementAtIndex(index: NSInteger): NSBezierPathElement; cdecl; overload;
    function elementAtIndex(index: NSInteger; associatedPoints: NSPointArray): NSBezierPathElement; cdecl; overload;
    function elementCount: NSInteger; cdecl;
    procedure fill; cdecl;
    function flatness: Single; cdecl;
    procedure getLineDash(pattern: PSingle; count: NSInteger; phase: PSingle); cdecl;
    function isEmpty: Boolean; cdecl;
    function lineCapStyle: NSLineCapStyle; cdecl;
    function lineJoinStyle: NSLineJoinStyle; cdecl;
    procedure lineToPoint(point: NSPoint); cdecl;
    function lineWidth: Single; cdecl;
    function miterLimit: Single; cdecl;
    procedure moveToPoint(point: NSPoint); cdecl;
    procedure relativeCurveToPoint(endPoint: NSPoint; controlPoint1: NSPoint; controlPoint2: NSPoint); cdecl;
    procedure relativeLineToPoint(point: NSPoint); cdecl;
    procedure relativeMoveToPoint(point: NSPoint); cdecl;
    procedure removeAllPoints; cdecl;
    procedure setAssociatedPoints(points: NSPointArray; atIndex: NSInteger); cdecl;
    procedure setCachesBezierPath(flag: Boolean); cdecl;
    procedure setClip; cdecl;
    procedure setFlatness(flatness: Single); cdecl;
    procedure setLineCapStyle(lineCapStyle: NSLineCapStyle); cdecl;
    procedure setLineDash(pattern: PSingle; count: NSInteger; phase: Single); cdecl;
    procedure setLineJoinStyle(lineJoinStyle: NSLineJoinStyle); cdecl;
    procedure setLineWidth(lineWidth: Single); cdecl;
    procedure setMiterLimit(miterLimit: Single); cdecl;
    procedure setWindingRule(windingRule: NSWindingRule); cdecl;
    procedure stroke; cdecl;
    procedure transformUsingAffineTransform(transform: NSAffineTransform); cdecl;
    function windingRule: NSWindingRule; cdecl;
  end;
  TNSBezierPath = class(TOCGenericImport<NSBezierPathClass, NSBezierPath>)  end;

  NSEventClass = interface(NSObjectClass)
    ['{BA7F9E43-1B68-4300-ACE9-D20194EBE754}']
    {class} function doubleClickInterval: NSTimeInterval; cdecl;
    {class} function enterExitEventWithType(type_: NSEventType; location: NSPoint; modifierFlags: NSUInteger; timestamp: NSTimeInterval; windowNumber: NSInteger; context: NSGraphicsContext; eventNumber: NSInteger; trackingNumber: NSInteger; userData: Pointer): Pointer; cdecl;
    {class} function eventWithCGEvent(cgEvent: CGEventRef): Pointer; cdecl;
    {class} function eventWithEventRef(eventRef: Pointer): Pointer; cdecl;
    {class} function isMouseCoalescingEnabled: Boolean; cdecl;
    {class} function keyEventWithType(type_: NSEventType; location: NSPoint; modifierFlags: NSUInteger; timestamp: NSTimeInterval; windowNumber: NSInteger; context: NSGraphicsContext; characters: NSString; charactersIgnoringModifiers: NSString; isARepeat: Boolean; keyCode: Word): Pointer; cdecl;
    {class} function keyRepeatDelay: NSTimeInterval; cdecl;
    {class} function keyRepeatInterval: NSTimeInterval; cdecl;
    {class} function modifierFlags: NSUInteger; cdecl; overload;
    {class} function mouseEventWithType(type_: NSEventType; location: NSPoint; modifierFlags: NSUInteger; timestamp: NSTimeInterval; windowNumber: NSInteger; context: NSGraphicsContext; eventNumber: NSInteger; clickCount: NSInteger; pressure: Single): Pointer; cdecl;
    {class} function mouseLocation: NSPoint; cdecl;
    {class} function otherEventWithType(type_: NSEventType; location: NSPoint; modifierFlags: NSUInteger; timestamp: NSTimeInterval; windowNumber: NSInteger; context: NSGraphicsContext; subtype: Smallint; data1: NSInteger; data2: NSInteger): Pointer; cdecl;
    {class} function pressedMouseButtons: NSUInteger; cdecl;
    {class} procedure removeMonitor(eventMonitor: Pointer); cdecl;
    {class} procedure setMouseCoalescingEnabled(flag: Boolean); cdecl;
    {class} procedure startPeriodicEventsAfterDelay(delay: NSTimeInterval; withPeriod: NSTimeInterval); cdecl;
    {class} procedure stopPeriodicEvents; cdecl;
  end;
  NSEvent = interface(NSObject)
    ['{CABC9A18-AF74-46E6-B5D9-6018556ABFAA}']
    function CGEvent: CGEventRef; cdecl;
    function absoluteX: NSInteger; cdecl;
    function absoluteY: NSInteger; cdecl;
    function absoluteZ: NSInteger; cdecl;
    function buttonMask: NSUInteger; cdecl;
    function buttonNumber: NSInteger; cdecl;
    function capabilityMask: NSUInteger; cdecl;
    function characters: NSString; cdecl;
    function charactersIgnoringModifiers: NSString; cdecl;
    function clickCount: NSInteger; cdecl;
    function context: NSGraphicsContext; cdecl;
    function data1: NSInteger; cdecl;
    function data2: NSInteger; cdecl;
    function deltaX: Single; cdecl;
    function deltaY: Single; cdecl;
    function deltaZ: Single; cdecl;
    function deviceID: NSUInteger; cdecl;
    function eventNumber: NSInteger; cdecl;
    function eventRef: Pointer; cdecl;
    function isARepeat: Boolean; cdecl;
    function isEnteringProximity: Boolean; cdecl;
    function keyCode: Word; cdecl;
    function locationInWindow: NSPoint; cdecl;
    function magnification: Single; cdecl;
    function modifierFlags: NSUInteger; cdecl; overload;
    function pointingDeviceID: NSUInteger; cdecl;
    function pointingDeviceSerialNumber: NSUInteger; cdecl;
    function pointingDeviceType: NSPointingDeviceType; cdecl;
    function pressure: Single; cdecl;
    function rotation: Single; cdecl;
    function subtype: Smallint; cdecl;
    function systemTabletID: NSUInteger; cdecl;
    function tabletID: NSUInteger; cdecl;
    function tangentialPressure: Single; cdecl;
    function tilt: NSPoint; cdecl;
    function timestamp: NSTimeInterval; cdecl;
    function touchesMatchingPhase(phase: NSTouchPhase; inView: NSView): NSSet; cdecl;
    function trackingArea: NSTrackingArea; cdecl;
    function trackingNumber: NSInteger; cdecl;
    function &type: NSEventType; cdecl;
    function uniqueID: UInt64; cdecl;
    function userData: Pointer; cdecl;
    function vendorDefined: Pointer; cdecl;
    function vendorID: NSUInteger; cdecl;
    function vendorPointingDeviceType: NSUInteger; cdecl;
    function window: NSWindow; cdecl;
    function windowNumber: NSInteger; cdecl;
  end;
  TNSEvent = class(TOCGenericImport<NSEventClass, NSEvent>)  end;

  NSDocumentControllerClass = interface(NSObjectClass)
    ['{F8DBC9C6-6F20-42E3-BBC2-996BF23B3C7E}']
    {class} function sharedDocumentController: Pointer; cdecl;
  end;
  NSDocumentController = interface(NSObject)
    ['{DA5E0E40-6B2E-4D78-A192-6DA07ACD8B8E}']
    function URLsFromRunningOpenPanel: NSArray; cdecl;
    procedure addDocument(document: NSDocument); cdecl;
    function autosavingDelay: NSTimeInterval; cdecl;
    procedure clearRecentDocuments(sender: Pointer); cdecl;
    procedure closeAllDocumentsWithDelegate(delegate: Pointer; didCloseAllSelector: SEL; contextInfo: Pointer); cdecl;
    function currentDirectory: NSString; cdecl;
    function currentDocument: Pointer; cdecl;
    function defaultType: NSString; cdecl;
    function displayNameForType(typeName: NSString): NSString; cdecl;
    function documentClassNames: NSArray; cdecl;
    function documentForFileName(fileName: NSString): Pointer; cdecl;
    function documentForURL(absoluteURL: NSURL): Pointer; cdecl;
    function documentForWindow(window: NSWindow): Pointer; cdecl;
    function documents: NSArray; cdecl;
    function fileExtensionsFromType(typeName: NSString): NSArray; cdecl;
    function fileNamesFromRunningOpenPanel: NSArray; cdecl;
    function hasEditedDocuments: Boolean; cdecl;
    function init: Pointer; cdecl;
    function makeDocumentForURL(absoluteDocumentURL: NSURL; withContentsOfURL: NSURL; ofType: NSString; error: PPointer): Pointer; cdecl;
    function makeDocumentWithContentsOfFile(fileName: NSString; ofType: NSString): Pointer; cdecl;
    function makeDocumentWithContentsOfURL(url: NSURL; ofType: NSString): Pointer; cdecl; overload;
    function makeDocumentWithContentsOfURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Pointer; cdecl; overload;
    function makeUntitledDocumentOfType(type_: NSString): Pointer; cdecl; overload;
    function makeUntitledDocumentOfType(typeName: NSString; error: PPointer): Pointer; cdecl; overload;
    function maximumRecentDocumentCount: NSUInteger; cdecl;
    procedure newDocument(sender: Pointer); cdecl;
    procedure noteNewRecentDocument(document: NSDocument); cdecl;
    procedure noteNewRecentDocumentURL(absoluteURL: NSURL); cdecl;
    procedure openDocument(sender: Pointer); cdecl;
    function openDocumentWithContentsOfFile(fileName: NSString; display: Boolean): Pointer; cdecl;
    function openDocumentWithContentsOfURL(url: NSURL; display: Boolean): Pointer; cdecl; overload;
    function openDocumentWithContentsOfURL(absoluteURL: NSURL; display: Boolean; error: NSError): Pointer; cdecl; overload;
    function openUntitledDocumentAndDisplay(displayDocument: Boolean; error: PPointer): Pointer; cdecl;
    function openUntitledDocumentOfType(type_: NSString; display: Boolean): Pointer; cdecl;
    function presentError(error: NSError): Boolean; cdecl; overload;
    procedure presentError(error: NSError; modalForWindow: NSWindow; delegate: Pointer; didPresentSelector: SEL; contextInfo: Pointer); cdecl; overload;
    function recentDocumentURLs: NSArray; cdecl;
    procedure removeDocument(document: NSDocument); cdecl;
    function reopenDocumentForURL(absoluteDocumentURL: NSURL; withContentsOfURL: NSURL; error: NSError): Boolean; cdecl;
    procedure reviewUnsavedDocumentsWithAlertTitle(title: NSString; cancellable: Boolean; delegate: Pointer; didReviewAllSelector: SEL; contextInfo: Pointer); cdecl;
    function runModalOpenPanel(openPanel: NSOpenPanel; forTypes: NSArray): NSInteger; cdecl;
    procedure saveAllDocuments(sender: Pointer); cdecl;
    procedure setAutosavingDelay(autosavingDelay: NSTimeInterval); cdecl;
    procedure setShouldCreateUI(flag: Boolean); cdecl;
    function shouldCreateUI: Boolean; cdecl;
    function typeForContentsOfURL(inAbsoluteURL: NSURL; error: PPointer): NSString; cdecl;
    function typeFromFileExtension(fileNameExtensionOrHFSFileType: NSString): NSString; cdecl;
    function validateUserInterfaceItem(anItem: NSValidatedUserInterfaceItem): Boolean; cdecl;
    function willPresentError(error: NSError): NSError; cdecl;
  end;
  TNSDocumentController = class(TOCGenericImport<NSDocumentControllerClass, NSDocumentController>)  end;

  NSDocumentClass = interface(NSObjectClass)
    ['{67E755BC-7AB7-4D8A-B3DD-D3BC6AF8161C}']
    {class} function canConcurrentlyReadDocumentsOfType(typeName: NSString): Boolean; cdecl;
    {class} function isNativeType(type_: NSString): Boolean; cdecl;
    {class} function readableTypes: NSArray; cdecl;
    {class} function writableTypes: NSArray; cdecl;
  end;
  NSDocument = interface(NSObject)
    ['{6B326F96-12FD-4BFA-A824-E000DF8FA22A}']
    procedure addWindowController(windowController: NSWindowController); cdecl;
    procedure autosaveDocumentWithDelegate(delegate: Pointer; didAutosaveSelector: SEL; contextInfo: Pointer); cdecl;
    function autosavedContentsFileURL: NSURL; cdecl;
    function autosavingFileType: NSString; cdecl;
    procedure canCloseDocumentWithDelegate(delegate: Pointer; shouldCloseSelector: SEL; contextInfo: Pointer); cdecl;
    procedure close; cdecl;
    function dataOfType(typeName: NSString; error: PPointer): NSData; cdecl;
    function dataRepresentationOfType(type_: NSString): NSData; cdecl;
    function displayName: NSString; cdecl;
    function fileAttributesToWriteToFile(fullDocumentPath: NSString; ofType: NSString; saveOperation: NSSaveOperationType): NSDictionary; cdecl;
    function fileAttributesToWriteToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; originalContentsURL: NSURL; error: PPointer): NSDictionary; cdecl;
    function fileModificationDate: NSDate; cdecl;
    function fileName: NSString; cdecl;
    function fileNameExtensionForType(typeName: NSString; saveOperation: NSSaveOperationType): NSString; cdecl;
    function fileNameExtensionWasHiddenInLastRunSavePanel: Boolean; cdecl;
    function fileType: NSString; cdecl;
    function fileTypeFromLastRunSavePanel: NSString; cdecl;
    function fileURL: NSURL; cdecl;
    function fileWrapperOfType(typeName: NSString; error: PPointer): NSFileWrapper; cdecl;
    function fileWrapperRepresentationOfType(type_: NSString): NSFileWrapper; cdecl;
    function handleCloseScriptCommand(command: NSCloseCommand): Pointer; cdecl;
    function handlePrintScriptCommand(command: NSScriptCommand): Pointer; cdecl;
    function handleSaveScriptCommand(command: NSScriptCommand): Pointer; cdecl;
    function hasUnautosavedChanges: Boolean; cdecl;
    function hasUndoManager: Boolean; cdecl;
    function init: Pointer; cdecl;
    function initForURL(absoluteDocumentURL: NSURL; withContentsOfURL: NSURL; ofType: NSString; error: PPointer): Pointer; cdecl;
    function initWithContentsOfFile(absolutePath: NSString; ofType: NSString): Pointer; cdecl;
    function initWithContentsOfURL(absoluteURL: NSURL; ofType: NSString): Pointer; cdecl; overload;
    function initWithContentsOfURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Pointer; cdecl; overload;
    function initWithType(typeName: NSString; error: PPointer): Pointer; cdecl;
    function isDocumentEdited: Boolean; cdecl;
    function keepBackupFile: Boolean; cdecl;
    function lastComponentOfFileName: NSString; cdecl;
    function loadDataRepresentation(data: NSData; ofType: NSString): Boolean; cdecl;
    function loadFileWrapperRepresentation(wrapper: NSFileWrapper; ofType: NSString): Boolean; cdecl;
    procedure makeWindowControllers; cdecl;
    function objectSpecifier: NSScriptObjectSpecifier; cdecl;
    function preparePageLayout(pageLayout: NSPageLayout): Boolean; cdecl;
    function prepareSavePanel(savePanel: NSSavePanel): Boolean; cdecl;
    function presentError(error: NSError): Boolean; cdecl; overload;
    procedure presentError(error: NSError; modalForWindow: NSWindow; delegate: Pointer; didPresentSelector: SEL; contextInfo: Pointer); cdecl; overload;
    procedure printDocument(sender: Pointer); cdecl;
    procedure printDocumentWithSettings(printSettings: NSDictionary; showPrintPanel: Boolean; delegate: Pointer; didPrintSelector: SEL; contextInfo: Pointer); cdecl;
    function printInfo: NSPrintInfo; cdecl;
    function printOperationWithSettings(printSettings: NSDictionary; error: PPointer): NSPrintOperation; cdecl;
    procedure printShowingPrintPanel(flag: Boolean); cdecl;
    function readFromData(data: NSData; ofType: NSString; error: PPointer): Boolean; cdecl;
    function readFromFile(fileName: NSString; ofType: NSString): Boolean; cdecl;
    function readFromFileWrapper(fileWrapper: NSFileWrapper; ofType: NSString; error: PPointer): Boolean; cdecl;
    function readFromURL(url: NSURL; ofType: NSString): Boolean; cdecl; overload;
    function readFromURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl; overload;
    procedure removeWindowController(windowController: NSWindowController); cdecl;
    procedure revertDocumentToSaved(sender: Pointer); cdecl;
    function revertToContentsOfURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl;
    function revertToSavedFromFile(fileName: NSString; ofType: NSString): Boolean; cdecl;
    function revertToSavedFromURL(url: NSURL; ofType: NSString): Boolean; cdecl;
    function runModalPageLayoutWithPrintInfo(printInfo: NSPrintInfo): NSInteger; cdecl; overload;
    procedure runModalPageLayoutWithPrintInfo(printInfo: NSPrintInfo; delegate: Pointer; didRunSelector: SEL; contextInfo: Pointer); cdecl; overload;
    procedure runModalPrintOperation(printOperation: NSPrintOperation; delegate: Pointer; didRunSelector: SEL; contextInfo: Pointer); cdecl;
    procedure runModalSavePanelForSaveOperation(saveOperation: NSSaveOperationType; delegate: Pointer; didSaveSelector: SEL; contextInfo: Pointer); cdecl;
    procedure runPageLayout(sender: Pointer); cdecl;
    procedure saveDocument(sender: Pointer); cdecl;
    procedure saveDocumentAs(sender: Pointer); cdecl;
    procedure saveDocumentTo(sender: Pointer); cdecl;
    procedure saveDocumentWithDelegate(delegate: Pointer; didSaveSelector: SEL; contextInfo: Pointer); cdecl;
    procedure saveToFile(fileName: NSString; saveOperation: NSSaveOperationType; delegate: Pointer; didSaveSelector: SEL; contextInfo: Pointer); cdecl;
    procedure saveToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; delegate: Pointer; didSaveSelector: SEL; contextInfo: Pointer); cdecl; overload;
    function saveToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; error: NSError): Boolean; cdecl; overload;
    procedure setAutosavedContentsFileURL(absoluteURL: NSURL); cdecl;
    procedure setFileModificationDate(modificationDate: NSDate); cdecl;
    procedure setFileName(fileName: NSString); cdecl;
    procedure setFileType(typeName: NSString); cdecl;
    procedure setFileURL(absoluteURL: NSURL); cdecl;
    procedure setHasUndoManager(hasUndoManager: Boolean); cdecl;
    procedure setLastComponentOfFileName(str: NSString); cdecl;
    procedure setPrintInfo(printInfo: NSPrintInfo); cdecl;
    procedure setUndoManager(undoManager: NSUndoManager); cdecl;
    procedure setWindow(window: NSWindow); cdecl;
    function shouldChangePrintInfo(newPrintInfo: NSPrintInfo): Boolean; cdecl;
    procedure shouldCloseWindowController(windowController: NSWindowController; delegate: Pointer; shouldCloseSelector: SEL; contextInfo: Pointer); cdecl;
    function shouldRunSavePanelWithAccessoryView: Boolean; cdecl;
    procedure showWindows; cdecl;
    function undoManager: NSUndoManager; cdecl;
    procedure updateChangeCount(change: NSDocumentChangeType); cdecl;
    function validateUserInterfaceItem(anItem: NSValidatedUserInterfaceItem): Boolean; cdecl;
    function willPresentError(error: NSError): NSError; cdecl;
    procedure windowControllerDidLoadNib(windowController: NSWindowController); cdecl;
    procedure windowControllerWillLoadNib(windowController: NSWindowController); cdecl;
    function windowControllers: NSArray; cdecl;
    function windowForSheet: NSWindow; cdecl;
    function windowNibName: NSString; cdecl;
    function writableTypesForSaveOperation(saveOperation: NSSaveOperationType): NSArray; cdecl;
    function writeSafelyToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; error: PPointer): Boolean; cdecl;
    function writeToFile(fileName: NSString; ofType: NSString): Boolean; cdecl; overload;
    function writeToFile(fullDocumentPath: NSString; ofType: NSString; originalFile: NSString; saveOperation: NSSaveOperationType): Boolean; cdecl; overload;
    function writeToURL(url: NSURL; ofType: NSString): Boolean; cdecl; overload;
    function writeToURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl; overload;
    function writeToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; originalContentsURL: NSURL; error: PPointer): Boolean; cdecl; overload;
    function writeWithBackupToFile(fullDocumentPath: NSString; ofType: NSString; saveOperation: NSSaveOperationType): Boolean; cdecl;
  end;
  TNSDocument = class(TOCGenericImport<NSDocumentClass, NSDocument>)  end;

  NSFontClass = interface(NSObjectClass)
    ['{682E3C5D-30D3-411D-8F39-B6D4CF817050}']
    {class} function boldSystemFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function controlContentFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function fontWithDescriptor(fontDescriptor: NSFontDescriptor; size: Single): Pointer; cdecl; overload;
    {class} function fontWithDescriptor(fontDescriptor: NSFontDescriptor; textTransform: NSAffineTransform): Pointer; cdecl; overload;
    {class} function fontWithName(fontName: NSString; matrix: PSingle): Pointer; cdecl; overload;
    {class} function fontWithName(fontName: NSString; size: Single): Pointer; cdecl; overload;
    {class} function labelFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function labelFontSize: Single; cdecl;
    {class} function menuBarFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function menuFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function messageFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function paletteFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} procedure setUserFixedPitchFont(aFont: NSFont); cdecl;
    {class} procedure setUserFont(aFont: NSFont); cdecl;
    {class} function smallSystemFontSize: Single; cdecl;
    {class} function systemFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function systemFontSize: Single; cdecl;
    {class} function systemFontSizeForControlSize(controlSize: NSControlSize): Single; cdecl;
    {class} function titleBarFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function toolTipsFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function userFixedPitchFontOfSize(fontSize: Single): Pointer; cdecl;
    {class} function userFontOfSize(fontSize: Single): Pointer; cdecl;
  end;
  NSFont = interface(NSObject)
    ['{02420779-E857-419D-B8B1-AD79A0D4FA23}']
    function advancementForGlyph(ag: NSGlyph): NSSize; cdecl;
    function ascender: Single; cdecl;
    function boundingRectForFont: NSRect; cdecl;
    function boundingRectForGlyph(aGlyph: NSGlyph): NSRect; cdecl;
    function capHeight: Single; cdecl;
    function coveredCharacterSet: NSCharacterSet; cdecl;
    function descender: Single; cdecl;
    function displayName: NSString; cdecl;
    function familyName: NSString; cdecl;
    function fontDescriptor: NSFontDescriptor; cdecl;
    function fontName: NSString; cdecl;
    procedure getAdvancements(advancements: NSSizeArray; forGlyphs: PNSGlyph; count: NSUInteger); cdecl; overload;
    procedure getAdvancements(advancements: NSSizeArray; forPackedGlyphs: Pointer; length: NSUInteger); cdecl; overload;
    procedure getBoundingRects(bounds: NSRectArray; forGlyphs: PNSGlyph; count: NSUInteger); cdecl;
    function glyphWithName(aName: NSString): NSGlyph; cdecl;
    function isFixedPitch: Boolean; cdecl;
    function italicAngle: Single; cdecl;
    function leading: Single; cdecl;
    function matrix: PSingle; cdecl;
    function maximumAdvancement: NSSize; cdecl;
    function mostCompatibleStringEncoding: NSStringEncoding; cdecl;
    function numberOfGlyphs: NSUInteger; cdecl;
    function pointSize: Single; cdecl;
    function printerFont: NSFont; cdecl;
    function renderingMode: NSFontRenderingMode; cdecl;
    function screenFont: NSFont; cdecl;
    function screenFontWithRenderingMode(renderingMode: NSFontRenderingMode): NSFont; cdecl;
    procedure setInContext(graphicsContext: NSGraphicsContext); cdecl;
    function textTransform: NSAffineTransform; cdecl;
    function underlinePosition: Single; cdecl;
    function underlineThickness: Single; cdecl;
    function xHeight: Single; cdecl;
  end;
  TNSFont = class(TOCGenericImport<NSFontClass, NSFont>)  end;

  NSFileWrapperClass = interface(NSObjectClass)
    ['{9166EE2B-0DFA-46B2-9816-EFAB8AC647B2}']
  end;
  NSFileWrapper = interface(NSObject)
    ['{032035DD-EE44-4986-B07F-7D151457085F}']
    function addFileWithPath(path: NSString): NSString; cdecl;
    function addFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function addRegularFileWithContents(data: NSData; preferredFilename: NSString): NSString; cdecl;
    function addSymbolicLinkWithDestination(path: NSString; preferredFilename: NSString): NSString; cdecl;
    function fileAttributes: NSDictionary; cdecl;
    function fileWrappers: NSDictionary; cdecl;
    function filename: NSString; cdecl;
    function icon: NSImage; cdecl;
    function initDirectoryWithFileWrappers(childrenByPreferredName: NSDictionary): Pointer; cdecl;
    function initRegularFileWithContents(contents: NSData): Pointer; cdecl;
    function initSymbolicLinkWithDestination(path: NSString): Pointer; cdecl;
    function initSymbolicLinkWithDestinationURL(url: NSURL): Pointer; cdecl;
    function initWithPath(path: NSString): Pointer; cdecl;
    function initWithSerializedRepresentation(serializeRepresentation: NSData): Pointer; cdecl;
    function initWithURL(url: NSURL; options: NSFileWrapperReadingOptions; error: PPointer): Pointer; cdecl;
    function isDirectory: Boolean; cdecl;
    function isRegularFile: Boolean; cdecl;
    function isSymbolicLink: Boolean; cdecl;
    function keyForFileWrapper(child: NSFileWrapper): NSString; cdecl;
    function matchesContentsOfURL(url: NSURL): Boolean; cdecl;
    function needsToBeUpdatedFromPath(path: NSString): Boolean; cdecl;
    function preferredFilename: NSString; cdecl;
    function readFromURL(url: NSURL; options: NSFileWrapperReadingOptions; error: PPointer): Boolean; cdecl;
    function regularFileContents: NSData; cdecl;
    procedure removeFileWrapper(child: NSFileWrapper); cdecl;
    function serializedRepresentation: NSData; cdecl;
    procedure setFileAttributes(fileAttributes: NSDictionary); cdecl;
    procedure setFilename(fileName: NSString); cdecl;
    procedure setIcon(icon: NSImage); cdecl;
    procedure setPreferredFilename(fileName: NSString); cdecl;
    function symbolicLinkDestination: NSString; cdecl;
    function symbolicLinkDestinationURL: NSURL; cdecl;
    function updateFromPath(path: NSString): Boolean; cdecl;
    function writeToFile(path: NSString; atomically: Boolean; updateFilenames: Boolean): Boolean; cdecl;
    function writeToURL(url: NSURL; options: NSFileWrapperWritingOptions; originalContentsURL: NSURL; error: PPointer): Boolean; cdecl;
  end;
  TNSFileWrapper = class(TOCGenericImport<NSFileWrapperClass, NSFileWrapper>)  end;

  NSDockTileClass = interface(NSObjectClass)
    ['{DBE53FD5-F05B-4CB7-BD07-48594764AEDB}']
  end;
  NSDockTile = interface(NSObject)
    ['{CE17EEE3-5B15-45F2-8A01-A9F8EF65B6C1}']
    function badgeLabel: NSString; cdecl;
    function contentView: NSView; cdecl;
    procedure display; cdecl;
    function owner: Pointer; cdecl;
    procedure setBadgeLabel(string_: NSString); cdecl;
    procedure setContentView(view: NSView); cdecl;
    procedure setShowsApplicationBadge(flag: Boolean); cdecl;
    function showsApplicationBadge: Boolean; cdecl;
    function size: NSSize; cdecl;
  end;
  TNSDockTile = class(TOCGenericImport<NSDockTileClass, NSDockTile>)  end;

  NSAlertClass = interface(NSObjectClass)
    ['{07E1AD7E-44F5-4F48-8D2C-1BACDAD84FCF}']
    {class} function alertWithError(error: NSError): Pointer; cdecl;
    {class} function alertWithMessageText(message: NSString; defaultButton: NSString; alternateButton: NSString; otherButton: NSString; informativeTextWithFormat: NSString): Pointer; cdecl;
  end;
  NSAlert = interface(NSObject)
    ['{AB0B39BE-C939-4D3E-A58D-316C78BA22EC}']
    function accessoryView: NSView; cdecl;
    function addButtonWithTitle(title: NSString): NSButton; cdecl;
    function alertStyle: NSAlertStyle; cdecl;
    procedure beginSheetModalForWindow(window: NSWindow; modalDelegate: Pointer; didEndSelector: SEL; contextInfo: Pointer); cdecl;
    function buttons: Pointer; cdecl;
    function delegate: NSAlertDelegate; cdecl;
    function helpAnchor: NSString; cdecl;
    function icon: NSImage; cdecl;
    function informativeText: NSString; cdecl;
    procedure layout; cdecl;
    function messageText: NSString; cdecl;
    function runModal: NSInteger; cdecl;
    procedure setAccessoryView(view: NSView); cdecl;
    procedure setAlertStyle(style: NSAlertStyle); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setHelpAnchor(anchor: NSString); cdecl;
    procedure setIcon(icon: NSImage); cdecl;
    procedure setInformativeText(informativeText: NSString); cdecl;
    procedure setMessageText(messageText: NSString); cdecl;
    procedure setShowsHelp(showsHelp: Boolean); cdecl;
    procedure setShowsSuppressionButton(flag: Boolean); cdecl;
    function showsHelp: Boolean; cdecl;
    function showsSuppressionButton: Boolean; cdecl;
    function suppressionButton: NSButton; cdecl;
    function window: Pointer; cdecl;
  end;
  TNSAlert = class(TOCGenericImport<NSAlertClass, NSAlert>)  end;

  NSToolbarItemClass = interface(NSObjectClass)
    ['{BB978267-2747-41B8-AB2A-2AAE74B7CDE3}']
  end;
  NSToolbarItem = interface(NSObject)
    ['{42E7E5F6-3C09-4010-998A-C348682B428B}']
    function action: SEL; cdecl;
    function allowsDuplicatesInToolbar: Boolean; cdecl;
    function autovalidates: Boolean; cdecl;
    function image: NSImage; cdecl;
    function initWithItemIdentifier(itemIdentifier: NSString): Pointer; cdecl;
    function isEnabled: Boolean; cdecl;
    function itemIdentifier: NSString; cdecl;
    function maxSize: NSSize; cdecl;
    function menuFormRepresentation: NSMenuItem; cdecl;
    function minSize: NSSize; cdecl;
    function paletteLabel: NSString; cdecl;
    procedure setAction(action: SEL); cdecl;
    procedure setAutovalidates(resistance: Boolean); cdecl;
    procedure setEnabled(enabled: Boolean); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setLabel(label_: NSString); cdecl;
    procedure setMaxSize(size: NSSize); cdecl;
    procedure setMenuFormRepresentation(menuItem: NSMenuItem); cdecl;
    procedure setMinSize(size: NSSize); cdecl;
    procedure setPaletteLabel(paletteLabel: NSString); cdecl;
    procedure setTag(tag: NSInteger); cdecl;
    procedure setTarget(target: Pointer); cdecl;
    procedure setToolTip(toolTip: NSString); cdecl;
    procedure setView(view: NSView); cdecl;
    procedure setVisibilityPriority(visibilityPriority: NSInteger); cdecl;
    function tag: NSInteger; cdecl;
    function target: Pointer; cdecl;
    function toolTip: NSString; cdecl;
    function toolbar: NSToolbar; cdecl;
    procedure validate; cdecl;
    function view: NSView; cdecl;
    function visibilityPriority: NSInteger; cdecl;
  end;
  TNSToolbarItem = class(TOCGenericImport<NSToolbarItemClass, NSToolbarItem>)  end;

  NSAnimationClass = interface(NSObjectClass)
    ['{34061C4A-3137-4271-A2F8-B4CB9436BC96}']
  end;
  NSAnimation = interface(NSObject)
    ['{A9E3322E-C31E-47B0-AA17-EAD8425937B9}']
    procedure addProgressMark(progressMark: NSAnimationProgress); cdecl;
    function animationBlockingMode: NSAnimationBlockingMode; cdecl;
    function animationCurve: NSAnimationCurve; cdecl;
    procedure clearStartAnimation; cdecl;
    procedure clearStopAnimation; cdecl;
    function currentProgress: NSAnimationProgress; cdecl;
    function currentValue: Single; cdecl;
    function delegate: NSAnimationDelegate; cdecl;
    function duration: NSTimeInterval; cdecl;
    function frameRate: Single; cdecl;
    function initWithDuration(duration: NSTimeInterval; animationCurve: NSAnimationCurve): Pointer; cdecl;
    function isAnimating: Boolean; cdecl;
    function progressMarks: NSArray; cdecl;
    procedure removeProgressMark(progressMark: NSAnimationProgress); cdecl;
    function runLoopModesForAnimating: NSArray; cdecl;
    procedure setAnimationBlockingMode(animationBlockingMode: NSAnimationBlockingMode); cdecl;
    procedure setAnimationCurve(curve: NSAnimationCurve); cdecl;
    procedure setCurrentProgress(progress: NSAnimationProgress); cdecl;
    procedure setDelegate(delegate: NSAnimationDelegate); cdecl;
    procedure setDuration(duration: NSTimeInterval); cdecl;
    procedure setFrameRate(framesPerSecond: Single); cdecl;
    procedure setProgressMarks(progressMarks: NSArray); cdecl;
    procedure startAnimation; cdecl;
    procedure startWhenAnimation(animation: NSAnimation; reachesProgress: NSAnimationProgress); cdecl;
    procedure stopAnimation; cdecl;
    procedure stopWhenAnimation(animation: NSAnimation; reachesProgress: NSAnimationProgress); cdecl;
  end;
  TNSAnimation = class(TOCGenericImport<NSAnimationClass, NSAnimation>)  end;

  NSCursorClass = interface(NSObjectClass)
    ['{DC019965-59A1-421E-A1A4-0AED35A706DE}']
    {class} function IBeamCursor: Pointer; cdecl;
    {class} function arrowCursor: Pointer; cdecl;
    {class} function closedHandCursor: Pointer; cdecl;
    {class} function contextualMenuCursor: Pointer; cdecl;
    {class} function crosshairCursor: Pointer; cdecl;
    {class} function currentCursor: Pointer; cdecl;
    {class} function currentSystemCursor: Pointer; cdecl;
    {class} function disappearingItemCursor: Pointer; cdecl;
    {class} function dragCopyCursor: Pointer; cdecl;
    {class} function dragLinkCursor: Pointer; cdecl;
    {class} procedure hide; cdecl;
    {class} function openHandCursor: Pointer; cdecl;
    {class} function operationNotAllowedCursor: Pointer; cdecl;
    {class} function pointingHandCursor: Pointer; cdecl;
    {class} procedure pop; cdecl; overload;
    {class} function resizeDownCursor: Pointer; cdecl;
    {class} function resizeLeftCursor: Pointer; cdecl;
    {class} function resizeLeftRightCursor: Pointer; cdecl;
    {class} function resizeRightCursor: Pointer; cdecl;
    {class} function resizeUpCursor: Pointer; cdecl;
    {class} function resizeUpDownCursor: Pointer; cdecl;
    {class} procedure setHiddenUntilMouseMoves(flag: Boolean); cdecl;
    {class} procedure unhide; cdecl;
  end;
  NSCursor = interface(NSObject)
    ['{DA363FAA-3CE0-416C-869D-E2C63E037796}']
    function hotSpot: NSPoint; cdecl;
    function image: NSImage; cdecl;
    function initWithImage(newImage: NSImage; foregroundColorHint: NSColor; backgroundColorHint: NSColor; hotSpot: NSPoint): Pointer; cdecl; overload;
    function initWithImage(newImage: NSImage; hotSpot: NSPoint): Pointer; cdecl; overload;
    function isSetOnMouseEntered: Boolean; cdecl;
    function isSetOnMouseExited: Boolean; cdecl;
    procedure mouseEntered(theEvent: NSEvent); cdecl;
    procedure mouseExited(theEvent: NSEvent); cdecl;
    procedure pop; cdecl; overload;
    procedure push; cdecl;
    procedure setOnMouseEntered(flag: Boolean); cdecl;
    procedure setOnMouseExited(flag: Boolean); cdecl;
  end;
  TNSCursor = class(TOCGenericImport<NSCursorClass, NSCursor>)  end;

  NSAnimationContextClass = interface(NSObjectClass)
    ['{84B1806B-885B-4BAB-BBCC-4E887E011842}']
    {class} procedure beginGrouping; cdecl;
    {class} function currentContext: Pointer; cdecl;
    {class} procedure endGrouping; cdecl;
  end;
  NSAnimationContext = interface(NSObject)
    ['{E398DC0A-6CAE-452F-89F4-0CE0CB8D10DB}']
    function duration: NSTimeInterval; cdecl;
    procedure setDuration(duration: NSTimeInterval); cdecl;
  end;
  TNSAnimationContext = class(TOCGenericImport<NSAnimationContextClass, NSAnimationContext>)  end;

  NSAffineTransformClass = interface(NSObjectClass)
    ['{A65AC5EC-D4AA-4DE6-B402-31B8D4AC3261}']
    {class} function transform: Pointer; cdecl;
  end;
  NSAffineTransform = interface(NSObject)
    ['{A47B9A3B-3F3E-4FD8-BACF-CE35D25C56EA}']
    procedure appendTransform(transform: NSAffineTransform); cdecl;
    procedure concat; cdecl;
    function initWithTransform(transform: NSAffineTransform): Pointer; cdecl;
    procedure invert; cdecl;
    procedure prependTransform(transform: NSAffineTransform); cdecl;
    procedure rotateByDegrees(angle: Single); cdecl;
    procedure rotateByRadians(angle: Single); cdecl;
    procedure scaleBy(scale: Single); cdecl;
    procedure scaleXBy(scaleX: Single; yBy: Single); cdecl;
    procedure setTransformStruct(transformStruct: NSAffineTransformStruct); cdecl;
    function transformBezierPath(aPath: NSBezierPath): NSBezierPath; cdecl;
    function transformPoint(aPoint: NSPoint): NSPoint; cdecl;
    function transformSize(aSize: NSSize): NSSize; cdecl;
    function transformStruct: NSAffineTransformStruct; cdecl;
    procedure translateXBy(deltaX: Single; yBy: Single); cdecl;
  end;
  TNSAffineTransform = class(TOCGenericImport<NSAffineTransformClass, NSAffineTransform>)  end;

  NSToolbarClass = interface(NSObjectClass)
    ['{253FC5BF-30F2-467C-8AC7-E8660447EB5B}']
  end;
  NSToolbar = interface(NSObject)
    ['{99470F81-6BDD-4ABF-9B84-DAC9A06595F4}']
    function allowsUserCustomization: Boolean; cdecl;
    function autosavesConfiguration: Boolean; cdecl;
    function configurationDictionary: NSDictionary; cdecl;
    function customizationPaletteIsRunning: Boolean; cdecl;
    function delegate: NSToolbarDelegate; cdecl;
    function displayMode: NSToolbarDisplayMode; cdecl;
    function identifier: NSString; cdecl;
    function initWithIdentifier(identifier: NSString): Pointer; cdecl;
    procedure insertItemWithItemIdentifier(itemIdentifier: NSString; atIndex: NSInteger); cdecl;
    function isVisible: Boolean; cdecl;
    function items: NSArray; cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure runCustomizationPalette(sender: Pointer); cdecl;
    function selectedItemIdentifier: NSString; cdecl;
    procedure setAllowsUserCustomization(allowCustomization: Boolean); cdecl;
    procedure setAutosavesConfiguration(flag: Boolean); cdecl;
    procedure setConfigurationFromDictionary(configDict: NSDictionary); cdecl;
    procedure setDelegate(delegate: NSToolbarDelegate); cdecl;
    procedure setDisplayMode(displayMode: NSToolbarDisplayMode); cdecl;
    procedure setSelectedItemIdentifier(itemIdentifier: NSString); cdecl;
    procedure setShowsBaselineSeparator(flag: Boolean); cdecl;
    procedure setSizeMode(sizeMode: NSToolbarSizeMode); cdecl;
    procedure setVisible(shown: Boolean); cdecl;
    function showsBaselineSeparator: Boolean; cdecl;
    function sizeMode: NSToolbarSizeMode; cdecl;
    procedure validateVisibleItems; cdecl;
    function visibleItems: NSArray; cdecl;
  end;
  TNSToolbar = class(TOCGenericImport<NSToolbarClass, NSToolbar>)  end;

  NSPersistentDocumentClass = interface(NSDocumentClass)
    ['{6A929872-0D61-4F65-BE3E-0861A452EC98}']
  end;
  NSPersistentDocument = interface(NSDocument)
    ['{A15DA6C3-7DA9-40D1-B2F7-34853CE14EA7}']
    function configurePersistentStoreCoordinatorForURL(url: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl; overload;
    function configurePersistentStoreCoordinatorForURL(url: NSURL; ofType: NSString; modelConfiguration: NSString; storeOptions: NSDictionary; error: PPointer): Boolean; cdecl; overload;
//    function managedObjectContext: NSManagedObjectContext; cdecl;
    function managedObjectModel: Pointer; cdecl;
    function persistentStoreTypeForFileType(fileType: NSString): NSString; cdecl;
    function readFromURL(absoluteURL: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl;
    function revertToContentsOfURL(inAbsoluteURL: NSURL; ofType: NSString; error: PPointer): Boolean; cdecl;
//    procedure setManagedObjectContext(managedObjectContext: NSManagedObjectContext); cdecl;
    function writeToURL(absoluteURL: NSURL; ofType: NSString; forSaveOperation: NSSaveOperationType; originalContentsURL: NSURL; error: PPointer): Boolean; cdecl;
  end;
  TNSPersistentDocument = class(TOCGenericImport<NSPersistentDocumentClass, NSPersistentDocument>)  end;

  NSViewControllerClass = interface(NSResponderClass)
    ['{75968B93-80E8-4A2F-9BE0-9CB986B7EB4F}']
  end;
  NSViewController = interface(NSResponder)
    ['{446D334D-2FCB-4C1E-B07E-0BCAB8B25EA1}']
    function commitEditing: Boolean; cdecl;
    procedure commitEditingWithDelegate(delegate: Pointer; didCommitSelector: SEL; contextInfo: Pointer); cdecl;
    procedure discardEditing; cdecl;
    function initWithNibName(nibNameOrNil: NSString; bundle: NSBundle): Pointer; cdecl;
    procedure loadView; cdecl;
    function nibBundle: NSBundle; cdecl;
    function nibName: NSString; cdecl;
    function representedObject: Pointer; cdecl;
    procedure setRepresentedObject(representedObject: Pointer); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure setView(view: NSView); cdecl;
    function title: NSString; cdecl;
    function view: NSView; cdecl;
  end;
  TNSViewController = class(TOCGenericImport<NSViewControllerClass, NSViewController>)  end;

  NSCIImageRepClass = interface(NSImageRepClass)
    ['{2DD44A15-4A94-4C20-9BD3-67103C530D08}']
    {class} function imageRepWithCIImage(image: CIImage): Pointer; cdecl;
  end;
  NSCIImageRep = interface(NSImageRep)
    ['{4928AA0F-EC6D-46B8-B1DD-414432BE5771}']
    function CIImage: CIImage; cdecl;
    function initWithCIImage(image: CIImage): Pointer; cdecl;
  end;
  TNSCIImageRep = class(TOCGenericImport<NSCIImageRepClass, NSCIImageRep>)  end;

  NSViewAnimationClass = interface(NSAnimationClass)
    ['{43C04EB7-F7D3-4706-83E5-B95610A96182}']
  end;
  NSViewAnimation = interface(NSAnimation)
    ['{1F18B8FB-6ECD-405C-A018-107B62F3F960}']
    function initWithViewAnimations(viewAnimations: NSArray): Pointer; cdecl;
    procedure setViewAnimations(viewAnimations: NSArray); cdecl;
    function viewAnimations: NSArray; cdecl;
  end;
  TNSViewAnimation = class(TOCGenericImport<NSViewAnimationClass, NSViewAnimation>)  end;

  NSBrowserCellClass = interface(NSCellClass)
    ['{C6164A7D-F96B-4FC1-BAA1-83D4695AF18C}']
    {class} function branchImage: NSImage; cdecl;
    {class} function highlightedBranchImage: NSImage; cdecl;
  end;
  NSBrowserCell = interface(NSCell)
    ['{B3F4FDA9-D9C0-4F3B-A2A5-033CCBAF8133}']
    function alternateImage: NSImage; cdecl;
    function highlightColorInView(controlView: NSView): NSColor; cdecl;
    function image: NSImage; cdecl;
    function isLeaf: Boolean; cdecl;
    function isLoaded: Boolean; cdecl;
    procedure reset; cdecl;
    procedure setAlternateImage(newAltImage: NSImage); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setLeaf(flag: Boolean); cdecl;
    procedure setLoaded(flag: Boolean); cdecl;
  end;
  TNSBrowserCell = class(TOCGenericImport<NSBrowserCellClass, NSBrowserCell>)  end;

  NSApplicationClass = interface(NSResponderClass)
    ['{77F2A389-04B0-4E8D-A5B7-89DB641BCBC4}']
    {class} procedure detachDrawingThread(selector: SEL; toTarget: Pointer; withObject: Pointer); cdecl;
    {class} function sharedApplication: Pointer; cdecl;
  end;
  NSApplication = interface(NSResponder)
    ['{460DBCB0-08C5-4E44-BAC8-46B49832D4C7}']
    procedure abortModal; cdecl;
    procedure activateContextHelpMode(sender: Pointer); cdecl;
    procedure activateIgnoringOtherApps(flag: Boolean); cdecl;
    function activationPolicy: NSApplicationActivationPolicy; cdecl;
    procedure addWindowsItem(win: NSWindow; title: NSString; filename: Boolean); cdecl;
    procedure application(sender: NSApplication; printFiles: NSArray); cdecl;
    function applicationIconImage: NSImage; cdecl;
    procedure arrangeInFront(sender: Pointer); cdecl;
    function beginModalSessionForWindow(theWindow: NSWindow): NSModalSession; cdecl; overload;
    function beginModalSessionForWindow(theWindow: NSWindow; relativeToWindow: NSWindow): NSModalSession; cdecl; overload;
    procedure beginSheet(sheet: NSWindow; modalForWindow: NSWindow; modalDelegate: Pointer; didEndSelector: SEL; contextInfo: Pointer); cdecl;
    procedure cancelUserAttentionRequest(request: NSInteger); cdecl;
    procedure changeWindowsItem(win: NSWindow; title: NSString; filename: Boolean); cdecl;
    function context: NSGraphicsContext; cdecl;
    function currentEvent: NSEvent; cdecl;
    function currentSystemPresentationOptions: NSApplicationPresentationOptions; cdecl;
    procedure deactivate; cdecl;
    function delegate: NSApplicationDelegate; cdecl;
    procedure discardEventsMatchingMask(mask: NSUInteger; beforeEvent: NSEvent); cdecl;
    function dockTile: NSDockTile; cdecl;
    procedure endModalSession(session: NSModalSession); cdecl;
    procedure endSheet(sheet: NSWindow); cdecl; overload;
    procedure endSheet(sheet: NSWindow; returnCode: NSInteger); cdecl; overload;
    procedure finishLaunching; cdecl;
    function helpMenu: NSMenu; cdecl;
    procedure hide(sender: Pointer); cdecl;
    procedure hideOtherApplications(sender: Pointer); cdecl;
    function isActive: Boolean; cdecl;
    function isFullKeyboardAccessEnabled: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isRunning: Boolean; cdecl;
    function keyWindow: NSWindow; cdecl;
    function mainMenu: NSMenu; cdecl;
    function mainWindow: NSWindow; cdecl;
    function makeWindowsPerform(aSelector: SEL; inOrder: Boolean): NSWindow; cdecl;
    procedure miniaturizeAll(sender: Pointer); cdecl;
    function modalWindow: NSWindow; cdecl;
    function nextEventMatchingMask(mask: NSInteger; untilDate: NSDate; inMode: NSString; dequeue: Boolean): NSEvent; cdecl;
    procedure orderFrontCharacterPalette(sender: Pointer); cdecl;
    procedure orderFrontColorPanel(sender: Pointer); cdecl;
    procedure orderFrontStandardAboutPanel(sender: Pointer); cdecl;
    procedure orderFrontStandardAboutPanelWithOptions(optionsDictionary: NSDictionary); cdecl;
    function orderedDocuments: NSArray; cdecl;
    function orderedWindows: NSArray; cdecl;
    procedure postEvent(event: NSEvent; atStart: Boolean); cdecl;
    function presentationOptions: NSApplicationPresentationOptions; cdecl;
    procedure preventWindowOrdering; cdecl;
    procedure registerServicesMenuSendTypes(sendTypes: NSArray; returnTypes: NSArray); cdecl;
    procedure registerUserInterfaceItemSearchHandler(handler: Pointer); cdecl;
    procedure removeWindowsItem(win: NSWindow); cdecl;
    procedure replyToApplicationShouldTerminate(shouldTerminate: Boolean); cdecl;
    procedure replyToOpenOrPrint(reply: NSApplicationDelegateReply); cdecl;
    procedure reportException(theException: NSException); cdecl;
    function requestUserAttention(requestType: NSRequestUserAttentionType): NSInteger; cdecl;
    procedure run; cdecl;
    function runModalForWindow(theWindow: NSWindow): NSInteger; cdecl; overload;
    function runModalForWindow(theWindow: NSWindow; relativeToWindow: NSWindow): NSInteger; cdecl; overload;
    function runModalSession(session: NSModalSession): NSInteger; cdecl;
    procedure runPageLayout(sender: Pointer); cdecl;
    function searchString(searchString: NSString; inUserInterfaceItemString: NSString; searchRange: NSRange; foundRange: PNSRange): Boolean; cdecl;
    procedure sendEvent(theEvent: NSEvent); cdecl;
    function servicesMenu: NSMenu; cdecl;
    function servicesProvider: Pointer; cdecl;
    function setActivationPolicy(activationPolicy: NSApplicationActivationPolicy): Boolean; cdecl;
    procedure setApplicationIconImage(image: NSImage); cdecl;
    procedure setDelegate(anObject: NSApplicationDelegate); cdecl;
    procedure setHelpMenu(helpMenu: NSMenu); cdecl;
    procedure setMainMenu(aMenu: NSMenu); cdecl;
    procedure setPresentationOptions(newOptions: NSApplicationPresentationOptions); cdecl;
    procedure setServicesMenu(aMenu: NSMenu); cdecl;
    procedure setServicesProvider(provider: Pointer); cdecl;
    procedure setWindowsMenu(aMenu: NSMenu); cdecl;
    procedure setWindowsNeedUpdate(needUpdate: Boolean); cdecl;
    procedure showHelp(sender: Pointer); cdecl;
    procedure stop(sender: Pointer); cdecl;
    procedure stopModal; cdecl;
    procedure stopModalWithCode(returnCode: NSInteger); cdecl;
    function targetForAction(theAction: SEL): Pointer; cdecl; overload;
    procedure terminate(sender: Pointer); cdecl;
    procedure unhide(sender: Pointer); cdecl;
    procedure unhideAllApplications(sender: Pointer); cdecl;
    procedure unhideWithoutActivation; cdecl;
    procedure unregisterUserInterfaceItemSearchHandler(handler: Pointer); cdecl;
    procedure updateWindows; cdecl;
    procedure updateWindowsItem(win: NSWindow); cdecl;
    function userInterfaceLayoutDirection: NSUserInterfaceLayoutDirection; cdecl;
    function validRequestorForSendType(sendType: NSString; returnType: NSString): Pointer; cdecl;
    function windowWithWindowNumber(windowNum: NSInteger): NSWindow; cdecl;
    function windows: NSArray; cdecl;
    function windowsMenu: NSMenu; cdecl;
  end;
  TNSApplication = class(TOCGenericImport<NSApplicationClass, NSApplication>)  end;

  NSActionCellClass = interface(NSCellClass)
    ['{8F92A6C1-9474-47B1-BB4E-F982CD87A503}']
  end;
  NSActionCell = interface(NSCell)
    ['{6EE3735B-1E8A-451C-9B07-E841484BE989}']
    function action: SEL; cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setTag(anInt: NSInteger); cdecl;
    procedure setTarget(anObject: Pointer); cdecl;
    function tag: NSInteger; cdecl;
    function target: Pointer; cdecl;
  end;
  TNSActionCell = class(TOCGenericImport<NSActionCellClass, NSActionCell>)  end;

  NSATSTypesetterClass = interface(NSTypesetterClass)
    ['{146F4C9A-47C1-4894-898E-5F32A96EE88C}']
    {class} function sharedTypesetter: Pointer; cdecl;
  end;
  NSATSTypesetter = interface(NSTypesetter)
    ['{83F74449-2325-4F91-96EA-05F5130604CD}']
    function lineFragmentRectForProposedRect(proposedRect: NSRect; remainingRect: NSRectPointer): NSRect; cdecl;
  end;
  TNSATSTypesetter = class(TOCGenericImport<NSATSTypesetterClass, NSATSTypesetter>)  end;

  NSWindowClass = interface(NSResponderClass)
    ['{DDED7F36-66D2-4057-ADA7-5E7019B17753}']
    {class} function contentRectForFrameRect(fRect: NSRect; styleMask: NSUInteger): NSRect; cdecl; overload;
    {class} function defaultDepthLimit: NSWindowDepth; cdecl;
    {class} function frameRectForContentRect(cRect: NSRect; styleMask: NSUInteger): NSRect; cdecl; overload;
    {class} procedure menuChanged(menu: NSMenu); cdecl;
    {class} function minFrameWidthWithTitle(aTitle: NSString; styleMask: NSUInteger): Single; cdecl;
    {class} procedure removeFrameUsingName(name: NSString); cdecl;
    {class} function standardWindowButton(b: NSWindowButton; forStyleMask: NSUInteger): NSButton; cdecl; overload;
    {class} function windowNumberAtPoint(point: NSPoint; belowWindowWithWindowNumber: NSInteger): NSInteger; cdecl;
    {class} function windowNumbersWithOptions(options: NSWindowNumberListOptions): NSArray; cdecl;
  end;
  NSWindow = interface(NSResponder)
    ['{8CDBAC20-6E46-4618-A33F-229394B70A6D}']
    function acceptsMouseMovedEvents: Boolean; cdecl;
    procedure addChildWindow(childWin: NSWindow; ordered: NSWindowOrderingMode); cdecl;
    function allowsConcurrentViewDrawing: Boolean; cdecl;
    function allowsToolTipsWhenApplicationIsInactive: Boolean; cdecl;
    function alphaValue: Single; cdecl;
    function animationResizeTime(newFrame: NSRect): NSTimeInterval; cdecl;
    function areCursorRectsEnabled: Boolean; cdecl;
    function aspectRatio: NSSize; cdecl;
    function attachedSheet: NSWindow; cdecl;
    function autorecalculatesContentBorderThicknessForEdge(edge: NSRectEdge): Boolean; cdecl;
    function autorecalculatesKeyViewLoop: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function backingLocation: NSWindowBackingLocation; cdecl;
    function backingType: NSBackingStoreType; cdecl;
    function backingScaleFactor: CGFloat; cdecl; // OS X 10.7+
    procedure becomeKeyWindow; cdecl;
    procedure becomeMainWindow; cdecl;
    procedure cacheImageInRect(aRect: NSRect); cdecl;
    function canBeVisibleOnAllSpaces: Boolean; cdecl;
    function canBecomeKeyWindow: Boolean; cdecl;
    function canBecomeMainWindow: Boolean; cdecl;
    function canBecomeVisibleWithoutLogin: Boolean; cdecl;
    function canHide: Boolean; cdecl;
    function canStoreColor: Boolean; cdecl;
    function cascadeTopLeftFromPoint(topLeftPoint: NSPoint): NSPoint; cdecl;
    procedure center; cdecl;
    function childWindows: NSArray; cdecl;
    procedure close; cdecl;
    function collectionBehavior: NSWindowCollectionBehavior; cdecl;
    function colorSpace: NSColorSpace; cdecl;
    function constrainFrameRect(frameRect: NSRect; toScreen: NSScreen): NSRect; cdecl;
    function contentAspectRatio: NSSize; cdecl;
    function contentBorderThicknessForEdge(edge: NSRectEdge): Single; cdecl;
    function contentMaxSize: NSSize; cdecl;
    function contentMinSize: NSSize; cdecl;
    function contentRectForFrameRect(frameRect: NSRect): NSRect; cdecl; overload;
    function contentResizeIncrements: NSSize; cdecl;
    function contentView: Pointer; cdecl;
    function convertBaseToScreen(aPoint: NSPoint): NSPoint; cdecl;
    function convertScreenToBase(aPoint: NSPoint): NSPoint; cdecl;
    function currentEvent: NSEvent; cdecl;
    function dataWithEPSInsideRect(rect: NSRect): NSData; cdecl;
    function dataWithPDFInsideRect(rect: NSRect): NSData; cdecl;
    function deepestScreen: NSScreen; cdecl;
    function defaultButtonCell: NSButtonCell; cdecl;
    function delegate: NSWindowDelegate; cdecl;
    procedure deminiaturize(sender: Pointer); cdecl;
    function depthLimit: NSWindowDepth; cdecl;
    function deviceDescription: NSDictionary; cdecl;
    procedure disableCursorRects; cdecl;
    procedure disableFlushWindow; cdecl;
    procedure disableKeyEquivalentForDefaultButtonCell; cdecl;
    procedure disableScreenUpdatesUntilFlush; cdecl;
    procedure discardCachedImage; cdecl;
    procedure discardCursorRects; cdecl;
    procedure discardEventsMatchingMask(mask: NSUInteger; beforeEvent: NSEvent); cdecl;
    procedure display; cdecl;
    procedure displayIfNeeded; cdecl;
    function displaysWhenScreenProfileChanges: Boolean; cdecl;
    function dockTile: NSDockTile; cdecl;
    procedure dragImage(anImage: NSImage; at: NSPoint; offset: NSSize; event: NSEvent; pasteboard: NSPasteboard; source: Pointer; slideBack: Boolean); cdecl;
    function drawers: NSArray; cdecl;
    procedure enableCursorRects; cdecl;
    procedure enableFlushWindow; cdecl;
    procedure enableKeyEquivalentForDefaultButtonCell; cdecl;
    procedure endEditingFor(anObject: Pointer); cdecl;
    function fieldEditor(createFlag: Boolean; forObject: Pointer): NSText; cdecl;
    function firstResponder: NSResponder; cdecl;
    procedure flushWindow; cdecl;
    procedure flushWindowIfNeeded; cdecl;
    function frame: NSRect; cdecl;
    function frameAutosaveName: NSString; cdecl;
    function frameRectForContentRect(contentRect: NSRect): NSRect; cdecl; overload;
    function gState: NSInteger; cdecl;
    function graphicsContext: NSGraphicsContext; cdecl;
    function handleCloseScriptCommand(command: NSCloseCommand): Pointer; cdecl;
    function handlePrintScriptCommand(command: NSScriptCommand): Pointer; cdecl;
    function handleSaveScriptCommand(command: NSScriptCommand): Pointer; cdecl;
    function hasCloseBox: Boolean; cdecl;
    function hasDynamicDepthLimit: Boolean; cdecl;
    function hasShadow: Boolean; cdecl;
    function hasTitleBar: Boolean; cdecl;
    function hidesOnDeactivate: Boolean; cdecl;
    function ignoresMouseEvents: Boolean; cdecl;
    function inLiveResize: Boolean; cdecl;
    function initWithContentRect(contentRect: NSRect; styleMask: NSUInteger; backing: NSBackingStoreType; defer: Boolean): Pointer; cdecl; overload;
    function initWithContentRect(contentRect: NSRect; styleMask: NSUInteger; backing: NSBackingStoreType; defer: Boolean; screen: NSScreen): Pointer; cdecl; overload;
    function initWithWindowRef(windowRef: Pointer): NSWindow; cdecl;
    function initialFirstResponder: NSView; cdecl;
    procedure invalidateCursorRectsForView(aView: NSView); cdecl;
    procedure invalidateShadow; cdecl;
    function isAutodisplay: Boolean; cdecl;
    function isDocumentEdited: Boolean; cdecl;
    function isExcludedFromWindowsMenu: Boolean; cdecl;
    function isFloatingPanel: Boolean; cdecl;
    function isFlushWindowDisabled: Boolean; cdecl;
    function isKeyWindow: Boolean; cdecl;
    function isMainWindow: Boolean; cdecl;
    function isMiniaturizable: Boolean; cdecl;
    function isMiniaturized: Boolean; cdecl;
    function isModalPanel: Boolean; cdecl;
    function isMovable: Boolean; cdecl;
    function isMovableByWindowBackground: Boolean; cdecl;
    function isOnActiveSpace: Boolean; cdecl;
    function isOneShot: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isReleasedWhenClosed: Boolean; cdecl;
    function isResizable: Boolean; cdecl;
    function isSheet: Boolean; cdecl;
    function isVisible: Boolean; cdecl;
    function isZoomable: Boolean; cdecl;
    function isZoomed: Boolean; cdecl;
    procedure keyDown(theEvent: NSEvent); cdecl;
    function keyViewSelectionDirection: NSSelectionDirection; cdecl;
    function level: NSInteger; cdecl;
    function makeFirstResponder(aResponder: NSResponder): Boolean; cdecl;
    procedure makeKeyAndOrderFront(sender: Pointer); cdecl;
    procedure makeKeyWindow; cdecl;
    procedure makeMainWindow; cdecl;
    function maxSize: NSSize; cdecl;
    function minSize: NSSize; cdecl;
    procedure miniaturize(sender: Pointer); cdecl;
    function miniwindowImage: NSImage; cdecl;
    function miniwindowTitle: NSString; cdecl;
    function mouseLocationOutsideOfEventStream: NSPoint; cdecl;
    function nextEventMatchingMask(mask: NSUInteger): NSEvent; cdecl; overload;
    function nextEventMatchingMask(mask: NSUInteger; untilDate: NSDate; inMode: NSString; dequeue: Boolean): NSEvent; cdecl; overload;
    procedure orderBack(sender: Pointer); cdecl;
    procedure orderFront(sender: Pointer); cdecl;
    procedure orderFrontRegardless; cdecl;
    procedure orderOut(sender: Pointer); cdecl;
    procedure orderWindow(place: NSWindowOrderingMode; relativeTo: NSInteger); cdecl;
    function orderedIndex: NSInteger; cdecl;
    function parentWindow: NSWindow; cdecl;
    procedure performClose(sender: Pointer); cdecl;
    procedure performMiniaturize(sender: Pointer); cdecl;
    procedure performZoom(sender: Pointer); cdecl;
    procedure postEvent(event: NSEvent; atStart: Boolean); cdecl;
    function preferredBackingLocation: NSWindowBackingLocation; cdecl;
    function preservesContentDuringLiveResize: Boolean; cdecl;
    function preventsApplicationTerminationWhenModal: Boolean; cdecl;
    procedure print(sender: Pointer); cdecl;
    procedure recalculateKeyViewLoop; cdecl;
    procedure registerForDraggedTypes(newTypes: NSArray); cdecl;
    procedure removeChildWindow(childWin: NSWindow); cdecl;
    function representedFilename: NSString; cdecl;
    function representedURL: NSURL; cdecl;
    procedure resetCursorRects; cdecl;
    procedure resignKeyWindow; cdecl;
    procedure resignMainWindow; cdecl;
    function resizeFlags: NSInteger; cdecl;
    function resizeIncrements: NSSize; cdecl;
    procedure restoreCachedImage; cdecl;
    procedure runToolbarCustomizationPalette(sender: Pointer); cdecl;
    procedure saveFrameUsingName(name: NSString); cdecl;
    function screen: NSScreen; cdecl;
    procedure selectKeyViewFollowingView(aView: NSView); cdecl;
    procedure selectKeyViewPrecedingView(aView: NSView); cdecl;
    procedure selectNextKeyView(sender: Pointer); cdecl;
    procedure selectPreviousKeyView(sender: Pointer); cdecl;
    procedure sendEvent(theEvent: NSEvent); cdecl;
    procedure setAcceptsMouseMovedEvents(flag: Boolean); cdecl;
    procedure setAllowsConcurrentViewDrawing(flag: Boolean); cdecl;
    procedure setAllowsToolTipsWhenApplicationIsInactive(allowWhenInactive: Boolean); cdecl;
    procedure setAlphaValue(windowAlpha: Single); cdecl;
    procedure setAspectRatio(ratio: NSSize); cdecl;
    procedure setAutodisplay(flag: Boolean); cdecl;
    procedure setAutorecalculatesContentBorderThickness(flag: Boolean; forEdge: NSRectEdge); cdecl;
    procedure setAutorecalculatesKeyViewLoop(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBackingType(bufferingType: NSBackingStoreType); cdecl;
    procedure setCanBeVisibleOnAllSpaces(flag: Boolean); cdecl;
    procedure setCanBecomeVisibleWithoutLogin(flag: Boolean); cdecl;
    procedure setCanHide(flag: Boolean); cdecl;
    procedure setCollectionBehavior(behavior: NSWindowCollectionBehavior); cdecl;
    procedure setColorSpace(colorSpace: NSColorSpace); cdecl;
    procedure setContentAspectRatio(ratio: NSSize); cdecl;
    procedure setContentBorderThickness(thickness: Single; forEdge: NSRectEdge); cdecl;
    procedure setContentMaxSize(size: NSSize); cdecl;
    procedure setContentMinSize(size: NSSize); cdecl;
    procedure setContentResizeIncrements(increments: NSSize); cdecl;
    procedure setContentSize(aSize: NSSize); cdecl;
    procedure setContentView(aView: NSView); cdecl;
    procedure setDefaultButtonCell(defButt: NSButtonCell); cdecl;
    procedure setDelegate(anObject: NSWindowDelegate); cdecl;
    procedure setDepthLimit(limit: NSWindowDepth); cdecl;
    procedure setDisplaysWhenScreenProfileChanges(flag: Boolean); cdecl;
    procedure setDocumentEdited(flag: Boolean); cdecl;
    procedure setDynamicDepthLimit(flag: Boolean); cdecl;
    procedure setExcludedFromWindowsMenu(flag: Boolean); cdecl;
    procedure setFrame(frameRect: NSRect; display: Boolean); cdecl; overload;
    procedure setFrame(frameRect: NSRect; display: Boolean; animate: Boolean); cdecl; overload;
    function setFrameAutosaveName(name: NSString): Boolean; cdecl;
    procedure setFrameFromString(string_: NSString); cdecl;
    procedure setFrameOrigin(aPoint: NSPoint); cdecl;
    procedure setFrameTopLeftPoint(aPoint: NSPoint); cdecl;
    function setFrameUsingName(name: NSString): Boolean; cdecl; overload;
    function setFrameUsingName(name: NSString; force: Boolean): Boolean; cdecl; overload;
    procedure setHasShadow(hasShadow: Boolean); cdecl;
    procedure setHidesOnDeactivate(flag: Boolean); cdecl;
    procedure setIgnoresMouseEvents(flag: Boolean); cdecl;
    procedure setInitialFirstResponder(view: NSView); cdecl;
    procedure setIsMiniaturized(flag: Boolean); cdecl;
    procedure setIsVisible(flag: Boolean); cdecl;
    procedure setIsZoomed(flag: Boolean); cdecl;
    procedure setLevel(newLevel: NSInteger); cdecl;
    procedure setMaxSize(size: NSSize); cdecl;
    procedure setMinSize(size: NSSize); cdecl;
    procedure setMiniwindowImage(image: NSImage); cdecl;
    procedure setMiniwindowTitle(title: NSString); cdecl;
    procedure setMovable(flag: Boolean); cdecl;
    procedure setMovableByWindowBackground(flag: Boolean); cdecl;
    procedure setOneShot(flag: Boolean); cdecl;
    procedure setOpaque(isOpaque: Boolean); cdecl;
    procedure setOrderedIndex(index: NSInteger); cdecl;
    procedure setParentWindow(window: NSWindow); cdecl;
    procedure setPreferredBackingLocation(backingLocation: NSWindowBackingLocation); cdecl;
    procedure setPreservesContentDuringLiveResize(flag: Boolean); cdecl;
    procedure setPreventsApplicationTerminationWhenModal(flag: Boolean); cdecl;
    procedure setReleasedWhenClosed(flag: Boolean); cdecl;
    procedure setRepresentedFilename(aString: NSString); cdecl;
    procedure setRepresentedURL(url: NSURL); cdecl;
    procedure setResizeIncrements(increments: NSSize); cdecl;
    procedure setSharingType(type_: NSWindowSharingType); cdecl;
    procedure setShowsResizeIndicator(show: Boolean); cdecl;
    procedure setShowsToolbarButton(show: Boolean); cdecl;
    procedure setStyleMask(styleMask: NSUInteger); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleWithRepresentedFilename(filename: NSString); cdecl;
    procedure setToolbar(toolbar: NSToolbar); cdecl;
    procedure setViewsNeedDisplay(flag: Boolean); cdecl;
    procedure setWindowController(windowController: NSWindowController); cdecl;
    function sharingType: NSWindowSharingType; cdecl;
    function showsResizeIndicator: Boolean; cdecl;
    function showsToolbarButton: Boolean; cdecl;
    function standardWindowButton(b: NSWindowButton): NSButton; cdecl; overload;
    function stringWithSavedFrame: NSString; cdecl;
    function styleMask: NSUInteger; cdecl;
    function title: NSString; cdecl;
    procedure toggleToolbarShown(sender: Pointer); cdecl;
    procedure toggleFullScreen(sender: Pointer); cdecl;
    function toolbar: NSToolbar; cdecl;
    procedure unregisterDraggedTypes; cdecl;
    procedure update; cdecl;
    procedure useOptimizedDrawing(flag: Boolean); cdecl;
    function userSpaceScaleFactor: Single; cdecl;
    function validRequestorForSendType(sendType: NSString; returnType: NSString): Pointer; cdecl;
    function viewsNeedDisplay: Boolean; cdecl;
    function windowController: Pointer; cdecl;
    function windowNumber: NSInteger; cdecl;
    function windowRef: Pointer; cdecl;
    function worksWhenModal: Boolean; cdecl;
    procedure zoom(sender: Pointer); cdecl;
  end;
  TNSWindow = class(TOCGenericImport<NSWindowClass, NSWindow>)  end;

  NSWindowControllerClass = interface(NSResponderClass)
    ['{5B7EA974-9532-434C-9129-F5C43546F987}']
  end;
  NSWindowController = interface(NSResponder)
    ['{8AD4042A-58ED-482B-B5C2-E37F6E46EAB6}']
    procedure close; cdecl;
    function document: Pointer; cdecl;
    function initWithWindow(window: NSWindow): Pointer; cdecl;
    function initWithWindowNibName(windowNibName: NSString): Pointer; cdecl; overload;
    function initWithWindowNibName(windowNibName: NSString; owner: Pointer): Pointer; cdecl; overload;
    function initWithWindowNibPath(windowNibPath: NSString; owner: Pointer): Pointer; cdecl;
    function isWindowLoaded: Boolean; cdecl;
    procedure loadWindow; cdecl;
    function owner: Pointer; cdecl;
    procedure setDocument(document: NSDocument); cdecl;
    procedure setDocumentEdited(dirtyFlag: Boolean); cdecl;
    procedure setShouldCascadeWindows(flag: Boolean); cdecl;
    procedure setShouldCloseDocument(flag: Boolean); cdecl;
    procedure setWindow(window: NSWindow); cdecl;
    procedure setWindowFrameAutosaveName(name: NSString); cdecl;
    function shouldCascadeWindows: Boolean; cdecl;
    function shouldCloseDocument: Boolean; cdecl;
    procedure showWindow(sender: Pointer); cdecl;
    procedure synchronizeWindowTitleWithDocumentName; cdecl;
    function window: NSWindow; cdecl;
    procedure windowDidLoad; cdecl;
    function windowFrameAutosaveName: NSString; cdecl;
    function windowNibName: NSString; cdecl;
    function windowNibPath: NSString; cdecl;
    function windowTitleForDocumentDisplayName(displayName: NSString): NSString; cdecl;
    procedure windowWillLoad; cdecl;
  end;
  TNSWindowController = class(TOCGenericImport<NSWindowControllerClass, NSWindowController>)  end;

  NSBitmapImageRepClass = interface(NSImageRepClass)
    ['{D21ECC8A-B6C7-41B5-81C6-B652E0F24F21}']
    {class} function TIFFRepresentationOfImageRepsInArray(array_: NSArray): NSData; cdecl; overload;
    {class} function TIFFRepresentationOfImageRepsInArray(array_: NSArray; usingCompression: NSTIFFCompression; factor: Single): NSData; cdecl; overload;
    {class} procedure getTIFFCompressionTypes(list: PNSTIFFCompression; count: NSInteger); cdecl;
    {class} function imageRepWithData(data: NSData): Pointer; cdecl;
    {class} function imageRepsWithData(data: NSData): NSArray; cdecl;
    {class} function localizedNameForTIFFCompressionType(compression: NSTIFFCompression): NSString; cdecl;
    {class} function representationOfImageRepsInArray(imageReps: NSArray; usingType: NSBitmapImageFileType; properties: NSDictionary): NSData; cdecl;
  end;
  NSBitmapImageRep = interface(NSImageRep)
    ['{CAA73118-CB84-44E6-9911-6626BD22FF99}']
    function CGImage: CGImageRef; cdecl;
    function TIFFRepresentation: NSData; cdecl;
    function TIFFRepresentationUsingCompression(comp: NSTIFFCompression; factor: Single): NSData; cdecl;
    function bitmapData: PByte; cdecl;
    function bitmapFormat: NSBitmapFormat; cdecl;
    function bitmapImageRepByConvertingToColorSpace(targetSpace: NSColorSpace; renderingIntent: NSColorRenderingIntent): NSBitmapImageRep; cdecl;
    function bitmapImageRepByRetaggingWithColorSpace(newSpace: NSColorSpace): NSBitmapImageRep; cdecl;
    function bitsPerPixel: NSInteger; cdecl;
    function bytesPerPlane: NSInteger; cdecl;
    function bytesPerRow: NSInteger; cdecl;
    function canBeCompressedUsing(compression: NSTIFFCompression): Boolean; cdecl;
    function colorAtX(x: NSInteger; y: NSInteger): NSColor; cdecl;
    function colorSpace: NSColorSpace; cdecl;
    procedure colorizeByMappingGray(midPoint: Single; toColor: NSColor; blackMapping: NSColor; whiteMapping: NSColor); cdecl;
    procedure getBitmapDataPlanes(data: PByte); cdecl;
    procedure getCompression(compression: PNSTIFFCompression; factor: PSingle); cdecl;
    procedure getPixel(p: NSUInteger; atX: NSInteger; y: NSInteger); cdecl;
    function incrementalLoadFromData(data: NSData; complete: Boolean): NSInteger; cdecl;
    function initForIncrementalLoad: Pointer; cdecl;
    function initWithBitmapDataPlanes(planes: PByte; pixelsWide: NSInteger; pixelsHigh: NSInteger; bitsPerSample: NSInteger; samplesPerPixel: NSInteger; hasAlpha: Boolean; isPlanar: Boolean; colorSpaceName: NSString; bitmapFormat: NSBitmapFormat; bytesPerRow: NSInteger; bitsPerPixel: NSInteger): Pointer; cdecl; overload;
    function initWithBitmapDataPlanes(planes: PByte; pixelsWide: NSInteger; pixelsHigh: NSInteger; bitsPerSample: NSInteger; samplesPerPixel: NSInteger; hasAlpha: Boolean; isPlanar: Boolean; colorSpaceName: NSString; bytesPerRow: NSInteger; bitsPerPixel: NSInteger): Pointer; cdecl; overload;
    function initWithCGImage(cgImage: CGImageRef): Pointer; cdecl;
    function initWithCIImage(ciImage: CIImage): Pointer; cdecl;
    function initWithData(data: NSData): Pointer; cdecl;
    function initWithFocusedViewRect(rect: NSRect): Pointer; cdecl;
    function isPlanar: Boolean; cdecl;
    function numberOfPlanes: NSInteger; cdecl;
    function representationUsingType(storageType: NSBitmapImageFileType; properties: NSDictionary): NSData; cdecl;
    function samplesPerPixel: NSInteger; cdecl;
    procedure setColor(color: NSColor; atX: NSInteger; y: NSInteger); cdecl;
    procedure setCompression(compression: NSTIFFCompression; factor: Single); cdecl;
    procedure setPixel(p: NSUInteger; atX: NSInteger; y: NSInteger); cdecl;
    procedure setProperty(property_: NSString; withValue: Pointer); cdecl;
    function valueForProperty(property_: NSString): Pointer; cdecl;
  end;
  TNSBitmapImageRep = class(TOCGenericImport<NSBitmapImageRepClass, NSBitmapImageRep>)  end;

  NSCustomImageRepClass = interface(NSImageRepClass)
    ['{3E3ADA33-103D-4B79-84ED-8A49C7BB675E}']
  end;
  NSCustomImageRep = interface(NSImageRep)
    ['{3E35D8E3-F7F9-480B-B5BD-B18A83332134}']
    function delegate: Pointer; cdecl;
    function drawSelector: SEL; cdecl;
    function initWithDrawSelector(aMethod: SEL; delegate: Pointer): Pointer; cdecl;
  end;
  TNSCustomImageRep = class(TOCGenericImport<NSCustomImageRepClass, NSCustomImageRep>)  end;

  NSToolbarItemGroupClass = interface(NSToolbarItemClass)
    ['{BC9762F8-D3B9-4CFC-A7C6-00FFCE1DCAEC}']
  end;
  NSToolbarItemGroup = interface(NSToolbarItem)
    ['{0DA6F148-9612-4D69-B6C4-6F7480556EA0}']
    procedure setSubitems(subitems: NSArray); cdecl;
    function subitems: NSArray; cdecl;
  end;
  TNSToolbarItemGroup = class(TOCGenericImport<NSToolbarItemGroupClass, NSToolbarItemGroup>)  end;
 
  NSNibControlConnectorClass = interface(NSNibConnectorClass)
    ['{C7A2D2D1-47A0-43F6-AA73-5CA986A6E5DD}']
  end;
  NSNibControlConnector = interface(NSNibConnector)
    ['{6263DFD9-316E-428C-A329-1824CCD195D7}']
    procedure establishConnection; cdecl;
  end;
  TNSNibControlConnector = class(TOCGenericImport<NSNibControlConnectorClass, NSNibControlConnector>)  end;

  NSMutableParagraphStyleClass = interface(NSParagraphStyleClass)
    ['{F3CD4FD7-26EC-4055-9937-652B38D47C58}']
  end;
  NSMutableParagraphStyle = interface(NSParagraphStyle)
    ['{038D286A-357F-4588-966D-120A616CC54A}']
    procedure addTabStop(anObject: NSTextTab); cdecl;
    procedure removeTabStop(anObject: NSTextTab); cdecl;
    procedure setAlignment(alignment: NSTextAlignment); cdecl;
    procedure setBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setDefaultTabInterval(aFloat: Single); cdecl;
    procedure setFirstLineHeadIndent(aFloat: Single); cdecl;
    procedure setHeadIndent(aFloat: Single); cdecl;
    procedure setHeaderLevel(level: NSInteger); cdecl;
    procedure setHyphenationFactor(aFactor: Single); cdecl;
    procedure setLineBreakMode(mode: NSLineBreakMode); cdecl;
    procedure setLineHeightMultiple(aFloat: Single); cdecl;
    procedure setLineSpacing(aFloat: Single); cdecl;
    procedure setMaximumLineHeight(aFloat: Single); cdecl;
    procedure setMinimumLineHeight(aFloat: Single); cdecl;
    procedure setParagraphSpacing(aFloat: Single); cdecl;
    procedure setParagraphSpacingBefore(aFloat: Single); cdecl;
    procedure setParagraphStyle(obj: NSParagraphStyle); cdecl;
    procedure setTabStops(array_: NSArray); cdecl;
    procedure setTailIndent(aFloat: Single); cdecl;
    procedure setTextBlocks(array_: NSArray); cdecl;
    procedure setTextLists(array_: NSArray); cdecl;
    procedure setTighteningFactorForTruncation(aFactor: Single); cdecl;
  end;
  TNSMutableParagraphStyle = class(TOCGenericImport<NSMutableParagraphStyleClass, NSMutableParagraphStyle>)  end;

  NSTextTableClass = interface(NSTextBlockClass)
    ['{27870908-E426-49D4-9644-C69E69AA491B}']
  end;
  NSTextTable = interface(NSTextBlock)
    ['{40A38626-DC5B-43C7-B481-670CEE0F987E}']
    function boundsRectForBlock(block: NSTextTableBlock; contentRect: NSRect; inRect: NSRect; textContainer: NSTextContainer; characterRange: NSRange): NSRect; cdecl;
    function collapsesBorders: Boolean; cdecl;
    procedure drawBackgroundForBlock(block: NSTextTableBlock; withFrame: NSRect; inView: NSView; characterRange: NSRange; layoutManager: NSLayoutManager); cdecl;
    function hidesEmptyCells: Boolean; cdecl;
    function layoutAlgorithm: NSTextTableLayoutAlgorithm; cdecl;
    function numberOfColumns: NSUInteger; cdecl;
    function rectForBlock(block: NSTextTableBlock; layoutAtPoint: NSPoint; inRect: NSRect; textContainer: NSTextContainer; characterRange: NSRange): NSRect; cdecl;
    procedure setCollapsesBorders(flag: Boolean); cdecl;
    procedure setHidesEmptyCells(flag: Boolean); cdecl;
    procedure setLayoutAlgorithm(algorithm: NSTextTableLayoutAlgorithm); cdecl;
    procedure setNumberOfColumns(numCols: NSUInteger); cdecl;
  end;
  TNSTextTable = class(TOCGenericImport<NSTextTableClass, NSTextTable>)  end;

  NSTextTableBlockClass = interface(NSTextBlockClass)
    ['{3E1F4FB5-540F-4A2C-8569-A98F3A1D46B2}']
  end;
  NSTextTableBlock = interface(NSTextBlock)
    ['{83A1F4E8-30BC-4862-A3D6-CDBCCC1583E2}']
    function columnSpan: NSInteger; cdecl;
    function initWithTable(table: NSTextTable; startingRow: NSInteger; rowSpan: NSInteger; startingColumn: NSInteger; columnSpan: NSInteger): Pointer; cdecl;
    function rowSpan: NSInteger; cdecl;
    function startingColumn: NSInteger; cdecl;
    function startingRow: NSInteger; cdecl;
    function table: NSTextTable; cdecl;
  end;
  TNSTextTableBlock = class(TOCGenericImport<NSTextTableBlockClass, NSTextTableBlock>)  end;

  NSEPSImageRepClass = interface(NSImageRepClass)
    ['{9950869B-E57B-49CC-AAEA-67E259A8C33E}']
    {class} function imageRepWithData(epsData: NSData): Pointer; cdecl;
  end;
  NSEPSImageRep = interface(NSImageRep)
    ['{9AA5C335-DFFA-4303-BE99-917533A687FB}']
    function EPSRepresentation: NSData; cdecl;
    function boundingBox: NSRect; cdecl;
    function initWithData(epsData: NSData): Pointer; cdecl;
    procedure prepareGState; cdecl;
  end;
  TNSEPSImageRep = class(TOCGenericImport<NSEPSImageRepClass, NSEPSImageRep>)  end;

  NSImageCellClass = interface(NSCellClass)
    ['{9349E98B-63D2-44B0-B78B-BF6B5F22F706}']
  end;
  NSImageCell = interface(NSCell)
    ['{7EE3BC5C-518A-4FDC-A943-13009F413E51}']
    function imageAlignment: NSImageAlignment; cdecl;
    function imageFrameStyle: NSImageFrameStyle; cdecl;
    function imageScaling: NSImageScaling; cdecl;
    procedure setImageAlignment(newAlign: NSImageAlignment); cdecl;
    procedure setImageFrameStyle(newStyle: NSImageFrameStyle); cdecl;
    procedure setImageScaling(newScaling: NSImageScaling); cdecl;
  end;
  TNSImageCell = class(TOCGenericImport<NSImageCellClass, NSImageCell>)  end;

  NSDrawerClass = interface(NSResponderClass)
    ['{29C248E9-9CCE-4488-9C91-2F388016CA8D}']
  end;
  NSDrawer = interface(NSResponder)
    ['{9D8FC18A-BE22-44A3-9739-155835E1C556}']
    procedure close; cdecl; overload;
    procedure close(sender: Pointer); cdecl; overload;
    function contentSize: NSSize; cdecl;
    function contentView: NSView; cdecl;
    function delegate: NSDrawerDelegate; cdecl;
    function edge: NSRectEdge; cdecl;
    function initWithContentSize(contentSize: NSSize; preferredEdge: NSRectEdge): Pointer; cdecl;
    function leadingOffset: Single; cdecl;
    function maxContentSize: NSSize; cdecl;
    function minContentSize: NSSize; cdecl;
    procedure open; cdecl; overload;
    procedure open(sender: Pointer); cdecl; overload;
    procedure openOnEdge(edge: NSRectEdge); cdecl;
    function parentWindow: NSWindow; cdecl;
    function preferredEdge: NSRectEdge; cdecl;
    procedure setContentSize(size: NSSize); cdecl;
    procedure setContentView(aView: NSView); cdecl;
    procedure setDelegate(anObject: NSDrawerDelegate); cdecl;
    procedure setLeadingOffset(offset: Single); cdecl;
    procedure setMaxContentSize(size: NSSize); cdecl;
    procedure setMinContentSize(size: NSSize); cdecl;
    procedure setParentWindow(parent: NSWindow); cdecl;
    procedure setPreferredEdge(edge: NSRectEdge); cdecl;
    procedure setTrailingOffset(offset: Single); cdecl;
    function state: NSInteger; cdecl;
    procedure toggle(sender: Pointer); cdecl;
    function trailingOffset: Single; cdecl;
  end;
  TNSDrawer = class(TOCGenericImport<NSDrawerClass, NSDrawer>)  end;

  NSNibOutletConnectorClass = interface(NSNibConnectorClass)
    ['{2AFE2821-17B4-40EA-884B-BDC22040C514}']
  end;
  NSNibOutletConnector = interface(NSNibConnector)
    ['{926FC5B4-07B9-482D-9F48-4A910635A258}']
    procedure establishConnection; cdecl;
  end;
  TNSNibOutletConnector = class(TOCGenericImport<NSNibOutletConnectorClass, NSNibOutletConnector>)  end;

  NSCachedImageRepClass = interface(NSImageRepClass)
    ['{D1B7B65D-CD6C-4233-BCED-79D873CA4602}']
  end;
  NSCachedImageRep = interface(NSImageRep)
    ['{C5445105-B892-42B5-B835-4DB1BBCBF724}']
    function initWithSize(size: NSSize; depth: NSWindowDepth; separate: Boolean; alpha: Boolean): Pointer; cdecl;
    function initWithWindow(win: NSWindow; rect: NSRect): Pointer; cdecl;
    function rect: NSRect; cdecl;
    function window: NSWindow; cdecl;
  end;
  TNSCachedImageRep = class(TOCGenericImport<NSCachedImageRepClass, NSCachedImageRep>)  end;

  NSPICTImageRepClass = interface(NSImageRepClass)
    ['{470888BC-E832-4E79-9140-A3B0431CB4FD}']
    {class} function imageRepWithData(pictData: NSData): Pointer; cdecl;
  end;
  NSPICTImageRep = interface(NSImageRep)
    ['{4D062111-8BF7-45C2-B4BC-F73F5987F8A7}']
    function PICTRepresentation: NSData; cdecl;
    function boundingBox: NSRect; cdecl;
    function initWithData(pictData: NSData): Pointer; cdecl;
  end;
  TNSPICTImageRep = class(TOCGenericImport<NSPICTImageRepClass, NSPICTImageRep>)  end;

  NSViewClass = interface(NSResponderClass)
    ['{B5D7C145-77C2-4826-B957-B8F2D7C01C9C}']
    {class} function defaultFocusRingType: NSFocusRingType; cdecl;
    {class} function defaultMenu: NSMenu; cdecl;
    {class} function focusView: Pointer; cdecl;
  end;
  NSView = interface(NSResponder)
    ['{607BF1EF-39B3-4440-B84F-C4EA8902ED43}']
    function acceptsFirstMouse(theEvent: NSEvent): Boolean; cdecl;
    function acceptsTouchEvents: Boolean; cdecl;
    procedure addCursorRect(aRect: NSRect; cursor: NSCursor); cdecl;
    procedure addSubview(aView: NSView); cdecl; overload;
    procedure addSubview(aView: NSView; positioned: NSWindowOrderingMode; relativeTo: NSView); cdecl; overload;
    function addToolTipRect(aRect: NSRect; owner: Pointer; userData: Pointer): NSToolTipTag; cdecl;
    procedure addTrackingArea(trackingArea: NSTrackingArea); cdecl;
    function addTrackingRect(aRect: NSRect; owner: Pointer; userData: Pointer; assumeInside: Boolean): NSTrackingRectTag; cdecl;
    procedure adjustPageHeightNew(newBottom: PSingle; top: Single; bottom: Single; limit: Single); cdecl;
    procedure adjustPageWidthNew(newRight: PSingle; left: Single; right: Single; limit: Single); cdecl;
    function adjustScroll(newVisible: NSRect): NSRect; cdecl;
    procedure allocateGState; cdecl;
    function alphaValue: Single; cdecl;
    function ancestorSharedWithView(aView: NSView): NSView; cdecl;
    function autoresizesSubviews: Boolean; cdecl;
    function autoresizingMask: NSUInteger; cdecl;
    function autoscroll(theEvent: NSEvent): Boolean; cdecl;
    function backgroundFilters: NSArray; cdecl;
    procedure beginDocument; cdecl;
    procedure beginPageInRect(aRect: NSRect; atPlacement: NSPoint); cdecl;
    function bitmapImageRepForCachingDisplayInRect(rect: NSRect): NSBitmapImageRep; cdecl;
    function bounds: NSRect; cdecl;
    function boundsRotation: Single; cdecl;
    procedure cacheDisplayInRect(rect: NSRect; toBitmapImageRep: NSBitmapImageRep); cdecl;
    function canBecomeKeyView: Boolean; cdecl;
    function canDraw: Boolean; cdecl;
    function canDrawConcurrently: Boolean; cdecl;
    function centerScanRect(aRect: NSRect): NSRect; cdecl;
    function compositingFilter: CIFilter; cdecl;
    function contentFilters: NSArray; cdecl;
    function convertPoint(aPoint: NSPoint; fromView: NSView): NSPoint; cdecl; overload;
//    function convertPoint(aPoint: NSPoint; toView: NSView): NSPoint; cdecl; overload;
    function convertPointFromBase(aPoint: NSPoint): NSPoint; cdecl;
    function convertPointToBase(aPoint: NSPoint): NSPoint; cdecl;
    function convertRect(aRect: NSRect; fromView: NSView): NSRect; cdecl; overload;
//    function convertRect(aRect: NSRect; toView: NSView): NSRect; cdecl; overload;
    function convertRectFromBase(aRect: NSRect): NSRect; cdecl;
    function convertRectToBase(aRect: NSRect): NSRect; cdecl;
    function convertSize(aSize: NSSize; fromView: NSView): NSSize; cdecl; overload;
//    function convertSize(aSize: NSSize; toView: NSView): NSSize; cdecl; overload;
    function convertSizeFromBase(aSize: NSSize): NSSize; cdecl;
    function convertSizeToBase(aSize: NSSize): NSSize; cdecl;
    function dataWithEPSInsideRect(rect: NSRect): NSData; cdecl;
    function dataWithPDFInsideRect(rect: NSRect): NSData; cdecl;
    procedure didAddSubview(subview: NSView); cdecl;
    procedure discardCursorRects; cdecl;
    procedure display; cdecl;
    procedure displayIfNeeded; cdecl;
    procedure displayIfNeededIgnoringOpacity; cdecl;
    procedure displayIfNeededInRect(rect: NSRect); cdecl;
    procedure displayIfNeededInRectIgnoringOpacity(rect: NSRect); cdecl;
    procedure displayRect(rect: NSRect); cdecl;
    procedure displayRectIgnoringOpacity(rect: NSRect); cdecl; overload;
    procedure displayRectIgnoringOpacity(aRect: NSRect; inContext: NSGraphicsContext); cdecl; overload;
    function dragFile(filename: NSString; fromRect: NSRect; slideBack: Boolean; event: NSEvent): Boolean; cdecl;
    procedure dragImage(anImage: NSImage; at: NSPoint; offset: NSSize; event: NSEvent; pasteboard: NSPasteboard; source: Pointer; slideBack: Boolean); cdecl;
    function dragPromisedFilesOfTypes(typeArray: NSArray; fromRect: NSRect; source: Pointer; slideBack: Boolean; event: NSEvent): Boolean; cdecl;
    procedure drawPageBorderWithSize(borderSize: NSSize); cdecl;
    procedure drawRect(dirtyRect: NSRect); cdecl;
    procedure drawSheetBorderWithSize(borderSize: NSSize); cdecl;
    function enclosingMenuItem: NSMenuItem; cdecl;
    function enclosingScrollView: NSScrollView; cdecl;
    procedure endDocument; cdecl;
    procedure endPage; cdecl;
    function enterFullScreenMode(screen: NSScreen; withOptions: NSDictionary): Boolean; cdecl;
    procedure exitFullScreenModeWithOptions(options: NSDictionary); cdecl;
    function focusRingType: NSFocusRingType; cdecl;
    function frame: NSRect; cdecl;
    function frameCenterRotation: Single; cdecl;
    function frameRotation: Single; cdecl;
    function gState: NSInteger; cdecl;
    procedure getRectsBeingDrawn(rects: Pointer; count: PNSInteger); cdecl;
    procedure getRectsExposedDuringLiveResize(exposedRects: NSRect; count: PNSInteger); cdecl;
    function heightAdjustLimit: Single; cdecl;
    function hitTest(aPoint: NSPoint): NSView; cdecl;
    function inLiveResize: Boolean; cdecl;
    function initWithFrame(frameRect: NSRect): Pointer; cdecl;
    function inputContext: NSTextInputContext; cdecl;
    function isDescendantOf(aView: NSView): Boolean; cdecl;
    function isFlipped: Boolean; cdecl;
    function isHidden: Boolean; cdecl;
    function isHiddenOrHasHiddenAncestor: Boolean; cdecl;
    function isInFullScreenMode: Boolean; cdecl;
    function isOpaque: Boolean; cdecl;
    function isRotatedFromBase: Boolean; cdecl;
    function isRotatedOrScaledFromBase: Boolean; cdecl;
    function knowsPageRange(range: PNSRange): Boolean; cdecl;
    function layer: CALayer; cdecl;
    function layerContentsPlacement: NSViewLayerContentsPlacement; cdecl;
    function layerContentsRedrawPolicy: NSViewLayerContentsRedrawPolicy; cdecl;
    function locationOfPrintRect(aRect: NSRect): NSPoint; cdecl;
    procedure lockFocus; cdecl;
    function lockFocusIfCanDraw: Boolean; cdecl;
    function lockFocusIfCanDrawInContext(context: NSGraphicsContext): Boolean; cdecl;
    function makeBackingLayer: CALayer; cdecl;
    function menuForEvent(event: NSEvent): NSMenu; cdecl;
    function mouse(aPoint: NSPoint; inRect: NSRect): Boolean; cdecl;
    function mouseDownCanMoveWindow: Boolean; cdecl;
    function needsDisplay: Boolean; cdecl;
    function needsPanelToBecomeKey: Boolean; cdecl;
    function needsToDrawRect(aRect: NSRect): Boolean; cdecl;
    function nextKeyView: NSView; cdecl;
    function nextValidKeyView: NSView; cdecl;
    function opaqueAncestor: NSView; cdecl;
    function pageFooter: NSAttributedString; cdecl;
    function pageHeader: NSAttributedString; cdecl;
    function performKeyEquivalent(theEvent: NSEvent): Boolean; cdecl;
    function performMnemonic(theString: NSString): Boolean; cdecl;
    function postsBoundsChangedNotifications: Boolean; cdecl;
    function postsFrameChangedNotifications: Boolean; cdecl;
    function preservesContentDuringLiveResize: Boolean; cdecl;
    function previousKeyView: NSView; cdecl;
    function previousValidKeyView: NSView; cdecl;
    procedure print(sender: Pointer); cdecl;
    function printJobTitle: NSString; cdecl;
    function rectForPage(page: NSInteger): NSRect; cdecl;
    function rectPreservedDuringLiveResize: NSRect; cdecl;
    procedure reflectScrolledClipView(aClipView: NSClipView); cdecl;
    procedure registerForDraggedTypes(newTypes: NSArray); cdecl;
    function registeredDraggedTypes: NSArray; cdecl;
    procedure releaseGState; cdecl;
    procedure removeAllToolTips; cdecl;
    procedure removeCursorRect(aRect: NSRect; cursor: NSCursor); cdecl;
    procedure removeFromSuperview; cdecl;
    procedure removeFromSuperviewWithoutNeedingDisplay; cdecl;
    procedure removeToolTip(tag: NSToolTipTag); cdecl;
    procedure removeTrackingArea(trackingArea: NSTrackingArea); cdecl;
    procedure removeTrackingRect(tag: NSTrackingRectTag); cdecl;
    procedure renewGState; cdecl;
    procedure resetCursorRects; cdecl;
    procedure resizeSubviewsWithOldSize(oldSize: NSSize); cdecl;
    procedure resizeWithOldSuperviewSize(oldSize: NSSize); cdecl;
    procedure rotateByAngle(angle: Single); cdecl;
    procedure rulerView(ruler: NSRulerView; didAddMarker: NSRulerMarker); cdecl; overload;
//    procedure rulerView(ruler: NSRulerView; didMoveMarker: NSRulerMarker); cdecl; overload;
//    procedure rulerView(ruler: NSRulerView; didRemoveMarker: NSRulerMarker); cdecl; overload;
    procedure rulerView(ruler: NSRulerView; handleMouseDown: NSEvent); cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldAddMarker: NSRulerMarker): Boolean; cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldMoveMarker: NSRulerMarker): Boolean; cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldRemoveMarker: NSRulerMarker): Boolean; cdecl; overload;
    function rulerView(ruler: NSRulerView; willAddMarker: NSRulerMarker; atLocation: Single): Single; cdecl; overload;
//    function rulerView(ruler: NSRulerView; willMoveMarker: NSRulerMarker; toLocation: Single): Single; cdecl; overload;
    procedure rulerView(ruler: NSRulerView; willSetClientView: NSView); cdecl; overload;
    procedure scaleUnitSquareToSize(newUnitSize: NSSize); cdecl;
    procedure scrollClipView(aClipView: NSClipView; toPoint: NSPoint); cdecl;
    procedure scrollPoint(aPoint: NSPoint); cdecl;
    procedure scrollRect(aRect: NSRect; by: NSSize); cdecl;
    function scrollRectToVisible(aRect: NSRect): Boolean; cdecl;
    procedure setAcceptsTouchEvents(flag: Boolean); cdecl;
    procedure setAlphaValue(viewAlpha: Single); cdecl;
    procedure setAutoresizesSubviews(flag: Boolean); cdecl;
    procedure setAutoresizingMask(mask: NSUInteger); cdecl;
    procedure setBackgroundFilters(filters: NSArray); cdecl;
    procedure setBounds(aRect: NSRect); cdecl;
    procedure setBoundsOrigin(newOrigin: NSPoint); cdecl;
    procedure setBoundsRotation(angle: Single); cdecl;
    procedure setBoundsSize(newSize: NSSize); cdecl;
    procedure setCanDrawConcurrently(flag: Boolean); cdecl;
    procedure setCompositingFilter(filter: CIFilter); cdecl;
    procedure setContentFilters(filters: NSArray); cdecl;
    procedure setFocusRingType(focusRingType: NSFocusRingType); cdecl;
    procedure setFrame(frameRect: NSRect); cdecl;
    procedure setFrameCenterRotation(angle: Single); cdecl;
    procedure setFrameOrigin(newOrigin: NSPoint); cdecl;
    procedure setFrameRotation(angle: Single); cdecl;
    procedure setFrameSize(newSize: NSSize); cdecl;
    procedure setHidden(flag: Boolean); cdecl;
    procedure setKeyboardFocusRingNeedsDisplayInRect(rect: NSRect); cdecl;
    procedure setLayer(newLayer: CALayer); cdecl;
    procedure setLayerContentsPlacement(newPlacement: NSViewLayerContentsPlacement); cdecl;
    procedure setLayerContentsRedrawPolicy(newPolicy: NSViewLayerContentsRedrawPolicy); cdecl;
    procedure setNeedsDisplay(flag: Boolean); cdecl;
    procedure setNeedsDisplayInRect(invalidRect: NSRect); cdecl;
    procedure setNextKeyView(next: NSView); cdecl;
    procedure setPostsBoundsChangedNotifications(flag: Boolean); cdecl;
    procedure setPostsFrameChangedNotifications(flag: Boolean); cdecl;
    procedure setShadow(shadow: NSShadow); cdecl;
    procedure setSubviews(newSubviews: NSArray); cdecl;
    procedure setToolTip(string_: NSString); cdecl;
    procedure setUpGState; cdecl;
    procedure setWantsLayer(flag: Boolean); cdecl;
    procedure setWantsRestingTouches(flag: Boolean); cdecl;
    function shadow: NSShadow; cdecl;
    function shouldDelayWindowOrderingForEvent(theEvent: NSEvent): Boolean; cdecl;
    function shouldDrawColor: Boolean; cdecl;
    procedure showDefinitionForAttributedString(attrString: NSAttributedString; atPoint: NSPoint); cdecl; overload;
    function subviews: NSArray; cdecl;
    function superview: Pointer; cdecl;
    function tag: NSInteger; cdecl;
    function toolTip: NSString; cdecl;
    function trackingAreas: NSArray; cdecl;
    procedure translateOriginToPoint(translation: NSPoint); cdecl;
    procedure translateRectsNeedingDisplayInRect(clipRect: NSRect; by: NSSize); cdecl;
    procedure unlockFocus; cdecl;
    procedure unregisterDraggedTypes; cdecl;
    procedure updateTrackingAreas; cdecl;
    procedure viewDidEndLiveResize; cdecl;
    procedure viewDidHide; cdecl;
    procedure viewDidMoveToSuperview; cdecl;
    procedure viewDidMoveToWindow; cdecl;
    procedure viewDidUnhide; cdecl;
    procedure viewWillDraw; cdecl;
    procedure viewWillMoveToSuperview(newSuperview: NSView); cdecl;
    procedure viewWillMoveToWindow(newWindow: NSWindow); cdecl;
    procedure viewWillStartLiveResize; cdecl;
    function viewWithTag(aTag: NSInteger): Pointer; cdecl;
    function visibleRect: NSRect; cdecl;
    function wantsDefaultClipping: Boolean; cdecl;
    function wantsLayer: Boolean; cdecl;
    function wantsRestingTouches: Boolean; cdecl;
    function widthAdjustLimit: Single; cdecl;
    procedure willRemoveSubview(subview: NSView); cdecl;
    function window: NSWindow; cdecl;
    procedure writeEPSInsideRect(rect: NSRect; toPasteboard: NSPasteboard); cdecl;
    procedure writePDFInsideRect(rect: NSRect; toPasteboard: NSPasteboard); cdecl;
  end;
  TNSView = class(TOCGenericImport<NSViewClass, NSView>)  end;

  NSObjectControllerClass = interface(NSControllerClass)
    ['{DFB4C22E-EB91-4974-BDB7-1029A90CC434}']
  end;
  NSObjectController = interface(NSController)
    ['{C7D8CC18-479B-4A85-A909-C11A4AE45208}']
    procedure add(sender: Pointer); cdecl;
    procedure addObject(object_: Pointer); cdecl;
    function automaticallyPreparesContent: Boolean; cdecl;
    function canAdd: Boolean; cdecl;
    function canRemove: Boolean; cdecl;
    function content: Pointer; cdecl;
//    function defaultFetchRequest: NSFetchRequest; cdecl;
    function entityName: NSString; cdecl;
    procedure fetch(sender: Pointer); cdecl;
    function fetchPredicate: NSPredicate; cdecl;
//    function fetchWithRequest(fetchRequest: NSFetchRequest; merge: Boolean; error: NSError): Boolean; cdecl;
    function initWithContent(content: Pointer): Pointer; cdecl;
    function isEditable: Boolean; cdecl;
//    function managedObjectContext: NSManagedObjectContext; cdecl;
    function newObject: Pointer; cdecl;
    procedure prepareContent; cdecl;
    procedure remove(sender: Pointer); cdecl;
    procedure removeObject(object_: Pointer); cdecl;
    function selectedObjects: NSArray; cdecl;
    function selection: Pointer; cdecl;
    procedure setAutomaticallyPreparesContent(flag: Boolean); cdecl;
    procedure setContent(content: Pointer); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setEntityName(entityName: NSString); cdecl;
    procedure setFetchPredicate(predicate: NSPredicate); cdecl;
//    procedure setManagedObjectContext(managedObjectContext: NSManagedObjectContext); cdecl;
    procedure setObjectClass(objectClass: Pointer); cdecl;
    procedure setUsesLazyFetching(enabled: Boolean); cdecl;
    function usesLazyFetching: Boolean; cdecl;
    function validateUserInterfaceItem(item: NSValidatedUserInterfaceItem): Boolean; cdecl;
  end;
  TNSObjectController = class(TOCGenericImport<NSObjectControllerClass, NSObjectController>)  end;

  NSUserDefaultsControllerClass = interface(NSControllerClass)
    ['{0E32B7AD-85B5-41CA-96DE-6B2EABE0D829}']
    {class} function sharedUserDefaultsController: Pointer; cdecl;
  end;
  NSUserDefaultsController = interface(NSController)
    ['{82B0C653-BCEA-43D3-AC34-A6625F0E7807}']
    function appliesImmediately: Boolean; cdecl;
    function defaults: NSUserDefaults; cdecl;
    function hasUnappliedChanges: Boolean; cdecl;
    function initWithDefaults(defaults: NSUserDefaults; initialValues: NSDictionary): Pointer; cdecl;
    function initialValues: NSDictionary; cdecl;
    procedure revert(sender: Pointer); cdecl;
    procedure revertToInitialValues(sender: Pointer); cdecl;
    procedure save(sender: Pointer); cdecl;
    procedure setAppliesImmediately(flag: Boolean); cdecl;
    procedure setInitialValues(initialValues: NSDictionary); cdecl;
    function values: Pointer; cdecl;
  end;
  TNSUserDefaultsController = class(TOCGenericImport<NSUserDefaultsControllerClass, NSUserDefaultsController>)  end;

  NSPDFImageRepClass = interface(NSImageRepClass)
    ['{0A337A1C-909B-4253-860E-E61888EA07FA}']
    {class} function imageRepWithData(pdfData: NSData): Pointer; cdecl;
  end;
  NSPDFImageRep = interface(NSImageRep)
    ['{9FFE409D-1CF4-41B1-AB22-2E6EC6772514}']
    function PDFRepresentation: NSData; cdecl;
    function bounds: NSRect; cdecl;
    function currentPage: NSInteger; cdecl;
    function initWithData(pdfData: NSData): Pointer; cdecl;
    function pageCount: NSInteger; cdecl;
    procedure setCurrentPage(page: NSInteger); cdecl;
  end;
  TNSPDFImageRep = class(TOCGenericImport<NSPDFImageRepClass, NSPDFImageRep>)  end;

  NSSegmentedCellClass = interface(NSActionCellClass)
    ['{DE26C11F-30D2-485D-97F4-8FFBAC4E1B24}']
  end;
  NSSegmentedCell = interface(NSActionCell)
    ['{063482DC-4C8A-46B1-A2D2-3E0268F8FDA5}']
    procedure drawSegment(segment: NSInteger; inFrame: NSRect; withView: NSView); cdecl;
    function imageForSegment(segment: NSInteger): NSImage; cdecl;
    function imageScalingForSegment(segment: NSInteger): NSImageScaling; cdecl;
    function interiorBackgroundStyleForSegment(segment: NSInteger): NSBackgroundStyle; cdecl;
    function isEnabledForSegment(segment: NSInteger): Boolean; cdecl;
    function isSelectedForSegment(segment: NSInteger): Boolean; cdecl;
    function labelForSegment(segment: NSInteger): NSString; cdecl;
    procedure makeNextSegmentKey; cdecl;
    procedure makePreviousSegmentKey; cdecl;
    function menuForSegment(segment: NSInteger): NSMenu; cdecl;
    function segmentCount: NSInteger; cdecl;
    function segmentStyle: NSSegmentStyle; cdecl;
    function selectSegmentWithTag(tag: NSInteger): Boolean; cdecl;
    function selectedSegment: NSInteger; cdecl;
    procedure setEnabled(enabled: Boolean; forSegment: NSInteger); cdecl;
    procedure setImage(image: NSImage; forSegment: NSInteger); cdecl;
    procedure setImageScaling(scaling: NSImageScaling; forSegment: NSInteger); cdecl;
    procedure setLabel(label_: NSString; forSegment: NSInteger); cdecl;
    procedure setMenu(menu: NSMenu; forSegment: NSInteger); cdecl;
    procedure setSegmentCount(count: NSInteger); cdecl;
    procedure setSegmentStyle(segmentStyle: NSSegmentStyle); cdecl;
    procedure setSelected(selected: Boolean; forSegment: NSInteger); cdecl;
    procedure setSelectedSegment(selectedSegment: NSInteger); cdecl;
    procedure setTag(tag: NSInteger; forSegment: NSInteger); cdecl;
    procedure setToolTip(toolTip: NSString; forSegment: NSInteger); cdecl;
    procedure setTrackingMode(trackingMode: NSSegmentSwitchTracking); cdecl;
    procedure setWidth(width: Single; forSegment: NSInteger); cdecl;
    function tagForSegment(segment: NSInteger): NSInteger; cdecl;
    function toolTipForSegment(segment: NSInteger): NSString; cdecl;
    function trackingMode: NSSegmentSwitchTracking; cdecl;
    function widthForSegment(segment: NSInteger): Single; cdecl;
  end;
  TNSSegmentedCell = class(TOCGenericImport<NSSegmentedCellClass, NSSegmentedCell>)  end;

  NSSliderCellClass = interface(NSActionCellClass)
    ['{884290A7-A218-44AB-A5D7-0D776EF676BA}']
    {class} function prefersTrackingUntilMouseUp: Boolean; cdecl;
  end;
  NSSliderCell = interface(NSActionCell)
    ['{3F968FDF-7868-475E-B3EB-5BF51CCB7790}']
    function allowsTickMarkValuesOnly: Boolean; cdecl;
    function altIncrementValue: double; cdecl;
    function closestTickMarkValueToValue(value: double): double; cdecl;
    procedure drawBarInside(aRect: NSRect; flipped: Boolean); cdecl;
    procedure drawKnob; cdecl; overload;
    procedure drawKnob(knobRect: NSRect); cdecl; overload;
    function indexOfTickMarkAtPoint(point: NSPoint): NSInteger; cdecl;
    function isVertical: NSInteger; cdecl;
    function knobRectFlipped(flipped: Boolean): NSRect; cdecl;
    function knobThickness: Single; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    function numberOfTickMarks: NSInteger; cdecl;
    function rectOfTickMarkAtIndex(index: NSInteger): NSRect; cdecl;
    procedure setAllowsTickMarkValuesOnly(yorn: Boolean); cdecl;
    procedure setAltIncrementValue(incValue: double); cdecl;
    procedure setKnobThickness(aFloat: Single); cdecl;
    procedure setMaxValue(aDouble: double); cdecl;
    procedure setMinValue(aDouble: double); cdecl;
    procedure setNumberOfTickMarks(count: NSInteger); cdecl;
    procedure setSliderType(sliderType: NSSliderType); cdecl;
    procedure setTickMarkPosition(position: NSTickMarkPosition); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleCell(aCell: NSCell); cdecl;
    procedure setTitleColor(newColor: NSColor); cdecl;
    procedure setTitleFont(fontObj: NSFont); cdecl;
    function sliderType: NSSliderType; cdecl;
    function tickMarkPosition: NSTickMarkPosition; cdecl;
    function tickMarkValueAtIndex(index: NSInteger): double; cdecl;
    function title: NSString; cdecl;
    function titleCell: Pointer; cdecl;
    function titleColor: NSColor; cdecl;
    function titleFont: NSFont; cdecl;
    function trackRect: NSRect; cdecl;
  end;
  TNSSliderCell = class(TOCGenericImport<NSSliderCellClass, NSSliderCell>)  end;

  NSTableHeaderViewClass = interface(NSViewClass)
    ['{7C414AB2-7AEF-4188-8CDF-7B04B00FF04D}']
  end;
  NSTableHeaderView = interface(NSView)
    ['{3A4FCD12-53D8-4063-8E16-8E907986555B}']
    function columnAtPoint(point: NSPoint): NSInteger; cdecl;
    function draggedColumn: NSInteger; cdecl;
    function draggedDistance: Single; cdecl;
    function headerRectOfColumn(column: NSInteger): NSRect; cdecl;
    function resizedColumn: NSInteger; cdecl;
    procedure setTableView(tableView: NSTableView); cdecl;
    function tableView: NSTableView; cdecl;
  end;
  TNSTableHeaderView = class(TOCGenericImport<NSTableHeaderViewClass, NSTableHeaderView>)  end;

  NSTabViewClass = interface(NSViewClass)
    ['{39F6D4E7-49B8-4D74-B063-D8D3365E5F1D}']
  end;
  NSTabView = interface(NSView)
    ['{8E60E57E-C6CF-4E51-859C-E8A5DD7E3DC5}']
    procedure addTabViewItem(tabViewItem: NSTabViewItem); cdecl;
    function allowsTruncatedLabels: Boolean; cdecl;
    function contentRect: NSRect; cdecl;
    function controlSize: NSControlSize; cdecl;
    function controlTint: NSControlTint; cdecl;
    function delegate: NSTabViewDelegate; cdecl;
    function drawsBackground: Boolean; cdecl;
    function font: NSFont; cdecl;
    function indexOfTabViewItem(tabViewItem: NSTabViewItem): NSInteger; cdecl;
    function indexOfTabViewItemWithIdentifier(identifier: Pointer): NSInteger; cdecl;
    procedure insertTabViewItem(tabViewItem: NSTabViewItem; atIndex: NSInteger); cdecl;
    function minimumSize: NSSize; cdecl;
    function numberOfTabViewItems: NSInteger; cdecl;
    procedure removeTabViewItem(tabViewItem: NSTabViewItem); cdecl;
    procedure selectFirstTabViewItem(sender: Pointer); cdecl;
    procedure selectLastTabViewItem(sender: Pointer); cdecl;
    procedure selectNextTabViewItem(sender: Pointer); cdecl;
    procedure selectPreviousTabViewItem(sender: Pointer); cdecl;
    procedure selectTabViewItem(tabViewItem: NSTabViewItem); cdecl;
    procedure selectTabViewItemAtIndex(index: NSInteger); cdecl;
    procedure selectTabViewItemWithIdentifier(identifier: Pointer); cdecl;
    function selectedTabViewItem: NSTabViewItem; cdecl;
    procedure setAllowsTruncatedLabels(allowTruncatedLabels: Boolean); cdecl;
    procedure setControlSize(controlSize: NSControlSize); cdecl;
    procedure setControlTint(controlTint: NSControlTint); cdecl;
    procedure setDelegate(anObject: NSTabViewDelegate); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setFont(font: NSFont); cdecl;
    procedure setTabViewType(tabViewType: NSTabViewType); cdecl;
    function tabViewItemAtIndex(index: NSInteger): NSTabViewItem; cdecl;
    function tabViewItemAtPoint(point: NSPoint): NSTabViewItem; cdecl;
    function tabViewItems: NSArray; cdecl;
    function tabViewType: NSTabViewType; cdecl;
    procedure takeSelectedTabViewItemFromSender(sender: Pointer); cdecl;
  end;
  TNSTabView = class(TOCGenericImport<NSTabViewClass, NSTabView>)  end;

  NSTextFieldCellClass = interface(NSActionCellClass)
    ['{3CBD3392-30D6-4E9C-8973-6FE7F7AE05F7}']
  end;
  NSTextFieldCell = interface(NSActionCell)
    ['{A3470082-2AD2-4F37-8009-9A67FA96D47C}']
    function allowedInputSourceLocales: NSArray; cdecl;
    function backgroundColor: NSColor; cdecl;
    function bezelStyle: NSTextFieldBezelStyle; cdecl;
    function drawsBackground: Boolean; cdecl;
    function placeholderAttributedString: NSAttributedString; cdecl;
    function placeholderString: NSString; cdecl;
    procedure setAllowedInputSourceLocales(localeIdentifiers: NSArray); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBezelStyle(style: NSTextFieldBezelStyle); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setPlaceholderAttributedString(string_: NSAttributedString); cdecl;
    procedure setPlaceholderString(string_: NSString); cdecl;
    procedure setTextColor(color: NSColor); cdecl;
    function setUpFieldEditorAttributes(textObj: NSText): NSText; cdecl;
    procedure setWantsNotificationForMarkedText(flag: Boolean); cdecl;
    function textColor: NSColor; cdecl;
  end;
  TNSTextFieldCell = class(TOCGenericImport<NSTextFieldCellClass, NSTextFieldCell>)  end;

  NSTreeControllerClass = interface(NSObjectControllerClass)
    ['{FB7A7A0F-2B22-4DB2-AE48-76B2516C5DED}']
  end;
  NSTreeController = interface(NSObjectController)
    ['{A6A0978E-6448-4EDD-AB50-C4B8744D9938}']
    procedure add(sender: Pointer); cdecl;
    procedure addChild(sender: Pointer); cdecl;
    function addSelectionIndexPaths(indexPaths: NSArray): Boolean; cdecl;
    function alwaysUsesMultipleValuesMarker: Boolean; cdecl;
    function arrangedObjects: Pointer; cdecl;
    function avoidsEmptySelection: Boolean; cdecl;
    function canAddChild: Boolean; cdecl;
    function canInsert: Boolean; cdecl;
    function canInsertChild: Boolean; cdecl;
    function childrenKeyPath: NSString; cdecl;
    function childrenKeyPathForNode(node: NSTreeNode): NSString; cdecl;
    function content: Pointer; cdecl;
    function countKeyPath: NSString; cdecl;
    function countKeyPathForNode(node: NSTreeNode): NSString; cdecl;
    procedure insert(sender: Pointer); cdecl;
    procedure insertChild(sender: Pointer); cdecl;
    procedure insertObject(object_: Pointer; atArrangedObjectIndexPath: NSIndexPath); cdecl;
    procedure insertObjects(objects: NSArray; atArrangedObjectIndexPaths: NSArray); cdecl;
    function leafKeyPath: NSString; cdecl;
    function leafKeyPathForNode(node: NSTreeNode): NSString; cdecl;
    procedure moveNode(node: NSTreeNode; toIndexPath: NSIndexPath); cdecl;
    procedure moveNodes(nodes: NSArray; toIndexPath: NSIndexPath); cdecl;
    function preservesSelection: Boolean; cdecl;
    procedure rearrangeObjects; cdecl;
    procedure remove(sender: Pointer); cdecl;
    procedure removeObjectAtArrangedObjectIndexPath(indexPath: NSIndexPath); cdecl;
    procedure removeObjectsAtArrangedObjectIndexPaths(indexPaths: NSArray); cdecl;
    function removeSelectionIndexPaths(indexPaths: NSArray): Boolean; cdecl;
    function selectedNodes: NSArray; cdecl;
    function selectedObjects: NSArray; cdecl;
    function selectionIndexPath: NSIndexPath; cdecl;
    function selectionIndexPaths: NSArray; cdecl;
    function selectsInsertedObjects: Boolean; cdecl;
    procedure setAlwaysUsesMultipleValuesMarker(flag: Boolean); cdecl;
    procedure setAvoidsEmptySelection(flag: Boolean); cdecl;
    procedure setChildrenKeyPath(keyPath: NSString); cdecl;
    procedure setContent(content: Pointer); cdecl;
    procedure setCountKeyPath(keyPath: NSString); cdecl;
    procedure setLeafKeyPath(keyPath: NSString); cdecl;
    procedure setPreservesSelection(flag: Boolean); cdecl;
    function setSelectionIndexPath(indexPath: NSIndexPath): Boolean; cdecl;
    function setSelectionIndexPaths(indexPaths: NSArray): Boolean; cdecl;
    procedure setSelectsInsertedObjects(flag: Boolean); cdecl;
    procedure setSortDescriptors(sortDescriptors: NSArray); cdecl;
    function sortDescriptors: NSArray; cdecl;
  end;
  TNSTreeController = class(TOCGenericImport<NSTreeControllerClass, NSTreeController>)  end;

  NSStepperCellClass = interface(NSActionCellClass)
    ['{EB62AD62-CCE7-49DF-A460-DA8D17B93B40}']
  end;
  NSStepperCell = interface(NSActionCell)
    ['{F182603B-784A-4C2C-8B6F-CEA14C666D0E}']
    function autorepeat: Boolean; cdecl;
    function increment: double; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    procedure setAutorepeat(autorepeat: Boolean); cdecl;
    procedure setIncrement(increment: double); cdecl;
    procedure setMaxValue(maxValue: double); cdecl;
    procedure setMinValue(minValue: double); cdecl;
    procedure setValueWraps(valueWraps: Boolean); cdecl;
    function valueWraps: Boolean; cdecl;
  end;
  TNSStepperCell = class(TOCGenericImport<NSStepperCellClass, NSStepperCell>)  end;

  NSTextStorageClass = interface(NSMutableAttributedStringClass)
    ['{EB0E07CA-3010-498B-9307-49744A89849C}']
  end;
  NSTextStorage = interface(NSMutableAttributedString)
    ['{53CEA2E6-F675-44D8-8320-F0305E8F0E86}']
    procedure addLayoutManager(obj: NSLayoutManager); cdecl;
    function attributeRuns: NSArray; cdecl;
    function changeInLength: NSInteger; cdecl;
    function characters: NSArray; cdecl;
    function delegate: NSTextStorageDelegate; cdecl;
    procedure edited(editedMask: NSUInteger; range: NSRange; changeInLength: NSInteger); cdecl;
    function editedMask: NSUInteger; cdecl;
    function editedRange: NSRange; cdecl;
    procedure ensureAttributesAreFixedInRange(range: NSRange); cdecl;
    function fixesAttributesLazily: Boolean; cdecl;
    function font: NSFont; cdecl;
    function foregroundColor: NSColor; cdecl;
    procedure invalidateAttributesInRange(range: NSRange); cdecl;
    function layoutManagers: NSArray; cdecl;
    function paragraphs: NSArray; cdecl;
    procedure processEditing; cdecl;
    procedure removeLayoutManager(obj: NSLayoutManager); cdecl;
    procedure setAttributeRuns(attributeRuns: NSArray); cdecl;
    procedure setCharacters(characters: NSArray); cdecl;
    procedure setDelegate(delegate: NSTextStorageDelegate); cdecl;
    procedure setFont(font: NSFont); cdecl;
    procedure setForegroundColor(color: NSColor); cdecl;
    procedure setParagraphs(paragraphs: NSArray); cdecl;
    procedure setWords(words: NSArray); cdecl;
    function words: NSArray; cdecl;
  end;
  TNSTextStorage = class(TOCGenericImport<NSTextStorageClass, NSTextStorage>)  end;

  NSTextClass = interface(NSViewClass)
    ['{A28F5D55-4AFE-431A-8497-89A916C8CB3C}']
  end;
  NSText = interface(NSView)
    ['{2F10859F-5512-4D42-9F4B-BA8DF54656BA}']
    function RTFDFromRange(range: NSRange): NSData; cdecl;
    function RTFFromRange(range: NSRange): NSData; cdecl;
    procedure alignCenter(sender: Pointer); cdecl;
    procedure alignLeft(sender: Pointer); cdecl;
    procedure alignRight(sender: Pointer); cdecl;
    function alignment: NSTextAlignment; cdecl;
    function backgroundColor: NSColor; cdecl;
    function baseWritingDirection: NSWritingDirection; cdecl;
    procedure changeFont(sender: Pointer); cdecl;
    procedure checkSpelling(sender: Pointer); cdecl;
    procedure copy(sender: Pointer); cdecl;
    procedure copyFont(sender: Pointer); cdecl;
    procedure copyRuler(sender: Pointer); cdecl;
    procedure cut(sender: Pointer); cdecl;
    function delegate: NSTextDelegate; cdecl;
    procedure delete(sender: Pointer); cdecl;
    function drawsBackground: Boolean; cdecl;
    function font: NSFont; cdecl;
    function importsGraphics: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isFieldEditor: Boolean; cdecl;
    function isHorizontallyResizable: Boolean; cdecl;
    function isRichText: Boolean; cdecl;
    function isRulerVisible: Boolean; cdecl;
    function isSelectable: Boolean; cdecl;
    function isVerticallyResizable: Boolean; cdecl;
    function maxSize: NSSize; cdecl;
    function minSize: NSSize; cdecl;
    procedure paste(sender: Pointer); cdecl;
    procedure pasteFont(sender: Pointer); cdecl;
    procedure pasteRuler(sender: Pointer); cdecl;
    function readRTFDFromFile(path: NSString): Boolean; cdecl;
    procedure replaceCharactersInRange(range: NSRange; withRTF: NSData); cdecl; overload;
//    procedure replaceCharactersInRange(range: NSRange; withRTFD: NSData); cdecl; overload;
    procedure replaceCharactersInRange(range: NSRange; withString: NSString); cdecl; overload;
    procedure scrollRangeToVisible(range: NSRange); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    function selectedRange: NSRange; cdecl;
    procedure setAlignment(mode: NSTextAlignment); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setDelegate(anObject: NSTextDelegate); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setFieldEditor(flag: Boolean); cdecl;
    procedure setFont(obj: NSFont); cdecl; overload;
    procedure setFont(font: NSFont; range: NSRange); cdecl; overload;
    procedure setHorizontallyResizable(flag: Boolean); cdecl;
    procedure setImportsGraphics(flag: Boolean); cdecl;
    procedure setMaxSize(newMaxSize: NSSize); cdecl;
    procedure setMinSize(newMinSize: NSSize); cdecl;
    procedure setRichText(flag: Boolean); cdecl;
    procedure setSelectable(flag: Boolean); cdecl;
    procedure setSelectedRange(range: NSRange); cdecl;
    procedure setString(string_: NSString); cdecl;
    procedure setTextColor(color: NSColor); cdecl; overload;
    procedure setTextColor(color: NSColor; range: NSRange); cdecl; overload;
    procedure setUsesFontPanel(flag: Boolean); cdecl;
    procedure setVerticallyResizable(flag: Boolean); cdecl;
    procedure showGuessPanel(sender: Pointer); cdecl;
    procedure sizeToFit; cdecl;
    procedure subscript(sender: Pointer); cdecl;
    procedure superscript(sender: Pointer); cdecl;
    function textColor: NSColor; cdecl;
    procedure toggleRuler(sender: Pointer); cdecl;
    procedure underline(sender: Pointer); cdecl;
    procedure unscript(sender: Pointer); cdecl;
    function usesFontPanel: Boolean; cdecl;
    function writeRTFDToFile(path: NSString; atomically: Boolean): Boolean; cdecl;
  end;
  TNSText = class(TOCGenericImport<NSTextClass, NSText>)  end;

  NSSplitViewClass = interface(NSViewClass)
    ['{D169CBB0-B6C2-4219-AE69-F3625F4041FC}']
  end;
  NSSplitView = interface(NSView)
    ['{96CA29B8-6371-44FD-B609-6546DB6081DC}']
    procedure adjustSubviews; cdecl;
    function autosaveName: NSString; cdecl;
    function delegate: NSSplitViewDelegate; cdecl;
    function dividerColor: NSColor; cdecl;
    function dividerStyle: NSSplitViewDividerStyle; cdecl;
    function dividerThickness: Single; cdecl;
    procedure drawDividerInRect(rect: NSRect); cdecl;
    function isPaneSplitter: Boolean; cdecl;
    function isSubviewCollapsed(subview: NSView): Boolean; cdecl;
    function isVertical: Boolean; cdecl;
    function maxPossiblePositionOfDividerAtIndex(dividerIndex: NSInteger): Single; cdecl;
    function minPossiblePositionOfDividerAtIndex(dividerIndex: NSInteger): Single; cdecl;
    procedure setAutosaveName(autosaveName: NSString); cdecl;
    procedure setDelegate(delegate: NSSplitViewDelegate); cdecl;
    procedure setDividerStyle(dividerStyle: NSSplitViewDividerStyle); cdecl;
    procedure setIsPaneSplitter(flag: Boolean); cdecl;
    procedure setPosition(position: Single; ofDividerAtIndex: NSInteger); cdecl;
    procedure setVertical(flag: Boolean); cdecl;
  end;
  TNSSplitView = class(TOCGenericImport<NSSplitViewClass, NSSplitView>)  end;

  NSFormCellClass = interface(NSActionCellClass)
    ['{8A6CB6F6-FA19-42F6-A207-AC0CE35C33D4}']
  end;
  NSFormCell = interface(NSActionCell)
    ['{0E056DE1-A722-41AD-8E8B-213C46C609C7}']
    function attributedTitle: NSAttributedString; cdecl;
    function initTextCell(aString: NSString): Pointer; cdecl;
    function isOpaque: Boolean; cdecl;
    function placeholderAttributedString: NSAttributedString; cdecl;
    function placeholderString: NSString; cdecl;
    procedure setAttributedTitle(obj: NSAttributedString); cdecl;
    procedure setPlaceholderAttributedString(string_: NSAttributedString); cdecl;
    procedure setPlaceholderString(string_: NSString); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleAlignment(mode: NSTextAlignment); cdecl;
    procedure setTitleBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setTitleFont(fontObj: NSFont); cdecl;
    procedure setTitleWidth(width: Single); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    function title: NSString; cdecl;
    function titleAlignment: NSTextAlignment; cdecl;
    function titleBaseWritingDirection: NSWritingDirection; cdecl;
    function titleFont: NSFont; cdecl;
    function titleWidth: Single; cdecl; overload;
    function titleWidth(aSize: NSSize): Single; cdecl; overload;
  end;
  TNSFormCell = class(TOCGenericImport<NSFormCellClass, NSFormCell>)  end;

  NSOpenGLViewClass = interface(NSViewClass)
    ['{869A3FBB-2093-44B0-B59F-31B5F0DA8158}']
    {class} function defaultPixelFormat: NSOpenGLPixelFormat; cdecl;
  end;
  NSOpenGLView = interface(NSView)
    ['{89499EC6-20D0-4D00-A9EF-3B4B3F4A23A8}']
    procedure clearGLContext; cdecl;
    function initWithFrame(frameRect: NSRect; pixelFormat: NSOpenGLPixelFormat): Pointer; cdecl;
    function openGLContext: NSOpenGLContext; cdecl;
    function pixelFormat: NSOpenGLPixelFormat; cdecl;
    procedure prepareOpenGL; cdecl;
    procedure reshape; cdecl;
    procedure setOpenGLContext(context: NSOpenGLContext); cdecl;
    procedure setPixelFormat(pixelFormat: NSOpenGLPixelFormat); cdecl;
    procedure update; cdecl;
    procedure setWantsBestResolutionOpenGLSurface(flag: Boolean); cdecl; // 10.7+
  end;
  TNSOpenGLView = class(TOCGenericImport<NSOpenGLViewClass, NSOpenGLView>)  end;

  NSCollectionViewItemClass = interface(NSViewControllerClass)
    ['{AE7A0DC8-5CF0-4603-9287-C7F9D36B2A32}']
  end;
  NSCollectionViewItem = interface(NSViewController)
    ['{D6A79CCD-41D3-4384-B1A5-A96CD9845217}']
    function collectionView: NSCollectionView; cdecl;
    function isSelected: Boolean; cdecl;
    procedure setSelected(flag: Boolean); cdecl;
  end;
  TNSCollectionViewItem = class(TOCGenericImport<NSCollectionViewItemClass, NSCollectionViewItem>)  end;

  NSProgressIndicatorClass = interface(NSViewClass)
    ['{E7585A65-053B-4889-A7D0-A09DAB8F559E}']
  end;
  NSProgressIndicator = interface(NSView)
    ['{3D482DF9-334A-4FD5-B5FD-F224ED05AD61}']
    procedure animate(sender: Pointer); cdecl;
    function animationDelay: NSTimeInterval; cdecl;
    function controlSize: NSControlSize; cdecl;
    function controlTint: NSControlTint; cdecl;
    function doubleValue: double; cdecl;
    procedure incrementBy(delta: double); cdecl;
    function isBezeled: Boolean; cdecl;
    function isDisplayedWhenStopped: Boolean; cdecl;
    function isIndeterminate: Boolean; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    procedure setAnimationDelay(delay: NSTimeInterval); cdecl;
    procedure setBezeled(flag: Boolean); cdecl;
    procedure setControlSize(size: NSControlSize); cdecl;
    procedure setControlTint(tint: NSControlTint); cdecl;
    procedure setDisplayedWhenStopped(isDisplayed: Boolean); cdecl;
    procedure setDoubleValue(doubleValue: double); cdecl;
    procedure setIndeterminate(flag: Boolean); cdecl;
    procedure setMaxValue(newMaximum: double); cdecl;
    procedure setMinValue(newMinimum: double); cdecl;
    procedure setStyle(style: NSProgressIndicatorStyle); cdecl;
    procedure setUsesThreadedAnimation(threadedAnimation: Boolean); cdecl;
    procedure sizeToFit; cdecl;
    procedure startAnimation(sender: Pointer); cdecl;
    procedure stopAnimation(sender: Pointer); cdecl;
    function style: NSProgressIndicatorStyle; cdecl;
    function usesThreadedAnimation: Boolean; cdecl;
  end;
  TNSProgressIndicator = class(TOCGenericImport<NSProgressIndicatorClass, NSProgressIndicator>)  end;

  NSPathCellClass = interface(NSActionCellClass)
    ['{2EFD8FFD-B7EE-47BA-93E1-5B2DF42049A5}']
  end;
  NSPathCell = interface(NSActionCell)
    ['{5F14CA23-3F14-4C62-AEC5-C61E4F960738}']
    function URL: NSURL; cdecl;
    function allowedTypes: NSArray; cdecl;
    function backgroundColor: NSColor; cdecl;
    function clickedPathComponentCell: NSPathComponentCell; cdecl;
    function delegate: NSPathCellDelegate; cdecl;
    function doubleAction: SEL; cdecl;
    procedure mouseEntered(event: NSEvent; withFrame: NSRect; inView: NSView); cdecl;
    procedure mouseExited(event: NSEvent; withFrame: NSRect; inView: NSView); cdecl;
    function pathComponentCellAtPoint(point: NSPoint; withFrame: NSRect; inView: NSView): NSPathComponentCell; cdecl;
    function pathComponentCells: NSArray; cdecl;
    function pathStyle: NSPathStyle; cdecl;
    function placeholderAttributedString: NSAttributedString; cdecl;
    function placeholderString: NSString; cdecl;
    function rectOfPathComponentCell(cell: NSPathComponentCell; withFrame: NSRect; inView: NSView): NSRect; cdecl;
    procedure setAllowedTypes(allowedTypes: NSArray); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setControlSize(size: NSControlSize); cdecl;
    procedure setDelegate(value: NSPathCellDelegate); cdecl;
    procedure setDoubleAction(action: SEL); cdecl;
    procedure setObjectValue(obj: NSCopying); cdecl;
    procedure setPathComponentCells(cells: NSArray); cdecl;
    procedure setPathStyle(style: NSPathStyle); cdecl;
    procedure setPlaceholderAttributedString(string_: NSAttributedString); cdecl;
    procedure setPlaceholderString(string_: NSString); cdecl;
    procedure setURL(url: NSURL); cdecl;
  end;
  TNSPathCell = class(TOCGenericImport<NSPathCellClass, NSPathCell>)  end;

  NSPanelClass = interface(NSWindowClass)
    ['{C6E265AF-3115-4762-B1B1-4BE2A280D734}']
  end;
  NSPanel = interface(NSWindow)
    ['{35734CC4-DD8A-4E47-8913-BE98CBF9258E}']
    function becomesKeyOnlyIfNeeded: Boolean; cdecl;
    function isFloatingPanel: Boolean; cdecl;
    procedure setBecomesKeyOnlyIfNeeded(flag: Boolean); cdecl;
    procedure setFloatingPanel(flag: Boolean); cdecl;
    procedure setWorksWhenModal(flag: Boolean); cdecl;
    function worksWhenModal: Boolean; cdecl;
  end;
  TNSPanel = class(TOCGenericImport<NSPanelClass, NSPanel>)  end;

  NSControlClass = interface(NSViewClass)
    ['{F12AD3A8-D516-44E1-9B81-F128425ED29E}']
    {class} procedure setCellClass(factoryId: Pointer); cdecl;
  end;
  NSControl = interface(NSView)
    ['{4A3C93CC-B1F4-40D1-B9CA-D5EDD3A3A54D}']
    function abortEditing: Boolean; cdecl;
    function action: SEL; cdecl;
    function alignment: NSTextAlignment; cdecl;
    function attributedStringValue: NSAttributedString; cdecl;
    function baseWritingDirection: NSWritingDirection; cdecl;
    procedure calcSize; cdecl;
    function cell: Pointer; cdecl;
    function currentEditor: NSText; cdecl;
    function doubleValue: double; cdecl;
    procedure drawCell(aCell: NSCell); cdecl;
    procedure drawCellInside(aCell: NSCell); cdecl;
    function floatValue: Single; cdecl;
    function font: NSFont; cdecl;
    function formatter: Pointer; cdecl;
    function ignoresMultiClick: Boolean; cdecl;
    function initWithFrame(frameRect: NSRect): Pointer; cdecl;
    function intValue: Integer; cdecl;
    function integerValue: NSInteger; cdecl;
    function isContinuous: Boolean; cdecl;
    function isEnabled: Boolean; cdecl;
    procedure mouseDown(theEvent: NSEvent); cdecl;
    function objectValue: Pointer; cdecl;
    procedure performClick(sender: Pointer); cdecl;
    function refusesFirstResponder: Boolean; cdecl;
    procedure selectCell(aCell: NSCell); cdecl;
    function selectedCell: Pointer; cdecl;
    function selectedTag: NSInteger; cdecl;
    function sendActionOn(mask: NSInteger): NSInteger; cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setAlignment(mode: NSTextAlignment); cdecl;
    procedure setAttributedStringValue(obj: NSAttributedString); cdecl;
    procedure setBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setCell(aCell: NSCell); cdecl;
    procedure setContinuous(flag: Boolean); cdecl;
    procedure setDoubleValue(aDouble: double); cdecl;
    procedure setEnabled(flag: Boolean); cdecl;
    procedure setFloatValue(aFloat: Single); cdecl;
    procedure setFloatingPointFormat(autoRange: Boolean; left: NSUInteger; right: NSUInteger); cdecl;
    procedure setFont(fontObj: NSFont); cdecl;
    procedure setFormatter(newFormatter: NSFormatter); cdecl;
    procedure setIgnoresMultiClick(flag: Boolean); cdecl;
    procedure setIntValue(anInt: Integer); cdecl;
    procedure setIntegerValue(anInteger: NSInteger); cdecl;
    procedure setNeedsDisplay; cdecl;
    procedure setObjectValue(obj: Pointer); cdecl;
    procedure setRefusesFirstResponder(flag: Boolean); cdecl;
    procedure setStringValue(aString: NSString); cdecl;
    procedure setTag(anInt: NSInteger); cdecl;
    procedure setTarget(anObject: Pointer); cdecl;
    procedure sizeToFit; cdecl;
    function stringValue: NSString; cdecl;
    function tag: NSInteger; cdecl;
    procedure takeDoubleValueFrom(sender: Pointer); cdecl;
    procedure takeFloatValueFrom(sender: Pointer); cdecl;
    procedure takeIntValueFrom(sender: Pointer); cdecl;
    procedure takeIntegerValueFrom(sender: Pointer); cdecl;
    procedure takeObjectValueFrom(sender: Pointer); cdecl;
    procedure takeStringValueFrom(sender: Pointer); cdecl;
    function target: Pointer; cdecl;
    procedure updateCell(aCell: NSCell); cdecl;
    procedure updateCellInside(aCell: NSCell); cdecl;
    procedure validateEditing; cdecl;
  end;
  TNSControl = class(TOCGenericImport<NSControlClass, NSControl>)  end;

  NSDatePickerCellClass = interface(NSActionCellClass)
    ['{3C1CEF83-03B7-4483-94B3-570066A668ED}']
  end;
  NSDatePickerCell = interface(NSActionCell)
    ['{190DF77D-B5EC-45CD-8330-FE6070D38477}']
    function backgroundColor: NSColor; cdecl;
    function calendar: NSCalendar; cdecl;
    function datePickerElements: NSDatePickerElementFlags; cdecl;
    function datePickerMode: NSDatePickerMode; cdecl;
    function datePickerStyle: NSDatePickerStyle; cdecl;
    function dateValue: NSDate; cdecl;
    function delegate: NSDatePickerCellDelegate; cdecl;
    function drawsBackground: Boolean; cdecl;
    function locale: NSLocale; cdecl;
    function maxDate: NSDate; cdecl;
    function minDate: NSDate; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setCalendar(newCalendar: NSCalendar); cdecl;
    procedure setDatePickerElements(elementFlags: NSDatePickerElementFlags); cdecl;
    procedure setDatePickerMode(newMode: NSDatePickerMode); cdecl;
    procedure setDatePickerStyle(newStyle: NSDatePickerStyle); cdecl;
    procedure setDateValue(newStartDate: NSDate); cdecl;
    procedure setDelegate(anObject: NSDatePickerCellDelegate); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setLocale(newLocale: NSLocale); cdecl;
    procedure setMaxDate(date: NSDate); cdecl;
    procedure setMinDate(date: NSDate); cdecl;
    procedure setTextColor(color: NSColor); cdecl;
    procedure setTimeInterval(newTimeInterval: NSTimeInterval); cdecl;
    procedure setTimeZone(newTimeZone: NSTimeZone); cdecl;
    function textColor: NSColor; cdecl;
    function timeInterval: NSTimeInterval; cdecl;
    function timeZone: NSTimeZone; cdecl;
  end;
  TNSDatePickerCell = class(TOCGenericImport<NSDatePickerCellClass, NSDatePickerCell>)  end;

  NSRulerViewClass = interface(NSViewClass)
    ['{B67F449C-CA1B-40AF-8634-ABF0B55C5B95}']
    {class} procedure registerUnitWithName(unitName: NSString; abbreviation: NSString; unitToPointsConversionFactor: Single; stepUpCycle: NSArray; stepDownCycle: NSArray); cdecl;
  end;
  NSRulerView = interface(NSView)
    ['{FF4F8936-4DC3-4FE9-80B5-F90E46B61069}']
    function accessoryView: NSView; cdecl;
    procedure addMarker(marker: NSRulerMarker); cdecl;
    function baselineLocation: Single; cdecl;
    function clientView: NSView; cdecl;
    procedure drawHashMarksAndLabelsInRect(rect: NSRect); cdecl;
    procedure drawMarkersInRect(rect: NSRect); cdecl;
    function initWithScrollView(scrollView: NSScrollView; orientation: NSRulerOrientation): Pointer; cdecl;
    procedure invalidateHashMarks; cdecl;
    function isFlipped: Boolean; cdecl;
    function markers: NSArray; cdecl;
    function measurementUnits: NSString; cdecl;
    procedure moveRulerlineFromLocation(oldLocation: Single; toLocation: Single); cdecl;
    function orientation: NSRulerOrientation; cdecl;
    function originOffset: Single; cdecl;
    procedure removeMarker(marker: NSRulerMarker); cdecl;
    function requiredThickness: Single; cdecl;
    function reservedThicknessForAccessoryView: Single; cdecl;
    function reservedThicknessForMarkers: Single; cdecl;
    function ruleThickness: Single; cdecl;
    function scrollView: NSScrollView; cdecl;
    procedure setAccessoryView(accessory: NSView); cdecl;
    procedure setClientView(client: NSView); cdecl;
    procedure setMarkers(markers: NSArray); cdecl;
    procedure setMeasurementUnits(unitName: NSString); cdecl;
    procedure setOrientation(orientation: NSRulerOrientation); cdecl;
    procedure setOriginOffset(offset: Single); cdecl;
    procedure setReservedThicknessForAccessoryView(thickness: Single); cdecl;
    procedure setReservedThicknessForMarkers(thickness: Single); cdecl;
    procedure setRuleThickness(thickness: Single); cdecl;
    procedure setScrollView(scrollView: NSScrollView); cdecl;
    function trackMarker(marker: NSRulerMarker; withMouseEvent: NSEvent): Boolean; cdecl;
  end;
  TNSRulerView = class(TOCGenericImport<NSRulerViewClass, NSRulerView>)  end;

  NSButtonCellClass = interface(NSActionCellClass)
    ['{6FC2C8D2-5474-4D85-870A-1AEFA6211EC0}']
  end;
  NSButtonCell = interface(NSActionCell)
    ['{DEE3EF96-52AA-4BEC-B4A1-4CD78ABF1A36}']
    function alternateImage: NSImage; cdecl;
    function alternateMnemonic: NSString; cdecl;
    function alternateMnemonicLocation: NSUInteger; cdecl;
    function alternateTitle: NSString; cdecl;
    function attributedAlternateTitle: NSAttributedString; cdecl;
    function attributedTitle: NSAttributedString; cdecl;
    function backgroundColor: NSColor; cdecl;
    function bezelStyle: NSBezelStyle; cdecl;
    procedure drawBezelWithFrame(frame: NSRect; inView: NSView); cdecl;
    procedure drawImage(image: NSImage; withFrame: NSRect; inView: NSView); cdecl;
    function drawTitle(title: NSAttributedString; withFrame: NSRect; inView: NSView): NSRect; cdecl;
    procedure getPeriodicDelay(delay: PSingle; interval: PSingle); cdecl;
    function gradientType: NSGradientType; cdecl;
    function highlightsBy: NSInteger; cdecl;
    function imageDimsWhenDisabled: Boolean; cdecl;
    function imagePosition: NSCellImagePosition; cdecl;
    function imageScaling: NSImageScaling; cdecl;
    function isOpaque: Boolean; cdecl;
    function isTransparent: Boolean; cdecl;
    function keyEquivalent: NSString; cdecl;
    function keyEquivalentFont: NSFont; cdecl;
    function keyEquivalentModifierMask: NSUInteger; cdecl;
    procedure mouseEntered(event: NSEvent); cdecl;
    procedure mouseExited(event: NSEvent); cdecl;
    procedure performClick(sender: Pointer); cdecl;
    procedure setAlternateImage(image: NSImage); cdecl;
    procedure setAlternateMnemonicLocation(location: NSUInteger); cdecl;
    procedure setAlternateTitle(aString: NSString); cdecl;
    procedure setAlternateTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setAttributedAlternateTitle(obj: NSAttributedString); cdecl;
    procedure setAttributedTitle(obj: NSAttributedString); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBezelStyle(bezelStyle: NSBezelStyle); cdecl;
    procedure setButtonType(aType: NSButtonType); cdecl;
    procedure setFont(fontObj: NSFont); cdecl;
    procedure setGradientType(type_: NSGradientType); cdecl;
    procedure setHighlightsBy(aType: NSInteger); cdecl;
    procedure setImageDimsWhenDisabled(flag: Boolean); cdecl;
    procedure setImagePosition(aPosition: NSCellImagePosition); cdecl;
    procedure setImageScaling(scaling: NSImageScaling); cdecl;
    procedure setKeyEquivalent(aKeyEquivalent: NSString); cdecl;
    procedure setKeyEquivalentFont(fontObj: NSFont); cdecl; overload;
    procedure setKeyEquivalentFont(fontName: NSString; size: Single); cdecl; overload;
    procedure setKeyEquivalentModifierMask(mask: NSUInteger); cdecl;
    procedure setPeriodicDelay(delay: Single; interval: Single); cdecl;
    procedure setShowsBorderOnlyWhileMouseInside(show: Boolean); cdecl;
    procedure setShowsStateBy(aType: NSInteger); cdecl;
    procedure setSound(aSound: NSSound); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setTransparent(flag: Boolean); cdecl;
    function showsBorderOnlyWhileMouseInside: Boolean; cdecl;
    function showsStateBy: NSInteger; cdecl;
    function sound: NSSound; cdecl;
    function title: NSString; cdecl;
  end;
  TNSButtonCell = class(TOCGenericImport<NSButtonCellClass, NSButtonCell>)  end;

  NSBoxClass = interface(NSViewClass)
    ['{FF441C9D-969E-4F7F-82FB-6E2A0A6D10CB}']
  end;
  NSBox = interface(NSView)
    ['{CA635DF0-2E40-46E1-8EE2-A48E94AF3664}']
    function borderColor: NSColor; cdecl;
    function borderRect: NSRect; cdecl;
    function borderType: NSBorderType; cdecl;
    function borderWidth: Single; cdecl;
    function boxType: NSBoxType; cdecl;
    function contentView: Pointer; cdecl;
    function contentViewMargins: NSSize; cdecl;
    function cornerRadius: Single; cdecl;
    function fillColor: NSColor; cdecl;
    function isTransparent: Boolean; cdecl;
    procedure setBorderColor(borderColor: NSColor); cdecl;
    procedure setBorderType(aType: NSBorderType); cdecl;
    procedure setBorderWidth(borderWidth: Single); cdecl;
    procedure setBoxType(boxType: NSBoxType); cdecl;
    procedure setContentView(aView: NSView); cdecl;
    procedure setContentViewMargins(offsetSize: NSSize); cdecl;
    procedure setCornerRadius(cornerRadius: Single); cdecl;
    procedure setFillColor(fillColor: NSColor); cdecl;
    procedure setFrameFromContentFrame(contentFrame: NSRect); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleFont(fontObj: NSFont); cdecl;
    procedure setTitlePosition(aPosition: NSTitlePosition); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setTransparent(flag: Boolean); cdecl;
    procedure sizeToFit; cdecl;
    function title: NSString; cdecl;
    function titleCell: Pointer; cdecl;
    function titleFont: NSFont; cdecl;
    function titlePosition: NSTitlePosition; cdecl;
    function titleRect: NSRect; cdecl;
  end;
  TNSBox = class(TOCGenericImport<NSBoxClass, NSBox>)  end;

  NSLevelIndicatorCellClass = interface(NSActionCellClass)
    ['{645AFF70-A347-41CD-AB51-413534B8E551}']
  end;
  NSLevelIndicatorCell = interface(NSActionCell)
    ['{BD370CB7-17BE-42BE-B777-A27FADB80ED2}']
    function criticalValue: double; cdecl;
    function initWithLevelIndicatorStyle(levelIndicatorStyle: NSLevelIndicatorStyle): Pointer; cdecl;
    function levelIndicatorStyle: NSLevelIndicatorStyle; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    function numberOfMajorTickMarks: NSInteger; cdecl;
    function numberOfTickMarks: NSInteger; cdecl;
    function rectOfTickMarkAtIndex(index: NSInteger): NSRect; cdecl;
    procedure setCriticalValue(criticalValue: double); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setLevelIndicatorStyle(levelIndicatorStyle: NSLevelIndicatorStyle); cdecl;
    procedure setMaxValue(maxValue: double); cdecl;
    procedure setMinValue(minValue: double); cdecl;
    procedure setNumberOfMajorTickMarks(count: NSInteger); cdecl;
    procedure setNumberOfTickMarks(count: NSInteger); cdecl;
    procedure setTickMarkPosition(position: NSTickMarkPosition); cdecl;
    procedure setWarningValue(warningValue: double); cdecl;
    function tickMarkPosition: NSTickMarkPosition; cdecl;
    function tickMarkValueAtIndex(index: NSInteger): double; cdecl;
    function warningValue: double; cdecl;
  end;
  TNSLevelIndicatorCell = class(TOCGenericImport<NSLevelIndicatorCellClass, NSLevelIndicatorCell>)  end;

  NSClipViewClass = interface(NSViewClass)
    ['{3E4FF083-EF77-4533-9573-A57520193F08}']
  end;
  NSClipView = interface(NSView)
    ['{EEE1CCDD-E60D-43EA-8243-37C07BA00018}']
    function autoscroll(theEvent: NSEvent): Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function constrainScrollPoint(newOrigin: NSPoint): NSPoint; cdecl;
    function copiesOnScroll: Boolean; cdecl;
    function documentCursor: NSCursor; cdecl;
    function documentRect: NSRect; cdecl;
    function documentView: Pointer; cdecl;
    function documentVisibleRect: NSRect; cdecl;
    function drawsBackground: Boolean; cdecl;
    procedure scrollToPoint(newOrigin: NSPoint); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setCopiesOnScroll(flag: Boolean); cdecl;
    procedure setDocumentCursor(anObj: NSCursor); cdecl;
    procedure setDocumentView(aView: NSView); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure viewBoundsChanged(notification: NSNotification); cdecl;
    procedure viewFrameChanged(notification: NSNotification); cdecl;
  end;
  TNSClipView = class(TOCGenericImport<NSClipViewClass, NSClipView>)  end;

  NSScrollViewClass = interface(NSViewClass)
    ['{C4626EF5-7D6E-4B77-AA34-4257B13A7C8B}']
    {class} function contentSizeForFrameSize(fSize: NSSize; hasHorizontalScroller: Boolean; hasVerticalScroller: Boolean; borderType: NSBorderType): NSSize; cdecl;
    {class} function frameSizeForContentSize(cSize: NSSize; hasHorizontalScroller: Boolean; hasVerticalScroller: Boolean; borderType: NSBorderType): NSSize; cdecl;
    {class} procedure setRulerViewClass(rulerViewClass: Pointer); cdecl;
  end;
  NSScrollView = interface(NSView)
    ['{1BDDEDF2-3127-4AF6-B7C0-5A1415119DD4}']
    function autohidesScrollers: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function borderType: NSBorderType; cdecl;
    function contentSize: NSSize; cdecl;
    function contentView: NSClipView; cdecl;
    function documentCursor: NSCursor; cdecl;
    function documentView: Pointer; cdecl;
    function documentVisibleRect: NSRect; cdecl;
    function drawsBackground: Boolean; cdecl;
    function hasHorizontalRuler: Boolean; cdecl;
    function hasHorizontalScroller: Boolean; cdecl;
    function hasVerticalRuler: Boolean; cdecl;
    function hasVerticalScroller: Boolean; cdecl;
    function horizontalLineScroll: Single; cdecl;
    function horizontalPageScroll: Single; cdecl;
    function horizontalRulerView: NSRulerView; cdecl;
    function horizontalScroller: NSScroller; cdecl;
    function lineScroll: Single; cdecl;
    function pageScroll: Single; cdecl;
    procedure reflectScrolledClipView(cView: NSClipView); cdecl;
    function rulersVisible: Boolean; cdecl;
    procedure scrollWheel(theEvent: NSEvent); cdecl;
    function scrollsDynamically: Boolean; cdecl;
    procedure setAutohidesScrollers(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBorderType(aType: NSBorderType); cdecl;
    procedure setContentView(contentView: NSClipView); cdecl;
    procedure setDocumentCursor(anObj: NSCursor); cdecl;
    procedure setDocumentView(aView: NSView); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setHasHorizontalRuler(flag: Boolean); cdecl;
    procedure setHasHorizontalScroller(flag: Boolean); cdecl;
    procedure setHasVerticalRuler(flag: Boolean); cdecl;
    procedure setHasVerticalScroller(flag: Boolean); cdecl;
    procedure setHorizontalLineScroll(value: Single); cdecl;
    procedure setHorizontalPageScroll(value: Single); cdecl;
    procedure setHorizontalRulerView(ruler: NSRulerView); cdecl;
    procedure setHorizontalScroller(anObject: NSScroller); cdecl;
    procedure setLineScroll(value: Single); cdecl;
    procedure setPageScroll(value: Single); cdecl;
    procedure setRulersVisible(flag: Boolean); cdecl;
    procedure setScrollsDynamically(flag: Boolean); cdecl;
    procedure setVerticalLineScroll(value: Single); cdecl;
    procedure setVerticalPageScroll(value: Single); cdecl;
    procedure setVerticalRulerView(ruler: NSRulerView); cdecl;
    procedure setVerticalScroller(anObject: NSScroller); cdecl;
    procedure tile; cdecl;
    function verticalLineScroll: Single; cdecl;
    function verticalPageScroll: Single; cdecl;
    function verticalRulerView: NSRulerView; cdecl;
    function verticalScroller: NSScroller; cdecl;
  end;
  TNSScrollView = class(TOCGenericImport<NSScrollViewClass, NSScrollView>)  end;

  NSCollectionViewClass = interface(NSViewClass)
    ['{0C51BCC0-30D4-4D41-85BC-46B6BF28CB9D}']
  end;
  NSCollectionView = interface(NSView)
    ['{95C36E28-A34C-46BF-837B-574F4EB0A36F}']
    function allowsMultipleSelection: Boolean; cdecl;
    function backgroundColors: NSArray; cdecl;
    function content: NSArray; cdecl;
    function delegate: NSCollectionViewDelegate; cdecl;
    function draggingImageForItemsAtIndexes(indexes: NSIndexSet; withEvent: NSEvent; offset: NSPointPointer): NSImage; cdecl;
    function frameForItemAtIndex(index: NSUInteger): NSRect; cdecl;
    function isFirstResponder: Boolean; cdecl;
    function isSelectable: Boolean; cdecl;
    function itemAtIndex(index: NSUInteger): NSCollectionViewItem; cdecl;
    function itemPrototype: NSCollectionViewItem; cdecl;
    function maxItemSize: NSSize; cdecl;
    function maxNumberOfColumns: NSUInteger; cdecl;
    function maxNumberOfRows: NSUInteger; cdecl;
    function minItemSize: NSSize; cdecl;
    function newItemForRepresentedObject(object_: Pointer): NSCollectionViewItem; cdecl;
    function selectionIndexes: NSIndexSet; cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    procedure setBackgroundColors(colors: NSArray); cdecl;
    procedure setContent(content: NSArray); cdecl;
    procedure setDelegate(aDelegate: NSCollectionViewDelegate); cdecl;
    procedure setDraggingSourceOperationMask(dragOperationMask: NSDragOperation; forLocal: Boolean); cdecl;
    procedure setItemPrototype(prototype: NSCollectionViewItem); cdecl;
    procedure setMaxItemSize(size: NSSize); cdecl;
    procedure setMaxNumberOfColumns(number: NSUInteger); cdecl;
    procedure setMaxNumberOfRows(number: NSUInteger); cdecl;
    procedure setMinItemSize(size: NSSize); cdecl;
    procedure setSelectable(flag: Boolean); cdecl;
    procedure setSelectionIndexes(indexes: NSIndexSet); cdecl;
  end;
  TNSCollectionView = class(TOCGenericImport<NSCollectionViewClass, NSCollectionView>)  end;

  NSArrayControllerClass = interface(NSObjectControllerClass)
    ['{5D7C7C78-7733-45B3-902A-0F8B952D5945}']
  end;
  NSArrayController = interface(NSObjectController)
    ['{ADAD4C6D-DFB2-4D41-97A6-5CD25C74EFD6}']
    procedure add(sender: Pointer); cdecl;
    procedure addObject(object_: Pointer); cdecl;
    procedure addObjects(objects: NSArray); cdecl;
    function addSelectedObjects(objects: NSArray): Boolean; cdecl;
    function addSelectionIndexes(indexes: NSIndexSet): Boolean; cdecl;
    function alwaysUsesMultipleValuesMarker: Boolean; cdecl;
    function arrangeObjects(objects: NSArray): NSArray; cdecl;
    function arrangedObjects: Pointer; cdecl;
    function automaticRearrangementKeyPaths: NSArray; cdecl;
    function automaticallyRearrangesObjects: Boolean; cdecl;
    function avoidsEmptySelection: Boolean; cdecl;
    function canInsert: Boolean; cdecl;
    function canSelectNext: Boolean; cdecl;
    function canSelectPrevious: Boolean; cdecl;
    function clearsFilterPredicateOnInsertion: Boolean; cdecl;
    procedure didChangeArrangementCriteria; cdecl;
    function filterPredicate: NSPredicate; cdecl;
    procedure insert(sender: Pointer); cdecl;
    procedure insertObject(object_: Pointer; atArrangedObjectIndex: NSUInteger); cdecl;
    procedure insertObjects(objects: NSArray; atArrangedObjectIndexes: NSIndexSet); cdecl;
    function preservesSelection: Boolean; cdecl;
    procedure rearrangeObjects; cdecl;
    procedure remove(sender: Pointer); cdecl;
    procedure removeObject(object_: Pointer); cdecl;
    procedure removeObjectAtArrangedObjectIndex(index: NSUInteger); cdecl;
    procedure removeObjects(objects: NSArray); cdecl;
    procedure removeObjectsAtArrangedObjectIndexes(indexes: NSIndexSet); cdecl;
    function removeSelectedObjects(objects: NSArray): Boolean; cdecl;
    function removeSelectionIndexes(indexes: NSIndexSet): Boolean; cdecl;
    procedure selectNext(sender: Pointer); cdecl;
    procedure selectPrevious(sender: Pointer); cdecl;
    function selectedObjects: NSArray; cdecl;
    function selectionIndex: NSUInteger; cdecl;
    function selectionIndexes: NSIndexSet; cdecl;
    function selectsInsertedObjects: Boolean; cdecl;
    procedure setAlwaysUsesMultipleValuesMarker(flag: Boolean); cdecl;
    procedure setAutomaticallyRearrangesObjects(flag: Boolean); cdecl;
    procedure setAvoidsEmptySelection(flag: Boolean); cdecl;
    procedure setClearsFilterPredicateOnInsertion(flag: Boolean); cdecl;
    procedure setFilterPredicate(filterPredicate: NSPredicate); cdecl;
    procedure setPreservesSelection(flag: Boolean); cdecl;
    function setSelectedObjects(objects: NSArray): Boolean; cdecl;
    function setSelectionIndex(index: NSUInteger): Boolean; cdecl;
    function setSelectionIndexes(indexes: NSIndexSet): Boolean; cdecl;
    procedure setSelectsInsertedObjects(flag: Boolean); cdecl;
    procedure setSortDescriptors(sortDescriptors: NSArray); cdecl;
    function sortDescriptors: NSArray; cdecl;
  end;
  TNSArrayController = class(TOCGenericImport<NSArrayControllerClass, NSArrayController>)  end;

  NSTextViewClass = interface(NSTextClass)
    ['{12621269-39BE-4BCB-AED2-51A228B41094}']
    {class} procedure registerForServices; cdecl;
  end;
  NSTextView = interface(NSText)
    ['{EF732A3D-50CB-4E2C-8538-F9DBC4D932F1}']
    function acceptableDragTypes: NSArray; cdecl;
    function acceptsGlyphInfo: Boolean; cdecl;
    procedure alignJustified(sender: Pointer); cdecl;
    function allowedInputSourceLocales: NSArray; cdecl;
    function allowsDocumentBackgroundColorChange: Boolean; cdecl;
    function allowsImageEditing: Boolean; cdecl;
    function allowsUndo: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    procedure breakUndoCoalescing; cdecl;
    procedure changeAttributes(sender: Pointer); cdecl;
    procedure changeColor(sender: Pointer); cdecl;
    procedure changeDocumentBackgroundColor(sender: Pointer); cdecl;
    function characterIndexForInsertionAtPoint(point: NSPoint): NSUInteger; cdecl;
    procedure checkTextInDocument(sender: Pointer); cdecl;
    procedure checkTextInRange(range: NSRange; types: NSTextCheckingTypes; options: NSDictionary); cdecl;
    procedure checkTextInSelection(sender: Pointer); cdecl;
    procedure cleanUpAfterDragOperation; cdecl;
    procedure clickedOnLink(link: Pointer; atIndex: NSUInteger); cdecl;
    procedure complete(sender: Pointer); cdecl;
    function completionsForPartialWordRange(charRange: NSRange; indexOfSelectedItem: NSInteger): NSArray; cdecl;
    function defaultParagraphStyle: NSParagraphStyle; cdecl;
    function delegate: NSTextViewDelegate; cdecl;
    procedure didChangeText; cdecl;
    function displaysLinkToolTips: Boolean; cdecl;
    function dragImageForSelectionWithEvent(event: NSEvent; origin: NSPointPointer): NSImage; cdecl;
    function dragSelectionWithEvent(event: NSEvent; offset: NSSize; slideBack: Boolean): Boolean; cdecl;
    procedure drawInsertionPointInRect(rect: NSRect; color: NSColor; turnedOn: Boolean); cdecl;
    procedure drawViewBackgroundInRect(rect: NSRect); cdecl;
    function drawsBackground: Boolean; cdecl;
    function enabledTextCheckingTypes: NSTextCheckingTypes; cdecl;
    procedure handleTextCheckingResults(results: NSArray; forRange: NSRange; types: NSTextCheckingTypes; options: NSDictionary; orthography: NSOrthography; wordCount: NSInteger); cdecl;
    function importsGraphics: Boolean; cdecl;
    function initWithFrame(frameRect: NSRect): Pointer; cdecl; overload;
    function initWithFrame(frameRect: NSRect; textContainer: NSTextContainer): Pointer; cdecl; overload;
    procedure insertCompletion(word: NSString; forPartialWordRange: NSRange; movement: NSInteger; isFinal: Boolean); cdecl;
    procedure insertText(insertString: Pointer); cdecl;
    function insertionPointColor: NSColor; cdecl;
    procedure invalidateTextContainerOrigin; cdecl;
    function isAutomaticDashSubstitutionEnabled: Boolean; cdecl;
    function isAutomaticDataDetectionEnabled: Boolean; cdecl;
    function isAutomaticLinkDetectionEnabled: Boolean; cdecl;
    function isAutomaticQuoteSubstitutionEnabled: Boolean; cdecl;
    function isAutomaticSpellingCorrectionEnabled: Boolean; cdecl;
    function isAutomaticTextReplacementEnabled: Boolean; cdecl;
    function isCoalescingUndo: Boolean; cdecl;
    function isContinuousSpellCheckingEnabled: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isFieldEditor: Boolean; cdecl;
    function isGrammarCheckingEnabled: Boolean; cdecl;
    function isRichText: Boolean; cdecl;
    function isRulerVisible: Boolean; cdecl;
    function isSelectable: Boolean; cdecl;
    function layoutManager: NSLayoutManager; cdecl;
    function linkTextAttributes: NSDictionary; cdecl;
    procedure loosenKerning(sender: Pointer); cdecl;
    procedure lowerBaseline(sender: Pointer); cdecl;
    function markedTextAttributes: NSDictionary; cdecl;
    procedure orderFrontLinkPanel(sender: Pointer); cdecl;
    procedure orderFrontListPanel(sender: Pointer); cdecl;
    procedure orderFrontSpacingPanel(sender: Pointer); cdecl;
    procedure orderFrontSubstitutionsPanel(sender: Pointer); cdecl;
    procedure orderFrontTablePanel(sender: Pointer); cdecl;
    procedure outline(sender: Pointer); cdecl;
    procedure pasteAsPlainText(sender: Pointer); cdecl;
    procedure pasteAsRichText(sender: Pointer); cdecl;
    procedure performFindPanelAction(sender: Pointer); cdecl;
    function preferredPasteboardTypeFromArray(availableTypes: NSArray; restrictedToTypesFromArray: NSArray): NSString; cdecl;
    procedure raiseBaseline(sender: Pointer); cdecl;
    function rangeForUserCharacterAttributeChange: NSRange; cdecl;
    function rangeForUserCompletion: NSRange; cdecl;
    function rangeForUserParagraphAttributeChange: NSRange; cdecl;
    function rangeForUserTextChange: NSRange; cdecl;
    function rangesForUserCharacterAttributeChange: NSArray; cdecl;
    function rangesForUserParagraphAttributeChange: NSArray; cdecl;
    function rangesForUserTextChange: NSArray; cdecl;
    function readSelectionFromPasteboard(pboard: NSPasteboard): Boolean; cdecl; overload;
    function readablePasteboardTypes: NSArray; cdecl;
    procedure replaceTextContainer(newContainer: NSTextContainer); cdecl;
    procedure rulerView(ruler: NSRulerView; didAddMarker: NSRulerMarker); cdecl; overload;
//    procedure rulerView(ruler: NSRulerView; didMoveMarker: NSRulerMarker); cdecl; overload;
//    procedure rulerView(ruler: NSRulerView; didRemoveMarker: NSRulerMarker); cdecl; overload;
    procedure rulerView(ruler: NSRulerView; handleMouseDown: NSEvent); cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldAddMarker: NSRulerMarker): Boolean; cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldMoveMarker: NSRulerMarker): Boolean; cdecl; overload;
//    function rulerView(ruler: NSRulerView; shouldRemoveMarker: NSRulerMarker): Boolean; cdecl; overload;
    function rulerView(ruler: NSRulerView; willAddMarker: NSRulerMarker; atLocation: Single): Single; cdecl; overload;
//    function rulerView(ruler: NSRulerView; willMoveMarker: NSRulerMarker; toLocation: Single): Single; cdecl; overload;
    function selectedRanges: NSArray; cdecl;
    function selectedTextAttributes: NSDictionary; cdecl;
    function selectionAffinity: NSSelectionAffinity; cdecl;
    function selectionGranularity: NSSelectionGranularity; cdecl;
    function selectionRangeForProposedRange(proposedCharRange: NSRange; granularity: NSSelectionGranularity): NSRange; cdecl;
    procedure setAcceptsGlyphInfo(flag: Boolean); cdecl;
    procedure setAlignment(alignment: NSTextAlignment; range: NSRange); cdecl;
    procedure setAllowedInputSourceLocales(localeIdentifiers: NSArray); cdecl;
    procedure setAllowsDocumentBackgroundColorChange(flag: Boolean); cdecl;
    procedure setAllowsImageEditing(flag: Boolean); cdecl;
    procedure setAllowsUndo(flag: Boolean); cdecl;
    procedure setAutomaticDashSubstitutionEnabled(flag: Boolean); cdecl;
    procedure setAutomaticDataDetectionEnabled(flag: Boolean); cdecl;
    procedure setAutomaticLinkDetectionEnabled(flag: Boolean); cdecl;
    procedure setAutomaticQuoteSubstitutionEnabled(flag: Boolean); cdecl;
    procedure setAutomaticSpellingCorrectionEnabled(flag: Boolean); cdecl;
    procedure setAutomaticTextReplacementEnabled(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBaseWritingDirection(writingDirection: NSWritingDirection; range: NSRange); cdecl;
    procedure setConstrainedFrameSize(desiredSize: NSSize); cdecl;
    procedure setContinuousSpellCheckingEnabled(flag: Boolean); cdecl;
    procedure setDefaultParagraphStyle(paragraphStyle: NSParagraphStyle); cdecl;
    procedure setDelegate(anObject: NSTextViewDelegate); cdecl;
    procedure setDisplaysLinkToolTips(flag: Boolean); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setEnabledTextCheckingTypes(checkingTypes: NSTextCheckingTypes); cdecl;
    procedure setFieldEditor(flag: Boolean); cdecl;
    procedure setGrammarCheckingEnabled(flag: Boolean); cdecl;
    procedure setImportsGraphics(flag: Boolean); cdecl;
    procedure setInsertionPointColor(color: NSColor); cdecl;
    procedure setLinkTextAttributes(attributeDictionary: NSDictionary); cdecl;
    procedure setMarkedTextAttributes(attributeDictionary: NSDictionary); cdecl;
    procedure setNeedsDisplayInRect(rect: NSRect; avoidAdditionalLayout: Boolean); cdecl;
    procedure setRichText(flag: Boolean); cdecl;
    procedure setRulerVisible(flag: Boolean); cdecl;
    procedure setSelectable(flag: Boolean); cdecl;
    procedure setSelectedRange(charRange: NSRange); cdecl; overload;
    procedure setSelectedRange(charRange: NSRange; affinity: NSSelectionAffinity; stillSelecting: Boolean); cdecl; overload;
    procedure setSelectedRanges(ranges: NSArray); cdecl; overload;
    procedure setSelectedRanges(ranges: NSArray; affinity: NSSelectionAffinity; stillSelecting: Boolean); cdecl; overload;
    procedure setSelectedTextAttributes(attributeDictionary: NSDictionary); cdecl;
    procedure setSelectionGranularity(granularity: NSSelectionGranularity); cdecl;
    procedure setSmartInsertDeleteEnabled(flag: Boolean); cdecl;
    procedure setSpellingState(value: NSInteger; range: NSRange); cdecl;
    procedure setTextContainer(container: NSTextContainer); cdecl;
    procedure setTextContainerInset(inset: NSSize); cdecl;
    procedure setTypingAttributes(attrs: NSDictionary); cdecl;
    procedure setUsesFindPanel(flag: Boolean); cdecl;
    procedure setUsesFontPanel(flag: Boolean); cdecl;
    procedure setUsesRuler(flag: Boolean); cdecl;
    function shouldChangeTextInRange(affectedCharRange: NSRange; replacementString: NSString): Boolean; cdecl;
    function shouldChangeTextInRanges(affectedRanges: NSArray; replacementStrings: NSArray): Boolean; cdecl;
    function shouldDrawInsertionPoint: Boolean; cdecl;
    procedure showFindIndicatorForRange(charRange: NSRange); cdecl;
    function smartDeleteRangeForProposedRange(proposedCharRange: NSRange): NSRange; cdecl;
    function smartInsertAfterStringForString(pasteString: NSString; replacingRange: NSRange): NSString; cdecl;
    function smartInsertBeforeStringForString(pasteString: NSString; replacingRange: NSRange): NSString; cdecl;
    function smartInsertDeleteEnabled: Boolean; cdecl;
    procedure smartInsertForString(pasteString: NSString; replacingRange: NSRange; beforeString: NSString; afterString: NSString); cdecl;
    function spellCheckerDocumentTag: NSInteger; cdecl;
    procedure startSpeaking(sender: Pointer); cdecl;
    procedure stopSpeaking(sender: Pointer); cdecl;
    function textContainer: NSTextContainer; cdecl;
    function textContainerInset: NSSize; cdecl;
    function textContainerOrigin: NSPoint; cdecl;
    function textStorage: NSTextStorage; cdecl;
    procedure tightenKerning(sender: Pointer); cdecl;
    procedure toggleAutomaticDashSubstitution(sender: Pointer); cdecl;
    procedure toggleAutomaticDataDetection(sender: Pointer); cdecl;
    procedure toggleAutomaticLinkDetection(sender: Pointer); cdecl;
    procedure toggleAutomaticQuoteSubstitution(sender: Pointer); cdecl;
    procedure toggleAutomaticSpellingCorrection(sender: Pointer); cdecl;
    procedure toggleAutomaticTextReplacement(sender: Pointer); cdecl;
    procedure toggleBaseWritingDirection(sender: Pointer); cdecl;
    procedure toggleContinuousSpellChecking(sender: Pointer); cdecl;
    procedure toggleGrammarChecking(sender: Pointer); cdecl;
    procedure toggleSmartInsertDelete(sender: Pointer); cdecl;
    procedure toggleTraditionalCharacterShape(sender: Pointer); cdecl;
    procedure turnOffKerning(sender: Pointer); cdecl;
    procedure turnOffLigatures(sender: Pointer); cdecl;
    function typingAttributes: NSDictionary; cdecl;
    procedure updateDragTypeRegistration; cdecl;
    procedure updateFontPanel; cdecl;
    procedure updateInsertionPointStateAndRestartTimer(restartFlag: Boolean); cdecl;
    procedure updateRuler; cdecl;
    procedure useAllLigatures(sender: Pointer); cdecl;
    procedure useStandardKerning(sender: Pointer); cdecl;
    procedure useStandardLigatures(sender: Pointer); cdecl;
    function usesFindPanel: Boolean; cdecl;
    function usesFontPanel: Boolean; cdecl;
    function usesRuler: Boolean; cdecl;
    function validRequestorForSendType(sendType: NSString; returnType: NSString): Pointer; cdecl;
    function writablePasteboardTypes: NSArray; cdecl;
    function writeSelectionToPasteboard(pboard: NSPasteboard; types: NSArray): Boolean; cdecl; overload;
  end;
  TNSTextView = class(TOCGenericImport<NSTextViewClass, NSTextView>)  end;

  NSImageViewClass = interface(NSControlClass)
    ['{8F5F2969-B3CA-4A55-B3AB-8CF061ABF084}']
  end;
  NSImageView = interface(NSControl)
    ['{DA0C0ED5-6192-4AE1-A766-A092B79E1CE5}']
    function allowsCutCopyPaste: Boolean; cdecl;
    function animates: Boolean; cdecl;
    function image: NSImage; cdecl;
    function imageAlignment: NSImageAlignment; cdecl;
    function imageFrameStyle: NSImageFrameStyle; cdecl;
    function imageScaling: NSImageScaling; cdecl;
    function isEditable: Boolean; cdecl;
    procedure setAllowsCutCopyPaste(allow: Boolean); cdecl;
    procedure setAnimates(flag: Boolean); cdecl;
    procedure setEditable(yn: Boolean); cdecl;
    procedure setImage(newImage: NSImage); cdecl;
    procedure setImageAlignment(newAlign: NSImageAlignment); cdecl;
    procedure setImageFrameStyle(newStyle: NSImageFrameStyle); cdecl;
    procedure setImageScaling(newScaling: NSImageScaling); cdecl;
  end;
  TNSImageView = class(TOCGenericImport<NSImageViewClass, NSImageView>)  end;

  NSLevelIndicatorClass = interface(NSControlClass)
    ['{9F5E1680-0618-4D7C-89E3-A9E011857D56}']
  end;
  NSLevelIndicator = interface(NSControl)
    ['{E2C72A65-8B0C-4B28-B49B-82C0F879D551}']
    function criticalValue: double; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    function numberOfMajorTickMarks: NSInteger; cdecl;
    function numberOfTickMarks: NSInteger; cdecl;
    function rectOfTickMarkAtIndex(index: NSInteger): NSRect; cdecl;
    procedure setCriticalValue(criticalValue: double); cdecl;
    procedure setMaxValue(maxValue: double); cdecl;
    procedure setMinValue(minValue: double); cdecl;
    procedure setNumberOfMajorTickMarks(count: NSInteger); cdecl;
    procedure setNumberOfTickMarks(count: NSInteger); cdecl;
    procedure setTickMarkPosition(position: NSTickMarkPosition); cdecl;
    procedure setWarningValue(warningValue: double); cdecl;
    function tickMarkPosition: NSTickMarkPosition; cdecl;
    function tickMarkValueAtIndex(index: NSInteger): double; cdecl;
    function warningValue: double; cdecl;
  end;
  TNSLevelIndicator = class(TOCGenericImport<NSLevelIndicatorClass, NSLevelIndicator>)  end;

  NSFontPanelClass = interface(NSPanelClass)
    ['{86F28FFC-0F78-482F-AD90-263F81855F71}']
    {class} function sharedFontPanel: Pointer; cdecl;
    {class} function sharedFontPanelExists: Boolean; cdecl;
  end;
  NSFontPanel = interface(NSPanel)
    ['{E75C63C2-81A6-4C3A-8E6C-FB2C7E12D8D8}']
    function accessoryView: NSView; cdecl;
    function isEnabled: Boolean; cdecl;
    function panelConvertFont(fontObj: NSFont): NSFont; cdecl;
    procedure reloadDefaultFontFamilies; cdecl;
    procedure setAccessoryView(aView: NSView); cdecl;
    procedure setEnabled(flag: Boolean); cdecl;
    procedure setPanelFont(fontObj: NSFont; isMultiple: Boolean); cdecl;
    function worksWhenModal: Boolean; cdecl;
  end;
  TNSFontPanel = class(TOCGenericImport<NSFontPanelClass, NSFontPanel>)  end;

  NSTokenFieldCellClass = interface(NSTextFieldCellClass)
    ['{4BE2DCD3-0C0C-4718-B2E3-F09786358A61}']
    {class} function defaultCompletionDelay: NSTimeInterval; cdecl;
    {class} function defaultTokenizingCharacterSet: NSCharacterSet; cdecl;
  end;
  NSTokenFieldCell = interface(NSTextFieldCell)
    ['{312CF34F-E90D-4CD9-B4BB-D7EA528FFBA5}']
    function completionDelay: NSTimeInterval; cdecl;
    function delegate: NSTokenFieldCellDelegate; cdecl;
    procedure setCompletionDelay(delay: NSTimeInterval); cdecl;
    procedure setDelegate(anObject: NSTokenFieldCellDelegate); cdecl;
    procedure setTokenStyle(style: NSTokenStyle); cdecl;
    procedure setTokenizingCharacterSet(characterSet: NSCharacterSet); cdecl;
    function tokenStyle: NSTokenStyle; cdecl;
    function tokenizingCharacterSet: NSCharacterSet; cdecl;
  end;
  TNSTokenFieldCell = class(TOCGenericImport<NSTokenFieldCellClass, NSTokenFieldCell>)  end;

  NSColorPanelClass = interface(NSPanelClass)
    ['{707AD100-884C-49ED-80D6-77E661074C77}']
    {class} function dragColor(color: NSColor; withEvent: NSEvent; fromView: NSView): Boolean; cdecl;
    {class} procedure setPickerMask(mask: NSUInteger); cdecl;
    {class} procedure setPickerMode(mode: NSColorPanelMode); cdecl;
    {class} function sharedColorPanel: Pointer; cdecl;
    {class} function sharedColorPanelExists: Boolean; cdecl;
  end;
  NSColorPanel = interface(NSPanel)
    ['{F3A8E1DF-2476-4A0B-AE4D-2C8D0C88E5FC}']
    function accessoryView: NSView; cdecl;
    function alpha: Single; cdecl;
    procedure attachColorList(colorList: NSColorList); cdecl;
    function color: NSColor; cdecl;
    procedure detachColorList(colorList: NSColorList); cdecl;
    function isContinuous: Boolean; cdecl;
    function mode: NSColorPanelMode; cdecl;
    procedure setAccessoryView(aView: NSView); cdecl;
    procedure setAction(aSelector: SEL); cdecl;
    procedure setColor(color: NSColor); cdecl;
    procedure setContinuous(flag: Boolean); cdecl;
    procedure setMode(mode: NSColorPanelMode); cdecl;
    procedure setShowsAlpha(flag: Boolean); cdecl;
    procedure setTarget(anObject: Pointer); cdecl;
    function showsAlpha: Boolean; cdecl;
  end;
  TNSColorPanel = class(TOCGenericImport<NSColorPanelClass, NSColorPanel>)  end;

  NSButtonClass = interface(NSControlClass)
    ['{7277596B-5B99-46CE-A404-C981F7456114}']
  end;
  NSButton = interface(NSControl)
    ['{6DE8CCED-A6EE-484D-8506-CE8169878B09}']
    function allowsMixedState: Boolean; cdecl;
    function alternateImage: NSImage; cdecl;
    function alternateTitle: NSString; cdecl;
    function attributedAlternateTitle: NSAttributedString; cdecl;
    function attributedTitle: NSAttributedString; cdecl;
    function bezelStyle: NSBezelStyle; cdecl;
    procedure getPeriodicDelay(delay: PSingle; interval: PSingle); cdecl;
    procedure highlight(flag: Boolean); cdecl;
    function image: NSImage; cdecl;
    function imagePosition: NSCellImagePosition; cdecl;
    function isBordered: Boolean; cdecl;
    function isTransparent: Boolean; cdecl;
    function keyEquivalent: NSString; cdecl;
    function keyEquivalentModifierMask: NSUInteger; cdecl;
    function performKeyEquivalent(key: NSEvent): Boolean; cdecl;
    procedure setAllowsMixedState(flag: Boolean); cdecl;
    procedure setAlternateImage(image: NSImage); cdecl;
    procedure setAlternateTitle(aString: NSString); cdecl;
    procedure setAttributedAlternateTitle(obj: NSAttributedString); cdecl;
    procedure setAttributedTitle(aString: NSAttributedString); cdecl;
    procedure setBezelStyle(bezelStyle: NSBezelStyle); cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setButtonType(aType: NSButtonType); cdecl;
    procedure setImage(image: NSImage); cdecl;
    procedure setImagePosition(aPosition: NSCellImagePosition); cdecl;
    procedure setKeyEquivalent(charCode: NSString); cdecl;
    procedure setKeyEquivalentModifierMask(mask: NSUInteger); cdecl;
    procedure setNextState; cdecl;
    procedure setPeriodicDelay(delay: Single; interval: Single); cdecl;
    procedure setShowsBorderOnlyWhileMouseInside(show: Boolean); cdecl;
    procedure setSound(aSound: NSSound); cdecl;
    procedure setState(value: NSInteger); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    procedure setTransparent(flag: Boolean); cdecl;
    function showsBorderOnlyWhileMouseInside: Boolean; cdecl;
    function sound: NSSound; cdecl;
    function state: NSInteger; cdecl;
    function title: NSString; cdecl;
  end;
  TNSButton = class(TOCGenericImport<NSButtonClass, NSButton>)  end;

  NSBrowserClass = interface(NSControlClass)
    ['{92C37361-D8D6-4CA2-876C-A0C7E7BC8721}']
    {class} procedure removeSavedColumnsWithAutosaveName(name: NSString); cdecl;
  end;
  NSBrowser = interface(NSControl)
    ['{ED2C8E2E-6232-4F1F-A61E-DC02BF5F6653}']
    function acceptsArrowKeys: Boolean; cdecl;
    procedure addColumn; cdecl;
    function allowsBranchSelection: Boolean; cdecl;
    function allowsEmptySelection: Boolean; cdecl;
    function allowsMultipleSelection: Boolean; cdecl;
    function allowsTypeSelect: Boolean; cdecl;
    function autohidesScroller: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function canDragRowsWithIndexes(rowIndexes: NSIndexSet; inColumn: NSInteger; withEvent: NSEvent): Boolean; cdecl;
    function cellPrototype: Pointer; cdecl;
    function clickedColumn: NSInteger; cdecl;
    function clickedRow: NSInteger; cdecl;
    function columnContentWidthForColumnWidth(columnWidth: Single): Single; cdecl;
    function columnOfMatrix(matrix: NSMatrix): NSInteger; cdecl;
    function columnResizingType: NSBrowserColumnResizingType; cdecl;
    function columnWidthForColumnContentWidth(columnContentWidth: Single): Single; cdecl;
    function columnsAutosaveName: NSString; cdecl;
    function defaultColumnWidth: Single; cdecl;
    function delegate: NSBrowserDelegate; cdecl;
    procedure displayAllColumns; cdecl;
    procedure displayColumn(column: NSInteger); cdecl;
    procedure doClick(sender: Pointer); cdecl;
    procedure doDoubleClick(sender: Pointer); cdecl;
    function doubleAction: SEL; cdecl;
    function draggingImageForRowsWithIndexes(rowIndexes: NSIndexSet; inColumn: NSInteger; withEvent: NSEvent; offset: NSPointPointer): NSImage; cdecl;
    procedure drawTitleOfColumn(column: NSInteger; inRect: NSRect); cdecl;
    procedure editItemAtIndexPath(indexPath: NSIndexPath; withEvent: NSEvent; select: Boolean); cdecl;
    function firstVisibleColumn: NSInteger; cdecl;
    function frameOfColumn(column: NSInteger): NSRect; cdecl;
    function frameOfInsideOfColumn(column: NSInteger): NSRect; cdecl;
    function frameOfRow(row: NSInteger; inColumn: NSInteger): NSRect; cdecl;
    function getRow(row: NSInteger; column: NSInteger; forPoint: NSPoint): Boolean; cdecl;
    function hasHorizontalScroller: Boolean; cdecl;
    function indexPathForColumn(column: NSInteger): NSIndexPath; cdecl;
    function isLeafItem(item: Pointer): Boolean; cdecl;
    function isLoaded: Boolean; cdecl;
    function isTitled: Boolean; cdecl;
    function itemAtIndexPath(indexPath: NSIndexPath): Pointer; cdecl;
    function itemAtRow(row: NSInteger; inColumn: NSInteger): Pointer; cdecl;
    function lastColumn: NSInteger; cdecl;
    function lastVisibleColumn: NSInteger; cdecl;
    procedure loadColumnZero; cdecl;
    function loadedCellAtRow(row: NSInteger; column: NSInteger): Pointer; cdecl;
    function matrixInColumn(column: NSInteger): NSMatrix; cdecl;
    function maxVisibleColumns: NSInteger; cdecl;
    function minColumnWidth: Single; cdecl;
    procedure noteHeightOfRowsWithIndexesChanged(indexSet: NSIndexSet; inColumn: NSInteger); cdecl;
    function numberOfVisibleColumns: NSInteger; cdecl;
    function parentForItemsInColumn(column: NSInteger): Pointer; cdecl;
    function path: NSString; cdecl;
    function pathSeparator: NSString; cdecl;
    function pathToColumn(column: NSInteger): NSString; cdecl;
    function prefersAllColumnUserResizing: Boolean; cdecl;
    procedure reloadColumn(column: NSInteger); cdecl;
    procedure reloadDataForRowIndexes(rowIndexes: NSIndexSet; inColumn: NSInteger); cdecl;
    function reusesColumns: Boolean; cdecl;
    function rowHeight: Single; cdecl;
    procedure scrollColumnToVisible(column: NSInteger); cdecl;
    procedure scrollColumnsLeftBy(shiftAmount: NSInteger); cdecl;
    procedure scrollColumnsRightBy(shiftAmount: NSInteger); cdecl;
    procedure scrollRowToVisible(row: NSInteger; inColumn: NSInteger); cdecl;
    procedure scrollViaScroller(sender: NSScroller); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure selectRow(row: NSInteger; inColumn: NSInteger); cdecl;
    procedure selectRowIndexes(indexes: NSIndexSet; inColumn: NSInteger); cdecl;
    function selectedCell: Pointer; cdecl;
    function selectedCellInColumn(column: NSInteger): Pointer; cdecl;
    function selectedCells: NSArray; cdecl;
    function selectedColumn: NSInteger; cdecl;
    function selectedRowInColumn(column: NSInteger): NSInteger; cdecl;
    function selectedRowIndexesInColumn(column: NSInteger): NSIndexSet; cdecl;
    function selectionIndexPath: NSIndexPath; cdecl;
    function selectionIndexPaths: NSArray; cdecl;
    function sendAction: Boolean; cdecl;
    function sendsActionOnArrowKeys: Boolean; cdecl;
    function separatesColumns: Boolean; cdecl;
    procedure setAcceptsArrowKeys(flag: Boolean); cdecl;
    procedure setAllowsBranchSelection(flag: Boolean); cdecl;
    procedure setAllowsEmptySelection(flag: Boolean); cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    procedure setAllowsTypeSelect(value: Boolean); cdecl;
    procedure setAutohidesScroller(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setCellClass(factoryId: Pointer); cdecl;
    procedure setCellPrototype(aCell: NSCell); cdecl;
    procedure setColumnResizingType(columnResizingType: NSBrowserColumnResizingType); cdecl;
    procedure setColumnsAutosaveName(name: NSString); cdecl;
    procedure setDefaultColumnWidth(columnWidth: Single); cdecl;
    procedure setDelegate(anObject: NSBrowserDelegate); cdecl;
    procedure setDoubleAction(aSelector: SEL); cdecl;
    procedure setDraggingSourceOperationMask(mask: NSDragOperation; forLocal: Boolean); cdecl;
    procedure setHasHorizontalScroller(flag: Boolean); cdecl;
    procedure setLastColumn(column: NSInteger); cdecl;
    procedure setMatrixClass(factoryId: Pointer); cdecl;
    procedure setMaxVisibleColumns(columnCount: NSInteger); cdecl;
    procedure setMinColumnWidth(columnWidth: Single); cdecl;
    function setPath(path: NSString): Boolean; cdecl;
    procedure setPathSeparator(newString: NSString); cdecl;
    procedure setPrefersAllColumnUserResizing(prefersAllColumnResizing: Boolean); cdecl;
    procedure setReusesColumns(flag: Boolean); cdecl;
    procedure setRowHeight(height: Single); cdecl;
    procedure setSelectionIndexPath(path: NSIndexPath); cdecl;
    procedure setSelectionIndexPaths(paths: NSArray); cdecl;
    procedure setSendsActionOnArrowKeys(flag: Boolean); cdecl;
    procedure setSeparatesColumns(flag: Boolean); cdecl;
    procedure setTakesTitleFromPreviousColumn(flag: Boolean); cdecl;
    procedure setTitle(aString: NSString; ofColumn: NSInteger); cdecl;
    procedure setTitled(flag: Boolean); cdecl;
    procedure setWidth(columnWidth: Single; ofColumn: NSInteger); cdecl;
    function takesTitleFromPreviousColumn: Boolean; cdecl;
    procedure tile; cdecl;
    function titleFrameOfColumn(column: NSInteger): NSRect; cdecl;
    function titleHeight: Single; cdecl;
    function titleOfColumn(column: NSInteger): NSString; cdecl;
    procedure updateScroller; cdecl;
    procedure validateVisibleColumns; cdecl;
    function widthOfColumn(column: NSInteger): Single; cdecl;
  end;
  TNSBrowser = class(TOCGenericImport<NSBrowserClass, NSBrowser>)  end;

  NSColorWellClass = interface(NSControlClass)
    ['{A829C44B-66B3-49CD-9DCB-C69ADBA40E65}']
  end;
  NSColorWell = interface(NSControl)
    ['{8D482DA8-A974-4E24-B1D4-AF972A0C7F05}']
    procedure activate(exclusive: Boolean); cdecl;
    function color: NSColor; cdecl;
    procedure deactivate; cdecl;
    procedure drawWellInside(insideRect: NSRect); cdecl;
    function isActive: Boolean; cdecl;
    function isBordered: Boolean; cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setColor(color: NSColor); cdecl;
    procedure takeColorFrom(sender: Pointer); cdecl;
  end;
  TNSColorWell = class(TOCGenericImport<NSColorWellClass, NSColorWell>)  end;

  NSDictionaryControllerClass = interface(NSArrayControllerClass)
    ['{7C7F6C2F-B07B-48F0-83F4-E0578982B5E0}']
  end;
  NSDictionaryController = interface(NSArrayController)
    ['{EB534AF4-6461-470B-AFAE-EBD735500B23}']
    function excludedKeys: NSArray; cdecl;
    function includedKeys: NSArray; cdecl;
    function initialKey: NSString; cdecl;
    function initialValue: Pointer; cdecl;
    function localizedKeyDictionary: NSDictionary; cdecl;
    function localizedKeyTable: NSString; cdecl;
    function newObject: Pointer; cdecl;
    procedure setExcludedKeys(keys: NSArray); cdecl;
    procedure setIncludedKeys(keys: NSArray); cdecl;
    procedure setInitialKey(key: NSString); cdecl;
    procedure setInitialValue(value: Pointer); cdecl;
    procedure setLocalizedKeyDictionary(dictionary: NSDictionary); cdecl;
    procedure setLocalizedKeyTable(stringsFileName: NSString); cdecl;
  end;
  TNSDictionaryController = class(TOCGenericImport<NSDictionaryControllerClass, NSDictionaryController>)  end;

  NSDatePickerClass = interface(NSControlClass)
    ['{AF03AE52-10C1-4BC0-A518-D351ED5DA342}']
  end;
  NSDatePicker = interface(NSControl)
    ['{572A98B1-8D62-4FDA-B6C3-C7AFBC1D0B36}']
    function backgroundColor: NSColor; cdecl;
    function calendar: NSCalendar; cdecl;
    function datePickerElements: NSDatePickerElementFlags; cdecl;
    function datePickerMode: NSDatePickerMode; cdecl;
    function datePickerStyle: NSDatePickerStyle; cdecl;
    function dateValue: NSDate; cdecl;
    function delegate: NSDatePickerCellDelegate; cdecl;
    function drawsBackground: Boolean; cdecl;
    function isBezeled: Boolean; cdecl;
    function isBordered: Boolean; cdecl;
    function locale: NSLocale; cdecl;
    function maxDate: NSDate; cdecl;
    function minDate: NSDate; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBezeled(flag: Boolean); cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setCalendar(newCalendar: NSCalendar); cdecl;
    procedure setDatePickerElements(elementFlags: NSDatePickerElementFlags); cdecl;
    procedure setDatePickerMode(newMode: NSDatePickerMode); cdecl;
    procedure setDatePickerStyle(newStyle: NSDatePickerStyle); cdecl;
    procedure setDateValue(newStartDate: NSDate); cdecl;
    procedure setDelegate(anObject: NSDatePickerCellDelegate); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setLocale(newLocale: NSLocale); cdecl;
    procedure setMaxDate(date: NSDate); cdecl;
    procedure setMinDate(date: NSDate); cdecl;
    procedure setTextColor(color: NSColor); cdecl;
    procedure setTimeInterval(newTimeInterval: NSTimeInterval); cdecl;
    procedure setTimeZone(newTimeZone: NSTimeZone); cdecl;
    function textColor: NSColor; cdecl;
    function timeInterval: NSTimeInterval; cdecl;
    function timeZone: NSTimeZone; cdecl;
  end;
  TNSDatePicker = class(TOCGenericImport<NSDatePickerClass, NSDatePicker>)  end;

  NSComboBoxCellClass = interface(NSTextFieldCellClass)
    ['{27AA0BD8-A359-4ED3-97DE-49257B608BA0}']
  end;
  NSComboBoxCell = interface(NSTextFieldCell)
    ['{4CEAA018-BC3C-4955-A984-3D16238DBB0F}']
    procedure addItemWithObjectValue(object_: Pointer); cdecl;
    procedure addItemsWithObjectValues(objects: NSArray); cdecl;
    function completedString(string_: NSString): NSString; cdecl;
    function completes: Boolean; cdecl;
    function dataSource: NSComboBoxCellDataSource; cdecl;
    procedure deselectItemAtIndex(index: NSInteger); cdecl;
    function hasVerticalScroller: Boolean; cdecl;
    function indexOfItemWithObjectValue(object_: Pointer): NSInteger; cdecl;
    function indexOfSelectedItem: NSInteger; cdecl;
    procedure insertItemWithObjectValue(object_: Pointer; atIndex: NSInteger); cdecl;
    function intercellSpacing: NSSize; cdecl;
    function isButtonBordered: Boolean; cdecl;
    function itemHeight: Single; cdecl;
    function itemObjectValueAtIndex(index: NSInteger): Pointer; cdecl;
    procedure noteNumberOfItemsChanged; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function numberOfVisibleItems: NSInteger; cdecl;
    function objectValueOfSelectedItem: Pointer; cdecl;
    function objectValues: NSArray; cdecl;
    procedure reloadData; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure removeItemWithObjectValue(object_: Pointer); cdecl;
    procedure scrollItemAtIndexToTop(index: NSInteger); cdecl;
    procedure scrollItemAtIndexToVisible(index: NSInteger); cdecl;
    procedure selectItemAtIndex(index: NSInteger); cdecl;
    procedure selectItemWithObjectValue(object_: Pointer); cdecl;
    procedure setButtonBordered(flag: Boolean); cdecl;
    procedure setCompletes(completes: Boolean); cdecl;
    procedure setDataSource(aSource: NSComboBoxCellDataSource); cdecl;
    procedure setHasVerticalScroller(flag: Boolean); cdecl;
    procedure setIntercellSpacing(aSize: NSSize); cdecl;
    procedure setItemHeight(itemHeight: Single); cdecl;
    procedure setNumberOfVisibleItems(visibleItems: NSInteger); cdecl;
    procedure setUsesDataSource(flag: Boolean); cdecl;
    function usesDataSource: Boolean; cdecl;
  end;
  TNSComboBoxCell = class(TOCGenericImport<NSComboBoxCellClass, NSComboBoxCell>)  end;

  NSPathControlClass = interface(NSControlClass)
    ['{F0345D56-145B-4A51-A14E-89A8E91EADBD}']
  end;
  NSPathControl = interface(NSControl)
    ['{E0955048-9430-4613-BEDF-429C003A71DE}']
    function URL: NSURL; cdecl;
    function backgroundColor: NSColor; cdecl;
    function clickedPathComponentCell: NSPathComponentCell; cdecl;
    function delegate: NSPathControlDelegate; cdecl;
    function doubleAction: SEL; cdecl;
    function menu: NSMenu; cdecl;
    function pathComponentCells: NSArray; cdecl;
    function pathStyle: NSPathStyle; cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setDelegate(delegate: NSPathControlDelegate); cdecl;
    procedure setDoubleAction(action: SEL); cdecl;
    procedure setDraggingSourceOperationMask(mask: NSDragOperation; forLocal: Boolean); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setPathComponentCells(cells: NSArray); cdecl;
    procedure setPathStyle(style: NSPathStyle); cdecl;
    procedure setURL(url: NSURL); cdecl;
  end;
  TNSPathControl = class(TOCGenericImport<NSPathControlClass, NSPathControl>)  end;

  NSPathComponentCellClass = interface(NSTextFieldCellClass)
    ['{23DEB535-8C18-4B4D-8577-3FF826EDF1E6}']
  end;
  NSPathComponentCell = interface(NSTextFieldCell)
    ['{7A5CB98A-B9A0-4B5D-911D-F4BB28B29FCE}']
    function URL: NSURL; cdecl;
    function image: NSImage; cdecl;
    procedure setImage(value: NSImage); cdecl;
    procedure setURL(url: NSURL); cdecl;
  end;
  TNSPathComponentCell = class(TOCGenericImport<NSPathComponentCellClass, NSPathComponentCell>)  end;

  NSTableHeaderCellClass = interface(NSTextFieldCellClass)
    ['{78809991-DC05-471E-A962-117292D8B24C}']
  end;
  NSTableHeaderCell = interface(NSTextFieldCell)
    ['{A1CA0B34-3C94-47CF-9F08-DA26B1184BBE}']
    procedure drawSortIndicatorWithFrame(cellFrame: NSRect; inView: NSView; ascending: Boolean; priority: NSInteger); cdecl;
    function sortIndicatorRectForBounds(theRect: NSRect): NSRect; cdecl;
  end;
  TNSTableHeaderCell = class(TOCGenericImport<NSTableHeaderCellClass, NSTableHeaderCell>)  end;

  NSScrollerClass = interface(NSControlClass)
    ['{15C1951E-DE6F-41E2-A96D-66506EACB5A9}']
    {class} function scrollerWidth: Single; cdecl;
    {class} function scrollerWidthForControlSize(controlSize: NSControlSize): Single; cdecl;
  end;
  NSScroller = interface(NSControl)
    ['{A354C66F-0EE8-494A-AA50-97F2D81B3735}']
    function arrowsPosition: NSScrollArrowPosition; cdecl;
    procedure checkSpaceForParts; cdecl;
    function controlSize: NSControlSize; cdecl;
    function controlTint: NSControlTint; cdecl;
    procedure drawArrow(whichArrow: NSScrollerArrow; highlight: Boolean); cdecl;
    procedure drawKnob; cdecl;
    procedure drawKnobSlotInRect(slotRect: NSRect; highlight: Boolean); cdecl;
    procedure drawParts; cdecl;
    procedure highlight(flag: Boolean); cdecl;
    function hitPart: NSScrollerPart; cdecl;
    function knobProportion: Single; cdecl;
    function rectForPart(partCode: NSScrollerPart): NSRect; cdecl;
    procedure setArrowsPosition(where: NSScrollArrowPosition); cdecl;
    procedure setControlSize(controlSize: NSControlSize); cdecl;
    procedure setControlTint(controlTint: NSControlTint); cdecl;
    procedure setFloatValue(aFloat: Single; knobProportion: Single); cdecl;
    procedure setKnobProportion(proportion: Single); cdecl;
    function testPart(thePoint: NSPoint): NSScrollerPart; cdecl;
    procedure trackKnob(theEvent: NSEvent); cdecl;
    procedure trackScrollButtons(theEvent: NSEvent); cdecl;
    function usableParts: NSUsableScrollerParts; cdecl;
  end;
  TNSScroller = class(TOCGenericImport<NSScrollerClass, NSScroller>)  end;

  NSRuleEditorClass = interface(NSControlClass)
    ['{965CA522-60F6-4CE4-A6EA-5DE281DD52FD}']
  end;
  NSRuleEditor = interface(NSControl)
    ['{3AB63B7A-8C5A-4CB3-BF11-8DA34858D527}']
    procedure addRow(sender: Pointer); cdecl;
    function canRemoveAllRows: Boolean; cdecl;
    function criteriaForRow(row: NSInteger): NSArray; cdecl;
    function criteriaKeyPath: NSString; cdecl;
    function delegate: NSRuleEditorDelegate; cdecl;
    function displayValuesForRow(row: NSInteger): NSArray; cdecl;
    function displayValuesKeyPath: NSString; cdecl;
    function formattingDictionary: NSDictionary; cdecl;
    function formattingStringsFilename: NSString; cdecl;
    procedure insertRowAtIndex(rowIndex: NSInteger; withType: NSRuleEditorRowType; asSubrowOfRow: NSInteger; animate: Boolean); cdecl;
    function isEditable: Boolean; cdecl;
    function nestingMode: NSRuleEditorNestingMode; cdecl;
    function numberOfRows: NSInteger; cdecl;
    function parentRowForRow(rowIndex: NSInteger): NSInteger; cdecl;
    function predicate: NSPredicate; cdecl;
    function predicateForRow(row: NSInteger): NSPredicate; cdecl;
    procedure reloadCriteria; cdecl;
    procedure reloadPredicate; cdecl;
    procedure removeRowAtIndex(rowIndex: NSInteger); cdecl;
    procedure removeRowsAtIndexes(rowIndexes: NSIndexSet; includeSubrows: Boolean); cdecl;
    function rowForDisplayValue(displayValue: Pointer): NSInteger; cdecl;
    function rowHeight: Single; cdecl;
    function rowTypeForRow(rowIndex: NSInteger): NSRuleEditorRowType; cdecl;
    function rowTypeKeyPath: NSString; cdecl;
    procedure selectRowIndexes(indexes: NSIndexSet; byExtendingSelection: Boolean); cdecl;
    function selectedRowIndexes: NSIndexSet; cdecl;
    procedure setCanRemoveAllRows(val: Boolean); cdecl;
    procedure setCriteria(criteria: NSArray; andDisplayValues: NSArray; forRowAtIndex: NSInteger); cdecl;
    procedure setCriteriaKeyPath(keyPath: NSString); cdecl;
    procedure setDelegate(delegate: NSRuleEditorDelegate); cdecl;
    procedure setDisplayValuesKeyPath(keyPath: NSString); cdecl;
    procedure setEditable(editable: Boolean); cdecl;
    procedure setFormattingDictionary(dictionary: NSDictionary); cdecl;
    procedure setFormattingStringsFilename(stringsFilename: NSString); cdecl;
    procedure setNestingMode(mode: NSRuleEditorNestingMode); cdecl;
    procedure setRowClass(rowClass: Pointer); cdecl;
    procedure setRowHeight(height: Single); cdecl;
    procedure setRowTypeKeyPath(keyPath: NSString); cdecl;
    procedure setSubrowsKeyPath(keyPath: NSString); cdecl;
    function subrowIndexesForRow(rowIndex: NSInteger): NSIndexSet; cdecl;
    function subrowsKeyPath: NSString; cdecl;
  end;
  TNSRuleEditor = class(TOCGenericImport<NSRuleEditorClass, NSRuleEditor>)  end;

  NSStepperClass = interface(NSControlClass)
    ['{9F627C6E-3496-4A8B-B455-B6D45AAF284C}']
  end;
  NSStepper = interface(NSControl)
    ['{EE388046-2F99-4041-A978-8F520C76C72D}']
    function autorepeat: Boolean; cdecl;
    function increment: double; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    procedure setAutorepeat(autorepeat: Boolean); cdecl;
    procedure setIncrement(increment: double); cdecl;
    procedure setMaxValue(maxValue: double); cdecl;
    procedure setMinValue(minValue: double); cdecl;
    procedure setValueWraps(valueWraps: Boolean); cdecl;
    function valueWraps: Boolean; cdecl;
  end;
  TNSStepper = class(TOCGenericImport<NSStepperClass, NSStepper>)  end;

  NSSavePanelClass = interface(NSPanelClass)
    ['{21888B44-CC60-4A82-BAA7-419C1E5AB523}']
    {class} function savePanel: Pointer; cdecl;
  end;
  NSSavePanel = interface(NSPanel)
    ['{F807CB71-C019-4EAA-9417-02612FEDB763}']
    function URL: NSURL; cdecl;
    function accessoryView: NSView; cdecl;
    function allowedFileTypes: NSArray; cdecl;
    function allowsOtherFileTypes: Boolean; cdecl;
    function canCreateDirectories: Boolean; cdecl;
    function canSelectHiddenExtension: Boolean; cdecl;
    procedure cancel(sender: Pointer); cdecl;
    function delegate: NSOpenSavePanelDelegate; cdecl;
    function directory: NSString; cdecl;
    function directoryURL: NSURL; cdecl;
    function filename: NSString; cdecl;
    function isExpanded: Boolean; cdecl;
    function isExtensionHidden: Boolean; cdecl;
    function message: NSString; cdecl;
    function nameFieldLabel: NSString; cdecl;
    function nameFieldStringValue: NSString; cdecl;
    procedure ok(sender: Pointer); cdecl;
    function prompt: NSString; cdecl;
    function requiredFileType: NSString; cdecl;
    function runModal: NSInteger; cdecl;
    procedure selectText(sender: Pointer); cdecl;
    procedure setAccessoryView(view: NSView); cdecl;
    procedure setAllowedFileTypes(types: NSArray); cdecl;
    procedure setAllowsOtherFileTypes(flag: Boolean); cdecl;
    procedure setCanCreateDirectories(flag: Boolean); cdecl;
    procedure setCanSelectHiddenExtension(flag: Boolean); cdecl;
    procedure setDelegate(delegate: Pointer); cdecl;
    procedure setDirectory(path: NSString); cdecl;
    procedure setDirectoryURL(url: NSURL); cdecl;
    procedure setExtensionHidden(flag: Boolean); cdecl;
    procedure setMessage(message: NSString); cdecl;
    procedure setNameFieldLabel(label_: NSString); cdecl;
    procedure setNameFieldStringValue(value: NSString); cdecl;
    procedure setPrompt(prompt: NSString); cdecl;
    procedure setRequiredFileType(type_: NSString); cdecl;
    procedure setShowsHiddenFiles(flag: Boolean); cdecl;
    procedure setTitle(title: NSString); cdecl;
    procedure setTreatsFilePackagesAsDirectories(flag: Boolean); cdecl;
    function showsHiddenFiles: Boolean; cdecl;
    function title: NSString; cdecl;
    function treatsFilePackagesAsDirectories: Boolean; cdecl;
    procedure validateVisibleColumns; cdecl;
  end;
  TNSSavePanel = class(TOCGenericImport<NSSavePanelClass, NSSavePanel>)  end;

  NSTableViewClass = interface(NSControlClass)
    ['{A808E5D0-E5C8-4695-95A8-E1DDCB6EBDD2}']
  end;
  NSTableView = interface(NSControl)
    ['{D72CAD25-D0F6-4B92-96C2-DEB916752FCC}']
    procedure addTableColumn(tableColumn: NSTableColumn); cdecl;
    function allowsColumnReordering: Boolean; cdecl;
    function allowsColumnResizing: Boolean; cdecl;
    function allowsColumnSelection: Boolean; cdecl;
    function allowsEmptySelection: Boolean; cdecl;
    function allowsMultipleSelection: Boolean; cdecl;
    function allowsTypeSelect: Boolean; cdecl;
    function autoresizesAllColumnsToFit: Boolean; cdecl;
    function autosaveName: NSString; cdecl;
    function autosaveTableColumns: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function canDragRowsWithIndexes(rowIndexes: NSIndexSet; atPoint: NSPoint): Boolean; cdecl;
    function clickedColumn: NSInteger; cdecl;
    function clickedRow: NSInteger; cdecl;
    function columnAtPoint(point: NSPoint): NSInteger; cdecl;
    function columnAutoresizingStyle: NSTableViewColumnAutoresizingStyle; cdecl;
    function columnIndexesInRect(rect: NSRect): NSIndexSet; cdecl;
    function columnWithIdentifier(identifier: Pointer): NSInteger; cdecl;
    function columnsInRect(rect: NSRect): NSRange; cdecl;
    function cornerView: NSView; cdecl;
    function dataSource: NSTableViewDataSource; cdecl;
    function delegate: NSTableViewDelegate; cdecl;
    procedure deselectAll(sender: Pointer); cdecl;
    procedure deselectColumn(column: NSInteger); cdecl;
    procedure deselectRow(row: NSInteger); cdecl;
    function doubleAction: SEL; cdecl;
    function dragImageForRows(dragRows: NSArray; event: NSEvent; dragImageOffset: NSPointPointer): NSImage; cdecl;
    function dragImageForRowsWithIndexes(dragRows: NSIndexSet; tableColumns: NSArray; event: NSEvent; offset: NSPointPointer): NSImage; cdecl;
    function draggingDestinationFeedbackStyle: NSTableViewDraggingDestinationFeedbackStyle; cdecl;
    procedure drawBackgroundInClipRect(clipRect: NSRect); cdecl;
    procedure drawGridInClipRect(clipRect: NSRect); cdecl;
    procedure drawRow(row: NSInteger; clipRect: NSRect); cdecl;
    function drawsGrid: Boolean; cdecl;
    procedure editColumn(column: NSInteger; row: NSInteger; withEvent: NSEvent; select: Boolean); cdecl;
    function editedColumn: NSInteger; cdecl;
    function editedRow: NSInteger; cdecl;
    function focusedColumn: NSInteger; cdecl;
    function frameOfCellAtColumn(column: NSInteger; row: NSInteger): NSRect; cdecl;
    function gridColor: NSColor; cdecl;
    function gridStyleMask: NSUInteger; cdecl;
    function headerView: NSTableHeaderView; cdecl;
    procedure highlightSelectionInClipRect(clipRect: NSRect); cdecl;
    function highlightedTableColumn: NSTableColumn; cdecl;
    function indicatorImageInTableColumn(tableColumn: NSTableColumn): NSImage; cdecl;
    function intercellSpacing: NSSize; cdecl;
    function isColumnSelected(column: NSInteger): Boolean; cdecl;
    function isRowSelected(row: NSInteger): Boolean; cdecl;
    procedure moveColumn(oldIndex: NSInteger; toColumn: NSInteger); cdecl;
    procedure noteHeightOfRowsWithIndexesChanged(indexSet: NSIndexSet); cdecl;
    procedure noteNumberOfRowsChanged; cdecl;
    function numberOfColumns: NSInteger; cdecl;
    function numberOfRows: NSInteger; cdecl;
    function numberOfSelectedColumns: NSInteger; cdecl;
    function numberOfSelectedRows: NSInteger; cdecl;
    procedure performClickOnCellAtColumn(column: NSInteger; row: NSInteger); cdecl;
    function preparedCellAtColumn(column: NSInteger; row: NSInteger): NSCell; cdecl;
    function rectOfColumn(column: NSInteger): NSRect; cdecl;
    function rectOfRow(row: NSInteger): NSRect; cdecl;
    procedure reloadData; cdecl;
    procedure reloadDataForRowIndexes(rowIndexes: NSIndexSet; columnIndexes: NSIndexSet); cdecl;
    procedure removeTableColumn(tableColumn: NSTableColumn); cdecl;
    function rowAtPoint(point: NSPoint): NSInteger; cdecl;
    function rowHeight: Single; cdecl;
    function rowsInRect(rect: NSRect): NSRange; cdecl;
    procedure scrollColumnToVisible(column: NSInteger); cdecl;
    procedure scrollRowToVisible(row: NSInteger); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure selectColumn(column: NSInteger; byExtendingSelection: Boolean); cdecl;
    procedure selectColumnIndexes(indexes: NSIndexSet; byExtendingSelection: Boolean); cdecl;
    procedure selectRow(row: NSInteger; byExtendingSelection: Boolean); cdecl;
    procedure selectRowIndexes(indexes: NSIndexSet; byExtendingSelection: Boolean); cdecl;
    function selectedColumn: NSInteger; cdecl;
    function selectedColumnEnumerator: NSEnumerator; cdecl;
    function selectedColumnIndexes: NSIndexSet; cdecl;
    function selectedRow: NSInteger; cdecl;
    function selectedRowEnumerator: NSEnumerator; cdecl;
    function selectedRowIndexes: NSIndexSet; cdecl;
    function selectionHighlightStyle: NSTableViewSelectionHighlightStyle; cdecl;
    procedure setAllowsColumnReordering(flag: Boolean); cdecl;
    procedure setAllowsColumnResizing(flag: Boolean); cdecl;
    procedure setAllowsColumnSelection(flag: Boolean); cdecl;
    procedure setAllowsEmptySelection(flag: Boolean); cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    procedure setAllowsTypeSelect(value: Boolean); cdecl;
    procedure setAutoresizesAllColumnsToFit(flag: Boolean); cdecl;
    procedure setAutosaveName(name: NSString); cdecl;
    procedure setAutosaveTableColumns(save: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setColumnAutoresizingStyle(style: NSTableViewColumnAutoresizingStyle); cdecl;
    procedure setCornerView(cornerView: NSView); cdecl;
    procedure setDataSource(aSource: NSTableViewDataSource); cdecl;
    procedure setDelegate(delegate: NSTableViewDelegate); cdecl;
    procedure setDoubleAction(aSelector: SEL); cdecl;
    procedure setDraggingDestinationFeedbackStyle(style: NSTableViewDraggingDestinationFeedbackStyle); cdecl;
    procedure setDraggingSourceOperationMask(mask: NSDragOperation; forLocal: Boolean); cdecl;
    procedure setDrawsGrid(flag: Boolean); cdecl;
    procedure setDropRow(row: NSInteger; dropOperation: NSTableViewDropOperation); cdecl;
    procedure setFocusedColumn(focusedColumn: NSInteger); cdecl;
    procedure setGridColor(color: NSColor); cdecl;
    procedure setGridStyleMask(gridType: NSUInteger); cdecl;
    procedure setHeaderView(headerView: NSTableHeaderView); cdecl;
    procedure setHighlightedTableColumn(tableColumn: NSTableColumn); cdecl;
    procedure setIndicatorImage(anImage: NSImage; inTableColumn: NSTableColumn); cdecl;
    procedure setIntercellSpacing(aSize: NSSize); cdecl;
    procedure setRowHeight(rowHeight: Single); cdecl;
    procedure setSelectionHighlightStyle(selectionHighlightStyle: NSTableViewSelectionHighlightStyle); cdecl;
    procedure setSortDescriptors(array_: NSArray); cdecl;
    procedure setUsesAlternatingRowBackgroundColors(useAlternatingRowColors: Boolean); cdecl;
    procedure setVerticalMotionCanBeginDrag(flag: Boolean); cdecl;
    function shouldFocusCell(cell: NSCell; atColumn: NSInteger; row: NSInteger): Boolean; cdecl;
    procedure sizeLastColumnToFit; cdecl;
    procedure sizeToFit; cdecl;
    function sortDescriptors: NSArray; cdecl;
    function tableColumnWithIdentifier(identifier: Pointer): NSTableColumn; cdecl;
    function tableColumns: NSArray; cdecl;
    procedure textDidBeginEditing(notification: NSNotification); cdecl;
    procedure textDidChange(notification: NSNotification); cdecl;
    procedure textDidEndEditing(notification: NSNotification); cdecl;
    function textShouldBeginEditing(textObject: NSText): Boolean; cdecl;
    function textShouldEndEditing(textObject: NSText): Boolean; cdecl;
    procedure tile; cdecl;
    function usesAlternatingRowBackgroundColors: Boolean; cdecl;
    function verticalMotionCanBeginDrag: Boolean; cdecl;
  end;
  TNSTableView = class(TOCGenericImport<NSTableViewClass, NSTableView>)  end;

  NSSecureTextFieldCellClass = interface(NSTextFieldCellClass)
    ['{6C5958F4-869F-4F08-B6D1-12ED9C13B872}']
  end;
  NSSecureTextFieldCell = interface(NSTextFieldCell)
    ['{731778B4-2888-4551-A82A-20ABF8221C08}']
    function echosBullets: Boolean; cdecl;
    procedure setEchosBullets(flag: Boolean); cdecl;
  end;
  TNSSecureTextFieldCell = class(TOCGenericImport<NSSecureTextFieldCellClass, NSSecureTextFieldCell>)  end;

  NSMenuItemCellClass = interface(NSButtonCellClass)
    ['{11E20F4D-109C-4BEB-96D2-36B8657D56B7}']
  end;
  NSMenuItemCell = interface(NSButtonCell)
    ['{60D506E1-F2AB-4A57-9C8D-9E739FDF61C0}']
    procedure calcSize; cdecl;
    procedure drawBorderAndBackgroundWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawImageWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawKeyEquivalentWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawSeparatorItemWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawStateImageWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    procedure drawTitleWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    function imageWidth: Single; cdecl;
    function keyEquivalentRectForBounds(cellFrame: NSRect): NSRect; cdecl;
    function keyEquivalentWidth: Single; cdecl;
    function menuItem: NSMenuItem; cdecl;
    function needsDisplay: Boolean; cdecl;
    function needsSizing: Boolean; cdecl;
    procedure setMenuItem(item: NSMenuItem); cdecl;
    procedure setNeedsDisplay(flag: Boolean); cdecl;
    procedure setNeedsSizing(flag: Boolean); cdecl;
    function stateImageRectForBounds(cellFrame: NSRect): NSRect; cdecl;
    function stateImageWidth: Single; cdecl;
    function tag: NSInteger; cdecl;
    function titleRectForBounds(cellFrame: NSRect): NSRect; cdecl;
    function titleWidth: Single; cdecl;
  end;
  TNSMenuItemCell = class(TOCGenericImport<NSMenuItemCellClass, NSMenuItemCell>)  end;

  NSTextFieldClass = interface(NSControlClass)
    ['{87E0CBCA-7208-49A9-A661-256403C1600B}']
  end;
  NSTextField = interface(NSControl)
    ['{A67D151A-ECE8-44D4-B2EA-E0BCF152B1B6}']
    function acceptsFirstResponder: Boolean; cdecl;
    function allowsEditingTextAttributes: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function bezelStyle: NSTextFieldBezelStyle; cdecl;
    function delegate: NSTextFieldDelegate; cdecl;
    function drawsBackground: Boolean; cdecl;
    function importsGraphics: Boolean; cdecl;
    function isBezeled: Boolean; cdecl;
    function isBordered: Boolean; cdecl;
    function isEditable: Boolean; cdecl;
    function isSelectable: Boolean; cdecl;
    procedure selectText(sender: Pointer); cdecl;
    procedure setAllowsEditingTextAttributes(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setBezelStyle(style: NSTextFieldBezelStyle); cdecl;
    procedure setBezeled(flag: Boolean); cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setDelegate(anObject: NSTextFieldDelegate); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setEditable(flag: Boolean); cdecl;
    procedure setImportsGraphics(flag: Boolean); cdecl;
    procedure setSelectable(flag: Boolean); cdecl;
    procedure setTextColor(color: NSColor); cdecl;
    procedure setTitleWithMnemonic(stringWithAmpersand: NSString); cdecl;
    function textColor: NSColor; cdecl;
    procedure textDidBeginEditing(notification: NSNotification); cdecl;
    procedure textDidChange(notification: NSNotification); cdecl;
    procedure textDidEndEditing(notification: NSNotification); cdecl;
    function textShouldBeginEditing(textObject: NSText): Boolean; cdecl;
    function textShouldEndEditing(textObject: NSText): Boolean; cdecl;
  end;
  TNSTextField = class(TOCGenericImport<NSTextFieldClass, NSTextField>)  end;

  NSMatrixClass = interface(NSControlClass)
    ['{E089FEAC-58B8-4F68-88A8-9472768BA694}']
  end;
  NSMatrix = interface(NSControl)
    ['{52C8841D-F726-413A-BADF-532164545DC1}']
    function acceptsFirstMouse(theEvent: NSEvent): Boolean; cdecl;
    procedure addColumn; cdecl;
    procedure addColumnWithCells(newCells: NSArray); cdecl;
    procedure addRow; cdecl;
    procedure addRowWithCells(newCells: NSArray); cdecl;
    function allowsEmptySelection: Boolean; cdecl;
    function autosizesCells: Boolean; cdecl;
    function backgroundColor: NSColor; cdecl;
    function cellAtRow(row: NSInteger; column: NSInteger): Pointer; cdecl;
    function cellBackgroundColor: NSColor; cdecl;
    function cellFrameAtRow(row: NSInteger; column: NSInteger): NSRect; cdecl;
    function cellSize: NSSize; cdecl;
    function cellWithTag(anInt: NSInteger): Pointer; cdecl;
    function cells: NSArray; cdecl;
    function delegate: NSMatrixDelegate; cdecl;
    procedure deselectAllCells; cdecl;
    procedure deselectSelectedCell; cdecl;
    function doubleAction: SEL; cdecl;
    procedure drawCellAtRow(row: NSInteger; column: NSInteger); cdecl;
    function drawsBackground: Boolean; cdecl;
    function drawsCellBackground: Boolean; cdecl;
    procedure getNumberOfRows(rowCount: NSInteger; columns: NSInteger); cdecl;
    function getRow(row: NSInteger; column: NSInteger; forPoint: NSPoint): Boolean; cdecl; overload;
    function getRow(row: NSInteger; column: NSInteger; ofCell: NSCell): Boolean; cdecl; overload;
    procedure highlightCell(flag: Boolean; atRow: NSInteger; column: NSInteger); cdecl;
    function initWithFrame(frameRect: NSRect): Pointer; cdecl; overload;
    function initWithFrame(frameRect: NSRect; mode: NSMatrixMode; cellClass: Pointer; numberOfRows: NSInteger; numberOfColumns: NSInteger): Pointer; cdecl; overload;
    function initWithFrame(frameRect: NSRect; mode: NSMatrixMode; prototype: NSCell; numberOfRows: NSInteger; numberOfColumns: NSInteger): Pointer; cdecl; overload;
    procedure insertColumn(column: NSInteger); cdecl; overload;
    procedure insertColumn(column: NSInteger; withCells: NSArray); cdecl; overload;
    procedure insertRow(row: NSInteger); cdecl; overload;
    procedure insertRow(row: NSInteger; withCells: NSArray); cdecl; overload;
    function intercellSpacing: NSSize; cdecl;
    function isAutoscroll: Boolean; cdecl;
    function isSelectionByRect: Boolean; cdecl;
    function keyCell: Pointer; cdecl;
    function makeCellAtRow(row: NSInteger; column: NSInteger): NSCell; cdecl;
    function mode: NSMatrixMode; cdecl;
    procedure mouseDown(theEvent: NSEvent); cdecl;
    function mouseDownFlags: NSInteger; cdecl;
    function numberOfColumns: NSInteger; cdecl;
    function numberOfRows: NSInteger; cdecl;
    function performKeyEquivalent(theEvent: NSEvent): Boolean; cdecl;
    function prototype: Pointer; cdecl;
    procedure putCell(newCell: NSCell; atRow: NSInteger; column: NSInteger); cdecl;
    procedure removeColumn(col: NSInteger); cdecl;
    procedure removeRow(row: NSInteger); cdecl;
    procedure renewRows(newRows: NSInteger; columns: NSInteger); cdecl;
    procedure resetCursorRects; cdecl;
    procedure scrollCellToVisibleAtRow(row: NSInteger; column: NSInteger); cdecl;
    procedure selectAll(sender: Pointer); cdecl;
    procedure selectCellAtRow(row: NSInteger; column: NSInteger); cdecl;
    function selectCellWithTag(anInt: NSInteger): Boolean; cdecl;
    procedure selectText(sender: Pointer); cdecl;
    function selectTextAtRow(row: NSInteger; column: NSInteger): Pointer; cdecl;
    function selectedCell: Pointer; cdecl;
    function selectedCells: NSArray; cdecl;
    function selectedColumn: NSInteger; cdecl;
    function selectedRow: NSInteger; cdecl;
    function sendAction: Boolean; cdecl; overload;
    procedure sendDoubleAction; cdecl;
    procedure setAllowsEmptySelection(flag: Boolean); cdecl;
    procedure setAutoscroll(flag: Boolean); cdecl;
    procedure setAutosizesCells(flag: Boolean); cdecl;
    procedure setBackgroundColor(color: NSColor); cdecl;
    procedure setCellBackgroundColor(color: NSColor); cdecl;
    procedure setCellClass(factoryId: Pointer); cdecl;
    procedure setCellSize(aSize: NSSize); cdecl;
    procedure setDelegate(anObject: NSMatrixDelegate); cdecl;
    procedure setDoubleAction(aSelector: SEL); cdecl;
    procedure setDrawsBackground(flag: Boolean); cdecl;
    procedure setDrawsCellBackground(flag: Boolean); cdecl;
    procedure setIntercellSpacing(aSize: NSSize); cdecl;
    procedure setKeyCell(keyCell: NSCell); cdecl;
    procedure setMode(aMode: NSMatrixMode); cdecl;
    procedure setPrototype(aCell: NSCell); cdecl;
    procedure setScrollable(flag: Boolean); cdecl;
    procedure setSelectionByRect(flag: Boolean); cdecl;
    procedure setState(value: NSInteger; atRow: NSInteger; column: NSInteger); cdecl;
    procedure setTabKeyTraversesCells(flag: Boolean); cdecl;
    procedure setToolTip(toolTipString: NSString; forCell: NSCell); cdecl;
    procedure setValidateSize(flag: Boolean); cdecl;
    procedure sizeToCells; cdecl;
    procedure sortUsingSelector(comparator: SEL); cdecl;
    function tabKeyTraversesCells: Boolean; cdecl;
    procedure textDidBeginEditing(notification: NSNotification); cdecl;
    procedure textDidChange(notification: NSNotification); cdecl;
    procedure textDidEndEditing(notification: NSNotification); cdecl;
    function textShouldBeginEditing(textObject: NSText): Boolean; cdecl;
    function textShouldEndEditing(textObject: NSText): Boolean; cdecl;
    function toolTipForCell(cell: NSCell): NSString; cdecl;
  end;
  TNSMatrix = class(TOCGenericImport<NSMatrixClass, NSMatrix>)  end;

  NSSliderClass = interface(NSControlClass)
    ['{7DC188EE-DB32-413D-B76A-4F6427251E62}']
  end;
  NSSlider = interface(NSControl)
    ['{4B3CE5FA-8955-4948-97AE-8CDD0E04DF48}']
    function acceptsFirstMouse(theEvent: NSEvent): Boolean; cdecl;
    function allowsTickMarkValuesOnly: Boolean; cdecl;
    function altIncrementValue: double; cdecl;
    function closestTickMarkValueToValue(value: double): double; cdecl;
    function image: NSImage; cdecl;
    function indexOfTickMarkAtPoint(point: NSPoint): NSInteger; cdecl;
    function isVertical: NSInteger; cdecl;
    function knobThickness: Single; cdecl;
    function maxValue: double; cdecl;
    function minValue: double; cdecl;
    function numberOfTickMarks: NSInteger; cdecl;
    function rectOfTickMarkAtIndex(index: NSInteger): NSRect; cdecl;
    procedure setAllowsTickMarkValuesOnly(yorn: Boolean); cdecl;
    procedure setAltIncrementValue(incValue: double); cdecl;
    procedure setImage(backgroundImage: NSImage); cdecl;
    procedure setKnobThickness(aFloat: Single); cdecl;
    procedure setMaxValue(aDouble: double); cdecl;
    procedure setMinValue(aDouble: double); cdecl;
    procedure setNumberOfTickMarks(count: NSInteger); cdecl;
    procedure setTickMarkPosition(position: NSTickMarkPosition); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setTitleCell(aCell: NSCell); cdecl;
    procedure setTitleColor(newColor: NSColor); cdecl;
    procedure setTitleFont(fontObj: NSFont); cdecl;
    function tickMarkPosition: NSTickMarkPosition; cdecl;
    function tickMarkValueAtIndex(index: NSInteger): double; cdecl;
    function title: NSString; cdecl;
    function titleCell: Pointer; cdecl;
    function titleColor: NSColor; cdecl;
    function titleFont: NSFont; cdecl;
  end;
  TNSSlider = class(TOCGenericImport<NSSliderClass, NSSlider>)  end;

  NSSearchFieldCellClass = interface(NSTextFieldCellClass)
    ['{240FBA3D-C0C2-4485-9491-61E2CB392C81}']
  end;
  NSSearchFieldCell = interface(NSTextFieldCell)
    ['{B0704D86-786D-4D04-B023-58D17D12D7E7}']
    function cancelButtonCell: NSButtonCell; cdecl;
    function cancelButtonRectForBounds(rect: NSRect): NSRect; cdecl;
    function maximumRecents: NSInteger; cdecl;
    function recentSearches: NSArray; cdecl;
    function recentsAutosaveName: NSString; cdecl;
    procedure resetCancelButtonCell; cdecl;
    procedure resetSearchButtonCell; cdecl;
    function searchButtonCell: NSButtonCell; cdecl;
    function searchButtonRectForBounds(rect: NSRect): NSRect; cdecl;
    function searchMenuTemplate: NSMenu; cdecl;
    function searchTextRectForBounds(rect: NSRect): NSRect; cdecl;
    function sendsSearchStringImmediately: Boolean; cdecl;
    function sendsWholeSearchString: Boolean; cdecl;
    procedure setCancelButtonCell(cell: NSButtonCell); cdecl;
    procedure setMaximumRecents(maxRecents: NSInteger); cdecl;
    procedure setRecentSearches(searches: NSArray); cdecl;
    procedure setRecentsAutosaveName(string_: NSString); cdecl;
    procedure setSearchButtonCell(cell: NSButtonCell); cdecl;
    procedure setSearchMenuTemplate(menu: NSMenu); cdecl;
    procedure setSendsSearchStringImmediately(flag: Boolean); cdecl;
    procedure setSendsWholeSearchString(flag: Boolean); cdecl;
  end;
  TNSSearchFieldCell = class(TOCGenericImport<NSSearchFieldCellClass, NSSearchFieldCell>)  end;

  NSSegmentedControlClass = interface(NSControlClass)
    ['{3528B696-1A8D-427E-ABF0-2857D10CDF6E}']
  end;
  NSSegmentedControl = interface(NSControl)
    ['{6AD4958A-75FF-49B5-BCEC-C8C9CC625994}']
    function imageForSegment(segment: NSInteger): NSImage; cdecl;
    function imageScalingForSegment(segment: NSInteger): NSImageScaling; cdecl;
    function isEnabledForSegment(segment: NSInteger): Boolean; cdecl;
    function isSelectedForSegment(segment: NSInteger): Boolean; cdecl;
    function labelForSegment(segment: NSInteger): NSString; cdecl;
    function menuForSegment(segment: NSInteger): NSMenu; cdecl;
    function segmentCount: NSInteger; cdecl;
    function segmentStyle: NSSegmentStyle; cdecl;
    function selectSegmentWithTag(tag: NSInteger): Boolean; cdecl;
    function selectedSegment: NSInteger; cdecl;
    procedure setEnabled(enabled: Boolean; forSegment: NSInteger); cdecl;
    procedure setImage(image: NSImage; forSegment: NSInteger); cdecl;
    procedure setImageScaling(scaling: NSImageScaling; forSegment: NSInteger); cdecl;
    procedure setLabel(label_: NSString; forSegment: NSInteger); cdecl;
    procedure setMenu(menu: NSMenu; forSegment: NSInteger); cdecl;
    procedure setSegmentCount(count: NSInteger); cdecl;
    procedure setSegmentStyle(segmentStyle: NSSegmentStyle); cdecl;
    procedure setSelected(selected: Boolean; forSegment: NSInteger); cdecl;
    procedure setSelectedSegment(selectedSegment: NSInteger); cdecl;
    procedure setWidth(width: Single; forSegment: NSInteger); cdecl;
    function widthForSegment(segment: NSInteger): Single; cdecl;
  end;
  TNSSegmentedControl = class(TOCGenericImport<NSSegmentedControlClass, NSSegmentedControl>)  end;

  NSSearchFieldClass = interface(NSTextFieldClass)
    ['{6DEA3159-91EA-4730-B8B7-71090294218B}']
  end;
  NSSearchField = interface(NSTextField)
    ['{2265D5E0-7073-4214-A5D6-859C814D1A4A}']
    function recentSearches: NSArray; cdecl;
    function recentsAutosaveName: NSString; cdecl;
    procedure setRecentSearches(searches: NSArray); cdecl;
    procedure setRecentsAutosaveName(string_: NSString); cdecl;
  end;
  TNSSearchField = class(TOCGenericImport<NSSearchFieldClass, NSSearchField>)  end;

  NSOutlineViewClass = interface(NSTableViewClass)
    ['{9DBFCE9B-C195-41A7-AAE1-EBD2589C314D}']
  end;
  NSOutlineView = interface(NSTableView)
    ['{B084CF88-F1C0-4644-99DE-C95C1547A6F6}']
    function autoresizesOutlineColumn: Boolean; cdecl;
    function autosaveExpandedItems: Boolean; cdecl;
    procedure collapseItem(item: Pointer); cdecl; overload;
    procedure collapseItem(item: Pointer; collapseChildren: Boolean); cdecl; overload;
    function dataSource: NSOutlineViewDataSource; cdecl;
    function delegate: NSOutlineViewDelegate; cdecl;
    procedure expandItem(item: Pointer); cdecl; overload;
    procedure expandItem(item: Pointer; expandChildren: Boolean); cdecl; overload;
    function frameOfOutlineCellAtRow(row: NSInteger): NSRect; cdecl;
    function indentationMarkerFollowsCell: Boolean; cdecl;
    function indentationPerLevel: Single; cdecl;
    function isExpandable(item: Pointer): Boolean; cdecl;
    function isItemExpanded(item: Pointer): Boolean; cdecl;
    function itemAtRow(row: NSInteger): Pointer; cdecl;
    function levelForItem(item: Pointer): NSInteger; cdecl;
    function levelForRow(row: NSInteger): NSInteger; cdecl;
    function outlineTableColumn: NSTableColumn; cdecl;
    function parentForItem(item: Pointer): Pointer; cdecl;
    procedure reloadItem(item: Pointer); cdecl; overload;
    procedure reloadItem(item: Pointer; reloadChildren: Boolean); cdecl; overload;
    function rowForItem(item: Pointer): NSInteger; cdecl;
    procedure setAutoresizesOutlineColumn(resize: Boolean); cdecl;
    procedure setAutosaveExpandedItems(save: Boolean); cdecl;
    procedure setDataSource(aSource: NSOutlineViewDataSource); cdecl;
    procedure setDelegate(anObject: NSOutlineViewDelegate); cdecl;
    procedure setDropItem(item: Pointer; dropChildIndex: NSInteger); cdecl;
    procedure setIndentationMarkerFollowsCell(drawInCell: Boolean); cdecl;
    procedure setIndentationPerLevel(indentationPerLevel: Single); cdecl;
    procedure setOutlineTableColumn(outlineTableColumn: NSTableColumn); cdecl;
    function shouldCollapseAutoExpandedItemsForDeposited(deposited: Boolean): Boolean; cdecl;
  end;
  TNSOutlineView = class(TOCGenericImport<NSOutlineViewClass, NSOutlineView>)  end;

  NSTokenFieldClass = interface(NSTextFieldClass)
    ['{74E25FB6-E43C-4CDE-932D-3EC64698F7C0}']
    {class} function defaultCompletionDelay: NSTimeInterval; cdecl;
    {class} function defaultTokenizingCharacterSet: NSCharacterSet; cdecl;
  end;
  NSTokenField = interface(NSTextField)
    ['{58CCC941-B684-4023-8CED-18D9514B0AAC}']
    function completionDelay: NSTimeInterval; cdecl;
    function delegate: NSTokenFieldDelegate; cdecl;
    procedure setCompletionDelay(delay: NSTimeInterval); cdecl;
    procedure setDelegate(anObject: NSTokenFieldDelegate); cdecl;
    procedure setTokenStyle(style: NSTokenStyle); cdecl;
    procedure setTokenizingCharacterSet(characterSet: NSCharacterSet); cdecl;
    function tokenStyle: NSTokenStyle; cdecl;
    function tokenizingCharacterSet: NSCharacterSet; cdecl;
  end;
  TNSTokenField = class(TOCGenericImport<NSTokenFieldClass, NSTokenField>)  end;

  NSFormClass = interface(NSMatrixClass)
    ['{DAA74DBF-16AF-4D89-9FEF-82990B41DE7B}']
  end;
  NSForm = interface(NSMatrix)
    ['{37603E6B-41C3-4B51-AD48-9029CF27C94C}']
    function addEntry(title: NSString): NSFormCell; cdecl;
    function cellAtIndex(index: NSInteger): Pointer; cdecl;
    procedure drawCellAtIndex(index: NSInteger); cdecl;
    function indexOfCellWithTag(aTag: NSInteger): NSInteger; cdecl;
    function indexOfSelectedItem: NSInteger; cdecl;
    function insertEntry(title: NSString; atIndex: NSInteger): NSFormCell; cdecl;
    procedure removeEntryAtIndex(index: NSInteger); cdecl;
    procedure selectTextAtIndex(index: NSInteger); cdecl;
    procedure setBezeled(flag: Boolean); cdecl;
    procedure setBordered(flag: Boolean); cdecl;
    procedure setEntryWidth(width: Single); cdecl;
    procedure setFrameSize(newSize: NSSize); cdecl;
    procedure setInterlineSpacing(spacing: Single); cdecl;
    procedure setTextAlignment(mode: NSTextAlignment); cdecl;
    procedure setTextBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setTextFont(fontObj: NSFont); cdecl;
    procedure setTitleAlignment(mode: NSTextAlignment); cdecl;
    procedure setTitleBaseWritingDirection(writingDirection: NSWritingDirection); cdecl;
    procedure setTitleFont(fontObj: NSFont); cdecl;
  end;
  TNSForm = class(TOCGenericImport<NSFormClass, NSForm>)  end;

  NSOpenPanelClass = interface(NSSavePanelClass)
    ['{86829F90-D9DE-4DAC-A08C-CF823938A92A}']
    {class} function openPanel: Pointer; cdecl;
  end;
  NSOpenPanel = interface(NSSavePanel)
    ['{38052642-8AF2-4F07-B181-0BCEF072082A}']
    function URLs: NSArray; cdecl;
    function allowsMultipleSelection: Boolean; cdecl;
    function canChooseDirectories: Boolean; cdecl;
    function canChooseFiles: Boolean; cdecl;
    function filenames: NSArray; cdecl;
    function resolvesAliases: Boolean; cdecl;
    function runModalForTypes(fileTypes: NSArray): NSInteger; cdecl;
    procedure setAllowsMultipleSelection(flag: Boolean); cdecl;
    procedure setCanChooseDirectories(flag: Boolean); cdecl;
    procedure setCanChooseFiles(flag: Boolean); cdecl;
    procedure setResolvesAliases(flag: Boolean); cdecl;
  end;
  TNSOpenPanel = class(TOCGenericImport<NSOpenPanelClass, NSOpenPanel>)  end;

  NSComboBoxClass = interface(NSTextFieldClass)
    ['{3373A039-7D93-46FF-894C-6930895D198A}']
  end;
  NSComboBox = interface(NSTextField)
    ['{8EE6DE40-CF23-4A0C-B420-4563BA0B7CED}']
    procedure addItemWithObjectValue(object_: Pointer); cdecl;
    procedure addItemsWithObjectValues(objects: NSArray); cdecl;
    function completes: Boolean; cdecl;
    function dataSource: NSComboBoxDataSource; cdecl;
    function delegate: NSComboBoxDelegate; cdecl;
    procedure deselectItemAtIndex(index: NSInteger); cdecl;
    function hasVerticalScroller: Boolean; cdecl;
    function indexOfItemWithObjectValue(object_: Pointer): NSInteger; cdecl;
    function indexOfSelectedItem: NSInteger; cdecl;
    procedure insertItemWithObjectValue(object_: Pointer; atIndex: NSInteger); cdecl;
    function intercellSpacing: NSSize; cdecl;
    function isButtonBordered: Boolean; cdecl;
    function itemHeight: Single; cdecl;
    function itemObjectValueAtIndex(index: NSInteger): Pointer; cdecl;
    procedure noteNumberOfItemsChanged; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function numberOfVisibleItems: NSInteger; cdecl;
    function objectValueOfSelectedItem: Pointer; cdecl;
    function objectValues: NSArray; cdecl;
    procedure reloadData; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure removeItemWithObjectValue(object_: Pointer); cdecl;
    procedure scrollItemAtIndexToTop(index: NSInteger); cdecl;
    procedure scrollItemAtIndexToVisible(index: NSInteger); cdecl;
    procedure selectItemAtIndex(index: NSInteger); cdecl;
    procedure selectItemWithObjectValue(object_: Pointer); cdecl;
    procedure setButtonBordered(flag: Boolean); cdecl;
    procedure setCompletes(completes: Boolean); cdecl;
    procedure setDataSource(aSource: NSComboBoxDataSource); cdecl;
    procedure setDelegate(anObject: NSComboBoxDelegate); cdecl;
    procedure setHasVerticalScroller(flag: Boolean); cdecl;
    procedure setIntercellSpacing(aSize: NSSize); cdecl;
    procedure setItemHeight(itemHeight: Single); cdecl;
    procedure setNumberOfVisibleItems(visibleItems: NSInteger); cdecl;
    procedure setUsesDataSource(flag: Boolean); cdecl;
    function usesDataSource: Boolean; cdecl;
  end;
  TNSComboBox = class(TOCGenericImport<NSComboBoxClass, NSComboBox>)  end;

  NSPredicateEditorClass = interface(NSRuleEditorClass)
    ['{7671F9B4-622A-495B-B9CE-47098C2B45E8}']
  end;
  NSPredicateEditor = interface(NSRuleEditor)
    ['{68792CDB-5AC0-479D-80C1-7AE5C6E970B9}']
    function rowTemplates: NSArray; cdecl;
    procedure setRowTemplates(rowTemplates: NSArray); cdecl;
  end;
  TNSPredicateEditor = class(TOCGenericImport<NSPredicateEditorClass, NSPredicateEditor>)  end;

  NSPopUpButtonClass = interface(NSButtonClass)
    ['{F5D0990F-0DE0-49E8-BB9B-542D57E8D384}']
  end;
  NSPopUpButton = interface(NSButton)
    ['{B5BFD53E-895B-4298-B5A1-1D1BDDBDF4CB}']
    procedure addItemWithTitle(title: NSString); cdecl;
    procedure addItemsWithTitles(itemTitles: NSArray); cdecl;
    function autoenablesItems: Boolean; cdecl;
    function indexOfItem(item: NSMenuItem): NSInteger; cdecl;
    function indexOfItemWithRepresentedObject(obj: Pointer): NSInteger; cdecl;
    function indexOfItemWithTag(tag: NSInteger): NSInteger; cdecl;
    function indexOfItemWithTarget(target: Pointer; andAction: SEL): NSInteger; cdecl;
    function indexOfItemWithTitle(title: NSString): NSInteger; cdecl;
    function indexOfSelectedItem: NSInteger; cdecl;
    function initWithFrame(buttonFrame: NSRect; pullsDown: Boolean): Pointer; cdecl;
    procedure insertItemWithTitle(title: NSString; atIndex: NSInteger); cdecl;
    function itemArray: NSArray; cdecl;
    function itemAtIndex(index: NSInteger): NSMenuItem; cdecl;
    function itemTitleAtIndex(index: NSInteger): NSString; cdecl;
    function itemTitles: NSArray; cdecl;
    function itemWithTitle(title: NSString): NSMenuItem; cdecl;
    function lastItem: NSMenuItem; cdecl;
    function menu: NSMenu; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function preferredEdge: NSRectEdge; cdecl;
    function pullsDown: Boolean; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure removeItemWithTitle(title: NSString); cdecl;
    procedure selectItem(item: NSMenuItem); cdecl;
    procedure selectItemAtIndex(index: NSInteger); cdecl;
    function selectItemWithTag(tag: NSInteger): Boolean; cdecl;
    procedure selectItemWithTitle(title: NSString); cdecl;
    function selectedItem: NSMenuItem; cdecl;
    procedure setAutoenablesItems(flag: Boolean); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setPreferredEdge(edge: NSRectEdge); cdecl;
    procedure setPullsDown(flag: Boolean); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure synchronizeTitleAndSelectedItem; cdecl;
    function titleOfSelectedItem: NSString; cdecl;
  end;
  TNSPopUpButton = class(TOCGenericImport<NSPopUpButtonClass, NSPopUpButton>)  end;

  NSPopUpButtonCellClass = interface(NSMenuItemCellClass)
    ['{47E71E3F-C720-402D-96C5-CCACA6D9103E}']
  end;
  NSPopUpButtonCell = interface(NSMenuItemCell)
    ['{E18442CB-1E33-4F5D-ADF4-C165CD06EB63}']
    procedure addItemWithTitle(title: NSString); cdecl;
    procedure addItemsWithTitles(itemTitles: NSArray); cdecl;
    function altersStateOfSelectedItem: Boolean; cdecl;
    function arrowPosition: NSPopUpArrowPosition; cdecl;
    procedure attachPopUpWithFrame(cellFrame: NSRect; inView: NSView); cdecl;
    function autoenablesItems: Boolean; cdecl;
    procedure dismissPopUp; cdecl;
    function indexOfItem(item: NSMenuItem): NSInteger; cdecl;
    function indexOfItemWithRepresentedObject(obj: Pointer): NSInteger; cdecl;
    function indexOfItemWithTag(tag: NSInteger): NSInteger; cdecl;
    function indexOfItemWithTarget(target: Pointer; andAction: SEL): NSInteger; cdecl;
    function indexOfItemWithTitle(title: NSString): NSInteger; cdecl;
    function indexOfSelectedItem: NSInteger; cdecl;
    function initTextCell(stringValue: NSString; pullsDown: Boolean): Pointer; cdecl;
    procedure insertItemWithTitle(title: NSString; atIndex: NSInteger); cdecl;
    function itemArray: NSArray; cdecl;
    function itemAtIndex(index: NSInteger): NSMenuItem; cdecl;
    function itemTitleAtIndex(index: NSInteger): NSString; cdecl;
    function itemTitles: NSArray; cdecl;
    function itemWithTitle(title: NSString): NSMenuItem; cdecl;
    function lastItem: NSMenuItem; cdecl;
    function menu: NSMenu; cdecl;
    function numberOfItems: NSInteger; cdecl;
    function objectValue: Pointer; cdecl;
    procedure performClickWithFrame(frame: NSRect; inView: NSView); cdecl;
    function preferredEdge: NSRectEdge; cdecl;
    function pullsDown: Boolean; cdecl;
    procedure removeAllItems; cdecl;
    procedure removeItemAtIndex(index: NSInteger); cdecl;
    procedure removeItemWithTitle(title: NSString); cdecl;
    procedure selectItem(item: NSMenuItem); cdecl;
    procedure selectItemAtIndex(index: NSInteger); cdecl;
    function selectItemWithTag(tag: NSInteger): Boolean; cdecl;
    procedure selectItemWithTitle(title: NSString); cdecl;
    function selectedItem: NSMenuItem; cdecl;
    procedure setAltersStateOfSelectedItem(flag: Boolean); cdecl;
    procedure setArrowPosition(position: NSPopUpArrowPosition); cdecl;
    procedure setAutoenablesItems(flag: Boolean); cdecl;
    procedure setMenu(menu: NSMenu); cdecl;
    procedure setObjectValue(obj: Pointer); cdecl;
    procedure setPreferredEdge(edge: NSRectEdge); cdecl;
    procedure setPullsDown(flag: Boolean); cdecl;
    procedure setTitle(aString: NSString); cdecl;
    procedure setUsesItemFromMenu(flag: Boolean); cdecl;
    procedure synchronizeTitleAndSelectedItem; cdecl;
    function titleOfSelectedItem: NSString; cdecl;
    function usesItemFromMenu: Boolean; cdecl;
  end;
  TNSPopUpButtonCell = class(TOCGenericImport<NSPopUpButtonCellClass, NSPopUpButtonCell>)  end;

  // Exported object consts
  function NSGeneralPboard: NSString;
  function NSFontPboard: NSString;
  function NSRulerPboard: NSString;
  function NSFindPboard: NSString;
  function NSDragPboard: NSString;

  function NSPasteboardTypeString: NSString;
  function NSFilenamesPboardType: NSString;
  function NSPasteboardTypePDF: NSString;
  function NSPasteboardTypeTIFF: NSString;
  function NSPasteboardTypePNG: NSString;
  function NSPasteboardTypeRTF: NSString;
  function NSPasteboardTypeRTFD: NSString;
  function NSPasteboardTypeHTML: NSString;
  function NSPasteboardTypeTabularText: NSString;
  function NSPasteboardTypeFont: NSString;
  function NSPasteboardTypeRuler: NSString;
  function NSPasteboardTypeColor: NSString;
  function NSPasteboardTypeSound: NSString;
  function NSPasteboardTypeMultipleTextSelection: NSString;
  function NSPasteboardTypeFindPanelSearchOptions: NSString;

  function NSModalPanelRunLoopMode: NSString;
  function NSEventTrackingRunLoopMode: NSString;

  function NSFontAttributeName: NSString;
  function NSParagraphStyleAttributeName: NSString;
  function NSForegroundColorAttributeName: NSString;
  function NSUnderlineStyleAttributeName: NSString;
  function NSSuperscriptAttributeName: NSString;
  function NSBackgroundColorAttributeName: NSString;
  function NSAttachmentAttributeName: NSString;
  function NSLigatureAttributeName: NSString;
  function NSBaselineOffsetAttributeName: NSString;
  function NSKernAttributeName: NSString;
  function NSLinkAttributeName: NSString;
  function NSStrokeWidthAttributeName: NSString;
  function NSStrokeColorAttributeName: NSString;
  function NSUnderlineColorAttributeName: NSString;
  function NSStrikethroughStyleAttributeName: NSString;
  function NSStrikethroughColorAttributeName: NSString;
  function NSShadowAttributeName: NSString;
  function NSObliquenessAttributeName: NSString;
  function NSExpansionAttributeName: NSString;
  function NSCursorAttributeName: NSString;
  function NSToolTipAttributeName: NSString;
  function NSMarkedClauseSegmentAttributeName: NSString;
  function NSWritingDirectionAttributeName: NSString;
  function NSVerticalGlyphFormAttributeName: NSString;
  function NSGlyphInfoAttributeName: NSString;  
  function NSPrintPrinter: NSString;
  function NSPrintCopies: NSString;
  function NSPrintAllPages: NSString;
  function NSPrintFirstPage: NSString;
  function NSPrintLastPage: NSString;
  function NSPrintMustCollate: NSString;
  function NSPrintReversePageOrder: NSString;
  function NSPrintJobDisposition: NSString;
  function NSPrintSavePath: NSString;
  function NSPrintPagesAcross: NSString;
  function NSPrintPagesDown: NSString;
  function NSPrintTime: NSString;
  function NSPrintDetailedErrorReporting: NSString;
  function NSPrintFaxNumber: NSString;
  function NSPrintPrinterName: NSString;
  function NSPrintHeaderAndFooter: NSString;
  function NSPrintSelectionOnly: NSString;
  function NSPrintJobSavingURL: NSString;
  function NSPrintJobSavingFileNameExtensionHidden: NSString;
  function NSPrintSpoolJob: NSString;
  function NSPrintPreviewJob: NSString;
  function NSPrintSaveJob: NSString;
  function NSPrintCancelJob: NSString;

  function NSAppKitVersionNumber: Double;

const
  NSAppKitVersionNumber10_6 = 1038;
  NSAppKitVersionNumber10_7 = 1138;

implementation

const
  AppKitFwk: string = '/System/Library/Frameworks/AppKit.framework/AppKit';

function NSGeneralPboard: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSGeneralPboard');
end;

function NSFontPboard: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSFontPboard');
end;

function NSRulerPboard: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSRulerPboard');
end;

function NSFindPboard: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSFindPboard');
end;

function NSDragPboard: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSDragPboard');
end;

function NSPasteboardTypeString: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeString');
end;

function NSFilenamesPboardType: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSFilenamesPboardType');
end;

function NSPasteboardTypePDF: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypePDF');
end;

function NSPasteboardTypeTIFF: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeTIFF');
end;

function NSPasteboardTypePNG: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypePNG');
end;

function NSPasteboardTypeRTF: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeRTF');
end;

function NSPasteboardTypeRTFD: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeRTFD');
end;

function NSPasteboardTypeHTML: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeHTML');
end;

function NSPasteboardTypeTabularText: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeTabularText');
end;

function NSPasteboardTypeFont: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeFont');
end;

function NSPasteboardTypeRuler: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeRuler');
end;

function NSPasteboardTypeColor: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeColor');
end;

function NSPasteboardTypeSound: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeSound');
end;

function NSPasteboardTypeMultipleTextSelection: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeMultipleTextSelection');
end;

function NSPasteboardTypeFindPanelSearchOptions: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPasteboardTypeFindPanelSearchOptions');
end;

function NSModalPanelRunLoopMode: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSModalPanelRunLoopMode');
end;

function NSEventTrackingRunLoopMode: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSEventTrackingRunLoopMode');
end;

function NSFontAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSFontAttributeName');
end;

function NSParagraphStyleAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSParagraphStyleAttributeName');
end;

function NSForegroundColorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSForegroundColorAttributeName');
end;

function NSUnderlineStyleAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSUnderlineStyleAttributeName');
end;

function NSSuperscriptAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSSuperscriptAttributeName');
end;

function NSBackgroundColorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSBackgroundColorAttributeName');
end;

function NSAttachmentAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSAttachmentAttributeName');
end;

function NSLigatureAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSLigatureAttributeName');
end;

function NSBaselineOffsetAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSBaselineOffsetAttributeName');
end;

function NSKernAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSKernAttributeName');
end;

function NSLinkAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSLinkAttributeName');
end;

function NSStrokeWidthAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSStrokeWidthAttributeName');
end;

function NSStrokeColorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSStrokeColorAttributeName');
end;

function NSUnderlineColorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSUnderlineColorAttributeName');
end;

function NSStrikethroughStyleAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSStrikethroughStyleAttributeName');
end;

function NSStrikethroughColorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSStrikethroughColorAttributeName');
end;

function NSShadowAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSShadowAttributeName');
end;

function NSObliquenessAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSObliquenessAttributeName');
end;

function NSExpansionAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSExpansionAttributeName');
end;

function NSCursorAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSCursorAttributeName');
end;

function NSToolTipAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSToolTipAttributeName');
end;

function NSMarkedClauseSegmentAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSMarkedClauseSegmentAttributeName');
end;

function NSWritingDirectionAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSWritingDirectionAttributeName');
end;

function NSVerticalGlyphFormAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSVerticalGlyphFormAttributeName');
end;

function NSGlyphInfoAttributeName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSGlyphInfoAttributeName');
end;

function NSPrintPrinter: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintPrinter');
end;

function NSPrintCopies: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintCopies');
end;

function NSPrintAllPages: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintAllPages');
end;

function NSPrintFirstPage: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintFirstPage');
end;

function NSPrintLastPage: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintLastPage');
end;

function NSPrintMustCollate: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintMustCollate');
end;

function NSPrintReversePageOrder: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintReversePageOrder');
end;

function NSPrintJobDisposition: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintJobDisposition');
end;

function NSPrintSavePath: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintSavePath');
end;

function NSPrintPagesAcross: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintPagesAcross');
end;

function NSPrintPagesDown: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintPagesDown');
end;

function NSPrintTime: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintTime');
end;

function NSPrintDetailedErrorReporting: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintDetailedErrorReporting');
end;

function NSPrintFaxNumber: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintFaxNumber');
end;

function NSPrintPrinterName: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintPrinterName');
end;

function NSPrintHeaderAndFooter: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintHeaderAndFooter');
end;

function NSPrintSelectionOnly: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintSelectionOnly');
end;

function NSPrintJobSavingURL: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintJobSavingURL');
end;

function NSPrintJobSavingFileNameExtensionHidden: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintJobSavingFileNameExtensionHidden');
end;

function NSPrintSpoolJob: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintSpoolJob');
end;

function NSPrintPreviewJob: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintPreviewJob');
end;

function NSPrintSaveJob: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintSaveJob');
end;

function NSPrintCancelJob: NSString;
begin
  Result := CocoaNSStringConst(AppKitFwk, 'NSPrintCancelJob');
end;

function NSAppKitVersionNumber: Double;
begin
  Result := PDouble(CocoaPointerConst(AppKitFwk, 'NSAppKitVersionNumber'))^;
end;


end.
