unit F_DocList;

{ $Id: F_DocList.pas,v 1.72 2015/08/17 15:38:50 voba Exp $ }

interface
{$I ProjectDefine.inc}
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls, Forms, Dialogs,
  vtForm,
  ImgList,
  Main,
  OvcBase, vtlister, vtOutliner,
  DictsSup, l3Types, l3DatLst,
  l3InternalInterfaces, l3Interfaces,
  l3Tree, l3TreeInterfaces, l3Tree_TLB, l3Nodes,
  DT_Const, DT_Types,
  dtIntf, dt_Sab,
  Dt_Doc, DT_Dict, DT_Log, DT_Hyper,
  DT_Query, Dt_QueryProvider,
  Menus,
  DocIntf,
  DragData,
  AdvMenus,  ComCtrls, vtStatusBar, W95Meter, vtCtrls,
  ActnList, afwControl, afwInputControl, afwControlPrim, afwBaseControl,
  ddAutoLinker;

type

  TDocumentList = class(TvtFrame, Il3ChangeRecipient)
    SrchResultLister: TvtLister;
    SubList: TvtDStringLister;
    Split1: TvtSplitter;
    FooterPanel: TvtStatusBar;
    PercentMeter: TW95Meter;
    pmSrch: TPopupMenu;
    piDocInfo: TMenuItem;
    miAddIDtoDocSet: TMenuItem;
    miInsertDocToObjList: TMenuItem;
    miRemoveItem: TMenuItem;

    alDocList: TActionList;
    acSort: TAction;
    acTypeFilter: TAction;
    acDocInfo: TAction;
    acAddIDtoDocSet: TAction;
    acInsertDocToObjList: TAction;
    acRemoveItem: TAction;
    acPrintAll: TAction;
    acSaveToEVD: TAction;
    acChangeHLinks: TAction;

    //piSort: TMenuItem;
    //piSortNone: TMenuItem;
    //piSortDate: TMenuItem;
    //piSortPriority: TMenuItem;
    //piSortName: TMenuItem;
    //piSortOrdIncr: TMenuItem;
    //piSortOrdDecr: TMenuItem;

    procedure SrchResultListerActionElement(Sender: TObject; Index : Longint);
    procedure SrchResultListerCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
    function  SrchResultListerGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
    function  SubListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
    
    procedure evntPercentMeterSetStr(const aStr: string);

    procedure miStatisticClick(Sender: TObject);
    procedure acSortExecute(Sender: TObject);
    procedure acTypeFilterExecute(Sender: TObject);
    procedure acDocInfoExecute(Sender: TObject);
    procedure acAddIDtoDocSetExecute(Sender: TObject);
    procedure acInsertDocToObjListExecute(Sender: TObject);
    procedure acRemoveItemExecute(Sender: TObject);
    procedure acPrintAllExecute(Sender: TObject);
    procedure acSaveToEVDExecute(Sender: TObject);
    procedure acChangeHLinksExecute(Sender: TObject);
    procedure SrchResultListerGetItemImageOverlays(Sender: TObject;
      aIndex: Integer; var theOverlays: TOverlayIndexArray);
  private
    fFamily          : TFamilyID;

    DDHLink          : TGlobalCoordinateRec;

    fSubShow         : Boolean;
    fWasSaved        : Boolean;
    fModified        : Boolean;
    //IsSrchDataLoad      : Boolean;
    //fUserDocTypesFilter : TUserTypeSet;
    //fDocTypesFilter     : TDocTypeSet;
    fQueryProvider   : TdtDocListQueryProvider;
    fInDeleteCycle   : boolean;
    fPreventReset    : integer;

    procedure Changing;
    procedure Changed;
    procedure SetSubShow(aValue : Boolean);

    {procedure ProgressProc(aState: Byte; aPercent: Integer;
                           aValue: Longint; const aMsg: AnsiString);}

    procedure SetFamily(Value : TFamilyID);
    procedure SetModified(Value : Boolean);

    function  GetQuery : TdtQuery;
    procedure SetQuery(aValue : TdtQuery);

    procedure SetQueryProvider(aValue : TdtDocListQueryProvider);
    function  GetQueryProvider : TdtDocListQueryProvider;

    procedure WMDropAccept(var Message: TMessage); message wm_DropAccept;

    procedure AssignDocsList(aDocsList : TDocsList);
    procedure DropItemPosition;
    procedure OpenDocumentInEditor(anIndex: Integer; aReadOnly: Boolean);
    procedure SetSortDirection(aDirection: TSortOrder; aNeedSave: Boolean = True);
    procedure SetSortField(aField: TSortField; aNeedSave: Boolean = True);

    procedure SetFilter(aUserFilter : TUserTypeSet; aDocFilter : TDocTypeSet);
    function  GoToDocID(aPrimaryDocID : TDocID; aSecondryDocID: TDocID = 0) : Boolean;
    function  pm_GetIsIDList: Boolean;
    function  SrchResultListerGetItemPainter(Sender: TObject; Index: Longint): Il3NodePainter;
    procedure SearchByTypingHandler(Sender : TObject; var SrchStr : AnsiString; aFromCurrent : Boolean; var Index : LongInt);
    procedure SrchResultListerGetItemColor(Sender : TObject; Index : LongInt; var FG, BG : TColor);
    procedure SaveSortField(aField: TSortField);
    procedure SaveSortOrder(aOrder: TSortOrder);
    procedure LoadSortFieldAndOrder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetQueryFrom(const aValue : ISab);
    procedure RunEditor(Sender: TObject; aReadOnly : Boolean);
    procedure RefreshDocItem(aNewCurrent: Longint);
    function  IsListEmpty : Boolean;
    function  IsDocListQuery : Boolean;
    procedure ResetCurrent;
    procedure RefreshQueryResults(aWithReSearch : Boolean = false);
    procedure InDeleteCycle(aToggle : Boolean);
    procedure GetStrItem(Index: Integer; var ItemString: Il3CString; aDocRec: PDocListAccessRec = nil);
    procedure RunEditorForAllSelected(Sender: TObject; aReadOnly : Boolean);

    procedure ExpandEdition;

    property  Family   : TFamilyID  read fFamily write SetFamily;
    property  IsIDList: Boolean read pm_GetIsIDList;
    property  Query  : TdtQuery read GetQuery write SetQuery;

    property  QueryProvider : TdtDocListQueryProvider read GetQueryProvider;
    property  WasSaved : Boolean read fWasSaved write fWasSaved;
    property  Modified : Boolean read fModified write SetModified;
    property  SubShow  : Boolean read fSubShow write SetSubShow;
  end;

