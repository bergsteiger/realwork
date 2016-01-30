unit PrimSaveLoadUserTypes_slqtOldKW_UserType;
 {* �����: �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtOldKW_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtKW_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

const
 {* ��������� ��� ���� ����� slqtOldKW }
 slqtOldKWName = 'slqtOldKW';
  {* ��������� ������������� ����������������� ���� "�����: �� ��������" }
 slqtOldKW = TvcmUserType(slqtKW + 1);
  {* �����: �� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtOldKW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtOldKW
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtOldKW.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtOldKW';
end;//Tkw_FormUserType_slqtOldKW.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_slqtOldKW.GetInteger: Integer;
begin
 Result := slqtOldKW;
end;//Tkw_FormUserType_slqtOldKW.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtOldKW.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtOldKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
