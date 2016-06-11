{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit System.Win.OleControls;

interface

uses
  System.Variants, System.Types, Winapi.Windows, Winapi.Messages, Winapi.ActiveX, System.SysUtils, System.Classes,
  System.UITypes, System.Win.ComObj;

{$IFDEF CPUX64}
  {$DEFINE PUREPASCAL}
{$ENDIF CPUX64}

type
  TDelegatedOleControl = class;
  TEventDispatch = class(TInterfacedObject, IDispatch)
  private
    FControl: TDelegatedOleControl;
  protected
    { IUnknown }
    function QueryInterface(const IID: TGUID; out Obj): HResult; stdcall;
    { IDispatch }
    /// <summary>
    ///  Retrieves the number of type information interfaces that an object provides (either 0 or 1).
    /// </summary>
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    /// <summary>
    ///   Retrieves the type information for an object, which can then be used to get the type information for an
    /// interface.
    /// </summary>
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    /// <summary>
    ///   Maps a single member and an optional set of argument names to a corresponding set of integer DISPIDs, which
    /// can be used on subsequent calls to Invoke
    /// </summary>
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer;
      DispIDs: Pointer): HResult; stdcall;
    /// <summary>
    ///   Provides access to properties and methods exposed by an object.
    /// </summary>
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
      ArgErr: Pointer): HResult; virtual; stdcall;
    /// <summary>
    ///   Provide access to OLE control
    /// </summary>
    property Control: TDelegatedOleControl read FControl;
  public
    constructor Create(Control: TDelegatedOleControl);
  end;

  TArgKind = (akDWord, akSingle, akDouble);

  PEventArg = ^TEventArg;
  TEventArg = record
    Kind: TArgKind;
    Data: array[0..1] of Integer;
  end;

  TEventInfo = record
    Method: TMethod;
    Sender: TObject;
    ArgCount: Integer;
    Args: array[0..MaxDispArgs - 1] of TEventArg;
  end;
  PControlData = ^TControlData;
  TControlData = record
    ClassID: TGUID;
    EventIID: TGUID;
    EventCount: Longint;
    EventDispIDs: Pointer;
    LicenseKey: Pointer;
    Flags: DWORD;
    Version: Integer;
    FontCount: Integer;
    FontIDs: PDispIDList;
    PictureCount: Integer;
    PictureIDs: PDispIDList;
    Reserved: Integer;
    InstanceCount: Integer;
    EnumPropDescs: TList;
  end;

  PControlData2 = ^TControlData2;
  TControlData2 = record
    ClassID: TGUID;
    EventIID: TGUID;
    EventCount: Longint;
    EventDispIDs: Pointer;
    LicenseKey: Pointer;
    Flags: DWORD;
    Version: Integer;
    FontCount: Integer;
    FontIDs: PDispIDList;
    PictureCount: Integer;
    PictureIDs: PDispIDList;
    Reserved: Integer;
    InstanceCount: Integer;
    EnumPropDescs: TList;
    FirstEventOfs: Cardinal;
  end;

  /// <summary>
  ///  Interface for OLE delegate. All controls that would work with OLE should support it
  /// </summary>
  IOLEFrameworkDelegate = interface
    ['{5240182A-FED7-41D3-B121-68E983247B1E}']
    /// <summary>
    ///  Set the procedure that invokes the default window procedure associated with this window.
    /// </summary>
    procedure SetDefWndProc(const AWndProc: Pointer);
    /// <summary>
    ///  Get the procedure that invokes the default window procedure associated with this window.
    /// </summary>
    function GetDefWndProc: Pointer;
    /// <summary>
    ///   Get the address of the procedure that invokes the default window procedure associated with this window.
    /// </summary>
    function InitWindowProc: Pointer;
    /// <summary>
    ///   Set handle to the OLE Control
    /// </summary>
    procedure SetHandle(const AHandle: HWND);
    /// <summary>
    ///   Get handle to the OLE control
    /// </summary>
    function GetHandle: HWND;
    /// <summary>
    ///   Get handle to parent control
    /// </summary>
    function GetParentHandle: THandle;
    /// <summary>
    ///   Get the bounds rect as set of integer values
    /// </summary>
    function GetBoundsRect: TRect;
    /// <summary>
    ///   Get value of visibilities
    /// </summary>
    function GetVisible: Boolean;
    /// <summary>
    ///   Set visibility
    /// </summary>
    procedure SetVisible(const AVisible: Boolean);
    /// <summary>
    ///   Set OLE control as CreationControl for using in InitWndProc
    /// </summary>
    procedure SetCreationControl;
    /// <summary>
    ///   Return the top parent handle for OLE control
    /// </summary>
    function GetTopParentHandle: HWND;
    property Visible: Boolean read GetVisible write SetVisible;
    property DefWndProc: Pointer read GetDefWndProc write SetDefWndProc;
    property Handle: HWND read GetHandle write SetHandle;
    /// <summary>
    ///  Setting the method that would be used for dispatching
    /// </summary>
    procedure SetDispatcher(const ADisp: TEventDispatchInvoker);
    /// <summary>
    ///  Get window handle
    /// </summary>
    function GetWindowHandle: HWND;
    /// <summary>
    ///  Set window handle
    /// </summary>
    procedure SetWindowHandle(AValue: HWND);
    property WindowHandle: HWND read GetWindowHandle write SetWindowHandle;
  end;

  TServiceQuery = function(const rsid, iid: TGuid; out obj): HResult of object;

  TDelegatedOleControl = class(TComponent, IUnknown, IOleClientSite, IOleControlSite, IOleInPlaceSite, IOleInPlaceFrame,
    IDispatch, IPropertyNotifySink, ISimpleFrameSite, IServiceProvider)
  private
    FDelegate: IOLEFrameworkDelegate;
    FControlData: PControlData;
    FRefCount: Longint;
    FEventDispatch: IDispatch;
    FObjectData: HGlobal;
    FOleObject: IOleObject;
    FPersistStream: IPersistStreamInit;
    FOleControl: IOleControl;
    FControlDispatch: IDispatch;
    FPropBrowsing: IPerPropertyBrowsing;
    FOleInPlaceObject: IOleInPlaceObject;
    FOleInPlaceActiveObject: IOleInPlaceActiveObject;
    FPropConnection: Longint;
    FEventsConnection: Longint;
    FMiscStatus: Longint;
    FServiceQuery: TServiceQuery;
    FControlInfo: TControlInfo;
    procedure SetUIActive(Active: Boolean);
    function GetOleObject: Variant;
    procedure CreateControl;
    procedure DestroyControl;
    procedure DestroyStorage;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    {IUnknown }
  protected
    function QueryInterface(const IID: TGUID; out Obj): HResult; override;
  private
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
    {IOleControlSite}
    function OnControlInfoChanged: HResult; stdcall;
    function LockInPlaceActive(fLock: BOOL): HResult; stdcall;
    function GetExtendedControl(out disp: IDispatch): HResult; stdcall;
    function TransformCoords(var ptlHimetric: TPoint; var ptfContainer: TPointF; flags: Longint): HResult; stdcall;
    function IOleControlSite.TranslateAccelerator = OleControlSite_TranslateAccelerator;
    function OleControlSite_TranslateAccelerator(msg: PMsg; grfModifiers: Longint): HResult; stdcall;
    function OnFocus(fGotFocus: BOOL): HResult; stdcall;
    function ShowPropertyFrame: HResult; stdcall;
    {IDispatch}
    function GetTypeInfoCount(out Count: Integer): HResult; stdcall;
    function GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult; stdcall;
    function GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer; DispIDs: Pointer): HResult;
      stdcall;
    function Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult, ExcepInfo,
      ArgErr: Pointer): HResult; stdcall;
    {IPropertyNotifySink}
    function OnChanged(dispid: TDispID): HResult; stdcall;
    function OnRequestEdit(dispid: TDispID): HResult; stdcall;
    {ISimpleFrameSite}
    function PreMessageFilter(wnd: HWnd; msg: UInt; wp: WPARAM; lp: LPARAM; out res: LRESULT; out Cookie: DWORD): HResult; stdcall;
    function PostMessageFilter(wnd: HWnd; msg: UInt; wp: WPARAM; lp: LPARAM; out res: LRESULT; Cookie: DWORD): HResult; stdcall;
    {IServiceProvider}
    function QueryService(const rsid, iid: TGuid; out Obj): HResult; stdcall;
    {IOleInPlaceUIWindow}
    function GetBorder(out rectBorder: TRect): HResult; stdcall;
    function RequestBorderSpace(const borderwidths: TRect): HResult; stdcall;
    function SetBorderSpace(pborderwidths: PRect): HResult; stdcall;
    function SetActiveObject(const activeObject: IOleInPlaceActiveObject; pszObjName: POleStr): HResult; stdcall;
    {IOleInPlaceFrame}
    function InsertMenus(hmenuShared: HMenu; var menuWidths: TOleMenuGroupWidths): HResult; stdcall;
    function SetMenu(hmenuShared: HMenu; holemenu: HMenu; hwndActiveObject: HWnd): HResult; stdcall;
    function RemoveMenus(hmenuShared: HMenu): HResult; stdcall;
    function SetStatusText(pszStatusText: POleStr): HResult; stdcall;
    function EnableModeless(fEnable: BOOL): HResult; stdcall;
    function IOleInPlaceFrame.TranslateAccelerator = OleInPlaceFrame_TranslateAccelerator;
    function OleInPlaceFrame_TranslateAccelerator(var msg: TMsg; wID: Word): HResult; stdcall;
    {IOleInPlaceSite}
    function CanInPlaceActivate: HResult; stdcall;
    function OnInPlaceActivate: HResult; stdcall;
    function OnUIActivate: HResult; stdcall;
    function GetWindowContext(out frame: IOleInPlaceFrame; out doc: IOleInPlaceUIWindow; out rcPosRect: TRect; out
      rcClipRect: TRect; out frameInfo: TOleInPlaceFrameInfo): HResult; stdcall;
    function Scroll(scrollExtent: TPoint): HResult; stdcall;
    function OnUIDeactivate(fUndoable: BOOL): HResult; stdcall;
    function OnInPlaceDeactivate: HResult; stdcall;
    function DiscardUndoState: HResult; stdcall;
    function DeactivateAndUndo: HResult; stdcall;
    function OnPosRectChange(const rcPosRect: TRect): HResult; stdcall;
    {IOleInPlaceSite, IOleWindow}
    function GetWindow(out wnd: HWnd): HResult; stdcall;
    function ContextSensitiveHelp(fEnterMode: BOOL): HResult; stdcall;
    {IOleClientSite}
    function SaveObject: HResult; stdcall;
    function GetMoniker(dwAssign: Longint; dwWhichMoniker: Longint; out mk: IMoniker): HResult; stdcall;
    function GetContainer(out container: IOleContainer): HResult; stdcall;
    function ShowObject: HResult; stdcall;
    function OnShowWindow(fShow: BOOL): HResult; stdcall;
    function RequestNewObjectLayout: HResult; stdcall;
    procedure HookControlWndProc;
    procedure FrameworksDispatcher(DispId: Integer; var Params: TOleVariantArray);
    procedure CreateInstance;
  protected
    procedure StandardEvent(DispID: TDispID; var Params: TDispParams); virtual;
    procedure InvokeEvent(DispID: TDispID; var Params: TDispParams); virtual;
{$IFDEF CPUX86}
    procedure D2InvokeEvent(DispID: TDispID; var Params: TDispParams);
{$ENDIF}
    procedure GetEventMethod(DispID: TDispID; var Method: TMethod);
    procedure InitControlInterface(const Obj: IUnknown); virtual;
    function GetByteProp(Index: Integer): Byte;
    function GetColorProp(Index: Integer): TColor;
    function GetTColorProp(Index: Integer): TColor;
    function GetCompProp(Index: Integer): Comp;
    function GetCurrencyProp(Index: Integer): Currency;
    function GetDoubleProp(Index: Integer): Double;
    function GetIDispatchProp(Index: Integer): IDispatch;
    function GetIntegerProp(Index: Integer): Integer;
    function GetIUnknownProp(Index: Integer): IUnknown;
    function GetWordBoolProp(Index: Integer): WordBool;
    function GetTDateTimeProp(Index: Integer): TDateTime;
    function GetOleBoolProp(Index: Integer): TOleBool;
    function GetOleDateProp(Index: Integer): TOleDate;
    function GetOleEnumProp(Index: Integer): TOleEnum;
    function GetTOleEnumProp(Index: Integer): TOleEnum;
    function GetOleVariantProp(Index: Integer): OleVariant;
    procedure GetProperty(Index: Integer; var Value: TVarData);
    function GetShortIntProp(Index: Integer): ShortInt;
    function GetSingleProp(Index: Integer): Single;
    function GetSmallintProp(Index: Integer): Smallint;
    function GetStringProp(Index: Integer): string;
    function GetVariantProp(Index: Integer): Variant;
    function GetWideStringProp(Index: Integer): WideString;
    function GetWordProp(Index: Integer): Word;

    procedure SetByteProp(Index: Integer; Value: Byte);
    procedure SetColorProp(Index: Integer; Value: TColor);
    procedure SetTColorProp(Index: Integer; Value: TColor);
    procedure SetCompProp(Index: Integer; const Value: Comp);
    procedure SetCurrencyProp(Index: Integer; const Value: Currency);
    procedure SetDoubleProp(Index: Integer; const Value: Double);
    procedure SetIDispatchProp(Index: Integer; const Value: IDispatch);
    procedure SetIntegerProp(Index: Integer; Value: Integer);
    procedure SetIUnknownProp(Index: Integer; const Value: IUnknown);
    procedure SetName(const Value: TComponentName); override;
    procedure SetWordBoolProp(Index: Integer; Value: WordBool);
    procedure SetTDateTimeProp(Index: Integer; const Value: TDateTime);
    procedure SetOleBoolProp(Index: Integer; Value: TOleBool);
    procedure SetOleDateProp(Index: Integer; const Value: TOleDate);
    procedure SetOleEnumProp(Index: Integer; Value: TOleEnum);
    procedure SetTOleEnumProp(Index: Integer; Value: TOleEnum);
    procedure SetOleVariantProp(Index: Integer; const Value: OleVariant);
    procedure SetProperty(Index: Integer; const Value: TVarData);
    procedure SetShortIntProp(Index: Integer; Value: Shortint);
    procedure SetSingleProp(Index: Integer; const Value: Single);
    procedure SetSmallintProp(Index: Integer; Value: Smallint);
    procedure SetStringProp(Index: Integer; const Value: string);
    procedure SetVariantProp(Index: Integer; const Value: Variant);
    procedure SetWideStringProp(Index: Integer; const Value: WideString);
    procedure SetWordProp(Index: Integer; Value: Word);

    procedure InitControlData; virtual; abstract;
    procedure CreateWnd; virtual;
    procedure DestroyWnd; virtual; abstract;
    procedure DestroyHandle; virtual;
    procedure DestroyWindowHandle; virtual;
    procedure SetBounds(ALeft, ATop, AWidth, AHeight: Integer); virtual;
  public
    property ControlData: PControlData read FControlData write FControlData;
    property OleObject: Variant read GetOleObject;
    constructor Create(ADelegate: IOLEFrameworkDelegate); reintroduce;
    procedure DoObjectVerb(Verb: Integer);
    destructor Destroy; override;
    property MiscStatus: LongInt read FMiscStatus;
  end;

  function CreateOleVarArray(const Args: array of OleVariant): TOleVariantArray;

