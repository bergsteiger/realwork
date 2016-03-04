unit AACContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AACContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , nscSimpleEditorForDialogs
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtProportionalPanel
 , vtScrollBar
 , vtSizeablePanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , AACContainer_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_AACContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AACContainer
----
*Пример использования*:
[code]
'aControl' форма::AACContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AACContainer

 Tkw_AACContainer_Control_pnWriteToUs = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnWriteToUs
----
*Пример использования*:
[code]
контрол::pnWriteToUs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnWriteToUs

 Tkw_AACContainer_Control_pnWriteToUs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnWriteToUs
----
*Пример использования*:
[code]
контрол::pnWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnWriteToUs_Push

 Tkw_AACContainer_Control_edWriteToUs = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edWriteToUs
----
*Пример использования*:
[code]
контрол::edWriteToUs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_edWriteToUs

 Tkw_AACContainer_Control_edWriteToUs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edWriteToUs
----
*Пример использования*:
[code]
контрол::edWriteToUs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_edWriteToUs_Push

 Tkw_AACContainer_Control_pnSeeAlso = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnSeeAlso
----
*Пример использования*:
[code]
контрол::pnSeeAlso TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnSeeAlso

 Tkw_AACContainer_Control_pnSeeAlso_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnSeeAlso
----
*Пример использования*:
[code]
контрол::pnSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnSeeAlso_Push

 Tkw_AACContainer_Control_lblSeeAlso = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblSeeAlso
----
*Пример использования*:
[code]
контрол::lblSeeAlso TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_lblSeeAlso

 Tkw_AACContainer_Control_lblSeeAlso_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblSeeAlso
----
*Пример использования*:
[code]
контрол::lblSeeAlso:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_lblSeeAlso_Push

 Tkw_AACContainer_Control_pnLinkToContent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnLinkToContent
----
*Пример использования*:
[code]
контрол::pnLinkToContent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pnLinkToContent

 Tkw_AACContainer_Control_pnLinkToContent_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLinkToContent
----
*Пример использования*:
[code]
контрол::pnLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLinkToContent_Push

 Tkw_AACContainer_Control_pbLinkToContent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbLinkToContent
----
*Пример использования*:
[code]
контрол::pbLinkToContent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AACContainer_Control_pbLinkToContent

 Tkw_AACContainer_Control_pbLinkToContent_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbLinkToContent
----
*Пример использования*:
[code]
контрол::pbLinkToContent:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pbLinkToContent_Push

 Tkw_AACContainer_Control_pnBack = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnBack

 Tkw_AACContainer_Control_pnBack_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnBack_Push

 Tkw_AACContainer_Control_pnRightEx = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnRightEx

 Tkw_AACContainer_Control_pnRightEx_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRightEx
----
*Пример использования*:
[code]
контрол::pnRightEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightEx_Push

 Tkw_AACContainer_Control_pnRightForScroll = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnRightForScroll

 Tkw_AACContainer_Control_pnRightForScroll_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRightForScroll
----
*Пример использования*:
[code]
контрол::pnRightForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRightForScroll_Push

 Tkw_AACContainer_Control_pnRight = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnRight

 Tkw_AACContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnRight
----
*Пример использования*:
[code]
контрол::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnRight_Push

 Tkw_AACContainer_Control_pnlRightTop = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnlRightTop

 Tkw_AACContainer_Control_pnlRightTop_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlRightTop
----
*Пример использования*:
[code]
контрол::pnlRightTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlRightTop_Push

 Tkw_AACContainer_Control_scrRight = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_scrRight

 Tkw_AACContainer_Control_scrRight_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола scrRight
----
*Пример использования*:
[code]
контрол::scrRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrRight_Push

 Tkw_AACContainer_Control_pnLeftEx = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnLeftEx

 Tkw_AACContainer_Control_pnLeftEx_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeftEx
----
*Пример использования*:
[code]
контрол::pnLeftEx:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftEx_Push

 Tkw_AACContainer_Control_pnLeftForScroll = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnLeftForScroll

 Tkw_AACContainer_Control_pnLeftForScroll_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeftForScroll
----
*Пример использования*:
[code]
контрол::pnLeftForScroll:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeftForScroll_Push

 Tkw_AACContainer_Control_pnlLeftTop = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnlLeftTop

 Tkw_AACContainer_Control_pnlLeftTop_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlLeftTop
