unit CsReplyTool;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsReplyTool.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReplyTool
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  CsCommon,
  CsDataPipe,
  CsQueryTypes,
  CsReplyProceduresPrim
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TcsProcessQueryProc = function (aQueryId: TCsQueryId): Boolean of object;

 TCsReplyTool = class
 public
 // public methods
   class procedure ProcessQuery(aPipe: TCsDataPipe;
     aProcessQueryProc: TcsProcessQueryProc;
     aReplyProcedures: TCsReplyProceduresPrim;
     aLogMessages: Boolean;
     out theClientId: TCsClientId);
 end;//TCsReplyTool
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  l3Base,
  TypInfo,
  CsErrors,
  CsConst,
  SysUtils,
  CsProcWithId
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}

// start class TCsReplyTool

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

{$IfEnd} //AppServerSide AND not Nemesis

end.