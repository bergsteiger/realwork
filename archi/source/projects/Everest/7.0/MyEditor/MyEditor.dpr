program MyEditor;

{ $Id: MyEditor.dpr,v 1.2 2009/03/05 12:20:23 lulin Exp $ }

{$I Everest.inc}

uses
  Forms,
  k2Tags,
  evttStd,
  evExtActionsRes,
  evExtActions,
  evExtFormat,
  Edwin in '..\..\EDWIN.PAS' {EditorWindow},
  D_mdilst in '..\..\DLG\D_MDILST.PAS' {MDIListDlg},
  D_repcon in '..\..\DLG\D_REPCON.PAS' {ReplaceConfirmDlg},
  Brddlg in '..\..\..\Common\Dialogs\brddlg.PAS' {BorderDlg},
  vtStdRes in 'J:\VT\vtStdRes.pas' {vtStdResources: TDataModule},
  d_edMSub in '..\..\dlg\D_EDMSUB.PAS' {NewSubDlg},
  D_ID in '..\..\dlg\D_ID.pas' {IDDlg},
  D_Hyperlink in '..\..\dlg\D_Hyperlink.pas' {dHyperLink},
  fr_SubCombo in '..\..\Frames\fr_SubCombo.pas' {frSubCombo: TFrame},
  D_Base in '..\..\..\Common\Meta\D_Base.pas' {BaseDlg},
  D_DocumentProperties in '..\..\dlg\D_DocumentProperties.pas' {DocumentPropertiesDlg},
  MainMDI in '..\..\Lite\MainMDI.pas',
  MainMDIEx in '..\..\Lite\MainMDIEx.pas' {evMainMDIFormEx},
  MainEditor in '..\..\Lite\MainEditor.pas' {MainEditorForm},
  D_TxSrch in '..\..\dlg\D_TXSRCH.PAS' {TextSearchDlg},
  MainLiteExpress in '..\..\Lite\7.0\Express\MainLiteExpress.pas' {MainLiteExpressForm},
  MainExpress in '..\Express\MainExpress.pas' {MainExpressForm},
  Main in 'Main.pas' {MainForm},
  dmStdRes in '..\..\Lite\dmStdRes.pas' {dmStandardRes: TDataModule};

{$R *.RES}

begin
 Application.Title := '��� ��������';
 if (vtStdResources = nil) then
  Application.CreateForm(TvtStdResources, vtStdResources);
  Application.CreateForm(TdmStandardRes, dmStandardRes);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
