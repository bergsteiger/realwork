unit BaseSearchContainerKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� BaseSearchContainer }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\BaseSearchContainerKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , BaseSearch_Module
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
 {$IfEnd} // NOT Defined(NoVCL)
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
 Tkw_Form_BaseSearchContainer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� BaseSearchContainer
----
*������ �������������*:
[code]
'aControl' �����::BaseSearchContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_BaseSearchContainer

 Tkw_BaseSearchContainer_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchContainer_Control_ChildZone

 Tkw_BaseSearchContainer_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchContainer_Control_ChildZone_Push

 Tkw_BaseSearchContainer_Control_pnHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchContainer_Control_pnHeader

 Tkw_BaseSearchContainer_Control_pnHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pnHeader
----
*������ �������������*:
[code]
�������::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchContainer_Control_pnHeader_Push

 Tkw_BaseSearchContainer_Control_lbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchContainer_Control_lbHeader

 Tkw_BaseSearchContainer_Control_lbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� lbHeader
----
*������ �������������*:
[code]
�������::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchContainer_Control_lbHeader_Push

 Tkw_BaseSearchContainer_Control_pbHeader = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchContainer_Control_pbHeader

 Tkw_BaseSearchContainer_Control_pbHeader_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� pbHeader
----
*������ �������������*:
[code]
�������::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchContainer_Control_pbHeader_Push

 Tkw_BaseSearchContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_BaseSearchContainer_Control_ParentZone

 Tkw_BaseSearchContainer_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ParentZone
----
*������ �������������*:
[code]
�������::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_BaseSearchContainer_Control_ParentZone_Push

 TkwBaseSearchContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TBaseSearchContainerForm.ChildZone
