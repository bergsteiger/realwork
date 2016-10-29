unit nsUtils;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�;                                                    }
{ �����      : 29.09.2005 12.42;                                               }
{ ������     : nsUtils                                                         }
{ ��������   : ����� ������� ������� �������.                                  }
{------------------------------------------------------------------------------}

// $Id: nsUtils.pas,v 1.53 2016/10/28 14:11:41 kostitsin Exp $
// $Log: nsUtils.pas,v $
// Revision 1.53  2016/10/28 14:11:41  kostitsin
// {requestlink: 631999129 }
//
// Revision 1.52  2016/09/30 06:45:28  morozov
// {RequestLink: 630816084}
//
// Revision 1.51  2016/09/14 13:01:18  kostitsin
// {requestlink: 630222434 }
//
// Revision 1.50  2016/08/03 13:13:06  lulin
// - �������������.
//
// Revision 1.49  2016/08/02 17:12:48  lulin
// - �������������.
//
// Revision 1.48  2016/07/26 12:56:07  lulin
// - �������������.
//
// Revision 1.47  2016/07/15 11:25:37  lulin
// - ���������� �����������.
//
// Revision 1.46  2016/07/14 11:31:38  morozov
// {RequestLink: 627015303}
//
// Revision 1.45  2016/04/14 12:13:34  morozov
// {RequestLink: 621277863}
//
// Revision 1.44  2015/07/30 10:11:21  kostitsin
// {requestlink: 604032841 } - ����� ����������� � ��������� ����� �� ������� "data"
//
// Revision 1.43  2015/04/16 16:51:32  lulin
// - ��������������.
//
// Revision 1.42  2015/03/18 11:42:35  morozov
// {RequestLink: 591142224}
//
// Revision 1.41  2014/11/14 11:15:42  kostitsin
// {requestlink: 573687343 }
//
// Revision 1.40  2014/11/14 10:50:16  kostitsin
// {requestlink: 573687343 }
//
// Revision 1.39  2014/10/13 11:46:14  morozov
// {RequestLink: 567553873}
//
// Revision 1.38  2014/08/01 11:47:46  morozov
// {RequestLink: 530839714} - ����������� ���� ��� ������
//
// Revision 1.37  2014/07/17 07:26:17  morozov
// {RequestLink: 340174500}
//
// Revision 1.36  2014/06/27 09:12:16  morozov
// {RequestLink: 340174500}
//
// Revision 1.35  2014/01/15 12:57:28  kostitsin
// {requestlink: 451251129}
//
// Revision 1.34  2013/10/04 06:20:46  morozov
// {RequestLink: 488611207}
//
// Revision 1.33  2013/09/23 07:33:22  morozov
// {RequestLink: 484018812}
//
// Revision 1.32  2013/09/17 09:24:19  morozov
// {RequestLink: 483399976}
//
// Revision 1.31  2013/09/12 13:34:45  morozov
// {RequestLink: 481813781}
//
// Revision 1.30  2013/09/09 11:12:46  morozov
// {RequestLink: 480833251}
//
// Revision 1.29  2013/09/09 11:08:27  morozov
// {RequestLink: 480833251}
//
// Revision 1.28  2013/04/24 09:35:56  lulin
// - ���������.
//
// Revision 1.27  2012/08/03 13:19:35  kostitsin
// [$380616604]
//  - nsUtils
//
// Revision 1.26  2012/07/26 18:34:56  lulin
// {RequestLink:378540022}
//
// Revision 1.25  2012/07/24 18:26:04  lulin
// - ������ ����.
//
// Revision 1.24  2012/03/23 17:55:05  lulin
// - ���������� ���������.
//
// Revision 1.23  2011/11/25 14:27:28  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=304875977
//
// Revision 1.22  2011/11/15 11:12:25  gensnet
// http://mdp.garant.ru/pages/viewpage.action?pageId=298419252
//
// Revision 1.21  2011/06/27 13:54:04  lulin
// {RequestLink:254944102}.
//
// Revision 1.20  2011/06/02 12:36:14  lulin
// {RequestLink:265396831}.
//
// Revision 1.19  2011/04/21 14:48:32  migel
// - spell: `Exiension` -> `Extension`.
//
// Revision 1.18  2011/04/21 12:30:55  migel
// - add: ��������� ��� ����� ����� ExternalObjects.
//
// Revision 1.17  2010/11/29 08:44:32  lulin
// {RequestLink:243698529}.
//
// Revision 1.16  2010/10/28 06:56:45  demon
// - ������� "������� �� ������" ������ ����� ��������� ����� ���������
//
// Revision 1.15  2010/10/25 08:36:46  lulin
// {RequestLink:237502802}.
// ��� �2.
//
// Revision 1.14  2010/10/04 12:32:31  oman
// - new: �������� � �� ������ {RequestLink:235057812}
//
// Revision 1.13  2010/03/22 15:44:17  lulin
// {RequestLink:198672893}.
// - �������� ��������� ������.
//
// Revision 1.12  2010/03/22 14:42:30  lulin
// {RequestLink:198672893}.
//
// Revision 1.11  2009/12/09 13:08:20  lulin
// {RequestLink:124453871}.
//
// Revision 1.10  2009/12/09 09:23:34  lulin
// - ������� �������������� �����.
//
// Revision 1.9  2009/12/08 15:27:29  lulin
// - ��������� TdeSearchInfo �� ������.
//
// Revision 1.8  2009/12/07 18:36:34  lulin
// - ��������� "���������� ������ �������" � ���������� �����.
//
// Revision 1.7  2009/11/25 10:19:37  oman
// - new: LE_TIME_MACHINE_ON {RequestLink:121157219}
//
// Revision 1.6  2009/10/15 08:33:31  oman
// - new: ������� � �������� �� ������ {RequestLink:122652464}
//
// Revision 1.5  2009/10/06 14:39:37  lulin
// {RequestLink:162596818}. ��������� ������.
//
// Revision 1.4  2009/09/29 16:34:51  lulin
// {RequestLink:159360578}. �39.
// �������� ������������� �������.
//
// Revision 1.3  2009/09/28 19:14:22  lulin
// - �������� �������� ������������ ���������.
//
// Revision 1.2  2009/09/25 17:14:51  lulin
// - ����� ������� ����������� ����� �� ������������.
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.128  2009/09/07 12:26:52  lulin
// - ������� ������� ��� �������� �������.
//
// Revision 1.127  2009/09/04 17:08:23  lulin
// {RequestLink:128288497}.
//
// Revision 1.126  2009/08/24 08:36:38  lulin
// - ��������� ��������� �������� �� ������.
//
// Revision 1.125  2009/08/05 10:09:55  oman
// - new: ������������ ��������� ������ - {RequestLink:158795570}
//
// Revision 1.124  2009/08/04 11:25:42  lulin
// [$159351827].
//
// Revision 1.123  2009/07/31 17:29:55  lulin
// - ������� �����.
//
// Revision 1.122  2009/06/03 12:28:03  oman
// - new: ������������� - [$148014435]
//
// Revision 1.121  2009/02/20 17:57:44  lulin
// - <K>: 136941122. ������ ����.
//
// Revision 1.120  2009/02/10 19:03:55  lulin
// - <K>: 133891247. �������� �������� ���������� ������.
//
// Revision 1.119  2009/02/09 19:17:25  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.118  2009/02/09 13:21:27  lulin
// - <K>: 133891247.
//
// Revision 1.117  2009/01/29 13:25:39  lulin
// - <K>: 136253229. ��������� ����������.
//
// Revision 1.116  2009/01/29 09:00:57  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=136253229&focusedCommentId=136253790#comment-136253790
//
// Revision 1.115  2009/01/21 19:18:18  lulin
// - <K>: 135602528.
//
// Revision 1.114  2009/01/19 13:12:41  lulin
// - <K>: 134316707.
//
// Revision 1.113  2009/01/11 16:09:49  lulin
// - <K>: 133138664. �14.
//
// Revision 1.112  2008/12/29 18:16:31  lulin
// - �������� ������ � �������.
//
// Revision 1.111  2008/12/29 17:23:46  lulin
// - ������ ���.
//
// Revision 1.110  2008/12/29 17:07:48  lulin
// - �������� ���.
//
// Revision 1.109  2008/12/29 16:52:38  lulin
// - ������ ����.
//
// Revision 1.108  2008/12/29 16:26:12  lulin
// - <K>: 133891773.
//
// Revision 1.107  2008/12/29 15:56:03  lulin
// - <K>: 133891773.
//
// Revision 1.106  2008/12/29 12:57:35  lulin
// - <K>: 133891773.
//
// Revision 1.105  2008/12/25 15:56:20  lulin
// - <K>: 133891729.
//
// Revision 1.104  2008/12/25 12:20:11  lulin
// - <K>: 121153186.
//
// Revision 1.103  2008/12/24 19:49:44  lulin
// - <K>: 121153186.
//
// Revision 1.102  2008/12/10 16:46:14  lulin
// - <K>: 128297578.
//
// Revision 1.101  2008/12/08 11:12:54  oman
// - fix: ��������� ����������� ���� �� ���� ������ (�-128297304)
//
// Revision 1.100  2008/12/08 09:33:21  lulin
// - <K>: 128292941.
//
// Revision 1.99  2008/12/05 14:58:09  lulin
// - ������������ ������� ������.
//
// Revision 1.98  2008/11/27 20:39:11  lulin
// - <K>: 122674167.
//
// Revision 1.97  2008/11/14 10:35:02  lulin
// - <K>: 122675356.
//
// Revision 1.96  2008/10/24 14:56:35  lulin
// - ������ ����.
//
// Revision 1.95  2008/10/01 12:22:13  oman
// - fix: ����� ��� ����������� ������� (�-120718929)
//
// Revision 1.94  2008/09/30 17:32:10  lulin
// - bug fix: �� ��������������� flash-splash.
//
// Revision 1.93  2008/09/30 12:43:22  lulin
// - <K>: 119472469.
//
// Revision 1.92  2008/09/26 08:00:51  oman
// - new: ��������� CDR � PPT (�-119473376)
//
// Revision 1.91  2008/08/21 09:32:58  mmorozov
// - new behaviour: �� �������� � FlashActiveX, ���� ���������� �������� �� ������ (<K> - 108626065);
//
// Revision 1.90  2008/08/04 12:15:04  mmorozov
// - new behaviour: ���������� ������� flash-���������� ��������� ������ ����������, � ������� ������ ������, �.�. � �������� ������ �� ��������, �� � �� �� �������������� (K<104434872>);
//
// Revision 1.89  2008/07/31 12:55:31  mmorozov
// - new: ����� �������� ��� ���������� FlashActiveX (K<104434872>).
//
// Revision 1.88  2008/07/23 11:56:01  mmorozov
// - change: ��������� �������� ��������� �� ������ (K<100958789>);
//
// Revision 1.87  2008/07/23 11:49:06  mmorozov
// - change: ��������� �������� ��������� �� ������ (K<100958789>);
//
// Revision 1.86  2008/07/23 06:16:06  mmorozov
// - new: ����� ������� (K<96484097>);
//
// Revision 1.85  2008/07/22 10:42:45  oman
// - new: ���������� ������� - ����� ����� �� (�-103940886)
//
// Revision 1.84  2008/07/22 08:47:05  mmorozov
// - new: ����������\�������� ����������-���� �� ���� ����������, ���������� � ������ ������ (K<103940108>);
//
// Revision 1.83  2008/07/22 07:34:39  oman
// - new: ��������� pdf � tiff � �������� ������� ������ (�-103940329)
//
// Revision 1.82  2008/07/18 17:15:35  mmorozov
// - bugfix:  �� ����� �������� ��� ��������� �� ������� "�� ��������"  (K<99647730>);
//
// Revision 1.81  2008/07/02 08:03:36  mmorozov
// - change: ��������� ������������ ����� ���������� (K<97354368>).
//
// Revision 1.80  2008/06/23 12:28:41  mmorozov
// - ������ ��� ����������-������... ��������� ������ �� ����� (CQ: OIT5-29377).
//
// Revision 1.79  2008/06/19 13:06:46  mmorozov
// - ������ ��������.
//
// Revision 1.78  2008/05/14 11:37:47  mmorozov
// - bugfix: ��� �������� � ������ �� ��������� �� ��������� ���������� �������.
//
// Revision 1.77  2008/05/08 06:27:58  mmorozov
// - ���������� ���������� ��������;
//
// Revision 1.76  2008/05/08 04:58:28  mmorozov
// - rename: QueryInfo -> SearchInfo;
//
// Revision 1.75  2008/05/05 12:05:55  mmorozov
// - new: ����� ��������� � ����������� �������� ������ ����� ������ � ������� ������� �������� ��������� "������\����" (CQ: OIT5-9285, 9656).
//
// Revision 1.74  2008/04/21 10:53:49  mmorozov
// - new: ��� ���������� ��������� ���� ���������� ������������ �������� ��� ���� ������� ��� ���������: ��������� | ���������.
//
// Revision 1.73  2008/04/14 12:20:21  mmorozov
// - ������ � ����� ����������� �� ������;
//
// Revision 1.72  2008/04/02 11:43:07  mmorozov
// - ����� ����� ���������������� ������ (������� ����� ������);
//
// Revision 1.71  2008/03/25 10:56:20  oman
// Cleanup - ��������� ��� HyperlinkManager
//
// Revision 1.70  2008/02/19 11:09:25  mmorozov
// - format code;
//
// Revision 1.69  2008/01/30 08:24:58  mmorozov
// - new: ���������� ���������� ������������� ��� ����������� �� �������� ��� 6.� (CQ: OIT5-28303);
//
// Revision 1.68  2008/01/17 06:45:19  mmorozov
// - new: �������� ��������� �� ����������� �� ��������� ���������;
//
// Revision 1.67  2008/01/10 07:23:30  oman
// ������� �� ����� �������
//
// Revision 1.66  2007/12/26 07:57:48  mmorozov
// - new: ������ ������ ���������� ���������� � ���� ���������� + ����������� ���, ���� ��� ��������� (� ������ CQ: OIT5-27823);
//
// Revision 1.65  2007/12/25 11:32:10  mmorozov
// - new: �������� �� ���������� ������ ���������� (CQ: OIT5-27823);
//
// Revision 1.64  2007/12/17 12:22:31  mmorozov
// - ����������� � ������ ��������������, � ����� ��������� ���������������� �������� + ����������� �� �������� enSystem.opConfigUpdated (� ������ CQ: OIT5-27823);
//
// Revision 1.63  2007/12/10 12:51:10  mmorozov
// - new: ��������� ������ publisher\subscriber ��� �������������� ��������, ������ �������� (������������ ������������), ��������� ������� ������������ (� ������ CQ: OIT5-27823);
//
// Revision 1.62.2.3  2007/11/27 07:21:50  oman
// ������������ �� ����� ������� - ������������
//
// Revision 1.62.2.2  2007/11/23 10:15:37  oman
// ������������ �� ����� �������
//
// Revision 1.62.2.1  2007/11/16 14:03:50  oman
// ������������ �� ����� �������
//
// Revision 1.63  2007/12/10 12:51:10  mmorozov
// - new: ��������� ������ publisher\subscriber ��� �������������� ��������, ������ �������� (������������ ������������), ��������� ������� ������������ (� ������ CQ: OIT5-27823);
//
// Revision 1.64  2007/12/17 12:22:31  mmorozov
// - ����������� � ������ ��������������, � ����� ��������� ���������������� �������� + ����������� �� �������� enSystem.opConfigUpdated (� ������ CQ: OIT5-27823);
//
// Revision 1.62  2007/10/20 14:11:39  mmorozov
// - ����������� ������ � �������������� ���� ����������� ��� ���������� ������ ��������� bs_csPaymentRefusalOldFormat;
// - ����� ��������� (� ����������) IdeConsultation, �� ���� �������� ����������� _IbsConsultation;
// - cleanup;
//
// Revision 1.61  2007/10/03 12:49:20  mmorozov
// - new: ��������� �������� ������ ������� �� ���� ������� ���� + ��� ���������� � �������� ����� �������� ������ ����������� �������� �������� ������ ������� � ���� �������� ������� �������� + ������������ ����������� (� ������ CQ: OIT5-26843; K<56295615>);
//
// Revision 1.60  2007/09/28 07:03:07  mmorozov
// - ��������� ����������� _StdRes � _nsSaveDialog;
// - ��������� ��������� ����� ����� ��� �������� ���������� � ��������� ������ + ������������� ����������� (� ������ ������ ��� CQ: OIT5-26809);
//
// Revision 1.59  2007/08/15 16:16:31  mmorozov
// - change: ��������� ����������� �� ������ bsConsultation;
//
// Revision 1.58  2007/08/14 07:32:32  mmorozov
// - new: ��������� ������ � ��������� ������������ (CQ: OIT5-25868);
//
// Revision 1.57  2007/07/26 12:27:48  oman
// - fix: ������� ��� ����������� vtHeader (cq24480)
//
// Revision 1.56  2007/07/19 13:24:06  mmorozov
// - add comment;
//
// Revision 1.55  2007/07/17 13:26:44  mmorozov
// - new: �������� ���������� ����������� ������� (� ������ CQ: OIT5-25852);
//
// Revision 1.54  2007/06/29 07:58:26  mmorozov
// - new: ����� ������� ������������ "����� �������, �� ��� ��������� �� ������������ � �������� ������", "����� ��������, �� ��� ��������� �� ������������ � �������� ������" (CQ: OIT5-25338);
//
// Revision 1.53  2007/05/17 12:04:16  oman
// cleanup
//
// Revision 1.52  2007/04/17 12:27:39  lulin
// - ���������� ������� �������������� ������ � ���������� � ����� �����.
//
// Revision 1.51  2007/04/05 13:42:47  lulin
// - ����������� �� ������ �������������� �����.
//
// Revision 1.50  2007/03/20 11:38:18  lulin
// - �� ������ ��������� ��� ������������ ���������� ���� � ���������.
//
// Revision 1.49  2007/03/16 16:57:11  lulin
// - ����������� �� ��������� ����������� � �������������� �����.
//
// Revision 1.48  2007/03/16 09:56:43  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.47  2007/03/05 13:47:21  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.46  2007/02/27 09:17:55  lulin
// - ���������� ����� ������� ���� ��� ������ � �������.
//
// Revision 1.45  2007/02/27 08:07:08  lulin
// - cleanup.
//
// Revision 1.44  2007/02/16 19:19:20  lulin
// - � ���������� ������� ���������� ������ ������ �����.
//
// Revision 1.43  2007/02/13 14:33:26  lulin
// - cleanup.
//
// Revision 1.42  2007/02/07 17:48:45  lulin
// - ����������� �� ����������� ����� ��� ������ �� ��������.
//
// Revision 1.41  2007/02/07 15:14:19  mmorozov
// - change: TbsListAdditionalDataSource -> _TbsListSynchroForm;
//
// Revision 1.40  2007/02/07 14:47:33  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.39  2007/02/07 09:15:59  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.38  2007/02/06 09:03:05  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.37  2007/01/15 18:15:47  lulin
// - ������� ������������� ������� ����������.
//
// Revision 1.36  2007/01/05 16:16:17  lulin
// - cleanup.
//
// Revision 1.35  2006/12/04 08:14:54  mmorozov
// - rename: some Il3LocaleInfo properties;
//
// Revision 1.34  2006/12/01 15:20:37  mmorozov
// - new: ���������� � ������ �������� � ��������� ���������;
//
// Revision 1.33  2006/11/28 15:35:26  mmorozov
// - ����������� ������������� ����� ���������� IafwApplication.LocateId: LCID;
// - �������������� �������� LocateId ������������� � DetailedLanguageId;
// - ����� ������ ���������� ������������� ����� ���������� ��������� ��� �� ������������;
// - ��������� ������������� ������ ���������� �� ������� ����������;
// - ��� ����������� ����� ���������� ���������� ������������� �������������� � afwInterfaces;
//
// Revision 1.32  2006/11/09 11:10:52  migel
// - fix: ������ `SHGetFolderPath` ���������� `SHGetSpecialFolderLocation` ��� ����� ������ ������������� ����� ������� �������� Windows (CQ: 23536).
//
// Revision 1.31  2006/11/03 09:46:00  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.30.2.2  2006/10/25 07:29:50  oman
// ���������� ���������� �� StdStr
//
// Revision 1.30.2.1  2006/10/13 11:07:46  mmorozov
// - bugfix: ����� ���������� ������ � ����� ������������� ����������  ��������� ���� (CQ: OIT5-18745);
//
// Revision 1.30  2006/09/06 10:44:22  civ
// fix: ������������� ���������
//
// Revision 1.29  2006/07/25 09:39:26  mmorozov
// - change: ��� ��������� ������������� ���� ������� ���������� ������� ������ ������� (�������� ����� �������� ���� �������);
//
// Revision 1.28  2006/07/12 15:03:10  oman
// - new beh: ������������ ��������� ��� ��������� ����� ������ ������� (cq21699)
//
// Revision 1.27  2006/07/07 15:23:29  mmorozov
// - new: � ������ � ������������ ��������� ������ (CQ: OIT500021512);
//
// Revision 1.26  2006/06/30 14:59:11  mmorozov
// - new: ��������� �������� "���������� � ������������" ���������� �� ���������� shortcut-�. �������� ��������� �������� ������ ����������� ��� ���������� � ������������;
// - change: ������� ��� �� ������ � mailto (���������� � nsUtils);
// - change: ������������� ������� ������ bsConvert;
//
// Revision 1.25  2006/06/29 11:56:09  mmorozov
// - change: ��������� � ����� � ��������� ���� GblAdapter.TDateTime;
//
// Revision 1.24  2006/06/07 10:32:23  mmorozov
// - bugfix: ��� ��������� �������� ������ � Word ����� ��������� ������, �������� ������ � ����, ������� ������ Word. ����� ���� ��� �������� ����������� ��� �����, ������ ������ ��� ����������,  ������ � ��������� � ��������������� ����������� (CQ: OIT500021216);
//
// Revision 1.23  2006/05/30 15:19:27  dinishev
// Remove procedure nsMakeImageListWrapper
//
// Revision 1.22  2006/05/25 10:41:45  oman
// - new beh: ��������� Il3ImageList ��� ProxyIngList
//
// Revision 1.21  2006/05/25 10:14:59  oman
// - fix: ������������
//
// Revision 1.20  2006/05/25 06:39:52  oman
// - fix: ������ ����������� l3 �� vt. ����� ������� nsMakeImageListWrapper
// ��� ��������� ���������� ���������� Il3ImageList
//
// Revision 1.19  2006/05/23 10:39:41  mmorozov
// - new behaviour: ��� ������ ������ ���� "��� ������������" ������������ ���� �� ����� ����������;
//
// Revision 1.18  2006/05/23 07:31:58  mmorozov
// - change: ���������� � ��������� ����� ������������� ������������, ��������� ������� ��������;
//
// Revision 1.17  2006/05/12 07:14:44  mmorozov
// - ��������� ������������ �� ����� ���������� CVS;
//
// Revision 1.16  2006/05/05 14:55:00  mmorozov
// - change: ������� ��� �������� ������� ������ �� ���������������� �� ���� � ������ (���������� ����� ��� �������� ���� ������������);
//
// Revision 1.15  2006/04/18 08:53:43  mmorozov
// - new: ������ ������������;
// - new: �������� ������ (bsHyperlinkManager);
// - warnings fix;
//
// Revision 1.14  2006/04/18 08:22:02  oman
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.13  2006/04/17 12:09:01  oman
// - change: ��������� ������-������� (���� ������) �� ������������
//  ����������� (�����, imageindex)
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.12  2006/04/17 11:46:58  mmorozov
// - �� ����������;
//
// Revision 1.11  2006/04/14 15:01:03  mmorozov
// - new: ����� ������ ��� ���������� ������������;
// - change: ������� ��� � ���� (��� ������ ���� �������) � � ������ ��������, ������� ���������� � ��������;
//
// Revision 1.10  2006/04/11 14:12:41  mmorozov
// - change: ������� ��� � �����;
// - bugfix: ��� ���������� ����� �� ���������� ������������� ��� ���� ����� ���� ��� ����������� (CQ: 20383);
//
// Revision 1.9  2006/04/11 12:07:04  mmorozov
// - ��������� ������� ���������� ���������� � nsUtils;
//
// Revision 1.8  2006/03/22 08:16:48  oman
// - new beh: ����� �������������� ���� � ����� �����
//
// Revision 1.7  2006/03/20 09:47:53  mmorozov
// - new: ������� ���� � ������� ������� � ������������ � ������� ������� (CQ: OIT500020043);
//
// Revision 1.6  2006/03/10 12:03:08  mmorozov
// - new: ��� ���������� ������ � xml ������������ ������������ ��� �������� "���� ������", "���������� ���������";
// - new: � �������� ���� �� ��������� ������������ ����� "��� ���������";
//
// Revision 1.5  2005/12/02 13:27:02  mmorozov
// - bugfix: ���������� ������� ��������� ����������� ������ �������  (cq: 00018418);
//
// Revision 1.4  2005/11/14 15:29:01  mmorozov
// - cleanup: �������� ���� ������ - "��������� �� �����������", "�����������", "����� ������";
// - new: ��������� ����������� ������ �������� ������ �� ������� ������;
//
// Revision 1.3  2005/09/30 14:07:38  mmorozov
// - �������� ������������;
//
// Revision 1.2  2005/09/30 07:58:41  mmorozov
// change: ����� ����� ������� �� ������;
//
// Revision 1.1  2005/09/29 10:12:39  mmorozov
// new: �������� ��������� � �����/������� ����;
//

