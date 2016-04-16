unit ShutDownKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ShutDown }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\ShutDownKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ShutDownKeywordsPack" MUID: (7FB5E199E37C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
 , vtPanel
 , vtLabel
 , vtButton
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ShutDown_Form
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
 Tkw_Form_ShutDown = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ShutDown
----
*Пример использования*:
[code]
'aControl' форма::ShutDown TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ShutDown

 Tkw_ShutDown_Component_ShutdownTimer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ShutdownTimer
----
*Пример использования*:
[code]
компонент::ShutdownTimer TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Component_ShutdownTimer

 Tkw_ShutDown_Control_vtPanel1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола vtPanel1
----
*Пример использования*:
[code]
контрол::vtPanel1 TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_vtPanel1

 Tkw_ShutDown_Control_vtPanel1_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_LeftPanel

 Tkw_ShutDown_Control_LeftPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_Image

 Tkw_ShutDown_Control_Image_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CenterPanel

 Tkw_ShutDown_Control_CenterPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_TopSpacerPanel

 Tkw_ShutDown_Control_TopSpacerPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_WarningText

 Tkw_ShutDown_Control_WarningText_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_RightSpacerPanel

 Tkw_ShutDown_Control_RightSpacerPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_pnlBottom

 Tkw_ShutDown_Control_pnlBottom_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CloseButton

 Tkw_ShutDown_Control_CloseButton_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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

function Tkw_Form_ShutDown.GetString: AnsiString;
begin
 Result := 'ShutDownForm';
end;//Tkw_Form_ShutDown.GetString

class function Tkw_Form_ShutDown.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ShutDown';
end;//Tkw_Form_ShutDown.GetWordNameForRegister

function Tkw_ShutDown_Component_ShutdownTimer.GetString: AnsiString;
begin
 Result := 'ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetString

class procedure Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTimer);
end;//Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine

class function Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := 'компонент::ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister

function Tkw_ShutDown_Control_vtPanel1.GetString: AnsiString;
begin
 Result := 'vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetString

class procedure Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_vtPanel1.RegisterInEngine

class function Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister

procedure Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('vtPanel1');
 inherited;
end;//Tkw_ShutDown_Control_vtPanel1_Push.DoDoIt

class function Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::vtPanel1:push';
end;//Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_LeftPanel.GetString: AnsiString;
begin
 Result := 'LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetString

class procedure Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_LeftPanel.RegisterInEngine

class function Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister

procedure Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('LeftPanel');
 inherited;
end;//Tkw_ShutDown_Control_LeftPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::LeftPanel:push';
end;//Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_Image.GetString: AnsiString;
begin
 Result := 'Image';
end;//Tkw_ShutDown_Control_Image.GetString

class procedure Tkw_ShutDown_Control_Image.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImage);
end;//Tkw_ShutDown_Control_Image.RegisterInEngine

class function Tkw_ShutDown_Control_Image.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image';
end;//Tkw_ShutDown_Control_Image.GetWordNameForRegister

procedure Tkw_ShutDown_Control_Image_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('Image');
 inherited;
end;//Tkw_ShutDown_Control_Image_Push.DoDoIt

class function Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::Image:push';
end;//Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_CenterPanel.GetString: AnsiString;
begin
 Result := 'CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetString

class procedure Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_CenterPanel.RegisterInEngine

class function Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister

procedure Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CenterPanel');
 inherited;
end;//Tkw_ShutDown_Control_CenterPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CenterPanel:push';
end;//Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_TopSpacerPanel.GetString: AnsiString;
begin
 Result := 'TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine

class function Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister

procedure Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TopSpacerPanel');
 inherited;
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TopSpacerPanel:push';
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_WarningText.GetString: AnsiString;
begin
 Result := 'WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetString

class procedure Tkw_ShutDown_Control_WarningText.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ShutDown_Control_WarningText.RegisterInEngine

class function Tkw_ShutDown_Control_WarningText.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetWordNameForRegister

procedure Tkw_ShutDown_Control_WarningText_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WarningText');
 inherited;
end;//Tkw_ShutDown_Control_WarningText_Push.DoDoIt

class function Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WarningText:push';
end;//Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_RightSpacerPanel.GetString: AnsiString;
begin
 Result := 'RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine

class function Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister

procedure Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('RightSpacerPanel');
 inherited;
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.DoDoIt

class function Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::RightSpacerPanel:push';
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_pnlBottom.GetString: AnsiString;
begin
 Result := 'pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetString

class procedure Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ShutDown_Control_pnlBottom.RegisterInEngine

class function Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister

procedure Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('pnlBottom');
 inherited;
end;//Tkw_ShutDown_Control_pnlBottom_Push.DoDoIt

class function Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnlBottom:push';
end;//Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister

function Tkw_ShutDown_Control_CloseButton.GetString: AnsiString;
begin
 Result := 'CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetString

class procedure Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_ShutDown_Control_CloseButton.RegisterInEngine

