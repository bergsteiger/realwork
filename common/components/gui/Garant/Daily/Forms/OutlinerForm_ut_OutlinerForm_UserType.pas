unit OutlinerForm_ut_OutlinerForm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Forms"
// �����: ������ �.�.
// ������: "w:/common/components/gui/Garant/Daily/Forms/OutlinerForm_ut_OutlinerForm_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi Operations For Tests::TestForms::Forms::Outliner::OutlinerForm::ut_OutlinerForm
//
// ����� ��� ������������ ������
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
   { ��������� ��� ���� ����� ut_OutlinerForm }
  ut_OutlinerFormName = 'ut_OutlinerForm';
   { ��������� ������������� ����������������� ���� "����� ��� ������������ ������" }
  ut_OutlinerForm = TvcmUserType(0);
   { ����� ��� ������������ ������ }
{$IfEnd} //nsTest AND not NoVCM

implementation

{$If defined(nsTest) AND not defined(NoVCM)}
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
type
  Tkw_FormUserType_ut_OutlinerForm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� ut_OutlinerForm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_ut_OutlinerForm
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}

// start class Tkw_FormUserType_ut_OutlinerForm

class function Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_OutlinerForm';
end;//Tkw_FormUserType_ut_OutlinerForm.GetWordNameForRegister

function Tkw_FormUserType_ut_OutlinerForm.GetInteger: Integer;
 {-}
begin
 Result := ut_OutlinerForm;
end;//Tkw_FormUserType_ut_OutlinerForm.GetInteger

{$IfEnd} //nsTest AND not NoScripts AND not NoVCM
{$IfEnd} //nsTest AND not NoVCM

initialization
{$If defined(nsTest) AND not defined(NoScripts) AND not defined(NoVCM)}
// ����������� Tkw_FormUserType_ut_OutlinerForm
 Tkw_FormUserType_ut_OutlinerForm.RegisterInEngine;
{$IfEnd} //nsTest AND not NoScripts AND not NoVCM

end.