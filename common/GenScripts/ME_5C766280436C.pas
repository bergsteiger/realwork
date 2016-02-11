unit AACContentsContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AACContentsContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACContentsContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , AACPrim_Module
 , vtProportionalPanel
 , vtPanel
 , vtScrollBar
 , vtSizeablePanel
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
 Tkw_Form_AACContentsContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AACContentsContainer
----
*Пример использования*:
[code]
'aControl' форма::AACContentsContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AACContentsContainer

 Tkw_AACContentsContainer_Control_pnBack = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnBack

 Tkw_AACContentsContainer_Control_pnBack_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnBack_Push

 Tkw_AACContentsContainer_Control_pnRightEx = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnRightEx
----
*Пример использования*:
[code]
контрол::pnRightEx TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnRightEx

 Tkw_AACContentsContainer_Control_pnRightEx_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRightEx
----
*Пример использования*:
[code]
контрол::pnRightEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightEx_Push

 Tkw_AACContentsContainer_Control_pnRightForScroll = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnRightForScroll
----
*Пример использования*:
[code]
контрол::pnRightForScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnRightForScroll

 Tkw_AACContentsContainer_Control_pnRightForScroll_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRightForScroll
----
*Пример использования*:
[code]
контрол::pnRightForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push

 Tkw_AACContentsContainer_Control_pnRight = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnRight

 Tkw_AACContentsContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRight_Push

 Tkw_AACContentsContainer_Control_pnlRightTop = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlRightTop
----
*Пример использования*:
[code]
контрол::pnlRightTop TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnlRightTop

 Tkw_AACContentsContainer_Control_pnlRightTop_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlRightTop
----
*Пример использования*:
[code]
контрол::pnlRightTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push

 Tkw_AACContentsContainer_Control_scrRight = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола scrRight
----
*Пример использования*:
[code]
контрол::scrRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_scrRight

 Tkw_AACContentsContainer_Control_scrRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола scrRight
----
*Пример использования*:
[code]
контрол::scrRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrRight_Push

 Tkw_AACContentsContainer_Control_pnLeftEx = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLeftEx
----
*Пример использования*:
[code]
контрол::pnLeftEx TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftEx

 Tkw_AACContentsContainer_Control_pnLeftEx_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeftEx
----
*Пример использования*:
[code]
контрол::pnLeftEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push

 Tkw_AACContentsContainer_Control_pnLeftForScroll = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLeftForScroll
----
*Пример использования*:
[code]
контрол::pnLeftForScroll TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftForScroll

 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeftForScroll
----
*Пример использования*:
[code]
контрол::pnLeftForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push

 Tkw_AACContentsContainer_Control_pnlLeftTop = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlLeftTop
----
*Пример использования*:
[code]
контрол::pnlLeftTop TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnlLeftTop

 Tkw_AACContentsContainer_Control_pnlLeftTop_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlLeftTop
----
*Пример использования*:
[code]
контрол::pnlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push

 Tkw_AACContentsContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_pnLeft

 Tkw_AACContentsContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeft_Push

 Tkw_AACContentsContainer_Control_scrLeft = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола scrLeft
----
*Пример использования*:
[code]
контрол::scrLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContentsContainer_Control_scrLeft

 Tkw_AACContentsContainer_Control_scrLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола scrLeft
----
*Пример использования*:
[code]
контрол::scrLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrLeft_Push

 TkwAACContentsContainerFormPnBack = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnBack
[panel]Контрол pnBack формы TAACContentsContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnBack >>> l_TvtProportionalPanel
[code]  }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnBack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnBack

 TkwAACContentsContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRightEx
[panel]Контрол pnRightEx формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRightEx >>> l_TvtPanel
[code]  }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRightEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnRightEx

 TkwAACContentsContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRightForScroll
[panel]Контрол pnRightForScroll формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRightForScroll >>> l_TvtPanel
[code]  }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRightForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnRightForScroll

 TkwAACContentsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRight
[panel]Контрол pnRight формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnRight

 TkwAACContentsContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnlRightTop
[panel]Контрол pnlRightTop формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnlRightTop >>> l_TvtPanel
[code]  }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnlRightTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnlRightTop

 TkwAACContentsContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.scrRight
