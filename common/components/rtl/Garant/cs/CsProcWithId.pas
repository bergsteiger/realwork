unit CsProcWithId;

// Модуль: "w:\common\components\rtl\Garant\cs\CsProcWithId.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsProcWithId" MUID: (537F6306025B)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsObject
 , CsQueryTypes
 , CsDataPipe
;

type
 TCsReplyProc = procedure(aPipe: TCsDataPipe) of object;

 TCsProcWithId = class(TCsObject)
  public
   QueryId: TCsQueryId;
   Proc: TCsReplyProc;
  public
   constructor Create(aQueryId: TCsQueryId;
    aProc: TCsReplyProc); reintroduce;
 end;//TCsProcWithId
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 //#UC START# *537F6306025Bimpl_uses*
 //#UC END# *537F6306025Bimpl_uses*
;

constructor TCsProcWithId.Create(aQueryId: TCsQueryId;
 aProc: TCsReplyProc);
//#UC START# *537F63B40386_537F6306025B_var*
//#UC END# *537F63B40386_537F6306025B_var*
begin
//#UC START# *537F63B40386_537F6306025B_impl*
 inherited Create;
 QueryId := aQueryId;
 Proc := aProc;
//#UC END# *537F63B40386_537F6306025B_impl*
end;//TCsProcWithId.Create
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
