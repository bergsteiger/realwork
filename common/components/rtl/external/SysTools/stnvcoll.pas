{*********************************************************}
{*                  STNVCOLL.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVColl;
  {-non visual component for TStCollection}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StColl, StNVCont;

type
  TStNVCollection = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer    : TStCollection; {instance of the container}
    FPageElements : Integer;

    {property methods}
    procedure SetPageElements(Value : Integer);

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

    property Container : TStCollection
      read FContainer;

  published
    property PageElements : Integer
      read FPageElements
      write SetPageElements;

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


{*** TStNVCollection ***}

constructor TStNVCollection.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}
  FPageElements := 1000;

  if Classes.GetClass(TStCollection.ClassName) = nil then
    RegisterClass(TStCollection);

  FContainer := TStCollection.Create(FPageElements);
end;

destructor TStNVCollection.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVCollection.GetOnCompare : TStCompareEvent;
begin
  Result := FContainer.OnCompare;
end;

function TStNVCollection.GetOnDisposeData : TStDisposeDataEvent;
begin
  Result := FContainer.OnDisposeData;
end;

function TStNVCollection.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVCollection.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

procedure TStNVCollection.RecreateContainer;
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
  FContainer := TStCollection.Create(FPageElements);
  FContainer.OnCompare := HoldOnCompare;
  FContainer.OnDisposeData := HoldOnDisposeData;
  FContainer.OnLoadData := HoldOnLoadData;
  FContainer.OnStoreData := HoldOnStoreData;
end;

procedure TStNVCollection.SetOnCompare(Value : TStCompareEvent);
begin
  FContainer.OnCompare := Value;
end;

procedure TStNVCollection.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
  FContainer.OnDisposeData := Value;
end;

procedure TStNVCollection.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVCollection.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;

procedure TStNVCollection.SetPageElements(Value : Integer);
begin
  FPageElements := Value;
  RecreateContainer;
end;


end.