{$Include nsDefine.inc}

interface

uses
  Dialogs,
  Classes,
  Controls,
  ImgList,
  SysUtils,
  ExtCtrls,
  Graphics,

  l3Interfaces,
  l3TreeInterfaces,
  l3InternalInterfaces,

  afwInterfaces,

  eeInterfaces,
  eeTreeView,

  vtSaveDialog,
  vtHeader,
  vtPngImgList,
  //vtShockwaveEx,

  vcmInterfaces,

  BaseTypesUnit,
  DocumentUnit,
  DynamicDocListUnit,
{$If not Defined(Admin) AND not Defined(Monitorings) }
  FiltersUnit,
{$IfEnd}

  bsTypes,

  nsTypes,

  StdRes,

  bsInterfaces,
  SearchInterfaces,

  FoldersDomainInterfaces
  ;

{------------------------------------------------------------------------------}
{ ��� ���������.                                                               }
{------------------------------------------------------------------------------}
{$If not Defined(Admin) AND not Defined(Monitorings) }
function nsListTypeToFilterFor(aType: TbsListType): TnsFolderFilterFor;
  {-}
{$IfEnd}
{------------------------------------------------------------------------------}
{ ������������                                                                 }
{------------------------------------------------------------------------------}
procedure nsWriteLetterAboutConsultation(const aNode: Il3SimpleNode);
  {* - ��������� ������ � �������� ��������� �� ���������.
       aNode - ���� � ������. }
{------------------------------------------------------------------------------}
{ �����                                                                        }
{------------------------------------------------------------------------------}
function nsDeleteFileNameDots(const aFileName: Il3CString): Il3CString;
  {* - ������� ���������� � ����� �����. }
{------------------------------------------------------------------------------}
{ ������                                                                       }
{------------------------------------------------------------------------------}
procedure nsSelectAndExpand(const aTreeView: TeeTreeView;
                            const aNode    : IeeNode;
                            const aAll     : Boolean = False);
  {-}
{$If not (defined(Monitorings) or defined(Admin))}
procedure nsTimeMachineOn(const aDocument : IDocument;
                          const aDate     : BaseTypesUnit.TDate);
  {* - �������� ������ �������. }
{$IfEnd}
{------------------------------------------------------------------------------}
{ ��������                                                                     }
{------------------------------------------------------------------------------}
{$If not (defined(Monitorings) or defined(Admin))}
procedure nsSaveExternalObject(const aObject : IUnknown;
                               const aType   : TLinkedObjectType);
  {* - ��������� �������� �� ������� ����. }
{$IfEnd}
procedure nsParseDocumentNumber(const aNumber    : Il3CString;
                                var aDocId       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType);
  overload;
