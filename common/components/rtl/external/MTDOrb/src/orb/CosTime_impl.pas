// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit CosTime_impl;

interface

uses
  sysutils, classes, orbtypes, orb_int, poa_int, timebase_int, CosTime_int, CosTime;

type
  TUTO_impl = class(TCosTime_UTO_serv)
  private
    // Time in units of 100 nanoseconds
    FTime: TTimeBase_TimeT;
    // Time inaccuracy in units of 100 nanoseconds
    FInaccuracy: TTimeBase_InaccuracyT;
    // Time displacement from Greenwich meridian in minutes
    FTdf: TTimeBase_TdfT;
  protected
    function absolute_time: ICosTime_UTO; override;
    function compare_time(const comparison_type: TCosTime_ComparisonType; const uto: ICosTime_UTO): TCosTime_TimeComparison; override;
    function time_to_interval(const uto: ICosTime_UTO): ICosTime_TIO; override;
    function interval: ICosTime_TIO; override;
    function _get_time: TTimeBase_TimeT; override;
    function _get_inaccuracy: TTimeBase_InaccuracyT; override;
    function _get_tdf: TTimeBase_TdfT; override;
    function _get_utc_time: TTimeBase_UtcT; override;
  public
    constructor Create(const AUtcT: TTimeBase_UtcT); overload;
    constructor Create(ATimeT: TTimeBase_TimeT; AInaccuracyT: TTimeBase_InaccuracyT; ATdfT: TTimeBase_TdfT = 0); overload;
  end;

  TTIO_impl = class(TCosTime_TIO_serv)
  private
    // Lower range
    FLower,
    // Upper range
    FUpper: TTimeBase_TimeT;
    function checkOverlap(ALower, AUpper: TTimeBase_TimeT; out AOverlap: ICosTime_TIO): TCosTime_OverlapType;
  protected
    function spans(const time: ICosTime_UTO; out overlap: ICosTime_TIO): TCosTime_OverlapType; override;
    function overlaps(const interval: ICosTime_TIO; out overlap: ICosTime_TIO): TCosTime_OverlapType; override;
    function time: ICosTime_UTO; override;
    function _get_time_interval: TTimeBase_IntervalT; override;
  public
    constructor Create(const ALower, AUpper: TTimeBase_TimeT);
  end;

  TTimeService_impl = class(TCosTime_TimeService_serv)
  private
    FInaccuracy: TTimeBase_InaccuracyT;
  protected
    function universal_time: ICosTime_UTO; override;
    function secure_universal_time: ICosTime_UTO; override;
    function new_universal_time(const time: TTimeBase_TimeT; const inaccuracy: TTimeBase_InaccuracyT; const tdf: TTimeBase_TdfT): ICosTime_UTO; override;
    function uto_from_utc(const utc: TTimeBase_UtcT): ICosTime_UTO; override;
    function new_interval(const lower: TTimeBase_TimeT; const upper: TTimeBase_TimeT): ICosTime_TIO; override;
  public
    constructor Create(const AInaccuracy: TTimeBase_InaccuracyT);
  end;

procedure TimeServiceInit(ORB: IORB; POA: IPOA; props: TStrings);

implementation

uses throw, timehelper, poa_impl, bootmanager, bootmanager_int;

procedure TimeServiceInit(ORB: IORB; POA: IPOA; props: TStrings);
var
  inacc: TTimeBase_InaccuracyT;
  i: integer;
  bootManager: IBootManager;
  obj: IORBObject;
begin
  i := 0; inacc := 0;
  if (props <> nil) then
    while i < props.count do begin
      if Uppercase(props[i]) = 'TIMEINACCURACY' then begin
        Inc(i);
        inacc := StrToInt(props[i]);
      end;
      Inc(i);
    end;
  assert(POA <> nil);
  obj := POA.servant_to_reference(TTimeService_impl.Create(inacc) as IServant);
  ORB.register_initial_reference('TimeService', obj);

  //BootManager
  bootManager := TBootManager._narrow(ORB.resolve_initial_reference('BootManager'));
  if bootManager <> nil then
    bootManager.add_binding('TimeService', obj);
end;

{ TUTO_impl }

function TUTO_impl._get_inaccuracy: TTimeBase_InaccuracyT;
begin
  result := FInaccuracy;
end;

function TUTO_impl._get_tdf: TTimeBase_TdfT;
begin
  result := FTdf;
end;

function TUTO_impl._get_time: TTimeBase_TimeT;
begin
  result := FTime;
end;

function TUTO_impl._get_utc_time: TTimeBase_UtcT;
begin
  result := TTimeHelper.toUtcT(FTime, FInaccuracy, FTdf);
