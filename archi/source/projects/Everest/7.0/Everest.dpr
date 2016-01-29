program Everest;

{ $Id: Everest.dpr,v 1.26 2015/03/05 06:34:45 dinishev Exp $ }

// $Log: Everest.dpr,v $
// Revision 1.26  2015/03/05 06:34:45  dinishev
// Не компилировалось.
//
// Revision 1.25  2014/12/18 14:05:04  lulin
// {RequestLink:569230238}
//
// Revision 1.24  2014/01/29 04:54:25  dinishev
// {Requestlink:514874360}
//
// Revision 1.23  2013/03/18 09:02:30  dinishev
// {Requestlink:437519030}. Тесты.
//
// Revision 1.22  2013/02/27 12:10:35  dinishev
// {Requestlink:431386215}. Подготавливаем инфраструктуру.
//
// Revision 1.21  2012/12/14 05:29:24  fireton
// - добавляем Everest в автосборку
//
// Revision 1.20  2011/03/21 17:32:31  lulin
// {RequestLink:257822084}.
//
// Revision 1.19  2009/03/05 12:20:22  lulin
// - <K>: 137470629. Удаляем устаревший модуль.
//
// Revision 1.18  2008/03/12 14:43:41  dinishev
// Делаем общими диалоги для Арчи и Эвереста
//
// Revision 1.17  2007/12/05 13:51:24  lulin
// - bug fix: не собирался Эверест.
//
// Revision 1.15.2.3  2007/09/25 11:23:29  lulin
// - bug fix: диалог редактирования формул не собирался в ветке.
//
// Revision 1.15.2.2  2006/04/17 16:59:02  lulin
// - bug fix: не компилировалось.
//
// Revision 1.15.2.1  2006/02/08 14:08:25  lulin
// - собрал EverestLite в ветке.
//
// Revision 1.15  2005/09/23 12:03:32  lulin
// - схема документа переехала в общий каталог.
//
// Revision 1.14  2005/04/04 06:44:27  lulin
// - в связи с появлением механизма событий и фасада библиотеки K-2, удалены глобальные "заплатки" связанные с созданием/уничтожением таблицы тегов.
//
// Revision 1.13  2005/02/18 13:34:12  lulin
// - навел порядок с формой поиска.
//
// Revision 1.12  2004/12/17 13:26:20  lulin
// - bug fix: падало при отрисовке кнопок, т.к. изменения были внесены "не в тот" проект.
//
// Revision 1.22  2004/12/17 08:34:16  dinishev
// добавлен в uses evDropTreeFactory и новый модуль картинок кнопок
//
// Revision 1.21  2004/07/13 09:23:56  fireton
// - add: прикрутка автозамены в Эверест
//
// Revision 1.20  2001/08/29 07:01:42  law
// - split unit: l3Intf -> l3BaseStream, l3BaseDraw, l3InterfacedComponent.
//
// Revision 1.19  2001/06/08 13:20:32  law
// - new action: ev_ccSpecialPaste.
//
// Revision 1.18  2001/06/08 12:11:08  law
// - добавлена директива Log.
//

{$Include Everest.inc}

uses
  Forms,
  l3TabStops,
  k2Interfaces,
  k2Tags,
  k2Facade,
  k2Base,
  evdSchema,
  evExtActions,
  evExtActionsRes,
  evExtFormat,
  vtStdRes,
  MAIN in '..\MAIN.PAS' {MainForm},
  Edwin in '..\Lite\7.0\Express\Main\EDWIN.PAS' {EditorWindow},
  D_mdilst in '..\DLG\D_MDILST.PAS' {MDIListDlg},
  D_repcon in '..\DLG\D_REPCON.PAS' {ReplaceConfirmDlg},
  D_memusg in '..\DLG\D_MEMUSG.PAS' {MemoryUsageDlg},
  D_FlSrch in '..\DLG\D_FLSRCH.PAS' {FileSrchForm},
  D_About in '..\dlg\D_About.pas' {AboutBox},
  Brddlg in '..\..\Common\Dialogs\brddlg.PAS' {BorderDlg},
  d_edMSub in '..\..\Common\Dialogs\D_EDMSUB.PAS' {NewSubDlg},
  D_ID in '..\dlg\D_ID.pas' {IDDlg},
  D_Hyperlink in '..\dlg\D_Hyperlink.pas' {dHyperLink},
  fr_SubCombo in '..\Frames\fr_SubCombo.pas' {frSubCombo: TFrame},
  D_Base in '..\..\Common\Meta\D_Base.pas' {BaseDlg},
  D_DocumentProperties in '..\dlg\D_DocumentProperties.pas' {DocumentPropertiesDlg},
  MainLite in '..\Lite\MainLite.pas' {MainFormLite},
  MainMDI in '..\Lite\MainMDI.pas',
  MainMDIEx in '..\Lite\MainMDIEx.pas' {evMainMDIFormEx},
  MainEditor in '..\Lite\7.0\Express\Main\MainEditor.pas' {MainEditorForm},
  dmStdRes in '..\Lite\dmStdRes.pas' {dmStandardRes: TDataModule},
  D_TxSrch in '..\..\Common\Dialogs\D_TXSRCH.PAS' {TextSearchDlg},
  D_TxSrch_Res in '..\..\Common\Dialogs\D_TxSrch_Res.pas' {SrchRes: TDataModule},
  dmControlRes in '..\Lite\dmControlRes.pas' {dmCtrlRes: TDataModule},
  ExprEditForm in '..\..\Common\Dialogs\ExprEditForm.pas' {ExprEditor},
  D_Style in '..\..\Common\Dialogs\D_Style.pas' {StyleDesignDlg},
  evControlParaConst,
  JwaWinBase {$IfNDef XE} in 'w:\common\components\rtl\external\JEDI\Win32API\JwaWinBase.pas' {$EndIf}
  ;

{$R *.RES}
{$R versioninfo.res}

begin
 Application.Title := 'ЭВЕРЕСТ';
 {$IfDef evUseOleClipboard}
 Application.Initialize;
 {$EndIf evUseOleClipboard}
 Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TdmStandardRes, dmStandardRes);
  Application.CreateForm(TdmCtrlRes, dmCtrlRes);
  if (vtStdResources = nil) then
  Application.CreateForm(TvtStdResources, vtStdResources);
 Application.Run;
end.