class function Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister

procedure Tkw_ShutDown_Control_CloseButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('CloseButton');
 inherited;
end;//Tkw_ShutDown_Control_CloseButton_Push.DoDoIt

class function Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::CloseButton:push';
end;//Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister

function TkwShutDownFormShutdownTimer.ShutdownTimer(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TTimer;
 {* Реализация слова скрипта .TShutDownForm.ShutdownTimer }
begin
 Result := aShutDownForm.ShutdownTimer;
end;//TkwShutDownFormShutdownTimer.ShutdownTimer

procedure TkwShutDownFormShutdownTimer.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShutdownTimer(aCtx, l_aShutDownForm));
end;//TkwShutDownFormShutdownTimer.DoDoIt

procedure TkwShutDownFormShutdownTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShutdownTimer', aCtx);
end;//TkwShutDownFormShutdownTimer.SetValuePrim

function TkwShutDownFormShutdownTimer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TTimer);
end;//TkwShutDownFormShutdownTimer.GetResultTypeInfo

function TkwShutDownFormShutdownTimer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormShutdownTimer.GetAllParamsCount

function TkwShutDownFormShutdownTimer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormShutdownTimer.ParamsTypes

class function TkwShutDownFormShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.ShutdownTimer';
end;//TkwShutDownFormShutdownTimer.GetWordNameForRegister

function TkwShutDownFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.vtPanel1 }
begin
 Result := aShutDownForm.vtPanel1;
end;//TkwShutDownFormVtPanel1.vtPanel1

procedure TkwShutDownFormVtPanel1.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtPanel1(aCtx, l_aShutDownForm));
end;//TkwShutDownFormVtPanel1.DoDoIt

procedure TkwShutDownFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству vtPanel1', aCtx);
end;//TkwShutDownFormVtPanel1.SetValuePrim

function TkwShutDownFormVtPanel1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormVtPanel1.GetResultTypeInfo

function TkwShutDownFormVtPanel1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormVtPanel1.GetAllParamsCount

function TkwShutDownFormVtPanel1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormVtPanel1.ParamsTypes

class function TkwShutDownFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.vtPanel1';
end;//TkwShutDownFormVtPanel1.GetWordNameForRegister

function TkwShutDownFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.LeftPanel }
begin
 Result := aShutDownForm.LeftPanel;
end;//TkwShutDownFormLeftPanel.LeftPanel

procedure TkwShutDownFormLeftPanel.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormLeftPanel.DoDoIt

procedure TkwShutDownFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftPanel', aCtx);
end;//TkwShutDownFormLeftPanel.SetValuePrim

function TkwShutDownFormLeftPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormLeftPanel.GetResultTypeInfo

function TkwShutDownFormLeftPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormLeftPanel.GetAllParamsCount

function TkwShutDownFormLeftPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormLeftPanel.ParamsTypes

class function TkwShutDownFormLeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.LeftPanel';
end;//TkwShutDownFormLeftPanel.GetWordNameForRegister

function TkwShutDownFormImage.Image(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TImage;
 {* Реализация слова скрипта .TShutDownForm.Image }
begin
 Result := aShutDownForm.Image;
end;//TkwShutDownFormImage.Image

procedure TkwShutDownFormImage.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Image(aCtx, l_aShutDownForm));
end;//TkwShutDownFormImage.DoDoIt

procedure TkwShutDownFormImage.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Image', aCtx);
end;//TkwShutDownFormImage.SetValuePrim

function TkwShutDownFormImage.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TImage);
end;//TkwShutDownFormImage.GetResultTypeInfo

function TkwShutDownFormImage.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormImage.GetAllParamsCount

function TkwShutDownFormImage.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormImage.ParamsTypes

class function TkwShutDownFormImage.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.Image';
end;//TkwShutDownFormImage.GetWordNameForRegister

function TkwShutDownFormCenterPanel.CenterPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.CenterPanel }
begin
 Result := aShutDownForm.CenterPanel;
end;//TkwShutDownFormCenterPanel.CenterPanel

procedure TkwShutDownFormCenterPanel.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CenterPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormCenterPanel.DoDoIt

procedure TkwShutDownFormCenterPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CenterPanel', aCtx);
end;//TkwShutDownFormCenterPanel.SetValuePrim

function TkwShutDownFormCenterPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormCenterPanel.GetResultTypeInfo

function TkwShutDownFormCenterPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormCenterPanel.GetAllParamsCount

function TkwShutDownFormCenterPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormCenterPanel.ParamsTypes

class function TkwShutDownFormCenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CenterPanel';
end;//TkwShutDownFormCenterPanel.GetWordNameForRegister

function TkwShutDownFormTopSpacerPanel.TopSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.TopSpacerPanel }
begin
 Result := aShutDownForm.TopSpacerPanel;
