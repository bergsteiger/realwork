unit PrimNavigator_utNavigator_UserType;
 {* ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\PrimNavigator_utNavigator_UserType.pas"
// ���������: "UserType"
// ������� ������: "utNavigator" MUID: (4BD72ACA02F6)

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
 {* ������������ ������ utNavigatorLocalConstants }
 str_utNavigatorCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorCaption'; rValue : '����');
  {* ��������� ����������������� ���� "����" }
 str_utNavigatorSettingsCaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'utNavigatorSettingsCaption'; rValue : '���� (�������)');
  {* ��������� ����������������� ���� "����" ��� ��������� ������� ������������ }
 {* ��������� ��� ���� ����� utNavigator }
 utNavigatorName = 'utNavigator';
  {* ��������� ������������� ����������������� ���� "����" }
 utNavigator = TvcmUserType(0);
  {* ���� }
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
 Tkw_FormUserType_utNavigator = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utNavigator }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utNavigator
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utNavigator.GetInteger: Integer;
begin
 Result := utNavigator;
end;//Tkw_FormUserType_utNavigator.GetInteger

class function Tkw_FormUserType_utNavigator.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utNavigator';
end;//Tkw_FormUserType_utNavigator.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_utNavigatorCaption.Init;
 {* ������������� str_utNavigatorCaption }
 str_utNavigatorSettingsCaption.Init;
 {* ������������� str_utNavigatorSettingsCaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utNavigator.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utNavigator }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
