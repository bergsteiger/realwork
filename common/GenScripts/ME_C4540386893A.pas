unit TextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , TextLoad_Form
 , evEditor
 , evTextSource
 , evLoadDocumentManager
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
 Tkw_Form_TextLoad = class(TtfwControlString)
  {* Слово словаря для идентификатора формы TextLoad
----
*Пример использования*:
[code]
'aControl' форма::TextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_TextLoad
 
 Tkw_TextLoad_Control_Text = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Control_Text
 
 Tkw_TextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Control_Text_Push
 
 Tkw_TextLoad_Component_TextSource = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Component_TextSource
 
 Tkw_TextLoad_Component_LoadManager = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_TextLoad_Component_LoadManager
 
 TkwTextLoadFormText = class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.Text
[panel]Контрол Text формы TTextLoadForm[panel]
*Тип результата:* TevEditor
*Пример:*
[code]
OBJECT VAR l_TevEditor
 aTextLoadForm .TTextLoadForm.Text >>> l_TevEditor
[code]  }
  function Text(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevEditor;
   {* Реализация слова скрипта .TTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormText
 
 TkwTextLoadFormTextSource = class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.TextSource
[panel]Контрол TextSource формы TTextLoadForm[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aTextLoadForm .TTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevTextSource;
   {* Реализация слова скрипта .TTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormTextSource
 
 TkwTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* Слово скрипта .TTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aTextLoadForm .TTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aTextLoadForm: TTextLoadForm): TevLoadDocumentManager;
   {* Реализация слова скрипта .TTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwTextLoadFormLoadManager
 
end.