[panel]Контрол scrRight формы TAACContentsContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContentsContainerForm .TAACContentsContainerForm.scrRight >>> l_TvtScrollBar
[code]  }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContentsContainerForm.scrRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormScrRight

 TkwAACContentsContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeftEx
[panel]Контрол pnLeftEx формы TAACContentsContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeftEx >>> l_TvtSizeablePanel
[code]  }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnLeftEx

 TkwAACContentsContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeftForScroll
[panel]Контрол pnLeftForScroll формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeftForScroll >>> l_TvtPanel
[code]  }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnLeftForScroll

 TkwAACContentsContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnlLeftTop
[panel]Контрол pnlLeftTop формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnlLeftTop >>> l_TvtPanel
[code]  }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnlLeftTop

 TkwAACContentsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeft
[panel]Контрол pnLeft формы TAACContentsContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContentsContainerForm .TAACContentsContainerForm.pnLeft >>> l_TvtPanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormPnLeft

 TkwAACContentsContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.scrLeft
[panel]Контрол scrLeft формы TAACContentsContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContentsContainerForm .TAACContentsContainerForm.scrLeft >>> l_TvtScrollBar
[code]  }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContentsContainerForm.scrLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContentsContainerFormScrLeft

class function Tkw_Form_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AACContentsContainer';
end;//Tkw_Form_AACContentsContainer.GetWordNameForRegister

function Tkw_Form_AACContentsContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9798BE93BB6A_var*
//#UC END# *4DDFD2EA0116_9798BE93BB6A_var*
begin
//#UC START# *4DDFD2EA0116_9798BE93BB6A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9798BE93BB6A_impl*
end;//Tkw_Form_AACContentsContainer.GetString

class function Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnBack.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8780061BFCCC_var*
//#UC END# *4DDFD2EA0116_8780061BFCCC_var*
begin
//#UC START# *4DDFD2EA0116_8780061BFCCC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8780061BFCCC_impl*
end;//Tkw_AACContentsContainer_Control_pnBack.GetString

class procedure Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
//#UC START# *52A086150180_8780061BFCCC_var*
//#UC END# *52A086150180_8780061BFCCC_var*
begin
//#UC START# *52A086150180_8780061BFCCC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8780061BFCCC_impl*
end;//Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D593F70F255_var*
//#UC END# *4DAEEDE10285_2D593F70F255_var*
begin
//#UC START# *4DAEEDE10285_2D593F70F255_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D593F70F255_impl*
end;//Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack:push';
end;//Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightEx.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EB9599D1DA76_var*
//#UC END# *4DDFD2EA0116_EB9599D1DA76_var*
begin
//#UC START# *4DDFD2EA0116_EB9599D1DA76_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EB9599D1DA76_impl*
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
//#UC START# *52A086150180_EB9599D1DA76_var*
//#UC END# *52A086150180_EB9599D1DA76_var*
begin
//#UC START# *52A086150180_EB9599D1DA76_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EB9599D1DA76_impl*
end;//Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_210BB187712A_var*
//#UC END# *4DAEEDE10285_210BB187712A_var*
begin
//#UC START# *4DAEEDE10285_210BB187712A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_210BB187712A_impl*
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx:push';
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightForScroll.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2B811DE078C0_var*
//#UC END# *4DDFD2EA0116_2B811DE078C0_var*
begin
//#UC START# *4DDFD2EA0116_2B811DE078C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2B811DE078C0_impl*
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
//#UC START# *52A086150180_2B811DE078C0_var*
//#UC END# *52A086150180_2B811DE078C0_var*
begin
//#UC START# *52A086150180_2B811DE078C0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2B811DE078C0_impl*
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5E53106365BD_var*
//#UC END# *4DAEEDE10285_5E53106365BD_var*
begin
//#UC START# *4DAEEDE10285_5E53106365BD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5E53106365BD_impl*
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D5E086721A8A_var*
//#UC END# *4DDFD2EA0116_D5E086721A8A_var*
begin
//#UC START# *4DDFD2EA0116_D5E086721A8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D5E086721A8A_impl*
end;//Tkw_AACContentsContainer_Control_pnRight.GetString