procedure nsParseDocumentNumber(const aNumber    : Il3CString;
                                var aDocID       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType;
                                var aNumberWrong : Boolean);
  overload;
  {* - ������ � ���������� ��������� � ������������� ��������� � �����
       ���������. }
procedure nsParseDocumentNumber(const aNumber    : String;
                                var aDocId       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType;
                                var aNumberWrong : Boolean);
  overload;
  {* - ������ � ���������� ��������� � ������������� ��������� � �����
       ���������. }

{$If not Defined(Admin) AND not Defined(Monitorings)}
function nsOpenDocumentByNumber(aDocId: Integer;
                                out aDocument: IDocument;
                                aFaultMessage: Boolean = True): Boolean;
  overload;
  {* - ������� �������� �� ������. }
function nsOpenDocumentByNumber(aDocId: Integer;
                                 aPosID: Integer;
                                 aPosType: TDocumentPositionType;
                                 aFaultMessage: Boolean = True;
                                 aIgnoreRefDoc: Boolean = False;
                                 aOpenKind: TvcmMainFormOpenKind = vcm_okInCurrentTab;
                                 aShowFaultMessageOnInvalidRef: Boolean = False): Boolean;
  overload;
  {* - ������� �������� �� ������. }
function nsOpenDocumentByNumber(const aDocPosition: String;
                                anInternalID: Boolean = True;
                                aFaultMessage: Boolean = True): Boolean;
  overload;
  {* - ������� �������� �� ������. }
