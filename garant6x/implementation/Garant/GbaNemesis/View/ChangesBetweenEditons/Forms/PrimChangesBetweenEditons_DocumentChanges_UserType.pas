unit PrimChangesBetweenEditons_DocumentChanges_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/ChangesBetweenEditons/Forms/PrimChangesBetweenEditons_DocumentChanges_UserType.pas"
// �����: 25.05.2011 14:13
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������������� �������::ChangesBetweenEditions::View::ChangesBetweenEditons::PrimChangesBetweenEditons::DocumentChanges
//
// ��������� � ���������
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
   { ��������� ��� ���� ����� DocumentChanges }
  DocumentChangesName = 'DocumentChanges';
   { ��������� ������������� ����������������� ���� "��������� � ���������" }
  DocumentChanges = TvcmUserType(0);
   { ��������� � ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_DocumentChanges = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� DocumentChanges }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_DocumentChanges
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_DocumentChanges

class function Tkw_FormUserType_DocumentChanges.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::DocumentChanges';
end;//Tkw_FormUserType_DocumentChanges.GetWordNameForRegister

function Tkw_FormUserType_DocumentChanges.GetInteger: Integer;
 {-}
begin
 Result := DocumentChanges;
end;//Tkw_FormUserType_DocumentChanges.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_DocumentChanges
 Tkw_FormUserType_DocumentChanges.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.