implementation

uses
  System.Win.ComConst;

const
  // The following flags may be or'd into the TControlData.Reserved field to override
  // default behaviors.
  // cdForceSetClientSite:
  //   Call SetClientSite early (in constructor) regardless of misc status flags
  cdForceSetClientSite = 1;
  // cdDeferSetClientSite:
  //   Don't call SetClientSite early.  Takes precedence over cdForceSetClientSite and misc status flags
  cdDeferSetClientSite = 2;

function CreateOleVarArray(const Args: array of OleVariant): TOleVariantArray;
var
  I: Integer;
begin
  SetLength(Result, Length(Args));
  for I :=0 to Length(Args) - 1 do
    Result[I] := Args[I];
end;

{ TDelegatedOleControl }

function TDelegatedOleControl.GetOleBoolProp(Index: Integer): TOleBool;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VBoolean;
end;

function TDelegatedOleControl.GetOleDateProp(Index: Integer): TOleDate;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VDate;
end;

function TDelegatedOleControl.GetOleEnumProp(Index: Integer): TOleEnum;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetOleObject: Variant;
begin
  CreateControl;
  Result := Variant(FOleObject as IDispatch);
end;

function TDelegatedOleControl.GetOleVariantProp(Index: Integer): OleVariant;
begin
  VarClear(Result);
  GetProperty(Index, TVarData(Result));
