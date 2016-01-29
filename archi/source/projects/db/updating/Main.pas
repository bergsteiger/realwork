unit Main;

{ $Id: Main.pas,v 1.24 2015/03/10 07:25:21 fireton Exp $ }
// $Log: Main.pas,v $
// Revision 1.24  2015/03/10 07:25:21  fireton
// - не учитывался ProjectDefine.inc
//
// Revision 1.23  2013/12/24 07:03:05  fireton
// - апдейт должен быть возможен только если версия меньше целевой
//
// Revision 1.22  2012/02/08 07:29:49  fireton
// - исправление нескольких ошибок
//
// Revision 1.21  2011/12/12 14:02:52  fireton
// - DbReformer и DbInfo переехали в DT
//
// Revision 1.20  2011/12/01 14:58:52  fireton
// - доработка реформера
//
// Revision 1.19  2009/04/09 08:36:36  fireton
// - расширение функционала
//
// Revision 1.18  2009/03/05 09:06:23  narry
// - включение-выключение кнопки в зависимости от версии базы
//
// Revision 1.17  2009/02/09 10:54:17  fireton
// - версия базы 131
//
// Revision 1.16  2007/03/12 11:19:12  fireton
// - убрал надпись в заголовке окна про 64 бита
//
// Revision 1.15  2007/03/01 11:07:39  fireton
// - сообщения по поводу когда какую программу использовать
//
// Revision 1.14  2007/02/22 15:00:58  fireton
// - переход на 64 бита в HyTech
//
// Revision 1.13  2005/02/09 17:34:12  step
// Слегка изменен дизайн (по замечаниям Гарри)
//
// Revision 1.12  2005/02/08 16:47:20  step
// добавлен показ номера версии в заголовке
//
// Revision 1.11  2004/10/25 16:08:12  step
// изменена TFormMain.AddToMemo
//
// Revision 1.10  2004/06/21 15:38:48  step
// добавлен выбор archi.ini из текущей директории по умолчанию
//
// Revision 1.9  2004/05/25 15:43:48  step
// убрано указание семейств "по путям"
//
// Revision 1.8  2004/05/07 17:37:47  step
// куча мелких исправлений
//
// Revision 1.7  2004/05/05 16:07:03  step
// переделка TDbInfo
//
// Revision 1.6  2004/04/28 13:45:46  step
// добавлен ручной ввод расположения папок
//
// Revision 1.5  2004/04/01 08:19:40  step
// new: procedure ApplyJournalActions - добавление журнала
// new: function DeleteLinkDictDuplicates - удаление дубликатов типа LNK_DICT
// new: function DeleteBadLinkToDict - удаление "висячих" линков
//
// Revision 1.4  2004/03/05 09:08:50  step
// мелкие исправления
//
// Revision 1.3  2004/03/04 18:03:10  step
// исправлен алгоритм сохранения-восстановления
//
// Revision 1.2  2004/03/02 15:47:00  step
// куча мелких изменений
//
// Revision 1.1  2004/03/01 19:04:54  step
// Занесен в CVS
//

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,
  HT_Const, HT_Dll, Mask, ToolEdit, ComCtrls, DT_DbInfo, XPMan;

{$I ProjectDefine.inc}

type
  TFormMain = class(TForm)
   pTop: TPanel;
   bDoUpdate: TButton;
   mLog: TMemo;
   labDbInfo: TLabel;
   mDbInfo: TMemo;
    labIniFile: TLabel;
    labUpdateInfo: TLabel;
    Bevel1: TBevel;
    edtBaseDir: TDirectoryEdit;
    XPManifest1: TXPManifest;
   procedure bDoUpdateClick(Sender: TObject);
   procedure FormCreate(Sender: TObject);
   procedure AddToMemo(const aStr: string);
   procedure FormDestroy(Sender: TObject);
    procedure edtBaseDirAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
  private
   f_DbInfo: TDbInfo;
   procedure InitPaths(aPath: string);
  public
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses
 l3Base,
 l3IniFile,
 l3FileUtils,
 UpdateManager,
 DT_DbReformer;

