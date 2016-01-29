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
{*                  OVCDBPLB.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbPLb;
  {-Data-aware picture label component}

interface

uses
  {$IFDEF Win32} Windows, {$ELSE} WinTypes, WinProcs, {$ENDIF}
  Classes, Controls, Db, DbConsts, DbCtrls, DbTables, Forms, Graphics,
  Menus, Messages, SysUtils,
  OvcPLb, OvcRLbl;

{!!.12} {added ShowDateOrTime property}

type
  TShowDateOrTime = (ftShowDate, ftShowTime);

const
  DefShowDateOrTime = ftShowDate;

type
  TOvcDbPictureLabel = class(TOvcCustomPictureLabel)
  {.Z+}
  protected {private}
    {property variables}
    FDataLink       : TFieldDataLink;
    FShowDateOrTime : TShowDateOrTime;

    {property methods}
    function GetDataField : string;
    function GetDataSource : TDataSource;
    function GetField : TField;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);
    procedure SetShowDateOrTime(Value : TShowDateOrTime);

    {internal methods}
    procedure plDataChange(Sender : TObject);
    procedure plGetFieldValue;

    {vcl message methods}
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;
    procedure Paint;
      override;

    function plGetSampleDisplayData : string;
      override;
      {-return the text to display while in design mode}
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

    property ShowDateOrTime : TShowDateOrTime
      read FShowDateOrTime
      write SetShowDateOrTime
      default DefShowDateOrTime;

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
    property PictureMask;
    property PopupMenu;
    property ShadowColor;
    property ShadowedText;
    property ShowHint;
    property Transparent;
    property UseIntlMask;
    property Version;                                                  {!!.13}
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



{*** TOvcDbPictureLabel ***}

{$IFDEF Win32}
procedure TOvcDbPictureLabel.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := Integer(FDataLink);
end;
{$ENDIF}

constructor TOvcDbPictureLabel.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {$IFDEF Win32}
  ControlStyle := ControlStyle + [csReplicatable];
  {$ENDIF}

  {create data link}
  FDataLink := TFieldDataLink.Create;
  FDataLink.OnDataChange := plDataChange;

  FShowDateOrTime := DefShowDateOrTime;
end;

destructor TOvcDbPictureLabel.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

function TOvcDbPictureLabel.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbPictureLabel.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

function TOvcDbPictureLabel.GetField : TField;
begin
  Result := FDataLink.Field;
end;

procedure TOvcDbPictureLabel.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDataLink <> nil) and  (AComponent = DataSource) then
    DataSource := nil;
end;

procedure TOvcDbPictureLabel.Paint;
var
  S : string;
begin
{$IFDEF Win32}
  if not (csPaintCopy in ControlState) or (Field = nil) or
         (csDesigning in ComponentState) or
     not FDataLink.Active then begin
    inherited Paint;
    Exit;
  end else begin
    S := FCaption;
    if Field.DataType = ftDateTime then begin
      case FShowDateOrTime of
        ftShowDate : FCaption := DateToStr(Field.AsDateTime);
        ftShowTime : FCaption := TimeToStr(Field.AsDateTime);
      end;
    end else
      FCaption := Field.DisplayText;
    inherited Paint;
    FCaption := S;
  end;
{$ELSE}
  inherited Paint;
{$ENDIF}
end;

procedure TOvcDbPictureLabel.plDataChange(Sender : TObject);
begin
  plGetFieldValue;
end;

procedure TOvcDbPictureLabel.plGetFieldValue;
begin
  if Field <> nil then begin
    case Field.DataType of
      ftString   : SetAsString(Field.AsString);
      ftSmallInt,
      ftWord,
      ftInteger  : SetAsInteger(Field.AsInteger);
      ftBoolean  : SetAsBoolean(Field.AsBoolean);
      ftFloat,
      ftCurrency : SetAsFloat(Field.AsFloat);
      ftDate     : SetAsDate(Field.AsDateTime);
      ftTime     : SetAsTime(Field.AsDateTime);
      ftDateTime :
        if FShowDateOrTime = ftShowDate then
          SetAsDate(Field.AsDateTime)
        else
          SetAsTime(Field.AsDateTime);
    else
      SetAsString(Field.AsString);
    end;
  end else
    SetAsString(plGetSampleDisplayData);
end;

function TOvcDbPictureLabel.plGetSampleDisplayData : string;
begin
  if (Field <> nil) and FDataLink.Active then
    Result := plGetDisplayString
  else
    Result := inherited plGetSampleDisplayData;
end;

procedure TOvcDbPictureLabel.SetDataField(const Value : string);
begin
  FDataLink.FieldName := Value;
end;

procedure TOvcDbPictureLabel.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;

  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}
end;

procedure TOvcDbPictureLabel.SetShowDateOrTime(Value : TShowDateOrTime);
begin
  if Value <> FShowDateOrTime then begin
    FShowDateOrTime := Value;
    plGetFieldValue;
    Invalidate;
  end;
end;


end.