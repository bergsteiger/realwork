 program Archi;
{ $Id: Archi.dpr,v 1.139 2016/09/16 12:24:08 lukyanets Exp $ }

//$(ex)\vcl6;$(DELPHI)\Source\ToolsAPI;$(DELPHI)\Source\Rtl\SYS;$(DELPHI)\Source\Rtl\Common\;$(DELPHI)\Lib;$(DELPHI)\Bin;$(DELPHI)\Imports;$(DELPHI)\Projects\Bpl;$(ex)\SysTools;$(in)\l3;$(in)\l3\ext;$(in)\k2;$(in)\m0\pas;$(in)\m1\src;$(in)\m2\src;$(in)\m3\src;$(in)\m4\src;$(in)\mg\pas;$(ing)\Everest;$(ing)\Everest\ext;$(ing)\Everest\Ext\Misc;$(ing)\vt;$(in)\DD;$(in)\DD\pipein;$(in)\DD\pipeout;$(in)\dt;$(in)\da;$(in)\ht;$(in)\pg;$(in)\ComboAccess;$(ex)\SRMgr;$(ex)\Orpheus;$(ex)\TB97\SOURCE;$(ex)\JEDI;$(ex)\RX6;$(ex)\Envision;$(ex)\1C\source;$(pkg);$(ex)\indy\source;$(ex)\DevExpress\ExpressBars\Sources;$(ex)\DevExpress\ExpressCommon\Sources;$(ex)\WinSock
//X:\#PKG\D6
//$(DELPHI)\source\rtl\Corba40;$(DELPHI)\source\rtl\Sys;$(DELPHI)\source\rtl\Win;$(DELPHI)\source\rtl\common;$(DELPHI)\source\Internet;$(DELPHI)\source\clx;C:\Program Files\Developer Express Inc\ExpressPageControl\Delphi 6\Sources;X:\DevExpress\ExpressCommon\Sources;X:\DevExpress\ExpressBars\Sources;C:\Program Files\Developer Express Inc\ExpressBars\Delphi 6\Sources

{ProjectDefine.inc}

