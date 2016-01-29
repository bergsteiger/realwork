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
{*                  OVCDBCAL.PAS 2.17                    *}
{*     Copyright (c) 1995-98 TurboPower Software Co      *}
{*                 All rights reserved.                  *}
{*********************************************************}


unit OvcDbCal;
  {-Data-Aware Calendar component}

interface

uses
  Classes, Controls, Db, DbCtrls, DbTables, Forms, Graphics, Menus, Messages,
  OvcBase, OvcCal, OvcConst, OvcCmd, OvcData, OvcExcpt, STDate;

const
  {field types supported}
  SupportedFieldTypes : set of  TFieldType = [ftDate, ftDateTime];

type
  TOvcDbCalendar = class(TOvcCustomCalendar)
  {.Z+}
  protected {private}
    {property variables}
    FAutoUpdate  : Boolean;
    FDataLink    : TFieldDataLink;

    {property methods}
    function GetDataField : string;
    function GetDataSource : TDataSource;
    function GetField : TField;
    procedure SetDataField(const Value : string);
    procedure SetDataSource(Value : TDataSource);

    {internal methods}
    procedure calDataChange(Sender : TObject);
    procedure calUpdateData(Sender : TObject);

    {windows message methods}
    procedure WMKeyDown(var Msg : TWMKeyDown);
      message WM_KEYDOWN;
    procedure WMLButtonDown(var Msg : TWMLButtonDown);
      message WM_LBUTTONDOWN;

    {vcl methods}
    procedure CMExit(var Msg : TMessage);
      message CM_EXIT;
    {$IFDEF Win32}
    procedure CMGetDataLink(var Msg : TMessage);
      message CM_GETDATALINK;
    {$ENDIF}

  protected
    procedure Notification(AComponent : TComponent; Operation : TOperation);
      override;

    {dynamic event wrappers}
    procedure DoOnChange;
      override;
    function IsReadOnly : Boolean;
      override;
    procedure SetCalendarDate(Value : TStDate);
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
    property AutoUpdate : Boolean
      read FAutoUpdate
      write FAutoUpdate
      default False;

    property DataField : string
      read GetDataField
      write SetDataField;

    property DataSource : TDataSource
      read GetDataSource
      write SetDataSource;

    property BorderStyle;
    property Colors;
    property DayNameLen;
    property DrawGridLines;
    property DrawHeader;
    property HeaderHeight;
    property LineColor;
    property ReadOnly;
    property ShortNames;
    property WantDblClicks;
    property WeekStarts;

    property OnChange;
    property OnDrawHeader;
    property OnDrawItem;
    property OnUserCommand;

    {inherited properties}
    property Align;
    property Controller;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop
      default True;
    property Visible;

    {inherited events}
    property AfterEnter;                                               {!!.12}
    property AfterExit;                                                {!!.12}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF Win32}
    property OnStartDrag;
    {$ENDIF}
  end;


implementation


{*** TOvcDbCalendar ***}

procedure TOvcDbCalendar.calDataChange(Sender : TObject);
begin
  if Field <> nil then begin
    {update our display value}
    case Field.DataType of
      ftDate,
      ftDateTime : Self.AsDateTime := Field.AsDateTime;
    else
      Self.AsDateTime := CurrentDate;
    end;
  end else
    Self.AsDateTime := CurrentDate;
end;

procedure TOvcDbCalendar.calUpdateData(Sender : TObject);
var
  DT : TDateTime;
begin
  if (DataSource = nil) or (Field = nil) then
    Exit;

  case Field.DataType of
    ftDate     : Field.AsDateTime := Self.AsDateTime;
    ftDateTime :
      begin
        {preserve unedited time portion of field value}
        DT := Field.AsDateTime;
        Field.AsDateTime := Trunc(Self.AsDateTime) + Frac(DT);
      end;
  end;
end;

procedure TOvcDbCalendar.CMExit(var Msg : TMessage);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

