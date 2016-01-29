{====================================================}
{                                                    }
{   EldoS Visual Components                          }
{                                                    }
{   Copyright (c) 1998-2003, EldoS Corporation       }
{                                                    }
{====================================================}
{$include elpack2.inc}
{$ifdef ELPACK_SINGLECOMP}
{$I ElPack.inc}
{$else}
{$ifdef LINUX}
{$I ../ElPack.inc}
{$else}
{$I ..\ElPack.inc}
{$endif}
{$endif}

(*

Version History

17/07/2003

  Fixed ReadOnly ...

01/10/2002

  Changed ReadOnly property to support Unassigned

*)

unit ElDBDTPick;

interface

uses
     DB,
     DBCtrls,
   {$ifdef VCL_6_USED}
     Variants,
   {$endif}
     ElDTPick,
     Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
   {$ifdef VCL_6_USED}
     Types,
   {$endif}
     ElVCLUtils,
     Classes,
     SysUtils;

type

  TElDBDateTimePicker = class(TElDateTimePicker)
  private
    FDataLink: TFieldDataLink;
    FNowForNULLValues: Boolean;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    procedure EditingChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure UpdateData(Sender: TObject);
  protected
    function DataLink_GetReadOnly: Boolean;
    procedure DataLink_SetReadOnly(Value: Boolean);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetModified(newValue : Boolean); override;
    procedure KeyDown(var Key : Word; Shift : TShiftState); override;
    procedure CMEnter(var Message: TMessage); message CM_ENTER;
    procedure CloseUp(AcceptValue : boolean); override;
    procedure DropDown; override;
    procedure SpinUpClick(Sender : TObject; Increment : Double);
    procedure SpinDownClick(Sender : TObject; Increment : Double);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    {$ifdef VCL_4_USED}
    function ExecuteAction(Action: TBasicAction): Boolean; override;
    function UpdateAction(Action: TBasicAction): Boolean; override;
    function UseRightToLeftAlignment: Boolean; override;
    {$endif}
    property Field: TField read GetField;
  published
    property DataField: string read GetDataField write SetDataField;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read DataLink_GetReadOnly write DataLink_SetReadOnly
      default False;
    property NowForNULLValues: Boolean read FNowForNULLValues write
        FNowForNULLValues;
  end;

implementation

constructor TElDBDateTimePicker.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited ReadOnly := True;
  UnassignedAllowed := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
  FButton.OnUpClick := SpinUpClick;
  FButton.OnDownClick := SpinDownClick;
end;

destructor TElDBDateTimePicker.Destroy;
begin
  FreeAndNil(FDataLink);
  inherited Destroy;
end;

procedure TElDBDateTimePicker.SpinUpClick(Sender : TObject; Increment : Double);
begin
  if not ReadOnly then
    FDataLink.Edit;
  inherited SpinUpClick(Sender, Increment);
end;

procedure TElDBDateTimePicker.SpinDownClick(Sender : TObject; Increment : Double);
begin
  if not ReadOnly then
    FDataLink.Edit;
  inherited SpinDownClick(Sender, Increment);
end;

procedure TElDBDateTimePicker.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

procedure TElDBDateTimePicker.CMExit(var Message: TCMExit);
begin
  try
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBDateTimePicker.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBDateTimePicker.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
  begin
    if FDataLink.Field.IsNull then
    begin
      if not NowForNullValues then
      begin
        DateTime := FDataLink.Field.AsDateTime;
        Unassigned := true;
      end
      else
      begin
        Unassigned := false;
        DateTime := Now;
      end;
    end
    else
    begin
      Unassigned := false;
      DateTime := FDataLink.Field.AsDateTime;
    end;
  end;
  Modified := false;
end;

{$ifdef VCL_4_USED}
function TElDBDateTimePicker.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBDateTimePicker.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBDateTimePicker.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBDateTimePicker.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBDateTimePicker.DataLink_GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBDateTimePicker.DataLink_SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
end;

procedure TElDBDateTimePicker.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBDateTimePicker.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBDateTimePicker.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then
    Value.FreeNotification(Self);
end;

{$ifdef VCL_4_USED}
function TElDBDateTimePicker.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBDateTimePicker.UpdateData(Sender: TObject);
begin
  //if FDataLink.Editing then
  begin
   if Unassigned then
      FDataLink.Field.Clear
    else
      FDataLink.Field.AsDateTime := DateTime;
  end;
end;

{$ifdef VCL_4_USED}
function TElDBDateTimePicker.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBDateTimePicker.SetModified(newValue : Boolean);
begin
  inherited;
  if FModified <> newValue then
  begin
    inherited;
    if newValue then
      FDataLink.Modified;
  end;
end;

procedure TElDBDateTimePicker.KeyDown(var Key : Word; Shift : TShiftState);
begin
  if not ReadOnly then
  begin
    if (Shift = []) then
    case Key of
      VK_BACK,
      VK_SPACE,
      VK_DELETE,
      Ord('0')..Ord('9'):
        FDataLink.Edit;
      VK_ESCAPE:
        FDataLink.Reset;
    end
    else
    if (ssCtrl in Shift) then
    begin
      if not (ssShift in Shift) then
      case Key of
        Ord('V'), Ord('v'),
        Ord('X'), Ord('x'):
          FDataLink.Edit;
      end;
    end
    else
    if (ssShift in Shift) and (Key = VK_INSERT) then
      FDataLink.Edit;
  end;
  inherited;
end;

procedure TElDBDateTimePicker.CMEnter(var Message: TMessage);
begin
  inherited;
  FDataLink.Reset;
  Modified := false;
end;

procedure TElDBDateTimePicker.CloseUp(AcceptValue : boolean);
begin
  {$ifdef DATETIMEPICKER_SUPPORT_CALENDAR}
  if FForm.Visible then
  begin
    if AcceptValue then
      FDataLink.Edit;
    inherited;
  end;
{$endif}
end;

procedure TElDBDateTimePicker.DropDown;
begin
  {$ifdef DATETIMEPICKER_SUPPORT_CALENDAR}
  if DroppedDown then
    inherited
  else
  begin
    if not ReadOnly then
      inherited
    else
      FCalButton.Down := false;
  end;
  {$endif}
end;

end.
