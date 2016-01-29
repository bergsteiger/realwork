unit evTableCellCursorPair;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evTableCellCursorPair.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevTableCellCursorPair
//
// Выделение для ячейки таблицы
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Everest\evDefine.inc}

interface

{$If defined(evUseVisibleCursors)}
uses
  evParaListCursorPair,
  nevBase,
  nevTools,
  l3Variant
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevTableCellCursorPair = class(TevParaListCursorPair)
  {* Выделение для ячейки таблицы }
 protected
 // overridden protected methods
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; override;
 end;//TevTableCellCursorPair
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  k2Tags
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevTableCellCursorPair

function TevTableCellCursorPair.DoSetAtom(const aView: InevView;
  anIndex: Cardinal;
  pSource: Tl3Variant;
  const anOp: InevOp): Boolean;
//#UC START# *4A38F7A40373_52E24FBF0273_var*
//#UC END# *4A38F7A40373_52E24FBF0273_var*
begin
//#UC START# *4A38F7A40373_52E24FBF0273_impl*
{$IfDef evNeedEditableCursors}
 if (anIndex = k2_tiVerticalAligment) then
 begin
  Result := true;
  GetRedirect.AttrW[anIndex, anOp] := pSource.AsObject;
 end//anIndex = k2_tiVerticalAligment
 else
{$EndIf evNeedEditableCursors}
  Result := inherited DoSetAtom(aView, anIndex, pSource, anOp);
//#UC END# *4A38F7A40373_52E24FBF0273_impl*
end;//TevTableCellCursorPair.DoSetAtom

{$IfEnd} //evUseVisibleCursors

end.