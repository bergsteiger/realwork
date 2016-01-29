unit CsReplyProcedures;

interface

uses
 l3IntfUses
 , CsReplyProceduresWithRegistering
;

type
 TCsReplyProcedures = class(TCsReplyProceduresWithRegistering)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента. Синглетон. Используется для "логики по-умолчанию". Т.е. когда сервер у нас в приложении ОДИН }
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TCsReplyProcedures
 
implementation

uses
 l3ImplUses
;

end.
