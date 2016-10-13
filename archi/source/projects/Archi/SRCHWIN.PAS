unit SrchWin;

{ $Id: SRCHWIN.PAS,v 1.323 2016/10/13 13:16:43 lukyanets Exp $ }

{$I ProjectDefine.inc}
interface

uses
  SysUtils,
  WinTypes,
  WinProcs,
  Messages,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Buttons,
  ExtCtrls,
  Menus,
  W95Meter,
  ComCtrls,
  ActnList,

  OvcBase,

  HT_Const,

  TypeShop,

  vtForm,
  vtlister,
  vtOutliner,
  vtStatusBar,
  vtCtrls,

  l3Types,
  l3DatLst,
  l3BaseStream, l3Stream,

  HelpCnst,

  daTypes,

  DT_Const,
  DT_Types,
  dt_AttrSchema,
  dtIntf, DT_Sab,
  DT_Serv,
  DT_Query,
  DT_AskList,
  DT_Dict,
  DT_Doc,
  DT_Hyper,
  DT_Lock,
  Dt_Jour,
  DT_LinkServ,


  DocIntf,
  DocUtils,

  TB97,
  F_DocList,
  DragData,

  arTypes,
  SavedQuery;

type
  TSearchWin = class(TvtForm)
    MainMenu1        : TMainMenu;
    MIDocSet         : TMenuItem;
    miNewDocSet      : TMenuItem;
    miOpenDoc        : TMenuItem;
    N1               : TMenuItem;
    N2               : TMenuItem;
    miGroupOperation : TMenuItem;
    miExport2NSRC    : TMenuItem;
    miStatistic      : TMenuItem;
    miGroupAdd       : TMenuItem;
    miGroupDel       : TMenuItem;
    miNextDocSet     : TMenuItem;
    miAddIDtoDocSet  : TMenuItem;
    miDocInfo        : TMenuItem;
    miAddDocSet      : TMenuItem;
    miSaveToEVD      : TMenuItem;
    miDocPrint       : TMenuItem;
    miTypeFilter     : TMenuItem;
    miSaveAs         : TMenuItem;
    miAndDocSet      : TMenuItem;
    miAndNotDocSet   : TMenuItem;
    N3               : TMenuItem;
    N5               : TMenuItem;
    miTouchStamp: TMenuItem;

    DocList: TDocumentList;
    miDeleteDoc: TMenuItem;
    miSaveDocSet: TMenuItem;
    alSearchActions: TActionList;
    actOpenDocument: TAction;
    actOpenSelectedDocuments: TAction;
    N6: TMenuItem;
    actSpecifySet: TAction;
    actAddSet: TAction;
    actTraverseSet: TAction;
    actSubstractSet: TAction;
    actNewSet: TAction;
    actSearchStats: TAction;
    actSaveDocAs: TAction;
    actGroupAdd: TAction;
    actGroupDelete: TAction;
    actGroupTouch: TAction;
    actDocExport: TAction;
    miChangeHLinks: TMenuItem;
    alDocListTools: TActionList;
    acSaveDocSet: TAction;
    acSaveDocSetAs: TAction;
    N7: TMenuItem;
    acBatchDeleteAttributes: TAction;
    N8: TMenuItem;
    actIZM: TAction;
    IZM1: TMenuItem;
    acRefreshResult: TAction;
    N9: TMenuItem;
    acExpandEdition: TAction;
    N11: TMenuItem;
    acSendToServer: TAction;
    N12: TMenuItem;
    acKTDocNameChange: TAction;
    N13: TMenuItem;
    actAutoSpell: TAction;
    N14: TMenuItem;
    N15: TMenuItem;
    acGetCorrespondents: TAction;
    actGroupAutolink: TAction;
    N16: TMenuItem;
    actGroupSetClone: TAction;
    N19: TMenuItem;
    acGetRespondents: TAction;
    N21: TMenuItem;
    acDeleteDocument: TAction;

    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

    procedure ShowSubBtnClick(Sender: TObject);
    procedure RunViewerBtnClick(Sender: TObject);
    procedure miDeleteDocClick(Sender: TObject);
    procedure SrchResultListerCountChanged(Sender: TObject; NewCount: Integer);
    procedure actOpenDocumentExecute(Sender: TObject);
    procedure actOpenSelectedDocumentsExecute(Sender: TObject);
    procedure actSpecifySetExecute(Sender: TObject);
    procedure actAddSetExecute(Sender: TObject);
    procedure actTraverseSetExecute(Sender: TObject);
    procedure actSubstractSetExecute(Sender: TObject);
    procedure actNewSetExecute(Sender: TObject);
    procedure DocListSrchResultListerCountChanged(Sender: TObject; NewCount: Integer);
    procedure miTypeFilterClick(Sender: TObject);
    procedure actSearchStatsExecute(Sender: TObject);
    procedure actSaveDocAsExecute(Sender: TObject);
    procedure actGroupAddExecute(Sender: TObject);
    procedure actGroupDeleteExecute(Sender: TObject);
    procedure actGroupTouchExecute(Sender: TObject);
    procedure actDocExportExecute(Sender: TObject);
    procedure miChangeHLinksClick(Sender: TObject);
    procedure miAddIDtoDocSetClick(Sender: TObject);
    procedure acSaveDocSetExecute(Sender: TObject);
    procedure acSaveDocSetAsExecute(Sender: TObject);
    procedure acBatchDeleteAttributesExecute(Sender: TObject);
    procedure miDocPrintClick(Sender: TObject);
    procedure DocListmiAddIDtoDocSetClick(Sender: TObject);
    procedure miDocInfoClick(Sender: TObject);
    procedure actIZMExecute(Sender: TObject);
    procedure acRefreshResultExecute(Sender: TObject);
    procedure miSaveToEVDClick(Sender: TObject);
    procedure acExpandEditionExecute(Sender: TObject);
    procedure acSendToServerExecute(Sender: TObject);
    procedure acKTDocNameChangeExecute(Sender: TObject);
    procedure actAutoSpellExecute(Sender: TObject);
    procedure acGetCorrespondentsExecute(Sender: TObject);
    procedure actGroupAutolinkExecute(Sender: TObject);
    procedure actGroupSetCloneExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure acGetRespondentsExecute(Sender: TObject);
  private
    f_SrchName  : AnsiString;
    fSavedQuery : TSavedQuery;
    procedure ExecSrchDlg(aNewSrchLog : Boolean);
    procedure ExecGroupOperation(ADMode : TOperActionType);
    procedure TouchGroup;
    procedure SetSrchName(Value : AnsiString);
    procedure SetFamily(Value : TdaFamilyID);
    function  GetFamily : TdaFamilyID;
    function  GetModified : Boolean;
    procedure SetModified(aValue : Boolean);
    function  Copy   : Boolean; override;
    function  Paste  : Boolean; override;
    function  Save   : Boolean; override;
    function  SaveAs : Boolean; override;
    function  Print  : Boolean; override;

    function  DeleteDoc(aDocID : TDocID) : Boolean;
    procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;
    procedure WMServerStatusChanged(var Message: TMessage); message WM_SERVERSTATUSCHANGED;

    // SpecialActions
    procedure SpecialDocProcessing;
    procedure CalcAverageDocHandlingTime;

    procedure OutListToStream(aStream : Tl3Stream; aSelectOnly : Boolean = false);
    procedure ReAutolinkDocs(aClearLinks: Boolean);
    procedure SetCloneToPublishedIns;
    function SelectQuery: TdtQuery;
  {$IFDEF InsiderTest}
  public
  {$ELSE}
  private
  {$ENDIF InsiderTest}
    procedure DoSaveDocsList2File(const aFileName: AnsiString);
  public
    procedure ShowDocSet(const aDocRecs: ISab);
    procedure LoadDocSet(aSavedQuery : TSavedQuery);
    procedure DeletePersistentDocSet;
    procedure SetSpeedButton(Enabled : Boolean); override;
    procedure MergeWithAnotherDocSet(aQuery : TdtQuery; aMergeMode : Tl3BoolOp);
    procedure SetDictLinks(aDictType : TdaDictionaryType; aReplace : Boolean = False);
    procedure SpecialAction;
    procedure DeleteAllHyperLinks;
    procedure FindButtonClick(Sender: TObject);
    procedure FindAgainButtonClick(Sender: TObject);

    property  Family   : TdaFamilyID read GetFamily write SetFamily;
    property  SrchName : AnsiString read f_SrchName write SetSrchName;
    property  Modified : Boolean read GetModified write SetModified;
  end;


procedure RenumerateExtID;

implementation
{$R *.DFM}

