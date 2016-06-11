{*******************************************************}
{                                                       }
{               Delphi DataSnap Framework               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit DSAzureTableRowDialog;

interface

uses
  Vcl.Buttons, System.Classes, Vcl.Controls, DSAzureTableDialog, Vcl.ExtCtrls, Vcl.Forms, Vcl.Graphics,
  Vcl.StdCtrls;

type
  /// <summary>
  ///   Dialog for modifying a single cell of a single row in an Azure table. The table column passed
  ///   in contains the name of the column, the value for the column and its data type. If the column info
  ///   passed in is nil then this dialog assumes a new one is being created.
  /// </summary>
  TTAzureTableRowDialog = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    nameField: TEdit;
    valueField: TEdit;
    datatypeCombo: TComboBox;
    nameLabel: TLabel;
    valueLabel: TLabel;
    datatypeLabel: TLabel;
    errorLabel: TLabel;
    procedure datatypeComboChange(Sender: TObject);
    procedure valueFieldChange(Sender: TObject);
    procedure nameFieldChange(Sender: TObject);
  private
    FColumnInfo: TAzureTableColumn;
    FRow: TAzureTableRow;

    function IsAlphaNumeric(const Value: String; CantStartWithNumber: Boolean = False): Boolean;
    function IsValidNameFormat: Boolean;

    procedure UpdateOKButtonEnablement;

    function GetName: String;
    function GetValue: String;
    function GetColumnDataType: TPropertyDataType;
  public
    /// <summary> Constructor which takes in an optional column and a required row. If the column given
    ///    is nil then a new one will be created when calling 'PersistChanges'.
    /// </summary>
    constructor Create(AOwner: TComponent; ColumnInfo: TAzureTableColumn; Row: TAzureTableRow); reintroduce;

    /// <summary> Returns the given instance (or a new instance if none was provided) of TAzureTableColumn
    ///   which holds the new values specified by this dialog.
    /// </summary>
    function PersistChanges: TAzureTableColumn;

    /// <summary> Returns the name as typed into the name field of the Dialog </summary>
    property Name: String read GetName;
    /// <summary> Returns the value as typed into the value field of the Dialog </summary>
    property Value: String read GetValue;
    /// <summary> Returns the datatype as chosen in the drop-down menu of the Dialog </summary>
    property DataType: TPropertyDataType read GetColumnDataType;
  end;

implementation

{$R *.dfm}

uses Data.DBXClientResStrs, System.SysUtils;

constructor TTAzureTableRowDialog.Create(AOwner: TComponent; ColumnInfo: TAzureTableColumn; Row: TAzureTableRow);
var
  PartiallyEnabled: Boolean;
  BeginIndex: Integer;
  NameEvent: TNotifyEvent;
  ValueEvent: TNotifyEvent;
begin
  inherited Create(AOwner);
  FColumnInfo := ColumnInfo;

  Assert(Row <> nil);

  FRow := Row;

  if ColumnInfo <> nil then
  begin
    BeginIndex :=
      datatypeCombo.Items.IndexOf(Copy(GetDataType(ColumnInfo.DataType), Length(DT_XML_PREFIX) + 1));

    if BeginIndex < 0 then
      BeginIndex := 0;

    datatypeCombo.ItemIndex := BeginIndex;

    NameEvent := nameField.OnChange;
    ValueEvent := valueField.OnChange;

    nameField.OnChange := nil;
    valueField.OnChange := nil;

    nameField.Text := ColumnInfo.Name;
    valueField.Text := ColumnInfo.Value;

    nameField.OnChange := NameEvent;
    valueField.OnChange := ValueEvent;

    PartiallyEnabled := (ColumnInfo.Name = XML_ROWKEY) or (ColumnInfo.Name = XML_PARTITION);

    nameField.Enabled := not PartiallyEnabled;
    datatypeCombo.Enabled := not PartiallyEnabled;
  end
  else
    datatypeCombo.ItemIndex := 0;
end;

function TTAzureTableRowDialog.GetColumnDataType: TPropertyDataType;
begin
  if (datatypeCombo.Text = EmptyStr) then
    Exit(azdtUnknown);

  Result := GetDataType(datatypeCombo.Text);
end;

function TTAzureTableRowDialog.GetName: String;
begin
  Result := Trim(nameField.Text);
end;

function TTAzureTableRowDialog.GetValue: String;
begin
  Result := valueField.Text;
end;

function TTAzureTableRowDialog.IsAlphaNumeric(const Value: String; CantStartWithNumber: Boolean): Boolean;
var
  I: Integer;
  Len: Integer;
  c: Char;
begin
  Result := True;
  Len := Length(Value);
  for I := 1 to Len do
  begin
    c := Value[I];

    //can't start with number
    if CantStartWithNumber and (I = 1) and CharInSet(c, ['0'..'9']) then
      Exit(False);
    
    if not CharInSet(c, ['0'..'9', 'A'..'Z', 'a'..'z', '_']) then
      Exit(False);
  end;
end;

function TTAzureTableRowDialog.IsValidNameFormat: Boolean;
var
  Num: String;
begin
  Result := True;

  Num := Name;

  //Name can't be empty
  if Num = EmptyStr then
    Exit(False)
  //name must be only numbers, letters and '_'... and can't start with a number
  else if not IsAlphaNumeric(Num, True) then
    Exit(False)
end;

procedure TTAzureTableRowDialog.UpdateOKButtonEnablement;
begin
  if (FColumnInfo <> nil) and (Name = FColumnInfo.Name) and
     (Value = FColumnInfo.Value) and
     (DataType = FColumnInfo.DataType) then
  begin
    OKBtn.Enabled := False;
    errorLabel.Caption := EmptyStr;
  end
  else if (AnsiLowerCase(Name) = AnsiLowerCase(XML_TIMESTAMP)) or
          (NameField.Enabled and ((AnsiLowerCase(Name) = AnsiLowerCase(XML_ROWKEY)) or
                                  (AnsiLowerCase(Name) = AnsiLowerCase(XML_PARTITION)))) then
  begin
    OKBtn.Enabled := False;
    errorLabel.Caption := SBadColumnName;
  end
  else if not ValidateValueForDataType(Value, DataType) then
  begin
    OKBtn.Enabled := False;
    errorLabel.Caption := Format(SInvalidDataType, [dataTypeCombo.Text]);
  end
  else if not IsValidNameFormat then
  begin
    OKBtn.Enabled := False;
    if Name = EmptyStr then
      errorLabel.Caption := EmptyStr
    else
      errorLabel.Caption := SInvalidColumnName;
  end
  else
  begin
    //If it is possible the given name may conflict with another column name, verify this
    if (FColumnInfo = nil) or ((FColumnInfo <> nil) and (Name <> FColumnInfo.Name)) then
    begin
      if FRow.GetColumn(Name, True) <> nil then
      begin
        OKBtn.Enabled := False;
        errorLabel.Caption := SColumnNameInUse;
        Exit;
      end;
    end;
    OKBtn.Enabled := True;
    errorLabel.Caption := EmptyStr;
  end;
end;

procedure TTAzureTableRowDialog.nameFieldChange(Sender: TObject);
begin
  UpdateOKButtonEnablement;
end;

function TTAzureTableRowDialog.PersistChanges: TAzureTableColumn;
begin
  if FColumnInfo = nil then
    FColumnInfo := TAzureTableColumn.Create;

  FColumnInfo.Name := Name;
  FColumnInfo.Value := Value;
  FColumnInfo.DataType := DataType;

  Result := FColumnInfo;
end;

procedure TTAzureTableRowDialog.datatypeComboChange(Sender: TObject);
begin

  UpdateOKButtonEnablement;
end;

procedure TTAzureTableRowDialog.valueFieldChange(Sender: TObject);
begin
  UpdateOKButtonEnablement;
end;

end.
