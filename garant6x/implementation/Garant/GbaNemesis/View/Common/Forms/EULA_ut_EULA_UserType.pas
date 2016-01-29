unit EULA_ut_EULA_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/EULA_ut_EULA_UserType.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::EULA::ut_EULA
//
// ������� �������������
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
    { ��������� ��� ���� ����� ut_EULA }
   ut_EULAName = 'ut_EULA';
    { ��������� ������������� ����������������� ���� "������� �������������" }
   ut_EULA = TvcmUserType(0);
    { ������� ������������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_EULA = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_EULA }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_EULA
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_EULA

class function Tkw_FormUserType_ut_EULA.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_EULA';
end;//Tkw_FormUserType_ut_EULA.GetWordNameForRegister

function Tkw_FormUserType_ut_EULA.GetInteger: Integer;
 {-}
begin
 Result := ut_EULA;
end;//Tkw_FormUserType_ut_EULA.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_EULA
 Tkw_FormUserType_ut_EULA.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.