uses
 Main,
 EditWin,
 ObjExWin,
 Progress,
 DictsSup,

 D_TxSrch,
 D_IntEdit,
 D_GetDS,
 D_DenyList,
 D_RepAsk,
 D_DSPrm,
 D_Export,
 D_AttrCopyEdit,
 D_BatchDelAttr,
 D_Srch,

 daDataProvider,
 daSchemeConsts,

 HT_Dll,
 DT_Err,
 dt_Misc,
 DT_Table,
 DT_aTbl,
 DT_Link,

 DT_DictConst,
 DT_SabHelp,
 DT_Renum, DT_Acces,
 DT_Log, DT_Stage,
 DT_SrchQueries,
 Dt_QueryProvider,
 Dt_IFltr,

 l3Except,
 l3MinMax,
 l3Clipboard,
 l3Parser,
 l3Filer,
 l3RecList,
 l3Base,
 l3Memory,
 l3Chars,
 l3String,
 l3Bits,
 l3Date,
 l3IniFile,
 //l3LongintList,
 l3IDList,
 l3FieldSortRecList,
 l3FileUtils,
 l3MarshalledTypes,

 evCommonRes,
 evPrintEngine,

 FileCtrl,

 vtMenus,
 vtClipSpy,
 vtDialogs,
 vtLogFile,

 ResShop,
 StrShop,
 IniShop,
 Base_CFG,

 ObjExpl,
 VConst,
 Com_Cnst,
 ObjList,

 DtSupport,
 Dt_TblCache, dt_TblCacheDef,

 arCustomMultiModifyDocsHelper,
 arDirectMultiModifyDocsHelper,
 arRemoteMultiModifyDocsHelper,

 arCustomMultiClearAttributesHelper,
 arDirectMultiClearAttributesHelper,
 arRemoteMultiClearAttributesHelper,

 arCustomMultiOperationHelper,
 arDirectMultiOperationHelper,
 arRemoteMultiOperationHelper,

 arIZM,
 SewerPipe,

 ddDocNameUpdateFilter,
 ddKTExtractor,
 ddAutoLinker,
 ddAutolinkServer,
 ddProgressObj,
 ddSimpleProgressDlg,
 ddClientBaseEngine,

 DocAttrIntf, DocAttrToolsIntf,
 ArchiUserRequestManager, csUserDefinedExport, k2TagGen,
 csAutoSpell, csUserRequestManager, csAutolinkerTask,
 arVAnouncedBlackList;

const
 cDocSetheader = 'ВЫБОРКА ДОКУМЕНТОВ';
 cInactText : array[Boolean] of AnsiString = ('', ' Документ утратил силу');
 cDocDeleted = 'Удален документ %s пользователем %s';
 cDocDeleteEX = 'Удален документ #%d (Garant #%d) пользователем %s';
 cProblemWithTopic = 'Проблемы с топиком %d';
 cProcessOfSyncCompleate = 'Процесс синхронизации завершен';
 cNeedInputNumber = 'Установить "%S"';
 cDictID = 'ID элемента словаря';
 cDeleting = 'Deleting...';
 cAvarageTimeOfProcessing = 'Среднее время обработки %d суток';
 cCountOfIncludedDocs = 'Учтена информация %d документов';

//!! !! к убиению
// sKTFilename = 'kthemes.csv';
//!! !! к убиению

resourceString
 sidQstDeleteAllHyperLinks = 'Эта функция удалит все гипессылки с документов текущей выборки,'^M+'Хотите продолжить?';
 sidDeleteAllHyperLinksResult = 'Удалено %d ссылок.';     

procedure TSearchWin.SetSpeedButton(Enabled : Boolean);
begin
 if Application.Terminated then Exit;
 MainForm.acFindDocNext.Enabled := Enabled and not DocList.IsListEmpty;
 MainForm.acRunEditor.Enabled := Enabled and not DocList.IsListEmpty;
 MainForm.acShowSub.Enabled := Enabled;
 MainForm.acRemoveFromDocSet .Enabled := MainForm.sbRunEditor.Enabled;
 MainForm.acRunViewer.Enabled := MainForm.sbRunEditor.Enabled;
 MainForm.acSaveDocExtracts.Enabled := Enabled and not DocList.IsListEmpty;
 MainForm.acSaveDocExtractsAs.Enabled := MainForm.acSaveDocExtracts.Enabled;
 MainForm.acCopy.Enabled := Enabled;
 MainForm.acPaste.Enabled := not ClipboardIsEmpty;
 MainForm.acSave.Enabled := Enabled;
 MainForm.acFind.Enabled := Enabled;
 MainForm.acPrint.Enabled := Enabled and not DocList.IsListEmpty;
 MainForm.acPrintAll.Enabled := Enabled and not DocList.IsListEmpty;

 if not Enabled then
  MainForm.acFindNext.Enabled := Enabled;
end;

procedure TSearchWin.SetSrchName(Value : AnsiString);
begin
 f_SrchName := Value;
 if f_SrchName <> '' then 
  Self.Caption := cDocSetheader + ' "'+ f_SrchName + '"'
 else 
  Self.Caption := cDocSetheader;
 MainForm.OEWin.AddToExplorer(eotDocSet, '"' + f_SrchName + '"', Longint(Self));
end;

function  TSearchWin.GetFamily : TdaFamilyID;
begin
 Result := DocList.Family;
end;

procedure TSearchWin.SetFamily(Value : TdaFamilyID);
begin
 if DocList.Family = Value then Exit;
 DocList.Family := Value;
 miDeleteDoc.Enabled := l3TestMask(AccessServer.GetSelfMask(Family), acfDelete);
end;

function  TSearchWin.GetModified : Boolean;
begin
 Result := DocList.Modified;
end;

procedure TSearchWin.SetModified(aValue : Boolean);
begin
 DocList.Modified := aValue;
end;

procedure TSearchWin.FormCreate(Sender: TObject);
begin
 HelpContext := hcDocSample;
 if (BaseConfig <> nil) then
 begin
  BaseConfig.Section := 'PERMISSIONS';
  acKTDocNameChange.Visible := BaseConfig.ReadParamBoolDef('EnableKT', False);
 end
 else
  acKTDocNameChange.Visible := False;
end;

procedure TSearchWin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 MainForm.OEWin.DelFromExplorer(eotDocSet, Longint(Self));
 Action := caFree;
end;

procedure TSearchWin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
 l_DlgResult : Word;
begin
 CanClose := True;
 if DocList.WasSaved and DocList.Modified then
  if not DocList.IsListEmpty then
  begin
   if MainForm.SilentClose then
    l_DlgResult := mrYes
   else
    l_DlgResult := vtMessageDlg(l3Fmt(sidSaveDocSetAsk, [SrchName]), mtWarning, mbYesNoCancel);
   case l_DlgResult of
    mrYes :
     try
      CanClose := False;
      Save;
      CanClose := True;
     except
      on E : Exception do Application.ShowException(E);
     end;
    mrNo :
     CanClose := True;
    mrCancel :
     CanClose :=False;
   end;//case l_DlgResult of
  end//if not DocList.IsListEmpty then
  else
   if MainForm.SilentClose then
    CanClose := True
   else
    case vtMessageDlg(l3Fmt(sidDelDocSetAsk, [SrchName]), mtWarning, mbYesNoCancel) of
     mrYes :
      try
       CanClose := True;
       DeletePersistentDocSet;
      except
       on E : Exception do Application.ShowException(E);
      end;
     mrNo :
      CanClose := True;
     mrCancel :
      CanClose := False;
    end;//case vtMessageDlg(
 ModalResult := mrCancel;
end;

procedure TSearchWin.FormDestroy(Sender: TObject);
begin
 l3Free(fSavedQuery);
 MainForm.CheckCurrChild(Self);
end;

procedure TSearchWin.ExecSrchDlg(aNewSrchLog : Boolean);
var
 l_DestForm : TForm;
 lSrchDlg   : TDocSearchDlg;
 lQuery     : TdtQuery;
begin
 lSrchDlg := TDocSearchDlg.CreateParam(Self, Family);
 try
  lQuery := nil;
  if not aNewSrchLog and (DocList.QueryProvider.Query is TdtDocListQuery) then
   lQuery := TdtDocListQuery(DocList.QueryProvider.Query).UQuery.Use;
  try
   if lSrchDlg.Execute(lQuery, l_DestForm, True {это уточнение выборки}) then
   begin
    Application.ProcessMessages;
    DocList.QueryProvider.Changing;
    if (DocList.QueryProvider.Query is TdtDocListQuery) then
     TdtDocListQuery(DocList.QueryProvider.Query).ClearAddLists;
    DocList.Query := lQuery;
    DocList.QueryProvider.Changed;
   end;
  finally
   l3Free(lQuery);
  end;
 finally
  lSrchDlg.Free;
 end;
end;

procedure TSearchWin.actNewSetExecute(Sender: TObject);
begin
 ExecSrchDlg(True);
end;

procedure TSearchWin.actSpecifySetExecute(Sender: TObject);
begin
 ExecSrchDlg(False);
end;

procedure TSearchWin.RunViewerBtnClick(Sender: TObject);
begin
 DocList.RunEditor(Sender, True);
end;

procedure TSearchWin.ShowSubBtnClick(Sender: TObject);
begin
 DocList.SubShow := not DocList.SubShow;
end;

