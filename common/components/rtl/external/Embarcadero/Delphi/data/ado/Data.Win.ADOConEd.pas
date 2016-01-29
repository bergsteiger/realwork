{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

unit Data.Win.ADOConEd;

{$R-}

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls,
  Data.DB, Data.Win.ADODB;

type
  TConnEditForm = class(TForm)
    OkButton: TButton;
    CancelButton: TButton;
    HelpButton: TButton;
    SourceofConnection: TGroupBox;
    UseDataLinkFile: TRadioButton;
    UseConnectionString: TRadioButton;
    DataLinkFile: TComboBox;
    Browse: TButton;
    ConnectionString: TEdit;
    Build: TButton;
    procedure FormCreate(Sender: TObject);
    procedure HelpButtonClick(Sender: TObject);
    procedure BuildClick(Sender: TObject);
    procedure BrowseClick(Sender: TObject);
    procedure SourceButtonClick(Sender: TObject);
  public
    function Edit(ConnStr: WideString): WideString;
  end;

function EditConnectionString(Component: TComponent): Boolean;

implementation

{$R *.dfm}

uses 
  Winapi.OleDB, Winapi.ADOInt, Winapi.ActiveX, System.TypInfo, System.Win.ComObj;

const
  SConnectionString = 'ConnectionString';     { Do not localize }
  
resourcestring
  SEditConnectionStringTitle = '%s%s%s %s';

function EditConnectionString(Component: TComponent): Boolean;
var
  PropInfo: PPropInfo;
  NewConnStr, InitialConnStr: WideString;
  LForm: TConnEditForm;
begin
  Result := False;
  LForm := TConnEditForm.Create(Application);
  try
    LForm.Caption := Format(SEditConnectionStringTitle, [Component.Owner.Name, DotSep,
    Component.Name, SConnectionString]);
    PropInfo := GetPropInfo(Component.ClassInfo, SConnectionString);
    InitialConnStr := GetStrProp(Component, PropInfo);
    NewConnStr := LForm.Edit(InitialConnStr);
    if NewConnStr <> InitialConnStr then
    begin
      SetStrProp(Component, PropInfo, NewConnStr);
      Result := True;
    end;
  finally
    LForm.Free;
  end;
end;

{ TConnEditForm }

function TConnEditForm.Edit(ConnStr: WideString): WideString;
var
  FileName: string;
begin
  Result := ConnStr;
  UseDataLinkFile.Checked := True;
  if Pos(WideString(CT_FILENAME), ConnStr) = 1 then
  begin
    FileName := Copy(ConnStr, Length(CT_FILENAME)+1, MAX_PATH);
    if ExtractFilePath(FileName) = (DataLinkDir + '\') then
      DataLinkFile.Text := ExtractFileName(FileName) else
      DataLinkFile.Text := FileName;
  end else
  begin
    ConnectionString.Text := ConnStr;
    UseConnectionString.Checked := True;
  end;
  SourceButtonClick(nil);
  if ShowModal = mrOk then
    if UseConnectionString.Checked then
      Result := ConnectionString.Text
    else if DataLinkFile.Text <> '' then
    begin
      if ExtractFilePath(DataLinkFile.Text) = '' then
        Result := CT_FILENAME + DataLinkDir + '\' +DataLinkFile.Text else
        Result := CT_FILENAME + DataLinkFile.Text
    end
    else
      Result := '';
end;

{ Event Handlers }

procedure TConnEditForm.FormCreate(Sender: TObject);
begin
  HelpContext := 27270; //hcDADOConnEdit;
  GetDataLinkFiles(DataLinkFile.Items);
end;

procedure TConnEditForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TConnEditForm.BrowseClick(Sender: TObject);
begin
  DataLinkFile.Text := PromptDataLinkFile(Handle, DataLinkFile.Text);
end;

procedure TConnEditForm.BuildClick(Sender: TObject);
begin
  ConnectionString.Text := PromptDataSource(Handle, ConnectionString.Text);
end;

procedure TConnEditForm.SourceButtonClick(Sender: TObject);
const
  EnabledColor: array[Boolean] of TColor = (clBtnFace, clWindow);
begin
  DataLinkFile.Enabled := UseDataLinkFile.Checked;
  DataLinkFile.Color := EnabledColor[DataLinkFile.Enabled];
  Browse.Enabled := DataLinkFile.Enabled;
  ConnectionString.Enabled := UseConnectionString.Checked;
  ConnectionString.Color := EnabledColor[ConnectionString.Enabled];
  Build.Enabled := ConnectionString.Enabled;
  if DataLinkFile.Enabled then
    ActiveControl := DataLinkFile else
    ActiveControl := ConnectionString;
end;

end.
