unit nsNodes;

// $Id: nsNodes.pas,v 1.14 2015/01/30 13:30:32 kostitsin Exp $

// $Log: nsNodes.pas,v $
// Revision 1.14  2015/01/30 13:30:32  kostitsin
// ������ l3Nodes
//
// Revision 1.13  2015/01/28 12:05:50  kostitsin
// ������ Tl3PrimNode
//
// Revision 1.12  2012/04/16 14:16:02  lulin
// - ������ ����.
//
// Revision 1.11  2012/04/04 09:02:53  lulin
// {RequestLink:237994598}
//
// Revision 1.10  2011/06/20 15:17:59  lulin
// {RequestLink:269083814}.
//
// Revision 1.9  2009/10/21 17:39:56  lulin
// - ������������ ������ �� ���������� ������.
//
// Revision 1.8  2009/10/21 16:25:53  lulin
// - ��������� �� ������ ���� ��������.
//
// Revision 1.7  2009/10/21 12:37:45  lulin
// - ��������� �� ������ ������� ����.
//
// Revision 1.6  2009/10/21 10:05:37  lulin
// - �������������.
// - ������ ����.
//
// Revision 1.5  2009/10/20 17:29:01  lulin
// {RequestLink:159360578}. �4.
//
// Revision 1.4  2009/10/19 13:07:56  lulin
// {RequestLink:159360578}. �7.
//
// Revision 1.3  2009/10/07 16:16:53  lulin
// - ��������� ������ "������, �������".
//
// Revision 1.2  2009/09/29 16:34:53  lulin
// {RequestLink:159360578}. �39.
// �������� ������������� �������.
//
// Revision 1.1  2009/09/14 11:28:58  lulin
// - ������� ���� � ��� ������������� �������.
//
// Revision 1.162  2009/08/19 08:50:59  oman
// - new: ���������� �������� - {RequestLink:159355458}
//
// Revision 1.161  2009/08/04 11:25:31  lulin
// [$159351827].
//
// Revision 1.160  2009/02/10 19:03:13  lulin
// - <K>: 133891247. �������� �������� ���������� ������.
//
// Revision 1.159  2009/02/10 16:26:51  lulin
// - <K>: 133891247. ��������� ���������� GUI.
//
// Revision 1.158  2009/02/09 15:51:00  lulin
// - <K>: 133891247. �������� ���������� ��������� ����.
//
// Revision 1.157  2009/02/09 13:57:04  lulin
// - <K>: 133891247. �������� ���������� ��� ������.
//
// Revision 1.156  2009/02/09 13:38:51  lulin
// - <K>: 133891247. ��������� ��������� ����������.
//
// Revision 1.155  2008/12/12 19:18:40  lulin
// - <K>: 129762414.
//
// Revision 1.154  2008/10/31 10:44:59  lulin
// - <K>: 121167580.
//
// Revision 1.153  2008/10/30 15:09:03  lulin
// - <K>: 121159648.
//
// Revision 1.152  2008/05/22 10:34:46  mmorozov
// - �������� ���� ������.
//
// Revision 1.151  2008/05/22 10:14:46  mmorozov
// - new: �������� ���� ������.
//
// Revision 1.150  2008/05/22 07:05:39  mmorozov
// - new: �������� ���� ������.
//
// Revision 1.149  2008/02/29 05:30:38  mmorozov
// - new: ������� �������� ����� � ����� � ��������� ���������;
//
// Revision 1.148  2008/02/05 18:54:59  lulin
// - ��������� �������� ������������� ����� ������.
//
// Revision 1.147  2008/01/31 13:24:05  lulin
// - �������� �������� ������ �� ��������.
//
// Revision 1.146  2008/01/10 07:23:10  oman
// ������� �� ����� �������
//
// Revision 1.145  2007/12/26 14:15:23  lulin
// - ������ l3Interfaces ��������� ��������� �� ������.
//
// Revision 1.144  2007/12/26 10:46:03  lulin
// - cleanup.
//
// Revision 1.143  2007/12/25 23:54:27  lulin
// - ������ l3Tree_TLB ��������� ��������� �� ������.
//
// Revision 1.142  2007/12/25 12:11:03  lulin
// - ������ �������� ���������.
//
// Revision 1.141  2007/12/25 12:03:51  lulin
// - ������ �������� �����.
//
// Revision 1.140  2007/10/09 11:21:36  mmorozov
// - new: � ��������� ����� ������ ��������� ���������� �������� ��������� (CQ: OIT5-26918) + ������������� �����������;
//
// Revision 1.139  2007/04/16 10:59:31  mmorozov
// - new behaviour: ����� ������� � ���������� �������� ��������� �������� ���������� ������� ������;
//
// Revision 1.138  2007/04/16 10:45:10  mmorozov
// - new behaviour: �������� ��������� �������� ���������� ������������ 170 ��������� (CQ: OIT5-25057);
//
// Revision 1.137  2007/04/11 15:15:19  mmorozov
// - new: � ������� �������� ���� ���������� ������ �������� � ������ ��������� �������� (CQ: OIT5-24958);
//
// Revision 1.136  2007/03/21 14:14:48  lulin
// - cleanup.
//
// Revision 1.135  2007/03/20 13:31:57  lulin
// - ���������� ������ � ����������.
//
// Revision 1.134  2007/03/19 14:24:14  lulin
// - ����������� �� ������� ��������� � ������ ���������� ������.
//
// Revision 1.133  2007/03/16 12:20:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.132  2007/02/28 16:30:43  lulin
// - ���������� ������������ ��������� ������.
//
// Revision 1.131  2007/02/16 16:31:28  lulin
// - ����������� �� ������������ ���������� ����.
//
// Revision 1.130  2007/02/16 15:36:08  lulin
// - cleanup.
//
// Revision 1.129  2007/02/09 12:37:41  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.128  2007/02/08 15:31:45  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.127  2007/02/07 19:47:35  lulin
// - new build.
//
// Revision 1.126  2007/02/07 14:30:31  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.125  2007/02/02 13:23:48  lulin
// - �������� �������������� �����.
//
// Revision 1.124  2007/02/02 09:10:36  lulin
// - �������� �������������� �����.
//
// Revision 1.123  2007/01/31 19:11:46  lulin
// - ��������� � ������� � ����������.
//
// Revision 1.122  2007/01/31 19:00:09  lulin
// - ��������� � ������� � ����������.
//
// Revision 1.121  2007/01/30 15:24:04  lulin
// - ����� ���� - ������ ����� �������� ����.
//
// Revision 1.120  2007/01/22 13:43:22  lulin
// - ������ ��� ���� ���������� �� ������ ����������.
//
// Revision 1.119  2007/01/22 13:06:36  lulin
// - ����������� �� �������� ������� ���� ����.
//
// Revision 1.118  2007/01/22 12:54:40  lulin
// - cleanup.
//
// Revision 1.117  2007/01/22 12:31:47  lulin
// - ����� �����-�� �������� ��� - ������������� �������� AV.
//
// Revision 1.116  2007/01/22 12:22:54  lulin
// - ��������� �� ����� ���������� ������.
//
// Revision 1.115  2007/01/22 11:19:30  lulin
// - cleanup.
//
// Revision 1.114  2007/01/18 12:57:11  mmorozov
// - new: ������� �������� ���� (CQ: OIT5-23939);
//
// Revision 1.113  2006/12/27 12:06:42  lulin
// - ���� ��������� �������� - ������� ������������ ������ �������� �����.
//
// Revision 1.112  2006/12/27 09:46:34  lulin
// - ��� ������, ����������� ������� ���� ���������� � ����.
//
// Revision 1.111  2006/12/25 10:19:16  lulin
// - ��������� ������ ������ �������� ����� �������, � �� �����.
//
// Revision 1.110  2006/12/22 15:06:18  lulin
// - ����� ���� - ������ ��������� � ������ � ������� ���������.
//
// Revision 1.109  2006/12/22 12:11:06  lulin
// - cleanup.
//
// Revision 1.108  2006/12/22 11:47:31  lulin
// - �� ������������� ����� ������ ��� ������ � ������.
//
// Revision 1.107  2006/12/20 12:09:31  lulin
// - cleanup.
//
// Revision 1.106  2006/12/20 11:39:59  lulin
// - cleanup.
//
// Revision 1.105  2006/12/20 10:37:48  lulin
// - cleanup.
//
// Revision 1.104  2006/12/15 11:04:16  lulin
// - cleanup.
//
// Revision 1.103  2006/12/15 10:45:44  oman
// - fix: ��������� ��������� "�������� %d �� %d" ��� ������
//  �������� (cq22970)
//
// Revision 1.102  2006/05/12 07:16:55  oman
// warning fix
//
// Revision 1.101  2006/04/20 14:31:16  lulin
// - ����������� �����.
// - ������ ����� ��������� �������������� �������.
//
// Revision 1.100  2006/03/21 15:03:58  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr, DebugStr � SystemStr)
//
// Revision 1.99  2005/11/09 15:28:16  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.98  2005/07/21 14:47:11  lulin
// - ������� ����������� ���� �������� � ��������� ������.
//
// Revision 1.97  2005/07/12 15:52:26  lulin
// - bug fix: ���������� ������� ������� � ������� ������ ������ �������������.
//
// Revision 1.96  2005/06/30 07:48:05  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.95  2005/06/16 09:23:38  mmorozov
// change: ������� ���������� � ��������� �� ����� ������;
//
// Revision 1.94  2005/06/16 08:19:07  mmorozov
// change: ������� ���������� � ��������� �� ����� ������;
//
// Revision 1.93  2005/06/08 05:11:36  mmorozov
// - change: �������� ������� _caption-� ������ �������������� � _TnsWindowList (_TnsWindowNode);
//
// Revision 1.92  2005/06/07 11:23:25  mmorozov
// new: class _TnsWindowNode;
//
// Revision 1.91  2005/04/08 12:08:40  mmorozov
// bugfix: ��� ��������� ����� ��������� ��� ��������� ���� ���� AV;
//
// Revision 1.90  2005/04/07 14:37:35  cyberz
// new behavioiur: ��� ��������� �������� OnDemand;
//
// Revision 1.89  2005/01/26 16:26:51  demon
// - fix: ����������� ������ �� �������� ���� ���������� ������� �����, ���� ��������� ������ ��� �� ���������, ����� ������������� ��� �������� ������ �� ���� ���������.
//
// Revision 1.88  2005/01/26 10:57:47  demon
// - fix: ��� �������� ��������� ������ ������� ���� changeing/changed � ������ �������� ����� ��������
//
// Revision 1.87  2005/01/18 06:13:01  mmorozov
// change: ����������� �� �������� � TnsUsualNode.Remove ���������� ����, �.�. ����� ��������������� �������� ����;
//
// Revision 1.86  2004/12/25 09:13:36  mmorozov
// new: property InsBookmarkNode.DocName;
//
// Revision 1.85  2004/12/23 08:41:32  lulin
// - ������� �������� ������.
//
// Revision 1.84  2004/12/14 16:02:23  demon
// - fix: ��������� ��� �������� ��������� �������� � ������.
//
// Revision 1.83  2004/12/09 15:35:02  mmorozov
// remove: property InsQueryNode.Date;
//
// Revision 1.82  2004/12/04 14:41:37  mmorozov
// new: property InsQueryNode.DocCount;
//
// Revision 1.81  2004/11/30 13:39:01  mmorozov
// NEW:
// - _InsWrapperNode, _TnsWrapperNode;
// - InsBookmarkNode, _TnsBookmarkNode;
// - InsQueryNode, _TnsQueryNode;
//
// Revision 1.80  2004/11/22 16:25:32  demon
// - fix: ����������� �������� �������� TnsCachableNode.InsertChildBefore + � TnsBaseNode �� ��� �������� ����� Get_AllChildrenCount.
//
// Revision 1.79  2004/11/22 12:26:55  demon
// - fix: �� ��������� �������� �������� TnsCachableNode.InsertChildBefore, ���� ��������� ������� ������.
//
// Revision 1.78  2004/08/31 15:39:46  am
// new: nsMakeTreeLevel
//
// Revision 1.77  2004/08/31 12:08:13  am
// change: ������ ������ �����������
//
// Revision 1.76  2004/08/31 11:53:39  am
// change: ������ ������ �����������
//
// Revision 1.75  2004/08/30 12:35:58  mmorozov
// new: _TnsNewCachableNode;
//
// Revision 1.74  2004/08/09 10:12:35  am
// new: TnsPrimCacheableNode._IsCaptionCached - ���������� �� f_AdapterCaption
//
// Revision 1.73  2004/06/25 12:55:23  am
// new: _nsGetCaption ��� _INodeBase
//
// Revision 1.72  2004/06/21 15:42:20  law
// - new behavior: ��������� ����������� �� �������� �����.
//
// Revision 1.71  2004/06/10 11:29:27  law
// - �������� Tl3CustomString.Len ������� �����������.
//
// Revision 1.70  2004/06/02 10:23:03  law
// - ������ ����������� Tl3VList.MakeIUnknown - ����������� _Tl3InterfaceList._Make.
//
// Revision 1.69  2004/05/27 09:01:49  law
// - change: ��������� �� ������� ������ IsMyIntf - ������ ���� ������ ������ ������������ IsSame.
//
// Revision 1.68  2004/05/26 18:18:25  law
// - change: Il3Node ������ ����������� �� Il3SimpleNode.
//
// Revision 1.67  2004/05/26 14:23:54  law
// - change: �������� "��� � ����" (������ ������� � ������).
//
// Revision 1.66  2004/05/18 07:44:30  demon
// - remame: f_Caption � f_AdapterCaption � ������� TnsPrimCacheableNode
//
// Revision 1.65  2004/04/13 15:08:01  law
// - ������ �������� ��������� � Il3Node.
//
// Revision 1.64  2004/04/06 09:43:14  nikitin75
// - ��������� �� IStringOld;
//
// Revision 1.63  2004/04/05 13:54:16  nikitin75
// - ��������� �� IStringOld;
//
// Revision 1.62  2004/03/03 15:49:01  demon
// - fix: ��� �������������� ChildNode �� ����������� f_AllChildrenCount
//
// Revision 1.61  2004/02/02 06:54:08  demon
// - add: ���������� � �������� SortChilds
//
// Revision 1.60  2004/01/30 18:25:31  demon
// - new: ��������� ���������� SortChilds �� TnsBaseNode
//
// Revision 1.59  2004/01/08 16:43:51  law
// - new behavior: �� ������ Next ��� ���������� ������� Next � nil.
//
// Revision 1.58  2004/01/08 15:51:40  law
// - new behavior: �� ������ Next ��� ���������� ������� Next.
//
// Revision 1.57  2003/12/27 16:40:07  law
// - new behavior: �� ���������� ������ ��� ������� ����.
//
// Revision 1.56  2003/12/26 17:14:25  law
// - bug fix: ������� ���������� � ���������� ������ ��� ��� ������� (CQ OIT5-5701).
//
// Revision 1.55  2003/12/11 19:01:30  law
// - cleanup: ����� ������� � AllChildrenCount � ThisChildrenCount.
//
// Revision 1.54  2003/12/11 12:51:30  law
// - rename: ��� ���������� ChildsCount ������������� � AllChildrenCount.
//
// Revision 1.53  2003/12/11 09:55:26  law
// - bug fix: ������ ���� � ������� ���������.
//
// Revision 1.52  2003/12/10 17:30:52  law
// - ����������� ���.
//
// Revision 1.51  2003/12/10 10:28:51  law
// - cleanup.
//
// Revision 1.50  2003/12/10 09:11:10  law
// - new behavior: ������� NumInParent � �������� �������� Prev/Next.
//
// Revision 1.49  2003/12/10 07:11:31  law
// - change: ���������������� � ������� NumInParent � �������� �������� ���.
//
// Revision 1.48  2003/12/09 12:52:24  am
// new: TnsListNode � TnsListItemNode - ���� ��� �������.
//
// Revision 1.47  2003/12/09 11:40:25  law
// - optimization: ����� IsLast ������ � �������� ��������� �� NumInParent. !!! ���� ��������� �� ��������� �� ��� !!!
//
// Revision 1.46  2003/12/05 12:07:42  law
// - new behavior: ������� "����������" �������� �������.
// - bug fix: GetCountView ��������� �� TnsUsualNode.
//
// Revision 1.45  2003/12/04 18:35:23  law
// - change: ������ ���������� ������� CountView, ���� ������ �� �������, �� � ���� ����� �� �����.
//
// Revision 1.44  2003/12/04 14:45:56  demon
// - new behavior: f_AdapterNode � TnsBaseNode ���������� � protected.
// - new: TnsUsualNode.MakeEmpty: Il3Node;
//
// Revision 1.43  2003/11/26 13:21:17  law
// - change: ���������� ReleaseChilds ��������� � TnsBaseNode.
//
// Revision 1.42  2003/11/26 13:14:49  law
// - change: ��������� ����������� _InsLastCache, _InsCacheable ���������� �� TnsBaseNode.
//
// Revision 1.41  2003/11/26 12:59:07  law
// - new behavior: � ������ ������� COMQueryInterface ����������� ������ � AdapterNode.QueryInterface.
//
// Revision 1.40  2003/11/26 12:41:21  law
// - cleanup: ���������� �����������.
//
// Revision 1.39  2003/11/26 12:32:00  law
// - cleanup: ���������� �����������.
//
// Revision 1.38  2003/11/26 12:01:34  law
// - cleanup: ���������� �����������.
//
// Revision 1.37  2003/11/26 11:49:56  law
// - change: ������� ������� ����� TnsBaseNode �� ������� _TnsCacheableNode � TnsUsualNode.
//
// Revision 1.36  2003/11/10 13:11:38  law
// - optimization: ��������� ���������� ������� Tns*Node.pm_GetAdapterNode ���������� � "������" ������� INode.AddRef.
//
// Revision 1.35  2003/10/21 08:29:00  demon
// - add: some optimization ��� ������ � ������� �� ������ ��������.
//
// Revision 1.34  2003/09/23 13:07:02  law
// - bug fix: ��������� �� �������� ��� ������� ���.
//
// Revision 1.33  2003/09/16 13:57:46  demon
// - new: ��� ����������� ������� ���� �������������� ������ Tl3String
//
// Revision 1.32  2003/08/26 16:36:37  demon
// - bug fix: ����������� ��� ��������������� ����, ���� ������ ������� � parent ���������� � ���������.
//
// Revision 1.31  2003/07/24 16:33:24  demon
// - new: �������� f_Caption ������� � protected ������ ��� ������� ���������� ������ get_st � ��������.
//
// Revision 1.30  2003/07/22 17:48:18  demon
// - bug fix: ��������� ������� ������������ ������� ��� Remove
//
// Revision 1.29  2003/07/22 11:50:34  demon
// - add: ���������� _TnsCacheableNode ��������� � ����������.
//
// Revision 1.28  2003/07/21 16:30:09  demon
// - add: ��������� ���������� _TnsCacheableNode (����������������� �� ���������)
//
// Revision 1.27  2003/07/11 16:31:43  demon
// - bug fix: ����� ������� ��������������� ��� ��� �������� ������� ��������.
//
// Revision 1.26  2003/07/11 16:19:52  demon
// - bug fix: ������� ��������������� ��� ��� �������� �� ������� ��������.
//
// Revision 1.25  2003/07/11 13:06:57  demon
// - bug fix: ������� ��������������� ��� ��� �������� ������� ��������.
//
// Revision 1.24  2003/07/11 12:47:15  demon
// - bug fix: ������� ��������������� ��� ��� �������� ��������.
//
// Revision 1.23  2003/07/04 17:37:04  demon
// - new: ������� ���������� �������� ��������� (������ ��� ����������)
//
// Revision 1.22  2003/07/03 13:29:25  law
// - bug fix: �������� ��������� ������. ����� ������ ����� �� ������� ������� - ��� ��������� �������� ���������� ���������� NumInParent ��� ListIndex.
//
// Revision 1.21  2003/07/02 19:45:58  law
// - ����� �� ������������� IDocument � TextSource.
//
// Revision 1.20  2003/07/02 17:26:00  law
// - bug fix: ����������� �������� ������� ������ (TnsListChild). �������� ��������, �� ����� �� ������� �������.
//
// Revision 1.19  2003/07/01 19:58:39  demon
// - new: ���������� �� ������� OnPaint � IList ����� � �����.
//
// Revision 1.18  2003/06/25 15:43:35  demon
// - cleanup.
//
// Revision 1.17  2003/06/25 09:23:39  law
// - change: ParentNodeClass, ChildNodeClass � �������� ������� ��������� �����������, � �� �������.
//
// Revision 1.16  2003/06/24 13:29:46  demon
// - new: �������� ������ �������� _IsFirst (�� ���� ��������� ������� ��������)
//
// Revision 1.15  2003/06/24 08:48:20  law
// - new behavior: � ������ TnsListChild ���������� ������ � IListNode.
//
// Revision 1.14  2003/06/24 08:31:50  law
// - comments: ������������� ����������� ������.
//
// Revision 1.13  2003/06/21 13:01:58  law
// - bug fix: ��� AV ��� ������ TnsUsualNode.IsMyIntf, ����� AdapterNode = nil.
//
// Revision 1.12  2003/06/21 12:49:47  law
// - new class: TnsListChild.
//
// Revision 1.11  2003/06/20 09:39:41  nikitin75
// +������� ��������;
//
// Revision 1.10  2003/06/19 16:51:39  law
// - bug fix: �� ��������� inherited Delete. ������ ��� ����������������, �.�. �� ��������. ���� ��������� � TeeVirtualNode. ����� ��������, ����� ����� � �� ���� ����� �������� UpdateList, ����� �������� ����.
//
// Revision 1.9  2003/06/19 16:10:42  law
// - bug fix: ������ �������, ����� ��������� ���� ������ ����������� Parent'�.
//
// Revision 1.8  2003/06/19 11:31:08  nikitin75
// - ������� _StatusBar � ������;
// - �������� Delete � ���� ������;
//
// Revision 1.7  2003/06/18 09:43:34  law
// - new behavior: ��� ������� NumInParent ���������� ������ � �������.
//
// Revision 1.6  2003/06/11 12:59:20  law
// - new behavior: ������� ����������� NumInParent.
// - bug fix: �� ��� ����� ���� ��������� ��� ��������� �� � ���.
//
// Revision 1.5  2003/06/10 16:16:29  law
// - new behavior: ����� ������ ����������� NumInParent.
//
// Revision 1.4  2003/06/05 09:47:19  demon
// - update: ����������� �������� ������ (������� cache ��� ����������� �����).
//
// Revision 1.3  2003/06/04 14:40:44  demon
// - new behavior: ������� ����������� ������.
//
// Revision 1.2  2003/06/04 10:38:03  demon
// - update: ������� ��������� prev � next ��������� � �������� �� Last � First � TnsUsualNode
//
// Revision 1.1  2003/06/03 16:55:23  demon
// - new units: nsNodes, nsTree.
// - bug fix: �� �������� ������ � ����� �������.
//

