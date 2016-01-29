unit MainForm;

{ $Id: MainForm.pas,v 1.1 2004/07/23 13:05:23 step Exp $ }
// $Log: MainForm.pas,v $
// Revision 1.1  2004/07/23 13:05:23  step
// утилита занесена в CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TMain = class(TForm)
    bLoadHLinks: TButton;
    edArchiIni: TEdit;
    edHLinkFile: TEdit;
    FileDialog: TOpenDialog;
    labIniFile: TLabel;
    labDataFile: TLabel;
    bSelectHlinkFile: TButton;
    bSelectArchiIni: TButton;
    labDataFile2: TLabel;
    edDatesFile: TEdit;
    bSelectDatesFile: TButton;
    bLoadDates: TButton;
    procedure bLoadHLinksClick(Sender: TObject);
    procedure bSelectHlinkFileClick(Sender: TObject);
    procedure bSelectArchiIniClick(Sender: TObject);
    procedure bSelectDatesFileClick(Sender: TObject);
    procedure bLoadDatesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.dfm}

uses
 DataLoader, l3FileUtils;

procedure TMain.bLoadHLinksClick(Sender: TObject);
begin
 if not FileExists(edArchiIni.Text) then
  raise Exception.Create(Format('Не найден файл %s', [edArchiIni.Text]));

 if not FileExists(edHLinkFile.Text) then
  raise Exception.Create(Format('Не найден файл %s', [edHLinkFile.Text]));

 with THLinksLoader.Create(edArchiIni.Text) do
  try
   RecalcHLinks(edHLinkFile.Text);
  finally
   Free;
  end;
end;

procedure TMain.bSelectHlinkFileClick(Sender: TObject);
begin
 with FileDialog do
 begin
  InitialDir := Application.ExeName;
  DefaultExt := '*.*';
  FileName := '';
  Filter := 'Все файлы|*.*';
  FilterIndex := 0;
  Title := 'Файл с данными о гиперссылках';
 end;

 if FileDialog.Execute then
 begin
  edHLinkFile.Text := FileDialog.FileName;
 end;
end;

procedure TMain.bSelectArchiIniClick(Sender: TObject);
begin
 with FileDialog do
 begin
  InitialDir := Application.ExeName;
  DefaultExt := '*.ini';
  FileName := 'archi.ini';
  Filter := 'Ini-файлы|*.ini|Все файлы|*.*';
  FilterIndex := 1;
  Title := 'Файл с настройками БД (archi.ini)';
 end;

 if FileDialog.Execute then
 begin
  edArchiIni.Text := FileDialog.FileName;
 end;
end;

procedure TMain.bSelectDatesFileClick(Sender: TObject);
begin
 with FileDialog do
 begin
  InitialDir := Application.ExeName;
  DefaultExt := '*.*';
  FileName := '';
  Filter := 'Все файлы|*.*';
  FilterIndex := 0;
  Title := 'Файл с данными о датах';
 end;

 if FileDialog.Execute then
 begin
  edDatesFile.Text := FileDialog.FileName;
 end;
end;

procedure TMain.bLoadDatesClick(Sender: TObject);
begin
 if not FileExists(edArchiIni.Text) then
  raise Exception.Create(Format('Не найден файл %s', [edArchiIni.Text]));

 if not FileExists(edDatesFile.Text) then
  raise Exception.Create(Format('Не найден файл %s', [edDatesFile.Text]));

 with TDatesLoader.Create(edArchiIni.Text) do
  try
   AddDates(edDatesFile.Text);
  finally
   Free;
  end;
end;

procedure TMain.FormCreate(Sender: TObject);
var
 l_Path: string;
begin
 l_Path := ConcatDirName(ExtractDirName(Application.ExeName), 'archi.ini');
 if FileExists(l_Path) then
  edArchiIni.Text := l_Path;
end;

end.
