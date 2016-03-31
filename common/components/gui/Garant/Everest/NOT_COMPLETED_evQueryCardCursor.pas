unit NOT_COMPLETED_evQueryCardCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evQueryCardCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevQueryCardCursor" MUID: (4BFFD963014E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evDocumentCursor
;

type
 TevQueryCardCursor = class(TevDocumentCursor)
  protected
   function CanInsertParaOnMove: Boolean; override;
 end;//TevQueryCardCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;

function TevQueryCardCursor.CanInsertParaOnMove: Boolean;
//#UC START# *4BFFD9C80181_4BFFD963014E_var*
//#UC END# *4BFFD9C80181_4BFFD963014E_var*
begin
//#UC START# *4BFFD9C80181_4BFFD963014E_impl*
 {$IfDef Nemesis}
 Result := false;
 {$Else  Nemesis}
 Result := inherited CanInsertParaOnMove;
 {$EndIf Nemesis}
//#UC END# *4BFFD9C80181_4BFFD963014E_impl*
end;//TevQueryCardCursor.CanInsertParaOnMove
{$IfEnd} // Defined(evUseVisibleCursors)

end.
