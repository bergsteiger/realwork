unit EditionsContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� EditionsContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Editions\EditionsContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseEditions_Module
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
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
 Tkw_Form_EditionsContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� EditionsContainer
----
*������ �������������*:
[code]
'aControl' �����::EditionsContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EditionsContainer

 Tkw_EditionsContainer_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel

 Tkw_EditionsContainer_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push

 Tkw_EditionsContainer_Control_pnLeft = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_pnLeft

 Tkw_EditionsContainer_Control_pnLeft_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnLeft
----
*������ �������������*:
[code]
�������::pnLeft:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnLeft_Push

 Tkw_EditionsContainer_Control_pnRight = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EditionsContainer_Control_pnRight

 Tkw_EditionsContainer_Control_pnRight_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnRight
----
*������ �������������*:
[code]
�������::pnRight:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EditionsContainer_Control_pnRight_Push

 TkwEditionsContainerFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TEditionsContainerForm[panel]
*��� ����������:* TvtProportionalPanel
*������:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aEditionsContainerForm .TEditionsContainerForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
    {* ���������� ����� ������� .TEditionsContainerForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormBackgroundPanel

 TkwEditionsContainerFormPnLeft = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.pnLeft
[panel]������� pnLeft ����� TEditionsContainerForm[panel]
*��� ����������:* TvtSizeablePanel
*������:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aEditionsContainerForm .TEditionsContainerForm.pnLeft >>> l_TvtSizeablePanel
[code]  }
  private
   function pnLeft(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
    {* ���������� ����� ������� .TEditionsContainerForm.pnLeft }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormPnLeft

 TkwEditionsContainerFormPnRight = {final} class(TtfwPropertyLike)
  {* ����� ������� .TEditionsContainerForm.pnRight
[panel]������� pnRight ����� TEditionsContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aEditionsContainerForm .TEditionsContainerForm.pnRight >>> l_TvtPanel
[code]  }
  private
   function pnRight(const aCtx: TtfwContext;
    aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
    {* ���������� ����� ������� .TEditionsContainerForm.pnRight }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEditionsContainerFormPnRight

class function Tkw_Form_EditionsContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::EditionsContainer';
end;//Tkw_Form_EditionsContainer.GetWordNameForRegister

function Tkw_Form_EditionsContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0357E5848E30_var*
//#UC END# *4DDFD2EA0116_0357E5848E30_var*
begin
//#UC START# *4DDFD2EA0116_0357E5848E30_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0357E5848E30_impl*
end;//Tkw_Form_EditionsContainer.GetString

class function Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_EditionsContainer_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1D28C1934E11_var*
//#UC END# *4DDFD2EA0116_1D28C1934E11_var*
begin
//#UC START# *4DDFD2EA0116_1D28C1934E11_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1D28C1934E11_impl*
end;//Tkw_EditionsContainer_Control_BackgroundPanel.GetString

class procedure Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_1D28C1934E11_var*
//#UC END# *52A086150180_1D28C1934E11_var*
begin
//#UC START# *52A086150180_1D28C1934E11_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1D28C1934E11_impl*
end;//Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D5FE5D3474DD_var*
//#UC END# *4DAEEDE10285_D5FE5D3474DD_var*
begin
//#UC START# *4DAEEDE10285_D5FE5D3474DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D5FE5D3474DD_impl*
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_EditionsContainer_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft';
end;//Tkw_EditionsContainer_Control_pnLeft.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnLeft.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9B44F0966128_var*
//#UC END# *4DDFD2EA0116_9B44F0966128_var*
begin
//#UC START# *4DDFD2EA0116_9B44F0966128_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9B44F0966128_impl*
end;//Tkw_EditionsContainer_Control_pnLeft.GetString

class procedure Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
//#UC START# *52A086150180_9B44F0966128_var*
//#UC END# *52A086150180_9B44F0966128_var*
begin
//#UC START# *52A086150180_9B44F0966128_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9B44F0966128_impl*
end;//Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine

procedure Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A3FAB16A745_var*
//#UC END# *4DAEEDE10285_1A3FAB16A745_var*
begin
//#UC START# *4DAEEDE10285_1A3FAB16A745_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A3FAB16A745_impl*
end;//Tkw_EditionsContainer_Control_pnLeft_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnLeft:push';
end;//Tkw_EditionsContainer_Control_pnLeft_Push.GetWordNameForRegister

class function Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight';
end;//Tkw_EditionsContainer_Control_pnRight.GetWordNameForRegister

function Tkw_EditionsContainer_Control_pnRight.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7082C628A0B6_var*
//#UC END# *4DDFD2EA0116_7082C628A0B6_var*
begin
//#UC START# *4DDFD2EA0116_7082C628A0B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7082C628A0B6_impl*
end;//Tkw_EditionsContainer_Control_pnRight.GetString

class procedure Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
//#UC START# *52A086150180_7082C628A0B6_var*
//#UC END# *52A086150180_7082C628A0B6_var*
begin
//#UC START# *52A086150180_7082C628A0B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7082C628A0B6_impl*
end;//Tkw_EditionsContainer_Control_pnRight.RegisterInEngine

procedure Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2482D3157379_var*
//#UC END# *4DAEEDE10285_2482D3157379_var*
begin
//#UC START# *4DAEEDE10285_2482D3157379_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2482D3157379_impl*
end;//Tkw_EditionsContainer_Control_pnRight_Push.DoDoIt

class function Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnRight:push';
end;//Tkw_EditionsContainer_Control_pnRight_Push.GetWordNameForRegister

function TkwEditionsContainerFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtProportionalPanel;
 {* ���������� ����� ������� .TEditionsContainerForm.BackgroundPanel }
//#UC START# *C6F751EFE83E_86D7719CD46B_var*
//#UC END# *C6F751EFE83E_86D7719CD46B_var*
begin
//#UC START# *C6F751EFE83E_86D7719CD46B_impl*
 !!! Needs to be implemented !!!
//#UC END# *C6F751EFE83E_86D7719CD46B_impl*
end;//TkwEditionsContainerFormBackgroundPanel.BackgroundPanel

procedure TkwEditionsContainerFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86D7719CD46B_var*
//#UC END# *4DAEEDE10285_86D7719CD46B_var*
begin
//#UC START# *4DAEEDE10285_86D7719CD46B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86D7719CD46B_impl*
end;//TkwEditionsContainerFormBackgroundPanel.DoDoIt

class function TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.BackgroundPanel';
end;//TkwEditionsContainerFormBackgroundPanel.GetWordNameForRegister

procedure TkwEditionsContainerFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_86D7719CD46B_var*
//#UC END# *52D00B00031A_86D7719CD46B_var*
begin
//#UC START# *52D00B00031A_86D7719CD46B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_86D7719CD46B_impl*
end;//TkwEditionsContainerFormBackgroundPanel.SetValuePrim

function TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwEditionsContainerFormBackgroundPanel.GetResultTypeInfo

function TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormBackgroundPanel.GetAllParamsCount

function TkwEditionsContainerFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_86D7719CD46B_var*
//#UC END# *5617F4D00243_86D7719CD46B_var*
begin
//#UC START# *5617F4D00243_86D7719CD46B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_86D7719CD46B_impl*
end;//TkwEditionsContainerFormBackgroundPanel.ParamsTypes

function TkwEditionsContainerFormPnLeft.pnLeft(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtSizeablePanel;
 {* ���������� ����� ������� .TEditionsContainerForm.pnLeft }
//#UC START# *234481016667_083A7C7D6482_var*
//#UC END# *234481016667_083A7C7D6482_var*
begin
//#UC START# *234481016667_083A7C7D6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *234481016667_083A7C7D6482_impl*
end;//TkwEditionsContainerFormPnLeft.pnLeft

procedure TkwEditionsContainerFormPnLeft.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_083A7C7D6482_var*
//#UC END# *4DAEEDE10285_083A7C7D6482_var*
begin
//#UC START# *4DAEEDE10285_083A7C7D6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_083A7C7D6482_impl*
end;//TkwEditionsContainerFormPnLeft.DoDoIt

class function TkwEditionsContainerFormPnLeft.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnLeft';
end;//TkwEditionsContainerFormPnLeft.GetWordNameForRegister

procedure TkwEditionsContainerFormPnLeft.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_083A7C7D6482_var*
//#UC END# *52D00B00031A_083A7C7D6482_var*
begin
//#UC START# *52D00B00031A_083A7C7D6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_083A7C7D6482_impl*
end;//TkwEditionsContainerFormPnLeft.SetValuePrim

function TkwEditionsContainerFormPnLeft.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwEditionsContainerFormPnLeft.GetResultTypeInfo

function TkwEditionsContainerFormPnLeft.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnLeft.GetAllParamsCount

function TkwEditionsContainerFormPnLeft.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_083A7C7D6482_var*
//#UC END# *5617F4D00243_083A7C7D6482_var*
begin
//#UC START# *5617F4D00243_083A7C7D6482_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_083A7C7D6482_impl*
end;//TkwEditionsContainerFormPnLeft.ParamsTypes

function TkwEditionsContainerFormPnRight.pnRight(const aCtx: TtfwContext;
 aEditionsContainerForm: TEditionsContainerForm): TvtPanel;
 {* ���������� ����� ������� .TEditionsContainerForm.pnRight }
//#UC START# *789F4F279DE8_7FDE9E2606E0_var*
//#UC END# *789F4F279DE8_7FDE9E2606E0_var*
begin
//#UC START# *789F4F279DE8_7FDE9E2606E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *789F4F279DE8_7FDE9E2606E0_impl*
end;//TkwEditionsContainerFormPnRight.pnRight

procedure TkwEditionsContainerFormPnRight.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7FDE9E2606E0_var*
//#UC END# *4DAEEDE10285_7FDE9E2606E0_var*
begin
//#UC START# *4DAEEDE10285_7FDE9E2606E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7FDE9E2606E0_impl*
end;//TkwEditionsContainerFormPnRight.DoDoIt

class function TkwEditionsContainerFormPnRight.GetWordNameForRegister: AnsiString;
begin
 Result := '.TEditionsContainerForm.pnRight';
end;//TkwEditionsContainerFormPnRight.GetWordNameForRegister

procedure TkwEditionsContainerFormPnRight.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7FDE9E2606E0_var*
//#UC END# *52D00B00031A_7FDE9E2606E0_var*
begin
//#UC START# *52D00B00031A_7FDE9E2606E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7FDE9E2606E0_impl*
end;//TkwEditionsContainerFormPnRight.SetValuePrim

function TkwEditionsContainerFormPnRight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEditionsContainerFormPnRight.GetResultTypeInfo

function TkwEditionsContainerFormPnRight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEditionsContainerFormPnRight.GetAllParamsCount

function TkwEditionsContainerFormPnRight.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7FDE9E2606E0_var*
//#UC END# *5617F4D00243_7FDE9E2606E0_var*
begin
//#UC START# *5617F4D00243_7FDE9E2606E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7FDE9E2606E0_impl*
end;//TkwEditionsContainerFormPnRight.ParamsTypes

initialization
 Tkw_Form_EditionsContainer.RegisterInEngine;
 {* ����������� Tkw_Form_EditionsContainer }
 Tkw_EditionsContainer_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_BackgroundPanel }
 Tkw_EditionsContainer_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_BackgroundPanel_Push }
 Tkw_EditionsContainer_Control_pnLeft.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnLeft }
 Tkw_EditionsContainer_Control_pnLeft_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnLeft_Push }
 Tkw_EditionsContainer_Control_pnRight.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnRight }
 Tkw_EditionsContainer_Control_pnRight_Push.RegisterInEngine;
 {* ����������� Tkw_EditionsContainer_Control_pnRight_Push }
 TkwEditionsContainerFormBackgroundPanel.RegisterInEngine;
 {* ����������� EditionsContainerForm_BackgroundPanel }
 TkwEditionsContainerFormPnLeft.RegisterInEngine;
 {* ����������� EditionsContainerForm_pnLeft }
 TkwEditionsContainerFormPnRight.RegisterInEngine;
 {* ����������� EditionsContainerForm_pnRight }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditionsContainerForm));
 {* ����������� ���� EditionsContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* ����������� ���� TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* ����������� ���� TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
