unit StartupTipsKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы StartupTips }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\DayTips\StartupTipsKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , DayTips_Module
 , vtPanel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtLabel
 , vtFocusLabel
 , vtCheckBox
 , ElPopBtn
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
 Tkw_Form_StartupTips = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы StartupTips
----
*Пример использования*:
[code]
'aControl' форма::StartupTips TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_StartupTips

 Tkw_StartupTips_Control_TopPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TopPanel

 Tkw_StartupTips_Control_TopPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TopPanel
----
*Пример использования*:
[code]
контрол::TopPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TopPanel_Push

 Tkw_StartupTips_Control_TitlePaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TitlePaintBox
----
*Пример использования*:
[code]
контрол::TitlePaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TitlePaintBox

 Tkw_StartupTips_Control_TitlePaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TitlePaintBox
----
*Пример использования*:
[code]
контрол::TitlePaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TitlePaintBox_Push

 Tkw_StartupTips_Control_TitleLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TitleLabel
----
*Пример использования*:
[code]
контрол::TitleLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TitleLabel

 Tkw_StartupTips_Control_TitleLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TitleLabel
----
*Пример использования*:
[code]
контрол::TitleLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TitleLabel_Push

 Tkw_StartupTips_Control_BottomPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_BottomPanel

 Tkw_StartupTips_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_BottomPanel_Push

 Tkw_StartupTips_Control_HintPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HintPanel
----
*Пример использования*:
[code]
контрол::HintPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_HintPanel

 Tkw_StartupTips_Control_HintPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HintPanel
----
*Пример использования*:
[code]
контрол::HintPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_HintPanel_Push

 Tkw_StartupTips_Control_TipLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TipLabel
----
*Пример использования*:
[code]
контрол::TipLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_TipLabel

 Tkw_StartupTips_Control_TipLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TipLabel
----
*Пример использования*:
[code]
контрол::TipLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_TipLabel_Push

 Tkw_StartupTips_Control_DetailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DetailLabel
----
*Пример использования*:
[code]
контрол::DetailLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_DetailLabel

 Tkw_StartupTips_Control_DetailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола DetailLabel
----
*Пример использования*:
[code]
контрол::DetailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_DetailLabel_Push

 Tkw_StartupTips_Control_ShowCheckBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ShowCheckBox
----
*Пример использования*:
[code]
контрол::ShowCheckBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_ShowCheckBox

 Tkw_StartupTips_Control_ShowCheckBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ShowCheckBox
----
*Пример использования*:
[code]
контрол::ShowCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_ShowCheckBox_Push

 Tkw_StartupTips_Control_wwwPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола wwwPanel
----
*Пример использования*:
[code]
контрол::wwwPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwPanel

 Tkw_StartupTips_Control_wwwPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола wwwPanel
----
*Пример использования*:
[code]
контрол::wwwPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwPanel_Push

 Tkw_StartupTips_Control_wwwPaintBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола wwwPaintBox
----
*Пример использования*:
[code]
контрол::wwwPaintBox TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwPaintBox

 Tkw_StartupTips_Control_wwwPaintBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола wwwPaintBox
----
*Пример использования*:
[code]
контрол::wwwPaintBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwPaintBox_Push

 Tkw_StartupTips_Control_wwwLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола wwwLabel
----
*Пример использования*:
[code]
контрол::wwwLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_wwwLabel

 Tkw_StartupTips_Control_wwwLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола wwwLabel
----
*Пример использования*:
[code]
контрол::wwwLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_wwwLabel_Push

 Tkw_StartupTips_Control_NextButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NextButton
----
*Пример использования*:
[code]
контрол::NextButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_NextButton

 Tkw_StartupTips_Control_NextButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NextButton
----
*Пример использования*:
[code]
контрол::NextButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_NextButton_Push

 Tkw_StartupTips_Control_PrevButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PrevButton
----
*Пример использования*:
[code]
контрол::PrevButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_PrevButton

 Tkw_StartupTips_Control_PrevButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола PrevButton
----
*Пример использования*:
[code]
контрол::PrevButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_PrevButton_Push

 Tkw_StartupTips_Control_CloseButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CloseButton
----
*Пример использования*:
[code]
контрол::CloseButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_StartupTips_Control_CloseButton

 Tkw_StartupTips_Control_CloseButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CloseButton
----
*Пример использования*:
[code]
контрол::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_StartupTips_Control_CloseButton_Push

 TkwEfStartupTipsTopPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.TopPanel
