unit NOT_FINISHED_bsTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Model"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Model/NOT_FINISHED_bsTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<Interfaces::Category>> F1 ������� ����������� ���������� �������::LegalDomain::Model::bsTypes
//
// ���� ������ ������. �� ����� ���� ������� �������. ����� ���� ��������� ���� ������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  BaseTypesUnit
  ;

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