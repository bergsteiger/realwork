unit DocumentUserTypes_dftAnnotation_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAnnotation_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAnnotation
//
// ���������
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
  DocumentUserTypes_dftDictSubEntry_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftAnnotation }
  dftAnnotationName = 'dftAnnotation';
   { ��������� ������������� ����������������� ���� "���������" }
  dftAnnotation = TvcmUserType(dftDictSubEntry + 1);
   { ��������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAnnotation = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAnnotation }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAnnotation
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAnnotation

class function Tkw_FormUserType_dftAnnotation.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAnnotation';
end;//Tkw_FormUserType_dftAnnotation.GetWordNameForRegister

function Tkw_FormUserType_dftAnnotation.GetInteger: Integer;
 {-}
begin
 Result := dftAnnotation;
end;//Tkw_FormUserType_dftAnnotation.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAnnotation
 Tkw_FormUserType_dftAnnotation.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.