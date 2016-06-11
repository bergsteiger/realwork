{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Gestures.Win;

interface

{$SCOPEDENUMS ON}

uses
  Winapi.MsInkAut, Winapi.RtsCom, Winapi.TpcShrd, Winapi.Windows, System.UITypes, System.Types, System.Classes,
  System.Generics.Collections, FMX.Gestures, FMX.Types;

type
  TPlatformGestureEngine = class(TGestureEngine)
  strict private
    FControl: TComponent;
    class var FDefaultEngineClass: TGestureEngineClass;
    public class function DoGetRecognizer: TCustomGestureRecognizer; override;
    class destructor Destroy;
    class constructor Create;
  private
    function GetGestureList: TGestureList; virtual; abstract;
  protected
    class function GetGestureEngine(const AControl: TComponent): TGestureEngine; override;
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
    property Control: TComponent read FControl;
  public
    class procedure CreateEngine(AControl: TComponent);
    constructor Create(const AControl: TComponent); override;

    class property DefaultEngineClass: TGestureEngineClass read FDefaultEngineClass write FDefaultEngineClass;
    property GestureList: TGestureList read GetGestureList;
    destructor Destroy; override;
  end;

  TWinTouchGestureEngine = class sealed(TPlatformGestureEngine)
  strict private
    class var FSupported: Boolean;
    class var FSupportedTested: Boolean;
    var FActive: Boolean;
    FGestureList: TGestureList;
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    ///<summary>Returns the available gesture list that the component can manage.</summary>
    function GetGestureList: TGestureList; override;
  public
    constructor Create(const AControl: TComponent); override;
    destructor Destroy; override;
    class function Supported(const AControl: TComponent = nil): Boolean; //override;
  end;

  TWinGestureEngine = class sealed(TPlatformGestureEngine)
  strict private class var
    FControlEngineList: TDictionary<Pointer, Pointer>;

    class procedure RegisterEngineInList(const AControl: TComponent; const AEngine: TPlatformGestureEngine); static;
    class procedure UnregisterEngineFromList(const AEngine: TPlatformGestureEngine); static;
    class function GetEngineFromList(const AControl: TComponent): TPlatformGestureEngine; static;
  strict private
  type
    TRealTimeStylus = class(TInterfacedObject, IStylusAsyncPlugin)
    strict private
      // Current captured controls under the touch
      FGestureList: TGestureList;
      FCurrentControl: TComponent;

      FEnabled: Boolean;
      FGestureRecognizer: IGestureRecognizer;
      FHandle: HWND;
      FRealTimeStylus: IRealTimeStylus;
      FGestures: TGestureList;
      procedure AddStylusAsyncPlugin(const APlugin: IStylusAsyncPlugin);
      procedure AddStylusSyncPlugin(const APlugin: IStylusSyncPlugin);
      procedure SetEnabled(const Value: Boolean);
      procedure SetHandle(const Value: HWND);
      class function StandardGestureMap(const AGesture: TStandardGesture): Integer;
      class function StylusGestureMap(AGesture: Integer): Integer;
      class function GetControlUnderTouch(const Value: TPointF): TComponent;
    public // IStylusAsyncPlugin
      function RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
        var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
        var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function StylusInRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult; stdcall;
      function StylusOutOfRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult; stdcall;
      function StylusDown(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal;
        pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusUp(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal;
        pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusButtonDown(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID; const pGuidStylusButton: TGUID;
        var pStylusPos: TPoint): HResult; stdcall;
      function StylusButtonUp(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID; const pGuidStylusButton: TGUID;
        var pStylusPos: TPoint): HResult; stdcall;
      function InAirPackets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo; cPktCount: Cardinal;
        cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
        var ppInOutPkts: PInteger): HResult; stdcall;
      function Packets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo; cPktCount: Cardinal;
        cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
        var ppInOutPkts: PInteger): HResult; stdcall;
      function CustomStylusDataAdded(piRtsSrc: IRealTimeStylus; const pGuidId: TGUID; cbData: Cardinal;
        pbData: PBYTE): HResult; stdcall;
      function SystemEvent(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID; event: SYSTEM_EVENT;
        eventdata: SYSTEM_EVENT_DATA): HResult; stdcall;
      function TabletAdded(piRtsSrc: IRealTimeStylus; piTablet: IInkTablet): HResult; stdcall;
      function TabletRemoved(piRtsSrc: IRealTimeStylus; iTabletIndex: Integer): HResult; stdcall;
      function Error(piRtsSrc: IRealTimeStylus; piPlugin: IStylusPlugin; dataInterest: RealTimeStylusDataInterest;
        hrErrorCode: HResult; var lptrKey: LONG_PTR): HResult; stdcall;
      function UpdateMapping(piRtsSrc: IRealTimeStylus): HResult; stdcall;
      function dataInterest(out pDataInterest: RealTimeStylusDataInterest): HResult; stdcall;
    public
      constructor Create; overload; virtual;
      ///<summary>This procedure sets the starting point to capture the points of the recognizing gesture.</summary>
      procedure SetInitialPoint(const Value: TPointF);
      destructor Destroy; override;
      function Initialize: Boolean;
      function EnableStylus(Value, Silent: Boolean): Boolean;
      procedure Uninitialize;
      ///<summary>Returns the available gesture list that the component associated to this object can manage.</summary>
      function GetGestureList: TGestureList;
      property Enabled: Boolean read FEnabled write SetEnabled;
      property Handle: HWND read FHandle write SetHandle;
    end;
  strict private
    class var FSupported: Boolean;
    class var FSupportedTested: Boolean;
  strict private
    FDeferredCleanupList: array of TRealTimeStylus;
    FStylusGestureEngine: TRealTimeStylus;
  protected
    function GetActive: Boolean; override;
    procedure SetActive(const Value: Boolean); override;
    ///<summary>This procedure sets the starting point to capture the points of the recognizing gesture.</summary>
    procedure SetInitialPoint(const Value: TPointF); override;
    ///<summary>Returns the available gesture list that the component associated to this object can manage.</summary>
    function GetGestureList: TGestureList; override;
  public
    constructor Create(const AControl: TComponent); override;
    destructor Destroy; override;
    class function Supported: Boolean;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  strict private
  type
    TPreCallback = procedure(const Points, GesturePoints: array of TPointF; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer) of object;
    TPostCallback = procedure(const Percentages: array of Double; const Points, GesturePoints: array of TPointF;
      GestureID: TGestureID) of object;
    TGestureFunc = function(const Points, GesturePoints: array of TPointF; GestureID: TGestureID; Deviation: Integer;
      ErrorMargin: Integer; var Percentages: array of Double): Integer of object;
  protected
    FPreCallback: TPreCallback;// for internal use only
    FPostCallback: TPostCallback; // for internal use only
  public
    function Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
  end;

implementation

uses
  Winapi.Messages, Winapi.ActiveX, System.SysUtils, System.Math, System.UIConsts, FMX.Consts,
  FMX.Forms, FMX.Platform, FMX.Platform.Win;

function GetSysErrorMessage(ErrorCode: HRESULT): string; inline;
begin
  Result := SysErrorMessage(Cardinal(ErrorCode));
end;

{ TPlatformGestureEngine }

constructor TPlatformGestureEngine.Create(const AControl: TComponent);
begin
  FControl := AControl;
end;

class constructor TPlatformGestureEngine.Create;
begin
  FRecognizer := nil;
  FDefaultRecognizerClass := TGestureRecognizer;
end;

class procedure TPlatformGestureEngine.CreateEngine(AControl: TComponent);
var
  LGObj: IGestureControl;
begin
  if not (csDesigning in AControl.ComponentState) and Supports(AControl, IGestureControl, LGObj) and
    not (LGObj.TouchManager.GestureEngine <> nil) then
    LGObj.TouchManager.GestureEngine := TWinGestureEngine.GetGestureEngine(AControl);
end;

destructor TPlatformGestureEngine.Destroy;
begin
  inherited;
end;

class destructor TPlatformGestureEngine.Destroy;
begin
  FreeAndNil(FRecognizer);
end;

function TPlatformGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [];
end;

class function TPlatformGestureEngine.DoGetRecognizer: TCustomGestureRecognizer;
var
  LRecognizer: TCustomGestureRecognizer;
begin
  if FRecognizer = nil then
  begin
    LRecognizer := DefaultRecognizerClass.Create;
    if InterlockedCompareExchangePointer(Pointer(FRecognizer), LRecognizer, nil) <> nil then
      LRecognizer.Free;
  end;
  Result := FRecognizer;
end;

{ TWinGestureEngine }

constructor TWinGestureEngine.Create(const AControl: TComponent);
begin
  inherited;
  SetLength(FDeferredCleanupList, 0);
  RegisterEngineInList(AControl, Self);
end;

destructor TWinGestureEngine.Destroy;
var
  I: Integer;
begin
  // Uninitialize RealTimeStylus
  if FStylusGestureEngine <> nil then
    FStylusGestureEngine.Uninitialize;

  // Handle deferred Uninitialization
  if Length(FDeferredCleanupList) > 0 then
    for I := 0 to Length(FDeferredCleanupList) - 1 do
      FDeferredCleanupList[I].Uninitialize;

  UnregisterEngineFromList(Self);
  inherited;
end;

procedure TWinGestureEngine.SetInitialPoint(const Value: TPointF);
begin
  inherited;
  FStylusGestureEngine.SetInitialPoint(Value);
end;

function TWinGestureEngine.GetActive: Boolean;
begin
  if FStylusGestureEngine <> nil then
    Result := FStylusGestureEngine.Enabled
  else
    Result := False;
end;

class function TWinGestureEngine.GetEngineFromList(const AControl: TComponent): TPlatformGestureEngine;
var
  LEngine: Pointer;
begin
  Result := nil;
  if (AControl <> nil) and (FControlEngineList <> nil) then
    if FControlEngineList.TryGetValue(Pointer(AControl), LEngine) then
      Result := TPlatformGestureEngine(LEngine);
end;

function TWinGestureEngine.GetGestureList: TGestureList;
begin
  Result := FStylusGestureEngine.GetGestureList;
end;

class procedure TWinGestureEngine.RegisterEngineInList(const AControl: TComponent;
  const AEngine: TPlatformGestureEngine);
begin
  if FControlEngineList = nil then
    FControlEngineList := TDictionary<Pointer, Pointer>.Create;
  FControlEngineList.AddOrSetValue(Pointer(AControl), Pointer(AEngine));
end;

procedure TWinGestureEngine.SetActive(const Value: Boolean);
var
  Success: Boolean;
  LForm: TCommonCustomForm;
  LOwner: TComponent;
begin
  LForm := nil;

  if (Control <> nil) and (not TPlatformServices.Current.GlobalFlags.ContainsKey(GlobalDisableStylusGestures) or
    not TPlatformServices.Current.GlobalFlags[GlobalDisableStylusGestures]) then
  begin
    if Value then
    begin
      // Initialize RealTimeStylus
      Success := True;
      if FStylusGestureEngine = nil then
      begin
        FStylusGestureEngine := TWinGestureEngine.TRealTimeStylus.Create;
        Success := FStylusGestureEngine.Initialize;
      end;

      if Success then
      begin
        if not (csDesigning in Control.ComponentState) then
          if (Control is TCommonCustomForm) then
            LForm := TCommonCustomForm(Control)
          else
          begin
            LOwner := Control.Owner;
            while (LOwner <> nil) and not (LOwner is TCommonCustomForm) do
              LOwner := LOwner.Owner;
            if LOwner <> nil then
              LForm := TCommonCustomForm(LOwner);
          end;

        if LForm <> nil then
          FStylusGestureEngine.Handle := WindowHandleToPlatform(LForm.Handle).Wnd;
      end;
      FStylusGestureEngine.Enabled := True;
    end
    else
      FStylusGestureEngine.Enabled := False;
  end
  else if FStylusGestureEngine <> nil then
  begin
    ClearPoints;

    // Uninitialize RealTimeStylus
    if (csUpdating in Control.ComponentState) and not FStylusGestureEngine.EnableStylus(Value, True) then
    begin
      // If the control is being recreated and can't be disabled, the
      // recreate originated from an OnGesture event and the RealTimeStylus
      // reference needs to be saved and disabled later.
      SetLength(FDeferredCleanupList, Length(FDeferredCleanupList) + 1);
      FDeferredCleanupList[Length(FDeferredCleanupList) - 1] := FStylusGestureEngine;
      FStylusGestureEngine := nil;
    end
    else
      FStylusGestureEngine.Enabled := Value;
  end;
end;

class function TWinGestureEngine.Supported: Boolean;
var
  LRealTimeStylus: IRealTimeStylus;
begin
  if not FSupportedTested then
  begin
    LRealTimeStylus := nil;
      CoCreateInstance(CLSID_RealTimeStylus, nil, CLSCTX_INPROC_SERVER,
        StringToGUID(SID_IRealTimeStylus), LRealTimeStylus);
    FSupported := LRealTimeStylus <> nil;
    FSupportedTested := True;
  end;
  Result := FSupported
end;

class procedure TWinGestureEngine.UnregisterEngineFromList(const AEngine: TPlatformGestureEngine);
var
  LPair: TPair<Pointer, Pointer>;
begin
  for LPair in FControlEngineList do
    if LPair.Value = Pointer(AEngine) then
    begin
      FControlEngineList.Remove(LPair.Key);
      Break;
    end;
  if FControlEngineList.Count = 0 then
    FreeAndNil(FControlEngineList);

end;

{ TWinGestureEngine.TRealTimeStylus }

procedure TWinGestureEngine.TRealTimeStylus.AddStylusAsyncPlugin(const APlugin: IStylusAsyncPlugin);
var
  Count: Cardinal;
  LResult: HResult;
begin
  LResult := FRealTimeStylus.GetStylusAsyncPluginCount(Count);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);

  LResult := FRealTimeStylus.AddStylusAsyncPlugin(Count, APlugin);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);
