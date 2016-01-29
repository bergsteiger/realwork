{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Vcl.Touch.Gestures;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.RtsCom, Winapi.TpcShrd, Winapi.MsInkAut,
{$ENDIF}
  Winapi.Windows, System.Types, System.Classes, System.SysUtils, System.Diagnostics, Vcl.Controls, Vcl.ActnList, Winapi.Messages,
  System.Generics.Collections;

type
  TGesturePoints = TList<TPoint>;

  TGestureEngine = class;

  TGestureList = TList<TCustomGestureCollectionItem>;

  TGestureEngineClass = class of TCustomGestureEngine;
  TCustomGestureRecognizer = class;
  TCustomGestureRecognizerClass = class of TCustomGestureRecognizer;

  TGestureEngine = class(TCustomGestureEngine)
  strict private
    class var FDefaultEngineClass: TGestureEngineClass;
    class var FDefaultRecognizerClass: TCustomGestureRecognizerClass;
    class var FRecognizer: TCustomGestureRecognizer;
    class var FSensitivity: Integer;
    class var FTimeOut: Integer;
    class constructor Create;
    class destructor Destroy;
    class function GetRecognizer: TCustomGestureRecognizer; static;
    class procedure SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass); static;
    class procedure SetSensitivity(const Value: Integer); static;
  strict private
    FControl: TWinControl;
    FInitialPoint: TPoint;
    FPoints: TGesturePoints;
    FStopWatch: TStopWatch;
    FTargetControl: TControl;
    function GetPointCount: Integer;
    function GetPoints: TGesturePointArray;
    function GetTimerExpired: Boolean;
    procedure SetInitialPoint(const Value: TPoint);
  protected
    procedure AddPoint(X, Y: Integer);
    procedure BroadcastGesture(AControl: TControl; EventInfo: TGestureEventInfo);
    procedure ClearPoints;
    class procedure GetCompleteGestureList(AControl: TControl; AGestureList: TGestureList);
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
    procedure ResetTimer;
    procedure StartTimer;
    property Control: TWinControl read FControl;
    property InitialPoint: TPoint read FInitialPoint write SetInitialPoint;
    property PointCount: Integer read GetPointCount;
    property Points: TGesturePointArray read GetPoints;
    property TargetControl: TControl read FTargetControl write FTargetControl;
    property TimerExpired: Boolean read GetTimerExpired;
  public
    class procedure CreateEngine(AControl: TControl);
    class function IsGesture(const Points: array of TPoint; Items: TGestureList;
      GestureTypes: TGestureTypes; var EventInfo: TGestureEventInfo): Boolean;
    class property DefaultEngineClass: TGestureEngineClass
      read FDefaultEngineClass write FDefaultEngineClass;
    class property DefaultRecognizerClass: TCustomGestureRecognizerClass
      read FDefaultRecognizerClass write SetDefaultRecognizerClass;
    class property Recognizer: TCustomGestureRecognizer read GetRecognizer;
    class property Sensitivity: Integer read FSensitivity write SetSensitivity;
    class property TimeOut: Integer read FTimeOut write FTimeOut;
  public
    constructor Create(AControl: TWinControl); override;
    destructor Destroy; override;
    procedure Notification(const Message: TMessage); override;
  end;

