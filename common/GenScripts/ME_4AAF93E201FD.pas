unit NOT_COMPLETED_nsPostingsLine;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\NOT_COMPLETED_nsPostingsLine.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "nsPostingsLine" MUID: (4AAF93E201FD)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , l3Interfaces
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 , f1NotificationManager
 , l3Tree_TLB
 , nsQueryInterfaces
 , IOUnit
 , SearchUnit
 , eeInterfaces
;

type
 TnsAddEvent = procedure(aIndex: Integer) of object;

 TnsCaptionChangeEvent = procedure(aIndex: Integer;
  const aNewCaption: Il3CString) of object;

 TnsPostingsTree = class({$If NOT Defined(NoVCM)}
 TvcmCacheableBase
 {$IfEnd} // NOT Defined(NoVCM)
 , If1NotificationListener)
  private
   f_MgrSearch: Pointer;
    {* IqaMgrSearch
поле для свойства MgrSearch }
   f_Root: Il3Node;
    {* указатель на корневой узел дерева, где хранятся списки рассылок списка рассылок. Фактически "Мои документы" для пользователя "_predefined_data". }
   f_DataChanged: Boolean;
    {* флаг изменения окна дерева (удаление или добавление узлов). Если пустое, то флаг автоматически выставляется в False. Реально нужен для проверки перед сохранением списка рассылки на диск. }
   f_LastCatalog: Il3CString;
    {* каталог, в который последний раз производилось сохранение. }
   f_EditNodeIndex: Integer;
    {* индекс редактируемого элемента в дереве (для которого открыта КЗ). Может не соответствовать выделенному. }
   f_OldModifed: Boolean;
    {* кэширование флага изменения параметров рассылки. }
   f_Closed: Boolean;
    {* признак того, что приложение закрывается. }
   f_NeedLoad: Boolean;
    {* флаг для загрузки данных из первой рассылки в КЗ. Флаг сбрасывается в функции GetFirstQuery. }
   f_ServerDown: Boolean;
    {* флаг закрытия приложения по выключению сервера. }
   f_OnAddNode: TnsAddEvent;
    {* обработчик события добавления узла в дерево. }
   f_OnDelNode: TnsAddEvent;
    {* обработчик события удаления узла из дерева. }
   f_OnEditNode: TnsCaptionChangeEvent;
    {* обработчик изменения названия узла. }
  private
   procedure LoadChildren;
    {* загружает список рассылок. }
   procedure LoadSettings;
    {* загружает настройки для дерева. }
   function MakeCurrentPrimeName: IString;
   procedure CheckAndChangeCaption(aCheckOnly: Boolean);
    {* передает дереву новое значение _Caption редактируемого узла. }
  protected
   function pm_GetRoot: Il3Node;
   function pm_GetMgrSearch: IqaMgrSearch;
   procedure pm_SetMgrSearch(const aValue: IqaMgrSearch);
   procedure pm_SetLastCatalog(const aValue: Il3CString);
   procedure pm_SetEditNodeIndex(aValue: Integer);
   function pm_GetHasChildren: Boolean;
   function pm_GetCount: Integer;
   procedure ServerDownNotification;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
   procedure InitFields; override;
   procedure ClearFields; override;
  public
   constructor Create; reintroduce;
   function SaveQuery2Adapter(const aQuery: IQuery): Boolean;
    {* сохраняет запрос в базу. }
   procedure SaveXMLForServer;
    {* если новостаная лента была изменена, нужно вылить папки для файл-серверной версии системы. }
   procedure DeletePosting(const aNode: IeeNode);
    {* удаляет рассылку из списка рассылок (одновременно на адаптере и дереве в оболочке). }
   procedure DeleteSelectedPostings(const aTreeView: IeeTreeView);
   procedure ExportSelected(const aTreeView: IeeTreeView;
    const aFileName: Il3CString);
   function GetFirstQuery: IQuery;
    {* возвращает запрос для первой рассылки в списке. }
   function SaveOrCreateQuery: Boolean;
    {* чтобы не мотаться по формам, сделан некоторый реверанс в сторону "ручного" программирования, тем более, что все данные для этого есть. }
  protected
   property Count: Integer
    read pm_GetCount;
    {* количество тематик. У TnsCacheableNode.ThisChildrenCount справшивать нельзя, значение кешируется. На AdapterNode тоже справшивать не хочется, вдруг там кроме тематик ещё какие-нибудь узлы появятся.
Нужно сделать, чтобы TnsPrimeNode наследовался от класса, на котором не кешируется ThisChildrenCount. }
  public
   property Root: Il3Node
    read pm_GetRoot;
    {* указатель на корневой узел дерева, где хранятся списки рассылок списка рассылок. Фактически "Мои документы" для пользователя "_predefined_data". }
   property DataChanged: Boolean
    read f_DataChanged
    write f_DataChanged;
    {* флаг изменения окна дерева (удаление или добавление узлов). Если пустое, то флаг автоматически выставляется в False. Реально нужен для проверки перед сохранением списка рассылки на диск. }
   property MgrSearch: IqaMgrSearch
    read pm_GetMgrSearch
    write pm_SetMgrSearch;
    {* указатель на менеджер КЗ заказа рассылки. Считается, что он всегда один. }
   property LastCatalog: Il3CString
    read f_LastCatalog
    write pm_SetLastCatalog;
    {* каталог, в который последний раз производилось сохранение. }
   property EditNodeIndex: Integer
    read f_EditNodeIndex
    write pm_SetEditNodeIndex;
    {* индекс редактируемого элемента в дереве (для которого открыта КЗ). Может не соответствовать выделенному. }
   property OldModifed: Boolean
    read f_OldModifed
    write f_OldModifed;
    {* кэширование флага изменения параметров рассылки. }
   property Closed: Boolean
    read f_Closed
    write f_Closed;
    {* признак того, что приложение закрывается. }
   property NeedLoad: Boolean
    read f_NeedLoad;
    {* флаг для загрузки данных из первой рассылки в КЗ. Флаг сбрасывается в функции GetFirstQuery. }
   property ServerDown: Boolean
    read f_ServerDown
    write f_ServerDown;
    {* флаг закрытия приложения по выключению сервера. }
   property HasChildren: Boolean
    read pm_GetHasChildren;
    {* наличие новостных лент. }
   property OnAddNode: TnsAddEvent
    read f_OnAddNode
    write f_OnAddNode;
    {* обработчик события добавления узла в дерево. }
   property OnDelNode: TnsAddEvent
    read f_OnDelNode
    write f_OnDelNode;
    {* обработчик события удаления узла из дерева. }
   property OnEditNode: TnsCaptionChangeEvent
    read f_OnEditNode
    write f_OnEditNode;
    {* обработчик изменения названия узла. }
 end;//TnsPostingsTree
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 , nsPrimeNode
 , nsNodes
 , DataAdapter
 , afwFacade
 , nsConst
 , l3Base
 , l3String
 , nsTypes
 , BaseTypesUnit
 {$If NOT Defined(NoVCM)}
 , vcmMessagesSupport
 {$IfEnd} // NOT Defined(NoVCM)
 , PrimeDomainInterfaces
 , SysUtils
 , DynamicTreeUnit
 {$If Defined(Nemesis)}
 , eeTreeMisc
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , l3MessageID
 {$If NOT Defined(NoVCL)}
 , Dialogs
 {$IfEnd} // NOT Defined(NoVCL)
 , l3Nodes
 , PrimeUnit
 , l3Chars