----
*Пример использования*:
[code]
контрол::pnlLeftTop:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnlLeftTop_Push

 Tkw_AACContainer_Control_pnLeft = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_pnLeft

 Tkw_AACContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnLeft
----
*Пример использования*:
[code]
контрол::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_pnLeft_Push

 Tkw_AACContainer_Control_scrLeft = {final} class(TtfwControlString)
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
 end;//Tkw_AACContainer_Control_scrLeft

 Tkw_AACContainer_Control_scrLeft_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола scrLeft
----
*Пример использования*:
[code]
контрол::scrLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContainer_Control_scrLeft_Push

 TkwAACContainerFormPnWriteToUs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnWriteToUs
[panel]Контрол pnWriteToUs формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnWriteToUs >>> l_TvtPanel
[code]  }
  private
   function pnWriteToUs(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnWriteToUs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnWriteToUs

 TkwAACContainerFormEdWriteToUs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.edWriteToUs
[panel]Контрол edWriteToUs формы TAACContainerForm[panel]
*Тип результата:* TnscSimpleEditorForDialogs
*Пример:*
[code]
OBJECT VAR l_TnscSimpleEditorForDialogs
 aAACContainerForm .TAACContainerForm.edWriteToUs >>> l_TnscSimpleEditorForDialogs
[code]  }
  private
   function edWriteToUs(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
    {* Реализация слова скрипта .TAACContainerForm.edWriteToUs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormEdWriteToUs

 TkwAACContainerFormPnSeeAlso = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnSeeAlso
[panel]Контрол pnSeeAlso формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnSeeAlso >>> l_TvtPanel
[code]  }
  private
   function pnSeeAlso(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnSeeAlso }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnSeeAlso

 TkwAACContainerFormLblSeeAlso = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.lblSeeAlso
[panel]Контрол lblSeeAlso формы TAACContainerForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aAACContainerForm .TAACContainerForm.lblSeeAlso >>> l_TvtLabel
[code]  }
  private
   function lblSeeAlso(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtLabel;
    {* Реализация слова скрипта .TAACContainerForm.lblSeeAlso }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormLblSeeAlso

 TkwAACContainerFormPnLinkToContent = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnLinkToContent
[panel]Контрол pnLinkToContent формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLinkToContent >>> l_TvtPanel
[code]  }
  private
   function pnLinkToContent(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnLinkToContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLinkToContent

 TkwAACContainerFormPbLinkToContent = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pbLinkToContent
[panel]Контрол pbLinkToContent формы TAACContainerForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aAACContainerForm .TAACContainerForm.pbLinkToContent >>> l_TPaintBox
[code]  }
  private
   function pbLinkToContent(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TPaintBox;
    {* Реализация слова скрипта .TAACContainerForm.pbLinkToContent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPbLinkToContent

 TkwAACContainerFormPnBack = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnBack
[panel]Контрол pnBack формы TAACContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aAACContainerForm .TAACContainerForm.pnBack >>> l_TvtProportionalPanel
[code]  }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnBack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnBack

 TkwAACContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnRightEx
[panel]Контрол pnRightEx формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightEx >>> l_TvtPanel
[code]  }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnRightEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRightEx

 TkwAACContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnRightForScroll
[panel]Контрол pnRightForScroll формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRightForScroll >>> l_TvtPanel
[code]  }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnRightForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRightForScroll

 TkwAACContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnRight
[panel]Контрол pnRight формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnRight

 TkwAACContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnlRightTop
[panel]Контрол pnlRightTop формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlRightTop >>> l_TvtPanel
[code]  }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnlRightTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnlRightTop

 TkwAACContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.scrRight
[panel]Контрол scrRight формы TAACContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrRight >>> l_TvtScrollBar
[code]  }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContainerForm.scrRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormScrRight

 TkwAACContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnLeftEx
[panel]Контрол pnLeftEx формы TAACContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aAACContainerForm .TAACContainerForm.pnLeftEx >>> l_TvtSizeablePanel
[code]  }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TAACContainerForm.pnLeftEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeftEx

 TkwAACContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnLeftForScroll
[panel]Контрол pnLeftForScroll формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeftForScroll >>> l_TvtPanel
[code]  }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnLeftForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeftForScroll

 TkwAACContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnlLeftTop
[panel]Контрол pnlLeftTop формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnlLeftTop >>> l_TvtPanel
[code]  }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnlLeftTop

 TkwAACContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.pnLeft
[panel]Контрол pnLeft формы TAACContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aAACContainerForm .TAACContainerForm.pnLeft >>> l_TvtPanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormPnLeft

 TkwAACContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContainerForm.scrLeft
[panel]Контрол scrLeft формы TAACContainerForm[panel]
*Тип результата:* TvtScrollBar
*Пример:*
[code]
OBJECT VAR l_TvtScrollBar
 aAACContainerForm .TAACContainerForm.scrLeft >>> l_TvtScrollBar
[code]  }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContainerForm: TAACContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContainerForm.scrLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAACContainerFormScrLeft

class function Tkw_Form_AACContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AACContainer';
end;//Tkw_Form_AACContainer.GetWordNameForRegister

function Tkw_Form_AACContainer.GetString: AnsiString;
begin
 Result := 'AACContainerForm';
end;//Tkw_Form_AACContainer.GetString

class function Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnWriteToUs';
end;//Tkw_AACContainer_Control_pnWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_pnWriteToUs.GetString: AnsiString;
begin
 Result := 'pnWriteToUs';
end;//Tkw_AACContainer_Control_pnWriteToUs.GetString

class procedure Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine

procedure Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnWriteToUs');
 inherited;
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnWriteToUs:push';
end;//Tkw_AACContainer_Control_pnWriteToUs_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edWriteToUs';
end;//Tkw_AACContainer_Control_edWriteToUs.GetWordNameForRegister

function Tkw_AACContainer_Control_edWriteToUs.GetString: AnsiString;
begin
 Result := 'edWriteToUs';
end;//Tkw_AACContainer_Control_edWriteToUs.GetString

class procedure Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscSimpleEditorForDialogs);
end;//Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine

procedure Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edWriteToUs');
 inherited;
end;//Tkw_AACContainer_Control_edWriteToUs_Push.DoDoIt

class function Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edWriteToUs:push';
end;//Tkw_AACContainer_Control_edWriteToUs_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSeeAlso';
end;//Tkw_AACContainer_Control_pnSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_pnSeeAlso.GetString: AnsiString;
begin
 Result := 'pnSeeAlso';
end;//Tkw_AACContainer_Control_pnSeeAlso.GetString

class procedure Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine

procedure Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnSeeAlso');
 inherited;
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnSeeAlso:push';
end;//Tkw_AACContainer_Control_pnSeeAlso_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblSeeAlso';
end;//Tkw_AACContainer_Control_lblSeeAlso.GetWordNameForRegister

function Tkw_AACContainer_Control_lblSeeAlso.GetString: AnsiString;
begin
 Result := 'lblSeeAlso';
end;//Tkw_AACContainer_Control_lblSeeAlso.GetString

class procedure Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine

procedure Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblSeeAlso');
 inherited;
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.DoDoIt

class function Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblSeeAlso:push';
end;//Tkw_AACContainer_Control_lblSeeAlso_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLinkToContent';
end;//Tkw_AACContainer_Control_pnLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLinkToContent.GetString: AnsiString;
begin
 Result := 'pnLinkToContent';
end;//Tkw_AACContainer_Control_pnLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLinkToContent');
 inherited;
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLinkToContent:push';
end;//Tkw_AACContainer_Control_pnLinkToContent_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLinkToContent';
end;//Tkw_AACContainer_Control_pbLinkToContent.GetWordNameForRegister

function Tkw_AACContainer_Control_pbLinkToContent.GetString: AnsiString;
begin
 Result := 'pbLinkToContent';
end;//Tkw_AACContainer_Control_pbLinkToContent.GetString

class procedure Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine

procedure Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pbLinkToContent');
 inherited;
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.DoDoIt

class function Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbLinkToContent:push';
end;//Tkw_AACContainer_Control_pbLinkToContent_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetWordNameForRegister

function Tkw_AACContainer_Control_pnBack.GetString: AnsiString;
begin
 Result := 'pnBack';
end;//Tkw_AACContainer_Control_pnBack.GetString

class procedure Tkw_AACContainer_Control_pnBack.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContainer_Control_pnBack.RegisterInEngine

procedure Tkw_AACContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack:push';
end;//Tkw_AACContainer_Control_pnBack_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightEx.GetString: AnsiString;
begin
 Result := 'pnRightEx';