end;

var  // init to zero, never written to
  DispParams: TDispParams = ();

procedure TDelegatedOleControl.GetProperty(Index: Integer; var Value: TVarData);
var
  Status: HResult;
  ExcepInfo: TExcepInfo;
begin
  CreateControl;
  Value.VType := varEmpty;
  Status := FControlDispatch.Invoke(Index, GUID_NULL, 0, DISPATCH_PROPERTYGET, DispParams, @Value, @ExcepInfo, nil);
  if Status <> 0 then
    DispatchInvokeError(Status, ExcepInfo);
end;


function TDelegatedOleControl.GetShortIntProp(Index: Integer): ShortInt;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetSingleProp(Index: Integer): Single;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VSingle;
end;

function TDelegatedOleControl.GetSmallintProp(Index: Integer): Smallint;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VSmallint;
end;

function TDelegatedOleControl.GetStringProp(Index: Integer): string;
begin
  Result := GetVariantProp(Index);
end;

function TDelegatedOleControl.GetTColorProp(Index: Integer): TColor;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetTDateTimeProp(Index: Integer): TDateTime;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VDate;
end;

function TDelegatedOleControl.GetTOleEnumProp(Index: Integer): TOleEnum;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TDelegatedOleControl.GetVariantProp(Index: Integer): Variant;
begin
  Result := GetOleVariantProp(Index);
end;

function TDelegatedOleControl.GetWideStringProp(Index: Integer): WideString;
var
  Temp: TVarData;
begin
  Result := '';
  GetProperty(Index, Temp);
  Pointer(Result) := Temp.VOleStr;
end;

function TDelegatedOleControl.GetWindow(out wnd: HWnd): HResult;
begin
  Result := S_OK;
  wnd := FDelegate.GetParentHandle;
  if wnd = 0 then
    Result := E_FAIL;
end;

function TDelegatedOleControl.GetWindowContext(out frame: IOleInPlaceFrame; out doc: IOleInPlaceUIWindow; out rcPosRect,
  rcClipRect: TRect; out frameInfo: TOleInPlaceFrameInfo): HResult;
begin
  frame := Self;
  doc := nil;
  rcPosRect := FDelegate.GetBoundsRect;
  SetRect(rcClipRect, 0, 0, 32767, 32767);
  with frameInfo do
  begin
    fMDIApp := False;
    hWndFrame := FDelegate.GetTopParentHandle;
    hAccel := 0;
    cAccelEntries := 0;
  end;
  Result := S_OK;
end;

function TDelegatedOleControl.GetWordBoolProp(Index: Integer): WordBool;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VBoolean;
end;

function TDelegatedOleControl.GetWordProp(Index: Integer): Word;
begin
  Result := GetIntegerProp(Index);
end;

procedure TDelegatedOleControl.HookControlWndProc;
var
  WndHandle: HWnd;
begin
  if (FOleInPlaceObject <> nil) and (FDelegate.WindowHandle = 0) then
  begin
    WndHandle := 0;
    FOleInPlaceObject.GetWindow(WndHandle);
    if WndHandle = 0 then
      raise EOleError.CreateRes(@SNoWindowHandle);
    FDelegate.WindowHandle := WndHandle;
    FDelegate.DefWndProc := Pointer(GetWindowLong(FDelegate.WindowHandle, GWL_WNDPROC));
    FDelegate.SetCreationControl;
    SetWindowLong(FDelegate.WindowHandle, GWL_WNDPROC, Longint(FDelegate.InitWindowProc));
    SendMessage(FDelegate.WindowHandle, WM_NULL, 0, 0);
  end;
end;

{$IFDEF CPUX86}
type
  PVarArg = ^TVarArg;
  TVarArg = array[0..3] of DWORD;

procedure TDelegatedOleControl.D2InvokeEvent(DispID: TDispID; var Params: TDispParams);
type
  TStringDesc = record
    PStr: Pointer;
    BStr: PBStr;
  end;
var
  I, J, K, ArgType, ArgCount, StrCount: Integer;
  ArgPtr: PEventArg;
  ParamPtr: PVarArg;
  Strings: array[0..MaxDispArgs - 1] of TStringDesc;
  EventInfo: TEventInfo;