{$IFDEF Win32}
procedure TOvcDbCalendar.CMGetDataLink(var Msg : TMessage);
begin
  Msg.Result := LongInt(FDataLink);
end;
{$ENDIF}

constructor TOvcDbCalendar.Create(AOwner : TComponent);
begin
  inherited Create(AOwner);

  {initialize default property values}
  FAutoUpdate               := False;
  FInitialize               := False;

  {create the data link object}
  FDataLink                 := TFieldDataLink.Create;
  FDataLink.Control         := Self;

  {set notification routines}
  FDataLink.OnActiveChange  := calDataChange;
  FDataLink.OnDataChange    := calDataChange;
  FDataLink.OnUpdateData    := calUpdateData;

  {set sample display date}
  CalendarDate := CurrentDate;
end;

destructor TOvcDbCalendar.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;

  inherited Destroy;
end;

procedure TOvcDbCalendar.DoOnChange;
begin
  FDataLink.Modified;
  inherited DoOnChange;
end;

function TOvcDbCalendar.GetDataField : string;
begin
  Result := FDataLink.FieldName;
end;

function TOvcDbCalendar.GetDataSource : TDataSource;
begin
  if Assigned(FDataLink) then
    Result := FDataLink.DataSource
  else
    Result := nil;
end;

function TOvcDbCalendar.GetField : TField;
begin
  Result := FDataLink.Field;
end;

function TOvcDbCalendar.IsReadOnly : Boolean;
begin
  Result := inherited IsReadOnly or (DataSource = nil) or
            not (DataSource.State in [dsEdit, dsInsert]);
end;

procedure TOvcDbCalendar.Notification(AComponent : TComponent; Operation : TOperation);
begin
  inherited Notification(AComponent, Operation);

  if (Operation = opRemove) and (FDataLink <> nil) and
     (AComponent = DataSource) then begin
    DataSource := nil;
    Refresh;
  end;
end;

procedure TOvcDbCalendar.SetCalendarDate(Value : TStDate);
begin
  inherited SetCalendarDate(Value);

  if FDataLink.Editing then
    if AutoUpdate then begin
      try
        FDataLink.UpdateRecord;
      except
        SetFocus;
        raise;
      end;
    end;
end;

procedure TOvcDbCalendar.SetDataField(const Value : string);
var
  SaveName : string;
begin
  {save current field name}
  SaveName := FDataLink.FieldName;
  try
    FDataLink.FieldName := Value;
  except
    FDataLink.FieldName := '';
    raise;
  end;

  {see if this is a valid field type}
  if not (csLoading in ComponentState) and (Field <> nil) and
         (csDesigning in ComponentState) and
         not (Field.DataType in SupportedFieldTypes) then begin

    {restore old field name}
    try
      FDataLink.FieldName := SaveName;
    except
      {ignore any errors}
    end;

    raise EOvcException.Create(GetOrphStr(SCInvalidFieldType));
  end;

  if csDesigning in ComponentState then
    RecreateWnd
  else
    Refresh;
end;

procedure TOvcDbCalendar.SetDataSource(Value : TDataSource);
begin
  FDataLink.DataSource := Value;

  {$IFDEF Win32}
  if Value <> nil then
    Value.FreeNotification(Self);
  {$ENDIF}

  Refresh;
end;

procedure TOvcDbCalendar.WMLButtonDown(var Msg : TWMLButtonDown);
begin
  {see if we need to enter edit mode}
  if (DataSource <> nil) then
    if not FDataLink.Editing and DataSource.AutoEdit then
      FDataLink.Edit;

  inherited;
end;

procedure TOvcDbCalendar.WMKeyDown(var Msg : TWMKeyDown);
begin
  {see if we need to enter edit mode}
  if (DataSource <> nil) then
    if not FDataLink.Editing and DataSource.AutoEdit then
      FDataLink.Edit;

  inherited;
end;

end.