function nsOpenLink(const aDocPosition: String;
                          aInternalID: Boolean;
                          aShowMainMenu: Boolean = False;
                          aFaultMessage: Boolean = True): Boolean;
  overload;
  {* - ������� ������. }
function nsOpenLink(aDocId: Integer;
                    aPosID: Integer;
                    aPosType: TDocumentPositionType;
                    aInternalID: Boolean = True;
                    aShowMainMenu: Boolean = False;
                    aFaultMessage: Boolean = True): Boolean; overload;
  {* - ������� ������. }
function nsNeedShellToOpenDocument(const aDocPosition: String;
                                  anInternalID: Boolean;
                                  out aWrongID: Boolean): Boolean;
{$IfEnd}
{------------------------------------------------------------------------------}
{ ������                                                                       }
{------------------------------------------------------------------------------}
procedure nsSetCurrentFirstSelected(const aTree : TeeTreeView;
                                    const aNode : Il3SimpleNode);
  {* - ������� ������� ������ ���������� �������. }
function nsGetFirstSelectedChild(const aParent: Il3SimpleNode) : Il3SimpleNode;
  {* - �������� ������� ���������� �������. }
{------------------------------------------------------------------------------}
{ �����                                                                        }
{------------------------------------------------------------------------------}
procedure nsPaintImage(aImageList : TvtNonFixedPngImageList;
                       aPaintBox  : TPaintBox;
                       anIndex    : Integer = 0;
                       aEraseBackGround: Boolean = False);
  {* - ������� ������ �� ������. }
function nsNewWindow(const aMainForm : IvcmContainer;
                           aOpenKind : TvcmMainFormOpenKind = vcm_okInNewWindow;
                           aNeedSwitchTab: Boolean = True): IvcmContainer;

  {* - ������� ����� ����. }
{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenList(const aDynList           : IDynList;
                     const aMainForm          : IvcmContainer;
                     const aWhatDoingIfOneDoc : TbsWhatDoingIfOneDoc = wdOpenIfUserDefine;
                     const aTimeMachineOff    : Boolean = True;
                     const aOpenFrom          : TbsListOpenFrom = lofNone);
  {* - ��������� ������. }
{$IfEnd}
{$If not (defined(Monitorings) or defined(Admin))}
function nsMyDocumentFolder(const aFileName  : Il3CString;
                            const aExtension : String = '';
                            const aCreate    : Boolean = True): Il3CString;
  {* - ���������� ��������� ����� "��� ���������" ��� �������� ������������. }
{$IfEnd}  
function nsDateToStr(const aDate: System.TDateTime): String;
  {-}
function nsConvertAnnoKind(const aValue: Il3CString): Il3CString;
  {-}
function nsPrepareTextForMailto(const aText: Il3CString): Il3CString;
  {* - ������������ ������� ������ ��� �������� ������ � �������� ���������. }
function StringToOrientation(const aString : Il3CString): Integer;
  {-}
{------------------------------------------------------------------------------}
{ �����������                                                                  }
{------------------------------------------------------------------------------}
function nsGetListHeaderLocalizationInfo(const aHeader: TvtCustomHeader): String;
  {-}
procedure nsSetListHeaderLocalizationInfo(const aHeader: TvtCustomHeader; const anInfo: String);
  {-}
{$IfDef InsiderTest}
var
 g_WasBeep : Boolean = false;
{$EndIf InsiderTest}
procedure nsBeepWrongContext;
  {-}
{------------------------------------------------------------------------------}
{$If not Defined(Admin) AND not Defined(Monitorings)}
function nsGetFilterCaption(const aFilter : IFilterFromQuery) : Il3CString;
{$IfEnd}

const
 cPosDelimiter = '.';
 cParaPrefix = '#';

implementation

uses
  Windows,
  StrUtils,

  ActiveX,
  ComObj,
  ShlObj,
  ShFolder,

  l3Base,
  l3ImageList,
  l3String,
  l3Chars,

  vtImageListWrapper,

  afwFacade,

  vcmBase,
  vcmExternalInterfaces,
  {$If not (defined(Monitorings) or defined(Admin))}
  vcmTabbedContainerFormDispatcher,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

  bsUtils,
  {$If not (defined(Monitorings) or defined(Admin))}
  bsConsultation,
  nsLogEvent,
  LoggingUnit,
  IOUnit,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

  {$If not (defined(Monitorings) or defined(Admin))}
  nsExternalObject,
  nsExternalObjectPrim,
  {$IfEnd}
  nsLogicOperationToFlags,
  nsTreeAttributeNodesNew,
  nsConst,
  nsFolderFilterInfo,
  nsOpenUtils,
  DataAdapter,

  DynamicTreeUnit,
  ExternalObjectUnit,

  DebugStr,
  SystemStr,
  {$If not (defined(Monitorings) or defined(Admin))}
  ConsultationInterfaces,
  ConsultationDomainInterfaces,
  deDocInfo,
  deListSet,
  deList,

  evdTypes,
  nsInternetUtils,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}

  SearchDomainInterfaces,
  PrimPrimListInterfaces,
  deSearchInfo,

  bsTypesNew,
  bsDocumentMissingMessage,
  LoggingWrapperInterfaces,
  l3SimpleObject,
  nsLogManager,
  nsLogEventData,
  Base_Operations_F1Services_Contracts
  {$If not (defined(Monitorings) or defined(Admin))}
  ,
  nsTryingToOpenMissingDocumentFromLinkEvent,
  bsConvert
  {$IfEnd not (defined(Monitorings) or defined(Admin))}
  ;


