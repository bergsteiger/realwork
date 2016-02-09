unit ShutDownKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ShutDown }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\ShutDownKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimCommon_Module
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtPanel
 , vtLabel
 , vtButton
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_ShutDown = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ShutDown
----
*Пример использования*:
[code]
'aControl' форма::ShutDown TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ShutDown

 Tkw_ShutDown_Component_ShutdownTimer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ShutdownTimer
----
*Пример использования*:
[code]
компонент::ShutdownTimer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Component_ShutdownTimer

 Tkw_ShutDown_Control_vtPanel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_vtPanel1

 Tkw_ShutDown_Control_vtPanel1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_vtPanel1_Push

 Tkw_ShutDown_Control_LeftPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола LeftPanel
----
*Пример использования*:
[code]
контрол::LeftPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_LeftPanel

 Tkw_ShutDown_Control_LeftPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftPanel
----
*Пример использования*:
[code]
контрол::LeftPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_LeftPanel_Push

 Tkw_ShutDown_Control_Image = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола Image
----
*Пример использования*:
[code]
контрол::Image TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_Image

 Tkw_ShutDown_Control_Image_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Image
----
*Пример использования*:
[code]
контрол::Image:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_Image_Push

 Tkw_ShutDown_Control_CenterPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола CenterPanel
----
*Пример использования*:
[code]
контрол::CenterPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_CenterPanel

 Tkw_ShutDown_Control_CenterPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CenterPanel
----
*Пример использования*:
[code]
контрол::CenterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CenterPanel_Push

 Tkw_ShutDown_Control_TopSpacerPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TopSpacerPanel
----
*Пример использования*:
[code]
контрол::TopSpacerPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_TopSpacerPanel

 Tkw_ShutDown_Control_TopSpacerPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола TopSpacerPanel
----
*Пример использования*:
[code]
контрол::TopSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_TopSpacerPanel_Push

 Tkw_ShutDown_Control_WarningText = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WarningText
----
*Пример использования*:
[code]
контрол::WarningText TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_WarningText

 Tkw_ShutDown_Control_WarningText_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WarningText
----
*Пример использования*:
[code]
контрол::WarningText:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_WarningText_Push

 Tkw_ShutDown_Control_RightSpacerPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола RightSpacerPanel
----
*Пример использования*:
[code]
контрол::RightSpacerPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_RightSpacerPanel

 Tkw_ShutDown_Control_RightSpacerPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола RightSpacerPanel
----
*Пример использования*:
[code]
контрол::RightSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_RightSpacerPanel_Push

 Tkw_ShutDown_Control_pnlBottom = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_pnlBottom

 Tkw_ShutDown_Control_pnlBottom_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnlBottom
----
*Пример использования*:
[code]
контрол::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_pnlBottom_Push

 Tkw_ShutDown_Control_CloseButton = {final} class(TtfwControlString)
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
 end;//Tkw_ShutDown_Control_CloseButton

 Tkw_ShutDown_Control_CloseButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола CloseButton
----
*Пример использования*:
[code]
контрол::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CloseButton_Push

 TkwShutDownFormShutdownTimer = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.ShutdownTimer
[panel]Контрол ShutdownTimer формы TShutDownForm[panel]
*Тип результата:* TTimer
*Пример:*
[code]
OBJECT VAR l_TTimer
 aShutDownForm .TShutDownForm.ShutdownTimer >>> l_TTimer
[code]  }
  private
   function ShutdownTimer(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TTimer;
    {* Реализация слова скрипта .TShutDownForm.ShutdownTimer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormShutdownTimer

 TkwShutDownFormVtPanel1 = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.vtPanel1
[panel]Контрол vtPanel1 формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.vtPanel1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormVtPanel1

 TkwShutDownFormLeftPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.LeftPanel
[panel]Контрол LeftPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.LeftPanel >>> l_TvtPanel
[code]  }
  private
   function LeftPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.LeftPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormLeftPanel

 TkwShutDownFormImage = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.Image
[panel]Контрол Image формы TShutDownForm[panel]
*Тип результата:* TImage
*Пример:*
[code]
OBJECT VAR l_TImage
 aShutDownForm .TShutDownForm.Image >>> l_TImage
[code]  }
  private
   function Image(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TImage;
    {* Реализация слова скрипта .TShutDownForm.Image }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormImage

 TkwShutDownFormCenterPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.CenterPanel
[panel]Контрол CenterPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.CenterPanel >>> l_TvtPanel
[code]  }
  private
   function CenterPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.CenterPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormCenterPanel

 TkwShutDownFormTopSpacerPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.TopSpacerPanel
