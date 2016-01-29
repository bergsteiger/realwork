unit DocNumberQuery_ut_DocNumberQuery_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document/Forms/DocNumberQuery_ut_DocNumberQuery_UserType.pas"
// �����: 16.09.2009 22:49
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ������ � ���������� � ������� ����������::Document::View::Document::Document::DocNumberQuery::ut_DocNumberQuery
//
// ������� �������� �� ������
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
    { ��������� ��� ���� ����� ut_DocNumberQuery }
   ut_DocNumberQueryName = 'ut_DocNumberQuery';
    { ��������� ������������� ����������������� ���� "������� �������� �� ������" }
   ut_DocNumberQuery = TvcmUserType(0);
    { ������� �������� �� ������ }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_DocNumberQuery = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_DocNumberQuery }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_DocNumberQuery
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_DocNumberQuery

class function Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_DocNumberQuery';
end;//Tkw_FormUserType_ut_DocNumberQuery.GetWordNameForRegister

function Tkw_FormUserType_ut_DocNumberQuery.GetInteger: Integer;
 {-}
begin
 Result := ut_DocNumberQuery;
end;//Tkw_FormUserType_ut_DocNumberQuery.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_DocNumberQuery
 Tkw_FormUserType_ut_DocNumberQuery.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.