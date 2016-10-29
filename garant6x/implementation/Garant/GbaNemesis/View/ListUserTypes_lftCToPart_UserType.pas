unit ListUserTypes_lftCToPart_UserType;
 {* ������ �� �������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\ListUserTypes_lftCToPart_UserType.pas"
// ���������: "UserType"
// ������� ������: "lftCToPart" MUID: (4BD588C1029B)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , ListUserTypes_lftSynchroView_UserType
 {$If NOT Defined(NoVCM)}
 , vcmUserControls
 {$IfEnd} // NOT Defined(NoVCM)
 , l3StringIDEx
;

const
 {* ������������ ������ lftCToPartLocalConstants }
 str_lftCToPartCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartCaption'; rValue : '������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" }
 str_lftCToPartSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'lftCToPartSettingsCaption'; rValue : '������: ������ �� ��������');
  {* ��������� ����������������� ���� "������ �� ��������" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� lftCToPart }
 lftCToPartName = 'lftCToPart';
  {* ��������� ������������� ����������������� ���� "������ �� ��������" }
 lftCToPart = TvcmUserType(lftSynchroView + 1);
  {* ������ �� �������� }
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
 Tkw_FormUserType_lftCToPart = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� lftCToPart }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_lftCToPart
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_lftCToPart.GetInteger: Integer;
begin
 Result := lftCToPart;
end;//Tkw_FormUserType_lftCToPart.GetInteger

class function Tkw_FormUserType_lftCToPart.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::lftCToPart';
end;//Tkw_FormUserType_lftCToPart.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_lftCToPartCaption.Init;
 {* ������������� str_lftCToPartCaption }
 str_lftCToPartSettingsCaption.Init;
 {* ������������� str_lftCToPartSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_lftCToPart.RegisterInEngine;
 {* ����������� Tkw_FormUserType_lftCToPart }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