end;

procedure TWinGestureEngine.TRealTimeStylus.AddStylusSyncPlugin(const APlugin: IStylusSyncPlugin);
var
  Count: Cardinal;
  LResult: HRESULT;
begin
  LResult := FRealTimeStylus.GetStylusSyncPluginCount(Count);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusSyncPluginError, [GetSysErrorMessage(LResult)]);

  LResult := FRealTimeStylus.AddStylusSyncPlugin(Count, APlugin);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusSyncPluginError, [GetSysErrorMessage(LResult)]);
end;

constructor TWinGestureEngine.TRealTimeStylus.Create;
begin
  inherited Create;
  FGestures := TGestureList.Create;
end;

function TWinGestureEngine.TRealTimeStylus.CustomStylusDataAdded(piRtsSrc: IRealTimeStylus; const pGuidId: TGUID;
  cbData: Cardinal; pbData: PBYTE): HResult;
var
  LEventInfo: TGestureEventInfo;
  LPoints: TGesturePointArray;
  LEngine: TPlatformGestureEngine;
begin
  if IsEqualGUID(pGuidId, GUID_GESTURE_DATA) and (cbData >= SizeOf(TGestureData)) and (pbData <> nil) then
  begin
    LEngine := TWinGestureEngine.GetEngineFromList(FCurrentControl);
    if LEngine <> nil then
      if PGestureData(pbData)^.GestureID <> IAG_NoGesture then
      begin
        ZeroMemory(@LEventInfo, SizeOf(LEventInfo));
        LEventInfo.GestureID := StylusGestureMap(PGestureData(pbData)^.GestureID);
        LEngine.BroadcastGesture(FCurrentControl, LEventInfo);
      end
      else
      begin
        // Request custom gesture recognition
        if LEngine.PointCount > 0 then
        begin
          LPoints := Recognizer.NormalizePoints(LEngine.Points);
          if IsGesture(LPoints, FGestures, CustomGestureTypes, LEventInfo) then
            LEngine.BroadcastGesture(FCurrentControl, LEventInfo);
        end;
      end;
  end;
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.dataInterest(out pDataInterest: RealTimeStylusDataInterest): HResult;
begin
  pDataInterest := RealTimeStylusDataInterest(RTSDI_AllData);
  Result := S_OK;
