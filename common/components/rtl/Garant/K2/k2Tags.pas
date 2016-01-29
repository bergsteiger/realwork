unit k2Tags;
{* �������� ��������������� ����������� ����� � �����. }

{ ���������� "K-2"        }
{ �����: ����� �.�. �     }
{ ������: k2Tags - }
{ �����: 05.05.1998 09:54 }
{ $Id: k2Tags.pas,v 1.203 2015/04/21 07:06:53 dinishev Exp $ }

// $Log: k2Tags.pas,v $
// Revision 1.203  2015/04/21 07:06:53  dinishev
// {Requestlink:596845383}
//
// Revision 1.202  2014/07/01 12:21:19  lulin
// - �������� ������� ��������������.
//
// Revision 1.201  2014/06/26 16:52:40  lulin
// - �������� ��� ��������������� ������������� ����� � �����.
//
// Revision 1.200  2014/06/25 15:24:32  lulin
// - ������ ����������� ��������� � ��������� ������.
//
// Revision 1.199  2014/06/25 14:19:45  lulin
// - ������ ����������� ��������� � ��������� ������.
//
// Revision 1.198  2014/03/03 16:07:51  lulin
// - ����������� �� �����������.
//
// Revision 1.197  2013/10/22 16:21:05  lulin
// - ������������ ������� �����, ����� ��������� �� "���������" � ����������������.
//
// Revision 1.196  2013/10/17 17:15:58  lulin
// - ������ �� ���������� �� ��������� Enum.
//
// Revision 1.195  2013/10/17 15:52:42  lulin
// - ������ �� ���������� �� ��������� Enum.
//
// Revision 1.194  2013/10/16 17:10:55  lulin
// - bug fix: �� �������� ��� �������������� �������������� ����.
//
// Revision 1.193  2013/10/16 16:33:55  lulin
// {RequestLink:280859697}.
//
// Revision 1.192  2013/10/16 12:21:56  lulin
// {RequestLink:280859697}.
//
// Revision 1.191  2013/09/13 14:42:08  lulin
// - ��������� ����� ��� ���������.
//
// Revision 1.190  2013/06/19 16:51:09  lulin
// {RequestLink:461701432}.
//
// Revision 1.189  2012/10/26 16:44:14  lulin
// - �������� ��������� ����� ���������.
//
// Revision 1.188  2012/05/24 13:52:09  lulin
// {RequestLink:360022952}
//
// Revision 1.187  2012/02/29 08:32:39  lulin
// {RequestLink:336664105}
//
// Revision 1.186  2012/01/30 13:18:35  lulin
// {RequestLink:332563400}
//
// Revision 1.185  2011/11/29 17:34:22  lulin
// {RequestLink:232098711}.
// - ����� ������ �������� �� ������.
//
// Revision 1.184  2011/11/15 18:31:13  lulin
// {RequestLink:232098711}
//
// Revision 1.183  2011/10/17 11:59:24  lulin
// {RequestLink:294258021}.
//
// Revision 1.182  2011/09/07 17:48:29  lulin
// {RequestLink:278837795}.
//
// Revision 1.181  2011/08/30 12:14:37  lulin
// {RequestLink:280859680}.
//
// Revision 1.180  2011/08/02 16:42:38  lulin
// {RequestLink:272663564}.
//
// Revision 1.179  2011/07/26 13:22:36  lulin
// {RequestLink:275780190}.
//
// Revision 1.178  2011/07/20 11:16:01  lulin
// {RequestLink:228688745}.
//
// Revision 1.177  2011/07/07 16:45:56  lulin
// {RequestLink:228688745}.
//
// Revision 1.176  2011/07/05 19:06:22  lulin
// {RequestLink:254944102}.
//
// Revision 1.175  2011/06/20 15:22:21  lulin
// {RequestLink:269083814}
//
// Revision 1.174  2011/05/23 15:33:31  lulin
// {RequestLink:266423791}.
//
// Revision 1.173  2011/03/02 18:29:15  lulin
// {RequestLink:254353230}.
//
// Revision 1.172  2011/02/22 13:57:42  lulin
// {RequestLink:182157315}.
//
// Revision 1.171  2010/11/24 11:12:24  lulin
// {RequestLink:238945411}.
//
// Revision 1.170  2010/11/18 12:20:59  lulin
// {RequestLink:242516109}.
//
// Revision 1.169  2010/09/03 12:04:59  dinishev
// [$234359474]
//
// Revision 1.168  2010/06/25 08:17:26  lulin
// {RequestLink:182452717}.
// - bug fix: �� ��� �������� ��� ContentsElement.
//
// Revision 1.167  2010/03/25 10:57:38  lulin
// {RequestLink:199590272}.
//
// Revision 1.166  2010/03/18 15:37:53  lulin
// {RequestLink:197497243}.
// - ������� ���.
//
// Revision 1.165  2010/02/11 14:13:58  lulin
// {RequestLink:190679656}.
//
// Revision 1.164  2009/11/11 14:21:16  lulin
// - ��������� ��� ��� ����������� ������� ������.
//
// Revision 1.163  2009/08/20 10:36:51  lulin
// - "��������" ��������� ������� ����������� ��� ����������.
//
// Revision 1.162  2009/07/15 16:24:30  lulin
// - ������� ������ ��������.
//
// Revision 1.161  2009/07/15 15:12:26  lulin
// - ������� �������� �������� ������� ����������.
//
// Revision 1.160  2009/07/09 19:11:21  lulin
// {RequestLink:141264340}. �10.
//
// Revision 1.159  2009/06/09 16:19:34  lulin
// - ������ ����������� ��������� ������� ��������� � ����������.
//
// Revision 1.158  2009/06/09 15:41:06  lulin
// - �������� ����������� ���������� ��������, �������� "���������" � ����������� �� �� ����� �������� ������.
//
// Revision 1.157  2009/04/22 14:21:42  lulin
// [$145097085].
//
// Revision 1.156  2009/03/27 15:38:05  lulin
// [$138549031].
//
// Revision 1.155  2009/03/04 13:33:12  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.154  2009/03/03 17:42:05  lulin
// - <K>: 137470629. ����� �������� ������������� ������.
//
// Revision 1.153  2009/03/03 17:27:26  lulin
// - <K>: 137470629. ��������� ��������� ����������� ����.
//
// Revision 1.152  2009/03/03 16:47:27  lulin
// - �������� � ������� ����������� ��������������� ����� �� ������.
//
// Revision 1.151  2009/02/16 11:38:29  lulin
// - <K>: 136271449.
//
// Revision 1.150  2009/01/12 13:35:08  lulin
// - <K>: 135594063.
//
// Revision 1.149  2009/01/12 11:22:09  lulin
// - <K>: 131793318. ��� ���������� DPI.
//
// Revision 1.148  2008/09/09 13:02:25  lulin
// - ��������� ���� ��� CaseCode.
//
// Revision 1.147  2008/07/16 12:16:43  lulin
// - ������� ���� ExternalNextVerLink, InternalNextVerLink.
//
// Revision 1.146  2008/06/11 07:57:23  lulin
// - ��������� ����� ������������ � ����������.
//
// Revision 1.145  2008/06/10 19:38:31  lulin
// - ���������� ������� ��� �������� ����������� �����.
//
// Revision 1.144  2008/06/09 15:29:58  lulin
// - ������ ����� EVD �� ������.
//
// Revision 1.143  2008/06/06 09:11:54  lulin
// - ������� �������� ���.
//
// Revision 1.142  2008/06/02 13:18:04  lulin
// - <K>: 89096952.
//
// Revision 1.141  2008/05/16 13:10:33  lulin
// - ���������� ���������� �������� ��� ������������ �����.
//
// Revision 1.140  2008/05/16 12:24:26  lulin
// - ���������� ������� �������� ��� ���� ����.
//
// Revision 1.139  2008/04/15 09:03:23  lulin
// - ������ �������� �������� - ����� ��������������� ������.
//
// Revision 1.138  2008/04/15 08:25:46  dinishev
// ��������������� ������ ��������
//
// Revision 1.137  2008/02/22 11:33:11  dinishev
// ��������� ����������� ��������� ������
//
// Revision 1.136  2008/02/11 13:16:24  lulin
// - �������� ��� ViewKind.
//
// Revision 1.135  2007/12/05 12:35:08  lulin
// - ������� �������� ���, ������������ ������� ����� � Head'�.
//
// Revision 1.134  2007/09/22 14:59:20  lulin
// - �������������, � ����� � ���������� �������� (������) ������ ��������� ����������.
//
// Revision 1.133  2007/09/20 14:06:24  lulin
// - �������� ��� ��������� � ���������.
//
// Revision 1.132  2007/09/03 14:31:01  lulin
// - �������� �������� � ������� �� ������� �������.
//
// Revision 1.131  2007/09/03 12:29:11  lulin
// - ��������������� ���.
//
// Revision 1.130  2007/09/03 10:46:49  lulin
// - ��������� ����� ����������.
//
// Revision 1.129  2007/08/31 15:34:35  lulin
// - cleanup.
//
// Revision 1.128  2007/08/31 13:37:23  lulin
// - ��������� �������� ����.
//
// Revision 1.127  2007/08/29 13:06:52  lulin
// - �������� ������������ �����.
//
// Revision 1.126  2007/08/08 13:26:34  lulin
// - ������� ���������� ��� (<K>-15958640).
//
// Revision 1.125  2007/08/02 15:07:48  lulin
// - ��� �������� � ��������� �������� ��������� �� DPI.
//
// Revision 1.124  2007/06/25 12:19:40  narry
// - ��������� ������� !SERVICEINFO
//
// Revision 1.123  2007/06/18 13:43:44  lulin
// - ������ �������� ��� (<K>-13795539).
//
// Revision 1.122  2007/06/18 11:25:28  lulin
// - �������� ������������ ��������� �������� (<K>-19333543).
//
// Revision 1.121  2007/06/08 09:17:21  lulin
// - �������� ���� ��-��������� ���������� � ��� (<K>-17335096).
//
// Revision 1.120  2007/06/06 07:11:01  lulin
// - �������� ��������� ���.
//
// Revision 1.119  2007/06/04 08:13:10  lulin
// - ������� �������� ��� (<K>-15663142).
//
// Revision 1.118  2007/05/30 10:49:05  lulin
// - �������� ������� ������������������ �������� �� ���������� ������, ������������� ��� � ��� (<K>-13239999).
//
// Revision 1.117  2007/05/29 13:04:01  lulin
// - �������� ��� ��� �������� ��������� �������� (<K>-13239724).
//
// Revision 1.116  2007/05/29 12:25:33  lulin
// - �������� �������� �������� ������������������ � ���������� ������ (<K>-13795407).
// - ������� �������� ��� (<K>-13795506).
//
// Revision 1.115  2007/05/29 07:15:38  lulin
// - �������� �������� ��� - "�������� ������ ��-���������" (<K>-13240502).
//
// Revision 1.114  2007/05/24 11:37:38  lulin
// - new behavior: � ����� �������� ����������� ����������, ���� �� ����� 4-� �����. ������ ����������� ������ ����������� �� ���������.
//
// Revision 1.113  2007/05/24 09:35:52  lulin
// - bug fix: �� ������, ���� ����� �������� �������������� ��������.
//
// Revision 1.112  2007/05/24 09:24:21  lulin
// - ��-������� �������������� ����������� ����������.
//
// Revision 1.111  2007/03/16 14:47:29  lulin
// - cleanup.
//
// Revision 1.110  2006/12/12 08:58:30  lulin
// - cleanup.
//
// Revision 1.109  2006/12/11 12:25:10  lulin
// - cleanup.
//
// Revision 1.108  2006/11/03 12:09:31  lulin
// - ������ ���, ��������� � ��������� ��������� ���������.
//
// Revision 1.107  2006/11/03 11:00:44  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.106.2.3  2006/10/26 12:03:59  lulin
// - �������� �������� ����.
//
// Revision 1.106.2.2  2006/10/26 11:48:22  oman
// - fix: ����� ���������� ������ ���������� k2_tiVisibleIndex
//
// Revision 1.106.2.1  2006/10/26 10:14:25  oman
// - fix: ��� ���������� VisibleIndex � �� ������� ���� ��������, � ��
//  ����� � k2_tiModelControl (cq23253)
//
// Revision 1.106  2006/09/18 07:43:44  oman
// - new: ����� ������� k2_tiMaxTextLength - ������������ ����� ������
//
// Revision 1.105  2006/09/11 13:55:34  oman
// - change: k2_tiContext ������� �� k2_tiReqKind
//
// Revision 1.104  2006/09/04 08:25:29  lulin
// - �������� �������������� �����.
//
// Revision 1.103  2006/04/26 15:27:13  dinishev
// �����, ����� ������ ��������
//
// Revision 1.102  2006/01/18 16:12:15  lulin
// - �� ������������ Listner'�� ��� ����� ��� ID.
//
// Revision 1.101  2006/01/10 07:23:41  lulin
// - ��������� ����� �������� ��������� ��� ������.
//
// Revision 1.100  2005/12/02 11:30:55  lulin
// - ������� ������� ��� ��������� ����� ����� - k2_idNSRCTag.
//
// Revision 1.99  2005/09/22 10:19:42  dinishev
// Bug fix: ������� k2_tiNumList (������ k2_tiDefaultValue) + �������� �� ���������
//
// Revision 1.98  2005/09/09 13:26:31  dinishev
// ����� ��� k2_tiContext - ��� ����, ����� �������� ����������� ����.
//
// Revision 1.97  2005/09/07 09:02:05  dinishev
// update comments
//
// Revision 1.96  2005/09/05 10:55:02  dinishev
// ��������� ������� �������������� ������ ���������
//
// Revision 1.95  2005/09/02 14:48:37  dinishev
// ��������� ����� �����
//
// Revision 1.94  2005/08/23 16:25:18  lulin
// - bug fix: ���������� "�����������" SBS.
//
// Revision 1.93  2005/08/23 15:41:54  lulin
// - ����� �� "�����������" �������� �������.
//
// Revision 1.92  2005/07/04 08:21:11  lulin
// - cleanup: �������� �������� �������������� �����.
//
// Revision 1.91  2005/07/04 07:52:52  lulin
// - cleanup.
//
// Revision 1.90  2005/06/30 07:27:07  dinishev
// ����� ��������� ��� ���������.
//
// Revision 1.89  2005/06/27 11:11:24  lulin
// - new prop: AllChildrenCount.
//
// Revision 1.88  2005/03/22 15:45:30  lulin
// - ������ �������� ������.
//
// Revision 1.87  2005/03/02 08:13:17  lulin
// - ��������� ���� ��� ��������� xml-�������� ��������.
//
// Revision 1.86  2005/02/21 15:02:09  lulin
// - ��������� ���������� �������� ��� k2_tiContentsLevel.
//
// Revision 1.85  2005/02/15 09:17:57  lulin
// - ��������� ��� ������������ ����� ���������� � "����������" �����.
//
// Revision 1.84  2005/02/14 15:56:34  dinishev
// ����� �� ������������� ���� k2_tiInHeader
//
// Revision 1.83  2005/02/14 12:26:53  lulin
// - ��������� ���� ��� ���������.
//
// Revision 1.82  2005/02/11 08:22:50  dinishev
// ����� ��� ������� ��� ���������
//
// Revision 1.81  2005/01/24 16:45:41  dinishev
// ��������� ��������� k2_idControlsBlock
//
// Revision 1.80  2005/01/20 12:16:17  lulin
// - new prop: IeeSub.InContents.
//
// Revision 1.79  2005/01/18 13:19:59  dinishev
// ����� �� ���� IsMasked
//
// Revision 1.78  2005/01/17 16:47:18  dinishev
// ��������������� ���� - ��������� ��� ��������� ���������� ����� k2_tiChildren
//
// Revision 1.77  2005/01/12 14:50:33  dinishev
// ��������� true-�������� ������. ������ �� ������ ���������.
//
// Revision 1.76  2005/01/11 16:39:03  dinishev
// ��������� �������� ���� ��� ���������.
//
// Revision 1.75  2004/12/24 15:29:35  dinishev
// �������� IsValid ��� ��������� � ������
//
// Revision 1.74  2004/12/20 16:40:49  dinishev
// �������� IsMasked ��� ���������
//
// Revision 1.73  2004/12/16 16:10:38  dinishev
// ����� �������� � ImageList, ������������ ��� ��������� ��������� ����������
//
// Revision 1.72  2004/12/01 14:50:36  dinishev
// ������� �� ��������� ���������, ����������� ��������� ��������� ������ ComboBox'�.
//
// Revision 1.71  2004/11/30 17:50:21  dinishev
// ���������� ����������� ������ ��� CombobBox'�. ��������� ����������� �����������.
//
// Revision 1.70  2004/11/16 16:09:00  dinishev
// �������� ���������� ���������, � ��� ����� � ��� ���, �������� ��������� �������
// Enabled � Flat.
//
// Revision 1.69  2004/11/12 14:00:16  lulin
// - new prop: idControlPara.tiChecked.
//
// Revision 1.68  2004/11/11 17:35:26  lulin
// - new behavior: ��� ����� � ������������ ������� ���������� ���������� � ��������� ���������� �� �����.
//
// Revision 1.67  2004/11/03 16:19:21  lulin
// - cleanup: ������ �������� �������������� �����.
//
// Revision 1.66  2004/11/03 13:05:59  lulin
// - new para: idCommentPara.
//
// Revision 1.65  2004/11/02 13:05:55  lulin
// - new para: k2_idControlPara.
//
// Revision 1.64  2004/06/04 13:48:21  law
// - ����������� �������� �������� �����.
//
// Revision 1.63  2004/06/04 13:03:59  law
// - new prop: idLeafPara.tiLoaded.
//
// Revision 1.62  2004/04/12 13:59:09  law
// - ����� ��� ������ "������� ��������� ������".
//
// Revision 1.61  2004/04/12 13:29:32  law
// - new: �������� ��� ���������� "��������� ������", �� �������� ShortName ������ �������������� �� �������, � �������� �����.
//
// Revision 1.60  2004/04/12 09:02:45  law
// - new tag: k2_idDictEntry.
//
// Revision 1.59  2004/04/12 08:20:04  law
// - change: "���������" ��� � ������� !Contents ������ ������.
//
// Revision 1.58  2004/03/17 13:01:12  law
// - new type: k2_idDictItemEx.
// - change: �������� ������������� ������ ����� ��� k2_idDictItemEx.
//
// Revision 1.57  2004/01/29 13:06:47  law
// - new tags: k2_tiContentsLevelBackLink, k2_tiPages, k2_tiLinkComment.
//
// Revision 1.56  2003/12/08 14:04:53  law
// - new tag: k2_toContentsLevel.
//
// Revision 1.55  2003/11/28 14:38:32  law
// - new tag: k2_idTextPara._k2_tiExcludeSuper.
//
// Revision 1.54  2003/10/16 12:33:51  law
// - change: ������� ��� ����-���� ��������� - LeafPara � StyledLeafPara - ��� ������������ �� ��� "���������" ����������.
// - bug fix: ��� ������� ������������ �� ���������� ��������.
//
// Revision 1.53  2003/09/12 13:48:49  law
// no message
//
// Revision 1.52  2003/09/10 12:18:39  law
// - new type: idMark.
// - new const: ev_sbtMark.
//
// Revision 1.51  2003/09/09 14:56:23  law
// - new prop: Address.ShortName, Address.Revision.
//
// Revision 1.50  2003/09/01 15:44:44  law
// - new: �������� ��� _k2_idBookmark.
//
// Revision 1.49  2003/05/20 08:56:16  law
// - new tag: k2_tiAutoClasses.
//
// Revision 1.48  2003/05/14 13:17:14  law
// - change _format: ���������� ��������� �������� ������ ������� ���������.
//
// Revision 1.47  2003/04/25 12:53:46  law
// - new behavior: ��������� ������ ��� k2_tiMaxHyperlinkHandle - ������������ �������� �������������� ������ � ���������, �� ��������� ���� ������ ����� ������������ ����� ������ ������.
//
// Revision 1.46  2003/03/12 13:36:28  law
// - new tag: k2_tiAlarms.
//
// Revision 1.45  2003/03/12 13:17:58  law
// - change: ������� ������ ��������� �������� ����������.
//
// Revision 1.44  2003/01/23 10:24:06  law
// - change: ��������� ��������� ��� NSRC.
//
// Revision 1.43  2003/01/16 12:37:16  law
// - rename tags: k2_tiNextChanger -> k2_tiNextChangers, k2_tiPrevChanger -> k2_tiPrevChangers.
// - new struct: ����������� �������� ���������� Changer'��.
//
// Revision 1.42  2003/01/15 16:53:24  law
// - new tag: k2_tiBullet.
// - new behavior: ����� ��������� ������������� �������.
//
// Revision 1.41  2003/01/15 13:27:01  law
// - new tags: ��������� ����� ���� ��� ��������� ������������.
//
// Revision 1.40  2002/12/19 13:59:23  law
// - change: f_Map -> k2_tiMap.
//
// Revision 1.39  2002/12/19 12:49:59  law
// - change: �������� DeltaP �� (k2_tiDeltaX, k2_tiDeltaY).
//
// Revision 1.38  2002/12/17 12:42:49  law
// - change: k2_idTableColumn ������������� � k2_idTableCell ��� �������� ����������� ������ ����.
//
// Revision 1.37  2002/12/15 13:38:08  law
// - new behaivor: ��������� ��������� ��������� ������.
//
// Revision 1.36  2002/11/01 18:50:27  law
// - new para types: k2_idSBSRow, k2_idSBSCell.
//
// Revision 1.35  2002/10/02 13:30:14  law
// - new units: eeTags, _eeTypes.
//
// Revision 1.34  2002/09/02 08:26:51  law
// - new tag types: k2_idDictItem, k2_idItemFlag.
// - change tag type: k2_idDictRec -> k2_idDictItem ��� k2_tiClasses, k2_tiTypes, k2_tiKeyWords, k2_tiPrefix.
//
// Revision 1.33  2002/07/23 09:04:51  law
// - comments.
//
// Revision 1.32  2002/07/08 13:48:24  law
// no message
//
// Revision 1.31  2002/07/08 12:09:38  law
// - new const: k2_idTreePara.
//
// Revision 1.30  2002/02/12 09:12:50  law
// - comments.
//
// Revision 1.29  2002/02/05 10:16:09  law
// - bug fix: ������������ ���������� ������ Preformatted-����������.
//
// Revision 1.28  2002/01/08 13:54:15  law
// - rename type: TevOrientation -> Tl3Orientation.
//
// Revision 1.27  2001/11/26 14:29:21  law
// - comments: ����������.
//
// Revision 1.26  2001/11/26 12:17:02  law
// - new tag: k2_tiRelInternalHandle.
//
// Revision 1.25  2001/11/21 10:50:05  law
// - new tag: k2_tiAccGroups.
//
// Revision 1.24  2001/09/19 15:54:33  law
// - new tag ID: k2_tiCollapsed.
//
// Revision 1.23  2001/03/15 14:52:23  law
// - cleaning & coments.
//
// Revision 1.22  2001/02/23 13:44:26  law
// - � ���������� ��������� ��������� �������� AllowHyphen.
//
// Revision 1.21  2001/01/15 15:50:09  law
// - ��������� �������� k2_tiVerticalAligment - ������������ �� ���������.
//
// Revision 1.20  2000/12/15 15:18:59  law
// - ��������� ��������� Log.
//

