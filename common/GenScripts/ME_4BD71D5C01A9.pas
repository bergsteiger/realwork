unit PrimUserProperty_admUseProperties_UserType;
 {* �������� ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserProperty_admUseProperties_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If Defined(Admin)}
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
 {* ��������� ��� ���� ����� admUseProperties }
 admUsePropertiesName = 'admUseProperties';
  {* ��������� ������������� ����������������� ���� "�������� ������������" }
 admUseProperties = TvcmUserType(0);
  {* �������� ������������ }
{$IfEnd} // Defined(Admin)

implementation

{$If Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUseProperties = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admUseProperties }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_admUseProperties
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_admUseProperties.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admUseProperties';
end;//Tkw_FormUserType_admUseProperties.GetWordNameForRegister

function Tkw_FormUserType_admUseProperties.GetInteger: Integer;
begin
 Result := admUseProperties;
end;//Tkw_FormUserType_admUseProperties.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUseProperties.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admUseProperties }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
