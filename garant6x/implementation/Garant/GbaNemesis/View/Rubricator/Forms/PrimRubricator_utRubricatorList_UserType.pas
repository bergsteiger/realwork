unit PrimRubricator_utRubricatorList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Rubricator/Forms/PrimRubricator_utRubricatorList_UserType.pas"
// �����: 08.09.2009 20:56
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Rubricator::View::Rubricator::PrimRubricator::utRubricatorList
//
// �������� ��������� (�������� �������������)
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� utRubricatorList }
  utRubricatorListName = 'utRubricatorList';
   { ��������� ������������� ����������������� ���� "�������� ��������� (�������� �������������)" }
  utRubricatorList = TvcmUserType(0);
   { �������� ��������� (�������� �������������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utRubricatorList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utRubricatorList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utRubricatorList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utRubricatorList

class function Tkw_FormUserType_utRubricatorList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utRubricatorList';
end;//Tkw_FormUserType_utRubricatorList.GetWordNameForRegister

function Tkw_FormUserType_utRubricatorList.GetInteger: Integer;
 {-}
begin
 Result := utRubricatorList;
end;//Tkw_FormUserType_utRubricatorList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utRubricatorList
 Tkw_FormUserType_utRubricatorList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.