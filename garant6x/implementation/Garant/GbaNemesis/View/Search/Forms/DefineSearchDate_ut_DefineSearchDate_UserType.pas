unit DefineSearchDate_ut_DefineSearchDate_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Search/Forms/DefineSearchDate_ut_DefineSearchDate_UserType.pas"
// �����: 22.09.2009 16:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::Search::View::Search::Search::DefineSearchDate::ut_DefineSearchDate
//
// ����
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
    { ��������� ��� ���� ����� ut_DefineSearchDate }
   ut_DefineSearchDateName = 'ut_DefineSearchDate';
    { ��������� ������������� ����������������� ���� "����" }
   ut_DefineSearchDate = TvcmUserType(0);
    { ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_DefineSearchDate = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_DefineSearchDate }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_DefineSearchDate
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_DefineSearchDate

class function Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_DefineSearchDate';
end;//Tkw_FormUserType_ut_DefineSearchDate.GetWordNameForRegister

function Tkw_FormUserType_ut_DefineSearchDate.GetInteger: Integer;
 {-}
begin
 Result := ut_DefineSearchDate;
end;//Tkw_FormUserType_ut_DefineSearchDate.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_DefineSearchDate
 Tkw_FormUserType_ut_DefineSearchDate.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.