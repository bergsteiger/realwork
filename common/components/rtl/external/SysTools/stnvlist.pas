{*********************************************************}
{*                  STNVLIST.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVList;
  {-non visual component for TStList}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StList, StNVCont;

type
  TStNVList = class(TStNVContainerBase)
  {.Z+}
  protected {private}
    {property variables}
    FContainer : TStList; {instance of the container}

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

    property Container : TStList
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


{*** TStNVList ***}

constructor TStNVList.Create(AOwner : TComponent);
begin
  {$IFDEF TRIALRUN} TCCVC; {$ENDIF}
  inherited Create(AOwner);

  {defaults}

  if Classes.GetClass(TStList.ClassName) = nil then
    RegisterClass(TStList);
  if Classes.GetClass(TStListNode.ClassName) = nil then
    RegisterClass(TStListNode);

  FContainer := TStList.Create(TStListNode);
end;

destructor TStNVList.Destroy;
begin
  FContainer.Free;
  FContainer := nil;

  inherited Destroy;
end;

function TStNVList.GetOnCompare : TStCompareEvent;
begin
  Result := FContainer.OnCompare;
end;

function TStNVList.GetOnDisposeData : TStDisposeDataEvent;
begin
  Result := FContainer.OnDisposeData;
end;

function TStNVList.GetOnLoadData : TStLoadDataEvent;
begin
  Result := FContainer.OnLoadData;
end;

function TStNVList.GetOnStoreData : TStStoreDataEvent;
begin
  Result := FContainer.OnStoreData;
end;

procedure TStNVList.SetOnCompare(Value : TStCompareEvent);
begin
  FContainer.OnCompare := Value;
end;

procedure TStNVList.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
  FContainer.OnDisposeData := Value;
end;

procedure TStNVList.SetOnLoadData(Value : TStLoadDataEvent);
begin
  FContainer.OnLoadData := Value;
end;

procedure TStNVList.SetOnStoreData(Value : TStStoreDataEvent);
begin
  FContainer.OnStoreData := Value;
end;



end.