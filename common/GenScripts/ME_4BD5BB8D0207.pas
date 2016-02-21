unit PrimSaveLoadUserTypes_slqtKW_UserType;
 {* �����: �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimSaveLoadUserTypes_slqtKW_UserType.pas"
// ���������: "UserType"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 , PrimSaveLoadUserTypes_slqtAttribute_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 {* ��������� ��� ���� ����� slqtKW }
 slqtKWName = 'slqtKW';
  {* ��������� ������������� ����������������� ���� "�����: �� ��������" }
 slqtKW = TvcmUserType(slqtAttribute + 1);
  {* �����: �� �������� }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� slqtKW }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_slqtKW
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_slqtKW.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::slqtKW';
end;//Tkw_FormUserType_slqtKW.GetWordNameForRegister

function Tkw_FormUserType_slqtKW.GetInteger: Integer;
begin
 Result := slqtKW;
end;//Tkw_FormUserType_slqtKW.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_slqtKW.RegisterInEngine;
 {* ����������� Tkw_FormUserType_slqtKW }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
