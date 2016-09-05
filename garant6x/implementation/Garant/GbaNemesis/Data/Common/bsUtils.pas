unit bsUtils;

{------------------------------------------------------------------------------}
{ ���������� : ������ ���� ������� "�������";                                  }
{ �����      : ������� �.�;                                                    }
{ �����      : 24.08.2005 12.24;                                               }
{ ������     : bsUtils                                                         }
{ ��������   : ����� ������� � ��������� ������ ����;                          }
{------------------------------------------------------------------------------}

// $Id: bsUtils.pas,v 1.66 2016/08/02 12:43:57 lulin Exp $
// $Log: bsUtils.pas,v $
// Revision 1.66  2016/08/02 12:43:57  lulin
// - �������������.
//
// Revision 1.65  2016/07/15 11:25:37  lulin
// - ���������� �����������.
//
// Revision 1.64  2016/02/12 13:57:35  kostitsin
// {requestlink: 612742232 }
//
// Revision 1.63  2015/10/01 12:28:19  morozov
// {RequestLink: 608114858}
//
// Revision 1.62  2014/04/03 17:17:49  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.61  2014/03/04 13:11:49  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.60  2013/10/24 12:33:13  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.59  2013/10/18 14:11:09  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.58  2013/07/03 11:08:04  morozov
// {RequestLink:466761779}
//
// Revision 1.57  2012/11/28 15:16:17  kostitsin
// ��������� ������ ����
//
// Revision 1.56  2012/07/25 18:34:44  lulin
// {RequestLink:378540022}
//
// Revision 1.55  2012/06/18 10:32:58  kostitsin
// [$371631761]
//
// Revision 1.54  2012/04/28 10:38:49  lulin
// {RequestLink:361404275}
//
// Revision 1.53  2012/02/01 09:27:03  kostitsin
// [$333545491]
//
// Revision 1.52  2012/01/27 12:36:43  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=330704779
//
// Revision 1.51  2012/01/27 08:32:13  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=328859701
//
// Revision 1.50  2012/01/26 14:02:29  kostitsin
// http://mdp.garant.ru/pages/viewpage.action?pageId=328859701
//
// Revision 1.49  2011/12/16 15:09:55  lulin
// [$320742215].
//
// Revision 1.48  2011/12/15 16:24:10  lulin
// {RequestLink:320734796}
//
// Revision 1.47  2011/11/14 15:52:34  lulin
// - ������������ ������������ ���.
//
// Revision 1.46  2011/09/23 10:57:02  lulin
// {RequestLink:287219493}.
//
// Revision 1.45  2011/07/21 16:29:57  lulin
// {RequestLink:269058433}.
//
// Revision 1.44  2011/06/27 13:54:04  lulin
// {RequestLink:254944102}.
//
// Revision 1.43  2011/06/23 15:30:00  lulin
// {RequestLink:254944102}.
//
// Revision 1.42  2011/06/16 09:54:30  lulin
// {RequestLink:269072361}.
//
// Revision 1.41  2011/06/07 11:31:35  lulin
// {RequestLink:268345098}.
// - �������� ������.
//
// Revision 1.40  2011/06/07 11:11:18  lulin
// {RequestLink:268345098}.
// - �������� ������.
//
// Revision 1.39  2011/06/06 13:10:38  lulin
// {RequestLink:268345098}.
// [$268347311].
//
// Revision 1.38  2011/05/05 17:22:07  lulin
// {RequestLink:265408824}.
//
// Revision 1.37  2011/05/05 15:22:59  lulin
// {RequestLink:265408824}.
// [$265409530].
//
// Revision 1.36  2011/05/05 09:07:12  lulin
// {RequestLink:265399862}.
//
// Revision 1.35  2011/05/03 18:36:56  lulin
// {RequestLink:259892768}.
// - ������������ ������ � ��� ��� ���� ��������.
//
// Revision 1.34  2011/04/28 18:39:26  lulin
// {RequestLink:259892768}.
// - ������������ ������� � ������� �������.
//
// Revision 1.33  2011/04/19 17:48:41  lulin
// {RequestLink:261981346}.
//
// Revision 1.32  2011/04/04 16:03:39  lulin
// {RequestLink:259175088}.
//
// Revision 1.31  2011/02/28 14:07:44  lulin
// {RequestLink:254944075}.
// - ������ ����.
//
// Revision 1.30  2011/02/28 13:31:35  lulin
// {RequestLink:254944075}.
//
// Revision 1.29  2011/01/27 12:14:15  lulin
// {RequestLink:248195582}.
// - ����������� �� ����������� �������.
//
// Revision 1.28  2010/11/01 19:38:12  lulin
// {RequestLink:237994238}.
// - ��������� ifdef ��� ��������� ��������.
//
// Revision 1.27  2010/11/01 13:20:41  lulin
// {RequestLink:237994238}.
//
// Revision 1.26  2010/10/25 12:13:56  lulin
// {RequestLink:236722190}.
//
// Revision 1.25  2010/10/25 09:55:03  lulin
// {RequestLink:237502802}.
// ��� �3.
//
// Revision 1.24  2010/10/25 08:36:46  lulin
// {RequestLink:237502802}.
// ��� �2.
//
// Revision 1.23  2010/08/19 11:42:55  oman
// - fix: {RequestLink:233015148}
//
// Revision 1.22  2010/05/26 12:09:57  oman
// - new: {RequestLink:197493008}
//
// Revision 1.21  2010/03/22 16:48:19  lulin
// {RequestLink:198672893}.
// - �������� ��������� ������.
//
// Revision 1.20  2010/03/22 15:03:24  lulin
// {RequestLink:198672893}.
// - �������� ��������� ������.
//
// Revision 1.19  2010/03/22 14:42:30  lulin
// {RequestLink:198672893}.
//
// Revision 1.18  2010/03/03 16:52:44  lulin
// {RequestLink:193825692}.
//
// Revision 1.17  2010/02/15 12:47:02  oman
// - fix: {RequestLink:190680948}
//
// Revision 1.16  2010/02/08 08:41:14  oman
// - new: {RequestLink:186352569}
//
// Revision 1.15  2009/12/09 16:36:51  lulin
// - ������ ��������� ��������� �� ������ � ������ �����������.
//
// Revision 1.14  2009/12/09 13:08:20  lulin
// {RequestLink:124453871}.
//
// Revision 1.13  2009/12/09 09:23:34  lulin
// - ������� �������������� �����.
//
// Revision 1.12  2009/12/07 19:06:13  lulin
// - ������ �������� ������.
//
// Revision 1.11  2009/12/07 18:36:34  lulin
// - ��������� "���������� ������ �������" � ���������� �����.
//
// Revision 1.10  2009/12/07 17:20:22  lulin
// - ��������� "���������� ������ �������" � ���������� �����.
//
// Revision 1.9  2009/12/04 11:53:06  lulin
// - ��������� �� ������ � �������� ������������.
//
// Revision 1.8  2009/11/05 11:41:39  oman
// - new: {RequestLink:121160631}
//
// Revision 1.7  2009/10/29 14:35:43  lulin
// - ������ ����� �������� �� ������ �� ������� ����������� ����������.
//
// Revision 1.6  2009/10/13 13:50:50  oman
// - new:  {RequestLink:164596265}
//
// Revision 1.5  2009/09/29 13:44:18  lulin
// {RequestLink:159360578}. �34.
//
// Revision 1.4  2009/09/28 16:42:39  lulin
// - ������ ����� ��������� �������� �� ������.
//
// Revision 1.3  2009/09/28 11:31:53  lulin
// - ����������� �� ���������� �������� ������ �����, ��������� � ����������� �� ��������.
//
// Revision 1.2  2009/09/22 14:49:21  lulin
// - ��������� ������ ������ �� ������.
//
// Revision 1.1  2009/09/14 11:28:53  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.188  2009/09/07 17:54:13  lulin
// - ��������� ������������ �� �������.
//
// Revision 1.187  2009/09/03 18:49:00  lulin
// - ����������������� ������ � ������� ��������.
//
// Revision 1.186  2009/09/03 13:25:48  lulin
// - ������ ���������� ����� �������������� ���� �� �����.
//
// Revision 1.185  2009/08/26 08:15:08  lulin
// - ���������� ����� ��������, ����� ����� ���� ������.
// - bug fix: �� ���������� �����������.
//
// Revision 1.184  2009/08/14 14:57:46  lulin
// {RequestLink:129240934}. �42.
//
// Revision 1.183  2009/08/04 11:25:39  lulin
// [$159351827].
//
// Revision 1.182  2009/07/31 17:29:53  lulin
// - ������� �����.
//
// Revision 1.181  2009/07/29 11:31:46  oman
// - new: ������������ ������ ������ - {RequestLink:152408792}
//
// Revision 1.180  2009/06/18 07:53:34  oman
// - new: ������ ������ ������ �� ������ - [$140286494]
//
// Revision 1.179  2009/06/03 12:27:38  oman
// - new: ������������� - [$148014435]
//
// Revision 1.178  2009/04/07 09:28:45  oman
// - new: ������ ����������� - [$96484299]
//
// Revision 1.177  2009/04/07 07:21:13  oman
// - new: ������� ������� - [$96484299]
//
// Revision 1.176  2009/04/07 06:38:20  oman
// - cleanup: ������ overload - [$96484299]
//
// Revision 1.175  2009/03/04 13:32:28  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.174  2009/03/03 17:42:00  lulin
// - <K>: 137470629. ����� �������� ������������� ������.
//
// Revision 1.173  2009/02/19 19:04:59  lulin
// - ��������� �������������� ���������.
//
// Revision 1.172  2009/02/11 14:00:47  lulin
// - �������� �������� ��������� � ����������� ������� ������.
// - ����� �������� ��������� �����.
//
// Revision 1.171  2009/02/10 19:03:16  lulin
// - <K>: 133891247. �������� �������� ���������� ������.
//
// Revision 1.170  2009/02/10 15:43:26  lulin
// - <K>: 133891247. �������� ���������� �����������.
//
// Revision 1.169  2009/02/09 19:17:21  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.168  2009/01/30 16:06:50  lulin
// - <K>: 122674504. �4.
//
// Revision 1.167  2009/01/30 07:59:07  lulin
// - <K>: 122674504.
//
// Revision 1.166  2009/01/27 15:14:06  lulin
// - <K>: 133138664. �25.
//
// Revision 1.165  2009/01/12 15:58:23  lulin
// - <K>: 133138664. � 22.
//
// Revision 1.164  2008/12/25 12:19:30  lulin
// - <K>: 121153186.
//
// Revision 1.163  2008/12/25 11:05:48  oman
// - fix: ������ �� ������ ������ (�-133891112)
//
// Revision 1.162  2008/12/24 19:49:12  lulin
// - <K>: 121153186.
//
// Revision 1.161  2008/12/04 14:58:41  lulin
// - <K>: 121153186.
//
// Revision 1.160  2008/12/02 10:28:12  lulin
// http://mdp.garant.ru/pages/viewpage.action?pageId=16351568&focusedCommentId=127766910#comment-127766910
//
// Revision 1.159  2008/11/14 10:34:46  lulin
// - <K>: 122675356.
//
// Revision 1.158  2008/10/30 15:09:05  lulin
// - <K>: 121159648.
//
// Revision 1.157  2008/10/10 13:55:07  oman
// - fix: ��������� ������� �� �������� ������������ ��������� (�-121146314)
//
// Revision 1.156  2008/10/02 11:20:57  oman
// - fix: �� ���������������� ������ (�-120720843)
//
// Revision 1.155  2008/09/26 10:44:27  oman
// - fix: �������� ��� ��� DnD (�-109904958)
//
// Revision 1.154  2008/08/01 13:10:07  mmorozov
// - new: ���������� �� ���������� FlashActiveX (K<104434872>);
//
// Revision 1.153  2008/07/28 16:05:46  mmorozov
// - new: ��������� ������ � �������� ��� �������������� �� ������ (K<104432822>);
//
// Revision 1.152  2008/07/15 09:03:45  oman
// - new: �������� ������ ��� �������� ������������� ��������� (�-100008730)
//
// Revision 1.151  2008/07/08 11:21:20  mmorozov
// - new: ������������ �������� ��� ����������-���� (�<99221827>);
//
// Revision 1.150  2008/07/07 07:30:11  mmorozov
// - bugfix: � ���� "��������" ��� ��������, �� � ��� �� ����� �������� �������� (�<96484615>);
//
// Revision 1.149  2008/06/24 07:43:35  oman
// - new: ������ ����������� �������� (cq29419)
//
// Revision 1.148  2008/06/20 13:55:28  lulin
// - ���������� �������� ���������.
//
// Revision 1.147  2008/06/20 12:49:28  lulin
// - ���������� �������� ���������.
//
// Revision 1.146  2008/06/18 12:57:08  oman
// - fix: �������� ����� ������������ (cq29204)
//
// Revision 1.145  2008/06/18 10:43:08  oman
// - new: ��������� ����������� �������� (cq29204)
//
// Revision 1.144  2008/06/18 06:11:51  mmorozov
// - new: ���������� ���������� �������� ��� ������� ������ (CQ: OIT5-29196);
//
// Revision 1.143  2008/06/09 11:39:44  demon
// - new: ������� ISearch.CorrectContext �������� �������������� �������� - ��� ������ ��� ���
//
// Revision 1.142  2008/05/27 09:04:24  lulin
// - ������� ������ �������� ���������� ���������.
//
// Revision 1.141  2008/05/26 11:46:50  mmorozov
// - change: ������ ������ �������� ��������� �� ������.
//
// Revision 1.140  2008/05/22 09:37:12  oman
// - fix: ������ ��� ����������� �������� (cq29024)
//
// Revision 1.139  2008/05/13 05:37:30  mmorozov
// - ���������� ���������� �������� (CQ: OIT5-29022);
//
// Revision 1.138  2008/05/08 04:58:21  mmorozov
// - rename: QueryInfo -> SearchInfo;
//
// Revision 1.137  2008/05/06 07:06:10  mmorozov
// - bugfix: ����������� ������ ������� � �����������;
//
// Revision 1.136  2008/04/29 12:43:01  oman
// - fix: ���������� ��� � ������ ���������� ��������� (cq28939)
//
// Revision 1.135  2008/04/17 08:36:46  oman
// - fix: �������� � ������� ������ ����������� ��������� (cq28899)
//
// Revision 1.134  2008/04/17 05:53:49  mmorozov
// - new: "�������������� � �������� ������ ��� ���������" ������������� ��� ���������� � ����������.
//
// Revision 1.133  2008/04/10 09:33:57  oman
// - new: ������ ���� � ������ (cq28805)
//
// Revision 1.132  2008/03/26 11:59:15  oman
// - new: ������ ��������� DocInfo ��� ����-��������������
//
// Revision 1.131  2008/03/25 08:33:01  mmorozov
// - bugfix: ��� ��������� �������� �� �������������� ������� � ����������������� ��� (CQ: OIT5-28504);
//
// Revision 1.130  2008/03/20 10:30:27  oman
// - fix: �� ������ � ������ ���������� ��������
//
// Revision 1.129  2008/02/19 13:34:43  mmorozov
// - new: ������������� ����� �������� ������ ��� ����������\����������� ���������� ���������� ������ � ��� ��������� (� ������ ������ CQ: OIT5-28331);
//
// Revision 1.128  2008/02/11 08:24:28  oman
// - fix: ������� �� �������� ���� ������ ���������� �������� (cq22611)
//
// Revision 1.127  2008/02/04 14:03:40  oman
// - new: �������������� � ��������� (cq20237, 11152)
//
// Revision 1.126  2008/01/31 10:55:03  oman
// - new: ������ ��� �������� ����� (cq28329)
//
// Revision 1.125  2008/01/21 07:18:36  mmorozov
// - new: ������ � ����������������� �������� �� �������� � �� ��������� ���������� �� sdsDocInfo, ����� ���� ��������� ��� ������ � ��������� + ������������� ����������� (� ������ ������ ��� CQ: OIT5-17587);
//
// Revision 1.124  2008/01/10 07:23:00  oman
// ������� �� ����� �������
//
// Revision 1.123  2007/12/28 17:59:30  lulin
// - ������� �������� ���������� ���������� - ������ �� ����� ��������� ��������.
//
// Revision 1.122.2.7  2008/01/09 09:02:50  oman
// - fix: �� ����������
//
// Revision 1.122.2.6  2007/12/13 08:46:33  oman
// ������������ �� ����� ������� - ���� �������� ���������
//
// Revision 1.122.2.5  2007/11/29 12:44:53  oman
// ������������ �� ����� �������
//
// Revision 1.122.2.4  2007/11/26 09:03:55  oman
// ������������ �� ����� �������
//
// Revision 1.122.2.3  2007/11/23 09:09:47  oman
// cleanup
//
// Revision 1.122.2.2  2007/11/23 09:03:16  oman
// ������������ �� ����� �������
//
// Revision 1.122.2.1  2007/11/16 14:03:46  oman
// ������������ �� ����� �������
//
// Revision 1.122  2007/10/20 14:11:33  mmorozov
// - ����������� ������ � �������������� ���� ����������� ��� ���������� ������ ��������� bs_csPaymentRefusalOldFormat;
// - ����� ��������� (� ����������) IdeConsultation, �� ���� �������� ����������� _IbsConsultation;
// - cleanup;
//
// Revision 1.121  2007/10/19 09:23:35  oman
// - fix: ��� ������� ��������� ������ ��������� - �����
//  ����������� ������� (�-57051004)
//
// Revision 1.120  2007/10/17 14:03:48  oman
// - fix: ��� ������� ��������� ������ ��������� (�-57051004)
//
// Revision 1.119  2007/10/13 11:10:02  mmorozov
// - new behaviour: ��� �������� ��� ������������ �� ��������� ���������  �� ������ ���������, ����� ���������� ������ �������; ��� ������������ � ���������������� ������� � 6.4. ��� �������� ������� ��������� � ���������� ����� ������� (CQ: OIT5-27021);
//
// Revision 1.118  2007/10/03 12:49:26  mmorozov
// - new: ��������� �������� ������ ������� �� ���� ������� ���� + ��� ���������� � �������� ����� �������� ������ ����������� �������� �������� ������ ������� � ���� �������� ������� �������� + ������������ ����������� (� ������ CQ: OIT5-26843; K<56295615>);
//
// Revision 1.117  2007/09/25 07:13:06  oman
// - new: ���������� �������� ��� ������
//
// Revision 1.116  2007/08/14 19:31:42  lulin
// - ������������ ������� ������.
//
// Revision 1.115  2007/08/14 14:29:50  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.114  2007/08/14 07:32:38  mmorozov
// - new: ��������� ������ � ��������� ������������ (CQ: OIT5-25868);
//
// Revision 1.113  2007/07/17 13:26:52  mmorozov
// - new: �������� ���������� ����������� ������� (� ������ CQ: OIT5-25852);
//
// Revision 1.112  2007/07/17 12:37:23  oman
// - fix: �������� �� ��������/������� ���������� �� ����� (cq25665)
//
// Revision 1.111  2007/07/17 11:29:50  oman
// - fix: ��� �������� ������������ ��������� ����������� ��������
//  � �������� (cq25665)
//
// Revision 1.110  2007/06/21 11:29:46  mmorozov
// - ������������� ��������;
//
// Revision 1.109  2007/06/06 14:29:04  oman
// hint fix
//
// Revision 1.108  2007/06/01 09:12:06  oman
// - new: ����� ������� �� ��������� ��������������� ���� ��� ��
//  ������������� (cq25285)
//
// Revision 1.107  2007/05/17 12:04:09  oman
// cleanup
//
// Revision 1.106  2007/05/14 14:15:27  oman
// cleanup
//
// Revision 1.105  2007/05/14 11:20:57  oman
// - new: ����������� ����� � ������ (cq25145)
//
// Revision 1.104  2007/05/11 14:07:10  oman
// - new: ������� ������ ��� ���������� � �������� (cq25218)
//
// Revision 1.103  2007/05/03 05:51:52  mmorozov
// - opt: ����������� ������������� � ������ (CQ: OIT5-24996; OIT5-24543);
//
// Revision 1.102  2007/04/23 08:35:07  oman
// - new: �������� ������ ��� � ������ ������� (cq25125)
//
// Revision 1.101  2007/04/05 10:49:24  lulin
// - ��������� ������������� ����.
//
// Revision 1.100  2007/03/28 08:49:19  oman
// cleanup
//
// Revision 1.99  2007/03/27 11:59:26  oman
// ��������� ��� ��������� �� ����������� ������
//
// Revision 1.98  2007/03/19 14:24:16  lulin
// - ����������� �� ������� ��������� � ������ ���������� ������.
//
// Revision 1.97  2007/03/16 16:56:57  lulin
// - ����������� �� ��������� ����������� � �������������� �����.
//
// Revision 1.96  2007/02/28 12:43:50  lulin
// - cleanup.
//
// Revision 1.95  2007/02/27 09:17:49  lulin
// - ���������� ����� ������� ���� ��� ������ � �������.
//
// Revision 1.94  2007/02/13 15:42:01  lulin
// - ����������� �� ������ �������������� ����� - ��������� ������� �������� �����, ���������� ����������.
//
// Revision 1.93  2007/02/13 14:33:12  lulin
// - cleanup.
//
// Revision 1.92  2007/02/12 19:35:52  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.91  2007/02/12 18:55:39  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.90  2007/02/12 18:44:28  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.89  2007/02/12 16:38:57  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.88  2007/02/12 09:58:42  lulin
// - bug fix: ���������� ������� ��������� ��������� ��������.
//
// Revision 1.87  2007/02/09 12:58:21  lulin
// - �������� ������� �������������� � ������� ������ ��������.
//
// Revision 1.86  2007/02/07 17:48:29  lulin
// - ����������� �� ����������� ����� ��� ������ �� ��������.
//
// Revision 1.85  2007/02/07 14:30:32  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.84  2007/02/06 15:20:45  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.83  2007/02/06 12:33:56  mmorozov
// - �� ���������� �����������;
//
// Revision 1.82  2007/02/06 09:03:00  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.81  2007/02/06 07:52:43  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.80  2007/02/06 07:28:18  mmorozov
// - bugfix: ��� �������� �� ������ ���������� �� ��������� � �������� ������������ �������� ��������� � ������������ � ���������� ������ ������� (CQ: OIT5-23950);
//
// Revision 1.79  2007/02/02 13:23:49  lulin
// - �������� �������������� �����.
//
// Revision 1.78  2007/02/02 08:38:51  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.77  2007/01/22 12:22:55  lulin
// - ��������� �� ����� ���������� ������.
//
// Revision 1.76  2006/12/22 15:06:20  lulin
// - ����� ���� - ������ ��������� � ������ � ������� ���������.
//
// Revision 1.75  2006/12/21 09:15:04  oman
// - new: ����������� ������ ��� ���������� � �������� ����������
//  � ������� (cq23937)
//
// Revision 1.74  2006/12/20 15:00:29  oman
// - fix: ���������� ����������� ������ � ��������� ������ �����
//
// Revision 1.73  2006/12/19 13:07:19  oman
// - new: ������� �� ��������� ������������ ������
//  ���������������� ����������� ����� (cq23829)
//
// Revision 1.72  2006/12/13 11:38:06  mmorozov
// - MERGE WITH B_NEMESIS_6_4;
//
// Revision 1.68.2.3.2.4  2006/12/13 11:27:58  mmorozov
// - bugfix: �� ����������� Root ������ ��� �������� ��������� �� ������ (CQ: OIT5-23773);
//
// Revision 1.71  2006/11/28 13:29:43  mmorozov
// MERGE WITH B_NEMESIS_6_4
//
// Revision 1.70  2006/11/21 11:36:32  mmorozov
// MERGE WITH B_NEMESIS_6_4 (new: ��� ���������� ������, ��� ������ ���������������� �� �������������, ��������� � ������ ��������� ������������� �������� �������� � ������ (CQ: OIT5-23059));
//
// Revision 1.69  2006/11/03 09:45:31  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.68.2.3  2006/11/02 07:40:36  oman
// - ��� ����������� ����� ������ �������� ��� ����, � ��
//  ��������� ��������� (cq20231, 20412)
//
// Revision 1.68.2.2  2006/10/31 16:18:55  oman
// - fix: ��� ���������� �� ����� �� ���� (cq23213)
//
// Revision 1.68.2.1  2006/10/25 07:29:36  oman
// ���������� ���������� �� StdStr
//
// Revision 1.68  2006/10/11 13:48:40  mmorozov
// - new behaviour: ���� ������������ ������� � ���� ����������, �� ������������ ��� �� ������������ �������� �� ������ (CQ: OIT5-22959);
//
// Revision 1.67  2006/09/29 08:01:52  mmorozov
// - new: ��� ���������� ����������� ���� � ��������������� ������� ���������� � ��������� �������� ���������� �������� (CQ: OIT00011244);
//
// Revision 1.66  2006/09/29 07:23:14  mmorozov
// - new: �������������� ������ ��� ���������� ��� ��������� ����������� �� ��������� ���������� �� ������������ ������������, ������ ������ (CQ: OIT500022747);
//
// Revision 1.65  2006/09/27 13:42:13  mmorozov
// � ������ ������ ��� CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. � ������ ���� �� ��������������, � ������������ ����� ��� ������ ��������������, ����� ���� �������� _IAttributeInfo;
// - remove: �������������� �������� � enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo ������� �������;
//
// Revision 1.64  2006/09/25 13:00:47  mmorozov
// - new behaviour: ��������� ��� ����� ����� "��� ���������" ��� ����������/�������� �������� �� ���� ����������;
// - new behaviour: ����� "��� ���������" �� ���������� ��� ���������� �� ���� �������;
// - _move: ���������� ���������� � ������ _nsInterfaces;
//
// Revision 1.63  2006/09/20 15:03:06  mmorozov
// - new: ��������� � ������ ������ ��� �������� ������ ������������;
//
// Revision 1.62  2006/08/24 13:33:46  oman
// - new beh: ������� ������������ � XML (cq22128)
//
// Revision 1.61  2006/08/22 13:13:58  oman
// - fix: �������������� ��������� ������� (cq22371)
//
// Revision 1.60  2006/08/01 10:57:00  mmorozov
// - rename: local variables;
//
// Revision 1.59  2006/07/28 14:24:08  mmorozov
// - new: ��������� �������� �������� �� ����� "��������� �������";
// - new: ��������� ����������� ��� �������� ������������ (�� ������ ���������, ��� ����� � ��������);
//
// Revision 1.58  2006/07/26 15:05:52  mmorozov
// - new: � ������ ������������ ������� ���������� � ������������ ��� �������� ������� ���� (CQ: OIT500021485);
//
// Revision 1.57  2006/07/18 11:59:25  mmorozov
// - new: ������� �������� �� ��������� �������� �� ��������� (CQ: OIT500021888);
//
// Revision 1.56  2006/07/03 05:24:49  oman
// -fix: �� ���������������.
//
// Revision 1.55  2006/06/30 14:59:03  mmorozov
// - new: ��������� �������� "���������� � ������������" ���������� �� ���������� shortcut-�. �������� ��������� �������� ������ ����������� ��� ���������� � ������������;
// - change: ������� ��� �� ������ � mailto (���������� � nsUtils);
// - change: ������������� ������� ������ bsConvert;
//
// Revision 1.54  2006/06/30 14:14:31  oman
// - new beh: � ������ ����������� ��������� ��������� ������ ���
//  ���������� (cq21517)
//
// Revision 1.53  2006/06/29 11:56:08  mmorozov
// - change: ��������� � ����� � ��������� ���� GblAdapter.TDateTime;
//
// Revision 1.52  2006/06/29 10:29:34  mmorozov
// - new behaviour: ����� �������� �������� � ������ ����������� ��� �� ������� ��������������� (CQ: OIT500021526);
//
// Revision 1.51  2006/06/27 11:08:50  mmorozov
// - bugfix: �� �������������� ���������� ��� ������������ ������� ������ (CQ: OIT500021503);
//
// Revision 1.50  2006/06/06 11:36:46  mmorozov
// - bugfix: ���� �� ������ ���� ������� ����������� ������������ �� ������ ���� ������� ����� ������������ (CQ: OIT00021243);
//
// Revision 1.49  2006/06/05 14:33:05  mmorozov
// - new behaviour: �� ��������� �������� ���� � �� �� ������������ (CQ: OIT500021143);
//
// Revision 1.48  2006/05/17 14:48:35  mmorozov
// - new behavour: ��� �������������� ������� ����������� �� ������ ��� ������� �� � ������ ���������, ����� ��������� � ������������ 5.� ��������� ������ �������� �������� ������ ��� 5.� ��� ��� ��� ������� (OIT500020569);
//
// Revision 1.47  2006/05/16 07:36:01  mmorozov
// - bugfix: ��������� ���� "���������� � �����������" ��� �������� �� ������� ���������� (CQ: OIT500020718);
//
// Revision 1.46  2006/05/12 07:13:59  oman
// warning fix
//
// Revision 1.45  2006/05/05 13:11:12  mmorozov
// - ������ ��� �������������;
//
// Revision 1.44  2006/05/05 09:01:49  mmorozov
// - new: ����������� ������� ������������ �� �����;
//
// Revision 1.43  2006/05/04 13:12:12  mmorozov
// - ������ ��� ��������������;
//
// Revision 1.42  2006/04/17 12:08:49  oman
// - change: ��������� ������-������� (���� ������) �� ������������
//  ����������� (�����, imageindex)
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.41  2006/04/17 07:18:42  oman
// - change: ��������� ������-������� (���� ������) �� ������������
//  ����������� (�����, imageindex)
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.40  2006/04/13 15:05:01  mmorozov
// - add comments;
//
// Revision 1.39  2006/04/12 13:14:54  oman
// - change: ������� ��������� ����������� ����� �� ������������� ������
// - new beh: ����������� nsc
//
// Revision 1.38  2006/04/12 09:53:04  mmorozov
// - �������� �������� ��������� ����������;
//
// Revision 1.37  2006/04/05 14:52:19  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.36  2006/04/04 14:03:33  oman
// - new beh: ������� �� �������� ��� "������ ��� ����������� � UI"-<�����>.
//
// Revision 1.35  2006/03/28 12:05:28  mmorozov
// - change: ��������� ��� ������������� ���������� ����� ������;
//
// Revision 1.34  2006/03/28 11:56:34  oman
// - change: ������� %s � ���������� + ����������� �� ������ ��������� �� �������� � ����.
//
// Revision 1.33  2006/03/27 07:19:16  mmorozov
// - bugfix: ��������� �������� �� ������� ��������� (cq: 20197);
//
// Revision 1.32  2006/03/15 14:12:58  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr � DebugStr)
//
// Revision 1.31  2006/03/15 12:26:07  mmorozov
// - new: ��� �������� ���� ��� �������������� �������� ���������� ���������� ������ �������;
//
// Revision 1.30  2006/03/01 12:16:29  mmorozov
// - new: � ������ ������������� ��������� ���� � ���� �������� ��������� � ���� ���������� ���������� (CQ: 19150);
//
// Revision 1.29  2006/02/08 09:57:04  mmorozov
// - new: �������� ������� � ��������� ������������ _nsQueryUtils.GetContextFromQuery;
//
// Revision 1.28  2006/02/07 15:48:03  mmorozov
// - new: ������� ��� ������ � ��� ���������;
//
// Revision 1.27  2005/12/23 14:07:35  lulin
// - ������ ��������������.
//
// Revision 1.26  2005/12/23 13:25:23  mmorozov
// - bugfix: ��� ���������� ���� ���� ����\���� �� �����;
//
// Revision 1.25  2005/12/21 11:26:57  mmorozov
// - bugfix: ������� �� ���������� ���������;
//
// Revision 1.24  2005/12/20 14:36:45  mmorozov
// - bugfix: ��� �������� ��������� ����� ����� ��������� �� �������� �� �������� �������, �������������� �� ��������, ������ ���������� �� ������ ������ (cq: 00018776);
// - bugfix: �� ������ ��������� "������������� ���������� ������ ������� ��� �������� ���������";
//
// Revision 1.23  2005/11/23 15:09:52  mmorozov
// bugfix: ��� �������� ��������� ������� �� ������������ ������ ������� (cq: 00018266);
//
// Revision 1.22  2005/11/11 19:47:31  mmorozov
// new: � ������ ���� �������� ������ ���� �������� ��� ������ ��������� ��������� � ����� ��������� ��������� ������ ������������ �� �� ���������� ���������, � �� ������������ ������;
//
// Revision 1.21  2005/11/04 09:39:16  demon
// - new behavior: "��������� �� ��������" � ������ ����� ���� ��������, ������� �������� ������� ���� ������� ��� ���������
// - new behavior: �������� "��������� �� ��������" ��� �������� "���������� ���������" �������
//
// Revision 1.20  2005/11/03 12:09:49  mmorozov
// new: ���� ������������ ������;
//
// Revision 1.19  2005/11/01 15:24:32  demon
// - fix: ������� �������� �������� "��������� �� ��������" ��� ������� � child-zone
//
// Revision 1.18  2005/10/24 12:51:08  mmorozov
// bugfix: ������ �������� ������ ������� �������� ��������� �� ���������� ���������� � ����;
//
// Revision 1.17  2005/10/18 16:46:36  mmorozov
// new: ������� ���������� �� ������ (���������� �� ����);
//
// Revision 1.16  2005/10/12 13:04:07  mmorozov
// - ������ ��� ������� ��������� �������;
//
// Revision 1.15  2005/10/10 16:32:46  mmorozov
// - ������ ��� ������� ��������� �������;
//
// Revision 1.14  2005/10/05 09:47:51  mmorozov
// change: ������� � ��������� ������ (��� ������, �������);
//
// Revision 1.13  2005/10/04 16:43:16  demon
// - new behavior: ������������� ���������� SaveAs �� ������
//
// Revision 1.12  2005/09/28 18:33:08  mmorozov
// - ������ ��������� � ����������� ������;
//
// Revision 1.11  2005/09/27 13:38:50  demon
// - new behavior: ��� ������ "��������" ������� ����������� ��������� � ��������� ������
//
// Revision 1.10  2005/09/22 12:05:09  demon
// - new behavior: �������� ��������� IdeDocInfo
//
// Revision 1.9  2005/09/19 09:44:26  mmorozov
// change: ������������ ������;
//
// Revision 1.8  2005/09/16 10:41:00  mmorozov
// new: ��������� ���������� � ������;
//
// Revision 1.7  2005/09/16 09:46:51  mmorozov
// new: ������������ ������;
//
// Revision 1.6  2005/09/16 09:08:59  demon
// - fix: � �������� _bsDocCount �� �������������� �������� CanNotFindData
//
// Revision 1.5  2005/09/15 13:18:58  mmorozov
// - ��������� ������� ������ � ������� �� �����;
//
// Revision 1.4  2005/09/13 10:18:06  demon
// - new behavior: ������������� ����������������� �������� �� ������ �� ������ ��������
//
// Revision 1.3  2005/08/26 12:06:38  mmorozov
// change: ��������� _bsDocInfoMake;
//
// Revision 1.2  2005/08/26 07:47:48  mmorozov
// new: function bsListClone;
//
// Revision 1.1  2005/08/24 09:33:45  mmorozov
// ����� ������: ����� ������� � ��������� ������ ����;
//

