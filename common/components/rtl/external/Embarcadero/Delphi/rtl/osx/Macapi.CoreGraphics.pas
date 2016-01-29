{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2010-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

//
// Delphi-Objective-C Bridge
// Interfaces for Cocoa framework CoreGraphics 
//
unit Macapi.CoreGraphics;

{$WEAKPACKAGEUNIT}

interface

uses
  Macapi.CocoaTypes,
  Macapi.CoreServices,
  Macapi.CoreFoundation;


const
  CGDisplayNoErr = 0;
  {$EXTERNALSYM CGDisplayNoErr}
  CGEventNoErr = 0;
  {$EXTERNALSYM CGEventNoErr}
  CGFLOAT_DEFINED = 1;
  {$EXTERNALSYM CGFLOAT_DEFINED}
  CGGlyphMax = 65534;
  {$EXTERNALSYM CGGlyphMax}
  CGGlyphMin = 0;
  {$EXTERNALSYM CGGlyphMin}
  CGPDFDataFormatJPEG2000 = 2;
  {$EXTERNALSYM CGPDFDataFormatJPEG2000}
  CGPDFDataFormatJPEGEncoded = 1;
  {$EXTERNALSYM CGPDFDataFormatJPEGEncoded}
  CGPDFDataFormatRaw = 0;
  {$EXTERNALSYM CGPDFDataFormatRaw}
  CGRectMaxXEdge = 2;
  {$EXTERNALSYM CGRectMaxXEdge}
  CGRectMaxYEdge = 3;
  {$EXTERNALSYM CGRectMaxYEdge}
  CGRectMinXEdge = 0;
  {$EXTERNALSYM CGRectMinXEdge}
  CGRectMinYEdge = 1;
  {$EXTERNALSYM CGRectMinYEdge}
  kCGAnnotatedSessionEventTap = 2;
  {$EXTERNALSYM kCGAnnotatedSessionEventTap}
  kCGAnyInputEventType = 4294967295;
  {$EXTERNALSYM kCGAnyInputEventType}
  kCGAssistiveTechHighWindowLevelKey = 20;
  {$EXTERNALSYM kCGAssistiveTechHighWindowLevelKey}
  kCGBackingStoreBuffered = 2;
  {$EXTERNALSYM kCGBackingStoreBuffered}
  kCGBackingStoreNonretained = 1;
  {$EXTERNALSYM kCGBackingStoreNonretained}
  kCGBackingStoreRetained = 0;
  {$EXTERNALSYM kCGBackingStoreRetained}
  kCGBackstopMenuLevelKey = 3;
  {$EXTERNALSYM kCGBackstopMenuLevelKey}
  kCGBaseWindowLevelKey = 0;
  {$EXTERNALSYM kCGBaseWindowLevelKey}
  kCGBitmapAlphaInfoMask = 31;
  {$EXTERNALSYM kCGBitmapAlphaInfoMask}
  kCGBitmapByteOrder16Big = 12288;
  {$EXTERNALSYM kCGBitmapByteOrder16Big}
  kCGBitmapByteOrder16Host = 4096;
  {$EXTERNALSYM kCGBitmapByteOrder16Host}
  kCGBitmapByteOrder16Little = 4096;
  {$EXTERNALSYM kCGBitmapByteOrder16Little}
  kCGBitmapByteOrder32Big = 16384;
  {$EXTERNALSYM kCGBitmapByteOrder32Big}
  kCGBitmapByteOrder32Host = 8192;
  {$EXTERNALSYM kCGBitmapByteOrder32Host}
  kCGBitmapByteOrder32Little = 8192;
  {$EXTERNALSYM kCGBitmapByteOrder32Little}
  kCGBitmapByteOrderDefault = 0;
  {$EXTERNALSYM kCGBitmapByteOrderDefault}
  kCGBitmapByteOrderMask = 28672;
  {$EXTERNALSYM kCGBitmapByteOrderMask}
  kCGBitmapFloatComponents = 256;
  {$EXTERNALSYM kCGBitmapFloatComponents}
  kCGBlendModeClear = 16;
  {$EXTERNALSYM kCGBlendModeClear}
  kCGBlendModeColor = 14;
  {$EXTERNALSYM kCGBlendModeColor}
  kCGBlendModeColorBurn = 7;
  {$EXTERNALSYM kCGBlendModeColorBurn}
  kCGBlendModeColorDodge = 6;
  {$EXTERNALSYM kCGBlendModeColorDodge}
  kCGBlendModeCopy = 17;
  {$EXTERNALSYM kCGBlendModeCopy}
  kCGBlendModeDarken = 4;
  {$EXTERNALSYM kCGBlendModeDarken}
  kCGBlendModeDestinationAtop = 24;
  {$EXTERNALSYM kCGBlendModeDestinationAtop}
  kCGBlendModeDestinationIn = 22;
  {$EXTERNALSYM kCGBlendModeDestinationIn}
  kCGBlendModeDestinationOut = 23;
  {$EXTERNALSYM kCGBlendModeDestinationOut}
  kCGBlendModeDestinationOver = 21;
  {$EXTERNALSYM kCGBlendModeDestinationOver}
  kCGBlendModeDifference = 10;
  {$EXTERNALSYM kCGBlendModeDifference}
  kCGBlendModeExclusion = 11;
  {$EXTERNALSYM kCGBlendModeExclusion}
  kCGBlendModeHardLight = 9;
  {$EXTERNALSYM kCGBlendModeHardLight}
  kCGBlendModeHue = 12;
  {$EXTERNALSYM kCGBlendModeHue}
  kCGBlendModeLighten = 5;
  {$EXTERNALSYM kCGBlendModeLighten}
  kCGBlendModeLuminosity = 15;
  {$EXTERNALSYM kCGBlendModeLuminosity}
  kCGBlendModeMultiply = 1;
  {$EXTERNALSYM kCGBlendModeMultiply}
  kCGBlendModeNormal = 0;
  {$EXTERNALSYM kCGBlendModeNormal}
  kCGBlendModeOverlay = 3;
  {$EXTERNALSYM kCGBlendModeOverlay}
  kCGBlendModePlusDarker = 26;
  {$EXTERNALSYM kCGBlendModePlusDarker}
  kCGBlendModePlusLighter = 27;
  {$EXTERNALSYM kCGBlendModePlusLighter}
  kCGBlendModeSaturation = 13;
  {$EXTERNALSYM kCGBlendModeSaturation}
  kCGBlendModeScreen = 2;
  {$EXTERNALSYM kCGBlendModeScreen}
  kCGBlendModeSoftLight = 8;
  {$EXTERNALSYM kCGBlendModeSoftLight}
  kCGBlendModeSourceAtop = 20;
  {$EXTERNALSYM kCGBlendModeSourceAtop}
  kCGBlendModeSourceIn = 18;
  {$EXTERNALSYM kCGBlendModeSourceIn}
  kCGBlendModeSourceOut = 19;
  {$EXTERNALSYM kCGBlendModeSourceOut}
  kCGBlendModeXOR = 25;
  {$EXTERNALSYM kCGBlendModeXOR}
  kCGCaptureNoFill = 1;
  {$EXTERNALSYM kCGCaptureNoFill}
  kCGCaptureNoOptions = 0;
  {$EXTERNALSYM kCGCaptureNoOptions}
  kCGColorSpaceModelCMYK = 2;
  {$EXTERNALSYM kCGColorSpaceModelCMYK}
  kCGColorSpaceModelDeviceN = 4;
  {$EXTERNALSYM kCGColorSpaceModelDeviceN}
  kCGColorSpaceModelIndexed = 5;
  {$EXTERNALSYM kCGColorSpaceModelIndexed}
  kCGColorSpaceModelLab = 3;
  {$EXTERNALSYM kCGColorSpaceModelLab}
  kCGColorSpaceModelMonochrome = 0;
  {$EXTERNALSYM kCGColorSpaceModelMonochrome}
  kCGColorSpaceModelPattern = 6;
  {$EXTERNALSYM kCGColorSpaceModelPattern}
  kCGColorSpaceModelRGB = 1;
  {$EXTERNALSYM kCGColorSpaceModelRGB}
  kCGColorSpaceModelUnknown = -1;
  {$EXTERNALSYM kCGColorSpaceModelUnknown}
  kCGConfigureForAppOnly = 0;
  {$EXTERNALSYM kCGConfigureForAppOnly}
  kCGConfigureForSession = 1;
  {$EXTERNALSYM kCGConfigureForSession}
  kCGConfigurePermanently = 2;
  {$EXTERNALSYM kCGConfigurePermanently}
  kCGCursorWindowLevelKey = 19;
  {$EXTERNALSYM kCGCursorWindowLevelKey}
  kCGDesktopIconWindowLevelKey = 18;
  {$EXTERNALSYM kCGDesktopIconWindowLevelKey}
  kCGDesktopWindowLevelKey = 2;
  {$EXTERNALSYM kCGDesktopWindowLevelKey}
  kCGDirectMainDisplay = 724062288;
  {$EXTERNALSYM kCGDirectMainDisplay}
  kCGDisplayAddFlag = 16;
  {$EXTERNALSYM kCGDisplayAddFlag}
  kCGDisplayBeginConfigurationFlag = 1;
  {$EXTERNALSYM kCGDisplayBeginConfigurationFlag}
  kCGDisplayBlendNormal = 0.0000000000000000;
  {$EXTERNALSYM kCGDisplayBlendNormal}
  kCGDisplayBlendSolidColor = 1.0000000000000000;
  {$EXTERNALSYM kCGDisplayBlendSolidColor}
  kCGDisplayDesktopShapeChangedFlag = 4096;
  {$EXTERNALSYM kCGDisplayDesktopShapeChangedFlag}
  kCGDisplayDisabledFlag = 512;
  {$EXTERNALSYM kCGDisplayDisabledFlag}
  kCGDisplayEnabledFlag = 256;
  {$EXTERNALSYM kCGDisplayEnabledFlag}
  kCGDisplayFadeReservationInvalidToken = 0;
  {$EXTERNALSYM kCGDisplayFadeReservationInvalidToken}
  kCGDisplayMirrorFlag = 1024;
  {$EXTERNALSYM kCGDisplayMirrorFlag}
  kCGDisplayMovedFlag = 2;
  {$EXTERNALSYM kCGDisplayMovedFlag}
  kCGDisplayRemoveFlag = 32;
  {$EXTERNALSYM kCGDisplayRemoveFlag}
  kCGDisplaySetMainFlag = 4;
  {$EXTERNALSYM kCGDisplaySetMainFlag}
  kCGDisplaySetModeFlag = 8;
  {$EXTERNALSYM kCGDisplaySetModeFlag}
  kCGDisplayUnMirrorFlag = 2048;
  {$EXTERNALSYM kCGDisplayUnMirrorFlag}
  kCGDockWindowLevelKey = 7;
  {$EXTERNALSYM kCGDockWindowLevelKey}
  kCGDraggingWindowLevelKey = 12;
  {$EXTERNALSYM kCGDraggingWindowLevelKey}
  kCGEncodingFontSpecific = 0;
  {$EXTERNALSYM kCGEncodingFontSpecific}
  kCGEncodingMacRoman = 1;
  {$EXTERNALSYM kCGEncodingMacRoman}
  kCGErrorApplicationAlreadyRunning = 1025;
  {$EXTERNALSYM kCGErrorApplicationAlreadyRunning}
  kCGErrorApplicationCanOnlyBeRunInOneSessionAtATime = 1026;
  {$EXTERNALSYM kCGErrorApplicationCanOnlyBeRunInOneSessionAtATime}
  kCGErrorApplicationIncorrectExecutableFormatFound = 1023;
  {$EXTERNALSYM kCGErrorApplicationIncorrectExecutableFormatFound}
  kCGErrorApplicationIsLaunching = 1024;
  {$EXTERNALSYM kCGErrorApplicationIsLaunching}
  kCGErrorApplicationNotPermittedToExecute = 1016;
  {$EXTERNALSYM kCGErrorApplicationNotPermittedToExecute}
  kCGErrorApplicationRequiresNewerSystem = 1015;
  {$EXTERNALSYM kCGErrorApplicationRequiresNewerSystem}
  kCGErrorCannotComplete = 1004;
  {$EXTERNALSYM kCGErrorCannotComplete}
  kCGErrorClassicApplicationsMustBeLaunchedByClassic = 1027;
  {$EXTERNALSYM kCGErrorClassicApplicationsMustBeLaunchedByClassic}
  kCGErrorFailure = 1000;
  {$EXTERNALSYM kCGErrorFailure}
  kCGErrorFirst = 1000;
  {$EXTERNALSYM kCGErrorFirst}
  kCGErrorForkFailed = 1028;
  {$EXTERNALSYM kCGErrorForkFailed}
  kCGErrorIllegalArgument = 1001;
  {$EXTERNALSYM kCGErrorIllegalArgument}
  kCGErrorInvalidConnection = 1002;
  {$EXTERNALSYM kCGErrorInvalidConnection}
  kCGErrorInvalidContext = 1003;
  {$EXTERNALSYM kCGErrorInvalidContext}
  kCGErrorInvalidOperation = 1010;
  {$EXTERNALSYM kCGErrorInvalidOperation}
  kCGErrorLast = 1029;
  {$EXTERNALSYM kCGErrorLast}
  kCGErrorNameTooLong = 1005;
  {$EXTERNALSYM kCGErrorNameTooLong}
  kCGErrorNoCurrentPoint = 1009;
  {$EXTERNALSYM kCGErrorNoCurrentPoint}
  kCGErrorNoneAvailable = 1011;
  {$EXTERNALSYM kCGErrorNoneAvailable}
  kCGErrorNotImplemented = 1006;
  {$EXTERNALSYM kCGErrorNotImplemented}
  kCGErrorRangeCheck = 1007;
  {$EXTERNALSYM kCGErrorRangeCheck}
  kCGErrorRetryRegistration = 1029;
  {$EXTERNALSYM kCGErrorRetryRegistration}
  kCGErrorSuccess = 0;
  {$EXTERNALSYM kCGErrorSuccess}
  kCGErrorTypeCheck = 1008;
  {$EXTERNALSYM kCGErrorTypeCheck}
  kCGEventFilterMaskPermitLocalKeyboardEvents = 2;
  {$EXTERNALSYM kCGEventFilterMaskPermitLocalKeyboardEvents}
  kCGEventFilterMaskPermitLocalMouseEvents = 1;
  {$EXTERNALSYM kCGEventFilterMaskPermitLocalMouseEvents}
  kCGEventFilterMaskPermitSystemDefinedEvents = 4;
  {$EXTERNALSYM kCGEventFilterMaskPermitSystemDefinedEvents}
  kCGEventFlagMaskAlphaShift = 65536;
  {$EXTERNALSYM kCGEventFlagMaskAlphaShift}
  kCGEventFlagMaskAlternate = 524288;
  {$EXTERNALSYM kCGEventFlagMaskAlternate}
  kCGEventFlagMaskCommand = 1048576;
  {$EXTERNALSYM kCGEventFlagMaskCommand}
  kCGEventFlagMaskControl = 262144;
  {$EXTERNALSYM kCGEventFlagMaskControl}
  kCGEventFlagMaskHelp = 4194304;
  {$EXTERNALSYM kCGEventFlagMaskHelp}
  kCGEventFlagMaskNonCoalesced = 256;
  {$EXTERNALSYM kCGEventFlagMaskNonCoalesced}
  kCGEventFlagMaskNumericPad = 2097152;
  {$EXTERNALSYM kCGEventFlagMaskNumericPad}
  kCGEventFlagMaskSecondaryFn = 8388608;
  {$EXTERNALSYM kCGEventFlagMaskSecondaryFn}
  kCGEventFlagMaskShift = 131072;
  {$EXTERNALSYM kCGEventFlagMaskShift}
  kCGEventFlagsChanged = 12;
  {$EXTERNALSYM kCGEventFlagsChanged}
  kCGEventKeyDown = 10;
  {$EXTERNALSYM kCGEventKeyDown}
  kCGEventKeyUp = 11;
  {$EXTERNALSYM kCGEventKeyUp}
  kCGEventLeftMouseDown = 1;
  {$EXTERNALSYM kCGEventLeftMouseDown}
  kCGEventLeftMouseDragged = 6;
  {$EXTERNALSYM kCGEventLeftMouseDragged}
  kCGEventLeftMouseUp = 2;
  {$EXTERNALSYM kCGEventLeftMouseUp}
  kCGEventMaskForAllEvents = 18446744073709551615;
  {$EXTERNALSYM kCGEventMaskForAllEvents}
  kCGEventMouseMoved = 5;
  {$EXTERNALSYM kCGEventMouseMoved}
  kCGEventMouseSubtypeDefault = 0;
  {$EXTERNALSYM kCGEventMouseSubtypeDefault}
  kCGEventMouseSubtypeTabletPoint = 1;
  {$EXTERNALSYM kCGEventMouseSubtypeTabletPoint}
  kCGEventMouseSubtypeTabletProximity = 2;
  {$EXTERNALSYM kCGEventMouseSubtypeTabletProximity}
  kCGEventNull = 0;
  {$EXTERNALSYM kCGEventNull}
  kCGEventOtherMouseDown = 25;
  {$EXTERNALSYM kCGEventOtherMouseDown}
  kCGEventOtherMouseDragged = 27;
  {$EXTERNALSYM kCGEventOtherMouseDragged}
  kCGEventOtherMouseUp = 26;
  {$EXTERNALSYM kCGEventOtherMouseUp}
  kCGEventRightMouseDown = 3;
  {$EXTERNALSYM kCGEventRightMouseDown}
  kCGEventRightMouseDragged = 7;
  {$EXTERNALSYM kCGEventRightMouseDragged}
  kCGEventRightMouseUp = 4;
  {$EXTERNALSYM kCGEventRightMouseUp}
  kCGEventScrollWheel = 22;
  {$EXTERNALSYM kCGEventScrollWheel}
  kCGEventSourceGroupID = 44;
  {$EXTERNALSYM kCGEventSourceGroupID}
  kCGEventSourceStateCombinedSessionState = 0;
  {$EXTERNALSYM kCGEventSourceStateCombinedSessionState}
  kCGEventSourceStateHIDSystemState = 1;
  {$EXTERNALSYM kCGEventSourceStateHIDSystemState}
  kCGEventSourceStateID = 45;
  {$EXTERNALSYM kCGEventSourceStateID}
  kCGEventSourceStatePrivate = -1;
  {$EXTERNALSYM kCGEventSourceStatePrivate}
  kCGEventSourceUnixProcessID = 41;
  {$EXTERNALSYM kCGEventSourceUnixProcessID}
  kCGEventSourceUserData = 42;
  {$EXTERNALSYM kCGEventSourceUserData}
  kCGEventSourceUserID = 43;
  {$EXTERNALSYM kCGEventSourceUserID}
  kCGEventSuppressionStateRemoteMouseDrag = 1;
  {$EXTERNALSYM kCGEventSuppressionStateRemoteMouseDrag}
  kCGEventSuppressionStateSuppressionInterval = 0;
  {$EXTERNALSYM kCGEventSuppressionStateSuppressionInterval}
  kCGEventTabletPointer = 23;
  {$EXTERNALSYM kCGEventTabletPointer}
  kCGEventTabletProximity = 24;
  {$EXTERNALSYM kCGEventTabletProximity}
  kCGEventTapDisabledByTimeout = -2;
  {$EXTERNALSYM kCGEventTapDisabledByTimeout}
  kCGEventTapDisabledByUserInput = -1;
  {$EXTERNALSYM kCGEventTapDisabledByUserInput}
  kCGEventTapOptionDefault = 0;
  {$EXTERNALSYM kCGEventTapOptionDefault}
  kCGEventTapOptionListenOnly = 1;
  {$EXTERNALSYM kCGEventTapOptionListenOnly}
  kCGEventTargetProcessSerialNumber = 39;
  {$EXTERNALSYM kCGEventTargetProcessSerialNumber}
  kCGEventTargetUnixProcessID = 40;
  {$EXTERNALSYM kCGEventTargetUnixProcessID}
  kCGFloatingWindowLevelKey = 5;
  {$EXTERNALSYM kCGFloatingWindowLevelKey}
  kCGFontIndexInvalid = 65535;
  {$EXTERNALSYM kCGFontIndexInvalid}
  kCGFontIndexMax = 65534;
  {$EXTERNALSYM kCGFontIndexMax}
  kCGFontPostScriptFormatType1 = 1;
  {$EXTERNALSYM kCGFontPostScriptFormatType1}
  kCGFontPostScriptFormatType3 = 3;
  {$EXTERNALSYM kCGFontPostScriptFormatType3}
  kCGFontPostScriptFormatType42 = 42;
  {$EXTERNALSYM kCGFontPostScriptFormatType42}
  kCGGlyphMax = 65534;
  {$EXTERNALSYM kCGGlyphMax}
  kCGGradientDrawsAfterEndLocation = 2;
  {$EXTERNALSYM kCGGradientDrawsAfterEndLocation}
  kCGGradientDrawsBeforeStartLocation = 1;
  {$EXTERNALSYM kCGGradientDrawsBeforeStartLocation}
  kCGHIDEventTap = 0;
  {$EXTERNALSYM kCGHIDEventTap}
  kCGHeadInsertEventTap = 0;
  {$EXTERNALSYM kCGHeadInsertEventTap}
  kCGHelpWindowLevelKey = 16;
  {$EXTERNALSYM kCGHelpWindowLevelKey}
  kCGImageAlphaFirst = 4;
  {$EXTERNALSYM kCGImageAlphaFirst}
  kCGImageAlphaLast = 3;
  {$EXTERNALSYM kCGImageAlphaLast}
  kCGImageAlphaNone = 0;
  {$EXTERNALSYM kCGImageAlphaNone}
  kCGImageAlphaNoneSkipFirst = 6;
  {$EXTERNALSYM kCGImageAlphaNoneSkipFirst}
  kCGImageAlphaNoneSkipLast = 5;
  {$EXTERNALSYM kCGImageAlphaNoneSkipLast}
  kCGImageAlphaOnly = 7;
  {$EXTERNALSYM kCGImageAlphaOnly}
  kCGImageAlphaPremultipliedFirst = 2;
  {$EXTERNALSYM kCGImageAlphaPremultipliedFirst}
  kCGImageAlphaPremultipliedLast = 1;
  {$EXTERNALSYM kCGImageAlphaPremultipliedLast}
  kCGInterpolationDefault = 0;
  {$EXTERNALSYM kCGInterpolationDefault}
  kCGInterpolationHigh = 3;
  {$EXTERNALSYM kCGInterpolationHigh}
  kCGInterpolationLow = 2;
  {$EXTERNALSYM kCGInterpolationLow}
  kCGInterpolationMedium = 4;
  {$EXTERNALSYM kCGInterpolationMedium}
  kCGInterpolationNone = 1;
  {$EXTERNALSYM kCGInterpolationNone}
  kCGKeyboardEventAutorepeat = 8;
  {$EXTERNALSYM kCGKeyboardEventAutorepeat}
  kCGKeyboardEventKeyboardType = 10;
  {$EXTERNALSYM kCGKeyboardEventKeyboardType}
  kCGKeyboardEventKeycode = 9;
  {$EXTERNALSYM kCGKeyboardEventKeycode}
  kCGLineCapButt = 0;
  {$EXTERNALSYM kCGLineCapButt}
  kCGLineCapRound = 1;
  {$EXTERNALSYM kCGLineCapRound}
  kCGLineCapSquare = 2;
  {$EXTERNALSYM kCGLineCapSquare}
  kCGLineJoinBevel = 2;
  {$EXTERNALSYM kCGLineJoinBevel}
  kCGLineJoinMiter = 0;
  {$EXTERNALSYM kCGLineJoinMiter}
  kCGLineJoinRound = 1;
  {$EXTERNALSYM kCGLineJoinRound}
  kCGMainMenuWindowLevelKey = 8;
  {$EXTERNALSYM kCGMainMenuWindowLevelKey}
  kCGMaxDisplayReservationInterval = 15.000000000000000;
  {$EXTERNALSYM kCGMaxDisplayReservationInterval}
  kCGMaximumWindowLevelKey = 14;
  {$EXTERNALSYM kCGMaximumWindowLevelKey}
  kCGMinimumWindowLevelKey = 1;
  {$EXTERNALSYM kCGMinimumWindowLevelKey}
  kCGModalPanelWindowLevelKey = 10;
  {$EXTERNALSYM kCGModalPanelWindowLevelKey}
  kCGMouseButtonCenter = 2;
  {$EXTERNALSYM kCGMouseButtonCenter}
  kCGMouseButtonLeft = 0;
  {$EXTERNALSYM kCGMouseButtonLeft}
  kCGMouseButtonRight = 1;
  {$EXTERNALSYM kCGMouseButtonRight}
  kCGMouseDownEventMaskingDeadSwitchTimeout = 60.000000000000000;
  {$EXTERNALSYM kCGMouseDownEventMaskingDeadSwitchTimeout}
  kCGMouseEventButtonNumber = 3;
  {$EXTERNALSYM kCGMouseEventButtonNumber}
  kCGMouseEventClickState = 1;
  {$EXTERNALSYM kCGMouseEventClickState}
  kCGMouseEventDeltaX = 4;
  {$EXTERNALSYM kCGMouseEventDeltaX}
  kCGMouseEventDeltaY = 5;
  {$EXTERNALSYM kCGMouseEventDeltaY}
  kCGMouseEventInstantMouser = 6;
  {$EXTERNALSYM kCGMouseEventInstantMouser}
  kCGMouseEventNumber = 0;
  {$EXTERNALSYM kCGMouseEventNumber}
  kCGMouseEventPressure = 2;
  {$EXTERNALSYM kCGMouseEventPressure}
  kCGMouseEventSubtype = 7;
  {$EXTERNALSYM kCGMouseEventSubtype}
  kCGNormalWindowLevelKey = 4;
  {$EXTERNALSYM kCGNormalWindowLevelKey}
  kCGNullDirectDisplay = 0;
  {$EXTERNALSYM kCGNullDirectDisplay}
  kCGNullWindowID = 0;
  {$EXTERNALSYM kCGNullWindowID}
  kCGNumReservedWindowLevels = 16;
  {$EXTERNALSYM kCGNumReservedWindowLevels}
  kCGNumberOfEventSuppressionStates = 2;
  {$EXTERNALSYM kCGNumberOfEventSuppressionStates}
  kCGNumberOfWindowLevelKeys = 21;
  {$EXTERNALSYM kCGNumberOfWindowLevelKeys}
  kCGOverlayWindowLevelKey = 15;
  {$EXTERNALSYM kCGOverlayWindowLevelKey}
  kCGPDFArtBox = 4;
  {$EXTERNALSYM kCGPDFArtBox}
  kCGPDFBleedBox = 2;
  {$EXTERNALSYM kCGPDFBleedBox}
  kCGPDFCropBox = 1;
  {$EXTERNALSYM kCGPDFCropBox}
  kCGPDFMediaBox = 0;
  {$EXTERNALSYM kCGPDFMediaBox}
  kCGPDFObjectTypeArray = 7;
  {$EXTERNALSYM kCGPDFObjectTypeArray}
  kCGPDFObjectTypeBoolean = 2;
  {$EXTERNALSYM kCGPDFObjectTypeBoolean}
  kCGPDFObjectTypeDictionary = 8;
  {$EXTERNALSYM kCGPDFObjectTypeDictionary}
  kCGPDFObjectTypeInteger = 3;
  {$EXTERNALSYM kCGPDFObjectTypeInteger}
  kCGPDFObjectTypeName = 5;
  {$EXTERNALSYM kCGPDFObjectTypeName}
  kCGPDFObjectTypeNull = 1;
  {$EXTERNALSYM kCGPDFObjectTypeNull}
  kCGPDFObjectTypeReal = 4;
  {$EXTERNALSYM kCGPDFObjectTypeReal}
  kCGPDFObjectTypeStream = 9;
  {$EXTERNALSYM kCGPDFObjectTypeStream}
  kCGPDFObjectTypeString = 6;
  {$EXTERNALSYM kCGPDFObjectTypeString}
  kCGPDFTrimBox = 3;
  {$EXTERNALSYM kCGPDFTrimBox}
  kCGPathEOFill = 1;
  {$EXTERNALSYM kCGPathEOFill}
  kCGPathEOFillStroke = 4;
  {$EXTERNALSYM kCGPathEOFillStroke}
  kCGPathElementAddCurveToPoint = 3;
  {$EXTERNALSYM kCGPathElementAddCurveToPoint}
  kCGPathElementAddLineToPoint = 1;
  {$EXTERNALSYM kCGPathElementAddLineToPoint}
  kCGPathElementAddQuadCurveToPoint = 2;
  {$EXTERNALSYM kCGPathElementAddQuadCurveToPoint}
  kCGPathElementCloseSubpath = 4;
  {$EXTERNALSYM kCGPathElementCloseSubpath}
  kCGPathElementMoveToPoint = 0;
  {$EXTERNALSYM kCGPathElementMoveToPoint}
  kCGPathFill = 0;
  {$EXTERNALSYM kCGPathFill}
  kCGPathFillStroke = 3;
  {$EXTERNALSYM kCGPathFillStroke}
  kCGPathStroke = 2;
  {$EXTERNALSYM kCGPathStroke}
  kCGPatternTilingConstantSpacing = 2;
  {$EXTERNALSYM kCGPatternTilingConstantSpacing}
  kCGPatternTilingConstantSpacingMinimalDistortion = 1;
  {$EXTERNALSYM kCGPatternTilingConstantSpacingMinimalDistortion}
  kCGPatternTilingNoDistortion = 0;
  {$EXTERNALSYM kCGPatternTilingNoDistortion}
  kCGPopUpMenuWindowLevelKey = 11;
  {$EXTERNALSYM kCGPopUpMenuWindowLevelKey}
  kCGRenderingIntentAbsoluteColorimetric = 1;
  {$EXTERNALSYM kCGRenderingIntentAbsoluteColorimetric}
  kCGRenderingIntentDefault = 0;
  {$EXTERNALSYM kCGRenderingIntentDefault}
  kCGRenderingIntentPerceptual = 3;
  {$EXTERNALSYM kCGRenderingIntentPerceptual}
  kCGRenderingIntentRelativeColorimetric = 2;
  {$EXTERNALSYM kCGRenderingIntentRelativeColorimetric}
  kCGRenderingIntentSaturation = 4;
  {$EXTERNALSYM kCGRenderingIntentSaturation}
  kCGScreenSaverWindowLevelKey = 13;
  {$EXTERNALSYM kCGScreenSaverWindowLevelKey}
  kCGScreenUpdateOperationMove = 1;
  {$EXTERNALSYM kCGScreenUpdateOperationMove}
  kCGScreenUpdateOperationReducedDirtyRectangleCount = -2147483648;
  {$EXTERNALSYM kCGScreenUpdateOperationReducedDirtyRectangleCount}
  kCGScreenUpdateOperationRefresh = 0;
  {$EXTERNALSYM kCGScreenUpdateOperationRefresh}
  kCGScrollEventUnitLine = 1;
  {$EXTERNALSYM kCGScrollEventUnitLine}
  kCGScrollEventUnitPixel = 0;
  {$EXTERNALSYM kCGScrollEventUnitPixel}
  kCGScrollWheelEventDeltaAxis1 = 11;
  {$EXTERNALSYM kCGScrollWheelEventDeltaAxis1}
  kCGScrollWheelEventDeltaAxis2 = 12;
  {$EXTERNALSYM kCGScrollWheelEventDeltaAxis2}
  kCGScrollWheelEventDeltaAxis3 = 13;
  {$EXTERNALSYM kCGScrollWheelEventDeltaAxis3}
  kCGScrollWheelEventFixedPtDeltaAxis1 = 93;
  {$EXTERNALSYM kCGScrollWheelEventFixedPtDeltaAxis1}
  kCGScrollWheelEventFixedPtDeltaAxis2 = 94;
  {$EXTERNALSYM kCGScrollWheelEventFixedPtDeltaAxis2}
  kCGScrollWheelEventFixedPtDeltaAxis3 = 95;
  {$EXTERNALSYM kCGScrollWheelEventFixedPtDeltaAxis3}
  kCGScrollWheelEventInstantMouser = 14;
  {$EXTERNALSYM kCGScrollWheelEventInstantMouser}
  kCGScrollWheelEventIsContinuous = 88;
  {$EXTERNALSYM kCGScrollWheelEventIsContinuous}
  kCGScrollWheelEventPointDeltaAxis1 = 96;
  {$EXTERNALSYM kCGScrollWheelEventPointDeltaAxis1}
  kCGScrollWheelEventPointDeltaAxis2 = 97;
  {$EXTERNALSYM kCGScrollWheelEventPointDeltaAxis2}
  kCGScrollWheelEventPointDeltaAxis3 = 98;
  {$EXTERNALSYM kCGScrollWheelEventPointDeltaAxis3}
  kCGSessionEventTap = 1;
  {$EXTERNALSYM kCGSessionEventTap}
  kCGStatusWindowLevelKey = 9;
  {$EXTERNALSYM kCGStatusWindowLevelKey}
  kCGTabletEventDeviceID = 24;
  {$EXTERNALSYM kCGTabletEventDeviceID}
  kCGTabletEventPointButtons = 18;
  {$EXTERNALSYM kCGTabletEventPointButtons}
  kCGTabletEventPointPressure = 19;
  {$EXTERNALSYM kCGTabletEventPointPressure}
  kCGTabletEventPointX = 15;
  {$EXTERNALSYM kCGTabletEventPointX}
  kCGTabletEventPointY = 16;
  {$EXTERNALSYM kCGTabletEventPointY}
  kCGTabletEventPointZ = 17;
  {$EXTERNALSYM kCGTabletEventPointZ}
  kCGTabletEventRotation = 22;
  {$EXTERNALSYM kCGTabletEventRotation}
  kCGTabletEventTangentialPressure = 23;
  {$EXTERNALSYM kCGTabletEventTangentialPressure}
  kCGTabletEventTiltX = 20;
  {$EXTERNALSYM kCGTabletEventTiltX}
  kCGTabletEventTiltY = 21;
  {$EXTERNALSYM kCGTabletEventTiltY}
  kCGTabletEventVendor1 = 25;
  {$EXTERNALSYM kCGTabletEventVendor1}
  kCGTabletEventVendor2 = 26;
  {$EXTERNALSYM kCGTabletEventVendor2}
  kCGTabletEventVendor3 = 27;
  {$EXTERNALSYM kCGTabletEventVendor3}
  kCGTabletProximityEventCapabilityMask = 36;
  {$EXTERNALSYM kCGTabletProximityEventCapabilityMask}
  kCGTabletProximityEventDeviceID = 31;
  {$EXTERNALSYM kCGTabletProximityEventDeviceID}
  kCGTabletProximityEventEnterProximity = 38;
  {$EXTERNALSYM kCGTabletProximityEventEnterProximity}
  kCGTabletProximityEventPointerID = 30;
  {$EXTERNALSYM kCGTabletProximityEventPointerID}
  kCGTabletProximityEventPointerType = 37;
  {$EXTERNALSYM kCGTabletProximityEventPointerType}
  kCGTabletProximityEventSystemTabletID = 32;
  {$EXTERNALSYM kCGTabletProximityEventSystemTabletID}
  kCGTabletProximityEventTabletID = 29;
  {$EXTERNALSYM kCGTabletProximityEventTabletID}
  kCGTabletProximityEventVendorID = 28;
  {$EXTERNALSYM kCGTabletProximityEventVendorID}
  kCGTabletProximityEventVendorPointerSerialNumber = 34;
  {$EXTERNALSYM kCGTabletProximityEventVendorPointerSerialNumber}
  kCGTabletProximityEventVendorPointerType = 33;
  {$EXTERNALSYM kCGTabletProximityEventVendorPointerType}
  kCGTabletProximityEventVendorUniqueID = 35;
  {$EXTERNALSYM kCGTabletProximityEventVendorUniqueID}
  kCGTailAppendEventTap = 1;
  {$EXTERNALSYM kCGTailAppendEventTap}
  kCGTextClip = 7;
  {$EXTERNALSYM kCGTextClip}
  kCGTextFill = 0;
  {$EXTERNALSYM kCGTextFill}
  kCGTextFillClip = 4;
  {$EXTERNALSYM kCGTextFillClip}
  kCGTextFillStroke = 2;
  {$EXTERNALSYM kCGTextFillStroke}
  kCGTextFillStrokeClip = 6;
  {$EXTERNALSYM kCGTextFillStrokeClip}
  kCGTextInvisible = 3;
  {$EXTERNALSYM kCGTextInvisible}
  kCGTextStroke = 1;
  {$EXTERNALSYM kCGTextStroke}
  kCGTextStrokeClip = 5;
  {$EXTERNALSYM kCGTextStrokeClip}
  kCGTornOffMenuWindowLevelKey = 6;
  {$EXTERNALSYM kCGTornOffMenuWindowLevelKey}
  kCGUtilityWindowLevelKey = 17;
  {$EXTERNALSYM kCGUtilityWindowLevelKey}
  kCGWindowBackingCFNumberType = 3;
  {$EXTERNALSYM kCGWindowBackingCFNumberType}
  kCGWindowIDCFNumberType = 3;
  {$EXTERNALSYM kCGWindowIDCFNumberType}
  kCGWindowImageBoundsIgnoreFraming = 1;
  {$EXTERNALSYM kCGWindowImageBoundsIgnoreFraming}
  kCGWindowImageDefault = 0;
  {$EXTERNALSYM kCGWindowImageDefault}
  kCGWindowImageOnlyShadows = 4;
  {$EXTERNALSYM kCGWindowImageOnlyShadows}
  kCGWindowImageShouldBeOpaque = 2;
  {$EXTERNALSYM kCGWindowImageShouldBeOpaque}
  kCGWindowListExcludeDesktopElements = 16;
  {$EXTERNALSYM kCGWindowListExcludeDesktopElements}
  kCGWindowListOptionAll = 0;
  {$EXTERNALSYM kCGWindowListOptionAll}
  kCGWindowListOptionIncludingWindow = 8;
  {$EXTERNALSYM kCGWindowListOptionIncludingWindow}
  kCGWindowListOptionOnScreenAboveWindow = 2;
  {$EXTERNALSYM kCGWindowListOptionOnScreenAboveWindow}
  kCGWindowListOptionOnScreenBelowWindow = 4;
  {$EXTERNALSYM kCGWindowListOptionOnScreenBelowWindow}
  kCGWindowListOptionOnScreenOnly = 1;
  {$EXTERNALSYM kCGWindowListOptionOnScreenOnly}
  kCGWindowSharingCFNumberType = 3;
  {$EXTERNALSYM kCGWindowSharingCFNumberType}
  kCGWindowSharingNone = 0;
  {$EXTERNALSYM kCGWindowSharingNone}
  kCGWindowSharingReadOnly = 1;
  {$EXTERNALSYM kCGWindowSharingReadOnly}
  kCGWindowSharingReadWrite = 2;
  {$EXTERNALSYM kCGWindowSharingReadWrite}

// ===== External functions =====

const
  libCoreGraphics = '/System/Library/Frameworks/ApplicationServices.framework/Frameworks/CoreGraphics.framework/CoreGraphics';

function CGAcquireDisplayFadeReservation(seconds: CGDisplayReservationInterval; token: PCGDisplayFadeReservationToken): CGError; cdecl; external libCoreGraphics name _PU + 'CGAcquireDisplayFadeReservation';
{$EXTERNALSYM CGAcquireDisplayFadeReservation}
function CGAffineTransformConcat(t1: CGAffineTransform; t2: CGAffineTransform): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformConcat';
{$EXTERNALSYM CGAffineTransformConcat}
function CGAffineTransformEqualToTransform(t1: CGAffineTransform; t2: CGAffineTransform): Integer; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformEqualToTransform';
{$EXTERNALSYM CGAffineTransformEqualToTransform}
function CGAffineTransformInvert(t: CGAffineTransform): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformInvert';
{$EXTERNALSYM CGAffineTransformInvert}
function CGAffineTransformIsIdentity(t: CGAffineTransform): Integer; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformIsIdentity';
{$EXTERNALSYM CGAffineTransformIsIdentity}
function CGAffineTransformMake(a: Single; b: Single; c: Single; d: Single; tx: Single; ty: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformMake';
{$EXTERNALSYM CGAffineTransformMake}
function CGAffineTransformMakeRotation(angle: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformMakeRotation';
{$EXTERNALSYM CGAffineTransformMakeRotation}
function CGAffineTransformMakeScale(sx: Single; sy: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformMakeScale';
{$EXTERNALSYM CGAffineTransformMakeScale}
function CGAffineTransformMakeTranslation(tx: Single; ty: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformMakeTranslation';
{$EXTERNALSYM CGAffineTransformMakeTranslation}
function CGAffineTransformRotate(t: CGAffineTransform; angle: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformRotate';
{$EXTERNALSYM CGAffineTransformRotate}
function CGAffineTransformScale(t: CGAffineTransform; sx: Single; sy: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformScale';
{$EXTERNALSYM CGAffineTransformScale}
function CGAffineTransformTranslate(t: CGAffineTransform; tx: Single; ty: Single): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGAffineTransformTranslate';
{$EXTERNALSYM CGAffineTransformTranslate}
function CGAssociateMouseAndMouseCursorPosition(connected: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGAssociateMouseAndMouseCursorPosition';
{$EXTERNALSYM CGAssociateMouseAndMouseCursorPosition}
function CGBeginDisplayConfiguration(config: CGDisplayConfigRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGBeginDisplayConfiguration';
{$EXTERNALSYM CGBeginDisplayConfiguration}
function CGBitmapContextCreate(data: Pointer; width: Longword; height: Longword; bitsPerComponent: Longword; bytesPerRow: Longword; space: CGColorSpaceRef; bitmapInfo: CGBitmapInfo): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextCreate';
{$EXTERNALSYM CGBitmapContextCreate}
function CGBitmapContextCreateImage(context: CGContextRef): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextCreateImage';
{$EXTERNALSYM CGBitmapContextCreateImage}
function CGBitmapContextCreateWithData(data: Pointer; width: Longword; height: Longword; bitsPerComponent: Longword; bytesPerRow: Longword; space: CGColorSpaceRef; bitmapInfo: CGBitmapInfo; releaseCallback: CGBitmapContextReleaseDataCallback; releaseInfo: Pointer): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextCreateWithData';
{$EXTERNALSYM CGBitmapContextCreateWithData}
function CGBitmapContextGetAlphaInfo(context: CGContextRef): CGImageAlphaInfo; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetAlphaInfo';
{$EXTERNALSYM CGBitmapContextGetAlphaInfo}
function CGBitmapContextGetBitmapInfo(context: CGContextRef): CGBitmapInfo; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetBitmapInfo';
{$EXTERNALSYM CGBitmapContextGetBitmapInfo}
function CGBitmapContextGetBitsPerComponent(context: CGContextRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetBitsPerComponent';
{$EXTERNALSYM CGBitmapContextGetBitsPerComponent}
function CGBitmapContextGetBitsPerPixel(context: CGContextRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetBitsPerPixel';
{$EXTERNALSYM CGBitmapContextGetBitsPerPixel}
function CGBitmapContextGetBytesPerRow(context: CGContextRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetBytesPerRow';
{$EXTERNALSYM CGBitmapContextGetBytesPerRow}
function CGBitmapContextGetColorSpace(context: CGContextRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetColorSpace';
{$EXTERNALSYM CGBitmapContextGetColorSpace}
function CGBitmapContextGetData(context: CGContextRef): Pointer; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetData';
{$EXTERNALSYM CGBitmapContextGetData}
function CGBitmapContextGetHeight(context: CGContextRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetHeight';
{$EXTERNALSYM CGBitmapContextGetHeight}
function CGBitmapContextGetWidth(context: CGContextRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGBitmapContextGetWidth';
{$EXTERNALSYM CGBitmapContextGetWidth}
function CGCancelDisplayConfiguration(config: CGDisplayConfigRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGCancelDisplayConfiguration';
{$EXTERNALSYM CGCancelDisplayConfiguration}
function CGCaptureAllDisplays: CGError; cdecl; external libCoreGraphics name _PU + 'CGCaptureAllDisplays';
{$EXTERNALSYM CGCaptureAllDisplays}
function CGCaptureAllDisplaysWithOptions(options: CGCaptureOptions): CGError; cdecl; external libCoreGraphics name _PU + 'CGCaptureAllDisplaysWithOptions';
{$EXTERNALSYM CGCaptureAllDisplaysWithOptions}
function CGColorCreate(space: CGColorSpaceRef; components: PSingle): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreate';
{$EXTERNALSYM CGColorCreate}
function CGColorCreateCopy(color: CGColorRef): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateCopy';
{$EXTERNALSYM CGColorCreateCopy}
function CGColorCreateCopyWithAlpha(color: CGColorRef; alpha: Single): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateCopyWithAlpha';
{$EXTERNALSYM CGColorCreateCopyWithAlpha}
function CGColorCreateGenericCMYK(cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateGenericCMYK';
{$EXTERNALSYM CGColorCreateGenericCMYK}
function CGColorCreateGenericGray(gray: Single; alpha: Single): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateGenericGray';
{$EXTERNALSYM CGColorCreateGenericGray}
function CGColorCreateGenericRGB(red: Single; green: Single; blue: Single; alpha: Single): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateGenericRGB';
{$EXTERNALSYM CGColorCreateGenericRGB}
function CGColorCreateWithPattern(space: CGColorSpaceRef; pattern: CGPatternRef; components: PSingle): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorCreateWithPattern';
{$EXTERNALSYM CGColorCreateWithPattern}
function CGColorEqualToColor(color1: CGColorRef; color2: CGColorRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGColorEqualToColor';
{$EXTERNALSYM CGColorEqualToColor}
function CGColorGetAlpha(color: CGColorRef): Single; cdecl; external libCoreGraphics name _PU + 'CGColorGetAlpha';
{$EXTERNALSYM CGColorGetAlpha}
function CGColorGetColorSpace(color: CGColorRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorGetColorSpace';
{$EXTERNALSYM CGColorGetColorSpace}
function CGColorGetComponents(color: CGColorRef): PSingle; cdecl; external libCoreGraphics name _PU + 'CGColorGetComponents';
{$EXTERNALSYM CGColorGetComponents}
function CGColorGetConstantColor(colorName: CFStringRef): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorGetConstantColor';
{$EXTERNALSYM CGColorGetConstantColor}
function CGColorGetNumberOfComponents(color: CGColorRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGColorGetNumberOfComponents';
{$EXTERNALSYM CGColorGetNumberOfComponents}
function CGColorGetPattern(color: CGColorRef): CGPatternRef; cdecl; external libCoreGraphics name _PU + 'CGColorGetPattern';
{$EXTERNALSYM CGColorGetPattern}
function CGColorGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGColorGetTypeID';
{$EXTERNALSYM CGColorGetTypeID}
procedure CGColorRelease(color: CGColorRef); cdecl; external libCoreGraphics name _PU + 'CGColorRelease';
{$EXTERNALSYM CGColorRelease}
function CGColorRetain(color: CGColorRef): CGColorRef; cdecl; external libCoreGraphics name _PU + 'CGColorRetain';
{$EXTERNALSYM CGColorRetain}
function CGColorSpaceCopyICCProfile(space: CGColorSpaceRef): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCopyICCProfile';
{$EXTERNALSYM CGColorSpaceCopyICCProfile}
function CGColorSpaceCopyName(space: CGColorSpaceRef): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCopyName';
{$EXTERNALSYM CGColorSpaceCopyName}
function CGColorSpaceCreateCalibratedGray(whitePoint: PSingle; blackPoint: PSingle; gamma: Single): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateCalibratedGray';
{$EXTERNALSYM CGColorSpaceCreateCalibratedGray}
function CGColorSpaceCreateCalibratedRGB(whitePoint: PSingle; blackPoint: PSingle; gamma: PSingle; matrix: PSingle): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateCalibratedRGB';
{$EXTERNALSYM CGColorSpaceCreateCalibratedRGB}
function CGColorSpaceCreateDeviceCMYK: CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateDeviceCMYK';
{$EXTERNALSYM CGColorSpaceCreateDeviceCMYK}
function CGColorSpaceCreateDeviceGray: CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateDeviceGray';
{$EXTERNALSYM CGColorSpaceCreateDeviceGray}
function CGColorSpaceCreateDeviceRGB: CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateDeviceRGB';
{$EXTERNALSYM CGColorSpaceCreateDeviceRGB}
function CGColorSpaceCreateICCBased(nComponents: Longword; range: PSingle; profile: CGDataProviderRef; alternate: CGColorSpaceRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateICCBased';
{$EXTERNALSYM CGColorSpaceCreateICCBased}
function CGColorSpaceCreateIndexed(baseSpace: CGColorSpaceRef; lastIndex: Longword; colorTable: PByte): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateIndexed';
{$EXTERNALSYM CGColorSpaceCreateIndexed}
function CGColorSpaceCreateLab(whitePoint: PSingle; blackPoint: PSingle; range: PSingle): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateLab';
{$EXTERNALSYM CGColorSpaceCreateLab}
function CGColorSpaceCreatePattern(baseSpace: CGColorSpaceRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreatePattern';
{$EXTERNALSYM CGColorSpaceCreatePattern}
function CGColorSpaceCreateWithICCProfile(data: CFDataRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateWithICCProfile';
{$EXTERNALSYM CGColorSpaceCreateWithICCProfile}
function CGColorSpaceCreateWithName(name: CFStringRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateWithName';
{$EXTERNALSYM CGColorSpaceCreateWithName}
function CGColorSpaceCreateWithPlatformColorSpace(ref: Pointer): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceCreateWithPlatformColorSpace';
{$EXTERNALSYM CGColorSpaceCreateWithPlatformColorSpace}
function CGColorSpaceGetBaseColorSpace(space: CGColorSpaceRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetBaseColorSpace';
{$EXTERNALSYM CGColorSpaceGetBaseColorSpace}
procedure CGColorSpaceGetColorTable(space: CGColorSpaceRef; table: PByte); cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetColorTable';
{$EXTERNALSYM CGColorSpaceGetColorTable}
function CGColorSpaceGetColorTableCount(space: CGColorSpaceRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetColorTableCount';
{$EXTERNALSYM CGColorSpaceGetColorTableCount}
function CGColorSpaceGetModel(space: CGColorSpaceRef): CGColorSpaceModel; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetModel';
{$EXTERNALSYM CGColorSpaceGetModel}
function CGColorSpaceGetNumberOfComponents(space: CGColorSpaceRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetNumberOfComponents';
{$EXTERNALSYM CGColorSpaceGetNumberOfComponents}
function CGColorSpaceGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceGetTypeID';
{$EXTERNALSYM CGColorSpaceGetTypeID}
procedure CGColorSpaceRelease(space: CGColorSpaceRef); cdecl; external libCoreGraphics name _PU + 'CGColorSpaceRelease';
{$EXTERNALSYM CGColorSpaceRelease}
function CGColorSpaceRetain(space: CGColorSpaceRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGColorSpaceRetain';
{$EXTERNALSYM CGColorSpaceRetain}
function CGCompleteDisplayConfiguration(config: CGDisplayConfigRef; option: CGConfigureOption): CGError; cdecl; external libCoreGraphics name _PU + 'CGCompleteDisplayConfiguration';
{$EXTERNALSYM CGCompleteDisplayConfiguration}
function CGConfigureDisplayFadeEffect(config: CGDisplayConfigRef; fadeOutSeconds: CGDisplayFadeInterval; fadeInSeconds: CGDisplayFadeInterval; fadeRed: Single; fadeGreen: Single; fadeBlue: Single): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayFadeEffect';
{$EXTERNALSYM CGConfigureDisplayFadeEffect}
function CGConfigureDisplayMirrorOfDisplay(config: CGDisplayConfigRef; display: CGDirectDisplayID; master: CGDirectDisplayID): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayMirrorOfDisplay';
{$EXTERNALSYM CGConfigureDisplayMirrorOfDisplay}
function CGConfigureDisplayMode(config: CGDisplayConfigRef; display: CGDirectDisplayID; mode: CFDictionaryRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayMode';
{$EXTERNALSYM CGConfigureDisplayMode}
function CGConfigureDisplayOrigin(config: CGDisplayConfigRef; display: CGDirectDisplayID; x: Integer; y: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayOrigin';
{$EXTERNALSYM CGConfigureDisplayOrigin}
function CGConfigureDisplayStereoOperation(config: CGDisplayConfigRef; display: CGDirectDisplayID; stereo: Integer; forceBlueLine: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayStereoOperation';
{$EXTERNALSYM CGConfigureDisplayStereoOperation}
function CGConfigureDisplayWithDisplayMode(config: CGDisplayConfigRef; display: CGDirectDisplayID; mode: CGDisplayModeRef; options: CFDictionaryRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGConfigureDisplayWithDisplayMode';
{$EXTERNALSYM CGConfigureDisplayWithDisplayMode}
procedure CGContextAddArc(c: CGContextRef; x: Single; y: Single; radius: Single; startAngle: Single; endAngle: Single; clockwise: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextAddArc';
{$EXTERNALSYM CGContextAddArc}
procedure CGContextAddArcToPoint(c: CGContextRef; x1: Single; y1: Single; x2: Single; y2: Single; radius: Single); cdecl; external libCoreGraphics name _PU + 'CGContextAddArcToPoint';
{$EXTERNALSYM CGContextAddArcToPoint}
procedure CGContextAddCurveToPoint(c: CGContextRef; cp1x: Single; cp1y: Single; cp2x: Single; cp2y: Single; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGContextAddCurveToPoint';
{$EXTERNALSYM CGContextAddCurveToPoint}
procedure CGContextAddEllipseInRect(context: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextAddEllipseInRect';
{$EXTERNALSYM CGContextAddEllipseInRect}
procedure CGContextAddLineToPoint(c: CGContextRef; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGContextAddLineToPoint';
{$EXTERNALSYM CGContextAddLineToPoint}
procedure CGContextAddLines(c: CGContextRef; points: PCGPoint; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextAddLines';
{$EXTERNALSYM CGContextAddLines}
procedure CGContextAddPath(context: CGContextRef; path: CGPathRef); cdecl; external libCoreGraphics name _PU + 'CGContextAddPath';
{$EXTERNALSYM CGContextAddPath}
procedure CGContextAddQuadCurveToPoint(c: CGContextRef; cpx: Single; cpy: Single; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGContextAddQuadCurveToPoint';
{$EXTERNALSYM CGContextAddQuadCurveToPoint}
procedure CGContextAddRect(c: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextAddRect';
{$EXTERNALSYM CGContextAddRect}
procedure CGContextAddRects(c: CGContextRef; rects: PCGRect; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextAddRects';
{$EXTERNALSYM CGContextAddRects}
procedure CGContextBeginPage(c: CGContextRef; mediaBox: PCGRect); cdecl; external libCoreGraphics name _PU + 'CGContextBeginPage';
{$EXTERNALSYM CGContextBeginPage}
procedure CGContextBeginPath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextBeginPath';
{$EXTERNALSYM CGContextBeginPath}
procedure CGContextBeginTransparencyLayer(context: CGContextRef; auxiliaryInfo: CFDictionaryRef); cdecl; external libCoreGraphics name _PU + 'CGContextBeginTransparencyLayer';
{$EXTERNALSYM CGContextBeginTransparencyLayer}
procedure CGContextBeginTransparencyLayerWithRect(context: CGContextRef; rect: CGRect; auxiliaryInfo: CFDictionaryRef); cdecl; external libCoreGraphics name _PU + 'CGContextBeginTransparencyLayerWithRect';
{$EXTERNALSYM CGContextBeginTransparencyLayerWithRect}
procedure CGContextClearRect(c: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextClearRect';
{$EXTERNALSYM CGContextClearRect}
procedure CGContextClip(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextClip';
{$EXTERNALSYM CGContextClip}
procedure CGContextClipToMask(c: CGContextRef; rect: CGRect; mask: CGImageRef); cdecl; external libCoreGraphics name _PU + 'CGContextClipToMask';
{$EXTERNALSYM CGContextClipToMask}
procedure CGContextClipToRect(c: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextClipToRect';
{$EXTERNALSYM CGContextClipToRect}
procedure CGContextClipToRects(c: CGContextRef; rects: PCGRect; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextClipToRects';
{$EXTERNALSYM CGContextClipToRects}
procedure CGContextClosePath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextClosePath';
{$EXTERNALSYM CGContextClosePath}
procedure CGContextConcatCTM(c: CGContextRef; transform: CGAffineTransform); cdecl; external libCoreGraphics name _PU + 'CGContextConcatCTM';
{$EXTERNALSYM CGContextConcatCTM}
function CGContextConvertPointToDeviceSpace(context: CGContextRef; point: CGPoint): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGContextConvertPointToDeviceSpace';
{$EXTERNALSYM CGContextConvertPointToDeviceSpace}
function CGContextConvertPointToUserSpace(context: CGContextRef; point: CGPoint): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGContextConvertPointToUserSpace';
{$EXTERNALSYM CGContextConvertPointToUserSpace}
function CGContextConvertRectToDeviceSpace(context: CGContextRef; rect: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGContextConvertRectToDeviceSpace';
{$EXTERNALSYM CGContextConvertRectToDeviceSpace}
function CGContextConvertRectToUserSpace(context: CGContextRef; rect: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGContextConvertRectToUserSpace';
{$EXTERNALSYM CGContextConvertRectToUserSpace}
function CGContextConvertSizeToDeviceSpace(context: CGContextRef; size: CGSize): CGSize; cdecl; external libCoreGraphics name _PU + 'CGContextConvertSizeToDeviceSpace';
{$EXTERNALSYM CGContextConvertSizeToDeviceSpace}
function CGContextConvertSizeToUserSpace(context: CGContextRef; size: CGSize): CGSize; cdecl; external libCoreGraphics name _PU + 'CGContextConvertSizeToUserSpace';
{$EXTERNALSYM CGContextConvertSizeToUserSpace}
function CGContextCopyPath(context: CGContextRef): CGPathRef; cdecl; external libCoreGraphics name _PU + 'CGContextCopyPath';
{$EXTERNALSYM CGContextCopyPath}
procedure CGContextDrawImage(c: CGContextRef; rect: CGRect; image: CGImageRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawImage';
{$EXTERNALSYM CGContextDrawImage}
procedure CGContextDrawLayerAtPoint(context: CGContextRef; point: CGPoint; layer: CGLayerRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawLayerAtPoint';
{$EXTERNALSYM CGContextDrawLayerAtPoint}
procedure CGContextDrawLayerInRect(context: CGContextRef; rect: CGRect; layer: CGLayerRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawLayerInRect';
{$EXTERNALSYM CGContextDrawLayerInRect}
procedure CGContextDrawLinearGradient(context: CGContextRef; gradient: CGGradientRef; startPoint: CGPoint; endPoint: CGPoint; options: CGGradientDrawingOptions); cdecl; external libCoreGraphics name _PU + 'CGContextDrawLinearGradient';
{$EXTERNALSYM CGContextDrawLinearGradient}
procedure CGContextDrawPDFDocument(c: CGContextRef; rect: CGRect; document: CGPDFDocumentRef; page: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextDrawPDFDocument';
{$EXTERNALSYM CGContextDrawPDFDocument}
procedure CGContextDrawPDFPage(c: CGContextRef; page: CGPDFPageRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawPDFPage';
{$EXTERNALSYM CGContextDrawPDFPage}
procedure CGContextDrawPath(c: CGContextRef; mode: CGPathDrawingMode); cdecl; external libCoreGraphics name _PU + 'CGContextDrawPath';
{$EXTERNALSYM CGContextDrawPath}
procedure CGContextDrawRadialGradient(context: CGContextRef; gradient: CGGradientRef; startCenter: CGPoint; startRadius: Single; endCenter: CGPoint; endRadius: Single; options: CGGradientDrawingOptions); cdecl; external libCoreGraphics name _PU + 'CGContextDrawRadialGradient';
{$EXTERNALSYM CGContextDrawRadialGradient}
procedure CGContextDrawShading(context: CGContextRef; shading: CGShadingRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawShading';
{$EXTERNALSYM CGContextDrawShading}
procedure CGContextDrawTiledImage(c: CGContextRef; rect: CGRect; image: CGImageRef); cdecl; external libCoreGraphics name _PU + 'CGContextDrawTiledImage';
{$EXTERNALSYM CGContextDrawTiledImage}
procedure CGContextEOClip(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextEOClip';
{$EXTERNALSYM CGContextEOClip}
procedure CGContextEOFillPath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextEOFillPath';
{$EXTERNALSYM CGContextEOFillPath}
procedure CGContextEndPage(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextEndPage';
{$EXTERNALSYM CGContextEndPage}
procedure CGContextEndTransparencyLayer(context: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextEndTransparencyLayer';
{$EXTERNALSYM CGContextEndTransparencyLayer}
procedure CGContextFillEllipseInRect(context: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextFillEllipseInRect';
{$EXTERNALSYM CGContextFillEllipseInRect}
procedure CGContextFillPath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextFillPath';
{$EXTERNALSYM CGContextFillPath}
procedure CGContextFillRect(c: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextFillRect';
{$EXTERNALSYM CGContextFillRect}
procedure CGContextFillRects(c: CGContextRef; rects: PCGRect; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextFillRects';
{$EXTERNALSYM CGContextFillRects}
procedure CGContextFlush(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextFlush';
{$EXTERNALSYM CGContextFlush}
function CGContextGetCTM(c: CGContextRef): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGContextGetCTM';
{$EXTERNALSYM CGContextGetCTM}
function CGContextGetClipBoundingBox(c: CGContextRef): CGRect; cdecl; external libCoreGraphics name _PU + 'CGContextGetClipBoundingBox';
{$EXTERNALSYM CGContextGetClipBoundingBox}
function CGContextGetInterpolationQuality(context: CGContextRef): CGInterpolationQuality; cdecl; external libCoreGraphics name _PU + 'CGContextGetInterpolationQuality';
{$EXTERNALSYM CGContextGetInterpolationQuality}
function CGContextGetPathBoundingBox(context: CGContextRef): CGRect; cdecl; external libCoreGraphics name _PU + 'CGContextGetPathBoundingBox';
{$EXTERNALSYM CGContextGetPathBoundingBox}
function CGContextGetPathCurrentPoint(context: CGContextRef): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGContextGetPathCurrentPoint';
{$EXTERNALSYM CGContextGetPathCurrentPoint}
function CGContextGetTextMatrix(c: CGContextRef): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGContextGetTextMatrix';
{$EXTERNALSYM CGContextGetTextMatrix}
function CGContextGetTextPosition(context: CGContextRef): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGContextGetTextPosition';
{$EXTERNALSYM CGContextGetTextPosition}
function CGContextGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGContextGetTypeID';
{$EXTERNALSYM CGContextGetTypeID}
function CGContextGetUserSpaceToDeviceSpaceTransform(context: CGContextRef): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGContextGetUserSpaceToDeviceSpaceTransform';
{$EXTERNALSYM CGContextGetUserSpaceToDeviceSpaceTransform}
function CGContextIsPathEmpty(context: CGContextRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGContextIsPathEmpty';
{$EXTERNALSYM CGContextIsPathEmpty}
procedure CGContextMoveToPoint(c: CGContextRef; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGContextMoveToPoint';
{$EXTERNALSYM CGContextMoveToPoint}
function CGContextPathContainsPoint(context: CGContextRef; point: CGPoint; mode: CGPathDrawingMode): Integer; cdecl; external libCoreGraphics name _PU + 'CGContextPathContainsPoint';
{$EXTERNALSYM CGContextPathContainsPoint}
procedure CGContextRelease(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextRelease';
{$EXTERNALSYM CGContextRelease}
procedure CGContextReplacePathWithStrokedPath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextReplacePathWithStrokedPath';
{$EXTERNALSYM CGContextReplacePathWithStrokedPath}
procedure CGContextRestoreGState(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextRestoreGState';
{$EXTERNALSYM CGContextRestoreGState}
function CGContextRetain(c: CGContextRef): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGContextRetain';
{$EXTERNALSYM CGContextRetain}
procedure CGContextRotateCTM(c: CGContextRef; angle: Single); cdecl; external libCoreGraphics name _PU + 'CGContextRotateCTM';
{$EXTERNALSYM CGContextRotateCTM}
procedure CGContextSaveGState(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextSaveGState';
{$EXTERNALSYM CGContextSaveGState}
procedure CGContextScaleCTM(c: CGContextRef; sx: Single; sy: Single); cdecl; external libCoreGraphics name _PU + 'CGContextScaleCTM';
{$EXTERNALSYM CGContextScaleCTM}
procedure CGContextSelectFont(c: CGContextRef; name: MarshaledAString; size: Single; textEncoding: CGTextEncoding); cdecl; external libCoreGraphics name _PU + 'CGContextSelectFont';
{$EXTERNALSYM CGContextSelectFont}
procedure CGContextSetAllowsAntialiasing(context: CGContextRef; allowsAntialiasing: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetAllowsAntialiasing';
{$EXTERNALSYM CGContextSetAllowsAntialiasing}
procedure CGContextSetAllowsFontSmoothing(context: CGContextRef; allowsFontSmoothing: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetAllowsFontSmoothing';
{$EXTERNALSYM CGContextSetAllowsFontSmoothing}
procedure CGContextSetAllowsFontSubpixelPositioning(context: CGContextRef; allowsFontSubpixelPositioning: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetAllowsFontSubpixelPositioning';
{$EXTERNALSYM CGContextSetAllowsFontSubpixelPositioning}
procedure CGContextSetAllowsFontSubpixelQuantization(context: CGContextRef; allowsFontSubpixelQuantization: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetAllowsFontSubpixelQuantization';
{$EXTERNALSYM CGContextSetAllowsFontSubpixelQuantization}
procedure CGContextSetAlpha(c: CGContextRef; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetAlpha';
{$EXTERNALSYM CGContextSetAlpha}
procedure CGContextSetBlendMode(context: CGContextRef; mode: CGBlendMode); cdecl; external libCoreGraphics name _PU + 'CGContextSetBlendMode';
{$EXTERNALSYM CGContextSetBlendMode}
procedure CGContextSetCMYKFillColor(context: CGContextRef; cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetCMYKFillColor';
{$EXTERNALSYM CGContextSetCMYKFillColor}
procedure CGContextSetCMYKStrokeColor(context: CGContextRef; cyan: Single; magenta: Single; yellow: Single; black: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetCMYKStrokeColor';
{$EXTERNALSYM CGContextSetCMYKStrokeColor}
procedure CGContextSetCharacterSpacing(context: CGContextRef; spacing: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetCharacterSpacing';
{$EXTERNALSYM CGContextSetCharacterSpacing}
procedure CGContextSetFillColor(context: CGContextRef; components: PSingle); cdecl; external libCoreGraphics name _PU + 'CGContextSetFillColor';
{$EXTERNALSYM CGContextSetFillColor}
procedure CGContextSetFillColorSpace(context: CGContextRef; space: CGColorSpaceRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetFillColorSpace';
{$EXTERNALSYM CGContextSetFillColorSpace}
procedure CGContextSetFillColorWithColor(c: CGContextRef; color: CGColorRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetFillColorWithColor';
{$EXTERNALSYM CGContextSetFillColorWithColor}
procedure CGContextSetFillPattern(context: CGContextRef; pattern: CGPatternRef; components: PSingle); cdecl; external libCoreGraphics name _PU + 'CGContextSetFillPattern';
{$EXTERNALSYM CGContextSetFillPattern}
procedure CGContextSetFlatness(c: CGContextRef; flatness: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetFlatness';
{$EXTERNALSYM CGContextSetFlatness}
procedure CGContextSetFont(c: CGContextRef; font: CGFontRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetFont';
{$EXTERNALSYM CGContextSetFont}
procedure CGContextSetFontSize(c: CGContextRef; size: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetFontSize';
{$EXTERNALSYM CGContextSetFontSize}
procedure CGContextSetGrayFillColor(context: CGContextRef; gray: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetGrayFillColor';
{$EXTERNALSYM CGContextSetGrayFillColor}
procedure CGContextSetGrayStrokeColor(context: CGContextRef; gray: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetGrayStrokeColor';
{$EXTERNALSYM CGContextSetGrayStrokeColor}
procedure CGContextSetInterpolationQuality(context: CGContextRef; quality: CGInterpolationQuality); cdecl; external libCoreGraphics name _PU + 'CGContextSetInterpolationQuality';
{$EXTERNALSYM CGContextSetInterpolationQuality}
procedure CGContextSetLineCap(c: CGContextRef; cap: CGLineCap); cdecl; external libCoreGraphics name _PU + 'CGContextSetLineCap';
{$EXTERNALSYM CGContextSetLineCap}
procedure CGContextSetLineDash(c: CGContextRef; phase: Single; lengths: PSingle; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextSetLineDash';
{$EXTERNALSYM CGContextSetLineDash}
procedure CGContextSetLineJoin(c: CGContextRef; join: CGLineJoin); cdecl; external libCoreGraphics name _PU + 'CGContextSetLineJoin';
{$EXTERNALSYM CGContextSetLineJoin}
procedure CGContextSetLineWidth(c: CGContextRef; width: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetLineWidth';
{$EXTERNALSYM CGContextSetLineWidth}
procedure CGContextSetMiterLimit(c: CGContextRef; limit: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetMiterLimit';
{$EXTERNALSYM CGContextSetMiterLimit}
procedure CGContextSetPatternPhase(context: CGContextRef; phase: CGSize); cdecl; external libCoreGraphics name _PU + 'CGContextSetPatternPhase';
{$EXTERNALSYM CGContextSetPatternPhase}
procedure CGContextSetRGBFillColor(context: CGContextRef; red: Single; green: Single; blue: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetRGBFillColor';
{$EXTERNALSYM CGContextSetRGBFillColor}
procedure CGContextSetRGBStrokeColor(context: CGContextRef; red: Single; green: Single; blue: Single; alpha: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetRGBStrokeColor';
{$EXTERNALSYM CGContextSetRGBStrokeColor}
procedure CGContextSetRenderingIntent(context: CGContextRef; intent: CGColorRenderingIntent); cdecl; external libCoreGraphics name _PU + 'CGContextSetRenderingIntent';
{$EXTERNALSYM CGContextSetRenderingIntent}
procedure CGContextSetShadow(context: CGContextRef; offset: CGSize; blur: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetShadow';
{$EXTERNALSYM CGContextSetShadow}
procedure CGContextSetShadowWithColor(context: CGContextRef; offset: CGSize; blur: Single; color: CGColorRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetShadowWithColor';
{$EXTERNALSYM CGContextSetShadowWithColor}
procedure CGContextSetShouldAntialias(context: CGContextRef; shouldAntialias: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetShouldAntialias';
{$EXTERNALSYM CGContextSetShouldAntialias}
procedure CGContextSetShouldSmoothFonts(context: CGContextRef; shouldSmoothFonts: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetShouldSmoothFonts';
{$EXTERNALSYM CGContextSetShouldSmoothFonts}
procedure CGContextSetShouldSubpixelPositionFonts(context: CGContextRef; shouldSubpixelPositionFonts: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetShouldSubpixelPositionFonts';
{$EXTERNALSYM CGContextSetShouldSubpixelPositionFonts}
procedure CGContextSetShouldSubpixelQuantizeFonts(context: CGContextRef; shouldSubpixelQuantizeFonts: Integer); cdecl; external libCoreGraphics name _PU + 'CGContextSetShouldSubpixelQuantizeFonts';
{$EXTERNALSYM CGContextSetShouldSubpixelQuantizeFonts}
procedure CGContextSetStrokeColor(context: CGContextRef; components: PSingle); cdecl; external libCoreGraphics name _PU + 'CGContextSetStrokeColor';
{$EXTERNALSYM CGContextSetStrokeColor}
procedure CGContextSetStrokeColorSpace(context: CGContextRef; space: CGColorSpaceRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetStrokeColorSpace';
{$EXTERNALSYM CGContextSetStrokeColorSpace}
procedure CGContextSetStrokeColorWithColor(c: CGContextRef; color: CGColorRef); cdecl; external libCoreGraphics name _PU + 'CGContextSetStrokeColorWithColor';
{$EXTERNALSYM CGContextSetStrokeColorWithColor}
procedure CGContextSetStrokePattern(context: CGContextRef; pattern: CGPatternRef; components: PSingle); cdecl; external libCoreGraphics name _PU + 'CGContextSetStrokePattern';
{$EXTERNALSYM CGContextSetStrokePattern}
procedure CGContextSetTextDrawingMode(c: CGContextRef; mode: CGTextDrawingMode); cdecl; external libCoreGraphics name _PU + 'CGContextSetTextDrawingMode';
{$EXTERNALSYM CGContextSetTextDrawingMode}
procedure CGContextSetTextMatrix(c: CGContextRef; t: CGAffineTransform); cdecl; external libCoreGraphics name _PU + 'CGContextSetTextMatrix';
{$EXTERNALSYM CGContextSetTextMatrix}
procedure CGContextSetTextPosition(c: CGContextRef; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGContextSetTextPosition';
{$EXTERNALSYM CGContextSetTextPosition}
procedure CGContextShowGlyphs(c: CGContextRef; g: PCGGlyph; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowGlyphs';
{$EXTERNALSYM CGContextShowGlyphs}
procedure CGContextShowGlyphsAtPoint(context: CGContextRef; x: Single; y: Single; glyphs: PCGGlyph; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowGlyphsAtPoint';
{$EXTERNALSYM CGContextShowGlyphsAtPoint}
procedure CGContextShowGlyphsAtPositions(context: CGContextRef; glyphs: PCGGlyph; positions: PCGPoint; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowGlyphsAtPositions';
{$EXTERNALSYM CGContextShowGlyphsAtPositions}
procedure CGContextShowGlyphsWithAdvances(c: CGContextRef; glyphs: PCGGlyph; advances: PCGSize; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowGlyphsWithAdvances';
{$EXTERNALSYM CGContextShowGlyphsWithAdvances}
procedure CGContextShowText(c: CGContextRef; string_: MarshaledAString; length: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowText';
{$EXTERNALSYM CGContextShowText}
procedure CGContextShowTextAtPoint(c: CGContextRef; x: Single; y: Single; string_: MarshaledAString; length: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextShowTextAtPoint';
{$EXTERNALSYM CGContextShowTextAtPoint}
procedure CGContextStrokeEllipseInRect(context: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextStrokeEllipseInRect';
{$EXTERNALSYM CGContextStrokeEllipseInRect}
procedure CGContextStrokeLineSegments(c: CGContextRef; points: PCGPoint; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGContextStrokeLineSegments';
{$EXTERNALSYM CGContextStrokeLineSegments}
procedure CGContextStrokePath(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextStrokePath';
{$EXTERNALSYM CGContextStrokePath}
procedure CGContextStrokeRect(c: CGContextRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGContextStrokeRect';
{$EXTERNALSYM CGContextStrokeRect}
procedure CGContextStrokeRectWithWidth(c: CGContextRef; rect: CGRect; width: Single); cdecl; external libCoreGraphics name _PU + 'CGContextStrokeRectWithWidth';
{$EXTERNALSYM CGContextStrokeRectWithWidth}
procedure CGContextSynchronize(c: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGContextSynchronize';
{$EXTERNALSYM CGContextSynchronize}
procedure CGContextTranslateCTM(c: CGContextRef; tx: Single; ty: Single); cdecl; external libCoreGraphics name _PU + 'CGContextTranslateCTM';
{$EXTERNALSYM CGContextTranslateCTM}
function CGCursorIsDrawnInFramebuffer: Integer; cdecl; external libCoreGraphics name _PU + 'CGCursorIsDrawnInFramebuffer';
{$EXTERNALSYM CGCursorIsDrawnInFramebuffer}
function CGCursorIsVisible: Integer; cdecl; external libCoreGraphics name _PU + 'CGCursorIsVisible';
{$EXTERNALSYM CGCursorIsVisible}
function CGDataConsumerCreate(info: Pointer; callbacks: PCGDataConsumerCallbacks): CGDataConsumerRef; cdecl; external libCoreGraphics name _PU + 'CGDataConsumerCreate';
{$EXTERNALSYM CGDataConsumerCreate}
function CGDataConsumerCreateWithCFData(data: CFMutableDataRef): CGDataConsumerRef; cdecl; external libCoreGraphics name _PU + 'CGDataConsumerCreateWithCFData';
{$EXTERNALSYM CGDataConsumerCreateWithCFData}
function CGDataConsumerCreateWithURL(url: CFURLRef): CGDataConsumerRef; cdecl; external libCoreGraphics name _PU + 'CGDataConsumerCreateWithURL';
{$EXTERNALSYM CGDataConsumerCreateWithURL}
function CGDataConsumerGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGDataConsumerGetTypeID';
{$EXTERNALSYM CGDataConsumerGetTypeID}
procedure CGDataConsumerRelease(consumer: CGDataConsumerRef); cdecl; external libCoreGraphics name _PU + 'CGDataConsumerRelease';
{$EXTERNALSYM CGDataConsumerRelease}
function CGDataConsumerRetain(consumer: CGDataConsumerRef): CGDataConsumerRef; cdecl; external libCoreGraphics name _PU + 'CGDataConsumerRetain';
{$EXTERNALSYM CGDataConsumerRetain}
function CGDataProviderCopyData(provider: CGDataProviderRef): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCopyData';
{$EXTERNALSYM CGDataProviderCopyData}
function CGDataProviderCreate(info: Pointer; callbacks: PCGDataProviderCallbacks): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreate';
{$EXTERNALSYM CGDataProviderCreate}
function CGDataProviderCreateDirect(info: Pointer; size: Integer; callbacks: PCGDataProviderDirectCallbacks): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateDirect';
{$EXTERNALSYM CGDataProviderCreateDirect}
function CGDataProviderCreateDirectAccess(info: Pointer; size: Longword; callbacks: PCGDataProviderDirectAccessCallbacks): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateDirectAccess';
{$EXTERNALSYM CGDataProviderCreateDirectAccess}
function CGDataProviderCreateSequential(info: Pointer; callbacks: PCGDataProviderSequentialCallbacks): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateSequential';
{$EXTERNALSYM CGDataProviderCreateSequential}
function CGDataProviderCreateWithCFData(data: CFDataRef): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateWithCFData';
{$EXTERNALSYM CGDataProviderCreateWithCFData}
function CGDataProviderCreateWithData(info: Pointer; data: Pointer; size: Longword; releaseData: CGDataProviderReleaseDataCallback): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateWithData';
{$EXTERNALSYM CGDataProviderCreateWithData}
function CGDataProviderCreateWithFilename(filename: MarshaledAString): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateWithFilename';
{$EXTERNALSYM CGDataProviderCreateWithFilename}
function CGDataProviderCreateWithURL(url: CFURLRef): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderCreateWithURL';
{$EXTERNALSYM CGDataProviderCreateWithURL}
function CGDataProviderGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGDataProviderGetTypeID';
{$EXTERNALSYM CGDataProviderGetTypeID}
procedure CGDataProviderRelease(provider: CGDataProviderRef); cdecl; external libCoreGraphics name _PU + 'CGDataProviderRelease';
{$EXTERNALSYM CGDataProviderRelease}
function CGDataProviderRetain(provider: CGDataProviderRef): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGDataProviderRetain';
{$EXTERNALSYM CGDataProviderRetain}
function CGDisplayAddressForPosition(display: CGDirectDisplayID; x: Integer; y: Integer): Pointer; cdecl; external libCoreGraphics name _PU + 'CGDisplayAddressForPosition';
{$EXTERNALSYM CGDisplayAddressForPosition}
function CGDisplayAvailableModes(display: CGDirectDisplayID): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayAvailableModes';
{$EXTERNALSYM CGDisplayAvailableModes}
function CGDisplayBaseAddress(display: CGDirectDisplayID): Pointer; cdecl; external libCoreGraphics name _PU + 'CGDisplayBaseAddress';
{$EXTERNALSYM CGDisplayBaseAddress}
function CGDisplayBeamPosition(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayBeamPosition';
{$EXTERNALSYM CGDisplayBeamPosition}
function CGDisplayBestModeForParameters(display: CGDirectDisplayID; bitsPerPixel: Longword; width: Longword; height: Longword; exactMatch: PInteger): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayBestModeForParameters';
{$EXTERNALSYM CGDisplayBestModeForParameters}
function CGDisplayBestModeForParametersAndRefreshRate(display: CGDirectDisplayID; bitsPerPixel: Longword; width: Longword; height: Longword; refreshRate: CGRefreshRate; exactMatch: PInteger): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayBestModeForParametersAndRefreshRate';
{$EXTERNALSYM CGDisplayBestModeForParametersAndRefreshRate}
function CGDisplayBestModeForParametersAndRefreshRateWithProperty(display: CGDirectDisplayID; bitsPerPixel: Longword; width: Longword; height: Longword; refreshRate: CGRefreshRate; property_: CFStringRef; exactMatch: PInteger): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayBestModeForParametersAndRefreshRateWithProperty';
{$EXTERNALSYM CGDisplayBestModeForParametersAndRefreshRateWithProperty}
function CGDisplayBitsPerPixel(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayBitsPerPixel';
{$EXTERNALSYM CGDisplayBitsPerPixel}
function CGDisplayBitsPerSample(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayBitsPerSample';
{$EXTERNALSYM CGDisplayBitsPerSample}
function CGDisplayBounds(display: CGDirectDisplayID): CGRect; cdecl; external libCoreGraphics name _PU + 'CGDisplayBounds';
{$EXTERNALSYM CGDisplayBounds}
function CGDisplayBytesPerRow(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayBytesPerRow';
{$EXTERNALSYM CGDisplayBytesPerRow}
function CGDisplayCanSetPalette(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayCanSetPalette';
{$EXTERNALSYM CGDisplayCanSetPalette}
function CGDisplayCapture(display: CGDirectDisplayID): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayCapture';
{$EXTERNALSYM CGDisplayCapture}
function CGDisplayCaptureWithOptions(display: CGDirectDisplayID; options: CGCaptureOptions): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayCaptureWithOptions';
{$EXTERNALSYM CGDisplayCaptureWithOptions}
function CGDisplayCopyAllDisplayModes(display: CGDirectDisplayID; options: CFDictionaryRef): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCopyAllDisplayModes';
{$EXTERNALSYM CGDisplayCopyAllDisplayModes}
function CGDisplayCopyColorSpace(display: CGDirectDisplayID): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCopyColorSpace';
{$EXTERNALSYM CGDisplayCopyColorSpace}
function CGDisplayCopyDisplayMode(display: CGDirectDisplayID): CGDisplayModeRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCopyDisplayMode';
{$EXTERNALSYM CGDisplayCopyDisplayMode}
function CGDisplayCreateImage(displayID: CGDirectDisplayID): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCreateImage';
{$EXTERNALSYM CGDisplayCreateImage}
function CGDisplayCreateImageForRect(display: CGDirectDisplayID; rect: CGRect): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCreateImageForRect';
{$EXTERNALSYM CGDisplayCreateImageForRect}
function CGDisplayCurrentMode(display: CGDirectDisplayID): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayCurrentMode';
{$EXTERNALSYM CGDisplayCurrentMode}
function CGDisplayFade(token: CGDisplayFadeReservationToken; duration: CGDisplayFadeInterval; startBlend: CGDisplayBlendFraction; endBlend: CGDisplayBlendFraction; redBlend: Single; greenBlend: Single; blueBlend: Single; synchronous: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayFade';
{$EXTERNALSYM CGDisplayFade}
function CGDisplayFadeOperationInProgress: Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayFadeOperationInProgress';
{$EXTERNALSYM CGDisplayFadeOperationInProgress}
function CGDisplayGammaTableCapacity(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayGammaTableCapacity';
{$EXTERNALSYM CGDisplayGammaTableCapacity}
function CGDisplayGetDrawingContext(display: CGDirectDisplayID): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayGetDrawingContext';
{$EXTERNALSYM CGDisplayGetDrawingContext}
function CGDisplayHideCursor(display: CGDirectDisplayID): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayHideCursor';
{$EXTERNALSYM CGDisplayHideCursor}
function CGDisplayIDToOpenGLDisplayMask(display: CGDirectDisplayID): CGOpenGLDisplayMask; cdecl; external libCoreGraphics name _PU + 'CGDisplayIDToOpenGLDisplayMask';
{$EXTERNALSYM CGDisplayIDToOpenGLDisplayMask}
//function CGDisplayIOServicePort(display: CGDirectDisplayID): io_service_t; cdecl; external libCoreGraphics name _PU + 'CGDisplayIOServicePort';
function CGDisplayIsActive(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsActive';
{$EXTERNALSYM CGDisplayIsActive}
function CGDisplayIsAlwaysInMirrorSet(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsAlwaysInMirrorSet';
{$EXTERNALSYM CGDisplayIsAlwaysInMirrorSet}
function CGDisplayIsAsleep(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsAsleep';
{$EXTERNALSYM CGDisplayIsAsleep}
function CGDisplayIsBuiltin(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsBuiltin';
{$EXTERNALSYM CGDisplayIsBuiltin}
function CGDisplayIsCaptured(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsCaptured';
{$EXTERNALSYM CGDisplayIsCaptured}
function CGDisplayIsInHWMirrorSet(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsInHWMirrorSet';
{$EXTERNALSYM CGDisplayIsInHWMirrorSet}
function CGDisplayIsInMirrorSet(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsInMirrorSet';
{$EXTERNALSYM CGDisplayIsInMirrorSet}
function CGDisplayIsMain(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsMain';
{$EXTERNALSYM CGDisplayIsMain}
function CGDisplayIsOnline(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsOnline';
{$EXTERNALSYM CGDisplayIsOnline}
function CGDisplayIsStereo(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayIsStereo';
{$EXTERNALSYM CGDisplayIsStereo}
function CGDisplayMirrorsDisplay(display: CGDirectDisplayID): CGDirectDisplayID; cdecl; external libCoreGraphics name _PU + 'CGDisplayMirrorsDisplay';
{$EXTERNALSYM CGDisplayMirrorsDisplay}
function CGDisplayModeCopyPixelEncoding(mode: CGDisplayModeRef): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeCopyPixelEncoding';
{$EXTERNALSYM CGDisplayModeCopyPixelEncoding}
function CGDisplayModeGetHeight(mode: CGDisplayModeRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetHeight';
{$EXTERNALSYM CGDisplayModeGetHeight}
function CGDisplayModeGetIODisplayModeID(mode: CGDisplayModeRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetIODisplayModeID';
{$EXTERNALSYM CGDisplayModeGetIODisplayModeID}
function CGDisplayModeGetIOFlags(mode: CGDisplayModeRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetIOFlags';
{$EXTERNALSYM CGDisplayModeGetIOFlags}
function CGDisplayModeGetRefreshRate(mode: CGDisplayModeRef): double; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetRefreshRate';
{$EXTERNALSYM CGDisplayModeGetRefreshRate}
function CGDisplayModeGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetTypeID';
{$EXTERNALSYM CGDisplayModeGetTypeID}
function CGDisplayModeGetWidth(mode: CGDisplayModeRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeGetWidth';
{$EXTERNALSYM CGDisplayModeGetWidth}
function CGDisplayModeIsUsableForDesktopGUI(mode: CGDisplayModeRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeIsUsableForDesktopGUI';
{$EXTERNALSYM CGDisplayModeIsUsableForDesktopGUI}
procedure CGDisplayModeRelease(mode: CGDisplayModeRef); cdecl; external libCoreGraphics name _PU + 'CGDisplayModeRelease';
{$EXTERNALSYM CGDisplayModeRelease}
function CGDisplayModeRetain(mode: CGDisplayModeRef): CGDisplayModeRef; cdecl; external libCoreGraphics name _PU + 'CGDisplayModeRetain';
{$EXTERNALSYM CGDisplayModeRetain}
function CGDisplayModelNumber(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayModelNumber';
{$EXTERNALSYM CGDisplayModelNumber}
function CGDisplayMoveCursorToPoint(display: CGDirectDisplayID; point: CGPoint): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayMoveCursorToPoint';
{$EXTERNALSYM CGDisplayMoveCursorToPoint}
function CGDisplayPixelsHigh(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayPixelsHigh';
{$EXTERNALSYM CGDisplayPixelsHigh}
function CGDisplayPixelsWide(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayPixelsWide';
{$EXTERNALSYM CGDisplayPixelsWide}
function CGDisplayPrimaryDisplay(display: CGDirectDisplayID): CGDirectDisplayID; cdecl; external libCoreGraphics name _PU + 'CGDisplayPrimaryDisplay';
{$EXTERNALSYM CGDisplayPrimaryDisplay}
function CGDisplayRegisterReconfigurationCallback(callback: CGDisplayReconfigurationCallBack; userInfo: Pointer): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayRegisterReconfigurationCallback';
{$EXTERNALSYM CGDisplayRegisterReconfigurationCallback}
function CGDisplayRelease(display: CGDirectDisplayID): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayRelease';
{$EXTERNALSYM CGDisplayRelease}
function CGDisplayRemoveReconfigurationCallback(callback: CGDisplayReconfigurationCallBack; userInfo: Pointer): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayRemoveReconfigurationCallback';
{$EXTERNALSYM CGDisplayRemoveReconfigurationCallback}
procedure CGDisplayRestoreColorSyncSettings; cdecl; external libCoreGraphics name _PU + 'CGDisplayRestoreColorSyncSettings';
{$EXTERNALSYM CGDisplayRestoreColorSyncSettings}
function CGDisplayRotation(display: CGDirectDisplayID): double; cdecl; external libCoreGraphics name _PU + 'CGDisplayRotation';
{$EXTERNALSYM CGDisplayRotation}
function CGDisplaySamplesPerPixel(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplaySamplesPerPixel';
{$EXTERNALSYM CGDisplaySamplesPerPixel}
function CGDisplayScreenSize(display: CGDirectDisplayID): CGSize; cdecl; external libCoreGraphics name _PU + 'CGDisplayScreenSize';
{$EXTERNALSYM CGDisplayScreenSize}
function CGDisplaySerialNumber(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplaySerialNumber';
{$EXTERNALSYM CGDisplaySerialNumber}
function CGDisplaySetDisplayMode(display: CGDirectDisplayID; mode: CGDisplayModeRef; options: CFDictionaryRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplaySetDisplayMode';
{$EXTERNALSYM CGDisplaySetDisplayMode}
function CGDisplaySetPalette(display: CGDirectDisplayID; palette: CGDirectPaletteRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplaySetPalette';
{$EXTERNALSYM CGDisplaySetPalette}
function CGDisplaySetStereoOperation(display: CGDirectDisplayID; stereo: Integer; forceBlueLine: Integer; option: CGConfigureOption): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplaySetStereoOperation';
{$EXTERNALSYM CGDisplaySetStereoOperation}
function CGDisplayShowCursor(display: CGDirectDisplayID): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayShowCursor';
{$EXTERNALSYM CGDisplayShowCursor}
function CGDisplaySwitchToMode(display: CGDirectDisplayID; mode: CFDictionaryRef): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplaySwitchToMode';
{$EXTERNALSYM CGDisplaySwitchToMode}
function CGDisplayUnitNumber(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayUnitNumber';
{$EXTERNALSYM CGDisplayUnitNumber}
function CGDisplayUsesOpenGLAcceleration(display: CGDirectDisplayID): Integer; cdecl; external libCoreGraphics name _PU + 'CGDisplayUsesOpenGLAcceleration';
{$EXTERNALSYM CGDisplayUsesOpenGLAcceleration}
function CGDisplayVendorNumber(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGDisplayVendorNumber';
{$EXTERNALSYM CGDisplayVendorNumber}
function CGDisplayWaitForBeamPositionOutsideLines(display: CGDirectDisplayID; upperScanLine: Longword; lowerScanLine: Longword): CGError; cdecl; external libCoreGraphics name _PU + 'CGDisplayWaitForBeamPositionOutsideLines';
{$EXTERNALSYM CGDisplayWaitForBeamPositionOutsideLines}
function CGEnableEventStateCombining(combineState: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGEnableEventStateCombining';
{$EXTERNALSYM CGEnableEventStateCombining}
function CGEventCreate(source: CGEventSourceRef): CGEventRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreate';
{$EXTERNALSYM CGEventCreate}
function CGEventCreateCopy(event: CGEventRef): CGEventRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateCopy';
{$EXTERNALSYM CGEventCreateCopy}
function CGEventCreateData(allocator: CFAllocatorRef; event: CGEventRef): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateData';
{$EXTERNALSYM CGEventCreateData}
function CGEventCreateFromData(allocator: CFAllocatorRef; data: CFDataRef): CGEventRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateFromData';
{$EXTERNALSYM CGEventCreateFromData}
function CGEventCreateKeyboardEvent(source: CGEventSourceRef; virtualKey: CGKeyCode; keyDown: Integer): CGEventRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateKeyboardEvent';
{$EXTERNALSYM CGEventCreateKeyboardEvent}
function CGEventCreateMouseEvent(source: CGEventSourceRef; mouseType: CGEventType; mouseCursorPosition: CGPoint; mouseButton: CGMouseButton): CGEventRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateMouseEvent';
{$EXTERNALSYM CGEventCreateMouseEvent}
function CGEventCreateScrollWheelEvent(source: CGEventSourceRef; units: CGScrollEventUnit; wheelCount: Longword; wheel1: Integer): CGEventRef; cdecl; varargs; external libCoreGraphics name _PU + 'CGEventCreateScrollWheelEvent';
{$EXTERNALSYM CGEventCreateScrollWheelEvent}
function CGEventCreateSourceFromEvent(event: CGEventRef): CGEventSourceRef; cdecl; external libCoreGraphics name _PU + 'CGEventCreateSourceFromEvent';
{$EXTERNALSYM CGEventCreateSourceFromEvent}
function CGEventGetDoubleValueField(event: CGEventRef; field: CGEventField): double; cdecl; external libCoreGraphics name _PU + 'CGEventGetDoubleValueField';
{$EXTERNALSYM CGEventGetDoubleValueField}
function CGEventGetFlags(event: CGEventRef): CGEventFlags; cdecl; external libCoreGraphics name _PU + 'CGEventGetFlags';
{$EXTERNALSYM CGEventGetFlags}
function CGEventGetIntegerValueField(event: CGEventRef; field: CGEventField): Int64; cdecl; external libCoreGraphics name _PU + 'CGEventGetIntegerValueField';
{$EXTERNALSYM CGEventGetIntegerValueField}
function CGEventGetLocation(event: CGEventRef): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGEventGetLocation';
{$EXTERNALSYM CGEventGetLocation}
function CGEventGetTimestamp(event: CGEventRef): CGEventTimestamp; cdecl; external libCoreGraphics name _PU + 'CGEventGetTimestamp';
{$EXTERNALSYM CGEventGetTimestamp}
function CGEventGetType(event: CGEventRef): CGEventType; cdecl; external libCoreGraphics name _PU + 'CGEventGetType';
{$EXTERNALSYM CGEventGetType}
function CGEventGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGEventGetTypeID';
{$EXTERNALSYM CGEventGetTypeID}
function CGEventGetUnflippedLocation(event: CGEventRef): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGEventGetUnflippedLocation';
{$EXTERNALSYM CGEventGetUnflippedLocation}
procedure CGEventKeyboardGetUnicodeString(event: CGEventRef; maxStringLength: UniCharCount; actualStringLength: UniCharCountPtr; unicodeString: PUniChar); cdecl; external libCoreGraphics name _PU + 'CGEventKeyboardGetUnicodeString';
{$EXTERNALSYM CGEventKeyboardGetUnicodeString}
procedure CGEventKeyboardSetUnicodeString(event: CGEventRef; stringLength: UniCharCount; unicodeString: PUniChar); cdecl; external libCoreGraphics name _PU + 'CGEventKeyboardSetUnicodeString';
{$EXTERNALSYM CGEventKeyboardSetUnicodeString}
procedure CGEventPost(tap: CGEventTapLocation; event: CGEventRef); cdecl; external libCoreGraphics name _PU + 'CGEventPost';
{$EXTERNALSYM CGEventPost}
procedure CGEventPostToPSN(processSerialNumber: Pointer; event: CGEventRef); cdecl; external libCoreGraphics name _PU + 'CGEventPostToPSN';
{$EXTERNALSYM CGEventPostToPSN}
procedure CGEventSetDoubleValueField(event: CGEventRef; field: CGEventField; value: double); cdecl; external libCoreGraphics name _PU + 'CGEventSetDoubleValueField';
{$EXTERNALSYM CGEventSetDoubleValueField}
procedure CGEventSetFlags(event: CGEventRef; flags: CGEventFlags); cdecl; external libCoreGraphics name _PU + 'CGEventSetFlags';
{$EXTERNALSYM CGEventSetFlags}
procedure CGEventSetIntegerValueField(event: CGEventRef; field: CGEventField; value: Int64); cdecl; external libCoreGraphics name _PU + 'CGEventSetIntegerValueField';
{$EXTERNALSYM CGEventSetIntegerValueField}
procedure CGEventSetLocation(event: CGEventRef; location: CGPoint); cdecl; external libCoreGraphics name _PU + 'CGEventSetLocation';
{$EXTERNALSYM CGEventSetLocation}
procedure CGEventSetSource(event: CGEventRef; source: CGEventSourceRef); cdecl; external libCoreGraphics name _PU + 'CGEventSetSource';
{$EXTERNALSYM CGEventSetSource}
procedure CGEventSetTimestamp(event: CGEventRef; timestamp: CGEventTimestamp); cdecl; external libCoreGraphics name _PU + 'CGEventSetTimestamp';
{$EXTERNALSYM CGEventSetTimestamp}
procedure CGEventSetType(event: CGEventRef; type_: CGEventType); cdecl; external libCoreGraphics name _PU + 'CGEventSetType';
{$EXTERNALSYM CGEventSetType}
function CGEventSourceButtonState(stateID: CGEventSourceStateID; button: CGMouseButton): Integer; cdecl; external libCoreGraphics name _PU + 'CGEventSourceButtonState';
{$EXTERNALSYM CGEventSourceButtonState}
function CGEventSourceCounterForEventType(stateID: CGEventSourceStateID; eventType: CGEventType): Longword; cdecl; external libCoreGraphics name _PU + 'CGEventSourceCounterForEventType';
{$EXTERNALSYM CGEventSourceCounterForEventType}
function CGEventSourceCreate(stateID: CGEventSourceStateID): CGEventSourceRef; cdecl; external libCoreGraphics name _PU + 'CGEventSourceCreate';
{$EXTERNALSYM CGEventSourceCreate}
function CGEventSourceFlagsState(stateID: CGEventSourceStateID): CGEventFlags; cdecl; external libCoreGraphics name _PU + 'CGEventSourceFlagsState';
{$EXTERNALSYM CGEventSourceFlagsState}
function CGEventSourceGetKeyboardType(source: CGEventSourceRef): CGEventSourceKeyboardType; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetKeyboardType';
{$EXTERNALSYM CGEventSourceGetKeyboardType}
function CGEventSourceGetLocalEventsFilterDuringSuppressionState(source: CGEventSourceRef; state: CGEventSuppressionState): CGEventFilterMask; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetLocalEventsFilterDuringSuppressionState';
{$EXTERNALSYM CGEventSourceGetLocalEventsFilterDuringSuppressionState}
function CGEventSourceGetLocalEventsSuppressionInterval(source: CGEventSourceRef): CFTimeInterval; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetLocalEventsSuppressionInterval';
{$EXTERNALSYM CGEventSourceGetLocalEventsSuppressionInterval}
function CGEventSourceGetPixelsPerLine(source: CGEventSourceRef): double; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetPixelsPerLine';
{$EXTERNALSYM CGEventSourceGetPixelsPerLine}
function CGEventSourceGetSourceStateID(source: CGEventSourceRef): CGEventSourceStateID; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetSourceStateID';
{$EXTERNALSYM CGEventSourceGetSourceStateID}
function CGEventSourceGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetTypeID';
{$EXTERNALSYM CGEventSourceGetTypeID}
function CGEventSourceGetUserData(source: CGEventSourceRef): Int64; cdecl; external libCoreGraphics name _PU + 'CGEventSourceGetUserData';
{$EXTERNALSYM CGEventSourceGetUserData}
function CGEventSourceKeyState(stateID: CGEventSourceStateID; key: CGKeyCode): Integer; cdecl; external libCoreGraphics name _PU + 'CGEventSourceKeyState';
{$EXTERNALSYM CGEventSourceKeyState}
function CGEventSourceSecondsSinceLastEventType(stateID: CGEventSourceStateID; eventType: CGEventType): CFTimeInterval; cdecl; external libCoreGraphics name _PU + 'CGEventSourceSecondsSinceLastEventType';
{$EXTERNALSYM CGEventSourceSecondsSinceLastEventType}
procedure CGEventSourceSetKeyboardType(source: CGEventSourceRef; keyboardType: CGEventSourceKeyboardType); cdecl; external libCoreGraphics name _PU + 'CGEventSourceSetKeyboardType';
{$EXTERNALSYM CGEventSourceSetKeyboardType}
procedure CGEventSourceSetLocalEventsFilterDuringSuppressionState(source: CGEventSourceRef; filter: CGEventFilterMask; state: CGEventSuppressionState); cdecl; external libCoreGraphics name _PU + 'CGEventSourceSetLocalEventsFilterDuringSuppressionState';
{$EXTERNALSYM CGEventSourceSetLocalEventsFilterDuringSuppressionState}
procedure CGEventSourceSetLocalEventsSuppressionInterval(source: CGEventSourceRef; seconds: CFTimeInterval); cdecl; external libCoreGraphics name _PU + 'CGEventSourceSetLocalEventsSuppressionInterval';
{$EXTERNALSYM CGEventSourceSetLocalEventsSuppressionInterval}
procedure CGEventSourceSetPixelsPerLine(source: CGEventSourceRef; pixelsPerLine: double); cdecl; external libCoreGraphics name _PU + 'CGEventSourceSetPixelsPerLine';
{$EXTERNALSYM CGEventSourceSetPixelsPerLine}
procedure CGEventSourceSetUserData(source: CGEventSourceRef; userData: Int64); cdecl; external libCoreGraphics name _PU + 'CGEventSourceSetUserData';
{$EXTERNALSYM CGEventSourceSetUserData}
function CGEventTapCreate(tap: CGEventTapLocation; place: CGEventTapPlacement; options: CGEventTapOptions; eventsOfInterest: CGEventMask; callback: CGEventTapCallBack; userInfo: Pointer): CFMachPortRef; cdecl; external libCoreGraphics name _PU + 'CGEventTapCreate';
{$EXTERNALSYM CGEventTapCreate}
function CGEventTapCreateForPSN(processSerialNumber: Pointer; place: CGEventTapPlacement; options: CGEventTapOptions; eventsOfInterest: CGEventMask; callback: CGEventTapCallBack; userInfo: Pointer): CFMachPortRef; cdecl; external libCoreGraphics name _PU + 'CGEventTapCreateForPSN';
{$EXTERNALSYM CGEventTapCreateForPSN}
procedure CGEventTapEnable(tap: CFMachPortRef; enable: Integer); cdecl; external libCoreGraphics name _PU + 'CGEventTapEnable';
{$EXTERNALSYM CGEventTapEnable}
function CGEventTapIsEnabled(tap: CFMachPortRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGEventTapIsEnabled';
{$EXTERNALSYM CGEventTapIsEnabled}
procedure CGEventTapPostEvent(proxy: CGEventTapProxy; event: CGEventRef); cdecl; external libCoreGraphics name _PU + 'CGEventTapPostEvent';
{$EXTERNALSYM CGEventTapPostEvent}
function CGFontCanCreatePostScriptSubset(font: CGFontRef; format: CGFontPostScriptFormat): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontCanCreatePostScriptSubset';
{$EXTERNALSYM CGFontCanCreatePostScriptSubset}
function CGFontCopyFullName(font: CGFontRef): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyFullName';
{$EXTERNALSYM CGFontCopyFullName}
function CGFontCopyGlyphNameForGlyph(font: CGFontRef; glyph: CGGlyph): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyGlyphNameForGlyph';
{$EXTERNALSYM CGFontCopyGlyphNameForGlyph}
function CGFontCopyPostScriptName(font: CGFontRef): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyPostScriptName';
{$EXTERNALSYM CGFontCopyPostScriptName}
function CGFontCopyTableForTag(font: CGFontRef; tag: Longword): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyTableForTag';
{$EXTERNALSYM CGFontCopyTableForTag}
function CGFontCopyTableTags(font: CGFontRef): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyTableTags';
{$EXTERNALSYM CGFontCopyTableTags}
function CGFontCopyVariationAxes(font: CGFontRef): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyVariationAxes';
{$EXTERNALSYM CGFontCopyVariationAxes}
function CGFontCopyVariations(font: CGFontRef): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGFontCopyVariations';
{$EXTERNALSYM CGFontCopyVariations}
function CGFontCreateCopyWithVariations(font: CGFontRef; variations: CFDictionaryRef): CGFontRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreateCopyWithVariations';
{$EXTERNALSYM CGFontCreateCopyWithVariations}
function CGFontCreatePostScriptEncoding(font: CGFontRef; encoding: PCGGlyph): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreatePostScriptEncoding';
{$EXTERNALSYM CGFontCreatePostScriptEncoding}
function CGFontCreatePostScriptSubset(font: CGFontRef; subsetName: CFStringRef; format: CGFontPostScriptFormat; glyphs: PCGGlyph; count: Longword; encoding: PCGGlyph): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreatePostScriptSubset';
{$EXTERNALSYM CGFontCreatePostScriptSubset}
function CGFontCreateWithDataProvider(provider: CGDataProviderRef): CGFontRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreateWithDataProvider';
{$EXTERNALSYM CGFontCreateWithDataProvider}
function CGFontCreateWithFontName(name: CFStringRef): CGFontRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreateWithFontName';
{$EXTERNALSYM CGFontCreateWithFontName}
function CGFontCreateWithPlatformFont(platformFontReference: Pointer): CGFontRef; cdecl; external libCoreGraphics name _PU + 'CGFontCreateWithPlatformFont';
{$EXTERNALSYM CGFontCreateWithPlatformFont}
function CGFontGetAscent(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetAscent';
{$EXTERNALSYM CGFontGetAscent}
function CGFontGetCapHeight(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetCapHeight';
{$EXTERNALSYM CGFontGetCapHeight}
function CGFontGetDescent(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetDescent';
{$EXTERNALSYM CGFontGetDescent}
function CGFontGetFontBBox(font: CGFontRef): CGRect; cdecl; external libCoreGraphics name _PU + 'CGFontGetFontBBox';
{$EXTERNALSYM CGFontGetFontBBox}
function CGFontGetGlyphAdvances(font: CGFontRef; glyphs: PCGGlyph; count: Longword; advances: PInteger): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetGlyphAdvances';
{$EXTERNALSYM CGFontGetGlyphAdvances}
function CGFontGetGlyphBBoxes(font: CGFontRef; glyphs: PCGGlyph; count: Longword; bboxes: PCGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetGlyphBBoxes';
{$EXTERNALSYM CGFontGetGlyphBBoxes}
function CGFontGetGlyphWithGlyphName(font: CGFontRef; name: CFStringRef): CGGlyph; cdecl; external libCoreGraphics name _PU + 'CGFontGetGlyphWithGlyphName';
{$EXTERNALSYM CGFontGetGlyphWithGlyphName}
function CGFontGetItalicAngle(font: CGFontRef): Single; cdecl; external libCoreGraphics name _PU + 'CGFontGetItalicAngle';
{$EXTERNALSYM CGFontGetItalicAngle}
function CGFontGetLeading(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetLeading';
{$EXTERNALSYM CGFontGetLeading}
function CGFontGetNumberOfGlyphs(font: CGFontRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGFontGetNumberOfGlyphs';
{$EXTERNALSYM CGFontGetNumberOfGlyphs}
function CGFontGetStemV(font: CGFontRef): Single; cdecl; external libCoreGraphics name _PU + 'CGFontGetStemV';
{$EXTERNALSYM CGFontGetStemV}
function CGFontGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGFontGetTypeID';
{$EXTERNALSYM CGFontGetTypeID}
function CGFontGetUnitsPerEm(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetUnitsPerEm';
{$EXTERNALSYM CGFontGetUnitsPerEm}
function CGFontGetXHeight(font: CGFontRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGFontGetXHeight';
{$EXTERNALSYM CGFontGetXHeight}
procedure CGFontRelease(font: CGFontRef); cdecl; external libCoreGraphics name _PU + 'CGFontRelease';
{$EXTERNALSYM CGFontRelease}
function CGFontRetain(font: CGFontRef): CGFontRef; cdecl; external libCoreGraphics name _PU + 'CGFontRetain';
{$EXTERNALSYM CGFontRetain}
function CGFunctionCreate(info: Pointer; domainDimension: Longword; domain: PSingle; rangeDimension: Longword; range: PSingle; callbacks: PCGFunctionCallbacks): CGFunctionRef; cdecl; external libCoreGraphics name _PU + 'CGFunctionCreate';
{$EXTERNALSYM CGFunctionCreate}
function CGFunctionGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGFunctionGetTypeID';
{$EXTERNALSYM CGFunctionGetTypeID}
procedure CGFunctionRelease(function_: CGFunctionRef); cdecl; external libCoreGraphics name _PU + 'CGFunctionRelease';
{$EXTERNALSYM CGFunctionRelease}
function CGFunctionRetain(function_: CGFunctionRef): CGFunctionRef; cdecl; external libCoreGraphics name _PU + 'CGFunctionRetain';
{$EXTERNALSYM CGFunctionRetain}
function CGGLContextCreate(glContext: Pointer; size: CGSize; colorspace: CGColorSpaceRef): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGGLContextCreate';
{$EXTERNALSYM CGGLContextCreate}
procedure CGGLContextUpdateViewportSize(c: CGContextRef; size: CGSize); cdecl; external libCoreGraphics name _PU + 'CGGLContextUpdateViewportSize';
{$EXTERNALSYM CGGLContextUpdateViewportSize}
function CGGetActiveDisplayList(maxDisplays: Longword; activeDisplays: PCGDirectDisplayID; displayCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetActiveDisplayList';
{$EXTERNALSYM CGGetActiveDisplayList}
function CGGetDisplayTransferByFormula(display: CGDirectDisplayID; redMin: PCGGammaValue; redMax: PCGGammaValue; redGamma: PCGGammaValue; greenMin: PCGGammaValue; greenMax: PCGGammaValue; greenGamma: PCGGammaValue; blueMin: PCGGammaValue; blueMax: PCGGammaValue; blueGamma: PCGGammaValue): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetDisplayTransferByFormula';
{$EXTERNALSYM CGGetDisplayTransferByFormula}
function CGGetDisplayTransferByTable(display: CGDirectDisplayID; capacity: Longword; redTable: PCGGammaValue; greenTable: PCGGammaValue; blueTable: PCGGammaValue; sampleCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetDisplayTransferByTable';
{$EXTERNALSYM CGGetDisplayTransferByTable}
function CGGetDisplaysWithOpenGLDisplayMask(mask: CGOpenGLDisplayMask; maxDisplays: Longword; displays: PCGDirectDisplayID; matchingDisplayCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetDisplaysWithOpenGLDisplayMask';
{$EXTERNALSYM CGGetDisplaysWithOpenGLDisplayMask}
function CGGetDisplaysWithPoint(point: CGPoint; maxDisplays: Longword; displays: PCGDirectDisplayID; matchingDisplayCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetDisplaysWithPoint';
{$EXTERNALSYM CGGetDisplaysWithPoint}
function CGGetDisplaysWithRect(rect: CGRect; maxDisplays: Longword; displays: PCGDirectDisplayID; matchingDisplayCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetDisplaysWithRect';
{$EXTERNALSYM CGGetDisplaysWithRect}
function CGGetEventTapList(maxNumberOfTaps: Longword; tapList: PCGEventTapInformation; eventTapCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetEventTapList';
{$EXTERNALSYM CGGetEventTapList}
procedure CGGetLastMouseDelta(deltaX: PInteger; deltaY: PInteger); cdecl; external libCoreGraphics name _PU + 'CGGetLastMouseDelta';
{$EXTERNALSYM CGGetLastMouseDelta}
function CGGetOnlineDisplayList(maxDisplays: Longword; onlineDisplays: PCGDirectDisplayID; displayCount: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGGetOnlineDisplayList';
{$EXTERNALSYM CGGetOnlineDisplayList}
function CGGradientCreateWithColorComponents(space: CGColorSpaceRef; components: PSingle; locations: PSingle; count: Longword): CGGradientRef; cdecl; external libCoreGraphics name _PU + 'CGGradientCreateWithColorComponents';
{$EXTERNALSYM CGGradientCreateWithColorComponents}
function CGGradientCreateWithColors(space: CGColorSpaceRef; colors: CFArrayRef; locations: PSingle): CGGradientRef; cdecl; external libCoreGraphics name _PU + 'CGGradientCreateWithColors';
{$EXTERNALSYM CGGradientCreateWithColors}
function CGGradientGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGGradientGetTypeID';
{$EXTERNALSYM CGGradientGetTypeID}
procedure CGGradientRelease(gradient: CGGradientRef); cdecl; external libCoreGraphics name _PU + 'CGGradientRelease';
{$EXTERNALSYM CGGradientRelease}
function CGGradientRetain(gradient: CGGradientRef): CGGradientRef; cdecl; external libCoreGraphics name _PU + 'CGGradientRetain';
{$EXTERNALSYM CGGradientRetain}
function CGImageCreate(width: Longword; height: Longword; bitsPerComponent: Longword; bitsPerPixel: Longword; bytesPerRow: Longword; space: CGColorSpaceRef; bitmapInfo: CGBitmapInfo; provider: CGDataProviderRef; decode: PSingle; shouldInterpolate: Integer; intent: CGColorRenderingIntent): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreate';
{$EXTERNALSYM CGImageCreate}
function CGImageCreateCopy(image: CGImageRef): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateCopy';
{$EXTERNALSYM CGImageCreateCopy}
function CGImageCreateCopyWithColorSpace(image: CGImageRef; space: CGColorSpaceRef): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateCopyWithColorSpace';
{$EXTERNALSYM CGImageCreateCopyWithColorSpace}
function CGImageCreateWithImageInRect(image: CGImageRef; rect: CGRect): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateWithImageInRect';
{$EXTERNALSYM CGImageCreateWithImageInRect}
function CGImageCreateWithJPEGDataProvider(source: CGDataProviderRef; decode: PSingle; shouldInterpolate: Integer; intent: CGColorRenderingIntent): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateWithJPEGDataProvider';
{$EXTERNALSYM CGImageCreateWithJPEGDataProvider}
function CGImageCreateWithMask(image: CGImageRef; mask: CGImageRef): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateWithMask';
{$EXTERNALSYM CGImageCreateWithMask}
function CGImageCreateWithMaskingColors(image: CGImageRef; components: PSingle): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateWithMaskingColors';
{$EXTERNALSYM CGImageCreateWithMaskingColors}
function CGImageCreateWithPNGDataProvider(source: CGDataProviderRef; decode: PSingle; shouldInterpolate: Integer; intent: CGColorRenderingIntent): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageCreateWithPNGDataProvider';
{$EXTERNALSYM CGImageCreateWithPNGDataProvider}
function CGImageGetAlphaInfo(image: CGImageRef): CGImageAlphaInfo; cdecl; external libCoreGraphics name _PU + 'CGImageGetAlphaInfo';
{$EXTERNALSYM CGImageGetAlphaInfo}
function CGImageGetBitmapInfo(image: CGImageRef): CGBitmapInfo; cdecl; external libCoreGraphics name _PU + 'CGImageGetBitmapInfo';
{$EXTERNALSYM CGImageGetBitmapInfo}
function CGImageGetBitsPerComponent(image: CGImageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGImageGetBitsPerComponent';
{$EXTERNALSYM CGImageGetBitsPerComponent}
function CGImageGetBitsPerPixel(image: CGImageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGImageGetBitsPerPixel';
{$EXTERNALSYM CGImageGetBitsPerPixel}
function CGImageGetBytesPerRow(image: CGImageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGImageGetBytesPerRow';
{$EXTERNALSYM CGImageGetBytesPerRow}
function CGImageGetColorSpace(image: CGImageRef): CGColorSpaceRef; cdecl; external libCoreGraphics name _PU + 'CGImageGetColorSpace';
{$EXTERNALSYM CGImageGetColorSpace}
function CGImageGetDataProvider(image: CGImageRef): CGDataProviderRef; cdecl; external libCoreGraphics name _PU + 'CGImageGetDataProvider';
{$EXTERNALSYM CGImageGetDataProvider}
function CGImageGetDecode(image: CGImageRef): PSingle; cdecl; external libCoreGraphics name _PU + 'CGImageGetDecode';
{$EXTERNALSYM CGImageGetDecode}
function CGImageGetHeight(image: CGImageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGImageGetHeight';
{$EXTERNALSYM CGImageGetHeight}
function CGImageGetRenderingIntent(image: CGImageRef): CGColorRenderingIntent; cdecl; external libCoreGraphics name _PU + 'CGImageGetRenderingIntent';
{$EXTERNALSYM CGImageGetRenderingIntent}
function CGImageGetShouldInterpolate(image: CGImageRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGImageGetShouldInterpolate';
{$EXTERNALSYM CGImageGetShouldInterpolate}
function CGImageGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGImageGetTypeID';
{$EXTERNALSYM CGImageGetTypeID}
function CGImageGetWidth(image: CGImageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGImageGetWidth';
{$EXTERNALSYM CGImageGetWidth}
function CGImageIsMask(image: CGImageRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGImageIsMask';
{$EXTERNALSYM CGImageIsMask}
function CGImageMaskCreate(width: Longword; height: Longword; bitsPerComponent: Longword; bitsPerPixel: Longword; bytesPerRow: Longword; provider: CGDataProviderRef; decode: PSingle; shouldInterpolate: Integer): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageMaskCreate';
{$EXTERNALSYM CGImageMaskCreate}
procedure CGImageRelease(image: CGImageRef); cdecl; external libCoreGraphics name _PU + 'CGImageRelease';
{$EXTERNALSYM CGImageRelease}
function CGImageRetain(image: CGImageRef): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGImageRetain';
{$EXTERNALSYM CGImageRetain}
function CGInhibitLocalEvents(inhibit: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGInhibitLocalEvents';
{$EXTERNALSYM CGInhibitLocalEvents}
function CGLayerCreateWithContext(context: CGContextRef; size: CGSize; auxiliaryInfo: CFDictionaryRef): CGLayerRef; cdecl; external libCoreGraphics name _PU + 'CGLayerCreateWithContext';
{$EXTERNALSYM CGLayerCreateWithContext}
function CGLayerGetContext(layer: CGLayerRef): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGLayerGetContext';
{$EXTERNALSYM CGLayerGetContext}
function CGLayerGetSize(layer: CGLayerRef): CGSize; cdecl; external libCoreGraphics name _PU + 'CGLayerGetSize';
{$EXTERNALSYM CGLayerGetSize}
function CGLayerGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGLayerGetTypeID';
{$EXTERNALSYM CGLayerGetTypeID}
procedure CGLayerRelease(layer: CGLayerRef); cdecl; external libCoreGraphics name _PU + 'CGLayerRelease';
{$EXTERNALSYM CGLayerRelease}
function CGLayerRetain(layer: CGLayerRef): CGLayerRef; cdecl; external libCoreGraphics name _PU + 'CGLayerRetain';
{$EXTERNALSYM CGLayerRetain}
function CGMainDisplayID: CGDirectDisplayID; cdecl; external libCoreGraphics name _PU + 'CGMainDisplayID';
{$EXTERNALSYM CGMainDisplayID}
function CGOpenGLDisplayMaskToDisplayID(mask: CGOpenGLDisplayMask): CGDirectDisplayID; cdecl; external libCoreGraphics name _PU + 'CGOpenGLDisplayMaskToDisplayID';
{$EXTERNALSYM CGOpenGLDisplayMaskToDisplayID}
function CGPDFArrayGetArray(array_: CGPDFArrayRef; index: Longword; value: PCGPDFArrayRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetArray';
{$EXTERNALSYM CGPDFArrayGetArray}
function CGPDFArrayGetBoolean(array_: CGPDFArrayRef; index: Longword; value: PCGPDFBoolean): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetBoolean';
{$EXTERNALSYM CGPDFArrayGetBoolean}
function CGPDFArrayGetCount(array_: CGPDFArrayRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetCount';
{$EXTERNALSYM CGPDFArrayGetCount}
function CGPDFArrayGetDictionary(array_: CGPDFArrayRef; index: Longword; value: PCGPDFDictionaryRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetDictionary';
{$EXTERNALSYM CGPDFArrayGetDictionary}
function CGPDFArrayGetInteger(array_: CGPDFArrayRef; index: Longword; value: PCGPDFInteger): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetInteger';
{$EXTERNALSYM CGPDFArrayGetInteger}
function CGPDFArrayGetName(array_: CGPDFArrayRef; index: Longword; value: Pchar): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetName';
{$EXTERNALSYM CGPDFArrayGetName}
function CGPDFArrayGetNull(array_: CGPDFArrayRef; index: Longword): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetNull';
{$EXTERNALSYM CGPDFArrayGetNull}
function CGPDFArrayGetNumber(array_: CGPDFArrayRef; index: Longword; value: PCGPDFReal): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetNumber';
{$EXTERNALSYM CGPDFArrayGetNumber}
function CGPDFArrayGetObject(array_: CGPDFArrayRef; index: Longword; value: PCGPDFObjectRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetObject';
{$EXTERNALSYM CGPDFArrayGetObject}
function CGPDFArrayGetStream(array_: CGPDFArrayRef; index: Longword; value: PCGPDFStreamRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetStream';
{$EXTERNALSYM CGPDFArrayGetStream}
function CGPDFArrayGetString(array_: CGPDFArrayRef; index: Longword; value: PCGPDFStringRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFArrayGetString';
{$EXTERNALSYM CGPDFArrayGetString}
function CGPDFContentStreamCreateWithPage(page: CGPDFPageRef): CGPDFContentStreamRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamCreateWithPage';
{$EXTERNALSYM CGPDFContentStreamCreateWithPage}
function CGPDFContentStreamCreateWithStream(stream: CGPDFStreamRef; streamResources: CGPDFDictionaryRef; parent: CGPDFContentStreamRef): CGPDFContentStreamRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamCreateWithStream';
{$EXTERNALSYM CGPDFContentStreamCreateWithStream}
function CGPDFContentStreamGetResource(cs: CGPDFContentStreamRef; category: MarshaledAString; name: MarshaledAString): CGPDFObjectRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamGetResource';
{$EXTERNALSYM CGPDFContentStreamGetResource}
function CGPDFContentStreamGetStreams(cs: CGPDFContentStreamRef): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamGetStreams';
{$EXTERNALSYM CGPDFContentStreamGetStreams}
procedure CGPDFContentStreamRelease(cs: CGPDFContentStreamRef); cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamRelease';
{$EXTERNALSYM CGPDFContentStreamRelease}
function CGPDFContentStreamRetain(cs: CGPDFContentStreamRef): CGPDFContentStreamRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContentStreamRetain';
{$EXTERNALSYM CGPDFContentStreamRetain}
procedure CGPDFContextAddDestinationAtPoint(context: CGContextRef; name: CFStringRef; point: CGPoint); cdecl; external libCoreGraphics name _PU + 'CGPDFContextAddDestinationAtPoint';
{$EXTERNALSYM CGPDFContextAddDestinationAtPoint}
procedure CGPDFContextBeginPage(context: CGContextRef; pageInfo: CFDictionaryRef); cdecl; external libCoreGraphics name _PU + 'CGPDFContextBeginPage';
{$EXTERNALSYM CGPDFContextBeginPage}
procedure CGPDFContextClose(context: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGPDFContextClose';
{$EXTERNALSYM CGPDFContextClose}
function CGPDFContextCreate(consumer: CGDataConsumerRef; mediaBox: PCGRect; auxiliaryInfo: CFDictionaryRef): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContextCreate';
{$EXTERNALSYM CGPDFContextCreate}
function CGPDFContextCreateWithURL(url: CFURLRef; mediaBox: PCGRect; auxiliaryInfo: CFDictionaryRef): CGContextRef; cdecl; external libCoreGraphics name _PU + 'CGPDFContextCreateWithURL';
{$EXTERNALSYM CGPDFContextCreateWithURL}
procedure CGPDFContextEndPage(context: CGContextRef); cdecl; external libCoreGraphics name _PU + 'CGPDFContextEndPage';
{$EXTERNALSYM CGPDFContextEndPage}
procedure CGPDFContextSetDestinationForRect(context: CGContextRef; name: CFStringRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGPDFContextSetDestinationForRect';
{$EXTERNALSYM CGPDFContextSetDestinationForRect}
procedure CGPDFContextSetURLForRect(context: CGContextRef; url: CFURLRef; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGPDFContextSetURLForRect';
{$EXTERNALSYM CGPDFContextSetURLForRect}
procedure CGPDFDictionaryApplyFunction(dict: CGPDFDictionaryRef; function_: CGPDFDictionaryApplierFunction; info: Pointer); cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryApplyFunction';
{$EXTERNALSYM CGPDFDictionaryApplyFunction}
function CGPDFDictionaryGetArray(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFArrayRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetArray';
{$EXTERNALSYM CGPDFDictionaryGetArray}
function CGPDFDictionaryGetBoolean(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFBoolean): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetBoolean';
{$EXTERNALSYM CGPDFDictionaryGetBoolean}
function CGPDFDictionaryGetCount(dict: CGPDFDictionaryRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetCount';
{$EXTERNALSYM CGPDFDictionaryGetCount}
function CGPDFDictionaryGetDictionary(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFDictionaryRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetDictionary';
{$EXTERNALSYM CGPDFDictionaryGetDictionary}
function CGPDFDictionaryGetInteger(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFInteger): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetInteger';
{$EXTERNALSYM CGPDFDictionaryGetInteger}
function CGPDFDictionaryGetName(dict: CGPDFDictionaryRef; key: MarshaledAString; value: Pchar): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetName';
{$EXTERNALSYM CGPDFDictionaryGetName}
function CGPDFDictionaryGetNumber(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFReal): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetNumber';
{$EXTERNALSYM CGPDFDictionaryGetNumber}
function CGPDFDictionaryGetObject(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFObjectRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetObject';
{$EXTERNALSYM CGPDFDictionaryGetObject}
function CGPDFDictionaryGetStream(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFStreamRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetStream';
{$EXTERNALSYM CGPDFDictionaryGetStream}
function CGPDFDictionaryGetString(dict: CGPDFDictionaryRef; key: MarshaledAString; value: PCGPDFStringRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDictionaryGetString';
{$EXTERNALSYM CGPDFDictionaryGetString}
function CGPDFDocumentAllowsCopying(document: CGPDFDocumentRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentAllowsCopying';
{$EXTERNALSYM CGPDFDocumentAllowsCopying}
function CGPDFDocumentAllowsPrinting(document: CGPDFDocumentRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentAllowsPrinting';
{$EXTERNALSYM CGPDFDocumentAllowsPrinting}
function CGPDFDocumentCreateWithProvider(provider: CGDataProviderRef): CGPDFDocumentRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentCreateWithProvider';
{$EXTERNALSYM CGPDFDocumentCreateWithProvider}
function CGPDFDocumentCreateWithURL(url: CFURLRef): CGPDFDocumentRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentCreateWithURL';
{$EXTERNALSYM CGPDFDocumentCreateWithURL}
function CGPDFDocumentGetArtBox(document: CGPDFDocumentRef; page: Integer): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetArtBox';
{$EXTERNALSYM CGPDFDocumentGetArtBox}
function CGPDFDocumentGetBleedBox(document: CGPDFDocumentRef; page: Integer): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetBleedBox';
{$EXTERNALSYM CGPDFDocumentGetBleedBox}
function CGPDFDocumentGetCatalog(document: CGPDFDocumentRef): CGPDFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetCatalog';
{$EXTERNALSYM CGPDFDocumentGetCatalog}
function CGPDFDocumentGetCropBox(document: CGPDFDocumentRef; page: Integer): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetCropBox';
{$EXTERNALSYM CGPDFDocumentGetCropBox}
function CGPDFDocumentGetID(document: CGPDFDocumentRef): CGPDFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetID';
{$EXTERNALSYM CGPDFDocumentGetID}
function CGPDFDocumentGetInfo(document: CGPDFDocumentRef): CGPDFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetInfo';
{$EXTERNALSYM CGPDFDocumentGetInfo}
function CGPDFDocumentGetMediaBox(document: CGPDFDocumentRef; page: Integer): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetMediaBox';
{$EXTERNALSYM CGPDFDocumentGetMediaBox}
function CGPDFDocumentGetNumberOfPages(document: CGPDFDocumentRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetNumberOfPages';
{$EXTERNALSYM CGPDFDocumentGetNumberOfPages}
function CGPDFDocumentGetPage(document: CGPDFDocumentRef; pageNumber: Longword): CGPDFPageRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetPage';
{$EXTERNALSYM CGPDFDocumentGetPage}
function CGPDFDocumentGetRotationAngle(document: CGPDFDocumentRef; page: Integer): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetRotationAngle';
{$EXTERNALSYM CGPDFDocumentGetRotationAngle}
function CGPDFDocumentGetTrimBox(document: CGPDFDocumentRef; page: Integer): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetTrimBox';
{$EXTERNALSYM CGPDFDocumentGetTrimBox}
function CGPDFDocumentGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetTypeID';
{$EXTERNALSYM CGPDFDocumentGetTypeID}
procedure CGPDFDocumentGetVersion(document: CGPDFDocumentRef; majorVersion: PInteger; minorVersion: PInteger); cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentGetVersion';
{$EXTERNALSYM CGPDFDocumentGetVersion}
function CGPDFDocumentIsEncrypted(document: CGPDFDocumentRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentIsEncrypted';
{$EXTERNALSYM CGPDFDocumentIsEncrypted}
function CGPDFDocumentIsUnlocked(document: CGPDFDocumentRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentIsUnlocked';
{$EXTERNALSYM CGPDFDocumentIsUnlocked}
procedure CGPDFDocumentRelease(document: CGPDFDocumentRef); cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentRelease';
{$EXTERNALSYM CGPDFDocumentRelease}
function CGPDFDocumentRetain(document: CGPDFDocumentRef): CGPDFDocumentRef; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentRetain';
{$EXTERNALSYM CGPDFDocumentRetain}
function CGPDFDocumentUnlockWithPassword(document: CGPDFDocumentRef; password: MarshaledAString): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFDocumentUnlockWithPassword';
{$EXTERNALSYM CGPDFDocumentUnlockWithPassword}
function CGPDFObjectGetType(object_: CGPDFObjectRef): CGPDFObjectType; cdecl; external libCoreGraphics name _PU + 'CGPDFObjectGetType';
{$EXTERNALSYM CGPDFObjectGetType}
function CGPDFObjectGetValue(object_: CGPDFObjectRef; type_: CGPDFObjectType; value: Pointer): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFObjectGetValue';
{$EXTERNALSYM CGPDFObjectGetValue}
function CGPDFOperatorTableCreate: CGPDFOperatorTableRef; cdecl; external libCoreGraphics name _PU + 'CGPDFOperatorTableCreate';
{$EXTERNALSYM CGPDFOperatorTableCreate}
procedure CGPDFOperatorTableRelease(table: CGPDFOperatorTableRef); cdecl; external libCoreGraphics name _PU + 'CGPDFOperatorTableRelease';
{$EXTERNALSYM CGPDFOperatorTableRelease}
function CGPDFOperatorTableRetain(table: CGPDFOperatorTableRef): CGPDFOperatorTableRef; cdecl; external libCoreGraphics name _PU + 'CGPDFOperatorTableRetain';
{$EXTERNALSYM CGPDFOperatorTableRetain}
procedure CGPDFOperatorTableSetCallback(table: CGPDFOperatorTableRef; name: MarshaledAString; callback: CGPDFOperatorCallback); cdecl; external libCoreGraphics name _PU + 'CGPDFOperatorTableSetCallback';
{$EXTERNALSYM CGPDFOperatorTableSetCallback}
function CGPDFPageGetBoxRect(page: CGPDFPageRef; box: CGPDFBox): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetBoxRect';
{$EXTERNALSYM CGPDFPageGetBoxRect}
function CGPDFPageGetDictionary(page: CGPDFPageRef): CGPDFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetDictionary';
{$EXTERNALSYM CGPDFPageGetDictionary}
function CGPDFPageGetDocument(page: CGPDFPageRef): CGPDFDocumentRef; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetDocument';
{$EXTERNALSYM CGPDFPageGetDocument}
function CGPDFPageGetDrawingTransform(page: CGPDFPageRef; box: CGPDFBox; rect: CGRect; rotate: Integer; preserveAspectRatio: Integer): CGAffineTransform; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetDrawingTransform';
{$EXTERNALSYM CGPDFPageGetDrawingTransform}
function CGPDFPageGetPageNumber(page: CGPDFPageRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetPageNumber';
{$EXTERNALSYM CGPDFPageGetPageNumber}
function CGPDFPageGetRotationAngle(page: CGPDFPageRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetRotationAngle';
{$EXTERNALSYM CGPDFPageGetRotationAngle}
function CGPDFPageGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGPDFPageGetTypeID';
{$EXTERNALSYM CGPDFPageGetTypeID}
procedure CGPDFPageRelease(page: CGPDFPageRef); cdecl; external libCoreGraphics name _PU + 'CGPDFPageRelease';
{$EXTERNALSYM CGPDFPageRelease}
function CGPDFPageRetain(page: CGPDFPageRef): CGPDFPageRef; cdecl; external libCoreGraphics name _PU + 'CGPDFPageRetain';
{$EXTERNALSYM CGPDFPageRetain}
function CGPDFScannerCreate(cs: CGPDFContentStreamRef; table: CGPDFOperatorTableRef; info: Pointer): CGPDFScannerRef; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerCreate';
{$EXTERNALSYM CGPDFScannerCreate}
function CGPDFScannerGetContentStream(scanner: CGPDFScannerRef): CGPDFContentStreamRef; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerGetContentStream';
{$EXTERNALSYM CGPDFScannerGetContentStream}
function CGPDFScannerPopArray(scanner: CGPDFScannerRef; value: PCGPDFArrayRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopArray';
{$EXTERNALSYM CGPDFScannerPopArray}
function CGPDFScannerPopBoolean(scanner: CGPDFScannerRef; value: PCGPDFBoolean): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopBoolean';
{$EXTERNALSYM CGPDFScannerPopBoolean}
function CGPDFScannerPopDictionary(scanner: CGPDFScannerRef; value: PCGPDFDictionaryRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopDictionary';
{$EXTERNALSYM CGPDFScannerPopDictionary}
function CGPDFScannerPopInteger(scanner: CGPDFScannerRef; value: PCGPDFInteger): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopInteger';
{$EXTERNALSYM CGPDFScannerPopInteger}
function CGPDFScannerPopName(scanner: CGPDFScannerRef; value: Pchar): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopName';
{$EXTERNALSYM CGPDFScannerPopName}
function CGPDFScannerPopNumber(scanner: CGPDFScannerRef; value: PCGPDFReal): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopNumber';
{$EXTERNALSYM CGPDFScannerPopNumber}
function CGPDFScannerPopObject(scanner: CGPDFScannerRef; value: PCGPDFObjectRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopObject';
{$EXTERNALSYM CGPDFScannerPopObject}
function CGPDFScannerPopStream(scanner: CGPDFScannerRef; value: PCGPDFStreamRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopStream';
{$EXTERNALSYM CGPDFScannerPopStream}
function CGPDFScannerPopString(scanner: CGPDFScannerRef; value: PCGPDFStringRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerPopString';
{$EXTERNALSYM CGPDFScannerPopString}
procedure CGPDFScannerRelease(scanner: CGPDFScannerRef); cdecl; external libCoreGraphics name _PU + 'CGPDFScannerRelease';
{$EXTERNALSYM CGPDFScannerRelease}
function CGPDFScannerRetain(scanner: CGPDFScannerRef): CGPDFScannerRef; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerRetain';
{$EXTERNALSYM CGPDFScannerRetain}
function CGPDFScannerScan(scanner: CGPDFScannerRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPDFScannerScan';
{$EXTERNALSYM CGPDFScannerScan}
function CGPDFStreamCopyData(stream: CGPDFStreamRef; format: PCGPDFDataFormat): CFDataRef; cdecl; external libCoreGraphics name _PU + 'CGPDFStreamCopyData';
{$EXTERNALSYM CGPDFStreamCopyData}
function CGPDFStreamGetDictionary(stream: CGPDFStreamRef): CGPDFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGPDFStreamGetDictionary';
{$EXTERNALSYM CGPDFStreamGetDictionary}
function CGPDFStringCopyDate(string_: CGPDFStringRef): CFDateRef; cdecl; external libCoreGraphics name _PU + 'CGPDFStringCopyDate';
{$EXTERNALSYM CGPDFStringCopyDate}
function CGPDFStringCopyTextString(string_: CGPDFStringRef): CFStringRef; cdecl; external libCoreGraphics name _PU + 'CGPDFStringCopyTextString';
{$EXTERNALSYM CGPDFStringCopyTextString}
function CGPDFStringGetBytePtr(string_: CGPDFStringRef): PByte; cdecl; external libCoreGraphics name _PU + 'CGPDFStringGetBytePtr';
{$EXTERNALSYM CGPDFStringGetBytePtr}
function CGPDFStringGetLength(string_: CGPDFStringRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPDFStringGetLength';
{$EXTERNALSYM CGPDFStringGetLength}
function CGPSConverterAbort(converter: CGPSConverterRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPSConverterAbort';
{$EXTERNALSYM CGPSConverterAbort}
function CGPSConverterConvert(converter: CGPSConverterRef; provider: CGDataProviderRef; consumer: CGDataConsumerRef; options: CFDictionaryRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPSConverterConvert';
{$EXTERNALSYM CGPSConverterConvert}
//function CGPSConverterCreate(info: Pointer; callbacks: PCGPSConverterCallbacks; options: CFDictionaryRef): CGPSConverterRef; cdecl; external libCoreGraphics name _PU + 'CGPSConverterCreate';
function CGPSConverterGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGPSConverterGetTypeID';
{$EXTERNALSYM CGPSConverterGetTypeID}
function CGPSConverterIsConverting(converter: CGPSConverterRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPSConverterIsConverting';
{$EXTERNALSYM CGPSConverterIsConverting}
function CGPaletteCreateCopy(palette: CGDirectPaletteRef): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateCopy';
{$EXTERNALSYM CGPaletteCreateCopy}
function CGPaletteCreateDefaultColorPalette: CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateDefaultColorPalette';
{$EXTERNALSYM CGPaletteCreateDefaultColorPalette}
function CGPaletteCreateFromPaletteBlendedWithColor(palette: CGDirectPaletteRef; fraction: CGPaletteBlendFraction; color: CGDeviceColor): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateFromPaletteBlendedWithColor';
{$EXTERNALSYM CGPaletteCreateFromPaletteBlendedWithColor}
function CGPaletteCreateWithByteSamples(samples: PCGDeviceByteColor; count: Longword): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateWithByteSamples';
{$EXTERNALSYM CGPaletteCreateWithByteSamples}
function CGPaletteCreateWithCapacity(capacity: Longword): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateWithCapacity';
{$EXTERNALSYM CGPaletteCreateWithCapacity}
function CGPaletteCreateWithDisplay(display: CGDirectDisplayID): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateWithDisplay';
{$EXTERNALSYM CGPaletteCreateWithDisplay}
function CGPaletteCreateWithSamples(samples: PCGDeviceColor; count: Longword): CGDirectPaletteRef; cdecl; external libCoreGraphics name _PU + 'CGPaletteCreateWithSamples';
{$EXTERNALSYM CGPaletteCreateWithSamples}
function CGPaletteGetColorAtIndex(palette: CGDirectPaletteRef; index: Longword): CGDeviceColor; cdecl; external libCoreGraphics name _PU + 'CGPaletteGetColorAtIndex';
{$EXTERNALSYM CGPaletteGetColorAtIndex}
function CGPaletteGetIndexForColor(palette: CGDirectPaletteRef; color: CGDeviceColor): Longword; cdecl; external libCoreGraphics name _PU + 'CGPaletteGetIndexForColor';
{$EXTERNALSYM CGPaletteGetIndexForColor}
function CGPaletteGetNumberOfSamples(palette: CGDirectPaletteRef): Longword; cdecl; external libCoreGraphics name _PU + 'CGPaletteGetNumberOfSamples';
{$EXTERNALSYM CGPaletteGetNumberOfSamples}
function CGPaletteIsEqualToPalette(palette1: CGDirectPaletteRef; palette2: CGDirectPaletteRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPaletteIsEqualToPalette';
{$EXTERNALSYM CGPaletteIsEqualToPalette}
procedure CGPaletteRelease(palette: CGDirectPaletteRef); cdecl; external libCoreGraphics name _PU + 'CGPaletteRelease';
{$EXTERNALSYM CGPaletteRelease}
procedure CGPaletteSetColorAtIndex(palette: CGDirectPaletteRef; color: CGDeviceColor; index: Longword); cdecl; external libCoreGraphics name _PU + 'CGPaletteSetColorAtIndex';
{$EXTERNALSYM CGPaletteSetColorAtIndex}
procedure CGPathAddArc(path: CGMutablePathRef; m: PCGAffineTransform; x: Single; y: Single; radius: Single; startAngle: Single; endAngle: Single; clockwise: Integer); cdecl; external libCoreGraphics name _PU + 'CGPathAddArc';
{$EXTERNALSYM CGPathAddArc}
procedure CGPathAddArcToPoint(path: CGMutablePathRef; m: PCGAffineTransform; x1: Single; y1: Single; x2: Single; y2: Single; radius: Single); cdecl; external libCoreGraphics name _PU + 'CGPathAddArcToPoint';
{$EXTERNALSYM CGPathAddArcToPoint}
procedure CGPathAddCurveToPoint(path: CGMutablePathRef; m: PCGAffineTransform; cp1x: Single; cp1y: Single; cp2x: Single; cp2y: Single; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGPathAddCurveToPoint';
{$EXTERNALSYM CGPathAddCurveToPoint}
procedure CGPathAddEllipseInRect(path: CGMutablePathRef; m: PCGAffineTransform; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGPathAddEllipseInRect';
{$EXTERNALSYM CGPathAddEllipseInRect}
procedure CGPathAddLineToPoint(path: CGMutablePathRef; m: PCGAffineTransform; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGPathAddLineToPoint';
{$EXTERNALSYM CGPathAddLineToPoint}
procedure CGPathAddLines(path: CGMutablePathRef; m: PCGAffineTransform; points: PCGPoint; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGPathAddLines';
{$EXTERNALSYM CGPathAddLines}
procedure CGPathAddPath(path1: CGMutablePathRef; m: PCGAffineTransform; path2: CGPathRef); cdecl; external libCoreGraphics name _PU + 'CGPathAddPath';
{$EXTERNALSYM CGPathAddPath}
procedure CGPathAddQuadCurveToPoint(path: CGMutablePathRef; m: PCGAffineTransform; cpx: Single; cpy: Single; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGPathAddQuadCurveToPoint';
{$EXTERNALSYM CGPathAddQuadCurveToPoint}
procedure CGPathAddRect(path: CGMutablePathRef; m: PCGAffineTransform; rect: CGRect); cdecl; external libCoreGraphics name _PU + 'CGPathAddRect';
{$EXTERNALSYM CGPathAddRect}
procedure CGPathAddRects(path: CGMutablePathRef; m: PCGAffineTransform; rects: PCGRect; count: Longword); cdecl; external libCoreGraphics name _PU + 'CGPathAddRects';
{$EXTERNALSYM CGPathAddRects}
procedure CGPathApply(path: CGPathRef; info: Pointer; function_: CGPathApplierFunction); cdecl; external libCoreGraphics name _PU + 'CGPathApply';
{$EXTERNALSYM CGPathApply}
procedure CGPathCloseSubpath(path: CGMutablePathRef); cdecl; external libCoreGraphics name _PU + 'CGPathCloseSubpath';
{$EXTERNALSYM CGPathCloseSubpath}
function CGPathContainsPoint(path: CGPathRef; m: PCGAffineTransform; point: CGPoint; eoFill: Integer): Integer; cdecl; external libCoreGraphics name _PU + 'CGPathContainsPoint';
{$EXTERNALSYM CGPathContainsPoint}
function CGPathCreateCopy(path: CGPathRef): CGPathRef; cdecl; external libCoreGraphics name _PU + 'CGPathCreateCopy';
{$EXTERNALSYM CGPathCreateCopy}
function CGPathCreateMutable: CGMutablePathRef; cdecl; external libCoreGraphics name _PU + 'CGPathCreateMutable';
{$EXTERNALSYM CGPathCreateMutable}
function CGPathCreateMutableCopy(path: CGPathRef): CGMutablePathRef; cdecl; external libCoreGraphics name _PU + 'CGPathCreateMutableCopy';
{$EXTERNALSYM CGPathCreateMutableCopy}
function CGPathEqualToPath(path1: CGPathRef; path2: CGPathRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPathEqualToPath';
{$EXTERNALSYM CGPathEqualToPath}
function CGPathGetBoundingBox(path: CGPathRef): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPathGetBoundingBox';
{$EXTERNALSYM CGPathGetBoundingBox}
function CGPathGetCurrentPoint(path: CGPathRef): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGPathGetCurrentPoint';
{$EXTERNALSYM CGPathGetCurrentPoint}
function CGPathGetPathBoundingBox(path: CGPathRef): CGRect; cdecl; external libCoreGraphics name _PU + 'CGPathGetPathBoundingBox';
{$EXTERNALSYM CGPathGetPathBoundingBox}
function CGPathGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGPathGetTypeID';
{$EXTERNALSYM CGPathGetTypeID}
function CGPathIsEmpty(path: CGPathRef): Integer; cdecl; external libCoreGraphics name _PU + 'CGPathIsEmpty';
{$EXTERNALSYM CGPathIsEmpty}
function CGPathIsRect(path: CGPathRef; rect: PCGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGPathIsRect';
{$EXTERNALSYM CGPathIsRect}
procedure CGPathMoveToPoint(path: CGMutablePathRef; m: PCGAffineTransform; x: Single; y: Single); cdecl; external libCoreGraphics name _PU + 'CGPathMoveToPoint';
{$EXTERNALSYM CGPathMoveToPoint}
procedure CGPathRelease(path: CGPathRef); cdecl; external libCoreGraphics name _PU + 'CGPathRelease';
{$EXTERNALSYM CGPathRelease}
function CGPathRetain(path: CGPathRef): CGPathRef; cdecl; external libCoreGraphics name _PU + 'CGPathRetain';
{$EXTERNALSYM CGPathRetain}
function CGPatternCreate(info: Pointer; bounds: CGRect; matrix: CGAffineTransform; xStep: Single; yStep: Single; tiling: CGPatternTiling; isColored: Integer; callbacks: PCGPatternCallbacks): CGPatternRef; cdecl; external libCoreGraphics name _PU + 'CGPatternCreate';
{$EXTERNALSYM CGPatternCreate}
function CGPatternGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGPatternGetTypeID';
{$EXTERNALSYM CGPatternGetTypeID}
procedure CGPatternRelease(pattern: CGPatternRef); cdecl; external libCoreGraphics name _PU + 'CGPatternRelease';
{$EXTERNALSYM CGPatternRelease}
function CGPatternRetain(pattern: CGPatternRef): CGPatternRef; cdecl; external libCoreGraphics name _PU + 'CGPatternRetain';
{$EXTERNALSYM CGPatternRetain}
function CGPointApplyAffineTransform(point: CGPoint; t: CGAffineTransform): CGPoint; cdecl; external libCoreGraphics name _PU + 'CGPointApplyAffineTransform';
{$EXTERNALSYM CGPointApplyAffineTransform}
function CGPointCreateDictionaryRepresentation(point: CGPoint): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGPointCreateDictionaryRepresentation';
{$EXTERNALSYM CGPointCreateDictionaryRepresentation}
function CGPointEqualToPoint(point1: CGPoint; point2: CGPoint): Integer; cdecl; external libCoreGraphics name _PU + 'CGPointEqualToPoint';
{$EXTERNALSYM CGPointEqualToPoint}
function CGPointMakeWithDictionaryRepresentation(dict: CFDictionaryRef; point: PCGPoint): Integer; cdecl; external libCoreGraphics name _PU + 'CGPointMakeWithDictionaryRepresentation';
{$EXTERNALSYM CGPointMakeWithDictionaryRepresentation}
function CGPostKeyboardEvent(keyChar: CGCharCode; virtualKey: CGKeyCode; keyDown: Integer): CGError; cdecl; external libCoreGraphics name _PU + 'CGPostKeyboardEvent';
{$EXTERNALSYM CGPostKeyboardEvent}
function CGPostMouseEvent(mouseCursorPosition: CGPoint; updateMouseCursorPosition: Integer; buttonCount: CGButtonCount; mouseButtonDown: Integer): CGError; cdecl; varargs; external libCoreGraphics name _PU + 'CGPostMouseEvent';
{$EXTERNALSYM CGPostMouseEvent}
function CGPostScrollWheelEvent(wheelCount: CGWheelCount; wheel1: Integer): CGError; cdecl; varargs; external libCoreGraphics name _PU + 'CGPostScrollWheelEvent';
{$EXTERNALSYM CGPostScrollWheelEvent}
function CGRectApplyAffineTransform(rect: CGRect; t: CGAffineTransform): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectApplyAffineTransform';
{$EXTERNALSYM CGRectApplyAffineTransform}
function CGRectContainsPoint(rect: CGRect; point: CGPoint): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectContainsPoint';
{$EXTERNALSYM CGRectContainsPoint}
function CGRectContainsRect(rect1: CGRect; rect2: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectContainsRect';
{$EXTERNALSYM CGRectContainsRect}
function CGRectCreateDictionaryRepresentation(dummy: CGRect): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGRectCreateDictionaryRepresentation';
{$EXTERNALSYM CGRectCreateDictionaryRepresentation}
procedure CGRectDivide(rect: CGRect; slice: PCGRect; remainder: PCGRect; amount: Single; edge: CGRectEdge); cdecl; external libCoreGraphics name _PU + 'CGRectDivide';
{$EXTERNALSYM CGRectDivide}
function CGRectEqualToRect(rect1: CGRect; rect2: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectEqualToRect';
{$EXTERNALSYM CGRectEqualToRect}
function CGRectGetHeight(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetHeight';
{$EXTERNALSYM CGRectGetHeight}
function CGRectGetMaxX(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMaxX';
{$EXTERNALSYM CGRectGetMaxX}
function CGRectGetMaxY(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMaxY';
{$EXTERNALSYM CGRectGetMaxY}
function CGRectGetMidX(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMidX';
{$EXTERNALSYM CGRectGetMidX}
function CGRectGetMidY(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMidY';
{$EXTERNALSYM CGRectGetMidY}
function CGRectGetMinX(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMinX';
{$EXTERNALSYM CGRectGetMinX}
function CGRectGetMinY(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetMinY';
{$EXTERNALSYM CGRectGetMinY}
function CGRectGetWidth(rect: CGRect): Single; cdecl; external libCoreGraphics name _PU + 'CGRectGetWidth';
{$EXTERNALSYM CGRectGetWidth}
function CGRectInset(rect: CGRect; dx: Single; dy: Single): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectInset';
{$EXTERNALSYM CGRectInset}
function CGRectIntegral(rect: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectIntegral';
{$EXTERNALSYM CGRectIntegral}
function CGRectIntersection(r1: CGRect; r2: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectIntersection';
{$EXTERNALSYM CGRectIntersection}
function CGRectIntersectsRect(rect1: CGRect; rect2: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectIntersectsRect';
{$EXTERNALSYM CGRectIntersectsRect}
function CGRectIsEmpty(rect: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectIsEmpty';
{$EXTERNALSYM CGRectIsEmpty}
function CGRectIsInfinite(rect: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectIsInfinite';
{$EXTERNALSYM CGRectIsInfinite}
function CGRectIsNull(rect: CGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectIsNull';
{$EXTERNALSYM CGRectIsNull}
function CGRectMakeWithDictionaryRepresentation(dict: CFDictionaryRef; rect: PCGRect): Integer; cdecl; external libCoreGraphics name _PU + 'CGRectMakeWithDictionaryRepresentation';
{$EXTERNALSYM CGRectMakeWithDictionaryRepresentation}
function CGRectOffset(rect: CGRect; dx: Single; dy: Single): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectOffset';
{$EXTERNALSYM CGRectOffset}
function CGRectStandardize(rect: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectStandardize';
{$EXTERNALSYM CGRectStandardize}
function CGRectUnion(r1: CGRect; r2: CGRect): CGRect; cdecl; external libCoreGraphics name _PU + 'CGRectUnion';
{$EXTERNALSYM CGRectUnion}
function CGRegisterScreenRefreshCallback(callback: CGScreenRefreshCallback; userInfo: Pointer): CGError; cdecl; external libCoreGraphics name _PU + 'CGRegisterScreenRefreshCallback';
{$EXTERNALSYM CGRegisterScreenRefreshCallback}
function CGReleaseAllDisplays: CGError; cdecl; external libCoreGraphics name _PU + 'CGReleaseAllDisplays';
{$EXTERNALSYM CGReleaseAllDisplays}
function CGReleaseDisplayFadeReservation(token: CGDisplayFadeReservationToken): CGError; cdecl; external libCoreGraphics name _PU + 'CGReleaseDisplayFadeReservation';
{$EXTERNALSYM CGReleaseDisplayFadeReservation}
procedure CGReleaseScreenRefreshRects(rects: PCGRect); cdecl; external libCoreGraphics name _PU + 'CGReleaseScreenRefreshRects';
{$EXTERNALSYM CGReleaseScreenRefreshRects}
procedure CGRestorePermanentDisplayConfiguration; cdecl; external libCoreGraphics name _PU + 'CGRestorePermanentDisplayConfiguration';
{$EXTERNALSYM CGRestorePermanentDisplayConfiguration}
function CGScreenRegisterMoveCallback(callback: CGScreenUpdateMoveCallback; userInfo: Pointer): CGError; cdecl; external libCoreGraphics name _PU + 'CGScreenRegisterMoveCallback';
{$EXTERNALSYM CGScreenRegisterMoveCallback}
procedure CGScreenUnregisterMoveCallback(callback: CGScreenUpdateMoveCallback; userInfo: Pointer); cdecl; external libCoreGraphics name _PU + 'CGScreenUnregisterMoveCallback';
{$EXTERNALSYM CGScreenUnregisterMoveCallback}
function CGSessionCopyCurrentDictionary: CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGSessionCopyCurrentDictionary';
{$EXTERNALSYM CGSessionCopyCurrentDictionary}
function CGSetDisplayTransferByByteTable(display: CGDirectDisplayID; tableSize: Longword; redTable: PByte; greenTable: PByte; blueTable: PByte): CGError; cdecl; external libCoreGraphics name _PU + 'CGSetDisplayTransferByByteTable';
{$EXTERNALSYM CGSetDisplayTransferByByteTable}
function CGSetDisplayTransferByFormula(display: CGDirectDisplayID; redMin: CGGammaValue; redMax: CGGammaValue; redGamma: CGGammaValue; greenMin: CGGammaValue; greenMax: CGGammaValue; greenGamma: CGGammaValue; blueMin: CGGammaValue; blueMax: CGGammaValue; blueGamma: CGGammaValue): CGError; cdecl; external libCoreGraphics name _PU + 'CGSetDisplayTransferByFormula';
{$EXTERNALSYM CGSetDisplayTransferByFormula}
function CGSetDisplayTransferByTable(display: CGDirectDisplayID; tableSize: Longword; redTable: PCGGammaValue; greenTable: PCGGammaValue; blueTable: PCGGammaValue): CGError; cdecl; external libCoreGraphics name _PU + 'CGSetDisplayTransferByTable';
{$EXTERNALSYM CGSetDisplayTransferByTable}
function CGSetLocalEventsFilterDuringSuppressionState(filter: CGEventFilterMask; state: CGEventSuppressionState): CGError; cdecl; external libCoreGraphics name _PU + 'CGSetLocalEventsFilterDuringSuppressionState';
{$EXTERNALSYM CGSetLocalEventsFilterDuringSuppressionState}
function CGSetLocalEventsSuppressionInterval(seconds: CFTimeInterval): CGError; cdecl; external libCoreGraphics name _PU + 'CGSetLocalEventsSuppressionInterval';
{$EXTERNALSYM CGSetLocalEventsSuppressionInterval}
function CGShadingCreateAxial(space: CGColorSpaceRef; start: CGPoint; end_: CGPoint; function_: CGFunctionRef; extendStart: Integer; extendEnd: Integer): CGShadingRef; cdecl; external libCoreGraphics name _PU + 'CGShadingCreateAxial';
{$EXTERNALSYM CGShadingCreateAxial}
function CGShadingCreateRadial(space: CGColorSpaceRef; start: CGPoint; startRadius: Single; end_: CGPoint; endRadius: Single; function_: CGFunctionRef; extendStart: Integer; extendEnd: Integer): CGShadingRef; cdecl; external libCoreGraphics name _PU + 'CGShadingCreateRadial';
{$EXTERNALSYM CGShadingCreateRadial}
function CGShadingGetTypeID: CFTypeID; cdecl; external libCoreGraphics name _PU + 'CGShadingGetTypeID';
{$EXTERNALSYM CGShadingGetTypeID}
procedure CGShadingRelease(shading: CGShadingRef); cdecl; external libCoreGraphics name _PU + 'CGShadingRelease';
{$EXTERNALSYM CGShadingRelease}
function CGShadingRetain(shading: CGShadingRef): CGShadingRef; cdecl; external libCoreGraphics name _PU + 'CGShadingRetain';
{$EXTERNALSYM CGShadingRetain}
function CGShieldingWindowID(display: CGDirectDisplayID): Longword; cdecl; external libCoreGraphics name _PU + 'CGShieldingWindowID';
{$EXTERNALSYM CGShieldingWindowID}
function CGShieldingWindowLevel: Integer; cdecl; external libCoreGraphics name _PU + 'CGShieldingWindowLevel';
{$EXTERNALSYM CGShieldingWindowLevel}
function CGSizeApplyAffineTransform(size: CGSize; t: CGAffineTransform): CGSize; cdecl; external libCoreGraphics name _PU + 'CGSizeApplyAffineTransform';
{$EXTERNALSYM CGSizeApplyAffineTransform}
function CGSizeCreateDictionaryRepresentation(size: CGSize): CFDictionaryRef; cdecl; external libCoreGraphics name _PU + 'CGSizeCreateDictionaryRepresentation';
{$EXTERNALSYM CGSizeCreateDictionaryRepresentation}
function CGSizeEqualToSize(size1: CGSize; size2: CGSize): Integer; cdecl; external libCoreGraphics name _PU + 'CGSizeEqualToSize';
{$EXTERNALSYM CGSizeEqualToSize}
function CGSizeMakeWithDictionaryRepresentation(dict: CFDictionaryRef; size: PCGSize): Integer; cdecl; external libCoreGraphics name _PU + 'CGSizeMakeWithDictionaryRepresentation';
{$EXTERNALSYM CGSizeMakeWithDictionaryRepresentation}
procedure CGUnregisterScreenRefreshCallback(callback: CGScreenRefreshCallback; userInfo: Pointer); cdecl; external libCoreGraphics name _PU + 'CGUnregisterScreenRefreshCallback';
{$EXTERNALSYM CGUnregisterScreenRefreshCallback}
function CGWaitForScreenRefreshRects(rects: PCGRect; count: PLongword): CGError; cdecl; external libCoreGraphics name _PU + 'CGWaitForScreenRefreshRects';
{$EXTERNALSYM CGWaitForScreenRefreshRects}
function CGWaitForScreenUpdateRects(requestedOperations: CGScreenUpdateOperation; currentOperation: PCGScreenUpdateOperation; rects: PCGRect; rectCount: PLongword; delta: PCGScreenUpdateMoveDelta): CGError; cdecl; external libCoreGraphics name _PU + 'CGWaitForScreenUpdateRects';
{$EXTERNALSYM CGWaitForScreenUpdateRects}
function CGWarpMouseCursorPosition(newCursorPosition: CGPoint): CGError; cdecl; external libCoreGraphics name _PU + 'CGWarpMouseCursorPosition';
{$EXTERNALSYM CGWarpMouseCursorPosition}
function CGWindowLevelForKey(key: CGWindowLevelKey): CGWindowLevel; cdecl; external libCoreGraphics name _PU + 'CGWindowLevelForKey';
{$EXTERNALSYM CGWindowLevelForKey}
function CGWindowListCopyWindowInfo(option: CGWindowListOption; relativeToWindow: CGWindowID): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGWindowListCopyWindowInfo';
{$EXTERNALSYM CGWindowListCopyWindowInfo}
function CGWindowListCreate(option: CGWindowListOption; relativeToWindow: CGWindowID): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGWindowListCreate';
{$EXTERNALSYM CGWindowListCreate}
function CGWindowListCreateDescriptionFromArray(windowArray: CFArrayRef): CFArrayRef; cdecl; external libCoreGraphics name _PU + 'CGWindowListCreateDescriptionFromArray';
{$EXTERNALSYM CGWindowListCreateDescriptionFromArray}
function CGWindowListCreateImage(screenBounds: CGRect; listOption: CGWindowListOption; windowID: CGWindowID; imageOption: CGWindowImageOption): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGWindowListCreateImage';
{$EXTERNALSYM CGWindowListCreateImage}
function CGWindowListCreateImageFromArray(screenBounds: CGRect; windowArray: CFArrayRef; imageOption: CGWindowImageOption): CGImageRef; cdecl; external libCoreGraphics name _PU + 'CGWindowListCreateImageFromArray';
{$EXTERNALSYM CGWindowListCreateImageFromArray}
function CGWindowServerCFMachPort: CFMachPortRef; cdecl; external libCoreGraphics name _PU + 'CGWindowServerCFMachPort';
{$EXTERNALSYM CGWindowServerCFMachPort}

// ===== Utility functions =====

function CGPointMake(x: Single; y: Single): CGPoint;
function CGSizeMake(width: Single; height: Single): CGSize;
function CGRectMake(x: Single; y: Single; width: Single; height: Single): CGRect;

implementation

function CGPointMake(x: Single; y: Single): CGPoint;
begin
  Result.x := x;
  Result.y := y;
end;

function CGSizeMake(width: Single; height: Single): CGSize;
begin
  Result.width := width;
  Result.height := height;
end;

function CGRectMake(x: Single; y: Single; width: Single; height: Single): CGRect;
begin
  Result.origin.x := x;
  Result.origin.y := y;
  Result.size.width := width;
  Result.size.height := height;
end;

end.
