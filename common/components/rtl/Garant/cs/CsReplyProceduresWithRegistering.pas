unit CsReplyProceduresWithRegistering;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsReplyProceduresWithRegistering.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReplyProceduresWithRegistering
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
  CsProcWithId,
  CsQueryTypes,
  CsReplyProceduresPrim
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReplyProceduresWithRegistering = {abstract} class(TCsReplyProceduresPrim)
 public
 // public methods
   procedure Register(aQueryId: TCsQueryId;
     aProc: TCsReplyProc);
   procedure UnregisterAll;
 end;//TCsReplyProceduresWithRegistering
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  l3Base,
  TypInfo,
  SysUtils
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}

// start class TCsReplyProceduresWithRegistering

procedure TCsReplyProceduresWithRegistering.Register(aQueryId: TCsQueryId;
  aProc: TCsReplyProc);
//#UC START# *53959AE3018D_5395C8DC03A7_var*
var
 l_ProcWithId: TCsProcWithId;
//#UC END# *53959AE3018D_5395C8DC03A7_var*
begin
//#UC START# *53959AE3018D_5395C8DC03A7_impl*
 Assert(Assigned(aProc));
 f_Synchronizer.BeginWrite;
 try
  l_ProcWithId := ListItemBy(aQueryId);
  if l_ProcWithId <> nil then
  begin
   l_ProcWithId.Proc := aProc;
   l3System.Msg2Log('Переопределение обработчика для %s', [GetEnumName(TypeInfo(TcsQueryID), ord(aQueryID))]);
  end//l_ProcWithId <> nil
  else
  begin
   l_ProcWithId := TCsProcWithId.Create(aQueryId, aProc);
   try
    f_List.Add(l_ProcWithId);
   finally
    FreeAndNil(l_ProcWithId);
   end;//try.f.inally
  end;//l_ProcWithId <> nil
 finally
  f_Synchronizer.EndWrite;
 end;//try..finally
//#UC END# *53959AE3018D_5395C8DC03A7_impl*
end;//TCsReplyProceduresWithRegistering.Register

procedure TCsReplyProceduresWithRegistering.UnregisterAll;
//#UC START# *53BFBB81029F_5395C8DC03A7_var*
//#UC END# *53BFBB81029F_5395C8DC03A7_var*
begin
//#UC START# *53BFBB81029F_5395C8DC03A7_impl*
 f_Synchronizer.BeginWrite;
 try
  f_List.Clear;
 finally
  f_Synchronizer.EndWrite;
 end;//try..finally
//#UC END# *53BFBB81029F_5395C8DC03A7_impl*
end;//TCsReplyProceduresWithRegistering.UnregisterAll

{$IfEnd} //AppServerSide AND not Nemesis

end.