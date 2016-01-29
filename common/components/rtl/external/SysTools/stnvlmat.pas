{*********************************************************}
{*                  STNVLMAT.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVLMat;
  {-non visual component for TStLMatrix}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StLArr, StNVCont;

type
  TStNVLMatrix = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer        : TStLMatrix; {instance of the container}
    FCols             : Cardinal;
    FRows             : Cardinal;
    FElementSize      : Cardinal;

    {property methods}
    function GetStoreable : Boolean;
    procedure SetCols(Value : Cardinal);
    procedure SetRows(Value : Cardinal);
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

    property Container : TStLMatrix
      read FContainer;

  published
    property Cols : Cardinal
      read FCols
      write SetCols;

    property Rows : Cardinal
      read FRows
      write SetRows;

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


{*** TStNVLMatrix ***}

constructor TStNVLMatrix.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}
  FCols := 2;
  FRows := 10;
  FElementSize := SizeOf(LongInt);

  if Classes.GetClass(TStLMatrix.ClassName) = nil then
    RegisterClass(TStLMatrix);

  FContainer := TStLMatrix.Create(FRows, FCols, FElementSize);
end;

destructor TStNVLMatrix.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVLMatrix.GetOnCompare : TStCompareEvent;
begin
  Result := FContainer.OnCompare;
end;

function TStNVLMatrix.GetOnDisposeData : TStDisposeDataEvent;
begin
  Result := FContainer.OnDisposeData;
end;

function TStNVLMatrix.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVLMatrix.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

function TStNVLMatrix.GetStoreable : Boolean;
begin
  Result := FContainer.ElementsStorable;
end;

procedure TStNVLMatrix.RecreateContainer;
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
  FContainer := TStLMatrix.Create(FRows, FCols, FElementSize);
  FContainer.OnCompare := HoldOnCompare;
  FContainer.OnDisposeData := HoldOnDisposeData;
  FContainer.OnLoadData := HoldOnLoadData;
  FContainer.OnStoreData := HoldOnStoreData;
end;

procedure TStNVLMatrix.SetCols(Value : Cardinal);
begin
  FCols := Value;
  RecreateContainer;
end;

procedure TStNVLMatrix.SetElementSize(Value : Cardinal);
begin
  FElementSize := Value;
  RecreateContainer;
end;

procedure TStNVLMatrix.SetOnCompare(Value : TStCompareEvent);
begin
  FContainer.OnCompare := Value;
end;

procedure TStNVLMatrix.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
  FContainer.OnDisposeData := Value;
end;

procedure TStNVLMatrix.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVLMatrix.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;

procedure TStNVLMatrix.SetRows(Value : Cardinal);
begin
  FRows := Value;
  RecreateContainer;
end;

procedure TStNVLMatrix.SetStoreable(Value : Boolean);
begin
  FContainer.ElementsStorable := Value;
end;


end.