unit F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// ������: "w:/common/components/gui/Garant/Daily/Forms/F1LikeFormWithBS_ut_F1LikeFormWithBS_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::F1LikeFormWithBS::ut_F1LikeFormWithBS
//
// ����� � ��������� ���������� � ������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\sdotDefine.inc}

interface

{$If defined(nsTest) AND not defined(NoVCM)}
uses
  vcmUserControls
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� ut_F1LikeFormWithBS }
  ut_F1LikeFormWithBSName = 'ut_F1LikeFormWithBS';
   { ��������� ������������� ����������������� ���� "����� � ��������� ���������� � ������� �������." }
  ut_F1LikeFormWithBS = TvcmUserType(0);
   { ����� � ��������� ���������� � ������� �������. }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_F1LikeFormWithBS = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_F1LikeFormWithBS }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_F1LikeFormWithBS
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_F1LikeFormWithBS

class function Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_F1LikeFormWithBS';
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetWordNameForRegister

function Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger: Integer;
 {-}
begin
 Result := ut_F1LikeFormWithBS;
end;//Tkw_FormUserType_ut_F1LikeFormWithBS.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_F1LikeFormWithBS
 Tkw_FormUserType_ut_F1LikeFormWithBS.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.