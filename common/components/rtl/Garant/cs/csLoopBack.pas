unit csLoopBack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/csLoopBack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::LoopBack::TcsLoopBack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\cs\CsDefine.inc}

interface

{$If not defined(Nemesis)}
uses
  CsCommon,
  CsDataPipe,
  CsQueryTypes
  {$If defined(AppServerSide) AND not defined(Nemesis)}
  ,
  CsReplyProceduresPrim
  {$IfEnd} //AppServerSide AND not Nemesis
  ,
  CsQueryRequester
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}
type
 TcsLoopBack = class
 private
 // private methods
   class function ProcessInternal(aQueryId: TCsQueryId): Boolean;
 public
 // public methods
   class procedure ExecuteQuery(aQueryId: TCsQueryId;
     aClientID: TCsClientId;
     aPipe: TCsDataPipe;
     aQueryProc: TCsQueryProc;
     aReplyProcedures: TCsReplyProceduresPrim);
 end;//TcsLoopBack
{$IfEnd} //not Nemesis

implementation

{$If not defined(Nemesis)}
uses
  CsQueryRequesterTool
  {$If defined(AppServerSide) AND not defined(Nemesis)}
  ,
  CsReplyTool
  {$IfEnd} //AppServerSide AND not Nemesis
  
  ;
{$IfEnd} //not Nemesis

{$If not defined(Nemesis)}

// start class TcsLoopBack

class function TcsLoopBack.ProcessInternal(aQueryId: TCsQueryId): Boolean;
//#UC START# *538DF4A80189_538DF3CC00C8_var*
//#UC END# *538DF4A80189_538DF3CC00C8_var*
begin
//#UC START# *538DF4A80189_538DF3CC00C8_impl*
 Result := false;
//#UC END# *538DF4A80189_538DF3CC00C8_impl*
end;//TcsLoopBack.ProcessInternal

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

{$IfEnd} //not Nemesis

end.