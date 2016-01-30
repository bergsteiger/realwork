unit LongProcessKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы LongProcess }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\LongProcessKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimCommon_Module
 , vtPanel
 , vtLabel
 , vtGradientWaitbar
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
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
 Tkw_Form_LongProcess = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы LongProcess
----
*Пример использования*:
[code]
'aControl' форма::LongProcess TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_LongProcess

 Tkw_LongProcess_Control_ClientPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ClientPanel
----
*Пример использования*:
[code]
контрол::ClientPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LongProcess_Control_ClientPanel

 Tkw_LongProcess_Control_ClientPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ClientPanel
----
*Пример использования*:
[code]
контрол::ClientPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ClientPanel_Push

 Tkw_LongProcess_Control_MessageLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MessageLabel
----
*Пример использования*:
[code]
контрол::MessageLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LongProcess_Control_MessageLabel

 Tkw_LongProcess_Control_MessageLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MessageLabel
----
*Пример использования*:
[code]
контрол::MessageLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_MessageLabel_Push

 Tkw_LongProcess_Control_BottomPanel = {final} class(TtfwControlString)
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
 end;//Tkw_LongProcess_Control_BottomPanel

 Tkw_LongProcess_Control_BottomPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BottomPanel
----
*Пример использования*:
[code]
контрол::BottomPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_BottomPanel_Push

 Tkw_LongProcess_Control_ProgressBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ProgressBar
----
*Пример использования*:
[code]
контрол::ProgressBar TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LongProcess_Control_ProgressBar

 Tkw_LongProcess_Control_ProgressBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ProgressBar
----
*Пример использования*:
[code]
контрол::ProgressBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ProgressBar_Push

 Tkw_LongProcess_Control_LeftPanel = {final} class(TtfwControlString)
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
 end;//Tkw_LongProcess_Control_LeftPanel

 Tkw_LongProcess_Control_LeftPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола LeftPanel
----
*Пример использования*:
[code]
контрол::LeftPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_LeftPanel_Push

 Tkw_LongProcess_Control_Image = {final} class(TtfwControlString)
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
 end;//Tkw_LongProcess_Control_Image

 Tkw_LongProcess_Control_Image_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола Image
----
*Пример использования*:
[code]
контрол::Image:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_Image_Push

 Tkw_LongProcess_Control_ButtonPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ButtonPanel
----
*Пример использования*:
[code]
контрол::ButtonPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LongProcess_Control_ButtonPanel

 Tkw_LongProcess_Control_ButtonPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ButtonPanel
----
*Пример использования*:
[code]
контрол::ButtonPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_ButtonPanel_Push

 Tkw_LongProcess_Control_btnExit = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnExit
----
*Пример использования*:
[code]
контрол::btnExit TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_LongProcess_Control_btnExit

 Tkw_LongProcess_Control_btnExit_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnExit
----
*Пример использования*:
[code]
контрол::btnExit:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_LongProcess_Control_btnExit_Push

 TkwLongProcessFormClientPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ClientPanel
[panel]Контрол ClientPanel формы TLongProcessForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.ClientPanel >>> l_TvtPanel
[code]  }
  private
   function ClientPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.ClientPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormClientPanel

 TkwLongProcessFormMessageLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.MessageLabel
[panel]Контрол MessageLabel формы TLongProcessForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aLongProcessForm .TLongProcessForm.MessageLabel >>> l_TvtLabel
[code]  }
  private
   function MessageLabel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtLabel;
    {* Реализация слова скрипта .TLongProcessForm.MessageLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormMessageLabel

 TkwLongProcessFormBottomPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.BottomPanel
[panel]Контрол BottomPanel формы TLongProcessForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.BottomPanel >>> l_TvtPanel
[code]  }
  private
   function BottomPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.BottomPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormBottomPanel

 TkwLongProcessFormProgressBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ProgressBar