implementation

{$R *.DFM}
 uses
      l3Except, l3Base, l3Date, l3Bits, l3Chars, l3String, l3Memory, l3LongintList,
      m4DocumentAddress, l3Languages, l3IniFile,
      HT_Const,

      daDataProvider,

      evdTypes,
      k2Interfaces,

      k2Tags,
      TextPara_Const,
      TextSegment_Const,
      evNodePainter,

      StrShop,
      ResShop, IniShop, TypeShop,
      ObjList,
      DocAttrIntf,
      vtDialogs,
      HelpCnst,
      arInterfaces,
      DT_LinkServ,
      D_DocListSort,
      D_GetNum, D_ProcD, D_DTFilt, D_ShowInfo, D_HLReplace, StrUtils, ddProgressObj;

const
 cListSortPropertiesSection = 'ListSortProperties';

constructor TDocumentList.Create(AOwner: TComponent);
begin
 inherited Create(AOwner);
// fCurSub := cNonDefSub;
// otlAttributes.Images := ArchiResources.CommonImageList;
 SrchResultLister.OnGetItemPainter := SrchResultListerGetItemPainter;
 SrchResultLister.OnGetItemColor := SrchResultListerGetItemColor;
 SrchResultLister.OnCharToItem := SearchByTypingHandler;
 SrchResultLister.UseStyleTable := True;
 SubList.UseStyleTable := True;
end;

destructor TDocumentList.Destroy;
begin
 SetQueryProvider(nil);
 inherited Destroy;
end;

procedure TDocumentList.evntPercentMeterSetStr(const aStr: string);
begin
 FooterPanel.Panels[1].Text := aStr;
end;

procedure TDocumentList.RefreshDocItem(aNewCurrent: Longint);
var
 SL   : Tl3StringDataList;
 //lDocID : TDocID;
 l_DocRec: PDocListAccessRec;
begin
 if (SrchResultLister.Total > 0) then
 begin
  FooterPanel.Panels[0].Text:=Format(scFmtFuterCounter,[Succ(aNewCurrent),SrchResultLister.Total]);
  l_DocRec := QueryProvider.GetItem(aNewCurrent);

  //DocumentServer.Family := fFamily;
  //Result := DocumentServer.ReNumTbl.ConvertToImportNumber(lDocId);

  FooterPanel.Panels[1].Text:=Format(scFmtFuterID2,
            [l_DocRec^.rID, l_DocRec^.rExtID]);

  If SubShow then
  begin
   SL:=Tl3StringDataList(SubList.Items);
   SubList.DrawLock;
   LinkServer(fFamily).SubTbl.GetDocSub(l_DocRec^.rID, SL);
   SubList.DrawUnLock;
   SubList.Visible := True;
  end;
 end
 else
  FooterPanel.Panels[0].Text:='';
end;

procedure TDocumentList.RunEditor(Sender: TObject; aReadOnly : Boolean);
begin
 if SrchResultLister.Total <= 0 then Exit;
 OpenDocumentInEditor(SrchResultLister.Current, aReadOnly);
end;

procedure TDocumentList.SetFamily(Value : TFamilyID);
begin
 //If FFamily = Value then Exit;
 fFamily := Value;
end;

procedure TDocumentList.SetModified(Value : Boolean);
begin
 fModified := Value;
end;

function  TDocumentList.GetQuery : TdtQuery;
begin
 Result := QueryProvider.Query;
