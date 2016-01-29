unit vtHintWordsPack;

interface

uses
 l3IntfUses
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , vtHintManager
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwApplicationCancelHint = class(TtfwGlobalKeyWord)
  {* Слово скрипта application:CancelHint
*Пример:*
[code]
 application:CancelHint
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationCancelHint
 
 TkwApplicationIsHintVisible = class(TtfwGlobalKeyWord)
  {* Слово скрипта application:IsHintVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 application:IsHintVisible >>> l_Boolean
[code]  }
  function application_IsHintVisible(const aCtx: TtfwContext): Boolean;
   {* Реализация слова скрипта application:IsHintVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationIsHintVisible
 
 TkwApplicationGetLastHint = class(TtfwGlobalKeyWord)
  {* Слово скрипта application:GetLastHint
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 application:GetLastHint >>> l_Il3CString
[code]  }
  function application_GetLastHint(const aCtx: TtfwContext): Il3CString;
   {* Реализация слова скрипта application:GetLastHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationGetLastHint
 
end.
