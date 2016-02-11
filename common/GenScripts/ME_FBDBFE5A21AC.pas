unit NewBaseSearchKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы NewBaseSearch }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\NewBaseSearchKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseSearch_Module
 {$If NOT Defined(NoVGScene)}
 , vg_controls
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_listbox
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_objects
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_layouts
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If NOT Defined(NoVGScene)}
 , vg_scene
 {$IfEnd} // NOT Defined(NoVGScene)
 {$If Defined(Nemesis)}
 , nscTreeComboWithHistoryAndOperations
 {$IfEnd} // Defined(Nemesis)
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_NewBaseSearch = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы NewBaseSearch
----
*Пример использования*:
[code]
'aControl' форма::NewBaseSearch TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Form_NewBaseSearch

 Tkw_NewBaseSearch_Control_FindBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FindBtn
----
*Пример использования*:
[code]
контрол::FindBtn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_FindBtn

 Tkw_NewBaseSearch_Control_FindBtn_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FindBtn
----
*Пример использования*:
[code]
контрол::FindBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBtn_Push

 Tkw_NewBaseSearch_Control_FindBackBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FindBackBtn
----
*Пример использования*:
[code]
контрол::FindBackBtn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_FindBackBtn

 Tkw_NewBaseSearch_Control_FindBackBtn_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FindBackBtn
----
*Пример использования*:
[code]
контрол::FindBackBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push

 Tkw_NewBaseSearch_Control_CloseBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CloseBtn
----
*Пример использования*:
[code]
контрол::CloseBtn TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_CloseBtn

 Tkw_NewBaseSearch_Control_CloseBtn_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CloseBtn
----
*Пример использования*:
[code]
контрол::CloseBtn:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_CloseBtn_Push

 Tkw_NewBaseSearch_Control_AreaCombo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола AreaCombo
----
*Пример использования*:
[code]
контрол::AreaCombo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_AreaCombo

 Tkw_NewBaseSearch_Control_AreaCombo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола AreaCombo
----
*Пример использования*:
[code]
контрол::AreaCombo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_AreaCombo_Push

 Tkw_NewBaseSearch_Control_QueryExampleLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола QueryExampleLabel
----
*Пример использования*:
[code]
контрол::QueryExampleLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_QueryExampleLabel

 Tkw_NewBaseSearch_Control_QueryExampleLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола QueryExampleLabel
----
*Пример использования*:
[code]
контрол::QueryExampleLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push

 Tkw_NewBaseSearch_Control_DropButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DropButton
----
*Пример использования*:
[code]
контрол::DropButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_DropButton

 Tkw_NewBaseSearch_Control_DropButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола DropButton
----
*Пример использования*:
[code]
контрол::DropButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_DropButton_Push

 Tkw_NewBaseSearch_Control_FoundCountLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FoundCountLabel
----
*Пример использования*:
[code]
контрол::FoundCountLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_FoundCountLabel

 Tkw_NewBaseSearch_Control_FoundCountLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FoundCountLabel
----
*Пример использования*:
[code]
контрол::FoundCountLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push

 Tkw_NewBaseSearch_Control_ExampleLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ExampleLabel
----
*Пример использования*:
[code]
контрол::ExampleLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_ExampleLabel

 Tkw_NewBaseSearch_Control_ExampleLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ExampleLabel
----
*Пример использования*:
[code]
контрол::ExampleLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push

 Tkw_NewBaseSearch_Control_ContextEditPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextEditPanel
----
*Пример использования*:
[code]
контрол::ContextEditPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_ContextEditPanel

 Tkw_NewBaseSearch_Control_ContextEditPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextEditPanel
----
*Пример использования*:
[code]
контрол::ContextEditPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push

 Tkw_NewBaseSearch_Control_Layout1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Layout1
----
*Пример использования*:
[code]
контрол::Layout1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_Layout1

 Tkw_NewBaseSearch_Control_Layout1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Layout1
----
*Пример использования*:
[code]
контрол::Layout1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout1_Push

 Tkw_NewBaseSearch_Control_Layout2 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Layout2
----
*Пример использования*:
[code]
контрол::Layout2 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_Layout2

 Tkw_NewBaseSearch_Control_Layout2_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Layout2
----
*Пример использования*:
[code]
контрол::Layout2:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout2_Push

 Tkw_NewBaseSearch_Control_Layout3 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Layout3
----
*Пример использования*:
[code]
контрол::Layout3 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_Layout3

 Tkw_NewBaseSearch_Control_Layout3_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Layout3
----
*Пример использования*:
[code]
контрол::Layout3:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout3_Push

 Tkw_NewBaseSearch_Control_vgScene1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vgScene1
----
*Пример использования*:
[code]
контрол::vgScene1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_vgScene1

 Tkw_NewBaseSearch_Control_vgScene1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола vgScene1
----
*Пример использования*:
[code]
контрол::vgScene1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_vgScene1_Push

 Tkw_NewBaseSearch_Control_MoreTab = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MoreTab
----
*Пример использования*:
[code]
контрол::MoreTab TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_MoreTab

 Tkw_NewBaseSearch_Control_MoreTab_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MoreTab
----
*Пример использования*:
[code]
контрол::MoreTab:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MoreTab_Push

 Tkw_NewBaseSearch_Control_Border = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Border
----
*Пример использования*:
[code]
контрол::Border TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_Border

 Tkw_NewBaseSearch_Control_Border_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Border
----
*Пример использования*:
[code]
контрол::Border:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Border_Push

 Tkw_NewBaseSearch_Control_InnerBorder = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола InnerBorder
----
*Пример использования*:
[code]
контрол::InnerBorder TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_InnerBorder

 Tkw_NewBaseSearch_Control_InnerBorder_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола InnerBorder
----
*Пример использования*:
[code]
контрол::InnerBorder:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_InnerBorder_Push

 Tkw_NewBaseSearch_Control_MostOuterRectangle = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MostOuterRectangle
----
*Пример использования*:
[code]
контрол::MostOuterRectangle TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_MostOuterRectangle

 Tkw_NewBaseSearch_Control_MostOuterRectangle_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MostOuterRectangle
----
*Пример использования*:
[code]
контрол::MostOuterRectangle:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push

 Tkw_NewBaseSearch_Control_Rectangle1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Rectangle1
----
*Пример использования*:
[code]
контрол::Rectangle1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_Rectangle1

 Tkw_NewBaseSearch_Control_Rectangle1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Rectangle1
----
*Пример использования*:
[code]
контрол::Rectangle1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Rectangle1_Push

 Tkw_NewBaseSearch_Control_ContextEdit = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextEdit
----
*Пример использования*:
[code]
контрол::ContextEdit TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Control_ContextEdit

 Tkw_NewBaseSearch_Control_ContextEdit_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextEdit
----
*Пример использования*:
[code]
контрол::ContextEdit:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEdit_Push

 Tkw_NewBaseSearch_Component_FlashTimer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FlashTimer
----
*Пример использования*:
[code]
компонент::FlashTimer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewBaseSearch_Component_FlashTimer

 TkwNewBaseSearchFormFindBtn = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.FindBtn
[panel]Контрол FindBtn формы TNewBaseSearchForm[panel]
*Тип результата:* TvgPathButton
*Пример:*
[code]
OBJECT VAR l_TvgPathButton
 aNewBaseSearchForm .TNewBaseSearchForm.FindBtn >>> l_TvgPathButton
