unit NOT_FINISHED_bsTypes;
 {* Типы бизнес уровня. На самом деле БОЛЬШАЯ ПОМОЙКА. Новые типы добавлять сюда нельзя }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Model\NOT_FINISHED_bsTypes.pas"
// Стереотип: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

const

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

 TbsUserCRList = (
 );//TbsUserCRList

 TbsLanguages = set of TbsLanguage;

 TbsObjectID = TObjectId;

 TbsUserNodeTypes = set of ;

 TbsNotification = (
 );//TbsNotification

 TbsConsultationOperation = (
 );//TbsConsultationOperation

 TbsConsultationOperations = set of TbsConsultationOperation;

implementation

uses
 l3ImplUses
;

end.
