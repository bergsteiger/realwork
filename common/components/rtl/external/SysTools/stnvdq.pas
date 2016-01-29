{*********************************************************}
{*                   STNVDQ.PAS 3.01                     *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVDQ;
  {-non visual component for TStDQue}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StList, StDQue, StNVCont;

type
  TStNVDQue = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer : TStDQue; {instance of the container}

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

    property Container : TStDQue
      read FContainer;

  published
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


{*** TStNVDQue ***}

constructor TStNVDQue.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}

  if Classes.GetClass(TStDQue.ClassName) = nil then
    RegisterClass(TStDQue);
  if Classes.GetClass(TStListNode.ClassName) = nil then
    RegisterClass(TStListNode);

  FContainer := TStDQue.Create(TStListNode);
end;

destructor TStNVDQue.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVDQue.GetOnCompare : TStCompareEvent;
begin
  Result := FContainer.OnCompare;
end;

function TStNVDQue.GetOnDisposeData : TStDisposeDataEvent;
begin
  Result := FContainer.OnDisposeData;
end;

function TStNVDQue.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVDQue.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

procedure TStNVDQue.SetOnCompare(Value : TStCompareEvent);
begin
  FContainer.OnCompare := Value;
end;

procedure TStNVDQue.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
  FContainer.OnDisposeData := Value;
end;

procedure TStNVDQue.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVDQue.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;


end.