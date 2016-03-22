unit F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType;
 {* ����� � ��������� ���������� � ������� �������. }

// ������: "w:\common\components\gui\Garant\Daily\Forms\F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType.pas"
// ���������: "UserType"
// ������� ������: "ut_F1LikeFormWithBS" MUID: (7865160AD7D7)

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If Defined(nsTest) AND NOT Defined(NoVCM)}
uses
 l3IntfUses
 , vcmUserControls
;

const
 {* ��������� ��� ���� ����� ut_F1LikeFormWithBS }
 ut_F1LikeFormWithBSName = 'ut_F1LikeFormWithBS';
  {* ��������� ������������� ����������������� ���� "����� � ��������� ���������� � ������� �������." }
 ut_F1LikeFormWithBS = TvcmUserType(0);
  {* ����� � ��������� ���������� � ������� �������. }
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
 Tkw_FormUserType_ut_F1LikeFormWithBS = {final} class(TtfwInteger)
  {* ����� ������� ��� ���� ����� ut_F1LikeFormWithBS }
  protected
   function GetInteger: Integer; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FormUserType_ut_F1LikeFormWithBS
{$IfEnd} // NOT Defined(NoScripts)

{$If NOT Defined(NoScripts)}
function Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger: Integer;
begin
 Result := ut_F1LikeFormWithBS;
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger

class function Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister: AnsiString;
begin
 Result := '���_�����::ut_F1LikeFormWithBS';
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister
{$IfEnd} // NOT Defined(NoScripts)

initialization
{$If NOT Defined(NoScripts)}
 Tkw_FormUserType_ut_F1LikeFormWithBS.RegisterInEngine;
 {* ����������� Tkw_FormUserType_ut_F1LikeFormWithBS }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(nsTest) AND NOT Defined(NoVCM)

end.