{$Include nsDefine.inc }

interface

// <no_string>

uses
  l3Types,
  l3TreeInterfaces,
  l3Tree_TLB,
  l3Interfaces,
  l3IID,
  l3Base,
  l3Nodes,

  vcmInterfaces,

  nsTypes,

  BaseTreeSupportUnit,
  DynamicTreeUnit,
  IOUnit,

  nsPrimNode,
  nsPrimAdapterNode,
  nsPrimCacheableNode,
  nsBaseNode,
  nsWrapperNode
  ;

type
  TnsCacheableNode = class(TnsBaseNode)
   {* ���� ������������� ������, ����������� �� AdapterNode. }
    private
      f_ThisChildrenCount : Integer;
    protected
    // internal fields
      f_Caption         : Tl3String;
    protected
      procedure ClearCache;
        override;
        {-}
      function  GetLevelForParent(const aNode : Il3SimpleNode) : Integer;
        override;
        {-}
      function DoGetIndexInParent: Integer;
        override;
        {-}
      procedure DoClearNums;
        override;
        {-}
      procedure DoIncAllChildrenCount(aInc : Integer);
        override;
        {-}
      function  GetAsPCharLen: Tl3PCharLenPrim;
        override;
        {-}
      procedure DoSetAsPCharLen(const Value: Tl3PCharLen);
        override;
        {-}
      procedure InitFields;
        override;
        {-}
    public
    // public methods
      function  IsFirstNode: Boolean;
        override;
        {-}
      function  IsLastNode: Boolean;
        override;
        {-}
      function  Get_ParentNode: Il3Node;
        override;
        {-}
      procedure Set_ParentNode(const aValue : Il3Node);
        override;
        {-}
      function  Get_NextNode: IL3Node;
        override;
        {-}
      function  Get_PrevNode: IL3Node;
        override;
        {-}
      procedure Set_PrevNode(const aNode: IL3Node);
        override;
        {-}
      function DoGetThisChildrenCount: Integer;
        override;
        {-}
      procedure Remove;
        override;
        {-}
      function DoInsertChildBefore(const aNextChild : Il3Node;
                                  const aChild : Il3Node) : Il3Node;
        override;
        {-}
      procedure Set_NextNodePrim(const aValue: Il3Node);
        override;
        {-}
      procedure Set_NextNode(const aNode : Il3Node);
        override;
        {-}
  end;//TnsCacheableNode

  RnsCacheableNode = class of TnsCacheableNode;

  {$If not Defined(Admin)}
  TnsRootNode = TnsWrapperNode;
  {$IfEnd}

