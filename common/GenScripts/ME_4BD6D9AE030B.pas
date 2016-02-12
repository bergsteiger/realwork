unit PrimTasksPanel_tpMain_UserType;
 {* ������ ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimTasksPanel_tpMain_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
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
 {* ��������� ��� ���� ����� tpMain }
 tpMainName = 'tpMain';
  {* ��������� ������������� ����������������� ���� "������ �����" }
 tpMain = TvcmUserType(0);
  {* ������ ����� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� tpMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_tpMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_tpMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::tpMain';
end;//Tkw_FormUserType_tpMain.GetWordNameForRegister

function Tkw_FormUserType_tpMain.GetInteger: Integer;
begin
 Result := tpMain;
end;//Tkw_FormUserType_tpMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_tpMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_tpMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
