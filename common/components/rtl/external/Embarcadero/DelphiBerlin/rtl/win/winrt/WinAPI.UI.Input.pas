{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Input;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.Devices,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}



type
  // Forward declare interfaces
  // Windows.UI.Input.IPointerPointProperties
  IPointerPointProperties = interface;
  PIPointerPointProperties = ^IPointerPointProperties;

  // Windows.UI.Input.IPointerPoint
  IPointerPoint = interface;
  PIPointerPoint = ^IPointerPoint;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.IPointerPoint>
  IIterator_1__IPointerPoint = interface;
  PIIterator_1__IPointerPoint = ^IIterator_1__IPointerPoint;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.IPointerPoint>
  IIterable_1__IPointerPoint = interface;
  PIIterable_1__IPointerPoint = ^IIterable_1__IPointerPoint;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.IPointerPoint>
  IVectorView_1__IPointerPoint = interface;
  PIVectorView_1__IPointerPoint = ^IVectorView_1__IPointerPoint;

  // Windows.Foundation.Collections.IVector`1<Windows.UI.Input.IPointerPoint>
  IVector_1__IPointerPoint = interface;
  PIVector_1__IPointerPoint = ^IVector_1__IPointerPoint;

  // Windows.UI.Input.IPointerPointTransform
  IPointerPointTransform = interface;
  PIPointerPointTransform = ^IPointerPointTransform;


  // Emit Forwarded interfaces
  // Windows.UI.Input Interfaces
  // Windows.UI.Input.IPointerPointProperties
  IPointerPointProperties = interface(IInspectable)
  ['{C79D8A4B-C163-4EE7-803F-67CE79F9972D}']
    function get_Pressure: Single; safecall;
    function get_IsInverted: Boolean; safecall;
    function get_IsEraser: Boolean; safecall;
    function get_Orientation: Single; safecall;
    function get_XTilt: Single; safecall;
    function get_YTilt: Single; safecall;
    function get_Twist: Single; safecall;
    function get_ContactRect: TRectF; safecall;
    function get_ContactRectRaw: TRectF; safecall;
    function get_TouchConfidence: Boolean; safecall;
    function get_IsLeftButtonPressed: Boolean; safecall;
    function get_IsRightButtonPressed: Boolean; safecall;
    function get_IsMiddleButtonPressed: Boolean; safecall;
    function get_MouseWheelDelta: Integer; safecall;
    function get_IsHorizontalMouseWheel: Boolean; safecall;
    function get_IsPrimary: Boolean; safecall;
    function get_IsInRange: Boolean; safecall;
    function get_IsCanceled: Boolean; safecall;
    function get_IsBarrelButtonPressed: Boolean; safecall;
    function get_IsXButton1Pressed: Boolean; safecall;
    function get_IsXButton2Pressed: Boolean; safecall;
    function get_PointerUpdateKind: PointerUpdateKind; safecall;
    function HasUsage(usagePage: Cardinal; usageId: Cardinal): Boolean; safecall;
    function GetUsageValue(usagePage: Cardinal; usageId: Cardinal): Integer; safecall;
    property ContactRect: TRectF read get_ContactRect;
    property ContactRectRaw: TRectF read get_ContactRectRaw;
    property IsBarrelButtonPressed: Boolean read get_IsBarrelButtonPressed;
    property IsCanceled: Boolean read get_IsCanceled;
    property IsEraser: Boolean read get_IsEraser;
    property IsHorizontalMouseWheel: Boolean read get_IsHorizontalMouseWheel;
    property IsInRange: Boolean read get_IsInRange;
    property IsInverted: Boolean read get_IsInverted;
    property IsLeftButtonPressed: Boolean read get_IsLeftButtonPressed;
    property IsMiddleButtonPressed: Boolean read get_IsMiddleButtonPressed;
    property IsPrimary: Boolean read get_IsPrimary;
    property IsRightButtonPressed: Boolean read get_IsRightButtonPressed;
    property IsXButton1Pressed: Boolean read get_IsXButton1Pressed;
    property IsXButton2Pressed: Boolean read get_IsXButton2Pressed;
    property MouseWheelDelta: Integer read get_MouseWheelDelta;
    property Orientation: Single read get_Orientation;
    property PointerUpdateKind: PointerUpdateKind read get_PointerUpdateKind;
    property Pressure: Single read get_Pressure;
    property TouchConfidence: Boolean read get_TouchConfidence;
    property Twist: Single read get_Twist;
    property XTilt: Single read get_XTilt;
    property YTilt: Single read get_YTilt;
  end;

  // Windows.UI.Input.IPointerPoint
  IPointerPoint = interface(IInspectable)
  ['{E995317D-7296-42D9-8233-C5BE73B74A4A}']
    function get_PointerDevice: Input_IPointerDevice; safecall;
    function get_Position: TPointF; safecall;
    function get_RawPosition: TPointF; safecall;
    function get_PointerId: Cardinal; safecall;
    function get_FrameId: Cardinal; safecall;
    function get_Timestamp: UInt64; safecall;
    function get_IsInContact: Boolean; safecall;
    function get_Properties: IPointerPointProperties; safecall;
    property FrameId: Cardinal read get_FrameId;
    property IsInContact: Boolean read get_IsInContact;
    property PointerDevice: Input_IPointerDevice read get_PointerDevice;
    property PointerId: Cardinal read get_PointerId;
    property Position: TPointF read get_Position;
    property Properties: IPointerPointProperties read get_Properties;
    property RawPosition: TPointF read get_RawPosition;
    property Timestamp: UInt64 read get_Timestamp;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.IPointerPoint>
  IIterator_1__IPointerPoint = interface(IInspectable)
  ['{2C506FAB-54BD-5007-8847-46FB9494DFB3}']
    function get_Current: IPointerPoint; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIPointerPoint): Cardinal; safecall;
    property Current: IPointerPoint read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.IPointerPoint>
  IIterable_1__IPointerPoint_Base = interface(IInspectable)
  ['{F6F2CBA6-7076-5B59-9631-F6AC32B57695}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.IPointerPoint>
  IIterable_1__IPointerPoint = interface(IIterable_1__IPointerPoint_Base)
  ['{69A48EED-AF6C-5AE9-ACAD-A403EB13C0DA}']
    function First: IIterator_1__IPointerPoint; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.IPointerPoint>
  IVectorView_1__IPointerPoint = interface(IInspectable)
  ['{1697E0A0-DFE4-5BAE-AC51-F4C43FCEF82B}']
    function GetAt(index: Cardinal): IPointerPoint; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IPointerPoint; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPointerPoint): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.Foundation.Collections.IVector`1<Windows.UI.Input.IPointerPoint>
  IVector_1__IPointerPoint = interface(IInspectable)
  ['{73154191-695C-5F04-9D43-911CB8336411}']
    function GetAt(index: Cardinal): IPointerPoint; safecall;
    function get_Size: Cardinal; safecall;
    function GetView: IVectorView_1__IPointerPoint; safecall;
    function IndexOf(value: IPointerPoint; out index: Cardinal): Boolean; safecall;
    procedure SetAt(index: Cardinal; value: IPointerPoint); safecall;
    procedure InsertAt(index: Cardinal; value: IPointerPoint); safecall;
    procedure RemoveAt(index: Cardinal); safecall;
    procedure Append(value: IPointerPoint); safecall;
    procedure RemoveAtEnd; safecall;
    procedure Clear; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIPointerPoint): Cardinal; safecall;
    procedure ReplaceAll(itemsSize: Cardinal; items: PIPointerPoint); safecall;
    property Size: Cardinal read get_Size;
  end;

  // Windows.UI.Input.IPointerPointTransform
  IPointerPointTransform = interface(IInspectable)
  ['{4D5FE14F-B87C-4028-BC9C-59E9947FB056}']
    function get_Inverse: IPointerPointTransform; safecall;
    function TryTransform(inPoint: TPointF; out outPoint: TPointF): Boolean; safecall;
    function TransformBounds(rect: TRectF): TRectF; safecall;
    property Inverse: IPointerPointTransform read get_Inverse;
  end;


  // Emit Forwarded classes

implementation

  // Emit Classes Implementation

end.