function nsGetCaption(const aNode : INode) : Il3CString;
  overload;
  {-}
function nsGetCaption(const aNode: INodeBase): Il3CString;
  overload;
  {-}
function nsGetHint(const aNode : INode) : Il3CString;
  overload;
  {-}
function nsGetHint(const aNode : INodeBase) : Il3CString;
  overload;
  {-}
procedure nsMakeTreeLevel(const aNode : Il3Node;
                          const aAdapterNode : INodeBase);
  {-}

implementation

uses
  SysUtils,

  l3String,
  l3InterfacesMisc,
  l3MinMax,

  DebugStr,

  BaseTypesUnit,
  nsNewCachableNode
  ;

function nsGetCaption(const aNode: INodeBase): Il3CString;
Var
 l_Str: IString;
begin
 if aNode <> nil then
 begin
  aNode.GetCaption(l_Str);
  Result := nsCStr(l_Str);
 end//if aNode <> nil then
 else
  Result := nil;
end;//nsGetCaption

function nsGetCaption(const aNode : INode) : Il3CString;
var
 l_String : IString;
begin
 if Assigned(aNode) then
  aNode.GetCaption(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetHint(const aNode : INode) : Il3CString;
var
 l_String : IString;
begin
 if Assigned(aNode) then
  aNode.GetHint(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
end;

function nsGetHint(const aNode : INodeBase) : Il3CString;
{var
 l_String : IString; }
begin
 Result := nsCStr('');
{
 if Assigned(aNode) then
  aNode.GetHint(l_String)
 else
  l_String := nil;
 Result := nsCStr(l_String);
}
end;

// start class TnsCacheableNode

procedure TnsCacheableNode.InitFields;
  //override;
  {-}
begin
 inherited;
 f_ThisChildrenCount := -1;
end;

procedure TnsCacheableNode.ClearCache;
begin
 f_ThisChildrenCount := -1;
 AdapterNode := nil;
 DoClearNums;
 Set_NextNode(nil);
 ChildNode := nil;
 Set_ParentNode(nil);
 Set_PrevNode(nil);
 LastChild := nil;
 l3Free(f_Caption);
 inherited;
end;

function TnsCacheableNode.DoGetIndexInParent: Integer;
begin
 Result := GetNumInParent(True);
end;

procedure TnsCacheableNode.DoClearNums;
begin
 f_ThisChildrenCount := -1;
 inherited;
end;

procedure TnsCacheableNode.DoIncAllChildrenCount(aInc: Integer);
begin
 if aInc <> 0 then
  f_ThisChildrenCount := -1;
 inherited DoIncAllChildrenCount(aInc);
end;

function TnsCacheableNode.IsFirstNode: Boolean;
begin
 if (f_NumInParent > 0) OR (f_TotalNumInParent > 0) then
  Result := false
 else
  if (f_NumInParent = 0) OR (f_TotalNumInParent = 0) then
   Result := true
  else
  begin
   Result := (ParentNode = nil) or (f_PrevNode = nil);
   if Result then
   begin
    f_NumInParent := 0;
    f_TotalNumInParent := 0;
   end;//Result
  end;//(f_NumInParent = 0) OR (f_TotalNumInParent = 0)
end;

function TnsCacheableNode.IsLastNode: Boolean;
begin
 Result := (ParentNode = nil) or (NextNode = nil);
end;

function TnsCacheableNode.Get_ParentNode: Il3Node;
begin
 if (f_ParentNode <> nil) then
  Result := Il3Node(f_ParentNode)
 else
  Result := nil;
end;

procedure TnsCacheableNode.Set_ParentNode(const aValue : Il3Node);
begin
 f_ParentNode := Pointer(aValue);
end;

function TnsCacheableNode.Get_NextNode : IL3Node;
begin
 if (NextNode <> nil) then
  Result := NextNode
 else
  Result := ParentNode.ChildNode;
end;

function TnsCacheableNode.Get_PrevNode: Il3Node;
begin
 if (f_PrevNode <> nil) then
  Result := Il3Node(f_PrevNode)
 else
  Result := (ParentNode as InsLastCache).LastChild;
end;

procedure TnsCacheableNode.Set_PrevNode(const aNode: Il3Node);
begin
 f_PrevNode := Pointer(aNode);
 DoClearNums;
 CallNextClearNums;
end;

function TnsCacheableNode.DoGetThisChildrenCount: Integer;

 procedure CountChild(const aNode: Il3Node);
 begin//CountChild
  Inc(Result);
 end;//CountChild

begin
 if (f_ThisChildrenCount < 0) then
 begin
  Result := 0;
  IterateF(l3L2NA(@CountChild), imOneLevel);
  f_ThisChildrenCount := Result;
 end//f_ThisChildrenCount < 0
 else
  Result := f_ThisChildrenCount;
end;

function TnsCacheableNode.GetAsPCharLen: Tl3PCharLenPrim;
  //override;
  {-}
begin
 if (f_Caption <> nil) then
  Result := f_Caption.AsPCharLen
 else
  Result := inherited GetAsPCharLen;
end;

procedure TnsCacheableNode.DoSetAsPCharLen(const Value: Tl3PCharLen);
  //override;
  {-}
begin
 if l3IsNil(Text) then
  l3Set(f_Caption, Value);
end;

procedure TnsCacheableNode.Remove;
var
 l_Parent   : Il3InternalNode;
 l_SaveSelf : Il3Node;
begin
 l_Parent := (ParentNode As Il3InternalNode);
 if (l_Parent = nil) then exit;
 l_SaveSelf := Self;
 try
  Changing;
  try
   Notify(ntDelete, l_SaveSelf);

   if IsFirst then
   begin
    if IsLast then
    begin
     (l_Parent As InsLastCache).LastChild := nil;
     l_Parent.ChildNode := nil;
    end//IsLast
    else
     l_Parent.ChildNode := NextNode;
   end//IsFirst
   else
    if IsLast then
     (l_Parent As InsLastCache).LastChild := Il3Node(f_PrevNode);

   if (f_PrevNode <> nil) then
    (Il3Node(f_PrevNode) as Il3InternalNode).NextNode := NextNode;

   if (NextNode <> nil) then
    (NextNode as Il3InternalNode).PrevNode := Il3Node(f_PrevNode);

   Set_NextNode(nil);
   Set_PrevNode(nil);
   DoClearNums;

   l_Parent.IncAllChildrenCount(-Succ(AllChildrenCount));
  finally
   Changed;
  end;
  Set_ParentNode(nil);
 finally
  l_SaveSelf := nil;
 end;//try..finally
end;

function TnsCacheableNode.DoInsertChildBefore(const aNextChild : Il3Node;
                                            const aChild : Il3Node) : Il3Node;
var
 lPrevNode,
 lNextNode  : Il3Node;
begin
 Changing;
 try
  Result := aChild;
  (aChild as Il3InternalNode).ParentNode := Self;
  if not HasChild then
  begin
   Set_ChildNode(aChild);
   Set_LastChild(aChild);
   (aChild as Il3InternalNode).NextNode := nil;
   (aChild as Il3InternalNode).PrevNode := nil;
  end
  else
  begin
   if ChildSorted then
   begin
    Assert(False, '�� �������������� ���������� �����');
        (*
        lNextNode := Child;
        While True do
         begin
          If CompareChild(aChild, lNextNode) < 0
           then
            begin
             If Child = lNextNode then Child := lNewChild;
             Break;
            end;

          lNextNode := lNextNode.Next;

          If lNextNode.IsFirst {����� ������}
           then
            begin
             lNextNode := Child;
             Break;
            end;
         end; *)
   end
   else
    if aNextChild = nil then
    begin
     lPrevNode := LastChild;
     LastChild := aChild;
     lNextNode := nil;
    end
    else
    begin
     lNextNode := aNextChild;
     if ChildNode = lNextNode then
     begin
      ChildNode := aChild;
      lPrevNode := nil;
     end
     else
      lPrevNode := lNextNode.PrevNode;
    end;

   if lPrevNode <> nil then
    (lPrevNode as Il3InternalNode).NextNode := aChild;
   if lNextNode <> nil then
    (lNextNode as Il3InternalNode).PrevNode := aChild;

   (aChild as Il3InternalNode).NextNode := lNextNode;
   (aChild as Il3InternalNode).PrevNode := lPrevNode;
  end;

  {Increment AllChildrenCount}
  IncAllChildrenCount(Succ(aChild.AllChildrenCount));
  f_ThisChildrenCount := -1;
  Notify(ntInsert, aChild);
 finally
  Changed;
 end;
end;

function TnsCacheableNode.GetLevelForParent(const aNode : Il3SimpleNode) : Integer;
var
 lCNode  : Il3SimpleNode;
begin
 Result := 0;
 lCNode := Self;
 while (lCNode <> nil) and not lCNode.IsSame(aNode) do
 begin
  Inc(Result);
  lCNode := lCNode.Parent;
 end;//while (lCNode <> nil)
 if (lCNode = nil) then Result := -1;
end;

procedure TnsCacheableNode.Set_NextNodePrim(const aValue: Il3Node);
  //override;
  {-}
begin
 if not l3IEQ(NextNode, aValue) then
 begin
  if (NextNode <> nil) then
   CallNextClearNums;

  NextNode := aValue;
 end;//if not l3IEQ(NextNode,aNode)
end;

procedure TnsCacheableNode.Set_NextNode(const aNode : Il3Node);
begin
 Set_NextNodePrim(aNode);
end;

procedure nsMakeTreeLevel(const aNode : Il3Node;
                          const aAdapterNode : INodeBase);
var
 l_Child : INodeBase;
 l_Node  : INodeBase;
begin
 if (aAdapterNode <> nil) then
 begin
  aAdapterNode.GetFirstChild(l_Child);
  while (l_Child <> nil) do
  begin
   aNode.InsertChild(TnsNewCachableNode.Make(l_Child));
   l_Child.GetNext(l_Node);
   l_Child := l_Node;
  end;//while (l_Child <> nil)
 end;//aAdapterNode <> nil
end;

end.
