unit csLoopBack;

// Модуль: "w:\common\components\rtl\Garant\cs\csLoopBack.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsQueryTypes
 , CsCommon
 , CsDataPipe
 , CsQueryRequester
 {$If Defined(AppServerSide)}
 , CsReplyProceduresPrim
 {$IfEnd} // Defined(AppServerSide)
;

type
 TcsLoopBack = class
  private
   class function ProcessInternal(aQueryId: TCsQueryId): Boolean;
  public
   class procedure ExecuteQuery(aQueryId: TCsQueryId;
    aClientID: TCsClientId;
    aPipe: TCsDataPipe;
    aQueryProc: TCsQueryProc;
    aReplyProcedures: TCsReplyProceduresPrim);
 end;//TcsLoopBack
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsQueryRequesterTool
 {$If Defined(AppServerSide)}
 , CsReplyTool
 {$IfEnd} // Defined(AppServerSide)
;

class procedure TcsLoopBack.ExecuteQuery(aQueryId: TCsQueryId;
 aClientID: TCsClientId;
 aPipe: TCsDataPipe;
 aQueryProc: TCsQueryProc;
 aReplyProcedures: TCsReplyProceduresPrim);
//#UC START# *538DF4250167_538DF3CC00C8_var*
var
 l_ClientId: TCsClientId;
//#UC END# *538DF4250167_538DF3CC00C8_var*
begin
//#UC START# *538DF4250167_538DF3CC00C8_impl*
 TCsQueryRequesterTool.ExecuteQuery(aQueryId, aClientID, aPipe, aQueryProc, false);
 TCsReplyTool.ProcessQuery(aPipe, ProcessInternal, aReplyProcedures, false, l_ClientId);
 Assert(aClientID = l_ClientId);
//#UC END# *538DF4250167_538DF3CC00C8_impl*
end;//TcsLoopBack.ExecuteQuery

class function TcsLoopBack.ProcessInternal(aQueryId: TCsQueryId): Boolean;
//#UC START# *538DF4A80189_538DF3CC00C8_var*
//#UC END# *538DF4A80189_538DF3CC00C8_var*
begin
//#UC START# *538DF4A80189_538DF3CC00C8_impl*
 Result := false;
//#UC END# *538DF4A80189_538DF3CC00C8_impl*
end;//TcsLoopBack.ProcessInternal
{$IfEnd} // NOT Defined(Nemesis)

end.