end;//Tkw_AACContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightEx.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx:push';
end;//Tkw_AACContainer_Control_pnRightEx_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRightForScroll.GetString: AnsiString;
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll:push';
end;//Tkw_AACContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetWordNameForRegister

function Tkw_AACContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_AACContainer_Control_pnRight.GetString

class procedure Tkw_AACContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnRight.RegisterInEngine

procedure Tkw_AACContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_AACContainer_Control_pnRight_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlRightTop.GetString: AnsiString;
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine

procedure Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop:push';
end;//Tkw_AACContainer_Control_pnlRightTop_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetWordNameForRegister

function Tkw_AACContainer_Control_scrRight.GetString: AnsiString;
begin
 Result := 'scrRight';
end;//Tkw_AACContainer_Control_scrRight.GetString

class procedure Tkw_AACContainer_Control_scrRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrRight.RegisterInEngine

procedure Tkw_AACContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight:push';
end;//Tkw_AACContainer_Control_scrRight_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftEx.GetString: AnsiString;
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx:push';
end;//Tkw_AACContainer_Control_pnLeftEx_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeftForScroll.GetString: AnsiString;
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll:push';
end;//Tkw_AACContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetWordNameForRegister

function Tkw_AACContainer_Control_pnlLeftTop.GetString: AnsiString;
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine

procedure Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop:push';
end;//Tkw_AACContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_AACContainer_Control_pnLeft.GetString

class procedure Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContainer_Control_pnLeft.RegisterInEngine

procedure Tkw_AACContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_AACContainer_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetWordNameForRegister

function Tkw_AACContainer_Control_scrLeft.GetString: AnsiString;
begin
 Result := 'scrLeft';
end;//Tkw_AACContainer_Control_scrLeft.GetString

class procedure Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContainer_Control_scrLeft.RegisterInEngine

procedure Tkw_AACContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft:push';
end;//Tkw_AACContainer_Control_scrLeft_Push.GetWordNameForRegister

function TkwAACContainerFormPnWriteToUs.pnWriteToUs(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnWriteToUs }
begin
 Result := aAACContainerForm.pnWriteToUs;
end;//TkwAACContainerFormPnWriteToUs.pnWriteToUs

