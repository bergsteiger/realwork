unit PrimMedicListSynchroView_mlsfDrugList_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicListSynchroView_mlsfDrugList_UserType.pas"
// �����: 27.01.2009 13:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::PrimMedicListSynchroView::mlsfDrugList
//
// ���������� ��������
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
   { ��������� ��� ���� ����� mlsfDrugList }
  mlsfDrugListName = 'mlsfDrugList';
   { ��������� ������������� ����������������� ���� "���������� ��������" }
  mlsfDrugList = TvcmUserType(0);
   { ���������� �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_mlsfDrugList = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� mlsfDrugList }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_mlsfDrugList
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_mlsfDrugList

class function Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::mlsfDrugList';
end;//Tkw_FormUserType_mlsfDrugList.GetWordNameForRegister

function Tkw_FormUserType_mlsfDrugList.GetInteger: Integer;
 {-}
begin
 Result := mlsfDrugList;
end;//Tkw_FormUserType_mlsfDrugList.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_mlsfDrugList
 Tkw_FormUserType_mlsfDrugList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.