[code]  }
  private
   function FindBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
    {* Реализация слова скрипта .TNewBaseSearchForm.FindBtn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormFindBtn

 TkwNewBaseSearchFormFindBackBtn = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.FindBackBtn
[panel]Контрол FindBackBtn формы TNewBaseSearchForm[panel]
*Тип результата:* TvgPathButton
*Пример:*
[code]
OBJECT VAR l_TvgPathButton
 aNewBaseSearchForm .TNewBaseSearchForm.FindBackBtn >>> l_TvgPathButton
[code]  }
  private
   function FindBackBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
    {* Реализация слова скрипта .TNewBaseSearchForm.FindBackBtn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormFindBackBtn

 TkwNewBaseSearchFormCloseBtn = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.CloseBtn
[panel]Контрол CloseBtn формы TNewBaseSearchForm[panel]
*Тип результата:* TvgCloseButton
*Пример:*
[code]
OBJECT VAR l_TvgCloseButton
 aNewBaseSearchForm .TNewBaseSearchForm.CloseBtn >>> l_TvgCloseButton
[code]  }
  private
   function CloseBtn(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgCloseButton;
    {* Реализация слова скрипта .TNewBaseSearchForm.CloseBtn }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormCloseBtn

 TkwNewBaseSearchFormAreaCombo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.AreaCombo
[panel]Контрол AreaCombo формы TNewBaseSearchForm[panel]
*Тип результата:* TvgComboBox
*Пример:*
[code]
OBJECT VAR l_TvgComboBox
 aNewBaseSearchForm .TNewBaseSearchForm.AreaCombo >>> l_TvgComboBox
[code]  }
  private
   function AreaCombo(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
    {* Реализация слова скрипта .TNewBaseSearchForm.AreaCombo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormAreaCombo

 TkwNewBaseSearchFormQueryExampleLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.QueryExampleLabel
[panel]Контрол QueryExampleLabel формы TNewBaseSearchForm[panel]
*Тип результата:* TvgText
*Пример:*
[code]
OBJECT VAR l_TvgText
 aNewBaseSearchForm .TNewBaseSearchForm.QueryExampleLabel >>> l_TvgText
[code]  }
  private
   function QueryExampleLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* Реализация слова скрипта .TNewBaseSearchForm.QueryExampleLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormQueryExampleLabel

 TkwNewBaseSearchFormDropButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.DropButton
[panel]Контрол DropButton формы TNewBaseSearchForm[panel]
*Тип результата:* TvgButton
*Пример:*
[code]
OBJECT VAR l_TvgButton
 aNewBaseSearchForm .TNewBaseSearchForm.DropButton >>> l_TvgButton
[code]  }
  private
   function DropButton(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgButton;
    {* Реализация слова скрипта .TNewBaseSearchForm.DropButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormDropButton

 TkwNewBaseSearchFormFoundCountLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.FoundCountLabel
[panel]Контрол FoundCountLabel формы TNewBaseSearchForm[panel]
*Тип результата:* TvgText
*Пример:*
[code]
OBJECT VAR l_TvgText
 aNewBaseSearchForm .TNewBaseSearchForm.FoundCountLabel >>> l_TvgText
[code]  }
  private
   function FoundCountLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* Реализация слова скрипта .TNewBaseSearchForm.FoundCountLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormFoundCountLabel

 TkwNewBaseSearchFormExampleLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.ExampleLabel
[panel]Контрол ExampleLabel формы TNewBaseSearchForm[panel]
*Тип результата:* TvgText
*Пример:*
[code]
OBJECT VAR l_TvgText
 aNewBaseSearchForm .TNewBaseSearchForm.ExampleLabel >>> l_TvgText
[code]  }
  private
   function ExampleLabel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
    {* Реализация слова скрипта .TNewBaseSearchForm.ExampleLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormExampleLabel

 TkwNewBaseSearchFormContextEditPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.ContextEditPanel
[panel]Контрол ContextEditPanel формы TNewBaseSearchForm[panel]
*Тип результата:* TvgNonVGLayout
*Пример:*
[code]
OBJECT VAR l_TvgNonVGLayout
 aNewBaseSearchForm .TNewBaseSearchForm.ContextEditPanel >>> l_TvgNonVGLayout
[code]  }
  private
   function ContextEditPanel(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgNonVGLayout;
    {* Реализация слова скрипта .TNewBaseSearchForm.ContextEditPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormContextEditPanel

 TkwNewBaseSearchFormLayout1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.Layout1
[panel]Контрол Layout1 формы TNewBaseSearchForm[panel]
*Тип результата:* TvgLayout
*Пример:*
[code]
OBJECT VAR l_TvgLayout
 aNewBaseSearchForm .TNewBaseSearchForm.Layout1 >>> l_TvgLayout
[code]  }
  private
   function Layout1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* Реализация слова скрипта .TNewBaseSearchForm.Layout1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormLayout1

 TkwNewBaseSearchFormLayout2 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.Layout2
[panel]Контрол Layout2 формы TNewBaseSearchForm[panel]
*Тип результата:* TvgLayout
*Пример:*
[code]
OBJECT VAR l_TvgLayout
 aNewBaseSearchForm .TNewBaseSearchForm.Layout2 >>> l_TvgLayout
[code]  }
  private
   function Layout2(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* Реализация слова скрипта .TNewBaseSearchForm.Layout2 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormLayout2

 TkwNewBaseSearchFormLayout3 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.Layout3
[panel]Контрол Layout3 формы TNewBaseSearchForm[panel]
*Тип результата:* TvgLayout
*Пример:*
[code]
OBJECT VAR l_TvgLayout
 aNewBaseSearchForm .TNewBaseSearchForm.Layout3 >>> l_TvgLayout
[code]  }
  private
   function Layout3(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
    {* Реализация слова скрипта .TNewBaseSearchForm.Layout3 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormLayout3

 TkwNewBaseSearchFormVgScene1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.vgScene1
[panel]Контрол vgScene1 формы TNewBaseSearchForm[panel]
*Тип результата:* TvgScene
*Пример:*
[code]
OBJECT VAR l_TvgScene
 aNewBaseSearchForm .TNewBaseSearchForm.vgScene1 >>> l_TvgScene
[code]  }
  private
   function vgScene1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgScene;
    {* Реализация слова скрипта .TNewBaseSearchForm.vgScene1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormVgScene1

 TkwNewBaseSearchFormMoreTab = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.MoreTab
[panel]Контрол MoreTab формы TNewBaseSearchForm[panel]
*Тип результата:* TvgComboBox
*Пример:*
[code]
OBJECT VAR l_TvgComboBox
 aNewBaseSearchForm .TNewBaseSearchForm.MoreTab >>> l_TvgComboBox
[code]  }
  private
   function MoreTab(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
    {* Реализация слова скрипта .TNewBaseSearchForm.MoreTab }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormMoreTab

 TkwNewBaseSearchFormBorder = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.Border
[panel]Контрол Border формы TNewBaseSearchForm[panel]
*Тип результата:* TvgRectangle
*Пример:*
[code]
OBJECT VAR l_TvgRectangle
 aNewBaseSearchForm .TNewBaseSearchForm.Border >>> l_TvgRectangle
[code]  }
  private
   function Border(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* Реализация слова скрипта .TNewBaseSearchForm.Border }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormBorder

 TkwNewBaseSearchFormInnerBorder = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.InnerBorder
[panel]Контрол InnerBorder формы TNewBaseSearchForm[panel]
*Тип результата:* TvgRectangle
*Пример:*
[code]
OBJECT VAR l_TvgRectangle
 aNewBaseSearchForm .TNewBaseSearchForm.InnerBorder >>> l_TvgRectangle
[code]  }
  private
   function InnerBorder(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* Реализация слова скрипта .TNewBaseSearchForm.InnerBorder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormInnerBorder

 TkwNewBaseSearchFormMostOuterRectangle = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.MostOuterRectangle
[panel]Контрол MostOuterRectangle формы TNewBaseSearchForm[panel]
*Тип результата:* TvgRectangle
*Пример:*
[code]
OBJECT VAR l_TvgRectangle
 aNewBaseSearchForm .TNewBaseSearchForm.MostOuterRectangle >>> l_TvgRectangle
[code]  }
  private
   function MostOuterRectangle(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* Реализация слова скрипта .TNewBaseSearchForm.MostOuterRectangle }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormMostOuterRectangle

 TkwNewBaseSearchFormRectangle1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.Rectangle1
[panel]Контрол Rectangle1 формы TNewBaseSearchForm[panel]
*Тип результата:* TvgRectangle
*Пример:*
[code]
OBJECT VAR l_TvgRectangle
 aNewBaseSearchForm .TNewBaseSearchForm.Rectangle1 >>> l_TvgRectangle
