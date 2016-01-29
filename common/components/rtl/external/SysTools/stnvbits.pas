{*********************************************************}
{*                  STNVBITS.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVBits;
  {-non visual component for TStBits}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StBits, StNVCont;

type
  TStNVBits = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer : TStBits; {instance of the container}
    FMaxBits   : LongInt;

    {property methods}
    procedure SetMaxBits(Value : LongInt);

  protected
    {virtual property methods}
    function GetOnLoadData : TStLoadDataEvent;
      override;
    function GetOnStoreData : TStStoreDataEvent;
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

    property Container : TStBits
      read FContainer;

  published
    property MaxBits : LongInt
      read FMaxBits
      write SetMaxBits;

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


{*** TStNVBits ***}

constructor TStNVBits.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}
  FMaxBits := 100;

  if Classes.GetClass(TStBits.ClassName) = nil then
    RegisterClass(TStBits);

  FContainer := TStBits.Create(FMaxBits-1);
end;

destructor TStNVBits.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVBits.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVBits.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

procedure TStNVBits.SetMaxBits(Value : LongInt);
var
  HoldOnLoadData  : TStLoadDataEvent;
  HoldOnStoreData : TStStoreDataEvent;
begin
  {setting MaxBits will destroy exisiting data}
  if Value < 0 then
    Value := 0;
  FMaxBits := Value;

  HoldOnLoadData := FContainer.OnLoadData;
  HoldOnStoreData := FContainer.OnStoreData;
  FContainer.Free;
  FContainer := TStBits.Create(FMaxBits-1);
  FContainer.OnLoadData := HoldOnLoadData;
  FContainer.OnStoreData := HoldOnStoreData;
end;

procedure TStNVBits.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVBits.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;


end.