unit StatusBarButtonWords;

interface

uses
 l3IntfUses
 , nscStatusBarButton
 , tfwClassLike
 , tfwScriptingInterfaces
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
 TkwPopStatusBarButtonIsDown = class(TtfwClassLike)
  {* Слово скрипта pop:StatusBarButton:IsDown
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aStatusBarButton pop:StatusBarButton:IsDown >>> l_Boolean
[code]  }
  function IsDown(const aCtx: TtfwContext;
   aStatusBarButton: TnscStatusBarButton): Boolean;
   {* Реализация слова скрипта pop:StatusBarButton:IsDown }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopStatusBarButtonIsDown
 
end.
