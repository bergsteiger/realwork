unit bsWorkJournalPrim;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\WorkJournal\bsWorkJournalPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TbsWorkJournalPrim" MUID: (4A825E02010E)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3SimpleObject
 , WorkJournalInterfaces
 , nsWorkJournalListeners
 , l3TreeInterfaces
 , SearchUnit
 , DocumentUnit
 , PrimWorkJournalInterfaces
;

type
 TbsWorkJournalPrim = class(Tl3SimpleObject, IbsWorkJournal)
  private
   f_Listeners: TnsWorkJournalListeners;
  protected
   function MakeTree: Il3SimpleTree;
   procedure Clear;
   procedure AddQuery(const aQuery: IQuery);
   procedure AddBookMark(const aBookMark: IJournalBookmark);
   function MakeQueryHistory(aQueryType: TQueryType;
    aMaxCount: Cardinal): IQueryList;
   function MakeBookMarkHistory(ForInpharm: Boolean;
    aMaxCount: Cardinal): IJournalBookmarkList;
   procedure Delete(const aNode: Il3SimpleNode);
   procedure RegisterListener(const aListener: InsWorkJournalListener);
   procedure UnRegisterListener(const aListener: InsWorkJournalListener);
   procedure NotifyJournalShrinked;
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   class function Make: IbsWorkJournal; reintroduce;
   constructor Create; reintroduce;
 end;//TbsWorkJournalPrim
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsJournalTreeStruct
 , DataAdapter
 , DynamicTreeUnit
 , UserJournalUnit
 , SysUtils
 {$If NOT Defined(NoVCM)}
 , StdRes
 {$IfEnd} // NOT Defined(NoVCM)
;

class function TbsWorkJournalPrim.Make: IbsWorkJournal;
var
 l_Inst : TbsWorkJournalPrim;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TbsWorkJournalPrim.Make

constructor TbsWorkJournalPrim.Create;
//#UC START# *4A83AD2D030F_4A825E02010E_var*
//#UC END# *4A83AD2D030F_4A825E02010E_var*
begin
//#UC START# *4A83AD2D030F_4A825E02010E_impl*
 inherited Create;
 f_Listeners := TnsWorkJournalListeners.MakeSOrted;
//#UC END# *4A83AD2D030F_4A825E02010E_impl*
end;//TbsWorkJournalPrim.Create

function TbsWorkJournalPrim.MakeTree: Il3SimpleTree;
//#UC START# *4A825DBE0310_4A825E02010E_var*
var
 l_Root: INodeBase;
//#UC END# *4A825DBE0310_4A825E02010E_var*
begin
//#UC START# *4A825DBE0310_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.GetUserJornalTree(l_Root);
 Result := TnsJournalTreeStruct.Make(l_Root, False);
//#UC END# *4A825DBE0310_4A825E02010E_impl*
end;//TbsWorkJournalPrim.MakeTree

procedure TbsWorkJournalPrim.Clear;
//#UC START# *4A825E760100_4A825E02010E_var*
//#UC END# *4A825E760100_4A825E02010E_var*
begin
//#UC START# *4A825E760100_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.Clear;
 NotifyJournalShrinked;
//#UC END# *4A825E760100_4A825E02010E_impl*
end;//TbsWorkJournalPrim.Clear

procedure TbsWorkJournalPrim.AddQuery(const aQuery: IQuery);
//#UC START# *4A82602103A2_4A825E02010E_var*
//#UC END# *4A82602103A2_4A825E02010E_var*
begin
//#UC START# *4A82602103A2_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.Save(aQuery, JOT_QUERY);
//#UC END# *4A82602103A2_4A825E02010E_impl*
end;//TbsWorkJournalPrim.AddQuery

procedure TbsWorkJournalPrim.AddBookMark(const aBookMark: IJournalBookmark);
//#UC START# *4A826038019A_4A825E02010E_var*
//#UC END# *4A826038019A_4A825E02010E_var*
begin
//#UC START# *4A826038019A_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.Save(aBookMark, JOT_BOOKMARK);
//#UC END# *4A826038019A_4A825E02010E_impl*
end;//TbsWorkJournalPrim.AddBookMark