;

function TnsPostingsTree.pm_GetRoot: Il3Node;
//#UC START# *52F9F7970349_4ADEF93B0159get_var*
//#UC END# *52F9F7970349_4ADEF93B0159get_var*
begin
//#UC START# *52F9F7970349_4ADEF93B0159get_impl*
 if (f_Root = nil) then
 begin
  f_Root := TnsRootNode.Make;
  f_Root.Text := vcmWStr(vcmCStr(str_MonitoringsList));
  LoadChildren;
 end;//f_Root = nil
 Result := f_Root;
//#UC END# *52F9F7970349_4ADEF93B0159get_impl*
end;//TnsPostingsTree.pm_GetRoot

function TnsPostingsTree.pm_GetMgrSearch: IqaMgrSearch;
//#UC START# *52F9F8640074_4ADEF93B0159get_var*
//#UC END# *52F9F8640074_4ADEF93B0159get_var*
begin
//#UC START# *52F9F8640074_4ADEF93B0159get_impl*
 Result := IqaMgrSearch(f_MgrSearch);
//#UC END# *52F9F8640074_4ADEF93B0159get_impl*
end;//TnsPostingsTree.pm_GetMgrSearch

procedure TnsPostingsTree.pm_SetMgrSearch(const aValue: IqaMgrSearch);
//#UC START# *52F9F8640074_4ADEF93B0159set_var*
//#UC END# *52F9F8640074_4ADEF93B0159set_var*
begin
//#UC START# *52F9F8640074_4ADEF93B0159set_impl*
 //f_MgrSearch := aValue;
 f_MgrSearch := Pointer(aValue);
 if Assigned(f_MgrSearch) then
  EditNodeIndex := -1;
