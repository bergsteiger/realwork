unit bsTypes;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������ �.�;                                                     }
{ �����      : 09.08.2005 17.51;                                               }
{ ������     : bsTypes                                                         }
{ ��������   : ������ �������� ���� ������������ ������ �����;                 }
{------------------------------------------------------------------------------}

// $Id: bsTypes.pas,v 1.86 2016/05/31 16:13:23 kostitsin Exp $
// $Log: bsTypes.pas,v $
// Revision 1.86  2016/05/31 16:13:23  kostitsin
// {requestlink: 623926949 }
//
// Revision 1.85  2015/03/12 09:39:27  morozov
// {RequestLink: 590745386}
//
// Revision 1.84  2014/10/16 12:37:49  morozov
// {RequestLink: 567573990}
//
// Revision 1.83  2014/10/15 08:37:28  morozov
// {RequestLink: 566792807}
//
// Revision 1.82  2014/07/14 10:33:09  kostitsin
// {requestlink: 513880934 }
//
// Revision 1.81  2012/08/28 09:34:20  lulin
// - ����������� �� ���������.
//
// Revision 1.80  2012/07/30 18:16:08  lulin
// {RequestLink:379238730}
//
// Revision 1.79  2012/07/26 18:36:11  lulin
// {RequestLink:378540022}
//
// Revision 1.78  2012/07/24 18:26:16  lulin
// - ������ ����.
//
// Revision 1.77  2011/06/07 11:32:12  lulin
// {RequestLink:268345098}.
// - �������� ������.
//
// Revision 1.76  2011/02/08 14:24:41  lulin
// {RequestLink:252522068}.
//
// Revision 1.75  2010/04/20 14:34:03  oman
// - new: {RequestLink:185205022}
//
// Revision 1.74  2010/03/22 14:42:50  lulin
// {RequestLink:198672893}.
//
// Revision 1.73  2009/12/08 19:13:27  lulin
// - ������ ��������� ��������� �� ������.
//
// Revision 1.72  2009/11/13 12:21:13  lulin
// {RequestLink:159360578}. �57.
//
// Revision 1.71  2009/10/12 11:27:27  lulin
// - �������� ����� ������� CVS.
//
// Revision 1.70  2009/09/07 12:27:04  lulin
// - ������� ������� ��� �������� �������.
//
// Revision 1.69  2009/08/03 14:40:32  oman
// - new: ������������ ExternalOperation - {RequestLink:158795570}
//
// Revision 1.68  2009/07/31 17:30:04  lulin
// - ������� �����.
//
// Revision 1.67  2009/07/22 07:51:46  oman
// - fix: ������ ���������� - {RequestLink:152408792}
//
// Revision 1.66  2009/06/25 09:44:02  oman
// - new: ���������� ��������� ���� ��������� - [$152408792]
//
// Revision 1.65  2009/06/05 10:17:35  oman
// - new: ���������� - [$137469030]
//
// Revision 1.64  2009/05/04 12:52:08  oman
// - new: ����������� �������� - [$136939327]
//
// Revision 1.63  2009/04/20 12:43:31  oman
// - new: ��������� �������� ��� ����� - [$127762671]
//
// Revision 1.62  2009/04/15 10:09:56  oman
// - new: ����������� � ����� ����� ������ - [$127762671]
//
// Revision 1.61  2009/02/02 12:12:49  lulin
// - ����������� �� ������������� ����������������� ����������.
//
// Revision 1.60  2008/11/14 10:35:05  lulin
// - <K>: 122675356.
//
// Revision 1.59  2008/08/21 06:31:33  oman
// - fix: ������������� ������� ����� �� ����������� (�-109511093)
//
// Revision 1.58  2008/07/09 12:39:24  mmorozov
// - new: ���������� � ��������� ��� ����� (K<100008166>);
//
// Revision 1.57  2008/07/08 11:21:18  mmorozov
// - new: ������������ �������� ��� ����������-���� (�<99221827>);
//
// Revision 1.56  2008/07/02 08:03:32  mmorozov
// - change: ��������� ������������ ����� ���������� (K<97354368>).
//
// Revision 1.55  2008/04/04 07:35:45  mmorozov
// - ��������� �������� � ����� �������� � ������ ����������;
//
// Revision 1.54  2008/04/01 10:56:05  oman
// - fix: �����-�������������� - ������������� ���������� � ���������
//
// Revision 1.53  2008/03/31 07:17:55  oman
// - new: ������ ��� ������ ����
//
// Revision 1.52  2008/03/25 10:56:18  oman
// Cleanup - ��������� ��� HyperlinkManager
//
// Revision 1.51  2008/03/24 08:43:21  oman
// - new: ��������� ��� ��������� ����� ������ ���. ����������
//
// Revision 1.50  2008/03/21 08:43:02  oman
// - new: ��������� ��� ��������� ����� ������ ������������� ����������
//
// Revision 1.49  2008/03/19 13:36:22  oman
// - new: ����� �������� ������ � ���������� ����� �������� (cq28560)
//
// Revision 1.48  2008/01/25 11:46:08  mmorozov
// - new: ����� ���������������� ��� � ���� ����������� ��������� (CQ: OIT5-17587);
//
// Revision 1.47  2008/01/21 07:18:38  mmorozov
// - new: ������ � ����������������� �������� �� �������� � �� ��������� ���������� �� sdsDocInfo, ����� ���� ��������� ��� ������ � ��������� + ������������� ����������� (� ������ ������ ��� CQ: OIT5-17587);
//
// Revision 1.46  2008/01/10 07:23:04  oman
// ������� �� ����� �������
//
// Revision 1.45  2007/12/03 12:12:52  oman
// - fix: ���������� ��������� ������������������� ���
//  ���������� ������������ (cq27766)
//
// Revision 1.44  2007/11/15 07:39:07  oman
// - new: ��������� ��� ����� ������ (cq27255)
//
// Revision 1.43  2007/10/20 14:11:35  mmorozov
// - ����������� ������ � �������������� ���� ����������� ��� ���������� ������ ��������� bs_csPaymentRefusalOldFormat;
// - ����� ��������� (� ����������) IdeConsultation, �� ���� �������� ����������� _IbsConsultation;
// - cleanup;
//
// Revision 1.42  2007/10/13 11:10:04  mmorozov
// - new behaviour: ��� �������� ��� ������������ �� ��������� ���������  �� ������ ���������, ����� ���������� ������ �������; ��� ������������ � ���������������� ������� � 6.4. ��� �������� ������� ��������� � ���������� ����� ������� (CQ: OIT5-27021);
//
// Revision 1.41  2007/08/14 07:32:36  mmorozov
// - new: ��������� ������ � ��������� ������������ (CQ: OIT5-25868);
//
// Revision 1.40  2007/08/10 12:56:37  mmorozov
// - new: ����� ������ ������� �� ������������ ��� ��������� � ����������� � ��������� ������������ (CQ: OIT5-24736);
//
// Revision 1.39  2007/08/01 05:35:29  mmorozov
// - new: ����� ������� ���������� �� ������� ���������� �������� ������ (CQ: OIT5-26013);
//
// Revision 1.38  2007/06/07 09:25:29  oman
// - new: ��� ������ ������ ����� ��������� ����������
//  �������� � ������ ������� ������ �������� (cq25445)
//
// Revision 1.37  2007/05/15 13:06:15  oman
// - new: ����������� ����� � ��������� - ������ �������� (cq25145)
//
// Revision 1.36  2007/05/03 05:51:54  mmorozov
// - opt: ����������� ������������� � ������ (CQ: OIT5-24996; OIT5-24543);
//
// Revision 1.35  2007/03/05 11:30:44  oman
// - fix: �������� � �������� ���������
//
// Revision 1.34  2007/02/28 12:27:58  lulin
// - cleanup.
//
// Revision 1.33  2007/02/07 15:14:14  mmorozov
// - change: TbsListAdditionalDataSource -> _TbsListSynchroForm;
//
// Revision 1.32  2007/01/29 14:19:08  mmorozov
// - change: bsDataSourceReference ������� ����� ���������� � vcmFormDataSourceRef;
//
// Revision 1.31  2006/11/03 09:46:16  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.30.2.2  2006/11/02 07:40:34  oman
// - ��� ����������� ����� ������ �������� ��� ����, � ��
//  ��������� ��������� (cq20231, 20412)
//
// Revision 1.30.2.1  2006/10/31 16:18:57  oman
// - fix: ��� ���������� �� ����� �� ���� (cq23213)
//
// Revision 1.30  2006/10/03 13:29:30  mmorozov
// - new: �������� ���������� �� ����������� ������� � ������������� (CQ: OIT500022637);
//
// Revision 1.29  2006/09/20 15:03:04  mmorozov
// - new: ��������� � ������ ������ ��� �������� ������ ������������;
//
// Revision 1.28  2006/08/01 09:29:30  mmorozov
// - new: ��������� ����������� � �������� ������������ (CQ: OIT500021819);
//
// Revision 1.27  2006/07/31 15:04:14  mmorozov
// - new: ��������� �������� ��������� ���� (CQ: OIT500021555);
//
// Revision 1.26  2006/07/28 14:24:10  mmorozov
// - new: ��������� �������� �������� �� ����� "��������� �������";
// - new: ��������� ����������� ��� �������� ������������ (�� ������ ���������, ��� ����� � ��������);
//
// Revision 1.25  2006/07/27 13:39:13  mmorozov
// - new: ������ �������� ������ ����� ������ (CQ: OIT500021557);
// - rename: ���������� �����������, �������� ������, ���������;
//
// Revision 1.24  2006/07/27 11:20:54  mmorozov
// - new: ������ ������� �������� �������� ������� (CQ: OIT500021553);
//
// Revision 1.23  2006/06/23 11:31:32  mmorozov
// - new: ������ ������� �������� ���������;
//
// Revision 1.22  2006/06/02 15:21:22  mmorozov
// - new: ������� ��� �� ������������ ������ � ��������� � ������ bsDocumentContextSearch;
// - new behaviour: ����� ��������� ������ � ���������� ��������������� ���������;
//
// Revision 1.21  2006/05/12 07:14:27  mmorozov
// - ��������� ������������ �� ����� ���������� CVS;
//
// Revision 1.20  2006/04/18 08:53:28  mmorozov
// - new: ������ ������������;
// - new: �������� ������ (bsHyperlinkManager);
// - warnings fix;
//
// Revision 1.19  2006/04/17 10:54:12  mmorozov
// - ��������� ��������� � ��������� ����� ������ ������������;
// - ��������� ���� ��������������;
//
// Revision 1.18  2006/04/17 07:18:45  oman
// - change: ��������� ������-������� (���� ������) �� ������������
//  ����������� (�����, imageindex)
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.17  2006/04/05 14:52:16  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.16  2006/04/04 14:03:36  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.15  2005/12/15 11:37:08  mmorozov
// - new: ������ �������� ������ ���� ���������;
// - new: ������ �������� ��������� �� ��������� ��������;
// - new: ������������� ��������������� ������ �� ������ ������� ����;
//
// Revision 1.14  2005/11/15 12:36:14  mmorozov
// - cleanup: �������� ���� ������ - "������������", "��� (�� ���� �����)";
//
// Revision 1.13  2005/11/14 15:28:54  mmorozov
// - cleanup: �������� ���� ������ - "��������� �� �����������", "�����������", "����� ������";
// - new: ��������� ����������� ������ �������� ������ �� ������� ������;
//
// Revision 1.12  2005/10/26 07:46:03  mmorozov
// bugfix: ����� ������� ����������� ��� ������, � ���������� ���� ��������;
//
// Revision 1.11  2005/10/11 13:18:20  mmorozov
// - ������ ��� ������� ������� (����� � ���������);
//
// Revision 1.10  2005/10/05 09:47:54  mmorozov
// change: ������� � ��������� ������ (��� ������, �������);
//
// Revision 1.9  2005/09/15 13:19:01  mmorozov
// - ��������� ������� ������ � ������� �� �����;
//
// Revision 1.8  2005/09/14 12:54:50  demon
// - new behavior: ��� TnsUserCRListId �������� � bsTypes
//
// Revision 1.7  2005/08/26 09:52:18  mmorozov
// change: TnsLanguage ���� TbsLanguage � �������� � bsTypes;
//
// Revision 1.6  2005/08/24 09:34:11  mmorozov
// change: �������������� ��������� ����;
//
// Revision 1.5  2005/08/24 07:18:58  mmorozov
// new: enum TbsWhatDoIfOneDoc;
//
// Revision 1.4  2005/08/24 06:51:06  mmorozov
// new: enum _TbsLinkType;
//
// Revision 1.3  2005/08/22 15:40:21  mmorozov
// new: TDocumentPositionType (��������� �� nsTypes);
//
// Revision 1.2  2005/08/17 08:31:19  mmorozov
// new: enum _TlstCRType;
//
// Revision 1.1  2005/08/15 14:09:02  mmorozov
// new: ���� ��� ������ ����;
//

