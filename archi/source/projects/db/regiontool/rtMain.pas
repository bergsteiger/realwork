unit rtMain;

{ $Id: rtMain.pas,v 1.8 2016/07/13 13:14:25 lukyanets Exp $}

// $Log: rtMain.pas,v $
// Revision 1.8  2016/07/13 13:14:25  lukyanets
// Пересаживаем UserManager на новые рельсы
//
// Revision 1.7  2015/04/30 11:14:39  lukyanets
// Заготовки Большого Брата
//
// Revision 1.6  2015/04/02 12:46:24  lukyanets
// Изолируем регион
//
// Revision 1.5  2015/03/31 14:08:45  lukyanets
// Начинаем изолировать GlobalHTServer
//
// Revision 1.4  2013/11/07 08:16:22  fireton
// - не собиралось
//
// Revision 1.3  2007/05/07 08:09:41  fireton
// - cBadRegion вынесен в отдельный модуль
//
// Revision 1.2  2007/04/20 14:28:12  fireton
// - регион по умолчанию = "не установлен"
//
// Revision 1.1  2007/04/09 11:31:44  fireton
// - первый коммит
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, XPMan, StdCtrls;

type
  TMainForm = class(TForm)
    dispRegion: TLabel;
    btnRegionChange: TButton;
    XPManifest1: TXPManifest;
    Bevel1: TBevel;
    btnStart: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnRegionChangeClick(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
  private
    procedure CheckRegion;
    procedure DisplayRegion;
    { Private declarations }
  public
    procedure ChangeRegionID;
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation
uses
 rtRegionIDDlg,
 rtGrinder,

 l3IniFile,
 l3FileUtils,

 daDataProvider,
 daInterfaces,

 Dt_Types,
 Dt_Serv;

{$R *.dfm}

procedure TMainForm.ChangeRegionID;
var
 l_Dlg         : TRegionIDDlg;
 l_BaseIniPath : string;
 l_BaseIni     : TCfgList;
begin
 l_Dlg := TRegionIDDlg.Create(Self);
 try
  l_Dlg.RegionID := GlobalDataProvider.RegionID;
  if l_Dlg.ShowModal = mrOK then
  begin
   l_BaseIniPath := ConcatDirName(GlobalHTServer.CurTblPath, 'base.ini');
   if not FileExists(l_BaseIniPath) then
    raise Exception.Create('Не найден файл ' + l_BaseIniPath);

   l_BaseIni := TCfgList.Create(l_BaseIniPath);
   try
    l_BaseIni.Section:= 'Tables';
    l_BaseIni.WriteParamInt('Region', l_Dlg.RegionID);
   finally
    l_BaseIni.Free;
   end;
   GlobalDataProvider.InitRegionFromIni(cBadRegion);
   DisplayRegion;
  end;
 finally
  l_Dlg.Free;
 end;
end;

procedure TMainForm.CheckRegion;
begin
 GlobalDataProvider.InitRegionFromIni(cBadRegion);
 if GlobalDataProvider.RegionID = cBadRegion then
  ChangeRegionID;
 DisplayRegion; 
end;

procedure TMainForm.DisplayRegion;
begin
 if GlobalDataProvider.RegionID = cBadRegion then
  dispRegion.Caption := '<регион не установлен>'
 else
  dispRegion.Caption := 'Ваш регион: '+GlobalDataProvider.GetRegionName(GlobalDataProvider.RegionID);
 btnStart.Enabled := GlobalDataProvider.RegionID <> cBadRegion;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
 CheckRegion;
end;

procedure TMainForm.btnRegionChangeClick(Sender: TObject);
begin
 ChangeRegionID;
end;

procedure TMainForm.btnStartClick(Sender: TObject);
var
 l_Grinder: TGrinder;
begin
 l_Grinder := TGrinder.Create;
 try
  l_Grinder.Grind;
  MessageDlg('Преобразование UserID в базе завершено.', mtInformation, [mbYes], 0);
 finally
  l_Grinder.Free;
 end;
end;

end.