procedure TkwAACContainerFormPnWriteToUs.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnWriteToUs(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnWriteToUs.DoDoIt

class function TkwAACContainerFormPnWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnWriteToUs';
end;//TkwAACContainerFormPnWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormPnWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnWriteToUs', aCtx);
end;//TkwAACContainerFormPnWriteToUs.SetValuePrim

function TkwAACContainerFormPnWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnWriteToUs.GetResultTypeInfo

function TkwAACContainerFormPnWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnWriteToUs.GetAllParamsCount

function TkwAACContainerFormPnWriteToUs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnWriteToUs.ParamsTypes

function TkwAACContainerFormEdWriteToUs.edWriteToUs(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TnscSimpleEditorForDialogs;
 {* Реализация слова скрипта .TAACContainerForm.edWriteToUs }
begin
 Result := aAACContainerForm.edWriteToUs;
end;//TkwAACContainerFormEdWriteToUs.edWriteToUs

procedure TkwAACContainerFormEdWriteToUs.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edWriteToUs(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormEdWriteToUs.DoDoIt

class function TkwAACContainerFormEdWriteToUs.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.edWriteToUs';
end;//TkwAACContainerFormEdWriteToUs.GetWordNameForRegister

procedure TkwAACContainerFormEdWriteToUs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству edWriteToUs', aCtx);
end;//TkwAACContainerFormEdWriteToUs.SetValuePrim

function TkwAACContainerFormEdWriteToUs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscSimpleEditorForDialogs);
end;//TkwAACContainerFormEdWriteToUs.GetResultTypeInfo

function TkwAACContainerFormEdWriteToUs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormEdWriteToUs.GetAllParamsCount

function TkwAACContainerFormEdWriteToUs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormEdWriteToUs.ParamsTypes

function TkwAACContainerFormPnSeeAlso.pnSeeAlso(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnSeeAlso }
begin
 Result := aAACContainerForm.pnSeeAlso;
end;//TkwAACContainerFormPnSeeAlso.pnSeeAlso

procedure TkwAACContainerFormPnSeeAlso.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnSeeAlso(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnSeeAlso.DoDoIt

class function TkwAACContainerFormPnSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnSeeAlso';
end;//TkwAACContainerFormPnSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormPnSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnSeeAlso', aCtx);
end;//TkwAACContainerFormPnSeeAlso.SetValuePrim

function TkwAACContainerFormPnSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnSeeAlso.GetResultTypeInfo

function TkwAACContainerFormPnSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnSeeAlso.GetAllParamsCount

function TkwAACContainerFormPnSeeAlso.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnSeeAlso.ParamsTypes

function TkwAACContainerFormLblSeeAlso.lblSeeAlso(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtLabel;
 {* Реализация слова скрипта .TAACContainerForm.lblSeeAlso }
begin
 Result := aAACContainerForm.lblSeeAlso;
end;//TkwAACContainerFormLblSeeAlso.lblSeeAlso

procedure TkwAACContainerFormLblSeeAlso.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblSeeAlso(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormLblSeeAlso.DoDoIt

class function TkwAACContainerFormLblSeeAlso.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.lblSeeAlso';
end;//TkwAACContainerFormLblSeeAlso.GetWordNameForRegister

procedure TkwAACContainerFormLblSeeAlso.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblSeeAlso', aCtx);
end;//TkwAACContainerFormLblSeeAlso.SetValuePrim

function TkwAACContainerFormLblSeeAlso.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwAACContainerFormLblSeeAlso.GetResultTypeInfo

function TkwAACContainerFormLblSeeAlso.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormLblSeeAlso.GetAllParamsCount

function TkwAACContainerFormLblSeeAlso.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormLblSeeAlso.ParamsTypes

function TkwAACContainerFormPnLinkToContent.pnLinkToContent(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnLinkToContent }
begin
 Result := aAACContainerForm.pnLinkToContent;
end;//TkwAACContainerFormPnLinkToContent.pnLinkToContent

procedure TkwAACContainerFormPnLinkToContent.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLinkToContent(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLinkToContent.DoDoIt

class function TkwAACContainerFormPnLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLinkToContent';
end;//TkwAACContainerFormPnLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPnLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLinkToContent', aCtx);
end;//TkwAACContainerFormPnLinkToContent.SetValuePrim

function TkwAACContainerFormPnLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPnLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLinkToContent.GetAllParamsCount

function TkwAACContainerFormPnLinkToContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLinkToContent.ParamsTypes

function TkwAACContainerFormPbLinkToContent.pbLinkToContent(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TPaintBox;
 {* Реализация слова скрипта .TAACContainerForm.pbLinkToContent }
begin
 Result := aAACContainerForm.pbLinkToContent;
end;//TkwAACContainerFormPbLinkToContent.pbLinkToContent

procedure TkwAACContainerFormPbLinkToContent.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pbLinkToContent(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPbLinkToContent.DoDoIt

class function TkwAACContainerFormPbLinkToContent.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pbLinkToContent';
end;//TkwAACContainerFormPbLinkToContent.GetWordNameForRegister

procedure TkwAACContainerFormPbLinkToContent.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pbLinkToContent', aCtx);
end;//TkwAACContainerFormPbLinkToContent.SetValuePrim

function TkwAACContainerFormPbLinkToContent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwAACContainerFormPbLinkToContent.GetResultTypeInfo

function TkwAACContainerFormPbLinkToContent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPbLinkToContent.GetAllParamsCount

function TkwAACContainerFormPbLinkToContent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPbLinkToContent.ParamsTypes

function TkwAACContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnBack }
begin
 Result := aAACContainerForm.pnBack;
end;//TkwAACContainerFormPnBack.pnBack

procedure TkwAACContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBack(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnBack.DoDoIt

class function TkwAACContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnBack';
end;//TkwAACContainerFormPnBack.GetWordNameForRegister

procedure TkwAACContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBack', aCtx);
end;//TkwAACContainerFormPnBack.SetValuePrim

function TkwAACContainerFormPnBack.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwAACContainerFormPnBack.GetResultTypeInfo

function TkwAACContainerFormPnBack.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnBack.GetAllParamsCount

function TkwAACContainerFormPnBack.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnBack.ParamsTypes

function TkwAACContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnRightEx }
begin
 Result := aAACContainerForm.pnRightEx;
end;//TkwAACContainerFormPnRightEx.pnRightEx

procedure TkwAACContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightEx(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRightEx.DoDoIt

class function TkwAACContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightEx';
end;//TkwAACContainerFormPnRightEx.GetWordNameForRegister

procedure TkwAACContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightEx', aCtx);
end;//TkwAACContainerFormPnRightEx.SetValuePrim

function TkwAACContainerFormPnRightEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightEx.GetResultTypeInfo

function TkwAACContainerFormPnRightEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRightEx.GetAllParamsCount

function TkwAACContainerFormPnRightEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightEx.ParamsTypes

function TkwAACContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnRightForScroll }
begin
 Result := aAACContainerForm.pnRightForScroll;
end;//TkwAACContainerFormPnRightForScroll.pnRightForScroll

procedure TkwAACContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightForScroll(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRightForScroll.DoDoIt

class function TkwAACContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRightForScroll';
end;//TkwAACContainerFormPnRightForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightForScroll', aCtx);
end;//TkwAACContainerFormPnRightForScroll.SetValuePrim

function TkwAACContainerFormPnRightForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRightForScroll.GetResultTypeInfo

function TkwAACContainerFormPnRightForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRightForScroll.GetAllParamsCount

function TkwAACContainerFormPnRightForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRightForScroll.ParamsTypes

function TkwAACContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnRight }
begin
 Result := aAACContainerForm.pnRight;
end;//TkwAACContainerFormPnRight.pnRight

procedure TkwAACContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnRight.DoDoIt

class function TkwAACContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnRight';
end;//TkwAACContainerFormPnRight.GetWordNameForRegister

procedure TkwAACContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRight', aCtx);
end;//TkwAACContainerFormPnRight.SetValuePrim

function TkwAACContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnRight.GetResultTypeInfo

function TkwAACContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnRight.GetAllParamsCount

function TkwAACContainerFormPnRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnRight.ParamsTypes

function TkwAACContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnlRightTop }
begin
 Result := aAACContainerForm.pnlRightTop;
end;//TkwAACContainerFormPnlRightTop.pnlRightTop

procedure TkwAACContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRightTop(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnlRightTop.DoDoIt

class function TkwAACContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlRightTop';
end;//TkwAACContainerFormPnlRightTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlRightTop', aCtx);
end;//TkwAACContainerFormPnlRightTop.SetValuePrim

function TkwAACContainerFormPnlRightTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlRightTop.GetResultTypeInfo

function TkwAACContainerFormPnlRightTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnlRightTop.GetAllParamsCount

function TkwAACContainerFormPnlRightTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlRightTop.ParamsTypes

function TkwAACContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContainerForm.scrRight }
begin
 Result := aAACContainerForm.scrRight;
end;//TkwAACContainerFormScrRight.scrRight

procedure TkwAACContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrRight(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormScrRight.DoDoIt

class function TkwAACContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrRight';
end;//TkwAACContainerFormScrRight.GetWordNameForRegister

procedure TkwAACContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrRight', aCtx);
end;//TkwAACContainerFormScrRight.SetValuePrim

function TkwAACContainerFormScrRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrRight.GetResultTypeInfo

function TkwAACContainerFormScrRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormScrRight.GetAllParamsCount

function TkwAACContainerFormScrRight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrRight.ParamsTypes

function TkwAACContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TAACContainerForm.pnLeftEx }
begin
 Result := aAACContainerForm.pnLeftEx;
end;//TkwAACContainerFormPnLeftEx.pnLeftEx

procedure TkwAACContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftEx(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeftEx.DoDoIt

class function TkwAACContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftEx';
end;//TkwAACContainerFormPnLeftEx.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftEx', aCtx);
end;//TkwAACContainerFormPnLeftEx.SetValuePrim

function TkwAACContainerFormPnLeftEx.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwAACContainerFormPnLeftEx.GetResultTypeInfo

function TkwAACContainerFormPnLeftEx.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeftEx.GetAllParamsCount

function TkwAACContainerFormPnLeftEx.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftEx.ParamsTypes

function TkwAACContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnLeftForScroll }
begin
 Result := aAACContainerForm.pnLeftForScroll;
end;//TkwAACContainerFormPnLeftForScroll.pnLeftForScroll

procedure TkwAACContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftForScroll(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeftForScroll';
end;//TkwAACContainerFormPnLeftForScroll.GetWordNameForRegister

procedure TkwAACContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftForScroll', aCtx);
end;//TkwAACContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeftForScroll.GetResultTypeInfo

function TkwAACContainerFormPnLeftForScroll.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeftForScroll.GetAllParamsCount

function TkwAACContainerFormPnLeftForScroll.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeftForScroll.ParamsTypes

function TkwAACContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnlLeftTop }
begin
 Result := aAACContainerForm.pnlLeftTop;
end;//TkwAACContainerFormPnlLeftTop.pnlLeftTop

procedure TkwAACContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeftTop(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnlLeftTop.DoDoIt

class function TkwAACContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnlLeftTop';
end;//TkwAACContainerFormPnlLeftTop.GetWordNameForRegister

procedure TkwAACContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeftTop', aCtx);
end;//TkwAACContainerFormPnlLeftTop.SetValuePrim

function TkwAACContainerFormPnlLeftTop.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnlLeftTop.GetResultTypeInfo

function TkwAACContainerFormPnlLeftTop.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnlLeftTop.GetAllParamsCount

function TkwAACContainerFormPnlLeftTop.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnlLeftTop.ParamsTypes

function TkwAACContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContainerForm.pnLeft }
begin
 Result := aAACContainerForm.pnLeft;
end;//TkwAACContainerFormPnLeft.pnLeft

procedure TkwAACContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormPnLeft.DoDoIt

class function TkwAACContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.pnLeft';
end;//TkwAACContainerFormPnLeft.GetWordNameForRegister

procedure TkwAACContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwAACContainerFormPnLeft.SetValuePrim

function TkwAACContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwAACContainerFormPnLeft.GetResultTypeInfo

function TkwAACContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormPnLeft.GetAllParamsCount

function TkwAACContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormPnLeft.ParamsTypes

function TkwAACContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContainerForm: TAACContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContainerForm.scrLeft }
begin
 Result := aAACContainerForm.scrLeft;
end;//TkwAACContainerFormScrLeft.scrLeft

procedure TkwAACContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContainerForm: TAACContainerForm;
begin
 try
  l_aAACContainerForm := TAACContainerForm(aCtx.rEngine.PopObjAs(TAACContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContainerForm: TAACContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrLeft(aCtx, l_aAACContainerForm));
end;//TkwAACContainerFormScrLeft.DoDoIt

class function TkwAACContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContainerForm.scrLeft';
end;//TkwAACContainerFormScrLeft.GetWordNameForRegister

procedure TkwAACContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrLeft', aCtx);
end;//TkwAACContainerFormScrLeft.SetValuePrim

function TkwAACContainerFormScrLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtScrollBar);
end;//TkwAACContainerFormScrLeft.GetResultTypeInfo

function TkwAACContainerFormScrLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAACContainerFormScrLeft.GetAllParamsCount

function TkwAACContainerFormScrLeft.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TAACContainerForm)]);
end;//TkwAACContainerFormScrLeft.ParamsTypes

initialization
 Tkw_Form_AACContainer.RegisterInEngine;
 {* Регистрация Tkw_Form_AACContainer }
 Tkw_AACContainer_Control_pnWriteToUs.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnWriteToUs }
 Tkw_AACContainer_Control_pnWriteToUs_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnWriteToUs_Push }
 Tkw_AACContainer_Control_edWriteToUs.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_edWriteToUs }
 Tkw_AACContainer_Control_edWriteToUs_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_edWriteToUs_Push }
 Tkw_AACContainer_Control_pnSeeAlso.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnSeeAlso }
 Tkw_AACContainer_Control_pnSeeAlso_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnSeeAlso_Push }
 Tkw_AACContainer_Control_lblSeeAlso.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_lblSeeAlso }
 Tkw_AACContainer_Control_lblSeeAlso_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_lblSeeAlso_Push }
 Tkw_AACContainer_Control_pnLinkToContent.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLinkToContent }
 Tkw_AACContainer_Control_pnLinkToContent_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLinkToContent_Push }
 Tkw_AACContainer_Control_pbLinkToContent.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pbLinkToContent }
 Tkw_AACContainer_Control_pbLinkToContent_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pbLinkToContent_Push }
 Tkw_AACContainer_Control_pnBack.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnBack }
 Tkw_AACContainer_Control_pnBack_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnBack_Push }
 Tkw_AACContainer_Control_pnRightEx.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRightEx }
 Tkw_AACContainer_Control_pnRightEx_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRightEx_Push }
 Tkw_AACContainer_Control_pnRightForScroll.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRightForScroll }
 Tkw_AACContainer_Control_pnRightForScroll_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRightForScroll_Push }
 Tkw_AACContainer_Control_pnRight.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRight }
 Tkw_AACContainer_Control_pnRight_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnRight_Push }
 Tkw_AACContainer_Control_pnlRightTop.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnlRightTop }
 Tkw_AACContainer_Control_pnlRightTop_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnlRightTop_Push }
 Tkw_AACContainer_Control_scrRight.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_scrRight }
 Tkw_AACContainer_Control_scrRight_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_scrRight_Push }
 Tkw_AACContainer_Control_pnLeftEx.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeftEx }
 Tkw_AACContainer_Control_pnLeftEx_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeftEx_Push }
 Tkw_AACContainer_Control_pnLeftForScroll.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeftForScroll }
 Tkw_AACContainer_Control_pnLeftForScroll_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeftForScroll_Push }
 Tkw_AACContainer_Control_pnlLeftTop.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnlLeftTop }
 Tkw_AACContainer_Control_pnlLeftTop_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnlLeftTop_Push }
 Tkw_AACContainer_Control_pnLeft.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeft }
 Tkw_AACContainer_Control_pnLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_pnLeft_Push }
 Tkw_AACContainer_Control_scrLeft.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_scrLeft }
 Tkw_AACContainer_Control_scrLeft_Push.RegisterInEngine;
 {* Регистрация Tkw_AACContainer_Control_scrLeft_Push }
 TkwAACContainerFormPnWriteToUs.RegisterInEngine;
 {* Регистрация AACContainerForm_pnWriteToUs }
 TkwAACContainerFormEdWriteToUs.RegisterInEngine;
 {* Регистрация AACContainerForm_edWriteToUs }
 TkwAACContainerFormPnSeeAlso.RegisterInEngine;
 {* Регистрация AACContainerForm_pnSeeAlso }
 TkwAACContainerFormLblSeeAlso.RegisterInEngine;
 {* Регистрация AACContainerForm_lblSeeAlso }
 TkwAACContainerFormPnLinkToContent.RegisterInEngine;
 {* Регистрация AACContainerForm_pnLinkToContent }
 TkwAACContainerFormPbLinkToContent.RegisterInEngine;
 {* Регистрация AACContainerForm_pbLinkToContent }
 TkwAACContainerFormPnBack.RegisterInEngine;
 {* Регистрация AACContainerForm_pnBack }
 TkwAACContainerFormPnRightEx.RegisterInEngine;
 {* Регистрация AACContainerForm_pnRightEx }
 TkwAACContainerFormPnRightForScroll.RegisterInEngine;
 {* Регистрация AACContainerForm_pnRightForScroll }
 TkwAACContainerFormPnRight.RegisterInEngine;
 {* Регистрация AACContainerForm_pnRight }
 TkwAACContainerFormPnlRightTop.RegisterInEngine;
 {* Регистрация AACContainerForm_pnlRightTop }
 TkwAACContainerFormScrRight.RegisterInEngine;
 {* Регистрация AACContainerForm_scrRight }
 TkwAACContainerFormPnLeftEx.RegisterInEngine;
 {* Регистрация AACContainerForm_pnLeftEx }
 TkwAACContainerFormPnLeftForScroll.RegisterInEngine;
 {* Регистрация AACContainerForm_pnLeftForScroll }
 TkwAACContainerFormPnlLeftTop.RegisterInEngine;
 {* Регистрация AACContainerForm_pnlLeftTop }
 TkwAACContainerFormPnLeft.RegisterInEngine;
 {* Регистрация AACContainerForm_pnLeft }
 TkwAACContainerFormScrLeft.RegisterInEngine;
 {* Регистрация AACContainerForm_scrLeft }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContainerForm));
 {* Регистрация типа AACContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscSimpleEditorForDialogs));
 {* Регистрация типа TnscSimpleEditorForDialogs }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtScrollBar));
 {* Регистрация типа TvtScrollBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
