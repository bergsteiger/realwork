{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit CDSEdit;

interface

uses SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, DB, DBClient, DesignIntf;

type

  TClientDataForm = class(TForm)
    GroupBox1: TGroupBox;
    DataSetList: TListBox;
    OkBtn: TButton;
    CancelBtn: TButton;
    HelpBtn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure OkBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
    procedure DataSetListDblClick(Sender: TObject);
    procedure DataSetListKeyPress(Sender: TObject; var Key: Char);
  private
    FDataSet: TCustomClientDataSet;
    FDesigner: IDesigner;
    procedure CheckComponent(const Value: string);
    function Edit: Boolean;
  end;

function EditClientDataSet(ADataSet: TCustomClientDataSet; ADesigner: IDesigner): Boolean;

function LoadFromFile(ADataSet: TCustomClientDataSet): Boolean;
function GetLoadFromFileName: string;
procedure SaveToFile(ADataSet: TCustomClientDataSet; Format: TDataPacketFormat = dfBinary);

implementation

uses DsnDBCst, TypInfo, LibHelp, DBConsts, Consts, Provider;

{$R *.dfm}

function EditClientDataSet(ADataSet: TCustomClientDataSet; ADesigner: IDesigner): Boolean;
begin
  with TClientDataForm.Create(Application) do
  try
    Caption := Format(SClientDataSetEditor, [ADataSet.Owner.Name, DotSep, ADataSet.Name]);
    FDataSet := ADataSet;
    FDesigner := ADesigner;
    Result := Edit;
  finally
    Free;
  end;
end;

function GetLoadFromFileName: string;
begin
  with TOpenDialog.Create(nil) do
  try
    Title := sOpenFileTitle;
    DefaultExt := 'xml';
    Filter := SAllClientDataFilter;
    if Execute then
      Result := FileName;
  finally
    Free;
  end;
end;

function LoadFromFile(ADataSet: TCustomClientDataSet): Boolean;
var
  FileName: string;
begin
  FileName := GetLoadFromFileName;
  Result := FileName <> '';
  if Result then
    ADataSet.LoadFromFile(FileName);
end;

procedure SaveToFile(ADataSet: TCustomClientDataSet; Format: TDataPacketFormat = dfBinary);
begin
  with TSaveDialog.Create(nil) do
  try
    Options := Options + [ofOverwritePrompt];
    if Format = dfBinary then
    begin
      DefaultExt := 'cds';
      Filter := SClientDataFilter;
    end else
    begin
      DefaultExt := 'xml';
      Filter := SXMLClientDataFilter;
    end;
    if Execute then ADataSet.SaveToFile(FileName, Format);
  finally
    Free;
  end;
end;

procedure TClientDataForm.CheckComponent(const Value: string);
var
  DataSet: TDataSet;
begin
  DataSet := TDataSet(FDesigner.GetComponent(Value));
  if (DataSet.Owner <> FDataSet.Owner) then
    DataSetList.Items.Add(Concat(DataSet.Owner.Name, '.', DataSet.Name))
  else
    if AnsiCompareText(DataSet.Name, FDataSet.Name) <> 0 then
      DataSetList.Items.Add(DataSet.Name);
end;

function TClientDataForm.Edit: Boolean;
begin
  DataSetList.Clear;
  FDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);
  if DataSetList.Items.Count > 0 then
  begin
    DataSetList.Enabled := True;
    DataSetList.ItemIndex := 0;
    OkBtn.Enabled := True;
    ActiveControl := DataSetList;
  end else
    ActiveControl := CancelBtn;
  Result := ShowModal = mrOK;
end;

procedure TClientDataForm.OkBtnClick(Sender: TObject);
var
  DataSet: TDataSet;
  DSProv: TDataSetProvider;
begin
  try
    if DataSetList.ItemIndex >= 0 then
    begin
      Screen.Cursor := crHourGlass;
      try
        with DataSetList do
          DataSet := FDesigner.GetComponent(Items[ItemIndex]) as TDataSet;
        if (DataSet is TCustomClientDataSet) then
          FDataSet.Data := TCustomClientDataSet(DataSet).Data
        else
        begin
          DSProv := TDataSetProvider.Create(nil);
          try
            DSProv.DataSet := DataSet;
            FDataSet.Data := DSProv.Data
          finally
            DSProv.Free;
          end;
        end;
      finally
        Screen.Cursor := crDefault;
      end;
    end
    else
      FDataSet.Data := varNull;
  except
    ModalResult := mrNone;
    raise;
  end;
end;

procedure TClientDataForm.FormCreate(Sender: TObject);
begin
  HelpContext := hcDAssignClientData;
end;

procedure TClientDataForm.HelpBtnClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TClientDataForm.DataSetListDblClick(Sender: TObject);
begin
  if OkBtn.Enabled then OkBtn.Click;
end;

procedure TClientDataForm.DataSetListKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) and OkBtn.Enabled then OkBtn.Click;
end;

end.
