unit elCustomEdit_ut_elCustomEdit_UserType;
 {* ����� ��� ������������ TelCustomEdit }

// ������: "w:\common\components\gui\Garant\Daily\Forms\elCustomEdit_ut_elCustomEdit_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_elCustomEdit" MUID: (ADA641CE296E)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* ��������� ��� ���� ����� ut_elCustomEdit }
 ut_elCustomEditName = 'ut_elCustomEdit';
  {* ��������� ������������� ����������������� ���� "����� ��� ������������ TelCustomEdit" }
 ut_elCustomEdit = TvcmUserType(0);
  {* ����� ��� ������������ TelCustomEdit }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

{$If NOT Defined(NoScripts)}
type
 Tkw_FormUserType_ut_elCustomEdit = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_elCustomEdit }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_elCustomEdit
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_elCustomEdit.GetInteger: Integer;
begin
 Result := ut_elCustomEdit;
end;//Tkw_FormUserType_ut_elCustomEdit.GetInteger

class function Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_elCustomEdit';
end;//Tkw_FormUserType_ut_elCustomEdit.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_elCustomEdit.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_elCustomEdit }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
