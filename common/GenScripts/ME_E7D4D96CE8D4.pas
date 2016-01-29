unit QFLikeTextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , QFLikeTextLoad_Form
 , evTextSource
 , evQueryCardEditor
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
 Tkw_Form_QFLikeTextLoad = class(TtfwControlString)
  {* Слово словаря для идентификатора формы QFLikeTextLoad
----
*Пример использования*:
[code]
'aControl' форма::QFLikeTextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_QFLikeTextLoad
 
 Tkw_QFLikeTextLoad_Component_TextSource = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Component_TextSource
 
 Tkw_QFLikeTextLoad_Control_Text = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Control_Text
 
 Tkw_QFLikeTextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Control_Text_Push
 
 Tkw_QFLikeTextLoad_Component_LoadManager = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_QFLikeTextLoad_Component_LoadManager
 
 TkwQFLikeTextLoadFormTextSource = class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.TextSource
[panel]Контрол TextSource формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevTextSource
*Пример:*
[code]
OBJECT VAR l_TevTextSource
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.TextSource >>> l_TevTextSource
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevTextSource;
   {* Реализация слова скрипта .TQFLikeTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormTextSource
 
 TkwQFLikeTextLoadFormText = class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.Text
[panel]Контрол Text формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevQueryCardEditor
*Пример:*
[code]
OBJECT VAR l_TevQueryCardEditor
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.Text >>> l_TevQueryCardEditor
[code]  }
  function Text(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevQueryCardEditor;
   {* Реализация слова скрипта .TQFLikeTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormText
 
 TkwQFLikeTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* Слово скрипта .TQFLikeTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TQFLikeTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aQFLikeTextLoadForm .TQFLikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aQFLikeTextLoadForm: TQFLikeTextLoadForm): TevLoadDocumentManager;
   {* Реализация слова скрипта .TQFLikeTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwQFLikeTextLoadFormLoadManager
 
end.