//#UC END# *52F9F8640074_4ADEF93B0159set_impl*
end;//TnsPostingsTree.pm_SetMgrSearch

procedure TnsPostingsTree.pm_SetLastCatalog(const aValue: Il3CString);
//#UC START# *52F9F8F100AE_4ADEF93B0159set_var*
//#UC END# *52F9F8F100AE_4ADEF93B0159set_var*
begin
//#UC START# *52F9F8F100AE_4ADEF93B0159set_impl*
 if not l3Same(f_LastCatalog, aValue) then
 begin
  f_LastCatalog := aValue;
  afw.Settings.SaveString(pi_PostingOrder_LastCatalog, f_LastCatalog);
 end;//not l3Same(f_LastCatalog.AsWStr, Value)  
//#UC END# *52F9F8F100AE_4ADEF93B0159set_impl*
end;//TnsPostingsTree.pm_SetLastCatalog

procedure TnsPostingsTree.pm_SetEditNodeIndex(aValue: Integer);
//#UC START# *52F9F9200319_4ADEF93B0159set_var*
//#UC END# *52F9F9200319_4ADEF93B0159set_var*
begin
//#UC START# *52F9F9200319_4ADEF93B0159set_impl*
 f_EditNodeIndex := aValue;
//#UC END# *52F9F9200319_4ADEF93B0159set_impl*
end;//TnsPostingsTree.pm_SetEditNodeIndex

function TnsPostingsTree.pm_GetHasChildren: Boolean;
//#UC START# *52F9FA6901B9_4ADEF93B0159get_var*
//#UC END# *52F9FA6901B9_4ADEF93B0159get_var*
begin
//#UC START# *52F9FA6901B9_4ADEF93B0159get_impl*
 Result := f_Root.HasChild;
//#UC END# *52F9FA6901B9_4ADEF93B0159get_impl*
end;//TnsPostingsTree.pm_GetHasChildren

function TnsPostingsTree.pm_GetCount: Integer;
//#UC START# *52F9FB13006F_4ADEF93B0159get_var*
 procedure CountChild(const aNode: Il3Node);
 begin//CountChild
  Inc(Result);
 end;//CountChild
//#UC END# *52F9FB13006F_4ADEF93B0159get_var*
begin
//#UC START# *52F9FB13006F_4ADEF93B0159get_impl*
 if Root.HasChild then
  Root.IterateF(l3L2NA(@CountChild), imOneLevel)
 else
  Result := 0;
//#UC END# *52F9FB13006F_4ADEF93B0159get_impl*
end;//TnsPostingsTree.pm_GetCount

procedure TnsPostingsTree.LoadChildren;
 {* загружает список рассылок. }
