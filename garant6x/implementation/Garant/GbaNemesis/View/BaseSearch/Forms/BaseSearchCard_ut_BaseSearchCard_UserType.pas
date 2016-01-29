unit BaseSearchCard_ut_BaseSearchCard_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/BaseSearch/Forms/BaseSearchCard_ut_BaseSearchCard_UserType.pas"
// �����: 21.09.2009 20:01
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 �������� ����������::BaseSearch::View::BaseSearch$Module::BaseSearch::BaseSearchCard::ut_BaseSearchCard
//
// ������� �����
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
    { ��������� ��� ���� ����� ut_BaseSearchCard }
   ut_BaseSearchCardName = 'ut_BaseSearchCard';
    { ��������� ������������� ����������������� ���� "������� �����" }
   ut_BaseSearchCard = TvcmUserType(0);
    { ������� ����� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
   Tkw_FormUserType_ut_BaseSearchCard = {final scriptword} class(TtfwInteger)
    {* ����� ������� ��� ���� ����� ut_BaseSearchCard }
   protected
   // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
   end;//Tkw_FormUserType_ut_BaseSearchCard
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_ut_BaseSearchCard

class function Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::ut_BaseSearchCard';
end;//Tkw_FormUserType_ut_BaseSearchCard.GetWordNameForRegister

function Tkw_FormUserType_ut_BaseSearchCard.GetInteger: Integer;
 {-}
begin
 Result := ut_BaseSearchCard;
end;//Tkw_FormUserType_ut_BaseSearchCard.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_ut_BaseSearchCard
 Tkw_FormUserType_ut_BaseSearchCard.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.