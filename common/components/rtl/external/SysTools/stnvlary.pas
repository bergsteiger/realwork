{*********************************************************}
{*                  STNVLARY.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVLAry;
  {-non visual component for TStLArray}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StLArr, StNVCont;

type
  TStNVLArray = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer        : TStLArray; {instance of the container}
    FElementCount     : LongInt;
    FElementSize      : Cardinal;

    {property methods}
    function GetStoreable : Boolean;
    procedure SetElementCount(Value : LongInt);
    procedure SetElementSize(Value : Cardinal);
    procedure SetStoreable(Value : Boolean);

    {internal methods}
    procedure RecreateContainer;

  protected
    function GetOnCompare : TStCompareEvent;
      override;
    function GetOnDisposeData : TStDisposeDataEvent;
      override;
    function GetOnLoadData : TStLoadDataEvent;
      override;
    function GetOnStoreData : TStStoreDataEvent;
      override;
    procedure SetOnCompare(Value : TStCompareEvent);
      override;
    procedure SetOnDisposeData(Value : TStDisposeDataEvent);
      override;
    procedure SetOnLoadData(Value : TStLoadDataEvent);
      override;
    procedure SetOnStoreData(Value : TStStoreDataEvent);
      override;

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;
  {.Z-}

    property Container : TStLArray
      read FContainer;

  published
    property ElementCount : LongInt
      read FElementCount
      write SetElementCount;

    property ElementSize : Cardinal
      read FElementSize
      write SetElementSize;

    property ElementsStorable : Boolean
      read GetStoreable
      write SetStoreable;

    property OnCompare;
    property OnDisposeData;
    property OnLoadData;
    property OnStoreData;
  end;


implementation

{$IFDEF TRIALRUN}
uses
  {$IFDEF Win32} Registry, {$ELSE} Ver, {$ENDIF}
  Forms,
  IniFiles,
  ShellAPI,
  SysUtils,
  StTrial;
{$I TRIAL00.INC} {FIX}
{$I TRIAL01.INC} {CAB}
{$I TRIAL02.INC} {CC}
{$I TRIAL03.INC} {VC}
{$I TRIAL04.INC} {TCC}
{$I TRIAL05.INC} {TVC}
{$I TRIAL06.INC} {TCCVC}
{$ENDIF}


{*** TStNVLArray ***}

constructor TStNVLArray.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}
  FElementCount := 10;
  FElementSize := SizeOf(LongInt);

  if Classes.GetClass(TStLArray.ClassName) = nil then
    RegisterClass(TStLArray);

  FContainer := TStLArray.Create(FElementCount, FElementSize);
end;

destructor TStNVLArray.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVLArray.GetOnCompare : TStCompareEvent;
begin
  Result := FContainer.OnCompare;
end;

function TStNVLArray.GetOnDisposeData : TStDisposeDataEvent;
begin
  Result := FContainer.OnDisposeData;
end;

function TStNVLArray.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVLArray.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

function TStNVLArray.GetStoreable : Boolean;
begin
  Result := FContainer.ElementsStorable;
end;

procedure TStNVLArray.RecreateContainer;
var
  HoldOnCompare     : TStCompareEvent;
  HoldOnDisposeData : TStDisposeDataEvent;
  HoldOnLoadData    : TStLoadDataEvent;
  HoldOnStoreData   : TStStoreDataEvent;
begin
  HoldOnCompare := FContainer.OnCompare;
  HoldOnDisposeData := FContainer.OnDisposeData;
  HoldOnLoadData := FContainer.OnLoadData;
  HoldOnStoreData := FContainer.OnStoreData;
  FContainer.Free;
  FContainer := TStLArray.Create(FElementCount, FElementSize);
  FContainer.OnCompare := HoldOnCompare;
  FContainer.OnDisposeData := HoldOnDisposeData;
  FContainer.OnLoadData := HoldOnLoadData;
  FContainer.OnStoreData := HoldOnStoreData;
end;

procedure TStNVLArray.SetElementCount(Value : LongInt);
begin
  FElementCount := Value;
  RecreateContainer;
end;

procedure TStNVLArray.SetElementSize(Value : Cardinal);
begin
  FElementSize := Value;
  RecreateContainer;
end;

procedure TStNVLArray.SetOnCompare(Value : TStCompareEvent);
begin
  FContainer.OnCompare := Value;
end;

procedure TStNVLArray.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
  FContainer.OnDisposeData := Value;
end;

procedure TStNVLArray.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVLArray.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;

procedure TStNVLArray.SetStoreable(Value : Boolean);
begin
  FContainer.ElementsStorable := Value;
end;


end.