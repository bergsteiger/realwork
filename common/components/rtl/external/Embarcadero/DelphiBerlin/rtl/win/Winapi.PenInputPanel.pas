{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{          File: peninputpanel.h                        }
{          Copyright (c) Microsoft Corporation          }
{                                                       }
{       Translator: Embarcadero Technologies, Inc.      }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Winapi.PenInputPanel;

{$ALIGN ON}
{$MINENUMSIZE 4}
{$WEAKPACKAGEUNIT}

{$HPPEMIT ''}
{$HPPEMIT '#include "peninputpanel.h"'}
{$HPPEMIT ''}

interface

uses Winapi.Windows, Winapi.ActiveX, Winapi.MsInkAut;

const
  // TypeLibrary Major and minor versions
  PenInputPanelLibMajorVersion = 1;
  PenInputPanelLibMinorVersion = 0;

  LIBID_PenInputPanelLib: TGUID = '{D7CA032C-B7D0-429E-9FD7-82241C356B4A}';

  IID_IPenInputPanel: TGUID = '{FA7A4083-5747-4040-A182-0B0E9FD4FAC7}';
  {$EXTERNALSYM IID_IPenInputPanel}
  DIID__IPenInputPanelEvents: TGUID = '{B7E489DA-3719-439F-848F-E7ACBD820F17}';
  {$EXTERNALSYM DIID__IPenInputPanelEvents}
  IID_IHandwrittenTextInsertion: TGUID = '{56FDEA97-ECD6-43E7-AA3A-816BE7785860}';
  {$EXTERNALSYM IID_IHandwrittenTextInsertion}
  CLASS_HandwrittenTextInsertion: TGUID = '{9F074EE2-E6E9-4D8A-A047-EB5B5C3C55DA}';
  {$EXTERNALSYM CLASS_HandwrittenTextInsertion}
  CLASS_PenInputPanel: TGUID = '{F744E496-1B5A-489E-81DC-FBD7AC6298A8}';
  {$EXTERNALSYM CLASS_PenInputPanel}
  IID_ITextInputPanelEventSink: TGUID = '{27560408-8E64-4FE1-804E-421201584B31}';
  {$EXTERNALSYM IID_ITextInputPanelEventSink}
  IID_ITextInputPanel: TGUID = '{6B6A65A5-6AF3-46C2-B6EA-56CD1F80DF71}';
  {$EXTERNALSYM IID_ITextInputPanel}
  IID_IInputPanelWindowHandle: TGUID = '{4AF81847-FDC4-4FC3-AD0B-422479C1B935}';
  {$EXTERNALSYM IID_IInputPanelWindowHandle}
  IID_ITextInputPanelRunInfo: TGUID = '{9F424568-1920-48CC-9811-A993CBF5ADBA}';
  {$EXTERNALSYM IID_ITextInputPanelRunInfo}
  CLASS_TextInputPanel: TGUID = '{F9B189D7-228B-4F2B-8650-B97F59E02C8C}';
  {$EXTERNALSYM CLASS_TextInputPanel}
  CLASS_PenInputPanel_Internal: TGUID = '{802B1FB9-056B-4720-B0CC-80D23B71171E}';
  {$EXTERNALSYM CLASS_PenInputPanel_Internal}

// Constants for enum DISPID_PenInputPanel
type
  DISPID_PenInputPanel = TOleEnum;
  {$EXTERNALSYM DISPID_PenInputPanel}
const
  DISPID_PIPAttachedEditWindow = $00000000;
  {$EXTERNALSYM DISPID_PIPAttachedEditWindow}
  DISPID_PIPFactoid = $00000001;
  {$EXTERNALSYM DISPID_PIPFactoid}
  DISPID_PIPCurrentPanel = $00000002;
  {$EXTERNALSYM DISPID_PIPCurrentPanel}
  DISPID_PIPDefaultPanel = $00000003;
  {$EXTERNALSYM DISPID_PIPDefaultPanel}
  DISPID_PIPVisible = $00000004;
  {$EXTERNALSYM DISPID_PIPVisible}
  DISPID_PIPTop = $00000005;
  {$EXTERNALSYM DISPID_PIPTop}
  DISPID_PIPLeft = $00000006;
  {$EXTERNALSYM DISPID_PIPLeft}
  DISPID_PIPWidth = $00000007;
  {$EXTERNALSYM DISPID_PIPWidth}
  DISPID_PIPHeight = $00000008;
  {$EXTERNALSYM DISPID_PIPHeight}
  DISPID_PIPMoveTo = $00000009;
  {$EXTERNALSYM DISPID_PIPMoveTo}
  DISPID_PIPCommitPendingInput = $0000000A;
  {$EXTERNALSYM DISPID_PIPCommitPendingInput}
  DISPID_PIPRefresh = $0000000B;
  {$EXTERNALSYM DISPID_PIPRefresh}
  DISPID_PIPBusy = $0000000C;
  {$EXTERNALSYM DISPID_PIPBusy}
  DISPID_PIPVerticalOffset = $0000000D;
  {$EXTERNALSYM DISPID_PIPVerticalOffset}
  DISPID_PIPHorizontalOffset = $0000000E;
  {$EXTERNALSYM DISPID_PIPHorizontalOffset}
  DISPID_PIPEnableTsf = $0000000F;
  {$EXTERNALSYM DISPID_PIPEnableTsf}
  DISPID_PIPAutoShow = $00000010;
  {$EXTERNALSYM DISPID_PIPAutoShow}

// Constants for enum DISPID_PenInputPanelEvents
type
  DISPID_PenInputPanelEvents = TOleEnum;
  {$EXTERNALSYM DISPID_PenInputPanelEvents}
const
  DISPID_PIPEVisibleChanged = $00000000;
  {$EXTERNALSYM DISPID_PIPEVisibleChanged}
  DISPID_PIPEPanelChanged = $00000001;
  {$EXTERNALSYM DISPID_PIPEPanelChanged}
  DISPID_PIPEInputFailed = $00000002;
  {$EXTERNALSYM DISPID_PIPEInputFailed}
  DISPID_PIPEPanelMoving = $00000003;
  {$EXTERNALSYM DISPID_PIPEPanelMoving}

// Constants for enum VisualState
type
  VisualState = TOleEnum;
  {$EXTERNALSYM VisualState}
const
  InPlace = $00000000;
  {$EXTERNALSYM InPlace}
  Floating = $00000001;
  {$EXTERNALSYM Floating}
  DockedTop = $00000002;
  {$EXTERNALSYM DockedTop}
  DockedBottom = $00000003;
  {$EXTERNALSYM DockedBottom}
  Closed = $00000004;
  {$EXTERNALSYM Closed}

// Constants for enum InteractionMode
type
  InteractionMode = TOleEnum;
  {$EXTERNALSYM InteractionMode}
const
  InteractionMode_InPlace = $00000000;
  {$EXTERNALSYM InteractionMode_InPlace}
  InteractionMode_Floating = $00000001;
  {$EXTERNALSYM InteractionMode_Floating}
  InteractionMode_DockedTop = $00000002;
  {$EXTERNALSYM InteractionMode_DockedTop}
  InteractionMode_DockedBottom = $00000003;
  {$EXTERNALSYM InteractionMode_DockedBottom}

// Constants for enum InPlaceState
type
  InPlaceState = TOleEnum;
  {$EXTERNALSYM InPlaceState}
const
  InPlaceState_Auto = $00000000;
  {$EXTERNALSYM InPlaceState_Auto}
  InPlaceState_HoverTarget = $00000001;
  {$EXTERNALSYM InPlaceState_HoverTarget}
  InPlaceState_Expanded = $00000002;
  {$EXTERNALSYM InPlaceState_Expanded}

// Constants for enum PanelInputArea
type
  PanelInputArea = TOleEnum;
  {$EXTERNALSYM PanelInputArea}
const
  PanelInputArea_Auto = $00000000;
  {$EXTERNALSYM PanelInputArea_Auto}
  PanelInputArea_Keyboard = $00000001;
  {$EXTERNALSYM PanelInputArea_Keyboard}
  PanelInputArea_WritingPad = $00000002;
  {$EXTERNALSYM PanelInputArea_WritingPad}
  PanelInputArea_CharacterPad = $00000003;
  {$EXTERNALSYM PanelInputArea_CharacterPad}

// Constants for enum CorrectionMode
type
  CorrectionMode = TOleEnum;
  {$EXTERNALSYM CorrectionMode}
const
  CorrectionMode_NotVisible = $00000000;
  {$EXTERNALSYM CorrectionMode_NotVisible}
  CorrectionMode_PreInsertion = $00000001;
  {$EXTERNALSYM CorrectionMode_PreInsertion}
  CorrectionMode_PostInsertionCollapsed = $00000002;
  {$EXTERNALSYM CorrectionMode_PostInsertionCollapsed}
  CorrectionMode_PostInsertionExpanded = $00000003;
  {$EXTERNALSYM CorrectionMode_PostInsertionExpanded}

// Constants for enum CorrectionPosition
type
  CorrectionPosition = TOleEnum;
  {$EXTERNALSYM CorrectionPosition}
const
  CorrectionPosition_Auto = $00000000;
  {$EXTERNALSYM CorrectionPosition_Auto}
  CorrectionPosition_Bottom = $00000001;
  {$EXTERNALSYM CorrectionPosition_Bottom}
  CorrectionPosition_Top = $00000002;
  {$EXTERNALSYM CorrectionPosition_Top}

// Constants for enum InPlaceDirection
type
  InPlaceDirection = TOleEnum;
  {$EXTERNALSYM InPlaceDirection}
const
  InPlaceDirection_Auto = $00000000;
  {$EXTERNALSYM InPlaceDirection_Auto}
  InPlaceDirection_Bottom = $00000001;
  {$EXTERNALSYM InPlaceDirection_Bottom}
  InPlaceDirection_Top = $00000002;
  {$EXTERNALSYM InPlaceDirection_Top}

// Constants for enum EventMask
type
  EventMask = TOleEnum;
  {$EXTERNALSYM EventMask}
const
  EventMask_InPlaceStateChanging = $00000001;
  {$EXTERNALSYM EventMask_InPlaceStateChanging}
  EventMask_InPlaceStateChanged = $00000002;
  {$EXTERNALSYM EventMask_InPlaceStateChanged}
  EventMask_InPlaceSizeChanging = $00000004;
  {$EXTERNALSYM EventMask_InPlaceSizeChanging}
  EventMask_InPlaceSizeChanged = $00000008;
  {$EXTERNALSYM EventMask_InPlaceSizeChanged}
  EventMask_InputAreaChanging = $00000010;
  {$EXTERNALSYM EventMask_InputAreaChanging}
  EventMask_InputAreaChanged = $00000020;
  {$EXTERNALSYM EventMask_InputAreaChanged}
  EventMask_CorrectionModeChanging = $00000040;
  {$EXTERNALSYM EventMask_CorrectionModeChanging}
  EventMask_CorrectionModeChanged = $00000080;
  {$EXTERNALSYM EventMask_CorrectionModeChanged}
  EventMask_InPlaceVisibilityChanging = $00000100;
  {$EXTERNALSYM EventMask_InPlaceVisibilityChanging}
  EventMask_InPlaceVisibilityChanged = $00000200;
  {$EXTERNALSYM EventMask_InPlaceVisibilityChanged}
  EventMask_TextInserting = $00000400;
  {$EXTERNALSYM EventMask_TextInserting}
  EventMask_TextInserted = $00000800;
  {$EXTERNALSYM EventMask_TextInserted}
  EventMask_All = $00000FFF;
  {$EXTERNALSYM EventMask_All}

// Constants for enum PanelType
type
  PanelType = TOleEnum;
  {$EXTERNALSYM PanelType}
const
  PT_Default = $00000000;
  {$EXTERNALSYM PT_Default}
  PT_Inactive = $00000001;
  {$EXTERNALSYM PT_Inactive}
  PT_Handwriting = $00000002;
  {$EXTERNALSYM PT_Handwriting}
  PT_Keyboard = $00000003;
  {$EXTERNALSYM PT_Keyboard}

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IPenInputPanel = interface;
  IPenInputPanelEvents = dispinterface;
  IHandwrittenTextInsertion = interface;
  ITextInputPanelEventSink = interface;
  ITextInputPanel = interface;
  IInputPanelWindowHandle = interface;
  ITextInputPanelRunInfo = interface;


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IPenInputPanel);'}
  IPenInputPanel = interface(IDispatch)
    ['{FA7A4083-5747-4040-A182-0B0E9FD4FAC7}']
    function Get_Busy(out Busy: WordBool): HResult; stdcall;
    function Get_Factoid(out Factoid: WideString): HResult; stdcall;
    function Set_Factoid(const Factoid: WideString): HResult; stdcall;
    function Get_AttachedEditWindow(out AttachedEditWindow: SYSINT): HResult; stdcall;
    function Set_AttachedEditWindow(AttachedEditWindow: SYSINT): HResult; stdcall;
    function Get_CurrentPanel(out CurrentPanel: PanelType): HResult; stdcall;
    function Set_CurrentPanel(CurrentPanel: PanelType): HResult; stdcall;
    function Get_DefaultPanel(out pDefaultPanel: PanelType): HResult; stdcall;
    function Set_DefaultPanel(pDefaultPanel: PanelType): HResult; stdcall;
    function Get_Visible(out Visible: WordBool): HResult; stdcall;
    function Set_Visible(Visible: WordBool): HResult; stdcall;
    function Get_Top(out Top: Integer): HResult; stdcall;
    function Get_Left(out Left: Integer): HResult; stdcall;
    function Get_Width(out Width: Integer): HResult; stdcall;
    function Get_Height(out Height: Integer): HResult; stdcall;
    function Get_VerticalOffset(out VerticalOffset: Integer): HResult; stdcall;
    function Set_VerticalOffset(VerticalOffset: Integer): HResult; stdcall;
    function Get_HorizontalOffset(out HorizontalOffset: Integer): HResult; stdcall;
    function Set_HorizontalOffset(HorizontalOffset: Integer): HResult; stdcall;
    function Get_AutoShow(out pAutoShow: WordBool): HResult; stdcall;
    function Set_AutoShow(pAutoShow: WordBool): HResult; stdcall;
    function MoveTo(Left: Integer; Top: Integer): HResult; stdcall;
    function CommitPendingInput: HResult; stdcall;
    function Refresh: HResult; stdcall;
    function EnableTsf(Enable: WordBool): HResult; stdcall;
  end;
  {$EXTERNALSYM IPenInputPanel}


  IPenInputPanelEvents = dispinterface
    ['{B7E489DA-3719-439F-848F-E7ACBD820F17}']
    function InputFailed(hWnd: SYSINT; Key: Integer; const Text: WideString; ShiftKey: Smallint): HResult; dispid 2;
    function VisibleChanged(NewVisibility: WordBool): HResult; dispid 0;
    function PanelChanged(NewPanelType: PanelType): HResult; dispid 1;
    function PanelMoving(var Left: Integer; var Top: Integer): HResult; dispid 3;
  end;
  {$EXTERNALSYM IPenInputPanelEvents}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IHandwrittenTextInsertion);'}
  IHandwrittenTextInsertion = interface(IUnknown)
    ['{56FDEA97-ECD6-43E7-AA3A-816BE7785860}']
    function InsertRecognitionResultsArray(psaAlternates: PSafeArray; locale: LongWord;
                                           fAlternateContainsAutoSpacingInformation: Integer): HResult; stdcall;
    function InsertInkRecognitionResult(const pIInkRecoResult: IInkRecognitionResult;
                                        locale: LongWord;
                                        fAlternateContainsAutoSpacingInformation: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM IHandwrittenTextInsertion}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextInputPanelEventSink);'}
  ITextInputPanelEventSink = interface(IUnknown)
    ['{27560408-8E64-4FE1-804E-421201584B31}']
    function InPlaceStateChanging(oldInPlaceState: InPlaceState; newInPlaceState: InPlaceState): HResult; stdcall;
    function InPlaceStateChanged(oldInPlaceState: InPlaceState; newInPlaceState: InPlaceState): HResult; stdcall;
    function InPlaceSizeChanging(oldBoundingRectangle: TRect; newBoundingRectangle: TRect): HResult; stdcall;
    function InPlaceSizeChanged(oldBoundingRectangle: TRect; newBoundingRectangle: TRect): HResult; stdcall;
    function InputAreaChanging(oldInputArea: PanelInputArea; newInputArea: PanelInputArea): HResult; stdcall;
    function InputAreaChanged(oldInputArea: PanelInputArea; newInputArea: PanelInputArea): HResult; stdcall;
    function CorrectionModeChanging(oldCorrectionMode: CorrectionMode;
                                    newCorrectionMode: CorrectionMode): HResult; stdcall;
    function CorrectionModeChanged(oldCorrectionMode: CorrectionMode;
                                   newCorrectionMode: CorrectionMode): HResult; stdcall;
    function InPlaceVisibilityChanging(oldVisible: Integer; newVisible: Integer): HResult; stdcall;
    function InPlaceVisibilityChanged(oldVisible: Integer; newVisible: Integer): HResult; stdcall;
    function TextInserting(Ink: PSafeArray): HResult; stdcall;
    function TextInserted(Ink: PSafeArray): HResult; stdcall;
  end;
  {$EXTERNALSYM ITextInputPanelEventSink}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextInputPanel);'}
  ITextInputPanel = interface(IUnknown)
    ['{6B6A65A5-6AF3-46C2-B6EA-56CD1F80DF71}']
    function Get_AttachedEditWindow(out AttachedEditWindow: HWND): HResult; stdcall;
    function Set_AttachedEditWindow(AttachedEditWindow: HWND): HResult; stdcall;
    function Get_CurrentInteractionMode(out CurrentInteractionMode: InteractionMode): HResult; stdcall;
    function Get_DefaultInPlaceState(out State: InPlaceState): HResult; stdcall;
    function Set_DefaultInPlaceState(State: InPlaceState): HResult; stdcall;
    function Get_CurrentInPlaceState(out State: InPlaceState): HResult; stdcall;
    function Get_DefaultInputArea(out Area: PanelInputArea): HResult; stdcall;
    function Set_DefaultInputArea(Area: PanelInputArea): HResult; stdcall;
    function Get_CurrentInputArea(out Area: PanelInputArea): HResult; stdcall;
    function Get_CurrentCorrectionMode(out Mode: CorrectionMode): HResult; stdcall;
    function Get_PreferredInPlaceDirection(out Direction: InPlaceDirection): HResult; stdcall;
    function Set_PreferredInPlaceDirection(Direction: InPlaceDirection): HResult; stdcall;
    function Get_ExpandPostInsertionCorrection(out Expand: Integer): HResult; stdcall;
    function Set_ExpandPostInsertionCorrection(Expand: Integer): HResult; stdcall;
    function Get_InPlaceVisibleOnFocus(out Visible: Integer): HResult; stdcall;
    function Set_InPlaceVisibleOnFocus(Visible: Integer): HResult; stdcall;
    function Get_InPlaceBoundingRectangle(out BoundingRectangle: TRect): HResult; stdcall;
    function Get_PopUpCorrectionHeight(out Height: SYSINT): HResult; stdcall;
    function Get_PopDownCorrectionHeight(out Height: SYSINT): HResult; stdcall;
    function CommitPendingInput: HResult; stdcall;
    function SetInPlaceVisibility(Visible: Integer): HResult; stdcall;
    function SetInPlacePosition(xPosition: SYSINT; yPosition: SYSINT; position: CorrectionPosition): HResult; stdcall;
    function SetInPlaceHoverTargetPosition(xPosition: SYSINT; yPosition: SYSINT): HResult; stdcall;
    function Advise(const EventSink: ITextInputPanelEventSink; EventMask: LongWord): HResult; stdcall;
    function Unadvise(const EventSink: ITextInputPanelEventSink): HResult; stdcall;
  end;
  {$EXTERNALSYM ITextInputPanel}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(IInputPanelWindowHandle);'}
  IInputPanelWindowHandle = interface(IUnknown)
    ['{4AF81847-FDC4-4FC3-AD0B-422479C1B935}']
    function Get_AttachedEditWindow32(out AttachedEditWindow: SYSINT): HResult; stdcall;
    function Set_AttachedEditWindow32(AttachedEditWindow: SYSINT): HResult; stdcall;
    function Get_AttachedEditWindow64(out AttachedEditWindow: Int64): HResult; stdcall;
    function Set_AttachedEditWindow64(AttachedEditWindow: Int64): HResult; stdcall;
  end;
  {$EXTERNALSYM IInputPanelWindowHandle}


  {$HPPEMIT 'DECLARE_DINTERFACE_TYPE(ITextInputPanelRunInfo);'}
  ITextInputPanelRunInfo = interface(IUnknown)
    ['{9F424568-1920-48CC-9811-A993CBF5ADBA}']
    function IsTipRunning(out pfRunning: Integer): HResult; stdcall;
  end;
  {$EXTERNALSYM ITextInputPanelRunInfo}

const
  MICROSOFT_PENINPUT_PANEL_PROPERTY_T     = 'Microsoft PenInputPanel 1.5';
  {$EXTERNALSYM MICROSOFT_PENINPUT_PANEL_PROPERTY_T}
  MICROSOFT_URL_EXPERIENCE_PROPERTY       = 'Microsoft TIP URL Experience';
  {$EXTERNALSYM MICROSOFT_URL_EXPERIENCE_PROPERTY}
  MICROSOFT_TIP_NO_INSERT_BUTTON_PROPERTY = 'Microsoft TIP No Insert Option';
  {$EXTERNALSYM MICROSOFT_TIP_NO_INSERT_BUTTON_PROPERTY}
  MICROSOFT_TIP_COMBOBOXLIST_PROPERTY     = 'Microsoft TIP ComboBox List Window Identifier';
  {$EXTERNALSYM MICROSOFT_TIP_COMBOBOXLIST_PROPERTY}
  MICROSOFT_TIP_OPENING_MSG               = 'TabletInputPanelOpening';
  {$EXTERNALSYM MICROSOFT_TIP_OPENING_MSG}

implementation

end.

