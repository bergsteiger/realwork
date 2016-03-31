unit NOT_COMPLETED_evParaListCursorInsertable;

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_COMPLETED_evParaListCursorInsertable.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TevParaListCursorInsertable" MUID: (4A3A4398010A)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(evUseVisibleCursors)}
uses
 l3IntfUses
 , evParaListCursorPrim
 , nevTools
 , nevBase
 , l3Variant
;

type
 TevParaListCursorInsertable = class(TevParaListCursorPrim, IevOpInsertPara)
  protected
   function DoIt(const anOpPack: InevOp;
    aPara: Tl3Variant;
    aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean;
 end;//TevParaListCursorInsertable
{$IfEnd} // Defined(evUseVisibleCursors)

implementation

{$If Defined(evUseVisibleCursors)}
uses
 l3ImplUses
;

function TevParaListCursorInsertable.DoIt(const anOpPack: InevOp;
 aPara: Tl3Variant;
 aFlags: TevInsertParaFlags = [ev_ipfAtEnd]): Boolean;
//#UC START# *48E4FEB90365_4A3A4398010A_var*
var
 l_Flags : TevInsertParaFlags;
 l_PID   : Integer;
//#UC END# *48E4FEB90365_4A3A4398010A_var*
begin
//#UC START# *48E4FEB90365_4A3A4398010A_impl*
 l_PID := Position;
 l_Flags := aFlags + [ev_ipfNeedFire];
 if ev_ipfAtEnd in aFlags then
 begin
  Inc(l_PID);
  l_Flags := l_Flags - [ev_ipfAtEnd];
 end; // if ev_ipfAtEnd in aFlags then
 //CheckProcessor(anOp);
 Result := ParaX.Modify.InsertPara(Pred(l_PID), aPara, anOpPack, l_Flags);
//#UC END# *48E4FEB90365_4A3A4398010A_impl*
end;//TevParaListCursorInsertable.DoIt
{$IfEnd} // Defined(evUseVisibleCursors)

end.
