unit F1LikeFormWithBSKeywordsPack;

interface

uses
 l3IntfUses
 , F1LikeFormWithBS_Form
 , nscTreeComboWithHistoryAndOperations
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
 Tkw_Form_F1LikeFormWithBS = class(TtfwControlString)
  {* Слово словаря для идентификатора формы F1LikeFormWithBS
----
*Пример использования*:
[code]
'aControl' форма::F1LikeFormWithBS TryFocus ASSERT
[code] }
 end;//Tkw_Form_F1LikeFormWithBS
 
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BaseSearchControl
----
*Пример использования*:
[code]
контрол::BaseSearchControl TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl
 
 Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола BaseSearchControl
----
*Пример использования*:
[code]
контрол::BaseSearchControl:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_BaseSearchControl_Push
 
 Tkw_F1LikeFormWithBS_Control_Text = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Text
----
*Пример использования*:
[code]
контрол::Text TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_Text
 
 Tkw_F1LikeFormWithBS_Control_Text_Push = class(TkwBynameControlPush)
  {* Слово словаря для контрола Text
----
*Пример использования*:
[code]
контрол::Text:push pop:control:SetFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Control_Text_Push
 
 Tkw_F1LikeFormWithBS_Component_TextSource = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TextSource
----
*Пример использования*:
[code]
компонент::TextSource TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Component_TextSource
 
 Tkw_F1LikeFormWithBS_Component_LoadManager = class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LoadManager
----
*Пример использования*:
[code]
компонент::LoadManager TryFocus ASSERT
[code] }
 end;//Tkw_F1LikeFormWithBS_Component_LoadManager
 
 TkwF1LikeFormWithBSFormBaseSearchControl = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.BaseSearchControl
[panel]Контрол BaseSearchControl формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TnscTreeComboWithHistoryAndOperations
*Пример:*
[code]
OBJECT VAR l_TnscTreeComboWithHistoryAndOperations
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.BaseSearchControl >>> l_TnscTreeComboWithHistoryAndOperations
[code]  }
  function BaseSearchControl(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TnscTreeComboWithHistoryAndOperations;
   {* Реализация слова скрипта .TF1LikeFormWithBSForm.BaseSearchControl }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormBaseSearchControl
 
 TkwF1LikeFormWithBSFormText = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.Text
[panel]Контрол Text формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TeeEditorExport
*Пример:*
[code]
OBJECT VAR l_TeeEditorExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.Text >>> l_TeeEditorExport
[code]  }
  function Text(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeEditorExport;
   {* Реализация слова скрипта .TF1LikeFormWithBSForm.Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormText
 
 TkwF1LikeFormWithBSFormTextSource = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.TextSource
[panel]Контрол TextSource формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TeeTextSourceExport
*Пример:*
[code]
OBJECT VAR l_TeeTextSourceExport
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.TextSource >>> l_TeeTextSourceExport
[code]  }
  function TextSource(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TeeTextSourceExport;
   {* Реализация слова скрипта .TF1LikeFormWithBSForm.TextSource }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormTextSource
 
 TkwF1LikeFormWithBSFormLoadManager = class(TtfwPropertyLike)
  {* Слово скрипта .TF1LikeFormWithBSForm.LoadManager
[panel]Контрол LoadManager формы TF1LikeFormWithBSForm[panel]
*Тип результата:* TevLoadDocumentManager
*Пример:*
[code]
OBJECT VAR l_TevLoadDocumentManager
 aF1LikeFormWithBSForm .TF1LikeFormWithBSForm.LoadManager >>> l_TevLoadDocumentManager
[code]  }
  function LoadManager(const aCtx: TtfwContext;
   aF1LikeFormWithBSForm: TF1LikeFormWithBSForm): TevLoadDocumentManager;
   {* Реализация слова скрипта .TF1LikeFormWithBSForm.LoadManager }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwF1LikeFormWithBSFormLoadManager
 
end.