[panel]Контрол ProgressBar формы TLongProcessForm[panel]
*Тип результата:* TvtGradientWaitbar
*Пример:*
[code]
OBJECT VAR l_TvtGradientWaitbar
 aLongProcessForm .TLongProcessForm.ProgressBar >>> l_TvtGradientWaitbar
[code]  }
  private
   function ProgressBar(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
    {* Реализация слова скрипта .TLongProcessForm.ProgressBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormProgressBar

 TkwLongProcessFormLeftPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.LeftPanel
[panel]Контрол LeftPanel формы TLongProcessForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.LeftPanel >>> l_TvtPanel
[code]  }
  private
   function LeftPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.LeftPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormLeftPanel

 TkwLongProcessFormImage = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.Image
[panel]Контрол Image формы TLongProcessForm[panel]
*Тип результата:* TImage
*Пример:*
[code]
OBJECT VAR l_TImage
 aLongProcessForm .TLongProcessForm.Image >>> l_TImage
[code]  }
  private
   function Image(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TImage;
    {* Реализация слова скрипта .TLongProcessForm.Image }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormImage

 TkwLongProcessFormButtonPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.ButtonPanel
[panel]Контрол ButtonPanel формы TLongProcessForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aLongProcessForm .TLongProcessForm.ButtonPanel >>> l_TvtPanel
[code]  }
  private
   function ButtonPanel(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtPanel;
    {* Реализация слова скрипта .TLongProcessForm.ButtonPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormButtonPanel

 TkwLongProcessFormBtnExit = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TLongProcessForm.btnExit
[panel]Контрол btnExit формы TLongProcessForm[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aLongProcessForm .TLongProcessForm.btnExit >>> l_TvtButton
[code]  }
  private
   function btnExit(const aCtx: TtfwContext;
    aLongProcessForm: TLongProcessForm): TvtButton;
    {* Реализация слова скрипта .TLongProcessForm.btnExit }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwLongProcessFormBtnExit

class function Tkw_Form_LongProcess.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::LongProcess';
end;//Tkw_Form_LongProcess.GetWordNameForRegister

function Tkw_Form_LongProcess.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C4A3AD5E3009_var*
//#UC END# *4DDFD2EA0116_C4A3AD5E3009_var*
begin
//#UC START# *4DDFD2EA0116_C4A3AD5E3009_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C4A3AD5E3009_impl*
end;//Tkw_Form_LongProcess.GetString

class function Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientPanel';
end;//Tkw_LongProcess_Control_ClientPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_ClientPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_80415E0A03B6_var*
//#UC END# *4DDFD2EA0116_80415E0A03B6_var*
begin
//#UC START# *4DDFD2EA0116_80415E0A03B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_80415E0A03B6_impl*
end;//Tkw_LongProcess_Control_ClientPanel.GetString

class procedure Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
//#UC START# *52A086150180_80415E0A03B6_var*
//#UC END# *52A086150180_80415E0A03B6_var*
begin
//#UC START# *52A086150180_80415E0A03B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_80415E0A03B6_impl*
end;//Tkw_LongProcess_Control_ClientPanel.RegisterInEngine

procedure Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8A095E715C45_var*
//#UC END# *4DAEEDE10285_8A095E715C45_var*
begin
//#UC START# *4DAEEDE10285_8A095E715C45_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8A095E715C45_impl*
end;//Tkw_LongProcess_Control_ClientPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ClientPanel:push';
end;//Tkw_LongProcess_Control_ClientPanel_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MessageLabel';
end;//Tkw_LongProcess_Control_MessageLabel.GetWordNameForRegister

function Tkw_LongProcess_Control_MessageLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EE429CEF80B2_var*
//#UC END# *4DDFD2EA0116_EE429CEF80B2_var*
begin
//#UC START# *4DDFD2EA0116_EE429CEF80B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EE429CEF80B2_impl*
end;//Tkw_LongProcess_Control_MessageLabel.GetString

class procedure Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
//#UC START# *52A086150180_EE429CEF80B2_var*
//#UC END# *52A086150180_EE429CEF80B2_var*
begin
//#UC START# *52A086150180_EE429CEF80B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EE429CEF80B2_impl*
end;//Tkw_LongProcess_Control_MessageLabel.RegisterInEngine

procedure Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BB38FEFB196C_var*
//#UC END# *4DAEEDE10285_BB38FEFB196C_var*
begin
//#UC START# *4DAEEDE10285_BB38FEFB196C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BB38FEFB196C_impl*
end;//Tkw_LongProcess_Control_MessageLabel_Push.DoDoIt

class function Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MessageLabel:push';
end;//Tkw_LongProcess_Control_MessageLabel_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel';
end;//Tkw_LongProcess_Control_BottomPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_BottomPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1D52AE8ECAD0_var*
//#UC END# *4DDFD2EA0116_1D52AE8ECAD0_var*
begin
//#UC START# *4DDFD2EA0116_1D52AE8ECAD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1D52AE8ECAD0_impl*
end;//Tkw_LongProcess_Control_BottomPanel.GetString

class procedure Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
//#UC START# *52A086150180_1D52AE8ECAD0_var*
//#UC END# *52A086150180_1D52AE8ECAD0_var*
begin
//#UC START# *52A086150180_1D52AE8ECAD0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1D52AE8ECAD0_impl*
end;//Tkw_LongProcess_Control_BottomPanel.RegisterInEngine

procedure Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_73A2CC14762E_var*
//#UC END# *4DAEEDE10285_73A2CC14762E_var*
begin
//#UC START# *4DAEEDE10285_73A2CC14762E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_73A2CC14762E_impl*
end;//Tkw_LongProcess_Control_BottomPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BottomPanel:push';
end;//Tkw_LongProcess_Control_BottomPanel_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar';
end;//Tkw_LongProcess_Control_ProgressBar.GetWordNameForRegister

function Tkw_LongProcess_Control_ProgressBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8A7072EA0EBB_var*
//#UC END# *4DDFD2EA0116_8A7072EA0EBB_var*
begin
//#UC START# *4DDFD2EA0116_8A7072EA0EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8A7072EA0EBB_impl*
end;//Tkw_LongProcess_Control_ProgressBar.GetString

class procedure Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
//#UC START# *52A086150180_8A7072EA0EBB_var*
//#UC END# *52A086150180_8A7072EA0EBB_var*
begin
//#UC START# *52A086150180_8A7072EA0EBB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8A7072EA0EBB_impl*
end;//Tkw_LongProcess_Control_ProgressBar.RegisterInEngine

procedure Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FECE38307A18_var*
//#UC END# *4DAEEDE10285_FECE38307A18_var*
begin
//#UC START# *4DAEEDE10285_FECE38307A18_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FECE38307A18_impl*
end;//Tkw_LongProcess_Control_ProgressBar_Push.DoDoIt

class function Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar:push';
end;//Tkw_LongProcess_Control_ProgressBar_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel';
end;//Tkw_LongProcess_Control_LeftPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_LeftPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_37371C609A4E_var*
//#UC END# *4DDFD2EA0116_37371C609A4E_var*
begin
//#UC START# *4DDFD2EA0116_37371C609A4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_37371C609A4E_impl*
end;//Tkw_LongProcess_Control_LeftPanel.GetString

class procedure Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
//#UC START# *52A086150180_37371C609A4E_var*
//#UC END# *52A086150180_37371C609A4E_var*
begin
//#UC START# *52A086150180_37371C609A4E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_37371C609A4E_impl*
end;//Tkw_LongProcess_Control_LeftPanel.RegisterInEngine

procedure Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FF3E57F14F3_var*
//#UC END# *4DAEEDE10285_4FF3E57F14F3_var*
begin
//#UC START# *4DAEEDE10285_4FF3E57F14F3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4FF3E57F14F3_impl*
end;//Tkw_LongProcess_Control_LeftPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel:push';
end;//Tkw_LongProcess_Control_LeftPanel_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_Image.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image';
end;//Tkw_LongProcess_Control_Image.GetWordNameForRegister

function Tkw_LongProcess_Control_Image.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1A4830627510_var*
//#UC END# *4DDFD2EA0116_1A4830627510_var*
begin
//#UC START# *4DDFD2EA0116_1A4830627510_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1A4830627510_impl*
end;//Tkw_LongProcess_Control_Image.GetString

class procedure Tkw_LongProcess_Control_Image.RegisterInEngine;
//#UC START# *52A086150180_1A4830627510_var*
//#UC END# *52A086150180_1A4830627510_var*
begin
//#UC START# *52A086150180_1A4830627510_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1A4830627510_impl*
end;//Tkw_LongProcess_Control_Image.RegisterInEngine

procedure Tkw_LongProcess_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C215319A5871_var*
//#UC END# *4DAEEDE10285_C215319A5871_var*
begin
//#UC START# *4DAEEDE10285_C215319A5871_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C215319A5871_impl*
end;//Tkw_LongProcess_Control_Image_Push.DoDoIt

class function Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image:push';
end;//Tkw_LongProcess_Control_Image_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ButtonPanel';
end;//Tkw_LongProcess_Control_ButtonPanel.GetWordNameForRegister

function Tkw_LongProcess_Control_ButtonPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6459869CFA95_var*
//#UC END# *4DDFD2EA0116_6459869CFA95_var*
begin
//#UC START# *4DDFD2EA0116_6459869CFA95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6459869CFA95_impl*
end;//Tkw_LongProcess_Control_ButtonPanel.GetString

class procedure Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
//#UC START# *52A086150180_6459869CFA95_var*
//#UC END# *52A086150180_6459869CFA95_var*
begin
//#UC START# *52A086150180_6459869CFA95_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6459869CFA95_impl*
end;//Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine

procedure Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_545230A3EEC9_var*
//#UC END# *4DAEEDE10285_545230A3EEC9_var*
begin
//#UC START# *4DAEEDE10285_545230A3EEC9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_545230A3EEC9_impl*
end;//Tkw_LongProcess_Control_ButtonPanel_Push.DoDoIt

class function Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ButtonPanel:push';
end;//Tkw_LongProcess_Control_ButtonPanel_Push.GetWordNameForRegister

class function Tkw_LongProcess_Control_btnExit.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnExit';
end;//Tkw_LongProcess_Control_btnExit.GetWordNameForRegister

function Tkw_LongProcess_Control_btnExit.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B8087B324800_var*
//#UC END# *4DDFD2EA0116_B8087B324800_var*
begin
//#UC START# *4DDFD2EA0116_B8087B324800_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B8087B324800_impl*
end;//Tkw_LongProcess_Control_btnExit.GetString

class procedure Tkw_LongProcess_Control_btnExit.RegisterInEngine;
//#UC START# *52A086150180_B8087B324800_var*
//#UC END# *52A086150180_B8087B324800_var*
begin
//#UC START# *52A086150180_B8087B324800_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B8087B324800_impl*
end;//Tkw_LongProcess_Control_btnExit.RegisterInEngine

procedure Tkw_LongProcess_Control_btnExit_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E7E0F6C9E87A_var*
//#UC END# *4DAEEDE10285_E7E0F6C9E87A_var*
begin
//#UC START# *4DAEEDE10285_E7E0F6C9E87A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E7E0F6C9E87A_impl*
end;//Tkw_LongProcess_Control_btnExit_Push.DoDoIt

class function Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnExit:push';
end;//Tkw_LongProcess_Control_btnExit_Push.GetWordNameForRegister

function TkwLongProcessFormClientPanel.ClientPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.ClientPanel }
//#UC START# *3479D5B334CC_486A220C7922_var*
//#UC END# *3479D5B334CC_486A220C7922_var*
begin
//#UC START# *3479D5B334CC_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *3479D5B334CC_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.ClientPanel

procedure TkwLongProcessFormClientPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_486A220C7922_var*
//#UC END# *4DAEEDE10285_486A220C7922_var*
begin
//#UC START# *4DAEEDE10285_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.DoDoIt

class function TkwLongProcessFormClientPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ClientPanel';
end;//TkwLongProcessFormClientPanel.GetWordNameForRegister

procedure TkwLongProcessFormClientPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_486A220C7922_var*
//#UC END# *52D00B00031A_486A220C7922_var*
begin
//#UC START# *52D00B00031A_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.SetValuePrim

function TkwLongProcessFormClientPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_486A220C7922_var*
//#UC END# *551544E2001A_486A220C7922_var*
begin
//#UC START# *551544E2001A_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.GetResultTypeInfo

function TkwLongProcessFormClientPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_486A220C7922_var*
//#UC END# *559687E6025A_486A220C7922_var*
begin
//#UC START# *559687E6025A_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.GetAllParamsCount

function TkwLongProcessFormClientPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_486A220C7922_var*
//#UC END# *5617F4D00243_486A220C7922_var*
begin
//#UC START# *5617F4D00243_486A220C7922_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_486A220C7922_impl*
end;//TkwLongProcessFormClientPanel.ParamsTypes

function TkwLongProcessFormMessageLabel.MessageLabel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtLabel;
 {* Реализация слова скрипта .TLongProcessForm.MessageLabel }
//#UC START# *32DE68119216_70AD8C304A76_var*
//#UC END# *32DE68119216_70AD8C304A76_var*
begin
//#UC START# *32DE68119216_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *32DE68119216_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.MessageLabel

procedure TkwLongProcessFormMessageLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_70AD8C304A76_var*
//#UC END# *4DAEEDE10285_70AD8C304A76_var*
begin
//#UC START# *4DAEEDE10285_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.DoDoIt

class function TkwLongProcessFormMessageLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.MessageLabel';
end;//TkwLongProcessFormMessageLabel.GetWordNameForRegister

procedure TkwLongProcessFormMessageLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_70AD8C304A76_var*
//#UC END# *52D00B00031A_70AD8C304A76_var*
begin
//#UC START# *52D00B00031A_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.SetValuePrim

function TkwLongProcessFormMessageLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_70AD8C304A76_var*
//#UC END# *551544E2001A_70AD8C304A76_var*
begin
//#UC START# *551544E2001A_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.GetResultTypeInfo

function TkwLongProcessFormMessageLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_70AD8C304A76_var*
//#UC END# *559687E6025A_70AD8C304A76_var*
begin
//#UC START# *559687E6025A_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.GetAllParamsCount

function TkwLongProcessFormMessageLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_70AD8C304A76_var*
//#UC END# *5617F4D00243_70AD8C304A76_var*
begin
//#UC START# *5617F4D00243_70AD8C304A76_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_70AD8C304A76_impl*
end;//TkwLongProcessFormMessageLabel.ParamsTypes

function TkwLongProcessFormBottomPanel.BottomPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.BottomPanel }
//#UC START# *7C16D12BA921_7257AAEDA827_var*
//#UC END# *7C16D12BA921_7257AAEDA827_var*
begin
//#UC START# *7C16D12BA921_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *7C16D12BA921_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.BottomPanel

procedure TkwLongProcessFormBottomPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7257AAEDA827_var*
//#UC END# *4DAEEDE10285_7257AAEDA827_var*
begin
//#UC START# *4DAEEDE10285_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.DoDoIt

class function TkwLongProcessFormBottomPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.BottomPanel';
end;//TkwLongProcessFormBottomPanel.GetWordNameForRegister

procedure TkwLongProcessFormBottomPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7257AAEDA827_var*
//#UC END# *52D00B00031A_7257AAEDA827_var*
begin
//#UC START# *52D00B00031A_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.SetValuePrim

function TkwLongProcessFormBottomPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7257AAEDA827_var*
//#UC END# *551544E2001A_7257AAEDA827_var*
begin
//#UC START# *551544E2001A_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.GetResultTypeInfo

function TkwLongProcessFormBottomPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7257AAEDA827_var*
//#UC END# *559687E6025A_7257AAEDA827_var*
begin
//#UC START# *559687E6025A_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.GetAllParamsCount

function TkwLongProcessFormBottomPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7257AAEDA827_var*
//#UC END# *5617F4D00243_7257AAEDA827_var*
begin
//#UC START# *5617F4D00243_7257AAEDA827_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7257AAEDA827_impl*
end;//TkwLongProcessFormBottomPanel.ParamsTypes

