unit NOT_FINISHED_dt_Types;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "dd"
// ������: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_dt_Types.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::dt_Types
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include ..\dd\ddDefine.inc}

interface

uses
  l3Types,
  evdDTTypes
  ;

type
 TDictID = System.LongWord;

 TDocID = System.LongInt;

 TSubID = System.LongInt;

 TDocType = (
  {* ���������� ���� ���������� }
   dtNone
 , dtText
 , dtRelText
 , dtShortCut
 , dtObject
 , dtDictEntry
 , dtAnnotation
 , dtFlash
 );//TDocType

 TFamilyID = System.Word;

 TDiapasonRec = record
 end;//TDiapasonRec

 TddPipeInputFileType = (
   dd_itAutoDetect
 , dd_itGarant
 , dd_itEverest
 , dd_itEverestInternal
 , dd_itRTFAnnotation
 , dd_itTXTAnnotation
 , dd_itFASCaseCode
 , dd_itKT
 , dd_itUnknown
 );//TddPipeInputFileType

 TUserType = (
   utNone
 , utDoc
 , utNoDoc
 , utCalendar
 , utBusiness
 , utUserInfo
 , utWEBReference
 , utEdition
 , utBook
 , utIzm
 , utCard
 , utDossier
 , utAAK_Cont
 , utAAK_Doc
 );//TUserType

 TDiapType = (
   tdNone
 , tdSingle
 , tdGroup
 , tdAll
 , tdSearch
 , tdNumList
 );//TDiapType

 TUserID = System.LongWord;

 TepSupportFileType = evdDTTypes.TepSupportFileType;

 TepDivideBy = evdDTTypes.TepDivideBy;

 TPathRec = record
 end;//TPathRec

 TPathStr = l3Types.Tl3PathStr;

 TOpenMode = record
 end;//TOpenMode

 TOperActionType = (
   
 );//TOperActionType

const
  { ������ ��� �������� evdDTTypes.TepDivideBy }
 divNone = evdDTTypes.divNone;
 divTopic = evdDTTypes.divTopic;
 divAccRight = evdDTTypes.divAccRight;
 divSize = evdDTTypes.divSize;
  { ������ ��� �������� evdDTTypes.TepSupportFileType }
 outEVD = evdDTTypes.outEVD;
 outEVDtext = evdDTTypes.outEVDtext;
 outTXT = evdDTTypes.outTXT;
 outNSRC = evdDTTypes.outNSRC;
 outRTF = evdDTTypes.outRTF;
 outHTML = evdDTTypes.outHTML;
 outXML = evdDTTypes.outXML;

implementation

end.