unit ciMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, l3InterfacedComponent, vtDirector, StdCtrls, Mask, ToolEdit,
  XPMan, imageenio;

type
  TForm1 = class(TForm)
    DirIterator: TvtDirNavigator;
    XPManifest1: TXPManifest;
    deInitDir: TDirectoryEdit;
    cbSubDir: TCheckBox;
    Label1: TLabel;
    btnStart: TButton;
    dispLabel1: TLabel;
    dispLabel2: TLabel;
    btnExit: TButton;
    procedure btnExitClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DirIteratorFound(Sender: TObject);
  private
    f_BadImages: Integer;
    f_TotalChecked: Integer;
    f_IO: TImageEnIO;
    procedure StartScan;
    procedure StopScan;
    { Private declarations }
  public
    procedure Execute;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses
 hyieutils,

 l3Base,
 l3IniFile;

{$R *.dfm}

procedure TForm1.StartScan;
begin
 deInitDir.Enabled := False;
 cbSubDir.Enabled := False;
 btnStart.Enabled := False;
 btnExit.Enabled := False;
 dispLabel1.Visible := True;
 dispLabel2.Visible := True;
 dispLabel1.Caption := '';
 dispLabel2.Caption := '';
 l3System.Str2Log(' ');
 l3System.Msg2Log('Начало обработки. Директория %s', [deInitDir.Text]);
 f_TotalChecked := 0;
 f_BadImages := 0;
end;

procedure TForm1.btnExitClick(Sender: TObject);
begin
 Close;
end;

procedure TForm1.StopScan;
var
 l_S: string;
begin
 deInitDir.Enabled := True;
 cbSubDir.Enabled := True;
 btnStart.Enabled := True;
 btnExit.Enabled := True;
 l_S := Format('Обработка завершена. Найдено битых образов: %d (из %d проверенных)', [f_BadImages, f_TotalChecked]);
 l3System.Msg2Log(l_S);
 dispLabel1.Caption := 'Обработка завершена';
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
 Execute;
end;

procedure TForm1.Execute;
begin
 if DirectoryExists(deInitDir.Text) then
 begin
  StartScan;
  try
   DirIterator.InitialDir := deInitDir.Text;
   if cbSubDir.Checked then
    DirIterator.ExploreDirAttr := DirIterator.ExploreDirAttr + [foSubDir]
   else
    DirIterator.ExploreDirAttr := DirIterator.ExploreDirAttr - [foSubDir];
   f_IO := TImageEnIO.Create(nil);
   try
    DirIterator.Execute;
   finally
    l3Free(f_IO);
   end;
  finally
   StopScan;
  end;
 end
 else
  MessageDlg('Указана некорректная директория', mtError, [mbOK], 0);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Settings';
  l_Ini.WriteParamStr('InitialDir', deInitDir.Text);
  l_ini.WriteParamBool('ScanSubdirs', cbSubDir.Checked);
 finally
  l3Free(l_Ini);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Settings';
  deInitDir.Text := l_Ini.ReadParamStrDef('InitialDir', 'C:\');
  cbSubDir.Checked := l_ini.ReadParamBoolDef('ScanSubdirs', True);
 finally
  l3Free(l_Ini);
 end;
end;

procedure TForm1.DirIteratorFound(Sender: TObject);
var
 I, N: Integer;
begin
 try
  Inc(f_TotalChecked);
  dispLabel1.Caption := DirIterator.FoundFileName;
  dispLabel1.Update;
  f_IO.LoadFromFileTIFF(DirIterator.FoundFileName);
  N := f_IO.Params.TIFF_ImageCount;
  for I := 1 to N-1 do
  begin
   f_IO.Params.TIFF_ImageIndex := I;
   f_IO.LoadFromFileTIFF(DirIterator.FoundFileName);
  end;
 except
  on EieImageReadError do
  begin
   Inc(f_BadImages);
   l3System.Msg2Log('Испорчен: %s', [DirIterator.FoundFileName]);
  end
  else
   raise;
 end;
 dispLabel2.Caption := Format('Проверено: %d    Испорченых: %d', [f_TotalChecked, f_BadImages]);
 Update;
end;

end.