end;

procedure TDocumentList.SetQuery(aValue : TdtQuery);
begin
 QueryProvider.Changing;
 try
  QueryProvider.Query := aValue;
  if (QueryProvider.Query is TdtDocListQuery) and
     (TdtDocListQuery(Query).UQuery <> nil) and
     (TdtDocListQuery(Query).Filter = nil) then
   SetFilter(IniRec.DocSetTypeFilter, IniRec.SysDocSetTypeFilter);
 finally
  QueryProvider.Changed;
  ResetCurrent;
 end;
 LoadSortFieldAndOrder;
 fWasSaved := False;
 Modified := True;
end;

procedure TDocumentList.ExpandEdition;
begin
 if SrchResultLister.Total = 0 then Exit;
 QueryProvider.Changing;
 try
  DocumentServer(fFamily).FileTbl.ExpandAllEdition(QueryProvider.Query.FoundList);
 finally
  QueryProvider.Changed;
  ResetCurrent;
 end;
 //fWasSaved := False;
 //Modified := True;
end;

procedure TDocumentList.SetQueryFrom(const aValue : ISab);
var
 lListQuery : TdtIDListQuery;
begin
 lListQuery := TdtIDListQuery.CreateFrom(aValue);
 try
  Query := lListQuery;
 finally
  l3Free(lListQuery);
 end;
end;

procedure TDocumentList.SetQueryProvider(aValue : TdtDocListQueryProvider);
begin
 if fQueryProvider = aValue then Exit;
 if fQueryProvider <> nil then
  (fQueryProvider as Il3ChangeNotifier).Unsubscribe(Il3ChangeRecipient(Self));
 l3Set(fQueryProvider, aValue);
 if fQueryProvider <> nil then
 begin
  (fQueryProvider as Il3ChangeNotifier).Subscribe(Il3ChangeRecipient(Self));
  LoadSortFieldAndOrder;
 end;
end;

function TDocumentList.GetQueryProvider : TdtDocListQueryProvider;
var
 lQueryProvider : TdtDocListQueryProvider;
begin
 if fQueryProvider = nil then
 begin
  lQueryProvider := TdtDocListQueryProvider.Create;
  try
   SetQueryProvider(lQueryProvider);
  finally
   l3Free(lQueryProvider)
  end;
 end;

 Result := fQueryProvider;
end;

procedure TDocumentList.SetSubShow(aValue : Boolean);
begin
 if fSubShow = aValue then Exit;
 fSubShow := aValue;
 if fSubShow then
 begin
  SrchResultLister.Align := alTop;
  SrchResultLister.Height := SrchResultLister.Height div 2;
  Split1.Visible := True;
  SubList.Visible := True;
  Split1.Align := alTop;
  SubList.Align := alClient;
  SrchResultListerCurrentChanged(Self, SrchResultLister.Current, 0);
 end
 else
 begin
  Split1.Visible := False;
  SubList.Visible := False;
  SubList.Align := alBottom;
  Split1.Align := alBottom;
  SrchResultLister.Align := alClient;
 end;
end;

procedure TDocumentList.SrchResultListerActionElement(Sender: TObject; Index : Longint);
begin
 RunEditor(Sender, False);
end;

procedure TDocumentList.SrchResultListerCurrentChanged(Sender: TObject; aNewCurrent: Longint; aOldCurrent: Longint);
begin
 RefreshDocItem(aNewCurrent);
end;

function TDocumentList.SrchResultListerGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 if (Index >= 0) then
  Result := GetDocumentImageIndex(QueryProvider.GetItem(Index))
 else
  Result := picText;
end;