begin
  GetEventMethod(DispID, EventInfo.Method);
  if Integer(EventInfo.Method.Code) >= $10000 then
  begin
    StrCount := 0;
    try
      ArgCount := Params.cArgs;
      EventInfo.Sender := Self;
      EventInfo.ArgCount := ArgCount;
      if ArgCount <> 0 then
      begin
        ParamPtr := @Params.rgvarg^[EventInfo.ArgCount];
        ArgPtr := @EventInfo.Args;
        I := 0;
        repeat
          Dec(PByte(ParamPtr), SizeOf(TVarArg));
          ArgType := ParamPtr^[0] and $0000FFFF;
          if ArgType and varTypeMask = varOleStr then
          begin
            ArgPtr^.Kind := akDWord;
            with Strings[StrCount] do
            begin
              PStr := nil;
              if ArgType and varByRef <> 0 then
              begin
                OleStrToStrVar(PBStr(ParamPtr^[2])^, AnsiString(PStr));
                BStr := PBStr(ParamPtr^[2]);
                ArgPtr^.Data[0] := Integer(@PStr);
              end else
              begin
                OleStrToStrVar(TBStr(ParamPtr^[2]), AnsiString(PStr));
                BStr := nil;
                ArgPtr^.Data[0] := Integer(PStr);
              end;
            end;
            Inc(StrCount);
          end else
          begin
            case ArgType of
              varSingle:
                begin
                  ArgPtr^.Kind := akSingle;
                  ArgPtr^.Data[0] := ParamPtr^[2];
                end;
              varDouble..varDate:
                begin
                  ArgPtr^.Kind := akDouble;
                  ArgPtr^.Data[0] := ParamPtr^[2];
                  ArgPtr^.Data[1] := ParamPtr^[3];
                end;
              varDispatch:
                begin
                  ArgPtr^.Kind := akDWord;
                  ArgPtr^.Data[0] := Integer(ParamPtr)
                end;
            else
              ArgPtr^.Kind := akDWord;
              if (ArgType and varArray) <> 0 then
                ArgPtr^.Data[0] := Integer(ParamPtr)
              else
                ArgPtr^.Data[0] := ParamPtr^[2];
            end;
          end;
          Inc(PByte(ArgPtr), SizeOf(TEventArg));
          Inc(I);
        until I = EventInfo.ArgCount;
      end;
      J := StrCount;
      while J <> 0 do
      begin
        Dec(J);
        with Strings[J] do
          if BStr <> nil then BStr^ := StringToOleStr(string(PStr));
      end;
    except
      raise;
    end;
    K := StrCount;
    while K <> 0 do
    begin
      Dec(K);
      string(Strings[K].PStr) := '';
    end;
  end;
end;
{$ENDIF CPUX86}

procedure TDelegatedOleControl.InitControlInterface(const Obj: IInterface);
begin
end;

function TDelegatedOleControl.InsertMenus(hmenuShared: HMenu; var menuWidths: TOleMenuGroupWidths): HResult;
begin
  Result := E_NOTIMPL;
end;

function StringToVarOleStr(const S: string): Variant;
begin
  VarClear(Result);
  TVarData(Result).VOleStr := StringToOleStr(S);
  TVarData(Result).VType := varOleStr;
end;

function TDelegatedOleControl.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params;
  VarResult, ExcepInfo, ArgErr: Pointer): HResult;
begin
  if (Flags and DISPATCH_PROPERTYGET <> 0) and (VarResult <> nil) then
  begin
    Result := S_OK;
    case DispID of
      DISPID_AMBIENT_DISPLAYNAME:
        PVariant(VarResult)^ := StringToVarOleStr(Name);
      DISPID_AMBIENT_LOCALEID:
        PVariant(VarResult)^ := Integer(GetUserDefaultLCID);
      DISPID_AMBIENT_MESSAGEREFLECT:
        PVariant(VarResult)^ := True;
      DISPID_AMBIENT_USERMODE:
        PVariant(VarResult)^ := not (csDesigning in ComponentState);
      DISPID_AMBIENT_UIDEAD:
        PVariant(VarResult)^ := csDesigning in ComponentState;
      DISPID_AMBIENT_SHOWGRABHANDLES:
        PVariant(VarResult)^ := False;
      DISPID_AMBIENT_SHOWHATCHING:
        PVariant(VarResult)^ := False;
      DISPID_AMBIENT_SUPPORTSMNEMONICS:
        PVariant(VarResult)^ := True;
      DISPID_AMBIENT_AUTOCLIP:
        PVariant(VarResult)^ := True;
    else
      Result := DISP_E_MEMBERNOTFOUND;
    end;
  end else
    Result := DISP_E_MEMBERNOTFOUND;
end;

procedure TDelegatedOleControl.GetEventMethod(DispID: TDispID; var Method: TMethod);
{$IFDEF PUREPASCAL}
const
  ALIGN_VAL = $8;
var
  P2: PControlData2;
  Index: Integer;
  Size: LongInt;
  PID: ^LongInt;
  PHandler: Pointer;
begin
  PID := FControlData^.EventDispIDs;
  for Index := 0 to FControlData^.EventCount-1 do
  begin
    if DispID = PID^ then
      break;
    Inc(PID);
  end;

  if Index = FControlData^.EventCount then
  begin
    Method.Code := nil;
    Method.Data := nil;
    Exit;
  end;

  Assert(Index >= 0);
  Assert(Index < FControlData^.EventCount);

  PHandler := nil;
  if (FControlData^.Version >= 401) then
  begin
    P2 := PControlData2(FControlData);
    if (P2^.FirstEventOfs <> 0) then
      PHandler := PByte(Self) + P2^.FirstEventOfs;
  end;

  if (PHandler = nil) then
  begin
    Size := Self.ClassParent.InstanceSize;
    Size := Size - SizeOf(Pointer); // TMonitor
    Size := Size + ALIGN_VAL;
    Size := Size and (not ALIGN_VAL);
    PHandler := PByte(Self) + Size;
  end;

  Assert(PHandler <> nil);
  // Size of any closure will do here!
  PHandler := PByte(PHandler) + (Index*Sizeof(TNotifyEvent));

  Method.Code := PPointer(PHandler)^;
  Method.Data := PPointer(PByte(PHandler) + Sizeof(Pointer))^;
end;
{$ENDIF}
{$IFDEF CPUX86}
asm
        PUSH    EBX
        PUSH    ESI
        PUSH    EDI
        PUSH    ECX
        MOV     EBX,EAX
        MOV     ECX,[EBX].TDelegatedOleControl.FControlData
        MOV     EDI,[ECX].TControlData.EventCount
        MOV     ESI,[ECX].TControlData.EventDispIDs
        XOR     EAX,EAX
        JMP     @@1
@@0:    CMP     EDX,[ESI].Integer[EAX*4]
        JE      @@2
        INC     EAX
@@1:    CMP     EAX,EDI
        JNE     @@0
        XOR     EAX,EAX
        XOR     EDX,EDX
        JMP     @@3
@@2:    PUSH    EAX
        CMP     [ECX].TControlData.Version, 401
        JB      @@2a
        MOV     EAX, [ECX].TControlData2.FirstEventOfs
        TEST    EAX, EAX
        JNE     @@2b
@@2a:   MOV     EAX, [EBX]
        CALL    TObject.ClassParent
        CALL    TObject.InstanceSize
        ADD     EAX, 7
        AND     EAX, not 7  // 8 byte alignment
@@2b:   ADD     EBX, EAX
        POP     EAX
        MOV     EDX,[EBX][EAX*8].TMethod.Data
        MOV     EAX,[EBX][EAX*8].TMethod.Code
@@3:    POP     ECX
        MOV     [ECX].TMethod.Code,EAX
        MOV     [ECX].TMethod.Data,EDX
        POP     EDI
        POP     ESI
        POP     EBX
