unit nsLastOpenDocTree;
 {* Дерево последних открытых документов }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsLastOpenDocTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsLastOpenDocTree" MUID: (490AE59703A6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsHistoryTree
 , l3Tree_TLB
 , l3TreeInterfaces
 , DocumentUnit
;

type
 TnsLastOpenDocTree = class(TnsHistoryTree)
  {* Дерево последних открытых документов }
  private
   f_FullDocName: Boolean;
   f_ForInpharm: Boolean;
  private
   function CreateNode(const aBookmark: IJournalBookmark): Il3Node;
    {* создаёт узел который умеет работать с IBookmark }
  protected
   function MakeRoot: Il3RootNode; override;
    {* Создаёт корень дерева }
  public
   constructor Create(aMaxCount: Integer;
    aForInpharm: Boolean;
    aFullDocName: Boolean); reintroduce;
   class function Make(aMaxCount: Integer;
    aForInpharm: Boolean;
    aFullDocName: Boolean = False): Il3SimpleTree; reintroduce;
 end;//TnsLastOpenDocTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsNodes
 {$If NOT Defined(NoVCM)}
 , vcmBase
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
 , DataAdapter
 , BaseTypesUnit
 , nsJournalBookmarkNode
;

function TnsLastOpenDocTree.CreateNode(const aBookmark: IJournalBookmark): Il3Node;
 {* создаёт узел который умеет работать с IBookmark }
//#UC START# *490AE5F60009_490AE59703A6_var*
//#UC END# *490AE5F60009_490AE59703A6_var*
begin
//#UC START# *490AE5F60009_490AE59703A6_impl*
 Result := TnsJournalBookmarkNode.Make(aBookmark, f_FullDocName);
//#UC END# *490AE5F60009_490AE59703A6_impl*
end;//TnsLastOpenDocTree.CreateNode

constructor TnsLastOpenDocTree.Create(aMaxCount: Integer;
 aForInpharm: Boolean;
 aFullDocName: Boolean);
//#UC START# *490AE8170294_490AE59703A6_var*
//#UC END# *490AE8170294_490AE59703A6_var*
begin
//#UC START# *490AE8170294_490AE59703A6_impl*
 inherited Create(aMaxCount);
 f_FullDocName := aFullDocName;
 f_ForInpharm := aForInpharm;
//#UC END# *490AE8170294_490AE59703A6_impl*
end;//TnsLastOpenDocTree.Create

class function TnsLastOpenDocTree.Make(aMaxCount: Integer;
 aForInpharm: Boolean;
 aFullDocName: Boolean = False): Il3SimpleTree;
var
 l_Inst : TnsLastOpenDocTree;
begin
 l_Inst := Create(aMaxCount, aForInpharm, aFullDocName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsLastOpenDocTree.Make

function TnsLastOpenDocTree.MakeRoot: Il3RootNode;
 {* Создаёт корень дерева }
//#UC START# *4909EF6E0361_490AE59703A6_var*

 procedure lp_CreateFakeNode;
 var
  l_Node  : Il3Node;
 begin
  l_Node := CreateNode(nil);
  try
   l_Node.Text := vcmCStr(str_lrDocumentAbsent).AsWStr;
   Result.InsertChild(l_Node);
  finally
   l_Node := nil;
  end;//try..finally
 end;//lp_CreateFakeNode

var
 l_List   : IJournalBookmarkList;
 l_Index  : Integer;
 l_AddDoc : Boolean;
 l_Item   : IJournalBookMark;
//#UC END# *4909EF6E0361_490AE59703A6_var*
begin
//#UC START# *4909EF6E0361_490AE59703A6_impl*
 // Root
 Result := CreateNode(nil) as Il3RootNode;
 // Покажем закладки
 try
  l_List := dmStdRes.MakeWorkJournal.MakeBookMarkHistory(f_ForInpharm, MaxCount);
  l_AddDoc := False;
  if Assigned(l_List) then
   for l_Index := 0 to Pred(l_List.Count) do
   begin
    l_List.pm_GetItem(l_Index, l_Item);
     // При замене одной базы на другую, если в новой отсутствуют
    if Assigned(l_Item) then
     begin
      l_AddDoc := True;
     Result.InsertChild(CreateNode(l_Item));
    end;
     end;
  // Ни одного документа не получена, создадим фиктивный узел "Документов нет"
  if not l_AddDoc then
   lp_CreateFakeNode;
 except
  // документов нет
  on ECanNotFindData do
   lp_CreateFakeNode;
 end;//try..except
//#UC END# *4909EF6E0361_490AE59703A6_impl*
end;//TnsLastOpenDocTree.MakeRoot
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