{.$I archiDefine.inc}
{$I arDefine.inc}
{version.lst}

 uses
  ddKTExtractor,
  evdSchema,
  Windows,
  SysUtils,
  Dialogs,
  Forms,
  vtForm,
  PrevInst,
  vtClipSpyService,
  evExtFormat,
  evExtActions,
  evExtActionsRes,
  D_TxSrch,
  D_TxSrch_Res,
  l3ExceptionsLog,
  l3Base,
  Main in 'Main\MAIN.PAS' {MainForm},
  d_GetNewDocParam in 'DLG\d_GetNewDocParam.pas' {NewDocParam},
  D_dsprm in 'DLG\D_DSPRM.PAS' {DocSetParamDlg},
  D_pass in 'DLG\D_PASS.PAS' {1_PasswordDlg _V},
  Logo in 'DLG\LOGO.PAS' {1_LOGODlg},
  Progress in 'DLG\PROGRESS.PAS' {1_ProgressDlg},
  Srchwin in 'SRCHWIN.PAS' {20.SearchWin},
  D_getnum in 'DLG\D_GETNUM.PAS' {21.GetNumberDlg _V},
  D_srch in 'DLG\D_SRCH.PAS' {21.DocSearchDlg _V},
  D_schres in 'DLG\D_SCHRES.PAS' {21.SearchResultDlg _V},
  D_export in 'DLG\D_EXPORT.PAS' {ExportDlg},
  D_ShowInfo in 'DLG\D_ShowInfo.pas' {D_ShowInfo},
  CustEditWin in 'Main\CustEditWin.pas',
  DictEntryWin in 'DictEntryWin.pas' {DictEntryWindow},
  Editwin in 'Main\Editwin.pas' {DocEditorWindow},
  D_edmsub {4_NewSubDlg _V},
  D_Style,
  D_cref in 'DLG\D_CREF.PAS' {4_ChoiceRefDlg},
  Showmes in 'DLG\SHOWMES.PAS' {4_ShowLongMessageDlg _V},
  Objexwin in 'OBJEXWIN.PAS' {5.ObjectExplorerWin},
  VMAILWIN in 'DLG\VMAILWIN.PAS' {5_ViewMailWin},
  MailWin in 'MAILWIN.PAS' {5_SendMailWin},
  TreeDWin in 'DLG\TREEDWIN.PAS' {9.TreeDesignerForm},
  DSHOWEQI in 'DLG\DSHOWEQI.pas' {DShowEq},
  Insdwin in 'DLG\INSDWIN.PAS' {9.InsertTextDictForm},
  D_DictItemEdit in 'DLG\D_DictItemEdit.pas' {DictItemEditDlg},
  D_NameSrcEd in 'D_NameSrcEd.pas' {NameEditSrcDlg},
  D_getds in 'DLG\D_GETDS.PAS' {GetDocSetDlg _V},
  Dsubview in 'DLG\DSUBVIEW.PAS' {ViewSubDlg},
  D_stat in 'DLG\D_STAT.PAS' {StatisticDlg _V},
  D_getabo in 'DLG\D_GETABO.PAS' {GetAbolishDataDlg},
  D_RepCon in 'DLG\D_REPCON.PAS' {ReplaceConfirmDlg _V},
  D_datein in 'DLG\D_DATEIN.PAS' {FindByJournalDlg _V},
  D_dtfilt in 'DLG\D_DTFilt.pas' {DocTypeFilterDlg},
  D_hnddoc in 'DLG\D_HNDDOC.PAS' {!!!HandlingDocDlg _V},
  D_config in 'DLG\D_CONFIG.PAS' {ConfigDlg},
  D_repask in 'DLG\D_REPASK.PAS' {SaveTroubleDlg _V},
  BtnDlg in 'MetaForms\BtnDlg.pas' {BtnDlg},
  RBtnDlg in 'MetaForms\RBtnDlg.pas' {RBtnDlg},
  BottomBtnDlg in 'MetaForms\BottomBtnDlg.pas' {BottomBtnDlg},
  RightBtnDlg in 'MetaForms\RightBtnDlg.pas' {RightBtnDlg},
  TabRBtnDlg in 'MetaForms\TabRBtnDlg.pas' {TabRBtnDlg},
  TabBBtnDlg in 'MetaForms\TabBBtnDlg.pas' {TabBBtnDlg},
  DictMetaForm in 'MetaForms\DictMetaForm.pas' {DictMetaForm},
  D_SrcChk in 'DLG\D_SrcChk.pas' {SrcCheckDlg},
  D_PaperWhere in 'DLG\D_PaperWhere.pas' {PaperWhereDlg},
  D_DateNumberEditor in 'DLG\D_DateNumberEditor.pas' {DateNumEditorDlg},
  D_StrEdit in 'DLG\common\d_StrEdit.pas' {StringEditDlg},
  D_DeltaKWFileEdit in 'Dlg\d_DeltaKWFileEdit.pas' {DeltaKWFileEditDlg},
  D_DirEdit in 'DLG\common\d_DirEdit.pas' {DirEditDlg},
  D_DateIntervalEdit in 'DLG\common\d_DateIntervalEdit.pas' {DateIntervalDlg},
  ClosingWin in 'ClosingWin.pas' {ClosingForm},
  D_DocByStageInfo in 'DLG\D_DocByStageInfo.pas' {DocByStageInfoDlg},
  D_SrchByAction in 'DLG\d_SrchByAction.pas' {SrchByActionDlg},
  D_ExtNameEd in 'DLG\D_ExtNameEd.pas' {ExtNameEditDlg},
  D_NewClassNameEd in 'DLG\D_NewClassNameEd.pas' {NewClassNameEditDlg},
  D_DictItemRequest in 'DLG\d_DictItemRequest.pas' {DictItemRequest},
  LinkHistoWin in 'LinkHistoWin.pas' {LinkHistoForm},
  D_DocAddr in 'DLG\D_DocAddr.pas' {DocAddrDlg},
  D_AttrActiveInterval in 'DLG\D_AttrActiveInterval.pas' {AttrActiveIntervalDlg},
  D_AttrAlarm in 'DLG\D_AttrAlarm.pas' {AttrAlarmDlg},
  D_AttrCopyEdit in 'DLG\D_AttrCopyEdit.pas' {AttrCopyEdit},
  D_OldEdition in 'DLG\d_OldEdition.pas' {OldEditionDlg},
  D_WizIzm in 'DLG\D_WizIzm.pas' {IzmWizardDlg},
  ResShop in 'CM\ResShop.pas' {ArchiResources: TDataModule},
  F_AttrExplorer in 'Frames\F_AttrExplorer.pas' {AttrExplorer: TvtFrame},
  F_TextEditor in 'Frames\F_TextEditor.pas' {TextEditorWin: TvtFrame},
  F_ImageView in 'Frames\F_ImageView.pas' {frmImgViewer: TvtFrame},
  F_DocList in 'Frames\F_DocList.pas' {DocumentList: TvtFrame},
  D_DocListSort in 'Dlg\D_DocListSort.pas' {DocListSortDlg},
  d_AddrEdit in 'DLG\common\d_AddrEdit.pas' {TAddressEditDlg},
  d_ReplCorresp in 'DLG\d_ReplCorresp.pas' {TReplaceCorrespDlg},
  d_ExternalObject in 'DLG\d_ExternalObject.pas' {ExternalObjectDlg},
  D_MacroSubNameProp in 'DLG\D_MacroSubNameProp.pas' {GetSubNamePropDlg},
  d_GetJurOp in 'DLG\d_GetJurOp.pas' {TGetJurOpDlg},
  D_DateCalc in 'DLG\D_DateCalc.PAS' {DateCalcDlg},
  d_DenyList in 'DLG\d_DenyList.pas' {AccessErrorWin},
  arAttrNodes in 'arAttrNodes.pas',
  D_TextMessages in 'Dlg\D_TextMessages.pas' {dlgTextMessages},
  d_BatchDelAttr in 'Dlg\d_BatchDelAttr.pas' {BatchAttrDelDlg},
  d_SearchSettings in 'Dlg\d_SearchSettings.pas' {SearchSettingsDlg},
  F_DictItemEdit in 'DLG\frames\F_DictItemEdit.pas' {DictItemEditFrame: TFrame},
  d_HyperlinkAddrChange in 'Dlg\d_HyperlinkAddrChange.pas' {ChangeHLAddrDlg},
  DeferDeleletedItemsWin in 'DeferDeleletedItemsWin.pas' {DeferDelItemsWin},
  arDocObject in 'arDocObject.pas',
  F_MiscDocImgView in 'Frames\F_MiscDocImgView.pas' {frmMiscDocImgView: TFrame},
  D_Doc2DocLinkEdit in 'Dlg\D_Doc2DocLinkEdit.pas' {Doc2DocLinkEditDlg},
  d_SrchByDocLink in 'Dlg\d_SrchByDocLink.pas' {SearchByDocLinkDlg},
  ArchiScriptEngine in 'Archi_Script_Engine\ArchiScriptEngine.pas',
  arDeliveryList in 'arDeliveryList.pas',
  arResultDeliverer in 'Processing\arResultDeliverer.pas',
  arOneTaskDeliverer in 'Processing\arOneTaskDeliverer.pas',
  arResultDeliveryInterfaces in 'Processing\arResultDeliveryInterfaces.pas',
  m4WordIDStr,
  m4WordIDStrListPrim,
  m4WordIDStrList,
  m4Word,
  m4WordList,
  arEditorDebugInfo in 'Main\arEditorDebugInfo.pas',
  D_TemplateEditor in 'Dlg\D_TemplateEditor.pas' {TemplateEditor},
  D_CorrectExportFolder in 'Dlg\D_CorrectExportFolder.pas' {TCorrectExportFolder},
  D_Autolink in 'Dlg\D_Autolink.pas' {AutolinkDlg},
  arDocObjectMixer in 'w:\archi\source\projects\Common\Utils\arDocObjectMixer.pas',
  arFoundSelectionFilter in 'w:\archi\source\projects\Common\Utils\arFoundSelectionFilter.pas',
  arUploadDocumentHelper in 'w:\archi\source\projects\archi\Processing\arUploadDocumentHelper.pas',
  arMultiModifyDocsHelper in 'w:\archi\source\projects\archi\Processing\arMultiModifyDocsHelper.pas';

