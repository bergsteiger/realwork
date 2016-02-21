unit nsTabbedInterfaceTypes;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\TabInterface\nsTabbedInterfaceTypes.pas"
// Стереотип: "UtilityPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 TnsTabIconType = (
  titMain
  , titList
  , titDocumentNormal
  , titDocumentPreactive
  , titDocumentAbolished
  , titDocumentNewRedaction
  , titAAC
  , titDrug
  , titDrugSpecial
  , titDrugAnnuled
  , titMedicFirm
  , titMedicDictionary
  , titDictionary
  , titAttributeSearch
  , titPublishSourceSearch
  , titLegislationReviewSearch
  , titDrugSearch
  , titCompareEditions
  , titChangesBetweenEditions
  , titSituationSearch
  , titPrime
  , titInpharmMainMenu
  , titConsultation
  , titComplectInfo
  , titLawSupportOnline
  , titRubricator
  , titBaseSearch
  , titPrintPreview
  , titNewsOnline
 );//TnsTabIconType

function nsTabIconIndex(aTabIconType: TnsTabIconType): Integer;

implementation

uses
 l3ImplUses
 , TabbedContainerRes
;

function nsTabIconIndex(aTabIconType: TnsTabIconType): Integer;
//#UC START# *53BA848503C1_53BA488F00D8_var*
//#UC END# *53BA848503C1_53BA488F00D8_var*
begin
//#UC START# *53BA848503C1_53BA488F00D8_impl*
 Result := nsTabbedContainerRes.IconIndex[aTabIconType];
//#UC END# *53BA848503C1_53BA488F00D8_impl*
end;//nsTabIconIndex

end.