end;

destructor TWinGestureEngine.TRealTimeStylus.Destroy;
begin
  FreeAndNil(FGestures);
  FreeAndNil(FGestureList);
  inherited;
end;

function TWinGestureEngine.TRealTimeStylus.EnableStylus(Value,
  Silent: Boolean): Boolean;
var
  LResult: HResult;
begin
  LResult := FRealTimeStylus.put_Enabled(FEnabled);
  if LResult <> S_OK then
    if Silent then
      Exit(False)
    else
      raise EGestureException.CreateResFmt(@SStylusEnableError, [GetSysErrorMessage(LResult)]);

  LResult := FGestureRecognizer.put_Enabled(FEnabled);
  if LResult <> S_OK then
    if Silent then
      Exit(False)
    else
      raise EGestureException.CreateResFmt(@SEnableRecognizerError, [GetSysErrorMessage(LResult)]);

  Result := True;
end;

function TWinGestureEngine.TRealTimeStylus.Error(piRtsSrc: IRealTimeStylus; piPlugin: IStylusPlugin;
  dataInterest: RealTimeStylusDataInterest; hrErrorCode: HResult; var lptrKey: LONG_PTR): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.InAirPackets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
  cPktCount, cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
  var ppInOutPkts: PInteger): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.Initialize: Boolean;