procedure TDocumentList.GetStrItem(Index: Integer; var ItemString: Il3CString; aDocRec: PDocListAccessRec = nil);
var
 lDoc    : PDocListAccessRec;

 function MakeNameByNumber : Il3CString;
  var
   S : ShortString;
  begin
   Result := l3CStr(Format(sidDocumentWithNumber+#0, [LinkServer(fFamily).ReNum.GetExtDocID(lDoc^.rId)]));
  end;

var
 lStrPos : Integer;

begin
 lDoc := aDocRec;
 if lDoc = nil then
  lDoc := QueryProvider.GetItem(Index);

 if lDoc <> nil then
  ItemString := l3ArrayToCString(lDoc^.rName, SizeOf(TFullNameStr), GlobalDataProvider.BaseLanguage[Family].AnsiCodePage)
 else
  ItemString := nil;

 if l3IsNil(ItemString) then
  ItemString := MakeNameByNumber;

 lStrPos := l3CharSetPresentEx(l3PCharLen(ItemString).S, -1,
                               [cc_DoubleQuote, cc_LDoubleQuote, cc_LTDoubleQuote]);
 if (lStrPos > 0) then
 begin
  if l3IsChar(ItemString, lStrPos-1, cc_HardSpace) then
   l3SetChar(ItemString, lStrPos-1, cc_SoftEnter);
 end;//lStrPos > 0

end;

function TDocumentList.SrchResultListerGetItemPainter(Sender: TObject; Index: Longint): Il3NodePainter;
var
 lDoc             : PDocListAccessRec;
 l_ItemString     : Il3CString;
 l_Comment        : Il3CString;
 l_CStart, l_CEnd : Integer;
 l_TextPara       : Tl3Variant;
 l_Seg            : Tl3Variant;

begin
 lDoc := QueryProvider.GetItem(Index);
 GetStrItem(Index, l_ItemString, lDoc);
 l_Comment := l3ArrayToCString(lDoc^.rComment, SizeOf(TDocCommentStr), GlobalDataProvider.BaseLanguage[Family].AnsiCodePage);
 if l_Comment <> nil then
 begin
  l_CStart := l3Len(l_ItemString) + 1;
  l_ItemString := l3Cat([l_ItemString, l3CStr(#10), l_Comment]);
  l_CEnd := l3Len(l_ItemString);
 end;
 l_TextPara := k2_typTextPara.MakeTag.AsObject;
 l_TextPara.PCharLenA[k2_tiText] := l3PCharLen(l_ItemString);
 l_TextPara.IntA[k2_tiFirstIndent] := 0;
// l_TextPara.IntA[k2_tiLeftIndent] := 30;
 l_TextPara.IntA[k2_tiJustification] := Ord(ev_itLeft);
 if l_Comment <> nil then
 begin
  with l_TextPara.cAtomEx([k2_tiSegments, k2_tiChildren, k2_tiHandle, Ord(ev_slView)], nil) do
  begin
   l_Seg := k2_typTextSegment.MakeTag.AsObject;
   l_Seg.IntA[k2_tiStart] := l_CStart;
   l_Seg.IntA[k2_tiFinish] := l_CEnd;
   with l_Seg.cAtom(k2_tiFont) do
   begin
    IntA[k2_tiSize] := 9;
    IntA[k2_tiForeColor] := clGray;
   end;
   AddChild(l_Seg);
  end;
 end;
 Result := TevNodePainter.Make(l_TextPara);
end;

function TDocumentList.SubListGetItemImageIndex(Sender: TObject; Index: Integer): Integer;
begin
 Result := picAnchor;
end;

function TDocumentList.IsListEmpty : Boolean;
begin
 Result := QueryProvider.IsEmpty;
end;

function  TDocumentList.IsDocListQuery : Boolean;
begin
 Result := Query is TdtDocListQuery;
end;

procedure TDocumentList.WMDropAccept(var Message: TMessage);
 var
  lAddCnt : Longint;
  I       : Longint;
  lItData : PAnsiChar;

 begin
  if (TDragDataSupport.Instance.DragDataType  = Ord(ddHyperLink)) or
     (TDragDataSupport.Instance.DragDataType  = Ord(ddMailDocLink)) then
  begin
   if TControl(Message.lParam) = SrchResultLister then
   begin
    I := SrchResultLister.MousePointToIndex;
    if I < 0 then Exit;
    Message.Result := 1;

    DDHLink.Family := Family;
    DDHLink.Doc := QueryProvider.GetItem(I).rID;
    DDHLink.Sub := 0;
   end
   else
    if (TControl(Message.lParam) = SubList) and
        (TDragDataSupport.Instance.DragDataType  = Ord(ddHyperLink)) then
    begin
     DDHLink.Family := Family;
     DDHLink.Doc := QueryProvider.GetItem(SrchResultLister.Current).rID;

     I := SubList.MousePointToIndex;
     if I < 0 then Exit;
     Message.Result := 1;

     DDHLink.Sub := SubList.Items.DataInt[I];
    end
    else
    begin
     Message.Result:=0;
     Exit;
    end;
   TDragDataSupport.Instance.AnswerData := @DDHLink;
   Message.Result := 1;
  end
  else
   if (TDragDataSupport.Instance.DragDataType = Ord(ddDragObj)) or
      (TDragDataSupport.Instance.DragDataType = Ord(ddDoc)) then
   begin
    lAddCnt := 0;
    With TArchiObjectList(TDragDataSupport.Instance.DragData) do
    begin
     (QueryProvider as Il3ChangeRecipient).Changing;
     try
      for I := 0 to Pred(Count) do
      begin
       lItData := Data[I];
       if (TDragDataType(lItData[0]) = ddDoc) then
        try
         QueryProvider.AddID(PGlobalCoordinateRec(lItData + 1)^.Doc);
         Inc(lAddCnt);
        except
        end;
      end;
     finally
      (QueryProvider as Il3ChangeRecipient).Changed;
     end;
     SrchResultLister.Current := 0;
    end; //With TArchiObjectList

    if lAddCnt = 0 then
     vtMessageDlg(l3CStr('Несовместимые типы данных.'), mtError)
    else
    begin
     TDragDataSupport.Instance.Stop(True);
     Message.Result := 1;
     Modified := True;
    end;
   end;
 end;

procedure TDocumentList.AssignDocsList(aDocsList : TDocsList);
var
 lDocAddr : TDocAddr;
 I        : Longint;
begin
 for I := 0 to Pred(SrchResultLister.Total) do
  if SrchResultLister.Selected[I] then
  begin
   lDocAddr.FamID := Family;
   lDocAddr.DocID := QueryProvider.GetItem(I).rID;
   aDocsList.AddAddrToList(lDocAddr);
  end;
end;

procedure TDocumentList.acDocInfoExecute(Sender: TObject);
var
 lDocsList : TDocsList;
 lInfoOut   : IInfoOut;
begin
 if SrchResultLister.Total <= 0 then exit;
 if SrchResultLister.SelectedCount <= 1 then
 begin
  with TarDocument.CreateParam(Family, QueryProvider.GetItem(SrchResultLister.Current).rID) do
   try
    ShowInfoDialog('Информация о документах', hcDocInfo, GetDocInformation);
   finally
    Free;
   end;  
 end
 else
 begin
  lDocsList := TDocsList.Create;
  try
   AssignDocsList(lDocsList);
   if lDocsList.Count > 0 then ProcessDocs(lDocsList, daShowStat);
  finally
   l3Free(lDocsList);
  end;
 end;
end;

procedure TDocumentList.acInsertDocToObjListExecute(Sender: TObject);
var
 I             : Longint;
 ItDataRec     : TGlobalCoordinateRec;
 SaveAllocFlag : Boolean;
 lDoc          : PDocListAccessRec;
begin
 if SrchResultLister.Total = 0 then Exit;
 for I := 0 to Pred(SrchResultLister.Total) do
  if SrchResultLister.Selected[I] then
   With ItDataRec do
   begin
    lDoc := QueryProvider.GetItem(I);
    Family := Family;
    Doc    := lDoc^.rID;
    Sub    := 0;
    SaveAllocFlag := ArchiObjectList.NeedAllocStr;
    ArchiObjectList.NeedAllocStr := False;
    try
     ArchiObjectList.AddObjRec(l3AllocPChar(lDoc^.rName, SizeOf(lDoc^.rName)), ddDoc, @ItDataRec);
    finally
     ArchiObjectList.NeedAllocStr := SaveAllocFlag;
    end;
   end;
end;

procedure TDocumentList.acRemoveItemExecute(Sender: TObject);
var
 I : Longint;
 lCurrent : Longint;
begin
 if SrchResultLister.Total = 0 then Exit;
 lCurrent := SrchResultLister.Current;

 SrchResultLister.LockChangeSelected;
 try
  Changing;
  try
   Inc(fPreventReset);
   try
    for I := Pred(SrchResultLister.Total) downto 0 do
     if SrchResultLister.Selected[I] then
     begin
      QueryProvider.DelID(I);
      if I < lCurrent then
       Dec(lCurrent)
     end;
   finally
    Dec(fPreventReset);
   end;
  finally
   Changed;
  end;
 finally
  SrchResultLister.UnLockChangeSelected
 end;

 SrchResultLister.Current := lCurrent;

 Modified := True;
end;

procedure TDocumentList.acSaveToEVDExecute(Sender: TObject);
var
 lDocsList : TDocsList;
begin
 if SrchResultLister.Total <= 0 then exit;
 lDocsList := TDocsList.Create;
 Try
  AssignDocsList(lDocsList);
  If lDocsList.Count > 0 then ProcessDocs(lDocsList, daSaveToEVD);
 finally
  l3Free(lDocsList);
 end;
end;

procedure TDocumentList.miStatisticClick(Sender: TObject);
var
 I : Integer;
begin
 With TShowInfoDlg.Create(Self, 'Cтатистика выборки') do
 begin
  HelpContext := hcSearchStat;

  {with SrchServ.SearchStatistics do
   for I := 0 to Pred(Count) do
    AddString(Strings[I]+#13#10);}
  AddString('Временно не работает');
  ShowModal;
  Free;
 end;
end;

procedure TDocumentList.acPrintAllExecute(Sender: TObject);
var
 lDocsList : TDocsList;
begin
 if SrchResultLister.Total <= 0 then exit;
 lDocsList := TDocsList.Create;
 try
  AssignDocsList(lDocsList);
  if lDocsList.Count > 0 then ProcessDocs(lDocsList, daPrint);
 finally
  l3Free(lDocsList);
 end;
end;

// Этот код - для отладки простановщика ссылок - НЕ УДАЛЯТЬ
(*
procedure TDocumentList.acPrintAllExecute(Sender: TObject);
var
 lDocsList : TDocsList;
 I: Integer;
 l_DocID: TDocID;
 l_Sab: ISab;
 l_Progressor: TddProgressObject;
begin
 if SrchResultLister.Total <= 0 then exit;
 l_Sab := QueryProvider.MakeDocIDList(False);
 l_Progressor := TddProgressObject.Create;
 try
  l_Progressor.ShowProcess := True;
  GetAutoLinker.SetLinks(l_Sab, l_Progressor);
 finally
  l3Free(l_Progressor);
 end;
end;
*)

procedure TDocumentList.acAddIDtoDocSetExecute(Sender: TObject);
var
 lDocID : TDocID;
 lSaveDocID : TDocID;
 //lIndex : Longint;
 lRenum : Boolean;
 lSaveCount : Integer;
begin
 if GetIDNumber(lDocID, lRenum, 'Добавить ID', 0) then
 begin
  lSaveDocID := lDocID;
  if lRenum then
   lDocID := LinkServer(fFamily).Renum.ConvertToRealNumber(lDocID);

  if lDocID <= 0 then
  begin
   vtMessageDlg(l3Fmt(sidNoDocPresent,[lSaveDocID]), mtError, [mbOK], 0);
   Exit;
  end;

  lSaveCount := QueryProvider.Count;
  QueryProvider.AddID(lDocID);

  if lSaveCount <> QueryProvider.Count then
   Modified := True;

  GoToDocID(lDocID);
 end;
end;

procedure TDocumentList.acSortExecute(Sender: TObject);
var
 l_SetAsDefault: Boolean;
begin
 with TDocListSortDlg.Create(nil) do
 try
  case QueryProvider.SortField of
   sfNone    : rgSortField.ItemIndex := 0;
   sfDate    : rgSortField.ItemIndex := 1;
   sfPriority: rgSortField.ItemIndex := 2;
   sfName    : rgSortField.ItemIndex := 3;
   sfUrgency : rgSortField.ItemIndex := 4;
  else
   Assert(False, 'Неизвестный тип сортировки');
  end;
  case QueryProvider.SortOrder of
   soUpDown  : rgSortOrder.ItemIndex := 0;
   soDownUp  : rgSortOrder.ItemIndex := 1;
  else
   Assert(False, 'Неизвестное направление сортировки');
  end;
  UpdateState;
  if Execute then
  begin
   l_SetAsDefault := cbSetAsDefault.Checked;
   case rgSortField.ItemIndex of
    0 : SetSortField(sfNone, l_SetAsDefault);
    1 : SetSortField(sfDate, l_SetAsDefault);
    2 : SetSortField(sfPriority, l_SetAsDefault);
    3 : SetSortField(sfName, l_SetAsDefault);
    4 : SetSortField(sfUrgency, l_SetAsDefault);
   else
    Assert(False);
   end;
   case rgSortOrder.ItemIndex of
    0 : SetSortDirection(soUpDown, l_SetAsDefault);
    1 : SetSortDirection(soDownUp, l_SetAsDefault);
   else
    Assert(False);
   end;
  end;
 finally
  Free;
 end;
end;

procedure TDocumentList.DropItemPosition;
begin
 SrchResultLister.Current := 0;
 RefreshDocItem(SrchResultLister.Current);
end;

procedure TDocumentList.SetSortDirection(aDirection: TSortOrder; aNeedSave: Boolean = True);
begin
 Screen.Cursor:=crHourGlass;
 try
  if QueryProvider.SortOrder = aDirection then
   Exit;
  SrchResultLister.Changing;
  try
   QueryProvider.SortOrder := aDirection;
   SrchResultLister.vlbDeselectAllItems;
   DropItemPosition;
  finally
   SrchResultLister.Changed;
  end;
  if aNeedSave then
   SaveSortOrder(aDirection);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocumentList.SetSortField(aField: TSortField; aNeedSave: Boolean = True);
begin
 Screen.Cursor:=crHourGlass;
 try
  if QueryProvider.SortField = aField then
   Exit;
  SrchResultLister.Changing;
  try
   QueryProvider.SortField := aField;
   SrchResultLister.vlbDeselectAllItems;
   DropItemPosition;
  finally
   SrchResultLister.Changed;
  end;
  if aNeedSave then
   SaveSortField(aField);
 finally
  Screen.Cursor := crDefault;
 end;
end;

procedure TDocumentList.acTypeFilterExecute(Sender: TObject);
var
  lUserDocTypesFilter : TUserTypeSet;
  lDocTypesFilter     : TDocTypeSet;
begin
 Assert(Query is TdtDocListQuery, 'aQuery is not TdtDocListQuery');

 With TDocTypeFilterDlg.Create(Self) do
 begin
  if TdtDocListQuery(Query).Filter <> nil then
   with TdtDocListQuery(Query).Filter do
   begin
    lUserDocTypesFilter := UserTypeFilter;
    lDocTypesFilter := DocTypeFilter;
   end
  else
   begin
    lUserDocTypesFilter := cAllUserTypeSet;
    lDocTypesFilter := cAllDocTypeSet;
   end;

  if Execute(lUserDocTypesFilter, lDocTypesFilter) then
   SetFilter(lUserDocTypesFilter, lDocTypesFilter);
  Free;
 end;
end;

procedure TDocumentList.SetFilter(aUserFilter : TUserTypeSet; aDocFilter : TDocTypeSet);
var
 lFilter : TdtDocTypeFilterQuery;
begin
 Assert(Query is TdtDocListQuery, 'aQuery is not TdtDocListQuery');

 if TdtDocListQuery(Query).Filter = nil then
 begin
  lFilter := TdtDocTypeFilterQuery.Create;
  TdtDocListQuery(Query).Filter := lFilter;
  l3Free(lFilter);
 end;

 with TdtDocListQuery(Query).Filter do
 begin
  Changing;
  UserTypeFilter := aUserFilter;
  DocTypeFilter := aDocFilter;
  Changed;
 end;

 ResetCurrent;
end;

procedure TDocumentList.OpenDocumentInEditor(anIndex: Integer; aReadOnly: Boolean);
var
 lDocID      : TDocID;
 lGoSubID    : TSubID;
 lDocJumpRec : TDocJumpRec;
 lSubList    : Tl3LongintList;
 lDocPointAddr : TDocPointAddr;
 lTextQuery : TdtTextQuery;
 lTextAddressList : Tm4Addresses;
begin
 lDocID := QueryProvider.GetItem(anIndex)^.rID;
 if Screen.ActiveControl = SubList then
  lGoSubID := SubList.Items.DataInt[SubList.Current]
 else
  lGoSubID := 0;

 if lGoSubID <> 0 then
 begin
  lDocPointAddr := MakeDocPointAddr(fFamily, lDocID, lGoSubID);
  lDocJumpRec := MakeDocJumpData(djSub, lDocPointAddr, True {JumpOnLoad});
 end
 else
 begin
  lTextQuery := QueryProvider.GetTextQuery;
  if (lTextQuery <> nil) and (lTextQuery.AddressList <> nil) then
  begin
   lTextAddressList := lTextQuery.AddressList;
   lDocJumpRec := MakeDocJumpData(djFoundWord, lTextAddressList, True {JumpOnLoad});
  end
  else
  begin
   lSubList := QueryProvider.GetFoundDocSubList(lDocID);
   if (lSubList <> nil) then
    lDocJumpRec := MakeDocJumpData(djSubList, lSubList, True {JumpOnLoad})
   else
    lDocJumpRec := EmptyDocJumpRec;
  end;
 end;

 if (lGoSubID = 0) and (lDocJumpRec.DocJumpType <> djNone) then
  lGoSubID := -1;

 MainForm.RunTextEditor(fFamily, lDocID, aReadOnly, lDocJumpRec);
end;

procedure TDocumentList.Changing;
begin
end;

procedure TDocumentList.Changed;
begin
 if fPreventReset > 0 then Exit;
 SrchResultLister.Total := QueryProvider.Count;
 SrchResultLister.FullRedraw;
 DropItemPosition;
end;

procedure TDocumentList.ResetCurrent;
begin
 SrchResultLister.Current := 0;
 SrchResultListerCurrentChanged(Self, 0, 0);
end;

procedure TDocumentList.InDeleteCycle(aToggle : Boolean);
begin
 if fInDeleteCycle = aToggle then Exit;
 fInDeleteCycle := aToggle;
 if fInDeleteCycle then
  SrchResultLister.LockChangeSelected
 else
 begin
  SrchResultLister.UnLockChangeSelected;
  RefreshQueryResults;
 end;
end;

procedure TDocumentList.RefreshQueryResults(aWithReSearch : Boolean = false);
var
 lCurDocID  : TDocID;
 lNextDocID : TDocID;
 lNeedGoto  : Boolean;
begin
 if fInDeleteCycle then Exit;

 // удаленное удаление влияет на наши выборки
 lNeedGoto := QueryProvider.Count > 1;
 if lNeedGoto then
 begin
  lCurDocID := QueryProvider.GetItem(SrchResultLister.Current)^.rID;
  if SrchResultLister.Current = Pred(QueryProvider.Count) then
   lNextDocID := QueryProvider.GetItem(Pred(SrchResultLister.Current))^.rID
  else
   lNextDocID := QueryProvider.GetItem(Succ(SrchResultLister.Current))^.rID;
 end;

 QueryProvider.RefreshResult(aWithReSearch);

 if lNeedGoto then
  GoToDocID(lCurDocID, lNextDocID);


 {!! Нужно запомнить текущий и попытаться встать на него, а не ResetCurrent}
 //ResetCurrent;
end;

function TDocumentList.GoToDocID(aPrimaryDocID : TDocID; aSecondryDocID: TDocID = 0) : Boolean;
var
 I : Cardinal;
 lIndex : Longint;
 lDocID : TDocID;
begin
 if SrchResultLister.Total = 0 then Exit;
 lIndex := -1;
 for I := 0 to Pred(QueryProvider.Count) do
 begin
  lDocID := QueryProvider.GetItem(I)^.rID;
  if lDocID = aPrimaryDocID then
  begin
   lIndex := I;
   Break;
  end
  else
  if lDocID = aSecondryDocID then
   lIndex := I;
 end;
 Result := lIndex >= 0;

 if Result then
  SrchResultLister.Current := lIndex;
end;

procedure TDocumentList.RunEditorForAllSelected(Sender: TObject; aReadOnly : Boolean);
var
 I: Integer;
begin
 if SrchResultLister.Total <= 0 then Exit;
 for I := 0 to Pred(SrchResultLister.Total) do
  if SrchResultLister.Selected[I] then
   OpenDocumentInEditor(I, aReadOnly);
end;

procedure TDocumentList.acChangeHLinksExecute(Sender: TObject);
var
 lOldDestDoc : TDocID;
 lNewDestDoc : TDocID;

 lSaveDocNum : TDocID;
 lDocIDSab   : ISab;
begin
 if RequestHLReplaceData(lOldDestDoc, lNewDestDoc, Self) then
 begin
  lSaveDocNum := lOldDestDoc;
  lOldDestDoc := LinkServer(fFamily).Renum.ConvertToRealNumber(lOldDestDoc);
  if lOldDestDoc <= 0 then
   raise El3NoLoggedException.CreateFmt(sidWrongDocID,[sidWrongDocID]);
  LinkServer(fFamily).Renum.GetRNumber(lNewDestDoc);

  lDocIDSab := QueryProvider.MakeDocIDList(True);

  LinkServer(fFamily).HLinkTbl.ChangeDestAddr(lOldDestDoc, lNewDestDoc, cAnySubId, lDocIDSab);

  if not Assigned(lDocIDSab) then
   Exit;

  //преобразуем lDocIDSab что бы вместо ID справок были ID доков
  DocumentServer(fFamily).FileTbl.SprIDs2DocIDs(lDocIDSab);

  LinkServer(CurrentFamily).LogBook.PutLogRecToDocs(lDocIDSab, acHLWork);
 end;
end;

procedure TDocumentList.LoadSortFieldAndOrder;
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create(GlobalDataProvider.CurHomePath+'user.ini');
 try
  l_Ini.Section := cListSortPropertiesSection;
  SetSortField(TSortField(l_Ini.ReadParamIntDef('SortField', Ord(sfNone))), False);
  SetSortDirection(TSortOrder(l_Ini.ReadParamIntDef('SortOrder', Ord(soUpDown))), False);
 finally
  FreeAndNil(l_Ini);
 end;
end;

function TDocumentList.pm_GetIsIDList: Boolean;
begin
 Result := Query is TdtIDListQuery;
end;

procedure TDocumentList.SaveSortField(aField: TSortField);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create(GlobalDataProvider.CurHomePath+'user.ini');
 try
  l_Ini.Section := cListSortPropertiesSection;
  l_Ini.WriteParamInt('SortField', Ord(aField));
 finally
  FreeAndNil(l_Ini);
 end;
end;

procedure TDocumentList.SaveSortOrder(aOrder: TSortOrder);
var
 l_Ini: TCfgList;
begin
 l_Ini := TCfgList.Create(GlobalDataProvider.CurHomePath+'user.ini');
 try
  l_Ini.Section := cListSortPropertiesSection;
  l_Ini.WriteParamInt('SortOrder', Ord(aOrder));
 finally
  FreeAndNil(l_Ini);
 end;
end;

procedure TDocumentList.SearchByTypingHandler(Sender : TObject; var SrchStr : AnsiString; aFromCurrent : Boolean; var Index : LongInt);
var
 l_Idx  : Integer;
 l_Doc  : PDocListAccessRec;
 l_Name : AnsiString;
begin
 Index := -1;
 if aFromCurrent and (Index > 0) then
  l_Idx := Index
 else
  l_Idx := 0;
 while l_Idx < QueryProvider.Count do
 begin
  l_Doc := QueryProvider.GetItem(l_Idx);
  l_Name := l3ArrayToString(l_Doc^.rName, cFullNameSize);
  if AnsiStartsText(SrchStr, l_Name) then
  begin
   Index := l_Idx;
   Break;
  end;
  Inc(l_Idx);
 end;
end;

procedure TDocumentList.SrchResultListerGetItemColor(Sender : TObject; Index : LongInt; var FG, BG : TColor);
var
 l_Doc: PDocListAccessRec;
begin
 l_Doc := QueryProvider.GetItem(Index);
 if l3TestMask(l_Doc^.rStatus, dstatHang) then
  BG := $FFF2E0; // светло-голубой
 if l3TestMask(l_Doc^.rStatus, dstatInternet) then
  BG := $E9E8FF; // светло-розовый
end;

procedure TDocumentList.SrchResultListerGetItemImageOverlays(
  Sender: TObject; aIndex: Integer; var theOverlays: TOverlayIndexArray);
var
 l_Urgency: Byte;
begin
 if (aIndex >= 0) then
 begin
  l_Urgency := QueryProvider.GetItem(aIndex)^.rUrgency;
  if l_Urgency in [1..2] then
  begin
   SetLength(theOverlays, 1);
   case l_Urgency of
    1 : theOverlays[0] := picUrgentOvr;
    2 : theOverlays[0] := picToVersionOvr;
   end;
  end;
  end;
end;

end.