//#UC START# *52F9FB7F0011_4ADEF93B0159_var*
var
 l_List: IPrimeList;
 l_Item: IPrime;
 l_Index: Integer;
//#UC END# *52F9FB7F0011_4ADEF93B0159_var*
begin
//#UC START# *52F9FB7F0011_4ADEF93B0159_impl*
 DefDataAdapter.PrimeManager.GetList(l_List);
 try
  if Assigned(l_List) and (l_List.Count > 0) then
  begin
   Root.Changing;
   try
    for l_Index := 0 to Pred(l_List.Count) do
    begin
     l_List.pm_GetItem(l_Index, l_Item);
     Root.InsertChild(TnsPrimeNode.Make(l_Item));
    end;//for l_Index := 0 to Pred(l_List.Count) do
    f_NeedLoad := True;
   finally
    Root.Changed;
   end;
  end;
  LoadSettings;    
 finally
  l_List := nil;
 end;
//#UC END# *52F9FB7F0011_4ADEF93B0159_impl*
end;//TnsPostingsTree.LoadChildren

procedure TnsPostingsTree.LoadSettings;
 {* загружает настройки для дерева. }
//#UC START# *52F9FBB9027F_4ADEF93B0159_var*
const
 FuckMagic = '-1';
var
 l_Value: Il3CString;
//#UC END# *52F9FBB9027F_4ADEF93B0159_var*
begin
//#UC START# *52F9FBB9027F_4ADEF93B0159_impl*
 l_Value := afw.Settings.LoadString(pi_PostingOrder_LastCatalog, FuckMagic);
 if not l3Same(l_Value, FuckMagic) then
  f_LastCatalog := l_Value;
 f_DataChanged := False;
//#UC END# *52F9FBB9027F_4ADEF93B0159_impl*
end;//TnsPostingsTree.LoadSettings

function TnsPostingsTree.MakeCurrentPrimeName: IString;
//#UC START# *52F9FC4C00A0_4ADEF93B0159_var*
//#UC END# *52F9FC4C00A0_4ADEF93B0159_var*
begin
//#UC START# *52F9FC4C00A0_4ADEF93B0159_impl*
 Result := nsIStr(l3RTrim(MgrSearch.GetName4Query, cc_WhiteSpaceExt));
//#UC END# *52F9FC4C00A0_4ADEF93B0159_impl*
end;//TnsPostingsTree.MakeCurrentPrimeName

constructor TnsPostingsTree.Create;
//#UC START# *52F9FCAF0340_4ADEF93B0159_var*
//#UC END# *52F9FCAF0340_4ADEF93B0159_var*
begin
//#UC START# *52F9FCAF0340_4ADEF93B0159_impl*
 inherited Create;
 f_EditNodeIndex := -1;
 f_MgrSearch := nil;
//#UC END# *52F9FCAF0340_4ADEF93B0159_impl*
end;//TnsPostingsTree.Create

function TnsPostingsTree.SaveQuery2Adapter(const aQuery: IQuery): Boolean;
 {* сохраняет запрос в базу. }
//#UC START# *52F9FCCE016F_4ADEF93B0159_var*
var
 l_NewPrime: IPrime;
//#UC END# *52F9FCCE016F_4ADEF93B0159_var*
begin
//#UC START# *52F9FCCE016F_4ADEF93B0159_impl*
 Result := False;
 try
  DefDataAdapter.PrimeManager.Add(MakeCurrentPrimeName, aQuery, l_NewPrime);
  Result := True;
 except
  on EDuplicateName do
  begin
   vcmSay(inf_PostingAlreadyExist);
   Exit;
  end;//EDuplicateName
 end;//try..except
 Root.InsertChild(TnsPrimeNode.Make(l_NewPrime));
 if Assigned(f_OnAddNode) then
  f_OnAddNode(Pred(Self.Count));
 DataChanged := True;
 EditNodeIndex := Root.ThisChildrenCount - 1;
//#UC END# *52F9FCCE016F_4ADEF93B0159_impl*
end;//TnsPostingsTree.SaveQuery2Adapter