var
  LStylusSyncPlugin: IStylusSyncPlugin;
begin
  // Create RealTimeStylus
  CoCreateInstance(CLSID_RealTimeStylus, nil, CLSCTX_INPROC_SERVER,
    StringToGUID(SID_IRealTimeStylus), FRealTimeStylus);
  Result := FRealTimeStylus <> nil;

  if Result then
  begin
    // Create GestureRecognizer
    CoCreateInstance(CLSID_GestureRecognizer, nil, CLSCTX_INPROC_SERVER,
      StringToGUID(SID_IGestureRecognizer), FGestureRecognizer);
    Result := FGestureRecognizer <> nil;

    if Result then
    begin
      // Add recognizer and handler to RealTimeStylus
      if Supports(FGestureRecognizer, IStylusSyncPlugin, LStylusSyncPlugin) then
        AddStylusSyncPlugin(LStylusSyncPlugin);
      AddStylusAsyncPlugin(Self as IStylusAsyncPlugin);
    end;
  end;
end;

procedure GetXYFromStylus(piRtsSrc: IRealTimeStylus; pPacket: PInteger; var X, Y: Double);
var
  LScaleX, LScaleY: Single;
  Lcids: PTABLET_CONTEXT_ID;
  LcidCount: ULONG;
  Lcid: TABLET_CONTEXT_ID;
  LPropertyCount: ULONG;
  LProperties: PPacketProperty;
