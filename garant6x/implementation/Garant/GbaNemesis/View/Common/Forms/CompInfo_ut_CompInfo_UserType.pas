unit CompInfo_ut_CompInfo_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/Forms/CompInfo_ut_CompInfo_UserType.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Common::View::Common::PrimF1Common::CompInfo::ut_CompInfo
//
// ���������� � ���������
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
    { ��������� ��� ���� ����� ut_CompInfo }
   ut_CompInfoName = 'ut_CompInfo';
    { ��������� ������������� ����������������� ���� "���������� � ���������" }
   ut_CompInfo = TvcmUserType(0);
    { ���������� � ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_CompInfo = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_CompInfo }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_CompInfo
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_CompInfo

class function Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_CompInfo';
end;//Tkw_FormUserType_ut_CompInfo.GetWordNameForRegister

function Tkw_FormUserType_ut_CompInfo.GetInteger: Integer;
 {-}
begin
 Result := ut_CompInfo;
end;//Tkw_FormUserType_ut_CompInfo.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_CompInfo
 Tkw_FormUserType_ut_CompInfo.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.