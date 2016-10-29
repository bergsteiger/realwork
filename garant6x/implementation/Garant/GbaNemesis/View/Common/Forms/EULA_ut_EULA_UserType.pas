unit EULA_ut_EULA_UserType;
 {* ������� ������������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\EULA_ut_EULA_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_EULA" MUID: (88631209C038)

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
 {* ������������ ������ ut_EULALocalConstants }
 str_ut_EULACaption: Tl3StringIDEx = (rS : -1; rLocalized : false; rKey : 'ut_EULACaption'; rValue : '������� �������������');
  {* ��������� ����������������� ���� "������� �������������" }
 {* ��������� ��� ���� ����� ut_EULA }
 ut_EULAName = 'ut_EULA';
  {* ��������� ������������� ����������������� ���� "������� �������������" }
 ut_EULA = TvcmUserType(0);
  {* ������� ������������� }
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
 Tkw_FormUserType_ut_EULA = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_EULA }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_EULA
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_EULA.GetInteger: Integer;
begin
 Result := ut_EULA;
end;//Tkw_FormUserType_ut_EULA.GetInteger

class function Tkw_FormUserType_ut_EULA.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_EULA';
end;//Tkw_FormUserType_ut_EULA.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
 str_ut_EULACaption.Init;
 {* ������������� str_ut_EULACaption }
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_EULA.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_EULA }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