procedure TSearchWin.DeletePersistentDocSet;
begin
 if DocList.WasSaved and (fSavedQuery <> nil) then
 begin
  g_dtQueryList.DelSQuery(fSavedQuery);
  DocList.WasSaved := False;
  DocList.Modified := False;
  l3Free(fSavedQuery);
 end;
end;

procedure TSearchWin.LoadDocSet(aSavedQuery : TSavedQuery);
var
 lQuery : TdtQuery;
begin
 Screen.Cursor:=crHourGlass;
 try
  fSavedQuery := aSavedQuery.Use;
  lQuery := fSavedQuery.MakeQuery;
  try
   DocList.Query := lQuery;
  finally
   l3Free(lQuery);
  end;

  Family := fSavedQuery.Family;

  DocList.WasSaved := True;
  DocList.Modified := False;
  SrchName := fSavedQuery.Name;
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TSearchWin.SpecialAction;
begin
 // подсчет средней продолжительности обработки документов
 CalcAverageDocHandlingTime;

 //SpecialDocProcessing;

 //Установить специальную базу
 //SetDictLinks(da_dlBases, True);
end;

procedure TSearchWin.CalcAverageDocHandlingTime;
type
 TReadRec = packed record
  rDocID  : TDocID;
  rType   : TStageType;
  rDate  : TStDate;
 end;
 PReadRec = ^TReadRec;

var
 l_Nums      : ISab;
 l_Beg       : ISab;
 l_End       : ISab;
 l_Stage     : TStageType;
 l_List      : Tl3FieldSortRecList;
 l_SaveDocID : TDocID;
 l_SaveDate  : TStDate;
 l_Count     : Int64;
 l_DateSum   : Int64;
 I           : Integer;
 lPhoto      : ISab;
begin
 l_Count := 0;
 l_DateSum := 0;

 l_Nums := DocList.QueryProvider.MakeDocIDList;

 lPhoto := MakePhoto(LinkServer(Family)[atStages]);

 l_Nums.RecordsByKey(stDocID_Key, lPhoto);

 l_Stage := stInput;
 l_Beg := MakeSab(lPhoto.Table);
 l_Beg.Select(stType_Key, l_Stage, EQUAL, l_Nums);
 l_Beg.SubSelect(stEDate_Key, Zero, GREAT);

 l_Stage := stFinUrObr;
 l_End := MakeSab(lPhoto.Table);
 l_End.Select(stType_Key, l_Stage, EQUAL, l_Nums);
 l_End.SubSelect(stEDate_Key, Zero, GREAT);

 l_Beg.OrSab(l_End);
 l_Nums.AndSab(l_Beg);
 l_Nums.Sort([stDocID_Key, stType_Key]);

 l_List := dtMakeRecListBySab(l_Nums.HTSab,[stDocID_Key, stType_Key, stEDate_Key]);
 try
  for I := 0 to Pred(l_List.Count) do
   with PReadRec(l_List.ItemSlot(I))^ do
   begin
    if rType = stInput then
    begin
     l_SaveDocID := rDocID;
     l_SaveDate  := rDate;
    end//if rType = stInput then
    else
     if l_SaveDocID = rDocID then
     begin
      Inc(l_Count);
      Inc(l_DateSum, Max(rDate - l_SaveDate, 1));
     end;//if l_SaveDocID = rDocID then
   end;//with TReadRec(l_List.ItemSlot(I)^) do
 finally
  l3Free(l_List);
 end;
 vtMessageDlg(l3Fmt(cAvarageTimeOfProcessing + ^M + cCountOfIncludedDocs, [l_DateSum/l_Count, l_Count]));
end;

procedure TSearchWin.DeleteAllHyperLinks;
var
 l_Cnt : Integer;
begin
 if vtMessageDlg(l3CStr(@sidQstDeleteAllHyperLinks), mtConfirmation, [mbYes, mbNo]) = mrYes then
 begin
  l_Cnt := LinkServer(Family)[atHLink].DelAllLinkItems(DocList.QueryProvider.MakeDocIDList(True));
  vtMessageDlg(l3Fmt(sidDeleteAllHyperLinksResult, [l_Cnt]));
 end;
end;

procedure TSearchWin.SetDictLinks(aDictType : TdaDictionaryType; aReplace : Boolean = False);
var
 i         : Longint;
 lDocID    : TDocID;
 lRec : packed record
  rDictID : TDictID;
  rSubID  : TSubID;
 end;

begin
 if not RequestIntegerValue(Integer(lRec.rDictID), Self, Format(cNeedInputNumber, [GetDictName(aDictType)]), cDictID) then Exit;
 with LinkServer(Family).Links[aDictType] do
 begin
  Table.StartCaching;
  try
   DocList.FooterPanel.Panels[0].Text := cDeleting;
   if aReplace then
    DelAllLinkItems(DocList.QueryProvider.MakeDocIDList);

   for i := 0 to DocList.SrchResultLister.Total - 1 do
   begin
    lDocID := DocList.QueryProvider.GetItem(I).rID;
    lRec.rSubID := 0;
    AddNode(lDocID, lRec);

    DocList.FooterPanel.Panels[0].Text := Format(scFmtFuterCounter,[i, DocList.SrchResultLister.Total]);
    Application.ProcessMessages;
   end;
  finally
   Table.StopCaching;
  end;
 end;
end;

procedure TSearchWin.SpecialDocProcessing;
var
 i      : Longint;
 lDocID : TDocID;
begin
 for i := DocList.SrchResultLister.Current to DocList.SrchResultLister.Total - 1 do
 begin
  lDocID := DocList.QueryProvider.GetItem(I).rID;
  try
   //duLoadAndSaveDoc(CurrentFamily, l_Doc.ID);
  except
   l3System.Msg2Log(Format(cProblemWithTopic, [lDocID]));
  end;
  DocList.FooterPanel.Panels[0].Text := Format(scFmtFuterCounter, [i, DocList.SrchResultLister.Total]);
  Application.ProcessMessages;
 end;
 l3System.Msg2Log(cProcessOfSyncCompleate);
 vtMessageDlg(l3CStr(cProcessOfSyncCompleate), mtWarning, [mbOK]);
end;

procedure TSearchWin.TouchGroup;
var
// lIDSab : ISAB;
 l_Helper: TarCustomMultiOperationHelper;
begin
 if DocList.SrchResultLister.Total <= 0 then Exit;

 if IniRec.DirectDocStorageAccess then
  l_Helper := TarDirectMultiOperationHelper.Create(Family, ar_moGroupTouch, DocList.QueryProvider.MakeDocIDList)
 else
  l_Helper := TarRemoteMultiOperationHelper.Create(Family, ar_moGroupTouch, DocList.QueryProvider.MakeDocIDList);
 try
  l_Helper.ModifyDocs;
 finally
  FreeAndNil(l_Helper);
 end;

// lIDSab := DocList.QueryProvider.MakeDocIDList;
// LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acAttrWork);
end;

procedure TSearchWin.ExecGroupOperation(ADMode : TOperActionType);
var
 l_It          : Longint;
 I             : Longint;
 l_LockHandle  : TJLHandle;
 l_MaxMask     : Longint;
 l_LockMask    : Longint;
 l_EdWin       : TDocEditorWindow;
 //l_GData       : TGroupData;
 l_ParamSetted : Boolean;
 l_Doc         : PDocListAccessRec;
 l_ErrWin      : TAccessErrorWin;
 l_Attribute   : IDocAttribute;

 l_Helper: TarCustomMultiModifyDocsHelper;
