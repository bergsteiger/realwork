unit UserCR2_WarningBaloonKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UserCR2_WarningBaloon }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\UserCR2_WarningBaloonKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 {$If Defined(Nemesis)}
 , nscEditor
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_UserCR2_WarningBaloon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� UserCR2_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::UserCR2_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR2_WarningBaloon

 Tkw_UserCR2_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer

 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push

 TkwUserCR2WarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TUserCR2_WarningBaloonForm.Viewer
[panel]������� Viewer ����� TUserCR2_WarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aUserCR2_WarningBaloonForm .TUserCR2_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
    {* ���������� ����� ������� .TUserCR2_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwUserCR2WarningBaloonFormViewer

class function Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserCR2_WarningBaloon';
end;//Tkw_Form_UserCR2_WarningBaloon.GetWordNameForRegister

function Tkw_Form_UserCR2_WarningBaloon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_11316102A2C2_var*
//#UC END# *4DDFD2EA0116_11316102A2C2_var*
begin
//#UC START# *4DDFD2EA0116_11316102A2C2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_11316102A2C2_impl*
end;//Tkw_Form_UserCR2_WarningBaloon.GetString

class function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_A546A6C8057F_var*
//#UC END# *4DDFD2EA0116_A546A6C8057F_var*
begin
//#UC START# *4DDFD2EA0116_A546A6C8057F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_A546A6C8057F_impl*
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_A546A6C8057F_var*
//#UC END# *52A086150180_A546A6C8057F_var*
begin
//#UC START# *52A086150180_A546A6C8057F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_A546A6C8057F_impl*
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C9AC5D59E95B_var*
//#UC END# *4DAEEDE10285_C9AC5D59E95B_var*
begin
//#UC START# *4DAEEDE10285_C9AC5D59E95B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C9AC5D59E95B_impl*
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer:push';
end;//Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwUserCR2WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aUserCR2_WarningBaloonForm: TUserCR2_WarningBaloonForm): TnscEditor;
 {* ���������� ����� ������� .TUserCR2_WarningBaloonForm.Viewer }
//#UC START# *634DA3AAFDC8_A8A947A902C4_var*
//#UC END# *634DA3AAFDC8_A8A947A902C4_var*
begin
//#UC START# *634DA3AAFDC8_A8A947A902C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *634DA3AAFDC8_A8A947A902C4_impl*
end;//TkwUserCR2WarningBaloonFormViewer.Viewer

procedure TkwUserCR2WarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A8A947A902C4_var*
//#UC END# *4DAEEDE10285_A8A947A902C4_var*
begin
//#UC START# *4DAEEDE10285_A8A947A902C4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A8A947A902C4_impl*
end;//TkwUserCR2WarningBaloonFormViewer.DoDoIt

class function TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TUserCR2_WarningBaloonForm.Viewer';
end;//TkwUserCR2WarningBaloonFormViewer.GetWordNameForRegister

procedure TkwUserCR2WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
end;//TkwUserCR2WarningBaloonFormViewer.SetValuePrim

function TkwUserCR2WarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwUserCR2WarningBaloonFormViewer.GetResultTypeInfo

function TkwUserCR2WarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwUserCR2WarningBaloonFormViewer.GetAllParamsCount

function TkwUserCR2WarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwUserCR2WarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_UserCR2_WarningBaloon.RegisterInEngine;
 {* ����������� Tkw_Form_UserCR2_WarningBaloon }
 Tkw_UserCR2_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_UserCR2_WarningBaloon_Control_Viewer }
 Tkw_UserCR2_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_UserCR2_WarningBaloon_Control_Viewer_Push }
 TkwUserCR2WarningBaloonFormViewer.RegisterInEngine;
 {* ����������� UserCR2_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR2_WarningBaloonForm));
 {* ����������� ���� UserCR2_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