class procedure Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
//#UC START# *52A086150180_D5E086721A8A_var*
//#UC END# *52A086150180_D5E086721A8A_var*
begin
//#UC START# *52A086150180_D5E086721A8A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D5E086721A8A_impl*
end;//Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A04CA39FCC34_var*
//#UC END# *4DAEEDE10285_A04CA39FCC34_var*
begin
//#UC START# *4DAEEDE10285_A04CA39FCC34_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A04CA39FCC34_impl*
end;//Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlRightTop.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3AD0CAD4EBC6_var*
//#UC END# *4DDFD2EA0116_3AD0CAD4EBC6_var*
begin
//#UC START# *4DDFD2EA0116_3AD0CAD4EBC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3AD0CAD4EBC6_impl*
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
//#UC START# *52A086150180_3AD0CAD4EBC6_var*
//#UC END# *52A086150180_3AD0CAD4EBC6_var*
begin
//#UC START# *52A086150180_3AD0CAD4EBC6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3AD0CAD4EBC6_impl*
end;//Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_935FA73F2EC8_var*
//#UC END# *4DAEEDE10285_935FA73F2EC8_var*
begin
//#UC START# *4DAEEDE10285_935FA73F2EC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_935FA73F2EC8_impl*
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop:push';
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CF484D939418_var*
//#UC END# *4DDFD2EA0116_CF484D939418_var*
begin
//#UC START# *4DDFD2EA0116_CF484D939418_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CF484D939418_impl*
end;//Tkw_AACContentsContainer_Control_scrRight.GetString

class procedure Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
//#UC START# *52A086150180_CF484D939418_var*
//#UC END# *52A086150180_CF484D939418_var*
begin
//#UC START# *52A086150180_CF484D939418_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CF484D939418_impl*
end;//Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D45F13B11DD_var*
//#UC END# *4DAEEDE10285_2D45F13B11DD_var*
begin
//#UC START# *4DAEEDE10285_2D45F13B11DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D45F13B11DD_impl*
end;//Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight:push';
end;//Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftEx.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5F1D233B7261_var*
//#UC END# *4DDFD2EA0116_5F1D233B7261_var*
begin
//#UC START# *4DDFD2EA0116_5F1D233B7261_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5F1D233B7261_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
//#UC START# *52A086150180_5F1D233B7261_var*
//#UC END# *52A086150180_5F1D233B7261_var*
begin
//#UC START# *52A086150180_5F1D233B7261_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5F1D233B7261_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8513EF9E2504_var*
//#UC END# *4DAEEDE10285_8513EF9E2504_var*
begin
//#UC START# *4DAEEDE10285_8513EF9E2504_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8513EF9E2504_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx:push';
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7DE661DD02E0_var*
//#UC END# *4DDFD2EA0116_7DE661DD02E0_var*
begin
//#UC START# *4DDFD2EA0116_7DE661DD02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7DE661DD02E0_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
//#UC START# *52A086150180_7DE661DD02E0_var*
//#UC END# *52A086150180_7DE661DD02E0_var*
begin
//#UC START# *52A086150180_7DE661DD02E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7DE661DD02E0_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7A90F0C374B3_var*
//#UC END# *4DAEEDE10285_7A90F0C374B3_var*
begin
//#UC START# *4DAEEDE10285_7A90F0C374B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7A90F0C374B3_impl*
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlLeftTop.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C6E19C62670B_var*
//#UC END# *4DDFD2EA0116_C6E19C62670B_var*
begin
//#UC START# *4DDFD2EA0116_C6E19C62670B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C6E19C62670B_impl*
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
//#UC START# *52A086150180_C6E19C62670B_var*
//#UC END# *52A086150180_C6E19C62670B_var*
begin
//#UC START# *52A086150180_C6E19C62670B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C6E19C62670B_impl*
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4ADC3266525D_var*
//#UC END# *4DAEEDE10285_4ADC3266525D_var*
begin
//#UC START# *4DAEEDE10285_4ADC3266525D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4ADC3266525D_impl*
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop:push';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4867954E723D_var*
//#UC END# *4DDFD2EA0116_4867954E723D_var*
begin
//#UC START# *4DDFD2EA0116_4867954E723D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4867954E723D_impl*
end;//Tkw_AACContentsContainer_Control_pnLeft.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
//#UC START# *52A086150180_4867954E723D_var*
//#UC END# *52A086150180_4867954E723D_var*
begin
//#UC START# *52A086150180_4867954E723D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4867954E723D_impl*
end;//Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D34290F1ED03_var*
//#UC END# *4DAEEDE10285_D34290F1ED03_var*
begin
//#UC START# *4DAEEDE10285_D34290F1ED03_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D34290F1ED03_impl*
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3FA21A0346D0_var*
//#UC END# *4DDFD2EA0116_3FA21A0346D0_var*
begin
//#UC START# *4DDFD2EA0116_3FA21A0346D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3FA21A0346D0_impl*
end;//Tkw_AACContentsContainer_Control_scrLeft.GetString