(*
 procedure l_AddToDenyList(const aIDList : Il3IDList);
 var
  I : Cardinal;
 begin
  if not Assigned(aIDList) or aIDList.Empty then
   Exit;

  if l_ErrWin = nil then
  begin
   l_ErrWin := TAccessErrorWin.Create(Self);
   l_ErrWin.ItemList.Items.DataSize := SizeOf(Longint);
  end;

  for I := 0 to Pred(aIDList.Count) do
   AddToDenyList(Family, aIDList[I], l_ErrWin.ItemList.Items, True);
 end;

{.$Define SilentAttrSet}
{.$Define FastAttrSet} // без захвата документа
var
 l_SavedDocID   : TDocID;
 l_LogActionSet : TLogActionSet;

 var
  lDBFilter : TGroupOpFilter;

 function lMakeDBFilter : TGroupOpFilter;
  // устанавливает фильтр, который укладывает данные в СУБД
 var
  lDocIDList : Il3IDList;
 begin
  Result := TGroupOpFilter.Create(nil);
  with Result do
  begin
   Family := l_EdWin.Document.DocFamily;
   //CurDocID := DocInfo.DocID;
   InternalFormat := True;
   //ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];
   ExcludeMainRec := false; //True;
   case ADMode of
    atAdd    : SaveMode := smAttrAdd;
    atDelete : SaveMode := smAttrDel;
   end;

   lDocIDList := dtMakeSortedIDListBySab(DocList.Query.GetDocIdList);
   Result.SetDocIDList(lDocIDList);

   ExcludeAttr := []; //CctAllAttributes - [ctHLink, ctSub];

   //NeedEventforEraseAttrRec := [ctKW];
   //OnEraseAttrRecords := evntOnEraseAttrRecords;
  end;
 end;

 procedure ProcessForAnoncedList(const aDocIDList : Il3IDList);
 var
  lSab : ISab;
  lTypeSab : ISab;
  lTypeSabCursor : ISabCursor;
  I : TUserType;

 begin
  if (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(Family).FileTbl, fId_Fld, aDocIDList);
  lSab.RecordsByKey;

  lTypeSab := MakeEmptyValueSab(lSab, fUserType_Fld);
  lTypeSabCursor := lTypeSab.MakeSabCursor([fUserType_Fld]);
  for I := low(TUserType) to high(TUserType) do
   if I in utFullFeatureDocTypes then
    lTypeSabCursor.AddItem(@I);
  lTypeSabCursor := nil;
  lTypeSab.InvertSab;
  lTypeSab.RecordsByKey;
  lSab.SubtractSab(lTypeSab);

  lSab.ValuesOfKey(fId_Fld);

  FilterbyVAnouncedAccGroupsBlackList(lSab);

  LinkServer(Family).LogBook.PutLogRecToDocs(lSab, acAnonced, 0, DateTimeToStDate(IniRec.AnouncedDate));
 end;

 procedure ProcessForIZMList(Const aDocIDList : Il3IDList);
 var
  lSab : ISab;
 begin
  if  (aDocIDList = nil) or aDocIDList.Empty then Exit;
  lSab := MakeValueSet(DocumentServer(Family).FileTbl, fId_Fld, aDocIDList);
  GetIZMChecker.CheckoutForIZM(lSab);
 end;

*)
{gr op}
begin
// l_SavedDocID := 0;
// l_LogActionSet := [];
 l_ParamSetted := False;
 if DocList.SrchResultLister.Total = 0 then Exit;
 l_ErrWin := nil;
 l_EdWin := TDocEditorWindow.Create(Self);
 try
  l_EdWin.Caption:='Редактoр группы - ';
  case ADMode of
   atAdd    : l_EdWin.Caption := l_EdWin.Caption + 'ДОБАВИТЬ';
   atDelete : l_EdWin.Caption := l_EdWin.Caption + 'УДАЛИТЬ';
  end;

  l_EdWin.DocFamily := Family;
 (**** l_EdWin.l_LockMask:=$ffffffff; ****)
  if l_EdWin.ExecuteGroupMode(ADMode) then
  begin
   Application.ProcessMessages;
   Screen.Cursor := crHourGlass;
   try
    //l_EdWin.GetGroupData(l_GData);

    //with l_GData do
    // l_ParamSetted := (FullName <> '')
    //                   or ExpDateSetted or ActDateSetted or (StatusSetted <> 0) or (rPriority > 0);

    l_EdWin.Document.PrepareEditablePartsInfo;


    if IniRec.DirectDocStorageAccess then
     l_Helper := TarDirectMultiModifyDocsHelper.Create(ADMode,
      l_EdWin.Document.DocFamily, IniRec.AnouncedDate, dtMakeSortedIDListBySab(DocList.Query.GetDocIdList))
    else
     l_Helper := TarRemoteMultiModifyDocsHelper.Create(ADMode,
      l_EdWin.Document.DocFamily, IniRec.AnouncedDate, DocList.Query.GetDocIdList);

    try

     try
      try
       l_EdWin.Document.TextSource.Save(l_Helper.Generator);
      except
       l_Helper.SignalException;
       raise;
      end;
     finally
      l_Helper.ModifyDocs;
     end;
     if l_Helper.HasLockedDocs then
     begin
      l_ErrWin := TAccessErrorWin.Create(Self);
      l_ErrWin.ItemList.Items.DataSize := SizeOf(TdaDocID);
      l_Helper.FillLockedList(l_ErrWin.ItemList.Items);
     end;


(*
     lDBFilter := lMakeDBFilter;
     try
      lDBFilter.StartCachingData;
      try
       l_EdWin.Document.TextSource.Save(lDBFilter);
      finally
       lDBFilter.DoneCachingData;
      end;

      ProcessForAnoncedList(lDBFilter.DocIDList_forAnonced);
      ProcessForIZMList(lDBFilter.DocIDList_forIZM);

      l_AddToDenyList(lDBFilter.RejectedDocsID);
     finally
      l3Free(lDBFilter);
     end;
*)

    finally
     l3Free(l_Helper);
    end;
    //DocList.PercentMeter.ProgressProc(piEnd, 0, 0,'');
   finally
    Screen.Cursor := crDefault;
    if l_ErrWin <> nil then
     l_ErrWin.ShowModal;
   end;

   if l_ParamSetted then
   begin
    DocList.RefreshQueryResults;
   end;//if l_ParamSetted then

  end;//if l_EdWin.ExecuteGroupMode(ADMode) then
 finally
  l_EdWin.Free;
 end;
end;

function TSearchWin.DeleteDoc(aDocID : TDocID) : Boolean;
var
 l_LockHandle : TJLHandle;
begin
 Result := False;

 l_LockHandle := LockServer.FullLockDoc(Family, aDocID);
 try
  if l_LockHandle = -1 then
   vtMessageDlg(l3CStr(@sidDocLockDeny), mtWarning)
   //raise El3NoLoggedException.Create(sidDocLockDeny)
  else
  begin
   //HLServer.DocId := aDocId;

   if (aDocId > 0) and // аварийное удаление нулевого дока
      LinkServer(Family).HLinkTbl.CheckHLinkOnSub(aDocId, AllSubs) and
      (vtMessageDlg(l3CStr(@sidLinkedDocDelQst), mtConfirmation, [mbYes, mbNo], 0, mbNo, mbNo) = mrNo) then
    Exit;  
   try
    Screen.Cursor := crHourGlass;
    DocumentServer(Family).DelDoc(aDocID);
    Result := True;
   finally
    Screen.Cursor := crDefault;
   end;
  end;
 finally
  LockServer.UnLockDoc(Family, l_LockHandle);
 end;
end;

procedure TSearchWin.miDeleteDocClick(Sender: TObject);
var
 l_Doc           : PDocListAccessRec;
 l_ExtNum        : Integer;
 l_IntNum        : Integer;
 I               : Longint;
 l_SelectedCount : Cardinal;
 l_Buttons       : TMsgDlgButtons;
 l_WithRequest   : Boolean;
 l_RequestResult : Integer;
 l_RealDelItem   : Boolean;
 l_Sab           : ISab;
 l_NumberStr     : AnsiString;

 procedure lMakeNumberStr(const aSab : ISab; var aStr : AnsiString);

  function lRecAccessProc(aBuffer : Pointer) : Boolean;
   begin
    Result := True;
    with PRenumRec(aBuffer)^ do
     aStr := aStr + Format(' #%d (Garant #%d)', [RealID, ImportID])
   end;

 var
  l_Sab               : ISab;
  l_RecAccessProcStub : TdtRecAccessProc;
 begin
  l_Sab := MakeSabCopy(aSab);
  l_Sab.RecordsByKey(rnRealID_fld, MakePhoto(LinkServer(Family).Renum));
  aStr := '';
  l_RecAccessProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   l_Sab.IterateRecords(l_RecAccessProcStub, [rnRealID_fld, rnImportID_fld]);
  finally
   FreeRecAccessProc(l_RecAccessProcStub);
  end;
 end;

 procedure lOutToDeletedLst(const aSab : ISab);

  function lRecAccessProc(aBuffer : Pointer) : Boolean;
  begin
   Result := True;
   vtLogFile.AppendToLogLN(IniRec.PathToDeletedFileList, Format('!TOPIC %d',[PInteger(aBuffer)^]));
  end;

 var
  l_Sab               : ISab;
  l_RecAccessProcStub : TdtRecAccessProc;

 const
  cNoDoc : TUserType = utNoDoc;
 begin
  l_Sab := MakeSabCopy(aSab);
  l_Sab.RecordsByKey;
  l_Sab.SubSelect(fUserType_Fld, cNoDoc);
  if l_Sab.Count = 0 then exit;
  l_Sab.ValuesOfKey(fId_Fld);
  l_Sab.RecordsByKey(rnRealID_fld, MakePhoto(LinkServer(Family).Renum));

  l_RecAccessProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   l_Sab.IterateRecords(l_RecAccessProcStub, [rnImportID_fld]);
  finally
   FreeRecAccessProc(l_RecAccessProcStub);
  end;
 end;

var
 lNeedOutToDelLog    : Boolean;