interface

uses
  Classes,
  Graphics,

  afwInterfaces,

  k2Interfaces,

  l3Interfaces,
  l3Types,
  l3Tree_TLB,
  l3TreeInterfaces,
  l3Base,

  eeInterfaces,

  vcmExternalInterfaces,
  vcmInterfaces,

  BaseTypesUnit,
  BaseTreeSupportUnit,
  ConsultingUnit,
  DocumentUnit,
  DynamicDocListUnit,
  DynamicTreeUnit,
  FoldersUnit,
  SearchUnit,
  SettingsUnit,
  UnderControlUnit,
  PharmFirmListUnit,

  bsTypes,

  nsTypes,
  bsInterfaces,

  SearchDomainInterfaces,
  PrimPrimListInterfaces
  {$If not Defined(Admin) AND not Defined(Monitorings)}
  ,
  BaseSearchInterfaces,
  DocumentInterfaces,
  DocumentAndListInterfaces,
  UnderControlInterfaces
  {$IfEnd}

  ,
  evdTypes
  ;

{------------------------------------------------------------------------------}
{ ������������                                                                 }
{------------------------------------------------------------------------------}
function bsIsSame(const aValue1 : IConsultation;
                  const aValue2 : IConsultation): Boolean;
  {* - ���������� ��� ������������. }
