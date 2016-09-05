unit NOT_FINISHED_evTableRowCursorPair;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evTableRowCursorPair.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevTableRowCursorPair" MUID: (53D6758E0352)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPair
 , nevTools
;

type
 TevTableRowCursorPair = class(TevParaListCursorPair)
  protected
   procedure CorrectChildBlock(const aView: InevView;
    const aSearcher: IevSearcher;
    const aChildBlock: InevRange); override;
 end;//TevTableRowCursorPair
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 //#UC START# *53D6758E0352impl_uses*
 //#UC END# *53D6758E0352impl_uses*
;

procedure TevTableRowCursorPair.CorrectChildBlock(const aView: InevView;
 const aSearcher: IevSearcher;
 const aChildBlock: InevRange);
//#UC START# *57C6AE1200E7_53D6758E0352_var*
//#UC END# *57C6AE1200E7_53D6758E0352_var*
begin
//#UC START# *57C6AE1200E7_53D6758E0352_impl*
 !!! Needs to be implemented !!!
//#UC END# *57C6AE1200E7_53D6758E0352_impl*
end;//TevTableRowCursorPair.CorrectChildBlock
{$IfEnd} // Defined(evUseVisibleCursors)

end.
