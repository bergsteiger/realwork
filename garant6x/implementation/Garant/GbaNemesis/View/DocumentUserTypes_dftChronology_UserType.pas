unit DocumentUserTypes_dftChronology_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftChronology_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftChronology
//
// ���������� ��������� ����
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
  ,
  DocumentUserTypes_dftRelatedDoc_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  ,
  DocumentUserTypes_dftAACContentsRight_UserType
  ;

const
   { ��������� ��� ���� ����� dftChronology }
  dftChronologyName = 'dftChronology';
   { ��������� ������������� ����������������� ���� "���������� ��������� ����" }
  dftChronology = TvcmUserType(dftAACContentsRight + 1);
   { ���������� ��������� ���� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftChronology = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftChronology }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftChronology
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftChronology

class function Tkw_FormUserType_dftChronology.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftChronology';
end;//Tkw_FormUserType_dftChronology.GetWordNameForRegister

function Tkw_FormUserType_dftChronology.GetInteger: Integer;
 {-}
begin
 Result := dftChronology;
end;//Tkw_FormUserType_dftChronology.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftChronology
 Tkw_FormUserType_dftChronology.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.