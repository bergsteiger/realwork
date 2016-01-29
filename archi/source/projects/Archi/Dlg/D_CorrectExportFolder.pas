unit D_CorrectExportFolder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RBtnDlg, StdCtrls, Buttons, ExtCtrls, vtCtrls, vtRadioButton,
  vtLabel;

type
  TTCorrectExportFolder = class(TRBtnDlg)
    btnSelectDir: TSpeedButton;
    vtLabel1: TvtLabel;
    rbChangeFolder: TvtRadioButton;
    rbCancel: TvtRadioButton;
    edtFolder: TVEdit;
    procedure btnSelectDirClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure rbCancelClick(Sender: TObject);
  private
    { Private declarations }
    procedure CheckPathWritable(const aPath: AnsiString);
  public
    { Public declarations }
    function Execute(var theFolder: AnsiString): Boolean;
  end;

var
  TCorrectExportFolder: TTCorrectExportFolder;

implementation

{$R *.dfm}

uses
 D_SelectDir, l3FileUtils, l3IniFile;

{ TTCorrectExportFolder }

function TTCorrectExportFolder.Execute(var theFolder: AnsiString): Boolean;
var
 l_History: TStringList;
 l_Index: Integer;
begin
  edtFolder.Text := theFolder;
  Result := (ShowModal = mrOk) and rbChangeFolder.Checked;
  if Result then
  begin
   theFolder := Trim(edtFolder.Text);
   l_History := TStringList.Create;
   try
    UserConfig.Section := 'ExportPathHistory';
    UserConfig.ReadParamList('PathHistory', l_History, 10);
    l_Index := l_History.IndexOf(theFolder);
    if l_Index = -1 then
     l_History.Insert(0, theFolder)
    else
     l_History.Move(l_Index, 0);
    UserConfig.Section := 'Export';
    UserConfig.WriteParamStr  ('ExpDir', theFolder);
    UserConfig.Section := 'ExportPathHistory';
    UserConfig.WriteParamList('PathHistory', l_History, 10);
   finally
    FreeAndNil(l_History);
   end;
  end;
end;

procedure TTCorrectExportFolder.btnSelectDirClick(Sender: TObject);
var
 l_Dlg: TarDirSelectDlg;
begin
 l_Dlg := TarDirSelectDlg.Create(Self);
 try
  l_Dlg.Path := Trim(edtFolder.Text);
  if l_Dlg.ShowModal = mrOK then
   edtFolder.Text := l_Dlg.Path;
 finally
  FreeAndNil(l_Dlg);
 end;
end;

procedure TTCorrectExportFolder.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if ModalResult = mrOk then
   try
    CheckPathWritable(Trim(edtFolder.Text));
   except
    ModalResult := mrNone;
    edtFolder.SetFocus;
    CanClose := False;
    raise;
   end;
end;

procedure TTCorrectExportFolder.CheckPathWritable(const aPath: AnsiString);
begin
 if not l3CheckPathWritable(aPath) then
  raise Exception.Create('Невозможно запсать в указанную папку');
end;

procedure TTCorrectExportFolder.rbCancelClick(Sender: TObject);
begin
  inherited;
  edtFolder.Enabled := rbChangeFolder.Checked;
  btnSelectDir.Enabled := edtFolder.Enabled;
end;

end.
