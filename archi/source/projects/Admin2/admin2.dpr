program admin2;

{ $Id: admin2.dpr,v 1.22 2015/04/03 11:30:19 lukyanets Exp $}

// $Log: admin2.dpr,v $
// Revision 1.22  2015/04/03 11:30:19  lukyanets
// Изолируем HT
//
// Revision 1.21  2014/09/12 15:29:37  lulin
// - прописываем пути.
//
// Revision 1.20  2013/11/12 04:33:37  fireton
// - переводим сборку на ProjectDefine
// - делаем версию базы настройкой в инклюдах
//
// Revision 1.19  2011/07/28 08:30:12  fireton
// - включаем version info отдельным ресурсом
//
// Revision 1.18  2011/07/27 10:48:48  fireton
// - version info в ночных сборках
//
// Revision 1.17  2010/02/17 13:09:35  fireton
// - фильтрация импорта/экспорта пользователей по региону
//
// Revision 1.16  2008/04/04 15:18:19  fireton
// - внешние номера документов из диапазона
//
// Revision 1.15  2007/05/07 08:11:03  fireton
// - корректное завершение работы, если пользователь отказался входить
//
// Revision 1.14  2007/04/20 14:27:20  fireton
// - bugfix: некорректная обработка исключений при инициализации базы
//
// Revision 1.13  2007/03/13 09:09:08  fireton
// - не-админ теперь не сможет пользоваться программой
// - мелкие правки
// - чистка кода
//
// Revision 1.12  2007/02/19 15:19:40  fireton
// - "admin" flag теперь экспортируется и импортируется
// - немного улучшена обработка ошибок
// - окошко "О программе" с номером версии
//
// Revision 1.11  2006/02/14 11:30:06  fireton
// - нормальная иконка и название приложения
//
// Revision 1.10  2006/02/14 11:20:44  fireton
// - реализация Большого Брата
//
// Revision 1.9  2006/02/01 16:08:23  fireton
// - запись в файл и печать
//
// Revision 1.8  2005/08/29 15:03:48  fireton
// - промежуточный коммит (профили группы)
//
// Revision 1.6  2005/08/22 13:12:59  fireton
// - промежуточный коммит (реализация визуальной части - bug fix и группы пользователей)
//
// Revision 1.5  2005/08/20 11:01:53  fireton
// - промежуточный коммит (реализация визуальной части и подгонка под сборки)
//
// Revision 1.4  2005/08/17 14:10:58  fireton
// - промежуточный коммит (подгонка под систему сборок)
//
// Revision 1.3  2005/08/02 15:14:20  fireton
// - реализация бизнес-объектов
//
// Revision 1.2  2005/07/29 16:52:10  fireton
// no message
//
// Revision 1.1  2005/07/28 13:54:24  fireton
// - первый коммит
//

{$I ProjectDefine.inc}

uses
  Windows,
  Classes,
  SysUtils,
  Dialogs,
  Forms,
  l3ExceptionsLog,
  l3Base,
  afwFacade,
  afwConsts,
  afwApplication,
  vcmBase,
  vcmHistory,
  evdSchema,
  daDataProvider,
  a2Security in 'a2Security.pas',
  stdRes in 'stdRes.pas' {dmStdRes: TDataModule},
  Main in 'Main.pas' {MainForm: TvcmMainForm},
  cfHoriz in 'cfHoriz.pas' {cfHorizontal: TvcmContainerForm},
  cfVert in 'cfVert.pas' {cfVertical: TvcmContainerForm},
  cfProperties in 'cfProperties.pas' {cfProps: TvcmContainerForm},
  a2Interfaces in 'a2Interfaces.pas',
  a2UserGroupTree in 'a2UserGroupTree.pas' {enUserTree: TvcmEntityForm},
  a2bUserGroupTree in 'a2bUserGroupTree.pas',
  a2bUserProfile in 'a2bUserProfile.pas',
  a2bBase in 'a2bBase.pas',
  a2Base in 'a2Base.pas',
  a2bGroupProfile in 'a2bGroupProfile.pas',
  enNoEdit in 'enNoEdit.pas' {enNoEditForm: TvcmEntityForm},
  modAdministration in 'modAdministration.pas' {moAdmin: TvcmModule},
  fsAdministration in 'fsAdministration.pas' {fsAdmin: TvcmFormSetFactory},
  a2sdsAdmin in 'a2sdsAdmin.pas',
  enUserProperties in 'enUserProperties.pas' {enUserPropertiesForm: TvcmEntityForm},
  a2dsProperties in 'a2dsProperties.pas',
  a2ChangePasswordDlg in 'a2ChangePasswordDlg.pas' {ChangePasswordDlg},
  enMarkedListView in 'enMarkedListView.pas' {enMarkedListForm: TvcmEntityForm},
  a2dsGroupRights in 'a2dsGroupRights.pas',
  enGroupProperties in 'enGroupProperties.pas' {enUserGroupPropetriesForm: TvcmEntityForm},
  enRightsGroups in 'enRightsGroups.pas' {enGroupRightsForm: TvcmEntityForm},
  enRightsValues in 'enRightsValues.pas' {enRigthsValuesForm: TvcmEntityForm},
  enBigBrother in 'enBigBrother.pas' {enBigBrotherForm: TvcmEntityForm},
  a2dsBigBrother in 'a2dsBigBrother.pas',
  a2AboutBox in 'a2AboutBox.pas' {AboutBox},
  a2DocIDRangeEditor in 'a2DocIDRangeEditor.pas' {DocIDRangeEditor: TvcmEntityForm},
  a2RangeEditDlg in 'a2RangeEditDlg.pas' {RangeEditDlg},
  a2InExUserDlg in 'a2InExUserDlg.pas' {RegionChooseDlg},
  
  JwaWinBase in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in 'W:\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in 'W:\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas'
  ;

{$R *.res}
{$R versioninfo.res} // включаем Version Info

begin
  Application.Title := '"Архивариус". Администратор системы';
  Application.CreateForm(TdmStdRes, dmStdRes);
  Application.Initialize;
  try
   if not GlobalInit then
    Exit;
  except
   // Мы еще не в Application.Run, поэтому об исключениях надо позаботиться самим
   Application.HandleException(nil);
   Exit;
  end;

  if GlobalDataProvider.AdminRights then
  begin
   Application.CreateForm(TMainForm, MainForm);
   Application.Run;
  end
  else
   MessageDlg('У вас нет административных прав', mtError, [mbOK], 0);
end.