class procedure Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
//#UC START# *52A086150180_3FA21A0346D0_var*
//#UC END# *52A086150180_3FA21A0346D0_var*
begin
//#UC START# *52A086150180_3FA21A0346D0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3FA21A0346D0_impl*
end;//Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine

procedure Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F4DD37609FDA_var*
//#UC END# *4DAEEDE10285_F4DD37609FDA_var*
begin
//#UC START# *4DAEEDE10285_F4DD37609FDA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F4DD37609FDA_impl*
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft:push';
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister

function TkwAACContentsContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnBack }
//#UC START# *7D5A2B19D72C_263DE971DEE2_var*
//#UC END# *7D5A2B19D72C_263DE971DEE2_var*
begin
//#UC START# *7D5A2B19D72C_263DE971DEE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *7D5A2B19D72C_263DE971DEE2_impl*
end;//TkwAACContentsContainerFormPnBack.pnBack

procedure TkwAACContentsContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_263DE971DEE2_var*
//#UC END# *4DAEEDE10285_263DE971DEE2_var*
begin
//#UC START# *4DAEEDE10285_263DE971DEE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_263DE971DEE2_impl*
end;//TkwAACContentsContainerFormPnBack.DoDoIt

class function TkwAACContentsContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnBack';
end;//TkwAACContentsContainerFormPnBack.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_263DE971DEE2_var*
//#UC END# *52D00B00031A_263DE971DEE2_var*
begin
//#UC START# *52D00B00031A_263DE971DEE2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_263DE971DEE2_impl*
end;//TkwAACContentsContainerFormPnBack.SetValuePrim

function TkwAACContentsContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContentsContainerFormPnBack.GetResultTypeInfo

function TkwAACContentsContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnBack.GetAllParamsCount

function TkwAACContentsContainerFormPnBack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnBack.ParamsTypes

function TkwAACContentsContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRightEx }
//#UC START# *068ADC59DF1C_AEF24D4E3600_var*
//#UC END# *068ADC59DF1C_AEF24D4E3600_var*
begin
//#UC START# *068ADC59DF1C_AEF24D4E3600_impl*
 !!! Needs to be implemented !!!
//#UC END# *068ADC59DF1C_AEF24D4E3600_impl*
end;//TkwAACContentsContainerFormPnRightEx.pnRightEx

procedure TkwAACContentsContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AEF24D4E3600_var*
//#UC END# *4DAEEDE10285_AEF24D4E3600_var*
begin
//#UC START# *4DAEEDE10285_AEF24D4E3600_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AEF24D4E3600_impl*
end;//TkwAACContentsContainerFormPnRightEx.DoDoIt

class function TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightEx';
end;//TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AEF24D4E3600_var*
//#UC END# *52D00B00031A_AEF24D4E3600_var*
begin
//#UC START# *52D00B00031A_AEF24D4E3600_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AEF24D4E3600_impl*
end;//TkwAACContentsContainerFormPnRightEx.SetValuePrim

function TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRightEx.GetAllParamsCount

function TkwAACContentsContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnRightEx.ParamsTypes

function TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRightForScroll }
//#UC START# *A5C62B9F596B_237FDDF0A879_var*
//#UC END# *A5C62B9F596B_237FDDF0A879_var*
begin
//#UC START# *A5C62B9F596B_237FDDF0A879_impl*
 !!! Needs to be implemented !!!
//#UC END# *A5C62B9F596B_237FDDF0A879_impl*
end;//TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll

