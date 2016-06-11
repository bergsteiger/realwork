{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Input.Inking;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.UI.Input,
  Winapi.UI.Core,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.Storage.Streams,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.UI.Input.Inking Class Names
  // Windows.UI.Input.Inking.InkUnprocessedInput
  // DualAPI
  SInkUnprocessedInput = 'Windows.UI.Input.Inking.InkUnprocessedInput';
  // Windows.UI.Input.Inking.InkStrokeInput
  // DualAPI
  SInkStrokeInput = 'Windows.UI.Input.Inking.InkStrokeInput';
  // Windows.UI.Input.Inking.InkInputProcessingConfiguration
  // DualAPI
  SInkInputProcessingConfiguration = 'Windows.UI.Input.Inking.InkInputProcessingConfiguration';
  // Windows.UI.Input.Inking.InkSynchronizer
  // DualAPI
  SInkSynchronizer = 'Windows.UI.Input.Inking.InkSynchronizer';
  // Windows.UI.Input.Inking.InkPresenter
  // DualAPI
  SInkPresenter = 'Windows.UI.Input.Inking.InkPresenter';
  // Windows.UI.Input.Inking.InkStrokesCollectedEventArgs
  // DualAPI
  SInkStrokesCollectedEventArgs = 'Windows.UI.Input.Inking.InkStrokesCollectedEventArgs';
  // Windows.UI.Input.Inking.InkStrokesErasedEventArgs
  // DualAPI
  SInkStrokesErasedEventArgs = 'Windows.UI.Input.Inking.InkStrokesErasedEventArgs';
  // Windows.UI.Input.Inking.Core.CoreInkIndependentInputSource
  // DualAPI
  SCore_CoreInkIndependentInputSource = 'Windows.UI.Input.Inking.Core.CoreInkIndependentInputSource';
  // Windows.UI.Input.Inking.InkPoint
  // DualAPI
  SInkPoint = 'Windows.UI.Input.Inking.InkPoint';
  // Windows.UI.Input.Inking.InkDrawingAttributes
  // DualAPI
  SInkDrawingAttributes = 'Windows.UI.Input.Inking.InkDrawingAttributes';
  // Windows.UI.Input.Inking.InkStrokeRenderingSegment
  // DualAPI
  SInkStrokeRenderingSegment = 'Windows.UI.Input.Inking.InkStrokeRenderingSegment';
  // Windows.UI.Input.Inking.InkStroke
  // DualAPI
  SInkStroke = 'Windows.UI.Input.Inking.InkStroke';
  // Windows.UI.Input.Inking.InkStrokeBuilder
  // DualAPI
  SInkStrokeBuilder = 'Windows.UI.Input.Inking.InkStrokeBuilder';
  // Windows.UI.Input.Inking.InkRecognitionResult
  // DualAPI
  SInkRecognitionResult = 'Windows.UI.Input.Inking.InkRecognitionResult';
  // Windows.UI.Input.Inking.InkStrokeContainer
  // DualAPI
  SInkStrokeContainer = 'Windows.UI.Input.Inking.InkStrokeContainer';
  // Windows.UI.Input.Inking.InkRecognizer
  // DualAPI
  SInkRecognizer = 'Windows.UI.Input.Inking.InkRecognizer';
  // Windows.UI.Input.Inking.InkRecognizerContainer
  // DualAPI
  SInkRecognizerContainer = 'Windows.UI.Input.Inking.InkRecognizerContainer';
  // Windows.UI.Input.Inking.InkManager
  // DualAPI
  SInkManager = 'Windows.UI.Input.Inking.InkManager';


type
  // Forward declare interfaces
  // Windows.UI.Input.Inking.IInkDrawingAttributes
  IInkDrawingAttributes = interface;
  PIInkDrawingAttributes = ^IInkDrawingAttributes;

  // Windows.UI.Input.Inking.IInkStrokeRenderingSegment
  IInkStrokeRenderingSegment = interface;
  PIInkStrokeRenderingSegment = ^IInkStrokeRenderingSegment;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IIterator_1__IInkStrokeRenderingSegment = interface;
  PIIterator_1__IInkStrokeRenderingSegment = ^IIterator_1__IInkStrokeRenderingSegment;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IIterable_1__IInkStrokeRenderingSegment = interface;
  PIIterable_1__IInkStrokeRenderingSegment = ^IIterable_1__IInkStrokeRenderingSegment;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IVectorView_1__IInkStrokeRenderingSegment = interface;
  PIVectorView_1__IInkStrokeRenderingSegment = ^IVectorView_1__IInkStrokeRenderingSegment;

  // Windows.UI.Input.Inking.IInkStroke
  IInkStroke = interface;
  PIInkStroke = ^IInkStroke;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkStroke>
  IIterator_1__IInkStroke = interface;
  PIIterator_1__IInkStroke = ^IIterator_1__IInkStroke;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStroke>
  IIterable_1__IInkStroke = interface;
  PIIterable_1__IInkStroke = ^IIterable_1__IInkStroke;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkStroke>
  IVectorView_1__IInkStroke = interface;
  PIVectorView_1__IInkStroke = ^IVectorView_1__IInkStroke;

  // Windows.UI.Input.Inking.IInkStrokesCollectedEventArgs
  IInkStrokesCollectedEventArgs = interface;
  PIInkStrokesCollectedEventArgs = ^IInkStrokesCollectedEventArgs;

  // Windows.UI.Input.Inking.IInkStrokesErasedEventArgs
  IInkStrokesErasedEventArgs = interface;
  PIInkStrokesErasedEventArgs = ^IInkStrokesErasedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkUnprocessedInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs = interface;
  PTypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs = ^TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs;

  // Windows.UI.Input.Inking.IInkUnprocessedInput
  IInkUnprocessedInput = interface;
  PIInkUnprocessedInput = ^IInkUnprocessedInput;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkStrokeInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs = interface;
  PTypedEventHandler_2__IInkStrokeInput__IPointerEventArgs = ^TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs;

  // Windows.UI.Input.Inking.IInkStrokeInput
  IInkStrokeInput = interface;
  PIInkStrokeInput = ^IInkStrokeInput;

  // Windows.UI.Input.Inking.IInkInputProcessingConfiguration
  IInkInputProcessingConfiguration = interface;
  PIInkInputProcessingConfiguration = ^IInkInputProcessingConfiguration;

  // Windows.UI.Input.Inking.IInkRecognitionResult
  IInkRecognitionResult = interface;
  PIInkRecognitionResult = ^IInkRecognitionResult;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IIterator_1__IInkRecognitionResult = interface;
  PIIterator_1__IInkRecognitionResult = ^IIterator_1__IInkRecognitionResult;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IIterable_1__IInkRecognitionResult = interface;
  PIIterable_1__IInkRecognitionResult = ^IIterable_1__IInkRecognitionResult;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IVectorView_1__IInkRecognitionResult = interface;
  PIVectorView_1__IInkRecognitionResult = ^IVectorView_1__IInkRecognitionResult;

  // Windows.UI.Input.Inking.IInkStrokeContainer
  IInkStrokeContainer = interface;
  PIInkStrokeContainer = ^IInkStrokeContainer;

  // Windows.UI.Input.Inking.IInkSynchronizer
  IInkSynchronizer = interface;
  PIInkSynchronizer = ^IInkSynchronizer;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesCollectedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs = interface;
  PTypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs = ^TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesErasedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs = interface;
  PTypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs = ^TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs;

  // Windows.UI.Input.Inking.IInkPresenter
  IInkPresenter = interface;
  PIInkPresenter = ^IInkPresenter;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSource,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs = interface;
  PTypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs = ^TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs;

  // Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSource
  Core_ICoreInkIndependentInputSource = interface;
  PCore_ICoreInkIndependentInputSource = ^Core_ICoreInkIndependentInputSource;

  // Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSourceStatics
  Core_ICoreInkIndependentInputSourceStatics = interface;
  PCore_ICoreInkIndependentInputSourceStatics = ^Core_ICoreInkIndependentInputSourceStatics;

  // Windows.UI.Input.Inking.IInkPoint
  IInkPoint = interface;
  PIInkPoint = ^IInkPoint;

  // Windows.UI.Input.Inking.IInkPointFactory
  IInkPointFactory = interface;
  PIInkPointFactory = ^IInkPointFactory;

  // Windows.UI.Input.Inking.IInkDrawingAttributes2
  IInkDrawingAttributes2 = interface;
  PIInkDrawingAttributes2 = ^IInkDrawingAttributes2;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkPoint>
  IIterator_1__IInkPoint = interface;
  PIIterator_1__IInkPoint = ^IIterator_1__IInkPoint;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkPoint>
  IIterable_1__IInkPoint = interface;
  PIIterable_1__IInkPoint = ^IIterable_1__IInkPoint;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkPoint>
  IVectorView_1__IInkPoint = interface;
  PIVectorView_1__IInkPoint = ^IVectorView_1__IInkPoint;

  // Windows.UI.Input.Inking.IInkStroke2
  IInkStroke2 = interface;
  PIInkStroke2 = ^IInkStroke2;

  // Windows.UI.Input.Inking.IInkStrokeBuilder
  IInkStrokeBuilder = interface;
  PIInkStrokeBuilder = ^IInkStrokeBuilder;

  // Windows.UI.Input.Inking.IInkStrokeBuilder2
  IInkStrokeBuilder2 = interface;
  PIInkStrokeBuilder2 = ^IInkStrokeBuilder2;

  // Windows.UI.Input.Inking.IInkStrokeContainer2
  IInkStrokeContainer2 = interface;
  PIInkStrokeContainer2 = ^IInkStrokeContainer2;

  // Windows.UI.Input.Inking.IInkRecognizer
  IInkRecognizer = interface;
  PIInkRecognizer = ^IInkRecognizer;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult = interface;
  PAsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult = ^AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  IAsyncOperation_1__IVectorView_1__IInkRecognitionResult = interface;
  PIAsyncOperation_1__IVectorView_1__IInkRecognitionResult = ^IAsyncOperation_1__IVectorView_1__IInkRecognitionResult;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkRecognizer>
  IIterator_1__IInkRecognizer = interface;
  PIIterator_1__IInkRecognizer = ^IIterator_1__IInkRecognizer;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognizer>
  IIterable_1__IInkRecognizer = interface;
  PIIterable_1__IInkRecognizer = ^IIterable_1__IInkRecognizer;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognizer>
  IVectorView_1__IInkRecognizer = interface;
  PIVectorView_1__IInkRecognizer = ^IVectorView_1__IInkRecognizer;

  // Windows.UI.Input.Inking.IInkRecognizerContainer
  IInkRecognizerContainer = interface;
  PIInkRecognizerContainer = ^IInkRecognizerContainer;

  // Windows.UI.Input.Inking.IInkManager
  IInkManager = interface;
  PIInkManager = ^IInkManager;


  // Emit Forwarded interfaces
  // Windows.UI.Input.Inking Interfaces
  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkDrawingAttributes
  [WinRTClassNameAttribute(SInkDrawingAttributes)]
  IInkDrawingAttributes = interface(IInspectable)
  ['{97A2176C-6774-48AD-84F0-48F5A9BE74F9}']
    function get_Color: Color; safecall;
    procedure put_Color(value: Color); safecall;
    function get_PenTip: PenTipShape; safecall;
    procedure put_PenTip(value: PenTipShape); safecall;
    function get_Size: TSizeF; safecall;
    procedure put_Size(value: TSizeF); safecall;
    function get_IgnorePressure: Boolean; safecall;
    procedure put_IgnorePressure(value: Boolean); safecall;
    function get_FitToCurve: Boolean; safecall;
    procedure put_FitToCurve(value: Boolean); safecall;
    property Color: Color read get_Color write put_Color;
    property FitToCurve: Boolean read get_FitToCurve write put_FitToCurve;
    property IgnorePressure: Boolean read get_IgnorePressure write put_IgnorePressure;
    property PenTip: PenTipShape read get_PenTip write put_PenTip;
    property Size: TSizeF read get_Size write put_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeRenderingSegment
  [WinRTClassNameAttribute(SInkStrokeRenderingSegment)]
  IInkStrokeRenderingSegment = interface(IInspectable)
  ['{68510F1F-88E3-477A-A2FA-569F5F1F9BD5}']
    function get_Position: TPointF; safecall;
    function get_BezierControlPoint1: TPointF; safecall;
    function get_BezierControlPoint2: TPointF; safecall;
    function get_Pressure: Single; safecall;
    function get_TiltX: Single; safecall;
    function get_TiltY: Single; safecall;
    function get_Twist: Single; safecall;
    property BezierControlPoint1: TPointF read get_BezierControlPoint1;
    property BezierControlPoint2: TPointF read get_BezierControlPoint2;
    property Position: TPointF read get_Position;
    property Pressure: Single read get_Pressure;
    property TiltX: Single read get_TiltX;
    property TiltY: Single read get_TiltY;
    property Twist: Single read get_Twist;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IIterator_1__IInkStrokeRenderingSegment = interface(IInspectable)
  ['{4C6160CF-7BA6-560A-B27C-80F5E4F7FDF5}']
    function get_Current: IInkStrokeRenderingSegment; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInkStrokeRenderingSegment): Cardinal; safecall;
    property Current: IInkStrokeRenderingSegment read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IIterable_1__IInkStrokeRenderingSegment_Base = interface(IInspectable)
  ['{27000F47-2885-5DA9-8923-16A3A58B7A55}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IIterable_1__IInkStrokeRenderingSegment = interface(IIterable_1__IInkStrokeRenderingSegment_Base)
  ['{8257ED76-E624-53F9-A263-989CE2165CBD}']
    function First: IIterator_1__IInkStrokeRenderingSegment; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkStrokeRenderingSegment>
  IVectorView_1__IInkStrokeRenderingSegment = interface(IInspectable)
  ['{533D1D1F-D4DE-5B1B-8AD2-33127C4637DD}']
    function GetAt(index: Cardinal): IInkStrokeRenderingSegment; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInkStrokeRenderingSegment; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInkStrokeRenderingSegment): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStroke
  [WinRTClassNameAttribute(SInkStroke)]
  IInkStroke = interface(IInspectable)
  ['{15144D60-CCE3-4FCF-9D52-11518AB6AFD4}']
    function get_DrawingAttributes: IInkDrawingAttributes; safecall;
    procedure put_DrawingAttributes(value: IInkDrawingAttributes); safecall;
    function get_BoundingRect: TRectF; safecall;
    function get_Selected: Boolean; safecall;
    procedure put_Selected(value: Boolean); safecall;
    function get_Recognized: Boolean; safecall;
    function GetRenderingSegments: IVectorView_1__IInkStrokeRenderingSegment; safecall;
    function Clone: IInkStroke; safecall;
    property BoundingRect: TRectF read get_BoundingRect;
    property DrawingAttributes: IInkDrawingAttributes read get_DrawingAttributes write put_DrawingAttributes;
    property Recognized: Boolean read get_Recognized;
    property Selected: Boolean read get_Selected write put_Selected;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkStroke>
  IIterator_1__IInkStroke = interface(IInspectable)
  ['{290D40AA-369B-5B43-89AB-EB478BF8E02E}']
    function get_Current: IInkStroke; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInkStroke): Cardinal; safecall;
    property Current: IInkStroke read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStroke>
  IIterable_1__IInkStroke_Base = interface(IInspectable)
  ['{BBC11401-89D0-5305-A3B3-36C887714B9B}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkStroke>
  IIterable_1__IInkStroke = interface(IIterable_1__IInkStroke_Base)
  ['{D85C9152-A2E8-5C08-AD59-D32E7631674F}']
    function First: IIterator_1__IInkStroke; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkStroke>
  IVectorView_1__IInkStroke = interface(IInspectable)
  ['{C3FC26F7-5323-55A2-90F5-5EBE01DAF672}']
    function GetAt(index: Cardinal): IInkStroke; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInkStroke; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInkStroke): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokesCollectedEventArgs
  [WinRTClassNameAttribute(SInkStrokesCollectedEventArgs)]
  IInkStrokesCollectedEventArgs = interface(IInspectable)
  ['{C4F3F229-1938-495C-B4D9-6DE4B08D4811}']
    function get_Strokes: IVectorView_1__IInkStroke; safecall;
    property Strokes: IVectorView_1__IInkStroke read get_Strokes;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokesErasedEventArgs
  [WinRTClassNameAttribute(SInkStrokesErasedEventArgs)]
  IInkStrokesErasedEventArgs = interface(IInspectable)
  ['{A4216A22-1503-4EBF-8FF5-2DE84584A8AA}']
    function get_Strokes: IVectorView_1__IInkStroke; safecall;
    property Strokes: IVectorView_1__IInkStroke read get_Strokes;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkUnprocessedInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs_Delegate_Base = interface(IUnknown)
  ['{4A86BD78-5BCF-5EDE-8F65-A8C65235055C}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkUnprocessedInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs = interface(TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs_Delegate_Base)
  ['{E5E83F48-D96A-5622-81AD-4BA59E3DCF06}']
    procedure Invoke(sender: IInkUnprocessedInput; args: IPointerEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkUnprocessedInput
  [WinRTClassNameAttribute(SInkUnprocessedInput)]
  IInkUnprocessedInput = interface(IInspectable)
  ['{DB4445E0-8398-4921-AC3B-AB978C5BA256}']
    function add_PointerEntered(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerEntered(cookie: EventRegistrationToken); safecall;
    function add_PointerHovered(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerHovered(cookie: EventRegistrationToken); safecall;
    function add_PointerExited(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerExited(cookie: EventRegistrationToken); safecall;
    function add_PointerPressed(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerPressed(cookie: EventRegistrationToken); safecall;
    function add_PointerMoved(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerMoved(cookie: EventRegistrationToken); safecall;
    function add_PointerReleased(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerReleased(cookie: EventRegistrationToken); safecall;
    function add_PointerLost(handler: TypedEventHandler_2__IInkUnprocessedInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerLost(cookie: EventRegistrationToken); safecall;
    function get_InkPresenter: IInkPresenter; safecall;
    property InkPresenter: IInkPresenter read get_InkPresenter;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkStrokeInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs_Delegate_Base = interface(IUnknown)
  ['{BF66B962-702D-5C07-A2D5-15F21583C43A}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkStrokeInput,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs = interface(TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs_Delegate_Base)
  ['{8D3570C6-D204-57E3-9A3D-07B8A0D5E873}']
    procedure Invoke(sender: IInkStrokeInput; args: IPointerEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeInput
  [WinRTClassNameAttribute(SInkStrokeInput)]
  IInkStrokeInput = interface(IInspectable)
  ['{CF2FFE7B-5E10-43C6-A080-88F26E1DC67D}']
    function add_StrokeStarted(handler: TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokeStarted(cookie: EventRegistrationToken); safecall;
    function add_StrokeContinued(handler: TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokeContinued(cookie: EventRegistrationToken); safecall;
    function add_StrokeEnded(handler: TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokeEnded(cookie: EventRegistrationToken); safecall;
    function add_StrokeCanceled(handler: TypedEventHandler_2__IInkStrokeInput__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokeCanceled(cookie: EventRegistrationToken); safecall;
    function get_InkPresenter: IInkPresenter; safecall;
    property InkPresenter: IInkPresenter read get_InkPresenter;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkInputProcessingConfiguration
  [WinRTClassNameAttribute(SInkInputProcessingConfiguration)]
  IInkInputProcessingConfiguration = interface(IInspectable)
  ['{2778D85E-33CA-4B06-A6D3-AC3945116D37}']
    function get_Mode: InkInputProcessingMode; safecall;
    procedure put_Mode(value: InkInputProcessingMode); safecall;
    function get_RightDragAction: InkInputRightDragAction; safecall;
    procedure put_RightDragAction(value: InkInputRightDragAction); safecall;
    property Mode: InkInputProcessingMode read get_Mode write put_Mode;
    property RightDragAction: InkInputRightDragAction read get_RightDragAction write put_RightDragAction;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkRecognitionResult
  [WinRTClassNameAttribute(SInkRecognitionResult)]
  IInkRecognitionResult = interface(IInspectable)
  ['{36461A94-5068-40EF-8A05-2C2FB60908A2}']
    function get_BoundingRect: TRectF; safecall;
    function GetTextCandidates: IVectorView_1__HSTRING; safecall;
    function GetStrokes: IVectorView_1__IInkStroke; safecall;
    property BoundingRect: TRectF read get_BoundingRect;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IIterator_1__IInkRecognitionResult = interface(IInspectable)
  ['{666B7A6D-1A5C-5075-8320-52A4D5F5727A}']
    function get_Current: IInkRecognitionResult; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInkRecognitionResult): Cardinal; safecall;
    property Current: IInkRecognitionResult read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IIterable_1__IInkRecognitionResult_Base = interface(IInspectable)
  ['{E29B658B-7CC1-561C-9912-001DBCA86651}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IIterable_1__IInkRecognitionResult = interface(IIterable_1__IInkRecognitionResult_Base)
  ['{146806FB-6B02-587F-9054-0F8C7AFD57BC}']
    function First: IIterator_1__IInkRecognitionResult; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>
  IVectorView_1__IInkRecognitionResult = interface(IInspectable)
  ['{3C16D87C-E0C0-5689-A3D8-87D11003DEA9}']
    function GetAt(index: Cardinal): IInkRecognitionResult; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInkRecognitionResult; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInkRecognitionResult): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeContainer
  [WinRTClassNameAttribute(SInkStrokeContainer)]
  IInkStrokeContainer = interface(IInspectable)
  ['{22ACCBC6-FAA9-4F14-B68C-F6CEE670AE16}']
    function get_BoundingRect: TRectF; safecall;
    procedure AddStroke(stroke: IInkStroke); safecall;
    function DeleteSelected: TRectF; safecall;
    function MoveSelected(translation: TPointF): TRectF; safecall;
    function SelectWithPolyLine(polyline: IIterable_1__Point): TRectF; safecall;
    function SelectWithLine(from: TPointF; &to: TPointF): TRectF; safecall;
    procedure CopySelectedToClipboard; safecall;
    function PasteFromClipboard(position: TPointF): TRectF; safecall;
    function CanPasteFromClipboard: Boolean; safecall;
    function LoadAsync(inputStream: IInputStream): IAsyncActionWithProgress_1__UInt64; safecall;
    function SaveAsync(outputStream: IOutputStream): IAsyncOperationWithProgress_2__Cardinal__Cardinal; safecall;
    procedure UpdateRecognitionResults(recognitionResults: IVectorView_1__IInkRecognitionResult); safecall;
    function GetStrokes: IVectorView_1__IInkStroke; safecall;
    function GetRecognitionResults: IVectorView_1__IInkRecognitionResult; safecall;
    property BoundingRect: TRectF read get_BoundingRect;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkSynchronizer
  [WinRTClassNameAttribute(SInkSynchronizer)]
  IInkSynchronizer = interface(IInspectable)
  ['{9B9EA160-AE9B-45F9-8407-4B493B163661}']
    function BeginDry: IVectorView_1__IInkStroke; safecall;
    procedure EndDry; safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesCollectedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs_Delegate_Base = interface(IUnknown)
  ['{176BFA8F-C0DE-5B3A-B28C-0F3931CA52D3}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesCollectedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs = interface(TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs_Delegate_Base)
  ['{EAEA1A9B-FCE4-51A5-B952-C4037CF4291E}']
    procedure Invoke(sender: IInkPresenter; args: IInkStrokesCollectedEventArgs); safecall;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesErasedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs_Delegate_Base = interface(IUnknown)
  ['{30FEC929-14D0-550F-84F2-137FC6A9F08F}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.IInkPresenter,Windows.UI.Input.Inking.IInkStrokesErasedEventArgs>
  TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs = interface(TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs_Delegate_Base)
  ['{78213819-AC61-5AC9-987D-45069CDCB496}']
    procedure Invoke(sender: IInkPresenter; args: IInkStrokesErasedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkPresenter
  [WinRTClassNameAttribute(SInkPresenter)]
  IInkPresenter = interface(IInspectable)
  ['{A69B70E2-887B-458F-B173-4FE4438930A3}']
    function get_IsInputEnabled: Boolean; safecall;
    procedure put_IsInputEnabled(value: Boolean); safecall;
    function get_InputDeviceTypes: CoreInputDeviceTypes; safecall;
    procedure put_InputDeviceTypes(value: CoreInputDeviceTypes); safecall;
    function get_UnprocessedInput: IInkUnprocessedInput; safecall;
    function get_StrokeInput: IInkStrokeInput; safecall;
    function get_InputProcessingConfiguration: IInkInputProcessingConfiguration; safecall;
    function get_StrokeContainer: IInkStrokeContainer; safecall;
    procedure put_StrokeContainer(value: IInkStrokeContainer); safecall;
    function CopyDefaultDrawingAttributes: IInkDrawingAttributes; safecall;
    procedure UpdateDefaultDrawingAttributes(value: IInkDrawingAttributes); safecall;
    function ActivateCustomDrying: IInkSynchronizer; safecall;
    procedure SetPredefinedConfiguration(value: InkPresenterPredefinedConfiguration); safecall;
    function add_StrokesCollected(handler: TypedEventHandler_2__IInkPresenter__IInkStrokesCollectedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokesCollected(cookie: EventRegistrationToken); safecall;
    function add_StrokesErased(handler: TypedEventHandler_2__IInkPresenter__IInkStrokesErasedEventArgs): EventRegistrationToken; safecall;
    procedure remove_StrokesErased(cookie: EventRegistrationToken); safecall;
    property InputDeviceTypes: CoreInputDeviceTypes read get_InputDeviceTypes write put_InputDeviceTypes;
    property InputProcessingConfiguration: IInkInputProcessingConfiguration read get_InputProcessingConfiguration;
    property IsInputEnabled: Boolean read get_IsInputEnabled write put_IsInputEnabled;
    property StrokeContainer: IInkStrokeContainer read get_StrokeContainer write put_StrokeContainer;
    property StrokeInput: IInkStrokeInput read get_StrokeInput;
    property UnprocessedInput: IInkUnprocessedInput read get_UnprocessedInput;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSource,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs_Delegate_Base = interface(IUnknown)
  ['{B83FBE98-882A-5B69-BD1C-C66690707FEF}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSource,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs = interface(TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs_Delegate_Base)
  ['{D5E0528D-E040-5453-B8AE-4AABC229B374}']
    procedure Invoke(sender: Core_ICoreInkIndependentInputSource; args: IPointerEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSource
  [WinRTClassNameAttribute(SCore_CoreInkIndependentInputSource)]
  Core_ICoreInkIndependentInputSource = interface(IInspectable)
  ['{39B38DA9-7639-4499-A5B5-191D00E35B16}']
    function add_PointerEntering(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerEntering(cookie: EventRegistrationToken); safecall;
    function add_PointerHovering(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerHovering(cookie: EventRegistrationToken); safecall;
    function add_PointerExiting(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerExiting(cookie: EventRegistrationToken); safecall;
    function add_PointerPressing(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerPressing(cookie: EventRegistrationToken); safecall;
    function add_PointerMoving(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerMoving(cookie: EventRegistrationToken); safecall;
    function add_PointerReleasing(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerReleasing(cookie: EventRegistrationToken); safecall;
    function add_PointerLost(handler: TypedEventHandler_2__Core_ICoreInkIndependentInputSource__IPointerEventArgs): EventRegistrationToken; safecall;
    procedure remove_PointerLost(cookie: EventRegistrationToken); safecall;
    function get_InkPresenter: IInkPresenter; safecall;
    property InkPresenter: IInkPresenter read get_InkPresenter;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.Core.ICoreInkIndependentInputSourceStatics
  [WinRTClassNameAttribute(SCore_CoreInkIndependentInputSource)]
  Core_ICoreInkIndependentInputSourceStatics = interface(IInspectable)
  ['{73E6011B-80C0-4DFB-9B66-10BA7F3F9C84}']
    function Create(inkPresenter: IInkPresenter): Core_ICoreInkIndependentInputSource; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkPoint
  [WinRTClassNameAttribute(SInkPoint)]
  IInkPoint = interface(IInspectable)
  ['{9F87272B-858C-46A5-9B41-D195970459FD}']
    function get_Position: TPointF; safecall;
    function get_Pressure: Single; safecall;
    property Position: TPointF read get_Position;
    property Pressure: Single read get_Pressure;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkPointFactory
  [WinRTClassNameAttribute(SInkPoint)]
  IInkPointFactory = interface(IInspectable)
  ['{29E5D51C-C98F-405D-9F3B-E53E31068D4D}']
    function CreateInkPoint(position: TPointF; pressure: Single): IInkPoint; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkDrawingAttributes2
  IInkDrawingAttributes2 = interface(IInspectable)
  ['{7CAB6508-8EC4-42FD-A5A5-E4B7D1D5316D}']
    function get_PenTipTransform: Numerics_Matrix3x2; safecall;
    procedure put_PenTipTransform(value: Numerics_Matrix3x2); safecall;
    function get_DrawAsHighlighter: Boolean; safecall;
    procedure put_DrawAsHighlighter(value: Boolean); safecall;
    property DrawAsHighlighter: Boolean read get_DrawAsHighlighter write put_DrawAsHighlighter;
    property PenTipTransform: Numerics_Matrix3x2 read get_PenTipTransform write put_PenTipTransform;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkPoint>
  IIterator_1__IInkPoint = interface(IInspectable)
  ['{CDD4F975-F1AD-501A-95D1-5CD7053A3DE1}']
    function get_Current: IInkPoint; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInkPoint): Cardinal; safecall;
    property Current: IInkPoint read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkPoint>
  IIterable_1__IInkPoint_Base = interface(IInspectable)
  ['{0630C0EF-A4E2-5AF6-B2E9-8E042E294E17}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkPoint>
  IIterable_1__IInkPoint = interface(IIterable_1__IInkPoint_Base)
  ['{A9E993DD-3779-5FEF-B8B2-1E40384D55DA}']
    function First: IIterator_1__IInkPoint; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkPoint>
  IVectorView_1__IInkPoint = interface(IInspectable)
  ['{86BAE711-F0CD-51F6-B838-CC568D127246}']
    function GetAt(index: Cardinal): IInkPoint; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInkPoint; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInkPoint): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStroke2
  IInkStroke2 = interface(IInspectable)
  ['{5DB9E4F4-BAFA-4DE1-89D3-201B1ED7D89B}']
    function get_PointTransform: Numerics_Matrix3x2; safecall;
    procedure put_PointTransform(value: Numerics_Matrix3x2); safecall;
    function GetInkPoints: IVectorView_1__IInkPoint; safecall;
    property PointTransform: Numerics_Matrix3x2 read get_PointTransform write put_PointTransform;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeBuilder
  [WinRTClassNameAttribute(SInkStrokeBuilder)]
  IInkStrokeBuilder = interface(IInspectable)
  ['{82BBD1DC-1C63-41DC-9E07-4B4A70CED801}']
    procedure BeginStroke(pointerPoint: IPointerPoint); safecall;
    function AppendToStroke(pointerPoint: IPointerPoint): IPointerPoint; safecall;
    function EndStroke(pointerPoint: IPointerPoint): IInkStroke; safecall;
    function CreateStroke(points: IIterable_1__Point): IInkStroke; safecall;
    procedure SetDefaultDrawingAttributes(drawingAttributes: IInkDrawingAttributes); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeBuilder2
  IInkStrokeBuilder2 = interface(IInspectable)
  ['{BD82BC27-731F-4CBC-BBBF-6D468044F1E5}']
    function CreateStrokeFromInkPoints(inkPoints: IIterable_1__IInkPoint; transform: Numerics_Matrix3x2): IInkStroke; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkStrokeContainer2
  IInkStrokeContainer2 = interface(IInspectable)
  ['{8901D364-DA36-4BCF-9E5C-D195825995B4}']
    procedure AddStrokes(strokes: IIterable_1__IInkStroke); safecall;
    procedure Clear; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkRecognizer
  [WinRTClassNameAttribute(SInkRecognizer)]
  IInkRecognizer = interface(IInspectable)
  ['{077CCEA3-904D-442A-B151-AACA3631C43B}']
    function get_Name: HSTRING; safecall;
    property Name: HSTRING read get_Name;
  end;

  // Generic Delegate for 
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult_Delegate_Base = interface(IUnknown)
  ['{ECE8567F-8080-5CED-8988-BB0364C803D4}']
  end;
  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult = interface(AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult_Delegate_Base)
  ['{B658F05D-8BA7-5DAC-9253-FF7006750267}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__IVectorView_1__IInkRecognitionResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  IAsyncOperation_1__IVectorView_1__IInkRecognitionResult_Base = interface(IInspectable)
  ['{B1923F59-D674-5365-B99A-3F1E52268C7F}']
  end;
  // Windows.Foundation.IAsyncOperation`1<Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognitionResult>>
  IAsyncOperation_1__IVectorView_1__IInkRecognitionResult = interface(IAsyncOperation_1__IVectorView_1__IInkRecognitionResult_Base)
  ['{13D81DD7-2C81-5ADB-9106-2B3C3E6F8298}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult; safecall;
    function GetResults: IVectorView_1__IInkRecognitionResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__IVectorView_1__IInkRecognitionResult read get_Completed write put_Completed;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Input.Inking.IInkRecognizer>
  IIterator_1__IInkRecognizer = interface(IInspectable)
  ['{28DFF88B-C687-51E7-B261-11999AA27264}']
    function get_Current: IInkRecognizer; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIInkRecognizer): Cardinal; safecall;
    property Current: IInkRecognizer read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognizer>
  IIterable_1__IInkRecognizer_Base = interface(IInspectable)
  ['{611B7E84-A803-5071-AAEA-4F2CE0151052}']
  end;
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Input.Inking.IInkRecognizer>
  IIterable_1__IInkRecognizer = interface(IIterable_1__IInkRecognizer_Base)
  ['{DAB88C7D-BE83-5950-B0EA-4B7018E046BE}']
    function First: IIterator_1__IInkRecognizer; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Input.Inking.IInkRecognizer>
  IVectorView_1__IInkRecognizer = interface(IInspectable)
  ['{C6A52642-FFBD-5410-ABA3-517FF9A91011}']
    function GetAt(index: Cardinal): IInkRecognizer; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: IInkRecognizer; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PIInkRecognizer): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkRecognizerContainer
  [WinRTClassNameAttribute(SInkRecognizerContainer)]
  IInkRecognizerContainer = interface(IInspectable)
  ['{A74D9A31-8047-4698-A912-F82A5085012F}']
    procedure SetDefaultRecognizer(recognizer: IInkRecognizer); safecall;
    function RecognizeAsync(strokeCollection: IInkStrokeContainer; recognitionTarget: InkRecognitionTarget): IAsyncOperation_1__IVectorView_1__IInkRecognitionResult; safecall;
    function GetRecognizers: IVectorView_1__IInkRecognizer; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Input.Inking.IInkManager
  [WinRTClassNameAttribute(SInkManager)]
  IInkManager = interface(IInspectable)
  ['{4744737D-671B-4163-9C95-4E8D7A035FE1}']
    function get_Mode: InkManipulationMode; safecall;
    procedure put_Mode(value: InkManipulationMode); safecall;
    procedure ProcessPointerDown(pointerPoint: IPointerPoint); safecall;
    function ProcessPointerUpdate(pointerPoint: IPointerPoint): IInspectable; safecall;
    function ProcessPointerUp(pointerPoint: IPointerPoint): TRectF; safecall;
    procedure SetDefaultDrawingAttributes(drawingAttributes: IInkDrawingAttributes); safecall;
    function RecognizeAsync(recognitionTarget: InkRecognitionTarget): IAsyncOperation_1__IVectorView_1__IInkRecognitionResult; safecall;
    property Mode: InkManipulationMode read get_Mode write put_Mode;
  end;


  // Emit Forwarded classes
  // Windows.UI.Input.Inking.InkUnprocessedInput
  // DualAPI

  // Windows.UI.Input.Inking.InkStrokeInput
  // DualAPI

  // Windows.UI.Input.Inking.InkInputProcessingConfiguration
  // DualAPI

  // Windows.UI.Input.Inking.InkSynchronizer
  // DualAPI

  // Windows.UI.Input.Inking.InkPresenter
  // DualAPI

  // Windows.UI.Input.Inking.InkStrokesCollectedEventArgs
  // DualAPI

  // Windows.UI.Input.Inking.InkStrokesErasedEventArgs
  // DualAPI

  // Windows.UI.Input.Inking.Core.CoreInkIndependentInputSource
  // DualAPI
  TCore_CoreInkIndependentInputSource = class(TWinRTGenericImportS<Core_ICoreInkIndependentInputSourceStatics>)
  public
    // -> Core_ICoreInkIndependentInputSourceStatics
    class function Create(inkPresenter: IInkPresenter): Core_ICoreInkIndependentInputSource; static; inline;
  end;

  // Windows.UI.Input.Inking.InkPoint
  // DualAPI
  TInkPoint = class(TWinRTGenericImportF<IInkPointFactory>)
  public
    // -> IInkPointFactory
    class function CreateInkPoint(position: TPointF; pressure: Single): IInkPoint; static; inline;
  end;

  // Windows.UI.Input.Inking.InkDrawingAttributes
  // DualAPI
  TInkDrawingAttributes = class(TWinRTGenericImportI<IInkDrawingAttributes>) end;

  // Windows.UI.Input.Inking.InkStrokeRenderingSegment
  // DualAPI

  // Windows.UI.Input.Inking.InkStroke
  // DualAPI

  // Windows.UI.Input.Inking.InkStrokeBuilder
  // DualAPI
  TInkStrokeBuilder = class(TWinRTGenericImportI<IInkStrokeBuilder>) end;

  // Windows.UI.Input.Inking.InkRecognitionResult
  // DualAPI

  // Windows.UI.Input.Inking.InkStrokeContainer
  // DualAPI
  TInkStrokeContainer = class(TWinRTGenericImportI<IInkStrokeContainer>) end;

  // Windows.UI.Input.Inking.InkRecognizer
  // DualAPI

  // Windows.UI.Input.Inking.InkRecognizerContainer
  // DualAPI
  TInkRecognizerContainer = class(TWinRTGenericImportI<IInkRecognizerContainer>) end;

  // Windows.UI.Input.Inking.InkManager
  // DualAPI
  TInkManager = class(TWinRTGenericImportI<IInkManager>) end;


implementation

  // Emit Classes Implementation
 { TCore_CoreInkIndependentInputSource }

class function TCore_CoreInkIndependentInputSource.Create(inkPresenter: IInkPresenter): Core_ICoreInkIndependentInputSource;
begin
  Result := Statics.Create(inkPresenter);
end;


 { TInkPoint }
// Factories for : "InkPoint"
// Factory: "Windows.UI.Input.Inking.IInkPointFactory"
// -> IInkPointFactory

class function TInkPoint.CreateInkPoint(position: TPointF; pressure: Single): IInkPoint;
begin
  Result := Factory.CreateInkPoint(position, pressure);
end;


 { TInkDrawingAttributes }

 { TInkStrokeBuilder }

 { TInkStrokeContainer }

 { TInkRecognizerContainer }

 { TInkManager }


end.