end;
{$ENDIF CPUX86}

{$IFDEF CPUX64}
type
  PParamBlock = ^TParamBlock;
  TParamBlock = record
    RegRCX: Int64;
    RegRDX: Int64;
    RegR8: Int64;
    RegR9: Int64;
    StackData: PByte;
    StackDataSize: Integer;
    OutRAX: Int64;
    OutXMM0: Double;
  end;

procedure RawInvoke(CodeAddress: Pointer; ParamBlock: PParamBlock);

  procedure InvokeError;
  begin
    raise Exception.CreateRes(@sParameterCountExceeded);
  end;

asm
      .PARAMS 62 // There's actually room for 64, assembler is saving locals for CodeAddress & ParamBlock
      MOV     [RBP+$210], CodeAddress                                                 
      MOV     [RBP+$218], ParamBlock
      MOV     EAX, [ParamBlock].TParamBlock.StackDataSize
      TEST    EAX, EAX                                          
      JZ      @@skip_push
      CMP     EAX, 480 // (64-4) params * 8 bytes.
      JBE     @@valid_frame

      Call InvokeError
@@valid_frame:
      // All items on stack should be 16 byte aligned. Caller should
      // have handled that, just copy data here.
      MOV     RCX, [ParamBlock].TParamBlock.StackData
      LEA     RDX, [RBP+$20]
      MOVSX   R8,  EAX                                      
      CALL    Move     // RCX: source, RDX: dest, R8, count
      MOV     RDX, [RBP+$218]

@@skip_push:
      MOV     RCX, [RDX].TParamBlock.RegRCX
      MOV     R8,  [RDX].TParamBlock.RegR8
      MOV     R9,  [RDX].TParamBlock.RegR9

      MOVSD   XMM0,[RDX].TParamBlock.RegRCX
      MOVSD   XMM1,[RDX].TParamBlock.RegRDX
      MOVSD   XMM2,[RDX].TParamBlock.RegR8
      MOVSD   XMM3,[RDX].TParamBlock.RegR9

      MOV     RDX, [RDX].TParamBlock.RegRDX

      CALL    [RBP+$210]

      MOV     RDX, [RBP+$218]
      MOV     [RDX].TParamBlock.OutRAX, RAX
      MOVSD   [RDX].TParamBlock.OutXMM0, XMM0

end;
{$ENDIF CPUX64}

procedure TDelegatedOleControl.InvokeEvent(DispID: TDispID; var Params: TDispParams);
{$IFDEF CPUX64}
var
  EventMethod: TMethod;
  ParamBlock : TParamBlock;
  i : Integer;
  StackParams2 : array of Int64;

begin
  GetEventMethod(DispID, EventMethod);
  if Integer(EventMethod.Code) < $10000 then Exit;

  ParamBlock.RegRCX := Int64(EventMethod.Data);
  ParamBlock.RegRDX := Int64(Self);

  if Params.cArgs > 2 then
  begin
    SetLength(StackParams2, Params.cArgs-2);
  end;

  for i := 1 to Params.cArgs do
    case i of
      1: ParamBlock.RegR8  := Int64(Params.rgvarg[Params.cArgs-1].unkVal);
      2: ParamBlock.RegR9  := Int64(Params.rgvarg[Params.cArgs-2].unkVal);
    else
      StackParams2[i-3] := Int64(Params.rgvarg[Params.cArgs-i].unkVal);
    end;

  ParamBlock.StackDataSize := Length(StackParams2) * sizeof(Pointer);

  if Length(StackParams2) > 0 then
    ParamBlock.StackData := @StackParams2[0];

  RawInvoke(EventMethod.Code, @ParamBlock);
end;
{$ELSE !CPUX64}
{$IFDEF CPUX86}
var
  EventMethod: TMethod;
begin
  if ControlData.Version < 300 then
    D2InvokeEvent(DispID, Params)
  else
  begin
    GetEventMethod(DispID, EventMethod);
    if Integer(EventMethod.Code) < $10000 then Exit;

    try
      asm
                PUSH    EBX
                PUSH    ESI
                MOV     ESI, Params
                MOV     EBX, [ESI].TDispParams.cArgs
                TEST    EBX, EBX
                JZ      @@7
                MOV     ESI, [ESI].TDispParams.rgvarg
                MOV     EAX, EBX
                SHL     EAX, 4                         // count * sizeof(TVarArg)
                XOR     EDX, EDX
                ADD     ESI, EAX                       // EDI = Params.rgvarg^[ArgCount]
        @@1:    SUB     ESI, 16                        // Sizeof(TVarArg)
                MOV     EAX, dword ptr [ESI]
                CMP     AX, varSingle                  // 4 bytes to push
                JA      @@3
                JE      @@5
        @@2:    TEST    DL,DL
                JNE     @@2a
                MOV     ECX, ESI
                INC     DL
                TEST    EAX, varArray
                JNZ     @@6
                MOV     ECX, dword ptr [ESI+8] // arg3
                JMP     @@6
        @@2a:   TEST    EAX, varArray
                JZ      @@5
                PUSH    ESI
                JMP     @@6
        @@3:    CMP     AX, varDate                    // 8 bytes to push
                JA      @@2
        @@4:    PUSH    dword ptr [ESI+12]
        @@5:    PUSH    dword ptr [ESI+8]
        @@6:    DEC     EBX
                JNE     @@1
        @@7:    MOV     EDX, Self             // arg2
                MOV     EAX, EventMethod.Data // arg1
                CALL    EventMethod.Code
                POP     ESI
                POP     EBX
      end;
    except
      raise;
    end;
  end;
end;
{$ENDIF CPUX86}
{$ENDIF !CPUX64}

