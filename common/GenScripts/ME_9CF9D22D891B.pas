unit BaseSearchCard_ut_BaseSearchCard_UserType;
 {* ������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\BaseSearch\Forms\BaseSearchCard_ut_BaseSearchCard_UserType.pas"
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
 {* ��������� ��� ���� ����� ut_BaseSearchCard }
 ut_BaseSearchCardName = 'ut_BaseSearchCard';
  {* ��������� ������������� ����������������� ���� "������� �����" }
 ut_BaseSearchCard = TvcmUserType(0);
  {* ������� ����� }
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
 Tkw_FormUserType_ut_BaseSearchCard = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_BaseSearchCard }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_BaseSearchCard
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_BaseSearchCard';
end;//Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister

function Tkw_FormUserType_ut_BaseSearchCard.GetInteger: Integer;
begin
 Result := ut_BaseSearchCard;
end;//Tkw_FormUserType_ut_BaseSearchCard.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_BaseSearchCard.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_BaseSearchCard }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