function bsConsultationName(const aConsultation: IConsultation): Il3CString;
  {* - ��� ������������. }
{------------------------------------------------------------------------------}
{ �����                                                                        }
{------------------------------------------------------------------------------}
function bsCheckNodeType(const aNode : Il3SimpleNode;
                         const aType : TFoldersItemType): Boolean;
  {* - ��� ���� �����. }
function bsHasFlag(const aNode  : IeeNode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - ������� ����� � ���� INode. }
function bsHasFlag(const aNode  : Il3SimpleNode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - ������� ����� � ���� INode. }
function bsHasFlag(const aNode  : INode;
                   const aFlags : array of LongWord): Boolean;
  overload;
  {* - ������� ����� � ���� INode. }
function bsHasFlag(const aFlags      : LongWord;
                   const aCheckFlags : array of LongWord): Boolean;
  overload;
  {* - ��������� ������� �����. }
function bsHasFlag(const aFlags      : LongWord;
                   aCheckFlag : LongWord): Boolean;
  overload;
  {* - ��������� ������� �����. }
function bsGetConsultation(const aNode: Il3SimpleNode): IConsultation;
  {* - ������� ������������. }
function bsCanExportNodeToXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� �������������� ����. }
procedure bsExportNodeToXML(const aNode     : Il3SimpleNode;
                            const aFileName : Tl3WString);
  {* - �������������� ����. }
function bsCanImportNodeFromXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� ������������� � ����. }
procedure bsImportNodeFromXML(const aNode     : Il3SimpleNode;
                              const aFileName : Tl3WString);
  {* - ������������� � ����. }
function bsCanExportNodeToIntegrationXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� �������������� ����. }
procedure bsExportNodeToIntegrationXML(const aNode: Il3SimpleNode);
  {* - �������������� ����� XML � ��������. }
function bsCalcUniqueName(const aParent: Il3Node; const aName: Il3CString; const aSuffix: Il3CString): Il3CString;
  {* - ��������� ���������� ��� ��� ���������� � ����� }  
{------------------------------------------------------------------------------}
{   ����� ��������                                                             }
{------------------------------------------------------------------------------}
{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure bsEditorAddWikiPara(const aGen  : Ik2TagGenerator;
                              const aText : Tl3WString;
                              aFixedFont  : Boolean;
                              aDeleteLink : Boolean);
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aAnchorNum     : TnsWarningSub = cNoneWarningSub;
                          aLinkHandle    : TnsWarningLinkHandle = cNone_LinkHandle;
                          aLinkStartPos  : Integer = 0;
                          aLinkEndPos    : Integer = 0;
                          anAddLinkText  : Il3CString = nil;
                          anAddLinkHandle: TnsWarningLinkHandle = cNone_LinkHandle;
                          aForeColor     : TColor = clWindowText;
                          aFontItalic    : Boolean = False;
                          NullifyIndent  : Boolean = False;
                          aJust          : TevIndentType = ev_itNone); overload;
  {* - �������� ��������, ������ ������ ����� ��������� ������. }
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aJust          : TevIndentType;
                          NullifyIndent  : Boolean = False); overload;
  { - }
{$IfEnd}
procedure bsAddLink(const aGen : Ik2TagGenerator;
                    aHandle    : Integer;
                    aStartPos,
                    aFinishPos : Integer);
  {* - �������� ������ � ��������. }
function bsComplectOwner: Il3CString;
  {* - �������� ��������������� ��������� (��� ���� ������� ����). }
function bsFindNodeByCaption(const aRoot : Il3Node;
                             const aNode : Tl3PCharLen): INodeBase;
  {* - ����� ���� �� ����� � ������� ���. }
function bsBaseDate: System.TDateTime;
  {* - ���� ���������� ����. }
function bsBaseDateStr: String;
  {* - ���� ���������� ����. }
function bsComplectName: Il3CString;
  {* - �������� ���������. }
{$If not defined(Admin) AND not defined(Monitorings)}
function bsBuildFullList(const aList: IDynList): IDynList;
  {-}
{$IfEnd} //not Admin  
{------------------------------------------------------------------------------}
{   ����                                                                       }
{------------------------------------------------------------------------------}
function bsIsDateEqual(const aDate1 : BaseTypesUnit.TDate;
                       const aDate2 : BaseTypesUnit.TDate): Boolean;
  {* - ���������� ��������� ���. }
{------------------------------------------------------------------------------}
{   ������                                                                     }
{------------------------------------------------------------------------------}
function bsListPrintOnlyFirstLevel(aList: TbsListType): Boolean;
  {-}
function bsIsListChanged(const aList: IDynList): Boolean;
  {* - ���������� ��� �� ������� ������. }
function bsIsListEmpty(const aList: IDynList): Boolean;
  {* - ���������� ������ �� ������. }
function bsListClone(const aList : IDynList) : IDynList;
  {* - ������������ ������. }
function bsDocCount(const aList: IDynList): Integer;
  {* - ���������� ���������� � ������. }
function bsListName(const aList: IDynList): Il3CString;
  {* - ���������� ��� ������. }
function bsShortListName(const aList: IDynList): Il3CString;
  {* - ���������� �������� ������. }
function bsListCreationHistory(const aList: IDynList): Il3CString;
  {* - ���������� ������� ��������, ��������� ������. }
function bsIsListSaved(const aList: IDynList): Boolean;
  {* - ���������� ��� �� �������� ������. }
function bsListEntryInfo(const aNode: Il3SimpleNode): IListEntryInfo;
  overload;
  {* - �������� ��������� ��� ������ � ����� ������. }
function bsListEntryInfo(const aNode: INodeBase): IListEntryInfo;
  overload;
  {* - �������� ��������� ��� ������ � ����� ������. }
function bsMedicFirmListEntryInfo(const aNode: INodeBase): IPharmFirmListEntry;
  {* - �������� ��������� ��� ������ � ����� ������. }
procedure bsMakeNewListName(const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  overload;
  {* - �������� ��� ������ ������. }
procedure bsMakeNewListName(const aParent   : Il3Node;
                            const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  overload;
  {* - �������� ��� ������ ������. }
function bsListType(const aList: IDynList): TbsListType;
  {* - ��� ������. }
function bsListNodeType(const aNode: INodeBase): TbsListNodeType;
  {* - ��� ����. }
{------------------------------------------------------------------------------}
{   ��������                                                                   }
{------------------------------------------------------------------------------}
{$If not defined(Admin) AND not defined(Monitorings)}
function bsConvertFilteredCRNode(const aNode: Il3SimpleNode): Il3SimpleNode;
  {* - �� ������������� ���� �������� �������������� ������ �� ������ �������� ��� }
{$IfEnd}  
function bsRedationInfo(const aDocument: IDocument): TRedactionInfo;
  {* - �������� ���������� � ��������� ���������. }
function bsIsCRUseAsUserCR(const aType : TlstCRType;
                           out aWeight : Integer): Boolean;
  {* - ���������� ������������ �� ����\���� ��� ���������������� ��������. }
function bsUserCRNode(const aValue: TnsUserCRListId): IbsFrozenNode;
  {* - ��� ��� ������ ���������������� ��������. }
function bsIsCRNodeAreNotAllDocuments(const aNode: IbsFrozenNode): Boolean;
  overload;
  {* - ���� ��� �� �������� "��� ���������". }
function bsIsCRNodeAreNotAllDocuments(const aNode: INodeBase): Boolean;
  overload;
  {* - ���� ��� �� �������� "��� ���������". }
function bsUserCRList(const aValue: TnsUserCRListId): TlstCRType;
  {* - ��� ������ ���������������� �������� ���. }
function bsGetCRType(const aNode: Il3SimpleNode): TNodeType;
  {* - ��� ���. }
(*function bsGetAllDocumentsCRNode: IbsFrozenNode;
  {* - ���� ��� ��������� }*)
{$If not defined(Admin) AND not defined(Monitorings)}
function bsDocInfoMake(const aListNode                 : INodeBase;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
 overload;
  {* - ��������� ��������� ������ ������� ��� ������������� ������ ��������. }
function bsDocInfoMake(const aData                     : IListEntryInfo;
                       const aListNode                 : INodeBase = nil;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo                : IdeSearchInfo = nil): IdeDocInfo;
 overload;
  {* - ��������� ��������� ������ ������� ��� ������������� ������ ��������. }
{$IfEnd}  
function bsExtractDocument(const aListNode : INodeBase): IDocument;
  overload;
  {* - ��������� �� �������� ������ ��������. }
function bsExtractDocument(const aListNode : Il3SimpleNode): IDocument;
  overload;
  {* - ��������� �� �������� ������ ��������. }
function bsCreateEditionDateInterval(const anActivIntervals: IActiveIntervalList): Il3CString;
  {* - ����������� �������� ��������. }
{$If not (defined(Monitorings) or defined(Admin))}
function bsCreatePrintEditionWarning(const aDocument: IDocument): Il3CString;
  {* - ����������� �������������� ��� �������� ��� ������. }
{$IfEnd}  
{------------------------------------------------------------------------------}
{   �������� �������                                                           }
{------------------------------------------------------------------------------}
function bsLanguageImage(const aLanguage: TbsLanguage): Integer;
  {* - ���������� ������ ��� ����� ����������� � StdRes.ImageList. }
function bsLanguageCaption(const aLanguage: TbsLanguage): Il3CString;
  {* - ���������� ������ ��� ����� ����������� � StdRes.ImageList. }
{------------------------------------------------------------------------------}
{    �����                                                                     }
{------------------------------------------------------------------------------}
function bsIsOneOperation(const aOperations: TLogicOperationSet): Boolean;
  {* - ���������� �������� ��������� ��� ������� ��������. }
function bsDocumentList(const aEntity: ISearchEntity): IDynList;
  {* - �������� ������ ���������� �� aEntity. }
function bsMonitoringList(const aEntity: ISearchEntity): IDynList;
  {* - �������� ����� ����������������. }
function bsGetOperations(const aTag : Il3CString) : TLogicOperationSet;
  overload;
  {* - �������� ������ ��������� ��������. }
function bsGetOperations(const aAttrInfo : IAttributeInfo) : TLogicOperationSet;
  overload;
  {* - �������� ������ ��������� ��������. }
{------------------------------------------------------------------------------}
{                                                                              }
{------------------------------------------------------------------------------}
function bsMakeSearchVisualizer(const aContext: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ������. }
function bsMakeSaveVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ����������. }
function bsMakeExportVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ��������. }
function bsMakeEMailVisualizer: IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ �������� �� �����. }
{$If not (defined(Monitorings) or defined(Admin))}
function bsCorrectMistakes(const aContext: Il3CString; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - ��������� �������� � ������������ �������� � ������������� ��������. }