[panel]������� ChildZone ����� TBaseSearchContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.ChildZone >>> l_TvtPanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
    {* ���������� ����� ������� .TBaseSearchContainerForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBaseSearchContainerFormChildZone

 TkwBaseSearchContainerFormPnHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TBaseSearchContainerForm.pnHeader
[panel]������� pnHeader ����� TBaseSearchContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.pnHeader >>> l_TvtPanel
[code]  }
  private
   function pnHeader(const aCtx: TtfwContext;
    aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
    {* ���������� ����� ������� .TBaseSearchContainerForm.pnHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBaseSearchContainerFormPnHeader

 TkwBaseSearchContainerFormLbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TBaseSearchContainerForm.lbHeader
[panel]������� lbHeader ����� TBaseSearchContainerForm[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aBaseSearchContainerForm .TBaseSearchContainerForm.lbHeader >>> l_TvtLabel
[code]  }
  private
   function lbHeader(const aCtx: TtfwContext;
    aBaseSearchContainerForm: TBaseSearchContainerForm): TvtLabel;
    {* ���������� ����� ������� .TBaseSearchContainerForm.lbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBaseSearchContainerFormLbHeader

 TkwBaseSearchContainerFormPbHeader = {final} class(TtfwPropertyLike)
  {* ����� ������� .TBaseSearchContainerForm.pbHeader
[panel]������� pbHeader ����� TBaseSearchContainerForm[panel]
*��� ����������:* TPaintBox
*������:*
[code]
OBJECT VAR l_TPaintBox
 aBaseSearchContainerForm .TBaseSearchContainerForm.pbHeader >>> l_TPaintBox
[code]  }
  private
   function pbHeader(const aCtx: TtfwContext;
    aBaseSearchContainerForm: TBaseSearchContainerForm): TPaintBox;
    {* ���������� ����� ������� .TBaseSearchContainerForm.pbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBaseSearchContainerFormPbHeader

 TkwBaseSearchContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TBaseSearchContainerForm.ParentZone
[panel]������� ParentZone ����� TBaseSearchContainerForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aBaseSearchContainerForm .TBaseSearchContainerForm.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
    {* ���������� ����� ������� .TBaseSearchContainerForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBaseSearchContainerFormParentZone

class function Tkw_Form_BaseSearchContainer.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::BaseSearchContainer';
end;//Tkw_Form_BaseSearchContainer.GetWordNameForRegister

function Tkw_Form_BaseSearchContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AA5100EA1801_var*
//#UC END# *4DDFD2EA0116_AA5100EA1801_var*
begin
//#UC START# *4DDFD2EA0116_AA5100EA1801_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AA5100EA1801_impl*
end;//Tkw_Form_BaseSearchContainer.GetString

class function Tkw_BaseSearchContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_BaseSearchContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_45049F216D5D_var*
//#UC END# *4DDFD2EA0116_45049F216D5D_var*
begin
//#UC START# *4DDFD2EA0116_45049F216D5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_45049F216D5D_impl*
end;//Tkw_BaseSearchContainer_Control_ChildZone.GetString

class procedure Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_45049F216D5D_var*
//#UC END# *52A086150180_45049F216D5D_var*
begin
//#UC START# *52A086150180_45049F216D5D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_45049F216D5D_impl*
end;//Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine

procedure Tkw_BaseSearchContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_960F0DF72DE4_var*
//#UC END# *4DAEEDE10285_960F0DF72DE4_var*
begin
//#UC START# *4DAEEDE10285_960F0DF72DE4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_960F0DF72DE4_impl*
end;//Tkw_BaseSearchContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_BaseSearchContainer_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_BaseSearchContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader';
end;//Tkw_BaseSearchContainer_Control_pnHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_pnHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_38D18A248F00_var*
//#UC END# *4DDFD2EA0116_38D18A248F00_var*
begin
//#UC START# *4DDFD2EA0116_38D18A248F00_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_38D18A248F00_impl*
end;//Tkw_BaseSearchContainer_Control_pnHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine;
//#UC START# *52A086150180_38D18A248F00_var*
//#UC END# *52A086150180_38D18A248F00_var*
begin
//#UC START# *52A086150180_38D18A248F00_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_38D18A248F00_impl*
end;//Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine

procedure Tkw_BaseSearchContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_65526659B4E7_var*
//#UC END# *4DAEEDE10285_65526659B4E7_var*
begin
//#UC START# *4DAEEDE10285_65526659B4E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_65526659B4E7_impl*
end;//Tkw_BaseSearchContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pnHeader:push';
end;//Tkw_BaseSearchContainer_Control_pnHeader_Push.GetWordNameForRegister

class function Tkw_BaseSearchContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader';
end;//Tkw_BaseSearchContainer_Control_lbHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_lbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_274A67AD25A0_var*
//#UC END# *4DDFD2EA0116_274A67AD25A0_var*
begin
//#UC START# *4DDFD2EA0116_274A67AD25A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_274A67AD25A0_impl*
end;//Tkw_BaseSearchContainer_Control_lbHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine;
//#UC START# *52A086150180_274A67AD25A0_var*
//#UC END# *52A086150180_274A67AD25A0_var*
begin
//#UC START# *52A086150180_274A67AD25A0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_274A67AD25A0_impl*
end;//Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine

procedure Tkw_BaseSearchContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F6849F49497_var*
//#UC END# *4DAEEDE10285_0F6849F49497_var*
begin
//#UC START# *4DAEEDE10285_0F6849F49497_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F6849F49497_impl*
end;//Tkw_BaseSearchContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::lbHeader:push';
end;//Tkw_BaseSearchContainer_Control_lbHeader_Push.GetWordNameForRegister

class function Tkw_BaseSearchContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader';
end;//Tkw_BaseSearchContainer_Control_pbHeader.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_pbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D86029405CB4_var*
//#UC END# *4DDFD2EA0116_D86029405CB4_var*
begin
//#UC START# *4DDFD2EA0116_D86029405CB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D86029405CB4_impl*
end;//Tkw_BaseSearchContainer_Control_pbHeader.GetString

class procedure Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine;
//#UC START# *52A086150180_D86029405CB4_var*
//#UC END# *52A086150180_D86029405CB4_var*
begin
//#UC START# *52A086150180_D86029405CB4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D86029405CB4_impl*
end;//Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine

procedure Tkw_BaseSearchContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9D02AE695AC4_var*
//#UC END# *4DAEEDE10285_9D02AE695AC4_var*
begin
//#UC START# *4DAEEDE10285_9D02AE695AC4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9D02AE695AC4_impl*
end;//Tkw_BaseSearchContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::pbHeader:push';
end;//Tkw_BaseSearchContainer_Control_pbHeader_Push.GetWordNameForRegister

class function Tkw_BaseSearchContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone';
end;//Tkw_BaseSearchContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_BaseSearchContainer_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AB099B9F85CC_var*
//#UC END# *4DDFD2EA0116_AB099B9F85CC_var*
begin
//#UC START# *4DDFD2EA0116_AB099B9F85CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AB099B9F85CC_impl*
end;//Tkw_BaseSearchContainer_Control_ParentZone.GetString

class procedure Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_AB099B9F85CC_var*
//#UC END# *52A086150180_AB099B9F85CC_var*
begin
//#UC START# *52A086150180_AB099B9F85CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AB099B9F85CC_impl*
end;//Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine

procedure Tkw_BaseSearchContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_47893968884B_var*
//#UC END# *4DAEEDE10285_47893968884B_var*
begin
//#UC START# *4DAEEDE10285_47893968884B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_47893968884B_impl*
end;//Tkw_BaseSearchContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_BaseSearchContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ParentZone:push';
end;//Tkw_BaseSearchContainer_Control_ParentZone_Push.GetWordNameForRegister

function TkwBaseSearchContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {* ���������� ����� ������� .TBaseSearchContainerForm.ChildZone }
//#UC START# *EE67BD516E7A_4369FA9D20E0_var*
//#UC END# *EE67BD516E7A_4369FA9D20E0_var*
begin
//#UC START# *EE67BD516E7A_4369FA9D20E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *EE67BD516E7A_4369FA9D20E0_impl*
end;//TkwBaseSearchContainerFormChildZone.ChildZone

procedure TkwBaseSearchContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4369FA9D20E0_var*
//#UC END# *4DAEEDE10285_4369FA9D20E0_var*
begin
//#UC START# *4DAEEDE10285_4369FA9D20E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4369FA9D20E0_impl*
end;//TkwBaseSearchContainerFormChildZone.DoDoIt

class function TkwBaseSearchContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TBaseSearchContainerForm.ChildZone';
end;//TkwBaseSearchContainerFormChildZone.GetWordNameForRegister

procedure TkwBaseSearchContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4369FA9D20E0_var*
//#UC END# *52D00B00031A_4369FA9D20E0_var*
begin
//#UC START# *52D00B00031A_4369FA9D20E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4369FA9D20E0_impl*
end;//TkwBaseSearchContainerFormChildZone.SetValuePrim

function TkwBaseSearchContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4369FA9D20E0_var*
//#UC END# *551544E2001A_4369FA9D20E0_var*
begin
//#UC START# *551544E2001A_4369FA9D20E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4369FA9D20E0_impl*
end;//TkwBaseSearchContainerFormChildZone.GetResultTypeInfo

function TkwBaseSearchContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBaseSearchContainerFormChildZone.GetAllParamsCount

function TkwBaseSearchContainerFormChildZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4369FA9D20E0_var*
//#UC END# *5617F4D00243_4369FA9D20E0_var*
begin
//#UC START# *5617F4D00243_4369FA9D20E0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4369FA9D20E0_impl*
end;//TkwBaseSearchContainerFormChildZone.ParamsTypes

function TkwBaseSearchContainerFormPnHeader.pnHeader(const aCtx: TtfwContext;
 aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {* ���������� ����� ������� .TBaseSearchContainerForm.pnHeader }
//#UC START# *29B2623F8E83_9C462472CA0F_var*
//#UC END# *29B2623F8E83_9C462472CA0F_var*
begin
//#UC START# *29B2623F8E83_9C462472CA0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *29B2623F8E83_9C462472CA0F_impl*
end;//TkwBaseSearchContainerFormPnHeader.pnHeader

procedure TkwBaseSearchContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9C462472CA0F_var*
//#UC END# *4DAEEDE10285_9C462472CA0F_var*
begin
//#UC START# *4DAEEDE10285_9C462472CA0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9C462472CA0F_impl*
end;//TkwBaseSearchContainerFormPnHeader.DoDoIt

class function TkwBaseSearchContainerFormPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TBaseSearchContainerForm.pnHeader';
end;//TkwBaseSearchContainerFormPnHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9C462472CA0F_var*
//#UC END# *52D00B00031A_9C462472CA0F_var*
begin
//#UC START# *52D00B00031A_9C462472CA0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9C462472CA0F_impl*
end;//TkwBaseSearchContainerFormPnHeader.SetValuePrim

function TkwBaseSearchContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9C462472CA0F_var*
//#UC END# *551544E2001A_9C462472CA0F_var*
begin
//#UC START# *551544E2001A_9C462472CA0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9C462472CA0F_impl*
end;//TkwBaseSearchContainerFormPnHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBaseSearchContainerFormPnHeader.GetAllParamsCount

function TkwBaseSearchContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9C462472CA0F_var*
//#UC END# *5617F4D00243_9C462472CA0F_var*
begin
//#UC START# *5617F4D00243_9C462472CA0F_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9C462472CA0F_impl*
end;//TkwBaseSearchContainerFormPnHeader.ParamsTypes

function TkwBaseSearchContainerFormLbHeader.lbHeader(const aCtx: TtfwContext;
 aBaseSearchContainerForm: TBaseSearchContainerForm): TvtLabel;
 {* ���������� ����� ������� .TBaseSearchContainerForm.lbHeader }
//#UC START# *114D06C5DF55_1A5A446A4230_var*
//#UC END# *114D06C5DF55_1A5A446A4230_var*
begin
//#UC START# *114D06C5DF55_1A5A446A4230_impl*
 !!! Needs to be implemented !!!
//#UC END# *114D06C5DF55_1A5A446A4230_impl*
end;//TkwBaseSearchContainerFormLbHeader.lbHeader

procedure TkwBaseSearchContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A5A446A4230_var*
//#UC END# *4DAEEDE10285_1A5A446A4230_var*
begin
//#UC START# *4DAEEDE10285_1A5A446A4230_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A5A446A4230_impl*
end;//TkwBaseSearchContainerFormLbHeader.DoDoIt

class function TkwBaseSearchContainerFormLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TBaseSearchContainerForm.lbHeader';
end;//TkwBaseSearchContainerFormLbHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1A5A446A4230_var*
//#UC END# *52D00B00031A_1A5A446A4230_var*
begin
//#UC START# *52D00B00031A_1A5A446A4230_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1A5A446A4230_impl*
end;//TkwBaseSearchContainerFormLbHeader.SetValuePrim

function TkwBaseSearchContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1A5A446A4230_var*
//#UC END# *551544E2001A_1A5A446A4230_var*
begin
//#UC START# *551544E2001A_1A5A446A4230_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1A5A446A4230_impl*
end;//TkwBaseSearchContainerFormLbHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBaseSearchContainerFormLbHeader.GetAllParamsCount

function TkwBaseSearchContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1A5A446A4230_var*
//#UC END# *5617F4D00243_1A5A446A4230_var*
begin
//#UC START# *5617F4D00243_1A5A446A4230_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1A5A446A4230_impl*
end;//TkwBaseSearchContainerFormLbHeader.ParamsTypes

function TkwBaseSearchContainerFormPbHeader.pbHeader(const aCtx: TtfwContext;
 aBaseSearchContainerForm: TBaseSearchContainerForm): TPaintBox;
 {* ���������� ����� ������� .TBaseSearchContainerForm.pbHeader }
//#UC START# *37DE407A0407_2D9CD384ECE9_var*
//#UC END# *37DE407A0407_2D9CD384ECE9_var*
begin
//#UC START# *37DE407A0407_2D9CD384ECE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *37DE407A0407_2D9CD384ECE9_impl*
end;//TkwBaseSearchContainerFormPbHeader.pbHeader

procedure TkwBaseSearchContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2D9CD384ECE9_var*
//#UC END# *4DAEEDE10285_2D9CD384ECE9_var*
begin
//#UC START# *4DAEEDE10285_2D9CD384ECE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2D9CD384ECE9_impl*
end;//TkwBaseSearchContainerFormPbHeader.DoDoIt

class function TkwBaseSearchContainerFormPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TBaseSearchContainerForm.pbHeader';
end;//TkwBaseSearchContainerFormPbHeader.GetWordNameForRegister

procedure TkwBaseSearchContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2D9CD384ECE9_var*
//#UC END# *52D00B00031A_2D9CD384ECE9_var*
begin
//#UC START# *52D00B00031A_2D9CD384ECE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2D9CD384ECE9_impl*
end;//TkwBaseSearchContainerFormPbHeader.SetValuePrim

function TkwBaseSearchContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2D9CD384ECE9_var*
//#UC END# *551544E2001A_2D9CD384ECE9_var*
begin
//#UC START# *551544E2001A_2D9CD384ECE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2D9CD384ECE9_impl*
end;//TkwBaseSearchContainerFormPbHeader.GetResultTypeInfo

function TkwBaseSearchContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBaseSearchContainerFormPbHeader.GetAllParamsCount

function TkwBaseSearchContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2D9CD384ECE9_var*
//#UC END# *5617F4D00243_2D9CD384ECE9_var*
begin
//#UC START# *5617F4D00243_2D9CD384ECE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2D9CD384ECE9_impl*
end;//TkwBaseSearchContainerFormPbHeader.ParamsTypes

function TkwBaseSearchContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aBaseSearchContainerForm: TBaseSearchContainerForm): TvtPanel;
 {* ���������� ����� ������� .TBaseSearchContainerForm.ParentZone }
//#UC START# *5661AC027FFB_E4F0AA226464_var*
//#UC END# *5661AC027FFB_E4F0AA226464_var*
begin
//#UC START# *5661AC027FFB_E4F0AA226464_impl*
 !!! Needs to be implemented !!!
//#UC END# *5661AC027FFB_E4F0AA226464_impl*
end;//TkwBaseSearchContainerFormParentZone.ParentZone

procedure TkwBaseSearchContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E4F0AA226464_var*
//#UC END# *4DAEEDE10285_E4F0AA226464_var*
begin
//#UC START# *4DAEEDE10285_E4F0AA226464_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E4F0AA226464_impl*
end;//TkwBaseSearchContainerFormParentZone.DoDoIt

class function TkwBaseSearchContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TBaseSearchContainerForm.ParentZone';
end;//TkwBaseSearchContainerFormParentZone.GetWordNameForRegister

procedure TkwBaseSearchContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E4F0AA226464_var*
//#UC END# *52D00B00031A_E4F0AA226464_var*
begin
//#UC START# *52D00B00031A_E4F0AA226464_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E4F0AA226464_impl*
end;//TkwBaseSearchContainerFormParentZone.SetValuePrim

function TkwBaseSearchContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E4F0AA226464_var*
//#UC END# *551544E2001A_E4F0AA226464_var*
begin
//#UC START# *551544E2001A_E4F0AA226464_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E4F0AA226464_impl*
end;//TkwBaseSearchContainerFormParentZone.GetResultTypeInfo

function TkwBaseSearchContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBaseSearchContainerFormParentZone.GetAllParamsCount

function TkwBaseSearchContainerFormParentZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E4F0AA226464_var*
//#UC END# *5617F4D00243_E4F0AA226464_var*
begin
//#UC START# *5617F4D00243_E4F0AA226464_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E4F0AA226464_impl*
end;//TkwBaseSearchContainerFormParentZone.ParamsTypes

initialization
 Tkw_Form_BaseSearchContainer.RegisterInEngine;
 {* ����������� Tkw_Form_BaseSearchContainer }
 Tkw_BaseSearchContainer_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_ChildZone }
 Tkw_BaseSearchContainer_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_ChildZone_Push }
 Tkw_BaseSearchContainer_Control_pnHeader.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_pnHeader }
 Tkw_BaseSearchContainer_Control_pnHeader_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_pnHeader_Push }
 Tkw_BaseSearchContainer_Control_lbHeader.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_lbHeader }
 Tkw_BaseSearchContainer_Control_lbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_lbHeader_Push }
 Tkw_BaseSearchContainer_Control_pbHeader.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_pbHeader }
 Tkw_BaseSearchContainer_Control_pbHeader_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_pbHeader_Push }
 Tkw_BaseSearchContainer_Control_ParentZone.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_ParentZone }
 Tkw_BaseSearchContainer_Control_ParentZone_Push.RegisterInEngine;
 {* ����������� Tkw_BaseSearchContainer_Control_ParentZone_Push }
 TkwBaseSearchContainerFormChildZone.RegisterInEngine;
 {* ����������� BaseSearchContainerForm_ChildZone }
 TkwBaseSearchContainerFormPnHeader.RegisterInEngine;
 {* ����������� BaseSearchContainerForm_pnHeader }
 TkwBaseSearchContainerFormLbHeader.RegisterInEngine;
 {* ����������� BaseSearchContainerForm_lbHeader }
 TkwBaseSearchContainerFormPbHeader.RegisterInEngine;
 {* ����������� BaseSearchContainerForm_pbHeader }
 TkwBaseSearchContainerFormParentZone.RegisterInEngine;
 {* ����������� BaseSearchContainerForm_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBaseSearchContainerForm));
 {* ����������� ���� BaseSearchContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* ����������� ���� TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
