unit NewBaseSearchKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы NewBaseSearch }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\NewBaseSearchKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "NewBaseSearchKeywordsPack" MUID: (FBDBFE5A21AC)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
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
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , NewBaseSearch_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_NewBaseSearch

 Tkw_NewBaseSearch_Control_FindBtn = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FindBtn
----
*Пример использования*:
[code]
контрол::FindBtn TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBtn

 Tkw_NewBaseSearch_Control_FindBtn_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FindBackBtn

 Tkw_NewBaseSearch_Control_FindBackBtn_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_CloseBtn

 Tkw_NewBaseSearch_Control_CloseBtn_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_AreaCombo

 Tkw_NewBaseSearch_Control_AreaCombo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_QueryExampleLabel

 Tkw_NewBaseSearch_Control_QueryExampleLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_DropButton

 Tkw_NewBaseSearch_Control_DropButton_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_FoundCountLabel

 Tkw_NewBaseSearch_Control_FoundCountLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ExampleLabel

 Tkw_NewBaseSearch_Control_ExampleLabel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEditPanel

 Tkw_NewBaseSearch_Control_ContextEditPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout1

 Tkw_NewBaseSearch_Control_Layout1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout2

 Tkw_NewBaseSearch_Control_Layout2_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Layout3

 Tkw_NewBaseSearch_Control_Layout3_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_vgScene1

 Tkw_NewBaseSearch_Control_vgScene1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MoreTab

 Tkw_NewBaseSearch_Control_MoreTab_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Border

 Tkw_NewBaseSearch_Control_Border_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_InnerBorder

 Tkw_NewBaseSearch_Control_InnerBorder_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_MostOuterRectangle

 Tkw_NewBaseSearch_Control_MostOuterRectangle_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_Rectangle1

 Tkw_NewBaseSearch_Control_Rectangle1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewBaseSearch_Control_ContextEdit

 Tkw_NewBaseSearch_Control_ContextEdit_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
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

function Tkw_Form_NewBaseSearch.GetString: AnsiString;
begin
 Result := 'NewBaseSearchForm';
end;//Tkw_Form_NewBaseSearch.GetString

class procedure Tkw_Form_NewBaseSearch.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TNewBaseSearchForm);
end;//Tkw_Form_NewBaseSearch.RegisterInEngine

class function Tkw_Form_NewBaseSearch.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::NewBaseSearch';
end;//Tkw_Form_NewBaseSearch.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBtn.GetString: AnsiString;
begin
 Result := 'FindBtn';
end;//Tkw_NewBaseSearch_Control_FindBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgPathButton);
end;//Tkw_NewBaseSearch_Control_FindBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBtn';
end;//Tkw_NewBaseSearch_Control_FindBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FindBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FindBackBtn.GetString: AnsiString;
begin
 Result := 'FindBackBtn';
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetString

class procedure Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgPathButton);
end;//Tkw_NewBaseSearch_Control_FindBackBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBackBtn';
end;//Tkw_NewBaseSearch_Control_FindBackBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FindBackBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FindBackBtn:push';
end;//Tkw_NewBaseSearch_Control_FindBackBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_CloseBtn.GetString: AnsiString;
begin
 Result := 'CloseBtn';
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetString

class procedure Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgCloseButton);
end;//Tkw_NewBaseSearch_Control_CloseBtn.RegisterInEngine

class function Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseBtn';
end;//Tkw_NewBaseSearch_Control_CloseBtn.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CloseBtn');
 inherited;
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseBtn:push';
end;//Tkw_NewBaseSearch_Control_CloseBtn_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_AreaCombo.GetString: AnsiString;
begin
 Result := 'AreaCombo';
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetString

class procedure Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgComboBox);
end;//Tkw_NewBaseSearch_Control_AreaCombo.RegisterInEngine

