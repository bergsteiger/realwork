unit nsTabbedInterfaceTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "TabInterface"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/TabInterface/nsTabbedInterfaceTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::TabInterface::TabbedInterfaceSupport::nsTabbedInterfaceTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

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
function NsTabIconIndex(aTabIconType: TnsTabIconType): Integer;

implementation

uses
  TabbedContainerRes
  ;

// unit methods

function NsTabIconIndex(aTabIconType: TnsTabIconType): Integer;
//#UC START# *53BA848503C1_53BA488F00D8_var*
//#UC END# *53BA848503C1_53BA488F00D8_var*
begin
//#UC START# *53BA848503C1_53BA488F00D8_impl*
 Result := nsTabbedContainerRes.IconIndex[aTabIconType];
//#UC END# *53BA848503C1_53BA488F00D8_impl*
end;//NsTabIconIndex

end.