{$If not (defined(Monitorings) or defined(Admin))}
type
 TnsTimeMachineOnEvent = class(TnsLogEvent)
 public
 // public methods
   class procedure Log(const aDoc: IDocument; const aDate: BaseTypesUnit.TDate);
 end;//TnsTimeMachineOnEvent
{$IfEnd not (defined(Monitorings) or defined(Admin))}

procedure nsPaintImage(aImageList : TvtNonFixedPngImageList;
                       aPaintBox  : TPaintBox;
                       anIndex    : Integer = 0;
                       aEraseBackGround: Boolean = False);
  {* - ������� ������ �� ������. }

  function lp_CalcOffset(const aParent, aChild: Integer): Integer;
  begin
   Result := 0;
   if aChild < aParent then
    Result := (aParent - aChild) div 2;
  end;//function lp_CalcOffsetY: Integer;

begin
 if aEraseBackGround then
 begin
  aPaintBox.Canvas.Brush.Color := clWindow;
  aPaintBox.Canvas.Pen.Style := psClear;
  aPaintBox.Canvas.Rectangle(aPaintBox.Canvas.ClipRect);
 end;
 with aImageList do
  Draw(aPaintBox.Canvas,
       lp_CalcOffset(aPaintBox.Width, Width),
       lp_CalcOffset(aPaintBox.Height, Height),
       anIndex);
end;

{$If not Defined(Admin) AND not Defined(Monitorings) }
function nsListTypeToFilterFor(aType: TbsListType): TnsFolderFilterFor;
begin
 case aType of
  bs_ltDocument:
   Result := ns_ffDocument;
  bs_ltDrug:
   Result := ns_ffDrug;
  else
  begin
   Result := Low(TnsFolderFilterFor);
   Assert(False);
  end;
 end;
end;
{$IfEnd}

{$If not (defined(Monitorings) or defined(Admin))}
function nsOpenDocumentByNumberInternal(aDocId: Integer;
                                out aDocument: IDocument;
                                out aMissingInfo: IMissingInfo;
                                aFaultMessage: Boolean = True): Boolean;
  forward;
{$IfEnd not (defined(Monitorings) or defined(Admin))}

{ ������������ }

procedure nsWriteLetterAboutConsultation(const aNode: Il3SimpleNode);
  {* - aNode - ���� � ������. }

 { �������� �������� ������������� ���� }

 {$If not (defined(Monitorings) or defined(Admin))}
 function nsTypeToDisplayName(const aValue: TbsConsultationStatuses): Il3CString;
   {* - ������ ������������. }

   procedure lp_AddStatus(const aStr: Il3CString);
   begin
    if l3IsNil(Result) then
     Result := aStr
    else
     Result := l3Cat([Result, l3Cat(', ', aStr)]);
   end;

 begin
  // ����������:
  if bs_csSent in aValue then
   lp_AddStatus(vcmCStr(str_csProcessing));
  // ������� ��������������� �����:
  if bs_csPaymentRequest in aValue then
   lp_AddStatus(vcmCStr(str_csNotificationReceived));
  // ������� �����:
  if bs_csAnswerReceived in aValue then
   lp_AddStatus(vcmCStr(str_csAnswerReceived));
  // ����� �������, �� ��� ��������� �� ������������ � �������� ������:
  if bs_csAnswerNotConfirm in aValue then
   lp_AddStatus(vcmCStr(str_csAnswerReceivedAndNotConfirm));
  // ����� ��������, �� ��� ��������� �� ������������ � �������� ������:
  if bs_csReadNotConfirm in aValue then
   lp_AddStatus(vcmCStr(str_csReadAndNotConfirm));
  // ���������:
  if bs_csRead in aValue then
   lp_AddStatus(vcmCStr(str_csRead));
  // ���������� ������:
  if bs_csEstimationSent in aValue then
   lp_AddStatus(vcmCStr(str_csEstimationWasSent));
  // ���� ��������:
  if bs_csDrafts in aValue then
   lp_AddStatus(vcmCStr(str_csDraft));
  // �� ����������:
  if [bs_csPaymentRefusal, bs_csPaymentRefusalOldFormat] * aValue <> [] then
   lp_AddStatus(vcmCStr(str_csNotSent));
  // ������������:
  if bs_csPaymentConfirm in aValue then
   lp_AddStatus(vcmCStr(str_csPaymentConfirm));
 end;//nsTypeToDisplayName
 {$IfEnd not (defined(Monitorings) or defined(Admin))}

{$If not (defined(Monitorings) or defined(Admin))}
var
 l_Consultation : IbsConsultation;
 l_Mailto       : Il3CString;
begin
 l_Consultation := TbsConsultation.Make(bsGetConsultation(aNode));
 try
  with l_Consultation do
   if (Data <> nil) and not WasDeleted then
   begin
    l_Mailto := nsPrepareTextForMailto(
    vcmFmt(str_strMailtoAboutConsultationProblem,
           [Caption,
            nsTypeToDisplayName(Status),
            Id,
            FormatDateTime('dd/mm/yyyy', WasCreated),
            FormatDateTime('dd/mm/yyyy', WasModified)]));
    nsDoShellExecute(l_Mailto);
   end;//if (Data <> nil) and not WasDeleted then
 finally
  l_Consultation := nil;
 end;//try..finally
{$Else not (defined(Monitorings) or defined(Admin))}
begin
{$IfEnd not (defined(Monitorings) or defined(Admin))}
end;

{ ���� }

function nsDeleteFileNameDots(const aFileName: Il3CString): Il3CString;
  {* - ������� ���������� � ����� �����. }
begin
 Result := l3RTrim(aFileName, ['.']);
 // ������ ����� � ����� ����� ����������� ����� �������� ������ ����������
 // �����, �� ����� ���������� ������������� ��� ���������� �����:
end;

{ ������ }

{$If not (defined(Monitorings) or defined(Admin))}
procedure nsTimeMachineOn(const aDocument : IDocument;
                          const aDate     : BaseTypesUnit.TDate);
  {* - �������� ������ �������. }
begin
 TnsTimeMachineOnEvent.Log(aDocument, aDate);
 defDataAdapter.TimeMachine.Date := aDate;
end;//nsTimeMachineOn
{$IfEnd}

procedure nsSelectAndExpand(const aTreeView : TeeTreeView;
                            const aNode     : IeeNode;
                            const aAll      : Boolean = False);
  {-}
begin
 with aTreeView.TreeView do
  if (GoToNode(aNode) > 0) then
  begin
   // ���������� ���:
   if aAll then
    Tree.ExpandSubDir(aNode, True, 2)
   // ������ ������ �������:
   else
    Tree.ChangeExpand(aNode, ee_sbSelect);
   aTreeView.DisableAlignTopIndex := True;
   //aTreeView.TopIndex := l_Index;
  end;//with aTreeView.TreeView do
end;//nsSelectAndExpand

{ �������� }

{$If not Defined(Admin) AND not Defined(Monitorings)}
function nsOpenDocumentByNumberInternal(aDocId: Integer;
                                        out aDocument: IDocument;
                                        out aMissingInfo: IMissingInfo; 
                                        aFaultMessage: Boolean = True): Boolean;
  {* - ������� �������� �� ������. }
begin
 // http://mdp.garant.ru/pages/viewpage.action?pageId=304875977
 try
  aDocument := nil;
  Result := DefDataAdapter.CommonInterfaces.
   GetDocumentOnNumber(aDocId, aDocument, aMissingInfo);
  if (not Result) and aFaultMessage then
    TbsDocumentMissingMessage.Show(False, aMissingInfo);
 except
  on ECanNotFindData do
   Result := false;
 end;{try..except}
end;

function nsOpenDocumentByNumber(aDocId: Integer;
                                out aDocument: IDocument;
                                aFaultMessage: Boolean = True): Boolean;
  //overload;
  {* - ������� �������� �� ������. }
var
 l_MI: IMissingInfo;
begin
 Result := nsOpenDocumentByNumberInternal(aDocId, aDocument, l_MI, aFaultMessage);
 if not Result then
 begin
  TnsTryingToOpenMissingDocumentFromLinkEvent.Log(aDocID);
  if aFaultMessage then
   TbsDocumentMissingMessage.Show(False, l_MI);
 end;