class function Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AreaCombo';
end;//Tkw_NewBaseSearch_Control_AreaCombo.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AreaCombo');
 inherited;
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AreaCombo:push';
end;//Tkw_NewBaseSearch_Control_AreaCombo_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString: AnsiString;
begin
 Result := 'QueryExampleLabel';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::QueryExampleLabel';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('QueryExampleLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::QueryExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_QueryExampleLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_DropButton.GetString: AnsiString;
begin
 Result := 'DropButton';
end;//Tkw_NewBaseSearch_Control_DropButton.GetString

class procedure Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgButton);
end;//Tkw_NewBaseSearch_Control_DropButton.RegisterInEngine

class function Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DropButton';
end;//Tkw_NewBaseSearch_Control_DropButton.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DropButton');
 inherited;
end;//Tkw_NewBaseSearch_Control_DropButton_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DropButton:push';
end;//Tkw_NewBaseSearch_Control_DropButton_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_FoundCountLabel.GetString: AnsiString;
begin
 Result := 'FoundCountLabel';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetString

class procedure Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoundCountLabel';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('FoundCountLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoundCountLabel:push';
end;//Tkw_NewBaseSearch_Control_FoundCountLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ExampleLabel.GetString: AnsiString;
begin
 Result := 'ExampleLabel';
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetString

class procedure Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgText);
end;//Tkw_NewBaseSearch_Control_ExampleLabel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExampleLabel';
end;//Tkw_NewBaseSearch_Control_ExampleLabel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ExampleLabel');
 inherited;
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ExampleLabel:push';
end;//Tkw_NewBaseSearch_Control_ExampleLabel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEditPanel.GetString: AnsiString;
begin
 Result := 'ContextEditPanel';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgNonVGLayout);
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEditPanel';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextEditPanel');
 inherited;
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEditPanel:push';
end;//Tkw_NewBaseSearch_Control_ContextEditPanel_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout1.GetString: AnsiString;
begin
 Result := 'Layout1';
end;//Tkw_NewBaseSearch_Control_Layout1.GetString

class procedure Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout1';
end;//Tkw_NewBaseSearch_Control_Layout1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout1');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout1:push';
end;//Tkw_NewBaseSearch_Control_Layout1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout2.GetString: AnsiString;
begin
 Result := 'Layout2';
end;//Tkw_NewBaseSearch_Control_Layout2.GetString

class procedure Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout2.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout2';
end;//Tkw_NewBaseSearch_Control_Layout2.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout2');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout2_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout2:push';
end;//Tkw_NewBaseSearch_Control_Layout2_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Layout3.GetString: AnsiString;
begin
 Result := 'Layout3';
end;//Tkw_NewBaseSearch_Control_Layout3.GetString

class procedure Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgLayout);
end;//Tkw_NewBaseSearch_Control_Layout3.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout3';
end;//Tkw_NewBaseSearch_Control_Layout3.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Layout3');
 inherited;
end;//Tkw_NewBaseSearch_Control_Layout3_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Layout3:push';
end;//Tkw_NewBaseSearch_Control_Layout3_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_vgScene1.GetString: AnsiString;
begin
 Result := 'vgScene1';
end;//Tkw_NewBaseSearch_Control_vgScene1.GetString

class procedure Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgScene);
end;//Tkw_NewBaseSearch_Control_vgScene1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vgScene1';
end;//Tkw_NewBaseSearch_Control_vgScene1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vgScene1');
 inherited;
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vgScene1:push';
end;//Tkw_NewBaseSearch_Control_vgScene1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MoreTab.GetString: AnsiString;
begin
 Result := 'MoreTab';
end;//Tkw_NewBaseSearch_Control_MoreTab.GetString

class procedure Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgComboBox);
end;//Tkw_NewBaseSearch_Control_MoreTab.RegisterInEngine

class function Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MoreTab';
end;//Tkw_NewBaseSearch_Control_MoreTab.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MoreTab');
 inherited;
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MoreTab:push';
end;//Tkw_NewBaseSearch_Control_MoreTab_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Border.GetString: AnsiString;
begin
 Result := 'Border';
