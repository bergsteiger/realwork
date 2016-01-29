unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, dt_Types, dt_AttrSchema, daTypes;

type
  TDictSyncForm = class(TForm)
    btnRun: TButton;
    Label1: TLabel;
    EditEtalonFolder: TEdit;
    btnBrowseForEtalon: TButton;
    Label2: TLabel;
    comboDicts: TComboBox;
    Label3: TLabel;
    editbaseFolder: TEdit;
    btnBrowseBaseFolder: TButton;
    cbCorrectLinks: TCheckBox;
    procedure btnRunClick(Sender: TObject);
    procedure btnBrowseForEtalonClick(Sender: TObject);
    procedure EditEtalonFolderChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure comboDictsChange(Sender: TObject);
    procedure btnBrowseBaseFolderClick(Sender: TObject);
  private
    function pm_GetDictType: TdaDictionaryType;
    { Private declarations }
  public
    property DictType: TdaDictionaryType read pm_GetDictType;
    { Public declarations }
  end;

var
  DictSyncForm: TDictSyncForm;

implementation

Uses
 dt_DictSync, dt_DictImport, dt_DictExport, dt_Const,
 ddHtInit, ddClientBaseEngine,
 FileCtrl, l3IniFile,
 l3FileUtils, l3ShellUtils;

{$R *.dfm}

procedure TDictSyncForm.btnRunClick(Sender: TObject);
begin
 btnRun.Enabled:= False;
 try
  InitStationAndServerConfig;
  if InitBaseEngine(editBaseFolder.Text) then
  try
   with TdtDictSync.Create do
   try
    if Execute(DictType, editEtalonFolder.Text, cbCorrectLinks.Checked) then
     MessageDlg(Format('Словарь "%s" исправлен', [cDLPAssports[DictType].rName]), mtInformation, [mbOk], 0)
    else
     MessageDlg(Format('Не удалось исправить Словарь "%s".'^M'%s', [cDLPAssports[DictType].rName, ErrorMessage]), mtWarning, [mbOk], 0);
   finally
    Free;
   end;
  finally
   DoneClientBaseEngine;
  end
  else
   MessageDlg('Не удалось подключиться к базе данных. Обновление невозможно.', mtError, [mbOk], 0);
 finally
  btnRun.Enabled:= True;
 end;
end;

procedure TDictSyncForm.btnBrowseForEtalonClick(Sender: TObject);
var
 l_Folder: String;
begin
 if SelectDirectory('Укажите папку с эталонными словарями', EditEtalonFolder.Text, l_Folder) then
  editEtalonFolder.Text:= l_Folder;
end;

procedure TDictSyncForm.EditEtalonFolderChange(Sender: TObject);
begin
 btnRun.Enabled:= DirectoryExists(editEtalonFolder.Text);
end;

procedure TDictSyncForm.FormCreate(Sender: TObject);
var
 i: TdaDictionaryType;
begin
 for i:= da_dlSources to High(TdaDictionaryType) do
  comboDicts.Items.Add(cDLPassports[i].rName);
end;

procedure TDictSyncForm.comboDictsChange(Sender: TObject);
var
 l_FileName: String;
begin
 // Нужно проверить наличие соответствующего словаря
 btnRun.Enabled:= False;
 if DictType in [da_dlSources..High(TdaDictionaryType)] then
 begin
  l_FileName:= ConcatDirName(editEtalonFolder.Text, FamTblNames[cDLPassports[DictType].rDict]+IntToHex(1, 3)+'.htb');
  btnRun.Enabled:= FileExists(l_FileName) and DirectoryExists(editBaseFolder.Text);
 end;
end;

function TDictSyncForm.pm_GetDictType: TdaDictionaryType;
begin
 if comboDicts.ItemIndex = -1 then
  Result:= da_dlNone
 else
  Result := TdaDictionaryType(comboDicts.ItemIndex+ord(da_dlSources));
end;

procedure TDictSyncForm.btnBrowseBaseFolderClick(Sender: TObject);
var
 l_Folder: String;
begin
 if SelectDirectory('Укажите папку с базой данных', editBaseFolder.Text, l_Folder) then
  editBaseFolder.Text:= l_Folder;
end;

end.