procedure TnsPostingsTree.SaveXMLForServer;
 {* если новостаная лента была изменена, нужно вылить папки для файл-серверной версии системы. }
//#UC START# *52F9FD21020E_4ADEF93B0159_var*
var
 l_MayGo: Boolean;
//#UC END# *52F9FD21020E_4ADEF93B0159_var*
begin
//#UC START# *52F9FD21020E_4ADEF93B0159_impl*
 if DataChanged then
 begin
  // сохранение XML на стороне сервера приложений
  l_MayGo := False;
  while not l_MayGo do
  try
   DefDataAdapter.PrimeManager.SharePrimeForFileServer;
   l_MayGo := True;
  except
   on EUnknownExportError do
    l_MayGo := not vcmAsk(qr_Save2ServerPostList);
  end;
 end;
//#UC END# *52F9FD21020E_4ADEF93B0159_impl*
end;//TnsPostingsTree.SaveXMLForServer

procedure TnsPostingsTree.CheckAndChangeCaption(aCheckOnly: Boolean);
 {* передает дереву новое значение _Caption редактируемого узла. }
//#UC START# *52F9FD4D014F_4ADEF93B0159_var*
 function lp_GetNameIndex(const aName: Il3CString): Integer;
 var
  l_PrimeList: IPrimeList;
  l_Prime: IPrime;
  l_Name: IString;
 begin
  DefDataAdapter.PrimeManager.GetList(l_PrimeList);
  try
   if Assigned(l_PrimeList) then
    for Result := 0 to l_PrimeList.Count - 1 do
    begin
     l_PrimeList.pm_GetItem(Result, l_Prime);
     try
      l_Prime.GetName(l_Name);
      if l3Same(aName, nsCStr(l_Name)) then
       Exit;
     finally
      l_Prime := nil;
     end;
    end;
   Result := -1;
  finally
   l_PrimeList := nil;
  end;
 end;
var
 l_Item: IPrime;
 l_List: IPrimeList;
 l_CurrentName: IString;
 l_NewName: Il3CString;
 l_SameNameIndex: Integer;
//#UC END# *52F9FD4D014F_4ADEF93B0159_var*
begin
//#UC START# *52F9FD4D014F_4ADEF93B0159_impl*
 DefDataAdapter.PrimeManager.GetList(l_List);
 Assert(Assigned(l_List));
 try
  l_NewName := MgrSearch.GetName4Query;
  l_List.pm_GetItem(f_EditNodeIndex, l_Item);
  l_Item.GetName(l_CurrentName);
  if not l3Same(l3RTrim(l_NewName, cc_WhiteSpaceExt), l3RTrim(nsCStr(l_CurrentName), cc_WhiteSpaceExt)) then
  begin
   l_SameNameIndex := lp_GetNameIndex(l_NewName);
   if (l_SameNameIndex >= 0) and (l_SameNameIndex <> EditNodeIndex) then
    raise EDuplicateName.Create('');
   if not aCheckOnly then
   begin
    l_Item.SetName(nsIStr(l_NewName));
    if Assigned(f_OnEditNode) then
     f_OnEditNode(f_EditNodeIndex, l_NewName);
   end;
  end;
 finally
  l_List := nil;
 end;//try..finally
//#UC END# *52F9FD4D014F_4ADEF93B0159_impl*
end;//TnsPostingsTree.CheckAndChangeCaption

procedure TnsPostingsTree.DeletePosting(const aNode: IeeNode);
 {* удаляет рассылку из списка рассылок (одновременно на адаптере и дереве в оболочке). }
//#UC START# *52F9FD68005A_4ADEF93B0159_var*
 function lp_NodeId: Integer;
 var
  l_Node: InsPrimeNode;
 begin
  if Supports(aNode, InsPrimeNode, l_Node) then
   Result := l_Node.Data.GetId
  else
  begin
   Result := 0;
   Assert(False);
  end;
 end;//lp_NodeIndex

 function lp_NodeIndex: Integer;
 var
  l_Node: Il3Node;
 begin
  if Supports(aNode, Il3Node, l_Node) then
   Result := l_Node.GetNumInParent
  else
  begin
   Result := 0;
   Assert(False);
  end;
 end;//lp_NodeIndex
