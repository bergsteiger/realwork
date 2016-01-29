unit evReqCellCursor;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Everest"
// Модуль: "w:/common/components/gui/Garant/Everest/evReqCellCursor.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi::Everest::ParaList Cursors::TevReqCellCursor
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
  evTableCellCursor,
  nevBase,
  nevTools
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}
type
 TevReqCellCursor = class(TevTableCellCursor)
 protected
 // overridden protected methods
   function DoMovePrim(const aView: InevView;
    aCode: Integer;
    const anOp: InevOp;
    aCount: Integer): TnevMoveResult; override;
 end;//TevReqCellCursor
{$IfEnd} //evUseVisibleCursors

implementation

{$If defined(evUseVisibleCursors)}
uses
  evOp
  ;
{$IfEnd} //evUseVisibleCursors

{$If defined(evUseVisibleCursors)}

// start class TevReqCellCursor

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

{$IfEnd} //evUseVisibleCursors

end.