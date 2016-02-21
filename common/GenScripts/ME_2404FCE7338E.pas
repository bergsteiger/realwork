unit OutlinerForm_ut_OutlinerForm_UserType;
 {* ����� ��� ������������ ������ }

// ������: "w:\common\components\gui\Garant\Daily\Forms\OutlinerForm_ut_OutlinerForm_UserType.pas"
// ���������: "UserType"

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* ��������� ��� ���� ����� ut_OutlinerForm }
 ut_OutlinerFormName = 'ut_OutlinerForm';
  {* ��������� ������������� ����������������� ���� "����� ��� ������������ ������" }
 ut_OutlinerForm = TvcmUserType(0);
  {* ����� ��� ������������ ������ }
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

implementation

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , tfwInteger
 {$IfEnd} // NOT Defined(NoScripts)
;

type
 {$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_OutlinerForm = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_OutlinerForm }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
 end;//Tkw_FormUserType_ut_OutlinerForm
 {$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
class function Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_OutlinerForm';
end;//Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister

function Tkw_FormUserType_ut_OutlinerForm.GetInteger: Integer;
begin
 Result := ut_OutlinerForm;
end;//Tkw_FormUserType_ut_OutlinerForm.GetInteger
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_OutlinerForm.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_OutlinerForm }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
