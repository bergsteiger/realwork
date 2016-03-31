unit NOT_COMPLETED_nsMainMenuNew;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\MainMenu\Forms\NOT_COMPLETED_nsMainMenuNew.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsMainMenuNew" MUID: (4AC9A3F801F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , Forms
 {$IfEnd} // NOT Defined(NoVCL)
 , Messages
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , Graphics
 , vtLister
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , l3TreeInterfaces
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
 , eeTreeView
 , l3ProtoDataContainer
 , MainMenuDomainInterfaces
 , SearchUnit
 , l3Memory
 , l3Types
 , l3Core
 , l3Except
 , Classes
;

const
 c_mmTreeColor = clWhite;
 c_mmSecondItemColor = $00F2F2F2;

type
 TnsLastOpenDocsManager = class(TvcmBase)
  {* менеджер дерева последних открытых документов }
  private
   f_MainMenuColor: TColor;
   f_NewSchool: Boolean;
  private
   procedure GetItemStyle(Sender: TObject;
    aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify);
   function GetItemCursor(aSender: TObject;
    aIndex: Integer): TCursor;
   procedure ActionElement(Sender: TObject;
    Index: LongInt);
   function GetItemTextHint(Sender: TObject;
    Index: LongInt): Il3CString;
   procedure AllowHotTruck(Sender: TObject;
    anIndex: Integer;
    var Allow: Boolean);
   function IsBookmark(const aNode: Il3SimpleNode): Boolean;
   procedure Init(aTree: TnscTreeViewHotTruck);
  public
   constructor Create(aMainMenuColor: TColor;
    aTree: TnscTreeViewHotTruck;
    aNewSchool: Boolean); reintroduce;
 end;//TnsLastOpenDocsManager

 TnsTreeStyleManager = class(TvcmBase)
  {* менеджер стилей деревьев для основного меню }
  private
   f_MainMenuColor: TColor;
   f_NewSchool: Boolean;
  private
   procedure TreeGetItemStyle(Sender: TObject;
    aItemIndex: Integer;
    const aFont: Il3Font;
    var aTextBackColor: TColor;
    var aItemBackColor: TColor;
    var aVJustify: TvtVJustify);
   function TreeGetItemImage(Sender: TObject;
    Index: Integer;
    var aImages: TCustomImageList): Integer;
  public
   procedure Init(aTree: TeeTreeView);
   constructor Create(aMainMenuColor: TColor;
    aNewSchool: Boolean); reintroduce;
 end;//TnsTreeStyleManager

 _ItemType_ = InsQueryNode;
 _l3InterfaceRefList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}
 TnsQueryHistory = class(_l3InterfaceRefList_)
  {* История запросов }
  private
   f_MaxCount: Integer;
   f_QueryType: TQueryType;
  public
   procedure LoadQueries;
   constructor Create(aMaxCount: Integer;
    aQueryType: TQueryType); reintroduce;
 end;//TnsQueryHistory

 TQHRec = record
  rH: TnsQueryHistory;
 end;//TQHRec

function nsScrollMainMenu(aWindow: TScrollingWinControl;
 var Message: TWMMouseWheel): Boolean;
function nsMakeMainMenuCaption: Il3CString;
function nsMakeQueryStr(var aBuf: TQHRec;
 aIndex: Integer;
 aHint: Boolean = False): Il3CString;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsLogEvent
 , DocumentUnit
 , Windows
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3String
 {$If NOT Defined(NoVCL)}
 , StdCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , DataAdapter
 , nsTypes
 , l3Chars
 , nsQueryNode
 , nsUtils
 , BaseTypesUnit
 , LoggingUnit
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

type
 TnsOpenDocumentFromHistory = {final} class(TnsLogEvent)
  private
   class procedure Log(const aDoc: IDocument;
    aPara: Longword); virtual;
 end;//TnsOpenDocumentFromHistory

function nsScrollMainMenu(aWindow: TScrollingWinControl;
 var Message: TWMMouseWheel): Boolean;
//#UC START# *4AC9A40B038E_4AC9A3F801F3_var*
const
 c_Delta = 10;