[code]  }
  private
   function Rectangle1(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
    {* Реализация слова скрипта .TNewBaseSearchForm.Rectangle1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormRectangle1

 TkwNewBaseSearchFormContextEdit = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.ContextEdit
[panel]Контрол ContextEdit формы TNewBaseSearchForm[panel]
*Тип результата:* TnscTreeComboWithHistoryAndOperations
*Пример:*
[code]
OBJECT VAR l_TnscTreeComboWithHistoryAndOperations
 aNewBaseSearchForm .TNewBaseSearchForm.ContextEdit >>> l_TnscTreeComboWithHistoryAndOperations
[code]  }
  private
   function ContextEdit(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TnscTreeComboWithHistoryAndOperations;
    {* Реализация слова скрипта .TNewBaseSearchForm.ContextEdit }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormContextEdit

 TkwNewBaseSearchFormFlashTimer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TNewBaseSearchForm.FlashTimer
[panel]Контрол FlashTimer формы TNewBaseSearchForm[panel]
*Тип результата:* TTimer
*Пример:*
[code]
OBJECT VAR l_TTimer
 aNewBaseSearchForm .TNewBaseSearchForm.FlashTimer >>> l_TTimer
[code]  }
  private
   function FlashTimer(const aCtx: TtfwContext;
    aNewBaseSearchForm: TNewBaseSearchForm): TTimer;
    {* Реализация слова скрипта .TNewBaseSearchForm.FlashTimer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNewBaseSearchFormFlashTimer

class function Tkw_Form_NewBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::NewBaseSearch';
end;//Tkw_Form_NewBaseSearch.GetWordNameForRegister

function Tkw_Form_NewBaseSearch.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5707F39565D1_var*
//#UC END# *4DDFD2EA0116_5707F39565D1_var*
begin
//#UC START# *4DDFD2EA0116_5707F39565D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5707F39565D1_impl*
end;//Tkw_Form_NewBaseSearch.GetString

class procedure Tkw_Form_NewBaseSearch.RegisterInEngine;
//#UC START# *52A086150180_5707F39565D1_var*
//#UC END# *52A086150180_5707F39565D1_var*
begin
//#UC START# *52A086150180_5707F39565D1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5707F39565D1_impl*
end;//Tkw_Form_NewBaseSearch.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBtn';
end;//Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBtn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F88258025D19_var*
//#UC END# *4DDFD2EA0116_F88258025D19_var*
begin
//#UC START# *4DDFD2EA0116_F88258025D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F88258025D19_impl*
end;//Tkw_NewBaseSearch_Control_FindBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine;
//#UC START# *52A086150180_F88258025D19_var*
//#UC END# *52A086150180_F88258025D19_var*
begin
//#UC START# *52A086150180_F88258025D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F88258025D19_impl*
end;//Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C6101BC5BF0_var*
//#UC END# *4DAEEDE10285_9C6101BC5BF0_var*
begin
//#UC START# *4DAEEDE10285_9C6101BC5BF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C6101BC5BF0_impl*
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBackBtn';
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBackBtn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2F99B63D2C04_var*
//#UC END# *4DDFD2EA0116_2F99B63D2C04_var*
begin
//#UC START# *4DDFD2EA0116_2F99B63D2C04_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2F99B63D2C04_impl*
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine;
//#UC START# *52A086150180_2F99B63D2C04_var*
//#UC END# *52A086150180_2F99B63D2C04_var*
begin
//#UC START# *52A086150180_2F99B63D2C04_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2F99B63D2C04_impl*
end;//Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C6FBEA064468_var*
//#UC END# *4DAEEDE10285_C6FBEA064468_var*
begin
//#UC START# *4DAEEDE10285_C6FBEA064468_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6FBEA064468_impl*
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBackBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseBtn';
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_CloseBtn.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F533BA194283_var*
//#UC END# *4DDFD2EA0116_F533BA194283_var*
begin
//#UC START# *4DDFD2EA0116_F533BA194283_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F533BA194283_impl*
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetString

class procedure Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine;
//#UC START# *52A086150180_F533BA194283_var*
//#UC END# *52A086150180_F533BA194283_var*
begin
//#UC START# *52A086150180_F533BA194283_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F533BA194283_impl*
end;//Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_41A637EF5374_var*
//#UC END# *4DAEEDE10285_41A637EF5374_var*
begin
//#UC START# *4DAEEDE10285_41A637EF5374_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_41A637EF5374_impl*
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseBtn:push';
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AreaCombo';
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_AreaCombo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FF7ECD6B4DDA_var*
//#UC END# *4DDFD2EA0116_FF7ECD6B4DDA_var*
begin
//#UC START# *4DDFD2EA0116_FF7ECD6B4DDA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FF7ECD6B4DDA_impl*
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetString

class procedure Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine;
//#UC START# *52A086150180_FF7ECD6B4DDA_var*
//#UC END# *52A086150180_FF7ECD6B4DDA_var*
begin
//#UC START# *52A086150180_FF7ECD6B4DDA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FF7ECD6B4DDA_impl*
end;//Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_281BC684F5B6_var*
//#UC END# *4DAEEDE10285_281BC684F5B6_var*
begin
//#UC START# *4DAEEDE10285_281BC684F5B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_281BC684F5B6_impl*
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AreaCombo:push';
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::QueryExampleLabel';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4AD512F08EBF_var*
//#UC END# *4DDFD2EA0116_4AD512F08EBF_var*
begin
//#UC START# *4DDFD2EA0116_4AD512F08EBF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4AD512F08EBF_impl*
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine;
//#UC START# *52A086150180_4AD512F08EBF_var*
//#UC END# *52A086150180_4AD512F08EBF_var*
begin
//#UC START# *52A086150180_4AD512F08EBF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4AD512F08EBF_impl*
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_63E2719671C9_var*
//#UC END# *4DAEEDE10285_63E2719671C9_var*
begin
//#UC START# *4DAEEDE10285_63E2719671C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_63E2719671C9_impl*
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::QueryExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DropButton';
end;//Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_DropButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B4C519AF5CA9_var*
//#UC END# *4DDFD2EA0116_B4C519AF5CA9_var*
begin
//#UC START# *4DDFD2EA0116_B4C519AF5CA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B4C519AF5CA9_impl*
end;//Tkw_NewBaseSearch_Control_DropButton.GetString

class procedure Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine;
//#UC START# *52A086150180_B4C519AF5CA9_var*
//#UC END# *52A086150180_B4C519AF5CA9_var*
begin
//#UC START# *52A086150180_B4C519AF5CA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B4C519AF5CA9_impl*
end;//Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_14AE50BBEDF2_var*
//#UC END# *4DAEEDE10285_14AE50BBEDF2_var*
begin
//#UC START# *4DAEEDE10285_14AE50BBEDF2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_14AE50BBEDF2_impl*
end;//Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DropButton:push';
end;//Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoundCountLabel';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FoundCountLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6A5423C6BEE1_var*
//#UC END# *4DDFD2EA0116_6A5423C6BEE1_var*
begin
//#UC START# *4DDFD2EA0116_6A5423C6BEE1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6A5423C6BEE1_impl*
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetString

class procedure Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine;
//#UC START# *52A086150180_6A5423C6BEE1_var*
//#UC END# *52A086150180_6A5423C6BEE1_var*
begin
//#UC START# *52A086150180_6A5423C6BEE1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6A5423C6BEE1_impl*
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_60EBA3B37CE9_var*
//#UC END# *4DAEEDE10285_60EBA3B37CE9_var*
begin
//#UC START# *4DAEEDE10285_60EBA3B37CE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_60EBA3B37CE9_impl*
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoundCountLabel:push';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExampleLabel';
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ExampleLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2414CC50895B_var*
//#UC END# *4DDFD2EA0116_2414CC50895B_var*
begin
//#UC START# *4DDFD2EA0116_2414CC50895B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2414CC50895B_impl*
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine;
//#UC START# *52A086150180_2414CC50895B_var*
//#UC END# *52A086150180_2414CC50895B_var*
begin
//#UC START# *52A086150180_2414CC50895B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2414CC50895B_impl*
end;//Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_37D160C15269_var*
//#UC END# *4DAEEDE10285_37D160C15269_var*
begin
//#UC START# *4DAEEDE10285_37D160C15269_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_37D160C15269_impl*
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEditPanel';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEditPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2B84D776B08C_var*
//#UC END# *4DDFD2EA0116_2B84D776B08C_var*
begin
//#UC START# *4DDFD2EA0116_2B84D776B08C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2B84D776B08C_impl*
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine;
//#UC START# *52A086150180_2B84D776B08C_var*
//#UC END# *52A086150180_2B84D776B08C_var*
begin
//#UC START# *52A086150180_2B84D776B08C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2B84D776B08C_impl*
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D2EBF9DC759D_var*
//#UC END# *4DAEEDE10285_D2EBF9DC759D_var*
begin
//#UC START# *4DAEEDE10285_D2EBF9DC759D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D2EBF9DC759D_impl*
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEditPanel:push';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout1';
end;//Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7111F74A2B08_var*
//#UC END# *4DDFD2EA0116_7111F74A2B08_var*
begin
//#UC START# *4DDFD2EA0116_7111F74A2B08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7111F74A2B08_impl*
end;//Tkw_NewBaseSearch_Control_Layout1.GetString

class procedure Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine;
//#UC START# *52A086150180_7111F74A2B08_var*
//#UC END# *52A086150180_7111F74A2B08_var*
begin
//#UC START# *52A086150180_7111F74A2B08_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7111F74A2B08_impl*
end;//Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CF454CAF1D20_var*
//#UC END# *4DAEEDE10285_CF454CAF1D20_var*
begin
//#UC START# *4DAEEDE10285_CF454CAF1D20_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CF454CAF1D20_impl*
end;//Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout1:push';
end;//Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout2';
end;//Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout2.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6A6DEA72B701_var*
//#UC END# *4DDFD2EA0116_6A6DEA72B701_var*
begin
//#UC START# *4DDFD2EA0116_6A6DEA72B701_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6A6DEA72B701_impl*
end;//Tkw_NewBaseSearch_Control_Layout2.GetString

class procedure Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine;
//#UC START# *52A086150180_6A6DEA72B701_var*
//#UC END# *52A086150180_6A6DEA72B701_var*
begin
//#UC START# *52A086150180_6A6DEA72B701_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6A6DEA72B701_impl*
end;//Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B8AFA826A71B_var*
//#UC END# *4DAEEDE10285_B8AFA826A71B_var*
begin
//#UC START# *4DAEEDE10285_B8AFA826A71B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B8AFA826A71B_impl*
end;//Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout2:push';
end;//Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout3';
end;//Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout3.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6EE6404D6ED3_var*
//#UC END# *4DDFD2EA0116_6EE6404D6ED3_var*
begin
//#UC START# *4DDFD2EA0116_6EE6404D6ED3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6EE6404D6ED3_impl*
end;//Tkw_NewBaseSearch_Control_Layout3.GetString

class procedure Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine;
//#UC START# *52A086150180_6EE6404D6ED3_var*
//#UC END# *52A086150180_6EE6404D6ED3_var*
begin
//#UC START# *52A086150180_6EE6404D6ED3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6EE6404D6ED3_impl*
end;//Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_873491FD86C7_var*
//#UC END# *4DAEEDE10285_873491FD86C7_var*
begin
//#UC START# *4DAEEDE10285_873491FD86C7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_873491FD86C7_impl*
end;//Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout3:push';
end;//Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vgScene1';
end;//Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_vgScene1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3C946C2DA0F4_var*
//#UC END# *4DDFD2EA0116_3C946C2DA0F4_var*
begin
//#UC START# *4DDFD2EA0116_3C946C2DA0F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3C946C2DA0F4_impl*
end;//Tkw_NewBaseSearch_Control_vgScene1.GetString

class procedure Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine;
//#UC START# *52A086150180_3C946C2DA0F4_var*
//#UC END# *52A086150180_3C946C2DA0F4_var*
begin
//#UC START# *52A086150180_3C946C2DA0F4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3C946C2DA0F4_impl*
end;//Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7FDB5B8D5DD8_var*
//#UC END# *4DAEEDE10285_7FDB5B8D5DD8_var*
begin
//#UC START# *4DAEEDE10285_7FDB5B8D5DD8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7FDB5B8D5DD8_impl*
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vgScene1:push';
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MoreTab';
end;//Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MoreTab.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7EA42D88CD42_var*
//#UC END# *4DDFD2EA0116_7EA42D88CD42_var*
begin
//#UC START# *4DDFD2EA0116_7EA42D88CD42_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7EA42D88CD42_impl*
end;//Tkw_NewBaseSearch_Control_MoreTab.GetString

class procedure Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine;
//#UC START# *52A086150180_7EA42D88CD42_var*
//#UC END# *52A086150180_7EA42D88CD42_var*
begin
//#UC START# *52A086150180_7EA42D88CD42_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7EA42D88CD42_impl*
end;//Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BBDB2A8BC88B_var*
//#UC END# *4DAEEDE10285_BBDB2A8BC88B_var*
begin
//#UC START# *4DAEEDE10285_BBDB2A8BC88B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BBDB2A8BC88B_impl*
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MoreTab:push';
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Border';
end;//Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Border.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8A11BAC5EB1F_var*
//#UC END# *4DDFD2EA0116_8A11BAC5EB1F_var*
begin
//#UC START# *4DDFD2EA0116_8A11BAC5EB1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8A11BAC5EB1F_impl*
end;//Tkw_NewBaseSearch_Control_Border.GetString

class procedure Tkw_NewBaseSearch_Control_Border.RegisterInEngine;
//#UC START# *52A086150180_8A11BAC5EB1F_var*
//#UC END# *52A086150180_8A11BAC5EB1F_var*
begin
//#UC START# *52A086150180_8A11BAC5EB1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8A11BAC5EB1F_impl*
end;//Tkw_NewBaseSearch_Control_Border.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_Border_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BAE448339058_var*
//#UC END# *4DAEEDE10285_BAE448339058_var*
begin
//#UC START# *4DAEEDE10285_BAE448339058_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BAE448339058_impl*
end;//Tkw_NewBaseSearch_Control_Border_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Border:push';
end;//Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBorder';
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_InnerBorder.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_ECD2B6691BE0_var*
//#UC END# *4DDFD2EA0116_ECD2B6691BE0_var*
begin
//#UC START# *4DDFD2EA0116_ECD2B6691BE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_ECD2B6691BE0_impl*
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetString

class procedure Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine;
//#UC START# *52A086150180_ECD2B6691BE0_var*
//#UC END# *52A086150180_ECD2B6691BE0_var*
begin
//#UC START# *52A086150180_ECD2B6691BE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_ECD2B6691BE0_impl*
end;//Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3ECBE4FA1D18_var*
//#UC END# *4DAEEDE10285_3ECBE4FA1D18_var*
begin
//#UC START# *4DAEEDE10285_3ECBE4FA1D18_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3ECBE4FA1D18_impl*
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBorder:push';
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MostOuterRectangle';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_24F9C8584DAC_var*
//#UC END# *4DDFD2EA0116_24F9C8584DAC_var*
begin
//#UC START# *4DDFD2EA0116_24F9C8584DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_24F9C8584DAC_impl*
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString

class procedure Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine;
//#UC START# *52A086150180_24F9C8584DAC_var*
//#UC END# *52A086150180_24F9C8584DAC_var*
begin
//#UC START# *52A086150180_24F9C8584DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_24F9C8584DAC_impl*
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CED4F70215DF_var*
//#UC END# *4DAEEDE10285_CED4F70215DF_var*
begin
//#UC START# *4DAEEDE10285_CED4F70215DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CED4F70215DF_impl*
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MostOuterRectangle:push';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Rectangle1';
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Rectangle1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1A646FFE10AE_var*
//#UC END# *4DDFD2EA0116_1A646FFE10AE_var*
begin
//#UC START# *4DDFD2EA0116_1A646FFE10AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1A646FFE10AE_impl*
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetString

class procedure Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine;
//#UC START# *52A086150180_1A646FFE10AE_var*
//#UC END# *52A086150180_1A646FFE10AE_var*
begin
//#UC START# *52A086150180_1A646FFE10AE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1A646FFE10AE_impl*
end;//Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9D65FE806B68_var*
//#UC END# *4DAEEDE10285_9D65FE806B68_var*
begin
//#UC START# *4DAEEDE10285_9D65FE806B68_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9D65FE806B68_impl*
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Rectangle1:push';
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEdit';
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEdit.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_86D06303158B_var*
//#UC END# *4DDFD2EA0116_86D06303158B_var*
begin
//#UC START# *4DDFD2EA0116_86D06303158B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_86D06303158B_impl*
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine;
//#UC START# *52A086150180_86D06303158B_var*
//#UC END# *52A086150180_86D06303158B_var*
begin
//#UC START# *52A086150180_86D06303158B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_86D06303158B_impl*
end;//Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine

procedure Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4E51B3F55D59_var*
//#UC END# *4DAEEDE10285_4E51B3F55D59_var*
begin
//#UC START# *4DAEEDE10285_4E51B3F55D59_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4E51B3F55D59_impl*
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEdit:push';
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister

class function Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::FlashTimer';
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister

function Tkw_NewBaseSearch_Component_FlashTimer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3F3CCC588CDE_var*
//#UC END# *4DDFD2EA0116_3F3CCC588CDE_var*
begin
//#UC START# *4DDFD2EA0116_3F3CCC588CDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3F3CCC588CDE_impl*
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetString

class procedure Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine;
//#UC START# *52A086150180_3F3CCC588CDE_var*
//#UC END# *52A086150180_3F3CCC588CDE_var*
begin
//#UC START# *52A086150180_3F3CCC588CDE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3F3CCC588CDE_impl*
end;//Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine

function TkwNewBaseSearchFormFindBtn.FindBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.FindBtn }
//#UC START# *950274AE5B1A_8487F43B0D1E_var*
//#UC END# *950274AE5B1A_8487F43B0D1E_var*
begin
//#UC START# *950274AE5B1A_8487F43B0D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *950274AE5B1A_8487F43B0D1E_impl*
end;//TkwNewBaseSearchFormFindBtn.FindBtn

procedure TkwNewBaseSearchFormFindBtn.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8487F43B0D1E_var*
//#UC END# *4DAEEDE10285_8487F43B0D1E_var*
begin
//#UC START# *4DAEEDE10285_8487F43B0D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8487F43B0D1E_impl*
end;//TkwNewBaseSearchFormFindBtn.DoDoIt

class function TkwNewBaseSearchFormFindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBtn';
end;//TkwNewBaseSearchFormFindBtn.GetWordNameForRegister

procedure TkwNewBaseSearchFormFindBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8487F43B0D1E_var*
//#UC END# *52D00B00031A_8487F43B0D1E_var*
begin
//#UC START# *52D00B00031A_8487F43B0D1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8487F43B0D1E_impl*
end;//TkwNewBaseSearchFormFindBtn.SetValuePrim

function TkwNewBaseSearchFormFindBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgPathButton);
end;//TkwNewBaseSearchFormFindBtn.GetResultTypeInfo

function TkwNewBaseSearchFormFindBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFindBtn.GetAllParamsCount

function TkwNewBaseSearchFormFindBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormFindBtn.ParamsTypes

function TkwNewBaseSearchFormFindBackBtn.FindBackBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.FindBackBtn }
//#UC START# *A4408FAB31FE_8FD4A0277CFF_var*
//#UC END# *A4408FAB31FE_8FD4A0277CFF_var*
begin
//#UC START# *A4408FAB31FE_8FD4A0277CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *A4408FAB31FE_8FD4A0277CFF_impl*
end;//TkwNewBaseSearchFormFindBackBtn.FindBackBtn

procedure TkwNewBaseSearchFormFindBackBtn.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8FD4A0277CFF_var*
//#UC END# *4DAEEDE10285_8FD4A0277CFF_var*
begin
//#UC START# *4DAEEDE10285_8FD4A0277CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8FD4A0277CFF_impl*
end;//TkwNewBaseSearchFormFindBackBtn.DoDoIt

class function TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBackBtn';
end;//TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister

procedure TkwNewBaseSearchFormFindBackBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8FD4A0277CFF_var*
//#UC END# *52D00B00031A_8FD4A0277CFF_var*
begin
//#UC START# *52D00B00031A_8FD4A0277CFF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8FD4A0277CFF_impl*
end;//TkwNewBaseSearchFormFindBackBtn.SetValuePrim

function TkwNewBaseSearchFormFindBackBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgPathButton);
end;//TkwNewBaseSearchFormFindBackBtn.GetResultTypeInfo

function TkwNewBaseSearchFormFindBackBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFindBackBtn.GetAllParamsCount

function TkwNewBaseSearchFormFindBackBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormFindBackBtn.ParamsTypes

function TkwNewBaseSearchFormCloseBtn.CloseBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgCloseButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.CloseBtn }
//#UC START# *C58A06E15145_90CDA41F40D2_var*
//#UC END# *C58A06E15145_90CDA41F40D2_var*
begin
//#UC START# *C58A06E15145_90CDA41F40D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *C58A06E15145_90CDA41F40D2_impl*
end;//TkwNewBaseSearchFormCloseBtn.CloseBtn

procedure TkwNewBaseSearchFormCloseBtn.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_90CDA41F40D2_var*
//#UC END# *4DAEEDE10285_90CDA41F40D2_var*
begin
//#UC START# *4DAEEDE10285_90CDA41F40D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_90CDA41F40D2_impl*
end;//TkwNewBaseSearchFormCloseBtn.DoDoIt

class function TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.CloseBtn';
end;//TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister

procedure TkwNewBaseSearchFormCloseBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_90CDA41F40D2_var*
//#UC END# *52D00B00031A_90CDA41F40D2_var*
begin
//#UC START# *52D00B00031A_90CDA41F40D2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_90CDA41F40D2_impl*
end;//TkwNewBaseSearchFormCloseBtn.SetValuePrim

function TkwNewBaseSearchFormCloseBtn.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgCloseButton);
end;//TkwNewBaseSearchFormCloseBtn.GetResultTypeInfo

function TkwNewBaseSearchFormCloseBtn.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormCloseBtn.GetAllParamsCount

function TkwNewBaseSearchFormCloseBtn.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormCloseBtn.ParamsTypes

function TkwNewBaseSearchFormAreaCombo.AreaCombo(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* Реализация слова скрипта .TNewBaseSearchForm.AreaCombo }
//#UC START# *6FBAA7D9C90F_4D85E5711038_var*
//#UC END# *6FBAA7D9C90F_4D85E5711038_var*
begin
//#UC START# *6FBAA7D9C90F_4D85E5711038_impl*
 !!! Needs to be implemented !!!
//#UC END# *6FBAA7D9C90F_4D85E5711038_impl*
end;//TkwNewBaseSearchFormAreaCombo.AreaCombo

procedure TkwNewBaseSearchFormAreaCombo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4D85E5711038_var*
//#UC END# *4DAEEDE10285_4D85E5711038_var*
begin
//#UC START# *4DAEEDE10285_4D85E5711038_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4D85E5711038_impl*
end;//TkwNewBaseSearchFormAreaCombo.DoDoIt

class function TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.AreaCombo';
end;//TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister

procedure TkwNewBaseSearchFormAreaCombo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4D85E5711038_var*
//#UC END# *52D00B00031A_4D85E5711038_var*
begin
//#UC START# *52D00B00031A_4D85E5711038_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4D85E5711038_impl*
end;//TkwNewBaseSearchFormAreaCombo.SetValuePrim

function TkwNewBaseSearchFormAreaCombo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgComboBox);
end;//TkwNewBaseSearchFormAreaCombo.GetResultTypeInfo

function TkwNewBaseSearchFormAreaCombo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormAreaCombo.GetAllParamsCount

function TkwNewBaseSearchFormAreaCombo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormAreaCombo.ParamsTypes

function TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.QueryExampleLabel }
//#UC START# *76A1048784E7_505ADAD50252_var*
//#UC END# *76A1048784E7_505ADAD50252_var*
begin
//#UC START# *76A1048784E7_505ADAD50252_impl*
 !!! Needs to be implemented !!!
//#UC END# *76A1048784E7_505ADAD50252_impl*
end;//TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel

procedure TkwNewBaseSearchFormQueryExampleLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_505ADAD50252_var*
//#UC END# *4DAEEDE10285_505ADAD50252_var*
begin
//#UC START# *4DAEEDE10285_505ADAD50252_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_505ADAD50252_impl*
end;//TkwNewBaseSearchFormQueryExampleLabel.DoDoIt

class function TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.QueryExampleLabel';
end;//TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister

procedure TkwNewBaseSearchFormQueryExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_505ADAD50252_var*
//#UC END# *52D00B00031A_505ADAD50252_var*
begin
//#UC START# *52D00B00031A_505ADAD50252_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_505ADAD50252_impl*
end;//TkwNewBaseSearchFormQueryExampleLabel.SetValuePrim

function TkwNewBaseSearchFormQueryExampleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormQueryExampleLabel.GetResultTypeInfo

function TkwNewBaseSearchFormQueryExampleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormQueryExampleLabel.GetAllParamsCount

function TkwNewBaseSearchFormQueryExampleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormQueryExampleLabel.ParamsTypes

function TkwNewBaseSearchFormDropButton.DropButton(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.DropButton }
//#UC START# *15B82C921510_A991331821D4_var*
//#UC END# *15B82C921510_A991331821D4_var*
begin
//#UC START# *15B82C921510_A991331821D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *15B82C921510_A991331821D4_impl*
end;//TkwNewBaseSearchFormDropButton.DropButton

procedure TkwNewBaseSearchFormDropButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A991331821D4_var*
//#UC END# *4DAEEDE10285_A991331821D4_var*
begin
//#UC START# *4DAEEDE10285_A991331821D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A991331821D4_impl*
end;//TkwNewBaseSearchFormDropButton.DoDoIt

class function TkwNewBaseSearchFormDropButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.DropButton';
end;//TkwNewBaseSearchFormDropButton.GetWordNameForRegister

procedure TkwNewBaseSearchFormDropButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A991331821D4_var*
//#UC END# *52D00B00031A_A991331821D4_var*
begin
//#UC START# *52D00B00031A_A991331821D4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A991331821D4_impl*
end;//TkwNewBaseSearchFormDropButton.SetValuePrim

function TkwNewBaseSearchFormDropButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgButton);
end;//TkwNewBaseSearchFormDropButton.GetResultTypeInfo

function TkwNewBaseSearchFormDropButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormDropButton.GetAllParamsCount

function TkwNewBaseSearchFormDropButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormDropButton.ParamsTypes

function TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.FoundCountLabel }
//#UC START# *5BDAC45D8222_6C75E19A9417_var*
//#UC END# *5BDAC45D8222_6C75E19A9417_var*
begin
//#UC START# *5BDAC45D8222_6C75E19A9417_impl*
 !!! Needs to be implemented !!!
//#UC END# *5BDAC45D8222_6C75E19A9417_impl*
end;//TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel

procedure TkwNewBaseSearchFormFoundCountLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6C75E19A9417_var*
//#UC END# *4DAEEDE10285_6C75E19A9417_var*
begin
//#UC START# *4DAEEDE10285_6C75E19A9417_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6C75E19A9417_impl*
end;//TkwNewBaseSearchFormFoundCountLabel.DoDoIt

class function TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FoundCountLabel';
end;//TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister

procedure TkwNewBaseSearchFormFoundCountLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6C75E19A9417_var*
//#UC END# *52D00B00031A_6C75E19A9417_var*
begin
//#UC START# *52D00B00031A_6C75E19A9417_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6C75E19A9417_impl*
end;//TkwNewBaseSearchFormFoundCountLabel.SetValuePrim

function TkwNewBaseSearchFormFoundCountLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormFoundCountLabel.GetResultTypeInfo

function TkwNewBaseSearchFormFoundCountLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFoundCountLabel.GetAllParamsCount

function TkwNewBaseSearchFormFoundCountLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormFoundCountLabel.ParamsTypes

function TkwNewBaseSearchFormExampleLabel.ExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.ExampleLabel }
//#UC START# *9BC365FC7E17_EB6013B55CA8_var*
//#UC END# *9BC365FC7E17_EB6013B55CA8_var*
begin
//#UC START# *9BC365FC7E17_EB6013B55CA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *9BC365FC7E17_EB6013B55CA8_impl*
end;//TkwNewBaseSearchFormExampleLabel.ExampleLabel

procedure TkwNewBaseSearchFormExampleLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EB6013B55CA8_var*
//#UC END# *4DAEEDE10285_EB6013B55CA8_var*
begin
//#UC START# *4DAEEDE10285_EB6013B55CA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EB6013B55CA8_impl*
end;//TkwNewBaseSearchFormExampleLabel.DoDoIt

class function TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ExampleLabel';
end;//TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister

procedure TkwNewBaseSearchFormExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_EB6013B55CA8_var*
//#UC END# *52D00B00031A_EB6013B55CA8_var*
begin
//#UC START# *52D00B00031A_EB6013B55CA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_EB6013B55CA8_impl*
end;//TkwNewBaseSearchFormExampleLabel.SetValuePrim

function TkwNewBaseSearchFormExampleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgText);
end;//TkwNewBaseSearchFormExampleLabel.GetResultTypeInfo

function TkwNewBaseSearchFormExampleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormExampleLabel.GetAllParamsCount

function TkwNewBaseSearchFormExampleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormExampleLabel.ParamsTypes

function TkwNewBaseSearchFormContextEditPanel.ContextEditPanel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgNonVGLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.ContextEditPanel }
//#UC START# *83BFA8B30125_BC18F8F57D3A_var*
//#UC END# *83BFA8B30125_BC18F8F57D3A_var*
begin
//#UC START# *83BFA8B30125_BC18F8F57D3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *83BFA8B30125_BC18F8F57D3A_impl*
end;//TkwNewBaseSearchFormContextEditPanel.ContextEditPanel

procedure TkwNewBaseSearchFormContextEditPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BC18F8F57D3A_var*
//#UC END# *4DAEEDE10285_BC18F8F57D3A_var*
begin
//#UC START# *4DAEEDE10285_BC18F8F57D3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BC18F8F57D3A_impl*
end;//TkwNewBaseSearchFormContextEditPanel.DoDoIt

class function TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEditPanel';
end;//TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister

procedure TkwNewBaseSearchFormContextEditPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_BC18F8F57D3A_var*
//#UC END# *52D00B00031A_BC18F8F57D3A_var*
begin
//#UC START# *52D00B00031A_BC18F8F57D3A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_BC18F8F57D3A_impl*
end;//TkwNewBaseSearchFormContextEditPanel.SetValuePrim

function TkwNewBaseSearchFormContextEditPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgNonVGLayout);
end;//TkwNewBaseSearchFormContextEditPanel.GetResultTypeInfo

function TkwNewBaseSearchFormContextEditPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormContextEditPanel.GetAllParamsCount

function TkwNewBaseSearchFormContextEditPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormContextEditPanel.ParamsTypes

function TkwNewBaseSearchFormLayout1.Layout1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout1 }
//#UC START# *2877FB08CB3C_2824E7848D0C_var*
//#UC END# *2877FB08CB3C_2824E7848D0C_var*
begin
//#UC START# *2877FB08CB3C_2824E7848D0C_impl*
 !!! Needs to be implemented !!!
//#UC END# *2877FB08CB3C_2824E7848D0C_impl*
end;//TkwNewBaseSearchFormLayout1.Layout1

procedure TkwNewBaseSearchFormLayout1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2824E7848D0C_var*
//#UC END# *4DAEEDE10285_2824E7848D0C_var*
begin
//#UC START# *4DAEEDE10285_2824E7848D0C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2824E7848D0C_impl*
end;//TkwNewBaseSearchFormLayout1.DoDoIt

class function TkwNewBaseSearchFormLayout1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout1';
end;//TkwNewBaseSearchFormLayout1.GetWordNameForRegister

procedure TkwNewBaseSearchFormLayout1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2824E7848D0C_var*
//#UC END# *52D00B00031A_2824E7848D0C_var*
begin
//#UC START# *52D00B00031A_2824E7848D0C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2824E7848D0C_impl*
end;//TkwNewBaseSearchFormLayout1.SetValuePrim

function TkwNewBaseSearchFormLayout1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout1.GetResultTypeInfo

function TkwNewBaseSearchFormLayout1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout1.GetAllParamsCount

function TkwNewBaseSearchFormLayout1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormLayout1.ParamsTypes

function TkwNewBaseSearchFormLayout2.Layout2(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout2 }
//#UC START# *C5319B3D34F0_57D5D6C99B6B_var*
//#UC END# *C5319B3D34F0_57D5D6C99B6B_var*
begin
//#UC START# *C5319B3D34F0_57D5D6C99B6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5319B3D34F0_57D5D6C99B6B_impl*
end;//TkwNewBaseSearchFormLayout2.Layout2

procedure TkwNewBaseSearchFormLayout2.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_57D5D6C99B6B_var*
//#UC END# *4DAEEDE10285_57D5D6C99B6B_var*
begin
//#UC START# *4DAEEDE10285_57D5D6C99B6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_57D5D6C99B6B_impl*
end;//TkwNewBaseSearchFormLayout2.DoDoIt

class function TkwNewBaseSearchFormLayout2.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout2';
end;//TkwNewBaseSearchFormLayout2.GetWordNameForRegister

procedure TkwNewBaseSearchFormLayout2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_57D5D6C99B6B_var*
//#UC END# *52D00B00031A_57D5D6C99B6B_var*
begin
//#UC START# *52D00B00031A_57D5D6C99B6B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_57D5D6C99B6B_impl*
end;//TkwNewBaseSearchFormLayout2.SetValuePrim

function TkwNewBaseSearchFormLayout2.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout2.GetResultTypeInfo

function TkwNewBaseSearchFormLayout2.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout2.GetAllParamsCount

function TkwNewBaseSearchFormLayout2.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormLayout2.ParamsTypes

function TkwNewBaseSearchFormLayout3.Layout3(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout3 }
//#UC START# *778118300E56_DC70024F6763_var*
//#UC END# *778118300E56_DC70024F6763_var*
begin
//#UC START# *778118300E56_DC70024F6763_impl*
 !!! Needs to be implemented !!!
//#UC END# *778118300E56_DC70024F6763_impl*
end;//TkwNewBaseSearchFormLayout3.Layout3

procedure TkwNewBaseSearchFormLayout3.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DC70024F6763_var*
//#UC END# *4DAEEDE10285_DC70024F6763_var*
begin
//#UC START# *4DAEEDE10285_DC70024F6763_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DC70024F6763_impl*
end;//TkwNewBaseSearchFormLayout3.DoDoIt

class function TkwNewBaseSearchFormLayout3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout3';
end;//TkwNewBaseSearchFormLayout3.GetWordNameForRegister

procedure TkwNewBaseSearchFormLayout3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_DC70024F6763_var*
//#UC END# *52D00B00031A_DC70024F6763_var*
begin
//#UC START# *52D00B00031A_DC70024F6763_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_DC70024F6763_impl*
end;//TkwNewBaseSearchFormLayout3.SetValuePrim

function TkwNewBaseSearchFormLayout3.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgLayout);
end;//TkwNewBaseSearchFormLayout3.GetResultTypeInfo

function TkwNewBaseSearchFormLayout3.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormLayout3.GetAllParamsCount

function TkwNewBaseSearchFormLayout3.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormLayout3.ParamsTypes

function TkwNewBaseSearchFormVgScene1.vgScene1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgScene;
 {* Реализация слова скрипта .TNewBaseSearchForm.vgScene1 }
