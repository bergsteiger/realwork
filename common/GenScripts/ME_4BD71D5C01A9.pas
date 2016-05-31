unit PrimUserProperty_admUseProperties_UserType;
 {* �������� ������������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\Forms\PrimUserProperty_admUseProperties_UserType.pas"
// ���������: "UserType"
// ������� ������: "admUseProperties" MUID: (4BD71D5C01A9)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ admUsePropertiesLocalConstants }
 str_admUsePropertiesCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'admUsePropertiesCaption'; rValue : '�������� ������������');
  {* ��������� ����������������� ���� "�������� ������������" }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_admUseProperties = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� admUseProperties }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_admUseProperties
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_admUseProperties.GetInteger: Integer;
begin
 Result := admUseProperties;
end;//Tkw_FormUserType_admUseProperties.GetInteger

class function Tkw_FormUserType_admUseProperties.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::admUseProperties';
end;//Tkw_FormUserType_admUseProperties.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_admUsePropertiesCaption.Init;
 {* ������������� str_admUsePropertiesCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_admUseProperties.RegisterInEngine;
 {* ����������� Tkw_FormUserType_admUseProperties }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Admin)

end.
