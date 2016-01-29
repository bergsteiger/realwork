unit DocumentUserTypes_dftAnnotationSynchroView_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/DocumentUserTypes_dftAnnotationSynchroView_UserType.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 Core::Base Operations::View::Base Forms::DocumentUserTypes::dftAnnotationSynchroView
//
// ��������� (���������� ��������)
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
  DocumentUserTypes_dftTranslation_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� dftAnnotationSynchroView }
  dftAnnotationSynchroViewName = 'dftAnnotationSynchroView';
   { ��������� ������������� ����������������� ���� "��������� (���������� ��������)" }
  dftAnnotationSynchroView = TvcmUserType(dftTranslation + 1);
   { ��������� (���������� ��������) }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_dftAnnotationSynchroView = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� dftAnnotationSynchroView }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_dftAnnotationSynchroView
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_dftAnnotationSynchroView

class function Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::dftAnnotationSynchroView';
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetWordNameForRegister

function Tkw_FormUserType_dftAnnotationSynchroView.GetInteger: Integer;
 {-}
begin
 Result := dftAnnotationSynchroView;
end;//Tkw_FormUserType_dftAnnotationSynchroView.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_dftAnnotationSynchroView
 Tkw_FormUserType_dftAnnotationSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.