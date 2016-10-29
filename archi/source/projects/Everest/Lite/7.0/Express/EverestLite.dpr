program EverestLite;

{ $Id: EverestLite.dpr,v 1.22 2016/10/21 11:12:52 dinishev Exp $ }

// $Log: EverestLite.dpr,v $
// Revision 1.22  2016/10/21 11:12:52  dinishev
// Восстановил Speller у Эвереста.
//
// Revision 1.21  2015/04/06 07:47:15  dinishev
// Перегенерация. Правки за Мишей Костициным.
//
// Revision 1.20  2014/09/12 15:28:27  lulin
// - прописываем пути.
//
// Revision 1.19  2014/02/21 13:10:08  dinishev
// "Скрытый" Preview в Арчи.
//
// Revision 1.18  2014/01/28 15:38:41  dinishev
// {Requestlink:514874360}
//
// Revision 1.17  2013/05/31 06:31:25  lulin
// - портируем под XE4.
//
// Revision 1.16  2013/03/18 09:02:28  dinishev
// {Requestlink:437519030}. Тесты.
//
// Revision 1.15  2013/02/27 11:15:30  dinishev
// {Requestlink:431386215}
//
// Revision 1.14  2012/07/19 07:45:59  dinishev
// Bug fix: AV во время поиска.
//
// Revision 1.13  2011/07/28 08:30:15  fireton
// - включаем version info отдельным ресурсом
//
// Revision 1.12  2011/07/27 12:07:57  fireton
// - убираем version info из .res файлов проектов
//
// Revision 1.11  2010/02/18 08:02:06  dinishev
// Не компилировался редактор в ветке.
//
// Revision 1.10  2009/03/05 12:20:24  lulin
// - <K>: 137470629. Удаляем устаревший модуль.
//
// Revision 1.9  2009/03/04 14:17:46  lulin
// - <K>: 137470629. Генерируем идентификаторы типов с модели и убираем их из общей помойки.
//
// Revision 1.8  2008/03/12 14:46:24  dinishev
// Делаем общими диалоги для Арчи и Эвереста
//
// Revision 1.7  2007/12/05 13:51:27  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.5.2.1  2006/02/07 15:15:58  lulin
// - попытка доточить под ветку (пока неудачно).
//
// Revision 1.5  2005/04/18 18:15:30  lulin
// - bug fix: не компилировалось.
//
// Revision 1.4  2005/02/18 12:59:41  lulin
// - промежуточный коммит.
//
// Revision 1.3  2004/07/13 09:22:19  fireton
// - add: прикрутка автозамены в Эверест
//
// Revision 1.2  2003/07/29 08:17:59  law
// no message
//
// Revision 1.1  2002/11/22 14:18:44  law
// - rename project: EverestLiteExpress -> EverestLite.
//

{$Include Everest.inc}

uses
  Forms,
  k2Interfaces,
  k2Tags,
  k2Facade,
  k2Base,
  evdSchema,
  evExtActionsRes,
  evExtActions,
  evExtFormat,
  BitmapPara_Const,
  afwApplication,
  arSpeller in 'w:\archi\source\projects\Archi\arSpeller.pas',
  Edwin in 'Main\EDWIN.PAS' {EditorWindow},
  D_mdilst in '..\..\..\DLG\D_MDILST.PAS' {MDIListDlg},
  D_repcon in '..\..\..\DLG\D_REPCON.PAS' {ReplaceConfirmDlg},
  Brddlg in '..\..\..\..\Common\Dialogs\brddlg.PAS' {BorderDlg},
  vtStdRes {vtStdResources: TDataModule},
  d_edMSub in '..\..\..\..\Common\Dialogs\D_EDMSUB.PAS' {NewSubDlg},
  D_ID in '..\..\..\dlg\D_ID.pas' {IDDlg},
  D_Hyperlink in '..\..\..\dlg\D_Hyperlink.pas' {dHyperLink},
  fr_SubCombo in '..\..\..\Frames\fr_SubCombo.pas' {frSubCombo: TFrame},
  D_Base in '..\..\..\..\Common\Meta\D_Base.pas' {BaseDlg},
  D_DocumentProperties in '..\..\..\dlg\D_DocumentProperties.pas' {DocumentPropertiesDlg},
  MainMDI in '..\..\MainMDI.pas',
  MainMDIEx in '..\..\MainMDIEx.pas' {evMainMDIFormEx},
  MainEditor in 'Main\MainEditor.pas' {MainEditorForm},
  MainLiteExpress in 'MainLiteExpress.pas' {MainLiteExpressForm},
  Main in 'Main.pas' {MainForm},
  dmStdResLite in 'dmStdResLite.pas' {dmStandardRes: TDataModule},
  BottomBtnDlg in '..\..\..\..\Archi\MetaForms\BottomBtnDlg.pas',
  BtnDlg in '..\..\..\..\Archi\MetaForms\BtnDlg.pas' {BtnDlg},
  D_Style in '..\..\..\..\Common\Dialogs\D_Style.pas' {StyleDesignDlg},
  PreviewFormUnit in '..\..\..\..\Common\Dialogs\PreviewFormUnit.pas' {PreviewForm},
  JwaWinBase in '..\..\..\..\..\..\..\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas',
  JwaNtStatus in '..\..\..\..\..\..\..\common\components\rtl\external\JEDI\Win32API\JwaNtStatus.pas',
  JwaWinNT in '..\..\..\..\..\..\..\common\components\rtl\external\JEDI\Win32API\JwaWinNT.pas',
  JwaWinType in '..\..\..\..\..\..\..\common\components\rtl\external\JEDI\Win32API\JwaWinType.pas';

{$R *.RES}
{$R versioninfo.res} // включаем Version Info

begin
 {$IfDef nsTest}
 g_CVSPath := 'w:\archi\source\projects\Everest\Lite\7.0\Express';
 {$EndIf nsTest}
 //#UC START# *512AF4A800AACVSPath*
 //#UC END# *512AF4A800AACVSPath*
 //#UC START# *512AF4A800AAmanualcode*
 Application.Title := 'ЭВЕРЕСТ (lite)';
 if (vtStdResources = nil) then
  Application.CreateForm(TvtStdResources, vtStdResources);
  Application.CreateForm(TdmStandardRes, dmStandardRes);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
