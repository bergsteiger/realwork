unit PrimProgressIndicator_utProgressIndicator_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/PrimProgressIndicator_utProgressIndicator_UserType.pas"
// �����: 25.08.2009 18:14
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimProgressIndicator::utProgressIndicator
//
// ��� ����������
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
   { ��������� ��� ���� ����� utProgressIndicator }
  utProgressIndicatorName = 'utProgressIndicator';
   { ��������� ������������� ����������������� ���� "��� ����������" }
  utProgressIndicator = TvcmUserType(0);
   { ��� ���������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_utProgressIndicator = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� utProgressIndicator }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_utProgressIndicator
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_utProgressIndicator

class function Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::utProgressIndicator';
end;//Tkw_FormUserType_utProgressIndicator.GetWordNameForRegister

function Tkw_FormUserType_utProgressIndicator.GetInteger: Integer;
 {-}
begin
 Result := utProgressIndicator;
end;//Tkw_FormUserType_utProgressIndicator.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_utProgressIndicator
 Tkw_FormUserType_utProgressIndicator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.