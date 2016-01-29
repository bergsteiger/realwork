unit PrimPageSetup_pstNone_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View$For F1 and Monitorings"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/PrimPageSetup_pstNone_UserType.pas"
// �����: 15.09.2009 16:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Common For Shell And Monitoring::Search::View$For F1 and Monitorings::Search$Presentation for F1 and Monitorings::PrimPageSetup::pstNone
//
// ��������� ��������
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
  
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� pstNone }
  pstNoneName = 'pstNone';
   { ��������� ������������� ����������������� ���� "��������� ��������" }
  pstNone = TvcmUserType(0);
   { ��������� �������� }
{$IfEnd} //not Admin

implementation

{$If not defined(Admin)}
{$If not defined(Admin) AND not defined(NoScripts)}
type
  Tkw_FormUserType_pstNone = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� pstNone }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_pstNone
{$IfEnd} //not Admin AND not NoScripts

{$If not defined(Admin) AND not defined(NoScripts)}

// start class Tkw_FormUserType_pstNone

class function Tkw_FormUserType_pstNone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::pstNone';
end;//Tkw_FormUserType_pstNone.GetWordNameForRegister

function Tkw_FormUserType_pstNone.GetInteger: Integer;
 {-}
begin
 Result := pstNone;
end;//Tkw_FormUserType_pstNone.GetInteger

{$IfEnd} //not Admin AND not NoScripts
{$IfEnd} //not Admin

initialization
{$If not defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_pstNone
 Tkw_FormUserType_pstNone.RegisterInEngine;
{$IfEnd} //not Admin AND not NoScripts

end.