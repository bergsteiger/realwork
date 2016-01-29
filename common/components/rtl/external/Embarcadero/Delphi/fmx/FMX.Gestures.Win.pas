{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2012-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit FMX.Gestures.Win;

interface

uses FMX.Gestures, FMX.Types, Winapi.MsInkAut, Winapi.RtsCom, Winapi.TpcShrd,
  Winapi.Windows, System.UITypes, System.Types;

type
  TPlatformGestureEngine = class(TGestureEngine)
  strict private
    class var FDefaultEngineClass: TGestureEngineClass;
    class var FDefaultRecognizerClass: TCustomGestureRecognizerClass;
    class var FRecognizer: TCustomGestureRecognizer;
    class function GetRecognizer: TCustomGestureRecognizer; static;
    class procedure SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass); static;
    class destructor Destroy;
    class constructor Create;
  strict private
    FControl: TFmxObject;
    FTargetControl: TFmxObject;
  protected
    class function GetGestureEngine(const AControl: TFmxObject): TGestureEngine; override;
    procedure AddPoint(X, Y: Extended);
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
    property Control: TFmxObject read FControl;
    property TargetControl: TFmxObject read FTargetControl write FTargetControl;
  public
    class procedure CreateEngine(AControl: TFmxObject);
    class function IsGesture(const Points: array of TPointF; Items: TGestureList;
      GestureTypes: TGestureTypes; var EventInfo: TGestureEventInfo): Boolean;
    class property DefaultEngineClass: TGestureEngineClass
      read FDefaultEngineClass write FDefaultEngineClass;
    class property Recognizer: TCustomGestureRecognizer read GetRecognizer;
    class property DefaultRecognizerClass: TCustomGestureRecognizerClass
      read FDefaultRecognizerClass write SetDefaultRecognizerClass;
  public
    constructor Create(const AControl: TFmxObject); override;
  end;

  TWinGestureEngine = class sealed(TPlatformGestureEngine)
  strict private
  type
    TRealTimeStylus = class(TInterfacedObject, IStylusAsyncPlugin)
    strict private
      FEnabled: Boolean;
      FEngine: TPlatformGestureEngine;
      FGestureRecognizer: IGestureRecognizer;
      FGestureList: TGestureList;
      FHandle: HWND;
      FRealTimeStylus: IRealTimeStylus;
      procedure AddStylusAsyncPlugin(const APlugin: IStylusAsyncPlugin);
      procedure AddStylusSyncPlugin(const APlugin: IStylusSyncPlugin);
      procedure SetEnabled(const Value: Boolean);
      procedure SetHandle(const Value: HWND);
      class function StandardGestureMap(const AGesture: TStandardGesture): Integer;
      class function StylusGestureMap(AGesture: Integer): Integer;
    public // IStylusAsyncPlugin
      function RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus;
        cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus;
        cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function StylusInRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
        sid: STYLUS_ID): HResult; stdcall;
      function StylusOutOfRange(piRtsSrc: IRealTimeStylus;
        tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult; stdcall;
      function StylusDown(piRtsSrc: IRealTimeStylus;
        const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal;
        pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusUp(piRtsSrc: IRealTimeStylus;
        const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal;
        pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusButtonDown(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
        const pGuidStylusButton: TGUID; var pStylusPos: TPoint)
        : HResult; stdcall;
      function StylusButtonUp(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
        const pGuidStylusButton: TGUID; var pStylusPos: TPoint)
        : HResult; stdcall;
      function InAirPackets(piRtsSrc: IRealTimeStylus;
        const pStylusInfo: TStylusInfo; cPktCount: Cardinal;
        cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
        var ppInOutPkts: PInteger): HResult; stdcall;
      function Packets(piRtsSrc: IRealTimeStylus;
        const pStylusInfo: TStylusInfo; cPktCount: Cardinal;
        cPktBuffLength: Cardinal; pPackets: PInteger; var pcInOutPkts: Cardinal;
        var ppInOutPkts: PInteger): HResult; stdcall;
      function CustomStylusDataAdded(piRtsSrc: IRealTimeStylus;
        const pGuidId: TGUID; cbData: Cardinal; pbData: PBYTE)
        : HResult; stdcall;
      function SystemEvent(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
        sid: STYLUS_ID; event: SYSTEM_EVENT; eventdata: SYSTEM_EVENT_DATA)
        : HResult; stdcall;
      function TabletAdded(piRtsSrc: IRealTimeStylus; piTablet: IInkTablet)
        : HResult; stdcall;
      function TabletRemoved(piRtsSrc: IRealTimeStylus; iTabletIndex: Integer)
        : HResult; stdcall;
      function Error(piRtsSrc: IRealTimeStylus; piPlugin: IStylusPlugin;
        dataInterest: RealTimeStylusDataInterest; hrErrorCode: HResult;
        var lptrKey: LONG_PTR): HResult; stdcall;
      function UpdateMapping(piRtsSrc: IRealTimeStylus): HResult; stdcall;
      function dataInterest(out pDataInterest: RealTimeStylusDataInterest): HResult; stdcall;
    public
      constructor Create(const Engine: TPlatformGestureEngine); overload; virtual;
      destructor Destroy; override;
      function Initialize: Boolean;
      function EnableStylus(Value, Silent: Boolean): Boolean;
      procedure Uninitialize;
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
  public
    constructor Create(const AControl: TFmxObject); override;
    destructor Destroy; override;
    class function Supported: Boolean; override;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  strict private
  type
    TPreCallback = procedure(const Points, GesturePoints: array of TPointF;
      GestureID: TGestureID; Deviation, ErrorMargin: Integer) of object;
    TPostCallback = procedure(const Percentages: array of Double;
      const Points, GesturePoints: array of TPointF; GestureID: TGestureID) of object;
    TGestureFunc = function(const Points, GesturePoints: array of TPointF;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer of object;
  private
    function IsPointsGesture(const Points, GesturePoints: array of TPointF;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer;
    function IsScratchout(const Points: array of TPointF; GestureID: TGestureID;
      Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer;
    function CopyPoints(const Points: TGesturePoints): TGesturePointArray;
    function InterpolatePoints(const Points: array of TPointF): TGesturePointArray;
    function RemoveDuplicates(const Points: array of TPointF): TGesturePointArray;
    function RotatePoints(const Points, GesturePoints: array of TPointF;
      ErrorMargin: Integer; var Angle: Double): TGesturePointArray;
  protected
    FPreCallback: TPreCallback;// for internal use only
    FPostCallback: TPostCallback; // for internal use only
  public
    function Match(const Points, GesturePoints: array of TPointF;
      const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
    function NormalizePoints(const Points: array of TPointF): TGesturePointArray; override;
    function ScalePoints(const Points, GesturePoints: array of TPointF;
      MinScale: Integer; Scaling: Boolean = False): TGesturePointArray; override;
  end;

implementation

uses FMX.Consts, System.Classes, Winapi.Messages, Winapi.ActiveX, System.UIConsts,
  System.SysUtils, System.Generics.Collections, System.Math, FMX.Forms, FMX.Platform,
  FMX.Platform.Win;

function GetSysErrorMessage(ErrorCode: HRESULT): string; inline;
begin
  Result := SysErrorMessage(Cardinal(ErrorCode));
end;

{ TPlatformGestureEngine }

function GesturePointsToArray(const Source: TGesturePoints): TGesturePointArray;
var
  I: Integer;
begin
  SetLength(Result, Source.Count);
  for I := 0 to Source.Count - 1 do
    Result[I] := TPointF(Source[I]);
end;

procedure TPlatformGestureEngine.AddPoint(X, Y: Extended);
var
  StepX, StepY: Single;
  I, DeltaX, DeltaY: Integer;
  LastPoint, NextPoint: TPointF;
  CountX, CountY, Count: Integer;
begin
  if not Assigned(FPoints) then
    FPoints := TGesturePoints.Create;

  if FPoints.Count = 0 then
    FPoints.Add(PointF(X, Y))
  else
  begin
    NextPoint := PointF(X, Y);
    LastPoint := FPoints[FPoints.Count - 1];

    // Determine distance between points
    DeltaX := Round(Abs(NextPoint.X - LastPoint.X));
    DeltaY := Round(Abs(NextPoint.Y - LastPoint.Y));

    // If points are too close together discard the new point
    if (DeltaX < 5) and (DeltaY < 5) then
      Exit;

    // If points are too far apart insert intermediate points
    if (DeltaX > 8) or (DeltaY > 8) then
    begin
      // Determine how many points to insert
      CountX := DeltaX div 5;
      if (DeltaX mod 5) = 0 then
        Dec(CountX);
      CountY := DeltaY div 5;
      if (DeltaY mod 5) = 0 then
        Dec(CountY);
      Count := Max(CountX, CountY);

      // Determine spacing between inserted points
      StepX := (NextPoint.X - LastPoint.X) / Count;
      StepY := (NextPoint.Y - LastPoint.Y) / Count;

      // Insert points
      for I := 1 to Count - 1 do
        FPoints.Add(PointF(LastPoint.X + Round(StepX * I),
          LastPoint.Y + Round(StepY * I)));
    end;

    // Add captured point
    FPoints.Add(NextPoint);
  end;
end;

constructor TPlatformGestureEngine.Create(const AControl: TFmxObject);
begin
  FControl := AControl;
  // FStopWatch := TStopWatch.Create;
end;

class constructor TPlatformGestureEngine.Create;
begin
  FRecognizer := nil;
  FDefaultRecognizerClass := TGestureRecognizer;
end;

class procedure TPlatformGestureEngine.CreateEngine(AControl: TFmxObject);
begin
  if not(csDesigning in AControl.ComponentState) then
    if not Assigned(AControl.Touch.GestureEngine) then
    begin
      AControl.Touch.GestureEngine := TWinGestureEngine.GetGestureEngine(AControl);
    end;
end;

class destructor TPlatformGestureEngine.Destroy;
begin
  if Assigned(FRecognizer) then
    FreeAndNil(FRecognizer);
end;

function TPlatformGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [];
end;

class function TPlatformGestureEngine.GetRecognizer: TCustomGestureRecognizer;
var
  LRecognizer: TCustomGestureRecognizer;
begin
  if not Assigned(FRecognizer) then
  begin
    LRecognizer := DefaultRecognizerClass.Create;
    if InterlockedCompareExchangePointer(Pointer(FRecognizer), LRecognizer, nil) <> nil then
      LRecognizer.Free;
  end;
  Result := FRecognizer;
end;

class function TPlatformGestureEngine.IsGesture(const Points: array of TPointF;
  Items: TGestureList; GestureTypes: TGestureTypes; var EventInfo: TGestureEventInfo): Boolean;
var
  LItem: TCustomGestureCollectionItem;
  LData: TStandardGestureData;
  LWeight, TempWeight: Single;
  I: Integer;
begin
  Result := False;
  ZeroMemory(@EventInfo, SizeOf(EventInfo));

  if not Assigned(Items) then
    Exit;

  LWeight := 0;

  // Process standard gestures
  if TGestureType.gtStandard in GestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType = TGestureType.gtStandard then
      begin
        if not FindStandardGesture(LItem.GestureID, LData) then
          raise EGestureException.CreateResFmt(@SInvalidGestureID, [LItem.GestureID]);

        TempWeight := Recognizer.Match(Points, LData.Points, LData.Options, LData.GestureID, LData.Deviation, LData.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          EventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
    Exit(True);

  // Process custom gestures
  if CustomGestureTypes * GestureTypes = CustomGestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType in CustomGestureTypes then
      begin
        TempWeight := Recognizer.Match(Points, LItem.Points, LItem.Options, LItem.GestureID, LItem.Deviation, LItem.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          EventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
    Exit(True);

  // No gesture was recognized. Return True if 3 or more points are in the list
  // so the listener is notified that a gesture occurred but wasn't recognized
  EventInfo.GestureID := sgiNoGesture;
  Result := Length(Points) >= 3;
end;

class procedure TPlatformGestureEngine.SetDefaultRecognizerClass(
  const Value: TCustomGestureRecognizerClass);
begin
  if Value <> FDefaultRecognizerClass then
  begin
    FDefaultRecognizerClass := Value;
    if Assigned(FRecognizer) then
      FreeAndNil(FRecognizer);
  end;
end;

{ TWinGestureEngine }

constructor TWinGestureEngine.Create(const AControl: TFmxObject);
begin
  inherited Create(AControl);
  SetLength(FDeferredCleanupList, 0);
end;

destructor TWinGestureEngine.Destroy;
var
  I: Integer;
begin
  // Uninitialize RealTimeStylus
  if Assigned(FStylusGestureEngine) then
    FStylusGestureEngine.Uninitialize;

  // Handle deferred Uninitialization
  if Length(FDeferredCleanupList) > 0 then
    for I := 0 to Length(FDeferredCleanupList) - 1 do
      FDeferredCleanupList[I].Uninitialize;

  inherited;
end;

function TWinGestureEngine.GetActive: Boolean;
begin
  if Assigned(FStylusGestureEngine) then
    Result := FStylusGestureEngine.Enabled
  else
    Result := False;
end;

procedure TWinGestureEngine.SetActive(const Value: Boolean);
var
  Success: Boolean;
  FForm: TCommonCustomForm;
begin
  FForm := nil;

  if Assigned(Control) and (not (TPlatformServices.Current.GlobalFlags.ContainsKey(GlobalDisableStylusGestures)) or
     not TPlatformServices.Current.GlobalFlags[GlobalDisableStylusGestures]) then
  begin
    if Value then
    begin
      // Initialize RealTimeStylus
      if not Assigned(FStylusGestureEngine) then
      begin
        FStylusGestureEngine := TWinGestureEngine.TRealTimeStylus.Create(Self);
        Success := FStylusGestureEngine.Initialize;
      end
      else
        Success := True;

      if Success then
      begin
        if not(csDesigning in Control.ComponentState) then
          if (Control is TCommonCustomForm) then
            FForm := TCommonCustomForm(Control)
          else if (Assigned(Control.Root)) and (Control.Root.GetObject is TCommonCustomForm) then
            FForm := TCommonCustomForm(Control.Root.GetObject);

        if Assigned(FForm) then
          FStylusGestureEngine.Handle := WindowHandleToPlatform(FForm.Handle).Wnd;
      end;
      FStylusGestureEngine.Enabled := True;
    end
    else
      FStylusGestureEngine.Enabled := False;
  end
  else if Assigned(FStylusGestureEngine) then
  begin
    ClearPoints;

    // Uninitialize RealTimeStylus
    if (csUpdating in Control.ComponentState) and
      not FStylusGestureEngine.EnableStylus(Value, True) then
    begin
      // If the control is being recreated and can't be disabled, the
      // recreate originated from an OnGesture event and the RealTimeStylus
      // reference needs to be saved and disabled later.
      SetLength(FDeferredCleanupList, Length(FDeferredCleanupList) + 1);
      FDeferredCleanupList[Length(FDeferredCleanupList) - 1] :=
        FStylusGestureEngine;
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
    FSupported := Assigned(LRealTimeStylus);
    FSupportedTested := True;
  end;
  Result := FSupported
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

constructor TWinGestureEngine.TRealTimeStylus.Create
  (const Engine: TPlatformGestureEngine);
begin
  inherited Create;
  FEngine := Engine;
  FGestureList := TGestureList.Create;
end;

function TWinGestureEngine.TRealTimeStylus.CustomStylusDataAdded
  (piRtsSrc: IRealTimeStylus; const pGuidId: TGUID; cbData: Cardinal;
  pbData: PBYTE): HResult;
var
  LEventInfo: TGestureEventInfo;
  LPoints: TGesturePointArray;
begin
  if IsEqualGUID(pGuidId, GUID_GESTURE_DATA) then
    if (cbData >= SizeOf(TGestureData)) and Assigned(pbData) then
    begin
      if PGestureData(pbData)^.GestureID <> IAG_NoGesture then
      begin
        ZeroMemory(@LEventInfo, SizeOf(LEventInfo));
        LEventInfo.GestureID := StylusGestureMap(PGestureData(pbData)^.GestureID);
        FEngine.BroadcastGesture(FEngine.TargetControl, LEventInfo);
      end
      else
      begin
        // Request custom gesture recognition
        if (TPlatformGestureEngine(FEngine).PointCount > 0) then
        begin
          LPoints := Recognizer.NormalizePoints(FEngine.Points);
          if IsGesture(LPoints, FGestureList, CustomGestureTypes, LEventInfo)
          then
            FEngine.BroadcastGesture(TPlatformGestureEngine(FEngine).TargetControl, LEventInfo);
        end;
      end;
    end;
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.dataInterest(out pDataInterest
  : RealTimeStylusDataInterest): HResult;
begin
  pDataInterest := RealTimeStylusDataInterest(RTSDI_AllData);
  Result := S_OK;
end;

destructor TWinGestureEngine.TRealTimeStylus.Destroy;
begin
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

function TWinGestureEngine.TRealTimeStylus.Error(piRtsSrc: IRealTimeStylus;
  piPlugin: IStylusPlugin; dataInterest: RealTimeStylusDataInterest;
  hrErrorCode: HResult; var lptrKey: LONG_PTR): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.InAirPackets
  (piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
  cPktCount, cPktBuffLength: Cardinal; pPackets: PInteger;
  var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HResult;
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
  Result := Assigned(FRealTimeStylus);

  if Result then
  begin
    // Create GestureRecognizer
    CoCreateInstance(CLSID_GestureRecognizer, nil, CLSCTX_INPROC_SERVER,
      StringToGUID(SID_IGestureRecognizer), FGestureRecognizer);
    Result := Assigned(FGestureRecognizer);

    if Result then
    begin
      // Add recognizer and handler to RealTimeStylus
      if Supports(FGestureRecognizer, IStylusSyncPlugin, LStylusSyncPlugin) then
        AddStylusSyncPlugin(LStylusSyncPlugin);
      AddStylusAsyncPlugin(Self as IStylusAsyncPlugin);
    end;
  end;
end;

function TWinGestureEngine.TRealTimeStylus.Packets(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPktCount, cPktBuffLength: Cardinal;
  pPackets: PInteger; var pcInOutPkts: Cardinal;
  var ppInOutPkts: PInteger): HResult;
var
  P: PInteger;
  Props, I, X, Y: Integer;
begin
  Props := cPktBuffLength div cPktCount;
  P := pPackets;
  for I := 1 to cPktCount do
  begin
    X := P^;
    Inc(P);
    Y := P^;
    Inc(P);
    TPlatformGestureEngine(FEngine).AddPoint(X, Y);
    if Props > 2 then
      Inc(P, Props - 2); // in case of additional properties we don't care about
  end;
  // begin
  // TPlatformGestureEngine(FEngine).ClearPoints;
  // end;
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.RealTimeStylusDisabled
  (piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
  var pTcids: TABLET_CONTEXT_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.RealTimeStylusEnabled
  (piRtsSrc: IRealTimeStylus; cTcidCount: Cardinal;
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

class function TWinGestureEngine.TRealTimeStylus.StandardGestureMap
  (const AGesture: TStandardGesture): Integer;
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

function TWinGestureEngine.TRealTimeStylus.StylusButtonDown
  (piRtsSrc: IRealTimeStylus; sid: STYLUS_ID; const pGuidStylusButton: TGUID;
  var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusButtonUp
  (piRtsSrc: IRealTimeStylus; sid: STYLUS_ID; const pGuidStylusButton: TGUID;
  var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusDown(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal; pPacket: PInteger;
  var ppInOutPkt: PInteger): HResult;
var
  LPoint: TPoint;
  LResult: HResult;
  Count, I, X, Y: Integer;
  LGestures: array of Integer;
  LItem: TCustomGestureCollectionItem;
  LForm: TCommonCustomForm;
  LControl: TFmxObject;
  Obj: IControl;
begin
  Result := S_OK;
  LForm := nil;
  // Find control that gesture belongs to
  if not GetCursorPos(LPoint) then
    raise EGestureException.CreateRes(@SInitialGesturePointError);

  FEngine.InitialPoint := PointF(LPoint.X, LPoint.Y);

  LControl := FEngine.Control;
  if (LControl is TCommonCustomForm) then
    LForm := TCommonCustomForm(LControl)
  else if (Assigned(LControl.Root)) and (LControl.Root.GetObject is TCommonCustomForm) then
    LForm := TCommonCustomForm(LControl.Root.GetObject);

  if Assigned(LForm) then
  begin
    Obj := LForm.ObjectAtPoint(FEngine.InitialPoint);
    if Assigned(Obj) then
      LControl := Obj.GetObject
    else
      LControl := TFmxObject(LForm);
    FEngine.TargetControl := LControl;
  end;

  if not Assigned(FEngine.TargetControl) then
    FEngine.TargetControl := FEngine.Control;
  // else if not (csGestures in TPlatformGestureEngine(FEngine).TargetControl.ControlStyle) then
  // Exit;

  // Build list of gestures
  FGestureList.Clear;
  TPlatformGestureEngine(FEngine).GetCompleteGestureList(TPlatformGestureEngine(FEngine).TargetControl, FGestureList);

  // Set gestures to listen for
  Count := 0;
  SetLength(LGestures, FGestureList.Count);
  for I := 0 to FGestureList.Count - 1 do
  begin
    LItem := FGestureList[I];
    if LItem.GestureType = TGestureType.gtStandard then
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

  // Add initial point to list of collected points
  X := pPacket^;
  Inc(pPacket);
  Y := pPacket^;
  TPlatformGestureEngine(FEngine).ClearPoints;
  TPlatformGestureEngine(FEngine).AddPoint(X, Y);
end;

class function TWinGestureEngine.TRealTimeStylus.StylusGestureMap
  (AGesture: Integer): Integer;
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

function TWinGestureEngine.TRealTimeStylus.StylusInRange
  (piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusOutOfRange
  (piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.StylusUp(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPropCountPerPkt: Cardinal; pPacket: PInteger;
  var ppInOutPkt: PInteger): HResult;
var
  X, Y: Integer;
begin
  X := pPacket^;
  Inc(pPacket);
  Y := pPacket^;
  TPlatformGestureEngine(FEngine).AddPoint(X, Y);

  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.SystemEvent
  (piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID;
  event: SYSTEM_EVENT; eventdata: SYSTEM_EVENT_DATA): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.TabletAdded
  (piRtsSrc: IRealTimeStylus; piTablet: IInkTablet): HResult;
begin
  Result := S_OK;
end;

function TWinGestureEngine.TRealTimeStylus.TabletRemoved
  (piRtsSrc: IRealTimeStylus; iTabletIndex: Integer): HResult;
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
  if not Assigned(FRealTimeStylus) then
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

function TWinGestureEngine.TRealTimeStylus.UpdateMapping
  (piRtsSrc: IRealTimeStylus): HResult;
begin
  Result := S_OK;
end;

{ TPlatformGestureEngine }

class function TPlatformGestureEngine.GetGestureEngine(const AControl: TFmxObject): TGestureEngine;
begin
  Result := nil;
  if TWinGestureEngine.Supported then
    Result := TWinGestureEngine.Create(AControl);
end;

{ TGestureRecognizer }
// Takes into account margin of error returning a percentage of match.
// 100% match will be margin of error of deviation from the source point.
// 0% will be at deviation away and beyond.
function CheckPoint(const Point, Source: TPointF;
  Deviation, ErrorMargin: Integer): Double;
var
  Distance: Double;
  ErrorMarginDistance: Double;
  M, B: Double;
begin
  Deviation := Deviation;
  Distance := Sqrt(Sqr(Point.X - Source.X) + Sqr(Point.Y - Source.Y));
  ErrorMarginDistance := MulDiv(Deviation, ErrorMargin, 100);

  if Distance <= ErrorMarginDistance then
    Result := 100
  else if Distance > Deviation then
    Result := 0
  else
  begin
    M := (100 - ErrorMargin) / (ErrorMarginDistance - Deviation);
    B := ErrorMargin - (M * Deviation);
    Result := M * Distance + B;
  end;
end;

function CheckPointInGesture(Point: TPointF; const SourcePoints: array of TPointF;
  var Verification: TDoubleDynArray; ADeviation, ErrorMargin: Integer): Boolean;
var
  Index: Integer;
  Percentage: Double;
begin
  Result := False;

  for Index := 0 to Length(SourcePoints) - 1 do
  begin
    Percentage := CheckPoint(Point, SourcePoints[Index], ADeviation, ErrorMargin);
    if Percentage > ErrorMargin then
    begin
      if Verification[Index] < Percentage then
        Verification[Index] := Percentage;
      Result := True;
    end;
  end;
end;

function CheckPointInGestureWindow(Point: TPointF;
  const SourcePoints: array of TPointF; var GestureIndex: Integer;
  var Verification: TDoubleDynArray; ADeviation, ErrorMargin: Integer): Boolean;
var
  Index: Integer;
  Percentage: Double;
begin
  Result := False;
  for Index := 0 to GestureIndex do
  begin
    Percentage := CheckPoint(Point, SourcePoints[Index], ADeviation, ErrorMargin);
    if Percentage > ErrorMargin then
    begin
      if Verification[Index] < Percentage then
        Verification[Index] := Percentage;
      Result := True;
    end;
  end;
end;

type
  TLine = record
    Point1, Point2: TPointF;
  end;

  TCircle = record
    Point: TPointF;
    Radius: Integer;
  end;

function Line(Point1, Point2: TPointF): TLine; inline;
begin
  Result.Point1 := Point1;
  Result.Point2 := Point2;
end;

function Circle(Point: TPointF; Radius: Integer): TCircle; inline;
begin
  Result.Point := Point;
  Result.Radius := Radius;
end;

function LineIntersectsCircle(Line: TLine; Circle: TCircle): Boolean;
var
  A, B, C: Single;
begin
  A := Sqr(Line.Point2.X - Line.Point1.X) + Sqr(Line.Point2.Y - Line.Point1.Y);

  B := 2 * ((Line.Point2.X - Line.Point1.X) * (Line.Point1.X - Circle.Point.X) +
    (Line.Point2.Y - Line.Point1.Y) * (Line.Point1.Y - Circle.Point.Y));

  C := Sqr(Circle.Point.X) + Sqr(Circle.Point.Y) + Sqr(Line.Point1.X) +
    Sqr(Line.Point1.Y) - 2 * (Circle.Point.X * Line.Point1.X + Circle.Point.Y *
    Line.Point1.Y) - Sqr(Circle.Radius);

  Result := (B * B - 4 * A * C) > 0;
end;

function CheckLineIntersectsCircle(Line: TLine; const SourcePoints: array of TPointF;
  GestureIndex, Radius: Integer; var Verification: TIntegerDynArray): Boolean;
var
  Index: Integer;
begin
  Result := False;

  for Index := 0 to GestureIndex do
  begin
    if LineIntersectsCircle(Line, Circle(SourcePoints[Index], Radius)) then
    begin
      Result := True;
      Inc(Verification[Index]);
    end;
  end;
end;

function ReversePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index1, Index2, Count: Integer;
begin
  Count := Length(Points);
  SetLength(Result, Count);
  Index2 := Count - 1;

  for Index1 := 0 to Count - 1 do
  begin
    Result[Index2] := Points[Index1];
    Dec(Index2);
  end;
end;

type
  TGesturePoint = record
    Point: TPointF;
    Angle: Single;
    Index: Integer;
  end;

  TPointsList = TList<TGesturePoint>;

function Distance(Point1, Point2: TPointF): Single;
begin
  Result := Sqrt(Sqr(Point1.X - Point2.X) + Sqr(Point1.Y - Point2.Y));
end;

function TGestureRecognizer.CopyPoints(const Points: TGesturePoints)
  : TGesturePointArray;
var
  Index: Integer;
begin
  SetLength(Result, Points.Count);
  for Index := 0 to Points.Count - 1 do
    Result[Index] := Points[Index];
end;

function TGestureRecognizer.InterpolatePoints(const Points: array of TPointF)
  : TGesturePointArray;
var
  Index, PointsCount: Integer;
  StepX, StepY: Double;
  I, DeltaX, DeltaY, Count: Integer;
  CurrentPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  Count := 0; // avoid compiler warning
  StepX := 0; // avoid compiler warning
  StepY := 0; // avoid compiler warning
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        CurrentPoint := Points[Index];

        // Determine distance between points
        DeltaX := Round(NextPoint.X - CurrentPoint.X);
        DeltaY := Round(NextPoint.Y - CurrentPoint.Y);

        if (DeltaX <> 0) and (DeltaY <> 0) then
        begin
          if Abs(DeltaX) > Abs(DeltaY) then
            Count := Abs(DeltaY)
          else
            Count := Abs(DeltaX);

          StepX := DeltaX / Count;
          StepY := DeltaY / Count;
        end
        else if (DeltaX = 0) and (DeltaY <> 0) then
        begin
          StepX := 0;
          StepY := DeltaY div Abs(DeltaY);
          Count := Abs(DeltaY);
        end
        else if (DeltaX <> 0) and (DeltaY = 0) then
        begin
          StepY := 0;
          StepX := DeltaX div Abs(DeltaX);
          Count := Abs(DeltaX);
        end;

        for I := 1 to Count - 1 do
        begin
          ResultPoints.Add(PointF(CurrentPoint.X + Trunc(StepX * I),
            CurrentPoint.Y + Trunc(StepY * I)));
        end;
      end;

      ResultPoints.Add(NextPoint);
    end;

    Result := CopyPoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;

end;

function TGestureRecognizer.IsPointsGesture(const Points,
  GesturePoints: array of TPointF; GestureID: TGestureID;
  Deviation, ErrorMargin: Integer; var Percentages: array of Double): Integer;
  function DistanceBetween(Point1, Point2: TPointF): Single;
  begin
    Result := Sqrt(Sqr(Point1.X - Point2.X) + Sqr(Point1.Y - Point2.Y));
  end;

var
  Index: Integer;
  AnglesMatched: Integer;
  LowestPercentage: Double;
  DegreeError: Double;
  Match: TDoubleDynArray;
  GestureIndex: Integer;
  DistancePoints: array of TPointF;
  Distances: TSingleDynarray;
  Distance: Single;
  PointsCount: Integer;
  GestureCount: Integer;
  GestureAngles: array of Double;
  DistanceAngles: array of Double;
  LinesMatched: Integer;
  LinesMatch: TIntegerDynArray;
  PointsIndex: Integer;
  PointsMatch: TDoubleDynArray;
  Passes, Fails: Double;
  PassesCount, FailsCount: Integer;
  Point: TPointF;
  GesturePointsPercentage: Integer;
  PointsPercentage: Integer;
begin
  Result := 0;

  PointsCount := Length(Points);
  GestureCount := Length(GesturePoints);

  if (PointsCount = 0) or (GestureCount = 0) then
    Exit;

  SetLength(Match, GestureCount);
  SetLength(Distances, GestureCount);
  SetLength(DistancePoints, GestureCount);
  SetLength(GestureAngles, GestureCount);
  SetLength(DistanceAngles, GestureCount);
  SetLength(LinesMatch, GestureCount);
  SetLength(PointsMatch, PointsCount);
  PointsPercentage := 0;
  GestureIndex := 0;
  LinesMatched := 0;
  PointsIndex := 0;

  for Index := 0 to GestureCount - 1 do
  begin
    // Initialize distances between the points and the gestures as very far.
    Distances[Index] := MaxInt;

    { while (PointsIndex + 1 < PointsCount) and
      PtInCircle(GesturePoints[Index], Points[PointsIndex + 1], Deviation) do
      Inc(PointsIndex); }

    CheckPointInGestureWindow(GesturePoints[Index], Points, PointsIndex,
      PointsMatch, Deviation, ErrorMargin);
  end;

  for Index := 0 to PointsCount - 1 do
  begin
    Inc(PointsPercentage, Round(PointsMatch[Index]));

    { while (GestureIndex + 1 < GestureCount) and
      PtInCircle(Points[Index], GesturePoints[GestureIndex + 1], Deviation) do
      Inc(GestureIndex); }

    CheckPointInGestureWindow(Points[Index], GesturePoints, GestureIndex, Match, Deviation, ErrorMargin);

    if Index + 1 < PointsCount - 1 then
      CheckLineIntersectsCircle(Line(Points[Index], Points[Index + 1]),
        GesturePoints, GestureIndex, Deviation, LinesMatch);
  end;

  // Find the distances between the points.
  for Index := 0 to PointsCount - 1 do
  begin
    Point := Points[Index];

    for GestureIndex := 0 to GestureCount - 1 do
    begin
      // Calculate the closest point to the gesture points.
      Distance := DistanceBetween(Point, GesturePoints[GestureIndex]);

      if Distance < Distances[GestureIndex] then
      begin
        Distances[GestureIndex] := Distance;
        DistancePoints[GestureIndex] := Point;
      end;
    end;
  end;

  // Calculate the angle between the points and the gesture's points.
  Index := 0;
  GesturePointsPercentage := 0;
  while Index < GestureCount do
  begin
    Inc(GesturePointsPercentage, Round(Match[Index]));

    if LinesMatch[Index] > 0 then
      Inc(LinesMatched);

    if Index + 1 < GestureCount - 1 then
    begin
      GestureAngles[Index] := ArcTan2(GesturePoints[Index].X - GesturePoints[Index + 1].X,
        GesturePoints[Index].Y - GesturePoints[Index + 1].Y);
      DistanceAngles[Index] := ArcTan2(DistancePoints[Index].X - DistancePoints[Index + 1].X,
        DistancePoints[Index].Y - DistancePoints[Index + 1].Y);
    end
    else
    begin
      GestureAngles[Index] := ArcTan2(GesturePoints[Index - 1].X - GesturePoints
        [Index].X, GesturePoints[Index - 1].Y - GesturePoints[Index].Y);
      DistanceAngles[Index] := ArcTan2(DistancePoints[Index - 1].X - DistancePoints[Index].X,
        DistancePoints[Index - 1].Y - DistancePoints[Index].Y);
    end;

    Inc(Index);
  end;

  AnglesMatched := 0;
  DegreeError := (ErrorMargin * Pi) / 100;

  for Index := 0 to GestureCount - 1 do
  begin
    if (DistanceAngles[Index] = 0) or ((GestureAngles[Index] - DegreeError) < DistanceAngles[Index]) and
      (DistanceAngles[Index] < (GestureAngles[Index] + DegreeError)) then
    begin
      Inc(AnglesMatched);
    end;
  end;

  Percentages[0] := PointsPercentage div PointsCount;
  Percentages[1] := GesturePointsPercentage div GestureCount;
  Percentages[2] := MulDiv(100, AnglesMatched, GestureCount);
  Percentages[3] := MulDiv(100, LinesMatched, GestureCount);

  LowestPercentage := MaxInt;

  for Index := 0 to Length(Percentages) - 1 do
  begin
    if Percentages[Index] < LowestPercentage then
      LowestPercentage := Percentages[Index];
  end;

  if (100 - ErrorMargin) < LowestPercentage then
    Result := Trunc(LowestPercentage)
  else
  begin
    Passes := 0;
    PassesCount := 0;
    Fails := 0;
    FailsCount := 0;

    for Index := 0 to Length(Percentages) - 1 do
    begin
      if Percentages[Index] <= ((100 - ErrorMargin) div 4) then
        Exit;

      if (100 - ErrorMargin) < Percentages[Index] then
      begin
        Inc(PassesCount);
        Passes := Passes + Percentages[Index];
      end
      else
      begin
        Inc(FailsCount);
        Fails := Fails + Percentages[Index];
      end;
    end;

    if (Passes <> 0) and (Fails <> 0) then
    begin
      Passes := Passes / PassesCount;
      Fails := Fails / FailsCount;
      Result := Trunc((Passes + Fails) / 2);

      if (100 - ErrorMargin) >= Result then
        Result := 0;
    end;
  end;
end;

type
  TSegmentArray = array of TGesturePointArray;

function TGestureRecognizer.IsScratchout(const Points: array of TPointF;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer;
  var Percentages: array of Double): Integer;
  function SegmentPoints(const Points: array of TPointF; var Right: Boolean): TSegmentArray;
  var
    Index: Integer;
    Max, Min: Extended;
    Segment: TGesturePoints;
    Diff: Extended;
    LRight: Boolean;
  begin
    Min := MaxInt;
    Max := 0;
    if Length(Points) <= 2 then
      Exit;

    Diff := Points[1].X - Points[0].X;

    if Diff = 0 then
      Exit
    else if Diff > 0 then
      Right := True
    else
      Right := False;

    LRight := Right;
    Segment := TGesturePoints.Create;

    try
      for Index := 0 to Length(Points) - 1 do
      begin
        if LRight and (Points[Index].X > Max) then
        begin
          Max := Points[Index].X;
          Segment.Add(Points[Index]);
        end
        else if not LRight and (Points[Index].X < Min) then
        begin
          Min := Points[Index].X;
          Segment.Add(Points[Index]);
        end
        else if Points[Index].X = 0 then
        begin
          Segment.Add(Points[Index]);
        end
        else
        begin
          SetLength(Result, Length(Result) + 1);
          Result[Length(Result) - 1] := CopyPoints(Segment);
          Min := MaxInt;
          Max := 0;
          Segment.Clear;
          Segment.Add(Points[Index]);
          LRight := not LRight;
        end;
      end;

      if Segment.Count > 0 then
      begin
        SetLength(Result, Length(Result) + 1);
        Result[Length(Result) - 1] := CopyPoints(Segment);
      end;

      // The last line segment may be short, so if it is less than a few points
      // throw it out.
      if (Length(Result) > 0) and (Length(Result[Length(Result) - 1]) < 5) then
        SetLength(Result, Length(Result) - 1);
    finally
      Segment.Free;
    end;
  end;

  function HeightDeviation(const Points: array of TPointF): Extended;
  var
    Index, Count: Integer;
    Min, Max: Extended;
    Point: TPointF;
  begin
    Result := MaxInt;
    Count := Length(Points);

    if Count > 0 then
    begin
      Min := MaxInt;
      Max := 0;

      for Index := 0 to Count - 1 do
      begin
        Point := Points[Index];

        if Point.Y < Min then
          Min := Point.Y;
        if Point.Y > Max then
          Max := Point.Y;
      end;

      Result := Max - Min;
    end;
  end;

var
  Index, PercentagesIndex: Integer;
  Segments: TSegmentArray;
  Gesture, SecondGesture, FirstGesture: TStandardGestureData;
  Right: Boolean;
  LPoints, LGesturePoints, LFirstPoints, LSecondPoints: TGesturePointArray;
  Results: array of Integer;
  SegmentsCount, Weight: Integer;
  LowestPercentage: Double;
  LPercentages: array of Double;
  Angles: array of Double;
begin
  Result := 0;
  LPoints := RemoveDuplicates(Points);
  if HeightDeviation(LPoints) > Deviation then
    Exit;
  Segments := SegmentPoints(LPoints, Right);
  SegmentsCount := Length(Segments);

  if SegmentsCount >= 3 then
  begin
    SetLength(LPercentages, Length(Percentages));
    SetLength(Angles, SegmentsCount);

    if Right then
    begin
      FindStandardGesture(sgiRight, FirstGesture);
      LFirstPoints := InterpolatePoints(FirstGesture.Points);
      LFirstPoints := RemoveDuplicates(LFirstPoints);

      FindStandardGesture(sgiLeft, SecondGesture);
      LSecondPoints := InterpolatePoints(SecondGesture.Points);
      LSecondPoints := RemoveDuplicates(LSecondPoints);
    end
    else
    begin
      FindStandardGesture(sgiLeft, FirstGesture);
      LFirstPoints := InterpolatePoints(FirstGesture.Points);
      LFirstPoints := RemoveDuplicates(LFirstPoints);

      FindStandardGesture(sgiRight, SecondGesture);
      LSecondPoints := InterpolatePoints(SecondGesture.Points);
      LSecondPoints := RemoveDuplicates(LSecondPoints);
    end;

    for Index := 0 to SegmentsCount - 1 do
    begin
      case Index mod 2 of
        0:
          begin
            Gesture := FirstGesture;
            LGesturePoints := LFirstPoints;
          end;
        1:
          begin
            Gesture := SecondGesture;
            LGesturePoints := LSecondPoints;
          end;
      end;

      LPoints := RotatePoints(Segments[Index], LGesturePoints, ErrorMargin, Angles[Index]);
      LPoints := NormalizePoints(LPoints);
      LPoints := ScalePoints(LPoints, Gesture.Points, Deviation, False);
      LPoints := RemoveDuplicates(LPoints);
      Weight := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
        ErrorMargin, LPercentages);
      SetLength(Results, Length(Results) + 1);
      Results[Length(Results) - 1] := Weight;

      for PercentagesIndex := 0 to Length(Percentages) - 1 do
      begin
        Percentages[PercentagesIndex] := Percentages[PercentagesIndex] + LPercentages[PercentagesIndex];
        LPercentages[PercentagesIndex] := 0;
      end;
    end;

    LowestPercentage := MaxInt;

    for PercentagesIndex := 0 to Length(Percentages) - 1 do
      Percentages[PercentagesIndex] := Percentages[PercentagesIndex] / SegmentsCount;

    for Index := 0 to Length(Percentages) - 1 do
    begin
      if Percentages[Index] < LowestPercentage then
        LowestPercentage := Percentages[Index];
    end;

    if (100 - ErrorMargin) < LowestPercentage then
      Result := Trunc(LowestPercentage);
  end;
end;

function TGestureRecognizer.Match(const Points, GesturePoints: array of TPointF;
  const Options: TGestureOptions; GestureID: TGestureID;
  Deviation, ErrorMargin: Integer): Single;
var
  LErrorMargin: Integer;
  LPoints, LGesturePoints: TGesturePointArray;
  { PointCount, } GesturePointCount: Integer;
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
    if TGestureOption.goRotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation, TGestureOption.goSkew in Options);
    LPoints := RemoveDuplicates(LPoints);
    { if (TGestureOption.goUniDirectional in Options) and
      not PtInCircle(LPoints[0], GesturePoints[0], Deviation) then
      Exit; }

    // PointCount := Length(LPoints);
    { if (TGestureOption.goEndpoint in Options) and
      (not PtInCircle(LPoints[PointCount - 1], GesturePoints[GesturePointCount - 1], Deviation)) then
      begin
      Exit;
      end; }

    LGesturePoints := InterpolatePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);
    //GesturePointCount := Length(GesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID, Deviation,
      LErrorMargin, Percentages);

    // If the gesture failed and the gesture is a bidirectional gesture,
    // and the start and end points of the gesture are the same, then reverse
    // the gesture and test again.
    { if (Result < LErrorMargin) and not (TGestureOption.goUniDirectional in Options) and
      PtInCircle(LPoints[0], GesturePoints[GesturePointCount - 1], Deviation) then
      begin
      Result := IsPointsGesture(LPoints, ReversePoints(LGesturePoints), GestureID,
      Deviation, LErrorMargin, Percentages);
      end; }
  finally
    if Assigned(FPostCallback) then
      FPostCallback(Percentages, LPoints, GesturePoints, GestureID);
  end;

end;

function TGestureRecognizer.NormalizePoints(const Points: array of TPointF): TGesturePointArray;
var
  Index: Integer;
  SmallestX, SmallestY: Single;
begin
  SetLength(Result, Length(Points));
  // Find the delta.
  SmallestX := MaxInt;
  SmallestY := MaxInt;

  for Index := 0 to Length(Points) - 1 do
  begin
    if SmallestX > Points[Index].X then
      SmallestX := Points[Index].X;

    if SmallestY > Points[Index].Y then
      SmallestY := Points[Index].Y;
  end;

  // Apply the delta.
  SetLength(Result, Length(Points));
  for Index := 0 to Length(Points) - 1 do
    Result[Index] := PointF(Points[Index].X - SmallestX, Points[Index].Y - SmallestY);
end;

function TGestureRecognizer.RemoveDuplicates(const Points: array of TPointF): TGesturePointArray;
var
  Index, PointsCount: Integer;
  LastPoint, NextPoint: TPointF;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then
    Exit;
  ResultPoints := TGesturePoints.Create;

  try
    ResultPoints.Add(Points[0]);

    for Index := 0 to Length(Points) - 1 do
    begin
      if Index < Length(Points) - 1 then
      begin
        NextPoint := Points[Index + 1];
        LastPoint := Points[Index];

        if (LastPoint.X <> NextPoint.X) or (LastPoint.Y <> NextPoint.Y) then
          ResultPoints.Add(NextPoint);
      end;
    end;

    Result := CopyPoints(ResultPoints);
  finally
    ResultPoints.Free;
  end;

end;

function TGestureRecognizer.RotatePoints(const Points, GesturePoints
  : array of TPointF; ErrorMargin: Integer; var Angle: Double)
  : TGesturePointArray;
  function WithinError(const Point1, Point2: TPointF; ErrorMargin: Integer;
    var Angle: Double): Boolean;
  var
    Angle1, Angle2: Double;
    DegreeError: Double;
  begin
    Result := False;
    Angle1 := ArcTan2(Point1.X, Point1.Y);
    Angle2 := ArcTan2(Point2.X, Point2.Y);
    Angle := Angle1 - Angle2;
    DegreeError := (ErrorMargin * Pi) / 100;
    if Abs(Angle) < DegreeError then
      Result := True;
  end;

var
  Index, GestureCount, PointsCount: Integer;
  Origin, Point2: TPointF;
  Success: Boolean;
begin
  Success := False;
  GestureCount := Length(GesturePoints);
  PointsCount := Length(Points);
  SetLength(Result, PointsCount);

  if (GestureCount > 1) and (PointsCount > 1) then
  begin
    Origin := GesturePoints[0];
    Point2 := GesturePoints[GestureCount - 1];

    if (Origin.X = Points[0].X) and (Origin.Y = Points[0].Y) then
    begin
      if WithinError(Point2, Points[PointsCount - 1], ErrorMargin, Angle) then
      begin
        Success := True;
        for Index := 0 to Length(Points) - 1 do
        begin
          Result[Index].X := Trunc(Points[Index].X * Cos(Angle) + Points[Index].Y * Sin(Angle));
          Result[Index].Y := Trunc(Points[Index].Y * Cos(Angle) - Points[Index].X * Sin(Angle));
        end;
      end;
    end;
  end;

  if not Success and (PointsCount > 0) then
  begin
    SetLength(Result, PointsCount);
    Move(Points[0], Result[0], PointsCount * SizeOf(TPointF));
  end;
end;

function TGestureRecognizer.ScalePoints(const Points, GesturePoints
  : array of TPointF; MinScale: Integer; Scaling: Boolean): TGesturePointArray;
var
  Index: Integer;
  LargestX1, LargestX2, LargestY1, LargestY2: Extended;
  ScaleX, ScaleY, Scale: Double;
  P: TPointF;
begin
  // Find the delta.
  LargestX1 := 0;
  LargestY1 := 0;
  LargestX2 := 0;
  LargestY2 := 0;

  for Index := 0 to Length(Points) - 1 do
  begin
    if LargestX1 < Abs(Points[Index].X) then
      LargestX1 := Abs(Points[Index].X);

    if LargestY1 < Abs(Points[Index].Y) then
      LargestY1 := Abs(Points[Index].Y);
  end;

  for Index := 0 to Length(GesturePoints) - 1 do
  begin
    if LargestX2 < Abs(GesturePoints[Index].X) then
      LargestX2 := Abs(GesturePoints[Index].X);

    if LargestY2 < Abs(GesturePoints[Index].Y) then
      LargestY2 := Abs(GesturePoints[Index].Y);
  end;

  if (LargestX1 = 0) or (LargestX2 = 0) then
    ScaleX := 1
  else
    ScaleX := LargestX2 / LargestX1;

  if (LargestY1 = 0) or (LargestY2 = 0) then
    ScaleY := 1
  else
    ScaleY := LargestY2 / LargestY1;

  // Apply the scale.
  SetLength(Result, Length(Points));

  if Scaling or (ScaleX = 1) or (ScaleY = 1) then
  begin
    for Index := 0 to Length(Result) - 1 do
    begin
      P := Points[Index];

      Result[Index] := PointF(Round(P.X * ScaleX), Round(P.Y * ScaleY));
    end;
  end
  else if (ScaleX <> 1) and (ScaleY <> 1) then
  begin
    if ScaleX < ScaleY then
      Scale := ScaleX
    else
      Scale := ScaleY;

    for Index := 0 to Length(Result) - 1 do
    begin
      P := Points[Index];

      Result[Index] := PointF(Round(P.X * Scale), Round(P.Y * Scale));
    end;
  end;

end;

end.
