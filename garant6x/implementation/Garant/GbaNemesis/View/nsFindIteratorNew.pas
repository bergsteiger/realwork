unit nsFindIteratorNew;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/nsFindIteratorNew.pas"
// Начат: 24.09.2010 15:55
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Base Operations::View::ContextSearchInEVDDocument::TnsFindIteratorNew
//
// Реализация IFindIterator для нового представления документов (без деревьев)
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
  DynamicTreeUnit,
  l3ProtoObjectForTie
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsFindIteratorNew = class(Tl3ProtoObjectForTie, IFindIterator)
  {* Реализация IFindIterator для нового представления документов (без деревьев) }
 private
 // private fields
   f_Current : Integer;
   f_List : IContextList;
 protected
 // realized methods
   procedure Next; stdcall;
     {* Перемещенеи итератора на следующий элемент. }
   procedure Prev; stdcall;
     {* Перемещенеи итератора на предыдущий элемент. }
   function IsGood: ByteBool; stdcall;
     {* Возвращает true, если по итератору можно получить данные, т.е. position. Иначе итератор за концом, т.е. равен end или вообще пуст }
   procedure GetPosition(out aRet {: IFindPositionList}); stdcall;
   function IsFirst: ByteBool; stdcall;
     {* возвращает true, если нельзя перейти на предыдущий фрагмент }
   function GetCount: Cardinal; stdcall;
 protected
 // overridden protected methods
   procedure ClearFields; override;
     {* Сигнатура метода ClearFields }
 public
 // public methods
   constructor Create(const aContext: IFoundContext); reintroduce; overload; 
   class function Make(const aContext: IFoundContext): IFindIterator; reintroduce; overload; 
     {* Сигнатура фабрики TnsFindIteratorNew.Make }
   constructor Create(const aList: IContextList); overload; 
   class function Make(const aList: IContextList): IFindIterator; reintroduce; overload; 
     {* Сигнатура фабрики TnsFindIteratorNew.Make$1 }
 end;//TnsFindIteratorNew
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsFindIteratorNewFindPositionList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsFindIteratorNew

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
end;

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
end;

procedure TnsFindIteratorNew.Next;
//#UC START# *45EEC28202A0_4C9C918102BC_var*
//#UC END# *45EEC28202A0_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A0_4C9C918102BC_impl*
 Assert(f_Current <= Pred(GetCount));
 Inc(f_Current);
//#UC END# *45EEC28202A0_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Next

procedure TnsFindIteratorNew.Prev;
//#UC START# *45EEC28202A1_4C9C918102BC_var*
//#UC END# *45EEC28202A1_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A1_4C9C918102BC_impl*
 Assert(f_Current >= 0);
 Dec(f_Current);
//#UC END# *45EEC28202A1_4C9C918102BC_impl*
end;//TnsFindIteratorNew.Prev

function TnsFindIteratorNew.IsGood: ByteBool;
//#UC START# *45EEC28202A2_4C9C918102BC_var*
//#UC END# *45EEC28202A2_4C9C918102BC_var*
begin
//#UC START# *45EEC28202A2_4C9C918102BC_impl*
 Result := (GetCount > 0) AND
           (f_Current >= 0) AND (f_Current <= Pred(GetCount));
//#UC END# *45EEC28202A2_4C9C918102BC_impl*
end;//TnsFindIteratorNew.IsGood

procedure TnsFindIteratorNew.GetPosition(out aRet {: IFindPositionList});
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
 {-}
begin
 {$If not defined(Admin) AND not defined(Monitorings)}
 f_List := nil;
 {$IfEnd} //not Admin AND not Monitorings
 inherited;
end;//TnsFindIteratorNew.ClearFields

{$IfEnd} //not Admin AND not Monitorings

end.