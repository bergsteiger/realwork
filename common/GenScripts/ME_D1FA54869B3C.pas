unit ChildKeywordsPack;

interface

uses
 l3IntfUses
 , ParentAndChildPrim_Module
 , nscFormsPageControl
 , ElPgCtl
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
 Tkw_Form_Child = class(TtfwControlString)
  {* Слово словаря для идентификатора формы Child
----
*Пример использования*:
[code]
'aControl' форма::Child TryFocus ASSERT
[code] }
 end;//Tkw_Form_Child
 
 Tkw_Child_Control_ChildZone = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
 end;//Tkw_Child_Control_ChildZone
 
 Tkw_Child_Control_ChildZone_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Child_Control_ChildZone_Push
 
 Tkw_Child_Control_MainPageTab = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainPageTab
----
*Пример использования*:
[code]
контрол::MainPageTab TryFocus ASSERT
[code] }
 end;//Tkw_Child_Control_MainPageTab
 
 Tkw_Child_Control_MainPageTab_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола MainPageTab
----
*Пример использования*:
[code]
контрол::MainPageTab:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Child_Control_MainPageTab_Push
 
 TkwChildFormChildZone = class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.ChildZone
[panel]Контрол ChildZone формы TChildForm[panel]
*Тип результата:* TnscFormsPageControl
*Пример:*
[code]
OBJECT VAR l_TnscFormsPageControl
 aChildForm .TChildForm.ChildZone >>> l_TnscFormsPageControl
[code]  }
  function ChildZone(const aCtx: TtfwContext;
   aChildForm: TChildForm): TnscFormsPageControl;
   {* Реализация слова скрипта .TChildForm.ChildZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwChildFormChildZone
 
 TkwChildFormMainPageTab = class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.MainPageTab
[panel]Контрол MainPageTab формы TChildForm[panel]
*Тип результата:* TElTabSheet
*Пример:*
[code]
OBJECT VAR l_TElTabSheet
 aChildForm .TChildForm.MainPageTab >>> l_TElTabSheet
[code]  }
  function MainPageTab(const aCtx: TtfwContext;
   aChildForm: TChildForm): TElTabSheet;
   {* Реализация слова скрипта .TChildForm.MainPageTab }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwChildFormMainPageTab
 
end.
