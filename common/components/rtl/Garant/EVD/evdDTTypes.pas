unit evdDTTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/evdDTTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Standard::evdDTTypes
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

type
 TDiapType = (
   tdNone
 , tdSingle
 , tdGroup
 , tdAll
 , tdSearch
 , tdNumList
 );//TDiapType

 TepDivideBy = (
   divNone
 , divTopic
 , divAccRight
 , divSize
 );//TepDivideBy

 TepSupportFileType = (
   outEVD
 , outEVDtext
 , outTXT
 , outNSRC
 , outRTF
 , outHTML
 , outXML
 );//TepSupportFileType

 TaeStages = (
   aeAnnotations
 , aeIncluded
 , aeChanged
 , aeInfo
 , aeNotIncluded
 );//TaeStages

 TaeStagesSet = set of TaeStages;

 TaeDocSource = (
   ae_dsAccGroups
 , ae_dsQuery
 );//TaeDocSource

implementation

end.