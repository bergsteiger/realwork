unit PrimTreeAttributeFirstLevel_flSituation_UserType;
 {* �������� ������� ������ (�������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
// ���������: "UserType"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin)}
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
 {* ��������� ��� ���� ����� flSituation }
 flSituationName = 'flSituation';
  {* ��������� ������������� ����������������� ���� "�������� ������� ������ (�������)" }
 flSituation = TvcmUserType(0);
  {* �������� ������� ������ (�������) }
{$IfEnd} // NOT Defined(Admin)

implementation

{$If NOT Defined(Admin)}
uses
 l3ImplUses
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� flSituation }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_flSituation
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister

function Tkw_FormUserType_flSituation.GetInteger: Integer;
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_flSituation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
