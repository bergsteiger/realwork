unit NOT_FINISHED_bsTypes;
 {* ���� ������ ������. �� ����� ���� ������� �������. ����� ���� ��������� ���� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Model\NOT_FINISHED_bsTypes.pas"
// ���������: "Interfaces"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , BaseTypesUnit
;

const

type
 TbsLanguage = (
  {* �����. }
 );//TbsLanguage

 TlstCRType = (
  {* ������ �������������� ���������������/������������. CorrRespType = crt. }
 );//TlstCRType

 TbsSortOrder = (
  {* ������� ���������� ������. }
 );//TbsSortOrder

 TbsSortType = (
  {* ��� ����������. }
 );//TbsSortType

 TbsValidSortTypes = (
  {* ��������� ���� ����������. }
 );//TbsValidSortTypes

 TbsListOpenFrom = (
  {* - ������ ��� ������ ������. }
 );//TbsListOpenFrom

 TbsListNodeType = (
  {* - ��� ���� ������ ����������. }
 );//TbsListNodeType

 TbsSaveListKind = (
  {* - ��� ���������� ������. }
 );//TbsSaveListKind

 TbsListType = (
  {* ��� ������ �� ��������. }
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
