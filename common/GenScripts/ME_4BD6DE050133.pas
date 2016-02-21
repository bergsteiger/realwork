unit PrimMedicFirmList_mflMain_UserType;
 {* ���������������� ����� (������ ������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\Forms\PrimMedicFirmList_mflMain_UserType.pas"
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
 {* ��������� ��� ���� ����� mflMain }
 mflMainName = 'mflMain';
  {* ��������� ������������� ����������������� ���� "���������������� ����� (������ ������)" }
 mflMain = TvcmUserType(0);
  {* ���������������� ����� (������ ������) }
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
 Tkw_FormUserType_mflMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� mflMain }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_mflMain
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_mflMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::mflMain';
end;//Tkw_FormUserType_mflMain.GetWordNameForRegister

function Tkw_FormUserType_mflMain.GetInteger: Integer;
begin
 Result := mflMain;
end;//Tkw_FormUserType_mflMain.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_mflMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_mflMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
