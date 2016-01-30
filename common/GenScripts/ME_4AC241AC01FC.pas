unit InpharmInterfaces;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Medic\InpharmInterfaces.pas"
// Стереотип: "ControllerInterfaces"

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
  {* Описание фирмы производителя }
  ['{85B069FE-7A20-4DBA-A63C-0A961206834D}']
  procedure OpenDrugList;
   {* открыть список выпускаемых препаратов }
 end;//IdsMedicFirmDocument

 IdsDrugDocument = interface(IdsBaseDocument)
  {* Препарат }
  ['{FFF0DB41-3AEC-4E8B-A967-D3E173DBFFB9}']
  procedure OpenDrugInternationalNameSynonims;
   {* открыть список похожих по международному названию }
  function As_IucbDocumentWithContents: IucbDocumentWithContents;
   {* Метод приведения нашего интерфейса к IucbDocumentWithContents }
  function As_IucbDocumentFromList: IucbDocumentFromList;
   {* Метод приведения нашего интерфейса к IucbDocumentFromList }
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
