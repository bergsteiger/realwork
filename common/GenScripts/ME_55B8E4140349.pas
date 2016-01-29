unit ContainedActionsWordspack;

interface

uses
 l3IntfUses
 , ActnList
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
 TkwPopContainedActionExecute = class(TtfwClassLike)
  {* Слово скрипта pop:ContainedAction:Execute
*Пример:*
[code]
 aContainedAction pop:ContainedAction:Execute
[code]  }
  procedure Execute(const aCtx: TtfwContext;
   aContainedAction: TContainedAction);
   {* Реализация слова скрипта pop:ContainedAction:Execute }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopContainedActionExecute
 
end.