//#UC END# *52F9FD68005A_4ADEF93B0159_var*
begin
//#UC START# *52F9FD68005A_4ADEF93B0159_impl*
 DefDataAdapter.PrimeManager.Remove(lp_NodeId);
 if Assigned(f_OnDelNode) then
  f_OnDelNode(lp_NodeIndex);
 aNode.Delete;
 DataChanged := True;
 EditNodeIndex := -1;
//#UC END# *52F9FD68005A_4ADEF93B0159_impl*
end;//TnsPostingsTree.DeletePosting

procedure TnsPostingsTree.DeleteSelectedPostings(const aTreeView: IeeTreeView);
//#UC START# *52F9FDC0007C_4ADEF93B0159_var*
 function lp_Iterate(const anIntf: IeeNode): Boolean;
 begin//lp_Iterate
  Result := False;
  if (aTreeView.NodeFlags[anIntf] and FM_SELECTION) <> 0 then
   DeletePosting(anIntf);
 end;//lp_Iterate
//#UC END# *52F9FDC0007C_4ADEF93B0159_var*
begin
//#UC START# *52F9FDC0007C_4ADEF93B0159_impl*
 aTreeView.Tree.IterateF(eeL2NA(@lp_Iterate), 0);
//#UC END# *52F9FDC0007C_4ADEF93B0159_impl*
end;//TnsPostingsTree.DeleteSelectedPostings

procedure TnsPostingsTree.ExportSelected(const aTreeView: IeeTreeView;
 const aFileName: Il3CString);
//#UC START# *52F9FDDA019A_4ADEF93B0159_var*
var
 l_List: IKeysList;

 function lp_Iterate(const anIntf: IeeNode): Boolean;
 var
  l_Node: InsPrimeNode;
 begin//lp_Iterate
  Result := False;
  if ((aTreeView.NodeFlags[anIntf] and FM_SELECTION) <> 0) and Supports(anIntf, InsPrimeNode, l_Node) then
   l_List.Add(l_Node.Data.GetId);
 end;//lp_Iterate
//#UC END# *52F9FDDA019A_4ADEF93B0159_var*
begin
//#UC START# *52F9FDDA019A_4ADEF93B0159_impl*
 l_List := DefDataAdapter.NativeAdapter.MakeKeysList;
 try
  aTreeView.Tree.IterateF(eeL2NA(@lp_Iterate), 0);

  DefDataAdapter.PrimeManager.SaveListToXml(l_List, nsAStr(aFileName).S);
 finally
  l_List := nil;
 end;//try..finally
//#UC END# *52F9FDDA019A_4ADEF93B0159_impl*
end;//TnsPostingsTree.ExportSelected

function TnsPostingsTree.GetFirstQuery: IQuery;
 {* возвращает запрос для первой рассылки в списке. }
//#UC START# *52F9FDF500F5_4ADEF93B0159_var*
var
 l_List: IPrimeList;
 l_FirstNode: IPrime;
//#UC END# *52F9FDF500F5_4ADEF93B0159_var*
begin
//#UC START# *52F9FDF500F5_4ADEF93B0159_impl*
 DefDataAdapter.PrimeManager.GetList(l_List);
 try
  if (l_List = nil) or (l_List.Count = 0) then
   Result := nil
  else
  begin
   l_List.pm_GetItem(0, l_FirstNode);
   try
    l_FirstNode.GetQuery(Result);
   finally
    l_FirstNode := nil;
   end;
  end;
 finally
  l_List := nil;
 end;
 f_NeedLoad := False;
//#UC END# *52F9FDF500F5_4ADEF93B0159_impl*
end;//TnsPostingsTree.GetFirstQuery

