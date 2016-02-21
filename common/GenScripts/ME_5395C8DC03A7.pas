unit CsReplyProceduresWithRegistering;

// Модуль: "w:\common\components\rtl\Garant\cs\CsReplyProceduresWithRegistering.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsReplyProceduresPrim
 , CsQueryTypes
 , CsProcWithId
;

type
 TCsReplyProceduresWithRegistering = {abstract} class(TCsReplyProceduresPrim)
  public
   procedure Register(aQueryId: TCsQueryId;
    aProc: TCsReplyProc);
   procedure UnregisterAll;
 end;//TCsReplyProceduresWithRegistering
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , l3Base
 , TypInfo
 , SysUtils
;

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
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
