unit F1LikeTextLoad_ut_F1LikeTextLoad_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// �����: ����� �.�.
// ������: "w:/common/components/gui/Garant/Daily/Forms/F1LikeTextLoad_ut_F1LikeTextLoad_UserType.pas"
// �����: 23.09.2010 14:51
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::F1LikeTextLoad::ut_F1LikeTextLoad
//
// F1LikeTextLoad
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
   { ��������� ��� ���� ����� ut_F1LikeTextLoad }
  ut_F1LikeTextLoadName = 'ut_F1LikeTextLoad';
   { ��������� ������������� ����������������� ���� "F1LikeTextLoad" }
  ut_F1LikeTextLoad = TvcmUserType(0);
   { F1LikeTextLoad }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_F1LikeTextLoad = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_F1LikeTextLoad }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_F1LikeTextLoad
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_F1LikeTextLoad

class function Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_F1LikeTextLoad';
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger: Integer;
 {-}
begin
 Result := ut_F1LikeTextLoad;
end;//Tkw_FormUserType_ut_F1LikeTextLoad.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_F1LikeTextLoad
 Tkw_FormUserType_ut_F1LikeTextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.