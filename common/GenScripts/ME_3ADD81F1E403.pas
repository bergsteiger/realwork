unit NavigatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Navigator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\NavigatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
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
 Tkw_Form_Navigator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Navigator
----
*������ �������������*:
[code]
'aControl' �����::Navigator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Navigator

 Tkw_Navigator_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Navigator_Control_BackgroundPanel

 Tkw_Navigator_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_BackgroundPanel_Push

 Tkw_Navigator_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Navigator_Control_ContextFilter

 Tkw_Navigator_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_ContextFilter_Push

 Tkw_Navigator_Control_NavigatorTree = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� NavigatorTree
----
*������ �������������*:
[code]
�������::NavigatorTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Navigator_Control_NavigatorTree

 Tkw_Navigator_Control_NavigatorTree_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� NavigatorTree
----
*������ �������������*:
[code]
�������::NavigatorTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Navigator_Control_NavigatorTree_Push

 TkwEnNavigatorBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_Navigator.BackgroundPanel
[panel]������� BackgroundPanel ����� Ten_Navigator[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_Navigator .Ten_Navigator.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TvtPanel;
    {* ���������� ����� ������� .Ten_Navigator.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorBackgroundPanel

 TkwEnNavigatorContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_Navigator.ContextFilter
[panel]������� ContextFilter ����� Ten_Navigator[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_Navigator .Ten_Navigator.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscContextFilter;
    {* ���������� ����� ������� .Ten_Navigator.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorContextFilter

 TkwEnNavigatorNavigatorTree = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_Navigator.NavigatorTree
[panel]������� NavigatorTree ����� Ten_Navigator[panel]
*��� ����������:* TnscTreeViewWithAdapterDragDrop
*������:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_Navigator .Ten_Navigator.NavigatorTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function NavigatorTree(const aCtx: TtfwContext;
    aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
    {* ���������� ����� ������� .Ten_Navigator.NavigatorTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNavigatorNavigatorTree

class function Tkw_Form_Navigator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Navigator';
end;//Tkw_Form_Navigator.GetWordNameForRegister

function Tkw_Form_Navigator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7D2047A498FC_var*
//#UC END# *4DDFD2EA0116_7D2047A498FC_var*
begin
//#UC START# *4DDFD2EA0116_7D2047A498FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7D2047A498FC_impl*
end;//Tkw_Form_Navigator.GetString

class function Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_Navigator_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Navigator_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CCD9CD9DC02B_var*
//#UC END# *4DDFD2EA0116_CCD9CD9DC02B_var*
begin
//#UC START# *4DDFD2EA0116_CCD9CD9DC02B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CCD9CD9DC02B_impl*
end;//Tkw_Navigator_Control_BackgroundPanel.GetString

class procedure Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_CCD9CD9DC02B_var*
//#UC END# *52A086150180_CCD9CD9DC02B_var*
begin
//#UC START# *52A086150180_CCD9CD9DC02B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CCD9CD9DC02B_impl*
end;//Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8A1290B1FFAB_var*
//#UC END# *4DAEEDE10285_8A1290B1FFAB_var*
begin
//#UC START# *4DAEEDE10285_8A1290B1FFAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8A1290B1FFAB_impl*
end;//Tkw_Navigator_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_Navigator_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_Navigator_Control_ContextFilter.GetWordNameForRegister

function Tkw_Navigator_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C47642E4B3A1_var*
//#UC END# *4DDFD2EA0116_C47642E4B3A1_var*
begin
//#UC START# *4DDFD2EA0116_C47642E4B3A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C47642E4B3A1_impl*
end;//Tkw_Navigator_Control_ContextFilter.GetString

class procedure Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_C47642E4B3A1_var*
//#UC END# *52A086150180_C47642E4B3A1_var*
begin
//#UC START# *52A086150180_C47642E4B3A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C47642E4B3A1_impl*
end;//Tkw_Navigator_Control_ContextFilter.RegisterInEngine

procedure Tkw_Navigator_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B6A378A35041_var*
//#UC END# *4DAEEDE10285_B6A378A35041_var*
begin
//#UC START# *4DAEEDE10285_B6A378A35041_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B6A378A35041_impl*
end;//Tkw_Navigator_Control_ContextFilter_Push.DoDoIt

class function Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_Navigator_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorTree';
end;//Tkw_Navigator_Control_NavigatorTree.GetWordNameForRegister

function Tkw_Navigator_Control_NavigatorTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EA7258EA96E2_var*
//#UC END# *4DDFD2EA0116_EA7258EA96E2_var*
begin
//#UC START# *4DDFD2EA0116_EA7258EA96E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EA7258EA96E2_impl*
end;//Tkw_Navigator_Control_NavigatorTree.GetString

class procedure Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
//#UC START# *52A086150180_EA7258EA96E2_var*
//#UC END# *52A086150180_EA7258EA96E2_var*
begin
//#UC START# *52A086150180_EA7258EA96E2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EA7258EA96E2_impl*
end;//Tkw_Navigator_Control_NavigatorTree.RegisterInEngine

procedure Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_86F03C36DFB4_var*
//#UC END# *4DAEEDE10285_86F03C36DFB4_var*
begin
//#UC START# *4DAEEDE10285_86F03C36DFB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_86F03C36DFB4_impl*
end;//Tkw_Navigator_Control_NavigatorTree_Push.DoDoIt

class function Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::NavigatorTree:push';
end;//Tkw_Navigator_Control_NavigatorTree_Push.GetWordNameForRegister

function TkwEnNavigatorBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TvtPanel;
 {* ���������� ����� ������� .Ten_Navigator.BackgroundPanel }
//#UC START# *DF5EB3AB0F99_70C417ED0B1C_var*
//#UC END# *DF5EB3AB0F99_70C417ED0B1C_var*
begin
//#UC START# *DF5EB3AB0F99_70C417ED0B1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *DF5EB3AB0F99_70C417ED0B1C_impl*
end;//TkwEnNavigatorBackgroundPanel.BackgroundPanel

procedure TkwEnNavigatorBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_70C417ED0B1C_var*
//#UC END# *4DAEEDE10285_70C417ED0B1C_var*
begin
//#UC START# *4DAEEDE10285_70C417ED0B1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_70C417ED0B1C_impl*
end;//TkwEnNavigatorBackgroundPanel.DoDoIt

class function TkwEnNavigatorBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.BackgroundPanel';
end;//TkwEnNavigatorBackgroundPanel.GetWordNameForRegister

procedure TkwEnNavigatorBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_70C417ED0B1C_var*
//#UC END# *52D00B00031A_70C417ED0B1C_var*
begin
//#UC START# *52D00B00031A_70C417ED0B1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_70C417ED0B1C_impl*
end;//TkwEnNavigatorBackgroundPanel.SetValuePrim

function TkwEnNavigatorBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnNavigatorBackgroundPanel.GetResultTypeInfo

function TkwEnNavigatorBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorBackgroundPanel.GetAllParamsCount

function TkwEnNavigatorBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnNavigatorBackgroundPanel.ParamsTypes

function TkwEnNavigatorContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscContextFilter;
 {* ���������� ����� ������� .Ten_Navigator.ContextFilter }
//#UC START# *4BAE554126C1_6F24A35F9C81_var*
//#UC END# *4BAE554126C1_6F24A35F9C81_var*
begin
//#UC START# *4BAE554126C1_6F24A35F9C81_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BAE554126C1_6F24A35F9C81_impl*
end;//TkwEnNavigatorContextFilter.ContextFilter

procedure TkwEnNavigatorContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6F24A35F9C81_var*
//#UC END# *4DAEEDE10285_6F24A35F9C81_var*
begin
//#UC START# *4DAEEDE10285_6F24A35F9C81_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6F24A35F9C81_impl*
end;//TkwEnNavigatorContextFilter.DoDoIt

class function TkwEnNavigatorContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.ContextFilter';
end;//TkwEnNavigatorContextFilter.GetWordNameForRegister

procedure TkwEnNavigatorContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6F24A35F9C81_var*
//#UC END# *52D00B00031A_6F24A35F9C81_var*
begin
//#UC START# *52D00B00031A_6F24A35F9C81_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6F24A35F9C81_impl*
end;//TkwEnNavigatorContextFilter.SetValuePrim

function TkwEnNavigatorContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnNavigatorContextFilter.GetResultTypeInfo

function TkwEnNavigatorContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorContextFilter.GetAllParamsCount

function TkwEnNavigatorContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnNavigatorContextFilter.ParamsTypes

function TkwEnNavigatorNavigatorTree.NavigatorTree(const aCtx: TtfwContext;
 aen_Navigator: Ten_Navigator): TnscTreeViewWithAdapterDragDrop;
 {* ���������� ����� ������� .Ten_Navigator.NavigatorTree }
//#UC START# *9506B2CB2FD9_584619536FEF_var*
//#UC END# *9506B2CB2FD9_584619536FEF_var*
begin
//#UC START# *9506B2CB2FD9_584619536FEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *9506B2CB2FD9_584619536FEF_impl*
end;//TkwEnNavigatorNavigatorTree.NavigatorTree

procedure TkwEnNavigatorNavigatorTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_584619536FEF_var*
//#UC END# *4DAEEDE10285_584619536FEF_var*
begin
//#UC START# *4DAEEDE10285_584619536FEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_584619536FEF_impl*
end;//TkwEnNavigatorNavigatorTree.DoDoIt

class function TkwEnNavigatorNavigatorTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_Navigator.NavigatorTree';
end;//TkwEnNavigatorNavigatorTree.GetWordNameForRegister

procedure TkwEnNavigatorNavigatorTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_584619536FEF_var*
//#UC END# *52D00B00031A_584619536FEF_var*
begin
//#UC START# *52D00B00031A_584619536FEF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_584619536FEF_impl*
end;//TkwEnNavigatorNavigatorTree.SetValuePrim

function TkwEnNavigatorNavigatorTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnNavigatorNavigatorTree.GetResultTypeInfo

function TkwEnNavigatorNavigatorTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNavigatorNavigatorTree.GetAllParamsCount

function TkwEnNavigatorNavigatorTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnNavigatorNavigatorTree.ParamsTypes

initialization
 Tkw_Form_Navigator.RegisterInEngine;
 {* ����������� Tkw_Form_Navigator }
 Tkw_Navigator_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_BackgroundPanel }
 Tkw_Navigator_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_BackgroundPanel_Push }
 Tkw_Navigator_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_ContextFilter }
 Tkw_Navigator_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_ContextFilter_Push }
 Tkw_Navigator_Control_NavigatorTree.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_NavigatorTree }
 Tkw_Navigator_Control_NavigatorTree_Push.RegisterInEngine;
 {* ����������� Tkw_Navigator_Control_NavigatorTree_Push }
 TkwEnNavigatorBackgroundPanel.RegisterInEngine;
 {* ����������� en_Navigator_BackgroundPanel }
 TkwEnNavigatorContextFilter.RegisterInEngine;
 {* ����������� en_Navigator_ContextFilter }
 TkwEnNavigatorNavigatorTree.RegisterInEngine;
 {* ����������� en_Navigator_NavigatorTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_Navigator));
 {* ����������� ���� Navigator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* ����������� ���� TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