begin
 l_RealDelItem := False;
 if DocList.SrchResultLister.Total <= 0 then Exit;
 l_SelectedCount := DocList.SrchResultLister.SelectedCount;
 if l_SelectedCount = 0 then Exit;

 if not l3TestMask(AccessServer.GetSelfMask(Family), acfDelete) then
 begin
  vtMessageDlg(l3Fmt(sidDeleteDenied, [sidAccessDeny]), mtError);
  Exit;
 end;

 if l_SelectedCount = 1 then
  l_Buttons := [mbYes, mbNo]
 else
  l_Buttons := [mbYes, mbAll, mbNo];
 l_WithRequest := True;
 DocList.InDeleteCycle(True);
 try
  for I := DocList.SrchResultLister.Total - 1 downto 0 do
   if DocList.SrchResultLister.Selected[I] then
   begin
    l_Doc := DocList.QueryProvider.GetItem(I);
    if l_WithRequest then
     l_RequestResult := vtMessageDlg(l3Fmt(sidDelDocAsk,
                        [DocumentServer(Family).FileTbl.GetRecordByUniq(l_Doc^.rID).GetStrField(fFName_Fld)]),
                       mtConfirmation, l_Buttons, 0, mbNo, mbNo)
    else
     l_RequestResult := mrYes;
    if (l_RequestResult = mrCancel) then Break;
    if l_RequestResult = mrAll then
    begin
     l_WithRequest := False;
     l_RequestResult := mrYes;
     with DocList.SrchResultLister do
      if SelectedCount = Total then
      begin
       Screen.Cursor:=crHourglass;
       try
        l_Sab := DocList.QueryProvider.MakeDocIDList;
        lMakeNumberStr(l_Sab, l_NumberStr);
        lOutToDeletedLst(l_Sab);
        //быстрое удаление без лишних вопросов
        DocumentServer(Family).DelDocs(l_Sab);

        l3System.Msg2Log(Format(cDocDeleted,
                                [l_NumberStr, dsGetCurrentUserName]));

        l_RealDelItem := True;
        Break;
       finally
        Screen.Cursor:=crDefault;
       end;
      end;//if SelectedCount = Total then
    end;//if l_RequestResult = mrAll then
    if l_RequestResult = mrYes then
     try
      l_IntNum := l_Doc^.rID;
      lNeedOutToDelLog := TUserType(l_Doc^.rFlag) = utNodoc;
      l_ExtNum := LinkServer(Family).Renum.GetExtDocID(l_Doc^.rID);
      if DeleteDoc(l_Doc^.rID) then
      begin
       l_RealDelItem := True;
       l3System.Msg2Log(Format(cDocDeleteEX, [l_IntNum, l_ExtNum, dsGetCurrentUserName]));
       if lNeedOutToDelLog then
        vtLogFile.AppendToLogLN(IniRec.PathToDeletedFileList, Format('!TOPIC %d',[l_ExtNum]));
      end;
     except
      on E : Exception do
      begin
       l3System.Exception2Log(E);
       Application.ShowException(E);
      end;
     end;
    DocList.SrchResultLister.Selected[I] := False;
   end;//if DocList.SrchResultLister.Selected[I] then
 finally
  DocList.InDeleteCycle(False);
 end;
 //if l_RealDelItem then
 // DocList.QueryChanged;
end;

procedure TSearchWin.MergeWithAnotherDocSet(aQuery : TdtQuery; aMergeMode : Tl3BoolOp);
begin
 if (aQuery.FoundList = nil) or (aQuery.FoundList.Count = 0) then
 begin
  vtMessageDlg(str_sidEmptyViborka.AsCStr, mtError, [mbOk]);
  Exit;
 end; // if (aQuery.FoundList = nil) or (aQuery.FoundList.Count = 0) then
 DocList.QueryProvider.MergeWith(aQuery, aMergeMode);
 Modified := True;
 DocList.SrchResultLister.Current := 0;
end;

function  TSearchWin.Print : Boolean;
var
 l_PrintEngine : TevPrintEngine;
 I             : Longint;
 l_Doc         : PDocListAccessRec;
begin
 Result := True;
 l_PrintEngine := TevPrintEngine.Create;
 try
  with l_PrintEngine do
  begin
   AddHeader(f_SrchName, '');
   for I := 0 to DocList.SrchResultLister.Total - 1 do
   begin
    l_Doc := DocList.QueryProvider.GetItem(I);
    AddPlainPara(Format(#10'[ID : %d]%s'#10'%s',
                        [LinkServer(Family).Renum.GetExtDocID(l_Doc^.rID),
                         cInactText[not l_Doc^.rIsActive],
                         l3ArrayToString(l_Doc^.rName, SizeOf(TFullNameStr))]));
   end;
   Print;
  end;
 finally
  l3Free(l_PrintEngine);
 end;
end;

procedure TSearchWin.OutListToStream(aStream : Tl3Stream; aSelectOnly : Boolean = false);
var
 l_TextStream : Tl3TextStream;
 I            : Longint;
 lDoc         : PDocListAccessRec;
 l_S          : AnsiString;
begin
 if (aStream is Tl3TextStream) then
  l_TextStream := aStream.Use
 else
  l_TextStream := Tl3TextStream.Create(aStream);
 try
  if aSelectOnly and (DocList.SrchResultLister.Total = DocList.SrchResultLister.SelectedCount) then
   aSelectOnly := False;
  with l_TextStream do
  begin
   for I := 0 to Pred(DocList.SrchResultLister.Total) do
    if not aSelectOnly or DocList.SrchResultLister.Selected[I] then
    begin
     lDoc := DocList.QueryProvider.GetItem(I);
     l_S:= IntToStr(lDoc^.rExtID)+#9;
     Write(l_S[1], Length(l_S));     // LinkServer(Family).Renum.GetExtDocID(lDoc^.rID));
     Write(lDoc^.rName, l3SizeOfTextArray(@lDoc^.rName, SizeOf(TFullNameStr)));
     l_S:= #13#10;
     Write(l_S[1], Length(l_S));
    end;
   if (aStream is Tl3ClipboardStream) then
   begin
    l_S:= #0;
    Write(l_S[1], 1);
   end;
  end;
 finally
  l3Free(l_TextStream);
 end;
end;

function  TSearchWin.Copy  : Boolean;
var
 l_Stream : Tl3ClipboardStream;
begin
 l_Stream := Tl3ClipboardStream.Create(l3_fmWrite);
 try
  OutListToStream(l_Stream, True);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TSearchWin.DoSaveDocsList2File(const aFileName: AnsiString);
var
 l_S         : AnsiString;
 l_TextStream: Tl3TextStream;
begin
 l_TextStream := Tl3TextStream.Create(aFileName, l3_fmWrite);
 try
  if f_SrchName <> '' then
   l_TextStream.Write(f_SrchName[1], Length(f_SrchName));
  l_S := Format('Количество найденных: %d', [DocList.QueryProvider.Count]);
  l_TextStream.Write(l_S[1], Length(l_S));
  OutListToStream(l_TextStream);
 finally
  l3Free(l_TextStream);
 end;
end;

procedure TSearchWin.actSaveDocAsExecute(Sender: TObject);
var
 l_FileName: AnsiString;
begin
 if vtExecuteSaveDialog(l_FileName, sidLSTDlgFilter) then
  DoSaveDocsList2File(l_FileName);
end;

{.$Define NumOfSpr}
function  TSearchWin.Paste : Boolean;
var
 l_Stream    : Tl3ClipboardStream;
 lNumSab     : ISab;
 lNumSabSpr  : ISab;
 lVSFiller   : IValueSetFiller;
 l_Parser    : Tl3Parser;
 l_CurNum    : Integer;
 lIterator   : TdtRecAccessProc;
 lIntNumber  : Boolean;

 function RAIterator(aRec : Pointer) : Boolean;
 begin
  Result := True;
  DocList.QueryProvider.AddID(TDocID(aRec^));
 end;

