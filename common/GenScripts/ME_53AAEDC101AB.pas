unit evdDTTypes;

interface

uses
 l3IntfUses
;

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

uses
 l3ImplUses
;

end.