procedure TkwAACContentsContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_237FDDF0A879_var*
//#UC END# *4DAEEDE10285_237FDDF0A879_var*
begin
//#UC START# *4DAEEDE10285_237FDDF0A879_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_237FDDF0A879_impl*
end;//TkwAACContentsContainerFormPnRightForScroll.DoDoIt

class function TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightForScroll';
end;//TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_237FDDF0A879_var*
//#UC END# *52D00B00031A_237FDDF0A879_var*
begin
//#UC START# *52D00B00031A_237FDDF0A879_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_237FDDF0A879_impl*
end;//TkwAACContentsContainerFormPnRightForScroll.SetValuePrim

function TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnRightForScroll.ParamsTypes

function TkwAACContentsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRight }
//#UC START# *85B65A82E442_751A50BCF486_var*
//#UC END# *85B65A82E442_751A50BCF486_var*
begin
//#UC START# *85B65A82E442_751A50BCF486_impl*
 !!! Needs to be implemented !!!
//#UC END# *85B65A82E442_751A50BCF486_impl*
end;//TkwAACContentsContainerFormPnRight.pnRight

procedure TkwAACContentsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_751A50BCF486_var*
//#UC END# *4DAEEDE10285_751A50BCF486_var*
begin
//#UC START# *4DAEEDE10285_751A50BCF486_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_751A50BCF486_impl*
end;//TkwAACContentsContainerFormPnRight.DoDoIt

class function TkwAACContentsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRight';
end;//TkwAACContentsContainerFormPnRight.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_751A50BCF486_var*
//#UC END# *52D00B00031A_751A50BCF486_var*
begin
//#UC START# *52D00B00031A_751A50BCF486_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_751A50BCF486_impl*
end;//TkwAACContentsContainerFormPnRight.SetValuePrim

function TkwAACContentsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnRight.GetResultTypeInfo

function TkwAACContentsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnRight.GetAllParamsCount

function TkwAACContentsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnRight.ParamsTypes

function TkwAACContentsContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnlRightTop }
//#UC START# *3BFCB42754FA_9B01FD076314_var*
//#UC END# *3BFCB42754FA_9B01FD076314_var*
begin
//#UC START# *3BFCB42754FA_9B01FD076314_impl*
 !!! Needs to be implemented !!!
//#UC END# *3BFCB42754FA_9B01FD076314_impl*
end;//TkwAACContentsContainerFormPnlRightTop.pnlRightTop

procedure TkwAACContentsContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9B01FD076314_var*
//#UC END# *4DAEEDE10285_9B01FD076314_var*
begin
//#UC START# *4DAEEDE10285_9B01FD076314_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9B01FD076314_impl*
end;//TkwAACContentsContainerFormPnlRightTop.DoDoIt

class function TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlRightTop';
end;//TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9B01FD076314_var*
//#UC END# *52D00B00031A_9B01FD076314_var*
begin
//#UC START# *52D00B00031A_9B01FD076314_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9B01FD076314_impl*
end;//TkwAACContentsContainerFormPnlRightTop.SetValuePrim

function TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnlRightTop.ParamsTypes

function TkwAACContentsContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContentsContainerForm.scrRight }
//#UC START# *4AA4C107FC4F_1C783FC526FD_var*
//#UC END# *4AA4C107FC4F_1C783FC526FD_var*
begin
//#UC START# *4AA4C107FC4F_1C783FC526FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4AA4C107FC4F_1C783FC526FD_impl*
end;//TkwAACContentsContainerFormScrRight.scrRight

procedure TkwAACContentsContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C783FC526FD_var*
//#UC END# *4DAEEDE10285_1C783FC526FD_var*
begin
//#UC START# *4DAEEDE10285_1C783FC526FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C783FC526FD_impl*
end;//TkwAACContentsContainerFormScrRight.DoDoIt

class function TkwAACContentsContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrRight';
end;//TkwAACContentsContainerFormScrRight.GetWordNameForRegister

procedure TkwAACContentsContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1C783FC526FD_var*
//#UC END# *52D00B00031A_1C783FC526FD_var*
begin
//#UC START# *52D00B00031A_1C783FC526FD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1C783FC526FD_impl*
end;//TkwAACContentsContainerFormScrRight.SetValuePrim

function TkwAACContentsContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrRight.GetResultTypeInfo

function TkwAACContentsContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormScrRight.GetAllParamsCount

function TkwAACContentsContainerFormScrRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormScrRight.ParamsTypes

function TkwAACContentsContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftEx }
//#UC START# *23099BB8B6B1_D8CD8423C7D6_var*
//#UC END# *23099BB8B6B1_D8CD8423C7D6_var*
begin
//#UC START# *23099BB8B6B1_D8CD8423C7D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *23099BB8B6B1_D8CD8423C7D6_impl*
end;//TkwAACContentsContainerFormPnLeftEx.pnLeftEx

procedure TkwAACContentsContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D8CD8423C7D6_var*
//#UC END# *4DAEEDE10285_D8CD8423C7D6_var*
begin
//#UC START# *4DAEEDE10285_D8CD8423C7D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D8CD8423C7D6_impl*
end;//TkwAACContentsContainerFormPnLeftEx.DoDoIt

class function TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftEx';
end;//TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D8CD8423C7D6_var*
//#UC END# *52D00B00031A_D8CD8423C7D6_var*
begin
//#UC START# *52D00B00031A_D8CD8423C7D6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D8CD8423C7D6_impl*
end;//TkwAACContentsContainerFormPnLeftEx.SetValuePrim

function TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContentsContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnLeftEx.ParamsTypes

function TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftForScroll }
//#UC START# *50EE90D2EA95_92C6BC5BF215_var*
//#UC END# *50EE90D2EA95_92C6BC5BF215_var*
begin
//#UC START# *50EE90D2EA95_92C6BC5BF215_impl*
 !!! Needs to be implemented !!!
//#UC END# *50EE90D2EA95_92C6BC5BF215_impl*
end;//TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll

procedure TkwAACContentsContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_92C6BC5BF215_var*
//#UC END# *4DAEEDE10285_92C6BC5BF215_var*
begin
//#UC START# *4DAEEDE10285_92C6BC5BF215_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_92C6BC5BF215_impl*
end;//TkwAACContentsContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftForScroll';
end;//TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_92C6BC5BF215_var*
//#UC END# *52D00B00031A_92C6BC5BF215_var*
begin
//#UC START# *52D00B00031A_92C6BC5BF215_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_92C6BC5BF215_impl*
end;//TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes

function TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnlLeftTop }
//#UC START# *4F954FC94A91_6C790E5B3DE3_var*
//#UC END# *4F954FC94A91_6C790E5B3DE3_var*
begin
//#UC START# *4F954FC94A91_6C790E5B3DE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F954FC94A91_6C790E5B3DE3_impl*
end;//TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop

procedure TkwAACContentsContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6C790E5B3DE3_var*
//#UC END# *4DAEEDE10285_6C790E5B3DE3_var*
begin
//#UC START# *4DAEEDE10285_6C790E5B3DE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6C790E5B3DE3_impl*
end;//TkwAACContentsContainerFormPnlLeftTop.DoDoIt

class function TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlLeftTop';
end;//TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6C790E5B3DE3_var*
//#UC END# *52D00B00031A_6C790E5B3DE3_var*
begin
//#UC START# *52D00B00031A_6C790E5B3DE3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6C790E5B3DE3_impl*
end;//TkwAACContentsContainerFormPnlLeftTop.SetValuePrim

function TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContentsContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnlLeftTop.ParamsTypes

function TkwAACContentsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeft }
//#UC START# *DA8D627BC367_8D6BA41415C4_var*
//#UC END# *DA8D627BC367_8D6BA41415C4_var*
begin
//#UC START# *DA8D627BC367_8D6BA41415C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA8D627BC367_8D6BA41415C4_impl*
end;//TkwAACContentsContainerFormPnLeft.pnLeft

procedure TkwAACContentsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8D6BA41415C4_var*
//#UC END# *4DAEEDE10285_8D6BA41415C4_var*
begin
//#UC START# *4DAEEDE10285_8D6BA41415C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8D6BA41415C4_impl*
end;//TkwAACContentsContainerFormPnLeft.DoDoIt

class function TkwAACContentsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeft';
end;//TkwAACContentsContainerFormPnLeft.GetWordNameForRegister