{$Include k2Define.inc }

interface

uses
  k2Const
  ;

type
  Tk2TagID = (
    {* ���������, ���������������� �������� ��������. }
    _k2_tiHandle,           {-������������� ������� (��� ������, ����� �����)} //0
    _k2_tiShortName,        {-�������� ��� ������� } // 1
    _k2_tiExternalHandle,   {-������� ������������� ������� (��� ������, ����� �����)} // 2
    _k2_tiInternalHandle,   {-���������� ������������� ������� (��� ������, ����� �����)} // 3
    _k2_tiMDPPageID,        // - ����� MDP ������ {RequestLink:275780190} 4
    _k2_tiNameComment,      // 5
    _k2_tiName,             {-��� ������� } // 6

    { ��������� ��� ������ }
    _k2_tiPitch,            {-��� ������ ������� (������������ ��� ���)} // 7
    _k2_tiSize,             {-������ ������} // 8
    _k2_tiBold,             {-������} // 9
    _k2_tiItalic,           {-������} // 10
    _k2_tiUnderline,        {-������������} // 11
    _k2_tiStrikeout,        {-�����������}  // 12
    _k2_tiForeColor,        {-���� ������ (��� �����)} // 13
    _k2_tiBackColor,        {-���� ����} // 14
    _k2_tiIndex,            {-������ - ������� ��� ������} // 15
    _k2_tiCodePage,         {-������� ��������} // 16
    _k2_tiFontParamRsr1,    // 17
    _k2_tiFontParamRsr2,    // 18
    _k2_tiFontParamRsr3,    // 19
    _k2_tiFontParamRsr4,    // 20

    { ��������� ���������� }
    _k2_tiFont,             {-����� �������} // 21
    _k2_tiStyle,            {-����� �������} // 22
    _k2_tiVisible,          {-���������}     // 23
    _k2_tiSegments,         {-������� ����������} // 24

    _k2_tiFrame,            {-����� ������ �������} // 25

    { ��������� ����� }
    _k2_tiFrameUp,          {-������� ����� �����} // 26
    _k2_tiFrameDown,        {-������ ����� �����}  // 27
    _k2_tiFrameLeft,        {-����� ����� �����}   // 28
    _k2_tiFrameRight,       {-������ ����� �����}  // 29

    { ������� � ���������� ������� }
    _k2_tiOrientation,      {-���������� �������}  // 30
    _k2_tiWidth,            {-������ � ������}     // 31
    _k2_tiHeight,           {-������ � ������}     // 32
    _k2_tiFirstIndent,      {-������ ������ ������ (�� ������)} // 33
    _k2_tiLeftIndent,       {-����� ������}        // 34
    _k2_tiJustification,    {-������������}        // 35
    _k2_tiFixedHeight,      {-������������� ������ ?} // 36
    _k2_tiPercentSign,      {-���� �������� % - ������������ ��� ������ � EVD} // 37
    _k2_tiRightIndent,      {-������ ������}          // 38
    _k2_tiFirstLineIndent,  {-������ ������ ������ (�� ������� ������)} // 39
    _k2_tiSpaceBefore,      {-������ ������}          // 40
    _k2_tiSpaceAfter,       {-������ �����}           // 41
    _k2_tiCollapsed,        {-������ �������}         // 42

    { ����������������� ��������� }
    _k2_tiParas,            {-��������� ������� � �� Style (�� ������ ������)} // 43
    _k2_tiSubs,             {-������ ����� ����� (Sub'��)} // 44
    _k2_tiIsActive,         // 45
    _k2_tiStrParamRsr2,     // 46
    _k2_tiStrParamRsr3,     // 47
    _k2_tiStrParamRsr4,     // 48
    _k2_tiCaseDocParticipants, // 49

    _k2_tiApply2Para,       {-�������� �� ����� � ���������} // 50
    _k2_tiStyleParamRsr1,   // 51
    _k2_tiIsChangeableFont, // ����� �� �������� ����� ����� �������� �� ������� // 52
    _k2_tiVisibleToUser,    // �������� �� � ������� ������ ��� ������������ // 53
    _k2_tiLineSpacing,      // - ����������� // 54
    _k2_tiHeaderHasOwnSpace,// 55

    { ��������� �������� }
    _k2_tiStart,            {-������ �������} // 56
    _k2_tiFinish,           {-����� ������� } // 57
    _k2_tiBaseLine,         // ������� ����� // 58 http://mdp.garant.ru/pages/viewpage.action?pageId=336663777
    _k2_tiSegmentParamRsr2, // 59
    _k2_tiSegmentParamRsr3, // 60
    _k2_tiSegmentParamRsr4, // 61
    _k2_tiSegmentParamRsr5, // 62

    _k2_tiText,             {-�����} // 63
    _k2_tiOldChildren,      {-������ �������� �������� // 64
                              (��� ��������� ������ evd ������� ����� 07/12/1998)}
    _k2_tiIsPeriodic,       {http://mdp.garant.ru/pages/viewpage.action?pageId=242516109} // 65
    _k2_tiLineType,         {-��� �����} // 66
    _k2_tiLoaded,           // - �������� �� �������� ������� // 67

    {����������������� ���� ��� �������}
    _k2_tiAlternateText,   // 68
    _k2_tiMaxTextLength,   {-������������� ����� ������ ��� ControlPara}// 69
    _k2_tiPrintFontSize,   // 70  http://mdp.garant.ru/pages/viewpage.action?pageId=199590272
    _k2_tiTextRsr4,        // 71
    _k2_tiTextRsr5,        // 72
    _k2_tiTextRsr6,        // 73
    _k2_tiTextRsr7,        // 74
    _k2_tiTextRsr8,        // 75
    _k2_tiTextRsr9,        // 76
    _k2_tiMaxSubID,        // 77 http://mdp.garant.ru/pages/viewpage.action?pageId=283608516&focusedCommentId=294257621#comment-294257621

    _k2_tiHasAnno,         // 78
    _k2_tiZoom,            // 79
    _k2_tiNoCompare,       // 80 // �������� �� ��������� � ���������� ��������
    _k2_tiOldNSRC,         // 81 // ������ � ������ ������� NSRC 
    _k2_tiLanguage,        // ���� http://mdp.garant.ru/pages/viewpage.action?pageId=135594063 // 82
    _k2_tiDPI,             // ���������� // 83
    _k2_tiUrgency,         // ���������  // 84
    _k2_tiFixedWidth,      // - ������������� ������ ? // 85
    _k2_tiAllowHyphen,     // 86
    _k2_tiVerticalAligment, // 87

    {���� ��� ��������� ������� NSRC}
    _k2_tiGroups,           {-������} // 88
    _k2_tiSources,          {-���������} // 89
    _k2_tiTypes,            {-����}      // 90
    _k2_tiClasses,          {-������}    // 91
    _k2_tiKeyWords,         {-�������� �����} // 92
    _k2_tiWarnings,         {-��������������} // 93
    _k2_tiType,             {-��� �������}    // 94
    _k2_tiUserType,         {-���������������� ��� �������} // 95
    _k2_tiUser,             {-������������}   // 96
    _k2_tiDocID,            {-������������� ���������} // 97
    _k2_tiSubID,            {-������������� Sub'�}     // 98
    _k2_tiNumber,           {-�����}                   // 99
    _k2_tiComment,          {-�����������}             // 100

    _k2_tiNumANDDates,      // 101
    _k2_tiLogRecords,       // 102
    _k2_tiStages,           // 103
    _k2_tiChecks,           // 104
    _k2_tiSource,            {-��������} // 105
    _k2_tiSortDate,         // 106
    _k2_tiActiveIntervals,  // 107
    _k2_tiRelExternalHandle, // 108
    _k2_tiPriority,          // 109

    _k2_tiPublishedIn,       // 110
    _k2_tiPrefix,            // 111
    _k2_tiTerritory,         // 112
    _k2_tiAlarms,            // 113
    _k2_tiNorm,              // 114
    _k2_tiExternalPath,      // 115
    _k2_tiLinkedDocuments,   // 116

    {��������������� ����}
    _k2_tiFlags,             {-�����} // 117
    _k2_tiObject,            {-��������� �� ������} // 118

    _k2_tiBitmap,            {-BMP-��������} // 119
    _k2_tiPriceLevel,        {-������� ���������} { NSRC } // 120
    _k2_tiURL,               {-URL}                        // 121
    _k2_tiHeaders,           {-������� �����������}        // 122
    _k2_tiFooters,           {-������ �����������}         // 123
    _k2_tiMergeStatus,       {-������ ����������� �����}   // 124
    _k2_tiAccGroups,         // NSRC                       // 125
    _k2_tiRelInternalHandle, // NSRC - ���������� ������������� ������� // 126
    _k2_tiAutoClasses,       // 127
    _k2_tiWeight,            // 128
    _k2_tiInternalVerLink,   // 129
    _k2_tiExternalVerLink,   // 130
    _k2_tiAnnoClasses,       // 131
    _k2_tiBullet,           {- ��� �������� ������} // 132
    _k2_tiTime,             // NSRC - �����                    // 133
    _k2_tiTabStops,         // - ������� ���������             // 134
    _k2_tiRevision,         // - �������                       // 135
    _k2_tiContentsLevel6,   // - ������� ����������            // 136
    _k2_tiContentsLevel5,   //                                 // 137
    _k2_tiPages,            //                                 // 138
    _k2_tiLinkComment,      //                                 // 139
    _k2_tiPrivate,          //                                 // 140
    _k2_tiValue,            //                                 // 141
    _k2_tiEnabled,          // - ����������� �������           // 142
    _k2_tiValid,            // - ������������ �������� ������  // 143
    _k2_tiUpper,            // - ���� ��� �������              // 144
    _k2_tiStateIndex,       // - ����� �������� ��� ��������   // 145
                            //���������                        
    _k2_tiFlat,             // - ������������������            // 146
    _k2_tiImageIndex,       // - ����� �������� � ������       // 147
    _k2_tiScript,           // - ������ ��� ����������         // 148
    _k2_tiCardType,         // - ��� ��                        // 149
    _k2_tiReqID,            // - ID ��������� (��� ���������� �����) //150
    _k2_tiRequired,         // - ������������ �������� //151                                
    _k2_tiNumList,          // - �������� � ��������  //152
    _k2_tiInternalNextVerLink,  // - ���������������� //153
    _k2_tiFilterType,       // - ��� ���������� ��������� //154
    _k2_tiModelControl,     // - ��������� �� ������� �� ������ //155
    _k2_tiMulty,            // - �������� ��������� ������������� ����� //156
    _k2_tiReqKind,          // - ��� ��������� (TevReqKind)      //157
    _k2_tiSysLogRecords,    //                                 //158
    _k2_tiVersions,         //                                 //159
    _k2_tiExternalNextVerLink, {- ���������������}          // 160
    _k2_tiServiceInfo,       {- "���������� ����������" ��������� ���� ������� ������ }  // 161
    _k2_tiInContents,         // - ����� �� ���� � ���������� // 162
    _k2_tiCompareContentsLevel, // http://mdp.garant.ru/pages/viewpage.action?pageId=332563400 // 163
    _k2_tiViewKind,         // 164
    _k2_tiLinkAddress,      // 165
    _k2_tiModified,         // 166
    _k2_tiEditableParts,    // 167
    _k2_tiVisibleToBlock,   // 168 // ����� ������� ��� �����
    {==================================================================================}
    {          ����, ����������� ���� ����� �����������, �� �����������                }
    {==================================================================================}
    _k2_tiChildren,         {-������ �������� ��������}        // 169
    _k2_tiFormatted,        {-������������� �������� ��� ���?} // 170
    _k2_tiLimitWidth,       // 171
    _k2_tiDeltaX,           {-�������� �� ��� X �� ��������} // 172
    _k2_tiDeltaY,           {-�������� �� ��� Y �� ��������} // 173
    _k2_tiMap,              {-����� �������������� ���������} // 174
    _k2_tiMaxHyperlinkHandle, // - ������������ ������������� ����������� // 175
    _k2_tiExcludeSuper,       // - ��������, ������� ���������� �� ������������ // 176
    _k2_tiLayerID,            // - ������������� ���� // 177
    _k2_tiStateCount,         // - ���������� ��������� // 178
    _k2_tiAllChildrenCount, // 179
    _k2_tiRubber,           // 180
    _k2_tiNodeVisibleIndex ,{-������� ������ � ������ ��� �� - ��� � ����� �����������,
                             �� ���������� ��� ��� ���������� k2_tiModelControl
                             ��� ����}// 181
    _k2_tiDefaultText,      // 182
    _k2_tiDefaultNode,      // 183
    _k2_tiOperations        // 184

  );//Tk2TagID

const
  { ���������, ���������������� ������� }
  k2_tiHandle         = Ord(_k2_tiHandle);
   {* - ������������� �������
     (��� ������, ����� ����� e.g k2_idHyperlink, k2_idSub, IevHyperlink, IevSub). }
  k2_tiShortName      = Ord(_k2_tiShortName);
   {* - �������� ��� �������. }
  k2_tiExternalHandle = Ord(_k2_tiExternalHandle);
   {* - ������� ������������� �������
     (��� ������, ���������� e.g k2_idDocument, k2_idBlock, IevDocument, IevDocumentPart). }
  k2_tiInternalHandle = Ord(_k2_tiInternalHandle);
   {* - ���������� ������������� �������. }
  k2_tiMDPPageID      = Ord(_k2_tiMDPPageID);
   // - ����� MDP ������ {RequestLink:275780190}
  k2_tiName           = Ord(_k2_tiName);
   {* - ��� �������. }
  k2_tiURL            = Ord(_k2_tiURL);
   {* - ���� � �������. }
  k2_tiHeaders        = Ord(_k2_tiHeaders);
   {* - ������� �����������. }
  k2_tiFooters        = Ord(_k2_tiFooters);
   {* - ������ �����������. }
  k2_tiHeader        = Ord(_k2_tiHeaders);
   {* - ������� ����������. }
  k2_tiFooter        = Ord(_k2_tiFooters);
   {* - ������ ����������. }
  k2_tiMergeStatus    = Ord(_k2_tiMergeStatus);
   {* - ������ ����������� (�����). }

  { ��������� ��� ������ }
  k2_tiPitch          = Ord(_k2_tiPitch);
   {* - ������� - ��� ������ ������� (������������ ��� ���). }
  k2_tiSize           = Ord(_k2_tiSize);
   {* - ����� - ������ ������. }
  k2_tiBold           = Ord(_k2_tiBold);
   {* - ������. }
  k2_tiItalic         = Ord(_k2_tiItalic);
   {* - ������. }
  k2_tiUnderline      = Ord(_k2_tiUnderline);
   {* - ������������. }
  k2_tiStrikeout      = Ord(_k2_tiStrikeout);
   {* - �����������. }
  k2_tiForeColor      = Ord(_k2_tiForeColor);
   {* - ���� ������ (��� �����). }
  k2_tiBackColor      = Ord(_k2_tiBackColor);
   {* - ���� ����. }
  k2_tiIndex          = Ord(_k2_tiIndex);
   {* - ������ - ������� ��� ������ (��. Tl3FontIndex). }

  { ��������� ���������� }
  k2_tiFont           = Ord(_k2_tiFont);
   {* - ����� �������. }
  k2_tiStyle          = Ord(_k2_tiStyle);
   {* - ����� �������. }
  k2_tiVisible        = Ord(_k2_tiVisible);
   {* - ���������. }
  k2_tiIsChangeableFont = Ord(_k2_tiIsChangeableFont);
   // ����� �� �������� ����� ����� �������� �� �������
  k2_tiVisibleToUser = Ord(_k2_tiVisibleToUser);
   // �������� �� � ������� ������ ��� ������������
  k2_tiSegments       = Ord(_k2_tiSegments);
   {* - ������� ����������. }
  k2_tiVisibleToBlock = Ord(_k2_tiVisibleToBlock);  

  k2_tiFrame          = Ord(_k2_tiFrame);
   {* - ����� ������ �������. }

  { ��������� ����� }
  k2_tiFrameUp        = Ord(_k2_tiFrameUp);
   {* - ������� ����� �����. }
  k2_tiFrameDown      = Ord(_k2_tiFrameDown);
   {* - ������ ����� �����. }
  k2_tiFrameLeft      = Ord(_k2_tiFrameLeft);
   {* - ����� ����� �����. }
  k2_tiFrameRight     = Ord(_k2_tiFrameRight);
   {* - ������ ����� �����. }

  { ������� � ���������� ������� }
  k2_tiOrientation    = Ord(_k2_tiOrientation);
   {* - ���������� �������. }
  k2_tiLineSpacing = Ord(_k2_tiLineSpacing);
   {* - �����������. }
  k2_tiHeaderHasOwnSpace = Ord(_k2_tiHeaderHasOwnSpace);
  k2_tiWidth          = Ord(_k2_tiWidth);
   {* - ������ � ������. }
  k2_tiHeight         = Ord(_k2_tiHeight);
   {* - ������ � ������. }
  k2_tiFirstIndent    = Ord(_k2_tiFirstIndent);
   {* - ������ ������ ������. }
  k2_tiLeftIndent     = Ord(_k2_tiLeftIndent);
   {* - ����� ������. }
  k2_tiJustification  = Ord(_k2_tiJustification);
   {* - ������������. }
  k2_tiFixedWidth     = Ord(_k2_tiFixedWidth);
   {* - ������������� ������ ?}
  k2_tiUrgency        = Ord(_k2_tiUrgency);
   {* - ���������. }
  k2_tiHasAnno        = Ord(_k2_tiHasAnno);
   {* - ���������� ������� ��������� � ���������. }
  k2_tiZoom           = Ord(_k2_tiZoom);
   {* - �������. }
  k2_tiNoCompare      = Ord(_k2_tiNoCompare);
   // �������� �� ��������� � ���������� ��������
  k2_tiOldNSRC        = Ord(_k2_tiOldNSRC);
  k2_tiLanguage       = Ord(_k2_tiLanguage);
   {* - ����. }
  k2_tiRightIndent    = Ord(_k2_tiRightIndent);
   {* - ������ ������. }
  k2_tiFirstLineIndent= Ord(_k2_tiFirstLineIndent);
   {* - ������ ������ ������ (�� ������� ������). }
  k2_tiSpaceBefore    = Ord(_k2_tiSpaceBefore);
   {* - ������ ������. }
  k2_tiSpaceAfter     = Ord(_k2_tiSpaceAfter);
   {* - ������ �����. }
  k2_tiCollapsed      = Ord(_k2_tiCollapsed);
   {* - ������ �������. }
  k2_tiCollapsable    = Ord(_k2_tiCollapsed);
   {* - ������ ����� �������������. }

  { ����������������� ��������� }
  k2_tiParas          = Ord(_k2_tiParas);
   {* - ��������� ������� � �� Style (�� ������ ������). }
  k2_tiSubs           = Ord(_k2_tiSubs);
   {* - ������ ����� ����� (Sub'��) (��. kd_idSub, IevSub). }
  k2_tiIsActive       = Ord(_k2_tiIsActive);

  k2_tiCaseDocParticipants = Ord(_k2_tiCaseDocParticipants);
   {* - ��������� ��������� ����. } 
  k2_tiApply2Para     = Ord(_k2_tiApply2Para);
   {* - �������� �� ����� � ���������? }

  { ��������� �������� }
  k2_tiStart          = Ord(_k2_tiStart);
   {* - ������ �������. }
  k2_tiFinish         = Ord(_k2_tiFinish);
   {* - ����� �������. }
  k2_tiBaseLine       = Ord(_k2_tiBaseLine);
   {* - ������� �����. }

  k2_tiText           = Ord(_k2_tiText);
   {* - �����. }
  k2_tiAlternateText  = Ord(_k2_tiAlternateText);
   {-}
  k2_tiMaxTextLength = Ord(_k2_tiMaxTextLength);
   {-}
  k2_tiPrintFontSize = Ord(_k2_tiPrintFontSize);
   {-}
  k2_tiMaxSubID = Ord(_k2_tiMaxSubID);
   {-}
  k2_tiNodeVisibleIndex = ord(_k2_tiNodeVisibleIndex);
   {-}
  k2_tiDefaultText = Ord(_k2_tiDefaultText);
   {* - �������� ������ ��-���������. }
  k2_tiDefaultNode = Ord(_k2_tiDefaultNode);
   {* - �������� ���� ��-���������. }
  k2_tiModified = Ord(_k2_tiModified);
   {-}
  k2_tiEditableParts = Ord(_k2_tiEditableParts);
   {-}
  k2_tiOperations = Ord(_k2_tiOperations);
   {-}
  k2_tiDPI = Ord(_k2_tiDPI);
   {-}
  k2_tiViewKind = Ord(_k2_tiViewKind);
   {-}
  k2_tiLinkAddress = Ord(_k2_tiLinkAddress);
   {-}
  k2_tiChildren       = Ord(_k2_tiChildren);
   {* - ������ �������� ��������. }
  k2_tiIsPeriodic     = Ord(_k2_tiIsPeriodic);
   {http://mdp.garant.ru/pages/viewpage.action?pageId=242516109}
  k2_tiLineType       = Ord(_k2_tiLineType);
   {* - ��� �����. }
  k2_tiAllowHyphen   =  Ord(_k2_tiAllowHyphen);
   {* - ����� �� ���������� ����� �� ������. }
  k2_tiVerticalAligment = Ord(_k2_tiVerticalAligment);
   {* - ������������ ������������ (��. TevVerticalAligment). }

  {���� ��� ��������� ������� NSRC}
  k2_tiNSRCStart      = Ord(_k2_tiGroups);        {-������ ����� NSRC}
  k2_tiGroups         = Ord(_k2_tiGroups);
   {* - ������. }
  k2_tiAccGroups      = Ord(_k2_tiAccGroups);
   {* - ������ �������. }
  k2_tiSources        = Ord(_k2_tiSources);
   {* - ���������. }
  k2_tiTypes          = Ord(_k2_tiTypes);
   {* - ����. }
  k2_tiClasses        = Ord(_k2_tiClasses);
   {* - ������. }
  k2_tiAutoClasses    = Ord(_k2_tiAutoClasses);
   {* - ����-������. }
  k2_tiAnnoClasses    = Ord(_k2_tiAnnoClasses);
   {* - ������ ��� ���������. }
  k2_tiWeight         = Ord(_k2_tiWeight);
   {* - ���. }
  k2_tiKeyWords       = Ord(_k2_tiKeyWords);
   {* - �������� �����. }
  k2_tiWarnings       = Ord(_k2_tiWarnings);
   {* - ��������������. }
  k2_tiType           = Ord(_k2_tiType);
   {* - ��� �������. }
  k2_tiUserType       = Ord(_k2_tiUserType);
   {* - ���������������� ��� �������. }
  k2_tiUser           = Ord(_k2_tiUser);
   {* - ������������. }
  k2_tiDocID          = Ord(_k2_tiDocID);
   {* - ������������� ��������� (��. TevAddress, IevDocument). }
  k2_tiSubID          = Ord(_k2_tiSubID);
   {* - ������������� Sub'� (�� TevAddress, IevSub). }
  k2_tiNumber         = Ord(_k2_tiNumber);
   {* - �����. }
  k2_tiComment        = Ord(_k2_tiComment);
   {* - �����������. }
  k2_tiNameComment    = Ord(_k2_tiNameComment);
   {* - �����������. }

  k2_tiNumANDDates    = Ord(_k2_tiNumANDDates);
   {* - ����/������. }
  k2_tiLogRecords     = Ord(_k2_tiLogRecords);
   {* - ������ ����������� ���������. }
  k2_tiSysLogRecords  = Ord(_k2_tiSysLogRecords);
   {* - ������ ��������� ���������. }
  k2_tiVersions       = Ord(_k2_tiVersions);
   {-}
  k2_tiStages         = Ord(_k2_tiStages);
   {* - �����. }
  k2_tiChecks         = Ord(_k2_tiChecks);
   {* - �������. }
  k2_tiChecked        = Ord(_k2_tiChecks);
   {* - ������ ������/��������. }
  k2_tiEnabled        = Ord(_k2_tiEnabled);
   {* - ����������� ����������. }
  k2_tiFlat        = Ord(_k2_tiFlat);
   {* - ����� Flat. }
  k2_tiSource         = Ord(_k2_tiSource);
   {* - ��������. }
  k2_tiImageIndex       = Ord(_k2_tiImageIndex);
   {* - ������ �������� ��� �����������. }
  k2_tiValid            = Ord(_k2_tiValid);
   {* - ������������ �������� ������. }
  k2_tiUpper        = Ord(_k2_tiUpper);
   {* - ���� ��� �������. }
  k2_tiStateCount   = Ord(_k2_tiStateCount);
   {* - ���������� ���������. }
  k2_tiInContents   = Ord(_k2_tiInContents);
   {* - ����� �� ���� � ����������. }
  k2_tiCardType     = Ord(_k2_tiCardType);
   {* - ��� �������� �������. }
  k2_tiReqID        = Ord(_k2_tiReqID);
   {* - ID ��������� ��� ����� �������. }
  k2_tiNumList = Ord(_k2_tiNumList);
   {-}
  k2_tiRequired = Ord(_k2_tiRequired);
   {* - ������������ ��������. }
  k2_tiFilterType = Ord(_k2_tiFilterType);
   {* - ��� ���������� ��������. }
  k2_tiModelControl = Ord(_k2_tiModelControl);
   {* - ��������� �� ��� ������. }
  k2_tiMulty = Ord(_k2_tiMulty);
   {* - ����������� �������������� ������. }
  k2_tiReqKind = Ord(_k2_tiReqKind);
   {* - ��� ���������. }

  k2_tiAllChildrenCount = Ord(_k2_tiAllChildrenCount);
   {-}
  k2_tiRubber = Ord(_k2_tiRubber);
   {-} 
  k2_tiStateIndex   = Ord(_k2_tiStateIndex);
   {* - ����� �������� ��� �������� ���������. }
  k2_tiScript         = Ord(_k2_tiScript); 
   {* - ������ ��� ���������� ��� �������. }

  k2_tiSortDate       = Ord(_k2_tiSortDate);
   {* - ���� ����������. }
  k2_tiRelExternalHandle = Ord(_k2_tiRelExternalHandle);
   {* - ������� ������������� �������. }
  k2_tiRelInternalHandle = Ord(_k2_tiRelInternalHandle);
   {* - ���������� ������������� �������. }
  k2_tiActiveIntervals = Ord(_k2_tiActiveIntervals);
   {-}
  k2_tiAlarms          = Ord(_k2_tiAlarms);
   {-}
  k2_tiInternalVerLink = Ord(_k2_tiInternalVerLink);
   {-}
  k2_tiExternalVerLink = Ord(_k2_tiExternalVerLink);
   {-}
  k2_tiInternalNextVerLink = Ord(_k2_tiInternalNextVerLink);
   {-}
  k2_tiExternalNextVerLink = Ord(_k2_tiExternalNextVerLink);
   {-}
  k2_tiBullet         = Ord(_k2_tiBullet);
   {* - ��� �������� ������. }
  k2_tiTime           = Ord(_k2_tiTime);
   {* NSRC - �����. }
  k2_tiTabStops       = Ord(_k2_tiTabStops);
   {* - ������� ���������. }
  k2_tiRevision       = Ord(_k2_tiRevision);
   {* - �������. }
  k2_tiContentsLevel6  = Ord(_k2_tiContentsLevel6);
   {* - ������� ���������� ��� 6.�. }
  k2_tiContentsLevel = k2_tiContentsLevel6;
   {* - ������� ����������. }
  k2_tiCompareContentsLevel = Ord(_k2_tiCompareContentsLevel);
   // http://mdp.garant.ru/pages/viewpage.action?pageId=332563400 
  k2_tiContentsLevel5  = Ord(_k2_tiContentsLevel5);
   {* - ������� ���������� ��� 5.�. }
  k2_tiPages = Ord(_k2_tiPages);
   {-}
  k2_tiLinkComment = Ord(_k2_tiLinkComment);
   {-}
  k2_tiPrivate = Ord(_k2_tiPrivate);
   {-}
  k2_tiPriority       = Ord(_k2_tiPriority);
   {-}

  k2_tiPublishedIn    = Ord(_k2_tiPublishedIn);
   {* - �������� ����������. }
  k2_tiPrefix         = Ord(_k2_tiPrefix);
   {* - �������. }
  k2_tiTerritory      = Ord(_k2_tiTerritory);
   {* - ����������. }
  k2_tiNorm           = Ord(_k2_tiNorm);
  k2_tiExternalPath   = Ord(_k2_tiExternalPath);
  k2_tiPriceLevel     = Ord(_k2_tiPriceLevel);
  k2_tiServiceInfo = Ord(_k2_tiServiceInfo);
   {* - ������� ���������. } { NSRC }
  k2_tiLinkedDocuments        = Ord(_k2_tiLinkedDocuments);
   {* - ��������� ���������. }

  {��������������� ����}
  k2_tiFlags          = Ord(_k2_tiFlags);
   {* - �����. }
  k2_tiObject         = Ord(_k2_tiObject);
   {* - ��������� �� ������. }
  k2_tiData           = Ord(_k2_tiBitmap);
   {* - BMP-��������. }
  k2_tiMaxHyperlinkHandle = Ord(_k2_tiMaxHyperlinkHandle);
   {* - ������������ ������������� �����������. }
  k2_tiLayerID        = Ord(_k2_tiLayerID);
   {* - ������������� ����. }
  k2_tiValue = Ord(_k2_tiValue);
   {* - �������� "����������" �������. }
  k2_tiLast = Ord(High(Tk2TagID));
   {-}
  k2_tiComplexBase = High(Byte) + 1 {k2_tiLast + 1};
   {* - ���� ��� �������� ������� ����������. }

  k2_attrSelfID = k2_tiSelfID;
  k2_attrNative = k2_tiNative;

  k2_attrMask = k2_tiMask;

  k2_attrHandle = k2_tiHandle;
  k2_attrName = k2_tiName;
  k2_attrStyle = k2_tiStyle;
  k2_attrForeColor = k2_tiForeColor;
  k2_attrBold = k2_tiBold;
  k2_attrStrikeout = k2_tiStrikeout;
  k2_attrSize = k2_tiSize;
  k2_attrBackColor = k2_tiBackColor;
  k2_attrUnderline = k2_tiUnderline;
  k2_attrItalic = k2_tiItalic; 
  k2_attrFont = k2_tiFont; 

type
  Tk2FontParam = k2_tiName .. k2_tiIndex;

(*type
  Tk2TypeID = (
    _k2_idEmpty,          {-����������� ��������} // 0
    _k2_idLong,           {-������� �����}        // 1
    _k2_idEnum,           {-������������ ���}     // 2
    _k2_idBool,           {-��������� ��������}   // 3
    _k2_idColor,          {-����}                 // 4
    _k2_idString,         {-������}               // 5
    _k2_idObject,         //_k2_idPitch,          {-��� ������ ������} // 6
    _k2_idJustification,  {-������������}         // 7
    _k2_idRsr2,           //_k2_idOrientation,    {-����������} // 8
    _k2_idl3Base,         {-������� ��� ���������� l3} // 9
    _k2_idTag,            {-������� ��� �����}    // 10
    _k2_idDocumentSub,    {-Sub ���������}        // 11
    _k2_idSegment,        {-�������}              // 12
    _k2_idTextSegment,    {-������� ������}       // 13
    _k2_idHyperLink,      {-�������������� ������}// 14
    _k2_idSub,            {-����� ����� (Sub)}    // 15
    _k2_idList,           {-������}               // 16
    _k2_idSubLayer,       {-���� ����� ����� (Sub'��)} // 17
    _k2_idDocSubLayer,    {-���� ����� ����� (Sub'��) ��� ���������} // 18
    _k2_idSegmentsLayer,  {-���� ��������}        // 19
    _k2_idDocument,       {-��������}             // 20
    _k2_idPara,           {-������� ��������}     // 21
    _k2_idTextPara,       {-��������� ��������}   // 22
    _k2_idParaList,       {-������ ����������}    // 23
    _k2_idTable,          {-�������}              // 24
    _k2_idSBS,            {-�������� Side By Side} // 25
    _k2_idTableRow,       {-������ �������}       // 26
    _k2_idTableColumn,    {-������ �������}       // 27
    _k2_idHandle,         {-�������������}        // 28
    _k2_idInch,           {-����}                 // 29
    _k2_idOList,          {-������}               // 30
    _k2_idPosition,       {-������� � ������}     // 31
    _k2_idObjectWithHandle, {-������ � Handl'��}    // 32
    _k2_idSgLHandle,      {-������������� ���� ��������} // 33
    _k2_idSbLHandle,      {-������������� ���� ����� ����� (Sub'��)} // 34
    _k2_idFontName,       {-��� ������}           // 35
    _k2_idFont,           {-�����}                       // 36
    _k2_idPercentSign,    {-���� �������� % - ������������ ��� ������ � EVD}            // 37
    _k2_idStyle,          {-�����}                // 38
    _k2_idTextStyle,      {-����� ������}         // 39
    _k2_idFramePart,      {-����� ����� (����, ���, �����, ����)} // 40
    _k2_idFrame,          {-�����}                // 41
    _k2_idRsr3,           {-��������� ���������}  // 42
    _k2_idRsr4,           {-��������� ���������� ���������} // 43
    _k2_idReserved6,      //_k2_idMergeStatus,    {-������ ����������� ����� ��. TevMergeStatus} // 44
    _k2_idReserved2,      {_k2_idSubs,     -������ ����� ����� (Sub'��)} // 45
    _k2_idNodeGroup,      // - ������ ��� // 46
    _k2_idCloak,          // Cloak - ��������������� ������ // 47 {_k2_idDocSubs   -������ ����� ����� (Sub'��) ���������} // 47
    _k2_idDictEntryBlock, {- ������� ��������� ������. } // 48
    _k2_idDictEntry,      {- ��������� ������. }         // 49
    _k2_idBlock,          {-���� ����������}             // 50
    _k2_idObjectSegment,  {-��������� ��� �������}       // 51
    _k2_idSimpleDocumentTextPara, {-��������� �������� � "������� ����������"} // 52
    _k2_idTableTextPara,  {-��������� �������� � �������}// 53
    _k2_idAnnoTopic,                                     // 54

    _k2_idReqGroup,       {-������ ����������}           // 55
    {��������� ���� ��� �������}
    _k2_idTextRsr4,                                      // 56
    _k2_idTextRsr5,                                      // 57
    _k2_idTextRsr6,                                      // 58
    _k2_idTextRsr7,                                      // 59
    _k2_idTextRsr8,                                      // 60
    _k2_idTextRsr9,                                      // 61
    _k2_idTextRsr10,                                     // 62
    _k2_idTextRsr11,                                     // 63
    _k2_idTextRsr12,                                     // 64
    _k2_idTextRsr13,                                     // 65
    _k2_idTextRsr14,                                     // 66
    _k2_idTextRsr15,                                     // 67
    _k2_idTextRsr16,                                     // 68
    _k2_idTextRsr17,                                     // 69
    _k2_idTextRsr18,                                     // 70
    _k2_idTextRsr19,                                     // 71
    
    _k2_idDecorTextPara, // - ��������� �������� - ����������, �� �������������, �� ��������� � ������ // 72

    _k2_idDictItem,     {- "�����������" ������� �������} // 73
    _k2_idDictRec,      {-������� �������}               // 74
    _k2_idDate,         {-����}                          // 75
    _k2_idType,         {-��� �������}                   // 76
    _k2_idAddress,      {-����� �������}                 // 77

    _k2_idLogRecord,                                     // 78
    _k2_idStagePrim,                                     // 79
    _k2_idStage,                                         // 80
    _k2_idCheck,        // 81
    _k2_idNumANDDate,   // 82

    _k2_idTinyDocument, {-���������� ��������}           // 83
    _k2_idActiveInterval, // 84
    _k2_idAlarm,        // 85
    _k2_idAutoClass,    // 86

    _k2_idDictItemEx,   // 87
    _k2_idPIRec,        // 88
    _k2_idNSRCTag,      // 89
    _k2_idParticipant,  // 90
    _k2_idNSRCRsr0,     // 91

    _k2_idNSRCRsr1,     // 92
    _k2_idNSRCRsr2,     // 93
    _k2_idNSRCRsr3,     // 94
    _k2_idNSRCEnd,      // 95
    _k2_idRawData,      {-"�����"-������}           {96}
    _k2_idBitmapPara,   {-�������� � BMP-���������} {97}
    _k2_idIUnknown,     {-���������}                {98}
    _k2_idHFParent,                                 {99}
    _k2_idHeader,       {-������� ���������}        {100}
    _k2_idFooter,       {-������ ����������}        {101}
    _k2_idDivision,     {-������}                   {102}
    _k2_idPageBreak,    {-������ ��������}          {103}
    _k2_idSectionBreak, {-������ �������}           {104}
    _k2_idSimpleDocument, {-"�������" ��������}     {105}
    _k2_idPageProperties,{-��������� ��������}      {106}
    _k2_idTreePara,      {-������}                  {107}
    _k2_idSBSRow,        {-������ �������}          {108}
    _k2_idSBSCell,       {-������ �������}          {109}
    _k2_idFormula,       {-�������}                 {110}
    _k2_idBullet,        {-��� �������� ������}     {111}
    _k2_idLogRecordPrim,                            {112}
    _k2_idTime,          {-�����}                   {113}
    _k2_idTabStop,       // - ������� ���������      114
    _k2_idBookmark,      // - ��������               115
    _k2_idMark,          // - ��������������� ������ 116
    _k2_idLeafPara,      // - "���������" ��������   117
    _k2_idStyledLeafPara, // - "���������" �������� � ����������� 118
    _k2_idControlPara,   // - �������� �������������� ����� ������� ����� 119
    _k2_idCommentPara,   // - ������� �������� � ������������ 120
    _k2_idControlsBlock, // - ������� �������� � ����������   121
    _k2_idXML,           // - XML-��������                    122
    _k2_idXMLTag,        // - XML-���                         123
    _k2_idTagName,       // - ��� ����                        124
    _k2_idAttr,          // - ������� ����                    125
    _k2_idAttrName,      // - ��� ��������                    126
    _k2_idAttrValue,     // - �������� ��������               127
    _k2_idTagBody,       // - ���� ����                       128
    _k2_idQueryCard,     // - ���� �������                    129
    _k2_idReqRow,        // - ������ ��������� (��������)     130
    _k2_idReqCell,       // - ������ ������ ���������         131
    _k2_idExtDataPara,   // - �������� � ������� �� ������� ������� 132
    _k2_idContentsElement, // - ������� ��������� ���������   133
    _k2_idLeafParaDecorationsHolder, // ��������� ���������    134
    _k2_idAutoreferatDocument, // 135
    _k2_idVersion,             // 136
    _k2_idImageListBitmap,     // 137
    _k2_idDocumentQuery,       // 138
    _k2_idEditablePart         // 139
  );//Tk2TypeID*)

//  Tk2EffTypeID = Succ(Low(Tk2TypeID)) .. High(Tk2TypeID);
  Tk2EffTypeID = 1 .. 255;

//const   
  //k2_idString      = Ord(_k2_idString     );
  //k2_idString      = 5;
   {* - ������ (��. Tl3CustomString, Tl3String). }
   
implementation

end.