end;//Tkw_NewBaseSearch_Control_Border.GetString

class procedure Tkw_NewBaseSearch_Control_Border.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_Border.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Border';
end;//Tkw_NewBaseSearch_Control_Border.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Border_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Border');
 inherited;
end;//Tkw_NewBaseSearch_Control_Border_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Border:push';
end;//Tkw_NewBaseSearch_Control_Border_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_InnerBorder.GetString: AnsiString;
begin
 Result := 'InnerBorder';
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetString

class procedure Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_InnerBorder.RegisterInEngine

class function Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBorder';
end;//Tkw_NewBaseSearch_Control_InnerBorder.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('InnerBorder');
 inherited;
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::InnerBorder:push';
end;//Tkw_NewBaseSearch_Control_InnerBorder_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString: AnsiString;
begin
 Result := 'MostOuterRectangle';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetString

class procedure Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.RegisterInEngine

class function Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MostOuterRectangle';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MostOuterRectangle');
 inherited;
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MostOuterRectangle:push';
end;//Tkw_NewBaseSearch_Control_MostOuterRectangle_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_Rectangle1.GetString: AnsiString;
begin
 Result := 'Rectangle1';
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetString

class procedure Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvgRectangle);
end;//Tkw_NewBaseSearch_Control_Rectangle1.RegisterInEngine

class function Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Rectangle1';
end;//Tkw_NewBaseSearch_Control_Rectangle1.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Rectangle1');
 inherited;
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Rectangle1:push';
end;//Tkw_NewBaseSearch_Control_Rectangle1_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Control_ContextEdit.GetString: AnsiString;
begin
 Result := 'ContextEdit';
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetString

class procedure Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeComboWithHistoryAndOperations);
end;//Tkw_NewBaseSearch_Control_ContextEdit.RegisterInEngine

class function Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEdit';
end;//Tkw_NewBaseSearch_Control_ContextEdit.GetWordNameForRegister

procedure Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextEdit');
 inherited;
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.DoDoIt

class function Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextEdit:push';
end;//Tkw_NewBaseSearch_Control_ContextEdit_Push.GetWordNameForRegister

function Tkw_NewBaseSearch_Component_FlashTimer.GetString: AnsiString;
begin
 Result := 'FlashTimer';
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetString

class procedure Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTimer);
end;//Tkw_NewBaseSearch_Component_FlashTimer.RegisterInEngine

class function Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::FlashTimer';
end;//Tkw_NewBaseSearch_Component_FlashTimer.GetWordNameForRegister

function TkwNewBaseSearchFormFindBtn.FindBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.FindBtn }
begin
 Result := aNewBaseSearchForm.FindBtn;
end;//TkwNewBaseSearchFormFindBtn.FindBtn

procedure TkwNewBaseSearchFormFindBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFindBtn.DoDoIt

procedure TkwNewBaseSearchFormFindBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FindBtn', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFindBtn.ParamsTypes

class function TkwNewBaseSearchFormFindBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBtn';
end;//TkwNewBaseSearchFormFindBtn.GetWordNameForRegister

function TkwNewBaseSearchFormFindBackBtn.FindBackBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgPathButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.FindBackBtn }
begin
 Result := aNewBaseSearchForm.FindBackBtn;
end;//TkwNewBaseSearchFormFindBackBtn.FindBackBtn

procedure TkwNewBaseSearchFormFindBackBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindBackBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFindBackBtn.DoDoIt

procedure TkwNewBaseSearchFormFindBackBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FindBackBtn', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFindBackBtn.ParamsTypes

class function TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FindBackBtn';
end;//TkwNewBaseSearchFormFindBackBtn.GetWordNameForRegister

function TkwNewBaseSearchFormCloseBtn.CloseBtn(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgCloseButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.CloseBtn }
begin
 Result := aNewBaseSearchForm.CloseBtn;
end;//TkwNewBaseSearchFormCloseBtn.CloseBtn

