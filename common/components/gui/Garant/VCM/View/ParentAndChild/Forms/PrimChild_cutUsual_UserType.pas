unit PrimChild_cutUsual_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/Forms/PrimChild_cutUsual_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::PrimChild::cutUsual
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� cutUsual }
  cutUsualName = 'cutUsual';
   { ��������� ������������� ����������������� ���� "" }
  cutUsual = TvcmUserType(0);

implementation

{$If not defined(NoScripts)}
type
  Tkw_FormUserType_cutUsual = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� cutUsual }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_cutUsual
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

// start class Tkw_FormUserType_cutUsual

class function Tkw_FormUserType_cutUsual.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::cutUsual';
end;//Tkw_FormUserType_cutUsual.GetWordNameForRegister

function Tkw_FormUserType_cutUsual.GetInteger: Integer;
 {-}
begin
 Result := cutUsual;
end;//Tkw_FormUserType_cutUsual.GetInteger

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_FormUserType_cutUsual
 Tkw_FormUserType_cutUsual.RegisterInEngine;
{$IfEnd} //not NoScripts

end.