function bsCorrectMistakes(const aContext: Il3StringsEx; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - ��������� �������� � ������������ �������� � ������������� ��������. }
{$IfEnd}

const
  c_bsCRWeights: array [0..1] of Integer = (40, 50);
    {* - ���� ������������ �������� ����\����. }

implementation

uses
  SysUtils,
  Controls,
  ClipBrd,

  k2Tags,

  l3Nodes,
  l3AsincMessageWindow,
  l3String,
  l3Chars,
  l3Const,

  afwFacade,

  vcmBase,
  vcmForm,
  vcmSettings,
  vcmStringList,

  StdRes,
  SystemStr,

  DataAdapter,

  ComplectUnit,
  IOUnit,
  FiltersUnit,

  bsConvert,
  bsConst,
{$If not defined(Admin) AND not defined(Monitorings)}
  bsDataContainer,
  evCustomWikiReader,
  evDocumentEliminator,
  bsUtilsConst,
{$IfEnd}
  bsFrozenNode,

  nsAttributeTreeCacheNew,
  nsSettings,
  nsNodes,
  nsValueMapsIDs,
  nsValueMaps,
  nsListExecuteProgressIndicator,
  {$If not defined(Admin)}
  nsQuery,
  {$IfEnd}
  nsConst,
  {$If not (defined(Monitorings) or defined(Admin))}
  nsTimeMachine,
  deDocInfo,
  nsQuestionsWithChoices,
  {$IfEnd not (defined(Monitorings) or defined(Admin))}
  nsINodeWrap,

  L10nInterfaces,
  vcmGUI,

  SegmentsLayer_Const,
  Hyperlink_Const,
  Sub_Const,
  TextPara_Const,

  bsTypesNew,

  vcmMessagesSupport,

  l3DateSt
  , Common_F1CommonServices_Contracts
  ;

procedure bsAddLink(const aGen : Ik2TagGenerator;
                    aHandle    : Integer;
                    aStartPos,
                    aFinishPos : Integer);
begin
 with aGen do
 begin
  StartTag(k2_tiSegments);
  try
   StartChild(k2_typSegmentsLayer);
   try
    AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperLinks));
    StartChild(k2_typHyperLink);
    try
     AddIntegerAtom(k2_tiStart, aStartPos);
     AddIntegerAtom(k2_tiFinish, aFinishPos);
     AddIntegerAtom(k2_tiHandle, aHandle);
    finally
     Finish; {k2_typHyperLink}
    end;
   finally
    Finish; {k2_typSegmentsLayer}
   end;
  finally
   Finish; {k2_tiSegments}
  end;
 end;
end;

{$If not Defined(Admin) AND not Defined(Monitorings)}
procedure bsEditorAddWikiPara(const aGen  : Ik2TagGenerator;
                              const aText : Tl3WString;
                              aFixedFont  : Boolean;
                              aDeleteLink : Boolean);
var
 l_G : Ik2TagGenerator;
 l_E : TevDocumentEliminator;
 l_S : Il3CString;