[panel]Контрол TopPanel формы TefStartupTips[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.TopPanel >>> l_TvtPanel
[code]  }
  private
   function TopPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* Реализация слова скрипта .TefStartupTips.TopPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTopPanel

 TkwEfStartupTipsTitlePaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.TitlePaintBox
[panel]Контрол TitlePaintBox формы TefStartupTips[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.TitlePaintBox >>> l_TPaintBox
[code]  }
  private
   function TitlePaintBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TPaintBox;
    {* Реализация слова скрипта .TefStartupTips.TitlePaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTitlePaintBox

 TkwEfStartupTipsTitleLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.TitleLabel
[panel]Контрол TitleLabel формы TefStartupTips[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TitleLabel >>> l_TvtLabel
[code]  }
  private
   function TitleLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtLabel;
    {* Реализация слова скрипта .TefStartupTips.TitleLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTitleLabel

 TkwEfStartupTipsBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.BottomPanel
[panel]Контрол BottomPanel формы TefStartupTips[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* Реализация слова скрипта .TefStartupTips.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsBottomPanel

 TkwEfStartupTipsHintPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.HintPanel
[panel]Контрол HintPanel формы TefStartupTips[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.HintPanel >>> l_TvtPanel
[code]  }
  private
   function HintPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* Реализация слова скрипта .TefStartupTips.HintPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsHintPanel

 TkwEfStartupTipsTipLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.TipLabel
[panel]Контрол TipLabel формы TefStartupTips[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefStartupTips .TefStartupTips.TipLabel >>> l_TvtLabel
[code]  }
  private
   function TipLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtLabel;
    {* Реализация слова скрипта .TefStartupTips.TipLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsTipLabel

 TkwEfStartupTipsDetailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.DetailLabel
[panel]Контрол DetailLabel формы TefStartupTips[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.DetailLabel >>> l_TvtFocusLabel
[code]  }
  private
   function DetailLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtFocusLabel;
    {* Реализация слова скрипта .TefStartupTips.DetailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsDetailLabel

 TkwEfStartupTipsShowCheckBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.ShowCheckBox
[panel]Контрол ShowCheckBox формы TefStartupTips[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aefStartupTips .TefStartupTips.ShowCheckBox >>> l_TvtCheckBox
[code]  }
  private
   function ShowCheckBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtCheckBox;
    {* Реализация слова скрипта .TefStartupTips.ShowCheckBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsShowCheckBox

 TkwEfStartupTipsWwwPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.wwwPanel
[panel]Контрол wwwPanel формы TefStartupTips[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefStartupTips .TefStartupTips.wwwPanel >>> l_TvtPanel
[code]  }
  private
   function wwwPanel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtPanel;
    {* Реализация слова скрипта .TefStartupTips.wwwPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwPanel

 TkwEfStartupTipsWwwPaintBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.wwwPaintBox
[panel]Контрол wwwPaintBox формы TefStartupTips[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aefStartupTips .TefStartupTips.wwwPaintBox >>> l_TPaintBox
[code]  }
  private
   function wwwPaintBox(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TPaintBox;
    {* Реализация слова скрипта .TefStartupTips.wwwPaintBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwPaintBox

 TkwEfStartupTipsWwwLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.wwwLabel
[panel]Контрол wwwLabel формы TefStartupTips[panel]
*Тип результата:* TvtFocusLabel
*Пример:*
[code]
OBJECT VAR l_TvtFocusLabel
 aefStartupTips .TefStartupTips.wwwLabel >>> l_TvtFocusLabel
[code]  }
  private
   function wwwLabel(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TvtFocusLabel;
    {* Реализация слова скрипта .TefStartupTips.wwwLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsWwwLabel

 TkwEfStartupTipsNextButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.NextButton
[panel]Контрол NextButton формы TefStartupTips[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.NextButton >>> l_TElPopupButton
[code]  }
  private
   function NextButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* Реализация слова скрипта .TefStartupTips.NextButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsNextButton

 TkwEfStartupTipsPrevButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.PrevButton
[panel]Контрол PrevButton формы TefStartupTips[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.PrevButton >>> l_TElPopupButton
[code]  }
  private
   function PrevButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* Реализация слова скрипта .TefStartupTips.PrevButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsPrevButton

 TkwEfStartupTipsCloseButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefStartupTips.CloseButton
[panel]Контрол CloseButton формы TefStartupTips[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aefStartupTips .TefStartupTips.CloseButton >>> l_TElPopupButton
[code]  }
  private
   function CloseButton(const aCtx: TtfwContext;
    aefStartupTips: TefStartupTips): TElPopupButton;
    {* Реализация слова скрипта .TefStartupTips.CloseButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfStartupTipsCloseButton

class function Tkw_Form_StartupTips.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::StartupTips';
end;//Tkw_Form_StartupTips.GetWordNameForRegister

function Tkw_Form_StartupTips.GetString: AnsiString;
begin
 Result := 'efStartupTips';
end;//Tkw_Form_StartupTips.GetString

class function Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_TopPanel.GetString: AnsiString;
begin
 Result := 'TopPanel';
end;//Tkw_StartupTips_Control_TopPanel.GetString

class procedure Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_TopPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_TopPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7DF813516E20_var*
//#UC END# *4DAEEDE10285_7DF813516E20_var*
begin
//#UC START# *4DAEEDE10285_7DF813516E20_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7DF813516E20_impl*
end;//Tkw_StartupTips_Control_TopPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopPanel:push';
end;//Tkw_StartupTips_Control_TopPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_TitlePaintBox.GetString: AnsiString;
begin
 Result := 'TitlePaintBox';
end;//Tkw_StartupTips_Control_TitlePaintBox.GetString

class procedure Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine

procedure Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_81D3F58DE336_var*
//#UC END# *4DAEEDE10285_81D3F58DE336_var*
begin
//#UC START# *4DAEEDE10285_81D3F58DE336_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_81D3F58DE336_impl*
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TitlePaintBox:push';
end;//Tkw_StartupTips_Control_TitlePaintBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TitleLabel.GetString: AnsiString;
begin
 Result := 'TitleLabel';
end;//Tkw_StartupTips_Control_TitleLabel.GetString

class procedure Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TitleLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A30B38772CD6_var*
//#UC END# *4DAEEDE10285_A30B38772CD6_var*
begin
//#UC START# *4DAEEDE10285_A30B38772CD6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A30B38772CD6_impl*
end;//Tkw_StartupTips_Control_TitleLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TitleLabel:push';
end;//Tkw_StartupTips_Control_TitleLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_BottomPanel.GetString: AnsiString;
begin
 Result := 'BottomPanel';
end;//Tkw_StartupTips_Control_BottomPanel.GetString

class procedure Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_BottomPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B4899D4E9041_var*
//#UC END# *4DAEEDE10285_B4899D4E9041_var*
begin
//#UC START# *4DAEEDE10285_B4899D4E9041_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B4899D4E9041_impl*
end;//Tkw_StartupTips_Control_BottomPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_StartupTips_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_HintPanel.GetString: AnsiString;
begin
 Result := 'HintPanel';
end;//Tkw_StartupTips_Control_HintPanel.GetString

class procedure Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_HintPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_HintPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2E0686E9199C_var*
//#UC END# *4DAEEDE10285_2E0686E9199C_var*
begin
//#UC START# *4DAEEDE10285_2E0686E9199C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2E0686E9199C_impl*
end;//Tkw_StartupTips_Control_HintPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HintPanel:push';
end;//Tkw_StartupTips_Control_HintPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_TipLabel.GetString: AnsiString;
begin
 Result := 'TipLabel';
end;//Tkw_StartupTips_Control_TipLabel.GetString

class procedure Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StartupTips_Control_TipLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_TipLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E0783AFF535_var*
//#UC END# *4DAEEDE10285_7E0783AFF535_var*
begin
//#UC START# *4DAEEDE10285_7E0783AFF535_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7E0783AFF535_impl*
end;//Tkw_StartupTips_Control_TipLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TipLabel:push';
end;//Tkw_StartupTips_Control_TipLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_DetailLabel.GetString: AnsiString;
begin
 Result := 'DetailLabel';
end;//Tkw_StartupTips_Control_DetailLabel.GetString

class procedure Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_DetailLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_864277A10C77_var*
//#UC END# *4DAEEDE10285_864277A10C77_var*
begin
//#UC START# *4DAEEDE10285_864277A10C77_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_864277A10C77_impl*
end;//Tkw_StartupTips_Control_DetailLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DetailLabel:push';
end;//Tkw_StartupTips_Control_DetailLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetWordNameForRegister

function Tkw_StartupTips_Control_ShowCheckBox.GetString: AnsiString;
begin
 Result := 'ShowCheckBox';
end;//Tkw_StartupTips_Control_ShowCheckBox.GetString

class procedure Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine

procedure Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7B1198AAB31C_var*
//#UC END# *4DAEEDE10285_7B1198AAB31C_var*
begin
//#UC START# *4DAEEDE10285_7B1198AAB31C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7B1198AAB31C_impl*
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.DoDoIt

class function Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ShowCheckBox:push';
end;//Tkw_StartupTips_Control_ShowCheckBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPanel.GetString: AnsiString;
begin
 Result := 'wwwPanel';
end;//Tkw_StartupTips_Control_wwwPanel.GetString

class procedure Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_StartupTips_Control_wwwPanel.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D7692CEA3106_var*
//#UC END# *4DAEEDE10285_D7692CEA3106_var*
begin
//#UC START# *4DAEEDE10285_D7692CEA3106_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D7692CEA3106_impl*
end;//Tkw_StartupTips_Control_wwwPanel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwPanel:push';
end;//Tkw_StartupTips_Control_wwwPanel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwPaintBox.GetString: AnsiString;
begin
 Result := 'wwwPaintBox';
end;//Tkw_StartupTips_Control_wwwPaintBox.GetString

class procedure Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TPaintBox);
end;//Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73CE45570DC2_var*
//#UC END# *4DAEEDE10285_73CE45570DC2_var*
begin
//#UC START# *4DAEEDE10285_73CE45570DC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73CE45570DC2_impl*
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwPaintBox:push';
end;//Tkw_StartupTips_Control_wwwPaintBox_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetWordNameForRegister

function Tkw_StartupTips_Control_wwwLabel.GetString: AnsiString;
begin
 Result := 'wwwLabel';
end;//Tkw_StartupTips_Control_wwwLabel.GetString

class procedure Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtFocusLabel);
end;//Tkw_StartupTips_Control_wwwLabel.RegisterInEngine

procedure Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7C38C3E1D4C5_var*
//#UC END# *4DAEEDE10285_7C38C3E1D4C5_var*
begin
//#UC START# *4DAEEDE10285_7C38C3E1D4C5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7C38C3E1D4C5_impl*
end;//Tkw_StartupTips_Control_wwwLabel_Push.DoDoIt

class function Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::wwwLabel:push';
end;//Tkw_StartupTips_Control_wwwLabel_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_NextButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetWordNameForRegister

function Tkw_StartupTips_Control_NextButton.GetString: AnsiString;
begin
 Result := 'NextButton';
end;//Tkw_StartupTips_Control_NextButton.GetString

class procedure Tkw_StartupTips_Control_NextButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_NextButton.RegisterInEngine

procedure Tkw_StartupTips_Control_NextButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_11F85FE0D364_var*
//#UC END# *4DAEEDE10285_11F85FE0D364_var*
begin
//#UC START# *4DAEEDE10285_11F85FE0D364_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_11F85FE0D364_impl*
end;//Tkw_StartupTips_Control_NextButton_Push.DoDoIt

class function Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NextButton:push';
end;//Tkw_StartupTips_Control_NextButton_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetWordNameForRegister

function Tkw_StartupTips_Control_PrevButton.GetString: AnsiString;
begin
 Result := 'PrevButton';
end;//Tkw_StartupTips_Control_PrevButton.GetString

class procedure Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_PrevButton.RegisterInEngine

procedure Tkw_StartupTips_Control_PrevButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98BA2132D85E_var*
//#UC END# *4DAEEDE10285_98BA2132D85E_var*
begin
//#UC START# *4DAEEDE10285_98BA2132D85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98BA2132D85E_impl*
end;//Tkw_StartupTips_Control_PrevButton_Push.DoDoIt

class function Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PrevButton:push';
end;//Tkw_StartupTips_Control_PrevButton_Push.GetWordNameForRegister

class function Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetWordNameForRegister

function Tkw_StartupTips_Control_CloseButton.GetString: AnsiString;
begin
 Result := 'CloseButton';
end;//Tkw_StartupTips_Control_CloseButton.GetString

class procedure Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StartupTips_Control_CloseButton.RegisterInEngine

procedure Tkw_StartupTips_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DE5B5144BBDC_var*
//#UC END# *4DAEEDE10285_DE5B5144BBDC_var*
begin
//#UC START# *4DAEEDE10285_DE5B5144BBDC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DE5B5144BBDC_impl*
end;//Tkw_StartupTips_Control_CloseButton_Push.DoDoIt

class function Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton:push';
end;//Tkw_StartupTips_Control_CloseButton_Push.GetWordNameForRegister

function TkwEfStartupTipsTopPanel.TopPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* Реализация слова скрипта .TefStartupTips.TopPanel }
begin
 Result := aefStartupTips.TopPanel;
end;//TkwEfStartupTipsTopPanel.TopPanel

procedure TkwEfStartupTipsTopPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTopPanel.DoDoIt

class function TkwEfStartupTipsTopPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TopPanel';
end;//TkwEfStartupTipsTopPanel.GetWordNameForRegister

procedure TkwEfStartupTipsTopPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopPanel', aCtx);
end;//TkwEfStartupTipsTopPanel.SetValuePrim

function TkwEfStartupTipsTopPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsTopPanel.GetResultTypeInfo

function TkwEfStartupTipsTopPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTopPanel.GetAllParamsCount

function TkwEfStartupTipsTopPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTopPanel.ParamsTypes

function TkwEfStartupTipsTitlePaintBox.TitlePaintBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TPaintBox;
 {* Реализация слова скрипта .TefStartupTips.TitlePaintBox }
begin
 Result := aefStartupTips.TitlePaintBox;
end;//TkwEfStartupTipsTitlePaintBox.TitlePaintBox

procedure TkwEfStartupTipsTitlePaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TitlePaintBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTitlePaintBox.DoDoIt

class function TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TitlePaintBox';
end;//TkwEfStartupTipsTitlePaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsTitlePaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TitlePaintBox', aCtx);
end;//TkwEfStartupTipsTitlePaintBox.SetValuePrim

function TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsTitlePaintBox.GetResultTypeInfo

function TkwEfStartupTipsTitlePaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTitlePaintBox.GetAllParamsCount

function TkwEfStartupTipsTitlePaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitlePaintBox.ParamsTypes

function TkwEfStartupTipsTitleLabel.TitleLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtLabel;
 {* Реализация слова скрипта .TefStartupTips.TitleLabel }
begin
 Result := aefStartupTips.TitleLabel;
end;//TkwEfStartupTipsTitleLabel.TitleLabel

procedure TkwEfStartupTipsTitleLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TitleLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTitleLabel.DoDoIt

class function TkwEfStartupTipsTitleLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TitleLabel';
end;//TkwEfStartupTipsTitleLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTitleLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TitleLabel', aCtx);
end;//TkwEfStartupTipsTitleLabel.SetValuePrim

function TkwEfStartupTipsTitleLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTitleLabel.GetResultTypeInfo

function TkwEfStartupTipsTitleLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTitleLabel.GetAllParamsCount

function TkwEfStartupTipsTitleLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTitleLabel.ParamsTypes

function TkwEfStartupTipsBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* Реализация слова скрипта .TefStartupTips.BottomPanel }
begin
 Result := aefStartupTips.BottomPanel;
end;//TkwEfStartupTipsBottomPanel.BottomPanel

procedure TkwEfStartupTipsBottomPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BottomPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsBottomPanel.DoDoIt

class function TkwEfStartupTipsBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.BottomPanel';
end;//TkwEfStartupTipsBottomPanel.GetWordNameForRegister

procedure TkwEfStartupTipsBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BottomPanel', aCtx);
end;//TkwEfStartupTipsBottomPanel.SetValuePrim

function TkwEfStartupTipsBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsBottomPanel.GetResultTypeInfo

function TkwEfStartupTipsBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsBottomPanel.GetAllParamsCount

function TkwEfStartupTipsBottomPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsBottomPanel.ParamsTypes

function TkwEfStartupTipsHintPanel.HintPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* Реализация слова скрипта .TefStartupTips.HintPanel }
begin
 Result := aefStartupTips.HintPanel;
end;//TkwEfStartupTipsHintPanel.HintPanel

procedure TkwEfStartupTipsHintPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HintPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsHintPanel.DoDoIt

class function TkwEfStartupTipsHintPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.HintPanel';
end;//TkwEfStartupTipsHintPanel.GetWordNameForRegister

procedure TkwEfStartupTipsHintPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству HintPanel', aCtx);
end;//TkwEfStartupTipsHintPanel.SetValuePrim

function TkwEfStartupTipsHintPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsHintPanel.GetResultTypeInfo

function TkwEfStartupTipsHintPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsHintPanel.GetAllParamsCount

function TkwEfStartupTipsHintPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsHintPanel.ParamsTypes

function TkwEfStartupTipsTipLabel.TipLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtLabel;
 {* Реализация слова скрипта .TefStartupTips.TipLabel }
begin
 Result := aefStartupTips.TipLabel;
end;//TkwEfStartupTipsTipLabel.TipLabel

procedure TkwEfStartupTipsTipLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TipLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsTipLabel.DoDoIt

class function TkwEfStartupTipsTipLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.TipLabel';
end;//TkwEfStartupTipsTipLabel.GetWordNameForRegister

procedure TkwEfStartupTipsTipLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TipLabel', aCtx);
end;//TkwEfStartupTipsTipLabel.SetValuePrim

function TkwEfStartupTipsTipLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfStartupTipsTipLabel.GetResultTypeInfo

function TkwEfStartupTipsTipLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsTipLabel.GetAllParamsCount

function TkwEfStartupTipsTipLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsTipLabel.ParamsTypes

function TkwEfStartupTipsDetailLabel.DetailLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtFocusLabel;
 {* Реализация слова скрипта .TefStartupTips.DetailLabel }
begin
 Result := aefStartupTips.DetailLabel;
end;//TkwEfStartupTipsDetailLabel.DetailLabel

procedure TkwEfStartupTipsDetailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DetailLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsDetailLabel.DoDoIt

class function TkwEfStartupTipsDetailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.DetailLabel';
end;//TkwEfStartupTipsDetailLabel.GetWordNameForRegister

procedure TkwEfStartupTipsDetailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DetailLabel', aCtx);
end;//TkwEfStartupTipsDetailLabel.SetValuePrim

function TkwEfStartupTipsDetailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsDetailLabel.GetResultTypeInfo

function TkwEfStartupTipsDetailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsDetailLabel.GetAllParamsCount

function TkwEfStartupTipsDetailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsDetailLabel.ParamsTypes

function TkwEfStartupTipsShowCheckBox.ShowCheckBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtCheckBox;
 {* Реализация слова скрипта .TefStartupTips.ShowCheckBox }
begin
 Result := aefStartupTips.ShowCheckBox;
end;//TkwEfStartupTipsShowCheckBox.ShowCheckBox

procedure TkwEfStartupTipsShowCheckBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShowCheckBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsShowCheckBox.DoDoIt

class function TkwEfStartupTipsShowCheckBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.ShowCheckBox';
end;//TkwEfStartupTipsShowCheckBox.GetWordNameForRegister

procedure TkwEfStartupTipsShowCheckBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShowCheckBox', aCtx);
end;//TkwEfStartupTipsShowCheckBox.SetValuePrim

function TkwEfStartupTipsShowCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwEfStartupTipsShowCheckBox.GetResultTypeInfo

function TkwEfStartupTipsShowCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsShowCheckBox.GetAllParamsCount

function TkwEfStartupTipsShowCheckBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsShowCheckBox.ParamsTypes

function TkwEfStartupTipsWwwPanel.wwwPanel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtPanel;
 {* Реализация слова скрипта .TefStartupTips.wwwPanel }
begin
 Result := aefStartupTips.wwwPanel;
end;//TkwEfStartupTipsWwwPanel.wwwPanel

procedure TkwEfStartupTipsWwwPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwPanel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwPanel.DoDoIt

class function TkwEfStartupTipsWwwPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwPanel';
end;//TkwEfStartupTipsWwwPanel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству wwwPanel', aCtx);
end;//TkwEfStartupTipsWwwPanel.SetValuePrim

function TkwEfStartupTipsWwwPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfStartupTipsWwwPanel.GetResultTypeInfo

function TkwEfStartupTipsWwwPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwPanel.GetAllParamsCount

function TkwEfStartupTipsWwwPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPanel.ParamsTypes

function TkwEfStartupTipsWwwPaintBox.wwwPaintBox(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TPaintBox;
 {* Реализация слова скрипта .TefStartupTips.wwwPaintBox }
begin
 Result := aefStartupTips.wwwPaintBox;
end;//TkwEfStartupTipsWwwPaintBox.wwwPaintBox

procedure TkwEfStartupTipsWwwPaintBox.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwPaintBox(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwPaintBox.DoDoIt

class function TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwPaintBox';
end;//TkwEfStartupTipsWwwPaintBox.GetWordNameForRegister

procedure TkwEfStartupTipsWwwPaintBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству wwwPaintBox', aCtx);
end;//TkwEfStartupTipsWwwPaintBox.SetValuePrim

function TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwEfStartupTipsWwwPaintBox.GetResultTypeInfo

function TkwEfStartupTipsWwwPaintBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwPaintBox.GetAllParamsCount

function TkwEfStartupTipsWwwPaintBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwPaintBox.ParamsTypes

function TkwEfStartupTipsWwwLabel.wwwLabel(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TvtFocusLabel;
 {* Реализация слова скрипта .TefStartupTips.wwwLabel }
begin
 Result := aefStartupTips.wwwLabel;
end;//TkwEfStartupTipsWwwLabel.wwwLabel

procedure TkwEfStartupTipsWwwLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(wwwLabel(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsWwwLabel.DoDoIt

class function TkwEfStartupTipsWwwLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.wwwLabel';
end;//TkwEfStartupTipsWwwLabel.GetWordNameForRegister

procedure TkwEfStartupTipsWwwLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству wwwLabel', aCtx);
end;//TkwEfStartupTipsWwwLabel.SetValuePrim

function TkwEfStartupTipsWwwLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtFocusLabel);
end;//TkwEfStartupTipsWwwLabel.GetResultTypeInfo

function TkwEfStartupTipsWwwLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsWwwLabel.GetAllParamsCount

function TkwEfStartupTipsWwwLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsWwwLabel.ParamsTypes

function TkwEfStartupTipsNextButton.NextButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* Реализация слова скрипта .TefStartupTips.NextButton }
begin
 Result := aefStartupTips.NextButton;
end;//TkwEfStartupTipsNextButton.NextButton

procedure TkwEfStartupTipsNextButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(NextButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsNextButton.DoDoIt

class function TkwEfStartupTipsNextButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.NextButton';
end;//TkwEfStartupTipsNextButton.GetWordNameForRegister

procedure TkwEfStartupTipsNextButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству NextButton', aCtx);
end;//TkwEfStartupTipsNextButton.SetValuePrim

function TkwEfStartupTipsNextButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsNextButton.GetResultTypeInfo

function TkwEfStartupTipsNextButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsNextButton.GetAllParamsCount

function TkwEfStartupTipsNextButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsNextButton.ParamsTypes

function TkwEfStartupTipsPrevButton.PrevButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* Реализация слова скрипта .TefStartupTips.PrevButton }
begin
 Result := aefStartupTips.PrevButton;
end;//TkwEfStartupTipsPrevButton.PrevButton

procedure TkwEfStartupTipsPrevButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PrevButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsPrevButton.DoDoIt

class function TkwEfStartupTipsPrevButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.PrevButton';
end;//TkwEfStartupTipsPrevButton.GetWordNameForRegister

procedure TkwEfStartupTipsPrevButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PrevButton', aCtx);
end;//TkwEfStartupTipsPrevButton.SetValuePrim

function TkwEfStartupTipsPrevButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsPrevButton.GetResultTypeInfo

function TkwEfStartupTipsPrevButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsPrevButton.GetAllParamsCount

function TkwEfStartupTipsPrevButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsPrevButton.ParamsTypes

function TkwEfStartupTipsCloseButton.CloseButton(const aCtx: TtfwContext;
 aefStartupTips: TefStartupTips): TElPopupButton;
 {* Реализация слова скрипта .TefStartupTips.CloseButton }
begin
 Result := aefStartupTips.CloseButton;
end;//TkwEfStartupTipsCloseButton.CloseButton

procedure TkwEfStartupTipsCloseButton.DoDoIt(const aCtx: TtfwContext);
var l_aefStartupTips: TefStartupTips;
begin
 try
  l_aefStartupTips := TefStartupTips(aCtx.rEngine.PopObjAs(TefStartupTips));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefStartupTips: TefStartupTips : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseButton(aCtx, l_aefStartupTips));
end;//TkwEfStartupTipsCloseButton.DoDoIt

class function TkwEfStartupTipsCloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefStartupTips.CloseButton';
end;//TkwEfStartupTipsCloseButton.GetWordNameForRegister

procedure TkwEfStartupTipsCloseButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CloseButton', aCtx);
end;//TkwEfStartupTipsCloseButton.SetValuePrim

function TkwEfStartupTipsCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwEfStartupTipsCloseButton.GetResultTypeInfo

function TkwEfStartupTipsCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfStartupTipsCloseButton.GetAllParamsCount

function TkwEfStartupTipsCloseButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefStartupTips)]);
end;//TkwEfStartupTipsCloseButton.ParamsTypes

initialization
 Tkw_Form_StartupTips.RegisterInEngine;
 {* Регистрация Tkw_Form_StartupTips }
 Tkw_StartupTips_Control_TopPanel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TopPanel }
 Tkw_StartupTips_Control_TopPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TopPanel_Push }
 Tkw_StartupTips_Control_TitlePaintBox.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TitlePaintBox }
 Tkw_StartupTips_Control_TitlePaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TitlePaintBox_Push }
 Tkw_StartupTips_Control_TitleLabel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TitleLabel }
 Tkw_StartupTips_Control_TitleLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TitleLabel_Push }
 Tkw_StartupTips_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_BottomPanel }
 Tkw_StartupTips_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_BottomPanel_Push }
 Tkw_StartupTips_Control_HintPanel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_HintPanel }
 Tkw_StartupTips_Control_HintPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_HintPanel_Push }
 Tkw_StartupTips_Control_TipLabel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TipLabel }
 Tkw_StartupTips_Control_TipLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_TipLabel_Push }
 Tkw_StartupTips_Control_DetailLabel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_DetailLabel }
 Tkw_StartupTips_Control_DetailLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_DetailLabel_Push }
 Tkw_StartupTips_Control_ShowCheckBox.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_ShowCheckBox }
 Tkw_StartupTips_Control_ShowCheckBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_ShowCheckBox_Push }
 Tkw_StartupTips_Control_wwwPanel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwPanel }
 Tkw_StartupTips_Control_wwwPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwPanel_Push }
 Tkw_StartupTips_Control_wwwPaintBox.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwPaintBox }
 Tkw_StartupTips_Control_wwwPaintBox_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwPaintBox_Push }
 Tkw_StartupTips_Control_wwwLabel.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwLabel }
 Tkw_StartupTips_Control_wwwLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_wwwLabel_Push }
 Tkw_StartupTips_Control_NextButton.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_NextButton }
 Tkw_StartupTips_Control_NextButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_NextButton_Push }
 Tkw_StartupTips_Control_PrevButton.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_PrevButton }
 Tkw_StartupTips_Control_PrevButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_PrevButton_Push }
 Tkw_StartupTips_Control_CloseButton.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_CloseButton }
 Tkw_StartupTips_Control_CloseButton_Push.RegisterInEngine;
 {* Регистрация Tkw_StartupTips_Control_CloseButton_Push }
 TkwEfStartupTipsTopPanel.RegisterInEngine;
 {* Регистрация efStartupTips_TopPanel }
 TkwEfStartupTipsTitlePaintBox.RegisterInEngine;
 {* Регистрация efStartupTips_TitlePaintBox }
 TkwEfStartupTipsTitleLabel.RegisterInEngine;
 {* Регистрация efStartupTips_TitleLabel }
 TkwEfStartupTipsBottomPanel.RegisterInEngine;
 {* Регистрация efStartupTips_BottomPanel }
 TkwEfStartupTipsHintPanel.RegisterInEngine;
 {* Регистрация efStartupTips_HintPanel }
 TkwEfStartupTipsTipLabel.RegisterInEngine;
 {* Регистрация efStartupTips_TipLabel }
 TkwEfStartupTipsDetailLabel.RegisterInEngine;
 {* Регистрация efStartupTips_DetailLabel }
 TkwEfStartupTipsShowCheckBox.RegisterInEngine;
 {* Регистрация efStartupTips_ShowCheckBox }
 TkwEfStartupTipsWwwPanel.RegisterInEngine;
 {* Регистрация efStartupTips_wwwPanel }
 TkwEfStartupTipsWwwPaintBox.RegisterInEngine;
 {* Регистрация efStartupTips_wwwPaintBox }
 TkwEfStartupTipsWwwLabel.RegisterInEngine;
 {* Регистрация efStartupTips_wwwLabel }
 TkwEfStartupTipsNextButton.RegisterInEngine;
 {* Регистрация efStartupTips_NextButton }
 TkwEfStartupTipsPrevButton.RegisterInEngine;
 {* Регистрация efStartupTips_PrevButton }
 TkwEfStartupTipsCloseButton.RegisterInEngine;
 {* Регистрация efStartupTips_CloseButton }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefStartupTips));
 {* Регистрация типа StartupTips }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtFocusLabel));
 {* Регистрация типа TvtFocusLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
 {* Регистрация типа TvtCheckBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
