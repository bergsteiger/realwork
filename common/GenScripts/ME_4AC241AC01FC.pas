unit InpharmInterfaces;

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\InpharmInterfaces.pas"
// ���������: "ControllerInterfaces"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , DocumentAndListInterfaces
 , nevTools
 , DocumentInterfaces
 , bsTypes
 , afwInterfaces
 , FoldersDomainInterfaces
 , DocumentUnit
 , bsTypesNew
 , l3Interfaces
;

type
 IdsMedicFirmDocument = interface(IdsBaseDocument)
  {* �������� ����� ������������� }
  ['{85B069FE-7A20-4DBA-A63C-0A961206834D}']
  procedure OpenDrugList;
   {* ������� ������ ����������� ���������� }
 end;//IdsMedicFirmDocument

 IdsDrugDocument = interface(IdsBaseDocument)
  {* �������� }
  ['{FFF0DB41-3AEC-4E8B-A967-D3E173DBFFB9}']
  procedure OpenDrugInternationalNameSynonims;
   {* ������� ������ ������� �� �������������� �������� }
  function As_IucbDocumentWithContents: IucbDocumentWithContents;
   {* ����� ���������� ������ ���������� � IucbDocumentWithContents }
  function As_IucbDocumentFromList: IucbDocumentFromList;
   {* ����� ���������� ������ ���������� � IucbDocumentFromList }
 end;//IdsDrugDocument

 IdsInpharmMainMenu = interface
  ['{6F913032-0D3B-4911-99E8-037100A99FD6}']
 end;//IdsInpharmMainMenu

 IsdsInpharmMainMenu = interface
  ['{6D692EF2-6DCF-48D0-A215-93EA51A710E7}']
  function pm_GetdsInpharmMainMenuData: IdsInpharmMainMenu;
  property dsInpharmMainMenuData: IdsInpharmMainMenu
   read pm_GetdsInpharmMainMenuData;
 end;//IsdsInpharmMainMenu
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
