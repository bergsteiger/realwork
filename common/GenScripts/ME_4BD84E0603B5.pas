unit PrimMonitoringsMain_utEmptyMainWindow_UserType;
 {* ������� ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\PrimMonitoringsMain_utEmptyMainWindow_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� utEmptyMainWindow }
 utEmptyMainWindowName = 'utEmptyMainWindow';
  {* ��������� ������������� ����������������� ���� "������� ����" }
 utEmptyMainWindow = TvcmUserType(0);
  {* ������� ���� }
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

implementation

{$If Defined(Monitorings) AND NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utEmptyMainWindow }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_utEmptyMainWindow
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utEmptyMainWindow';
end;//Tkw_FormUserType_utEmptyMainWindow.GetWordNameForRegister

function Tkw_FormUserType_utEmptyMainWindow.GetInteger: Integer;
begin
 Result := utEmptyMainWindow;
end;//Tkw_FormUserType_utEmptyMainWindow.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utEmptyMainWindow.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utEmptyMainWindow }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Monitorings) AND NOT Defined(Admin)

end.