end;

function  nsOpenDocumentByNumber(aDocId: Integer;
                                 aPosID: Integer;
                                 aPosType: TDocumentPositionType;
                                 aFaultMessage: Boolean = True;
                                 aIgnoreRefDoc: Boolean = False;
                                 aOpenKind: TvcmMainFormOpenKind = vcm_okInCurrentTab;
                                 aShowFaultMessageOnInvalidRef: Boolean = False): Boolean; overload;
  // overload;
  {* - ������� �������� �� ������. }
var
 l_Document : IDocument;
 l_Container: IvcmContainer;
 l_ContainerMaker: IvcmContainerMaker;
 l_Topic: TTopic;
 l_MI: IMissingInfo;
begin
 Result := nsOpenDocumentByNumberInternal(aDocId, l_Document, l_MI, False);

 if (not Result) then
 begin
  l3FillChar(l_Topic, SizeOf(l_Topic), 0);

  l_Topic.rPid.rObjectId := aDocID;
  l_Topic.rPid.rClassId := CI_TOPIC;
  l_Topic.rPosition.rPoint := aPosID;
  l_Topic.rPosition.rType := bsBusinessToAdapter(aPosType);

  TnsTryingToOpenMissingDocumentFromLinkEvent.Log(l_Topic);
  if aShowFaultMessageOnInvalidRef then
   TbsDocumentMissingMessage.Show(False, l_MI);
 end;

 if Result and ((l_Document.GetDocType = DT_REF) and (not aIgnoreRefDoc)) then
 begin
  Result := False;
  if aShowFaultMessageOnInvalidRef then
   TbsDocumentMissingMessage.Show;
  Exit;
 end;
 if Result then
 begin
  l_Container := nil;
  if TvcmTabbedContainerFormDispatcher.Instance.NeedUseTabs AND
   Supports(vcmDispatcher.FormDispatcher.CurrentMainForm.VCLWinControl,
   IvcmContainerMaker, l_ContainerMaker) then
  try
   l_Container := TvcmTabbedContainerFormDispatcher.Instance.MakeAndPlaceVCMContainer(l_ContainerMaker,
    vcmDispatcher.FormDispatcher.CurrentMainForm.AsContainer, aOpenKind, True);
  finally
   l_ContainerMaker := nil;
  end;
  TDocumentService.Instance.OpenDocument(TdeDocInfo.Make(l_Document, TbsDocPos_C(aPosType, Longword(aPosID))), l_Container);
 end;
end;

function nsOpenDocumentByNumber(const aDocPosition: String;
                                anInternalID: Boolean = True;
                                aFaultMessage: Boolean = True): Boolean;
  //overload;
  {* - ������� �������� �� ������. }
var
 l_DocId       : Integer;
 l_PosID       : Integer;
 l_PosType     : TDocumentPositionType;
 l_NumberWrong : Boolean;
begin
 Result := False;
 nsParseDocumentNumber(aDocPosition, l_DocId, l_PosID, l_PosType, l_NumberWrong);
 if not l_NumberWrong then
 begin
  if anInternalID then
   l_DocId := l_DocId + c_InternalDocShift;
  Result := nsOpenDocumentByNumber(l_DocId, l_PosID, l_PosType, aFaultMessage, False);
 end;
end;

function nsGetExternalLink(aDocId        : Integer;
                           aPosID        : Integer;
                           aPosType      : TDocumentPositionType;
                           aInternalId   : Boolean;
                           aFaultMessage : Boolean = False): IExternalLink;
var
 l_DocId : Integer;
 l_Document: IDocument;
 l_Link: IExternalLink;
 l_Topic: TTopic;
 l_ObjType      : TLinkedObjectType;
 l_Obj          : IUnknown;
 l_MI: IMissingInfo;
begin
 Result := nil;
 l_Link := nil;
 l_DocId := aDocId;
 if aInternalId then
  l_DocId := l_DocId + c_InternalDocShift;
 if nsOpenDocumentByNumberInternal(l_DocId, l_Document, l_MI, aFaultMessage) then
 try
  if (l_Document.GetDocType <> DT_REF) then
   Exit;
  l3FillChar(l_Topic, SizeOf(l_Topic), 0);
  with l_Topic do
  begin
   rPid.rObjectId := BaseTypesUnit.TObjectId(l_DocId);
   rPid.rClassId := CI_REF;
   rPosition.rPoint := aPosID;
   rPosition.rType := PT_SUB;
  end;//with l_Topic
  try
   l_Document.GetLinkedObject(l_DocId, l_Topic, 0, l_ObjType, l_Obj);
  except
   on EInvalidTopicID do
   begin
    Result := nil;
    Exit;
   end//on EInvalidTopicID
   else
    Assert(False);
  end;//try..except
  if (l_ObjType = LO_EXTERNAL_LINK) and Supports(l_Obj, IExternalLink, l_Link) then
   Result := l_Link;
 finally
  l_Obj := nil;
  l_Document := nil;
  l_Link := nil;
 end;//try..finally
end;//nsGetExternalLink

function nsOpenLink(const aDocPosition: String;
                          aInternalID: Boolean;
                          aShowMainMenu: Boolean = False;
                          aFaultMessage: Boolean = True): Boolean;
  {* - ������� ������. }
var
 l_DocId       : Integer;
 l_PosID       : Integer;
 l_PosType     : TDocumentPositionType;
 l_NumberWrong : Boolean;
begin
 Result := False;
 nsParseDocumentNumber(aDocPosition, l_DocId, l_PosID, l_PosType, l_NumberWrong);
 if not l_NumberWrong then
  Result := nsOpenLink(l_DocId, l_PosID, l_PosType, aInternalID, aShowMainMenu,
   aFaultMessage);
end;

function nsOpenLink(aDocId: Integer;
                    aPosID: Integer;
                    aPosType: TDocumentPositionType;
                    aInternalId: Boolean = True;
                    aShowMainMenu: Boolean = False;
                    aFaultMessage: Boolean = True): Boolean;
  {* - ������� ������. }
const
 cPrefixDelimiter = ':';
 cScriptPrefix = 'script';
 cEnoPrefix = 'eno';
var
 l_ExternalLink : IExternalLink;
 l_Url          : IString;
 l_UrlStr       : Il3CString;
 l_UrlWStr      : WideString;
 l_P            : Il3CString;
 l_S            : Il3CString;
begin
 l_ExternalLink := nsGetExternalLink(aDocId, aPosId, aPosType, aInternalId,
  aFaultMessage);
 if (l_ExternalLink <> nil) then
 try
  l_ExternalLink.GetUrl(l_Url);
  l_UrlStr := nsCStr(l_Url);
  if l3IsNil(l_UrlStr) then
   Result := false
  else
  begin
   l3Split(l_UrlStr, cPrefixDelimiter, l_P, l_S);
   Result := (not l3Same(l_P, cScriptPrefix)) AND (not l3Same(l_P, cEnoPrefix)) AND (not l3IsNil(l_S));
   l_UrlWStr := l3WideString(l_UrlStr);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=484018812
   if aShowMainMenu and nsNeedOpenLinkInExternalBrowser(l_UrlWStr) then
    TMainMenuService.Instance.OpenMainMenuIfNeeded(nil);
   if Result then
    Result := nsDoShellExecute(l_UrlStr);
  end;//l3IsNil(l_UrlStr)
 finally
  l_ExternalLink := nil;
  l_Url := nil;
  l_UrlStr := nil;
  l_P := nil;
  l_S := nil;
 end;//try..finally
end;//nsOpenLink

function nsNeedShellToOpenDocument(const aDocPosition: String;
                                         anInternalID: Boolean;
                                     out aWrongID: Boolean): Boolean;
var
 l_DocID: Integer;
 l_PosID: Integer;
 l_PosType: TDocumentPositionType;
 l_NumberWrong: Boolean;
 l_Document: IDocument;
 l_Link: IExternalLink;
 l_Url: IString;
 l_UrlStr: WideString;
 l_MI: IMissingInfo;
begin
 Result := True;
 nsParseDocumentNumber(aDocPosition, l_DocId, l_PosId, l_PosType, l_NumberWrong);
 aWrongID := l_NumberWrong;
 if (not l_NumberWrong) then
 begin
  if anInternalID then
   l_DocId := l_DocId + c_InternalDocShift;
  if nsOpenDocumentByNumberInternal(l_DocId, l_Document, l_MI, False) then
  try
   if (l_Document.GetDocType <> DT_REF) then
    Exit
   else
   begin
    l_Link := nsGetExternalLink(l_DocId, l_PosID, l_PosType, False, False);
    if (l_Link = nil) then
    begin
     aWrongID := True;
     Exit;
    end;//if (l_Link = nil)
    l_Link.GetUrl(l_Url);
    l_UrlStr := l3WideString(nsCStr(l_Url));
    Result := (nsIsGarantUrl(l_UrlStr) AND
              (not nsIsContractConstructorURL(l_UrlStr)) AND
              (not nsIsMobileGarantOnlineURL(l_UrlStr)) AND
              (not nsIsObtainRequisitesForMobileAccessURL(l_UrlStr)));
   end;
  finally
   l_Document := nil;
   l_Link := nil;
   l_Url := nil;
  end;//try..finally
 end;//if (not l_NumberWrong)
