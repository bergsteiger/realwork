unit nsLastOpenDocTree;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Common$Lib"
// Автор: Морозов М.А.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsLastOpenDocTree.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::MainMenu::TnsLastOpenDocTree
//
// Дерево последних открытых документов
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit,
  l3TreeInterfaces,
  l3Tree_TLB,
  nsHistoryTree
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsLastOpenDocTree = class(TnsHistoryTree)
  {* Дерево последних открытых документов }
 private
 // private fields
   f_FullDocName : Boolean;
   f_ForInpharm : Boolean;
 private
 // private methods
   function CreateNode(const aBookmark: IJournalBookmark): Il3Node;
     {* создаёт узел который умеет работать с IBookmark }
 protected
 // overridden protected methods
   function MakeRoot: Il3RootNode; override;
     {* Создаёт корень дерева }
 public
 // public methods
   constructor Create(aMaxCount: Integer;
    aForInpharm: Boolean;
    aFullDocName: Boolean); reintroduce;
   class function Make(aMaxCount: Integer;
    aForInpharm: Boolean;
    aFullDocName: Boolean = false): Il3SimpleTree; reintroduce;
 end;//TnsLastOpenDocTree
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsNodes
  {$If not defined(NoVCM)}
  ,
  vcmBase
  {$IfEnd} //not NoVCM
  
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  ,
  DataAdapter,
  BaseTypesUnit,
  nsJournalBookmarkNode
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsLastOpenDocTree

function TnsLastOpenDocTree.CreateNode(const aBookmark: IJournalBookmark): Il3Node;
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
  aFullDocName: Boolean = false): Il3SimpleTree;
var
 l_Inst : TnsLastOpenDocTree;
begin
 l_Inst := Create(aMaxCount, aForInpharm, aFullDocName);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;

function TnsLastOpenDocTree.MakeRoot: Il3RootNode;
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

{$IfEnd} //not Admin AND not Monitorings

end.