begin
 l_S := l3CStr(aText);
 if not aDeleteLink then
  l_S := l3StringReplace(l_S,
                         str_wgReferenceHyperlinkSearchText.AsWStr,
                         str_wgReferenceHyperlinkReplaceText.AsWStr,
                         [rfReplaceAll])
 else
  l_S := l3StringReplace(l_S,
                         str_wgReferenceHyperlinkSearchText.AsWStr,
                         nsWStr(''),
                         [rfReplaceAll]);
 if aFixedFont then
 begin
  l_S := l3Cat('{fontsize:12}'#13#10 +
               '{justification:ev_itLeft}'#13#10, l_S);
  l_S := l3Cat(l_S, #13#10'{/justification}' +
                    #13#10'{/fontsize}');
 end//aFixedFont
 else
 begin // mdp.garant.ru/pages/viewpage.action?pageId=333545491
  l_S := l3Cat('{indent}'#13#10'{indent}'#13#10, l_S);
  l_S := l3Cat(l_S, #13#10'{/indent}'#13#10'{/indent}');
 end;
 l_G := aGen;
 l_E := TevDocumentEliminator.Create;
   // !!! SetTo ��� ������ ������������, �.�. ��� �������� � FakeStarts � ������ CloseStructure !!!
 try
  l_E.Start;
  try
   l_E.Generator := l_G;
   try
    l_G := l_E;
    TevCustomWikiReader.SetFromStringTo(l_G, l_S.AsWStr).Execute;
   finally
    l_E.Generator := nil;
   end;//try..finally
  finally
   l_E.Finish;
  end;//try..finally
 finally
  FreeAndNil(l_E);
 end;//try..finally
end;
                          
procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aAnchorNum     : TnsWarningSub;
                          aLinkHandle    : TnsWarningLinkHandle;
                          aLinkStartPos  : Integer;
                          aLinkEndPos    : Integer;
                          anAddLinkText  : Il3CString;
                          anAddLinkHandle: TnsWarningLinkHandle;
                          aForeColor     : TColor;
                          aFontItalic    : Boolean;
                          NullifyIndent  : Boolean;
                          aJust          : TevIndentType);

 procedure lp_AddSub(const aGen : Ik2TagGenerator;
                  aAnchorNum : TnsWarningSub);
 begin
  with aGen do
  begin
   StartChild(k2_typSub);
   try
    AddIntegerAtom(k2_tiHandle, Ord(aAnchorNum));
   finally
    Finish; {k2_typSub}
   end;
  end;
 end;

var
 l_SegmentsStarted: Boolean;

 procedure lp_StartHyperLinks;
 begin
  if l_SegmentsStarted then
   Exit;
  with aGen do
  begin
   StartTag(k2_tiSegments);
   StartChild(k2_typSegmentsLayer);
   AddIntegerAtom(k2_tiHandle, Ord(ev_slHyperLinks));
  end;
  l_SegmentsStarted := true;
 end;

 procedure lp_FinishHyperLinks;
 begin
  if not l_SegmentsStarted then
   Exit;
  with aGen do
  begin
   Finish;
   Finish;
  end;
  l_SegmentsStarted := false;
 end;

 procedure lp_AddHyperLink(aHandle: TnsWarningLinkHandle; aStartPos, aFinishPos : Integer);
 begin
  lp_StartHyperLinks;
  with aGen do
  begin
   StartChild(k2_typHyperLink);
   try
    AddIntegerAtom(k2_tiStart, aStartPos);
    AddIntegerAtom(k2_tiFinish, aFinishPos);
    AddIntegerAtom(k2_tiHandle, Ord(aHandle));
   finally
    Finish; {k2_typHyperLink}
   end;//try..finally
  end;//with aGen
 end;

var
 l_SearchString: Il3CString;
 l_Pos: Integer;
 l_AdditionalPos: Integer;
begin
 with aGen do
 begin
  StartChild(k2_typTextPara);
  try
   if NullifyIndent
      OR aFixedFont
      // - ��� �������� ������ ������� ������ ������ ��������� � 0
      // http://mdp.garant.ru/pages/viewpage.action?pageId=265408824&focusedCommentId=265409530#comment-265409530
      then
    AddIntegerAtom(k2_tiFirstIndent, 0);
   if aFixedFont then
   // http://mdp.garant.ru/pages/viewpage.action?pageId=265408824&focusedCommentId=265409618#comment-265409618
    AddIntegerAtom(k2_tiJustification, Ord(ev_itLeft))
   else
   if (aJust <> ev_itNone) then
    AddIntegerAtom(k2_tiJustification, Ord(aJust));
   // ��������� Sub:
   if (aAnchorNum > cNoneWarningSub) then
    lp_AddSub(aGen, aAnchorNum);
   l_SegmentsStarted := False;
   try
    // ��������� ������:
    if (aLinkHandle > cNone_LinkHandle) then
     lp_AddHyperLink(aLinkHandle, aLinkStartPos, aLinkEndPos);
    // ���������� ������ ������
    if not l3IsNil(anAddLinkText) and (anAddLinkHandle <> cNone_LinkHandle) then
    begin
     l_AdditionalPos := 0;
     l_SearchString := l3CStr(aText);
     repeat
      l_Pos := l3Pos(l_SearchString, anAddLinkText);
      if l_Pos <> l3NotFound then
      begin
       lp_AddHyperLink(anAddLinkHandle,
                       l_Pos + l_AdditionalPos + 1,
                       l_Pos + l_AdditionalPos + l3Len(anAddLinkText));
       l3Delete(l_SearchString, 0, l_Pos + l3Len(anAddLinkText));
       Inc(l_AdditionalPos, l_Pos + l3Len(anAddLinkText));
      end;//l_Pos <> l3NotFound
     until l_Pos = l3NotFound;
    end;
   finally
    lp_FinishHyperLinks;
   end;
   // ���� ������:
   StartTag(k2_tiFont);
   try
    if aFixedFont then
     AddIntegerAtom(k2_tiSize, 12);
    AddIntegerAtom(k2_tiForeColor, aForeColor);
    AddBoolAtom(k2_tiItalic, aFontItalic);
   finally
    Finish;
   end;//try..finally
   // ��������� �����:
   AddStringAtom(k2_tiText, aText);
  finally
   Finish; {ee_idTextPara}
  end;//try..finally
 end;//with aGen
end;//AddPara

procedure bsEditorAddPara(const aGen     : Ik2TagGenerator;
                          const aText    : Tl3WString;
                          aFixedFont     : Boolean;
                          aJust          : TevIndentType;
                          NullifyIndent  : Boolean);
  { - }
begin
 bsEditorAddPara(aGen, aText, aFixedFont,
                 cNoneWarningSub,
                 cNone_LinkHandle,
                 0,
                 0,
                 nil,
                 cNone_LinkHandle,
                 clWindowText,
                 False,
                 NullifyIndent,
                 aJust
                 );
end;
{$IfEnd}

function bsConsultationName(const aConsultation: IConsultation): Il3CString;
  {* - ��� ������������. }
var
 l_Name: IString;
begin
 if aConsultation <> nil then
 begin
  aConsultation.GetName(l_Name);
  try
   Result := nsCStr(l_Name);
  finally
   l_Name := nil;
  end;//try..finally
 end//if aConsultation <> nil then
 else
  Result := nil;
end;//bsConsultationName

function bsIsSame(const aValue1 : IConsultation;
                  const aValue2 : IConsultation): Boolean;
  {* - ���������� ��� ������������. }
var
 l_Value1 : IString;
 l_Value2 : IString;
begin
 Result := False;
 try
  aValue1.GetId(l_Value1);
 except
  on EDeleted do
   Exit;
 end;
 try
  try
   aValue2.GetId(l_Value2);
  except
   on EDeleted do
    Exit;
  end;
  try
   Result := l3Same(nsCStr(l_Value1), nsCStr(l_Value2));
  finally
   l_Value2 := nil;
  end;//try..finally
 finally
  l_Value1 := nil;
 end;//try..finally
end;

function bsGetConsultation(const aNode: Il3SimpleNode): IConsultation;
  {* - ������� ������������. }
var
 l_Node   : INode;
 l_Entity : IUnknown;
begin
 Result := nil;
 if bsCheckNodeType(aNode, FIT_CONSULTATION) and
  Supports(aNode, INode, l_Node) then
 try
  l_Node.Open(l_Entity);
  try
   Supports(l_Entity, IConsultation, Result);
  finally
   l_Entity := nil;
  end;{try..finally}
 finally
  l_Node := nil;
 end;{try..finally}
end;//bsGetConsultation

function bsCanExportNodeToXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� �������������� ����. }
var
 l_Node: IFoldersNode;
begin
 Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanSaveToXml;
end;

procedure bsExportNodeToXML(const aNode     : Il3SimpleNode;
                            const aFileName : Tl3WString);
  {* - �������������� ����. }
var
 l_Node: IFoldersNode;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
  l_Node.SaveToXml(nsAStr(aFileName).S);
end;

function bsCanImportNodeFromXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� ������������� � ����. }
var
 l_Node: IFoldersNode;
begin
  Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanLoadFromXml;
end;

procedure bsImportNodeFromXML(const aNode     : Il3SimpleNode;
                              const aFileName : Tl3WString);
  {* - ������������� � ����. }
var
 l_Node: IFoldersNode;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
  l_Node.LoadFromXml(nsAStr(aFileName).S);
end;

function bsCanExportNodeToIntegrationXML(const aNode: Il3SimpleNode): Boolean;
  {* - ����� �� �������������� ����. }
var
 l_Node: IFoldersNode;
begin
  Result := Supports(aNode, IFoldersNode, l_Node) and l_Node.CanSaveToIntegrationXml;
end;

procedure bsExportNodeToIntegrationXML(const aNode: Il3SimpleNode);
  {* - ����� �� �������������� ����. }
var
 l_Node: IFoldersNode;
 l_XML: IString;
begin
 if Supports(aNode, IFoldersNode, l_Node) then
 begin
  l_Node.SaveToIntegrationXml(l_XML);
  with ClipBoard do
  begin
   Open;
   try
    AsText := StrPas(l_XML.GetData);
   finally
    Close;
   end;
  end;
 end;
end;

function bsCalcUniqueName(const aParent: Il3Node; const aName: Il3CString; const aSuffix: Il3CString): Il3CString;
  {* - ��������� ���������� ��� ��� ���������� � ����� }

 function lp_BuildName(const aName: Il3CString; const anIndex: Il3CString; const aSuffix: Il3CString): Il3CString;
 const
  c_MaxLen = 70;
 var
  l_Name: Il3CString;
 begin
  l_Name := aName;
  if (l3Len(aName) + l3Len(anIndex) + l3Len(aSuffix)) > c_MaxLen then
  begin
   l3SetLen(l_Name, c_MaxLen - l3Len(anIndex) - l3Len(aSuffix) - 3);
   l_Name := l3Cat(l3Trim(l_Name), '...');
  end;
  Result := l3Cat([l_Name, anIndex, aSuffix]);
 end;

 function lp_BuildIndex(anIndex: Cardinal): Il3CString;
 begin
  if anIndex = 0 then
   Result := nil
  else
   Result := l3Fmt(l3CStr(' %d'), [anIndex]);
 end;

var
 l_NewName: Il3CString;

 function lp_CheckUniqueCaption(const Intf: Il3Node): Boolean;
 begin
  Result := l3Same(l_NewName, Intf.Text);
 end;

var
 l_Index: Cardinal;

begin
 l_Index := 0;
 repeat
  l_NewName := lp_BuildName(aName, lp_BuildIndex(l_Index), aSuffix);
  Inc(l_Index);
 until (aParent = nil) or (aParent.IterateF(l3L2NA(@lp_CheckUniqueCaption), imCheckResult) = nil);
 Result := l_NewName;
end;

function bsHasFlag(const aNode  : Il3SimpleNode;
                   const aFlags : array of LongWord): Boolean;
  // overload;
  {* - ������� ����� � ���� INode. }
var
 l_Node: INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
  Result := bsHasFlag(l_Node, aFlags);
end;

function bsHasFlag(const aFlags      : LongWord;
                   const aCheckFlags : array of LongWord): Boolean;
  {* - ��������� ������� �����. }
var
 l_Index : Integer;
begin
 Result := False;
 for l_Index := Low(aCheckFlags) to High(aCheckFlags) do
  if aFlags and aCheckFlags[l_Index] = aCheckFlags[l_Index] then
  begin
   Result := True;
   Break;
  end;
end;

function bsHasFlag(const aFlags      : LongWord;
                   aCheckFlag : LongWord): Boolean;
  //overload;
  {* - ��������� ������� �����. }
begin
 Result := bsHasFlag(aFlags, [aCheckFlag]);
end;

function bsHasFlag(const aNode  : INode;
                   const aFlags : array of LongWord): Boolean;
  // overload;
  {* - ������� ����� � ���� INode. }
begin
 Result := bsHasFlag(LongWord(aNode.GetFlags), aFlags);
end;

function bsHasFlag(const aNode  : IeeNode;
                   const aFlags : array of LongWord): Boolean;
  {* - ������� ����� � ���� INode. }
var
 l_Node  : INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
 try
  Result := bsHasFlag(l_Node, aFlags);
 finally
  l_Node := nil;
 end{try..finally}
end;//HasFlag

function bsCheckNodeType(const aNode : Il3SimpleNode;
                         const aType : TFoldersItemType): Boolean;

  {-}
var
 l_Node: INode;
begin
 Result := False;
 if Supports(aNode, INode, l_Node) then
 try
  Result := TFoldersItemType(l_Node.GetObjectType) = aType;
 finally
  l_Node := nil;
 end;{try..finally}
end;//TypeNode

function bsDocumentList(const aEntity: ISearchEntity): IDynList;
  {* - �������� ������ ���������� �� aEntity. }
var
 l_List: ISearchDynList;
begin
 if Supports(aEntity, ISearchDynList, l_List) then
 try
  l_List.GetDynList(Result);
 finally
  l_List := nil;
 end;{try..finally}
end;//bsDocumentList

function bsGetOperations(const aTag : Il3CString) : TLogicOperationSet;
  overload;
  {* - �������� ������ ��������� ��������. }
var
 l_AttrInfo : IAttributeInfo;
begin
 Result := [];
 if not l3IsNil(aTag) then
 begin
  DefDataAdapter.Search.GetAttributeInfo(nsAStr(aTag).S, l_AttrInfo);
  try
   Result := bsGetOperations(l_AttrInfo);
  finally
   l_AttrInfo := nil;
  end;{try..finally}
 end;//if aTag <> '' then
end;//nsGetOperations

function bsGetOperations(const aAttrInfo : IAttributeInfo) : TLogicOperationSet;
  // overload;
  {* - �������� ������ ��������� ��������. }
var
 l_Operations : IOperationList;
 l_Index      : Integer;
begin
 Result := [];
 aAttrInfo.GetAvailableOperations(l_Operations);
 if Assigned(l_Operations) then
  try
   for l_Index := 0 to Pred(l_Operations.Count) do
    Include(Result, bsAdapterToBusiness(l_Operations[l_Index]));
  finally
   l_Operations := nil;
  end;{try..finally}
end;//nsGetOperations

function bsMonitoringList(const aEntity: ISearchEntity): IDynList;
  {* - �������� ����� ����������������. }
begin
 Supports(aEntity, IDynList, Result);
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsBuildFullList(const aList: IDynList): IDynList;
  {-}
var
 l_Entity: ISearchEntity;
 l_Succsess: Boolean;
 l_Short: IFilterable;
 l_Full: IFilterable;
 l_Filters: IFiltersFromQuery;
begin
 Result := aList;
 if Assigned(aList) and aList.GetIsShort then
 begin
  l_Succsess := TnsListExecuteProgressIndicator.Make(aList).Execute(vcmCStr(str_seSearchTitle), l_Entity);
  if l_Succsess and Assigned(l_Entity) then
   with l_Entity do
    case GetResultType of
     SRT_DOCUMENT_LIST:
      begin
       Result := bsDocumentList(l_Entity);
       if Supports(aList, IFilterable, l_Short) and Supports(Result, IFilterable, l_Full) then
       begin
        l_Short.GetActiveFilters(l_Filters);
        if Assigned(l_Filters) and (l_Filters.Count > 0) then
         l_Full.ApplyFilters(l_Filters);
       end;
      end;
    else
     Assert(False, '�� ��������������');
    end;//case l_Entity.GetResultType of
 end
end;
{$IfEnd} //not Admin

function bsComplectName: Il3CString;
  {* - �������� ���������. }
var
 l_Str: IString;
begin
 DefDataAdapter.CommonInterfaces.GetComplectName(l_Str);
 try
  Result := nsCStr(l_Str);
 finally
  l_Str := nil;
 end;{try..finally}
end;//bsComplectName

function bsBaseDate: System.TDateTime;
  {* - ���� ���������� ����. }
var
 l_Date: BaseTypesUnit.TDate;
begin
 DefDataAdapter.CommonInterfaces.GetBaseDate(l_Date);
 with l_Date do
  Result := EncodeDate(rYear, rMonth, rDay);
end;//bsBaseDate

function bsBaseDateStr: String;
  {* - ���� ���������� ����. }
begin
 //Result := l3DateToStr(bsBaseDate);
 Result := FormatDateTime('dd/mm/yyyy', bsBaseDate);
end;
  
function bsComplectOwner: Il3CString;
  {* - �������� ��������������� ��������� (��� ���� ������� ����). }
var
 l_Owner : IString;
begin
 DefDataAdapter.NativeAdapter.MakeComplectInfo.GetOwner(l_Owner);
 Result := nsCStr(l_Owner);
end;

function bsFindNodeByCaption(const aRoot : Il3Node;
                             const aNode : Tl3PCharLen): INodeBase;
  {* - ����� ���� �� ����� � ������� ���. }
begin//bsFindNodeByCaption
 Supports(l3SearchByName(aRoot, aNode), INodeBase, Result);
end;//bsFindNodeByCaption

{ ���� }

function bsIsDateEqual(const aDate1 : BaseTypesUnit.TDate;
                       const aDate2 : BaseTypesUnit.TDate): Boolean;
  {* - ���������� ��������� ���. }
begin
 Result := (aDate1.rDay = aDate2.rDay) and
           (aDate1.rMonth = aDate2.rMonth) and
           (aDate1.rYear = aDate2.rYear);
end;//bsIsDataEqual

function bsIsOneOperation(const aOperations: TLogicOperationSet): Boolean;
  {* - ���������� �������� ��������� ��� ������� ��������. }
var
 l_Count : Integer;
 l_Op    : TLogicOperation;
begin
 l_Count := 0;
 Result := True;
 for l_Op := Low(TLogicOperation) to High(TLogicOperation) do
  if l_Op in aOperations then
  begin
   if l_Count = 0 then
    inc(l_Count)
   else
   begin
    Result := False;
    Exit;
   end
  end;
end;//bsIsOneOperation

function bsListPrintOnlyFirstLevel(aList: TbsListType): Boolean;
  {-}
begin
 case aList of
  bs_ltDocument:
   Result := afw.Settings.LoadBoolean(pi_DocumentList_PrintOnlyFirstLevel,
    dv_DocumentList_PrintOnlyFirstLevel);
  bs_ltDrug:
   Result := afw.Settings.LoadBoolean(pi_DrugList_PrintOnlyFirstLevel,
    dv_DrugList_PrintOnlyFirstLevel);
  else
  begin
   Result := True;
   Assert(False);
  end;
 end;
end;

function bsIsListChanged(const aList: IDynList): Boolean;
  {* - ���������� ��� �� ������� ������. }
var
 l_Entity: IEntityBase;
begin
 Result := False;
 if Supports(aList, IEntityBase, l_Entity) then
 try
  try
   Result := l_Entity.GetIsChanged;
  except
   on ECanNotFindData do
    Result := False;
  end;
 finally
  l_Entity := nil;
 end;{try..finally}
end;//bsIsListChanged

function bsIsListEmpty(const aList: IDynList): Boolean;
  {* - ���������� ������ �� ������. }
var
 l_Root: INodeBase;
begin
 Result := False;
 Assert(aList <> nil);
 l_Root := nil;
 aList.GetRoot(l_Root);
 Assert(l_Root <> nil);
 try
  Result := (l_Root.GetChildCount = 0);
 finally
  l_Root := nil;
 end;
end;

function bsLanguageCaption(const aLanguage: TbsLanguage): Il3CString;
  {* - ���������� ������ ��� ����� ����������� � StdRes.ImageList. }
begin
 Result := nsIntegerMapManager.Map[imap_Interface_Language].ValueToDisplayName(Ord(aLanguage));
end;

function bsLanguageImage(const aLanguage: TbsLanguage): Integer;
  {* - ���������� ������ ��� ����� ����������� � StdRes.ImageList. }
begin
 Result := cDocumentImage;
 case aLanguage of
  LG_RUSSIAN : Result := cRussianLangImage;
  LG_ENGLISH : Result := cEnglishLangImage;
  LG_GERMAN  : Result := cGermanLangImage;
  LG_FRENCH  : Result := cFrenchLangImage;
  LG_SPANISH : Result := cSpanishLangImage;
  LG_ITALIAN : Result := cItalianLangImage;
  else
   Assert(False);
 end;
end;

function bsIsListSaved(const aList: IDynList): Boolean;
  {* - ���������� ��� �� �������� ������. }
var
 l_Entity: IEntityBase;
begin
 Result := False;
 if Supports(aList, IEntityBase, l_Entity) then
  Result := l_Entity.GetIsSaved;
end;

function bsListCreationHistory(const aList: IDynList): Il3CString;
  {* - ���������� ������� ��������, ��������� ������. }
var
 l_Info : IString;
begin
 if Assigned(aList) then
  aList.GetHistory(l_Info)
 else
  l_Info := nil;
 Result := nsCStr(l_Info);
end;

function bsListName(const aList: IDynList): Il3CString;
  {* - ���������� ��� ������. }
var
 l_String: IString;
begin
 if (aList <> nil) then
  aList.GetName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function bsShortListName(const aList: IDynList): Il3CString;
  {* - ���������� �������� ������. }
var
 l_String: IString;
begin
 if (aList <> nil) then
  aList.GetShortName(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function bsDocCount(const aList: IDynList): Integer;
  {* - ���������� ���������� � ������. }
var
 l_Root: INodeBase;
begin
 Result := 0;
 if Assigned(aList) then
 begin
  try
   aList.GetRoot(l_Root);
   try
    Result := l_Root.GetChildCount;
   finally
    l_Root := nil;
   end;
  except
   on ECanNotFindData do
    Result := 0;
  end;
 end;
end;

function bsListClone(const aList : IDynList) : IDynList;
  {* - ������������ ������. }
var
 l_List: ICatalogBase;
begin
 Result := nil;
 if Assigned(aList) then
 try
  aList.Clone(l_List);
  Supports(l_List, IDynList, Result);
 except
  on ECanNotFindData do
 end;
end;//bsListClone

function bsExtractDocument(const aListNode : Il3SimpleNode): IDocument;
  // overload;
  {* - ��������� �� �������� ������ ��������. }
var
 l_Node: INodeBase;
begin
 Result := nil;
 if Supports(aListNode, INodeBase, l_Node) then
 try
  Result := bsExtractDocument(l_Node);
 finally
  l_Node := nil;
 end;{try..finally}
end;

function bsExtractDocument(const aListNode : INodeBase): IDocument;
  // overload;
  {* - ��������� �� �������� ������ ��������. }
var
 l_Info: IListEntryInfo;
 l_MedInfo: IPharmFirmListEntry;
begin
 l_Info := bsListEntryInfo(aListNode);
 if l_Info <> nil then
 try
  l_Info.GetDoc(Result);
 finally
  l_Info := nil;
 end
 else
 begin
  l_MedInfo := bsMedicFirmListEntryInfo(aListNode);
  if l_MedInfo <> nil then
  try
   l_MedInfo.GetDocument(Result)
  finally
   l_MedInfo := nil;
  end
  else
   Result := nil;
 end;
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsConvertFilteredCRNode(const aNode: Il3SimpleNode): Il3SimpleNode;
  {* - �� ������������� ���� �������� �������������� ������ �� ������ �������� ��� }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := TnsINodeWrap.Make(TbsCRTypeFrozen.Make(l_Node).Value)
 else
  Result := nil;
end;
{$IfEnd}

function bsRedationInfo(const aDocument: IDocument): TRedactionInfo;
  {* - �������� ���������� � ��������� ���������. }
var
 l_State: IDocumentState;
begin
 l3FillChar(Result, SizeOf(Result), 0);
 if Assigned(aDocument) then
 begin
  aDocument.GetCurrentState(l_State);
  try
   l_State.GetCurrentRedaction(Result);
  finally
   l_State := nil;
  end;//try..finally
 end;//if Assigned(aDocument) then
end;//bsRedationInfo

function bsIsCRUseAsUserCR(const aType : TlstCRType;
                           out aWeight : Integer): Boolean;
  {* - ���������� ������������ �� ����\���� ��� ���������������� ��������. }
var
 l_Resp: Integer;
 l_Corr: Integer;

 function lp_AllDocumentsSelected(const aType        : TlstCRType;
                                  var aIndex         : Integer): Boolean;
   {* - ���� �� ����� ��� ���������������� ��������. }
 begin
  Result := False;
  if (bsUserCRList(ulFirst) = aType) and
   not bsIsCRNodeAreNotAllDocuments(bsUserCRNode(ulFirst)) then
  begin
   Result := True;
   aIndex := 0;
  end;//if (bsUserCRList(ulFirst) = aType) and
  if (bsUserCRList(ulSecond) = aType) and
   not bsIsCRNodeAreNotAllDocuments(bsUserCRNode(ulSecond)) then
  begin
   Result := True;
   aIndex := 1;
  end;//if (bsUserCRList(ulSecond) = aType) and
 end;//bsHasUserCRType

begin
 Result := False;
 if lp_AllDocumentsSelected(crtRespondents, l_Resp) and
  lp_AllDocumentsSelected(crtCorrespondents, l_Corr) then
 begin
  case aType of
   crtCorrespondents:
    aWeight := c_bsCRWeights[l_Corr];
   crtRespondents:
    aWeight := c_bsCRWeights[l_Resp];
  end;
  Result := True;
 end;//if lp_AllDocumentsSelected(crtRespondents, l_Resp) and
end;//IsCRUseAsUserCR

function bsUserCRNode(const aValue: TnsUserCRListId): IbsFrozenNode;
  {* - ��� ��� ������ ���������������� ��������. }
var
 l_Converter: IbsCRSettingsConverter;
begin
 case aValue of
  ulFirst:
   if Supports(nsStringMapManager.Map[smap_SettingsCRType],
               IbsCRSettingsConverter,
               l_Converter) then
    Result := l_Converter.GetCRNodeByValue(
     afw.Settings.LoadString(pi_Document_CRType0, dv_Document_CRType0));
  ulSecond:
   if Supports(nsStringMapManager.Map[smap_SettingsCRType],
               IbsCRSettingsConverter,
               l_Converter) then
    Result := l_Converter.GetCRNodeByValue(afw.Settings.
     LoadString(pi_Document_CRType1, dv_Document_CRType1));
  else
  begin
   Result := nil;
   Assert(False);
  end;//else
 end;//case aValue of
end;//bsUserCRNode

(*function bsGetAllDocumentsCRNode: IbsFrozenNode;
  {* - ���� ��� ��������� }
var
 l_Converter: IbsCRSettingsConverter;
begin
 if Supports(nsStringMapManager.Map[smap_SettingsCRType],
             IbsCRSettingsConverter,
             l_Converter) then
  Result := l_Converter.GetCRNodeByValue(nsIntegerMapManager.Map[imap_SettingsCRTypes].ValueToDisplayName(Ord(PIT_ALL_DOCS)))
 else
  Result := nil;
end;*)

function bsUserCRList(const aValue: TnsUserCRListId): TlstCRType;
  {* - ��� ������ ���������������� �������� ���. }
begin
 case aValue of
  ulFirst:
   Result := TlstCRType(afw.Settings.LoadInteger(pi_Document_CRSheet0,
                                                 dv_Document_CRSheet0));
  ulSecond:
   Result := TlstCRType(afw.Settings.LoadInteger(pi_Document_CRSheet1,
                                                 dv_Document_CRSheet1));
  else
  begin
   Result := Low(TlstCRType);
   Assert(False);
  end;//else
 end;//case aValue of
end;//bsUserCRList

function bsGetCRType(const aNode: Il3SimpleNode): TNodeType;
  {* - ��� ���. }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := l_Node.GetType
 else
  Result := High(TNodeType);
end;

function bsIsCRNodeAreNotAllDocuments(const aNode: IbsFrozenNode): Boolean;
  {* - ���� ��� �� �������� "��� ���������". }
begin
 if Assigned(aNode) and aNode.HasNode then
  Result := bsIsCRNodeAreNotAllDocuments(aNode.Value)
 else
  Result := true;
end;

function bsIsCRNodeAreNotAllDocuments(const aNode: INodeBase): Boolean;
  {* - ���� ��� �� �������� "��� ���������". }
begin
 if (aNode = nil) then
  Result := true
 else
  // � ����� � ������ 64-������� kind ����������� ������������ ���
  // http://mdp.garant.ru/pages/viewpage.action?pageId=466761779
  Result := aNode.GetType <> ALL_DOCUMENTS_KIND;
  (*Result := TPrefixItemType(aNode.GetType) <> PIT_ALL_DOCS;*)
end;

{$If not defined(Admin) AND not defined(Monitorings)}
function bsDocInfoMake(const aData                     : IListEntryInfo;
                       const aListNode                 : INodeBase = nil;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
  {* - ��������� ��������� ������ ������� ��� ������������� ������ ��������. }
begin
 if (aData <> nil) then
 begin
  Result := TdeDocInfo.MakeFromList(TbsListNodeContainer.Make(aListNode, aData),
                                    TnsListInfo_C(aList,
                                                  aListNode,
                                                  aListRoot,
                                                  aCorrectByTimeMachine,
                                                  aQueryInfo),
                                    TbsDocPos_C(bsAdapterToBusiness(aData.GetType),
                                                aData.GetPosition),
                                    aLanguage);
 end//aData <> nil
 else
  Result := nil;
end;

function bsDocInfoMake(const aListNode                 : INodeBase;
                       const aList                     : IDynList = nil;
                       const aLanguage                 : TbsLanguage = LG_RUSSIAN;
                       const aListRoot                 : INodeBase = nil;
                       const aCorrectByTimeMachine     : Boolean = False;
                       const aQueryInfo: IdeSearchInfo = nil): IdeDocInfo;
  {* - ��������� ��������� ������ ������� ��� ������������� ������ ��������. }
var
 l_Info: IListEntryInfo;
 l_MedInfo: IPharmFirmListEntry;
begin
 l_Info := bsListEntryInfo(aListNode);
 if l_Info <> nil then
 begin
  try
   Result := TdeDocInfo.MakeFromList(TbsListNodeContainer.Make(aListNode,
                                                               l_Info),
                                     TnsListInfo_C(aList,
                                                   aListNode,
                                                   aListRoot,
                                                   aCorrectByTimeMachine,
                                                   aQueryInfo),
                                     TbsDocPos_C(bsAdapterToBusiness(l_Info.GetType),
                                                 l_Info.GetPosition),
                                     aLanguage);
  finally
   l_Info := nil;
  end;//if Supports(l_Entity,
 end//if Assigned(aListNode) then
 else
 begin
  l_MedInfo := bsMedicFirmListEntryInfo(aListNode);
  if l_MedInfo <> nil then
  try
   Result := TdeDocInfo.MakeFromList(TbsMedicFirmNodeContainer.Make(aListNode,
                                                                    l_MedInfo),
                                     TnsListInfo_C(aList,
                                                   aListNode,
                                                   aListRoot,
                                                   aCorrectByTimeMachine,
                                                   aQueryInfo),
                                     TbsDocPos_E,
                                     aLanguage);
  finally
   l_MedInfo := nil;
  end
  else
   Result := nil;
 end;
end;//bsDocInfoMake
{$IfEnd}

function bsCreateEditionDateInterval(const anActivIntervals: IActiveIntervalList): Il3CString;
  {* - ����������� �������� ��������. }
var
 l_IntervalStr : Il3CString;
 J             : Integer;
 l_Count       : LongInt;
 l_Interval    : TDateInterval;
begin
 if (anActivIntervals = nil) then
 // http://mdp.garant.ru/pages/viewpage.action?pageId=260447845&focusedCommentId=320742195#comment-320742195
 begin
  Result := nil;
  Exit;
 end;//anActivIntervals = nil
 l_Count := anActivIntervals.Count;
 if l_Count = 0 then
  Result := nil
 else
  if (l_Count - 1 = 0) then
  begin
   anActivIntervals.pm_GetItem(0, l_Interval);
   l_IntervalStr := IntervalToString(l_Interval);
   if not l3IsNil(l_IntervalStr) then
    Result := l3Cat([vcmCStr(str_dwRedactionDateDiapazone), l_IntervalStr])
   else
    Result := nil;
  end//l_Count - 1 = 0
  else
  begin
   Result := vcmCStr(str_dwRedactionDateDiapazones);

   for J := 0 to l_Count - 1 do
   begin
    anActivIntervals.pm_GetItem(J, l_Interval);
    Result := l3Cat([Result, IntervalToString(l_Interval)]);
    if (J <> (l_Count - 1)) then
     Result := l3Cat(Result, ', ');
   end;//for J
  end;//l_Count - 1 = 0
end;

{$If not (defined(Monitorings) or defined(Admin))}
function bsCreatePrintEditionWarning(const aDocument: IDocument): Il3CString;
  {* - ����������� �������������� ��� �������� ��� ������. }
var
 l_State: IDocumentState;
 l_RedactionInfo    : TRedactionInfo;
 l_DateInterval: Il3CString;
begin
 aDocument.GetCurrentState(l_State);
 if not TCommonService.Instance.IsCurEditionActual(l_State) then
 begin
  l_State.GetCurrentRedaction(l_RedactionInfo);
  l_DateInterval := bsCreateEditionDateInterval(l_RedactionInfo.rActiveIntervals);
  if Assigned(l_DateInterval) then
   Result := vcmFmt(str_PrintEditionWarningWithDate,[l_DateInterval])
  else
   Result := vcmCStr(str_PrintEditionWarning);
 end
 else
  Result := nil;
end;
{$IfEnd}

function bsListType(const aList: IDynList): TbsListType;
  {* - ��� ������. }
begin
 Result := bs_ltNone;
 if (aList <> nil) then
  case aList.GetContentType of
   DLC_LEGAL_DOCUMENTS:
    Result := bs_ltDocument;
   DLC_MEDICAL_DOCUMENTS:
    Result := bs_ltDrug;
   else
    Assert(False);
  end;//case ImpList.GetContentType of
end;

function bsListNodeType(const aNode: INodeBase): TbsListNodeType;
  {* - ��� ����. }
begin
 if Assigned(aNode) then
  Result := cbsListNodeTypeMap[TListNodeType(aNode.GetType)]
 else
  Result := lntDocActive;
end;

procedure bsMakeNewListName(const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  {* - �������� ��� ������ ������. }
begin
 bsMakeNewListName(nil, aSource, aTarget, aSelected);
end;

procedure bsMakeNewListName(const aParent   : Il3Node;
                            const aSource   : IDynList;
                            const aTarget   : IDynList;
                            const aSelected : Integer);
  {* - �������� ��� ������ ������. }
var
 l_NewName: Il3CString;
 l_Name  : IString;
const
 c_Frm  = ' (%d)';

  begin
 l_NewName := bsCalcUniqueName(aParent, bsListName(aSource), l3Fmt(l3CStr(c_Frm), [aSelected]));
 l_Name := nsIStr(l_NewName);
 try
  aTarget.SetName(l_Name);
 finally
  l_Name := nil;
 end;//try..finally
end;//bsMakeNewListName

function bsListEntryInfo(const aNode: Il3SimpleNode): IListEntryInfo;
  // overload;
  {* - �������� ��������� ��� ������ � ����� ������. }
var
 l_Node: INodeBase;
begin
 if Supports(aNode, INodeBase, l_Node) then
  Result := bsListEntryInfo(l_Node)
 else
  Result := nil;
end;

function bsListEntryInfo(const aNode: INodeBase): IListEntryInfo;
  {* - �������� ��������� ��� ������ � ����� ������. }
var
 l_Entity: IEntityBase;
begin
 if (aNode <> nil) then
 begin
  try
   aNode.GetEntity(l_Entity);
   try
    Supports(l_Entity, IListEntryInfo, Result);
   finally
    l_Entity := nil;
   end;//try..finally
  except
   // �������� �� ����� ���� ��������:
   on ENoEntity do
    Result := nil;
  end;//try..except
 end//aNode <> nil
 else
  Result := nil;
end;

function bsMedicFirmListEntryInfo(const aNode: INodeBase): IPharmFirmListEntry;
  {* - �������� ��������� ��� ������ � ����� ������. }
var
 l_Entity: IEntityBase;
begin
 if (aNode <> nil) then
 begin
  try
   aNode.GetEntity(l_Entity);
   try
    Supports(l_Entity, IPharmFirmListEntry, Result);
   finally
    l_Entity := nil;
   end;//try..finally
  except
   // �������� �� ����� ���� ��������:
   on ENoEntity do begin end;
  end;//try..except
 end//aNode <> nil
 else
  Result := nil;
end;

function bsMakeSearchVisualizer(const aContext: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ������. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(vcmFmt(str_SearchContextMessage,
                                                            [aContext]),
                                                     0,
                                                     afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cFindContextImage)
end;

function bsMakeSaveVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ����������. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(aCaption, 0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cSaveToFileImage);
end;

function bsMakeExportVisualizer(const aCaption: Il3CString): IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ ��������. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(aCaption, 0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cExportToWordImage);
end;

function bsMakeEMailVisualizer: IafwLongProcessVisualizer;
  {* - ������� ����������� ���� ��� ������������ �������� �� �����. }
begin
 Result := afw.Application.MakeLongProcessVisualizer(vcmCStr(str_MailVisualizer),
                                                     0, afw_lpwTimeout,
                                                     dmStdRes.LargeImageList,
                                                     cExportToEMailImage);
end;

{$If not (defined(Monitorings) or defined(Admin))}
function bsCorrectMistakes(const aContext: Il3CString; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean; overload;
  {* - ��������� �������� � ������������ �������� � ������������� ��������. }
var
 l_Context: Il3StringsEx;
begin
 l_Context := TvcmStringList.Make;
 l_Context.Add(aContext);
 Result := bsCorrectMistakes(l_Context, aForInpharm, aCorrector);
end;

function bsCorrectMistakes(const aContext: Il3StringsEx; aForInpharm: Boolean;
     const aCorrector: InsMistakesCorrector): Boolean;
  {* - ��������� �������� � ������������ �������� � �������������� ��������. }
var
 l_Visualizer : IafwLongProcessVisualizer;
 l_CorrectedContext: Il3StringsEx;
 l_MistakesList: Il3StringsEx;
 l_Words: Il3CString;
 l_IDX: Integer;
 l_AskResult: Integer;
begin
 l_Visualizer := afw.Application.MakeLongProcessVisualizer(vcmCStr(str_ParsingContext),
                                                     0,
                                                     100,
                                                     dmStdRes.LargeImageList,
                                                     cFindContextImage);
 try
  Result := DefDataAdapter.CorrectMistakes(aContext, aForInpharm, l_CorrectedContext,
                                           l_MistakesList);
 finally
  l_Visualizer := nil;
 end;
 if Result then
 begin
  Assert(Assigned(aCorrector));
  aCorrector.Correct(l_CorrectedContext, l_MistakesList);
  if Assigned(l_MistakesList) then
  begin
   l_Words := nil;
   for l_IDX := 0 to l_MistakesList.Count - 1 do
   begin
    if Assigned(l_Words) then
     l_Words := l3Cat([l_Words, l3CStr(', ')]);
    l_Words := l3Cat([l_Words, l_MistakesList.ItemC[l_IDX]]);
   end;
   l_AskResult := vcmMessageDlg(str_SearchUnresolvedContext,[l_Words]);
   if (l_AskResult = mrNo) OR (l_AskResult = -2) then
    Result := False;
  end;//Assigned(l_MistakesList)
 end;//Result
end;
{$IfEnd}

end.