procedure TkwAACContentsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8D6BA41415C4_var*
//#UC END# *52D00B00031A_8D6BA41415C4_var*
begin
//#UC START# *52D00B00031A_8D6BA41415C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8D6BA41415C4_impl*
end;//TkwAACContentsContainerFormPnLeft.SetValuePrim

function TkwAACContentsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContentsContainerFormPnLeft.GetResultTypeInfo

function TkwAACContentsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormPnLeft.GetAllParamsCount

function TkwAACContentsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormPnLeft.ParamsTypes

function TkwAACContentsContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContentsContainerForm.scrLeft }
//#UC START# *9C36D0072BAE_F1BCB862CA6F_var*
//#UC END# *9C36D0072BAE_F1BCB862CA6F_var*
begin
//#UC START# *9C36D0072BAE_F1BCB862CA6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *9C36D0072BAE_F1BCB862CA6F_impl*
end;//TkwAACContentsContainerFormScrLeft.scrLeft

procedure TkwAACContentsContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F1BCB862CA6F_var*
//#UC END# *4DAEEDE10285_F1BCB862CA6F_var*
begin
//#UC START# *4DAEEDE10285_F1BCB862CA6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F1BCB862CA6F_impl*
end;//TkwAACContentsContainerFormScrLeft.DoDoIt

class function TkwAACContentsContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrLeft';
end;//TkwAACContentsContainerFormScrLeft.GetWordNameForRegister

procedure TkwAACContentsContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F1BCB862CA6F_var*
//#UC END# *52D00B00031A_F1BCB862CA6F_var*
begin
//#UC START# *52D00B00031A_F1BCB862CA6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F1BCB862CA6F_impl*
end;//TkwAACContentsContainerFormScrLeft.SetValuePrim

function TkwAACContentsContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContentsContainerFormScrLeft.GetResultTypeInfo

function TkwAACContentsContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContentsContainerFormScrLeft.GetAllParamsCount

function TkwAACContentsContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAACContentsContainerFormScrLeft.ParamsTypes

initialization
 Tkw_Form_AACContentsContainer.RegisterInEngine;
 {* Регистрация Tkw_Form_AACContentsContainer }
 Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnBack }
 Tkw_AACContentsContainer_Control_pnBack_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnBack_Push }
 Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRightEx }
 Tkw_AACContentsContainer_Control_pnRightEx_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRightEx_Push }
 Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRightForScroll }
 Tkw_AACContentsContainer_Control_pnRightForScroll_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRightForScroll_Push }
 Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRight }
 Tkw_AACContentsContainer_Control_pnRight_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnRight_Push }
 Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnlRightTop }
 Tkw_AACContentsContainer_Control_pnlRightTop_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnlRightTop_Push }
 Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_scrRight }
 Tkw_AACContentsContainer_Control_scrRight_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_scrRight_Push }
 Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeftEx }
 Tkw_AACContentsContainer_Control_pnLeftEx_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeftEx_Push }
 Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeftForScroll }
 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeftForScroll_Push }
 Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnlLeftTop }
 Tkw_AACContentsContainer_Control_pnlLeftTop_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnlLeftTop_Push }
 Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeft }
 Tkw_AACContentsContainer_Control_pnLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_pnLeft_Push }
 Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_scrLeft }
 Tkw_AACContentsContainer_Control_scrLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContentsContainer_Control_scrLeft_Push }
 TkwAACContentsContainerFormPnBack.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnBack }
 TkwAACContentsContainerFormPnRightEx.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnRightEx }
 TkwAACContentsContainerFormPnRightForScroll.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnRightForScroll }
 TkwAACContentsContainerFormPnRight.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnRight }
 TkwAACContentsContainerFormPnlRightTop.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnlRightTop }
 TkwAACContentsContainerFormScrRight.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_scrRight }
 TkwAACContentsContainerFormPnLeftEx.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnLeftEx }
 TkwAACContentsContainerFormPnLeftForScroll.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnLeftForScroll }
 TkwAACContentsContainerFormPnlLeftTop.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnlLeftTop }
 TkwAACContentsContainerFormPnLeft.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_pnLeft }
 TkwAACContentsContainerFormScrLeft.RegisterInEngine;
 {* Регистрация AACContentsContainerForm_scrLeft }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContentsContainerForm));
 {* Регистрация типа AACContentsContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* Регистрация типа TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
