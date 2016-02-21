unit ShutDownKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ShutDown }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimCommon\ShutDownKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
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
  {* ����� ������� ��� �������������� ����� ShutDown
----
*������ �������������*:
[code]
'aControl' �����::ShutDown TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ShutDown

 Tkw_ShutDown_Component_ShutdownTimer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShutdownTimer
----
*������ �������������*:
[code]
���������::ShutdownTimer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Component_ShutdownTimer

 Tkw_ShutDown_Control_vtPanel1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_vtPanel1

 Tkw_ShutDown_Control_vtPanel1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� vtPanel1
----
*������ �������������*:
[code]
�������::vtPanel1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_vtPanel1_Push

 Tkw_ShutDown_Control_LeftPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� LeftPanel
----
*������ �������������*:
[code]
�������::LeftPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_LeftPanel

 Tkw_ShutDown_Control_LeftPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� LeftPanel
----
*������ �������������*:
[code]
�������::LeftPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_LeftPanel_Push

 Tkw_ShutDown_Control_Image = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Image
----
*������ �������������*:
[code]
�������::Image TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_Image

 Tkw_ShutDown_Control_Image_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Image
----
*������ �������������*:
[code]
�������::Image:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_Image_Push

 Tkw_ShutDown_Control_CenterPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CenterPanel
----
*������ �������������*:
[code]
�������::CenterPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_CenterPanel

 Tkw_ShutDown_Control_CenterPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CenterPanel
----
*������ �������������*:
[code]
�������::CenterPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CenterPanel_Push

 Tkw_ShutDown_Control_TopSpacerPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� TopSpacerPanel
----
*������ �������������*:
[code]
�������::TopSpacerPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_TopSpacerPanel

 Tkw_ShutDown_Control_TopSpacerPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� TopSpacerPanel
----
*������ �������������*:
[code]
�������::TopSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_TopSpacerPanel_Push

 Tkw_ShutDown_Control_WarningText = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� WarningText
----
*������ �������������*:
[code]
�������::WarningText TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_WarningText

 Tkw_ShutDown_Control_WarningText_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� WarningText
----
*������ �������������*:
[code]
�������::WarningText:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_WarningText_Push

 Tkw_ShutDown_Control_RightSpacerPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� RightSpacerPanel
----
*������ �������������*:
[code]
�������::RightSpacerPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_RightSpacerPanel

 Tkw_ShutDown_Control_RightSpacerPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� RightSpacerPanel
----
*������ �������������*:
[code]
�������::RightSpacerPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_RightSpacerPanel_Push

 Tkw_ShutDown_Control_pnlBottom = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_pnlBottom

 Tkw_ShutDown_Control_pnlBottom_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnlBottom
----
*������ �������������*:
[code]
�������::pnlBottom:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_pnlBottom_Push

 Tkw_ShutDown_Control_CloseButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ShutDown_Control_CloseButton

 Tkw_ShutDown_Control_CloseButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� CloseButton
----
*������ �������������*:
[code]
�������::CloseButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ShutDown_Control_CloseButton_Push

 TkwShutDownFormShutdownTimer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TShutDownForm.ShutdownTimer
[panel]������� ShutdownTimer ����� TShutDownForm[panel]
*��� ����������:* TTimer
*������:*
[code]
OBJECT VAR l_TTimer
 aShutDownForm .TShutDownForm.ShutdownTimer >>> l_TTimer
[code]  }
  private
   function ShutdownTimer(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TTimer;
    {* ���������� ����� ������� .TShutDownForm.ShutdownTimer }
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
  {* ����� ������� .TShutDownForm.vtPanel1
[panel]������� vtPanel1 ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.vtPanel1 >>> l_TvtPanel
[code]  }
  private
   function vtPanel1(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.vtPanel1 }
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
  {* ����� ������� .TShutDownForm.LeftPanel
[panel]������� LeftPanel ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.LeftPanel >>> l_TvtPanel
[code]  }
  private
   function LeftPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.LeftPanel }
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
  {* ����� ������� .TShutDownForm.Image
[panel]������� Image ����� TShutDownForm[panel]
*��� ����������:* TImage
*������:*
[code]
OBJECT VAR l_TImage
 aShutDownForm .TShutDownForm.Image >>> l_TImage
[code]  }
  private
   function Image(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TImage;
    {* ���������� ����� ������� .TShutDownForm.Image }
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
  {* ����� ������� .TShutDownForm.CenterPanel
[panel]������� CenterPanel ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.CenterPanel >>> l_TvtPanel
[code]  }
  private
   function CenterPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.CenterPanel }
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
  {* ����� ������� .TShutDownForm.TopSpacerPanel
[panel]������� TopSpacerPanel ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.TopSpacerPanel >>> l_TvtPanel
[code]  }
  private
   function TopSpacerPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.TopSpacerPanel }
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
  {* ����� ������� .TShutDownForm.WarningText
[panel]������� WarningText ����� TShutDownForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aShutDownForm .TShutDownForm.WarningText >>> l_TvtLabel
[code]  }
  private
   function WarningText(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtLabel;
    {* ���������� ����� ������� .TShutDownForm.WarningText }
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
  {* ����� ������� .TShutDownForm.RightSpacerPanel
[panel]������� RightSpacerPanel ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.RightSpacerPanel >>> l_TvtPanel
[code]  }
  private
   function RightSpacerPanel(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.RightSpacerPanel }
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
  {* ����� ������� .TShutDownForm.pnlBottom
[panel]������� pnlBottom ����� TShutDownForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aShutDownForm .TShutDownForm.pnlBottom >>> l_TvtPanel
[code]  }
  private
   function pnlBottom(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtPanel;
    {* ���������� ����� ������� .TShutDownForm.pnlBottom }
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
  {* ����� ������� .TShutDownForm.CloseButton
[panel]������� CloseButton ����� TShutDownForm[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aShutDownForm .TShutDownForm.CloseButton >>> l_TvtButton
[code]  }
  private
   function CloseButton(const aCtx: TtfwContext;
    aShutDownForm: TShutDownForm): TvtButton;
    {* ���������� ����� ������� .TShutDownForm.CloseButton }
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
 Result := '�����::ShutDown';
end;//Tkw_Form_ShutDown.GetWordNameForRegister

function Tkw_Form_ShutDown.GetString: AnsiString;
begin
 Result := 'ShutDownForm';
end;//Tkw_Form_ShutDown.GetString

class function Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '���������::ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetWordNameForRegister

function Tkw_ShutDown_Component_ShutdownTimer.GetString: AnsiString;
begin
 Result := 'ShutdownTimer';
end;//Tkw_ShutDown_Component_ShutdownTimer.GetString

class procedure Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TTimer);
end;//Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine

class function Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetWordNameForRegister

function Tkw_ShutDown_Control_vtPanel1.GetString: AnsiString;
begin
 Result := 'vtPanel1';
end;//Tkw_ShutDown_Control_vtPanel1.GetString

class procedure Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::vtPanel1:push';
end;//Tkw_ShutDown_Control_vtPanel1_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_LeftPanel.GetString: AnsiString;
begin
 Result := 'LeftPanel';
end;//Tkw_ShutDown_Control_LeftPanel.GetString

class procedure Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::LeftPanel:push';
end;//Tkw_ShutDown_Control_LeftPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_Image.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Image';
end;//Tkw_ShutDown_Control_Image.GetWordNameForRegister

function Tkw_ShutDown_Control_Image.GetString: AnsiString;
begin
 Result := 'Image';
end;//Tkw_ShutDown_Control_Image.GetString

class procedure Tkw_ShutDown_Control_Image.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TImage);
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
 Result := '�������::Image:push';
end;//Tkw_ShutDown_Control_Image_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_CenterPanel.GetString: AnsiString;
begin
 Result := 'CenterPanel';
end;//Tkw_ShutDown_Control_CenterPanel.GetString

class procedure Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::CenterPanel:push';
end;//Tkw_ShutDown_Control_CenterPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_TopSpacerPanel.GetString: AnsiString;
begin
 Result := 'TopSpacerPanel';
end;//Tkw_ShutDown_Control_TopSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::TopSpacerPanel:push';
end;//Tkw_ShutDown_Control_TopSpacerPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_WarningText.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetWordNameForRegister

function Tkw_ShutDown_Control_WarningText.GetString: AnsiString;
begin
 Result := 'WarningText';
end;//Tkw_ShutDown_Control_WarningText.GetString

class procedure Tkw_ShutDown_Control_WarningText.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
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
 Result := '�������::WarningText:push';
end;//Tkw_ShutDown_Control_WarningText_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetWordNameForRegister

function Tkw_ShutDown_Control_RightSpacerPanel.GetString: AnsiString;
begin
 Result := 'RightSpacerPanel';
end;//Tkw_ShutDown_Control_RightSpacerPanel.GetString

class procedure Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::RightSpacerPanel:push';
end;//Tkw_ShutDown_Control_RightSpacerPanel_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetWordNameForRegister

function Tkw_ShutDown_Control_pnlBottom.GetString: AnsiString;
begin
 Result := 'pnlBottom';
end;//Tkw_ShutDown_Control_pnlBottom.GetString

class procedure Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
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
 Result := '�������::pnlBottom:push';
end;//Tkw_ShutDown_Control_pnlBottom_Push.GetWordNameForRegister

class function Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetWordNameForRegister

function Tkw_ShutDown_Control_CloseButton.GetString: AnsiString;
begin
 Result := 'CloseButton';
end;//Tkw_ShutDown_Control_CloseButton.GetString

class procedure Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
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
 Result := '�������::CloseButton:push';
end;//Tkw_ShutDown_Control_CloseButton_Push.GetWordNameForRegister

function TkwShutDownFormShutdownTimer.ShutdownTimer(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TTimer;
 {* ���������� ����� ������� .TShutDownForm.ShutdownTimer }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShutdownTimer(aCtx, l_aShutDownForm));
end;//TkwShutDownFormShutdownTimer.DoDoIt

class function TkwShutDownFormShutdownTimer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.ShutdownTimer';
end;//TkwShutDownFormShutdownTimer.GetWordNameForRegister

procedure TkwShutDownFormShutdownTimer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ShutdownTimer', aCtx);
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

function TkwShutDownFormVtPanel1.vtPanel1(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.vtPanel1 }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(vtPanel1(aCtx, l_aShutDownForm));
end;//TkwShutDownFormVtPanel1.DoDoIt

class function TkwShutDownFormVtPanel1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.vtPanel1';
end;//TkwShutDownFormVtPanel1.GetWordNameForRegister

procedure TkwShutDownFormVtPanel1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� vtPanel1', aCtx);
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

function TkwShutDownFormLeftPanel.LeftPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.LeftPanel }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(LeftPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormLeftPanel.DoDoIt

class function TkwShutDownFormLeftPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.LeftPanel';
end;//TkwShutDownFormLeftPanel.GetWordNameForRegister

procedure TkwShutDownFormLeftPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� LeftPanel', aCtx);
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

function TkwShutDownFormImage.Image(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TImage;
 {* ���������� ����� ������� .TShutDownForm.Image }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Image(aCtx, l_aShutDownForm));
end;//TkwShutDownFormImage.DoDoIt

class function TkwShutDownFormImage.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.Image';
end;//TkwShutDownFormImage.GetWordNameForRegister

procedure TkwShutDownFormImage.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Image', aCtx);
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

function TkwShutDownFormCenterPanel.CenterPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.CenterPanel }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CenterPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormCenterPanel.DoDoIt

class function TkwShutDownFormCenterPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CenterPanel';
end;//TkwShutDownFormCenterPanel.GetWordNameForRegister

procedure TkwShutDownFormCenterPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CenterPanel', aCtx);
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

function TkwShutDownFormTopSpacerPanel.TopSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.TopSpacerPanel }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TopSpacerPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormTopSpacerPanel.DoDoIt

class function TkwShutDownFormTopSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.TopSpacerPanel';
end;//TkwShutDownFormTopSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormTopSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� TopSpacerPanel', aCtx);
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

function TkwShutDownFormWarningText.WarningText(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtLabel;
 {* ���������� ����� ������� .TShutDownForm.WarningText }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WarningText(aCtx, l_aShutDownForm));
end;//TkwShutDownFormWarningText.DoDoIt

class function TkwShutDownFormWarningText.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.WarningText';
end;//TkwShutDownFormWarningText.GetWordNameForRegister

procedure TkwShutDownFormWarningText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� WarningText', aCtx);
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

function TkwShutDownFormRightSpacerPanel.RightSpacerPanel(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.RightSpacerPanel }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(RightSpacerPanel(aCtx, l_aShutDownForm));
end;//TkwShutDownFormRightSpacerPanel.DoDoIt

class function TkwShutDownFormRightSpacerPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.RightSpacerPanel';
end;//TkwShutDownFormRightSpacerPanel.GetWordNameForRegister

procedure TkwShutDownFormRightSpacerPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� RightSpacerPanel', aCtx);
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

function TkwShutDownFormPnlBottom.pnlBottom(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtPanel;
 {* ���������� ����� ������� .TShutDownForm.pnlBottom }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pnlBottom(aCtx, l_aShutDownForm));
end;//TkwShutDownFormPnlBottom.DoDoIt

class function TkwShutDownFormPnlBottom.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.pnlBottom';
end;//TkwShutDownFormPnlBottom.GetWordNameForRegister

procedure TkwShutDownFormPnlBottom.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� pnlBottom', aCtx);
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

function TkwShutDownFormCloseButton.CloseButton(const aCtx: TtfwContext;
 aShutDownForm: TShutDownForm): TvtButton;
 {* ���������� ����� ������� .TShutDownForm.CloseButton }
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
   RunnerError('������ ��� ��������� ��������� aShutDownForm: TShutDownForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(CloseButton(aCtx, l_aShutDownForm));
end;//TkwShutDownFormCloseButton.DoDoIt

class function TkwShutDownFormCloseButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TShutDownForm.CloseButton';
end;//TkwShutDownFormCloseButton.GetWordNameForRegister

procedure TkwShutDownFormCloseButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� CloseButton', aCtx);
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

initialization
 Tkw_Form_ShutDown.RegisterInEngine;
 {* ����������� Tkw_Form_ShutDown }
 Tkw_ShutDown_Component_ShutdownTimer.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Component_ShutdownTimer }
 Tkw_ShutDown_Control_vtPanel1.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_vtPanel1 }
 Tkw_ShutDown_Control_vtPanel1_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_vtPanel1_Push }
 Tkw_ShutDown_Control_LeftPanel.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_LeftPanel }
 Tkw_ShutDown_Control_LeftPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_LeftPanel_Push }
 Tkw_ShutDown_Control_Image.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_Image }
 Tkw_ShutDown_Control_Image_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_Image_Push }
 Tkw_ShutDown_Control_CenterPanel.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_CenterPanel }
 Tkw_ShutDown_Control_CenterPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_CenterPanel_Push }
 Tkw_ShutDown_Control_TopSpacerPanel.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_TopSpacerPanel }
 Tkw_ShutDown_Control_TopSpacerPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_TopSpacerPanel_Push }
 Tkw_ShutDown_Control_WarningText.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_WarningText }
 Tkw_ShutDown_Control_WarningText_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_WarningText_Push }
 Tkw_ShutDown_Control_RightSpacerPanel.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_RightSpacerPanel }
 Tkw_ShutDown_Control_RightSpacerPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_RightSpacerPanel_Push }
 Tkw_ShutDown_Control_pnlBottom.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_pnlBottom }
 Tkw_ShutDown_Control_pnlBottom_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_pnlBottom_Push }
 Tkw_ShutDown_Control_CloseButton.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_CloseButton }
 Tkw_ShutDown_Control_CloseButton_Push.RegisterInEngine;
 {* ����������� Tkw_ShutDown_Control_CloseButton_Push }
 TkwShutDownFormShutdownTimer.RegisterInEngine;
 {* ����������� ShutDownForm_ShutdownTimer }
 TkwShutDownFormVtPanel1.RegisterInEngine;
 {* ����������� ShutDownForm_vtPanel1 }
 TkwShutDownFormLeftPanel.RegisterInEngine;
 {* ����������� ShutDownForm_LeftPanel }
 TkwShutDownFormImage.RegisterInEngine;
 {* ����������� ShutDownForm_Image }
 TkwShutDownFormCenterPanel.RegisterInEngine;
 {* ����������� ShutDownForm_CenterPanel }
 TkwShutDownFormTopSpacerPanel.RegisterInEngine;
 {* ����������� ShutDownForm_TopSpacerPanel }
 TkwShutDownFormWarningText.RegisterInEngine;
 {* ����������� ShutDownForm_WarningText }
 TkwShutDownFormRightSpacerPanel.RegisterInEngine;
 {* ����������� ShutDownForm_RightSpacerPanel }
 TkwShutDownFormPnlBottom.RegisterInEngine;
 {* ����������� ShutDownForm_pnlBottom }
 TkwShutDownFormCloseButton.RegisterInEngine;
 {* ����������� ShutDownForm_CloseButton }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TShutDownForm));
 {* ����������� ���� ShutDown }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TTimer));
 {* ����������� ���� TTimer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TImage));
 {* ����������� ���� TImage }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
{$IfEnd} // NOT Defined(NoScripts)

end.