[panel]Контрол TopSpacerPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.TopSpacerPanel >>> l_TvtPanel
[code]  }
  private
   function TopSpacerPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.TopSpacerPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormTopSpacerPanel

 TkwShutDownFormWarningText = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.WarningText
[panel]Контрол WarningText формы TShutDownForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aShutDownForm .TShutDownForm.WarningText >>> l_TvtLabel
[code]  }
  private
   function WarningText(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtLabel;
    {* Реализация слова скрипта .TShutDownForm.WarningText }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormWarningText

 TkwShutDownFormRightSpacerPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.RightSpacerPanel
[panel]Контрол RightSpacerPanel формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.RightSpacerPanel >>> l_TvtPanel
[code]  }
  private
   function RightSpacerPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.RightSpacerPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormRightSpacerPanel

 TkwShutDownFormPnlBottom = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.pnlBottom
[panel]Контрол pnlBottom формы TShutDownForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* Реализация слова скрипта .TShutDownForm.pnlBottom }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormPnlBottom

 TkwShutDownFormCloseButton = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TShutDownForm.CloseButton
[panel]Контрол CloseButton формы TShutDownForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aShutDownForm .TShutDownForm.CloseButton >>> l_TvtButton
[code]  }
  private
   function CloseButton(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtButton;
    {* Реализация слова скрипта .TShutDownForm.CloseButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwShutDownFormCloseButton

class function Tkw_Form_ShutDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ShutDown';
end;//Tkw_Form_ShutDown.GetWordNameForRegister

function Tkw_Form_ShutDown.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D482E48B82F8_var*
//#UC END# *4DDFD2EA0116_D482E48B82F8_var*
begin
//#UC START# *4DDFD2EA0116_D482E48B82F8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D482E48B82F8_impl*
end;//Tkw_Form_ShutDown.GetString

class function Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister

function Tkw_ShutDown_Component_ShutdownTimer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1D2C13E70A44_var*
//#UC END# *4DDFD2EA0116_1D2C13E70A44_var*
begin
//#UC START# *4DDFD2EA0116_1D2C13E70A44_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1D2C13E70A44_impl*
end;//Tkw_ShutDown_Component_ShutdownTimer.GetString

class procedure Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
//#UC START# *52A086150180_1D2C13E70A44_var*
//#UC END# *52A086150180_1D2C13E70A44_var*
begin
//#UC START# *52A086150180_1D2C13E70A44_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1D2C13E70A44_impl*
end;//Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine

class function Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister

function Tkw_ShutDown_Control_vtPanel1.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_506FB9C4AE9E_var*
//#UC END# *4DDFD2EA0116_506FB9C4AE9E_var*
begin
//#UC START# *4DDFD2EA0116_506FB9C4AE9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_506FB9C4AE9E_impl*
end;//Tkw_ShutDown_Control_vtPanel1.GetString

class procedure Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
//#UC START# *52A086150180_506FB9C4AE9E_var*
//#UC END# *52A086150180_506FB9C4AE9E_var*
begin
//#UC START# *52A086150180_506FB9C4AE9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_506FB9C4AE9E_impl*
end;//Tkw_ShutDown_Control_vtPanel1.RegisterInEngine

procedure Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BC834AFD97D9_var*
//#UC END# *4DAEEDE10285_BC834AFD97D9_var*
begin
//#UC START# *4DAEEDE10285_BC834AFD97D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BC834AFD97D9_impl*
end;//Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt

class function Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtPanel1:push';
end;//Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_LeftPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_4406F66A6769_var*
//#UC END# *4DDFD2EA0116_4406F66A6769_var*
begin
//#UC START# *4DDFD2EA0116_4406F66A6769_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_4406F66A6769_impl*
end;//Tkw_ShutDown_Control_LeftPanel.GetString

class procedure Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
//#UC START# *52A086150180_4406F66A6769_var*
//#UC END# *52A086150180_4406F66A6769_var*
begin
//#UC START# *52A086150180_4406F66A6769_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_4406F66A6769_impl*
end;//Tkw_ShutDown_Control_LeftPanel.RegisterInEngine

procedure Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CC6E30846E09_var*
//#UC END# *4DAEEDE10285_CC6E30846E09_var*
begin
//#UC START# *4DAEEDE10285_CC6E30846E09_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CC6E30846E09_impl*
end;//Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel:push';
end;//Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_Image.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image';
end;//Tkw_ShutDown_Control_Image.GetWordNameForRegister

function Tkw_ShutDown_Control_Image.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_65FA8501C473_var*
//#UC END# *4DDFD2EA0116_65FA8501C473_var*
begin
//#UC START# *4DDFD2EA0116_65FA8501C473_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_65FA8501C473_impl*
end;//Tkw_ShutDown_Control_Image.GetString

class procedure Tkw_ShutDown_Control_Image.RegisterInEngine;
//#UC START# *52A086150180_65FA8501C473_var*
//#UC END# *52A086150180_65FA8501C473_var*
begin
//#UC START# *52A086150180_65FA8501C473_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_65FA8501C473_impl*
end;//Tkw_ShutDown_Control_Image.RegisterInEngine

procedure Tkw_ShutDown_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E8C12B6EF28C_var*
//#UC END# *4DAEEDE10285_E8C12B6EF28C_var*
begin
//#UC START# *4DAEEDE10285_E8C12B6EF28C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E8C12B6EF28C_impl*
end;//Tkw_ShutDown_Control_Image_Push.DoDoIt

class function Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image:push';
end;//Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_CenterPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_74F5B3CD8745_var*
//#UC END# *4DDFD2EA0116_74F5B3CD8745_var*
begin
//#UC START# *4DDFD2EA0116_74F5B3CD8745_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_74F5B3CD8745_impl*
end;//Tkw_ShutDown_Control_CenterPanel.GetString

class procedure Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
//#UC START# *52A086150180_74F5B3CD8745_var*
//#UC END# *52A086150180_74F5B3CD8745_var*
begin
//#UC START# *52A086150180_74F5B3CD8745_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_74F5B3CD8745_impl*
end;//Tkw_ShutDown_Control_CenterPanel.RegisterInEngine

procedure Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76E4DB6B7EE5_var*
//#UC END# *4DAEEDE10285_76E4DB6B7EE5_var*
begin
//#UC START# *4DAEEDE10285_76E4DB6B7EE5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_76E4DB6B7EE5_impl*
end;//Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CenterPanel:push';
end;//Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_TopSpacerPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FD2D24E3E7B3_var*
//#UC END# *4DDFD2EA0116_FD2D24E3E7B3_var*
begin
//#UC START# *4DDFD2EA0116_FD2D24E3E7B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FD2D24E3E7B3_impl*
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
//#UC START# *52A086150180_FD2D24E3E7B3_var*
//#UC END# *52A086150180_FD2D24E3E7B3_var*
begin
//#UC START# *52A086150180_FD2D24E3E7B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_FD2D24E3E7B3_impl*
end;//Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine

procedure Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E5D919676EED_var*
//#UC END# *4DAEEDE10285_E5D919676EED_var*
begin
//#UC START# *4DAEEDE10285_E5D919676EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E5D919676EED_impl*
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopSpacerPanel:push';
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_WarningText.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetWordNameForRegister

function Tkw_ShutDown_Control_WarningText.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EEA83BB79FD4_var*
//#UC END# *4DDFD2EA0116_EEA83BB79FD4_var*
begin
//#UC START# *4DDFD2EA0116_EEA83BB79FD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EEA83BB79FD4_impl*
end;//Tkw_ShutDown_Control_WarningText.GetString

class procedure Tkw_ShutDown_Control_WarningText.RegisterInEngine;
//#UC START# *52A086150180_EEA83BB79FD4_var*
//#UC END# *52A086150180_EEA83BB79FD4_var*
begin
//#UC START# *52A086150180_EEA83BB79FD4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EEA83BB79FD4_impl*
end;//Tkw_ShutDown_Control_WarningText.RegisterInEngine

procedure Tkw_ShutDown_Control_WarningText_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_69D7D9B24E5D_var*
//#UC END# *4DAEEDE10285_69D7D9B24E5D_var*
begin
//#UC START# *4DAEEDE10285_69D7D9B24E5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_69D7D9B24E5D_impl*
end;//Tkw_ShutDown_Control_WarningText_Push.DoDoIt

class function Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarningText:push';
end;//Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_RightSpacerPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1F02004AC237_var*
//#UC END# *4DDFD2EA0116_1F02004AC237_var*
begin
//#UC START# *4DDFD2EA0116_1F02004AC237_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1F02004AC237_impl*
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
//#UC START# *52A086150180_1F02004AC237_var*
//#UC END# *52A086150180_1F02004AC237_var*
begin
//#UC START# *52A086150180_1F02004AC237_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1F02004AC237_impl*
end;//Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine

procedure Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_67B257456FD1_var*
//#UC END# *4DAEEDE10285_67B257456FD1_var*
begin
//#UC START# *4DAEEDE10285_67B257456FD1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_67B257456FD1_impl*
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightSpacerPanel:push';
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister

function Tkw_ShutDown_Control_pnlBottom.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_32A0050AEA5C_var*
//#UC END# *4DDFD2EA0116_32A0050AEA5C_var*
begin
//#UC START# *4DDFD2EA0116_32A0050AEA5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_32A0050AEA5C_impl*
end;//Tkw_ShutDown_Control_pnlBottom.GetString

class procedure Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
//#UC START# *52A086150180_32A0050AEA5C_var*
//#UC END# *52A086150180_32A0050AEA5C_var*
begin
//#UC START# *52A086150180_32A0050AEA5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_32A0050AEA5C_impl*
end;//Tkw_ShutDown_Control_pnlBottom.RegisterInEngine

procedure Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_28192EC3DA32_var*
//#UC END# *4DAEEDE10285_28192EC3DA32_var*
begin
//#UC START# *4DAEEDE10285_28192EC3DA32_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_28192EC3DA32_impl*
end;//Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt

class function Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBottom:push';
end;//Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister

function Tkw_ShutDown_Control_CloseButton.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7300B472659A_var*
//#UC END# *4DDFD2EA0116_7300B472659A_var*
begin
//#UC START# *4DDFD2EA0116_7300B472659A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7300B472659A_impl*
end;//Tkw_ShutDown_Control_CloseButton.GetString

class procedure Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
//#UC START# *52A086150180_7300B472659A_var*
//#UC END# *52A086150180_7300B472659A_var*
begin
//#UC START# *52A086150180_7300B472659A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7300B472659A_impl*
end;//Tkw_ShutDown_Control_CloseButton.RegisterInEngine

procedure Tkw_ShutDown_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E77AE64103D9_var*
//#UC END# *4DAEEDE10285_E77AE64103D9_var*
begin
//#UC START# *4DAEEDE10285_E77AE64103D9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E77AE64103D9_impl*
end;//Tkw_ShutDown_Control_CloseButton_Push.DoDoIt

class function Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton:push';
end;//Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister

function TkwShutDownFormShutdownTimer.ShutdownTimer(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TTimer;
 {* Реализация слова скрипта .TShutDownForm.ShutdownTimer }
//#UC START# *C81ECD7469A3_DE97E923CA92_var*
//#UC END# *C81ECD7469A3_DE97E923CA92_var*
begin
//#UC START# *C81ECD7469A3_DE97E923CA92_impl*
 !!! Needs to be implemented !!!
//#UC END# *C81ECD7469A3_DE97E923CA92_impl*
end;//TkwShutDownFormShutdownTimer.ShutdownTimer

procedure TkwShutDownFormShutdownTimer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DE97E923CA92_var*
//#UC END# *4DAEEDE10285_DE97E923CA92_var*
begin
//#UC START# *4DAEEDE10285_DE97E923CA92_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DE97E923CA92_impl*
end;//TkwShutDownFormShutdownTimer.DoDoIt

class function TkwShutDownFormShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.ShutdownTimer';
end;//TkwShutDownFormShutdownTimer.GetWordNameForRegister

procedure TkwShutDownFormShutdownTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_DE97E923CA92_var*
//#UC END# *52D00B00031A_DE97E923CA92_var*
begin
//#UC START# *52D00B00031A_DE97E923CA92_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_DE97E923CA92_impl*
end;//TkwShutDownFormShutdownTimer.SetValuePrim

function TkwShutDownFormShutdownTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DE97E923CA92_var*
//#UC END# *551544E2001A_DE97E923CA92_var*
begin
//#UC START# *551544E2001A_DE97E923CA92_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DE97E923CA92_impl*
end;//TkwShutDownFormShutdownTimer.GetResultTypeInfo

function TkwShutDownFormShutdownTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormShutdownTimer.GetAllParamsCount

function TkwShutDownFormShutdownTimer.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DE97E923CA92_var*
//#UC END# *5617F4D00243_DE97E923CA92_var*
begin
//#UC START# *5617F4D00243_DE97E923CA92_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DE97E923CA92_impl*
end;//TkwShutDownFormShutdownTimer.ParamsTypes

function TkwShutDownFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.vtPanel1 }
//#UC START# *E9A2917D3A16_158CF0E1A25F_var*
//#UC END# *E9A2917D3A16_158CF0E1A25F_var*
begin
//#UC START# *E9A2917D3A16_158CF0E1A25F_impl*
 !!! Needs to be implemented !!!
//#UC END# *E9A2917D3A16_158CF0E1A25F_impl*
end;//TkwShutDownFormVtPanel1.vtPanel1

procedure TkwShutDownFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_158CF0E1A25F_var*
//#UC END# *4DAEEDE10285_158CF0E1A25F_var*
begin
//#UC START# *4DAEEDE10285_158CF0E1A25F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_158CF0E1A25F_impl*
end;//TkwShutDownFormVtPanel1.DoDoIt

class function TkwShutDownFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.vtPanel1';
end;//TkwShutDownFormVtPanel1.GetWordNameForRegister

procedure TkwShutDownFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_158CF0E1A25F_var*
//#UC END# *52D00B00031A_158CF0E1A25F_var*
begin
//#UC START# *52D00B00031A_158CF0E1A25F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_158CF0E1A25F_impl*
end;//TkwShutDownFormVtPanel1.SetValuePrim

function TkwShutDownFormVtPanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_158CF0E1A25F_var*
//#UC END# *551544E2001A_158CF0E1A25F_var*
begin
//#UC START# *551544E2001A_158CF0E1A25F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_158CF0E1A25F_impl*
end;//TkwShutDownFormVtPanel1.GetResultTypeInfo

function TkwShutDownFormVtPanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormVtPanel1.GetAllParamsCount

function TkwShutDownFormVtPanel1.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_158CF0E1A25F_var*
//#UC END# *5617F4D00243_158CF0E1A25F_var*
begin
//#UC START# *5617F4D00243_158CF0E1A25F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_158CF0E1A25F_impl*
end;//TkwShutDownFormVtPanel1.ParamsTypes

function TkwShutDownFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.LeftPanel }
//#UC START# *EAD26D650C81_59E9C9B4EA9C_var*
//#UC END# *EAD26D650C81_59E9C9B4EA9C_var*
begin
//#UC START# *EAD26D650C81_59E9C9B4EA9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *EAD26D650C81_59E9C9B4EA9C_impl*
end;//TkwShutDownFormLeftPanel.LeftPanel

procedure TkwShutDownFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_59E9C9B4EA9C_var*
//#UC END# *4DAEEDE10285_59E9C9B4EA9C_var*
begin
//#UC START# *4DAEEDE10285_59E9C9B4EA9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_59E9C9B4EA9C_impl*
end;//TkwShutDownFormLeftPanel.DoDoIt

class function TkwShutDownFormLeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.LeftPanel';
end;//TkwShutDownFormLeftPanel.GetWordNameForRegister

procedure TkwShutDownFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_59E9C9B4EA9C_var*
//#UC END# *52D00B00031A_59E9C9B4EA9C_var*
begin
//#UC START# *52D00B00031A_59E9C9B4EA9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_59E9C9B4EA9C_impl*
end;//TkwShutDownFormLeftPanel.SetValuePrim

function TkwShutDownFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_59E9C9B4EA9C_var*
//#UC END# *551544E2001A_59E9C9B4EA9C_var*
begin
//#UC START# *551544E2001A_59E9C9B4EA9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_59E9C9B4EA9C_impl*
end;//TkwShutDownFormLeftPanel.GetResultTypeInfo

function TkwShutDownFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormLeftPanel.GetAllParamsCount

function TkwShutDownFormLeftPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_59E9C9B4EA9C_var*
//#UC END# *5617F4D00243_59E9C9B4EA9C_var*
begin
//#UC START# *5617F4D00243_59E9C9B4EA9C_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_59E9C9B4EA9C_impl*
end;//TkwShutDownFormLeftPanel.ParamsTypes

function TkwShutDownFormImage.Image(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TImage;
 {* Реализация слова скрипта .TShutDownForm.Image }
//#UC START# *AA20C3236153_E7709C854526_var*
//#UC END# *AA20C3236153_E7709C854526_var*
begin
//#UC START# *AA20C3236153_E7709C854526_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA20C3236153_E7709C854526_impl*
end;//TkwShutDownFormImage.Image

procedure TkwShutDownFormImage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7709C854526_var*
//#UC END# *4DAEEDE10285_E7709C854526_var*
begin
//#UC START# *4DAEEDE10285_E7709C854526_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7709C854526_impl*
end;//TkwShutDownFormImage.DoDoIt

class function TkwShutDownFormImage.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.Image';
end;//TkwShutDownFormImage.GetWordNameForRegister

procedure TkwShutDownFormImage.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E7709C854526_var*
//#UC END# *52D00B00031A_E7709C854526_var*
begin
//#UC START# *52D00B00031A_E7709C854526_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E7709C854526_impl*
end;//TkwShutDownFormImage.SetValuePrim

function TkwShutDownFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E7709C854526_var*
//#UC END# *551544E2001A_E7709C854526_var*
begin
//#UC START# *551544E2001A_E7709C854526_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E7709C854526_impl*
end;//TkwShutDownFormImage.GetResultTypeInfo

function TkwShutDownFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormImage.GetAllParamsCount

function TkwShutDownFormImage.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E7709C854526_var*
//#UC END# *5617F4D00243_E7709C854526_var*
begin
//#UC START# *5617F4D00243_E7709C854526_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E7709C854526_impl*
end;//TkwShutDownFormImage.ParamsTypes

function TkwShutDownFormCenterPanel.CenterPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.CenterPanel }
//#UC START# *345187A27894_656B67C7EC87_var*
//#UC END# *345187A27894_656B67C7EC87_var*
begin
//#UC START# *345187A27894_656B67C7EC87_impl*
 !!! Needs to be implemented !!!
//#UC END# *345187A27894_656B67C7EC87_impl*
end;//TkwShutDownFormCenterPanel.CenterPanel

procedure TkwShutDownFormCenterPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_656B67C7EC87_var*
//#UC END# *4DAEEDE10285_656B67C7EC87_var*
begin
//#UC START# *4DAEEDE10285_656B67C7EC87_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_656B67C7EC87_impl*
end;//TkwShutDownFormCenterPanel.DoDoIt

class function TkwShutDownFormCenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CenterPanel';
end;//TkwShutDownFormCenterPanel.GetWordNameForRegister

procedure TkwShutDownFormCenterPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_656B67C7EC87_var*
//#UC END# *52D00B00031A_656B67C7EC87_var*
begin
//#UC START# *52D00B00031A_656B67C7EC87_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_656B67C7EC87_impl*
end;//TkwShutDownFormCenterPanel.SetValuePrim

function TkwShutDownFormCenterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_656B67C7EC87_var*
//#UC END# *551544E2001A_656B67C7EC87_var*
begin
//#UC START# *551544E2001A_656B67C7EC87_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_656B67C7EC87_impl*
end;//TkwShutDownFormCenterPanel.GetResultTypeInfo

function TkwShutDownFormCenterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormCenterPanel.GetAllParamsCount

function TkwShutDownFormCenterPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_656B67C7EC87_var*
//#UC END# *5617F4D00243_656B67C7EC87_var*
begin
//#UC START# *5617F4D00243_656B67C7EC87_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_656B67C7EC87_impl*
end;//TkwShutDownFormCenterPanel.ParamsTypes

function TkwShutDownFormTopSpacerPanel.TopSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.TopSpacerPanel }
//#UC START# *2B4B510F023C_00128E113C54_var*
//#UC END# *2B4B510F023C_00128E113C54_var*
begin
//#UC START# *2B4B510F023C_00128E113C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *2B4B510F023C_00128E113C54_impl*
end;//TkwShutDownFormTopSpacerPanel.TopSpacerPanel

procedure TkwShutDownFormTopSpacerPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_00128E113C54_var*
//#UC END# *4DAEEDE10285_00128E113C54_var*
begin
//#UC START# *4DAEEDE10285_00128E113C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_00128E113C54_impl*
end;//TkwShutDownFormTopSpacerPanel.DoDoIt

class function TkwShutDownFormTopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.TopSpacerPanel';
end;//TkwShutDownFormTopSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormTopSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_00128E113C54_var*
//#UC END# *52D00B00031A_00128E113C54_var*
begin
//#UC START# *52D00B00031A_00128E113C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_00128E113C54_impl*
end;//TkwShutDownFormTopSpacerPanel.SetValuePrim

function TkwShutDownFormTopSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_00128E113C54_var*
//#UC END# *551544E2001A_00128E113C54_var*
begin
//#UC START# *551544E2001A_00128E113C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_00128E113C54_impl*
end;//TkwShutDownFormTopSpacerPanel.GetResultTypeInfo

function TkwShutDownFormTopSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormTopSpacerPanel.GetAllParamsCount

function TkwShutDownFormTopSpacerPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_00128E113C54_var*
//#UC END# *5617F4D00243_00128E113C54_var*
begin
//#UC START# *5617F4D00243_00128E113C54_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_00128E113C54_impl*
end;//TkwShutDownFormTopSpacerPanel.ParamsTypes

