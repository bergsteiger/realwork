unit nsConst;

// $Id: nsConst.pas,v 1.45 2015/11/06 12:42:26 kostitsin Exp $

// $Log: nsConst.pas,v $
// Revision 1.45  2015/11/06 12:42:26  kostitsin
// ��������
//
// Revision 1.44  2015/09/07 12:35:58  kostitsin
// {requestlink: 606128536 }
//
// Revision 1.43  2015/08/13 10:22:18  dinishev
// {Requestlink:602009846}
//
// Revision 1.42  2015/07/23 13:59:37  kostitsin
// {requestlink: 596385728 }
//
// Revision 1.41  2014/07/24 10:26:26  morozov
// {RequestLink: 340174500}
//
// Revision 1.40  2014/06/25 07:15:39  morozov
// {RequestLink: 340174500}
//
// Revision 1.39  2014/06/24 06:04:33  morozov
// {RequestLink: 340174500}
//
// Revision 1.38  2014/06/18 11:22:17  kostitsin
// {requestlink: 513615258 }
//
// Revision 1.37  2014/05/23 07:25:48  morozov
// {RequestLink: 518765917}
//
// Revision 1.36  2013/08/23 12:58:45  lulin
// {RequestLink:414849897}
//
// Revision 1.35  2013/08/21 06:28:25  morozov
// ����� �� ���������
//
// Revision 1.34  2013/08/20 17:22:07  kostitsin
// [$414849897]
//
// Revision 1.33  2013/07/02 14:21:33  morozov
// {RequestLink:434744658}
//
// Revision 1.32  2012/09/06 12:56:01  kostitsin
// [$390585678]
//
// Revision 1.31  2012/04/04 09:02:51  lulin
// {RequestLink:237994598}
//
// Revision 1.30  2012/01/19 14:09:22  lulin
// {RequestLink:327825257}
//
// Revision 1.29  2011/06/08 16:06:20  lulin
// {RequestLink:267326476}.
//
// Revision 1.28  2011/04/13 14:33:55  lulin
// {RequestLink:258607641}.
//
// Revision 1.27  2011/03/21 14:03:18  lulin
// {RequestLink:228691765}.
//
// Revision 1.26  2011/03/17 15:27:33  lulin
// {RequestLink:228691765}.
//
// Revision 1.25  2011/03/16 18:24:14  lulin
// {RequestLink:228688510}.
// - ���������� ����� ����� ���� ����.
//
// Revision 1.24  2011/02/15 13:25:15  lulin
// {RequestLink:231670346}.
//
// Revision 1.23  2010/12/21 11:34:08  migel
// - add: ��������� "�������� ���������� � MS Office".
//
// Revision 1.22  2010/10/28 06:56:31  demon
// - ��������� � �������� ��������� ���������� InsOpenDocOnNumberData. ������ ����� ���� ����� ���������� �� ������ Sub'�, �� � ����� ���� ���� ������� � ���������
//
// Revision 1.21  2010/10/11 08:42:42  oman
// - new: {RequestLink:235871729}
//
// Revision 1.20  2010/10/04 12:32:31  oman
// - new: �������� � �� ������ {RequestLink:235057812}
//
// Revision 1.19  2010/09/10 15:58:29  lulin
// {RequestLink:197496539}.
//
// Revision 1.18  2010/08/26 09:13:59  oman
// - new: {RequestLink:233734442}
//
// Revision 1.17  2010/07/15 12:28:43  oman
// - new: ��������� {RequestLink:226002365}
//
// Revision 1.16  2010/06/08 06:29:16  oman
// - new: {RequestLink:217681269}
//
// Revision 1.15  2010/06/02 07:09:53  oman
// - new: {RequestLink:217156696}
//
// Revision 1.14  2010/02/12 11:33:44  oman
// - fix: {RequestLink:190680537}
//
// Revision 1.13  2010/01/19 12:09:23  lulin
// {RequestLink:178717037}.
//
// Revision 1.12  2010/01/18 12:14:09  oman
// - new: ��������� ���� {RequestLink:177538395}
//
// Revision 1.11  2009/12/15 09:16:17  oman
// - new: ��������� {RequestLink:173933321}
//
// Revision 1.10  2009/11/05 11:41:39  oman
// - new: {RequestLink:121160631}
//
// Revision 1.9  2009/11/05 08:29:50  oman
// - new: {RequestLink:168955411}
//
// Revision 1.8  2009/11/03 13:28:43  oman
// - new: {RequestLink:168955411}
//
// Revision 1.7  2009/10/26 09:24:02  oman
// - fix: {RequestLink:121160631}
//
// Revision 1.6  2009/10/23 12:00:18  oman
// - fix: {RequestLink:121160631}
//
// Revision 1.5  2009/10/19 06:47:00  oman
// - new: ������������ � ������� {RequestLink:164596503}
//
// Revision 1.4  2009/10/16 09:17:50  oman
// - new: ��������� � �������� �� ������ {RequestLink:164596503}
//
// Revision 1.3  2009/10/14 08:06:35  oman
// - new:  {RequestLink:166855015}
//
// Revision 1.2  2009/10/14 07:30:56  oman
// - new:  {RequestLink:166855383}
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.116  2009/07/31 17:29:52  lulin
// - ������� �����.
//
// Revision 1.115  2009/07/29 12:27:59  oman
// - new: ��������� ������������ - {RequestLink:152408792}
//
// Revision 1.114  2009/06/10 08:35:42  oman
// - new: ���� ��������� - [$151585826]
//
// Revision 1.113  2009/06/08 07:25:41  oman
// - new: ���������� ���������� ������ - [$140286494]
//
// Revision 1.112  2009/04/17 09:04:01  oman
// - new: ���������� ������ � ��������� ������������ - [$127762671]
//
// Revision 1.111  2009/03/26 08:04:52  oman
// Cleanup - [$140283704]
//
// Revision 1.110  2009/03/25 17:22:25  lulin
// [$136937722]. �������� ��������� � ������������� ����.
//
// Revision 1.109  2009/03/25 17:10:11  lulin
// [$136937722]. �������� ���������.
//
// Revision 1.108  2009/03/25 16:01:49  lulin
// [$136937722]. ��������� ������, ���������, ������.
//
// Revision 1.107  2009/02/09 19:17:18  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.106  2008/12/24 14:18:22  lulin
// - <K>: 133138664.
//
// Revision 1.105  2008/11/01 12:31:08  lulin
// - <K>: 121167580.
//
// Revision 1.104  2008/10/01 11:54:01  oman
// - fix: ������ ��������� ���������� (�-120718336)
//
// Revision 1.103  2008/09/25 11:42:57  oman
// - fix: ��������� �������� (�-119472960)
//
// Revision 1.102  2008/08/01 13:09:53  mmorozov
// - new: ���������� �� ���������� FlashActiveX (K<104434872>);
//
// Revision 1.101  2008/07/30 10:43:50  oman
// - new: ����������� ������� ������ (�-104432770)
//
// Revision 1.100  2008/07/22 12:48:44  mmorozov
// - new: ������ �� ������� ������� ��� ������ (K<96484593>);
//
// Revision 1.99  2008/07/22 10:10:22  oman
// - new: ���������� ������� - �������� (�-103940886)
//
// Revision 1.98  2008/07/01 09:34:46  oman
// - new: �������� ������ ����� � ������ ����� (�-96484702)
//
// Revision 1.97  2008/06/25 08:04:48  oman
// - new: ������ ��������� ��� �� (cq29374)
//
// Revision 1.96  2008/06/04 13:05:28  mmorozov
// - new: ���������� �������� ������� ����������� � �������� ���� ������;
//
// Revision 1.95  2008/05/22 11:31:14  mmorozov
// - ������ ������ � ��������� ���� ������.
//
// Revision 1.94  2008/05/22 07:05:39  mmorozov
// - new: �������� ���� ������.
//
// Revision 1.93  2008/05/07 16:17:23  mmorozov
// new: ���������� �������;
//
// Revision 1.92  2008/04/17 05:53:28  mmorozov
// - new: "�������������� � �������� ������ ��� ���������" ������������� ��� ���������� � ����������.
//
// Revision 1.91  2008/04/10 07:45:36  oman
// - new: ��������� ������� (cq28755)
//
// Revision 1.90  2008/04/09 11:26:13  mmorozov
// - ��������� ����������� ���������� ��� ������ ���������.
//
// Revision 1.89  2008/04/09 09:38:23  oman
// - new: ����� �������� ��������� ����
//
// Revision 1.88  2008/04/07 09:48:04  oman
// - new: ������ ���� - ������ ��� ������� �����
//
// Revision 1.87  2008/04/03 11:18:57  oman
// - new: ��������-�������� - ��������� ����������� ���������� (cq28562)
//
// Revision 1.86  2008/03/31 12:58:33  oman
// - new: ������ ����-�������������� - ��������� ����������� ����������
//
// Revision 1.85  2008/03/21 09:11:17  oman
// - fix: ��������� � �� ���
//
// Revision 1.84  2008/03/11 12:05:30  oman
// ����� ������� ��
//
// Revision 1.83  2008/03/06 10:49:21  oman
// - new: ��������� ��� ������� ����������� �������� - ��������� ����������� ����������
//
// Revision 1.82  2008/03/06 10:02:55  oman
// - new: ��������� ��� ������� ����������� ��������
//
// Revision 1.81  2008/03/06 07:58:40  oman
// - new: ��������� ��� �� ������� (cq28584)
//
// Revision 1.80  2008/02/27 07:32:45  oman
// - fix: ��������� ����������� ����������� (cq28507)
//
// Revision 1.79  2008/02/19 07:45:13  oman
// - new: ��������� ����������� ���������� ��� ������� ��� (cq28223, 16723)
//
// Revision 1.78  2008/02/14 12:33:34  oman
// - new: ������� ��� �������� � �������� (cq28223, 16723)
//
// Revision 1.77  2008/02/13 11:23:59  oman
// ��������
//
// Revision 1.76  2008/02/13 11:15:10  oman
// - new: ��������� ��� ������� ��� (cq28223, 16723)
//
// Revision 1.75  2008/02/07 08:01:55  oman
// - new: ��������� ����������� ������������ - ���� ��� �������� (cq28378)
//
// Revision 1.74  2008/01/26 12:30:38  mmorozov
// - change: ���������� �� ����������� ��������� � �������������� ������ ��� ������ � ����������� (K<79858834>);
//
// Revision 1.73  2008/01/25 11:25:33  oman
// - new: ������ ������ ����� ������ �� �������� (cq27281)
//
// Revision 1.72  2008/01/15 14:41:18  oman
// - new: ����� ������ ���� ������ (cq13279)
//
// Revision 1.71  2008/01/10 07:23:10  oman
// ������� �� ����� �������
//
// Revision 1.69.4.4  2007/12/11 09:31:52  mmorozov
// - MERGE WITH HEAD;
//
// Revision 1.69.4.3  2007/11/26 09:03:45  oman
// ������������ �� ����� �������
//
// Revision 1.69.4.2  2007/11/21 10:26:01  oman
// ������������ �� ����� �������
//
// Revision 1.69.4.1  2007/11/16 12:23:36  oman
// ������������ �� ����� �������
//
// Revision 1.70  2007/12/10 12:50:42  mmorozov
// - new: ��������� ������ publisher\subscriber ��� �������������� ��������, ������ �������� (������������ ������������), ��������� ������� ������������ (� ������ CQ: OIT5-27823);
//
// Revision 1.69  2007/10/10 06:58:28  oman
// - new: �������� ������ �� ��������-������� (cq26995)
//
// Revision 1.68  2007/08/28 10:33:44  oman
// - new: ������ �� ������� ������ � ��� (cq26503)
//
// Revision 1.67  2007/08/28 07:26:06  oman
// - fix: ���������� �� �� �������� ����� (cq26511)
//
// Revision 1.66  2007/08/22 11:17:27  oman
// - fix: ������� AT_TEXT_OPT (cq25394)
//
// Revision 1.65  2007/08/21 10:30:03  oman
// - new: ��� ����� ��������� � ����������  ��� ������ �� � ��������
//  ����, � �� ����� ��������� (cq26410)
//
// Revision 1.64  2007/07/30 09:24:30  mmorozov
// - new: ���������� ������� ������ ��� �������� ����� ���� ��������� ����������� ����;
//
// Revision 1.63  2007/05/17 06:52:10  oman
// - fix: ��� ������ �� ��� � ������� ���������� ��������� �
//  "����� � ��������"
//
// Revision 1.62  2007/04/25 10:14:32  oman
// - fix: ����� ��������� � ��������� ������ � ����� ����� (cq25145)
//
// Revision 1.61  2007/04/17 09:29:47  mmorozov
// - new: ���������� ��������� ������ ��������� ������ ����������;
//
// Revision 1.60  2007/04/16 09:20:36  oman
// - new: ������� EMail ��� �������� ��������� ������/������ �
//  ������� (cq24416)
//
// Revision 1.59  2007/03/26 11:51:44  oman
// - ������ ������ ����������
// - ����������� ��������� ����������
//
// Revision 1.58  2007/03/19 13:10:42  oman
// - new: ��������� ����������� ���������� ��� ������
//  ������������� (cq24456)
//
// Revision 1.57  2007/03/06 08:17:58  oman
// Cleanup
//
// Revision 1.56  2007/02/14 16:58:07  lulin
// - ����������� �� ������������� ����������� �����.
//
// Revision 1.55  2007/01/30 09:18:02  oman
// - new: �������� ��� ����������� ���������� � ����������
//  (cq24111)
//
// Revision 1.54  2007/01/29 10:09:28  mmorozov
// - new: � ������ ������ ��� CQ: OIT5-24234;
// - bugfix: �� ��������� ������� ����� ������������ ����;
//
// Revision 1.53  2007/01/24 14:13:24  lulin
// - ������ ������������� ������� ������� ���������.
//
// Revision 1.52  2007/01/18 12:57:11  mmorozov
// - new: ������� �������� ���� (CQ: OIT5-23939);
//
// Revision 1.51  2007/01/05 15:23:14  lulin
// - cleanup.
//
// Revision 1.50  2006/10/02 08:15:43  oman
// - fix: ����� ������ � "������ � ���������" (cq22780)
//
// Revision 1.49  2006/09/19 12:29:17  oman
// - new: ����� ����� ��� ���������������� ������ �� ������������
//  (cq22633)
//
// Revision 1.48  2006/09/18 09:08:43  oman
// - fix: ���������� �������� ������������ �����
// - fix: ���������� ����������� �� ����� �����
// cleanup (�������� ��������/���������/��������)
//
// Revision 1.47  2006/07/25 09:39:24  mmorozov
// - change: ��� ��������� ������������� ���� ������� ���������� ������� ������ ������� (�������� ����� �������� ���� �������);
//
// Revision 1.46  2006/07/25 09:11:24  mmorozov
// - change: TConsultationStatus;
//
// Revision 1.45  2006/07/07 15:23:39  mmorozov
// - new: � ������ � ������������ ��������� ������ (CQ: OIT500021512);
//
// Revision 1.44  2006/05/17 14:48:57  mmorozov
// - new behavour: ��� �������������� ������� ����������� �� ������ ��� ������� �� � ������ ���������, ����� ��������� � ������������ 5.� ��������� ������ �������� �������� ������ ��� 5.� ��� ��� ��� ������� (OIT500020569);
//
// Revision 1.43  2006/05/02 13:56:12  mmorozov
// - ������ ��������� � ��������������� ��������;
//
// Revision 1.42  2006/04/21 12:44:29  dinishev
// new constansts
//
// Revision 1.41  2006/04/21 10:16:34  mmorozov
// - new: �������������� ����� �������;
//
// Revision 1.40  2006/04/19 13:34:29  oman
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.39  2006/04/06 11:24:19  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.38  2006/04/05 13:50:18  dinishev
// �������� �� ������� ������������
//
// Revision 1.37  2006/03/20 15:08:03  dinishev
// �������� ������������� �������� ����� � ������� ��� ����� ��
//
// Revision 1.36  2006/03/20 09:27:53  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr, DebugStr � SystemStr)
//
// Revision 1.35  2005/11/25 12:43:59  demon
// - fix: ������ ������� � ����������
//
// Revision 1.34  2005/11/23 13:24:12  demon
// - fix: �������� ������������ �������������� � ����������� ���
//
// Revision 1.33  2005/09/26 09:11:17  dinishev
// ����� ��������� � ������������ ������ ��� ������ � �����������
//
// Revision 1.32  2005/09/22 15:03:50  dinishev
// �������� ���������������� ���������
//
// Revision 1.31  2005/09/16 09:09:19  demon
// - new _string const
//
// Revision 1.30  2005/09/15 13:18:39  mmorozov
// - ��������� ������� ������ � ������� �� �����;
//
// Revision 1.29  2005/08/26 12:02:07  demon
// - new behavior: ������ �� ���������� ������������ ���������� �� UID ������ Login'�
//
// Revision 1.28  2005/08/11 15:48:54  demon
// - new behavior: ��������� ������ ������� ��� ��� ������� �� ��������� ��������������
//
// Revision 1.27  2005/07/29 16:06:29  mmorozov
// change: �������������� ��������� �����;
//
// Revision 1.26  2005/04/18 11:49:00  lulin
// - nothing special.
//
// Revision 1.25  2005/02/15 08:12:23  mmorozov
// - ���������� ��������� ��������� �� ������ nsQuery;
//
// Revision 1.24  2004/10/11 08:35:45  mmorozov
// - cleanup;
// - rename;
//
// Revision 1.23  2004/09/17 07:11:51  am
// change: cDictionSearchBorder = 5
//
// Revision 1.22  2004/09/15 15:16:14  am
// change: cDictionSearchBorder
//
// Revision 1.21  2004/08/23 16:23:27  demon
// - new behavior: ������������������� ��������� ���� (��� ���)
//
// Revision 1.20  2004/07/23 17:12:10  mmorozov
// - cleaup: constants BreafLogicalSelections, BreafSelectionAttributesTag, NumbersTag;
//
// Revision 1.19  2004/07/09 14:16:11  demon
// - new const
//
// Revision 1.18  2004/07/06 16:22:52  mmorozov
// new: ��������� �������������;
//
// Revision 1.17  2004/07/01 13:44:47  law
// - new build.
//
// Revision 1.16  2004/06/30 14:48:52  demon
// - stub: ����� �������� ��������� �������� ���������
//
// Revision 1.15  2004/06/30 10:51:11  law
// - new behavior: ���������� �������� �������� ���������.
//
// Revision 1.14  2004/06/28 07:14:35  nikitin75
// bool is_para -> PositionType type //PT_SUB|PT_PARA|PT_BOOKMARK
//
// Revision 1.13  2004/06/24 13:13:08  demon
// - new behavior: ��������� ��������� cDocumentFrame �� MaxLongInt, ���� �� ��������� ������� �������� ��������.
//
// Revision 1.12  2004/06/16 10:32:54  am
// change: TLogicSelection -> TLogicOperation
//
// Revision 1.11  2004/06/09 15:31:20  law
// - ���������� �������� ���������.
//
// Revision 1.10  2004/06/07 15:29:16  law
// - new behavior: ��� �������� ��������� ������ ����� � ��� �����, �� ������� ���� �����������������.
//
// Revision 1.9  2004/06/07 12:06:30  law
// - ��������� ��������� CVS.
//

