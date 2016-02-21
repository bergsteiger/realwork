unit evCellsIterator;

// ћодуль: "w:\common\components\gui\Garant\Everest\evCellsIterator.pas"
// —тереотип: "SimpleClass"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3IntfUses
 , evCustomParaListUtils
 , evEditorInterfaces
 , nevTools
 , l3Variant
 , nevBase
;

type
 TevCellsIterator = class(TevRowChild, IedBackCellsIterator, IedCellsIterator)
  private
   f_NeedNeighbours: Boolean;
   f_StartCell: Integer;
   f_First: Integer;
  protected
   function Last(aNeedNeighbours: Boolean): IedCell;
    {* возвращает последнюю €чейку и начинает перебор }
   function Prev: IedCell;
    {* возвращает предыдущую €чейку или nil, если перебор закончен }
   function pm_GetBackIterator: IedBackCellsIterator;
   function First(aNeedNeighbours: Boolean): IedCell;
    {* возвращает первую €чейку и начинает перебор }
   function Next: IedCell;
    {* возвращает следующую €чейку или nil, если перебор закончен }
   function CellsCount: Integer;
    {*  оличество €чеек }
  public
   class function Make(const aView: InevView;
    const aRow: IedRow;
    aTagWrap: Tl3Variant;
    const aProcessor: InevProcessor;
    const aLocation: InevLocation = nil): IedCellsIterator;
 end;//TevCellsIterator
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

implementation

{$If Defined(k2ForEditor) AND Defined(evNeedEditableCursors)}
uses
 l3ImplUses
 , l3Base
 , SysUtils
 , nevFacade
;

class function TevCellsIterator.Make(const aView: InevView;
 const aRow: IedRow;
 aTagWrap: Tl3Variant;
 const aProcessor: InevProcessor;
 const aLocation: InevLocation = nil): IedCellsIterator;
//#UC START# *4FC48DC101EB_4FC48D1B02AC_var*
var
 l_CellsIterator : TevCellsIterator;
//#UC END# *4FC48DC101EB_4FC48D1B02AC_var*
begin
//#UC START# *4FC48DC101EB_4FC48D1B02AC_impl*
 l_CellsIterator := Create(aView, aRow, aTagWrap, aProcessor, aLocation);
 try
  Result := l_CellsIterator;
 finally
  l3Free(l_CellsIterator);
 end;//try..finally
//#UC END# *4FC48DC101EB_4FC48D1B02AC_impl*
end;//TevCellsIterator.Make

function TevCellsIterator.Last(aNeedNeighbours: Boolean): IedCell;
 {* возвращает последнюю €чейку и начинает перебор }
//#UC START# *4BBC922302CA_4FC48D1B02AC_var*
//#UC END# *4BBC922302CA_4FC48D1B02AC_var*
begin
//#UC START# *4BBC922302CA_4FC48D1B02AC_impl*
 f_First := TagInst.ChildrenCount - 1;
 f_NeedNeighbours := aNeedNeighbours;
 Result := Prev;
//#UC END# *4BBC922302CA_4FC48D1B02AC_impl*
end;//TevCellsIterator.Last

function TevCellsIterator.Prev: IedCell;
 {* возвращает предыдущую €чейку или nil, если перебор закончен }
//#UC START# *4BBC92390009_4FC48D1B02AC_var*
var
 l_Result : IedCell absolute Result;

 function _DoCell(const aCellBlock: InevRange; anIndex: Integer): Boolean;
 var
  l_Para : InevPara;
 begin//_DoCell
  Result := false;
  l_Para := aCellBlock.Obj.AsPara;
  l_Result := GetRow.Table.GetTagCell(TagInst, l_Para, anIndex, aCellBlock, f_NeedNeighbours);
  Dec(f_First);
  // - —ледующий раз начинаем с предыдущей €чейки
 end;//_DoCell

var
 l_Sel : InevRange;
//#UC END# *4BBC92390009_4FC48D1B02AC_var*
begin
//#UC START# *4BBC92390009_4FC48D1B02AC_impl*
 Result := nil;
 if f_First < 0 then Exit;
 if Supports(f_Location, InevRange, l_Sel) then
  l_Sel.IterateF(evL2TSA(@_DoCell), f_First)
//#UC END# *4BBC92390009_4FC48D1B02AC_impl*
end;//TevCellsIterator.Prev

function TevCellsIterator.pm_GetBackIterator: IedBackCellsIterator;
//#UC START# *4BBC9430038B_4FC48D1B02ACget_var*
//#UC END# *4BBC9430038B_4FC48D1B02ACget_var*
begin
//#UC START# *4BBC9430038B_4FC48D1B02ACget_impl*
 Result := Self;
//#UC END# *4BBC9430038B_4FC48D1B02ACget_impl*
end;//TevCellsIterator.pm_GetBackIterator

function TevCellsIterator.First(aNeedNeighbours: Boolean): IedCell;
 {* возвращает первую €чейку и начинает перебор }
//#UC START# *4BBC944C0195_4FC48D1B02AC_var*
//#UC END# *4BBC944C0195_4FC48D1B02AC_var*
begin
//#UC START# *4BBC944C0195_4FC48D1B02AC_impl*
 f_First := f_StartCell;
 f_NeedNeighbours := aNeedNeighbours;
 Result := Next;
//#UC END# *4BBC944C0195_4FC48D1B02AC_impl*
end;//TevCellsIterator.First

function TevCellsIterator.Next: IedCell;
 {* возвращает следующую €чейку или nil, если перебор закончен }
//#UC START# *4BBC94640082_4FC48D1B02AC_var*
var
 l_Result : IedCell absolute Result;

 function _DoCell(const aCellBlock: InevRange; anIndex: Integer): Boolean;
 var
  l_Para : InevPara;
 begin//_DoCell
  Result := false;
  l_Para := aCellBlock.Obj.AsPara;
  l_Result := GetRow.Table.GetTagCell(TagInst, l_Para, anIndex, aCellBlock, f_NeedNeighbours);
  f_First := anIndex + 1;
  // - —ледующий раз начинаем со следующей €чейки
 end;//_DoCell

var
 l_Sel : InevRange;
//#UC END# *4BBC94640082_4FC48D1B02AC_var*
begin
//#UC START# *4BBC94640082_4FC48D1B02AC_impl*
 Result := nil;
 if Supports(f_Location, InevRange, l_Sel) then
  l_Sel.IterateF(evL2TSA(@_DoCell), f_First)
//#UC END# *4BBC94640082_4FC48D1B02AC_impl*
end;//TevCellsIterator.Next

function TevCellsIterator.CellsCount: Integer;
 {*  оличество €чеек }
//#UC START# *4BBC947B0399_4FC48D1B02AC_var*
//#UC END# *4BBC947B0399_4FC48D1B02AC_var*
begin
//#UC START# *4BBC947B0399_4FC48D1B02AC_impl*
 Result := TagInst.ChildrenCount;
//#UC END# *4BBC947B0399_4FC48D1B02AC_impl*
end;//TevCellsIterator.CellsCount
{$IfEnd} // Defined(k2ForEditor) AND Defined(evNeedEditableCursors)

end.
