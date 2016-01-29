unit FromWithPanelKeywordsPack;

interface

uses
 l3IntfUses
 , FromWithPanel_Form
 , vtPanel
 , tfwControlString
 , kwBynameControlPush
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_FromWithPanel = class(TtfwControlString)
  {* Слово словаря для идентификатора формы FromWithPanel
----
*Пример использования*:
[code]
'aControl' форма::FromWithPanel TryFocus ASSERT
[code] }
 end;//Tkw_Form_FromWithPanel
 
 Tkw_FromWithPanel_Control_WorkSpace = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WorkSpace
----
*Пример использования*:
[code]
контрол::WorkSpace TryFocus ASSERT
[code] }
 end;//Tkw_FromWithPanel_Control_WorkSpace
 
 Tkw_FromWithPanel_Control_WorkSpace_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола WorkSpace
----
*Пример использования*:
[code]
контрол::WorkSpace:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_FromWithPanel_Control_WorkSpace_Push
 
 TkwFromWithPanelFormWorkSpace = class(TtfwPropertyLike)
  {* Слово скрипта .TFromWithPanelForm.WorkSpace
[panel]Контрол WorkSpace формы TFromWithPanelForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aFromWithPanelForm .TFromWithPanelForm.WorkSpace >>> l_TvtPanel
[code]  }
  function WorkSpace(const aCtx: TtfwContext;
   aFromWithPanelForm: TFromWithPanelForm): TvtPanel;
   {* Реализация слова скрипта .TFromWithPanelForm.WorkSpace }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFromWithPanelFormWorkSpace
 
end.