begin
  X := 0;
  Y := 0;

  // Get all the tablet context identifiers
  if piRtsSrc.GetAllTabletContextIds(@LcidCount, Lcids) = S_OK then
  begin
    // Use the first tablet context identifier in the array
    Lcid := Lcids^;

    // Get the packet description data
    if piRtsSrc.GetPacketDescriptionData(Lcid, LScaleX, LScaleY, LPropertyCount, LProperties) = S_OK then
    begin
      X := pPacket^;
      Inc(pPacket);
      Y := pPacket^;

      X := X * LScaleX;
      Y := Y * LScaleY;
    end;
  end;
end;

function TWinGestureEngine.TRealTimeStylus.Packets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
  cPktCount, cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
  var ppInOutPkts: PInteger): HResult;
var
  P: PInteger;
  Props, I: Integer;
  X, Y: Double;
  LEngine: TPlatformGestureEngine;
begin
  LEngine := TWinGestureEngine.GetEngineFromList(FCurrentControl);
  if LEngine <> nil then
  begin
    Props := cPktBuffLength div cPktCount;
    P := pPackets;
    for I := 1 to cPktCount do
    begin
      GetXYFromStylus(piRtsSrc, P, X, Y);
      Inc(P);
      Inc(P);
      LEngine.AddPoint(X, Y);
      if Props > 2 then
        Inc(P, Props - 2); // in case of additional properties we don't care about
    end;
  end;
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
  var pTcids: TABLET_CONTEXT_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
  var pTcids: TABLET_CONTEXT_ID): HResult;
begin
  Result := S_OK;
end;

procedure TWinGestureEngine.TRealTimeStylus.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    EnableStylus(FEnabled, False);
  end;
end;

procedure TWinGestureEngine.TRealTimeStylus.SetHandle(const Value: HWND);
var
  LResult: HResult;
begin
  if Value <> FHandle then
  begin
    LResult := FRealTimeStylus.put_HWND(Value);
    if LResult <> S_OK then
      raise EGestureException.CreateResFmt(@SStylusHandleError, [GetSysErrorMessage(LResult)]);
    FHandle := Value;
  end;
end;

class function TWinGestureEngine.TRealTimeStylus.GetControlUnderTouch(const Value: TPointF): TComponent;
var
  LForm: TCommonCustomForm;
  LComponent: TComponent;
  LControl: IControl;
