unit PrimListAnalizer_listAnalize_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/List/Forms/PrimListAnalizer_listAnalize_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::WorkWithList::View::List::PrimListAnalizer::listAnalize
//
// ������ ������
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
   { ��������� ��� ���� ����� listAnalize }
  listAnalizeName = 'listAnalize';
   { ��������� ������������� ����������������� ���� "������ ������" }
  listAnalize = TvcmUserType(0);
   { ������ ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_listAnalize = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� listAnalize }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_listAnalize
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_listAnalize

class function Tkw_FormUserType_listAnalize.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::listAnalize';
end;//Tkw_FormUserType_listAnalize.GetWordNameForRegister

function Tkw_FormUserType_listAnalize.GetInteger: Integer;
 {-}
begin
 Result := listAnalize;
end;//Tkw_FormUserType_listAnalize.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_listAnalize
 Tkw_FormUserType_listAnalize.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.