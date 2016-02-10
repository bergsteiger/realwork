unit MedicListSynchroViewKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� MedicListSynchroView }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicListSynchroViewKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Inpharm_Module
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
 Tkw_Form_MedicListSynchroView = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� MedicListSynchroView
----
*������ �������������*:
[code]
'aControl' �����::MedicListSynchroView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicListSynchroView

 Tkw_MedicListSynchroView_Control_ztChild = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ztChild
----
*������ �������������*:
[code]
�������::ztChild TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicListSynchroView_Control_ztChild

 Tkw_MedicListSynchroView_Control_ztChild_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ztChild
----
*������ �������������*:
[code]
�������::ztChild:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicListSynchroView_Control_ztChild_Push

 TkwEnMedicListSynchroViewZtChild = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_MedicListSynchroView.ztChild
[panel]������� ztChild ����� Ten_MedicListSynchroView[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicListSynchroView .Ten_MedicListSynchroView.ztChild >>> l_TvtPanel
[code]  }
  private
   function ztChild(const aCtx: TtfwContext;
    aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
    {* ���������� ����� ������� .Ten_MedicListSynchroView.ztChild }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicListSynchroViewZtChild

class function Tkw_Form_MedicListSynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetWordNameForRegister

function Tkw_Form_MedicListSynchroView.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E7B39B4BEC84_var*
//#UC END# *4DDFD2EA0116_E7B39B4BEC84_var*
begin
//#UC START# *4DDFD2EA0116_E7B39B4BEC84_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E7B39B4BEC84_impl*
end;//Tkw_Form_MedicListSynchroView.GetString

class function Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister

function Tkw_MedicListSynchroView_Control_ztChild.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AD16E495852F_var*
//#UC END# *4DDFD2EA0116_AD16E495852F_var*
begin
//#UC START# *4DDFD2EA0116_AD16E495852F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AD16E495852F_impl*
end;//Tkw_MedicListSynchroView_Control_ztChild.GetString

class procedure Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
//#UC START# *52A086150180_AD16E495852F_var*
//#UC END# *52A086150180_AD16E495852F_var*
begin
//#UC START# *52A086150180_AD16E495852F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AD16E495852F_impl*
end;//Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine

procedure Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44E9C0B077E7_var*
//#UC END# *4DAEEDE10285_44E9C0B077E7_var*
begin
//#UC START# *4DAEEDE10285_44E9C0B077E7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44E9C0B077E7_impl*
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt

class function Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ztChild:push';
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister

function TkwEnMedicListSynchroViewZtChild.ztChild(const aCtx: TtfwContext;
 aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
 {* ���������� ����� ������� .Ten_MedicListSynchroView.ztChild }
//#UC START# *CADC58F04913_B2A1FE850B9A_var*
//#UC END# *CADC58F04913_B2A1FE850B9A_var*
begin
//#UC START# *CADC58F04913_B2A1FE850B9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *CADC58F04913_B2A1FE850B9A_impl*
end;//TkwEnMedicListSynchroViewZtChild.ztChild

procedure TkwEnMedicListSynchroViewZtChild.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2A1FE850B9A_var*
//#UC END# *4DAEEDE10285_B2A1FE850B9A_var*
begin
//#UC START# *4DAEEDE10285_B2A1FE850B9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2A1FE850B9A_impl*
end;//TkwEnMedicListSynchroViewZtChild.DoDoIt

class function TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicListSynchroView.ztChild';
end;//TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister

procedure TkwEnMedicListSynchroViewZtChild.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B2A1FE850B9A_var*
//#UC END# *52D00B00031A_B2A1FE850B9A_var*
begin
//#UC START# *52D00B00031A_B2A1FE850B9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B2A1FE850B9A_impl*
end;//TkwEnMedicListSynchroViewZtChild.SetValuePrim

function TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo

function TkwEnMedicListSynchroViewZtChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicListSynchroViewZtChild.GetAllParamsCount

function TkwEnMedicListSynchroViewZtChild.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B2A1FE850B9A_var*
//#UC END# *5617F4D00243_B2A1FE850B9A_var*
begin
//#UC START# *5617F4D00243_B2A1FE850B9A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B2A1FE850B9A_impl*
end;//TkwEnMedicListSynchroViewZtChild.ParamsTypes

initialization
 Tkw_Form_MedicListSynchroView.RegisterInEngine;
 {* ����������� Tkw_Form_MedicListSynchroView }
 Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
 {* ����������� Tkw_MedicListSynchroView_Control_ztChild }
 Tkw_MedicListSynchroView_Control_ztChild_Push.RegisterInEngine;
 {* ����������� Tkw_MedicListSynchroView_Control_ztChild_Push }
 TkwEnMedicListSynchroViewZtChild.RegisterInEngine;
 {* ����������� en_MedicListSynchroView_ztChild }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicListSynchroView));
 {* ����������� ���� MedicListSynchroView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
