unit CsReplyTool;

// Модуль: "w:\common\components\rtl\Garant\cs\CsReplyTool.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsReplyTool" MUID: (538DEBEA032D)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsDataPipe
 , CsReplyProceduresPrim
 , CsCommon
 , CsQueryTypes
;

type
 TcsProcessQueryProc = function(aQueryId: TCsQueryId): Boolean of object;

 TCsReplyTool = class
  public
   class procedure ProcessQuery(aPipe: TCsDataPipe;
    aProcessQueryProc: TcsProcessQueryProc;
    aReplyProcedures: TCsReplyProceduresPrim;
    aLogMessages: Boolean;
    out theClientId: TCsClientId);
 end;//TCsReplyTool
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , TypInfo
 , CsErrors
 , CsConst
 , SysUtils
 , CsProcWithId
 //#UC START# *538DEBEA032Dimpl_uses*
 //#UC END# *538DEBEA032Dimpl_uses*
;

class procedure TCsReplyTool.ProcessQuery(aPipe: TCsDataPipe;
 aProcessQueryProc: TcsProcessQueryProc;
 aReplyProcedures: TCsReplyProceduresPrim;
 aLogMessages: Boolean;
 out theClientId: TCsClientId);
//#UC START# *538DEC9601CC_538DEBEA032D_var*
var
 l_CsVersion: Integer;
 l_QueryId: TCsQueryId;
 l_ReplyProc: TCsReplyProc;
//#UC END# *538DEC9601CC_538DEBEA032D_var*
begin
//#UC START# *538DEC9601CC_538DEBEA032D_impl*
 l_CsVersion := aPipe.ReadInteger;
 theClientId := TcsClientID(aPipe.ReadInteger);
 aPipe.ClientID := theClientId;
 l_QueryId := TcsQueryId(aPipe.ReadInteger);

 if aLogMessages and (l_QueryID <> qtKeepAlive) then
  l3System.Msg2Log('Обработка %s от %d', [GetEnumName(TypeInfo(TcsQueryID), ord(l_QueryID)), theClientId]);

 if l_QueryID <> qtGetProtocolVersion then
  ECsWrongVersionError.IfNot(l_CsVersion = c_CsVersion);

 if not aProcessQueryProc(l_QueryId) then
 begin
  l_ReplyProc := aReplyProcedures.ProcBy(l_QueryId);
  if Assigned(l_ReplyProc) then
  try
   l_ReplyProc(aPipe)
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end
  else
  if aLogMessages and (l_QueryID <> qtKeepAlive)  then
   l3System.Msg2Log('Не зарегистрирован обработчик для %s', [GetEnumName(TypeInfo(TcsQueryID), ord(l_QueryID))]);
 end;// not aProcessQueryProc(l_QueryId)
 if aLogMessages and (l_QueryID <> qtKeepAlive)  then
  l3System.Msg2Log('%s от %d обработан', [GetEnumName(TypeInfo(TcsQueryID), ord(l_QueryID)), theClientId]);
//#UC END# *538DEC9601CC_538DEBEA032D_impl*
end;//TCsReplyTool.ProcessQuery
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
