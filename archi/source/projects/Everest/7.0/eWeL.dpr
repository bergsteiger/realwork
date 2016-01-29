program eWeL;

{ $Id: eWeL.dpr,v 1.5 2009/03/05 12:20:22 lulin Exp $ }

// $Log: eWeL.dpr,v $
// Revision 1.5  2009/03/05 12:20:22  lulin
// - <K>: 137470629. Удаляем устаревший модуль.
//
// Revision 1.4  2002/11/11 14:07:06  law
// - new behavior: acConvertTextToTable.
//
// Revision 1.3  2002/11/04 15:05:21  law
// no message
//
// Revision 1.2  2002/08/02 08:17:41  law
// no message
//
// Revision 1.1  2002/07/09 12:15:21  law
// - new projects: eWe, eWeL.
//
// Revision 1.2  2002/04/06 11:33:46  law
// - Delphi 6.0.
//
// Revision 1.1.2.6  2001/10/16 14:27:57  law
// - new behavior: работа с буфером обмена через OLE.
//
// Revision 1.1.2.5  2001/10/08 09:36:28  law
// - cleanup.
//
// Revision 1.1.2.4  2001/10/02 15:07:14  law
// - new unit: MainEditor.
//
// Revision 1.1.2.3  2001/10/02 12:34:02  law
// - new units: MainMDI и MainMDIEx - в них вынесена часть функциональности с основной формы.
//
// Revision 1.1.2.2  2001/10/01 14:06:01  law
// - new unit: сделано разделение на MainForm и MainFormLite.
//
// Revision 1.1.2.1  2001/09/14 09:48:55  law
// - change: Delphi 6.
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

{$I Everest.inc}

uses
  Forms,
  k2Tags,
  evttStd,
  evExtActions,
  evExtActionsRes,
  evExtFormat,
  MAIN in '..\MAIN.PAS' {MainForm},
  Edwin in '..\EDWIN.PAS' {EditorWindow},
  D_txsrch in '..\DLG\D_TXSRCH.PAS' {TextSearchDlg},
  D_Style in '..\DLG\D_STYLE.PAS' {StyleDlg},
  D_mdilst in '..\DLG\D_MDILST.PAS' {MDIListDlg},
  D_repcon in '..\DLG\D_REPCON.PAS' {ReplaceConfirmDlg},
  D_FlSrch in '..\DLG\D_FLSRCH.PAS' {FileSrchForm},
  D_About in '..\dlg\D_About.pas' {AboutBox},
  Brddlg in '..\..\Common\Dialogs\brddlg.PAS' {BorderDlg},
  vtStdRes in 'J:\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  d_edMSub in '..\dlg\D_EDMSUB.PAS' {NewSubDlg},
  D_ID in '..\dlg\D_ID.pas' {IDDlg},
  D_Hyperlink in '..\dlg\D_Hyperlink.pas' {dHyperLink},
  fr_SubCombo in '..\Frames\fr_SubCombo.pas' {frSubCombo: TFrame},
  D_Base in '..\..\Common\Meta\D_Base.pas' {BaseDlg},
  D_DocumentProperties in '..\dlg\D_DocumentProperties.pas' {DocumentPropertiesDlg},
  MainLite in '..\Lite\MainLite.pas' {MainFormLite},
  MainMDI in '..\Lite\MainMDI.pas',
  MainMDIEx in '..\Lite\MainMDIEx.pas' {evMainMDIFormEx},
  MainEditor in '..\Lite\MainEditor.pas' {MainEditorForm},
  dmStdRes in '..\Lite\dmStdRes.pas' {dmStandardRes: TDataModule};

{$R *.RES}

begin
 Application.Title := 'ЭВЕРЕСТ (lite)';
 {$IfDef evUseOleClipboard}
 Application.Initialize;
 {$EndIf evUseOleClipboard}
 Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TdmStandardRes, dmStandardRes);
  if (vtStdResources = nil) then
  Application.CreateForm(TvtStdResources, vtStdResources);
 Application.Run;
end.




