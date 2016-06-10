unit SrchWin;

{ $Id: SRCHWIN.PAS,v 1.300 2016/06/03 09:24:39 fireton Exp $ }

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
    procedure SetFamily(Value : TFamilyID);
    function  GetFamily : TFamilyID;
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

    property  Family   : TFamilyID read GetFamily write SetFamily;
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
 DT_Log, DT_User, DT_Stage,
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
 csAutoSpell, csUserRequestManager,
 arVAnouncedBlackList;

const
 cDocSetheader = 'ВЫБОРКА ДОКУМЕНТОВ';
 cInactText : array[Boolean] of AnsiString = ('', ' Документ утратил силу');
 cDocDeleted = 'Удален документ %s пользователем %s';
 cDocDeleteEX = 'Удален документ #%d (Garant #%d) пользователем %s';
 cUserMsg      = 'Пользователь : %s';
 cUsersMsg     = 'Пользователи : %s';
 cStationMsg  = 'Станция : %s';
 cAccessHoldByUser = 'Доступ захвачен пользователем (';
 //cDocAccessDeny = 'Невозможно получить доступ к документу [GarantID = %d] по группе доступа "%S".';
 cDocAccessDeny = 'Невозможно получить доступ к документу [GarantID = %d].';
 cProblemWithTopic = 'Проблемы с топиком %d';
 cProcessOfSyncCompleate = 'Процесс синхронизации завершен';
 cNeedInputNumber = 'Установить "%S"';
 cDictID = 'ID элемента словаря';
 cDeleting = 'Deleting...';
 cAvarageTimeOfProcessing = 'Среднее время обработки %d суток';
 cCountOfIncludedDocs = 'Учтена информация %d документов';

 sKTFilename = 'kthemes.csv';

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

function  TSearchWin.GetFamily : TFamilyID;
begin
 Result := DocList.Family;
end;

procedure TSearchWin.SetFamily(Value : TFamilyID);
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
 lIDSab : ISAB;
 // настоящее
begin
 if DocList.SrchResultLister.Total <= 0 then Exit;
 lIDSab := DocList.QueryProvider.MakeDocIDList;
 LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acAttrWork);
end;

procedure AddToDenyList(aFamily: TFamilyID; aDocID: TDocID;{ aAssessItem : Longint;}
    aList: Tl3StringDataList; aReqUserNames: Boolean = False; aIgnoredLockHandle : TJLHandle = -1);
var
 l_Msg      : AnsiString;
 l_Station  : TStationNameArray;
 l_UserID   : TUserIDArray;
 l_UsersStr : AnsiString;
 I          : Integer;
 lImpId     : TDocID;
begin
 l_Msg := '';
 if aReqUserNames then
 begin
  LockServer.WhoLockDoc(aFamily, aDocID, l_Station, l_UserID, aIgnoredLockHandle);
  //l_Msg := Format(cStationMsg, [l_Station]);
  if Length(l_UserID) > 0 then
  begin
   l_UsersStr := '';
   for I := Low(l_UserID) to High(l_UserID) do
   begin
    if l_UsersStr <> '' then
     l_UsersStr := l_UsersStr + ', ';
    l_UsersStr := l_UsersStr + GlobalDataProvider.UserManager.GetUserName(l_UserID[I]);
   end;

   if High(l_UserID) > 0 then
    l_Msg := l_Msg + Format(cUsersMsg, [l_UsersStr])
   else
    l_Msg := l_Msg + Format(cUserMsg, [l_UsersStr]);
   l_Msg := ^M + cAccessHoldByUser + l_Msg +')';
  end;
 end;
 lImpId := LinkServer(aFamily).Renum.GetExtDocID(aDocID);
 l_Msg := Format(cDocAccessDeny, [lImpId{, GetAssGroupName(aAssessItem)}]) + l_Msg;
 aList.AddStr(l_Msg, @lImpId);
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

 procedure l_AddToDenyList(const aIDList : Il3IDList);
 var
  I : Cardinal;
 begin
  if aIDList.Empty then Exit;

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

var
 lDocIDList_forAnonced : Il3IDList;
 lDocIDList_forIZM : Il3IDList;

{gr op}
begin
 lDocIDList_forAnonced := nil;
 lDocIDList_forIZM := nil;

 l_SavedDocID := 0;
 l_LogActionSet := [];
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
 l_LockHandles : Il3IDList;
 l_RejectedDocs : Il3IDList;
 l_AcceptedDocs : Il3IDList;
 I : Integer;
 l_AttrSet: set of TdtAttribute;
 l_RightsNeeded: Longint;
 l_DLType : TdaDictionaryType;
 l_AttrLogged: Boolean;
 l_ErrWin: TAccessErrorWin;
 l_RejIterator: TdtRecAccessProc;
 lIDSab : ISab;
 //function RejIterator(aRec : Pointer) : Boolean;
 //begin
 // Result := True;
 // AddToDenyList(Family, TDocID(aRec^), {l_RightsNeeded,} l_ErrWin.ItemList.Items, True);
 //end;

begin
 if DocList.QueryProvider.IsEmpty then Exit;
 l_Dlg := TBatchAttrDelDlg.Create(Self);
 try
  if l_Dlg.Execute then
  begin
   try
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
     finally
      LockServer.BatchUnlockDoc(CurrentFamily, l_LockHandles);
     end;
   finally
   end;
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
 l_Count: Integer;
 lIZMIDs : ISab;
 lValue : Byte;
begin
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
 l_OutPipe  : TSewerPipe;
 l_KTFilter : TddKTExtractorTermFilter;
 l_DocNameFilter: TddDocNameUpdateFilter;
 l_Filename: AnsiString;
 l_Sab: ISab;
begin
 if DocList.Query.IsEmpty then
  Exit;
 Screen.Cursor := crHourglass;
 try
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
begin
 if DocList.SrchResultLister.Total = 0 then Exit;
 l_Answer := vtMessageDlg(l3CStr('Перед расстановкой, удалить существующие ссылки в документах?'), mtConfirmation, [mbYes, mbNo, mbCancel], 0, mbNo);
 if l_Answer = mrCancel then
  Exit;
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
 l_LinkList: ISab;
 l_BadDocList: ISab;
 l_BadLinkList: ISab;
 l_ErrWin: TAccessErrorWin;
 l_AccProc: TdtRecAccessProc;

 function l_AddErrorDocs(aDocID : PDocID) : Boolean; register;
 var
  l_ImpId: TDocID;
  l_Msg: AnsiString;
 begin
  l_ImpId := LinkServer(CurrentFamily).Renum.GetExtDocID(aDocID^);
  l_Msg := IntToStr(l_ImpId);
  l_ErrWin.ItemList.Items.AddStr(l_Msg, @l_ImpId);
 end;
