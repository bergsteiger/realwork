unit InpharmInterfaces;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Medic"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Medic/InpharmInterfaces.pas"
// �����: 29.09.2009 21:19
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ControllerInterfaces::Category>> F1 Core::Common::Medic::InpharmInterfaces
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
  DocumentAndListInterfaces,
  vcmInterfaces {a},
  vcmControllers {a}
  ;

type
 IdsMedicFirmDocument = interface(IdsBaseDocument)
  {* �������� ����� ������������� }
   ['{85B069FE-7A20-4DBA-A63C-0A961206834D}']
   procedure OpenDrugList;
     {* ������� ������ ����������� ���������� }
 end;//IdsMedicFirmDocument

 IdsDrugDocument = interface(IdsBaseDocument{, IucbDocumentWithContents, IucbDocumentFromList})
  {* �������� }
   ['{FFF0DB41-3AEC-4E8B-A967-D3E173DBFFB9}']
   procedure OpenDrugInternationalNameSynonims;
     {* ������� ������ ������� �� �������������� �������� }
  // ������ �������������� � ����������� �����������
   function As_IucbDocumentWithContents: IucbDocumentWithContents;
   function As_IucbDocumentFromList: IucbDocumentFromList;
 end;//IdsDrugDocument

 IdsInpharmMainMenu = interface(IvcmViewAreaController)
   ['{6F913032-0D3B-4911-99E8-037100A99FD6}']
 end;//IdsInpharmMainMenu

 IsdsInpharmMainMenu = interface(IvcmUseCaseController)
   ['{6D692EF2-6DCF-48D0-A215-93EA51A710E7}']
   function pm_GetDsInpharmMainMenuData: IdsInpharmMainMenu;
   property dsInpharmMainMenuData: IdsInpharmMainMenu
     read pm_GetDsInpharmMainMenuData;
 end;//IsdsInpharmMainMenu
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  DocumentUnit
  ;
{$IfEnd} //not Admin AND not Monitorings

end.