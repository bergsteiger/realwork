unit AACContentsContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AACContentsContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\AAC\AACContentsContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "AACContentsContainerKeywordsPack" MUID: (5C766280436C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtPanel
 , vtScrollBar
 , vtSizeablePanel
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , AACContentsContainer_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AACContentsContainer

 Tkw_AACContentsContainer_Control_pnBack = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnBack
----
*Пример использования*:
[code]
контрол::pnBack TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnBack

 Tkw_AACContentsContainer_Control_pnBack_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightEx

 Tkw_AACContentsContainer_Control_pnRightEx_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRightForScroll

 Tkw_AACContentsContainer_Control_pnRightForScroll_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnRight

 Tkw_AACContentsContainer_Control_pnRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlRightTop

 Tkw_AACContentsContainer_Control_pnlRightTop_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrRight

 Tkw_AACContentsContainer_Control_scrRight_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftEx

 Tkw_AACContentsContainer_Control_pnLeftEx_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeftForScroll

 Tkw_AACContentsContainer_Control_pnLeftForScroll_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnlLeftTop

 Tkw_AACContentsContainer_Control_pnlLeftTop_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_pnLeft

 Tkw_AACContentsContainer_Control_pnLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AACContentsContainer_Control_scrLeft

 Tkw_AACContentsContainer_Control_scrLeft_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* Слово скрипта .TAACContentsContainerForm.pnBack }
  private
   function pnBack(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnBack }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnBack

 TkwAACContentsContainerFormPnRightEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRightEx }
  private
   function pnRightEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRightEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRightEx

 TkwAACContentsContainerFormPnRightForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRightForScroll }
  private
   function pnRightForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRightForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRightForScroll

 TkwAACContentsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnRight }
  private
   function pnRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnRight

 TkwAACContentsContainerFormPnlRightTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnlRightTop }
  private
   function pnlRightTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnlRightTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnlRightTop

 TkwAACContentsContainerFormScrRight = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.scrRight }
  private
   function scrRight(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContentsContainerForm.scrRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormScrRight

 TkwAACContentsContainerFormPnLeftEx = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeftEx }
  private
   function pnLeftEx(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftEx }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeftEx

 TkwAACContentsContainerFormPnLeftForScroll = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeftForScroll }
  private
   function pnLeftForScroll(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftForScroll }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeftForScroll

 TkwAACContentsContainerFormPnlLeftTop = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnlLeftTop }
  private
   function pnlLeftTop(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnlLeftTop }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnlLeftTop

 TkwAACContentsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.pnLeft }
  private
   function pnLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
    {* Реализация слова скрипта .TAACContentsContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormPnLeft

 TkwAACContentsContainerFormScrLeft = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAACContentsContainerForm.scrLeft }
  private
   function scrLeft(const aCtx: TtfwContext;
    aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
    {* Реализация слова скрипта .TAACContentsContainerForm.scrLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwAACContentsContainerFormScrLeft

function Tkw_Form_AACContentsContainer.GetString: AnsiString;
begin
 Result := 'AACContentsContainerForm';
end;//Tkw_Form_AACContentsContainer.GetString

class function Tkw_Form_AACContentsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AACContentsContainer';
end;//Tkw_Form_AACContentsContainer.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnBack.GetString: AnsiString;
begin
 Result := 'pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetString

class procedure Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AACContentsContainer_Control_pnBack.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack';
end;//Tkw_AACContentsContainer_Control_pnBack.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnBack');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnBack_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBack:push';
end;//Tkw_AACContentsContainer_Control_pnBack_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightEx.GetString: AnsiString;
begin
 Result := 'pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightEx.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx';
end;//Tkw_AACContentsContainer_Control_pnRightEx.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightEx:push';
end;//Tkw_AACContentsContainer_Control_pnRightEx_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRightForScroll.GetString: AnsiString;
begin
 Result := 'pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRightForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRightForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnRightForScroll_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnRight.GetString: AnsiString;
begin
 Result := 'pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetString

class procedure Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnRight.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight';
end;//Tkw_AACContentsContainer_Control_pnRight.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnRight:push';
end;//Tkw_AACContentsContainer_Control_pnRight_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlRightTop.GetString: AnsiString;
begin
 Result := 'pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlRightTop.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop';
end;//Tkw_AACContentsContainer_Control_pnlRightTop.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlRightTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlRightTop:push';
end;//Tkw_AACContentsContainer_Control_pnlRightTop_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrRight.GetString: AnsiString;
begin
 Result := 'scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetString

class procedure Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrRight.RegisterInEngine

class function Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight';
end;//Tkw_AACContentsContainer_Control_scrRight.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrRight');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrRight_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrRight:push';
end;//Tkw_AACContentsContainer_Control_scrRight_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftEx.GetString: AnsiString;
begin
 Result := 'pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AACContentsContainer_Control_pnLeftEx.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx';
end;//Tkw_AACContentsContainer_Control_pnLeftEx.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftEx');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftEx:push';
end;//Tkw_AACContentsContainer_Control_pnLeftEx_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString: AnsiString;
begin
 Result := 'pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeftForScroll');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeftForScroll:push';
end;//Tkw_AACContentsContainer_Control_pnLeftForScroll_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnlLeftTop.GetString: AnsiString;
begin
 Result := 'pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetString

class procedure Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlLeftTop');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlLeftTop:push';
end;//Tkw_AACContentsContainer_Control_pnlLeftTop_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_pnLeft.GetString: AnsiString;
begin
 Result := 'pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetString

class procedure Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AACContentsContainer_Control_pnLeft.RegisterInEngine

class function Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft';
end;//Tkw_AACContentsContainer_Control_pnLeft.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnLeft:push';
end;//Tkw_AACContentsContainer_Control_pnLeft_Push.GetWordNameForRegister

function Tkw_AACContentsContainer_Control_scrLeft.GetString: AnsiString;
begin
 Result := 'scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetString

class procedure Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtScrollBar);
end;//Tkw_AACContentsContainer_Control_scrLeft.RegisterInEngine

