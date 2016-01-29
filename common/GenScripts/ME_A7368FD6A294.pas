unit ParentKeywordsPack;

interface

uses
 l3IntfUses
 , ParentAndChildPrim_Module
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
 Tkw_Form_Parent = class(TtfwControlString)
  {* Слово словаря для идентификатора формы Parent
----
*Пример использования*:
[code]
'aControl' форма::Parent TryFocus ASSERT
[code] }
 end;//Tkw_Form_Parent
 
 Tkw_Parent_Control_ParentZone = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
 end;//Tkw_Parent_Control_ParentZone
 
 Tkw_Parent_Control_ParentZone_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_Parent_Control_ParentZone_Push
 
 TkwParentFormParentZone = class(TtfwPropertyLike)
  {* Слово скрипта .TParentForm.ParentZone
[panel]Контрол ParentZone формы TParentForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aParentForm .TParentForm.ParentZone >>> l_TvtPanel
[code]  }
  function ParentZone(const aCtx: TtfwContext;
   aParentForm: TParentForm): TvtPanel;
   {* Реализация слова скрипта .TParentForm.ParentZone }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwParentFormParentZone
 
end.
