unit PrimChild_cutForDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/PrimChild_cutForDiction_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::PrimChild::cutForDiction
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimChild_cutUsual_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� cutForDiction }
  cutForDictionName = 'cutForDiction';
   { ��������� ������������� ����������������� ���� "" }
  cutForDiction = TvcmUserType(cutUsual + 1);

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_cutForDiction = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� cutForDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutForDiction
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_cutForDiction

class function Tkw_FormUserType_cutForDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::cutForDiction';
end;//Tkw_FormUserType_cutForDiction.GetWordNameForRegister

function Tkw_FormUserType_cutForDiction.GetInteger: Integer;
 {-}
begin
 Result := cutForDiction;
end;//Tkw_FormUserType_cutForDiction.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_cutForDiction
 Tkw_FormUserType_cutForDiction.RegisterInEngine;
{$IfEnd} //not NoScripts

end.