procedure TkwNewBaseSearchFormCloseBtn.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseBtn(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormCloseBtn.DoDoIt

procedure TkwNewBaseSearchFormCloseBtn.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CloseBtn', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormCloseBtn.ParamsTypes

class function TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.CloseBtn';
end;//TkwNewBaseSearchFormCloseBtn.GetWordNameForRegister

function TkwNewBaseSearchFormAreaCombo.AreaCombo(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* Реализация слова скрипта .TNewBaseSearchForm.AreaCombo }
begin
 Result := aNewBaseSearchForm.AreaCombo;
end;//TkwNewBaseSearchFormAreaCombo.AreaCombo

procedure TkwNewBaseSearchFormAreaCombo.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AreaCombo(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormAreaCombo.DoDoIt

procedure TkwNewBaseSearchFormAreaCombo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству AreaCombo', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormAreaCombo.ParamsTypes

class function TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.AreaCombo';
end;//TkwNewBaseSearchFormAreaCombo.GetWordNameForRegister

function TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.QueryExampleLabel }
begin
 Result := aNewBaseSearchForm.QueryExampleLabel;
end;//TkwNewBaseSearchFormQueryExampleLabel.QueryExampleLabel

procedure TkwNewBaseSearchFormQueryExampleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(QueryExampleLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormQueryExampleLabel.DoDoIt

procedure TkwNewBaseSearchFormQueryExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству QueryExampleLabel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormQueryExampleLabel.ParamsTypes

class function TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.QueryExampleLabel';
end;//TkwNewBaseSearchFormQueryExampleLabel.GetWordNameForRegister

function TkwNewBaseSearchFormDropButton.DropButton(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgButton;
 {* Реализация слова скрипта .TNewBaseSearchForm.DropButton }
begin
 Result := aNewBaseSearchForm.DropButton;
end;//TkwNewBaseSearchFormDropButton.DropButton

procedure TkwNewBaseSearchFormDropButton.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DropButton(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormDropButton.DoDoIt

procedure TkwNewBaseSearchFormDropButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DropButton', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormDropButton.ParamsTypes

class function TkwNewBaseSearchFormDropButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.DropButton';
end;//TkwNewBaseSearchFormDropButton.GetWordNameForRegister

function TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.FoundCountLabel }
begin
 Result := aNewBaseSearchForm.FoundCountLabel;
end;//TkwNewBaseSearchFormFoundCountLabel.FoundCountLabel

procedure TkwNewBaseSearchFormFoundCountLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FoundCountLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFoundCountLabel.DoDoIt

procedure TkwNewBaseSearchFormFoundCountLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FoundCountLabel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFoundCountLabel.ParamsTypes

class function TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FoundCountLabel';
end;//TkwNewBaseSearchFormFoundCountLabel.GetWordNameForRegister

function TkwNewBaseSearchFormExampleLabel.ExampleLabel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgText;
 {* Реализация слова скрипта .TNewBaseSearchForm.ExampleLabel }
begin
 Result := aNewBaseSearchForm.ExampleLabel;
end;//TkwNewBaseSearchFormExampleLabel.ExampleLabel

procedure TkwNewBaseSearchFormExampleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ExampleLabel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormExampleLabel.DoDoIt

procedure TkwNewBaseSearchFormExampleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ExampleLabel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormExampleLabel.ParamsTypes

class function TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ExampleLabel';
end;//TkwNewBaseSearchFormExampleLabel.GetWordNameForRegister

function TkwNewBaseSearchFormContextEditPanel.ContextEditPanel(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgNonVGLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.ContextEditPanel }
begin
 Result := aNewBaseSearchForm.ContextEditPanel;
end;//TkwNewBaseSearchFormContextEditPanel.ContextEditPanel

procedure TkwNewBaseSearchFormContextEditPanel.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextEditPanel(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormContextEditPanel.DoDoIt

procedure TkwNewBaseSearchFormContextEditPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextEditPanel', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormContextEditPanel.ParamsTypes

class function TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEditPanel';
end;//TkwNewBaseSearchFormContextEditPanel.GetWordNameForRegister

function TkwNewBaseSearchFormLayout1.Layout1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout1 }
begin
 Result := aNewBaseSearchForm.Layout1;
end;//TkwNewBaseSearchFormLayout1.Layout1

procedure TkwNewBaseSearchFormLayout1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout1.DoDoIt

procedure TkwNewBaseSearchFormLayout1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Layout1', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout1.ParamsTypes

class function TkwNewBaseSearchFormLayout1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout1';
end;//TkwNewBaseSearchFormLayout1.GetWordNameForRegister

function TkwNewBaseSearchFormLayout2.Layout2(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout2 }
begin
 Result := aNewBaseSearchForm.Layout2;
end;//TkwNewBaseSearchFormLayout2.Layout2

procedure TkwNewBaseSearchFormLayout2.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout2(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout2.DoDoIt

procedure TkwNewBaseSearchFormLayout2.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Layout2', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout2.ParamsTypes

class function TkwNewBaseSearchFormLayout2.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout2';
end;//TkwNewBaseSearchFormLayout2.GetWordNameForRegister

function TkwNewBaseSearchFormLayout3.Layout3(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgLayout;
 {* Реализация слова скрипта .TNewBaseSearchForm.Layout3 }
begin
 Result := aNewBaseSearchForm.Layout3;
end;//TkwNewBaseSearchFormLayout3.Layout3

procedure TkwNewBaseSearchFormLayout3.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Layout3(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormLayout3.DoDoIt

procedure TkwNewBaseSearchFormLayout3.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Layout3', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormLayout3.ParamsTypes

class function TkwNewBaseSearchFormLayout3.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Layout3';
end;//TkwNewBaseSearchFormLayout3.GetWordNameForRegister

function TkwNewBaseSearchFormVgScene1.vgScene1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgScene;
 {* Реализация слова скрипта .TNewBaseSearchForm.vgScene1 }
begin
 Result := aNewBaseSearchForm.vgScene1;
end;//TkwNewBaseSearchFormVgScene1.vgScene1

procedure TkwNewBaseSearchFormVgScene1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vgScene1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormVgScene1.DoDoIt

procedure TkwNewBaseSearchFormVgScene1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vgScene1', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormVgScene1.ParamsTypes

class function TkwNewBaseSearchFormVgScene1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.vgScene1';
end;//TkwNewBaseSearchFormVgScene1.GetWordNameForRegister

function TkwNewBaseSearchFormMoreTab.MoreTab(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgComboBox;
 {* Реализация слова скрипта .TNewBaseSearchForm.MoreTab }
begin
 Result := aNewBaseSearchForm.MoreTab;
end;//TkwNewBaseSearchFormMoreTab.MoreTab

procedure TkwNewBaseSearchFormMoreTab.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MoreTab(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormMoreTab.DoDoIt

procedure TkwNewBaseSearchFormMoreTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MoreTab', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormMoreTab.ParamsTypes

class function TkwNewBaseSearchFormMoreTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MoreTab';
end;//TkwNewBaseSearchFormMoreTab.GetWordNameForRegister

function TkwNewBaseSearchFormBorder.Border(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.Border }
begin
 Result := aNewBaseSearchForm.Border;
end;//TkwNewBaseSearchFormBorder.Border

procedure TkwNewBaseSearchFormBorder.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Border(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormBorder.DoDoIt

procedure TkwNewBaseSearchFormBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Border', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormBorder.ParamsTypes

class function TkwNewBaseSearchFormBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Border';
end;//TkwNewBaseSearchFormBorder.GetWordNameForRegister

function TkwNewBaseSearchFormInnerBorder.InnerBorder(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.InnerBorder }
begin
 Result := aNewBaseSearchForm.InnerBorder;
end;//TkwNewBaseSearchFormInnerBorder.InnerBorder

procedure TkwNewBaseSearchFormInnerBorder.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(InnerBorder(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormInnerBorder.DoDoIt

procedure TkwNewBaseSearchFormInnerBorder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству InnerBorder', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormInnerBorder.ParamsTypes

class function TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.InnerBorder';
end;//TkwNewBaseSearchFormInnerBorder.GetWordNameForRegister

function TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.MostOuterRectangle }
begin
 Result := aNewBaseSearchForm.MostOuterRectangle;
end;//TkwNewBaseSearchFormMostOuterRectangle.MostOuterRectangle

procedure TkwNewBaseSearchFormMostOuterRectangle.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MostOuterRectangle(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormMostOuterRectangle.DoDoIt

procedure TkwNewBaseSearchFormMostOuterRectangle.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MostOuterRectangle', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormMostOuterRectangle.ParamsTypes

class function TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.MostOuterRectangle';
end;//TkwNewBaseSearchFormMostOuterRectangle.GetWordNameForRegister

function TkwNewBaseSearchFormRectangle1.Rectangle1(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TvgRectangle;
 {* Реализация слова скрипта .TNewBaseSearchForm.Rectangle1 }
begin
 Result := aNewBaseSearchForm.Rectangle1;
end;//TkwNewBaseSearchFormRectangle1.Rectangle1

procedure TkwNewBaseSearchFormRectangle1.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Rectangle1(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormRectangle1.DoDoIt

procedure TkwNewBaseSearchFormRectangle1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Rectangle1', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormRectangle1.ParamsTypes

class function TkwNewBaseSearchFormRectangle1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.Rectangle1';
end;//TkwNewBaseSearchFormRectangle1.GetWordNameForRegister

function TkwNewBaseSearchFormContextEdit.ContextEdit(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TnscTreeComboWithHistoryAndOperations;
 {* Реализация слова скрипта .TNewBaseSearchForm.ContextEdit }
begin
 Result := aNewBaseSearchForm.ContextEdit;
end;//TkwNewBaseSearchFormContextEdit.ContextEdit

procedure TkwNewBaseSearchFormContextEdit.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextEdit(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormContextEdit.DoDoIt

procedure TkwNewBaseSearchFormContextEdit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextEdit', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormContextEdit.ParamsTypes

class function TkwNewBaseSearchFormContextEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.ContextEdit';
end;//TkwNewBaseSearchFormContextEdit.GetWordNameForRegister

function TkwNewBaseSearchFormFlashTimer.FlashTimer(const aCtx: TtfwContext;
 aNewBaseSearchForm: TNewBaseSearchForm): TTimer;
 {* Реализация слова скрипта .TNewBaseSearchForm.FlashTimer }
begin
 Result := aNewBaseSearchForm.FlashTimer;
end;//TkwNewBaseSearchFormFlashTimer.FlashTimer

procedure TkwNewBaseSearchFormFlashTimer.DoDoIt(const aCtx: TtfwContext);
var l_aNewBaseSearchForm: TNewBaseSearchForm;
begin
 try
  l_aNewBaseSearchForm := TNewBaseSearchForm(aCtx.rEngine.PopObjAs(TNewBaseSearchForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewBaseSearchForm: TNewBaseSearchForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FlashTimer(aCtx, l_aNewBaseSearchForm));
end;//TkwNewBaseSearchFormFlashTimer.DoDoIt

procedure TkwNewBaseSearchFormFlashTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству FlashTimer', aCtx);
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
 Result := OpenTypesToTypes([TypeInfo(TNewBaseSearchForm)]);
end;//TkwNewBaseSearchFormFlashTimer.ParamsTypes

class function TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TNewBaseSearchForm.FlashTimer';
end;//TkwNewBaseSearchFormFlashTimer.GetWordNameForRegister

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