{$IFNDEF HT_MODE64}
const
 cWarnMessage = 'ВНИМАНИЕ!'#10#13'Эта программа обновляет базы до версий 113 для MAIN и 114 для GARANT.'+
            ' Для того, чтобы обновить базы до более высокой версии, используйте программу DbUpdate64.';
{$ENDIF}            

procedure TFormMain.AddToMemo(const aStr: string);
begin
 if aStr <> '' then
  mLog.Lines.Add(aStr);
 Application.ProcessMessages;
end;

procedure TFormMain.bDoUpdateClick(Sender: TObject);
var
 l_SavedCursor: TCursor;
begin
 mLog.Clear;
 l_SavedCursor := Screen.Cursor;
 Screen.Cursor := crHourGlass;
 bDoUpdate.Enabled := False;
 try
  with TUpdateManager.Create(f_DbInfo, AddToMemo) do
   try
    Execute;
   finally
    Free;
   end;
 finally
  {$IFNDEF HT_MODE64}
  AddToMemo(cWarnMessage);
  {$ENDIF}
  bDoUpdate.Enabled := True;
  Screen.Cursor := l_SavedCursor;
 end;
 
 // заполнение сведений о БД
 mDbInfo.Text := f_DbInfo.Data;
 // вкл-выкл контролов
 bDoUpdate.Enabled := (f_DbInfo.MainFolderVersion < TUpdateManager.MaxMainVersion) or
                       (f_DbInfo.FamilyFolderVersion < TUpdateManager.MaxGarantVersion);

end;

procedure TFormMain.FormCreate(Sender: TObject);
var
 l_Ini: TCfgList;
 l_Path: string;
begin
 l_Ini := TCfgList.Create;
 try
  l_Ini.Section := 'Configuration';
  l_Path := l_Ini.ReadParamStrDef('BasePath', '');
  edtBaseDir.Text := l_Path;
  InitPaths(l_Path);
 finally
  l3Free(l_Ini);
 end;

 labUpdateInfo.Caption := SysUtils.Format('Программа выполняет обновление'#13#10 +
                                          'базы документов до версии %d и'#13#10 +
                                          'административной базы до версии %d',
                                          [TUpdateManager.MaxGarantVersion,
                                           TUpdateManager.MaxMainVersion]);
end;

procedure TFormMain.InitPaths(aPath: string);

var
 l_Ini: TCfgList;
begin
 if aPath = '' then
  Exit;
 try
  if Assigned(f_DbInfo) then
   FreeAndNil(f_DbInfo);
  f_DbInfo := TDbInfo.Make(aPath);
 
  // заполнение сведений о БД
  mDbInfo.Text := f_DbInfo.Data;
 
  mLog.Clear;
 
  {$IFDEF HT_MODE64}
  if (f_DbInfo.MainFolderVersion < 113) or (f_DbInfo.FamilyFolderVersion < 114) then
  begin
   AddToMemo('Программа DbUpdate64 обновляет базы, начиная с версий 113 для MAIN и 114 для GARANT.'+
             ' Обновите базы до указанных значений c помощью программы DbUpdate, а затем снова запустите эту.');
   bDoUpdate.Enabled := False;
  end;
  {$ELSE}
  if (f_DbInfo.MainFolderVersion >= 113) and (f_DbInfo.FamilyFolderVersion >= 114) then
  begin
   AddToMemo(cWarnMessage);
   bDoUpdate.Enabled := False;
  end;
  {$ENDIF}

  // вкл-выкл контролов
  bDoUpdate.Enabled := (f_DbInfo.MainFolderVersion < TUpdateManager.MaxMainVersion) or
                       (f_DbInfo.FamilyFolderVersion < TUpdateManager.MaxGarantVersion);

  l_Ini := TCfgList.Create;
  try
   l_Ini.Section := 'Configuration';
   l_Ini.WriteParamStr('BasePath', aPath);
  finally
   l3Free(l_Ini);
  end;

 except
  on E: EDBInfoError do
   MessageDlg(E.Message, mtError, [mbOK], 0);
 end;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
 l3Free(f_DbInfo);
end;

procedure TFormMain.edtBaseDirAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
 if Action then
  InitPaths(Name);
end;

end.

