unit PrimSaveLoadUserTypes_slqtConsult_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimSaveLoadUserTypes_slqtConsult_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimSaveLoadUserTypes::slqtConsult
//
// �������� ��������� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  vcmUserControls
  {$IfEnd} //not NoVCM
  ,
  PrimSaveLoadUserTypes_slqtPostingOrder_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� slqtConsult }
  slqtConsultName = 'slqtConsult';
   { ��������� ������������� ����������������� ���� "�������� ��������� ������" }
  slqtConsult = TvcmUserType(slqtPostingOrder + 1);
   { �������� ��������� ������ }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_slqtConsult = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� slqtConsult }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_slqtConsult
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_slqtConsult

class function Tkw_FormUserType_slqtConsult.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::slqtConsult';
end;//Tkw_FormUserType_slqtConsult.GetWordNameForRegister

function Tkw_FormUserType_slqtConsult.GetInteger: Integer;
 {-}
begin
 Result := slqtConsult;
end;//Tkw_FormUserType_slqtConsult.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_slqtConsult
 Tkw_FormUserType_slqtConsult.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.