begin
 Result := True;
 lIntNumber := False;
 l_Stream := Tl3ClipboardStream.Create(l3_fmRead);
 try
  lNumSab := MakeSab(LinkServer(Family).Renum);
  lVSFiller := lNumSab.MakeValueSetFiller(rnImportID_fld);
  try
   l_Parser := Tl3Parser.Create;
   try
    l_Parser.NullAsEOF := True;
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := l_Stream;
    l_Parser.NextTokenSp;
    l_Parser.Filer.SoftEnterAsEOL := True;

    if (l_Parser.TokenType = l3_ttSingleChar) and (l_Parser.TokenChar = '#') then
    begin
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
     lIntNumber := True;
    end;

    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      try
       l_CurNum := l_Parser.TokenInt;
       lVSFiller.AddValue(l_CurNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   lVSFiller := nil;
  end;
 finally
  l3Free(l_Stream);
 end;

 if lNumSab.isEmpty then Exit;

 if not lIntNumber then
  lNumSab.ValuesOfKey(rnRealID_fld);

 {и справки из клипборда доставать}
 lNumSabSpr := MakeSabCopy(lNumSab);
 lNumSabSpr.TransferToPhoto(fRelated_fld, DocumentServer(Family).FileTbl);
 lNumSabSpr.ValuesOfKey(fId_Fld);
 lNumSab.TransferToPhoto(fId_Fld, lNumSabSpr);
 lNumSab.OrSab(lNumSabSpr);
 lNumSabSpr := nil;

 lIterator := L2RecAccessProc(@RAIterator);
 try
  DocList.QueryProvider.Changing;
  try
   lNumSab.IterateRecords(lIterator);
  finally
   DocList.QueryProvider.Changed;
  end;
 finally
  FreeRecAccessProc(lIterator);
 end;
 Modified := True;
end;

function TSearchWin.Save : Boolean;
begin
 Result := True;
 if DocList.WasSaved then
 begin
  if DocList.Modified then
  begin
   fSavedQuery.Save(DocList.Query);
   DocList.Modified := False;
   DocList.WasSaved := True;
  end;
 end
 else
  SaveAs;
end;

function TSearchWin.SaveAs : boolean;
var
 lSQ : TSavedQuery;
 l_Q: TdtQuery;
begin
 Result := True;

 //if DocList.SrchResultLister.Total <= 0 then Exit;
 with TDocSetParamDlg.Create(Self) do
  try
   NameEdit.Text := SrchName;
   if not DocList.IsDocListQuery then
   begin
    rgSaveMethod.ItemIndex := 1;
    rgSaveMethod.Enabled := False;
   end;


   while True do
   begin
    if ShowModal = mrOk then
    begin
     if g_dtQueryList.FindByName(NameEdit.Text, lSQ) then
     begin
      with TSaveTroubleDlg.Create(Self) do
       try
        case ShowModal of
         mrOk     : g_dtQueryList.DelSQuery(lSQ);
         mrRetry  : Continue;
         mrCancel : Break;
        end;
       finally
        Free;
       end;
     end; //if AsksList.FindStr(PChar(NameEdit.Text), l_SID) then

     if (rgSaveMethod.ItemIndex = 1) and (not DocList.IsIDList) then
     begin
      l_Q := MakeIDList(DocList.Query);
      try
       DocList.Query := l_Q;
      finally
       l3Free(l_Q);
      end;
     end;

     l3Set(fSavedQuery, g_dtQueryList.SaveQuery(NameEdit.Text, DocList.Query));
     DocList.WasSaved  := True;
     DocList.Modified  := False;
     SrchName   := NameEdit.Text;
    end; //if ShowModal = mrOk then
   Break;
  end; //while True do
 finally
  Free;
 end;

end;

procedure TSearchWin.SrchResultListerCountChanged(Sender: TObject; NewCount: Integer);
begin
 SetSpeedButton(True);
end;

procedure TSearchWin.FindButtonClick(Sender: TObject);
begin
 if TTextSearchDlg.Execute(Self) then
  MainForm.acFindNext.Enabled := True;
end;

procedure TSearchWin.FindAgainButtonClick(Sender: TObject);
begin
 TTextSearchDlg.FindNext(Self);
end;

procedure TSearchWin.ShowDocSet(const aDocRecs: ISab);
begin
 DocList.SetQueryFrom(aDocRecs);
end;

procedure TSearchWin.actOpenDocumentExecute(Sender: TObject);
begin
 DocList.RunEditor(Sender, False);
end;

procedure TSearchWin.actOpenSelectedDocumentsExecute(Sender: TObject);
begin
 DocList.RunEditorForAllSelected(Sender, False);
end;

procedure TSearchWin.actAddSetExecute(Sender: TObject);
var
 l_Query: TdtQuery;
begin
 l_Query := SelectQuery;
 if l_Query <> nil then
  MergeWithAnotherDocSet(l_Query, l3_boOr);
end;

procedure TSearchWin.actTraverseSetExecute(Sender: TObject);
var
 l_Query: TdtQuery;
begin
 l_Query := SelectQuery;
 if l_Query <> nil then
  MergeWithAnotherDocSet(l_Query, l3_boAnd);
end;

function TSearchWin.SelectQuery: TdtQuery;
begin
 Result := nil;
 with TGetDocSetDlg.Create(Self) do
  try
   if Execute(Self) then
    Result := TSearchWin(lstDocSet.Items.Objects[lstDocSet.Current]).DocList.Query;
  finally
   Free;
  end;
end;

procedure TSearchWin.actSubstractSetExecute(Sender: TObject);
var
 l_Query: TdtQuery;
begin
 l_Query := SelectQuery;
 if l_Query <> nil then
  MergeWithAnotherDocSet(l_Query, l3_boAndNot);
end;

procedure TSearchWin.WMDropAccept(var Message: TMessage);
begin
 l3System.Translate(DocList, Message);
end;

procedure TSearchWin.DocListSrchResultListerCountChanged(Sender: TObject; NewCount: Integer);
begin
 SetSpeedButton(MainForm.ActiveMDIChild = Self);
 acSaveDocSet.Enabled := NewCount > 0;
 acSaveDocSetAs.Enabled := NewCount > 0;
end;

procedure TSearchWin.miTypeFilterClick(Sender: TObject);
begin
  DocList.acTypeFilterExecute(Sender);
end;

procedure TSearchWin.actSearchStatsExecute(Sender: TObject);
begin
 DocList.miStatisticClick(Sender);
end;

procedure TSearchWin.actGroupAddExecute(Sender: TObject);
begin
 ExecGroupOperation(atAdd);
end;

procedure TSearchWin.actGroupDeleteExecute(Sender: TObject);
begin
 ExecGroupOperation(atDelete);
end;

procedure TSearchWin.actGroupTouchExecute(Sender: TObject);
begin
 TouchGroup;
end;

procedure TSearchWin.actDocExportExecute(Sender: TObject);
begin
{$IFNDEF InsiderTest}
 if g_BaseEngine.WorkWithServer and not MainForm.CheckServer then
  Exit;
{$ENDIF InsiderTest}  
 DoDocExport(Self, (g_BaseEngine.CSClient <> nil) and g_BaseEngine.CSClient.IsStarted);
end;

procedure TSearchWin.miChangeHLinksClick(Sender: TObject);
begin
 DocList.acChangeHLinksExecute(Sender);
end;

procedure TSearchWin.miAddIDtoDocSetClick(Sender: TObject);
begin
  DocList.acInsertDocToObjListExecute(Sender);
end;

procedure TSearchWin.acSaveDocSetExecute(Sender: TObject);
begin
 if DocList.SrchResultLister.Total > 0 then Save;
end;

procedure TSearchWin.acSaveDocSetAsExecute(Sender: TObject);
begin
 if DocList.SrchResultLister.Total > 0 then SaveAs;
end;

procedure TSearchWin.acBatchDeleteAttributesExecute(Sender: TObject);
var
 l_Dlg      : TBatchAttrDelDlg;
 l_Selected : TBADDResult;
 I : Integer;
 l_RightsNeeded: Longint;
(*
 l_LockHandles : Il3IDList;
 l_RejectedDocs : Il3IDList;
 l_AcceptedDocs : Il3IDList;
 l_DLType : TdaDictionaryType;
 l_AttrLogged: Boolean;
 lIDSab : ISab;
*)
 l_AttrSet: set of TdtAttribute;
 l_ErrWin: TAccessErrorWin;
 l_Helper: TarCustomMultiClearAttributesHelper;
 l_SelectedArray: TdaDictionaryTypeArray;
begin
 if DocList.QueryProvider.IsEmpty then Exit;
 l_Dlg := TBatchAttrDelDlg.Create(Self);
 try
  if l_Dlg.Execute then
  begin
   l_Dlg.GetSelectedAttrTypes(l_Selected);
   // формируем маску требуемых прав
   l_AttrSet := [];
   for I := Low(l_Selected) to High(l_Selected) do
    Include(l_AttrSet, l_Selected[I]);
   l_RightsNeeded := 0;
   if (atClasses in l_AttrSet) or (atPrefixes in l_AttrSet) then
   begin
    l_RightsNeeded := l_RightsNeeded or acgClass;
    Exclude(l_AttrSet, atClasses);
    Exclude(l_AttrSet, atPrefixes);
   end;
   if (atKeyWords in l_AttrSet) then
   begin
    l_RightsNeeded := l_RightsNeeded or acgKeyWord;
    Exclude(l_AttrSet, atKeyWords);
   end;
   if l_AttrSet <> [] then
    l_RightsNeeded := l_RightsNeeded or acgNameAttr;
   Assert(l_RightsNeeded <> 0);



   SetLength(l_SelectedArray, Length(l_Selected));
   for I := Low(l_Selected) to High(l_Selected) do
    l_SelectedArray[I] := AttrID2DLType(l_Selected[I]);


   if IniRec.DirectDocStorageAccess then
    l_Helper := TarDirectMultiClearAttributesHelper.Create(Family, dtMakeSortedIDListBySab(DocList.Query.GetDocIdList), l_RightsNeeded, l_SelectedArray)
   else
    l_Helper := TarRemoteMultiClearAttributesHelper.Create(Family, DocList.Query.GetDocIdList, l_RightsNeeded, l_SelectedArray);

   try
    l_Helper.ClearAttributes;
    if l_Helper.HasRejectedDocs then
    begin
     l_ErrWin := TAccessErrorWin.Create(Self);
     try
      l_Helper.FillRejectedList(l_ErrWin.ItemList.Items);
      l_ErrWin.ShowModal;
     finally
      l3Free(l_ErrWin);
     end;
    end
    else
     vtMessageDlg(l3CStr('Очистка атрибутов успешно завершена'), mtInformation);
   finally
    FreeAndNil(l_Helper);
   end;

(*
   l_LockHandles  := l3MakeIDList;
   l_AcceptedDocs := l3MakeIDList;
   l_RejectedDocs := l3MakeIDList;
   LockServer.BatchLockDoc(Family, DocList.QueryProvider.MakeDocIDList, l_RightsNeeded,
       l_LockHandles, l_AcceptedDocs, l_RejectedDocs);
   try
    if (l_AcceptedDocs <> nil) and (l_AcceptedDocs.Count > 0) then
    begin
     lIDSab := MakeValueSet(DocumentServer(Family).FileTbl, fId_Fld, l_AcceptedDocs);
     try
      l_AttrLogged := False;
      for I := Low(l_Selected) to High(l_Selected) do
      begin
       l_DLType := AttrID2DLType(l_Selected[I]);
       LinkServer(Family).Links[l_DLType].DelAllLinkItems(lIDSab);
       case l_DLType of
        da_dlPrefixes,
        da_dlClasses  : LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acClassWork);
        da_dlKeyWords : LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acKWWork);
       else
        if not l_AttrLogged then
        begin
         LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acAttrWork);
         l_AttrLogged := True;
        end;
       end;{case}
      end;{for}
     finally
      lIDSab := nil;
     end;
    end;
   finally
    LockServer.BatchUnlockDoc(Family, l_LockHandles);
   end;
   // отображаем список документов, которые не удалось поменять
   if (l_RejectedDocs <> nil) and (l_RejectedDocs.Count > 0) then
   begin
    l_ErrWin := TAccessErrorWin.Create(Self);
    try
     for I := 0 to pred(l_RejectedDocs.Count) do
      AddToDenyList(Family, l_RejectedDocs[I], l_ErrWin.ItemList.Items, True);

     l_ErrWin.ShowModal;
    finally
     l3Free(l_ErrWin);
    end;
   end
   else
    vtMessageDlg(l3CStr('Очистка атрибутов успешно завершена'), mtInformation);
