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
  {* ����� ������� pop:ContainedAction:Execute
*������:*
[code]
 aContainedAction pop:ContainedAction:Execute
[code]  }
  procedure Execute(const aCtx: TtfwContext;
   aContainedAction: TContainedAction);
   {* ���������� ����� ������� pop:ContainedAction:Execute }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopContainedActionExecute
 
end.
