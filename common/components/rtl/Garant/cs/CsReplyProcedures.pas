unit CsReplyProcedures;
 {* Класс для регистрации "ответных процедур" сервера для запросов от клиента. Синглетон. Используется для "логики по-умолчанию". Т.е. когда сервер у нас в приложении ОДИН }

// Модуль: "w:\common\components\rtl\Garant\cs\CsReplyProcedures.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TCsReplyProcedures" MUID: (5395B29D0177)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3IntfUses
 , CsReplyProceduresWithRegistering
;

type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента. Синглетон. Используется для "логики по-умолчанию". Т.е. когда сервер у нас в приложении ОДИН }
  public
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
   class function Instance: TCsReplyProcedures;
    {* Метод получения экземпляра синглетона TCsReplyProcedures }
 end;//TCsReplyProcedures
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

implementation

{$If Defined(AppServerSide) AND NOT Defined(Nemesis)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
;

var g_TCsReplyProcedures: TCsReplyProcedures = nil;
 {* Экземпляр синглетона TCsReplyProcedures }

procedure TCsReplyProceduresFree;
 {* Метод освобождения экземпляра синглетона TCsReplyProcedures }
begin
 l3Free(g_TCsReplyProcedures);
end;//TCsReplyProceduresFree

class function TCsReplyProcedures.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TCsReplyProcedures <> nil;
end;//TCsReplyProcedures.Exists

class function TCsReplyProcedures.Instance: TCsReplyProcedures;
 {* Метод получения экземпляра синглетона TCsReplyProcedures }
begin
 if (g_TCsReplyProcedures = nil) then
 begin
  l3System.AddExitProc(TCsReplyProceduresFree);
  g_TCsReplyProcedures := Create;
 end;
 Result := g_TCsReplyProcedures;
end;//TCsReplyProcedures.Instance
{$IfEnd} // Defined(AppServerSide) AND NOT Defined(Nemesis)

end.
