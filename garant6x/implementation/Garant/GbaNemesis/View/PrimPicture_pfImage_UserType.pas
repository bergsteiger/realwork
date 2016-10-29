unit PrimPicture_pfImage_UserType;
 {* �������� ������������ ������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\PrimPicture_pfImage_UserType.pas"
// ���������: "UserType"
// ������� ������: "pfImage" MUID: (4BD72A4C0062)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ pfImageLocalConstants }
 str_pfImageCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageCaption'; rValue : '�������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" }
 str_pfImageSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'pfImageSettingsCaption'; rValue : '��������: �������� ������������ �������');
  {* ��������� ����������������� ���� "�������� ������������ �������" ��� ��������� ������� ������������ }
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_pfImage = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� pfImage }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_pfImage
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_pfImage.GetInteger: Integer;
begin
 Result := pfImage;
end;//Tkw_FormUserType_pfImage.GetInteger

class function Tkw_FormUserType_pfImage.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::pfImage';
end;//Tkw_FormUserType_pfImage.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_pfImageCaption.Init;
 {* ������������� str_pfImageCaption }
 str_pfImageSettingsCaption.Init;
 {* ������������� str_pfImageSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_pfImage.RegisterInEngine;
 {* ����������� Tkw_FormUserType_pfImage }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