end;//nsNeedShellToOpenDocument
{$IfEnd}

procedure nsParseDocumentNumber(const aNumber    : Il3CString;
                                var aDocId       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType);
var
 l_Wrong: Boolean;
begin
 nsParseDocumentNumber(aNumber, aDocId, aPosID, aPosType, l_Wrong);
end;

procedure nsParseDocumentNumber(const aNumber    : Il3CString;
                                var aDocId       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType;
                                var aNumberWrong : Boolean);
  {* - ������ � ���������� ��������� � ������������� ��������� � �����
       ���������. }
var
 l_InputStr: String;
begin
 l_InputStr := l3Str(l3Trim(aNumber));
 nsParseDocumentNumber(l_InputStr, aDocId, aPosID, aPosType, aNumberWrong);
end;

procedure nsParseDocumentNumber(const aNumber    : String;
                                var aDocId       : Integer;
                                var aPosID       : Integer;
                                var aPosType     : TDocumentPositionType;
                                var aNumberWrong : Boolean);
  overload;
  {* - ������ � ���������� ��������� � ������������� ��������� � �����
       ���������. }
var
 l_DelimiterPos,
 l_PositionLength: Integer;
 l_PositionStr,
 l_InputStr: String;
begin
 l_InputStr := aNumber;
 aPosType := dptSub; // ����������� ��� ������� = ����/���, �� ���������
 // �������� ����� �� ��������� ���������� ������� � ����������
 l_DelimiterPos := Pos(cPosDelimiter, l_InputStr);
 if l_DelimiterPos > 0 then
 begin
  Inc(l_DelimiterPos); // ������������ �� ������ �������
  l_PositionLength := Length(l_InputStr) - l_DelimiterPos + 1; // ����� ������ � ��������
  l_PositionStr := Copy(l_InputStr, l_DelimiterPos, l_PositionLength); // ������ � ��������
  Delete(l_InputStr, l_DelimiterPos - 1, l_PositionLength + 1); // ������� ��� ������� � ����������� � �� �����
 end
 else
  l_PositionStr := '';

 // ���������� � ������ ����� ���������
 aNumberWrong := not TryStrToInt(l_InputStr, aDocId);
 if not aNumberWrong then
 begin
  // ���������� � ������ ���������� � �������
  if (l_PositionStr = '') then
   aPosID := 0
  else
  begin
   if l_PositionStr[1] = cParaPrefix then
   begin
    Delete(l_PositionStr, 1, 1); // ������� ������� ���������
    aPosType := dptPara; // ����������� ��� ������� = ��������
   end;//if l_PositionStr[1] = cParaPrefix then
   try
    aPosID := StrToInt(l_PositionStr);
   except
    on EConvertError do
     aPosID := 0; // �� ������� ������� ���������� � ���, ��� �� ���������� �������
   end;//try..except
  end;
 end;
end;

{$If not (defined(Monitorings) or defined(Admin))}
procedure nsSaveExternalObject(const aObject : IUnknown;
                               const aType   : TLinkedObjectType);
  {* - ��������� �������� �� ������� ����. }
var
 l_ExternalObject       : IExternalObject;
 l_ExternalObjectStream : TnsExternalObjectStream;
begin
 if Assigned(aObject) and (aType = LO_EXTERNAL_OBJECT) and
  Supports(aObject, IExternalObject, l_ExternalObject) then
 begin
  l_ExternalObjectStream := TnsExternalObjectStream.Create(l_ExternalObject);
  try
   with dmStdRes.sdExternalObject do
   begin
    FileName := l3PStr(l_ExternalObjectStream.ExternalObjectName);
    case l_ExternalObject.GetDataType of
     EOT_MP3:
     begin
      DefaultExt := vcmConstString(str_MP3FileExtension);
      Filter := vcmConstString(str_MP3FileFilter);
     end;//EOT_MP3
     EOT_PIC:
     begin
      DefaultExt := vcmConstString(str_BMPFileExtension);
      Filter := vcmConstString(str_BMPFileFilter);
     end;//EOT_PIC
     EOT_RTF:
     begin
      DefaultExt := vcmConstString(str_RTFFileExtension);
      Filter := vcmConstString(str_RTFFileFilter);
     end;//EOT_RTF
     EOT_XLS:
     begin
      DefaultExt := vcmConstString(str_XLSFileExtension);
      Filter := vcmConstString(str_XLSFileFilter);
     end;//EOT_XLS
     EOT_XLSX:
     begin
      DefaultExt := vcmConstString(str_XLSXFileExtension);
      Filter := vcmConstString(str_XLSXFileFilter);
     end;//EOT_XLSX
     EOT_PDF:
     begin
      DefaultExt := vcmConstString(str_PDFFileExtension);
      Filter := vcmConstString(str_PDFFileFilter);
     end;//EOT_PDF
     EOT_PPT:
     begin
      DefaultExt := vcmConstString(str_PPTFileExtension);
      Filter := vcmConstString(str_PPTFileFilter);
     end;//EOT_PPT
     EOT_CDR:
     begin
      DefaultExt := vcmConstString(str_CDRFileExtension);
      Filter := vcmConstString(str_CDRFileFilter);
     end;//EOT_CDR
     EOT_DOC:
     begin
      DefaultExt := vcmConstString(str_DOCFileExtension);
      Filter := vcmConstString(str_DOCFileFilter);
     end;//EOT_DOC
     EOT_DOCX:
     begin
      DefaultExt := vcmConstString(str_DOCXFileExtension);
      Filter := vcmConstString(str_DOCXFileFilter);
     end;//EOT_DOCX
     EOT_XML:
     begin
      DefaultExt := vcmConstString(str_XMLFileExtension);
      Filter := vcmConstString(str_XMLFileFilter);
     end;//EOT_XML
     EOT_XSD:
     begin
      DefaultExt := vcmConstString(str_XSDFileExtension);
      Filter := vcmConstString(str_XSDFileFilter);
     end;//EOT_XSD
     EOT_USR:
     begin
      DefaultExt := AnsiUpperCase(Copy(l3PStr(nsGetExternalObjectExt(l_ExternalObject)), 2, MaxInt));
      Filter := Format(vcmConstString(str_USRFileFilterFormat), [DefaultExt, DefaultExt]);
     end;//EOT_USR
     else
     begin
      DefaultExt := '';
      Filter := '';
     end;//else
    end;//case l_ExternalObject.GetDataType of
    if (Filter <> '') then
     Filter := Filter+'|';
    Filter := Filter + vcmConstString(str_AllFileFilter);
    if (DefaultExt <> '') and
       (not AnsiSameText(ExtractFileExt(dmStdRes.sdExternalObject.FileName), '.' + DefaultExt)) then
       // - http://mdp.garant.ru/pages/viewpage.action?pageId=621277863
     FileName := FileName+'.'+DefaultExt;
    if Execute then
     l_ExternalObjectStream.SaveToFile(FileName);
   end;
  finally
   vcmFree(l_ExternalObjectStream);
  end;{try..finally}
 end;//if Assigned(aObject) and (aType = LO_EXTERNAL_OBJECT) and
end;//nsSaveExternalObject
{$IfEnd}

{ ������ }

procedure nsSetCurrentFirstSelected(const aTree : TeeTreeView;
                                    const aNode : Il3SimpleNode);
  {* - ������� ������� ������ ���������� �������. }
var
 l_SelectedNode: Il3SimpleNode;
begin
 l_SelectedNode := nsGetFirstSelectedChild(aNode);
 if Assigned(l_SelectedNode) then
 try
  aTree.GotoOnNode(l_SelectedNode);
 finally
  l_SelectedNode := nil;
 end;{try..finally}
end;//nsSetCurrentFirstSelected

function nsGetFirstSelectedChild(const aParent: Il3SimpleNode) : Il3SimpleNode;
  {* - �������� ������� ���������� �������. }

 function lp_GetFirstNode(const aNode: INodeBase; aOp: TLogicOperation): INodeBase;
 var
  l_Iterator: INodeIterator;
 begin
  l_Iterator := GetOperationIterator(aNode, aOp);
  try
   l_Iterator.GetNext(Result);
  finally
   l_Iterator := nil;
  end;{try..finally}
 end;//lp_GetFirstNode

