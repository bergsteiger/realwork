{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.UI.Core;

{$HPPEMIT NOUSINGNAMESPACE}

{$WARN SYMBOL_DEPRECATED OFF}

interface

uses 
  // Fixed Uses...
  Winapi.UI.Input,
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
  // Windows.UI.Core Class Names
  // Windows.UI.Core.AnimationMetrics.AnimationDescription
  // DualAPI
  SAnimationMetrics_AnimationDescription = 'Windows.UI.Core.AnimationMetrics.AnimationDescription';
  // Windows.UI.Core.AnimationMetrics.PropertyAnimation
  // DualAPI
  SAnimationMetrics_PropertyAnimation = 'Windows.UI.Core.AnimationMetrics.PropertyAnimation';
  // Windows.UI.Core.AnimationMetrics.ScaleAnimation
  // DualAPI
  SAnimationMetrics_ScaleAnimation = 'Windows.UI.Core.AnimationMetrics.ScaleAnimation';
  // Windows.UI.Core.AnimationMetrics.TranslationAnimation
  // DualAPI
  SAnimationMetrics_TranslationAnimation = 'Windows.UI.Core.AnimationMetrics.TranslationAnimation';
  // Windows.UI.Core.AnimationMetrics.OpacityAnimation
  // DualAPI
  SAnimationMetrics_OpacityAnimation = 'Windows.UI.Core.AnimationMetrics.OpacityAnimation';


type
  // Forward declare interfaces
  // Windows.UI.Core.DispatchedHandler
  DispatchedHandler = interface;
  PDispatchedHandler = ^DispatchedHandler;

  // Windows.UI.Core.IIdleDispatchedHandlerArgs
  IIdleDispatchedHandlerArgs = interface;
  PIIdleDispatchedHandlerArgs = ^IIdleDispatchedHandlerArgs;

  // Windows.UI.Core.IdleDispatchedHandler
  IdleDispatchedHandler = interface;
  PIdleDispatchedHandler = ^IdleDispatchedHandler;

  // Windows.UI.Core.ICoreDispatcher
  ICoreDispatcher = interface;
  PICoreDispatcher = ^ICoreDispatcher;

  // Windows.UI.Core.IPointerEventArgs
  IPointerEventArgs = interface;
  PIPointerEventArgs = ^IPointerEventArgs;

  // Windows.Foundation.TypedEventHandler`2<Object,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInspectable__IPointerEventArgs = interface;
  PTypedEventHandler_2__IInspectable__IPointerEventArgs = ^TypedEventHandler_2__IInspectable__IPointerEventArgs;

  // Windows.UI.Core.AnimationMetrics.IPropertyAnimation
  AnimationMetrics_IPropertyAnimation = interface;
  PAnimationMetrics_IPropertyAnimation = ^AnimationMetrics_IPropertyAnimation;

  // Windows.UI.Core.AnimationMetrics.IScaleAnimation
  AnimationMetrics_IScaleAnimation = interface;
  PAnimationMetrics_IScaleAnimation = ^AnimationMetrics_IScaleAnimation;

  // Windows.UI.Core.AnimationMetrics.IOpacityAnimation
  AnimationMetrics_IOpacityAnimation = interface;
  PAnimationMetrics_IOpacityAnimation = ^AnimationMetrics_IOpacityAnimation;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IIterator_1__AnimationMetrics_IPropertyAnimation = interface;
  PIIterator_1__AnimationMetrics_IPropertyAnimation = ^IIterator_1__AnimationMetrics_IPropertyAnimation;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IIterable_1__AnimationMetrics_IPropertyAnimation = interface;
  PIIterable_1__AnimationMetrics_IPropertyAnimation = ^IIterable_1__AnimationMetrics_IPropertyAnimation;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IVectorView_1__AnimationMetrics_IPropertyAnimation = interface;
  PIVectorView_1__AnimationMetrics_IPropertyAnimation = ^IVectorView_1__AnimationMetrics_IPropertyAnimation;

  // Windows.UI.Core.AnimationMetrics.IAnimationDescription
  AnimationMetrics_IAnimationDescription = interface;
  PAnimationMetrics_IAnimationDescription = ^AnimationMetrics_IAnimationDescription;

  // Windows.UI.Core.AnimationMetrics.IAnimationDescriptionFactory
  AnimationMetrics_IAnimationDescriptionFactory = interface;
  PAnimationMetrics_IAnimationDescriptionFactory = ^AnimationMetrics_IAnimationDescriptionFactory;


  // Emit Forwarded interfaces
  // Windows.UI.Core Interfaces
  // Windows.UI.Core.DispatchedHandler
  DispatchedHandler = interface(IUnknown)
  ['{D1F276C4-98D8-4636-BF49-EB79507548E9}']
    procedure Invoke; safecall;
  end;

  // Windows.UI.Core.IIdleDispatchedHandlerArgs
  IIdleDispatchedHandlerArgs = interface(IInspectable)
  ['{98BB6A24-DC1C-43CB-B4ED-D1C0EB2391F3}']
    function get_IsDispatcherIdle: Boolean; safecall;
    property IsDispatcherIdle: Boolean read get_IsDispatcherIdle;
  end;

  // Windows.UI.Core.IdleDispatchedHandler
  IdleDispatchedHandler = interface(IUnknown)
  ['{A42B0C24-7F21-4ABC-99C1-8F01007F0880}']
    procedure Invoke(e: IIdleDispatchedHandlerArgs); safecall;
  end;

  // Windows.UI.Core.ICoreDispatcher
  ICoreDispatcher = interface(IInspectable)
  ['{60DB2FA8-B705-4FDE-A7D6-EBBB1891D39E}']
    function get_HasThreadAccess: Boolean; safecall;
    procedure ProcessEvents(options: CoreProcessEventsOption); safecall;
    function RunAsync(priority: CoreDispatcherPriority; agileCallback: DispatchedHandler): IAsyncAction; safecall;
    function RunIdleAsync(agileCallback: IdleDispatchedHandler): IAsyncAction; safecall;
    property HasThreadAccess: Boolean read get_HasThreadAccess;
  end;

  // Windows.UI.Core.IPointerEventArgs
  IPointerEventArgs = interface(IInspectable)
  ['{920D9CB1-A5FC-4A21-8C09-49DFE6FFE25F}']
    function get_CurrentPoint: IPointerPoint; safecall;
    function get_KeyModifiers: VirtualKeyModifiers; safecall;
    function GetIntermediatePoints: IVector_1__IPointerPoint; safecall;
    property CurrentPoint: IPointerPoint read get_CurrentPoint;
    property KeyModifiers: VirtualKeyModifiers read get_KeyModifiers;
  end;

  // Generic Delegate for 
  // Windows.Foundation.TypedEventHandler`2<Object,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInspectable__IPointerEventArgs_Delegate_Base = interface(IUnknown)
  ['{26AABF41-A0FD-5E66-B188-6C74182D00CD}']
  end;
  // Windows.Foundation.TypedEventHandler`2<Object,Windows.UI.Core.IPointerEventArgs>
  TypedEventHandler_2__IInspectable__IPointerEventArgs = interface(TypedEventHandler_2__IInspectable__IPointerEventArgs_Delegate_Base)
  ['{698383FB-4816-51E2-B784-F1EFD30A0A7F}']
    procedure Invoke(sender: IInspectable; args: IPointerEventArgs); safecall;
  end;

  // DualAPI Interface
  // Windows.UI.Core.AnimationMetrics.IPropertyAnimation
  [WinRTClassNameAttribute(SAnimationMetrics_TranslationAnimation)]
  AnimationMetrics_IPropertyAnimation = interface(IInspectable)
  ['{3A01B4DA-4D8C-411E-B615-1ADE683A9903}']
    function get_Type: AnimationMetrics_PropertyAnimationType; safecall;
    function get_Delay: TimeSpan; safecall;
    function get_Duration: TimeSpan; safecall;
    function get_Control1: TPointF; safecall;
    function get_Control2: TPointF; safecall;
    property Control1: TPointF read get_Control1;
    property Control2: TPointF read get_Control2;
    property Delay: TimeSpan read get_Delay;
    property Duration: TimeSpan read get_Duration;
    property &Type: AnimationMetrics_PropertyAnimationType read get_Type;
  end;

  // DualAPI Interface
  // Windows.UI.Core.AnimationMetrics.IScaleAnimation
  [WinRTClassNameAttribute(SAnimationMetrics_ScaleAnimation)]
  AnimationMetrics_IScaleAnimation = interface(IInspectable)
  ['{023552C7-71AB-428C-9C9F-D31780964995}']
    function get_InitialScaleX: IReference_1__Single; safecall;
    function get_InitialScaleY: IReference_1__Single; safecall;
    function get_FinalScaleX: Single; safecall;
    function get_FinalScaleY: Single; safecall;
    function get_NormalizedOrigin: TPointF; safecall;
    property FinalScaleX: Single read get_FinalScaleX;
    property FinalScaleY: Single read get_FinalScaleY;
    property InitialScaleX: IReference_1__Single read get_InitialScaleX;
    property InitialScaleY: IReference_1__Single read get_InitialScaleY;
    property NormalizedOrigin: TPointF read get_NormalizedOrigin;
  end;

  // DualAPI Interface
  // Windows.UI.Core.AnimationMetrics.IOpacityAnimation
  [WinRTClassNameAttribute(SAnimationMetrics_OpacityAnimation)]
  AnimationMetrics_IOpacityAnimation = interface(IInspectable)
  ['{803AABE5-EE7E-455F-84E9-2506AFB8D2B4}']
    function get_InitialOpacity: IReference_1__Single; safecall;
    function get_FinalOpacity: Single; safecall;
    property FinalOpacity: Single read get_FinalOpacity;
    property InitialOpacity: IReference_1__Single read get_InitialOpacity;
  end;

  // Windows.Foundation.Collections.IIterator`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IIterator_1__AnimationMetrics_IPropertyAnimation = interface(IInspectable)
  ['{BB6799D3-9F1A-5A4E-A940-945F1AB8C4FE}']
    function get_Current: AnimationMetrics_IPropertyAnimation; safecall;
    function get_HasCurrent: Boolean; safecall;
    function MoveNext: Boolean; safecall;
    function GetMany(itemsSize: Cardinal; items: PAnimationMetrics_IPropertyAnimation): Cardinal; safecall;
    property Current: AnimationMetrics_IPropertyAnimation read get_Current;
    property HasCurrent: Boolean read get_HasCurrent;
  end;

  // Windows.Foundation.Collections.IIterable`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IIterable_1__AnimationMetrics_IPropertyAnimation = interface(IInspectable)
  ['{C75F1BD1-A3C1-5881-9DA0-1ECDB8E51BC3}']
    function First: IIterator_1__AnimationMetrics_IPropertyAnimation; safecall;
  end;

  // Windows.Foundation.Collections.IVectorView`1<Windows.UI.Core.AnimationMetrics.IPropertyAnimation>
  IVectorView_1__AnimationMetrics_IPropertyAnimation = interface(IInspectable)
  ['{3A6ED95D-6A50-5EAD-A4C6-09F8BABC632C}']
    function GetAt(index: Cardinal): AnimationMetrics_IPropertyAnimation; safecall;
    function get_Size: Cardinal; safecall;
    function IndexOf(value: AnimationMetrics_IPropertyAnimation; out index: Cardinal): Boolean; safecall;
    function GetMany(startIndex: Cardinal; itemsSize: Cardinal; items: PAnimationMetrics_IPropertyAnimation): Cardinal; safecall;
    property Size: Cardinal read get_Size;
  end;

  // DualAPI Interface
  // Windows.UI.Core.AnimationMetrics.IAnimationDescription
  [WinRTClassNameAttribute(SAnimationMetrics_AnimationDescription)]
  AnimationMetrics_IAnimationDescription = interface(IInspectable)
  ['{7D11A549-BE3D-41DE-B081-05C149962F9B}']
    function get_Animations: IVectorView_1__AnimationMetrics_IPropertyAnimation; safecall;
    function get_StaggerDelay: TimeSpan; safecall;
    function get_StaggerDelayFactor: Single; safecall;
    function get_DelayLimit: TimeSpan; safecall;
    function get_ZOrder: Integer; safecall;
    property Animations: IVectorView_1__AnimationMetrics_IPropertyAnimation read get_Animations;
    property DelayLimit: TimeSpan read get_DelayLimit;
    property StaggerDelay: TimeSpan read get_StaggerDelay;
    property StaggerDelayFactor: Single read get_StaggerDelayFactor;
    property ZOrder: Integer read get_ZOrder;
  end;

  // DualAPI Interface
  // Windows.UI.Core.AnimationMetrics.IAnimationDescriptionFactory
  [WinRTClassNameAttribute(SAnimationMetrics_AnimationDescription)]
  AnimationMetrics_IAnimationDescriptionFactory = interface(IInspectable)
  ['{C6E27ABE-C1FB-48B5-9271-ECC70AC86EF0}']
    function CreateInstance(effect: AnimationMetrics_AnimationEffect; target: AnimationMetrics_AnimationEffectTarget): AnimationMetrics_IAnimationDescription; safecall;
  end;


  // Emit Forwarded classes
  // Windows.UI.Core.AnimationMetrics.AnimationDescription
  // DualAPI
  TAnimationMetrics_AnimationDescription = class(TWinRTGenericImportF<AnimationMetrics_IAnimationDescriptionFactory>)
  public
    // -> AnimationMetrics_IAnimationDescriptionFactory
    class function CreateInstance(effect: AnimationMetrics_AnimationEffect; target: AnimationMetrics_AnimationEffectTarget): AnimationMetrics_IAnimationDescription; static; inline;
  end;

  // Windows.UI.Core.AnimationMetrics.PropertyAnimation
  // DualAPI

  // Windows.UI.Core.AnimationMetrics.ScaleAnimation
  // DualAPI

  // Windows.UI.Core.AnimationMetrics.TranslationAnimation
  // DualAPI

  // Windows.UI.Core.AnimationMetrics.OpacityAnimation
  // DualAPI


implementation

  // Emit Classes Implementation
 { TAnimationMetrics_AnimationDescription }
// Factories for : "AnimationMetrics_AnimationDescription"
// Factory: "Windows.UI.Core.AnimationMetrics.IAnimationDescriptionFactory"
// -> AnimationMetrics_IAnimationDescriptionFactory

class function TAnimationMetrics_AnimationDescription.CreateInstance(effect: AnimationMetrics_AnimationEffect; target: AnimationMetrics_AnimationEffectTarget): AnimationMetrics_IAnimationDescription;
begin
  Result := Factory.CreateInstance(effect, target);
end;



end.
