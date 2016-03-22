unit PrimTreeAttributeFirstLevel_flSituation_UserType;
 {* �������� ������� ������ (�������) }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PrimTreeAttributeFirstLevel_flSituation_UserType.pas"
// ���������: "UserType"
// ������� ������: "flSituation" MUID: (4BD71C0000AE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
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
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_flSituation = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� flSituation }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_flSituation
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_flSituation.GetInteger: Integer;
begin
 Result := flSituation;
end;//Tkw_FormUserType_flSituation.GetInteger

class function Tkw_FormUserType_flSituation.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::flSituation';
end;//Tkw_FormUserType_flSituation.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_flSituation.RegisterInEngine;
 {* ����������� Tkw_FormUserType_flSituation }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin)

end.
