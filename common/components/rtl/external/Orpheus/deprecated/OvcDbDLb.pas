{$I OVC.INC}

{$B-} {Complete Boolean Evaluation}
{$I+} {Input/Output-Checking}
{$P+} {Open Parameters}
{$T-} {Typed @ Operator}
{$W-} {Windows Stack Frame}
{$X+} {Extended Syntax}

{$IFNDEF Win32}
{$G+} {286 Instructions}
{$N+} {Numeric Coprocessor}

{$C MOVEABLE,DEMANDLOAD,DISCARDABLE}
{$ENDIF}

{*********************************************************}
{*                  OVCDBDLB.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}

unit OvcDbDLb;
  {-Data-aware display label component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Db, DbCtrls, DbTables, Graphics, Menus, Messages, StdCtrls,
  OvcRLbl;

type
  TOvcDbDisplayLabel = class(TOvcCustomRotatedLabel)
  {.Z+}
  protected {private}
    {property variables}
    FDataLink : TFieldDataLink;

    {property methods}
    function GetDataField : string;
    function GetDataSource : TDataSource;
    function GetField : TField;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);

    {internal methods}
    procedure dlDataChange(Sender : TObject);
      {-data change notification}
    function dlGetDisplayLabel : string;
      {-return the display label}


    {vcl message methods}
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;
  {.Z-}

  public
    constructor Create(AOwner : TComponent);
      override;
    destructor Destroy;
      override;

    property Field : TField
      read GetField;

  published
    {properties}
    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    {inherited properties}
    property Align;
    property Alignment;
    property AutoSizeHeight;
    property AutoSizeWidth;
    property Color;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property FontAngle;
    property OriginX;
    property OriginY;
    property ParentColor;
    {property ParentFont;}                                             {!!.10}
    property ParentShowHint;
    property PopupMenu;
    property ShadowColor;
    property ShadowedText;
    property ShowHint;
    property Transparent;
    property Visible;

    {events}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation


{*** TOvcDbDisplayLabel ***}

{$IFDEF Win32}
procedure TOvcDbDisplayLabel.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;
{$ENDIF}

constructor TOvcDbDisplayLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {create data link}
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := dlDataChange;
end;

destructor TOvcDbDisplayLabel.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

procedure TOvcDbDisplayLabel.dlDataChange(Sender : TObject);
begin
  Caption := dlGetDisplayLabel;
end;

function TOvcDbDisplayLabel.dlGetDisplayLabel : string;
begin
  if FDataLink.Field <> nil then
    Result := FDataLink.Field.DisplayLabel
  else
    if csDesigning in ComponentState then
      Result := Name
    else
      Result := '';
end;

function TOvcDbDisplayLabel.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbDisplayLabel.GetDataSource : TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TOvcDbDisplayLabel.GetField : TField;
begin
  Result := FDataLink.Field;
end;

procedure TOvcDbDisplayLabel.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TOvcDbDisplayLabel.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

procedure TOvcDbDisplayLabel.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;
  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
end;


end.