begin
  inherited;

  if (Screen <> nil) and (Screen.ActiveForm <> nil) then
    LForm := Screen.ActiveForm
  else
    LForm := nil;

  if LForm <> nil then
  begin
    LControl := LForm.ObjectAtPoint(Value);
    if LControl <> nil then
      LComponent := LControl.GetObject
    else
      LComponent := TComponent(LForm);
  end
  else
    LComponent := nil;

  Result := LComponent;
end;

function TWinGestureEngine.TRealTimeStylus.GetGestureList: TGestureList;
begin
  Result := FGestureList;
end;

procedure TWinGestureEngine.TRealTimeStylus.SetInitialPoint(const Value: TPointF);
begin
  if FCurrentControl <> nil then
  begin
    if FGestureList = nil then
      FGestureList := TGestureList.Create;
    FGestureList.Clear;
    GetCompleteGestureList(FCurrentControl, FGestureList);
  end;
end;

class function TWinGestureEngine.TRealTimeStylus.StandardGestureMap(const AGesture: TStandardGesture): Integer;
const
  LGestureMap: array [TStandardGesture] of Integer = (IAG_Left, IAG_Right,
    IAG_Up, IAG_Down, IAG_UpLeft, IAG_UpRight, IAG_DownLeft, IAG_DownRight,
    IAG_LeftUp, IAG_LeftDown, IAG_RightUp, IAG_RightDown, IAG_UpDown,
    IAG_DownUp, IAG_LeftRight, IAG_RightLeft, IAG_UpLeftLong, IAG_UpRightLong,
    IAG_DownLeftLong, IAG_DownRightLong, IAG_Scratchout, IAG_Triangle,
    IAG_Square, IAG_Check, IAG_Curlicue, IAG_DoubleCurlicue, IAG_Circle,
    IAG_DoubleCircle, IAG_SemiCircleLeft, IAG_SemiCircleRight, IAG_ChevronUp,
    IAG_ChevronDown, IAG_ChevronLeft, IAG_ChevronRight);
begin
  Result := LGestureMap[AGesture];
end;

