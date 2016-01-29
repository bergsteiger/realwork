unit F1LikeTextLoadKeywordsPack;

interface

uses
 l3IntfUses
 , F1LikeTextLoad_Form
 , eeEditorExport
 , eeTextSourceExport
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
 Tkw_Form_F1LikeTextLoad = class(TtfwControlString)
  {* Слово словаря для идентификатора формы F1LikeTextLoad
----
*Пример использования*:
[code]
'aControl' форма::F1LikeTextLoad TryFocus ASSERT
[code] }
 end;//Tkw_Form_F1LikeTextLoad
 
 Tkw_F1LikeTextLoad_Control_Text = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Control_Text
 
 Tkw_F1LikeTextLoad_Control_Text_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Control_Text_Push
 
 Tkw_F1LikeTextLoad_Component_TextSource = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Component_TextSource
 
 Tkw_F1LikeTextLoad_Component_LoadManager = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeTextLoad_Component_LoadManager
 
 TkwF1LikeTextLoadFormText = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.Text
[panel]Контрол Text формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeEditorExport
*Пример:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.Text >>> l_TeeEditorExport
[code]  }
  function Text(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeEditorExport;
   {* Реализация слова скрипта .TF1LikeTextLoadForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormText
 
 TkwF1LikeTextLoadFormTextSource = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.TextSource
[panel]Контрол TextSource формы TF1LikeTextLoadForm[panel]
*Тип результата:* TeeTextSourceExport
*Пример:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TeeTextSourceExport;
   {* Реализация слова скрипта .TF1LikeTextLoadForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormTextSource
 
 TkwF1LikeTextLoadFormLoadManager = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeTextLoadForm.LoadManager
[panel]Контрол LoadManager формы TF1LikeTextLoadForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeTextLoadForm .TF1LikeTextLoadForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aF1LikeTextLoadForm: TF1LikeTextLoadForm): TevLoadDocumentManager;
   {* Реализация слова скрипта .TF1LikeTextLoadForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeTextLoadFormLoadManager
 
end.