begin
 Screen.Cursor := crHourglass;
 try
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

(*
for l_It := 0 to Pred(DocList.SrchResultLister.Total) do
      begin
       l_Doc := DocList.QueryProvider.GetItem(l_It);
      {$IfNDef FastAttrSet}
       l_LockHandle := LockServer.LockDoc(Family, l_Doc^.rID, l_MaxMask, l_LockMask);
      {$else}
       l_LockMask :=$ffffffff;
      {$EndIf FastAttrSet}
       try
        l_EdWin.Document.TextSource.Save(lDBFilter);

        with l_GData do
        begin
         if ((l_LockMask and romNameAttr) = 0) then
         begin
          if l_ParamSetted then l_AddToDenyList(romNameAttr);
         end//if ((l_LockMask and romNameAttr) = 0) then
         else
         begin
          if l_ParamSetted then
          begin
           DocumentServer(Family).GroupUpdateDoc(l_Doc^.rID, FullName, ''{ShortName},
                                        Status, StatusSetted,
                                        UserType, UserTypeSetted,
                                        rPriority);
           lAddToLog(acAttrWork);
          end;//

          //GetIZMChecker.CheckoutForIZM(l_Doc^.rID);

         end;//else if ((l_LockMask and romNameAttr) = 0) then
        end;//with l_GData do
       finally
       {$IfNDef FastAttrSet}
        if l_LockHandle >= 0 then
         LockServer.UnLockDoc(Family,l_LockHandle);
       {$EndIf FastAttrSet}
       end;
       DocList.PercentMeter.ProgressProc(piCurrent, 0, Succ(l_It), '');
      end;//for l_It := 0 to Pred(DocList.SrchResultLister.Total) do
*)

(*
Сносил Stage stDocFormat
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lValue : Integer;
begin
 lSab := MakeSab(LinkServer(Family).Attribute[atStages]);
 lValue := ord(stDocFormat);
 lSab.Select(stType_Key, lValue);
 lSab.DeleteFromTable;
end;
*)