function TWinGestureEngine.TRealTimeStylus.StylusButtonDown(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
  const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusButtonUp(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
  const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusDown(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
  cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HResult;
var
  LPoint: TPoint;
  LResult: HResult;
  Count, I: Integer;
  X, Y: Double;
  LGestures: array of Integer;
  LItem: TCustomGestureCollectionItem;
  LEngine: TPlatformGestureEngine;
begin
  Result := S_OK;

  // Find control that gesture belongs to
  if not GetCursorPos(LPoint) then
    raise EGestureException.CreateRes(@SInitialGesturePointError);

  FCurrentControl := GetControlUnderTouch(LPoint);
  if FCurrentControl <> nil then
  begin
    LEngine := TWinGestureEngine.GetEngineFromList(FCurrentControl);
    if LEngine <> nil then
    begin
      LEngine.InitialPoint := TPointF.Create(LPoint.X, LPoint.Y);

      // Build list of gestures
      FGestures.Clear;
      LEngine.GetCompleteGestureList(FCurrentControl, FGestures);

      // Set gestures to listen for
      Count := 0;
      SetLength(LGestures, FGestures.Count);
      for I := 0 to FGestures.Count - 1 do
      begin
        LItem := FGestures[I];
        if LItem.GestureType = TGestureType.Standard then
        begin
          LGestures[Count] := StandardGestureMap(TStandardGesture(LItem.GestureID));
          Inc(Count);
        end;
      end;
      if Count > 0 then
      begin
        SetLength(LGestures, Count);
        LResult := FGestureRecognizer.EnableGestures(Length(LGestures), @LGestures[0]);
        if LResult <> S_OK then
          raise EGestureException.CreateResFmt(@SSetStylusGestureError, [GetSysErrorMessage(LResult)]);
      end;

      GetXYFromStylus(piRtsSrc, pPacket, X, Y);

      LEngine.ClearPoints;
      LEngine.AddPoint(X, Y);
    end;
  end;
end;

class function TWinGestureEngine.TRealTimeStylus.StylusGestureMap(AGesture: Integer): Integer;
begin
  case AGesture of
    IAG_Left:
      Result := sgiLeft;
    IAG_Right:
      Result := sgiRight;
    IAG_Up:
      Result := sgiUp;
    IAG_Down:
      Result := sgiDown;
    IAG_UpLeft:
      Result := sgiUpLeft;
    IAG_UpRight:
      Result := sgiUpRight;
    IAG_DownLeft:
      Result := sgiDownLeft;
    IAG_DownRight:
      Result := sgiDownRight;
    IAG_LeftUp:
      Result := sgiLeftUp;
    IAG_LeftDown:
      Result := sgiLeftDown;
    IAG_RightUp:
      Result := sgiRightUp;
    IAG_RightDown:
      Result := sgiRightDown;
    IAG_UpDown:
      Result := sgiUpDown;
    IAG_DownUp:
      Result := sgiDownUp;
    IAG_LeftRight:
      Result := sgiLeftRight;
    IAG_RightLeft:
      Result := sgiRightLeft;
    IAG_UpLeftLong:
      Result := sgiUpLeftLong;
    IAG_UpRightLong:
      Result := sgiUpRightLong;
    IAG_DownLeftLong:
      Result := sgiDownLeftLong;
    IAG_DownRightLong:
      Result := sgiDownRightLong;
    IAG_Scratchout:
      Result := sgiScratchout;
    IAG_Triangle:
      Result := sgiTriangle;
    IAG_Square:
      Result := sgiSquare;
    IAG_Check:
      Result := sgiCheck;
    IAG_Curlicue:
      Result := sgiCurlicue;
    IAG_DoubleCurlicue:
      Result := sgiDoubleCurlicue;
    IAG_Circle:
      Result := sgiCircle;
    IAG_DoubleCircle:
      Result := sgiDoubleCircle;
    IAG_SemiCircleLeft:
      Result := sgiSemiCircleLeft;
    IAG_SemiCircleRight:
      Result := sgiSemiCircleRight;
    IAG_ChevronUp:
      Result := sgiChevronUp;
    IAG_ChevronDown:
      Result := sgiChevronDown;
    IAG_ChevronLeft:
      Result := sgiChevronLeft;
    IAG_ChevronRight:
      Result := sgiChevronRight;
  else
    Result := -1;
  end;
end;

function TWinGestureEngine.TRealTimeStylus.StylusInRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
  sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusOutOfRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
  sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusUp(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
  cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HResult;
var
  X, Y: Double;
  LEngine: TPlatformGestureEngine;
begin
  if FCurrentControl <> nil then
  begin
    GetXYFromStylus(piRtsSrc, pPacket, X, Y);
    LEngine := TWinGestureEngine.GetEngineFromList(FCurrentControl);
    if LEngine <> nil then
      LEngine.AddPoint(X, Y);
  end;

  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.SystemEvent(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
  sid: STYLUS_ID; event: SYSTEM_EVENT; eventdata: SYSTEM_EVENT_DATA): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.TabletAdded(piRtsSrc: IRealTimeStylus; piTablet: IInkTablet): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.TabletRemoved(piRtsSrc: IRealTimeStylus; iTabletIndex: Integer): HResult;
begin
  Result := S_OK;
end;

procedure TWinGestureEngine.TRealTimeStylus.Uninitialize;
var
  I: Integer;
  LCount: Cardinal;
  LResult: HResult;
  PSyncPlugin: IStylusSyncPlugin;
  PAsyncPlugin: IStylusAsyncPlugin;
begin
  if FRealTimeStylus = nil then
    Exit;

  if FEnabled then
    Enabled := False;

  // Remove IStylusSyncPlugins
  LResult := FRealTimeStylus.GetStylusSyncPluginCount(LCount);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SRemoveIStylusSyncPluginError, [GetSysErrorMessage(LResult)]);

  PSyncPlugin := nil;
  for I := 0 to LCount - 1 do
  begin
    LResult := FRealTimeStylus.RemoveStylusSyncPlugin(I, PSyncPlugin);
    if LResult <> S_OK then
      raise EGestureException.CreateResFmt(@SRemoveIStylusSyncPluginError, [GetSysErrorMessage(LResult)]);
  end;

  // Remove IStylusAsyncPlugins
  LResult := FRealTimeStylus.GetStylusAsyncPluginCount(LCount);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SRemoveIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);

  PAsyncPlugin := nil;
  for I := 0 to LCount - 1 do
  begin
    LResult := FRealTimeStylus.RemoveStylusAsyncPlugin(I, PAsyncPlugin);
    if LResult <> S_OK then
      raise EGestureException.CreateResFmt(@SRemoveIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);
  end;
end;

function TWinGestureEngine.TRealTimeStylus.UpdateMapping(piRtsSrc: IRealTimeStylus): HResult;
begin
  Result := S_OK;
end;

{ TPlatformGestureEngine }

class function TPlatformGestureEngine.GetGestureEngine(const AControl: TComponent): TGestureEngine;
begin
  Result := nil;
  if TWinTouchGestureEngine.Supported(AControl) then
    Result := TWinTouchGestureEngine.Create(AControl)
  else if TWinGestureEngine.Supported then
    Result := TWinGestureEngine.Create(AControl);
end;

{ TGestureRecognizer }

function TGestureRecognizer.Match(const Points, GesturePoints: array of TPointF; const Options: TGestureOptions;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer): Single;
var
  LErrorMargin: Integer;
  LPoints, LGesturePoints: TGesturePointArray;
  GesturePointCount: Integer;
  Percentages: array of Double;
  Angle: Double;
begin
  Result := 0;
  SetLength(Percentages, 4);

  // Apply global sensitivity adjustment to gesture's ErrorMargin property
  LErrorMargin := Round(Sqr(100 - TPlatformGestureEngine.Sensitivity) / 100) + ErrorMargin;
  if LErrorMargin > 100 then
    LErrorMargin := 100;
                                                    

  try
    GesturePointCount := Length(GesturePoints);

    if (Length(Points) = 0) or (GesturePointCount = 0) then
      Exit;

    if Assigned(FPreCallback) then
      FPreCallback(Points, GesturePoints, GestureID, Deviation, LErrorMargin);

    if GestureID = sgiScratchout then
    begin
      Result := IsScratchout(Points, GestureID, Deviation, LErrorMargin, Percentages);
      Exit;
    end;

    LPoints := NormalizePoints(Points);
    if TGestureOption.Rotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation, TGestureOption.Skew in Options);
    LPoints := RemoveDuplicates(LPoints);

    LGesturePoints := InterpolateGesturePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
      LErrorMargin, Percentages);
  finally
    if Assigned(FPostCallback) then
      FPostCallback(Percentages, LPoints, GesturePoints, GestureID);
  end;

