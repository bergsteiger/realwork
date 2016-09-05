unit evReqCellCursor;

// Модуль: "w:\common\components\gui\Garant\Everest\evReqCellCursor.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevReqCellCursor" MUID: (53D0BFE802C7)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evTableCellCursor
 , nevTools
 , nevBase
;

type
 TevReqCellCursor = class(TevTableCellCursor)
  protected
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
 end;//TevReqCellCursor
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
 , evOp
 //#UC START# *53D0BFE802C7impl_uses*
 //#UC END# *53D0BFE802C7impl_uses*
;

function TevReqCellCursor.DoMovePrim(const aView: InevView;
 aCode: Integer;
 const anOp: InevOp;
 aCount: Integer): TnevMoveResult;
//#UC START# *49E31657038E_53D0BFE802C7_var*
//#UC END# *49E31657038E_53D0BFE802C7_var*
begin
//#UC START# *49E31657038E_53D0BFE802C7_impl*
 Case aCode of
  ev_ocColumnLeft,
  ev_ocColumnRight :
   if not Self.HasInner then
    Result := inherited DoMovePrim(aView, aCode, anOp, aCount)
   else
    Result := Self.GetInner.DoMove(aView, aCode, anOp, aCount);
(*  ev_ocColumnRight :
  begin
   Move(ev_ocListEnd, anOp);
   Move(ev_ocParaRight, anOp);
   Result := ev_dcDoneOk;
  end;//ev_ocColumnLeft*)
  else
   Result := inherited DoMovePrim(aView, aCode, anOp, aCount);
 end;//Case aCode
//#UC END# *49E31657038E_53D0BFE802C7_impl*
end;//TevReqCellCursor.DoMovePrim
{$IfEnd} // Defined(evUseVisibleCursors)

end.
