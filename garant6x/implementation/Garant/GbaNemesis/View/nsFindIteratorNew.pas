unit nsFindIteratorNew;
 {* Реализация IFindIterator для нового представления документов (без деревьев) }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\nsFindIteratorNew.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsFindIteratorNew" MUID: (4C9C918102BC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObjectForTie
 , DynamicTreeUnit
 , DocumentUnit
;

type
 TnsFindIteratorNew = class(Tl3ProtoObjectForTie, IFindIterator)
  {* Реализация IFindIterator для нового представления документов (без деревьев) }
  private
   f_Current: Integer;
   f_List: IContextList;
  protected
   procedure Next; stdcall;
    {* Перемещенеи итератора на следующий элемент. }
   procedure Prev; stdcall;
    {* Перемещенеи итератора на предыдущий элемент. }
   function IsGood: ByteBool; stdcall;
    {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
   procedure GetPosition(out aRet
    {* IFindPositionList }); stdcall;
   function IsFirst: ByteBool; stdcall;
    {* возвращает true, если нельзя перейти на предыдущий фрагмент }
   function GetCount: Cardinal; stdcall;
   procedure ClearFields; override;
  public
   constructor Create(const aContext: IFoundContext); reintroduce; overload;
   class function Make(const aContext: IFoundContext): IFindIterator; reintroduce; overload;
   constructor Create(const aList: IContextList); reintroduce; overload;
   class function Make(const aList: IContextList): IFindIterator; reintroduce; overload;
 end;//TnsFindIteratorNew
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsFindIteratorNewFindPositionList
;

constructor TnsFindIteratorNew.Create(const aContext: IFoundContext);
//#UC START# *4C9C92330122_4C9C918102BC_var*
var
 l_List : IContextList;
//#UC END# *4C9C92330122_4C9C918102BC_var*
begin
//#UC START# *4C9C92330122_4C9C918102BC_impl*
 if (aContext <> nil) then
  aContext.GetList(l_List)
 else
  l_List := nil;
 Create(l_List);
//#UC END# *4C9C92330122_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Create

class function TnsFindIteratorNew.Make(const aContext: IFoundContext): IFindIterator;
var
 l_Inst : TnsFindIteratorNew;
begin
 l_Inst := Create(aContext);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNew.Make

constructor TnsFindIteratorNew.Create(const aList: IContextList);
//#UC START# *4D8A1E420133_4C9C918102BC_var*
//#UC END# *4D8A1E420133_4C9C918102BC_var*
begin
//#UC START# *4D8A1E420133_4C9C918102BC_impl*
 inherited Create;
 f_Current := -1;
 f_List := aList;
//#UC END# *4D8A1E420133_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Create

class function TnsFindIteratorNew.Make(const aList: IContextList): IFindIterator;
var
 l_Inst : TnsFindIteratorNew;
begin
 l_Inst := Create(aList);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnsFindIteratorNew.Make

procedure TnsFindIteratorNew.Next;
 {* Перемещенеи итератора на следующий элемент. }
//#UC START# *45EEC28202A0_4C9C918102BC_var*
//#UC END# *45EEC28202A0_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A0_4C9C918102BC_impl*
 Assert(f_Current <= Pred(GetCount));
 Inc(f_Current);
//#UC END# *45EEC28202A0_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Next

procedure TnsFindIteratorNew.Prev;
 {* Перемещенеи итератора на предыдущий элемент. }
//#UC START# *45EEC28202A1_4C9C918102BC_var*
//#UC END# *45EEC28202A1_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A1_4C9C918102BC_impl*
 Assert(f_Current >= 0);
 Dec(f_Current);
//#UC END# *45EEC28202A1_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Prev

function TnsFindIteratorNew.IsGood: ByteBool;
 {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
//#UC START# *45EEC28202A2_4C9C918102BC_var*
//#UC END# *45EEC28202A2_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A2_4C9C918102BC_impl*
 Result := (GetCount > 0) AND
           (f_Current >= 0) AND (f_Current <= Pred(GetCount));
//#UC END# *45EEC28202A2_4C9C918102BC_impl*
end;//TnsFindIteratorNew.IsGood

procedure TnsFindIteratorNew.GetPosition(out aRet
 {* IFindPositionList });
//#UC START# *461D00B9005D_4C9C918102BC_var*
var
 l_GotList : IFragmentList;
//#UC END# *461D00B9005D_4C9C918102BC_var*
begin
//#UC START# *461D00B9005D_4C9C918102BC_impl*
 Assert(IsGood);
 f_List.pm_GetItem(f_Current, l_GotList);
 IFindPositionList(aRet) := TnsFindIteratorNewFindPositionList.Make(l_GotList);
//#UC END# *461D00B9005D_4C9C918102BC_impl*
end;//TnsFindIteratorNew.GetPosition

function TnsFindIteratorNew.IsFirst: ByteBool;
 {* возвращает true, если нельзя перейти на предыдущий фрагмент }
//#UC START# *49FEC51501D8_4C9C918102BC_var*
//#UC END# *49FEC51501D8_4C9C918102BC_var*
begin
//#UC START# *49FEC51501D8_4C9C918102BC_impl*
 Result := (f_Current <= 0);
//#UC END# *49FEC51501D8_4C9C918102BC_impl*
end;//TnsFindIteratorNew.IsFirst

function TnsFindIteratorNew.GetCount: Cardinal;
//#UC START# *49FFDC8B015D_4C9C918102BCget_var*
//#UC END# *49FFDC8B015D_4C9C918102BCget_var*
begin
//#UC START# *49FFDC8B015D_4C9C918102BCget_impl*
 if (f_List = nil) then
  Result := 0
 else
  Result := f_List.Count;
//#UC END# *49FFDC8B015D_4C9C918102BCget_impl*
end;//TnsFindIteratorNew.GetCount

procedure TnsFindIteratorNew.ClearFields;
begin
 Finalize(f_List);
 inherited;
end;//TnsFindIteratorNew.ClearFields
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
