unit CsReplyProceduresPrim;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsReplyProceduresPrim.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReplyProceduresPrim
//
// Класс для регистрации "ответных процедур" сервера для запросов от клиента
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
  SysUtils,
  CsObject,
  CsProcWithId,
  CsQueryTypes,
  CsProcWithIdList
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReplyProceduresPrim = {abstract} class(TCsObject)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента }
 protected
 // overridden protected methods
   procedure Cleanup; override;
     {* Функция очистки полей объекта. }
 protected
 // protected fields
   f_List : TCsProcWithIdList;
   f_Synchronizer : TMultiReadExclusiveWriteSynchronizer;
 protected
 // protected methods
   function ListItemBy(aQueryId: TCsQueryId): TCsProcWithId;
 public
 // public methods
   constructor Create; reintroduce;
   function ProcBy(aQueryId: TCsQueryId): TCsReplyProc;
 end;//TCsReplyProceduresPrim
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  TypInfo,
  l3Base
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}

// start class TCsReplyProceduresPrim

constructor TCsReplyProceduresPrim.Create;
//#UC START# *53959A720000_537F645C01D1_var*
//#UC END# *53959A720000_537F645C01D1_var*
begin
//#UC START# *53959A720000_537F645C01D1_impl*
 inherited;
 f_List := TCsProcWithIdList.Create;
 f_Synchronizer := TMultiReadExclusiveWriteSynchronizer.Create;
//#UC END# *53959A720000_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.Create

function TCsReplyProceduresPrim.ListItemBy(aQueryId: TCsQueryId): TCsProcWithId;
//#UC START# *53959ABC03D4_537F645C01D1_var*
var
 I: Integer;
//#UC END# *53959ABC03D4_537F645C01D1_var*
begin
//#UC START# *53959ABC03D4_537F645C01D1_impl*
 Result := nil;
 for I := 0 to f_List.Count - 1 do
  if (f_List[I].QueryId = aQueryId) then
  begin
   Result := f_List[I];
   Break;
  end;//f_List[I].QueryId = aQueryId
//#UC END# *53959ABC03D4_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.ListItemBy

function TCsReplyProceduresPrim.ProcBy(aQueryId: TCsQueryId): TCsReplyProc;
//#UC START# *53959B1400E0_537F645C01D1_var*
var
 l_ProcWithId: TCsProcWithId;
//#UC END# *53959B1400E0_537F645C01D1_var*
begin
//#UC START# *53959B1400E0_537F645C01D1_impl*
 f_Synchronizer.BeginRead;
 try
  l_ProcWithId := ListItemBy(aQueryId);
  if l_ProcWithId <> nil then
   Result := l_ProcWithId.Proc
  else
   Result := nil;
 finally
  f_Synchronizer.EndRead;
 end;//try..finally
//#UC END# *53959B1400E0_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.ProcBy

procedure TCsReplyProceduresPrim.Cleanup;
//#UC START# *479731C50290_537F645C01D1_var*
//#UC END# *479731C50290_537F645C01D1_var*
begin
//#UC START# *479731C50290_537F645C01D1_impl*
 FreeAndNil(f_Synchronizer);
 FreeAndNil(f_List);
 inherited;
//#UC END# *479731C50290_537F645C01D1_impl*
end;//TCsReplyProceduresPrim.Cleanup

{$IfEnd} //AppServerSide AND not Nemesis

end.