end;

function TUTO_impl.absolute_time: ICosTime_UTO;
var
  _now: TTimeBase_UtcT;
  uto: TUTO_impl;
begin
  // time_ is an interval in this case
  _now := TTimeHelper.utcNow();
  // Will we overflow?
  if TimeHelper.MaxTimeT - _now.time < FTime then
    dorb_throw(st_DATA_CONVERSION);
  UtcT_Plus_Time(_now, FTime);
  uto := TUTO_impl.Create(_now);
  result := uto._this();
end;

function TUTO_impl.compare_time(
  const comparison_type: TCosTime_ComparisonType;
  const uto: ICosTime_UTO): TCosTime_TimeComparison;
var
  otherTime: TTimeBase_TimeT;
  otherInacc: TTimeBase_InaccuracyT;
  my, other: TTimeBase_IntervalT;
begin
  if uto = nil then
    dorb_throw(st_BAD_PARAM);

  otherTime := uto.time;
  otherInacc := uto.inaccuracy;

  if FInaccuracy > TimeHelper.MaxInaccuracyT then
    dorb_throw(st_BAD_PARAM);

  my := TTimeHelper.toIntervalT(FTime, FInaccuracy);
  other := TTimeHelper.toIntervalT(otherTime, otherInacc);

  if comparison_type = IntervalC then begin
    // For IntervalC comparison, two UTOs are deemed to contain
    // the same time only if the Time attribute of the two objects
    // are equal and the Inaccuracy attributes of both the objects
    // are zero.
    if (FTime = otherTime) and (FInaccuracy = 0) and (otherInacc = 0) then begin
      result := TCEqualTo;
      Exit;
    end;

    // In an IntervalC comparison, TCIndeterminate value is
    // returned if the error envelopes around the two times being
    // compared overlap.
    //
    // <------- t1 -------->  <--------- t2 ------------>
    //
    // First test left hand side of t1 against right hand side of
    // t2.  Next test right hand side of t1 against left hand side
    // of t2.  If neither then there are overlapping areas.
    if (my.upper_bound < other.lower_bound) then
      result := TCLessThan
    else if (my.lower_bound > other.upper_bound) then
      result := TCGreaterThan
    else
      result := TCIndeterminate;
  end
  else begin
    // MidC comparison just compares the base times. A MidC
    // comparison can never return TCIndeterminate.
    if FTime = otherTime then
      result := TCEqualTo
    else if FTime < otherTime then
      result := TCLessThan
    else
      result := TCGreaterThan;
  end;
end;

function TUTO_impl.interval: ICosTime_TIO;
var
  inter: TTimeBase_IntervalT;
  tio: TTIO_impl;
begin
  inter := TTimeHelper.toIntervalT(FTime, FInaccuracy);
  tio := TTIO_impl.Create(inter.lower_bound, inter.upper_bound);
  result := tio._this();
end;

function TUTO_impl.time_to_interval(const uto: ICosTime_UTO): ICosTime_TIO;
var
  t: TTimeBase_TimeT;
  tio: TTIO_impl;
begin
  if uto = nil then
    dorb_throw(st_BAD_PARAM);

  t := uto.time;
  if FTime < t then
    tio := TTIO_impl.Create(FTime, t)
  else
    tio := TTIO_impl.Create(t, FTime);
  result := tio._this();
end;

constructor TUTO_impl.Create(const AUtcT: TTimeBase_UtcT);
begin
  inherited Create();
  with AUtcT do begin
    FTime := time;
    FInaccuracy := inacclo or inacchi shl 32;
    FTdf := tdf;
  end; { with }
end;

constructor TUTO_impl.Create(ATimeT: TTimeBase_TimeT;
  AInaccuracyT: TTimeBase_InaccuracyT; ATdfT: TTimeBase_TdfT);
begin
  inherited Create();
  FTime := ATimeT;
  FInaccuracy := AInaccuracyT;
  FTdf := ATdfT;
end;

{ TTIO_impl }

function TTIO_impl._get_time_interval: TTimeBase_IntervalT;
begin
  with result do begin
    lower_bound := FLower;
    upper_bound := FUpper;
  end; { with }
end;

function TTIO_impl.overlaps(const interval: ICosTime_TIO;
  out overlap: ICosTime_TIO): TCosTime_OverlapType;
var
  inter: TTimeBase_IntervalT;
begin
  if interval = nil then
    dorb_throw(st_BAD_PARAM);

  inter := interval.time_interval;

  if inter.lower_bound > inter.upper_bound then
    dorb_throw(st_BAD_PARAM);

  result := checkOverlap(inter.lower_bound, inter.upper_bound, overlap);
