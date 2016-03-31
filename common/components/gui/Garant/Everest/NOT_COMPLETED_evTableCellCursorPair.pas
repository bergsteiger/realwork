unit NOT_COMPLETED_evTableCellCursorPair;
 {* Выделение для ячейки таблицы }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evTableCellCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableCellCursorPair" MUID: (52E24FBF0273)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
 , l3Variant
 , nevBase
;

type
 TevTableCellCursorPair = class(TevParaListCursorPair)
  {* Выделение для ячейки таблицы }
  protected
   function DoSetAtom(const aView: InevView;
    anIndex: Cardinal;
    pSource: Tl3Variant;
    const anOp: InevOp): Boolean; override;
 end;//TevTableCellCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , k2Tags
;

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
{$IfEnd} // Defined(evUseVisibleCursors)

end.