var
 l_Node   : INodeBase;
 l_Parent : INodeBase;
begin
 Result := nil;
 if Supports(aParent, INodeBase, l_Parent) then
 try
  l_Node := lp_GetFirstNode(l_Parent, loOr);
  if l_Node = nil then
  begin
   l_Node := lp_GetFirstNode(l_Parent, loAnd);
   if l_Node = nil then
    l_Node := lp_GetFirstNode(l_Parent, loNot);
  end;
  try
   Result := TnsSelectedNode.Make(l_Node);
  finally
   l_Node := nil;
  end;{try..finally}
 finally
  l_Parent := nil;
 end;{try..finally}
end;//nsGetFirstSelectedChild

{ ����� }

function nsPrepareTextForMailto(const aText: Il3CString): Il3CString;
  {* - ������������ ������� ������ ��� �������� ������ � �������� ���������. }
begin
 Result := aText;
 l3MReplace(Result,
            [' ',
             '"',
             #13,
             #10,
             #9],
            ['%20',
             '%22',
             '%0d',
             '%0a',
             '%09']);
end;

function nsDateToStr(const aDate: System.TDateTime): String;
  {-}
var
 l_Count   : Integer;
 l_Buffer  : PAnsiChar;
 l_SysTime : TSystemTime;
begin
 Result := '';
 DateTimeToSystemTime(aDate, l_SysTime);
 // ��������� ������ ������
 l_Count := Windows.GetDateFormat(afw.Application.LocaleInfo.Id, DATE_LONGDATE,
  @l_SysTime, nil, nil, 0);
 // ������� ������
 l3System.GetLocalMem(l_Buffer, l_Count);
 try
  if Windows.GetDateFormatA(afw.Application.LocaleInfo.Id, DATE_LONGDATE, @l_SysTime, nil,
    l_Buffer, l_Count) <> 0 then
   Result := l_Buffer;
 finally
  l3System.FreeLocalMem(l_Buffer);
 end;//try..finally
end;//nsDateToStr

{$If not (defined(Monitorings) or defined(Admin))}
function nsMyDocumentFolder(const aFileName  : Il3CString;
                            const aExtension : String = '';
                            const aCreate    : Boolean = True): Il3CString;
  {* - ���������� ��������� ����� "��� ���������" ��� �������� ������������. }

 function GetSpecialFolderPath(const a_CSIDL: Integer): string;
 var
  l_Buffer: packed array [0..MAX_PATH] of Char;
  l_ItemIDList: PItemIDList;
  l_Malloc: IMalloc;
 begin//GetSpecialFolderPath
  Result := '';
  //
  try
   OleCheck(SHGetMalloc(l_Malloc));
   try
    OleCheck(SHGetSpecialFolderLocation(HWND(0), a_CSIDL, l_ItemIDList));
    try
     if SHGetPathFromIDList(l_ItemIDList, @l_Buffer) then
      Result := PChar(@l_Buffer);
    finally
     l_Malloc.Free(l_ItemIDList);
    end;//try..finally
   finally
    l_Malloc := nil;
   end;//try..finally
  except
   on E: Exception do
    l3System.Exception2Log(E);
  end;//try..except
 end;//GetSpecialFolderPath

const
 c_CSIDL: array [Boolean] of Integer = (
  CSIDL_PERSONAL
  , CSIDL_PERSONAL or CSIDL_FLAG_CREATE
 );
begin
 Result := l3Fmt('%s\%s%s',
                 [
                  GetSpecialFolderPath(c_CSIDL[aCreate]),
                  nsPrepareFileName(aFileName),
                  aExtension
                 ]);
end;//nsMyDocumentFolder
{$IfEnd}

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure nsOpenList(const aDynList           : IDynList;
                     const aMainForm          : IvcmContainer;
                     const aWhatDoingIfOneDoc : TbsWhatDoingIfOneDoc = wdOpenIfUserDefine;
                     const aTimeMachineOff    : Boolean = True;
                     const aOpenFrom          : TbsListOpenFrom = lofNone);
  {* - ��������� ������. }

  function lp_MakeListData: IdeList;

    function lp_QueryInfo: IdeSearchInfo;
    begin
     if (aOpenFrom = lofRubricator) then
      Result := TdeSearchInfo.Make(aDynList, True)
     else
      Result := nil;
    end;

  begin
   case aDynList.GetContentType of
    DLC_LEGAL_DOCUMENTS:
    begin
     Result := TdeListSet.Make(aDynList,
                               aWhatDoingIfOneDoc,
                               aOpenFrom,
                               aTimeMachineOff,
                               nil,
                               lp_QueryInfo);
    end;
    DLC_MEDICAL_DOCUMENTS:
     Result := TdeList.Make(aDynList);
    else
    begin
     Assert(False);
     Result := nil;
    end;
   end;
  end;

begin
 if Assigned(aDynList) then
  TListService.Instance.OpenList(lp_MakeListData, aMainForm);
end;
{$IfEnd}

function nsNewWindow(const aMainForm : IvcmContainer;
                           aOpenKind : TvcmMainFormOpenKind = vcm_okInNewWindow;
                           aNeedSwitchTab: Boolean = True): IvcmContainer;
  {* - ������� ����� ����. }
begin
 Result := nsOpenNewWindowTabbed(aMainForm, aOpenKind, aNeedSwitchTab);
end;

function nsConvertAnnoKind(const aValue: Il3CString): Il3CString;
begin
 if (afw.Application.LocaleInfo.Language = afw_lngRussian) then
 begin
  if l3Same(aValue, ccakFederalLawFull) then
   Result := nsCStr(ccakFederalLawShort)
  else
  if l3Same(aValue, ccakJudgePracticeLawFull) then
   Result := nsCStr(ccakJudgePracticeLawShort)
  else
   // �������: ��������� ���� ��� ������������� ���-�� ��� ���
   // ������� ��� ��� ��������� � ���� �������...
   Result := nsCStr(ccakRegionalLaw);
 end//afw.Application.LocaleInfo.Language = afw_lngRussian
 else 
  Result := aValue;
end;

function nsGetListHeaderLocalizationInfo(const aHeader: TvtCustomHeader): String;
var
 l_Idx: Integer;
begin
 Result := '';
 with aHeader.Sections do
  for l_Idx := 0 to Count - 1 do
  begin
   if l_Idx > 0 then
    Result := Result + #13#10;
   Result := Result + Items[l_Idx].Caption;
  end;
end;

procedure nsSetListHeaderLocalizationInfo(const aHeader: TvtCustomHeader; const anInfo: String);
var
 P, Start: PChar;
 S: string;
 l_Idx: Integer;
begin
 with aHeader.Sections do
 begin
  l_Idx := 0;
  P := Pointer(anInfo);
  if P <> nil then
   while P^ <> #0 do
   begin
    Start := P;
    while not (P^ in [#0, #10, #13]) do Inc(P);
    SetString(S, Start, P - Start);
    if l_Idx < Count then
     Items[l_Idx].Caption := S
    else
     exit;
    Inc(l_Idx);
    if P^ = #13 then Inc(P);
    if P^ = #10 then Inc(P);
   end;
 end;
end;

procedure nsBeepWrongContext;
  {-}
begin
 if afw.Application.Settings.LoadBoolean(pi_PlayBeepOnMistake, dv_PlayBeepOnMistake) then
  Windows.Beep(750, 50);
 {$IfDef InsiderTest}
 g_WasBeep := true;
 {$EndIf InsiderTest}
end;

function StringToOrientation(const aString: Il3CString): Integer;
begin
 if l3Same(aString, li_Metrics_Orientation1) then
  Result := DMORIENT_LANDSCAPE
 else
  Result := DMORIENT_PORTRAIT;
end;

{ TnsDeleteFromListEvent }

{$If not (defined(Monitorings) or defined(Admin))}
class procedure TnsTimeMachineOnEvent.Log(const aDoc: IDocument; const aDate: BaseTypesUnit.TDate);
var
 l_Data: InsLogEventData;
//#UC END# *4B0A86E800FF_4B0A86AD0232_var*
begin
//#UC START# *4B0A86E800FF_4B0A86AD0232_impl*
 l_Data := MakeParamsList;
 l_Data.AddObject(aDoc);
 l_Data.AddDate(aDate);
 GetLogger.AddEvent(LE_TIME_MACHINE_ON, l_Data);
end;
{$IfEnd not (defined(Monitorings) or defined(Admin))}

{$If not Defined(Admin) AND not Defined(Monitorings)}
function nsGetFilterCaption(const aFilter : IFilterFromQuery) : Il3CString;
var
 l_Name: IString;
begin
 aFilter.GetName(l_Name);
 Result := nsCStr(l_Name);
end;
{$IfEnd}

end.