end;

function TTIO_impl.spans(const time: ICosTime_UTO;
  out overlap: ICosTime_TIO): TCosTime_OverlapType;
var
  _time: TTimeBase_TimeT;
  inacc: TTimeBase_InaccuracyT;
  inter: TTimeBase_IntervalT;
begin
  if time = nil then
    dorb_throw(st_BAD_PARAM);

  _time := time.time;
  inacc := time.inaccuracy;

  if inacc > MaxInaccuracyT then
    dorb_throw(st_BAD_PARAM);

  inter := TTimeHelper.toIntervalT(_time, inacc);

  result := checkOverlap(inter.lower_bound, inter.upper_bound, overlap);
end;

function TTIO_impl.time: ICosTime_UTO;
var
  inacc: TTimeBase_InaccuracyT;
  _time: TTimeBase_TimeT;
  uto: TUTO_impl;
begin
  inacc := (FUpper + FLower) div 2;
  _time := FLower + inacc;

  // Is inaccuracy too big?
  if inacc > TimeHelper.MaxInaccuracyT then
    dorb_throw(st_DATA_CONVERSION);

  uto := TUTO_impl.Create(_time, inacc);
  result := uto._this();
end;

constructor TTIO_impl.Create(const ALower, AUpper: TTimeBase_TimeT);
begin
  inherited Create();
  FLower := ALower;
  FUpper := AUpper;
end;

function TTIO_impl.checkOverlap(ALower, AUpper: TTimeBase_TimeT;
  out AOverlap: ICosTime_TIO): TCosTime_OverlapType;
var
  tio: TTIO_impl;
begin
  // First handle no overlap
  if FUpper < ALower then begin
    tio := TTIO_impl.Create(FUpper, ALower);
    AOverlap := tio._this();
    result := OTNoOverlap;
    Exit;
  end
  else if FLower > AUpper then begin
    tio := TTIO_impl.Create(AUpper, FLower);
    AOverlap := tio._this();
    result := OTNoOverlap;
    Exit;
  end
  // Is this TIO contained in the interval or vice versa? The spec
  // isn't clear what happens if the intervals are exactly the
  // same. This code will return Contained.
  else if (FLower >= ALower) and (FUpper <= AUpper) then begin
    AOverlap := Self;
    result := OTContained;
    Exit;
  end
  else if (FLower < ALower) and (FUpper > AUpper) then begin
    tio := TTIO_impl.Create(AUpper, ALower);
    AOverlap := tio._this();
    result := OTContainer;
    Exit;
  end
  // Overlap
  else if FUpper > AUpper then
    tio := TTIO_impl.Create(FLower, AUpper)
  else
    tio := TTIO_impl.Create(ALower, FUpper);
  AOverlap := tio._this();

  result := OTOverlap;
end;

{ TTimeService_impl }

constructor TTimeService_impl.Create(
  const AInaccuracy: TTimeBase_InaccuracyT);
begin
  inherited Create();
  if AInaccuracy > TimeHelper.MaxInaccuracyT then
    dorb_throw(st_BAD_PARAM);

  FInaccuracy := AInaccuracy;
end;

function TTimeService_impl.new_interval(const lower,
  upper: TTimeBase_TimeT): ICosTime_TIO;
var
  tio: TTIO_impl;
begin
  if lower > upper then
    dorb_throw(st_BAD_PARAM);

  tio := TTIO_impl.Create(lower, upper);
  result := tio._this();
end;

function TTimeService_impl.new_universal_time(const time: TTimeBase_TimeT;
  const inaccuracy: TTimeBase_InaccuracyT;
  const tdf: TTimeBase_TdfT): ICosTime_UTO;
var
  uto: TUTO_impl;
begin
  if inaccuracy > TimeHelper.MaxInaccuracyT then
    dorb_throw(st_BAD_PARAM);

  uto := TUTO_impl.Create(time, inaccuracy, tdf);
  result := uto._this();
end;

function TTimeService_impl.secure_universal_time: ICosTime_UTO;
var
  e: ICosTime_TimeUnavailable;
begin
  e := TCosTime_TimeUnavailable.Create();
  e.throw();
end;

function TTimeService_impl.universal_time: ICosTime_UTO;
var
  uto: TUTO_impl;
begin
  uto := TUTO_impl.Create(TTimeHelper.utcNow(FInaccuracy));
  result := uto._this();
end;

function TTimeService_impl.uto_from_utc(
  const utc: TTimeBase_UtcT): ICosTime_UTO;
var
  uto: TUTO_impl;
begin
  uto := TUTO_impl.Create(utc);
  result := uto._this();
end;

end.