function TkwLongProcessFormProgressBar.ProgressBar(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtGradientWaitbar;
 {* Реализация слова скрипта .TLongProcessForm.ProgressBar }
//#UC START# *854A47C11673_B362DE4317E9_var*
//#UC END# *854A47C11673_B362DE4317E9_var*
begin
//#UC START# *854A47C11673_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *854A47C11673_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.ProgressBar

procedure TkwLongProcessFormProgressBar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B362DE4317E9_var*
//#UC END# *4DAEEDE10285_B362DE4317E9_var*
begin
//#UC START# *4DAEEDE10285_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.DoDoIt

class function TkwLongProcessFormProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ProgressBar';
end;//TkwLongProcessFormProgressBar.GetWordNameForRegister

procedure TkwLongProcessFormProgressBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B362DE4317E9_var*
//#UC END# *52D00B00031A_B362DE4317E9_var*
begin
//#UC START# *52D00B00031A_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.SetValuePrim

function TkwLongProcessFormProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B362DE4317E9_var*
//#UC END# *551544E2001A_B362DE4317E9_var*
begin
//#UC START# *551544E2001A_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.GetResultTypeInfo

function TkwLongProcessFormProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B362DE4317E9_var*
//#UC END# *559687E6025A_B362DE4317E9_var*
begin
//#UC START# *559687E6025A_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.GetAllParamsCount

function TkwLongProcessFormProgressBar.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B362DE4317E9_var*
//#UC END# *5617F4D00243_B362DE4317E9_var*
begin
//#UC START# *5617F4D00243_B362DE4317E9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B362DE4317E9_impl*
end;//TkwLongProcessFormProgressBar.ParamsTypes

function TkwLongProcessFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.LeftPanel }
//#UC START# *E2251777354D_763DFD3968B4_var*
//#UC END# *E2251777354D_763DFD3968B4_var*
begin
//#UC START# *E2251777354D_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *E2251777354D_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.LeftPanel

