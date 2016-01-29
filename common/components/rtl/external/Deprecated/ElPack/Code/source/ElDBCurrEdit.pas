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

03/18/2003
 Added handling of VK_DELETE, VK_BACK, VK_ESCAPE keys
 Fixed Calculator Dialog edit cancellation
 Added ReadOnly Property synchronization

*)

unit ElDBCurrEdit;

interface

uses
     DB,
     DBCtrls,

     ElCurrEdit,

     Forms,
     Windows,
     Controls,
     StdCtrls,
     Messages,
     {$ifdef VCL_6_USED}
     Types,
     {$endif}
     Classes,
     SysUtils;

type

  TElDBCurrencyEdit = class(TElCurrencyEdit)
  private
    FDataLink: TFieldDataLink;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMGetDataLink(var Message: TMessage); message CM_GETDATALINK;
    procedure DataChange(Sender: TObject);
    function GetDataField: string;
    function GetDataSource: TDataSource;
    function GetField: TField;
    function GetReadOnly: Boolean;
    procedure SetDataField(const Value: string);
    procedure SetDataSource(Value: TDataSource);
    procedure SetReadOnly(Value: Boolean);
    procedure UpdateData(Sender: TObject);
    procedure EditingChange(Sender: TObject);
  protected
    procedure KeyPress(var Key: Char); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoOnChange; override;
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
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;
  end;


implementation

constructor TElDBCurrencyEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //inherited ReadOnly := true;
  FDataLink := TFieldDataLink.Create;
  FDataLink.Control := Self;
  FDataLink.OnDataChange := DataChange;
  FDataLink.OnUpdateData := UpdateData;
  FDataLink.OnEditingChange := EditingChange;
end;

destructor TElDBCurrencyEdit.Destroy;
begin
  FDataLink.Free;
  FDataLink := nil;
  inherited Destroy;
end;

procedure TElDBCurrencyEdit.CMExit(var Message: TCMExit);
begin
  try
    if Modified then
      FDataLink.Modified;
    FDataLink.UpdateRecord;
  except
    SetFocus;
    raise;
  end;
  inherited;
end;

procedure TElDBCurrencyEdit.CMGetDataLink(var Message: TMessage);
begin
  Message.Result := Integer(FDataLink);
end;

procedure TElDBCurrencyEdit.DataChange(Sender: TObject);
begin
  if FDataLink.Field <> nil then
    Value := FDataLink.Field.AsCurrency
  else
    Value := 0;
end;

{$ifdef VCL_4_USED}
function TElDBCurrencyEdit.ExecuteAction(Action: TBasicAction): Boolean;
begin
  Result := inherited ExecuteAction(Action) or (FDataLink <> nil) and
    FDataLink.ExecuteAction(Action);
end;
{$endif}

function TElDBCurrencyEdit.GetDataField: string;
begin
  Result := FDataLink.FieldName;
end;

function TElDBCurrencyEdit.GetDataSource: TDataSource;
begin
  Result := FDataLink.DataSource;
end;

function TElDBCurrencyEdit.GetField: TField;
begin
  Result := FDataLink.Field;
end;

function TElDBCurrencyEdit.GetReadOnly: Boolean;
begin
  Result := FDataLink.ReadOnly;
end;

procedure TElDBCurrencyEdit.KeyPress(var Key: Char);
begin
  if Key=#0 then
    exit;
  inherited KeyPress(Key);
  if (Key in ['0'..'9']) and (FDataLink.Field <> nil) and
    not FDataLink.Field.IsValidChar(Key) then
  begin
    MessageBeep(0);
    Key := #0;
  end
  else
  case Key of
    ^H, ^V, ^X, #32..#255:
      FDataLink.Edit;
  end;
end;

procedure TElDBCurrencyEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_DELETE, VK_BACK] then
  begin
    FDataLink.Edit;
    inherited KeyDown(Key, Shift);
  end
  else
  if Key = VK_ESCAPE then
  begin
    FDataLink.Reset;
    //DataChange(Self);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TElDBCurrencyEdit.DoOnChange;
begin
  inherited;
  UpdateData(Self);
end;

procedure TElDBCurrencyEdit.Notification(AComponent: TComponent; Operation:
    TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (FDataLink <> nil) and
    (AComponent = DataSource) then DataSource := nil;
end;

procedure TElDBCurrencyEdit.SetDataField(const Value: string);
begin
  FDataLink.FieldName := Value;
end;

procedure TElDBCurrencyEdit.SetDataSource(Value: TDataSource);
begin
  {$ifdef VCL_5_USED}
  if FDataLink.DataSource <> nil then
    if not (csDestroying in FDatALink.DataSource.ComponentState) then
      FDataLink.DataSource.RemoveFreeNotification(Self);
  {$endif}
  if not (FDataLink.DataSourceFixed and (csLoading in ComponentState)) then
    FDataLink.DataSource := Value;
  if Value <> nil then Value.FreeNotification(Self);
end;

procedure TElDBCurrencyEdit.SetReadOnly(Value: Boolean);
begin
  FDataLink.ReadOnly := Value;
  inherited ReadOnly := FDataLink.ReadOnly;
end;

{$ifdef VCL_4_USED}
function TElDBCurrencyEdit.UpdateAction(Action: TBasicAction): Boolean;
begin
  Result := inherited UpdateAction(Action) or (FDataLink <> nil) and
    FDataLink.UpdateAction(Action);
end;
{$endif}

procedure TElDBCurrencyEdit.UpdateData(Sender: TObject);
  var NewValue:Currency;
begin
  if FDataLink.Field.AsCurrency <> Value then
  begin
    NewValue := Value;
    FDataLink.Edit; // <- call DataChange ...
    FDataLink.Field.AsCurrency := NewValue;
  end
  else
    FDataLink.Edit;
end;

{$ifdef VCL_4_USED}
function TElDBCurrencyEdit.UseRightToLeftAlignment: Boolean;
begin
  Result := DBUseRightToLeftAlignment(Self, Field);
end;
{$endif}

procedure TElDBCurrencyEdit.EditingChange(Sender: TObject);
begin
  inherited ReadOnly := not FDataLink.Editing;
end;

end.
