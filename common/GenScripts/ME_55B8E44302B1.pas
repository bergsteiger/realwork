unit ActionListWordsPack;

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
 , ContainedActionsWordspack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopActionListFindAction = class(TtfwClassLike)
  {* Слово скрипта pop:ActionList:FindAction
*Тип результата:* TContainedAction
*Пример:*
[code]
OBJECT VAR l_TContainedAction
 anActionName aActionList pop:ActionList:FindAction >>> l_TContainedAction
[code]  }
  function FindAction(const aCtx: TtfwContext;
   aActionList: TActionList;
   const anActionName: AnsiString): TContainedAction;
   {* Реализация слова скрипта pop:ActionList:FindAction }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopActionListFindAction
 
end.
