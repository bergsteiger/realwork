unit QFLikeTextLoad_ut_QFLikeTextLoad_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// ������: "w:/common/components/gui/Garant/Daily/Forms/QFLikeTextLoad_ut_QFLikeTextLoad_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Everest::QFLikeTextLoad::ut_QFLikeTextLoad
//
// ����� ��� ������ � ��
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
   { ��������� ��� ���� ����� ut_QFLikeTextLoad }
  ut_QFLikeTextLoadName = 'ut_QFLikeTextLoad';
   { ��������� ������������� ����������������� ���� "����� ��� ������ � ��" }
  ut_QFLikeTextLoad = TvcmUserType(0);
   { ����� ��� ������ � �� }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_QFLikeTextLoad = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_QFLikeTextLoad }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_QFLikeTextLoad
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_QFLikeTextLoad

class function Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_QFLikeTextLoad';
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetWordNameForRegister

function Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger: Integer;
 {-}
begin
 Result := ut_QFLikeTextLoad;
end;//Tkw_FormUserType_ut_QFLikeTextLoad.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_QFLikeTextLoad
 Tkw_FormUserType_ut_QFLikeTextLoad.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.