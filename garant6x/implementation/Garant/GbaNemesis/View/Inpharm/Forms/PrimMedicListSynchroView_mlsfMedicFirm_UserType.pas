unit PrimMedicListSynchroView_mlsfMedicFirm_UserType;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/Forms/PrimMedicListSynchroView_mlsfMedicFirm_UserType.pas"
// �����: 27.01.2009 13:29
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UserType::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::PrimMedicListSynchroView::mlsfMedicFirm
//
// ��������
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
  PrimMedicListSynchroView_mlsfDrugList_UserType
  {$If not defined(NoScripts)}
  ,
  tfwInteger
  {$IfEnd} //not NoScripts
  
  ;

const
   { ��������� ��� ���� ����� mlsfMedicFirm }
  mlsfMedicFirmName = 'mlsfMedicFirm';
   { ��������� ������������� ����������������� ���� "��������" }
  mlsfMedicFirm = TvcmUserType(mlsfDrugList + 1);
   { �������� }
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
type
  Tkw_FormUserType_mlsfMedicFirm = {final scriptword} class(TtfwInteger)
   {* ����� ������� ��� ���� ����� mlsfMedicFirm }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetInteger: Integer; override;
  end;//Tkw_FormUserType_mlsfMedicFirm
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}

// start class Tkw_FormUserType_mlsfMedicFirm

class function Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_�����::mlsfMedicFirm';
end;//Tkw_FormUserType_mlsfMedicFirm.GetWordNameForRegister

function Tkw_FormUserType_mlsfMedicFirm.GetInteger: Integer;
 {-}
begin
 Result := mlsfMedicFirm;
end;//Tkw_FormUserType_mlsfMedicFirm.GetInteger

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$IfEnd} //not Admin AND not Monitorings

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_FormUserType_mlsfMedicFirm
 Tkw_FormUserType_mlsfMedicFirm.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.