{$Include nsDefine.inc}

interface

// <no_string>

uses
  SysUtils,

  BaseTypesUnit,
  SecurityUnit,

  bsTypesNew
  ;

const
  LG_RUSSIAN = BaseTypesUnit.LG_RUSSIAN;

type
  TbsSortType = TSortType;
  TbsValidSortTypes = set of TbsSortType;

  TbsSortOrder = TSortOrder; 

  TbsLanguage = TLanguages;

  TbsTextSearchOptionType = TTextSearchOptionType;

  TbsObjectId = TObjectID;

  TbsLanguages = set of TbsLanguage;

  TbsListNodeType = (
    lntUnknown,
    lntBlock,
    lntDocActive,
    lntDocPreActive,
    lntDocAbolished,
    lntExternalObject,
    lntExternalLink,
    lntRedaction,
    lntRedactions,
    lntDrugAnnuled,
    lntDrugNarcotic,
    lntDrugNoAnnuledNoNarcoric,
    lntFormAnnuled,
    lntFormRussianImportant,
    lntFormNoRussianImportant,
    lntFormRussianNoImportant,
    lntFormNoRussianNoImportant,
    lntMedicFirm,
    lntAAC
  );//TbsListNodeType

  TbsUserNodeType = (
    untUnknownUser,
    untActiveSystem,
    untActiveNonSystem,
    untInactiveSystem,
    untInactiveNonSystem,
    untExiting,
    untActivePrivileged,
    untInActivePrivileged
  );//TbsUserNodeType

  TbsUserNodeTypes = set of TbsUserNodeType;

  TbsGroupNodeType = (
    gntUnknown,
    gntSystem,
    gntUsual
  );//TbsGroupNodeType

  TlstCRType = (
  {* ������ �������������� ���������������/������������. CorrRespType = crt. }
    crtCorrespondents, // ��������������
    crtRespondents,    // �����������
    crtNone            // ������ ����������
  );//TlstCRType

  TbsListOpenFrom = (
  {* ������ ��� ������ ������. }
   lofNone,        // �� ��������/�� �����
   lofRubricator,  // ��������� �� �����������
   lofMultilink,   // �������� ������������
   lofFullScreenCR, // ��� �������� �� ���� �����
   lofBaseSearch,   // ����� �������� ������
   lofBaseSearchEx, // ����� ���������� ������
   lofAttributeSearch // ����� ���
  );//TbsListOpenFrom

  TbsUserCRList = (
   {* ��� ����������������� ������ �������� � ������� ����������� ���������. }
   bs_ulUserCR,
    // - ���������������� ���;
   bs_ulFullCR
    // - ������ ��� � ������������ ������ ����;
  );//TbsUserCRListSynchroForm

  TbsNestedDocumentType = (
   {* - ���� ���������� ���������� ��������� ������ IDocument. }
    ndtAnnotation,
     // - ���������;
    ndtRelatedDoc,
     // - �������;
    ndtTranslation,
     // - �������;
    ndtChronology
  );//TbsNestedDocumentType

  TnsUserCRListId = (
   {* ������������� ���������������� �������. }
    ulFirst,
     // - ������ �������.
    ulSecond
     // - ������ �������.
  );//TnsUserCRListId

  PnsUserCRListId = ^TnsUserCRListId;

  TbsWhatDoingIfOneDoc = (
  {* ��� ������ ���� � ������ ���� ��������. }
    wdAlwaysOpen,
    // ������ ��������� ���� � ������ ���� ��������
    wdOpenIfUserDefine
    // ��������� ���� ������������ ��������� ��� � ����������
  );//TbsWhatDoingIfOneDoc

  TDocumentPositionType = bsTypesNew.TDocumentPositionType;

  TbsDocPos = bsTypesNew.TbsDocPos;

  TbsConsultationMark = (
  {* ���� ������ ������������. }
    bs_cmNotSure, // ����������� ��������
    bs_cmFive,    // �������
    bs_cmFour,    // ������
    bs_cmThree,   // �����������������
    bs_cmTwo,     // �������������������
    bs_cmNone     // �� ����������
  );//TbsConsultationMark

  TbsNotification = (
  {* ��� �����������. }
    nConsultation
     // - ������������;
  );//TbsNotification

  TbsConsultationOperation = (
  {* �������� ����������� � ��������������. }
    coUnreadChanged,
     // - ���������� ���������� �� ����������� ������������;
    coNoConnection,
     // - �� ����� � �������� ������������;
    coNoSubscription,
     // - ��� ������� � ������� ������������;
    coInternetConnected,
     // - ����� ��������� �����;
    coInternetDisConnected 
  );//TbsConsultationOperation                     `

  TbsConsultationOperations = set of TbsConsultationOperation;

  TbsUseCaseProfile = (
  {* ���������� � �������� ����������. }
    ucpDocument,
     // - �������� ���������� ��������;
    ucpQueryCard,
     // - �������� �������� �������;
    ucpOpenListAfterSearch,
     // - �������� ������ ����� ������;
    ucpMainMenu
     // - �������� ��������� ����;
  );//TbsUseCaseProfile

  TbsSaveListKind = (
   bs_slkTitlesFirstLevel,
    // - �������� ����������, ������ ������ ������� (��� ���������)
   bs_slkTitlesFullTree,
    // - �������� ���������� �� �����������
   bs_slkTitlesTopicNumbers
    // - ���������� �������������� ����������
  );//TbsSaveListKind

  TbsConsultationStatus = (
   {* - ������� ������������. }
    bs_csNone,
     // - �����������
    bs_csSent,
     // ����������
    bs_csPaymentRequest,
     // ������� ������ �� ������
    bs_csAnswerReceived,
     // ������� �����
    bs_csRead,
     // ���������
    bs_csEstimationSent,
     // ���������� ������
    bs_csDrafts,
     // ���� ��������
    bs_csPaymentRefusal,
     // �� ����������
    bs_csPaymentRefusalOldFormat,
     // �� ����������, ������� ������� 6.4, �� ���������� �����
    bs_csPaymentConfirm,
     // ������ ������������
    bs_csValidationFailed,
     // �� ������ ��������� �� ��
    bs_csAnswerNotConfirm,
     //
    bs_csReadNotConfirm
     // ������������ ���������, �� ������������� � ��������� ������ �� ����������
  );//������ ������������

  TbsConsultationStatuses = set of TbsConsultationStatus;

  TbsListType = (
   {* - ��� ������ }
   bs_ltDocument,
   bs_ltDrug,
   bs_ltNone
  );//TbsListType

const
  c_bsShowQueryForConsultations = [
   {* - ������������ ��� ������� ����� ���������� ����� ������� ������������. }
    bs_csDrafts,
    bs_csSent,
    bs_csPaymentRefusalOldFormat,
    bs_csValidationFailed
  ];//c_bsShowQueryForConsultations
  c_bsConsultationsWithoutList  = c_bsShowQueryForConsultations;
   {* - ������������ � ������� ��� ������. }
  c_bsSetReadStatusForConsultations = [bs_csAnswerReceived, bs_csAnswerNotConfirm];
   {* - ������������ ��� ������� ����� ������������� ������ �������������. }
  c_bsNeedMarkForConsultations = [bs_csRead, bs_csReadNotConfirm];
   {* - ������������, ������� ����� �������. }

implementation

end.
