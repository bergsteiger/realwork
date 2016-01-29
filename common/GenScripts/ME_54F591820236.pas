unit tb97WordsPack;

interface

uses
 l3IntfUses
 , tb97Ctls
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
 TkwPopTB97ButtonDown = class(TtfwPropertyLike)
  {* Слово скрипта pop:TB97Button:Down
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTB97Button pop:TB97Button:Down >>> l_Boolean
[code]  }
  function Down(const aCtx: TtfwContext;
   aTB97Button: TCustomToolbarButton97): Boolean;
   {* Реализация слова скрипта pop:TB97Button:Down }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopTB97ButtonDown
 
end.
