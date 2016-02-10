unit UserCR1_WarningBaloonKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UserCR1_WarningBaloon }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\UserCR1_WarningBaloonKeywordsPack.pas"
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
 Tkw_Form_UserCR1_WarningBaloon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� UserCR1_WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::UserCR1_WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserCR1_WarningBaloon

 Tkw_UserCR1_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_UserCR1_WarningBaloon_Control_Viewer

 Tkw_UserCR1_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push

 TkwUserCR1WarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TUserCR1_WarningBaloonForm.Viewer
[panel]������� Viewer ����� TUserCR1_WarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aUserCR1_WarningBaloonForm .TUserCR1_WarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
    {* ���������� ����� ������� .TUserCR1_WarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwUserCR1WarningBaloonFormViewer

class function Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserCR1_WarningBaloon';
end;//Tkw_Form_UserCR1_WarningBaloon.GetWordNameForRegister

function Tkw_Form_UserCR1_WarningBaloon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AD39E7ED8CEA_var*
//#UC END# *4DDFD2EA0116_AD39E7ED8CEA_var*
begin
//#UC START# *4DDFD2EA0116_AD39E7ED8CEA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AD39E7ED8CEA_impl*
end;//Tkw_Form_UserCR1_WarningBaloon.GetString

class function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8CF7747C37B3_var*
//#UC END# *4DDFD2EA0116_8CF7747C37B3_var*
begin
//#UC START# *4DDFD2EA0116_8CF7747C37B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8CF7747C37B3_impl*
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_8CF7747C37B3_var*
//#UC END# *52A086150180_8CF7747C37B3_var*
begin
//#UC START# *52A086150180_8CF7747C37B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8CF7747C37B3_impl*
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_062C6C431BEB_var*
//#UC END# *4DAEEDE10285_062C6C431BEB_var*
begin
//#UC START# *4DAEEDE10285_062C6C431BEB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_062C6C431BEB_impl*
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer:push';
end;//Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwUserCR1WarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aUserCR1_WarningBaloonForm: TUserCR1_WarningBaloonForm): TnscEditor;
 {* ���������� ����� ������� .TUserCR1_WarningBaloonForm.Viewer }
//#UC START# *710B1D82649B_65A23A9E714E_var*
//#UC END# *710B1D82649B_65A23A9E714E_var*
begin
//#UC START# *710B1D82649B_65A23A9E714E_impl*
 !!! Needs to be implemented !!!
//#UC END# *710B1D82649B_65A23A9E714E_impl*
end;//TkwUserCR1WarningBaloonFormViewer.Viewer

procedure TkwUserCR1WarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_65A23A9E714E_var*
//#UC END# *4DAEEDE10285_65A23A9E714E_var*
begin
//#UC START# *4DAEEDE10285_65A23A9E714E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_65A23A9E714E_impl*
end;//TkwUserCR1WarningBaloonFormViewer.DoDoIt

class function TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TUserCR1_WarningBaloonForm.Viewer';
end;//TkwUserCR1WarningBaloonFormViewer.GetWordNameForRegister

procedure TkwUserCR1WarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ', aCtx);
end;//TkwUserCR1WarningBaloonFormViewer.SetValuePrim

function TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwUserCR1WarningBaloonFormViewer.GetResultTypeInfo

function TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwUserCR1WarningBaloonFormViewer.GetAllParamsCount

function TkwUserCR1WarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwUserCR1WarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_UserCR1_WarningBaloon.RegisterInEngine;
 {* ����������� Tkw_Form_UserCR1_WarningBaloon }
 Tkw_UserCR1_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_UserCR1_WarningBaloon_Control_Viewer }
 Tkw_UserCR1_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_UserCR1_WarningBaloon_Control_Viewer_Push }
 TkwUserCR1WarningBaloonFormViewer.RegisterInEngine;
 {* ����������� UserCR1_WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TUserCR1_WarningBaloonForm));
 {* ����������� ���� UserCR1_WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