*)
  end;
 finally
  l3Free(l_Dlg);
 end;
end;

procedure RenumerateExtID;
var
 lStream    : Tl3ClipboardStream;
 lParser    : Tl3Parser;
 lOldNum   : TDocID;
 lNewNum   : TDocID;

 AbsNum     : LongInt;
 RecH       : RHANDLE;
 tmpID      : LongInt;
begin
 lStream := Tl3ClipboardStream.Create(l3_fmRead);
 try
  lParser := Tl3Parser.Create;
  try
   lParser.CheckFloat := False;
   lParser.CheckFiler.Stream := lStream;
   lParser.NextToken;

   while lParser.TokenType <> l3_ttEOF do
   begin
    lOldNum := lParser.TokenInt;
    lParser.NextToken;
    lNewNum := lParser.TokenInt;
    with LinkServer(CurrentFamily).Renum do
    begin
     AbsNum := Ht(htRecordByUniq(nil, Table.Handle, rnImportID_fld, @lOldNum, @RecH));
     if AbsNum > 0 then
     begin
      Table.GetFullRec(AbsNum, True);
      Table.PutToFullRec(rnImportID_fld, lNewNum);
      Table.UpdFRec(AbsNum);
     end;
    end;
    lParser.Filer.ReadLn;
    lParser.NextToken;
   end;
  finally
   l3Free(lParser);
  end;
 finally
  l3Free(lStream);
 end;
end;

procedure TSearchWin.miDocPrintClick(Sender: TObject);
begin
  DocList.acPrintAllExecute(Sender);
end;

procedure TSearchWin.DocListmiAddIDtoDocSetClick(Sender: TObject);
begin
  DocList.acAddIDtoDocSetExecute(Sender);
end;

procedure TSearchWin.miDocInfoClick(Sender: TObject);
begin
  DocList.acDocInfoExecute(Sender);
end;

procedure TSearchWin.actIZMExecute(Sender: TObject);
var
(*
 l_Count: Integer;
 lIZMIDs : ISab;
 lValue : Byte;
*)
 l_Helper: TarCustomMultiOperationHelper;
begin

 if IniRec.DirectDocStorageAccess then
  l_Helper := TarDirectMultiOperationHelper.Create(Family, ar_moTouchIZM, DocList.QueryProvider.MakeDocIDList)
 else
  l_Helper := TarRemoteMultiOperationHelper.Create(Family, ar_moTouchIZM, DocList.QueryProvider.MakeDocIDList);
 try
  Screen.Cursor := crHourglass;
  try
   l_Helper.ModifyDocs;
  finally
   Screen.Cursor := crDefault;
  end;
  if l_Helper.ProcessedDocsCount = 0 then
   vtMessageDlg(l3CStr('Документов не найдено'), mtInformation)
  else
   vtMessageDlg(l3CStr(Format('В %d документах проставлено IZM', [l_Helper.ProcessedDocsCount])), mtInformation);
 finally
  FreeAndNil(l_Helper);
 end;