//d_ReplCorresp in 'DLG\d_ReplCorresp.pas';

//D_TxSrch,
 // D_TxSrch_Res,

//D_SrchIncludeDoc2 in 'DLG\D_SrchIncludeDoc2.pas' {SrchIncludeDoc2Dlg},
//D_edmktb in 'common\D_EDMKTB.PAS' {4_MakeTblDlg _V},
 //D_Paste in 'common\D_Paste.PAS' {4_PasteSpecial _V},
{Диалоги с Everest
  EDITWIN, D_GetAbo, ShowMes, d_edMSub}
 //D_Spell in 'DLG\EDITOR\D_Spell.PAS' {4_SpellChecker _V},
  {VMailWin MailWin}
  {clipspy in 'clipspy.pas',         l3FileUtils
   Idocspc in 'IDOCSPC.PAS',
   Hfpaintr in 'HFPAINTR.PAS',
   }
  (*n:\mg;N:\GM;N:\DT;y:\o;y:\v;y:\my;y:\r;t:\;Y:\sd;y:\WS;\admin\dlg\*)
  (*l:\st;l:\mg;l:\GM;l:\DT;l:\o;l:\v;l:\my;l:\r;l:\ev;l:\sd;l:\rd;L:\c;l:\c;L:\l;l:\cs;l:\WS;dlg;admin\dlg\*)

 //D_DtTyp in 'DLG\D_DTTYP.PAS' {4_DTTypeDlg},
 //W_WarnEd in 'ADMIN\W_WARNED.PAS' {9.WarnEditWin},
 //W_Dict in 'ADMIN\W_DICT.PAS' {9.DictionDesignForm},
 //D_KWLink in 'DLG\D_KWLINK.PAS' {9.KWLinkDlg},

 //D_trechk in 'DLG\D_TRECHK.PAS' {4_TreeCheckDlg _V},

  //D_keyw in 'DLG\D_KEYW.PAS' {4_KeyWordDlg _V},                   project.inc
  //D_kwlnks in 'D_KWLNKS.PAS' {4_KWLinkShowDlg},
  //D_KWDes in 'DLG\D_KWDES.PAS' {9.KWDesignerDlg},                                        dt_lock
  //W_Dict in 'DLG\W_DICT.PAS' {9.DictionDesignForm},
  //D_getfil in 'DLG\D_GETFIL.PAS' {GetFileDlg},

{Удаленные}
//D_delrpl in 'DLG\D_DELRPL.PAS' {DelWithReplaceDlg _V},

{$R *.RES}
{$R versioninfo.res} // включаем Version Info

begin
 Application.Title := 'АРХИВАРИУС';

 if (Win32Platform <> VER_PLATFORM_WIN32_NT) or
    (Win32MajorVersion < 5) then
 begin
  ShowMessage('Для работы программы небходима OS Windows 2000 или выше!');
  Exit;
 end;

 {.$IfNDef DebugRelease}
 if CheckRunCondition then
 {.$EndIf}
 try
  Application.CreateForm(TArchiResources, ArchiResources);
  GlobalInit;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
 except
  on E : EAbort do;
  on E : Exception do
  begin
   l3System.Msg2Log(E.Message);
   Application.ShowException(E);
  end;
 end;

end.