end;

{ TWinTouchGestureEngine }

constructor TWinTouchGestureEngine.Create(const AControl: TComponent);
begin
  inherited;
  FGestureList := TGestureList.Create;
end;

destructor TWinTouchGestureEngine.Destroy;
begin
  FGestureList.Free;
  inherited;
end;

function TWinTouchGestureEngine.GetActive: Boolean;
begin
  Result := FActive;
end;

function TWinTouchGestureEngine.GetGestureList: TGestureList;
begin
  GetCompleteGestureList(Control, FGestureList);
  Result := FGestureList;
end;

procedure TWinTouchGestureEngine.SetActive(const Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if not FActive then
      ClearPoints;
  end;
end;

class function TWinTouchGestureEngine.Supported(const AControl: TComponent): Boolean;
var
  LForm: TCommonCustomForm;
  LOwner: TComponent;
  FormHandle: HWND;
  Metrics: Integer;
begin
  if not FSupportedTested then
  begin
    FSupportedTested := True;
    LForm := nil;

    if AControl <> nil then
    begin
      if (AControl is TCommonCustomForm) then
        LForm := TCommonCustomForm(AControl)
      else
      begin
        LOwner := AControl.Owner;
        while (LOwner <> nil) and not (LOwner is TCommonCustomForm) do
          LOwner := LOwner.Owner;
        if LOwner <> nil then
          LForm := TCommonCustomForm(LOwner);
      end;

      if (LForm <> nil) and TOSVersion.Check(6, 1) then
      begin
        Metrics := GetSystemMetrics(SM_DIGITIZER);
        if ((Metrics and NID_READY) = NID_READY) and ((Metrics and NID_MULTI_INPUT) = NID_MULTI_INPUT) then
        begin
          FormHandle := WindowHandleToPlatform(LForm.Handle).Wnd;
          if IsTouchWindow(FormHandle, nil) or IsTouchWindow(FormHandle, Pointer(TWF_WANTPALM)) then
            FSupported := True
          else if RegisterTouchWindow(FormHandle, 0) then
          begin
            FSupported := True;
            UnregisterTouchWindow(FormHandle);
          end;
        end;
      end;
    end;
  end;
  Result := FSupported
end;

end.

