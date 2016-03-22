unit PrimConsultationMark_utcmMain_UserType;
 {* ������ ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Consultation\Forms\PrimConsultationMark_utcmMain_UserType.pas"
// ���������: "UserType"
// ������� ������: "utcmMain" MUID: (4CD142B70232)

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
 {* ��������� ��� ���� ����� utcmMain }
 utcmMainName = 'utcmMain';
  {* ��������� ������������� ����������������� ���� "������ ������" }
 utcmMain = TvcmUserType(0);
  {* ������ ������ }
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
 Tkw_FormUserType_utcmMain = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� utcmMain }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_utcmMain
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_utcmMain.GetInteger: Integer;
begin
 Result := utcmMain;
end;//Tkw_FormUserType_utcmMain.GetInteger

class function Tkw_FormUserType_utcmMain.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::utcmMain';
end;//Tkw_FormUserType_utcmMain.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_utcmMain.RegisterInEngine;
 {* ����������� Tkw_FormUserType_utcmMain }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
