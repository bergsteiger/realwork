unit ListUserTypes_lftCorrespondent_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ListUserTypes_lftCorrespondent_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::ListUserTypes::lftCorrespondent
//
// ������ �� ��������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  ListUserTypes_lftRespondent_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� lftCorrespondent }
  lftCorrespondentName = 'lftCorrespondent';
   { ��������� ������������� ����������������� ���� "������ �� ��������" }
  lftCorrespondent = TvcmUserType(lftRespondent + 1);
   { ������ �� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_lftCorrespondent = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� lftCorrespondent }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_lftCorrespondent
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_lftCorrespondent

class function Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::lftCorrespondent';
end;//Tkw_FormUserType_lftCorrespondent.GetWordNameForRegister

function Tkw_FormUserType_lftCorrespondent.GetInteger: Integer;
 {-}
begin
 Result := lftCorrespondent;
end;//Tkw_FormUserType_lftCorrespondent.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_lftCorrespondent
 Tkw_FormUserType_lftCorrespondent.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.