//#UC START# *88FC0BF68D8A_B13A4A98049B_var*
//#UC END# *88FC0BF68D8A_B13A4A98049B_var*
begin
//#UC START# *88FC0BF68D8A_B13A4A98049B_impl*
 !!! Needs to be implemented !!!
//#UC END# *88FC0BF68D8A_B13A4A98049B_impl*
end;//TkwNewBaseSearchFormVgScene1.vgScene1

procedure TkwNewBaseSearchFormVgScene1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B13A4A98049B_var*
//#UC END# *4DAEEDE10285_B13A4A98049B_var*
begin
//#UC START# *4DAEEDE10285_B13A4A98049B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B13A4A98049B_impl*
end;//TkwNewBaseSearchFormVgScene1.DoDoIt

class function TkwNewBaseSearchFormVgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.vgScene1';
end;//TkwNewBaseSearchFormVgScene1.GetWordNameForRegister

procedure TkwNewBaseSearchFormVgScene1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B13A4A98049B_var*
//#UC END# *52D00B00031A_B13A4A98049B_var*
begin
//#UC START# *52D00B00031A_B13A4A98049B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B13A4A98049B_impl*
end;//TkwNewBaseSearchFormVgScene1.SetValuePrim

function TkwNewBaseSearchFormVgScene1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgScene);
end;//TkwNewBaseSearchFormVgScene1.GetResultTypeInfo

function TkwNewBaseSearchFormVgScene1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormVgScene1.GetAllParamsCount

function TkwNewBaseSearchFormVgScene1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormVgScene1.ParamsTypes

function TkwNewBaseSearchFormMoreTab.MoreTab(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* Реализация слова скрипта .TNewBaseSearchForm.MoreTab }
//#UC START# *8AEBBA5A35C2_FF59636CB724_var*
//#UC END# *8AEBBA5A35C2_FF59636CB724_var*
begin
//#UC START# *8AEBBA5A35C2_FF59636CB724_impl*
 !!! Needs to be implemented !!!
//#UC END# *8AEBBA5A35C2_FF59636CB724_impl*
end;//TkwNewBaseSearchFormMoreTab.MoreTab

procedure TkwNewBaseSearchFormMoreTab.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FF59636CB724_var*
//#UC END# *4DAEEDE10285_FF59636CB724_var*
begin
//#UC START# *4DAEEDE10285_FF59636CB724_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FF59636CB724_impl*
end;//TkwNewBaseSearchFormMoreTab.DoDoIt

class function TkwNewBaseSearchFormMoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MoreTab';
end;//TkwNewBaseSearchFormMoreTab.GetWordNameForRegister

procedure TkwNewBaseSearchFormMoreTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FF59636CB724_var*
//#UC END# *52D00B00031A_FF59636CB724_var*
begin
//#UC START# *52D00B00031A_FF59636CB724_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FF59636CB724_impl*
end;//TkwNewBaseSearchFormMoreTab.SetValuePrim

function TkwNewBaseSearchFormMoreTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgComboBox);
end;//TkwNewBaseSearchFormMoreTab.GetResultTypeInfo

function TkwNewBaseSearchFormMoreTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormMoreTab.GetAllParamsCount

function TkwNewBaseSearchFormMoreTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormMoreTab.ParamsTypes

function TkwNewBaseSearchFormBorder.Border(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.Border }
//#UC START# *DC3F44F28F49_02D50A1E8F6D_var*
//#UC END# *DC3F44F28F49_02D50A1E8F6D_var*
begin
//#UC START# *DC3F44F28F49_02D50A1E8F6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *DC3F44F28F49_02D50A1E8F6D_impl*
end;//TkwNewBaseSearchFormBorder.Border

procedure TkwNewBaseSearchFormBorder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_02D50A1E8F6D_var*
//#UC END# *4DAEEDE10285_02D50A1E8F6D_var*
begin
//#UC START# *4DAEEDE10285_02D50A1E8F6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_02D50A1E8F6D_impl*
end;//TkwNewBaseSearchFormBorder.DoDoIt

class function TkwNewBaseSearchFormBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Border';
end;//TkwNewBaseSearchFormBorder.GetWordNameForRegister

procedure TkwNewBaseSearchFormBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_02D50A1E8F6D_var*
//#UC END# *52D00B00031A_02D50A1E8F6D_var*
begin
//#UC START# *52D00B00031A_02D50A1E8F6D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_02D50A1E8F6D_impl*
end;//TkwNewBaseSearchFormBorder.SetValuePrim

function TkwNewBaseSearchFormBorder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormBorder.GetResultTypeInfo

function TkwNewBaseSearchFormBorder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormBorder.GetAllParamsCount

function TkwNewBaseSearchFormBorder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormBorder.ParamsTypes

function TkwNewBaseSearchFormInnerBorder.InnerBorder(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.InnerBorder }
//#UC START# *000E7CBB0C25_85C7A7A826B7_var*
//#UC END# *000E7CBB0C25_85C7A7A826B7_var*
begin
//#UC START# *000E7CBB0C25_85C7A7A826B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *000E7CBB0C25_85C7A7A826B7_impl*
end;//TkwNewBaseSearchFormInnerBorder.InnerBorder

procedure TkwNewBaseSearchFormInnerBorder.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_85C7A7A826B7_var*
//#UC END# *4DAEEDE10285_85C7A7A826B7_var*
begin
//#UC START# *4DAEEDE10285_85C7A7A826B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_85C7A7A826B7_impl*
end;//TkwNewBaseSearchFormInnerBorder.DoDoIt

class function TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.InnerBorder';
end;//TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister

procedure TkwNewBaseSearchFormInnerBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_85C7A7A826B7_var*
//#UC END# *52D00B00031A_85C7A7A826B7_var*
begin
//#UC START# *52D00B00031A_85C7A7A826B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_85C7A7A826B7_impl*
end;//TkwNewBaseSearchFormInnerBorder.SetValuePrim

function TkwNewBaseSearchFormInnerBorder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormInnerBorder.GetResultTypeInfo

function TkwNewBaseSearchFormInnerBorder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormInnerBorder.GetAllParamsCount

function TkwNewBaseSearchFormInnerBorder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormInnerBorder.ParamsTypes

function TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.MostOuterRectangle }
//#UC START# *1B90617F0BB2_B8CD8BF7C9B3_var*
//#UC END# *1B90617F0BB2_B8CD8BF7C9B3_var*
begin
//#UC START# *1B90617F0BB2_B8CD8BF7C9B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *1B90617F0BB2_B8CD8BF7C9B3_impl*
end;//TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle

procedure TkwNewBaseSearchFormMostOuterRectangle.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B8CD8BF7C9B3_var*
//#UC END# *4DAEEDE10285_B8CD8BF7C9B3_var*
begin
//#UC START# *4DAEEDE10285_B8CD8BF7C9B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B8CD8BF7C9B3_impl*
end;//TkwNewBaseSearchFormMostOuterRectangle.DoDoIt

class function TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MostOuterRectangle';
end;//TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister

procedure TkwNewBaseSearchFormMostOuterRectangle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B8CD8BF7C9B3_var*
//#UC END# *52D00B00031A_B8CD8BF7C9B3_var*
begin
//#UC START# *52D00B00031A_B8CD8BF7C9B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B8CD8BF7C9B3_impl*
end;//TkwNewBaseSearchFormMostOuterRectangle.SetValuePrim

function TkwNewBaseSearchFormMostOuterRectangle.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormMostOuterRectangle.GetResultTypeInfo

function TkwNewBaseSearchFormMostOuterRectangle.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormMostOuterRectangle.GetAllParamsCount

function TkwNewBaseSearchFormMostOuterRectangle.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormMostOuterRectangle.ParamsTypes

function TkwNewBaseSearchFormRectangle1.Rectangle1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.Rectangle1 }
//#UC START# *676533D22355_CB750FEEA0A4_var*
//#UC END# *676533D22355_CB750FEEA0A4_var*
begin
//#UC START# *676533D22355_CB750FEEA0A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *676533D22355_CB750FEEA0A4_impl*
end;//TkwNewBaseSearchFormRectangle1.Rectangle1

procedure TkwNewBaseSearchFormRectangle1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB750FEEA0A4_var*
//#UC END# *4DAEEDE10285_CB750FEEA0A4_var*
begin
//#UC START# *4DAEEDE10285_CB750FEEA0A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB750FEEA0A4_impl*
end;//TkwNewBaseSearchFormRectangle1.DoDoIt

class function TkwNewBaseSearchFormRectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Rectangle1';
end;//TkwNewBaseSearchFormRectangle1.GetWordNameForRegister