function TbsWorkJournalPrim.MakeQueryHistory(aQueryType: TQueryType;
 aMaxCount: Cardinal): IQueryList;
//#UC START# *4A8261F2003D_4A825E02010E_var*
//#UC END# *4A8261F2003D_4A825E02010E_var*
begin
//#UC START# *4A8261F2003D_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.GetQueryHistory(aQueryType, aMaxCount, Result);
//#UC END# *4A8261F2003D_4A825E02010E_impl*
end;//TbsWorkJournalPrim.MakeQueryHistory

function TbsWorkJournalPrim.MakeBookMarkHistory(ForInpharm: Boolean;
 aMaxCount: Cardinal): IJournalBookmarkList;
//#UC START# *4A82623302E1_4A825E02010E_var*
const
 cMap: array [Boolean] of TBookmarkJournalType = (BJT_BOOKMARK, BJT_PHARM_BOOKMARK);
//#UC END# *4A82623302E1_4A825E02010E_var*
begin
//#UC START# *4A82623302E1_4A825E02010E_impl*
 defDataAdapter.NativeAdapter.MakeUserJournal.GetBookmarkHistory(cMap[ForInpharm], aMaxCount, Result);
//#UC END# *4A82623302E1_4A825E02010E_impl*
end;//TbsWorkJournalPrim.MakeBookMarkHistory

procedure TbsWorkJournalPrim.Delete(const aNode: Il3SimpleNode);
//#UC START# *4A8277980075_4A825E02010E_var*
var
 l_Node: INodeBase;
//#UC END# *4A8277980075_4A825E02010E_var*
begin
//#UC START# *4A8277980075_4A825E02010E_impl*
 if Supports(aNode, INodeBase, l_Node) then
 begin
  defDataAdapter.NativeAdapter.MakeUserJournal.Remove(l_Node);
  NotifyJournalShrinked;
 end;
//#UC END# *4A8277980075_4A825E02010E_impl*
end;//TbsWorkJournalPrim.Delete

procedure TbsWorkJournalPrim.RegisterListener(const aListener: InsWorkJournalListener);
//#UC START# *4A83AD4402AC_4A825E02010E_var*
//#UC END# *4A83AD4402AC_4A825E02010E_var*
begin
//#UC START# *4A83AD4402AC_4A825E02010E_impl*
 f_Listeners.Add(aListener);
//#UC END# *4A83AD4402AC_4A825E02010E_impl*
end;//TbsWorkJournalPrim.RegisterListener

procedure TbsWorkJournalPrim.UnRegisterListener(const aListener: InsWorkJournalListener);
//#UC START# *4A83AD6D02B9_4A825E02010E_var*
//#UC END# *4A83AD6D02B9_4A825E02010E_var*
begin
//#UC START# *4A83AD6D02B9_4A825E02010E_impl*
 f_Listeners.Remove(aListener);
//#UC END# *4A83AD6D02B9_4A825E02010E_impl*
end;//TbsWorkJournalPrim.UnRegisterListener

procedure TbsWorkJournalPrim.NotifyJournalShrinked;
//#UC START# *4A83ADA701C0_4A825E02010E_var*
var
 l_IDX: Integer;
//#UC END# *4A83ADA701C0_4A825E02010E_var*
begin
//#UC START# *4A83ADA701C0_4A825E02010E_impl*
 for l_IDX := 0 to f_Listeners.Count - 1 do
  f_Listeners[l_IDX].JournalShrinked;
//#UC END# *4A83ADA701C0_4A825E02010E_impl*
end;//TbsWorkJournalPrim.NotifyJournalShrinked

procedure TbsWorkJournalPrim.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_4A825E02010E_var*
//#UC END# *479731C50290_4A825E02010E_var*
begin
//#UC START# *479731C50290_4A825E02010E_impl*
 FreeAndNil(f_Listeners);
 inherited Cleanup;
//#UC END# *479731C50290_4A825E02010E_impl*
end;//TbsWorkJournalPrim.Cleanup
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