procedure TkwLongProcessFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_763DFD3968B4_var*
//#UC END# *4DAEEDE10285_763DFD3968B4_var*
begin
//#UC START# *4DAEEDE10285_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.DoDoIt

class function TkwLongProcessFormLeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.LeftPanel';
end;//TkwLongProcessFormLeftPanel.GetWordNameForRegister

procedure TkwLongProcessFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_763DFD3968B4_var*
//#UC END# *52D00B00031A_763DFD3968B4_var*
begin
//#UC START# *52D00B00031A_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.SetValuePrim

function TkwLongProcessFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_763DFD3968B4_var*
//#UC END# *551544E2001A_763DFD3968B4_var*
begin
//#UC START# *551544E2001A_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.GetResultTypeInfo

function TkwLongProcessFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_763DFD3968B4_var*
//#UC END# *559687E6025A_763DFD3968B4_var*
begin
//#UC START# *559687E6025A_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.GetAllParamsCount

function TkwLongProcessFormLeftPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_763DFD3968B4_var*
//#UC END# *5617F4D00243_763DFD3968B4_var*
begin
//#UC START# *5617F4D00243_763DFD3968B4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_763DFD3968B4_impl*
end;//TkwLongProcessFormLeftPanel.ParamsTypes

function TkwLongProcessFormImage.Image(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TImage;
 {* Реализация слова скрипта .TLongProcessForm.Image }
//#UC START# *C88A16931701_E257BCDBC2B9_var*
//#UC END# *C88A16931701_E257BCDBC2B9_var*
begin
//#UC START# *C88A16931701_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *C88A16931701_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.Image

procedure TkwLongProcessFormImage.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E257BCDBC2B9_var*
//#UC END# *4DAEEDE10285_E257BCDBC2B9_var*
begin
//#UC START# *4DAEEDE10285_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.DoDoIt

class function TkwLongProcessFormImage.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.Image';
end;//TkwLongProcessFormImage.GetWordNameForRegister

procedure TkwLongProcessFormImage.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E257BCDBC2B9_var*
//#UC END# *52D00B00031A_E257BCDBC2B9_var*
begin
//#UC START# *52D00B00031A_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.SetValuePrim

function TkwLongProcessFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E257BCDBC2B9_var*
//#UC END# *551544E2001A_E257BCDBC2B9_var*
begin
//#UC START# *551544E2001A_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.GetResultTypeInfo

function TkwLongProcessFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E257BCDBC2B9_var*
//#UC END# *559687E6025A_E257BCDBC2B9_var*
begin
//#UC START# *559687E6025A_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.GetAllParamsCount

function TkwLongProcessFormImage.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E257BCDBC2B9_var*
//#UC END# *5617F4D00243_E257BCDBC2B9_var*
begin
//#UC START# *5617F4D00243_E257BCDBC2B9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E257BCDBC2B9_impl*
end;//TkwLongProcessFormImage.ParamsTypes

function TkwLongProcessFormButtonPanel.ButtonPanel(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtPanel;
 {* Реализация слова скрипта .TLongProcessForm.ButtonPanel }
//#UC START# *4A4E4FD73CCD_372A17FE3DFD_var*
//#UC END# *4A4E4FD73CCD_372A17FE3DFD_var*
begin
//#UC START# *4A4E4FD73CCD_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A4E4FD73CCD_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.ButtonPanel

procedure TkwLongProcessFormButtonPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_372A17FE3DFD_var*
//#UC END# *4DAEEDE10285_372A17FE3DFD_var*
begin
//#UC START# *4DAEEDE10285_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.DoDoIt

class function TkwLongProcessFormButtonPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.ButtonPanel';
end;//TkwLongProcessFormButtonPanel.GetWordNameForRegister

procedure TkwLongProcessFormButtonPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_372A17FE3DFD_var*
//#UC END# *52D00B00031A_372A17FE3DFD_var*
begin
//#UC START# *52D00B00031A_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.SetValuePrim

function TkwLongProcessFormButtonPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_372A17FE3DFD_var*
//#UC END# *551544E2001A_372A17FE3DFD_var*
begin
//#UC START# *551544E2001A_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.GetResultTypeInfo

function TkwLongProcessFormButtonPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_372A17FE3DFD_var*
//#UC END# *559687E6025A_372A17FE3DFD_var*
begin
//#UC START# *559687E6025A_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.GetAllParamsCount

function TkwLongProcessFormButtonPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_372A17FE3DFD_var*
//#UC END# *5617F4D00243_372A17FE3DFD_var*
begin
//#UC START# *5617F4D00243_372A17FE3DFD_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_372A17FE3DFD_impl*
end;//TkwLongProcessFormButtonPanel.ParamsTypes

function TkwLongProcessFormBtnExit.btnExit(const aCtx: TtfwContext;
 aLongProcessForm: TLongProcessForm): TvtButton;
 {* Реализация слова скрипта .TLongProcessForm.btnExit }
//#UC START# *2A2D9AD94E8B_ECD55A49EDCE_var*
//#UC END# *2A2D9AD94E8B_ECD55A49EDCE_var*
begin
//#UC START# *2A2D9AD94E8B_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A2D9AD94E8B_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.btnExit

procedure TkwLongProcessFormBtnExit.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ECD55A49EDCE_var*
//#UC END# *4DAEEDE10285_ECD55A49EDCE_var*
begin
//#UC START# *4DAEEDE10285_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.DoDoIt

class function TkwLongProcessFormBtnExit.GetWordNameForRegister: AnsiString;
begin
 Result := '.TLongProcessForm.btnExit';
end;//TkwLongProcessFormBtnExit.GetWordNameForRegister

procedure TkwLongProcessFormBtnExit.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_ECD55A49EDCE_var*
//#UC END# *52D00B00031A_ECD55A49EDCE_var*
begin
//#UC START# *52D00B00031A_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.SetValuePrim

function TkwLongProcessFormBtnExit.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ECD55A49EDCE_var*
//#UC END# *551544E2001A_ECD55A49EDCE_var*
begin
//#UC START# *551544E2001A_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.GetResultTypeInfo

function TkwLongProcessFormBtnExit.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_ECD55A49EDCE_var*
//#UC END# *559687E6025A_ECD55A49EDCE_var*
begin
//#UC START# *559687E6025A_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.GetAllParamsCount

function TkwLongProcessFormBtnExit.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ECD55A49EDCE_var*
//#UC END# *5617F4D00243_ECD55A49EDCE_var*
begin
//#UC START# *5617F4D00243_ECD55A49EDCE_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ECD55A49EDCE_impl*
end;//TkwLongProcessFormBtnExit.ParamsTypes

initialization
 Tkw_Form_LongProcess.RegisterInEngine;
 {* Регистрация Tkw_Form_LongProcess }
 Tkw_LongProcess_Control_ClientPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ClientPanel }
 Tkw_LongProcess_Control_ClientPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ClientPanel_Push }
 Tkw_LongProcess_Control_MessageLabel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_MessageLabel }
 Tkw_LongProcess_Control_MessageLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_MessageLabel_Push }
 Tkw_LongProcess_Control_BottomPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_BottomPanel }
 Tkw_LongProcess_Control_BottomPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_BottomPanel_Push }
 Tkw_LongProcess_Control_ProgressBar.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ProgressBar }
 Tkw_LongProcess_Control_ProgressBar_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ProgressBar_Push }
 Tkw_LongProcess_Control_LeftPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_LeftPanel }
 Tkw_LongProcess_Control_LeftPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_LeftPanel_Push }
 Tkw_LongProcess_Control_Image.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_Image }
 Tkw_LongProcess_Control_Image_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_Image_Push }
 Tkw_LongProcess_Control_ButtonPanel.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ButtonPanel }
 Tkw_LongProcess_Control_ButtonPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_ButtonPanel_Push }
 Tkw_LongProcess_Control_btnExit.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_btnExit }
 Tkw_LongProcess_Control_btnExit_Push.RegisterInEngine;
 {* Регистрация Tkw_LongProcess_Control_btnExit_Push }
 TkwLongProcessFormClientPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_ClientPanel }
 TkwLongProcessFormMessageLabel.RegisterInEngine;
 {* Регистрация LongProcessForm_MessageLabel }
 TkwLongProcessFormBottomPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_BottomPanel }
 TkwLongProcessFormProgressBar.RegisterInEngine;
 {* Регистрация LongProcessForm_ProgressBar }
 TkwLongProcessFormLeftPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_LeftPanel }
 TkwLongProcessFormImage.RegisterInEngine;
 {* Регистрация LongProcessForm_Image }
 TkwLongProcessFormButtonPanel.RegisterInEngine;
 {* Регистрация LongProcessForm_ButtonPanel }
 TkwLongProcessFormBtnExit.RegisterInEngine;
 {* Регистрация LongProcessForm_btnExit }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TLongProcessForm));
 {* Регистрация типа LongProcess }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGradientWaitbar));
 {* Регистрация типа TvtGradientWaitbar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
 {* Регистрация типа TImage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