var
 l_Rect: TRect;
 l_Index: Integer;
 l_Lister: TvtLister;

 procedure lpScroll;
 var
  l_Delta: Integer;
 begin
  with Message, aWindow.VertScrollBar do
  begin
   // Определим приращение
   if WheelDelta < 0 then
    l_Delta := c_Delta
   else
    l_Delta := - c_Delta;
   // Сместимся если не выходим за пределы
   if (Position + l_Delta >= 0) and (Position + l_Delta <= Range) then
    Position := Position + l_Delta
   else
   // Смещаемся к началу или к концу
   if Message.WheelDelta > 0 then
    Position := 0
   else
    Position := Range;
  end;//with Message, aWindow.VertScrollBar do
 end;//lpScroll
//#UC END# *4AC9A40B038E_4AC9A3F801F3_var*
begin
//#UC START# *4AC9A40B038E_4AC9A3F801F3_impl*
 Result := True;
 // Видима вертикальная полоса прокрутки
 with aWindow do
  if VertScrollBar.Visible then
   for l_Index := 0 to Pred(ComponentCount) do
    if (Components[l_Index] is TvtLister) or
     (Components[l_Index] is TeeTreeView) then
    begin
     l_Lister := TvtLister(Components[l_Index]);
     Windows.GetWindowRect(l_Lister.Handle, l_Rect);
     // Колесо используется списком, который имеет вертикальную полосу прокрутки
     if PtInRect(l_Rect, Point(Message.XPos, Message.YPos)) then
     begin
      Result := not l_Lister.IsVScrollVisible;
      Break;
     end;//if PtInRect(l_Rect, Point(Message.XPos, Message.YPos)) then
    end;//if (Components[l_Index] is TnscLister)..
 if Result then
  lpScroll;
//#UC END# *4AC9A40B038E_4AC9A3F801F3_impl*
end;//nsScrollMainMenu

function nsMakeMainMenuCaption: Il3CString;
//#UC START# *4AC9F24E031B_4AC9A3F801F3_var*
 function lp_MakeDate: Il3CString;
 begin
  with DefDataAdapter.CurrentBaseDate do
  try
   Result := nsCStr(nsDateToStr(EncodeDate(rYear, rMonth, rDay)));
  except
   on EConvertError do
   begin
    Result := nsCStr('');
    Assert(False);
   end;//on EConvertError do
  end;//try..except
 end;//lp_MakeDate

 function lp_MakeComplectName: Il3CString;
 begin
  Result := l3RTrim(DefDataAdapter.ComplectName, [cc_Dot]);
   // - отрежем точку в конце названия комплекта, подготовим к использованию в
   //   str_SimpleMainMenuCaptionF;
 end;//lp_MakeComplectName
//#UC END# *4AC9F24E031B_4AC9A3F801F3_var*
begin
//#UC START# *4AC9F24E031B_4AC9A3F801F3_impl*
 Result := vcmFmt(str_SimpleMainMenuCaptionF, [lp_MakeComplectName, lp_MakeDate]);
//#UC END# *4AC9F24E031B_4AC9A3F801F3_impl*
end;//nsMakeMainMenuCaption

function nsMakeQueryStr(var aBuf: TQHRec;
 aIndex: Integer;
 aHint: Boolean = False): Il3CString;
//#UC START# *559BDBA00236_4AC9A3F801F3_var*
//#UC END# *559BDBA00236_4AC9A3F801F3_var*
begin
//#UC START# *559BDBA00236_4AC9A3F801F3_impl*
 Result := nil;
 if Assigned(aBuf.rH) then
 begin
  if (aBuf.rH.Count = 0) then
  begin
   // Выводим название элемента, но не показываем hint
   if not aHint then
    Result := vcmCStr(str_NotQueries);
  end
  else
   with aBuf.rH.Items[aIndex] do
    if not aHint then
     Result := nsCStr(Name)
       {$IfDef mmQueryHistoryUseColumns}
       + #9 + IntToStr(DocCount)
       {$EndIf mmQueryHistoryUseColumns}
    else
     Result := vcmFmt(str_QueryHintFrmt, [DocCount]);
 end;//aBuf.rH
//#UC END# *559BDBA00236_4AC9A3F801F3_impl*
end;//nsMakeQueryStr

