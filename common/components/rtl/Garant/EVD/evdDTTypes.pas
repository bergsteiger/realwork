unit evdDTTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/evdDTTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Standard::evdDTTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

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