interface

uses
  Graphics,

  l3Defaults,

  vcmInterfaces,

  evConst,

  vtNavigator,

  bsTypes,

  nsTypes,
  nsAppConfigRes,
  SystemStr,

  evAACContentUtils,

  BaseTypesUnit,
  DynamicTreeUnit,

  SearchDomainInterfaces,

  nsSettingsConst
  ;

const
{------------------------------------------------------------------------------}
{ �������������� �������� ��� �������� ������������ ��� �����������.           }
{------------------------------------------------------------------------------}
  gi_cpKeywordSerch  = AT_KW;
  gi_cpPublishSource = AT_PUBLISH_SOURCE;
  gi_cpDiction       = 'stcpDiction';
  gi_cpNavigator     = 'stidNavigator';
  gi_cpType          = AT_TYPE;
  gi_cpRegNumber     = AT_REG_NUM;
  gi_cpMURegNumber   = AT_REG_IN_MU_NUM;
  gi_cpMURegStatus   = AT_REG_IN_MU;
  gi_cpStatus        = AT_STATUS;
  gi_cpNorm          = AT_NORM;
  gi_cpTerritory     = AT_TERRITORY;
  gi_cpBases         = AT_BASES;
  gi_cpContents      = 'stcpContents';
  gi_cpUserList      = 'stcpUserList';
  gi_cpDayTips       = 'stcpDayTips';
  gi_cpMedicDiction  = 'stcpMedicDiction';
  gi_cpMedicFirms    = 'stcpMedicFirms';
  gi_cpDrugContents  = 'stcpDrugContents';
  gi_cpDrugList      = 'stcpDrugList';
  gi_cpGroupList     = 'stcpGroupList';
{------------------------------------------------------------------------------}
{ ������ �� �������� ��� ���� ������.                                          }
{------------------------------------------------------------------------------}
  ciitGarant = 'http://www.garant.ru';
    // - �������� "������
  ciitHotDocs = 'http://www.garant.ru/hotlaw/federal/';
    // - ������� ���������
  ciitGovermentNews = 'http://www.garant.ru/news/';
    // - ������� ������� ������
  ciitGovermentWebLinks = 'http://www.garant.ru/doc/busref/spr_gos_site/';
    // - ����������� ��������-����� ������� ������
  ciitEncyclopaediaMonitorings = 'http://www.garant.ru/hotlaw/encmon/';
    // - ������������ �����������
  ciitBasicDocs = 'http://www.garant.ru/doc/';
    // - �������� ���������
  ciitForum = 'http://forum.garant.ru/';
    // - �����
  ciitTeaching = 'http://www.garant.ru/ipo/my_system/education/';
    // - ��������
  ciitAdviceOfDay = 'http://www.garant.ru/ipo/my_system/sovet/';
    // - ����� ���
  ciitTesting = 'http://www.garant.ru/products/ipo/my_system/certificate/';
    // - ����������� ����������������� ������������
  ciitCatalogOfProducts = 'http://www.garant.ru/ipo/system/solution/';
    // - ������� ���������
  ciitGarantWithYou = 'http://www.garant.ru/company/partner/';
    // - ������ ����� � ����
  ciitEnglishGarant = 'http://english.garant.ru/mon.htm';
    // - ������ - ���������� ����
{------------------------------------------------------------------------------}
{ �������������� �������� ������� �������.                                     }
{------------------------------------------------------------------------------}
  cHelpStartPage       = 'page-hello.htm';
  cHelpAttributeRules  = 'page-man-search-req-fields.htm';
  cHelpConsultingRules = 'page-man-consulting-rules.htm';
  cHelpInpharm         = 'page-man-inpharm.htm';
  cHelpSearchInpharm   = 'page-man-inpharm-search-kz-requisite.htm';
  cHelpShortcutPage = 'page-shortcut_summary.htm';
  cInternetReplyBook = 'http://www.garant.ru/nav.php?pid=301&ssid=100';
{------------------------------------------------------------------------------}
{ ��������� ������ ��������� ����������.                                       }
{------------------------------------------------------------------------------}
  ns_nipBusinessInfoFolder: TnsNavigatorItemParams = (
   rId    : NM_BUSINESS_INFO_FOLDER;
   rLevel : 0);//ns_nipBusinessInfoFolder
  ns_nipLawNavigatorFolder: TnsNavigatorItemParams = (
   rId    : NM_LAW_NAVIGATOR_FOLDER;
   rLevel : 0);//ns_nipLawNavigatorFolder
  ns_nipHotInformation: TnsNavigatorItemParams = (
    rId    : NM_HOT_INFORMATION;
    rLevel : 1);//ns_nipHotInformation
  ns_nipLawSupport: TnsNavigatorItemParams = (
    rId    : NM_LAW_SUPPORT;
    rLevel : 0);//ns_nipLawSupport
  ns_nipExplanatoryDictionary: TnsNavigatorItemParams = (
   rId    : NM_EXPLANATORY_DICTIONARY;
   rLevel : 1);//ns_nipExpDictionary
  ns_nipAttributeSearch: TnsNavigatorItemParams = (
   rId: NM_ATTRIBUTE_SEARCH;
   rLevel : 1);//ns_nipAttributeSearch
  ns_nipSituationSearch: TnsNavigatorItemParams = (
   rId    : NM_SITUATION_SEARCH;
   rLevel : 1);//ns_nipSituationSearch
  ns_nipPublishSourceSearch: TnsNavigatorItemParams = (
   rId    : NM_PUBLISH_SOURCE_SEARCH;
   rLevel : 1);//ns_nipPublishSourceSearch
  ns_nipReview : TnsNavigatorItemParams = (
   rId    : NM_REVIEW;
   rLevel : 1);//ns_nipReview
  ns_nipNewDocs: TnsNavigatorItemParams = (
   rId    : NM_NEW_DOCS;
   rLevel : 1);//ns_nipNewDocs
  ns_nipNewsLine: TnsNavigatorItemParams = (
   rId    : NM_NEWS_LINE;
   rLevel : 0);//ns_nipNewsLine
  ns_nipMonitorings: TnsNavigatorItemParams = (
   rId    : NM_MONITORINGS;
   rLevel : 1);//ns_nipMonitorings
  ns_nipCodex: TnsNavigatorItemParams = (
   rId    : NM_CODEX;
   rLevel : 1);//ns_nipCodex
  ns_nipCalendar : TnsNavigatorItemParams = (
   rId    : NM_CALENDAR;
   rLevel : 1
    // - �� �������� NM_BUSINESS_INFO_FOLDER;
  );//ns_nipCalendar
  ns_nipForms: TnsNavigatorItemParams = (
   rId    : NM_FORMS;
   rLevel : 1;
    // - �� �������� NM_BUSINESS_INFO_FOLDER;
  );//ns_nipForms
  ns_nipBusinessReferences: TnsNavigatorItemParams = (
   rId    : NM_BUSINESS_REFERENCES;
   rLevel : 1;
    // - �� �������� NM_BUSINESS_INFO_FOLDER;
  );//ns_nipBusinessReferences
  ns_nipInpharm: TnsNavigatorItemParams = (
   rId    : NM_INPHARM;
   rLevel : 0;
  );//ns_nipInpharm
  ns_nipInpharmDrugList: TnsNavigatorItemParams = (
   rId    : NM_PHARM_LEK;
   rLevel : 0;
  );//ns_nipInpharm
  ns_nipInpharmFirms: TnsNavigatorItemParams = (
   rId    : NM_PHARM_FIRMS;
   rLevel : 0;
  );//ns_nipInpharm
  ns_nipInpharmDiction: TnsNavigatorItemParams = (
   rId    : NM_PHARM_DICT;
   rLevel : 0;
  );//ns_nipInpharm
  ns_nipInpharmSearch: TnsNavigatorItemParams = (
   rId    : NM_PHARM_SEARCH;
   rLevel : 1;
  );//ns_nipInpharm
  ns_nipInpharmBasicSection: TnsNavigatorItemParams = (
   rId    : NM_PHARM_BASIC_SECTION;
   rLevel : 1;
  );//ns_nipInpharmReferences
{------------------------------------------------------------------------------}
{ ��������� ���� ��������� ����                                                }
{------------------------------------------------------------------------------}
  c_MainMenuColor = l3Defaults.c_MainMenuColor;
 cGarant2011BackColor = l3Defaults.cGarant2011BackColor;
 {VK. ������� ���� ����
  http://mdp.garant.ru/pages/viewpage.action?pageId=228688486&focusedCommentId=228692478#comment-228692478 }
 cGarant2011GradientStartColor = l3Defaults.cGarant2011GradientStartColor;
 cGarant2011GradientEndColor = l3Defaults.cGarant2011GradientEndColor;
 cGarant2011SelectionColor = l3Defaults.cGarant2011SelectionColor;
 cGarant2011LinkColor = l3Defaults.cGarant2011LinkColor;
 cGarant2011BorderColor = l3Defaults.cGarant2011BorderColor;
 cGarant2011InnerBorderColor = l3Defaults.cGarant2011InnerBorderColor;
 cGarant2011KZBorderColor = l3Defaults.cGarant2011KZBorderColor;
 cGarant2011KZInnerBorderColor = l3Defaults.cGarant2011KZInnerBorderColor;
 cAACContentsBackColor = cnAACLeftBackColor;
{------------------------------------------------------------------------------}
{ �������������� �������� ����������.                                          }
{------------------------------------------------------------------------------}
   pi_ActivateDefaultLanguage = gi_IfaceSettings + '/�������� ������� ���� ��� �������';
    dv_ActivateDefaultLanguage = True;

   pi_IfaceLanguage = gi_IfaceSettings + '/���� ����������';
    dv_IfaceLanguage = li_il_Russian;

   pi_DefaultDocLanguage = gi_IfaceSettings + '/���� ��������� � ����';
    dv_DefaultDocLanguage = li_il_Russian;

     cvHistoryItemsMin = 5;
     cvHistoryItemsMax = 99;

   gi_MainWindowTabs = gi_IfaceSettings + '/������� ��������� ����';
    pi_OpenDocumentsFromList = gi_MainWindowTabs + '/��������� ��������� �� �������';
    pi_OpenLinksFromDocument = gi_MainWindowTabs + '/��������� ������ �� ����������';

  gi_Behaviour = '��������� �������';

   pi_OpenOnStart = gi_Behaviour + '/������ ������';
    li_OpenOnStartAttributeSearch = '����� �� ����������';
    li_OpenOnStartSituationSearch = '����� �� ��������';
    li_OpenOnStartMainMenu        = '�������� ����';
    li_OpenOnStartNavigator       = '�������� ���������';
    li_OpenOnStartInpharmSearch   = '����� �������������� ���������';
    li_OpenOnStartFullDrugList    = '������ ������������� ����������';
    li_OpenOnStartInpharmMainMenu = '�������� ���� ������';
    dv_OpenOnStart = li_OpenOnStartMainMenu;

   pi_NoShowPrimeDialog = gi_Behaviour + '/NoShowPrimeDialog';
    dv_NoShowPrimeDialog = False;
   pi_NeedShowSettingsDialog = gi_Behaviour + '/NeedShowSettingsDialog';
    dv_NeedShowSettingsDialog = False;
  // http://mdp.garant.ru/pages/viewpage.action?pageId=434744658
(*   pi_MainMenuType = gi_Behaviour + '/��� ��������� ����';
    dv_MainMenuType = Ord(ns_mmDefault); *)

   cWorkJournalPrefix = '��������� �������/������ ������/';

   pi_WorkJournalSize = cWorkJournalPrefix + '������';
    max_WorkJournalSize  = 30;
    dv_WorkJournalSize = 10;

   pi_RecentlyOpenDocumentsCount = cWorkJournalPrefix + '��������� �������� ���������';
    max_RecentlyOpenDocumentsCount  = 20;
    dv_RecentlyOpenDocumentsCount = 5;

(*   {$If not defined(Admin) AND not defined(Monitorings)}
   cPrintAndExport = gi_Behaviour + '/������ � �������/';
    pi_PrintAndExportDefaultFontSize = cPrintAndExport + '����� ��� �� ������';
    dv_PrintAndExportDefaultFontSize = False;
    pi_PrintAndExportFontSize = cPrintAndExport + '���������������� ��������';
    dv_PrintAndExportFontSize = True;
    pi_PrintAndExportCombo = cPrintAndExport + '������ ������';
    dv_PrintAndExportCombo = pef12;
   {$IfEnd} //not Admin AND not Monitorings*)

   cBehaviourSheets = gi_Behaviour + '/��������/';

   pi_Sheets_MainMenu = cBehaviourSheets + '�������� ����';
    dv_Sheets_MainMenu = True;

   pi_Sheets_Config = cBehaviourSheets + '������������';
    dv_Sheets_Config = False;

   pi_Sheets_MyDocuments = cBehaviourSheets + '��� ���������';
    dv_Sheets_MyDocuments = True;

   piSheetsDocUnderControl = cBehaviourSheets + '�� ��������';
    cv5xSheetsDocUnderControl = False;
    cv6xSheetsDocUnderControl = False;
      dvSheetsDocUnderControl = cv6xSheetsDocUnderControl;

   piSheetsTaskPanel = cBehaviourSheets + '������ �����';
    cv5xSheetsTaskPanel = False;
    cv6xSheetsTaskPanel = False;
      dvSheetsTaskPanel = cv6xSheetsTaskPanel;

   gi_DayTips = gi_Behaviour + '/����� ���';
   pi_DayTips_DontShowAtStart = gi_DayTips + '/�� ���������� �� ������';
    dv_DayTips_DontShowAtStart = False;

   pi_PlayBeepOnMistake = gi_Behaviour + '/������ � �� �� ���������';
    dv_PlayBeepOnMistake = True;

   pi_NotifyNewChatMesages = gi_Behaviour + '/�������������� ����� ���-���������';
    dv_NotifyNewChatMesages = True;

   pi_EnableMSOfficeIntegration = gi_Behaviour + '/�������� ���������� � MS Office';
    dv_EnableMSOfficeIntegration = True;

  gi_List = '������ �� �������';

   pi_DocumentList_PrintOnlyFirstLevel = gi_List + '/�������� ������ ������ �������';
    dv_DocumentList_PrintOnlyFirstLevel = True;

   pi_DrugList_PrintOnlyFirstLevel = gi_List + '/�������� ������ ������ ������� ����������';
    dv_DrugList_PrintOnlyFirstLevel = True;

   // ����� ���� ����������� ��������� ������������ �� ���������:
   pi_List_ShowAnnotationByDefault = gi_List + '/ShowAnnotationByDefault';
    dv_List_ShowAnnotationByDefault = True;

   pi_List_ExportWORestrictions = gi_List + '/�������������� ��� �����������';
    dv_List_ExportWORestrictions = False;

//   pi_List_OpenInNewWindow = '������ �� �������/��������� � ����� ����';
//    dv_List_OpenInNewWindow = False;

   pi_List_AutoTransfer = gi_List + '/�������������� �������';
    dv_List_AutoTransfer = True;

   pi_List_SortType = gi_List + '/��������� ����������/��� ����������';
    dv_List_SortType = Ord(ST_PRIORITY);

   pi_List_OrderType = gi_List + '/��������� ����������/�������';
    dv_List_OrderType = ord(SO_DESCENDING);

   pi_List_Sheets_Filters = gi_List + '/��������/�������';
    dv_List_Sheets_Filters = True;

  giRubricator = '������ � ������������';
   piRubricatorTreeShow = giRubricator + '/��������/����������';
     cv5xRubricatorTreeShow = True;
     cv6xRubricatorTreeShow = True;
       dvRubricatorTreeShow = cv6xRubricatorTreeShow;

  gi_Document = '������ � ����������';
//   pi_Document_OpenInNewWindow = gi_Document + '/��������� ������ � ����� ����';
//    dv_Document_OpenInNewWindow = False;

   pi_Document_Warning = gi_Document + '/��������� ��������������';
    dv_Document_Warning = True;

   pi_Document_PermanentSelection = gi_Document + '/���������� ��������� ������';
    dv_Document_PermanentSelection = False;

   pi_Document_AutoShowContextSearch = gi_Document + '/�������������� ����� ������������ ������';
    dv_Document_AutoShowContextSearch = True;

   pi_Document_CRSheet0 = gi_Document + '/��������������-�����������/�������� 1';
    li_Document_CRSheet0_Disable = Ord(crtNone);
    dv_Document_CRSheet0 = Ord(crtCorrespondents);

   pi_Document_CRType0 = gi_Document + '/��������������-�����������/��� 1';
    dv_Document_CRType0 = li_li_Document_CRType5;

   pi_Document_CRSheet1 = gi_Document + '/��������������-�����������/�������� 2';
    li_Document_CRSheet1_Disable = Ord(crtNone);
    dv_Document_CRSheet1 = Ord(crtCorrespondents);

   pi_Document_CRType1 = gi_Document + '/��������������-�����������/��� 2';
    dv_Document_CRType1 = li_li_Document_CRType2;

   pi_Document_Sheets_Redactions = gi_Document + '/��������/������ ��������';
    dv_Document_Sheets_Redactions = True;

   pi_Document_Sheets_Attributes = gi_Document + '/��������/��������';
    dv_Document_Sheets_Attributes = True;

   pi_Document_Sheets_Translation = gi_Document + '/��������/�������';
    dv_Document_Sheets_Translation = True;

   piDocumentPictureScale = gi_Document + '/������� ��������';
     cvDocumentPictureScaleFit = '�� �� ����';
       {* - �� �� ����. }
     cvDocumentPictureScaleLow  = 1;
       {* - ������ ������� ��������. }
     cvDocumentPictureScaleHigh = 2000;
       {* - ������� ������� ��������. }
     dvDocumentPictureScale    = cvDocumentPictureScaleFit;
       {* - �� ���������. }
     li_dpsValues: array [0..7] of integer = (2000,1000,500,200,100,50,25,10);
     li_dps_Fit = cvDocumentPictureScaleFit;
     cv5xDocumentPictureScale = cvDocumentPictureScaleFit;
     cv6xDocumentPictureScale = cvDocumentPictureScaleFit;
      dv_DocumentPictureScale = cv6xDocumentPictureScale;

   pi_Document_ShowBlockBorders = gi_Document + '/������� ������';
    dv_Document_ShowBlockBorders = False;

   pi_Document_ShowSpecial = gi_Document + '/�����������';
    dv_Document_ShowSpecial = False;

   pi_Document_ShowTechComment = gi_Document + '/����������� �����������';
    dv_Document_ShowTechComment = False;

   pi_Document_SubPanel = gi_Document + '/������ �����';

   pi_Document_SubPanel_ShowBlocks = pi_Document_SubPanel + '/�����';
    dv_Document_SubPanel_ShowBlocks = True;

   pi_Document_SubPanel_ShowBookmarks = pi_Document_SubPanel + '/��������';
    dv_Document_SubPanel_ShowBookmarks = True;

   pi_Document_SubPanel_ShowJurorComments = pi_Document_SubPanel + '/����������� �������';
    dv_Document_SubPanel_ShowJurorComments = False;

   pi_Document_SubPanel_ShowUserComments = pi_Document_SubPanel + '/���������� ������������';
    dv_Document_SubPanel_ShowUserComments = False;

   pi_Document_SubPanel_ShowSubNumbers = pi_Document_SubPanel + '/������ �����';
    dv_Document_SubPanel_ShowSubNumbers = False;

   pi_Document_ExportWithBlockNames = gi_Document + '/������� � ������� ������';
    dv_Document_ExportWithBlockNames = False; 

   pi_Document_ShowVersionsComment = gi_Document + '/���������� ���������� �����������';
    dv_Document_ShowVersionsComment = False;

   pi_Document_ShowVersionCommentsLinkBehaviour = gi_Document + '/�� ������ � ���������� �� ���������� � ������ ��������� ���������';
    dv_Document_ShowVersionCommentsLinkBehaviour = False;

   pi_Document_SubPanel_ShowVersionComments = gi_Document + '/���������� ������ ���������� ������������';
    dv_Document_SubPanel_ShowVersionComments = true;
    
   pi_Document_ForceAskForIntranet = gi_Document + '/���������� ��� ����������������';
    dv_Document_ForceAskForIntranet = True; 

  gi_Search = '������ � �������';
   (* ���� �������� *)
   li_NewKindSearchForm = '�����������';
   li_OldKindSearchForm = '�������������, ���� ������ 5.�';
   (* ����� �� �������� *)
   pi_Search_SituationType = gi_Search + '/����� �� ��������';
    li_NewSearch_SituationType = li_NewKindSearchForm;
    li_OldSearch_SituationType = li_OldKindSearchForm;
    li_Search_SituationType_Disable = 1;
    dv_Search_SituationType = li_NewSearch_SituationType;
   pi_BaseSearch_BuildShortList = gi_Search + '/����������� ������ ��� ��';
    dv_BaseSearch_BuildShortList = True;

   pi_Search_FullInfo = gi_Search + '/���������� �������������� ���������';
    dv_Search_FullInfo = True;

   pi_Search_Sheets_Filters = gi_Search + '/��������/�������';
    dv_Search_Sheets_Filters = True;

   // ���������� ������
   pi_Search_List_IsBuild = gi_Search + '/�������������/���������� ������';
    dv_Search_List_IsBuild = True;

   pi_Search_List_BuildCount = gi_Search + '/�������������/���������� ������/���������� ���������';
    dv_Search_List_BuildCount = 0;

   // �����������
   piSearchListIsBuildReview = gi_Search + '/�������������/���������� ������/������������';
    cv5xSearchListIsBuildReview = True;
    cv6xSearchListIsBuildReview = True;
     dvSearchListIsBuildReview  = True;

   piSearchListBuildCountReview = gi_Search + '/�������������/���������� ������/���������� ���������/�����������';
    cv5xSearchListBuildCountReview = 0;
    cv6xSearchListBuildCountReview = 0;
     dvSearchListBuildCountReview  = 0;

  gi_Controllable = '��������� �� ��������';
   pi_DropChangeStatus = gi_Controllable + '/����� ������� ''�������''';
    li_DropChangeStatus_Manual = '�������';
    li_DropChangeStatus_OnOpen = '������������� ��� �������� ���������';
    li_DropChangeStatus_OnClose = '��� ���� ������������� ��� ������ �� �������';
    dv_DropChangeStatus = li_DropChangeStatus_Manual;

   gi_Print = '������';
    pi_Print_Metrics_Orientation = gi_Print + '/�������/����������';
     li_Metrics_Orientation0 = '�������';
     li_Metrics_Orientation1 = '��������';
     dv_Print_Metrics_Orientation = li_Metrics_Orientation0;
    pi_Print_Metrics_Margins_Left = gi_Print + '/�������/�������/�����';
     dv_Print_Metrics_Margins_Left = '20';
    pi_Print_Metrics_Margins_Top = gi_Print + '/�������/�������/������';
     dv_Print_Metrics_Margins_Top = '15';
    pi_Print_Metrics_Margins_Right = gi_Print + '/�������/�������/������';
     dv_Print_Metrics_Margins_Right = '15';
    pi_Print_Metrics_Margins_Bottom = gi_Print + '/�������/�������/�����';
     dv_Print_Metrics_Margins_Bottom = '15';
    pi_Print_Catchwords_First_UpLeft = gi_Print + '/�����������/������ ��������/������� �����';
     dv_Print_Catchwords_First_UpLeft = '%AppTitle%';
    pi_Print_Catchwords_First_UpRight = gi_Print + '/�����������/������ ��������/������� ������';
     dv_Print_Catchwords_First_UpRight = '%DocName%'#13#10'�������: %DocPagesCount%'#13#10'���������: %CurrentDate%';
    pi_Print_Catchwords_First_BottomLeft = gi_Print + '/�����������/������ ��������/������ �����';
     dv_Print_Catchwords_First_BottomLeft = '';
    pi_Print_Catchwords_First_BottomRight = gi_Print + '/�����������/������ ��������/������ ������';
     dv_Print_Catchwords_First_BottomRight = '';
    pi_Print_Catchwords_Other_UpLeft = gi_Print + '/�����������/����������� �������/������� �����';
     dv_Print_Catchwords_Other_UpLeft = '%AppTitle%';
    pi_Print_Catchwords_Other_UpRight = gi_Print + '/�����������/����������� �������/������� ������';
     dv_Print_Catchwords_Other_UpRight = '%DocCurrentPage% / %DocPagesCount%';
    pi_Print_Catchwords_Other_BottomLeft = gi_Print + '/�����������/����������� �������/������ �����';
     dv_Print_Catchwords_Other_BottomLeft = '';
    pi_Print_Catchwords_Other_BottomRight = gi_Print + '/�����������/����������� �������/������ ������';
     dv_Print_Catchwords_Other_BottomRight = '';

   pi_MainWindow_Reminder_Anchors = gi_Internal + '/������� ����/�����������/������';
    dv_MainWindow_Reminder_Anchors = 3;
   pi_MainWindow_Reminder_TopPos = gi_Internal + '/������� ����/�����������/������� �������';
    dv_MainWindow_Reminder_TopPos = 2;
   pi_MainWindow_Reminder_LeftPos = gi_Internal + '/������� ����/�����������/����� �������';
    dv_MainWindow_Reminder_LeftPos = 2;
   pi_Document_LastOpen_IsInternal = gi_Internal + '/��������/��������� �������� �� ������/����������';
    dv_Document_LastOpen_IsInternal = True;
   pi_Document_LastOpen_DocNumber = gi_Internal + '/��������/��������� �������� �� ������/����� ���������';
    dv_Document_LastOpen_DocNumber = 0;
   pi_Document_LastOpen_Position = gi_Internal + '/��������/��������� �������� �� ������/�������';
    dv_Document_LastOpen_Position = 0;
   pi_Document_LastOpen_PosType = gi_Internal + '/��������/��������� �������� �� ������/��� �������';
    dv_Document_LastOpen_PosType = 0;
   pi_Document_LastOpen_DocHistory = gi_Internal + '/��������/��������� �������� �� ������/������� �������';
    dv_Document_LastOpen_DocHistory = '';
   pi_Document_Reminder_Anchors = gi_Internal + '/��������/�����������/������';
    dv_Document_Reminder_Anchors = 3;
   pi_Document_Reminder_TopPos = gi_Internal + '/��������/�����������/������� �������';
    dv_Document_Reminder_TopPos = 2;
   pi_Document_Reminder_LeftPos = gi_Internal + '/��������/�����������/����� �������';
    dv_Document_Reminder_LeftPos = 2;
   pi_List_Reminder_Anchors = gi_Internal + '/������/�����������/������';
    dv_List_Reminder_Anchors = 3;
   pi_List_Reminder_TopPos = gi_Internal + '/������/�����������/������� �������';
    dv_List_Reminder_TopPos = 2;
   pi_List_Reminder_LeftPos = gi_Internal + '/������/�����������/����� �������';
    dv_List_Reminder_LeftPos = 2;
   pi_BaseSearch_StartCounter = gi_Internal + '/������� �����/������� ��������';
    dv_BaseSearch_StartCounter = 0;
   pi_BaseSearch_ExampleIndex = gi_Internal + '/������� �����/������ ������������ �������';
    dv_BaseSearch_ExampleIndex = 0;

  gi_Diction = '������ � ������������';
   pi_Diction_Sheets_Dictionary = gi_Diction + '/��������/�������';
    dv_Diction_Sheets_Dictionary = True;

  gi_Monitorings = '�����������';
   pi_Monitorings_Active_Theme = gi_Monitorings + '/�������� �������� ��������';

  gi_PostingOrder = '����� ��������';
   pi_PostingOrder_LastCatalog = gi_PostingOrder + '/��������� �������';
   //pi_PostingOrder_ListSaved = gi_PostingOrder + '/������ ��������';

  pi_ActiveShelVersion = 'pi_ActiveShelVersion';
  pi_ShowHelpCounter = 'pi_ShowHelpCounter';
  pi_FirstLogin = 'pi_FirstLogin';
  // �������� �� ��������� � ����� ������������:
    pi_FindDocumentContext_Strings = '����� ���������/��������/������';
    pi_FindInhparmContext_Strings = '����� ���������/������/������';
    pi_StyleTable = '������� ������';
    // �����:
    pi_ClosedGroups = 'nsAttributeSearch/ClosedGroups';
    pi_CollapsedDescriptions = 'nsAttributeSearch/CollapsedDescriptions';
    pi_ConsultationAttributes = 'nsAttributeSearch/Consultations';
    // ������������:
    pi_ConfigurationExpandedItems = 'Configuration/ExpandedItems/%s';
      {* - ����������� � ������������ ����. � �������� "%s" �������������
            ���������� ��� ������������. }
{------------------------------------------------------------------------------}
{ ������ ���������.                                                            }
{------------------------------------------------------------------------------}
  cMaxFoldersDepth = 31;
    {* - ������������ ������� ����������� �����.}
  cContextHistoryItems = 25;
    {* - ���������� ����� ����� ������� ���������, ���������� � ����������. }
  cFullLogicalSelectionSet : TLogicOperationSet = [loNone, loOr, loAnd, loNot];
  cNullDate : BaseTypesUnit.TDate = (rDay:0; rMonth:0; rYear:0);
  cNullRedactionID : LongInt = -1;
  cMax_CR_List_Count = 50;
  cBadUID = -1;
  c_DocumentSubID = 0;
  c_SmallSizeIcon = 16;
  c_LargeSizeIcon = 32;
  c_ControlBorder = 4;
  c_MaxDocumentInListLimit = 50;
  c_MaxTotalDocumentInListLimit = 10000;
  c_FlashActiveXInstallURL = 'http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash';
   // - ������ �� ��������� FlashActiveX ����������.
{------------------------------------------------------------------------------}

const
 c_InternalDocShift = 100000;

const
 cHasPassword = 'HasPassword';


implementation

end.