class procedure TnsOpenDocumentFromHistory.Log(const aDoc: IDocument;
 aPara: Longword);
//#UC START# *4B0BE97A0326_4B0BE93B0070_var*
var
 l_Data: InsLogEventData;
//#UC END# *4B0BE97A0326_4B0BE93B0070_var*
begin
//#UC START# *4B0BE97A0326_4B0BE93B0070_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddString(''); //пустые скобки для несуществующего саба/блока. http://mdp.garant.ru/pages/viewpage.action?pageId=516542110&focusedCommentId=600944909#comment-600944909
 l_Data.AddULong(aPara);
 GetLogger.AddEvent(LE_OPEN_DOCUMENT_FROM_HISTORY, l_Data);
//#UC END# *4B0BE97A0326_4B0BE93B0070_impl*
end;//TnsOpenDocumentFromHistory.Log

procedure TnsLastOpenDocsManager.GetItemStyle(Sender: TObject;
 aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify);
//#UC START# *559BCCE9036A_4AC9C1F40041_var*
//#UC END# *559BCCE9036A_4AC9C1F40041_var*
begin
//#UC START# *559BCCE9036A_4AC9C1F40041_impl*
 aVJustify := vt_vjCenter;
 if not f_NewSchool then
  aFont.ForeColor := f_MainMenuColor
 else
  aFont.ForeColor := TnscTreeViewHotTruck(Sender).Font.Color;
 if f_NewSchool then
  aItemBackColor := c_mmTreeColor
 else
 begin
  if aItemIndex mod 2 = 1 then
   aItemBackColor := c_mmSecondItemColor
  else
   aItemBackColor := c_mmTreeColor;
 end;//f_NewSchool
 aTextBackColor := aItemBackColor;
//#UC END# *559BCCE9036A_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.GetItemStyle

function TnsLastOpenDocsManager.GetItemCursor(aSender: TObject;
 aIndex: Integer): TCursor;
//#UC START# *559BDAD602E3_4AC9C1F40041_var*
//#UC END# *559BDAD602E3_4AC9C1F40041_var*
begin
//#UC START# *559BDAD602E3_4AC9C1F40041_impl*
 if not IsBookmark(TnscTreeViewHotTruck(aSender).GetNode(aIndex))
  then Result := crDefault
  else Result := crHandPoint;
//#UC END# *559BDAD602E3_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.GetItemCursor

procedure TnsLastOpenDocsManager.ActionElement(Sender: TObject;
 Index: LongInt);
//#UC START# *559BDAE200EE_4AC9C1F40041_var*
var
 l_Node: Il3SimpleNode;
 l_MyNode: InsJournalBookmarkNode;
 l_Document: IDocument;
//#UC END# *559BDAE200EE_4AC9C1F40041_var*
begin
//#UC START# *559BDAE200EE_4AC9C1F40041_impl*
 l_Node := TnscTreeViewHotTruck(Sender).GetNode(Index);
 try
  if IsBookmark(l_Node) and Supports(l_Node, InsJournalBookmarkNode, l_MyNode) then
  try
   l_Document := TdmStdRes.SafeOpenDocument(l_MyNode.Bookmark);
   // Регистрируем открытие документа из истории:
   if l_Document <> nil then
   try
    if l_Document.GetDocType in [DT_DOCUMENT, DT_FLASH, DT_ACTUAL_ANALYTICS, DT_ACTUAL_ANALYTICS_CONTENTS] then
     TnsOpenDocumentFromHistory.Log(l_Document, l_MyNode.Bookmark.GetParaId);
   finally
    l_Document := nil;
   end;//try..finally
  finally
   l_MyNode := nil;
  end;//try..finally
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *559BDAE200EE_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.ActionElement

function TnsLastOpenDocsManager.GetItemTextHint(Sender: TObject;
 Index: LongInt): Il3CString;
//#UC START# *559BDAF3021A_4AC9C1F40041_var*
var
 l_Node: Il3SimpleNode;
 l_Book: InsJournalBookmarkNode;
 l_N: Il3CString;
