unit CsReplyProceduresPrim;

interface

uses
 l3IntfUses
 , CsObject
 , CsProcWithIdList
 , SysUtils
 , CsProcWithId
 , CsQueryTypes
;

type
 TCsReplyProceduresPrim = class(TCsObject)
  {* Класс для регистрации "ответных процедур" сервера для запросов от клиента }
  procedure Create;
  function ListItemBy(aQueryId: TCsQueryId): TCsProcWithId;
  function ProcBy(aQueryId: TCsQueryId): TCsReplyProc;
 end;//TCsReplyProceduresPrim
 
implementation

uses
 l3ImplUses
 , TypInfo
 , l3Base
;

end.