class function Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft';
end;//Tkw_AACContentsContainer_Control_scrLeft.GetWordNameForRegister

procedure Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('scrLeft');
 inherited;
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.DoDoIt

class function Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::scrLeft:push';
end;//Tkw_AACContentsContainer_Control_scrLeft_Push.GetWordNameForRegister

function TkwAACContentsContainerFormPnBack.pnBack(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnBack }
begin
 Result := aAACContentsContainerForm.pnBack;
end;//TkwAACContentsContainerFormPnBack.pnBack

procedure TkwAACContentsContainerFormPnBack.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnBack(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnBack.DoDoIt

class function TkwAACContentsContainerFormPnBack.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnBack';
end;//TkwAACContentsContainerFormPnBack.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnBack.ParamsTypes

procedure TkwAACContentsContainerFormPnBack.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnBack', aCtx);
end;//TkwAACContentsContainerFormPnBack.SetValuePrim

function TkwAACContentsContainerFormPnRightEx.pnRightEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRightEx }
begin
 Result := aAACContentsContainerForm.pnRightEx;
end;//TkwAACContentsContainerFormPnRightEx.pnRightEx

procedure TkwAACContentsContainerFormPnRightEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightEx(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRightEx.DoDoIt

class function TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightEx';
end;//TkwAACContentsContainerFormPnRightEx.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightEx.ParamsTypes

procedure TkwAACContentsContainerFormPnRightEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightEx', aCtx);
end;//TkwAACContentsContainerFormPnRightEx.SetValuePrim

function TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRightForScroll }
begin
 Result := aAACContentsContainerForm.pnRightForScroll;
end;//TkwAACContentsContainerFormPnRightForScroll.pnRightForScroll

procedure TkwAACContentsContainerFormPnRightForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRightForScroll(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRightForScroll.DoDoIt

class function TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRightForScroll';
end;//TkwAACContentsContainerFormPnRightForScroll.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRightForScroll.ParamsTypes

procedure TkwAACContentsContainerFormPnRightForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRightForScroll', aCtx);
end;//TkwAACContentsContainerFormPnRightForScroll.SetValuePrim

function TkwAACContentsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnRight }
begin
 Result := aAACContentsContainerForm.pnRight;
end;//TkwAACContentsContainerFormPnRight.pnRight

procedure TkwAACContentsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnRight(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnRight.DoDoIt

class function TkwAACContentsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnRight';
end;//TkwAACContentsContainerFormPnRight.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnRight.ParamsTypes

procedure TkwAACContentsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnRight', aCtx);
end;//TkwAACContentsContainerFormPnRight.SetValuePrim

function TkwAACContentsContainerFormPnlRightTop.pnlRightTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnlRightTop }
begin
 Result := aAACContentsContainerForm.pnlRightTop;
end;//TkwAACContentsContainerFormPnlRightTop.pnlRightTop

