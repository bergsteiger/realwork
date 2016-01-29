{*********************************************************}
{*                  STNVCONT.PAS 3.01                    *}
{*   Copyright (c) TurboPower Software Co., 1996-2000    *}
{*                 All rights reserved.                  *}
{*********************************************************}

{$I STDEFINE.INC}

{$IFNDEF WIN32}
  {$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

unit StNVCont;
  {-non visual components for container classes}

interface

uses
  {$IFDEF WIN32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes,
  StBase, StBits;

type
  TStContainerClass = class of TStContainer;

  TStDisposeDataEvent = procedure(Sender : TObject; Data : Pointer)
    of object;
  TStLoadDataEvent = procedure(Sender : TObject; Reader : TReader; var Data : Pointer)
    of object;
  TStStoreDataEvent = procedure(Sender : TObject; Writer : TWriter; Data : Pointer)
    of object;

  {.Z+}
  TStNVContainerBase = class(TStComponent)
  protected
    {virtual property methods}
    function GetOnCompare : TStCompareEvent;
      virtual;
    function GetOnDisposeData : TStDisposeDataEvent;
      virtual;
    function GetOnLoadData : TStLoadDataEvent;
      virtual;
    function GetOnStoreData : TStStoreDataEvent;
      virtual;
    procedure SetOnCompare(Value : TStCompareEvent);
      virtual;
    procedure SetOnDisposeData(Value : TStDisposeDataEvent);
      virtual;
    procedure SetOnLoadData(Value : TStLoadDataEvent);
      virtual;
    procedure SetOnStoreData(Value : TStStoreDataEvent);
      virtual;

    {events}
    property OnCompare : TStCompareEvent
      read GetOnCompare
      write SetOnCompare;

    property OnDisposeData : TStDisposeDataEvent
      read GetOnDisposeData
      write SetOnDisposeData;

    property OnLoadData : TStLoadDataEvent
      read GetOnLoadData
      write SetOnLoadData;

    property OnStoreData : TStStoreDataEvent
      read GetOnStoreData
      write SetOnStoreData;
  end;
  {.Z-}


implementation



{*** TStNVContainerBase ***}

function TStNVContainerBase.GetOnCompare : TStCompareEvent;
begin
end;

function TStNVContainerBase.GetOnDisposeData : TStDisposeDataEvent;
begin
end;

function TStNVContainerBase.GetOnLoadData : TStLoadDataEvent;
begin
end;

function TStNVContainerBase.GetOnStoreData : TStStoreDataEvent;
begin
end;

procedure TStNVContainerBase.SetOnCompare(Value : TStCompareEvent);
begin
end;

procedure TStNVContainerBase.SetOnDisposeData(Value : TStDisposeDataEvent);
begin
end;

procedure TStNVContainerBase.SetOnLoadData(Value : TStLoadDataEvent);
begin
end;

procedure TStNVContainerBase.SetOnStoreData(Value : TStStoreDataEvent);
begin
end;


end.