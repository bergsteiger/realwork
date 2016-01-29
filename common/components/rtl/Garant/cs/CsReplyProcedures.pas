unit CsReplyProcedures;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "cs"
// Модуль: "w:/common/components/rtl/Garant/cs/CsReplyProcedures.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> Shared Delphi For Archi::cs::ServerSide::TCsReplyProcedures
//
// Класс для регистрации "ответных процедур" сервера для запросов от клиента. Синглетон.
// Используется для "логики по-умолчанию". Т.е. когда сервер у нас в приложении ОДИН
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
  CsReplyProceduresWithRegistering
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}
type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента. Синглетон. Используется для "логики по-умолчанию". Т.е. когда сервер у нас в приложении ОДИН }
 public
 // public methods
   class function Exists: Boolean;
     {* Проверяет создан экземпляр синглетона или нет }
 public
 // singleton factory method
   class function Instance: TCsReplyProcedures;
    {- возвращает экземпляр синглетона. }
 end;//TCsReplyProcedures
{$IfEnd} //AppServerSide AND not Nemesis

implementation

{$If defined(AppServerSide) AND not defined(Nemesis)}
uses
  l3Base {a}
  ;
{$IfEnd} //AppServerSide AND not Nemesis

{$If defined(AppServerSide) AND not defined(Nemesis)}


// start class TCsReplyProcedures

var g_TCsReplyProcedures : TCsReplyProcedures = nil;

procedure TCsReplyProceduresFree;
begin
 l3Free(g_TCsReplyProcedures);
end;

class function TCsReplyProcedures.Instance: TCsReplyProcedures;
begin
 if (g_TCsReplyProcedures = nil) then
 begin
  l3System.AddExitProc(TCsReplyProceduresFree);
  g_TCsReplyProcedures := Create;
 end;
 Result := g_TCsReplyProcedures;
end;


class function TCsReplyProcedures.Exists: Boolean;
 {-}
begin
 Result := g_TCsReplyProcedures <> nil;
end;//TCsReplyProcedures.Exists

{$IfEnd} //AppServerSide AND not Nemesis

end.