//#UC END# *559BDAF3021A_4AC9C1F40041_var*
begin
//#UC START# *559BDAF3021A_4AC9C1F40041_impl*
 Result := nil;
 l_Node := TnscTreeViewHotTruck(Sender).GetNode(Index);
 try
  if Supports(l_Node, InsJournalBookmarkNode, l_Book) then
  try
   l_N := l_Book.DocName;
   if not l3Same(l_N, l_Node.Text) then
    Result := l_N;
  finally
   l_Book := nil;
  end;//try..finally
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *559BDAF3021A_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.GetItemTextHint

procedure TnsLastOpenDocsManager.AllowHotTruck(Sender: TObject;
 anIndex: Integer;
 var Allow: Boolean);
//#UC START# *559BDAFF0396_4AC9C1F40041_var*
//#UC END# *559BDAFF0396_4AC9C1F40041_var*
begin
//#UC START# *559BDAFF0396_4AC9C1F40041_impl*
 Allow := IsBookmark(TnscTreeViewHotTruck(Sender).GetNode(anIndex));
//#UC END# *559BDAFF0396_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.AllowHotTruck

function TnsLastOpenDocsManager.IsBookmark(const aNode: Il3SimpleNode): Boolean;
//#UC START# *559BDB16017C_4AC9C1F40041_var*
var
 l_Book: InsJournalBookmarkNode;
//#UC END# *559BDB16017C_4AC9C1F40041_var*
begin
//#UC START# *559BDB16017C_4AC9C1F40041_impl*
 Result := Supports(aNode, InsJournalBookmarkNode, l_Book) and Assigned(l_Book.Bookmark);
//#UC END# *559BDB16017C_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.IsBookmark

procedure TnsLastOpenDocsManager.Init(aTree: TnscTreeViewHotTruck);
//#UC START# *559BDB2B038C_4AC9C1F40041_var*
//#UC END# *559BDB2B038C_4AC9C1F40041_var*
begin
//#UC START# *559BDB2B038C_4AC9C1F40041_impl*
 with aTree do
 begin
  OnActionElement := ActionElement;
  OnGetItemStyle := GetItemStyle;
  OnGetItemTextHint := GetItemTextHint;
  OnGetItemCursor := GetItemCursor;
  OnAllowHotTruck := AllowHotTruck;
 end;//with aTree do
//#UC END# *559BDB2B038C_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.Init

constructor TnsLastOpenDocsManager.Create(aMainMenuColor: TColor;
 aTree: TnscTreeViewHotTruck;
 aNewSchool: Boolean);
//#UC START# *559BDB4701AD_4AC9C1F40041_var*
//#UC END# *559BDB4701AD_4AC9C1F40041_var*
begin
//#UC START# *559BDB4701AD_4AC9C1F40041_impl*
 inherited Create;
 f_MainMenuColor := aMainMenuColor;
 f_NewSchool := aNewSchool;
 Init(aTree);
//#UC END# *559BDB4701AD_4AC9C1F40041_impl*
end;//TnsLastOpenDocsManager.Create

procedure TnsTreeStyleManager.TreeGetItemStyle(Sender: TObject;
 aItemIndex: Integer;
 const aFont: Il3Font;
 var aTextBackColor: TColor;
 var aItemBackColor: TColor;
 var aVJustify: TvtVJustify);
//#UC START# *559BCA25016A_4AC9C91202FA_var*
var
 l_Node: Il3SimpleNode;
//#UC END# *559BCA25016A_4AC9C91202FA_var*
begin
//#UC START# *559BCA25016A_4AC9C91202FA_impl*
 if not f_NewSchool then
  aFont.ForeColor := f_MainMenuColor
 else
  aFont.ForeColor := TvtCustomOutliner(Sender).Font.Color;
 aVJustify := vt_vjCenter;
 l_Node := TeeTreeView(Sender).GetNode(aItemIndex);
 try
  if f_NewSchool then
  begin
   aTextBackColor := c_mmTreeColor;
   aItemBackColor := aTextBackColor;
  end//l_Node <> nil
  else
  if (l_Node <> nil) and ((Succ(l_Node.IndexInParent) mod 2) = 1) then
  begin
   aTextBackColor := c_mmTreeColor;
   aItemBackColor := aTextBackColor;
  end//l_Node <> nil
  else
  begin
   aTextBackColor := c_mmSecondItemColor;
   aItemBackColor := aTextBackColor;
  end;//l_Node <> nil
 finally
  l_Node := nil;
 end;//try..finally
