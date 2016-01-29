unit OutlinerFormKeywordsPack;

interface

uses
 l3IntfUses
 , Outliner_Form
 , vtOutlinerControl
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
 Tkw_Form_OutlinerForm = class(TtfwControlString)
  {* Слово словаря для идентификатора формы OutlinerForm
----
*Пример использования*:
[code]
'aControl' форма::OutlinerForm TryFocus ASSERT
[code] }
 end;//Tkw_Form_OutlinerForm
 
 Tkw_OutlinerForm_Control_TreeControl = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TreeControl
----
*Пример использования*:
[code]
контрол::TreeControl TryFocus ASSERT
[code] }
 end;//Tkw_OutlinerForm_Control_TreeControl
 
 Tkw_OutlinerForm_Control_TreeControl_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола TreeControl
----
*Пример использования*:
[code]
контрол::TreeControl:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_OutlinerForm_Control_TreeControl_Push
 
 TkwOutlinerFormFormTreeControl = class(TtfwPropertyLike)
  {* Слово скрипта .TOutlinerFormForm.TreeControl
[panel]Контрол TreeControl формы TOutlinerFormForm[panel]
*Тип результата:* TvtOutlinerControl
*Пример:*
[code]
OBJECT VAR l_TvtOutlinerControl
 aOutlinerFormForm .TOutlinerFormForm.TreeControl >>> l_TvtOutlinerControl
[code]  }
  function TreeControl(const aCtx: TtfwContext;
   aOutlinerFormForm: TOutlinerFormForm): TvtOutlinerControl;
   {* Реализация слова скрипта .TOutlinerFormForm.TreeControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwOutlinerFormFormTreeControl
 
end.