function TnsPostingsTree.SaveOrCreateQuery: Boolean;
 {* чтобы не мотаться по формам, сделан некоторый реверанс в сторону "ручного" программирования, тем более, что все данные для этого есть. }
//#UC START# *52F9FE130263_4ADEF93B0159_var*
 procedure lp_Save;
 var
  l_Prime : IPrime;
  l_List  : IPrimeList;
 begin
  DefDataAdapter.PrimeManager.GetList(l_List);
  Assert(Assigned(l_List));
  l_List.pm_GetItem(EditNodeIndex, l_Prime);
  l_Prime.SetQuery(MgrSearch.Query);
  //Количество рассылок не изменилось, но изменилось их содержание.
  DataChanged := True;
  //При закрытии приложения нет смысла выставлять этот флаг.
  if not f_Closed then
   MgrSearch.Modified := False;
 end;

 function lp_New: Boolean;
 begin
  Result := SaveQuery2Adapter(MgrSearch.Query);
  if Result and not f_Closed then
   MgrSearch.Modified := False;
 end;
//#UC END# *52F9FE130263_4ADEF93B0159_var*
begin
//#UC START# *52F9FE130263_4ADEF93B0159_impl*
 try
  MgrSearch.Check;
  Result := True;
 except
  on E: EqaException do
  begin
   if not (E is EqaSilentAbort) then
    vcmShowMessageDlg(Tl3Message_C(nsCStr(E.Message),
                                   'TnsPostingsTree.SaveOrCreateQuery',
                                   mtError));
   Result := False;
   Exit;
  end;//on E: EqaException
 end;//try..except

 if MgrSearch.Save then
 begin
  if (EditNodeIndex <> -1) then
  begin
   Result := False;
   try
    CheckAndChangeCaption(True);
   except
    on EDuplicateName do
    begin
     vcmSay(inf_PostingAlreadyExist);
     Result := False;
     Exit;
    end;//EDuplicateName
   end;//try..except

   if vcmAsk(qr_QueryWasSaved) then
   begin
    CheckAndChangeCaption(False);
    lp_Save;
   end
   else
    Result := False;
  end
  else
   Result := lp_New;
 end
 else
  Result := False;
//#UC END# *52F9FE130263_4ADEF93B0159_impl*
end;//TnsPostingsTree.SaveOrCreateQuery

procedure TnsPostingsTree.ServerDownNotification;
//#UC START# *54F5D89D02FD_4ADEF93B0159_var*
//#UC END# *54F5D89D02FD_4ADEF93B0159_var*
begin
//#UC START# *54F5D89D02FD_4ADEF93B0159_impl*
 ServerDown := True;
//#UC END# *54F5D89D02FD_4ADEF93B0159_impl*
end;//TnsPostingsTree.ServerDownNotification

procedure TnsPostingsTree.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4ADEF93B0159_var*
//#UC END# *479731C50290_4ADEF93B0159_var*
begin
//#UC START# *479731C50290_4ADEF93B0159_impl*
 Tf1NotificationManager.RemoveListener(Self);
 f_LastCatalog := nil;
 f_OnAddNode := nil;
 f_OnDelNode := nil;
 f_Root := nil;
 f_MgrSearch := nil;
 inherited;
//#UC END# *479731C50290_4ADEF93B0159_impl*
end;//TnsPostingsTree.Cleanup

procedure TnsPostingsTree.InitFields;
//#UC START# *47A042E100E2_4ADEF93B0159_var*
//#UC END# *47A042E100E2_4ADEF93B0159_var*
begin
//#UC START# *47A042E100E2_4ADEF93B0159_impl*
 inherited;
 Tf1NotificationManager.AddListener(Self);
//#UC END# *47A042E100E2_4ADEF93B0159_impl*
end;//TnsPostingsTree.InitFields

procedure TnsPostingsTree.ClearFields;
begin
 f_Root := nil;
 LastCatalog := nil;
 inherited;
end;//TnsPostingsTree.ClearFields
{$IfEnd} // NOT Defined(Admin)

end.