procedure TkwNewBaseSearchFormRectangle1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CB750FEEA0A4_var*
//#UC END# *52D00B00031A_CB750FEEA0A4_var*
begin
//#UC START# *52D00B00031A_CB750FEEA0A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CB750FEEA0A4_impl*
end;//TkwNewBaseSearchFormRectangle1.SetValuePrim

function TkwNewBaseSearchFormRectangle1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvgRectangle);
end;//TkwNewBaseSearchFormRectangle1.GetResultTypeInfo

function TkwNewBaseSearchFormRectangle1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormRectangle1.GetAllParamsCount

function TkwNewBaseSearchFormRectangle1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormRectangle1.ParamsTypes

function TkwNewBaseSearchFormContextEdit.ContextEdit(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TnscTreeComboWithHistoryAndOperations;
 {* Реализация слова скрипта .TNewBaseSearchForm.ContextEdit }
//#UC START# *42FBE2C33494_C6AE29665243_var*
//#UC END# *42FBE2C33494_C6AE29665243_var*
begin
//#UC START# *42FBE2C33494_C6AE29665243_impl*
 !!! Needs to be implemented !!!
//#UC END# *42FBE2C33494_C6AE29665243_impl*
end;//TkwNewBaseSearchFormContextEdit.ContextEdit

procedure TkwNewBaseSearchFormContextEdit.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C6AE29665243_var*
//#UC END# *4DAEEDE10285_C6AE29665243_var*
begin
//#UC START# *4DAEEDE10285_C6AE29665243_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C6AE29665243_impl*
end;//TkwNewBaseSearchFormContextEdit.DoDoIt

class function TkwNewBaseSearchFormContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEdit';
end;//TkwNewBaseSearchFormContextEdit.GetWordNameForRegister

procedure TkwNewBaseSearchFormContextEdit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C6AE29665243_var*
//#UC END# *52D00B00031A_C6AE29665243_var*
begin
//#UC START# *52D00B00031A_C6AE29665243_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C6AE29665243_impl*
end;//TkwNewBaseSearchFormContextEdit.SetValuePrim

function TkwNewBaseSearchFormContextEdit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeComboWithHistoryAndOperations);
end;//TkwNewBaseSearchFormContextEdit.GetResultTypeInfo

function TkwNewBaseSearchFormContextEdit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormContextEdit.GetAllParamsCount

function TkwNewBaseSearchFormContextEdit.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormContextEdit.ParamsTypes

function TkwNewBaseSearchFormFlashTimer.FlashTimer(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TTimer;
 {* Реализация слова скрипта .TNewBaseSearchForm.FlashTimer }
//#UC START# *7C6367EDDBBB_52CA7BEB5C5D_var*
//#UC END# *7C6367EDDBBB_52CA7BEB5C5D_var*
begin
//#UC START# *7C6367EDDBBB_52CA7BEB5C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C6367EDDBBB_52CA7BEB5C5D_impl*
end;//TkwNewBaseSearchFormFlashTimer.FlashTimer

procedure TkwNewBaseSearchFormFlashTimer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52CA7BEB5C5D_var*
//#UC END# *4DAEEDE10285_52CA7BEB5C5D_var*
begin
//#UC START# *4DAEEDE10285_52CA7BEB5C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_52CA7BEB5C5D_impl*
end;//TkwNewBaseSearchFormFlashTimer.DoDoIt

class function TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FlashTimer';
end;//TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister

procedure TkwNewBaseSearchFormFlashTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_52CA7BEB5C5D_var*
//#UC END# *52D00B00031A_52CA7BEB5C5D_var*
begin
//#UC START# *52D00B00031A_52CA7BEB5C5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_52CA7BEB5C5D_impl*
end;//TkwNewBaseSearchFormFlashTimer.SetValuePrim

function TkwNewBaseSearchFormFlashTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTimer);
end;//TkwNewBaseSearchFormFlashTimer.GetResultTypeInfo

function TkwNewBaseSearchFormFlashTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNewBaseSearchFormFlashTimer.GetAllParamsCount

function TkwNewBaseSearchFormFlashTimer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwNewBaseSearchFormFlashTimer.ParamsTypes

initialization
 Tkw_Form_NewBaseSearch.RegisterInEngine;
 {* Регистрация Tkw_Form_NewBaseSearch }
 Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FindBtn }
 Tkw_NewBaseSearch_Control_FindBtn_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FindBtn_Push }
 Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FindBackBtn }
 Tkw_NewBaseSearch_Control_FindBackBtn_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FindBackBtn_Push }
 Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_CloseBtn }
 Tkw_NewBaseSearch_Control_CloseBtn_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_CloseBtn_Push }
 Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_AreaCombo }
 Tkw_NewBaseSearch_Control_AreaCombo_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_AreaCombo_Push }
 Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_QueryExampleLabel }
 Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_QueryExampleLabel_Push }
 Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_DropButton }
 Tkw_NewBaseSearch_Control_DropButton_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_DropButton_Push }
 Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FoundCountLabel }
 Tkw_NewBaseSearch_Control_FoundCountLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_FoundCountLabel_Push }
 Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ExampleLabel }
 Tkw_NewBaseSearch_Control_ExampleLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ExampleLabel_Push }
 Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ContextEditPanel }
 Tkw_NewBaseSearch_Control_ContextEditPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ContextEditPanel_Push }
 Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout1 }
 Tkw_NewBaseSearch_Control_Layout1_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout1_Push }
 Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout2 }
 Tkw_NewBaseSearch_Control_Layout2_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout2_Push }
 Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout3 }
 Tkw_NewBaseSearch_Control_Layout3_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Layout3_Push }
 Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_vgScene1 }
 Tkw_NewBaseSearch_Control_vgScene1_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_vgScene1_Push }
 Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_MoreTab }
 Tkw_NewBaseSearch_Control_MoreTab_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_MoreTab_Push }
 Tkw_NewBaseSearch_Control_Border.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Border }
 Tkw_NewBaseSearch_Control_Border_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Border_Push }
 Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_InnerBorder }
 Tkw_NewBaseSearch_Control_InnerBorder_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_InnerBorder_Push }
 Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_MostOuterRectangle }
 Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_MostOuterRectangle_Push }
 Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Rectangle1 }
 Tkw_NewBaseSearch_Control_Rectangle1_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_Rectangle1_Push }
 Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ContextEdit }
 Tkw_NewBaseSearch_Control_ContextEdit_Push.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Control_ContextEdit_Push }
 Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine;
 {* Регистрация Tkw_NewBaseSearch_Component_FlashTimer }
 TkwNewBaseSearchFormFindBtn.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_FindBtn }
 TkwNewBaseSearchFormFindBackBtn.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_FindBackBtn }
 TkwNewBaseSearchFormCloseBtn.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_CloseBtn }
 TkwNewBaseSearchFormAreaCombo.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_AreaCombo }
 TkwNewBaseSearchFormQueryExampleLabel.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_QueryExampleLabel }
 TkwNewBaseSearchFormDropButton.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_DropButton }
 TkwNewBaseSearchFormFoundCountLabel.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_FoundCountLabel }
 TkwNewBaseSearchFormExampleLabel.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_ExampleLabel }
 TkwNewBaseSearchFormContextEditPanel.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_ContextEditPanel }
 TkwNewBaseSearchFormLayout1.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_Layout1 }
 TkwNewBaseSearchFormLayout2.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_Layout2 }
 TkwNewBaseSearchFormLayout3.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_Layout3 }
 TkwNewBaseSearchFormVgScene1.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_vgScene1 }
 TkwNewBaseSearchFormMoreTab.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_MoreTab }
 TkwNewBaseSearchFormBorder.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_Border }
 TkwNewBaseSearchFormInnerBorder.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_InnerBorder }
 TkwNewBaseSearchFormMostOuterRectangle.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_MostOuterRectangle }
 TkwNewBaseSearchFormRectangle1.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_Rectangle1 }
 TkwNewBaseSearchFormContextEdit.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_ContextEdit }
 TkwNewBaseSearchFormFlashTimer.RegisterInEngine;
 {* Регистрация NewBaseSearchForm_FlashTimer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TNewBaseSearchForm));
 {* Регистрация типа NewBaseSearch }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgPathButton));
 {* Регистрация типа TvgPathButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgCloseButton));
 {* Регистрация типа TvgCloseButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgComboBox));
 {* Регистрация типа TvgComboBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgText));
 {* Регистрация типа TvgText }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgButton));
 {* Регистрация типа TvgButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgNonVGLayout));
 {* Регистрация типа TvgNonVGLayout }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgLayout));
 {* Регистрация типа TvgLayout }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgScene));
 {* Регистрация типа TvgScene }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvgRectangle));
 {* Регистрация типа TvgRectangle }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeComboWithHistoryAndOperations));
 {* Регистрация типа TnscTreeComboWithHistoryAndOperations }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTimer));
 {* Регистрация типа TTimer }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
