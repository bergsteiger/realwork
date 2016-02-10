unit WarningBaloonKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� WarningBaloon }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\WarningBaloonKeywordsPack.pas"
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
 Tkw_Form_WarningBaloon = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� WarningBaloon
----
*������ �������������*:
[code]
'aControl' �����::WarningBaloon TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_WarningBaloon

 Tkw_WarningBaloon_Control_Viewer = {final} class(TtfwControlString)
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
 end;//Tkw_WarningBaloon_Control_Viewer

 Tkw_WarningBaloon_Control_Viewer_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� Viewer
----
*������ �������������*:
[code]
�������::Viewer:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_WarningBaloon_Control_Viewer_Push

 TkwWarningBaloonFormViewer = {final} class(TtfwPropertyLike)
  {* ����� ������� .TWarningBaloonForm.Viewer
[panel]������� Viewer ����� TWarningBaloonForm[panel]
*��� ����������:* TnscEditor
*������:*
[code]
OBJECT VAR l_TnscEditor
 aWarningBaloonForm .TWarningBaloonForm.Viewer >>> l_TnscEditor
[code]  }
  private
   function Viewer(const aCtx: TtfwContext;
    aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
    {* ���������� ����� ������� .TWarningBaloonForm.Viewer }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwWarningBaloonFormViewer

class function Tkw_Form_WarningBaloon.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::WarningBaloon';
end;//Tkw_Form_WarningBaloon.GetWordNameForRegister

function Tkw_Form_WarningBaloon.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7F45DE4EB998_var*
//#UC END# *4DDFD2EA0116_7F45DE4EB998_var*
begin
//#UC START# *4DDFD2EA0116_7F45DE4EB998_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7F45DE4EB998_impl*
end;//Tkw_Form_WarningBaloon.GetString

class function Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer';
end;//Tkw_WarningBaloon_Control_Viewer.GetWordNameForRegister

function Tkw_WarningBaloon_Control_Viewer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_915A024169A2_var*
//#UC END# *4DDFD2EA0116_915A024169A2_var*
begin
//#UC START# *4DDFD2EA0116_915A024169A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_915A024169A2_impl*
end;//Tkw_WarningBaloon_Control_Viewer.GetString

class procedure Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
//#UC START# *52A086150180_915A024169A2_var*
//#UC END# *52A086150180_915A024169A2_var*
begin
//#UC START# *52A086150180_915A024169A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_915A024169A2_impl*
end;//Tkw_WarningBaloon_Control_Viewer.RegisterInEngine

procedure Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7E6C9BCC2E13_var*
//#UC END# *4DAEEDE10285_7E6C9BCC2E13_var*
begin
//#UC START# *4DAEEDE10285_7E6C9BCC2E13_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7E6C9BCC2E13_impl*
end;//Tkw_WarningBaloon_Control_Viewer_Push.DoDoIt

class function Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::Viewer:push';
end;//Tkw_WarningBaloon_Control_Viewer_Push.GetWordNameForRegister

function TkwWarningBaloonFormViewer.Viewer(const aCtx: TtfwContext;
 aWarningBaloonForm: TWarningBaloonForm): TnscEditor;
 {* ���������� ����� ������� .TWarningBaloonForm.Viewer }
//#UC START# *A7DCFD28DF9D_6B8C8DEE7B25_var*
//#UC END# *A7DCFD28DF9D_6B8C8DEE7B25_var*
begin
//#UC START# *A7DCFD28DF9D_6B8C8DEE7B25_impl*
 !!! Needs to be implemented !!!
//#UC END# *A7DCFD28DF9D_6B8C8DEE7B25_impl*
end;//TkwWarningBaloonFormViewer.Viewer

procedure TkwWarningBaloonFormViewer.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6B8C8DEE7B25_var*
//#UC END# *4DAEEDE10285_6B8C8DEE7B25_var*
begin
//#UC START# *4DAEEDE10285_6B8C8DEE7B25_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6B8C8DEE7B25_impl*
end;//TkwWarningBaloonFormViewer.DoDoIt

class function TkwWarningBaloonFormViewer.GetWordNameForRegister: AnsiString;
begin
 Result := '.TWarningBaloonForm.Viewer';
end;//TkwWarningBaloonFormViewer.GetWordNameForRegister

procedure TkwWarningBaloonFormViewer.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6B8C8DEE7B25_var*
//#UC END# *52D00B00031A_6B8C8DEE7B25_var*
begin
//#UC START# *52D00B00031A_6B8C8DEE7B25_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6B8C8DEE7B25_impl*
end;//TkwWarningBaloonFormViewer.SetValuePrim

function TkwWarningBaloonFormViewer.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEditor);
end;//TkwWarningBaloonFormViewer.GetResultTypeInfo

function TkwWarningBaloonFormViewer.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwWarningBaloonFormViewer.GetAllParamsCount

function TkwWarningBaloonFormViewer.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6B8C8DEE7B25_var*
//#UC END# *5617F4D00243_6B8C8DEE7B25_var*
begin
//#UC START# *5617F4D00243_6B8C8DEE7B25_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6B8C8DEE7B25_impl*
end;//TkwWarningBaloonFormViewer.ParamsTypes

initialization
 Tkw_Form_WarningBaloon.RegisterInEngine;
 {* ����������� Tkw_Form_WarningBaloon }
 Tkw_WarningBaloon_Control_Viewer.RegisterInEngine;
 {* ����������� Tkw_WarningBaloon_Control_Viewer }
 Tkw_WarningBaloon_Control_Viewer_Push.RegisterInEngine;
 {* ����������� Tkw_WarningBaloon_Control_Viewer_Push }
 TkwWarningBaloonFormViewer.RegisterInEngine;
 {* ����������� WarningBaloonForm_Viewer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWarningBaloonForm));
 {* ����������� ���� WarningBaloon }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEditor));
 {* ����������� ���� TnscEditor }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