//#UC END# *559BCA25016A_4AC9C91202FA_impl*
end;//TnsTreeStyleManager.TreeGetItemStyle

function TnsTreeStyleManager.TreeGetItemImage(Sender: TObject;
 Index: Integer;
 var aImages: TCustomImageList): Integer;
//#UC START# *559BCA3300B9_4AC9C91202FA_var*
//#UC END# *559BCA3300B9_4AC9C91202FA_var*
begin
//#UC START# *559BCA3300B9_4AC9C91202FA_impl*
 Result := vtItemWithoutImage;
//#UC END# *559BCA3300B9_4AC9C91202FA_impl*
end;//TnsTreeStyleManager.TreeGetItemImage

procedure TnsTreeStyleManager.Init(aTree: TeeTreeView);
//#UC START# *559BCA4A02E1_4AC9C91202FA_var*
//#UC END# *559BCA4A02E1_4AC9C91202FA_var*
begin
//#UC START# *559BCA4A02E1_4AC9C91202FA_impl*
 with aTree do
 begin
  ScrollStyle := ssNone;
  EditOptions := EditOptions - [eoItemExpand];
  ActionElementMode := l3_amSingleClick;
  OnGetItemStyle := TreeGetItemStyle;
  // В данный момент дерево не поддерживает опцию voShowInterRowSpace для
  // однострочных элементов дерева, поэтому разряжаем элементы сами:
  if f_NewSchool then
   ViewOptions := ViewOptions - [voShowInterRowSpace]
  else
   ViewOptions := ViewOptions + [voShowInterRowSpace];
  OnGetItemImage := TreeGetItemImage;
  Color := c_mmTreeColor;
 end;//with aTree do
//#UC END# *559BCA4A02E1_4AC9C91202FA_impl*
end;//TnsTreeStyleManager.Init

constructor TnsTreeStyleManager.Create(aMainMenuColor: TColor;
 aNewSchool: Boolean);
//#UC START# *559BCA680342_4AC9C91202FA_var*
//#UC END# *559BCA680342_4AC9C91202FA_var*
begin
//#UC START# *559BCA680342_4AC9C91202FA_impl*
 inherited Create;
 f_MainMenuColor := aMainMenuColor;
 f_NewSchool := aNewSchool;
//#UC END# *559BCA680342_4AC9C91202FA_impl*
end;//TnsTreeStyleManager.Create

type _Instance_R_ = TnsQueryHistory;

{$Include w:\common\components\rtl\Garant\L3\l3InterfaceRefList.imp.pas}

procedure TnsQueryHistory.LoadQueries;
//#UC START# *559BC7B5001A_559BC4A30149_var*
var
 l_Index: Integer;
 l_List: IQueryList;
 l_Item: IQuery;
//#UC END# *559BC7B5001A_559BC4A30149_var*
begin
//#UC START# *559BC7B5001A_559BC4A30149_impl*
 Clear;
 try
  l_List := TdmStdRes.MakeWorkJournal.MakeQueryHistory(f_QueryType, f_MaxCount);
  if Assigned(l_List) then
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_List.pm_GetItem(l_Index, l_Item);
    Add(TnsQueryNode.Make(l_Item) as InsQueryNode);
   end;
 except
  // в истории запросов нет
  on ECanNotFindData do 
 end;
//#UC END# *559BC7B5001A_559BC4A30149_impl*
end;//TnsQueryHistory.LoadQueries

constructor TnsQueryHistory.Create(aMaxCount: Integer;
 aQueryType: TQueryType);
//#UC START# *559BC7CA015F_559BC4A30149_var*
//#UC END# *559BC7CA015F_559BC4A30149_var*
begin
//#UC START# *559BC7CA015F_559BC4A30149_impl*
 inherited Create;
 f_MaxCount := aMaxCount;
 f_QueryType := aQueryType;
//#UC END# *559BC7CA015F_559BC4A30149_impl*
end;//TnsQueryHistory.Create
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
