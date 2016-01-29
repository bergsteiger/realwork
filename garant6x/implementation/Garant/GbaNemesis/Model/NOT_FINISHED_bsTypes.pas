unit NOT_FINISHED_bsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Model"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/Model/NOT_FINISHED_bsTypes.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 Базовые определения предметной области::LegalDomain::Model::bsTypes
//
// Типы бизнес уровня. На самом деле БОЛЬШАЯ ПОМОЙКА. Новые типы добавлять сюда нельзя
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit
  ;

type
 TbsLanguage = (
  {* Языки. }
   
 );//TbsLanguage

 TlstCRType = (
  {* Список типизированных корреспондентов/респондентов. CorrRespType = crt. }
   
 );//TlstCRType

 TbsSortOrder = (
  {* Порядок сортировки списка. }
   
 );//TbsSortOrder

 TbsSortType = (
  {* Тип сортировки. }
   
 );//TbsSortType

 TbsValidSortTypes = (
  {* Доступные типы сортировки. }
   
 );//TbsValidSortTypes

 TbsListOpenFrom = (
  {* - откуда был открыт список. }
   
 );//TbsListOpenFrom

 TbsListNodeType = (
  {* - тип узла списка документов. }
   
 );//TbsListNodeType

 TbsSaveListKind = (
  {* - тип сохранения списка. }
   
 );//TbsSaveListKind

 TbsListType = (
  {* Тип списка по крупному. }
   
 );//TbsListType

 TbsConsultationStatus = (
   
 );//TbsConsultationStatus

 TbsConsultationStatuses = set of TbsConsultationStatus;

 TbsWhatDoingIfOneDoc = (
   
 );//TbsWhatDoingIfOneDoc

 TbsConsultationMark = (
   
 );//TbsConsultationMark

 TnsUserCRListId = (
   
 );//TnsUserCRListId

 TbsUserNodeType = (
   
 );//TbsUserNodeType

const
  { Consultation }
 

type
 TbsUserCRList = (
   
 );//TbsUserCRList

 TbsLanguages = set of TbsLanguage;

 TbsObjectID = BaseTypesUnit.TObjectId;

 TbsUserNodeTypes = set of ;

 TbsNotification = (
   
 );//TbsNotification

 TbsConsultationOperation = (
   
 );//TbsConsultationOperation

 TbsConsultationOperations = set of TbsConsultationOperation;

implementation

end.