{$IFDEF MSWINDOWS}
  TPlatformGestureEngine = class sealed(TGestureEngine)
  strict private type
    TRealTimeStylus = class(TInterfacedObject, IStylusAsyncPlugin)
    strict private
      FEnabled: Boolean;
      FEngine: TGestureEngine;
      FGestureRecognizer: IGestureRecognizer;
      FGestureList: TGestureList;
      FHandle: HWND;
      FRealTimeStylus: IRealTimeStylus;
      procedure AddStylusAsyncPlugin(APlugin: IStylusAsyncPlugin);
      procedure AddStylusSyncPlugin(APlugin: IStylusSyncPlugin);
      procedure SetEnabled(const Value: Boolean);
      procedure SetHandle(const Value: HWND);
      class function StandardGestureMap(AGesture: TStandardGesture): Integer;
      class function StylusGestureMap(AGesture: Integer): Integer;
    public // IStylusAsyncPlugin
      function RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus;
        cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus;
        cTcidCount: Cardinal; var pTcids: TABLET_CONTEXT_ID): HResult; stdcall;
      function StylusInRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
        sid: STYLUS_ID): HResult; stdcall;
      function StylusOutOfRange(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
        sid: STYLUS_ID): HResult; stdcall;
      function StylusDown(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
        cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusUp(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
        cPropCountPerPkt: Cardinal; pPacket: PInteger; var ppInOutPkt: PInteger): HResult; stdcall;
      function StylusButtonDown(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
        const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HResult; stdcall;
      function StylusButtonUp(piRtsSrc: IRealTimeStylus; sid: STYLUS_ID;
        const pGuidStylusButton: TGUID; var pStylusPos: TPoint): HResult; stdcall;
      function InAirPackets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
        cPktCount: Cardinal; cPktBuffLength: Cardinal; pPackets: PInteger;
        var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HResult; stdcall;
      function Packets(piRtsSrc: IRealTimeStylus; const pStylusInfo: TStylusInfo;
        cPktCount: Cardinal; cPktBuffLength: Cardinal; pPackets: PInteger;
        var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HResult; stdcall;
      function CustomStylusDataAdded(piRtsSrc: IRealTimeStylus; const pGuidId: TGUID;
        cbData: Cardinal; pbData: PBYTE): HResult; stdcall;
      function SystemEvent(piRtsSrc: IRealTimeStylus; tcid: TABLET_CONTEXT_ID;
        sid: STYLUS_ID; event: SYSTEM_EVENT;
        eventdata: SYSTEM_EVENT_DATA): HResult; stdcall;
      function TabletAdded(piRtsSrc: IRealTimeStylus;
        piTablet: IInkTablet): HResult; stdcall;
      function TabletRemoved(piRtsSrc: IRealTimeStylus;
        iTabletIndex: Integer): HResult; stdcall;
      function Error(piRtsSrc: IRealTimeStylus; piPlugin: IStylusPlugin;
        dataInterest: RealTimeStylusDataInterest; hrErrorCode: HResult;
        var lptrKey: LONG_PTR): HResult; stdcall;
      function UpdateMapping(piRtsSrc: IRealTimeStylus): HResult; stdcall;
      function DataInterest(out pDataInterest: RealTimeStylusDataInterest): HResult; stdcall;
    public
      constructor Create(Engine: TGestureEngine); overload; virtual;
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
    constructor Create(AControl: TWinControl); override;
    destructor Destroy; override;
    class function Supported: Boolean; override;
  end;
{$ENDIF}

  TMouseGestureEngine = class sealed(TGestureEngine)
  strict private
    FActive: Boolean;
  protected
    function GetActive: Boolean; override;
    function GetFlags: TCustomGestureEngine.TGestureEngineFlags; override;
    procedure SetActive(const Value: Boolean); override;
  public
    destructor Destroy; override;
    procedure Notification(const Message: TMessage); override;
    class function Supported: Boolean; override;
  end;

  TCustomGestureRecognizer = class
  public
    function Match(const Points, GesturePoints: array of TPoint;
      const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; virtual; abstract;
    function NormalizePoints(const Points: array of TPoint): TGesturePointArray; virtual; abstract;
    function ScalePoints(const Points, GesturePoints: array of TPoint;
      MinScale: Integer; Scaling: Boolean = False): TGesturePointArray; virtual; abstract;
  end;

  TGestureRecognizer = class(TCustomGestureRecognizer)
  strict private type
    TPreCallback = procedure(const Points, GesturePoints: array of TPoint;
      GestureID: TGestureID; Deviation, ErrorMargin: Integer) of object;
    TPostCallback = procedure(const Percentages: array of Double;
      const Points, GesturePoints: array of TPoint; GestureID: TGestureID) of object;
    TGestureFunc = function(const Points, GesturePoints: array of TPoint;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer of object;
  private
    function IsPointsGesture(const Points, GesturePoints: array of TPoint;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer;
    function IsScratchout(const Points: array of TPoint;
      GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
      var Percentages: array of Double): Integer;
    function CopyPoints(Points: TGesturePoints): TGesturePointArray;
    function InterpolatePoints(const Points: array of TPoint): TGesturePointArray;
    function RemoveDuplicates(const Points: array of TPoint): TGesturePointArray;
    function RotatePoints(const Points, GesturePoints: array of TPoint;
      ErrorMargin: Integer; var Angle: Double): TGesturePointArray;
  protected
    FPreCallback: TPreCallback;   // for internal use only
    FPostCallback: TPostCallback; // for internal use only
  public
    function Match(const Points, GesturePoints: array of TPoint;
      const Options: TGestureOptions; GestureID: TGestureID;
      Deviation, ErrorMargin: Integer): Single; override;
    function NormalizePoints(const Points: array of TPoint): TGesturePointArray; override;
    function ScalePoints(const Points, GesturePoints: array of TPoint;
      MinScale: Integer; Scaling: Boolean = False): TGesturePointArray; override;
  end;

function GestureToIdent(ID: Integer; var Ident: string): Boolean;
function IdentToGesture(const Ident: string; var ID: Integer): Boolean;

type
  TStandardGestureData = record
    Points: TGesturePointArray;
    GestureID: TGestureID;
    Options: TGestureOptions;
    Deviation: Integer;
    ErrorMargin: Integer;
  end;

function FindStandardGesture(AGestureID: TGestureID; var AGestureData: TStandardGestureData): Boolean; overload;
function FindStandardGesture(const AName: string; var AGestureID: TGestureID): Boolean; overload;

implementation

uses
  Winapi.ActiveX, System.TypInfo, System.Math, Vcl.Touch.GestureConsts, Vcl.Consts, Vcl.Touch.GestureMgr,
  Vcl.Forms;

const
  CustomGestureTypes: TGestureTypes = [gtRecorded, gtRegistered];

  GestureNameMap: array[0..34] of TIdentMapEntry = (
    (Value: sgiNoGesture;       Name: 'sgiNoGesture'),
    (Value: sgiLeft;            Name: 'sgiLeft'),
    (Value: sgiRight;           Name: 'sgiRight'),
    (Value: sgiUp;              Name: 'sgiUp'),
    (Value: sgiDown;            Name: 'sgiDown'),
    (Value: sgiUpLeft;          Name: 'sgiUpLeft'),
    (Value: sgiUpRight;         Name: 'sgiUpRight'),
    (Value: sgiDownLeft;        Name: 'sgiDownLeft'),
    (Value: sgiDownRight;       Name: 'sgiDownRight'),
    (Value: sgiLeftUp;          Name: 'sgiLeftUp'),
    (Value: sgiLeftDown;        Name: 'sgiLeftDown'),
    (Value: sgiRightUp;         Name: 'sgiRightUp'),
    (Value: sgiRightDown;       Name: 'sgiRightDown'),
    (Value: sgiUpDown;          Name: 'sgiUpDown'),
    (Value: sgiDownUp;          Name: 'sgiDownUp'),
    (Value: sgiLeftRight;       Name: 'sgiLeftRight'),
    (Value: sgiRightLeft;       Name: 'sgiRightLeft'),
    (Value: sgiUpLeftLong;      Name: 'sgiUpLeftLong'),
    (Value: sgiUpRightLong;     Name: 'sgiUpRightLong'),
    (Value: sgiDownLeftLong;    Name: 'sgiDownLeftLong'),
    (Value: sgiDownRightLong;   Name: 'sgiDownRightLong'),
    (Value: sgiScratchout;      Name: 'sgiScratchout'),
    (Value: sgiTriangle;        Name: 'sgiTriangle'),
    (Value: sgiSquare;          Name: 'sgiSquare'),
    (Value: sgiCheck;           Name: 'sgiCheck'),
    (Value: sgiCurlicue;        Name: 'sgiCurlicue'),
    (Value: sgiDoubleCurlicue;  Name: 'sgiDoubleCurlicue'),
    (Value: sgiCircle;          Name: 'sgiCircle'),
    (Value: sgiDoubleCircle;    Name: 'sgiDoubleCircle'),
    (Value: sgiSemiCircleLeft;  Name: 'sgiSemiCircleLeft'),
    (Value: sgiSemiCircleRight; Name: 'sgiSemiCircleRight'),
    (Value: sgiChevronUp;       Name: 'sgiChevronUp'),
    (Value: sgiChevronDown;     Name: 'sgiChevronDown'),
    (Value: sgiChevronLeft;     Name: 'sgiChevronLeft'),
    (Value: sgiChevronRight;    Name: 'sgiChevronRight'));

function GestureToIdent(ID: Integer; var Ident: string): Boolean;
begin
  Result := IntToIdent(ID, Ident, GestureNameMap);
end;

function IdentToGesture(const Ident: string; var ID: Integer): Boolean;
begin
  Result := IdentToInt(Ident, ID, GestureNameMap);
end;

function GesturePointsToArray(Source: TGesturePoints): TGesturePointArray;
var
  I: Integer;
begin
  SetLength(Result, Source.Count);
  for I := 0 to Source.Count - 1 do
    Result[I] := Source[I];
end;

function GetSysErrorMessage(ErrorCode: HRESULT): string; inline;
begin
  Result := SysErrorMessage(Cardinal(ErrorCode));
end;

{ TGestureEngine }

class constructor TGestureEngine.Create;
begin
  FRecognizer := nil;
  FDefaultRecognizerClass := TGestureRecognizer;
{$IFDEF MSWINDOWS}
  FDefaultEngineClass := TPlatformGestureEngine;
{$ELSE}
  FDefaultEngineClass := TMouseGestureEngine;
{$ENDIF}
  FSensitivity := 80; // 80% by default
  FTimeOut := 5000; // time out delay in milliseconds
end;

constructor TGestureEngine.Create(AControl: TWinControl);
begin
  FControl := AControl;
  FStopWatch := TStopWatch.Create;
end;

class destructor TGestureEngine.Destroy;
begin
  if FRecognizer <> nil then
    FreeAndNil(FRecognizer);
end;

destructor TGestureEngine.Destroy;
begin
  if FPoints <> nil then
    FreeAndNil(FPoints);
  inherited;
end;

procedure TGestureEngine.AddPoint(X, Y: Integer);
var
  StepX, StepY: Single;
  I, DeltaX, DeltaY: Integer;
  LastPoint, NextPoint: TPoint;
  CountX, CountY, Count: Integer;
begin
  if FPoints = nil then
    FPoints := TGesturePoints.Create;

  if FPoints.Count = 0 then
    FPoints.Add(Point(X, Y))
  else
  begin
    NextPoint := Point(X, Y);
    LastPoint := FPoints[FPoints.Count - 1];

    // Determine distance between points
    DeltaX := Abs(NextPoint.X - LastPoint.X);
    DeltaY := Abs(NextPoint.Y - LastPoint.Y);

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
        FPoints.Add(Point(LastPoint.X + Round(StepX * I),
          LastPoint.Y + Round(StepY * I)));
    end;

    // Add captured point
    FPoints.Add(NextPoint);
  end;
end;

procedure TGestureEngine.BroadcastGesture(AControl: TControl; EventInfo: TGestureEventInfo);
var
  LControl: TControl;
  LItem: TCustomGestureCollectionItem;
begin
  // Find control that will respond to the gesture
  LItem := nil;
  LControl := AControl;
  while LControl <> nil do
  begin
    if LControl.Touch.GestureManager <> nil then
      if EventInfo.GestureID <> sgiNoGesture then
      begin
        LItem := LControl.Touch.GestureManager.FindGesture(LControl, EventInfo.GestureID);
        if LItem <> nil then
          Break;
      end
      else
        Break;
    LControl := LControl.Parent;
  end;

  // Execute the action or notify the control
  if (LItem <> nil) and (LItem.Action <> nil) then
    LItem.Action.Execute
  else if LControl <> nil then
  begin
    EventInfo.Location := LControl.ScreenToClient(FInitialPoint);
    LControl.Perform(CM_GESTURE, 0, LPARAM(@EventInfo));
  end;
end;

procedure TGestureEngine.ClearPoints;
begin
  if FPoints = nil then
    FPoints := TGesturePoints.Create
  else
    FPoints.Clear;
end;

function TGestureEngine.GetPoints: TGesturePointArray;
begin
  if FPoints <> nil then
    Result := GesturePointsToArray(FPoints)
  else
    Result := TGesturePointArray.Create();
end;

function TGestureEngine.GetPointCount: Integer;
begin
  if FPoints <> nil then
    Result := FPoints.Count
  else
    Result := 0;
end;

class procedure TGestureEngine.CreateEngine(AControl: TControl);

  function InternalCreateEngine(AWinControl: TWinControl): TCustomGestureEngine;
  begin
    if DefaultEngineClass.Supported then
      Result := DefaultEngineClass.Create(AWinControl)
    else
      Result := TMouseGestureEngine.Create(AWinControl);
  end;

var
  I: Integer;
begin
  if not (csDesigning in AControl.ComponentState) then
    if AControl is TWinControl then
    begin
      if AControl.Touch.GestureEngine = nil then
      begin
        AControl.Touch.GestureEngine := InternalCreateEngine(TWinControl(AControl));
        for I := 0 to TWinControl(AControl).ControlCount - 1 do
          if TWinControl(AControl).Controls[I] is TWinControl then
            CreateEngine(TWinControl(TWinControl(AControl).Controls[I]));
      end;
    end
    else
    begin
      if AControl.Parent.Touch.GestureEngine = nil then
        AControl.Parent.Touch.GestureEngine := InternalCreateEngine(AControl.Parent);
    end;
end;

class procedure TGestureEngine.GetCompleteGestureList(AControl: TControl; AGestureList: TGestureList);
var
  LControl: TControl;
  LItem: TCustomGestureCollectionItem;
begin
  LControl := AControl;
  while LControl <> nil do
  begin
    if LControl.Touch.GestureManager <> nil then
      for LItem in LControl.Touch.GestureList do
        AGestureList.Add(LItem);
    LControl := LControl.Parent;
  end;
end;

function TGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [];
end;

class function TGestureEngine.GetRecognizer: TCustomGestureRecognizer;
var
  LRecognizer: TCustomGestureRecognizer;
begin
  if FRecognizer = nil then
  begin
    LRecognizer := FDefaultRecognizerClass.Create;
    if InterlockedCompareExchangePointer(Pointer(FRecognizer), LRecognizer, nil) <> nil then
      LRecognizer.Free;
  end;
  Result := FRecognizer;
end;

function TGestureEngine.GetTimerExpired: Boolean;
begin
  Result := not FStopWatch.IsRunning or (FStopWatch.ElapsedMilliseconds > FTimeOut);
  if Result then
    FStopWatch.Stop;
end;

class function TGestureEngine.IsGesture(const Points: array of TPoint; Items: TGestureList;
  GestureTypes: TGestureTypes; var EventInfo: TGestureEventInfo): Boolean;
var
  LItem: TCustomGestureCollectionItem;
  LData: TStandardGestureData;
  LWeight, TempWeight: Single;
  LEventInfo: TGestureEventInfo;
  I: Integer;
begin
  Result := False;
  ZeroMemory(@LEventInfo, SizeOf(LEventInfo));
  EventInfo := LEventInfo;

  if Items = nil then
    Exit;

  LWeight := 0;

  // Process standard gestures
  if gtStandard in GestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType = gtStandard then
      begin
        if not FindStandardGesture(LItem.GestureID, LData) then
          raise EGestureException.CreateResFmt(@SInvalidGestureID, [LItem.GestureID]);

        TempWeight := Recognizer.Match(Points, LData.Points, LData.Options,
          LData.GestureID, LData.Deviation, LData.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          LEventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
  begin
    EventInfo := LEventInfo;
    Exit(True);
  end;

  // Process custom gestures
  if CustomGestureTypes * GestureTypes = CustomGestureTypes then
    for I := 0 to Items.Count - 1 do
    begin
      LItem := Items[I];
      if LItem.GestureType in CustomGestureTypes then
      begin
        TempWeight := Recognizer.Match(Points, LItem.Points, LItem.Options,
          LItem.GestureID, LItem.Deviation, LItem.ErrorMargin);

        if TempWeight > LWeight then
        begin
          LWeight := TempWeight;
          LEventInfo.GestureID := LItem.GestureID;
        end;
      end;
    end;

  if LWeight > 0 then
  begin
    EventInfo := LEventInfo;
    Exit(True);
  end;

  // No gesture was recognized. Return True if 3 or more points are in the list
  // so the listener is notified that a gesture occurred but wasn't recognized
  EventInfo.GestureID := sgiNoGesture;
  Result := Length(Points) >= 3;
end;

procedure TGestureEngine.Notification(const Message: TMessage);
begin
  // Do nothing
end;

procedure TGestureEngine.ResetTimer;
begin
  FStopWatch.Reset;
end;

class procedure TGestureEngine.SetDefaultRecognizerClass(const Value: TCustomGestureRecognizerClass);
begin
  if Value <> FDefaultRecognizerClass then
  begin
    FDefaultRecognizerClass := Value;
    if FRecognizer <> nil then
      FreeAndNil(FRecognizer);
  end;
end;

procedure TGestureEngine.SetInitialPoint(const Value: TPoint);
begin
  FInitialPoint := Value;
end;

class procedure TGestureEngine.SetSensitivity(const Value: Integer);
begin
  if Value <> FSensitivity then
  begin
    if (Value > 0) and (Value <= 100) then
      FSensitivity := Value
    else
      raise Exception.CreateResFmt(@SOutOfRange, [1, 100]);
  end;
end;

procedure TGestureEngine.StartTimer;
begin
  FStopWatch.Reset;
  FStopWatch.Start;
end;

{ TPlatformGestureEngine.TRealTimeStylus }

{$IFDEF MSWINDOWS}
constructor TPlatformGestureEngine.TRealTimeStylus.Create(Engine: TGestureEngine);
begin
  inherited Create;
  FEngine := Engine;
  FGestureList := TGestureList.Create;
end;

destructor TPlatformGestureEngine.TRealTimeStylus.Destroy;
begin
  FreeAndNil(FGestureList);
  inherited;
end;

procedure TPlatformGestureEngine.TRealTimeStylus.AddStylusAsyncPlugin(APlugin: IStylusAsyncPlugin);
var
  Count: Cardinal;
  LResult: HRESULT;
begin
  LResult := FRealTimeStylus.GetStylusAsyncPluginCount(Count);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);

  LResult := FRealTimeStylus.AddStylusAsyncPlugin(Count, APlugin);
  if LResult <> S_OK then
    raise EGestureException.CreateResFmt(@SAddIStylusAsyncPluginError, [GetSysErrorMessage(LResult)]);
end;

procedure TPlatformGestureEngine.TRealTimeStylus.AddStylusSyncPlugin(APlugin: IStylusSyncPlugin);
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

function TPlatformGestureEngine.TRealTimeStylus.CustomStylusDataAdded(piRtsSrc: IRealTimeStylus;
  const pGuidId: TGUID; cbData: ULONG; pbData: PBYTE): HResult;
var
  LEventInfo: TGestureEventInfo;
  LPoints: TGesturePointArray;
begin
  if (csGestures in FEngine.TargetControl.ControlStyle) and
     IsEqualGUID(pGuidId, GUID_GESTURE_DATA) then
    if (cbData >= SizeOf(TGestureData)) and (pbData <> nil) then
    begin
      if PGestureData(pbData)^.gestureId <> IAG_NoGesture then
      begin
        ZeroMemory(@LEventInfo, SizeOf(LEventInfo));
        LEventInfo.GestureID := StylusGestureMap(PGestureData(pbData)^.gestureId);
        FEngine.BroadcastGesture(FEngine.TargetControl, LEventInfo);
      end
      else
      begin
        // Request custom gesture recognition
        if not FEngine.TimerExpired and (FEngine.PointCount > 0) then
        begin
          LPoints := TGestureEngine.Recognizer.NormalizePoints(FEngine.Points);
          if TGestureEngine.IsGesture(LPoints, FGestureList, CustomGestureTypes, LEventInfo) then
            FEngine.BroadcastGesture(FEngine.TargetControl, LEventInfo);
        end;
      end;
    end;
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.DataInterest(out pDataInterest: RealTimeStylusDataInterest): HResult;
begin
  pDataInterest := RealTimeStylusDataInterest(RTSDI_AllData);
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.Error(piRtsSrc: IRealTimeStylus;
  piPlugin: IStylusPlugin; dataInterest: RealTimeStylusDataInterest;
  hrErrorCode: HResult; var lptrKey: LONG_PTR): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.InAirPackets(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPktCount, cPktBuffLength: Cardinal;
  pPackets: PInteger; var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.Initialize: Boolean;
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

function TPlatformGestureEngine.TRealTimeStylus.Packets(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPktCount, cPktBuffLength: Cardinal;
  pPackets: PInteger; var pcInOutPkts: Cardinal; var ppInOutPkts: PInteger): HResult;
var
  P: PInteger;
  Props, I, X, Y: Integer;
begin
  if not FEngine.TimerExpired then
  begin
    Props := cPktBuffLength div cPktCount;
    P := pPackets;
    for I := 1 to cPktCount do
    begin
      X := P^;
      Inc(P);
      Y := P^;
      Inc(P);
      FEngine.AddPoint(X, Y);
      if Props > 2 then
        Inc(P, Props - 2); // in case of additional properties we don't care about
    end;
  end
  else
  begin
    FEngine.ResetTimer;
    FEngine.ClearPoints;
  end;
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.RealTimeStylusDisabled(piRtsSrc: IRealTimeStylus;
  cTcidCount: ULONG; var pTcids: TABLET_CONTEXT_ID): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.RealTimeStylusEnabled(piRtsSrc: IRealTimeStylus;
  cTcidCount: ULONG; var pTcids: TABLET_CONTEXT_ID): HResult;
begin
  Result := S_OK;
end;

procedure TPlatformGestureEngine.TRealTimeStylus.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    FEnabled := Value;
    EnableStylus(FEnabled, False);
  end;
end;

procedure TPlatformGestureEngine.TRealTimeStylus.SetHandle(const Value: HWND);
var
  LResult: HRESULT;
begin
  if Value <> FHandle then
  begin
    LResult := FRealTimeStylus.put_HWND(Value);
    if LResult <> S_OK then
      raise EGestureException.CreateResFmt(@SStylusHandleError, [GetSysErrorMessage(LResult)]);
    FHandle := Value;
  end;
end;

class function TPlatformGestureEngine.TRealTimeStylus.StandardGestureMap(AGesture: TStandardGesture): Integer;
const
  LGestureMap: array[TStandardGesture] of Integer = (
    IAG_Left, IAG_Right, IAG_Up, IAG_Down, IAG_UpLeft, IAG_UpRight,
    IAG_DownLeft, IAG_DownRight, IAG_LeftUp, IAG_LeftDown, IAG_RightUp,
    IAG_RightDown, IAG_UpDown, IAG_DownUp, IAG_LeftRight, IAG_RightLeft,
    IAG_UpLeftLong, IAG_UpRightLong, IAG_DownLeftLong, IAG_DownRightLong,
    IAG_Scratchout, IAG_Triangle, IAG_Square, IAG_Check, IAG_Curlicue,
    IAG_DoubleCurlicue, IAG_Circle, IAG_DoubleCircle, IAG_SemiCircleLeft,
    IAG_SemiCircleRight, IAG_ChevronUp, IAG_ChevronDown, IAG_ChevronLeft,
    IAG_ChevronRight);
begin
  Result := LGestureMap[AGesture];
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusButtonDown(piRtsSrc: IRealTimeStylus;
  sid: STYLUS_ID; const pGuidStylusButton: TGUID;
  var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusButtonUp(piRtsSrc: IRealTimeStylus;
  sid: STYLUS_ID; const pGuidStylusButton: TGUID;
  var pStylusPos: TPoint): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusDown(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPropCountPerPkt: ULONG; pPacket: PInteger;
  var ppInOutPkt: PInteger): HResult;
var
  LPoint: TPoint;
  LResult: HRESULT;
  Count, I, X, Y: Integer;
  LGestures: array of Integer;
  LItem: TCustomGestureCollectionItem;
begin
  Result := S_OK;

  // Find control that gesture belongs to
  if not GetCursorPos(LPoint) then
    raise EGestureException.CreateRes(@SInitialGesturePointError);
  FEngine.InitialPoint := LPoint;
  LPoint := FEngine.Control.ScreenToClient(FEngine.InitialPoint);
  FEngine.TargetControl := FEngine.Control.ControlAtPos(LPoint, False);
  if FEngine.TargetControl = nil then
    FEngine.TargetControl := FEngine.Control
  else if not (csGestures in FEngine.TargetControl.ControlStyle) then
    Exit;

  // Build list of gestures
  FGestureList.Clear;
  FEngine.GetCompleteGestureList(FEngine.TargetControl, FGestureList);

  // Set gestures to listen for
  Count := 0;
  SetLength(LGestures, FGestureList.Count);
  for I := 0 to FGestureList.Count - 1 do
  begin
    LItem := FGestureList[I];
    if LItem.GestureType = gtStandard then
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
  FEngine.ClearPoints;
  FEngine.AddPoint(X, Y);
  FEngine.StartTimer;
end;

class function TPlatformGestureEngine.TRealTimeStylus.StylusGestureMap(AGesture: Integer): Integer;
begin
  case AGesture of
    IAG_LEFT: Result := sgiLeft;
    IAG_RIGHT: Result := sgiRight;
    IAG_UP: Result := sgiUp;
    IAG_DOWN: Result := sgiDown;
    IAG_UpLeft: Result := sgiUpLeft;
    IAG_UpRight: Result := sgiUpRight;
    IAG_DownLeft: Result := sgiDownLeft;
    IAG_DownRight: Result := sgiDownRight;
    IAG_LeftUp: Result := sgiLeftUp;
    IAG_LeftDown: Result := sgiLeftDown;
    IAG_RightUp: Result := sgiRightUp;
    IAG_RightDown: Result := sgiRightDown;
    IAG_UpDown: Result := sgiUpDown;
    IAG_DownUp: Result := sgiDownUp;
    IAG_LeftRight: Result := sgiLeftRight;
    IAG_RightLeft: Result := sgiRightLeft;
    IAG_UpLeftLong: Result := sgiUpLeftLong;
    IAG_UpRightLong: Result := sgiUpRightLong;
    IAG_DownLeftLong: Result := sgiDownLeftLong;
    IAG_DownRightLong: Result := sgiDownRightLong;
    IAG_Scratchout: Result := sgiScratchout;
    IAG_Triangle: Result := sgiTriangle;
    IAG_Square: Result := sgiSquare;
    IAG_Check: Result := sgiCheck;
    IAG_Curlicue: Result := sgiCurlicue;
    IAG_DoubleCurlicue: Result := sgiDoubleCurlicue;
    IAG_Circle: Result := sgiCircle;
    IAG_DoubleCircle: Result := sgiDoubleCircle;
    IAG_SemiCircleLeft: Result := sgiSemiCircleLeft;
    IAG_SemiCircleRight: Result := sgiSemiCircleRight;
    IAG_ChevronUp: Result := sgiChevronUp;
    IAG_ChevronDown: Result := sgiChevronDown;
    IAG_ChevronLeft: Result := sgiChevronLeft;
    IAG_ChevronRight: Result := sgiChevronRight;
  else
    Result := -1;
  end;
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusInRange(piRtsSrc: IRealTimeStylus;
  tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusOutOfRange(piRtsSrc: IRealTimeStylus;
  tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.StylusUp(piRtsSrc: IRealTimeStylus;
  const pStylusInfo: TStylusInfo; cPropCountPerPkt: ULONG; pPacket: PInteger;
  var ppInOutPkt: PInteger): HResult;
var
  X, Y: Integer;
begin
  X := pPacket^;
  Inc(pPacket);
  Y := pPacket^;
  FEngine.AddPoint(X, Y);

  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.SystemEvent(piRtsSrc: IRealTimeStylus;
  tcid: TABLET_CONTEXT_ID; sid: STYLUS_ID; event: SYSTEM_EVENT;
  eventdata: SYSTEM_EVENT_DATA): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.TabletAdded(piRtsSrc: IRealTimeStylus;
  piTablet: IInkTablet): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.TabletRemoved(piRtsSrc: IRealTimeStylus;
  iTabletIndex: Integer): HResult;
begin
  Result := S_OK;
end;

function TPlatformGestureEngine.TRealTimeStylus.EnableStylus(Value, Silent: Boolean): Boolean;
var
  LResult: HRESULT;
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

procedure TPlatformGestureEngine.TRealTimeStylus.Uninitialize;
var
  I: Integer;
  LCount: Cardinal;
  LResult: HRESULT;
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

function TPlatformGestureEngine.TRealTimeStylus.UpdateMapping(piRtsSrc: IRealTimeStylus): HResult;
begin
  Result := S_OK;
end;

{ TPlatformGestureEngine }

constructor TPlatformGestureEngine.Create(AControl: TWinControl);
begin
  inherited Create(AControl);
  SetLength(FDeferredCleanupList, 0);
end;

destructor TPlatformGestureEngine.Destroy;
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

  inherited;
end;

function TPlatformGestureEngine.GetActive: Boolean;
begin
  if FStylusGestureEngine <> nil then
    Result := FStylusGestureEngine.Enabled
  else
    Result := False;
end;

class function TPlatformGestureEngine.Supported: Boolean;
var
  LRealTimeStylus: IRealTimeStylus;
begin
  if not FSupportedTested then
  begin
    LRealTimeStylus := nil;
    // Disable stylus API for Metropolis
    if not Application.IsMetropolisUI and
      (Win32MajorVersion >= 6) then
      CoCreateInstance(CLSID_RealTimeStylus, nil, CLSCTX_INPROC_SERVER,
        StringToGUID(SID_IRealTimeStylus), LRealTimeStylus);
    FSupported := LRealTimeStylus <> nil;
    FSupportedTested := True;
  end;
  Result := FSupported
end;

procedure TPlatformGestureEngine.SetActive(const Value: Boolean);
var
  Success: Boolean;
begin
  if Control.HandleAllocated then
  begin
    if Value then
    begin
      // Initialize RealTimeStylus
      if FStylusGestureEngine = nil then
      begin
        FStylusGestureEngine := TPlatformGestureEngine.TRealTimeStylus.Create(Self);
        Success := FStylusGestureEngine.Initialize;
      end
      else
        Success := True;

      if Success then
      begin
        FStylusGestureEngine.Handle := Control.Handle;
        FStylusGestureEngine.Enabled := True;
      end
      else
        FStylusGestureEngine.Enabled := False;
    end
    else if FStylusGestureEngine <> nil then
    begin
      if not TimerExpired then
      begin
        ResetTimer;
        ClearPoints;
      end;

      // Uninitialize RealTimeStylus
      if (csRecreating in Control.ControlState) and
         not FStylusGestureEngine.EnableStylus(Value, True) then
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
end;
{$ENDIF}

{ TMouseGestureEngine }

destructor TMouseGestureEngine.Destroy;
begin
  Active := False;
  inherited;
end;

function TMouseGestureEngine.GetActive: Boolean;
begin
  Result := FActive;
end;

function TMouseGestureEngine.GetFlags: TCustomGestureEngine.TGestureEngineFlags;
begin
  Result := [efMouseEvents];
end;

procedure TMouseGestureEngine.Notification(const Message: TMessage);
var
  LPoint: TPoint;
  LGestureList: TGestureList;
  LEventInfo: TGestureEventInfo;
begin
  if FActive then
    case Message.Msg of
      WM_MOUSEMOVE:
        if not TimerExpired then
          AddPoint(TWMMouse(Message).XPos, TWMMouse(Message).YPos)
        else
        begin
          ResetTimer;
          ClearPoints;
        end;
      WM_LBUTTONDOWN:
        begin
          // Find control that gesture belongs to
          LPoint := Point(TWMMouse(Message).XPos, TWMMouse(Message).YPos);
          TargetControl := Control.ControlAtPos(LPoint, False);
          if TargetControl = nil then
            TargetControl := Control
          else if not (csGestures in TargetControl.ControlStyle) then
            Exit;

          // Convert to screen coordinates for use in BroadcastGesture
          InitialPoint := Control.ClientToScreen(LPoint);

          // Add initial point to list of collected points
          ClearPoints;
          AddPoint(TWMMouse(Message).XPos, TWMMouse(Message).YPos);

          // Start timer
          StartTimer;
        end;
      WM_LBUTTONUP:
        if not TimerExpired and (PointCount > 0) then
        begin
          // Reset timer
          ResetTimer;

          // Add final point to list
          AddPoint(TWMMouse(Message).XPos, TWMMouse(Message).YPos);

          LGestureList := TGestureList.Create;
          try
            // Retrieve list of gestures
            GetCompleteGestureList(TargetControl, LGestureList);

            // Request gesture recognition
            if (LGestureList.Count > 0) and
               TGestureEngine.IsGesture(Points, LGestureList, [gtStandard] + CustomGestureTypes, LEventInfo) then
              BroadcastGesture(TargetControl, LEventInfo);
          finally
            LGestureList.Free;
          end;
        end;
    end;
end;

procedure TMouseGestureEngine.SetActive(const Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if not FActive and not TimerExpired then
    begin
      ResetTimer;
      ClearPoints;
    end;
  end;
end;

class function TMouseGestureEngine.Supported: Boolean;
begin
  Result := True;
end;

{ TGestureRecognizer }

// Takes into account margin of error returning a percentage of match.
// 100% match will be margin of error of deviation from the source point.
// 0% will be at deviation away and beyond.
function CheckPoint(const Point, Source: TPoint; Deviation,
  ErrorMargin: Integer): Double;
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

function CheckPointInGesture(Point: TPoint;
  SourcePoints: array of TPoint;
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

function CheckPointInGestureWindow(Point: TPoint;
  SourcePoints: array of TPoint; var GestureIndex: Integer;
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
    Point1, Point2: TPoint;
  end;

  TCircle = record
    Point: TPoint;
    Radius: Integer;
  end;

function Line(Point1, Point2: TPoint): TLine; inline;
begin
  Result.Point1 := Point1;
  Result.Point2 := Point2;
end;

function Circle(Point: TPoint; Radius: Integer): TCircle; inline;
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

  C := Sqr(Circle.Point.X) + Sqr(Circle.Point.Y ) + Sqr(Line.Point1.X) +
      Sqr(Line.Point1.Y) -
      2 * (Circle.Point.X * Line.Point1.X + Circle.Point.Y * Line.Point1.Y) - Sqr(Circle.Radius);

  Result := (B * B - 4 * A * C) > 0;
end;

function CheckLineIntersectsCircle(Line: TLine;
  SourcePoints: array of TPoint; GestureIndex, Radius: Integer;
  var Verification: TIntegerDynArray): Boolean;
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

function ReversePoints(const Points: array of TPoint): TGesturePointArray;
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
    Point: TPoint;
    Angle: Single;
    Index: Integer;
  end;

  TPointsList = TList<TGesturePoint>;

function Distance(Point1, Point2: TPoint): Single;
begin
  Result := Sqrt(Sqr(Point1.X - Point2.X) + Sqr(Point1.Y - Point2.Y));
end;

function TGestureRecognizer.CopyPoints(
  Points: TGesturePoints): TGesturePointArray;
var
  Index: Integer;
begin
  SetLength(Result, Points.Count);
  for Index := 0 to Points.Count - 1 do
    Result[Index] := Points[Index];
end;

function TGestureRecognizer.InterpolatePoints(const Points: array of TPoint): TGesturePointArray;
var
  Index, PointsCount: Integer;
  StepX, StepY: Double;
  I, DeltaX, DeltaY, Count: Integer;
  CurrentPoint, NextPoint: TPoint;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then Exit;
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
        DeltaX := NextPoint.X - CurrentPoint.X;
        DeltaY := NextPoint.Y - CurrentPoint.Y;

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
          ResultPoints.Add(Point(CurrentPoint.X + Trunc(StepX * I),
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

function TGestureRecognizer.Match(const Points: array of TPoint;
  const GesturePoints: array of TPoint; const Options: TGestureOptions;
  GestureID: TGestureID; Deviation, ErrorMargin: Integer): Single;
var
  LErrorMargin: Integer;
  LPoints, LGesturePoints: TGesturePointArray;
  PointCount, GesturePointCount: Integer;
  Percentages: array of Double;
  Angle: Double;
begin
  Result := 0;
  SetLength(Percentages, 4);

  // Apply global sensitivity adjustment to gesture's ErrorMargin property
  LErrorMargin := Round(Sqr(100 - TGestureEngine.Sensitivity) / 100) + ErrorMargin;
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
    if goRotate in Options then
      LPoints := RotatePoints(LPoints, GesturePoints, LErrorMargin, Angle);
    LPoints := ScalePoints(LPoints, GesturePoints, Deviation, goSkew in Options);
    LPoints := RemoveDuplicates(LPoints);
    if (goUniDirectional in Options) and
       not PtInCircle(LPoints[0], GesturePoints[0], Deviation) then
      Exit;

    PointCount := Length(LPoints);
    if (goEndpoint in Options) and
      (not PtInCircle(LPoints[PointCount - 1], GesturePoints[GesturePointCount - 1], Deviation)) then
    begin
      Exit;
    end;

    LGesturePoints := InterpolatePoints(GesturePoints);
    LGesturePoints := RemoveDuplicates(LGesturePoints);
    GesturePointCount := Length(GesturePoints);

    Result := IsPointsGesture(LPoints, LGesturePoints, GestureID,
      Deviation, LErrorMargin, Percentages);

    // If the gesture failed and the gesture is a bidirectional gesture,
    // and the start and end points of the gesture are the same, then reverse
    // the gesture and test again.
    if (Result < LErrorMargin) and not (goUniDirectional in Options) and
      PtInCircle(LPoints[0], GesturePoints[GesturePointCount - 1], Deviation) then
    begin
      Result := IsPointsGesture(LPoints, ReversePoints(LGesturePoints), GestureID,
        Deviation, LErrorMargin, Percentages);
    end;
  finally
    if Assigned(FPostCallback) then
      FPostCallback(Percentages, LPoints, GesturePoints, GestureID);
  end;
end;

function TGestureRecognizer.IsPointsGesture(const Points, GesturePoints: array of TPoint;
  GestureID: TGestureID; Deviation: Integer; ErrorMargin: Integer;
  var Percentages: array of Double): Integer;

  function DistanceBetween(Point1, Point2: TPoint): Single;
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
  DistancePoints: array of TPoint;
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
  Point: TPoint;
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

    while (PointsIndex + 1 < PointsCount) and
          PtInCircle(GesturePoints[Index], Points[PointsIndex + 1], Deviation) do
      Inc(PointsIndex);

    CheckPointInGestureWindow(GesturePoints[Index], Points, PointsIndex, PointsMatch, Deviation, ErrorMargin);
  end;

  for Index := 0 to PointsCount - 1 do
  begin
    Inc(PointsPercentage, Round(PointsMatch[Index]));

    while (GestureIndex + 1 < GestureCount) and
          PtInCircle(Points[Index], GesturePoints[GestureIndex + 1], Deviation) do
      Inc(GestureIndex);

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
      GestureAngles[Index] := ArcTan2(GesturePoints[Index - 1].X - GesturePoints[Index].X,
        GesturePoints[Index - 1].Y - GesturePoints[Index].Y);
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

function TGestureRecognizer.IsScratchout(const Points: array of TPoint;
  GestureID: TGestureID; Deviation,
  ErrorMargin: Integer; var Percentages: array of Double): Integer;

  function SegmentPoints(const Points: array of TPoint; var Right: Boolean): TSegmentArray;
  var
    Index: Integer;
    Max, Min: Integer;
    Segment: TGesturePoints;
    Diff: Integer;
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

  function HeightDeviation(const Points: array of TPoint): Integer;
  var
    Index, Count: Integer;
    Min, Max: Integer;
    Point: TPoint;
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
      Weight := IsPointsGesture(LPoints, LGesturePoints, GestureID,
        Deviation, ErrorMargin, LPercentages);
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

function TGestureRecognizer.NormalizePoints(
  const Points: array of TPoint): TGesturePointArray;
var
  Index, SmallestX, SmallestY: Integer;
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
    Result[Index] := Point(Points[Index].X - SmallestX, Points[Index].Y - SmallestY);
end;

function TGestureRecognizer.RemoveDuplicates(const Points: array of TPoint): TGesturePointArray;
var
  Index, PointsCount: Integer;
  LastPoint, NextPoint: TPoint;
  ResultPoints: TGesturePoints;
begin
  PointsCount := Length(Points);
  if PointsCount = 0 then Exit;
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

function TGestureRecognizer.RotatePoints(const Points, GesturePoints: array of TPoint;
  ErrorMargin: Integer; var Angle: Double): TGesturePointArray;

  function WithinError(const Point1, Point2: TPoint; ErrorMargin: Integer; var Angle: Double): Boolean;
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
  Origin, Point2: TPoint;
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
    Move(Points[0], Result[0], PointsCount * SizeOf(TPoint));
  end;
end;

function TGestureRecognizer.ScalePoints(const Points: array of TPoint;
  const GesturePoints: array of TPoint; MinScale: Integer; Scaling: Boolean = False): TGesturePointArray;
var
  Index: Integer;
  LargestX1, LargestX2, LargestY1, LargestY2: Integer;
  ScaleX, ScaleY, Scale: Double;
  P: TPoint;
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

      Result[Index] := Point(Round(P.X * ScaleX),
        Round(P.Y * ScaleY));
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

      Result[Index] := Point(Round(P.X * Scale),
        Round(P.Y * Scale));
    end;
  end;
end;

{ Standard gesture definitions }

const
  PDefaultLeft: array[0..1] of TPoint = ((X:200; Y:0), (X:0; Y:0));

  CDefaultLeft: TStandardGestureData = (
    GestureID: sgiLeft;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultRight: array[0..1] of TPoint = ((X:0; Y:0), (X:200; Y:0));

  CDefaultRight: TStandardGestureData = (
    GestureID: sgiRight;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUp: array[0..1] of TPoint = ((X:0; Y:200), (X:0; Y:0));

  CDefaultUp: TStandardGestureData = (
    GestureID: sgiUp;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDown: array[0..1] of TPoint = ((X:0; Y:0), (X:0; Y:200));

  CDefaultDown: TStandardGestureData = (
    GestureID: sgiDown;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUpLeft: array[0..2] of TPoint =
    ((X:200; Y:200), (X:200; Y:0), (X:0; Y:0));

  CDefaultUpLeft: TStandardGestureData = (
    GestureID: sgiUpLeft;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUpRight: array[0..2] of TPoint =
    ((X:0; Y:200), (X:0; Y:0), (X:200; Y:0));

  CDefaultUpRight: TStandardGestureData = (
    GestureID: sgiUpRight;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDownLeft: array[0..2] of TPoint =
    ((X:200; Y:0), (X:200; Y:200), (X:0; Y:200));

  CDefaultDownLeft: TStandardGestureData = (
    GestureID: sgiDownLeft;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDownRight: array[0..2] of TPoint =
    ((X:0; Y:0), (X:0; Y:200), (X:200; Y:200));

  CDefaultDownRight: TStandardGestureData = (
    GestureID: sgiDownRight;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultLeftUp: array[0..2] of TPoint =
    ((X:200; Y:200), (X:0; Y:200), (X:0; Y:0));

  CDefaultLeftUp: TStandardGestureData = (
    GestureID: sgiLeftUp;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultLeftDown: array[0..2] of TPoint =
    ((X:200; Y:0), (X:0; Y:0), (X:0; Y:200));

  CDefaultLeftDown: TStandardGestureData = (
    GestureID: sgiLeftDown;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultRightUp: array[0..2] of TPoint =
    ((X:0; Y:200), (X:200; Y:200), (X:200; Y:0));

  CDefaultRightUp: TStandardGestureData = (
    GestureID: sgiRightUp;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultRightDown: array[0..2] of TPoint =
    ((X:0; Y:0), (X:200; Y:0), (X:200; Y:200));

  CDefaultRightDown: TStandardGestureData = (
    GestureID: sgiRightDown;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUpDown: array[0..2] of TPoint =
    ((X:0; Y:200), (X:0; Y:0), (X:0; Y:200));

  CDefaultUpDown: TStandardGestureData = (
    GestureID: sgiUpDown;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDownUp: array[0..2] of TPoint =
    ((X:0; Y:0), (X:0; Y:200), (X:0; Y:0));

  CDefaultDownUp: TStandardGestureData = (
    GestureID: sgiDownUp;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultLeftRight: array[0..2] of TPoint =
    ((X:200; Y:0), (X:0; Y:0), (X:200; Y:0));

  CDefaultLeftRight: TStandardGestureData = (
    GestureID: sgiLeftRight;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultRightLeft: array[0..2] of TPoint =
    ((X:0; Y:0), (X:200; Y:0), (X:0; Y:0));

  CDefaultRightLeft: TStandardGestureData = (
    GestureID: sgiRightLeft;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUpLeftLong: array[0..2] of TPoint =
    ((X:200; Y:100), (X:200; Y:0), (X:0; Y:0));

  CDefaultUpLeftLong: TStandardGestureData = (
    GestureID: sgiUpLeftLong;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultUpRightLong: array[0..2] of TPoint =
    ((X:0; Y:100), (X:0; Y:0), (X:200; Y:0));

  CDefaultUpRightLong: TStandardGestureData = (
    GestureID: sgiUpRightLong;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDownLeftLong: array[0..2] of TPoint =
    ((X:200; Y:0), (X:200; Y:100), (X:0; Y:100));

  CDefaultDownLeftLong: TStandardGestureData = (
    GestureID: sgiDownLeftLong;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDownRightLong: array[0..2] of TPoint =
    ((X:0; Y:0), (X:0; Y:100), (X:200; Y:100));

  CDefaultDownRightLong: TStandardGestureData = (
    GestureID: sgiDownRightLong;
    Options: [goUniDirectional];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultScratchout: array[0..1] of TPoint = ((X:0; Y:0), (X:200; Y:0));

  CDefaultScratchout: TStandardGestureData = (
    GestureID: sgiScratchout;
    Options: [];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultTriangle: array[0..3] of TPoint =
    ((X:100; Y:0), (X:0; Y:141), (X:200; Y:141), (X:100; Y:0));

  CDefaultTriangle: TStandardGestureData = (
    GestureID: sgiTriangle;
    Options: [goSkew, goEndpoint, goRotate];
    Deviation: 30;
    ErrorMargin: 40);

  PDefaultSquare: array[0..4] of TPoint =
    ((X:0; Y:0), (X:0; Y:200), (X:200; Y:200), (X:200; Y:0), (X:0; Y:0));

  CDefaultSquare: TStandardGestureData = (
    GestureID: sgiSquare;
    Options: [goSkew, goEndpoint, goRotate];
    Deviation: 30;
    ErrorMargin: 40);

  PDefaultCheck: array[0..2] of TPoint =
    ((X:0; Y:140), (X:80; Y:200), (X:200; Y:0));

  CDefaultCheck: TStandardGestureData = (
    GestureID: sgiCheck;
    Options: [goUniDirectional, goRotate];
    Deviation: 50;
    ErrorMargin: 20);

  PDefaultCurlicue: array[0..60] of TPoint = (
    (X:0; Y:97), (X:5; Y:96), (X:11; Y:96), (X:16; Y:95), (X:21; Y:95),
    (X:26; Y:94), (X:31; Y:92), (X:36; Y:89), (X:41; Y:87), (X:47; Y:84),
    (X:52; Y:79), (X:56; Y:74), (X:59; Y:69), (X:62; Y:64), (X:66; Y:59),
    (X:68; Y:54), (X:71; Y:48), (X:72; Y:43), (X:72; Y:38), (X:73; Y:32),
    (X:74; Y:27), (X:74; Y:22), (X:72; Y:17), (X:67; Y:13), (X:62; Y:10),
    (X:57; Y:8), (X:52; Y:7), (X:47; Y:6), (X:42; Y:5), (X:37; Y:5),
    (X:32; Y:6), (X:27; Y:8), (X:22; Y:12), (X:20; Y:17), (X:20; Y:22),
    (X:20; Y:27), (X:20; Y:32), (X:22; Y:37), (X:25; Y:42), (X:28; Y:47),
    (X:33; Y:50), (X:38; Y:53), (X:43; Y:54), (X:48; Y:54), (X:53; Y:55),
    (X:58; Y:55), (X:63; Y:55), (X:68; Y:55), (X:73; Y:54), (X:79; Y:52),
    (X:84; Y:50), (X:88; Y:45), (X:91; Y:40), (X:94; Y:35), (X:96; Y:30),
    (X:99; Y:25), (X:101; Y:20), (X:104; Y:15), (X:108; Y:10), (X:110; Y:5),
     (X:113; Y:0));

  CDefaultCurlicue: TStandardGestureData = (
    GestureID: sgiCurlicue;
    Options: [goUniDirectional, goSkew, goRotate];
    Deviation: 30;
    ErrorMargin: 20);

  PDefaultDoubleCurlicue: array[0..77] of TPoint = (
    (X:0; Y:175), (X:5; Y:171), (X:10; Y:168), (X:14; Y:163), (X:18; Y:158),
    (X:20; Y:153), (X:23; Y:148), (X:25; Y:143), (X:28; Y:137), (X:29; Y:132),
    (X:31; Y:126), (X:32; Y:121), (X:32; Y:115), (X:32; Y:110), (X:32; Y:105),
    (X:32; Y:99), (X:29; Y:94), (X:26; Y:89), (X:21; Y:86), (X:16; Y:83),
    (X:11; Y:83), (X:6; Y:84), (X:4; Y:89), (X:2; Y:94), (X:2; Y:99),
    (X:2; Y:105), (X:5; Y:110), (X:11; Y:114), (X:16; Y:116), (X:21; Y:118),
    (X:26; Y:118), (X:31; Y:118), (X:36; Y:118), (X:42; Y:118), (X:47; Y:114),
    (X:52; Y:111), (X:56; Y:106), (X:58; Y:101), (X:60; Y:96), (X:61; Y:90),
    (X:61; Y:84), (X:61; Y:79), (X:61; Y:74), (X:61; Y:69), (X:61; Y:64),
    (X:60; Y:59), (X:59; Y:54), (X:59; Y:48), (X:57; Y:42), (X:54; Y:36),
    (X:49; Y:31), (X:44; Y:30), (X:39; Y:33), (X:37; Y:38), (X:35; Y:43),
    (X:35; Y:48), (X:37; Y:53), (X:42; Y:57), (X:47; Y:61), (X:53; Y:64),
    (X:58; Y:66), (X:63; Y:67), (X:68; Y:67), (X:73; Y:67), (X:78; Y:64),
    (X:84; Y:61), (X:89; Y:56), (X:91; Y:51), (X:93; Y:46), (X:94; Y:41),
    (X:95; Y:35), (X:95; Y:30), (X:95; Y:25), (X:95; Y:20), (X:95; Y:15),
    (X:95; Y:10), (X:95; Y:5),  (X:94; Y:0));

  CDefaultDoubleCurlicue: TStandardGestureData = (
    GestureID: sgiDoubleCurlicue;
    Options: [goUniDirectional, goSkew, goRotate];
    Deviation: 30;
    ErrorMargin: 30);

  PDefaultCircle: array[0..16] of TPoint = (
    (X:50; Y:0), (X:32; Y:4), (X:16; Y:16), (X:4; Y:31), (X:0; Y:50),
    (X:4; Y:67), (X:15; Y:85), (X:31; Y:95), (X:50; Y:100), (X:68; Y:96),
    (X:84; Y:84), (X:96; Y:69), (X:100; Y:50), (X:97; Y:30), (X:85; Y:14),
    (X:68; Y:3),  (X:50; Y:0));

  CDefaultCircle: TStandardGestureData = (
    GestureID: sgiCircle;
    Options: [goSkew, goEndpoint];
    Deviation: 30;
    ErrorMargin: 30);

  PDefaultDoubleCircle: array[0..33] of TPoint = (
    (X:50; Y:0), (X:32; Y:4), (X:16; Y:16), (X:4; Y:31), (X:0; Y:50),
    (X:4; Y:67), (X:15; Y:85), (X:31; Y:95), (X:50; Y:100), (X:68; Y:96),
    (X:84; Y:84), (X:96; Y:69), (X:100; Y:50), (X:97; Y:30), (X:85; Y:14),
    (X:68; Y:3),  (X:50; Y:0),
    (X:50; Y:0), (X:32; Y:4), (X:16; Y:16), (X:4; Y:31), (X:0; Y:50),
    (X:4; Y:67), (X:15; Y:85), (X:31; Y:95), (X:50; Y:100), (X:68; Y:96),
    (X:84; Y:84), (X:96; Y:69), (X:100; Y:50), (X:97; Y:30), (X:85; Y:14),
    (X:68; Y:3),  (X:50; Y:0));

  CDefaultDoubleCircle: TStandardGestureData = (
    GestureID: sgiDoubleCircle;
    Options: [goSkew, goEndpoint];
    Deviation: 30;
    ErrorMargin: 40);

  PDefaultSemiCircleLeft: array[0..8] of TPoint = (
    (X:100; Y:50), (X:97; Y:30), (X:85; Y:14), (X:68; Y:3), (X:50; Y:0),
    (X:32; Y:4), (X:16; Y:16), (X:4; Y:31), (X:0; Y:50));

  CDefaultSemiCircleLeft: TStandardGestureData = (
    GestureID: sgiSemiCircleLeft;
    Options: [goUniDirectional, goEndpoint, goRotate];
    Deviation: 30;
    ErrorMargin: 30);

  PDefaultSemiCircleRight: array[0..8] of TPoint = (
    (X:0; Y:50), (X:4; Y:31), (X:16; Y:16), (X:32; Y:4), (X:50; Y:0),
    (X:68; Y:3), (X:85; Y:14), (X:97; Y:30), (X:100; Y:50));

  CDefaultSemiCircleRight: TStandardGestureData = (
    GestureID: sgiSemiCircleLeft;
    Options: [goUniDirectional, goEndpoint, goRotate];
    Deviation: 30;
    ErrorMargin: 30);

  PDefaultChevronUp: array[0..2] of TPoint =
    ((X:0; Y:100), (X:100; Y:0), (X:200; Y:100));

  CDefaultChevronUp: TStandardGestureData = (
    GestureID: sgiChevronUp;
    Options: [goSkew, goRotate];
    Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronDown: array[0..2] of TPoint =
    ((X:0; Y:0), (X:100; Y:100), (X:200; Y:0));

  CDefaultChevronDown: TStandardGestureData = (
    GestureID: sgiChevronDown;
    Options: [goSkew, goRotate];
    Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronLeft: array[0..2] of TPoint =
    ((X:100; Y:0), (X:0; Y:100), (X:100; Y:200));

  CDefaultChevronLeft: TStandardGestureData = (
    GestureID: sgiChevronLeft;
    Options: [goSkew, goRotate];
    Deviation: 20;
    ErrorMargin: 20);

  PDefaultChevronRight: array[0..2] of TPoint =
    ((X:0; Y:0), (X:100; Y:100), (X:0; Y:200));

  CDefaultChevronRight: TStandardGestureData = (
    GestureID: sgiChevronRight;
    Options: [goSkew, goRotate];
    Deviation: 20;
    ErrorMargin: 20);

function AssignDefaultGestureData(const AGestureData: TStandardGestureData;
  Points: array of TPoint): TStandardGestureData;
var
  Count: Integer;
begin
  Result := AGestureData;
  Count := Length(Points);
  if Count > 0 then
  begin
    SetLength(Result.Points, Count);
    Move(Points[0], Result.Points[0], Count * SizeOf(TPoint));
  end;
end;

function FindStandardGesture(AGestureID: TGestureID; var AGestureData: TStandardGestureData): Boolean;
begin
  Result := True;
  case AGestureID of
    sgiLeft: AGestureData := AssignDefaultGestureData(CDefaultLeft, PDefaultLeft);
    sgiRight: AGestureData := AssignDefaultGestureData(CDefaultRight, PDefaultRight);
    sgiUp: AGestureData := AssignDefaultGestureData(CDefaultUp, PDefaultUp);
    sgiDown: AGestureData := AssignDefaultGestureData(CDefaultDown, PDefaultDown);
    sgiUpLeft: AGestureData := AssignDefaultGestureData(CDefaultUpLeft, PDefaultUpLeft);
    sgiUpRight: AGestureData := AssignDefaultGestureData(CDefaultUpRight, PDefaultUpRight);
    sgiDownLeft: AGestureData := AssignDefaultGestureData(CDefaultDownLeft, PDefaultDownLeft);
    sgiDownRight: AGestureData := AssignDefaultGestureData(CDefaultDownRight, PDefaultDownRight);
    sgiLeftUp: AGestureData := AssignDefaultGestureData(CDefaultLeftUp, PDefaultLeftUp);
    sgiLeftDown: AGestureData := AssignDefaultGestureData(CDefaultLeftDown, PDefaultLeftDown);
    sgiRightUp: AGestureData := AssignDefaultGestureData(CDefaultRightUp, PDefaultRightUp);
    sgiRightDown: AGestureData := AssignDefaultGestureData(CDefaultRightDown, PDefaultRightDown);
    sgiUpDown: AGestureData := AssignDefaultGestureData(CDefaultUpDown, PDefaultUpDown);
    sgiDownUp: AGestureData := AssignDefaultGestureData(CDefaultDownUp, PDefaultDownUp);
    sgiLeftRight: AGestureData := AssignDefaultGestureData(CDefaultLeftRight, PDefaultLeftRight);
    sgiRightLeft: AGestureData := AssignDefaultGestureData(CDefaultRightLeft, PDefaultRightLeft);
    sgiUpLeftLong: AGestureData := AssignDefaultGestureData(CDefaultUpLeftLong, PDefaultUpLeftLong);
    sgiUpRightLong: AGestureData := AssignDefaultGestureData(CDefaultUpRightLong, PDefaultUpRightLong);
    sgiDownLeftLong: AGestureData := AssignDefaultGestureData(CDefaultDownLeftLong, PDefaultDownLeftLong);
    sgiDownRightLong: AGestureData := AssignDefaultGestureData(CDefaultDownRightLong, PDefaultDownRightLong);
    sgiScratchout: AGestureData := AssignDefaultGestureData(CDefaultScratchout, PDefaultScratchout);
    sgiTriangle: AGestureData := AssignDefaultGestureData(CDefaultTriangle, PDefaultTriangle);
    sgiSquare: AGestureData := AssignDefaultGestureData(CDefaultSquare, PDefaultSquare);
    sgiCheck: AGestureData := AssignDefaultGestureData(CDefaultCheck, PDefaultCheck);
    sgiCurlicue: AGestureData := AssignDefaultGestureData(CDefaultCurlicue, PDefaultCurlicue);
    sgiDoubleCurlicue: AGestureData := AssignDefaultGestureData(CDefaultDoubleCurlicue, PDefaultDoubleCurlicue);
    sgiCircle: AGestureData := AssignDefaultGestureData(CDefaultCircle, PDefaultCircle);
    sgiDoubleCircle: AGestureData := AssignDefaultGestureData(CDefaultDoubleCircle, PDefaultDoubleCircle);
    sgiSemiCircleLeft: AGestureData := AssignDefaultGestureData(CDefaultSemiCircleLeft, PDefaultSemiCircleLeft);
    sgiSemiCircleRight: AGestureData := AssignDefaultGestureData(CDefaultSemiCircleRight, PDefaultSemiCircleRight);
    sgiChevronUp: AGestureData := AssignDefaultGestureData(CDefaultChevronUp, PDefaultChevronUp);
    sgiChevronDown: AGestureData := AssignDefaultGestureData(CDefaultChevronDown, PDefaultChevronDown);
    sgiChevronLeft: AGestureData := AssignDefaultGestureData(CDefaultChevronLeft, PDefaultChevronLeft);
    sgiChevronRight: AGestureData := AssignDefaultGestureData(CDefaultChevronRight, PDefaultChevronRight);
  else
    begin
      ZeroMemory(@AGestureData, SizeOf(AGestureData));
      Result := False;
    end;
  end;
end;

function FindStandardGesture(const AName: string; var AGestureID: TGestureID): Boolean;
var
  Entry: TIdentMapEntry;
begin
  Result := False;
  for Entry in GestureNameMap do
    if CompareText(AName, Copy(Entry.Name, 4, $FF)) = 0 then
    begin
      AGestureID := Entry.Value;
      Result := True;
      Break;
    end;
end;

initialization
  RegisterIntegerConsts(TypeInfo(TGestureID), IdentToGesture, GestureToIdent);
end.
