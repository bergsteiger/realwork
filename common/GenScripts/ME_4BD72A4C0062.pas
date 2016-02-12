unit PrimPicture_pfImage_UserType;
 {* �������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_pfImage_UserType.pas"
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
 {* ��������� ��� ���� ����� pfImage }
 pfImageName = 'pfImage';
  {* ��������� ������������� ����������������� ���� "�������� ������������ �������" }
 pfImage = TvcmUserType(0);
  {* �������� ������������ ������� }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� pfImage }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_pfImage
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister

function Tkw_FormUserType_pfImage.GetInteger: Integer;
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage.RegisterInEngine;
 {* ����������� Tkw_FormUserType_pfImage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