function TkwShutDownFormWarningText.WarningText(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtLabel;
 {* Реализация слова скрипта .TShutDownForm.WarningText }
//#UC START# *747D110BD723_3CE1A3888F23_var*
//#UC END# *747D110BD723_3CE1A3888F23_var*
begin
//#UC START# *747D110BD723_3CE1A3888F23_impl*
 !!! Needs to be implemented !!!
//#UC END# *747D110BD723_3CE1A3888F23_impl*
end;//TkwShutDownFormWarningText.WarningText

procedure TkwShutDownFormWarningText.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3CE1A3888F23_var*
//#UC END# *4DAEEDE10285_3CE1A3888F23_var*
begin
//#UC START# *4DAEEDE10285_3CE1A3888F23_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3CE1A3888F23_impl*
end;//TkwShutDownFormWarningText.DoDoIt

class function TkwShutDownFormWarningText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.WarningText';
end;//TkwShutDownFormWarningText.GetWordNameForRegister

procedure TkwShutDownFormWarningText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_3CE1A3888F23_var*
//#UC END# *52D00B00031A_3CE1A3888F23_var*
begin
//#UC START# *52D00B00031A_3CE1A3888F23_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_3CE1A3888F23_impl*
end;//TkwShutDownFormWarningText.SetValuePrim

function TkwShutDownFormWarningText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_3CE1A3888F23_var*
//#UC END# *551544E2001A_3CE1A3888F23_var*
begin
//#UC START# *551544E2001A_3CE1A3888F23_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_3CE1A3888F23_impl*
end;//TkwShutDownFormWarningText.GetResultTypeInfo

function TkwShutDownFormWarningText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormWarningText.GetAllParamsCount

function TkwShutDownFormWarningText.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_3CE1A3888F23_var*
//#UC END# *5617F4D00243_3CE1A3888F23_var*
begin
//#UC START# *5617F4D00243_3CE1A3888F23_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_3CE1A3888F23_impl*
end;//TkwShutDownFormWarningText.ParamsTypes

function TkwShutDownFormRightSpacerPanel.RightSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.RightSpacerPanel }
//#UC START# *AA3DCE1FF5B2_C2796C4F6F52_var*
//#UC END# *AA3DCE1FF5B2_C2796C4F6F52_var*
begin
//#UC START# *AA3DCE1FF5B2_C2796C4F6F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *AA3DCE1FF5B2_C2796C4F6F52_impl*
end;//TkwShutDownFormRightSpacerPanel.RightSpacerPanel

procedure TkwShutDownFormRightSpacerPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C2796C4F6F52_var*
//#UC END# *4DAEEDE10285_C2796C4F6F52_var*
begin
//#UC START# *4DAEEDE10285_C2796C4F6F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C2796C4F6F52_impl*
end;//TkwShutDownFormRightSpacerPanel.DoDoIt

class function TkwShutDownFormRightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.RightSpacerPanel';
end;//TkwShutDownFormRightSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormRightSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C2796C4F6F52_var*
//#UC END# *52D00B00031A_C2796C4F6F52_var*
begin
//#UC START# *52D00B00031A_C2796C4F6F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C2796C4F6F52_impl*
end;//TkwShutDownFormRightSpacerPanel.SetValuePrim

function TkwShutDownFormRightSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C2796C4F6F52_var*
//#UC END# *551544E2001A_C2796C4F6F52_var*
begin
//#UC START# *551544E2001A_C2796C4F6F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C2796C4F6F52_impl*
end;//TkwShutDownFormRightSpacerPanel.GetResultTypeInfo

function TkwShutDownFormRightSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormRightSpacerPanel.GetAllParamsCount

function TkwShutDownFormRightSpacerPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C2796C4F6F52_var*
//#UC END# *5617F4D00243_C2796C4F6F52_var*
begin
//#UC START# *5617F4D00243_C2796C4F6F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C2796C4F6F52_impl*
end;//TkwShutDownFormRightSpacerPanel.ParamsTypes

function TkwShutDownFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.pnlBottom }
//#UC START# *B17D85786F9B_27832B920452_var*
//#UC END# *B17D85786F9B_27832B920452_var*
begin
//#UC START# *B17D85786F9B_27832B920452_impl*
 !!! Needs to be implemented !!!
//#UC END# *B17D85786F9B_27832B920452_impl*
end;//TkwShutDownFormPnlBottom.pnlBottom

procedure TkwShutDownFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_27832B920452_var*
//#UC END# *4DAEEDE10285_27832B920452_var*
begin
//#UC START# *4DAEEDE10285_27832B920452_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_27832B920452_impl*
end;//TkwShutDownFormPnlBottom.DoDoIt

class function TkwShutDownFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.pnlBottom';
end;//TkwShutDownFormPnlBottom.GetWordNameForRegister

procedure TkwShutDownFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_27832B920452_var*
//#UC END# *52D00B00031A_27832B920452_var*
begin
//#UC START# *52D00B00031A_27832B920452_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_27832B920452_impl*
end;//TkwShutDownFormPnlBottom.SetValuePrim

function TkwShutDownFormPnlBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_27832B920452_var*
//#UC END# *551544E2001A_27832B920452_var*
begin
//#UC START# *551544E2001A_27832B920452_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_27832B920452_impl*
end;//TkwShutDownFormPnlBottom.GetResultTypeInfo

function TkwShutDownFormPnlBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormPnlBottom.GetAllParamsCount

function TkwShutDownFormPnlBottom.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_27832B920452_var*
//#UC END# *5617F4D00243_27832B920452_var*
begin
//#UC START# *5617F4D00243_27832B920452_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_27832B920452_impl*
end;//TkwShutDownFormPnlBottom.ParamsTypes

function TkwShutDownFormCloseButton.CloseButton(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtButton;
 {* Реализация слова скрипта .TShutDownForm.CloseButton }
//#UC START# *F6DBCBF04EFC_1E09A179F85E_var*
//#UC END# *F6DBCBF04EFC_1E09A179F85E_var*
begin
//#UC START# *F6DBCBF04EFC_1E09A179F85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *F6DBCBF04EFC_1E09A179F85E_impl*
end;//TkwShutDownFormCloseButton.CloseButton

procedure TkwShutDownFormCloseButton.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1E09A179F85E_var*
//#UC END# *4DAEEDE10285_1E09A179F85E_var*
begin
//#UC START# *4DAEEDE10285_1E09A179F85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1E09A179F85E_impl*
end;//TkwShutDownFormCloseButton.DoDoIt

class function TkwShutDownFormCloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CloseButton';
end;//TkwShutDownFormCloseButton.GetWordNameForRegister

procedure TkwShutDownFormCloseButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1E09A179F85E_var*
//#UC END# *52D00B00031A_1E09A179F85E_var*
begin
//#UC START# *52D00B00031A_1E09A179F85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1E09A179F85E_impl*
end;//TkwShutDownFormCloseButton.SetValuePrim

function TkwShutDownFormCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1E09A179F85E_var*
//#UC END# *551544E2001A_1E09A179F85E_var*
begin
//#UC START# *551544E2001A_1E09A179F85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1E09A179F85E_impl*
end;//TkwShutDownFormCloseButton.GetResultTypeInfo

function TkwShutDownFormCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormCloseButton.GetAllParamsCount

function TkwShutDownFormCloseButton.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1E09A179F85E_var*
//#UC END# *5617F4D00243_1E09A179F85E_var*
begin
//#UC START# *5617F4D00243_1E09A179F85E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1E09A179F85E_impl*
end;//TkwShutDownFormCloseButton.ParamsTypes

initialization
 Tkw_Form_ShutDown.RegisterInEngine;
 {* Регистрация Tkw_Form_ShutDown }
 Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Component_ShutdownTimer }
 Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_vtPanel1 }
 Tkw_ShutDown_Control_vtPanel1_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_vtPanel1_Push }
 Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_LeftPanel }
 Tkw_ShutDown_Control_LeftPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_LeftPanel_Push }
 Tkw_ShutDown_Control_Image.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_Image }
 Tkw_ShutDown_Control_Image_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_Image_Push }
 Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_CenterPanel }
 Tkw_ShutDown_Control_CenterPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_CenterPanel_Push }
 Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_TopSpacerPanel }
 Tkw_ShutDown_Control_TopSpacerPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_TopSpacerPanel_Push }
 Tkw_ShutDown_Control_WarningText.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_WarningText }
 Tkw_ShutDown_Control_WarningText_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_WarningText_Push }
 Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_RightSpacerPanel }
 Tkw_ShutDown_Control_RightSpacerPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_RightSpacerPanel_Push }
 Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_pnlBottom }
 Tkw_ShutDown_Control_pnlBottom_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_pnlBottom_Push }
 Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_CloseButton }
 Tkw_ShutDown_Control_CloseButton_Push.RegisterInEngine;
 {* Регистрация Tkw_ShutDown_Control_CloseButton_Push }
 TkwShutDownFormShutdownTimer.RegisterInEngine;
 {* Регистрация ShutDownForm_ShutdownTimer }
 TkwShutDownFormVtPanel1.RegisterInEngine;
 {* Регистрация ShutDownForm_vtPanel1 }
 TkwShutDownFormLeftPanel.RegisterInEngine;
 {* Регистрация ShutDownForm_LeftPanel }
 TkwShutDownFormImage.RegisterInEngine;
 {* Регистрация ShutDownForm_Image }
 TkwShutDownFormCenterPanel.RegisterInEngine;
 {* Регистрация ShutDownForm_CenterPanel }
 TkwShutDownFormTopSpacerPanel.RegisterInEngine;
 {* Регистрация ShutDownForm_TopSpacerPanel }
 TkwShutDownFormWarningText.RegisterInEngine;
 {* Регистрация ShutDownForm_WarningText }
 TkwShutDownFormRightSpacerPanel.RegisterInEngine;
 {* Регистрация ShutDownForm_RightSpacerPanel }
 TkwShutDownFormPnlBottom.RegisterInEngine;
 {* Регистрация ShutDownForm_pnlBottom }
 TkwShutDownFormCloseButton.RegisterInEngine;
 {* Регистрация ShutDownForm_CloseButton }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TShutDownForm));
 {* Регистрация типа ShutDown }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTimer));
 {* Регистрация типа TTimer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
 {* Регистрация типа TImage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
