unit NOT_FINISHED_dt_Types;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dt_Types.pas"
// Стереотип: "Interfaces"
// Элемент модели: "dt_Types" MUID: (47BC51FE018B)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , l3Types
 , l3MarshalledTypes
 , evdDTTypes
;

const
 {* Алиасы для значений l3MarshalledTypes.TDocType }
 dtNone = l3MarshalledTypes.dtNone;
 dtText = l3MarshalledTypes.dtText;
 dtRelText = l3MarshalledTypes.dtRelText;
 dtShortCut = l3MarshalledTypes.dtShortCut;
 dtObject = l3MarshalledTypes.dtObject;
 dtDictEntry = l3MarshalledTypes.dtDictEntry;
 dtAnnotation = l3MarshalledTypes.dtAnnotation;
 dtFlash = l3MarshalledTypes.dtFlash;
 dtGroupOp = l3MarshalledTypes.dtGroupOp;
 {* Алиасы для значений evdDTTypes.TepSupportFileType }
 outEVD = evdDTTypes.outEVD;
 outEVDtext = evdDTTypes.outEVDtext;
 outTXT = evdDTTypes.outTXT;
 outNSRC = evdDTTypes.outNSRC;
 outRTF = evdDTTypes.outRTF;
 outHTML = evdDTTypes.outHTML;
 outXML = evdDTTypes.outXML;
 {* Алиасы для значений evdDTTypes.TepDivideBy }
 divNone = evdDTTypes.divNone;
 divTopic = evdDTTypes.divTopic;
 divAccRight = evdDTTypes.divAccRight;
 divSize = evdDTTypes.divSize;

type
 TDictID = LongWord;

 TDocID = LongInt;

 TSubID = LongInt;

 TDocType = l3MarshalledTypes.TDocType;
  {* Внутренние типы документов }

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

 TUserID = LongWord;

 TepSupportFileType = evdDTTypes.TepSupportFileType;

 TepDivideBy = evdDTTypes.TepDivideBy;

 TPathRec = record
 end;//TPathRec

 TPathStr = Tl3PathStr;

 TOpenMode = record
 end;//TOpenMode

 TOperActionType = (
 );//TOperActionType

 TStageType = (
 );//TStageType

implementation

uses
 l3ImplUses
;

end.