(*
 Screen.Cursor := crHourglass;
 try
  l_Count := GetIZMChecker.CheckoutForIZM(DocList.Query.FoundList, lIZMIDs);

  // всем докам выборки ставим ИЗМ
  //lIZMIDs := MakeSabCopy(DocList.Query.FoundList);
  //lIZMIDs.ValuesOfKey(fId_Fld);
  //l_Count := lIZMIDs.Count;
 finally
  Screen.Cursor := crDefault;
 end;

 if l_Count = 0 then
  vtMessageDlg(l3CStr('Документов не найдено'), mtInformation)
 else
 begin
  //OutSab2File(lIZMIDs, 'd:\IZM.lst');
  if vtMessageDlg(l3CStr(Format('Найдено документов: %d'#13#10'Проставить "IZM"?', [lIZMIDs.Count])), mtConfirmation, [mbYes, mbNo]) = mrYes then
  begin
   LinkServer(Family).LogBook.PutLogRecToDocs(lIZMIDs, acAttrWork);
   lValue := Byte(utIzm);
   lIZMIDs.RecordsByKey;
   lIZMIDs.ModifyRecs(fUserType_Fld, lValue);
   vtMessageDlg(l3CStr('Сделано'), mtInformation);
  end;
 end;
*)

end;

procedure TSearchWin.acRefreshResultExecute(Sender: TObject);
begin
 DocList.RefreshQueryResults(True {aWithReSearch});
end;

procedure TSearchWin.miSaveToEVDClick(Sender: TObject);
begin
 DocList.acSaveToEVDExecute(Sender);
end;

procedure TSearchWin.acExpandEditionExecute(Sender: TObject);
begin
 DocList.ExpandEdition;
end;

procedure TSearchWin.acGetCorrespondentsExecute(Sender: TObject);
begin
 if DocList.SrchResultLister.Total = 0 then Exit;
 MainForm.ShowCorrespondentsForList(Self);
end;

procedure TSearchWin.acGetRespondentsExecute(Sender: TObject);
begin
 if DocList.SrchResultLister.Total = 0 then Exit;
 MainForm.ShowRespondentsForList(Self);
end;

procedure TSearchWin.acSendToServerExecute(Sender: TObject);
var
 l_Task: TcsUserDefinedExport;
begin
 if not MainForm.CheckServer then
  Exit;
 Save;
 l_Task:= TcsUserDefinedExport.Create({Sender,} GlobalDataProvider.UserID);
 try
  l_Task.QueryFile:= fSavedQuery.FileName;
  l_Task.Comment:= fSavedQuery.Name;
  ArchiRequestManager.SendTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TSearchWin.acKTDocNameChangeExecute(Sender: TObject);
var
(*
 l_OutPipe  : TSewerPipe;
 l_KTFilter : TddKTExtractorTermFilter;
 l_DocNameFilter: TddDocNameUpdateFilter;
 l_Filename: AnsiString;
 l_Sab: ISab;
*)

 l_Helper: TarCustomMultiOperationHelper;
begin
 if DocList.Query.IsEmpty then
  Exit;
 Screen.Cursor := crHourglass;
 try

  if IniRec.DirectDocStorageAccess then
   l_Helper := TarDirectMultiOperationHelper.Create(Family, ar_moChangeKeywords, DocList.QueryProvider.MakeDocIDList(False))
  else
   l_Helper := TarRemoteMultiOperationHelper.Create(Family, ar_moChangeKeywords, DocList.QueryProvider.MakeDocIDList(False));
  try
   l_Helper.ModifyDocs;
   DocList.RefreshQueryResults;
  finally
   FreeAndNil(l_Helper);
  end;


(*
  l_Filename := ConcatDirName(GlobalHtServer.Family[CurrentFamily].Path, sKTFilename);
  LoadKTScan(l_Filename);
  l_OutPipe := TSewerPipe.Create;
  try
   l_OutPipe.ExportDocument:= True;
   l_OutPipe.Attributes := cAllMainRecData;
   l_OutPipe.ExportDocTypes := [dtText];
   l_KTFilter := TddKTExtractorTermFilter.Create;
   try
    l_OutPipe.Writer := l_KTFilter;
    l_DocNameFilter := TddDocNameUpdateFilter.Create;
    try
     l_KTFilter.Generator := l_DocNameFilter;

     l_Sab := DocList.QueryProvider.MakeDocIDList(False);
     try
      //f_OutPipe.Progressor := aProgressor;
      l_OutPipe.DocSab := l_Sab;
      DocumentServer(CurrentFamily).FileTbl.StartCaching([roUpdate]);
      try
       l_OutPipe.Execute;
       LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(l_Sab, acAttrWork);
      finally
       DocumentServer(CurrentFamily).FileTbl.StopCaching;
      end;
     finally
      l_Sab := nil;
     end;
    finally
     FreeAndNil(l_DocNameFilter);
    end;
   finally
    FreeAndNil(l_KTFilter);
   end;
  finally
   FreeAndNil(l_OutPipe);
  end;
  DocList.RefreshQueryResults;
*)
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TSearchWin.actAutoSpellExecute(Sender: TObject);
var
 l_Task: TcsAutoSpellTask;
 l_Sab: ISab;
begin
 if not MainForm.CheckServer then
  Exit;
 Save;
 l_Task:= TcsAutoSpellTask.Create({Sender,} GlobalDataProvider.UserID);
 try
  l_Sab := DocList.QueryProvider.MakeDocIDList;
  dtCopyValuesSabToList(l_Sab, l_task.DocumentIDList);
  ArchiRequestManager.SendTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
end;

procedure TSearchWin.actGroupAutolinkExecute(Sender: TObject);
var
 l_Answer: Integer;
 l_Task: TcsAutolinkerTask;
begin
 if DocList.SrchResultLister.Total = 0 then Exit;
 l_Answer := vtMessageDlg(l3CStr('Перед расстановкой, удалить существующие ссылки в документах?'), mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbNo);
 if l_Answer = mrCancel then
  Exit;
(*
 l_Task := TcsAutolinkerTask.Create;
 try
  l_Task.ClearLinksBeforeRun := l_Answer = mrYes;
  dtCopyValuesSabToList(DocList.QueryProvider.MakeDocIDList, l_Task.DocumentIDList);
  ArchiRequestManager.SendTask(l_Task);
 finally
  FreeAndNil(l_Task);
 end;
*)

 try
  ReAutolinkDocs(l_Answer = mrYes);
 finally
  CleanupAutolinkServer;
 end;

 
end;

procedure TSearchWin.actGroupSetCloneExecute(Sender: TObject);
begin
 SetCloneToPublishedIns;
end;

procedure TSearchWin.FormShow(Sender: TObject);
begin
 UserConfig.Section := 'PREFERENCES';
 actGroupAutolink.Visible := UserConfig.ReadParamBoolDef(sEnableAutolinkParam, False) and (bfAutoLink in g_BaseEngine.BaseFlags);
 MainForm.CheckServer(True);
 Perform(WM_SERVERSTATUSCHANGED, 0, 0);
end;

procedure TSearchWin.ReAutolinkDocs(aClearLinks: Boolean);
var
 lIDSab : ISAB;
 l_AL: TddAutoLinker;
 l_Progress: TddProgressObject;
 l_Dlg: TddSimpleProgressDialog;
begin
 lIDSab := DocList.QueryProvider.MakeDocIDList;
 l_AL := GetAutoLinker;
 l_Progress := TddProgressObject.Create;
 try
  l_Dlg := TddSimpleProgressDialog.Create(Application);
  try
   l_Dlg.Caption := 'Простановка ссылок на выборке';
   l_Progress.OnUpdate := l_Dlg.UpdateProc;
   l_Dlg.Show;
   l_AL.SetLinks(lIDSab, l_Progress, aClearLinks);
  finally
   l_Progress.OnUpdate := nil;
   FreeAndNil(l_Dlg);
  end;
 finally
  FreeAndNil(l_Progress);
 end;
end;

{$I HTDefine.inc}
function lpSetClone(gRecNo: LongInt; fpRecord: Pointer; fpUser  : Pointer) : MFUNC_RET; {$IFDEF HT_MODE64} stdcall {$ELSE} pascasl {$ENDIF};
begin
 Result := MFUNC_SUCCESS;
 PPublishLinkRec(fpRecord)^.Flags := PPublishLinkRec(fpRecord)^.Flags or pinfClone;
end;

procedure TSearchWin.SetCloneToPublishedIns;
var
(*
 l_LinkList: ISab;
 l_BadDocList: ISab;
 l_BadLinkList: ISab;
 l_AccProc: TdtRecAccessProc;
*)
 l_ErrWin: TAccessErrorWin;
 l_Helper: TarCustomMultiOperationHelper;
(*
 function l_AddErrorDocs(aDocID : PDocID) : Boolean; register;
 var
  l_ImpId: TDocID;
  l_Msg: AnsiString;
 begin
  l_ImpId := LinkServer(CurrentFamily).Renum.GetExtDocID(aDocID^);
  l_Msg := IntToStr(l_ImpId);
  l_ErrWin.ItemList.Items.AddStr(l_Msg, @l_ImpId);
 end;
*)
begin
 Screen.Cursor := crHourglass;
 try


  if IniRec.DirectDocStorageAccess then
   l_Helper := TarDirectMultiOperationHelper.Create(Family, ar_moSetClonePublishedin, DocList.Query.FoundList)
  else
   l_Helper := TarRemoteMultiOperationHelper.Create(Family, ar_moSetClonePublishedin, DocList.Query.FoundList);
  try
   l_Helper.ModifyDocs;
   if l_Helper.HasErrorDocs then
   begin
    // выводим список документов, у которых больше одного источника опубликования => нельзя ставить пометку
    l_ErrWin := TAccessErrorWin.Create(Self);
    try
     l_ErrWin.ItemList.Items.DataSize := SizeOf(Longint);
     l_ErrWin.Caption := 'ОШИБКИ: Не удалось установить пометку "клон" (несколько ИО)';
     l_Helper.FillErrorDocsList(l_ErrWin.ItemList.Items);
     Screen.Cursor := crDefault;
     l_ErrWin.ShowModal;
    finally
     FreeAndNil(l_ErrWin);
    end;
   end;
  finally
   FreeAndNil(l_Helper);
  end;

(*
  // найдём список всех линков источников опубликования к документам
  l_LinkList := MakeSabCopy(DocList.Query.FoundList);
  l_LinkList.ValuesOfKey(fId_Fld);
  l_LinkList.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily)[atPublisheds]);
  l_LinkList.RecordsByKey;

  // теперь найдём список всех линков, которых больше двух к одному документу
  l_BadDocList := MakeSabCopy(l_LinkList);
  l_BadDocList.ValuesOfKeyByCount(lnkDocIDFld);
  //BadDocList.ValuesOfKey(1);

  l_BadLinkList := MakeSabCopy(l_BadDocList);

  l_BadDocList.TransferToPhoto(fId_Fld, DocumentServer(Family).FileTbl);
  l_BadDocList.RecordsByKey; // саб со списком "плохих" документов (для отчёта)

  l_BadLinkList.TransferToPhoto(lnkDocIDFld, LinkServer(CurrentFamily)[atPublisheds]);
  l_BadLinkList.RecordsByKey; // саб со списком "плохих" линков, чтобы выкинуть из списка обработки

  // вычитаем результаты
  l_LinkList.SubtractSab(l_BadLinkList);
  l_BadLinkList := nil;

  // правим поле Flags
  l_LinkList.ModifyRecs(@lpSetClone);

  if l_BadDocList.Count > 0 then
  begin
   // выводим список документов, у которых больше одного источника опубликования => нельзя ставить пометку
   l_ErrWin := TAccessErrorWin.Create(Self);
   try
    l_ErrWin.ItemList.Items.DataSize := SizeOf(Longint);
    l_ErrWin.Caption := 'ОШИБКИ: Не удалось установить пометку "клон" (несколько ИО)';
    l_AccProc := L2RecAccessProc(@l_AddErrorDocs);
    try
     l_BadDocList.IterateRecords(l_AccProc, [fId_Fld]);
    finally
     FreeRecAccessProc(l_AccProc);
    end;
    Screen.Cursor := crDefault;
    l_ErrWin.ShowModal;
   finally
    FreeAndNil(l_ErrWin);
   end;
  end;
*)

 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TSearchWin.WMServerStatusChanged(var Message: TMessage);
var
 l_Online: Boolean;
begin
 l_Online := ArchiRequestManager.ServerOnline;
{$IFNDEF InsiderTest}
 actDocExport.Enabled := not g_BaseEngine.WorkWithServer or l_Online;
{$ENDIF InsiderTest}
 acSendToServer.Enabled := l_Online;
 actAutoSpell.Enabled := l_Online;
end;

end.
