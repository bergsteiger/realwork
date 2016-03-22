unit About_ut_About_UserType;
 {* � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\About_ut_About_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_About" MUID: (FF4420B11953)

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
 {* ��������� ��� ���� ����� ut_About }
 ut_AboutName = 'ut_About';
  {* ��������� ������������� ����������������� ���� "� ���������" }
 ut_About = TvcmUserType(0);
  {* � ��������� }
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
 Tkw_FormUserType_ut_About = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_About }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_About
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_About.GetInteger: Integer;
begin
 Result := ut_About;
end;//Tkw_FormUserType_ut_About.GetInteger

class function Tkw_FormUserType_ut_About.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_About';
end;//Tkw_FormUserType_ut_About.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_About.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_About }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
