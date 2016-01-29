unit NOT_FINISHED_dt_Types;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "dd"
// Модуль: "w:/common/components/rtl/Garant/dd/NOT_FINISHED_dt_Types.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> Shared Delphi::dd::dt_Types
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

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
  {* Внутренние типы документов }
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
  { Алиасы для значений evdDTTypes.TepDivideBy }
 divNone = evdDTTypes.divNone;
 divTopic = evdDTTypes.divTopic;
 divAccRight = evdDTTypes.divAccRight;
 divSize = evdDTTypes.divSize;
  { Алиасы для значений evdDTTypes.TepSupportFileType }
 outEVD = evdDTTypes.outEVD;
 outEVDtext = evdDTTypes.outEVDtext;
 outTXT = evdDTTypes.outTXT;
 outNSRC = evdDTTypes.outNSRC;
 outRTF = evdDTTypes.outRTF;
 outHTML = evdDTTypes.outHTML;
 outXML = evdDTTypes.outXML;

implementation

end.