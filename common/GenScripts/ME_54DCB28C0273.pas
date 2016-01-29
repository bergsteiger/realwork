unit VCMFormsProcessingPack;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopFormIsFloatingStateAndParentNotVisible = class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingStateAndParentNotVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingStateAndParentNotVisible >>> l_Boolean
[code]  }
  function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Boolean;
   {* Реализация слова скрипта pop:Form:IsFloatingStateAndParentNotVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormIsFloatingStateAndParentNotVisible
 
 TkwPopFormIsFloatingState = class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:IsFloatingState
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingState >>> l_Boolean
[code]  }
  function IsFloatingState(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Boolean;
   {* Реализация слова скрипта pop:Form:IsFloatingState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormIsFloatingState
 
 TkwPopFormUserType = class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:UserType
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:Form:UserType >>> l_Integer
[code]  }
  function UserType(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Integer;
   {* Реализация слова скрипта pop:Form:UserType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormUserType
 
 TkwPopFormFormID = class(TtfwPropertyLike)
  {* Слово скрипта pop:Form:FormID
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aForm pop:Form:FormID >>> l_String
[code]  }
  function FormID(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): AnsiString;
   {* Реализация слова скрипта pop:Form:FormID }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFormID
 
end.