procedure TkwAACContentsContainerFormPnlRightTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlRightTop(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnlRightTop.DoDoIt

class function TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlRightTop';
end;//TkwAACContentsContainerFormPnlRightTop.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlRightTop.ParamsTypes

procedure TkwAACContentsContainerFormPnlRightTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlRightTop', aCtx);
end;//TkwAACContentsContainerFormPnlRightTop.SetValuePrim

function TkwAACContentsContainerFormScrRight.scrRight(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContentsContainerForm.scrRight }
begin
 Result := aAACContentsContainerForm.scrRight;
end;//TkwAACContentsContainerFormScrRight.scrRight

procedure TkwAACContentsContainerFormScrRight.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrRight(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormScrRight.DoDoIt

class function TkwAACContentsContainerFormScrRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrRight';
end;//TkwAACContentsContainerFormScrRight.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrRight.ParamsTypes

procedure TkwAACContentsContainerFormScrRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrRight', aCtx);
end;//TkwAACContentsContainerFormScrRight.SetValuePrim

function TkwAACContentsContainerFormPnLeftEx.pnLeftEx(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftEx }
begin
 Result := aAACContentsContainerForm.pnLeftEx;
end;//TkwAACContentsContainerFormPnLeftEx.pnLeftEx

procedure TkwAACContentsContainerFormPnLeftEx.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftEx(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeftEx.DoDoIt

class function TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftEx';
end;//TkwAACContentsContainerFormPnLeftEx.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftEx.ParamsTypes

procedure TkwAACContentsContainerFormPnLeftEx.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftEx', aCtx);
end;//TkwAACContentsContainerFormPnLeftEx.SetValuePrim

function TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeftForScroll }
begin
 Result := aAACContentsContainerForm.pnLeftForScroll;
end;//TkwAACContentsContainerFormPnLeftForScroll.pnLeftForScroll

procedure TkwAACContentsContainerFormPnLeftForScroll.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeftForScroll(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeftForScroll.DoDoIt

class function TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeftForScroll';
end;//TkwAACContentsContainerFormPnLeftForScroll.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeftForScroll.ParamsTypes

procedure TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeftForScroll', aCtx);
end;//TkwAACContentsContainerFormPnLeftForScroll.SetValuePrim

function TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnlLeftTop }
begin
 Result := aAACContentsContainerForm.pnlLeftTop;
end;//TkwAACContentsContainerFormPnlLeftTop.pnlLeftTop

procedure TkwAACContentsContainerFormPnlLeftTop.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlLeftTop(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnlLeftTop.DoDoIt

class function TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnlLeftTop';
end;//TkwAACContentsContainerFormPnlLeftTop.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnlLeftTop.ParamsTypes

procedure TkwAACContentsContainerFormPnlLeftTop.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlLeftTop', aCtx);
end;//TkwAACContentsContainerFormPnlLeftTop.SetValuePrim

function TkwAACContentsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtPanel;
 {* Реализация слова скрипта .TAACContentsContainerForm.pnLeft }
begin
 Result := aAACContentsContainerForm.pnLeft;
end;//TkwAACContentsContainerFormPnLeft.pnLeft

procedure TkwAACContentsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnLeft(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormPnLeft.DoDoIt

class function TkwAACContentsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.pnLeft';
end;//TkwAACContentsContainerFormPnLeft.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormPnLeft.ParamsTypes

procedure TkwAACContentsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnLeft', aCtx);
end;//TkwAACContentsContainerFormPnLeft.SetValuePrim

function TkwAACContentsContainerFormScrLeft.scrLeft(const aCtx: TtfwContext;
 aAACContentsContainerForm: TAACContentsContainerForm): TvtScrollBar;
 {* Реализация слова скрипта .TAACContentsContainerForm.scrLeft }
begin
 Result := aAACContentsContainerForm.scrLeft;
end;//TkwAACContentsContainerFormScrLeft.scrLeft

procedure TkwAACContentsContainerFormScrLeft.DoDoIt(const aCtx: TtfwContext);
var l_aAACContentsContainerForm: TAACContentsContainerForm;
begin
 try
  l_aAACContentsContainerForm := TAACContentsContainerForm(aCtx.rEngine.PopObjAs(TAACContentsContainerForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aAACContentsContainerForm: TAACContentsContainerForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(scrLeft(aCtx, l_aAACContentsContainerForm));
end;//TkwAACContentsContainerFormScrLeft.DoDoIt

class function TkwAACContentsContainerFormScrLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAACContentsContainerForm.scrLeft';
end;//TkwAACContentsContainerFormScrLeft.GetWordNameForRegister

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
 Result := OpenTypesToTypes([TypeInfo(TAACContentsContainerForm)]);
end;//TkwAACContentsContainerFormScrLeft.ParamsTypes

procedure TkwAACContentsContainerFormScrLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству scrLeft', aCtx);
end;//TkwAACContentsContainerFormScrLeft.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAACContentsContainerForm));
 {* Регистрация типа TAACContentsContainerForm }
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