function TDelegatedOleControl.LockInPlaceActive(fLock: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.OleControlSite_TranslateAccelerator(msg: PMsg; grfModifiers: Integer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.OleInPlaceFrame_TranslateAccelerator(var msg: TMsg; wID: Word): HResult;
begin
  Result := S_FALSE;
end;

function TDelegatedOleControl.OnChanged(dispid: TDispID): HResult;
begin
  Result := S_OK;
end;

procedure TDelegatedOleControl.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin

end;

procedure TDelegatedOleControl.WMPaint(var Message: TWMPaint);
var
  DC: HDC;
  PS: TPaintStruct;
begin
  if FMiscStatus and OLEMISC_INVISIBLEATRUNTIME <> 0 then
  begin
    DC := Message.DC;
    if DC = 0 then DC := BeginPaint(FDelegate.Handle, PS);
{$IFDEF MSWINDOWS}
    OleDraw(FOleObject, DVASPECT_CONTENT, DC, FDelegate.GetBoundsRect);
{$ENDIF}
    if Message.DC = 0 then EndPaint(FDelegate.Handle, PS);
  end else
    inherited;
end;

{IUnknown }
function TDelegatedOleControl.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then Result := S_OK else Result := E_NOINTERFACE;
end;

function TDelegatedOleControl._AddRef: Integer; stdcall;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TDelegatedOleControl._Release: Integer; stdcall;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

function TDelegatedOleControl.OnControlInfoChanged: HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.OnFocus(fGotFocus: BOOL): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.OnInPlaceActivate: HResult;
begin
  FOleObject.QueryInterface(IOleInPlaceObject, FOleInPlaceObject);
  FOleObject.QueryInterface(IOleInPlaceActiveObject, FOleInPlaceActiveObject);
  Result := S_OK;
end;

function TDelegatedOleControl.OnInPlaceDeactivate: HResult;
begin
  FOleInPlaceActiveObject := nil;
  FOleInPlaceObject := nil;
  Result := S_OK;
end;

function TDelegatedOleControl.OnPosRectChange(const rcPosRect: TRect): HResult;
begin
  FOleInPlaceObject.SetObjectRects(rcPosRect, Rect(0, 0, 32767, 32767));
  Result := S_OK;
end;

function TDelegatedOleControl.OnRequestEdit(dispid: TDispID): HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.OnShowWindow(fShow: BOOL): HResult;
begin
  Result := S_OK;
end;

procedure TDelegatedOleControl.SetUIActive(Active: Boolean);
begin

end;

function TDelegatedOleControl.OnUIActivate: HResult;
begin
  SetUIActive(True);
  Result := S_OK;
end;

function TDelegatedOleControl.OnUIDeactivate(fUndoable: BOOL): HResult;
begin
  SetMenu(0, 0, 0);
  SetUIActive(False);
  Result := S_OK;
end;

function TDelegatedOleControl.PostMessageFilter(wnd: HWnd; msg: UInt; wp: WPARAM; lp: LPARAM;
  out res: LRESULT; Cookie: DWORD): HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.PreMessageFilter(wnd: HWnd; msg: UInt; wp: WPARAM; lp: LPARAM;
  out res: LRESULT; out Cookie: DWORD): HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.QueryService(const rsid, iid: TGuid; out Obj): HResult;
begin
  if Assigned(FServiceQuery) then
    Result := FServiceQuery(rsid, iid, Obj)
  else
    Result := E_NOTIMPL;
end;

function TDelegatedOleControl.RemoveMenus(hmenuShared: HMenu): HResult;
begin
  while GetMenuItemCount(hmenuShared) > 0 do
    RemoveMenu(hmenuShared, 0, MF_BYPOSITION);
  Result := S_OK;
end;

function TDelegatedOleControl.RequestBorderSpace(const borderwidths: TRect): HResult;
begin
  Result := INPLACE_E_NOTOOLSPACE;
end;

function TDelegatedOleControl.RequestNewObjectLayout: HResult;
var
  Extent: TPoint;
begin
  Result := FOleObject.GetExtent(DVASPECT_CONTENT, Extent);
end;

function TDelegatedOleControl.SaveObject: HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.Scroll(scrollExtent: TPoint): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.SetActiveObject(const activeObject: IOleInPlaceActiveObject;
  pszObjName: POleStr): HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.SetBorderSpace(pborderwidths: PRect): HResult;
begin
  Result := E_NOTIMPL;
end;

procedure TDelegatedOleControl.SetBounds(ALeft, ATop, AWidth, AHeight: Integer);
var
  LRect: TRect;
{$IFDEF WIN64}
  Temp: TPoint;
{$ENDIF}
begin
  LRect := FDelegate.GetBoundsRect;
  LRect := RectF(LRect.Left, LRect.Top, LRect.Left+AWidth, LRect.Top+AHeight).Round;
  if FOleInPlaceObject <> nil then
    FOleInplaceObject.SetObjectRects(LRect, LRect);
  if ((AWidth <> LRect.Width) and (LRect.Width > 0)) or ((AHeight <> LRect.Height) and (LRect.Height > 0)) then
  begin
{$IFDEF WIN64}
    Temp := Point(MulDiv(AWidth, 2540, 100), MulDiv(AHeight, 2540, 100));
    if (FMiscStatus and OLEMISC_INVISIBLEATRUNTIME <> 0) or
      ((FOleObject.SetExtent(DVASPECT_CONTENT, @Temp) <> S_OK)) then
{$ELSE}
    if (FMiscStatus and OLEMISC_INVISIBLEATRUNTIME <> 0) or
      ((FOleObject.SetExtent(DVASPECT_CONTENT, Point(
        MulDiv(AWidth, 2540, 100),
        MulDiv(AHeight, 2540, 100))) <> S_OK)) then
{$ENDIF}
    if FOleInplaceObject <> nil then
      FOleInplaceObject.SetObjectRects(LRect, LRect);
  end;
end;

procedure TDelegatedOleControl.SetByteProp(Index: Integer; Value: Byte);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetColorProp(Index: Integer; Value: TColor);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetCompProp(Index: Integer; const Value: Comp);
var
  Temp: TVarData;
begin
  Temp.VType := VT_I8;
  Temp.VDouble := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetCurrencyProp(Index: Integer; const Value: Currency);
var
  Temp: TVarData;
begin
  Temp.VType := varCurrency;
  Temp.VCurrency := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetDoubleProp(Index: Integer; const Value: Double);
var
  Temp: TVarData;
begin
  Temp.VType := varDouble;
  Temp.VDouble := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetIDispatchProp(Index: Integer; const Value: IDispatch);
var
  Temp: TVarData;
begin
  Temp.VType := varDispatch;
  Temp.VDispatch := Pointer(Value);
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetIntegerProp(Index, Value: Integer);
var
  Temp: TVarData;
begin
  Temp.VType := varInteger;
  Temp.VInteger := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetIUnknownProp(Index: Integer; const Value: IInterface);
var
  Temp: TVarData;
begin
  Temp.VType := VT_UNKNOWN;
  Temp.VUnknown := Pointer(Value);
  SetProperty(Index, Temp);
end;

function TDelegatedOleControl.SetMenu(hmenuShared, holemenu: HMenu; hwndActiveObject: HWnd): HResult;
begin
  // requires the implementation
  Result := S_OK;
end;

procedure TDelegatedOleControl.SetName(const Value: TComponentName);
begin
  inherited;
end;

procedure TDelegatedOleControl.SetOleBoolProp(Index: Integer; Value: TOleBool);
var
  Temp: TVarData;
begin
  Temp.VType := varBoolean;
  if Value then
    Temp.VBoolean := WordBool(-1) else
    Temp.VBoolean := WordBool(0);
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetOleDateProp(Index: Integer; const Value: TOleDate);
var
  Temp: TVarData;
begin
  Temp.VType := varDate;
  Temp.VDate := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetOleEnumProp(Index: Integer; Value: TOleEnum);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetOleVariantProp(Index: Integer; const Value: OleVariant);
begin
  SetProperty(Index, TVarData(Value));
end;

procedure TDelegatedOleControl.SetProperty(Index: Integer; const Value: TVarData);
const
  DispIDArgs: Longint = DISPID_PROPERTYPUT;
var
  Status, InvKind: Integer;
  DispParams: TDispParams;
  ExcepInfo: TExcepInfo;
begin
  CreateControl;
  DispParams.rgvarg := @Value;
  DispParams.rgdispidNamedArgs := @DispIDArgs;
  DispParams.cArgs := 1;
  DispParams.cNamedArgs := 1;
  if Value.VType <> varDispatch then
    InvKind := DISPATCH_PROPERTYPUT
  else
    InvKind := DISPATCH_PROPERTYPUTREF;
  Status := FControlDispatch.Invoke(Index, GUID_NULL, 0, InvKind, DispParams, nil, @ExcepInfo, nil);
  if Status <> 0 then
    DispatchInvokeError(Status, ExcepInfo);
end;

procedure TDelegatedOleControl.SetShortIntProp(Index: Integer; Value: Shortint);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetSingleProp(Index: Integer; const Value: Single);
var
  Temp: TVarData;
begin
  Temp.VType := varSingle;
  Temp.VSingle := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetSmallintProp(Index: Integer; Value: Smallint);
var
  Temp: TVarData;
begin
  Temp.VType := varSmallint;
  Temp.VSmallint := Value;
  SetProperty(Index, Temp);
end;

function TDelegatedOleControl.SetStatusText(pszStatusText: POleStr): HResult;
begin
  Result := S_OK;
end;

procedure TDelegatedOleControl.SetStringProp(Index: Integer; const Value: string);
var
  Temp: TVarData;
begin
  Temp.VType := varOleStr;
  Temp.VOleStr := StringToOleStr(Value);
  try
    SetProperty(Index, Temp);
  finally
    SysFreeString(Temp.VOleStr);
  end;
end;

procedure TDelegatedOleControl.SetTColorProp(Index: Integer; Value: TColor);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetTDateTimeProp(Index: Integer; const Value: TDateTime);
var
  Temp: TVarData;
begin
  Temp.VType := varDate;
  Temp.VDate := Value;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetTOleEnumProp(Index: Integer; Value: TOleEnum);
begin
  SetIntegerProp(Index, Value);
end;

procedure TDelegatedOleControl.SetVariantProp(Index: Integer; const Value: Variant);
begin
  SetOleVariantProp(Index, Value);
end;

procedure TDelegatedOleControl.SetWideStringProp(Index: Integer; const Value: WideString);
var
  Temp: TVarData;
begin
  Temp.VType := varOleStr;
  if Value <> '' then
    Temp.VOleStr := PWideChar(Value)
  else
    Temp.VOleStr := nil;
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetWordBoolProp(Index: Integer; Value: WordBool);
var
  Temp: TVarData;
begin
  Temp.VType := varBoolean;
  if Value then
    Temp.VBoolean := WordBool(-1)
  else
    Temp.VBoolean := WordBool(0);
  SetProperty(Index, Temp);
end;

procedure TDelegatedOleControl.SetWordProp(Index: Integer; Value: Word);
begin
  SetIntegerProp(Index, Value);
end;

function TDelegatedOleControl.ShowObject: HResult;
begin
  HookControlWndProc;
  Result := S_OK;
end;

function TDelegatedOleControl.ShowPropertyFrame: HResult;
begin
  Result := E_NOTIMPL;
end;

procedure TDelegatedOleControl.StandardEvent(DispID: TDispID; var Params: TDispParams);
begin

end;

function TDelegatedOleControl.TransformCoords(var ptlHimetric: TPoint; var ptfContainer: TPointF;
  flags: Integer): HResult;
begin
  // requires the implementation
  Result := S_OK;
end;

function TDelegatedOleControl.CanInPlaceActivate: HResult;
begin
  Result := S_OK;
end;

function TDelegatedOleControl.ContextSensitiveHelp(fEnterMode: BOOL): HResult;
begin
  Result := S_OK;
end;

procedure TDelegatedOleControl.DoObjectVerb(Verb: Integer);
var
  ActiveWindow: HWnd;
begin
  CreateControl;
  ActiveWindow := GetActiveWindow;
  try
    OleCheck(FOleObject.DoVerb(Verb, nil, Self, 0, FDelegate.GetParentHandle, FDelegate.GetBoundsRect));
  finally
    SetActiveWindow(ActiveWindow);
    Winapi.Windows.SetFocus(ActiveWindow);
  end;
end;

constructor TDelegatedOleControl.Create(ADelegate: IOLEFrameworkDelegate);
begin
  FDelegate := ADelegate;
  FDelegate.SetDispatcher(FrameworksDispatcher);
  InitControlData;
  Inc(FControlData^.InstanceCount);
  FEventDispatch := TEventDispatch.Create(Self);
  CreateInstance;
  InitControlInterface(FOleObject);
  OleCheck(FOleObject.GetMiscStatus(DVASPECT_CONTENT, FMiscStatus));
  if (FControlData^.Reserved and cdDeferSetClientSite) = 0 then
    if ((FMiscStatus and OLEMISC_SETCLIENTSITEFIRST) <> 0) or ((FControlData^.Reserved and cdForceSetClientSite) <> 0)
      then
      OleCheck(FOleObject.SetClientSite(Self));
  OleCheck(FOleObject.QueryInterface(IPersistStreamInit, FPersistStream));
  if FMiscStatus and OLEMISC_INVISIBLEATRUNTIME <> 0 then
    FDelegate.Visible := False;
  OleCheck(RequestNewObjectLayout);
end;

procedure TDelegatedOleControl.CreateControl;
var
  Stream: IStream;
  CS: IOleClientSite;
  X: Integer;
begin
  FOleControl := nil;
  if FOleControl = nil then
    try
      try  // work around ATL bug
        X := FOleObject.GetClientSite(CS);
      except
        X := -1;
      end;
      if (X <> 0) or (CS = nil) then
        OleCheck(FOleObject.SetClientSite(Self));
      if (FObjectData = 0) and Assigned(FPersistStream) then
        OleCheck(FPersistStream.InitNew)
      else
      begin
        OleCheck(CreateStreamOnHGlobal(FObjectData, False, Stream));
        OleCheck(FPersistStream.Load(Stream));
        DestroyStorage;
      end;
      OleCheck(FOleObject.QueryInterface(IOleControl, FOleControl));
      FControlInfo.cb := SizeOf(FControlInfo);
      FOleControl.GetControlInfo(FControlInfo);
      OleCheck(FOleObject.QueryInterface(IDispatch, FControlDispatch));
      InterfaceConnect(FOleObject, IPropertyNotifySink, Self, FPropConnection);
      InterfaceConnect(FOleObject, FControlData^.EventIID, FEventDispatch, FEventsConnection);
{
      if FControlData^.Flags then
        OnChanged(DISPID_BACKCOLOR);
      if FControlData^.Flags and cfEnabled <> 0 then
        OnChanged(DISPID_ENABLED);
      if FControlData^.Flags and cfFont <> 0 then
        OnChanged(DISPID_FONT);
      if FControlData^.Flags and cfForeColor <> 0 then
        OnChanged(DISPID_FORECOLOR);
}
      FOleControl.OnAmbientPropertyChange(DISPID_UNKNOWN);
      RequestNewObjectLayout;
    except
      DestroyControl;
      raise;
    end;
end;

procedure TDelegatedOleControl.CreateInstance;
var
  ClassFactory2: IClassFactory2;
  LicKeyStr: WideString;

  procedure LicenseCheck(Status: HResult; const Ident: string);
  begin
    if Status = CLASS_E_NOTLICENSED then
      raise EOleError.CreateFmt(Ident, [ClassName]);
    OleCheck(Status);
  end;

begin
  if (FControlData^.LicenseKey <> nil) then
  begin
    OleCheck(CoGetClassObject(FControlData^.ClassID, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, nil, IClassFactory2,
      ClassFactory2));
    LicKeyStr := PWideChar(FControlData^.LicenseKey);
    LicenseCheck(ClassFactory2.CreateInstanceLic(nil, nil, IOleObject, LicKeyStr, FOleObject), SInvalidLicense);
  end
  else
    LicenseCheck(CoCreateInstance(FControlData^.ClassID, nil, CLSCTX_INPROC_SERVER or CLSCTX_LOCAL_SERVER, IOleObject,
      FOleObject), SNotLicensed);
end;

procedure TDelegatedOleControl.CreateWnd;
begin
  CreateControl;
  if FMiscStatus and OLEMISC_INVISIBLEATRUNTIME = 0 then
  begin
    FOleObject.DoVerb(OLEIVERB_INPLACEACTIVATE, nil, Self, 0, FDelegate.GetParentHandle, FDelegate.GetBoundsRect);
    if FOleInPlaceObject = nil then
      raise EOleError.CreateRes(@SCannotActivate);
    HookControlWndProc;
    if not FDelegate.Visible and IsWindowVisible(FDelegate.Handle) then
      ShowWindow(FDelegate.Handle, SW_HIDE);
  end;
end;

function TDelegatedOleControl.DeactivateAndUndo: HResult;
begin
  FOleInPlaceObject.UIDeactivate;
  Result := S_OK;
end;

destructor TDelegatedOleControl.Destroy;

  procedure FreeList(var L: TList);
  var
    I: Integer;
  begin
    if L <> nil then
    begin
      for I := 0 to L.Count-1 do
        TObject(L[I]).Free;
      L.Free;
      L := nil;
    end;
  end;

begin
  // jmt.  Comment out SetUIActive because it usually doesn't do anything.
  // SetUIActive is intended to clear the parent
  // form's reference (if any) to this control.  Usually
  // TWinControl.Destroy has been called on the parent, clearing
  // this control's parent property.  So SetUIActive won't be
  // able to find the parent form.
  // TCustomForm now adds a FreeNotification on
  // FActiveOleControl for clearing the reference.

  if FOleObject <> nil then
    FOleObject.Close(OLECLOSE_NOSAVE);
  DestroyControl;
  DestroyStorage;
  Dec(FControlData^.InstanceCount);
  DestroyWindowHandle;
  inherited Destroy;
end;

procedure TDelegatedOleControl.DestroyControl;
begin
  InterfaceDisconnect(FOleObject, FControlData^.EventIID, FEventsConnection);
  InterfaceDisconnect(FOleObject, IPropertyNotifySink, FPropConnection);
  FPropBrowsing := nil;
  FControlDispatch := nil;
  FOleControl := nil;
end;

procedure TDelegatedOleControl.DestroyHandle;
begin

end;

procedure TDelegatedOleControl.DestroyStorage;
begin
  if FObjectData <> 0 then
  begin
    GlobalFree(FObjectData);
    FObjectData := 0;
  end;
end;

procedure TDelegatedOleControl.DestroyWindowHandle;
begin
  SetWindowLong(FDelegate.WindowHandle, GWL_WNDPROC, NativeInt(FDelegate.DefWndProc));
  if FOleObject <> nil then
    FOleObject.Close(OLECLOSE_NOSAVE);
  FDelegate.WindowHandle := 0;
end;

function TDelegatedOleControl.DiscardUndoState: HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.EnableModeless(fEnable: BOOL): HResult;
begin
  Result := S_OK;
end;

procedure TDelegatedOleControl.FrameworksDispatcher(DispId: Integer; var Params: TOleVariantArray);
begin
  case TInvoke(DispId) of
    TInvoke.CreateWnd:
      Self.CreateWnd;
    TInvoke.SetBounds:
      Self.SetBounds( Params[0], Params[1], Params[2], Params[3]);
    TInvoke.DestroyWindowHandle:;
  else
    Assert(False,'Unknown identifier DispId');
  end;
end;

function TDelegatedOleControl.GetBorder(out rectBorder: TRect): HResult;
begin
  Result := INPLACE_E_NOTOOLSPACE;
end;

function TDelegatedOleControl.GetByteProp(Index: Integer): Byte;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetColorProp(Index: Integer): TColor;
begin
  Result := GetIntegerProp(Index);
end;

function TDelegatedOleControl.GetCompProp(Index: Integer): Comp;
begin
  Result := GetDoubleProp(Index);
end;

function TDelegatedOleControl.GetContainer(out container: IOleContainer): HResult;
begin
  Result := E_NOINTERFACE;
end;

function TDelegatedOleControl.GetCurrencyProp(Index: Integer): Currency;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VCurrency;
end;

function TDelegatedOleControl.GetDoubleProp(Index: Integer): Double;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VDouble;
end;

function TDelegatedOleControl.GetExtendedControl(out disp: IDispatch): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.GetIDispatchProp(Index: Integer): IDispatch;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := IDispatch(Temp.VDispatch);
  IDispatch(Temp.VDispatch) := nil;
end;

function TDelegatedOleControl.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer;
  DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TDelegatedOleControl.GetIntegerProp(Index: Integer): Integer;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := Temp.VInteger;
end;

function TDelegatedOleControl.GetIUnknownProp(Index: Integer): IUnknown;
var
  Temp: TVarData;
begin
  GetProperty(Index, Temp);
  Result := IUnknown(Temp.VUnknown);
  IUnknown(Temp.VUnknown) := nil;
end;

function TDelegatedOleControl.GetMoniker(dwAssign, dwWhichMoniker: Integer; out mk: IMoniker): HResult;
begin
  Result := E_NOTIMPL;
end;

{ TEventDispatch }

constructor TEventDispatch.Create(Control: TDelegatedOleControl);
begin
  FControl := Control;
end;

function TEventDispatch.GetIDsOfNames(const IID: TGUID; Names: Pointer; NameCount, LocaleID: Integer;
  DispIDs: Pointer): HResult;
begin
  Result := E_NOTIMPL;
end;

function TEventDispatch.GetTypeInfo(Index, LocaleID: Integer; out TypeInfo): HResult;
begin
  Pointer(TypeInfo) := nil;
  Result := E_NOTIMPL;
end;

function TEventDispatch.GetTypeInfoCount(out Count: Integer): HResult;
begin
  Count := 0;
  Result := S_OK;
end;

function TEventDispatch.Invoke(DispID: Integer; const IID: TGUID; LocaleID: Integer; Flags: Word; var Params; VarResult,
  ExcepInfo, ArgErr: Pointer): HResult;
begin
  if (DispID >= DISPID_MOUSEUP) and (DispID <= DISPID_CLICK) then
    Control.StandardEvent(DispID, TDispParams(Params))
  else
    Control.InvokeEvent(DispID, TDispParams(Params));
  Result := S_OK;
end;

function TEventDispatch.QueryInterface(const IID: TGUID; out Obj): HResult;
begin
  if GetInterface(IID, Obj) then
  begin
    Result := S_OK;
    Exit;
  end;
  if Assigned(FControl) and IsEqualIID(IID, FControl.FControlData^.EventIID) then
  begin
    GetInterface(IDispatch, Obj);
    Result := S_OK;
    Exit;
  end;
  Result := E_NOINTERFACE;
end;

end.
