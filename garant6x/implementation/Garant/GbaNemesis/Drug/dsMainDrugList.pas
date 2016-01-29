unit dsMainDrugList;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Drug"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Drug/dsMainDrugList.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ViewAreaControllerImp::Class>> F1 ���������� ��������::Inpharm::Drug::sdsDrugList::TdsMainDrugList
//
// ��� ������ ���������� � ������� ����
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
  dsDrugList
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TdsMainDrugList = {vac} class(TdsDrugList)
  {* ��� ������ ���������� � ������� ���� }
 protected
 // overridden protected methods
   function NotifyAboutChangeCurrent: Boolean; override;
     {* ���������� ������ ������ ���������� � ����� ��������. }
   function DoIsMain: Boolean; override;
     {* - ���������� ������ � �������� ���� ����������. }
 end;//TdsMainDrugList
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TdsMainDrugList

function TdsMainDrugList.NotifyAboutChangeCurrent: Boolean;
//#UC START# *47F0D913030D_47F5D70E03AB_var*
//#UC END# *47F0D913030D_47F5D70E03AB_var*
begin
//#UC START# *47F0D913030D_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47F0D913030D_47F5D70E03AB_impl*
end;//TdsMainDrugList.NotifyAboutChangeCurrent

function TdsMainDrugList.DoIsMain: Boolean;
//#UC START# *47FB00640212_47F5D70E03AB_var*
//#UC END# *47FB00640212_47F5D70E03AB_var*
begin
//#UC START# *47FB00640212_47F5D70E03AB_impl*
 Result := True;
//#UC END# *47FB00640212_47F5D70E03AB_impl*
end;//TdsMainDrugList.DoIsMain

{$IfEnd} //not Admin AND not Monitorings

end.