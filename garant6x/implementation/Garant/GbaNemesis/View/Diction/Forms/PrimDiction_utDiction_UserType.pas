unit PrimDiction_utDiction_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Diction/Forms/PrimDiction_utDiction_UserType.pas"
// �����: 23.01.2009 17:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Diction::View::Diction::PrimDiction::utDiction
//
// �������� �������
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
   { ��������� ��� ���� ����� utDiction }
  utDictionName = 'utDiction';
   { ��������� ������������� ����������������� ���� "�������� �������" }
  utDiction = TvcmUserType(0);
   { �������� ������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utDiction = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utDiction }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utDiction
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utDiction

class function Tkw_FormUserType_utDiction.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utDiction';
end;//Tkw_FormUserType_utDiction.GetWordNameForRegister

function Tkw_FormUserType_utDiction.GetInteger: Integer;
 {-}
begin
 Result := utDiction;
end;//Tkw_FormUserType_utDiction.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utDiction
 Tkw_FormUserType_utDiction.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.