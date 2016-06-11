{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Composition;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.GraphicsRT,
  Winapi.UI.Core,
  // Internal Uses...
  Winapi.Foundation,
  Winapi.Foundation.Collections,
  Winapi.CommonTypes,
  Winapi.Foundation.Types,
  Winapi.Winrt,
  System.Types,
  System.Win.WinRT;


{$SCOPEDENUMS ON}

const
  // Windows.UI.Composition Class Names
  // Windows.UI.Composition.CompositionObject
  // DualAPI
  SCompositionObject = 'Windows.UI.Composition.CompositionObject';
  // Windows.UI.Composition.CompositionEffect
  // DualAPI
  SCompositionEffect = 'Windows.UI.Composition.CompositionEffect';
  // Windows.UI.Composition.CompositionEffectFactoryLoadResult
  // DualAPI
  SCompositionEffectFactoryLoadResult = 'Windows.UI.Composition.CompositionEffectFactoryLoadResult';
  // Windows.UI.Composition.CompositionEffectSourceParameter
  // DualAPI
  SCompositionEffectSourceParameter = 'Windows.UI.Composition.CompositionEffectSourceParameter';
  // Windows.UI.Composition.CompositionImageOptions
  // DualAPI
  SCompositionImageOptions = 'Windows.UI.Composition.CompositionImageOptions';
  // Windows.UI.Composition.CompositionImage
  // DualAPI
  SCompositionImage = 'Windows.UI.Composition.CompositionImage';
  // Windows.UI.Composition.CompositionImageLoadResult
  // DualAPI
  SCompositionImageLoadResult = 'Windows.UI.Composition.CompositionImageLoadResult';
  // Windows.UI.Composition.Compositor
  // DualAPI
  SCompositor = 'Windows.UI.Composition.Compositor';
  // Windows.UI.Composition.CompositionAnimation
  // DualAPI
  SCompositionAnimation = 'Windows.UI.Composition.CompositionAnimation';
  // Windows.UI.Composition.CompositionPropertyAnimator
  // DualAPI
  SCompositionPropertyAnimator = 'Windows.UI.Composition.CompositionPropertyAnimator';
  // Windows.UI.Composition.AnimationEndedEventArgs
  // DualAPI
  SAnimationEndedEventArgs = 'Windows.UI.Composition.AnimationEndedEventArgs';
  // Windows.UI.Composition.CompositionPropertySet
  // DualAPI
  SCompositionPropertySet = 'Windows.UI.Composition.CompositionPropertySet';
  // Windows.UI.Composition.CompositionGraphicsDevice
  // DualAPI
  SCompositionGraphicsDevice = 'Windows.UI.Composition.CompositionGraphicsDevice';
  // Windows.UI.Composition.CompositionEffectFactory
  // DualAPI
  SCompositionEffectFactory = 'Windows.UI.Composition.CompositionEffectFactory';
  // Windows.UI.Composition.CompositionTarget
  // DualAPI
  SCompositionTarget = 'Windows.UI.Composition.CompositionTarget';
  // Windows.UI.Composition.ExpressionAnimation
  // DualAPI
  SExpressionAnimation = 'Windows.UI.Composition.ExpressionAnimation';
  // Windows.UI.Composition.CompositionEasingFunction
  // DualAPI
  SCompositionEasingFunction = 'Windows.UI.Composition.CompositionEasingFunction';
  // Windows.UI.Composition.CubicBezierEasingFunction
  // DualAPI
  SCubicBezierEasingFunction = 'Windows.UI.Composition.CubicBezierEasingFunction';
  // Windows.UI.Composition.LinearEasingFunction
  // DualAPI
  SLinearEasingFunction = 'Windows.UI.Composition.LinearEasingFunction';
  // Windows.UI.Composition.Visual
  // DualAPI
  SVisual = 'Windows.UI.Composition.Visual';
  // Windows.UI.Composition.ContainerVisual
  // DualAPI
  SContainerVisual = 'Windows.UI.Composition.ContainerVisual';
  // Windows.UI.Composition.EffectVisual
  // DualAPI
  SEffectVisual = 'Windows.UI.Composition.EffectVisual';
  // Windows.UI.Composition.ImageVisual
  // DualAPI
  SImageVisual = 'Windows.UI.Composition.ImageVisual';
  // Windows.UI.Composition.SolidColorVisual
  // DualAPI
  SSolidColorVisual = 'Windows.UI.Composition.SolidColorVisual';
  // Windows.UI.Composition.CompositionClip
  // DualAPI
  SCompositionClip = 'Windows.UI.Composition.CompositionClip';
  // Windows.UI.Composition.InsetClip
  // DualAPI
  SInsetClip = 'Windows.UI.Composition.InsetClip';
  // Windows.UI.Composition.VisualCollection
  // DualAPI
  SVisualCollection = 'Windows.UI.Composition.VisualCollection';
  // Windows.UI.Composition.KeyFrameAnimation
  // DualAPI
  SKeyFrameAnimation = 'Windows.UI.Composition.KeyFrameAnimation';
  // Windows.UI.Composition.ScalarKeyFrameAnimation
  // DualAPI
  SScalarKeyFrameAnimation = 'Windows.UI.Composition.ScalarKeyFrameAnimation';
  // Windows.UI.Composition.Vector2KeyFrameAnimation
  // DualAPI
  SVector2KeyFrameAnimation = 'Windows.UI.Composition.Vector2KeyFrameAnimation';
  // Windows.UI.Composition.Vector3KeyFrameAnimation
  // DualAPI
  SVector3KeyFrameAnimation = 'Windows.UI.Composition.Vector3KeyFrameAnimation';
  // Windows.UI.Composition.Vector4KeyFrameAnimation
  // DualAPI
  SVector4KeyFrameAnimation = 'Windows.UI.Composition.Vector4KeyFrameAnimation';


type
  // Forward declare interfaces
  // Windows.UI.Composition.IAnimationEndedEventArgs
  IAnimationEndedEventArgs = interface;
  PIAnimationEndedEventArgs = ^IAnimationEndedEventArgs;

  // Windows.UI.Composition.ICompositionImageLoadResult
  ICompositionImageLoadResult = interface;
  PICompositionImageLoadResult = ^ICompositionImageLoadResult;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface;
  PAsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = ^AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface;
  PAsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = ^AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface;
  PIAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage = ^IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage;

  // Windows.UI.Composition.ICompositionImage
  ICompositionImage = interface;
  PICompositionImage = ^ICompositionImage;

  // Windows.UI.Composition.ICompositionImageOptions
  ICompositionImageOptions = interface;
  PICompositionImageOptions = ^ICompositionImageOptions;

  // Windows.UI.Composition.ICompositionGraphicsDevice
  ICompositionGraphicsDevice = interface;
  PICompositionGraphicsDevice = ^ICompositionGraphicsDevice;

  // Windows.UI.Composition.ICompositionClip
  ICompositionClip = interface;
  PICompositionClip = ^ICompositionClip;

  // Windows.UI.Composition.IVisual
  IVisual = interface;
  PIVisual = ^IVisual;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Composition.IVisual>
  IIterator_1__IVisual = interface;
  PIIterator_1__IVisual = ^IIterator_1__IVisual;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Composition.IVisual>
  IIterable_1__IVisual = interface;
  PIIterable_1__IVisual = ^IIterable_1__IVisual;

  // Windows.UI.Composition.IVisualCollection
  IVisualCollection = interface;
  PIVisualCollection = ^IVisualCollection;

  // Windows.UI.Composition.IContainerVisual
  IContainerVisual = interface;
  PIContainerVisual = ^IContainerVisual;

  // Windows.UI.Composition.ICubicBezierEasingFunction
  ICubicBezierEasingFunction = interface;
  PICubicBezierEasingFunction = ^ICubicBezierEasingFunction;

  // Windows.UI.Composition.ICompositionSurface
  ICompositionSurface = interface;
  PICompositionSurface = ^ICompositionSurface;

  // Windows.UI.Composition.ICompositionEffect
  ICompositionEffect = interface;
  PICompositionEffect = ^ICompositionEffect;

  // Windows.UI.Composition.ICompositionEffectFactoryLoadResult
  ICompositionEffectFactoryLoadResult = interface;
  PICompositionEffectFactoryLoadResult = ^ICompositionEffectFactoryLoadResult;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Composition.ICompositionEffectFactoryLoadResult>
  AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult = interface;
  PAsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult = ^AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult;

  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Composition.ICompositionEffectFactoryLoadResult>
  IAsyncOperation_1__ICompositionEffectFactoryLoadResult = interface;
  PIAsyncOperation_1__ICompositionEffectFactoryLoadResult = ^IAsyncOperation_1__ICompositionEffectFactoryLoadResult;

  // Windows.UI.Composition.ICompositionEffectFactory
  ICompositionEffectFactory = interface;
  PICompositionEffectFactory = ^ICompositionEffectFactory;

  // Windows.UI.Composition.IEffectVisual
  IEffectVisual = interface;
  PIEffectVisual = ^IEffectVisual;

  // Windows.UI.Composition.IExpressionAnimation
  IExpressionAnimation = interface;
  PIExpressionAnimation = ^IExpressionAnimation;

  // Windows.UI.Composition.IImageVisual
  IImageVisual = interface;
  PIImageVisual = ^IImageVisual;

  // Windows.UI.Composition.IInsetClip
  IInsetClip = interface;
  PIInsetClip = ^IInsetClip;

  // Windows.UI.Composition.ILinearEasingFunction
  ILinearEasingFunction = interface;
  PILinearEasingFunction = ^ILinearEasingFunction;

  // Windows.UI.Composition.ICompositionPropertySet
  ICompositionPropertySet = interface;
  PICompositionPropertySet = ^ICompositionPropertySet;

  // Windows.UI.Composition.ICompositionEasingFunction
  ICompositionEasingFunction = interface;
  PICompositionEasingFunction = ^ICompositionEasingFunction;

  // Windows.UI.Composition.IScalarKeyFrameAnimation
  IScalarKeyFrameAnimation = interface;
  PIScalarKeyFrameAnimation = ^IScalarKeyFrameAnimation;

  // Windows.UI.Composition.ISolidColorVisual
  ISolidColorVisual = interface;
  PISolidColorVisual = ^ISolidColorVisual;

  // Windows.UI.Composition.ICompositionTarget
  ICompositionTarget = interface;
  PICompositionTarget = ^ICompositionTarget;

  // Windows.UI.Composition.IVector2KeyFrameAnimation
  IVector2KeyFrameAnimation = interface;
  PIVector2KeyFrameAnimation = ^IVector2KeyFrameAnimation;

  // Windows.UI.Composition.IVector3KeyFrameAnimation
  IVector3KeyFrameAnimation = interface;
  PIVector3KeyFrameAnimation = ^IVector3KeyFrameAnimation;

  // Windows.UI.Composition.IVector4KeyFrameAnimation
  IVector4KeyFrameAnimation = interface;
  PIVector4KeyFrameAnimation = ^IVector4KeyFrameAnimation;

  // Windows.UI.Composition.ICompositor
  ICompositor = interface;
  PICompositor = ^ICompositor;

  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Composition.ICompositionPropertyAnimator,Windows.UI.Composition.IAnimationEndedEventArgs>
  TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs = interface;
  PTypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs = ^TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs;

  // Windows.UI.Composition.ICompositionPropertyAnimator
  ICompositionPropertyAnimator = interface;
  PICompositionPropertyAnimator = ^ICompositionPropertyAnimator;

  // Windows.UI.Composition.ICompositionObject
  ICompositionObject = interface;
  PICompositionObject = ^ICompositionObject;

  // Windows.UI.Composition.ICompositionAnimation
  ICompositionAnimation = interface;
  PICompositionAnimation = ^ICompositionAnimation;

  // Windows.UI.Composition.ICompositionEffectSourceParameter
  ICompositionEffectSourceParameter = interface;
  PICompositionEffectSourceParameter = ^ICompositionEffectSourceParameter;

  // Windows.UI.Composition.ICompositionEffectSourceParameterFactory
  ICompositionEffectSourceParameterFactory = interface;
  PICompositionEffectSourceParameterFactory = ^ICompositionEffectSourceParameterFactory;

  // Windows.UI.Composition.IKeyFrameAnimation
  IKeyFrameAnimation = interface;
  PIKeyFrameAnimation = ^IKeyFrameAnimation;

  // Windows.UI.Composition.ICompositionAnimationFactory
  ICompositionAnimationFactory = interface;
  PICompositionAnimationFactory = ^ICompositionAnimationFactory;

  // Windows.UI.Composition.ICompositionClipFactory
  ICompositionClipFactory = interface;
  PICompositionClipFactory = ^ICompositionClipFactory;

  // Windows.UI.Composition.ICompositionEasingFunctionFactory
  ICompositionEasingFunctionFactory = interface;
  PICompositionEasingFunctionFactory = ^ICompositionEasingFunctionFactory;

  // Windows.UI.Composition.ICompositionObjectFactory
  ICompositionObjectFactory = interface;
  PICompositionObjectFactory = ^ICompositionObjectFactory;

  // Windows.UI.Composition.IContainerVisualFactory
  IContainerVisualFactory = interface;
  PIContainerVisualFactory = ^IContainerVisualFactory;

  // Windows.UI.Composition.IKeyFrameAnimationFactory
  IKeyFrameAnimationFactory = interface;
  PIKeyFrameAnimationFactory = ^IKeyFrameAnimationFactory;

  // Windows.UI.Composition.IVisualFactory
  IVisualFactory = interface;
  PIVisualFactory = ^IVisualFactory;


  // Emit Forwarded interfaces
  // Windows.UI.Composition Interfaces
  // DualAPI Interface
  // Windows.UI.Composition.IAnimationEndedEventArgs
  [WinRTClassNameAttribute(SAnimationEndedEventArgs)]
  IAnimationEndedEventArgs = interface(IInspectable)
  ['{2D4ECD9B-47D6-4201-9237-42FF1F25B045}']
    function get_ActualEndReason: AnimationEndReason; safecall;
    property ActualEndReason: AnimationEndReason read get_ActualEndReason;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionImageLoadResult
  [WinRTClassNameAttribute(SCompositionImageLoadResult)]
  ICompositionImageLoadResult = interface(IInspectable)
  ['{C6EC450B-4D45-4040-866A-0F71A785A6E7}']
    function get_ExtendedError: HRESULT; safecall;
    function get_Status: CompositionImageLoadStatus; safecall;
    property ExtendedError: HRESULT read get_ExtendedError;
    property Status: CompositionImageLoadStatus read get_Status;
  end;

  // Windows.Foundation.AsyncOperationProgressHandler`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface(IUnknown)
  ['{CC6612A2-D860-53B1-B98C-3AC71D7EFA71}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage; progressInfo: CompositionImageProgressStage); safecall;
  end;

  // Windows.Foundation.AsyncOperationWithProgressCompletedHandler`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface(IUnknown)
  ['{910C4A0D-EF0E-58EA-A9F8-D4B7EF670986}']
    procedure Invoke(asyncInfo: IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperationWithProgress`2<Windows.UI.Composition.ICompositionImageLoadResult,Windows.UI.Composition.CompositionImageProgressStage>
  IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage = interface(IInspectable)
  ['{8460435A-9EC4-533C-82F7-FD229FF1EACA}']
    procedure put_Progress(handler: AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage); safecall;
    function get_Progress: AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage; safecall;
    procedure put_Completed(handler: AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage); safecall;
    function get_Completed: AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage; safecall;
    function GetResults: ICompositionImageLoadResult; safecall;
    property Progress: AsyncOperationProgressHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage read get_Progress write put_Progress;
    property Completed: AsyncOperationWithProgressCompletedHandler_2__ICompositionImageLoadResult__CompositionImageProgressStage read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionImage
  [WinRTClassNameAttribute(SCompositionImage)]
  ICompositionImage = interface(IInspectable)
  ['{7FD7856F-8077-45B1-AE2B-B55D1678E62B}']
    function get_Size: TSizeF; safecall;
    function CompleteLoadAsync: IAsyncOperationWithProgress_2__ICompositionImageLoadResult__CompositionImageProgressStage; safecall;
    property Size: TSizeF read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionImageOptions
  [WinRTClassNameAttribute(SCompositionImageOptions)]
  ICompositionImageOptions = interface(IInspectable)
  ['{F4FD3A1B-C37E-47C1-9DC4-AE6F9F079AC2}']
    function get_DecodeWidth: Integer; safecall;
    procedure put_DecodeWidth(value: Integer); safecall;
    function get_DecodeHeight: Integer; safecall;
    procedure put_DecodeHeight(value: Integer); safecall;
    property DecodeHeight: Integer read get_DecodeHeight write put_DecodeHeight;
    property DecodeWidth: Integer read get_DecodeWidth write put_DecodeWidth;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionGraphicsDevice
  [WinRTClassNameAttribute(SCompositionGraphicsDevice)]
  ICompositionGraphicsDevice = interface(IInspectable)
  ['{6BDA3863-7BD2-4DB8-87B4-7EB7A4357E2C}']
    function CreateImageFromUri(uri: IUriRuntimeClass): ICompositionImage; overload; safecall;
    function CreateImageFromUri(uri: IUriRuntimeClass; options: ICompositionImageOptions): ICompositionImage; overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionClip
  [WinRTClassNameAttribute(SCompositionClip)]
  ICompositionClip = interface(IInspectable)
  ['{38FEC7AD-D25F-41F3-828F-F6D25C864AA6}']
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IVisual
  [WinRTClassNameAttribute(SVisual)]
  IVisual = interface(IInspectable)
  ['{3B432316-F36F-4904-8797-2B2326C31626}']
    function get_CenterPoint: Numerics_Vector3; safecall;
    procedure put_CenterPoint(value: Numerics_Vector3); safecall;
    function get_Clip: ICompositionClip; safecall;
    procedure put_Clip(value: ICompositionClip); safecall;
    function get_Offset: Numerics_Vector3; safecall;
    procedure put_Offset(value: Numerics_Vector3); safecall;
    function get_Opacity: Single; safecall;
    procedure put_Opacity(value: Single); safecall;
    function get_Orientation: Numerics_Quaternion; safecall;
    procedure put_Orientation(value: Numerics_Quaternion); safecall;
    function get_Parent: IContainerVisual; safecall;
    function get_RotationAngle: Single; safecall;
    procedure put_RotationAngle(value: Single); safecall;
    function get_RotationAxis: Numerics_Vector3; safecall;
    procedure put_RotationAxis(value: Numerics_Vector3); safecall;
    function get_Scale: Numerics_Vector3; safecall;
    procedure put_Scale(value: Numerics_Vector3); safecall;
    function get_Size: Numerics_Vector2; safecall;
    procedure put_Size(value: Numerics_Vector2); safecall;
    function get_TransformMatrix: Numerics_Matrix4x4; safecall;
    procedure put_TransformMatrix(value: Numerics_Matrix4x4); safecall;
    property CenterPoint: Numerics_Vector3 read get_CenterPoint write put_CenterPoint;
    property Clip: ICompositionClip read get_Clip write put_Clip;
    property Offset: Numerics_Vector3 read get_Offset write put_Offset;
    property Opacity: Single read get_Opacity write put_Opacity;
    property Orientation: Numerics_Quaternion read get_Orientation write put_Orientation;
    property Parent: IContainerVisual read get_Parent;
    property RotationAngle: Single read get_RotationAngle write put_RotationAngle;
    property RotationAxis: Numerics_Vector3 read get_RotationAxis write put_RotationAxis;
    property Scale: Numerics_Vector3 read get_Scale write put_Scale;
    property Size: Numerics_Vector2 read get_Size write put_Size;
    property TransformMatrix: Numerics_Matrix4x4 read get_TransformMatrix write put_TransformMatrix;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Composition.IVisual>
  IIterator_1__IVisual = interface(IInspectable)
  ['{2EED39F4-A3EB-5854-850B-DBB09497B6C7}']
    function get_Current: IVisual; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PIVisual): Cardinal; safecall;
    property Current: IVisual read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Generic Ancestor for 
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Composition.IVisual>
  IIterable_1__IVisual_Base = interface(IInspectable)
  ['{F9B2FB2B-B244-5175-9D09-6B592ABC7EAD}']
  end;
  // DualAPI Interface
  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Composition.IVisual>
  IIterable_1__IVisual = interface(IIterable_1__IVisual_Base)
  ['{89679A21-F1F6-5CEF-9569-4E776AED8908}']
    function First: IIterator_1__IVisual; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IVisualCollection
  [WinRTClassNameAttribute(SVisualCollection)]
  IVisualCollection = interface(IInspectable)
  ['{0E26A5AF-ECDF-497B-A081-25B3FC9A9EEA}']
    function get_Count: Integer; safecall;
    procedure InsertAbove(newChild: IVisual; sibling: IVisual); safecall;
    procedure InsertAtBottom(newChild: IVisual); safecall;
    procedure InsertAtTop(newChild: IVisual); safecall;
    procedure InsertBelow(newChild: IVisual; sibling: IVisual); safecall;
    procedure Remove(child: IVisual); safecall;
    procedure RemoveAll; safecall;
    property Count: Integer read get_Count;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IContainerVisual
  [WinRTClassNameAttribute(SContainerVisual)]
  IContainerVisual = interface(IInspectable)
  ['{60191509-0B6E-41A1-B564-C7FB90115EEE}']
    function get_Children: IVisualCollection; safecall;
    property Children: IVisualCollection read get_Children;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICubicBezierEasingFunction
  [WinRTClassNameAttribute(SCubicBezierEasingFunction)]
  ICubicBezierEasingFunction = interface(IInspectable)
  ['{A4D9C792-DBB9-4559-9548-336C9BBC6E60}']
    function get_ControlPoint1: Numerics_Vector2; safecall;
    function get_ControlPoint2: Numerics_Vector2; safecall;
    property ControlPoint1: Numerics_Vector2 read get_ControlPoint1;
    property ControlPoint2: Numerics_Vector2 read get_ControlPoint2;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionSurface
  ICompositionSurface = interface(IInspectable)
  ['{B2A77623-3F4E-40FA-A26A-64366B1F281D}']
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEffect
  [WinRTClassNameAttribute(SCompositionEffect)]
  ICompositionEffect = interface(IInspectable)
  ['{35170320-91C3-4E89-9C98-928F9919BEFD}']
    function GetSourceParameter(name: HSTRING): ICompositionSurface; safecall;
    procedure SetSourceParameter(name: HSTRING; source: ICompositionSurface); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEffectFactoryLoadResult
  [WinRTClassNameAttribute(SCompositionEffectFactoryLoadResult)]
  ICompositionEffectFactoryLoadResult = interface(IInspectable)
  ['{14DFDFCD-B1B8-42AE-B646-5181EF563ACB}']
    function get_ExtendedError: HRESULT; safecall;
    function get_Status: CompositionEffectFactoryLoadStatus; safecall;
    property ExtendedError: HRESULT read get_ExtendedError;
    property Status: CompositionEffectFactoryLoadStatus read get_Status;
  end;

  // Windows.Foundation.AsyncOperationCompletedHandler`1<Windows.UI.Composition.ICompositionEffectFactoryLoadResult>
  AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult = interface(IUnknown)
  ['{95F00499-555F-5FD2-A651-87FC1290DFC1}']
    procedure Invoke(asyncInfo: IAsyncOperation_1__ICompositionEffectFactoryLoadResult; asyncStatus: AsyncStatus); safecall;
  end;

  // Windows.Foundation.IAsyncOperation`1<Windows.UI.Composition.ICompositionEffectFactoryLoadResult>
  IAsyncOperation_1__ICompositionEffectFactoryLoadResult = interface(IInspectable)
  ['{7D240BDA-BFAA-5DF8-ADB0-B599D1D0A75E}']
    procedure put_Completed(handler: AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult); safecall;
    function get_Completed: AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult; safecall;
    function GetResults: ICompositionEffectFactoryLoadResult; safecall;
    property Completed: AsyncOperationCompletedHandler_1__ICompositionEffectFactoryLoadResult read get_Completed write put_Completed;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEffectFactory
  [WinRTClassNameAttribute(SCompositionEffectFactory)]
  ICompositionEffectFactory = interface(IInspectable)
  ['{6BEDAE71-D5BE-4B25-A672-776EEA024D07}']
    function CreateEffect: ICompositionEffect; safecall;
    function CompleteLoadAsync: IAsyncOperation_1__ICompositionEffectFactoryLoadResult; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IEffectVisual
  [WinRTClassNameAttribute(SEffectVisual)]
  IEffectVisual = interface(IInspectable)
  ['{7A067471-8A80-4F17-8283-9B90310C5744}']
    function get_Effect: ICompositionEffect; safecall;
    procedure put_Effect(value: ICompositionEffect); safecall;
    property Effect: ICompositionEffect read get_Effect write put_Effect;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IExpressionAnimation
  [WinRTClassNameAttribute(SExpressionAnimation)]
  IExpressionAnimation = interface(IInspectable)
  ['{72854C04-20B5-486B-AD9E-0F51252B6FFC}']
    function get_Expression: HSTRING; safecall;
    procedure put_Expression(value: HSTRING); safecall;
    property Expression: HSTRING read get_Expression write put_Expression;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IImageVisual
  [WinRTClassNameAttribute(SImageVisual)]
  IImageVisual = interface(IInspectable)
  ['{F2FBA317-218E-4830-857A-EA71DE874E44}']
    function get_HorizontalAlignmentRatio: Single; safecall;
    procedure put_HorizontalAlignmentRatio(value: Single); safecall;
    function get_Image: ICompositionSurface; safecall;
    procedure put_Image(value: ICompositionSurface); safecall;
    function get_Stretch: CompositionStretch; safecall;
    procedure put_Stretch(value: CompositionStretch); safecall;
    function get_VerticalAlignmentRatio: Single; safecall;
    procedure put_VerticalAlignmentRatio(value: Single); safecall;
    property HorizontalAlignmentRatio: Single read get_HorizontalAlignmentRatio write put_HorizontalAlignmentRatio;
    property Image: ICompositionSurface read get_Image write put_Image;
    property Stretch: CompositionStretch read get_Stretch write put_Stretch;
    property VerticalAlignmentRatio: Single read get_VerticalAlignmentRatio write put_VerticalAlignmentRatio;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IInsetClip
  [WinRTClassNameAttribute(SInsetClip)]
  IInsetClip = interface(IInspectable)
  ['{7C77E042-4F79-4F7C-82A0-663C567CCB23}']
    function get_BottomInset: Single; safecall;
    procedure put_BottomInset(value: Single); safecall;
    function get_LeftInset: Single; safecall;
    procedure put_LeftInset(value: Single); safecall;
    function get_RightInset: Single; safecall;
    procedure put_RightInset(value: Single); safecall;
    function get_TopInset: Single; safecall;
    procedure put_TopInset(value: Single); safecall;
    property BottomInset: Single read get_BottomInset write put_BottomInset;
    property LeftInset: Single read get_LeftInset write put_LeftInset;
    property RightInset: Single read get_RightInset write put_RightInset;
    property TopInset: Single read get_TopInset write put_TopInset;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ILinearEasingFunction
  [WinRTClassNameAttribute(SLinearEasingFunction)]
  ILinearEasingFunction = interface(IInspectable)
  ['{6EA74588-3AB1-4CDE-8C67-4162C2D92E29}']
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionPropertySet
  [WinRTClassNameAttribute(SCompositionPropertySet)]
  ICompositionPropertySet = interface(IInspectable)
  ['{B3962778-2C20-421D-983B-3D5A9A69F614}']
    procedure InsertMatrix3x2(propertyName: HSTRING; value: Numerics_Matrix3x2); safecall;
    procedure InsertMatrix4x4(propertyName: HSTRING; value: Numerics_Matrix4x4); safecall;
    procedure InsertScalar(propertyName: HSTRING; value: Single); safecall;
    procedure InsertVector2(propertyName: HSTRING; value: Numerics_Vector2); safecall;
    procedure InsertVector3(propertyName: HSTRING; value: Numerics_Vector3); safecall;
    procedure InsertVector4(propertyName: HSTRING; value: Numerics_Vector4); safecall;
    function TryGetMatrix3x2(propertyName: HSTRING; out value: Numerics_Matrix3x2): CompositionGetValueStatus; safecall;
    function TryGetMatrix4x4(propertyName: HSTRING; out value: Numerics_Matrix4x4): CompositionGetValueStatus; safecall;
    function TryGetScalar(propertyName: HSTRING; out value: Single): CompositionGetValueStatus; safecall;
    function TryGetVector2(propertyName: HSTRING; out value: Numerics_Vector2): CompositionGetValueStatus; safecall;
    function TryGetVector3(propertyName: HSTRING; out value: Numerics_Vector3): CompositionGetValueStatus; safecall;
    function TryGetVector4(propertyName: HSTRING; out value: Numerics_Vector4): CompositionGetValueStatus; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEasingFunction
  [WinRTClassNameAttribute(SCompositionEasingFunction)]
  ICompositionEasingFunction = interface(IInspectable)
  ['{17EAB812-0BAD-4D2D-BAE2-43FD7B4D071F}']
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IScalarKeyFrameAnimation
  [WinRTClassNameAttribute(SScalarKeyFrameAnimation)]
  IScalarKeyFrameAnimation = interface(IInspectable)
  ['{4B670259-698E-4285-9D39-9DEE83578A50}']
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Single); overload; safecall;
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Single; easingFunction: ICompositionEasingFunction); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ISolidColorVisual
  [WinRTClassNameAttribute(SSolidColorVisual)]
  ISolidColorVisual = interface(IInspectable)
  ['{B83979A7-7865-411D-AC87-336DD1AC39DC}']
    function get_Color: Color; safecall;
    procedure put_Color(value: Color); safecall;
    property Color: Color read get_Color write put_Color;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionTarget
  [WinRTClassNameAttribute(SCompositionTarget)]
  ICompositionTarget = interface(IInspectable)
  ['{CA8116F8-D203-4EA0-A7CB-62D4A3A9E274}']
    function get_Root: IVisual; safecall;
    procedure put_Root(value: IVisual); safecall;
    property Root: IVisual read get_Root write put_Root;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IVector2KeyFrameAnimation
  [WinRTClassNameAttribute(SVector2KeyFrameAnimation)]
  IVector2KeyFrameAnimation = interface(IInspectable)
  ['{FE7974E6-D9F6-4216-B9E5-5B53617EB399}']
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector2); overload; safecall;
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector2; easingFunction: ICompositionEasingFunction); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IVector3KeyFrameAnimation
  [WinRTClassNameAttribute(SVector3KeyFrameAnimation)]
  IVector3KeyFrameAnimation = interface(IInspectable)
  ['{C41DD554-E744-4624-9AA5-A22BC2D5200E}']
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector3); overload; safecall;
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector3; easingFunction: ICompositionEasingFunction); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IVector4KeyFrameAnimation
  [WinRTClassNameAttribute(SVector4KeyFrameAnimation)]
  IVector4KeyFrameAnimation = interface(IInspectable)
  ['{753D5A87-C318-4D1D-BA59-2F90AAED2AC9}']
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector4); overload; safecall;
    procedure InsertKeyFrame(normalizedProgressKey: Single; value: Numerics_Vector4; easingFunction: ICompositionEasingFunction); overload; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositor
  [WinRTClassNameAttribute(SCompositor)]
  ICompositor = interface(IInspectable)
  ['{89DF0836-6FA5-41FD-ABA2-B07D63AC1712}']
    function get_DefaultGraphicsDevice: ICompositionGraphicsDevice; safecall;
    function CreateContainerVisual: IContainerVisual; safecall;
    function CreateCubicBezierEasingFunction(controlPoint1: Numerics_Vector2; controlPoint2: Numerics_Vector2): ICubicBezierEasingFunction; safecall;
    function CreateEffectFactory(graphicsEffect: Effects_IGraphicsEffect): ICompositionEffectFactory; overload; safecall;
    function CreateEffectFactory(graphicsEffect: Effects_IGraphicsEffect; animatableProperties: IIterable_1__HSTRING): ICompositionEffectFactory; overload; safecall;
    function CreateEffectVisual: IEffectVisual; safecall;
    function CreateExpressionAnimation: IExpressionAnimation; overload; safecall;
    function CreateExpressionAnimation(expression: HSTRING): IExpressionAnimation; overload; safecall;
    function CreateImageVisual: IImageVisual; safecall;
    function CreateInsetClip: IInsetClip; overload; safecall;
    function CreateInsetClip(leftInset: Single; topInset: Single; rightInset: Single; bottomInset: Single): IInsetClip; overload; safecall;
    function CreateLinearEasingFunction: ILinearEasingFunction; safecall;
    function CreatePropertySet: ICompositionPropertySet; safecall;
    function CreateScalarKeyFrameAnimation: IScalarKeyFrameAnimation; safecall;
    function CreateSolidColorVisual: ISolidColorVisual; safecall;
    function CreateTargetForCurrentView: ICompositionTarget; safecall;
    function CreateVector2KeyFrameAnimation: IVector2KeyFrameAnimation; safecall;
    function CreateVector3KeyFrameAnimation: IVector3KeyFrameAnimation; safecall;
    function CreateVector4KeyFrameAnimation: IVector4KeyFrameAnimation; safecall;
    property DefaultGraphicsDevice: ICompositionGraphicsDevice read get_DefaultGraphicsDevice;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Composition.ICompositionPropertyAnimator,Windows.UI.Composition.IAnimationEndedEventArgs>
  TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs_Delegate_Base = interface(IUnknown)
  ['{F525BB2B-323A-5EA7-9208-9D28EEAFA92E}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Windows.UI.Composition.ICompositionPropertyAnimator,Windows.UI.Composition.IAnimationEndedEventArgs>
  TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs = interface(TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs_Delegate_Base)
  ['{BB2E0192-9C56-5A3D-9A7A-79FAB48792CA}']
    procedure Invoke(sender: ICompositionPropertyAnimator; args: IAnimationEndedEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionPropertyAnimator
  [WinRTClassNameAttribute(SCompositionPropertyAnimator)]
  ICompositionPropertyAnimator = interface(IInspectable)
  ['{D74137CC-C0A4-43F0-A2B7-0E19CD2A69F5}']
    function add_AnimationEnded(handler: TypedEventHandler_2__ICompositionPropertyAnimator__IAnimationEndedEventArgs): EventRegistrationToken; safecall;
    procedure remove_AnimationEnded(token: EventRegistrationToken); safecall;
    procedure Pause; safecall;
    procedure Start; safecall;
    procedure Stop; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionObject
  [WinRTClassNameAttribute(SCompositionObject)]
  ICompositionObject = interface(IInspectable)
  ['{8F6BB0F6-B8F9-4C67-85F2-D862D70D33A8}']
    function get_Compositor: ICompositor; safecall;
    function get_Dispatcher: ICoreDispatcher; safecall;
    function get_Properties: ICompositionPropertySet; safecall;
    function ConnectAnimation(propertyName: HSTRING; animation: ICompositionAnimation): ICompositionPropertyAnimator; safecall;
    procedure DisconnectAnimation(propertyName: HSTRING); safecall;
    property Compositor: ICompositor read get_Compositor;
    property Dispatcher: ICoreDispatcher read get_Dispatcher;
    property Properties: ICompositionPropertySet read get_Properties;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionAnimation
  [WinRTClassNameAttribute(SCompositionAnimation)]
  ICompositionAnimation = interface(IInspectable)
  ['{93AC9D77-6B74-4960-A4B8-F274248487AE}']
    procedure ClearAllParameters; safecall;
    procedure ClearParameter(key: HSTRING); safecall;
    procedure SetMatrix3x2Parameter(key: HSTRING; value: Numerics_Matrix3x2); safecall;
    procedure SetMatrix4x4Parameter(key: HSTRING; value: Numerics_Matrix4x4); safecall;
    procedure SetReferenceParameter(key: HSTRING; compositionObject: ICompositionObject); safecall;
    procedure SetScalarParameter(key: HSTRING; value: Single); safecall;
    procedure SetVector2Parameter(key: HSTRING; value: Numerics_Vector2); safecall;
    procedure SetVector3Parameter(key: HSTRING; value: Numerics_Vector3); safecall;
    procedure SetVector4Parameter(key: HSTRING; value: Numerics_Vector4); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEffectSourceParameter
  [WinRTClassNameAttribute(SCompositionEffectSourceParameter)]
  ICompositionEffectSourceParameter = interface(IInspectable)
  ['{515F6E87-1874-47F7-95D9-BD381E13618C}']
    function get_Name: HSTRING; safecall;
    property Name: HSTRING read get_Name;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.ICompositionEffectSourceParameterFactory
  [WinRTClassNameAttribute(SCompositionEffectSourceParameter)]
  ICompositionEffectSourceParameterFactory = interface(IInspectable)
  ['{A2977915-62D1-4A10-93B4-42F14D248057}']
    function Create(name: HSTRING): ICompositionEffectSourceParameter; safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Composition.IKeyFrameAnimation
  [WinRTClassNameAttribute(SKeyFrameAnimation)]
  IKeyFrameAnimation = interface(IInspectable)
  ['{0F3E5983-D4A8-4B6A-88AE-A758ADE19EEC}']
    function get_DelayTime: TimeSpan; safecall;
    procedure put_DelayTime(value: TimeSpan); safecall;
    function get_Duration: TimeSpan; safecall;
    procedure put_Duration(value: TimeSpan); safecall;
    function get_IterationBehavior: AnimationIterationBehavior; safecall;
    procedure put_IterationBehavior(value: AnimationIterationBehavior); safecall;
    function get_IterationCount: Integer; safecall;
    procedure put_IterationCount(value: Integer); safecall;
    function get_KeyFrameCount: Integer; safecall;
    function get_StopBehavior: AnimationStopBehavior; safecall;
    procedure put_StopBehavior(value: AnimationStopBehavior); safecall;
    procedure InsertExpressionKeyFrame(normalizedProgressKey: Single; value: HSTRING); overload; safecall;
    procedure InsertExpressionKeyFrame(normalizedProgressKey: Single; value: HSTRING; easingFunction: ICompositionEasingFunction); overload; safecall;
    property DelayTime: TimeSpan read get_DelayTime write put_DelayTime;
    property Duration: TimeSpan read get_Duration write put_Duration;
    property IterationBehavior: AnimationIterationBehavior read get_IterationBehavior write put_IterationBehavior;
    property IterationCount: Integer read get_IterationCount write put_IterationCount;
    property KeyFrameCount: Integer read get_KeyFrameCount;
    property StopBehavior: AnimationStopBehavior read get_StopBehavior write put_StopBehavior;
  end;

  // Windows.UI.Composition.ICompositionAnimationFactory
  ICompositionAnimationFactory = interface(IInspectable)
  ['{918F4415-C8CB-4251-9BEA-F2C9EE22B2B3}']
  end;

  // Windows.UI.Composition.ICompositionClipFactory
  ICompositionClipFactory = interface(IInspectable)
  ['{788C0D0A-13C1-4FAC-9B20-FDDD316D76AB}']
  end;

  // Windows.UI.Composition.ICompositionEasingFunctionFactory
  ICompositionEasingFunctionFactory = interface(IInspectable)
  ['{FD5B13AB-3F9D-4F6C-AD97-976D864F2815}']
  end;

  // Windows.UI.Composition.ICompositionObjectFactory
  ICompositionObjectFactory = interface(IInspectable)
  ['{124AF11C-E4DD-4048-92F6-CFD86F8723C2}']
  end;

  // Windows.UI.Composition.IContainerVisualFactory
  IContainerVisualFactory = interface(IInspectable)
  ['{E562C939-9A17-45B9-81F3-16F486A354E6}']
  end;

  // Windows.UI.Composition.IKeyFrameAnimationFactory
  IKeyFrameAnimationFactory = interface(IInspectable)
  ['{2BEE8642-BC63-4E3B-83F2-01E914C6679E}']
  end;

  // Windows.UI.Composition.IVisualFactory
  IVisualFactory = interface(IInspectable)
  ['{3A0F240A-C92E-49CF-82B4-8E57CBEA2EDE}']
  end;


  // Emit Forwarded classes
  // Windows.UI.Composition.CompositionObject
  // DualAPI

  // Windows.UI.Composition.CompositionEffect
  // DualAPI

  // Windows.UI.Composition.CompositionEffectFactoryLoadResult
  // DualAPI

  // Windows.UI.Composition.CompositionEffectSourceParameter
  // DualAPI
  TCompositionEffectSourceParameter = class(TWinRTGenericImportF<ICompositionEffectSourceParameterFactory>)
  public
    // -> ICompositionEffectSourceParameterFactory
    class function Create(name: HSTRING): ICompositionEffectSourceParameter; static; inline;
  end;

  // Windows.UI.Composition.CompositionImageOptions
  // DualAPI
  TCompositionImageOptions = class(TWinRTGenericImportI<ICompositionImageOptions>) end;

  // Windows.UI.Composition.CompositionImage
  // DualAPI

  // Windows.UI.Composition.CompositionImageLoadResult
  // DualAPI

  // Windows.UI.Composition.Compositor
  // DualAPI
  TCompositor = class(TWinRTGenericImportI<ICompositor>) end;

  // Windows.UI.Composition.CompositionAnimation
  // DualAPI

  // Windows.UI.Composition.CompositionPropertyAnimator
  // DualAPI

  // Windows.UI.Composition.AnimationEndedEventArgs
  // DualAPI

  // Windows.UI.Composition.CompositionPropertySet
  // DualAPI

  // Windows.UI.Composition.CompositionGraphicsDevice
  // DualAPI

  // Windows.UI.Composition.CompositionEffectFactory
  // DualAPI

  // Windows.UI.Composition.CompositionTarget
  // DualAPI

  // Windows.UI.Composition.ExpressionAnimation
  // DualAPI

  // Windows.UI.Composition.CompositionEasingFunction
  // DualAPI

  // Windows.UI.Composition.CubicBezierEasingFunction
  // DualAPI

  // Windows.UI.Composition.LinearEasingFunction
  // DualAPI

  // Windows.UI.Composition.Visual
  // DualAPI

  // Windows.UI.Composition.ContainerVisual
  // DualAPI

  // Windows.UI.Composition.EffectVisual
  // DualAPI

  // Windows.UI.Composition.ImageVisual
  // DualAPI

  // Windows.UI.Composition.SolidColorVisual
  // DualAPI

  // Windows.UI.Composition.CompositionClip
  // DualAPI

  // Windows.UI.Composition.InsetClip
  // DualAPI

  // Windows.UI.Composition.VisualCollection
  // DualAPI

  // Windows.UI.Composition.KeyFrameAnimation
  // DualAPI

  // Windows.UI.Composition.ScalarKeyFrameAnimation
  // DualAPI

  // Windows.UI.Composition.Vector2KeyFrameAnimation
  // DualAPI

  // Windows.UI.Composition.Vector3KeyFrameAnimation
  // DualAPI

  // Windows.UI.Composition.Vector4KeyFrameAnimation
  // DualAPI


implementation

  // Emit Classes Implementation
 { TCompositionEffectSourceParameter }
// Factories for : "CompositionEffectSourceParameter"
// Factory: "Windows.UI.Composition.ICompositionEffectSourceParameterFactory"
// -> ICompositionEffectSourceParameterFactory

class function TCompositionEffectSourceParameter.Create(name: HSTRING): ICompositionEffectSourceParameter;
begin
  Result := Factory.Create(name);
end;


 { TCompositionImageOptions }

 { TCompositor }


end.