(*procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lStatusOffs : Word;
 function lModifyRec(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 begin
  PWord(PChar(fpRecord)+lStatusOffs)^ := PWord(PChar(fpRecord)+lStatusOffs)^ or dstatNotTM;
  Result := MFUNC_SUCCESS;
 end;

var
 lHTStub    : Pointer;
begin
 lStatusOffs := DocumentServer.FileTbl.FldOffset[fStatus_Fld];
 lSab := MakeAllRecords(DocumentServer.FileTbl);

 lHTStub := HTStub3(@lModifyRec);
 try
  DocumentServer.FileTbl.ModifyRecs(lSab.HTSab, lHTStub, false {aDupIgnore});
 finally
  HTStubFree(lHTStub);
 end;
end;
*)

(*procedure TSearchWin.TouchGroup;
var
 lAction : TLogActionType;
 lSab : ISab;
 lSabIncl : ISab;
begin
 DocumentServer.Family := Family;
 lSab := MakeAllRecords(DocumentServer.FileTbl);
 lSab.ValuesOfKey(fId_Fld);

 {Стирает VIncluded у пачки}
 lSabIncl := MakeSab(LinkServer(Family).LogBook);
 lAction := acIncluded;
 lSabIncl.Select(lgAction_Key, lAction);
 lSabIncl.ValuesOfKey(lgDocID_Key);
 lSabIncl.TransferToPhoto(fId_Fld, lSab);

 lSab.SubtractSab(lSabIncl);

 {Добавляет VIncluded пачку}
 LinkServer(Family).LogBook.PutLogRecToDocs(lSab, lAction, 0, CurrentDate +9);
end;
*)
(*
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lSabD : ISAB;
 lValue : Integer;

begin
 DocumentServer.Family := Family;
 lSab := MakeAllRecords(DocumentServer.FileTbl);

 lSab.ValuesOfKeyByCount(fRelated_fld);

 lSabD := MakeSabCopy(lSab);
 lSab.TransferToPhoto(fId_Fld, DocumentServer.FileTbl);
 DocumentServer.DelDocs(lSab);

 lSabD.RecordsByKey;
 lValue := 0;
  // уберем нулевое значение
 lSabD.SubSelect(fRelated_fld, lValue, Not_Equal);

 lSabD.ModifyRecs(fRelated_fld, lValue, True);
 lSabD.ValuesOfKey(fId_Fld);
 OutSab2File(lSabD, 'd:\docWdblspr.lst');


 {
 OutSab2File(lSab, 'd:\dblspr.lst');

 //lSab := MakeSab(LinkServer(Family).Attribute[atDateNums]);
 lSab := MakeSab(DictServer(Family).Tbl[da_dlDateNums]);
 lValue := dnLawCaseNum;
 lSab.Select(dnTypFld, lValue);

 lSab.ValuesOfKeyByCount(dnNumFld);
 }
 //LinkServer(Family).LogBook.PutLogRecToDocs(lIDSab, acAnnoWork, 64 {Соловьев});
end;
*)

{begin
}

(*
 var
  lOldID : Integer;
  lNewID : Integer;
  lFilteredIDList : Sab;
begin
 // менять ID атрибута в выборке
 {lOldID := 0;
 lNewID := 0;
 if not RequestAttrCopyData(lOldID, lNewID, Self, 'Замена префиксов') then Exit;
 LinkServer.Family := CurrentFamily;
 lFilteredIDList := DocList.SrchServ.FilteredIDList;
 LinkServer[da_dlPrefixes].ModifyDictID(lOldID, lNewID, @lFilteredIDList);
 }


 // выставление атрибутов в file.tbl для выборки
 //lBoolValue := True;
 //DocumentServer.FileTbl.ModifyRecs(DocList.SrchServ.GetFilteredSrchList, fPriorFlag_fld, @lBoolValue);

 //lWordValue := 399;
 //DocumentServer.FileTbl.ModifyRecs(DocList.SrchServ.GetFilteredSrchList, fPriority_fld, @lWordValue);

 //lValue := Byte(utIzm);
 //DocumentServer.FileTbl.ModifyRecs(DocList.SrchServ.GetFilteredSrchList, fUserType_Fld, @lValue);

 //Удаляет записи из LOG
 //LinkServer(Family).LogBook.DeleteRecords(2, DateTimeToStDate(StrToDate('09.08.2004')),DateTimeToStDate(StrToDate('09.08.2004')));

 (*
 // удаляет !CODE для выборки
 if DocList.SrchServ.SrchCount = 0 then Exit;
 //список ID
 lIDSab := DocList.QueryProvider.MakeDocIDList;

 // Список Dict_ID
 LinkServ[da_dlDateNums].SrchOnIDs(lIDSab, lDictIDSab);

 DictServer.Family := Family;
 with DictServer.GroupTbl[da_dlDateNums] do
 begin
  RefreshSrchList;
  //перевели список в таблицу словаря
  htTransferToPhoto(lDictIDSab, fSrchList, dtIDFld);
  // получили записи
  htSortResults(lSorted, lDictIDSab, 0, 0);
  htRecordsByKey(lDictRecords,lSorted);


  //отобрали записи с непустым номером
   htSubSearch(lDictRecords, lDictRecordsNotEmptyNum, TblH, 3 {Num}, not_EQUAL, @cEmptyNum, nil);

  //нашли записи с пустой датой
  htSubSearch(lDictRecordsNotEmptyNum, lDictRecordsEmptyDate, TblH, 2 {Date}, EQUAL, @DT_Const.BlankDate, nil);

  //вычли из списка, остальным надо занулить номер
  htXorResults(lDictRecordsReplNum, lDictRecordsNotEmptyNum, lDictRecordsEmptyDate);

  if lDictRecordsReplNum.gFoundCnt > 0 then
   ModifyRecs(lDictRecordsReplNum, 3 {Num}, @cEmptyNum);
 end;

 //записи с пустой датой надо удалить
 htValuesOfKey(lDictRecordsEmptyDateValues, 1, lDictRecordsEmptyDate);
 // из dict
 htDeleteRecords(lDictRecordsEmptyDate);
 //из link
 with LinkServ[da_dlDateNums] do
 begin
  htTransferToPhoto(lDictRecordsEmptyDateValues, fSrchList, lnkBodyFld);
  htRecordsByKey(lLinkRecordsEmptyDate, lDictRecordsEmptyDateValues);
  htDeleteRecords(lLinkRecordsEmptyDate);
 end;

 htClearResults(lIDSab);
 htClearResults(lDictIDSab);
 htClearResults(lSorted);
 htClearResults(lDictRecords);
 htClearResults(lDictRecordsNotEmptyNum);
 htClearResults(lDictRecordsEmptyDate);
 htClearResults(lDictRecordsReplNum);
 htClearResults(lLinkRecordsEmptyDate);
 htClearResults(lDictRecordsEmptyDateValues);

end;
 *)

 (*
замена номеров топиков для соловьева
в клипборде два столбика внешних номеров - "откуда" и "куда"

function  TSearchWin.Paste : Boolean;
var
 l_Stream    : Tl3ClipboardStream;
 l_TmpStream : Tl3MemoryStream;
 l_Parser    : Tl3Parser;
 l_HasAdded  : Boolean;
 l_CurNum    : Integer;
 l_NewNum    : Integer;
 lSab : ISab;
begin
 Result := True;
 l_HasAdded := False;
 l_Stream := Tl3ClipboardStream.Create(l3_fmRead);
 try
  l_TmpStream := Tl3MemoryStream.Create;
  l_TmpStream.Size := 0;
  try
   l_Parser := Tl3Parser.Create(nil);
   try
    l_Parser.CheckFloat := False;
    l_Parser.CheckFiler.Stream := l_Stream;
    l_Parser.NextTokenSp;

    DocumentServer.Family := Family;
    while l_Parser.TokenType <> l3_ttEOF do
    begin
     if l_Parser.TokenType = l3_ttInteger then
     begin
      try
       l_CurNum := l_Parser.TokenInt;
       l_Parser.NextTokenSp;
       l_NewNum := l_Parser.TokenInt;

       l_CurNum := DocumentServer.RenumTbl.ConvertToRealNumber(l_CurNum);

       l_NewNum := DocumentServer.RenumTbl.ConvertToRealNumber(l_NewNum);

       if (l_CurNum = 0) or (l_NewNum = 0) then
        Assert(false, 'Не бывает');

       lSab := MakeSab(DocumentServer.FileTbl);
       lSab.Select(fRelated_fld, l_CurNum);
       lSab.ModifyRecs(fRelated_fld, l_NewNum);
       //DocumentServer.FileTbl.SetRelated(l_CurNum, l_NewNum);
      except
      end;
     end;
     l_Parser.Filer.ReadLn;
     l_Parser.NextTokenSp;
    end;
    if l_HasAdded then
    begin
    end;
   finally
    l3Free(l_Parser);
   end;
  finally
   l3Free(l_TmpStream);
  end;
 finally
  l3Free(l_Stream);
 end;
end;
*)

(*
восстанавливаем покоцанные адреса гиперссылок
копированием из левой таблицы "hlink_"
в aStream внешние номера доков
* )
procedure ReplaceHLink(aStream : Tl3MemoryStream);
var
 lSabOld   : ISab;
 lSabNew   : ISab;
 lOldHLinkTbl : TdtTable;

 lStub : TdtBlockAccessProc;
 lDocIDFld : ThtField;
 lTable    : TdtTable;
 lDonorTblName : AnsiString;

 function lBlockAccessProc(aBuffer: Pointer; aBufSize: Longint) : Boolean; register;
 begin
  Result := True;
  with lTable do
   AddRecs(aBuffer, aBufSize div RecSize);
 end;

begin
 HLServer.Family := 1;
 DocumentServer.Family := 1;
 LinkServer.Family := 1;


 lDocIDFld := hlSourD_fld;
 lTable := HLServer.HLinkTbl;
 lDonorTblName := 'hlink__';


 {lDocIDFld := 1;
 lTable := DocumentServer.ActiveIntervalTbl;
 lDonorTblName := 'activ_';
 }

 {
 lDocIDFld := 1;
 lTable := LinkServer.Links[da_dlAccGroups];
 lDonorTblName := 'LNK#F_';
 }

 lSabNew := MakeValueSet(DocumentServer.RenumTbl, rnImportID_fld, aStream);
 lSabNew.RecordsByKey;
 lSabNew.ValuesOfKey(rnRealID_fld);

 lOldHLinkTbl := TdtTable.CreateWithOpen('d:\oldHL\', '', lDonorTblName, 1);
 lSabOld := MakeSabCopy(lSabNew);
 lSabOld.TransferToPhoto(lDocIDFld, lOldHLinkTbl);
 lSabOld.RecordsByKey;

 lSabNew.TransferToPhoto(lDocIDFld, lTable);
 lSabNew.RecordsByKey;
 lSabNew.DeleteFromTable;

 lStub := L2BlockAccessProc(@lBlockAccessProc);
 try
  lSabOld.IterateBlockOfRecords(lStub, []);
 finally
  FreeBlockAccessProc(lStub);
 end;

 l3Free(lOldHLinkTbl);
end;
//*)

(*
копирование адресов ссылок
procedure TSearchWin.DeleteAllHyperLinks;
var
 //l_Cnt : Integer;
 lDonorTbl : TAbsHtTbl;
 lDonorSab : ISab;
 lHLSab    : ISab;
begin
 HLServer.Family := CurrentFamily;
 //if vtMessageDlg(l3CStr(@sidQstDeleteAllHyperLinks), mtConfirmation, [mbYes, mbNo]) <> mrYes then Exit;
 //l_Cnt := HLServer.HLinkTbl.DelDocsHLink(DocList.QueryProvider.MakeDocIDList(True));
 //vtMessageDlg(l3Fmt(sidDeleteAllHyperLinksResult, [l_Cnt]));

 // откроем доп таблицу HLINk

 //inherited Create(aFamily,TablePassword(ftHLink), FamTblName(ftHLink, aFamily), aSharing);
 lDonorTbl := TAbsHtTbl.CreateWithOpen(GlobalHtServer.FamilyTbl.FamilyPath(1{aFamily}),
                                       '' {aPass},
		                       'HLINKOLD' {aName},
                                       GlobalHtServer.HyTechTableOpenMode);
 try
  lDonorSab := MakeSabCopy(DocList.QueryProvider.MakeDocIDList);
  lDonorSab.TransferToPhoto(hlSourD_fld, MakePhoto(lDonorTbl));
  lDonorSab.RecordsByKey;

  HLServer.Family := CurrentFamily;
  HLServer.HLinkTbl.DelDocsHLink(DocList.QueryProvider.MakeDocIDList);
  //lHLSab := MakeSab(lDonorTbl, DocList.QueryProvider.MakeDocIDList));

  HLServer.HLinkTbl.CopyRecs(lDonorSab.HTSab, nil);

 finally
  l3Free(lDonorTbl);
 end;

end;
*)

(*
procedure TSearchWin.SetDictLinks(aDictType : TdaDictionaryType; aReplace : Boolean = False);
var
 lRec : packed record
  rDictID : TDictID;
  rSubID    : TSubID;
 end;

 lSab      : ISab;
begin
 if not RequestIntegerValue(Integer(lRec.rDictID), Self, Format(cNeedInputNumber, [GetAttrName(ord(aDictType))]), cDictID) then Exit;

 lSab := DocList.QueryProvider.MakeDocIDList;

 lSab.TransferToPhoto(lnkDocIDFld, LinkServ[aDictType]);

 lSab.RecordsByKey;
 lSab.SubSelect(lnkDictIDFld, lRec.rDictID);

 lRec.rSubID := 0;
 lSab.ModifyRecs(lnkSubIDFld, lRec.rSubID, true);
end;
*)
 (*
 //спецсредства
 procedure DelIncludedLogOnDocsID(aIDs : ISab);
 var
  lAction : TLogActionType;
  lSab : ISab;
 begin
  lSab := MakeSabCopy(aIDs);
  {Стирает VIncluded у пачки}
  lSab.TransferToPhoto(lgDocID_Key, LinkServer(Family).LogBook);
  lSab.RecordsByKey;
  lAction := acIncluded;
  lSab.SubSelect(lgAction_Key, lAction);
  lSab.DeleteFromTable;

  {Добавляет VIncluded пачку}
  LinkServer(Family).LogBook.PutLogRecToDocs(aIDs, lAction, 0, CurrentDate - 3);
 end;
 *)

(*
procedure TSearchWin.ExecGroupOperation(ADMode : TOperActionType);
var
 l_It          : Longint;
 I             : Longint;
 l_LockHandle  : TJLHandle;
 l_MaxMask     : Longint;
 l_LockMask    : Longint;
 l_EdWin       : TDocEditorWindow;
 l_GData       : TGroupData;
 l_ParamSetted : Boolean;
 l_Doc         : PDocListAccessRec;
 l_ErrWin      : TAccessErrorWin;
 l_Attribute   : IDocAttribute;

 procedure l_AddToDenyList(aAssessItem : Longint);
 begin
  if l_ErrWin = nil then
  begin
   l_ErrWin := TAccessErrorWin.Create(Self);
   l_ErrWin.ItemList.Items.DataSize := SizeOf(Longint);
  end;
  AddToDenyList(Family, l_Doc^.rID, aAssessItem, l_ErrWin.ItemList.Items,
    l_MaxMask and not l_LockMask <> 0, l_LockHandle);
 end;

 function SetDictListToDoc(aDict : TdtAttribute; aAccessItem : Longint) : Boolean;
 var
  l_Attribute : IDocAttribute;
 begin
  Result := False;
  if not IsLegalAttr(TDocType(l_Doc^.rTyp), aDict) then Exit;

  l_Attribute := l_EdWin.Document.Attribute[aDict];
  if l_Attribute.IsEmpty then Exit;
  with (l_Attribute as IListDocAttribute) do
   if l3TestMask(l_LockMask, aAccessItem) then
   begin
    Result := True;
    if (aDict = atDateNums) and (ADMode = atAdd) then
     LinkServer(Family).SetGroupDateNumList(l_Doc^.rID, List)
    else
    if (aDict in GlSingleItemLinkAttrSet) and (ADMode = atAdd) then
     LinkServer(Family).SetGroupAttributeList(aDict, l_Doc^.rID, List, atMove)
    else
     LinkServer(Family).SetGroupAttributeList(aDict, l_Doc^.rID, List, ADMode)
   end
   else
    begin
     l_AddToDenyList(aAccessItem);
     Result := False;
    end;
 end;
{.$Define SilentAttrSet}
{.$Define FastAttrSet} // без захвата документа
var
 l_SavedDocID   : TDocID;
 l_LogActionSet : TLogActionSet;

 procedure lAddToLog(aAction : TLogActionType);
 begin
  {$IfNDef SilentAttrSet}
   if l_Doc^.rID <> l_SavedDocID then
   begin
    l_SavedDocID := l_Doc^.rID;
    l_LogActionSet := [];
   end;
   if not (aAction in l_LogActionSet) then
   begin
    LinkServer(Family).LogBook.PutLogRec(l_Doc^.rID, aAction);
    l_LogActionSet := l_LogActionSet + [aAction];
   end;
  {$EndIf SilentAttrSet}
 end;

Procedure DelIncludedLogOnDocsID(aIDs : ISab);
var
 lAction : TLogActionType;
 lSab : ISab;
begin
 lSab := MakeSabCopy(aIDs);
 {Стирает VIncluded у пачки}
 lSab.TransferToPhoto(lgDocID_Key, LinkServer(Family).LogBook);
 lSab.RecordsByKey;
 lAction := acIncluded;
 lSab.SubSelect(lgAction_Key, lAction);
 lSab.DeleteFromTable;

 {Добавляет VIncluded пачку}
 LinkServer(Family).LogBook.PutLogRecToDocs(aIDs, lAction, 0, CurrentDate - 3);
end;

begin
 l_SavedDocID := 0;
 l_LogActionSet := [];
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
  if l_EdWin.ExecuteGroupMode(ADMode) then
  begin
   Application.ProcessMessages;
   Screen.Cursor:=crHourGlass;
   try
    l_EdWin.GetGroupData(l_GData);

    DocList.PercentMeter.ProgressProc(piStart, 0, DocList.SrchResultLister.Total, 'Групповая операция');
    // стирал vincluded у пачки          

    //DelIncludedLogOnDocsID(DocList.QueryProvider.MakeDocIDList);
    //Exit;
    with l_GData do
     l_ParamSetted := (FullName <> '') 
                       or ExpDateSetted or ActDateSetted or (StatusSetted <> 0) or (rPriority > 0);

    for l_It := 0 to Pred(DocList.SrchResultLister.Total) do
    begin
     l_Doc := DocList.QueryProvider.GetItem(l_It);
     {$IfNDef FastAttrSet}
      l_LockHandle := LockServer.LockDoc(Family, l_Doc^.rID, l_MaxMask, l_LockMask);
     {$else}
      l_LockMask :=$ffffffff;
     {$EndIf FastAttrSet}
     try
      {!!!}
      //Убираем/проставляем HasAnno
      {!!
      DocumentServer.FileTbl.SetHasAnno(l_Doc^.rID, True);
      Continue;}
      with l_GData do
      begin
       if ((l_LockMask and romNameAttr) = 0) then
       begin
        if l_ParamSetted then l_AddToDenyList(romNameAttr);
       end//if ((l_LockMask and romNameAttr) = 0) then
       else
       begin
        if l_ParamSetted then
        begin
          DocumentServer(Family).GroupUpdateDoc(l_Doc^.rID, FullName, ''{ShortName},
                                       Status, StatusSetted,
                                       UserType, UserTypeSetted,
                                       rPriority);
         lAddToLog(acAttrWork);
        end;//
       end;//else if ((l_LockMask and romNameAttr) = 0) then

       {$B+}
       if SetDictListToDoc(atDateNums, romNameAttr) or
          SetDictListToDoc(atTypes, romNameAttr) or
          SetDictListToDoc(atSources, romNameAttr) or
          SetDictListToDoc(atTerritories, romNameAttr) or
          SetDictListToDoc(atWarnings, romNameAttr) or
          SetDictListToDoc(atBases, romNameAttr) or
          SetDictListToDoc(atPublisheds, romNameAttr) or
          SetDictListToDoc(atServiceInfo, romNameAttr)
        then
         lAddToLog(acAttrWork);
       {$B-}

       if SetDictListToDoc(atAccGroups, romDocGroup) then
        lAddToLog(acAttrWork); // acDocGroupWork

       if SetDictListToDoc(atAnnoClasses, romAnno) then
        lAddToLog(acAnnoWork);

       {$B+}
       if SetDictListToDoc(atClasses, romClass) or
          SetDictListToDoc(atPrefixes, romClass) or
          SetDictListToDoc(atNorms, romClass)
        then
         lAddToLog(acClassWork);
       {$B-}
       if SetDictListToDoc(atKeyWords, romKeyWord) then
        lAddToLog(acKWWork);

       l_Attribute := l_EdWin.Document.Attribute[atStages];
       if not l_Attribute.IsEmpty then
        with (l_Attribute as IListDocAttribute) do
        begin
         //LinkServer(Family).Stages.SetDocStagesRecList(l_Doc^.rID, List);
         for I := 0 to Pred(List.Count) do
          with PStageFullRec(List.Data[I])^ do
          begin
           if LinkServer(Family).Stages.PutStageRec(l_Doc^.rID, TStageType(StType), BDate, EDate, Author) then
           begin
            if (TStageType(StType) = stUrObr) and (EDate > 0 {closed}) then
             GetIZMChecker.CheckoutForIZM(l_Doc^.rID);

            if (TStageType(StType) = stEdit) and (EDate > 0 {closed}) and
               (TUserType(l_Doc^.rFlag) in utFullFeatureDocTypes) and
               (not IsDocAccGroupInAnouncedBlackList(l_Doc^.rID)) then
              LinkServer(Family).LogBook.PutDateLogRec(l_Doc^.rID, acAnonced, DateTimeToStDate(IniRec.AnouncedDate), 0);
           end;
          end;
        end;//with (l_Attribute as IListDocAttribute) do

       l_Attribute := l_EdWin.Document.Attribute[atJurLogRecords];
       if not l_Attribute.IsEmpty then
       with (l_Attribute as IListDocAttribute) do
       begin
        for I := 0 to Pred(Count) do
         with PDisplayLogRec(Data[I])^ do
         begin
          if (TLogActionType(Action) <> acAnnoDate) and
             not l3TestMask(l_LockMask, romJurOp) then
          begin
           l_AddToDenyList(romJurOp);
           Continue;
          end;//if (TLogActionType(Action) <> acAnnoDate) and
          if (TLogActionType(Action) = acAnnoDate) and
             not l3TestMask(l_LockMask, romAnno) then
          begin
           l_AddToDenyList(romAnno);
           Continue;
          end;//if (TLogActionType(Action) = acAnnoDate) and
          LinkServer(Family).LogBook.PutDateLogRec(l_Doc^.rID, TLogActionType(Action), Date, 0);
         end;//with PDisplayLogRec(Data[I])^ do
       end;//with (l_Attribute as IListDocAttribute) do
       //lAddToLog(??acAttrWork);
      end;//with l_GData do
     finally
     {$IfNDef FastAttrSet}
      if l_LockHandle >= 0 then
       LockServer.UnLockDoc(Family,l_LockHandle);
     {$EndIf FastAttrSet}
     end;
     DocList.PercentMeter.ProgressProc(piCurrent, 0, Succ(l_It), '');
    end;//for l_It := 0 to Pred(DocList.SrchResultLister.Total) do
    DocList.PercentMeter.ProgressProc(piEnd, 0, 0,'');
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
*)
{procedure TSearchWin.TouchGroup;
var
 lAction : TLogActionType;
 lSab : ISab;
 lSabIncl : ISab;
 lDate : TStDate;
begin
 //Стирает VIncluded у пачки
 lSabIncl := MakeSab(LinkServer(Family).LogBook);
 lAction := acIncluded;
 lSabIncl.Select(lgAction_Key, lAction);

 lDate := DateTimeToStDate(StrToDate('10.05.2008'));
 lSabIncl.SubSelect(lgDate_Key, lDate);

 lSabIncl.DeleteFromTable;
end;}


(*procedure TSearchWin.TouchGroup;
var
 lAction : TLogActionType;
 lSab : ISab;
 lSabIncl : ISab;
 lValue : byte;
 l_TextStream: Tl3TextStream;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  s : string;
 begin
  Result := True;
  s := inttostr(PInteger(aItemPtr)^)+ #13#10;
  l_TextStream.Write(S[1], length(s));
 end;

 var
  lRAProcStub : TdtRecAccessProc;

begin
 DocumentServer.Family := Family;
 lSab := MakeSab(DocumentServer.FileTbl);
 lValue := 1;
 lSab.Select(fHasAnno_fld, lValue);

 lSabIncl := MakeSab(LinkServer(Family).LogBook);
 lAction := acAnnoWasImported;  //acAnnoWork,        // 15  //acAnnoWasImported, // 16

 lSabIncl.Select(lgAction_Key, lAction);
 lSabIncl.ValuesOfKey(lgDocID_Key);
 lSabIncl.TransferToPhoto(fId_Fld, lSab);
 lSabIncl.RecordsByKey;

 lSab.SubtractSab(lSabIncl);

 lSabIncl := MakeSab(LinkServer(Family).LogBook);
 lAction := acAnnoWork;

 lSabIncl.Select(lgAction_Key, lAction);
 lSabIncl.ValuesOfKey(lgDocID_Key);
 lSabIncl.TransferToPhoto(fId_Fld, lSab);
 lSabIncl.RecordsByKey;

 lSab.SubtractSab(lSabIncl);


 l_TextStream := Tl3TextStream.Create('c:\list.out', l3_fmWrite);
 try
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [fId_Fld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 finally
  l3Free(l_TextStream);
 end;

 lValue := 0;
 lSab.ModifyRecs(fHasAnno_fld, lValue);

end;

procedure TSearchWin.TouchGroup;
var
 lSab : ISab;
 lSabIncl : ISab;
begin
 //Стирает двойные VIncluded
 lSabIncl := MakeSab(LinkServer(Family).LogBook);
 lAction := acIncluded;
 lSabIncl.Select(lgAction_Key, lAction);

 lSab := MakeSabCopy(lSabIncl);
 lSab.Distinct([lgDocID_Key{, lgAction_Keyate_Key}]);
 lSabIncl.SubtractSab(lSab);

 lSabIncl.DeleteFromTable;
end;
*)

(*
 дату менял
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lDateOffs : Word;
 lValue :  TStDate;
type
 PStDate = ^TStDate;

 function lModifyRec(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 begin
  PStDate(PChar(fpRecord)+lDateOffs)^ := lValue;
  Result := MFUNC_SUCCESS;
 end;

var
 lHTStub : Pointer;
 lZeroValue :  TStDate;
begin
 lValue := DMYtoStDate(01, 10, 2014);

 lSab := DocList.QueryProvider.MakeDocIDList;

 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dnIDFld, DictServer(Family).Tbl[da_dlDateNums]);
 lSab.RecordsByKey;

 lZeroValue := 0;
 lSab.SubSelect(dnDateFld, lZeroValue, GREAT);

 lDateOffs := DictServer(Family).Tbl[da_dlDateNums].FldOffset[dnDateFld];

 lHTStub := HTStub3(@lModifyRec);
 try
  DictServer(Family).Tbl[da_dlDateNums].ModifyRecs(lSab.HTSab, lHTStub, false {aDupIgnore});
 finally
  HTStubFree(lHTStub);
 end;

 //lSab := DocList.QueryProvider.FoundList;

 lSab.ValuesOfKey(dnIDFld);
 lSab.TransferToPhoto(lnkDictIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(lnkDocIDFld);
 lSab.TransferToPhoto(fId_Fld, DocumentServer.FileTbl);
 lSab.RecordsByKey;

 lDateOffs := DocumentServer.FileTbl.FldOffset[fSDate_Fld];

 lHTStub := HTStub3(@lModifyRec);
 try
  DocumentServer.FileTbl.ModifyRecs(lSab.HTSab, lHTStub, false {aDupIgnore});
 finally
  HTStubFree(lHTStub);
 end;

end;
*)


(*

//поиск непустых аннотаций с не высталенным флагом HasAnno

{uses
m3DBInterfaces,
 m3StorageInterfaces,
 m2COMLib,
 ComObj,
 evStatisticsFilter,
 evTextFormatter,
 evEvdRd,
 m3DB,
 }
procedure TSearchWin.TouchGroup;
var
 lAction : TLogActionType;
 lSab : ISab;
 lSabIncl : ISab;
 lValue : integer;
 l_TextStream: Tl3TextStream;
 l_DB : Im3DB;
 lCnt : Integer;
 lFoundCnt : Integer;

 function AnnoExists(aDocID : TDocID) : Boolean;

  function HasChar : boolean;
  var
   lTextReader : TevEVDReader;
   lBaseFiler  : Tl3CustomFiler;
   lCntFilter  : TevStatisticsFilter;
  begin
   lTextReader := TevEVDReader.Create;
   try
    lBaseFiler := Tm3DBFiler.Create(l_DB, aDocID, m3_dsAnno);
    try
     lTextReader.Filer := lBaseFiler;
    finally
     l3Free(lBaseFiler);
    end;
    lCntFilter := TevStatisticsFilter.Create;
    try
     lTextReader.Generator := lCntFilter;
     lTextReader.Execute;
     Result := lCntFilter.CharCount > 0;
     //aCharCount := lCntFilter.CharCount;
     //aTableCharCount := lCntFilter.TableCharCount;
     //aCellCount := lCntFilter.CellCount;
    finally
     l3Free(lCntFilter);
    end;{try..finally}
   finally
    l3Free(lTextReader);
   end;
  end;

 var
  lSize : Int64;
 begin
  Result := False;

  try
   lSize := m2ComGetSize(l_DB.GetDocument(aDocID).Open(m3_saRead, m3_dsAnno));
   Result := (lSize > 0) and HasChar;
  except
   on E: EOleSysError do
    if (E.ErrorCode = E_NOTIMPL) OR
       (E.ErrorCode = STG_E_INVALIDFUNCTION) OR
       (E.ErrorCode = STG_E_INVALIDPOINTER) OR
       (E.ErrorCode = E_UNEXPECTED) then
    begin
     Result := true;
    end//E.ErrorCode = E_NOTIMPL..
    else
     raise;
  end;//try..except
 end;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 var
  s : string;
  lID : Integer;
 begin
  inc(lCnt);
  if (lCnt mod 10000) = 0 then
   l3System.Msg2Log(Format('%d', [lCnt]));

  Result := True;
  lID := PInteger(aItemPtr)^;
  {Result := AnnoExists(lID);
  if Result then}
  if AnnoExists(lID) then
  begin
   s := inttostr(lID)+ #13#10;
   l_TextStream.Write(S[1], length(s));
   l3System.Msg2Log(Format('found %d', [lID]));
   Inc(lFoundCnt);
  end;
 end;

 var
  lRAProcStub : TdtRecAccessProc;

begin
 lcnt := 0;
 lFoundCnt := 0;
 DocumentServer.Family := Family;
 lSab := MakeSab(DocumentServer.FileTbl);
 //lSab := DocList.QueryProvider.Query.FoundList;
 // берем все доки у которых fHasAnno_fld = 0
 lValue := 0;
 lSab.Select(fHasAnno_fld, lValue);

 //lValue := 10000;
 //lSab.SubSelect(fId_Fld, lValue, LESS_EQUAL);

 lSab.Sort([fId_Fld]);

 l3System.Msg2Log(Format('Обрабатываем %d', [lSab.Count]));
 // и сканируем на реальное отсутствие текста
 l_DB := dtGetDB(Family);
 try

 l_TextStream := Tl3TextStream.Create('c:\list.out', l3_fmWrite);
 try
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.IterateRecords(lRAProcStub, [fId_Fld]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;

  {lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lSab.SubSelectUserDefined(fId_Fld, lRAProcStub);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;}
 finally
  l3Free(l_TextStream);
 end;

 finally
  l_DB := nil;
 end;//try..finally

 l3System.Msg2Log(Format('Найдено %d', [lFoundCnt]));
 lValue := 1;
 //lSab.ModifyRecs(fHasAnno_fld, lValue);

end;
*)

{procedure TSearchWin.TouchGroup;
var
 lSab : ISab;
 lValue : byte;
begin
 DocumentServer.Family := Family;
 lSab := MakeSabCopy(DocList.QueryProvider.Query.FoundList);

 lValue := 1;
 lSab.ModifyRecs(fHasAnno_fld, lValue);
end; }


{procedure TSearchWin.TouchGroup;
 var
  lAction : TLogActionType;
  lSab : ISab;
  lIDSab : ISAB;
 begin
  lSab := MakeSabCopy(DocList.QueryProvider.MakeDocIDList);
  //Стирает VIncluded у пачки
  lSab.TransferToPhoto(lgDocID_Key, LinkServer(Family).LogBook);
  lSab.RecordsByKey;
  lAction := acIncluded;
  lSab.SubSelect(lgAction_Key, lAction);
  lSab.DeleteFromTable;
 end;
}

{
сносил этапы
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lValue : Integer;
begin
 lSab := MakeSab(LinkServer(Family).Attribute[atStages]);
 lValue := 2; // Бабанин
 //stBDate_Key       = 3;
 //stEDate_Key       = 4;
 //stAuthor_Key      = 5;

 lSab.Select(stAuthor_Key, lValue);

 lValue := DMYtoStDate(9, 6, 2015);
 lSab.subSelect(stBDate_Key, lValue);
 lValue := ord(stAnno);
 lSab.SubSelect(stType_Key, lValue, NOT_EQUAL);
 lValue := ord(stAnnoClass);
 lSab.SubSelect(stType_Key, lValue, NOT_EQUAL);
 lSab.DeleteFromTable;
end;}

(*procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lValue : Integer;
begin
 lSab := MakeSab(LinkServer(Family).Attribute[atStages]);
 lValue := 179339;
 //stBDate_Key       = 3;
 //stEDate_Key       = 4;
 //stAuthor_Key      = 5;

 lSab.Select(stDocID_Key, lValue);
 lValue := 6;
 lSab.SubSelect(stType_Key, lValue);
 lSab.DeleteFromTable;

 TStageTbl(LinkServer(Family).Attribute[atStages]).
  PutStageRec(179339, TStageType(6), 146759, 146759, 75);
end;
*)

(*
//исправляет номера -k:447388418
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lNumOffs : Word;
 lNumLen  : word;
 //lDateOffs : Word;
 //lValue :  TStDate;   l3String
 lValue : TDNType;
 lCount,
 lTotal : integer;

 lStr : Tl3PCharLen;
type
 PStDate = ^TStDate;

 function lModifyRec(gRecNo : LongInt;fpRecord : Pointer) : MFUNC_RET;
 var
  I : Integer;
  lS : String;
 begin
  inc(lCount);
  //if (lCount mod 100000) = 0 then l3System.Msg2Log(Format('%d/%d', [lCount, lTotal]));

  lStr := l3PCharLen(PChar(fpRecord) + lNumOffs, lNumLen);
  lS := l3Str(lStr);
  if not (lStr.s[0] in ['А','A']) then
  begin
   l3System.Msg2Log(Format('Начинается не с А: "%s"', [lS]));
   Exit;
  end;

  lStr := l3FindChar('/', lStr);
  if lStr.sLen < 4 then exit;  // удлинение номера не влезет
  for I := 0 to 1 do
   if not (lStr.s[I] in cc_Digits) then exit;  // не формат

  if lStr.s[2] in cc_Digits then
   Exit // уже все хорошо
  else
  begin
   lStr.s[2] := lStr.s[0];
   lStr.s[3] := lStr.s[1];
   lStr.s[0] := '2';
   lStr.s[1] := '0';
   for I := 4 to pred(lStr.sLen) do
    lStr.s[I] := ' ';
  end;

  //lStr := l3PCharLen(PChar(fpRecord) + lNumOffs, lNumLen);
  //l3System.Msg2Log(Format('"%s" -> "%s"', [lS,  l3Str(lStr)]));

  Result := MFUNC_SUCCESS;
 end;

var
 lHTStub : Pointer;
 //lZeroValue :  TStDate;
begin
 //lValue := DMYtoStDate(01, 10, 2014);

 lSab := MakeSab(DictServer(Family).Tbl[da_dlDateNums]);
 lValue := dnLawCaseNum;
 lSab.Select(dnTypFld, lValue);

 {lSab := DocList.QueryProvider.MakeDocIDList;

 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dnIDFld, DictServer(Family).Tbl[da_dlDateNums]);
 lSab.RecordsByKey;
 }

 lValue := dnLawCaseNum;
 lSab.SubSelect(dnTypFld, lValue);



 lNumOffs := DictServer(Family).Tbl[da_dlDateNums].FldOffset[dnNumFld];
 lNumLen  := DictServer(Family).Tbl[da_dlDateNums].FldLength[dnNumFld];

 lCount := 0;
 lTotal := lSab.Count;

 lHTStub := HTStub3(@lModifyRec);
 try
  DictServer(Family).Tbl[da_dlDateNums].ModifyRecs(lSab.HTSab, lHTStub, false {aDupIgnore});
 finally
  HTStubFree(lHTStub);
 end;
 l3System.Msg2Log('All done!');
end;
*)

(*
// Добавление номера судебного дела в первой инстанции  -k:494533603
procedure TSearchWin.TouchGroup;
var
 lSab : ISAB;
 lSab_ForDelDict : ISAB;
 lSab_ForDelLink : ISAB;
 lNumOffs : Word;
 lNumLen  : word;
 //lDateOffs : Word;
 //lValue :  TStDate;   l3String
 lValue : TDNType;
 lEmptyStr : string;
 lCount,
 lTotal : integer;
 lSab_DocIDs : ISAB;
 lJoinSabDN_DocID : IJoinSAB;

 lStr : Tl3PCharLen;
 lAttrCache : TCacheDirectAddAttrData;

type
 PStDate = ^TStDate;

function lNormNumStr(lStr : Tl3PCharLen) : boolean;
 var
  I : Integer;
  lS : String;
 begin
  Result := false;
  lStr := l3FindChar('/', lStr);
  if lStr.sLen < 4 then exit;  // удлинение номера не влезет
  for I := 0 to 1 do
   if not (lStr.s[I] in cc_Digits) then exit;  // не формат

  if lStr.s[2] in cc_Digits then
   //Result := True // уже все хорошо
  else
  begin
   lStr.s[2] := lStr.s[0];
   lStr.s[3] := lStr.s[1];
   lStr.s[0] := '2';
   lStr.s[1] := '0';
   for I := 4 to pred(lStr.sLen) do
    lStr.s[I] := ' ';
  end;
  Result := True;
 end;

function lRecAccessProc(fpRecord : Pointer) : Boolean;
 begin
  Result := True;
  inc(lCount);
  if (lCount mod 100000) = 0 then l3System.Msg2Log(Format('%d/%d', [lCount, lTotal]));

   lStr := l3PCharLen(PChar(fpRecord) + lNumOffs, lNumLen);

  if not (lStr.s[0] in ['А','A']) then
  begin
   l3System.Msg2Log(Format('#%d Начинается не с А: "%s"', [PInteger(fpRecord)^, l3Str(lStr)]));
   Exit;
  end;

  if lNormNumStr(lStr) then
  begin
   lAttrCache.AddRecord([PInteger(fpRecord)^, 0, Tl3ConstString.MakeI(lStr), ord(dnLawCaseNum), PChar(nil), 0]);
   //l3System.Msg2Log(Format('%d "%s"', [PInteger(fpRecord)^,  l3Str(lStr)]));
  end;
 end;

var
 //lHTStub : Pointer;
 lRAProcStub : TdtRecAccessProc;
 //lZeroValue :  TStDate;
begin
 //lValue := DMYtoStDate(01, 10, 2014);

 //lSab := MakeSab(DictServer(Family).Tbl[da_dlDateNums]);
 //lValue := dnLawCaseNum;
 //lSab.Select(dnTypFld, lValue);

 // тут типа мы вручную нашли все доки с (группа документов = "Практика арбитражных судов первой инстанции")
 lSab := DocList.QueryProvider.MakeDocIDList;

 lSab.TransferToPhoto(lnkDocIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab_DocIDs := MakeSabCopy(lSab);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dnIDFld, DictServer(Family).Tbl[da_dlDateNums]);
 lSab.RecordsByKey;

 lValue := dnLawCaseNum;
 lSab.SubSelect(dnTypFld, lValue);

 lSab_ForDelDict := MakeSabCopy(lSab);

 lEmptyStr := ' ';
 lSab_ForDelDict.SubSelect(dnNumFld, lEmptyStr[1]);

 lSab.SubtractSab(lSab_ForDelDict);

 lSab_ForDelLink := MakeSabCopy(lSab_ForDelDict);
 lSab_ForDelLink.ValuesOfKey(dnIDFld);
 lSab_ForDelLink.TransferToPhoto(lnkDictIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab_ForDelLink.RecordsByKey;

 lSab.ValuesOfKey(dnIDFld);
 lSab.TransferToPhoto(lnkDictIDFld, LinkServer(Family).Attribute[atDateNums]);
 lSab.RecordsByKey;
 lSab.ValuesOfKey(lnkDocIDFld);

 lSab_DocIDs.SubtractSab(lSab);
 lSab_DocIDs.RecordsByKey;

 lSab := MakeSabCopy(lSab_DocIDs);
 lSab.ValuesOfKey(lnkDictIDFld);
 lSab.TransferToPhoto(dnIDFld, DictServer(Family).Tbl[da_dlDateNums]);
 lSab.RecordsByKey;
 lValue := dnPublish;
 lSab.SubSelect(dnTypFld, lValue);
 lEmptyStr := ' ';
 lSab.SubSelect(dnNumFld, lEmptyStr[1], NOT_EQUAL);


 //объединение DN-DocID
 lJoinSabDN_DocID := MakeJoinSab(lSab, dnIDFld,
                                 lSab_DocIDs, lnkDictIDFld);

 lJoinSabDN_DocID.Distinct(lJoinSabDN_DocID.TranslateFieldNumber([JFRec(lSab_DocIDs.Table, lnkDocIDFld)]));

 lNumOffs := 4;
 lNumLen  := DictServer(Family).Tbl[da_dlDateNums].FldLength[dnNumFld];


 lAttrCache := TCacheDirectAddAttrData.Create(CurrentFamily, ctDateNum);
 DictServer(Family).Tbl[da_dlDateNums].FreeNumsCacheSize := 10000;
 lCount := 0;
 lTotal := lJoinSabDN_DocID.Count;
 try

  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   lJoinSabDN_DocID.IterateJoinRecords(lRAProcStub, [JFRec(lSab_DocIDs.Table, lnkDocIDFld), JFRec(lSab.Table, dnNumFld)]);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
 finally
  l3Free(lAttrCache);
  DictServer(Family).Tbl[da_dlDateNums].FreeNumsCacheSize := 0;
 end;
 lSab_ForDelLink.DeleteFromTable;
 lSab_ForDelDict.DeleteFromTable;

 l3System.Msg2Log('All done!');
end;
*)