end;//TkwShutDownFormTopSpacerPanel.TopSpacerPanel

procedure TkwShutDownFormTopSpacerPanel.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopSpacerPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormTopSpacerPanel.DoDoIt

procedure TkwShutDownFormTopSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TopSpacerPanel', aCtx);
end;//TkwShutDownFormTopSpacerPanel.SetValuePrim

function TkwShutDownFormTopSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormTopSpacerPanel.GetResultTypeInfo

function TkwShutDownFormTopSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormTopSpacerPanel.GetAllParamsCount

function TkwShutDownFormTopSpacerPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormTopSpacerPanel.ParamsTypes

class function TkwShutDownFormTopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.TopSpacerPanel';
end;//TkwShutDownFormTopSpacerPanel.GetWordNameForRegister

function TkwShutDownFormWarningText.WarningText(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtLabel;
 {* Реализация слова скрипта .TShutDownForm.WarningText }
begin
 Result := aShutDownForm.WarningText;
end;//TkwShutDownFormWarningText.WarningText

procedure TkwShutDownFormWarningText.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarningText(aCtx, l_aShutDownForm));
end;//TkwShutDownFormWarningText.DoDoIt

procedure TkwShutDownFormWarningText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству WarningText', aCtx);
end;//TkwShutDownFormWarningText.SetValuePrim

function TkwShutDownFormWarningText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwShutDownFormWarningText.GetResultTypeInfo

function TkwShutDownFormWarningText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormWarningText.GetAllParamsCount

function TkwShutDownFormWarningText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormWarningText.ParamsTypes

class function TkwShutDownFormWarningText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.WarningText';
end;//TkwShutDownFormWarningText.GetWordNameForRegister

function TkwShutDownFormRightSpacerPanel.RightSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.RightSpacerPanel }
begin
 Result := aShutDownForm.RightSpacerPanel;
end;//TkwShutDownFormRightSpacerPanel.RightSpacerPanel

procedure TkwShutDownFormRightSpacerPanel.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightSpacerPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormRightSpacerPanel.DoDoIt

procedure TkwShutDownFormRightSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightSpacerPanel', aCtx);
end;//TkwShutDownFormRightSpacerPanel.SetValuePrim

function TkwShutDownFormRightSpacerPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormRightSpacerPanel.GetResultTypeInfo

function TkwShutDownFormRightSpacerPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormRightSpacerPanel.GetAllParamsCount

function TkwShutDownFormRightSpacerPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormRightSpacerPanel.ParamsTypes

class function TkwShutDownFormRightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.RightSpacerPanel';
end;//TkwShutDownFormRightSpacerPanel.GetWordNameForRegister

function TkwShutDownFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* Реализация слова скрипта .TShutDownForm.pnlBottom }
begin
 Result := aShutDownForm.pnlBottom;
end;//TkwShutDownFormPnlBottom.pnlBottom

procedure TkwShutDownFormPnlBottom.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBottom(aCtx, l_aShutDownForm));
end;//TkwShutDownFormPnlBottom.DoDoIt

procedure TkwShutDownFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству pnlBottom', aCtx);
end;//TkwShutDownFormPnlBottom.SetValuePrim

function TkwShutDownFormPnlBottom.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwShutDownFormPnlBottom.GetResultTypeInfo

function TkwShutDownFormPnlBottom.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormPnlBottom.GetAllParamsCount

function TkwShutDownFormPnlBottom.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormPnlBottom.ParamsTypes

class function TkwShutDownFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.pnlBottom';
end;//TkwShutDownFormPnlBottom.GetWordNameForRegister

function TkwShutDownFormCloseButton.CloseButton(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtButton;
 {* Реализация слова скрипта .TShutDownForm.CloseButton }
begin
 Result := aShutDownForm.CloseButton;
end;//TkwShutDownFormCloseButton.CloseButton

procedure TkwShutDownFormCloseButton.DoDoIt(const aCtx: TtfwContext);
var l_aShutDownForm: TShutDownForm;
begin
 try
  l_aShutDownForm := TShutDownForm(aCtx.rEngine.PopObjAs(TShutDownForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseButton(aCtx, l_aShutDownForm));
end;//TkwShutDownFormCloseButton.DoDoIt

procedure TkwShutDownFormCloseButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству CloseButton', aCtx);
end;//TkwShutDownFormCloseButton.SetValuePrim

function TkwShutDownFormCloseButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwShutDownFormCloseButton.GetResultTypeInfo

function TkwShutDownFormCloseButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwShutDownFormCloseButton.GetAllParamsCount

function TkwShutDownFormCloseButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TShutDownForm)]);
end;//TkwShutDownFormCloseButton.ParamsTypes

class function TkwShutDownFormCloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CloseButton';
end;//TkwShutDownFormCloseButton.GetWordNameForRegister

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
