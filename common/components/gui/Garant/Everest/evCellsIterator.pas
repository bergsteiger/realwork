unit evCellsIterator;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evCellsIterator.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaUtils::TevCellsIterator
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
uses
  nevBase,
  nevTools,
  evEditorInterfaces,
  evCustomParaListUtils,
  l3Variant
  ;
{$IfEnd} //evNeedEditableCursors AND k2ForEditor

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
type
 TevCellsIterator = class(TevRowChild, IedBackCellsIterator, IedCellsIterator)
 private
 // private fields
   f_NeedNeighbours : Boolean;
   f_StartCell : Integer;
   f_First : Integer;
 protected
 // realized methods
   function Last(aNeedNeighbours: Boolean): IedCell;
     {* возвращает последнюю ячейку и начинает перебор }
   function Prev: IedCell;
     {* возвращает предыдущую ячейку или nil, если перебор закончен }
   function pm_GetBackIterator: IedBackCellsIterator;
   function First(aNeedNeighbours: Boolean): IedCell;
     {* возвращает первую ячейку и начинает перебор }
   function Next: IedCell;
     {* возвращает следующую ячейку или nil, если перебор закончен }
   function CellsCount: Integer;
     {* Количество ячеек }
 public
 // public methods
   class function Make(const aView: InevView;
     const aRow: IedRow;
     aTagWrap: Tl3Variant;
     const aProcessor: InevProcessor;
     const aLocation: InevLocation = nil): IedCellsIterator;
 end;//TevCellsIterator
{$IfEnd} //evNeedEditableCursors AND k2ForEditor

implementation

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}
uses
  l3Base,
  SysUtils,
  nevFacade
  ;
{$IfEnd} //evNeedEditableCursors AND k2ForEditor

{$If defined(evNeedEditableCursors) AND defined(k2ForEditor)}

// start class TevCellsIterator

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
  // - Следующий раз начинаем с предыдущей ячейки
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
  // - Следующий раз начинаем со следующей ячейки
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
//#UC START# *4BBC947B0399_4FC48D1B02AC_var*
//#UC END# *4BBC947B0399_4FC48D1B02AC_var*
begin
//#UC START# *4BBC947B0399_4FC48D1B02AC_impl*
 Result := TagInst.ChildrenCount;
//#UC END# *4BBC947B0399_4FC48D1B02AC_impl*
end;//TevCellsIterator.CellsCount

{$IfEnd} //evNeedEditableCursors AND k2ForEditor

end.