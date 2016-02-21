unit NemesisMain_utMainWindow_UserType;
 {* ������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\NemesisMain_utMainWindow_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� utMainWindow }
 utMainWindowName = 'utMainWindow';
  {* ��������� ������������� ����������������� ���� "������� ����" }
 utMainWindow = TvcmUserType(0);
  {* ������� ���� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainWindow = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utMainWindow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utMainWindow
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utMainWindow';
end;//Tkw_FormUserType_utMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utMainWindow.GetInteger: Integer;
begin
 Result := utMainWindow;
end;//Tkw_FormUserType_utMainWindow.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utMainWindow.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
