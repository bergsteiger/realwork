unit nsQuery;

// $Id: nsQuery.pas,v 1.16 2015/05/14 15:15:14 morozov Exp $

// $Log: nsQuery.pas,v $
// Revision 1.16  2015/05/14 15:15:14  morozov
// {RequestLink: 597354916}
//
// Revision 1.15  2015/03/15 13:00:18  kostitsin
// {requestlink: 590754782 }
//
// Revision 1.14  2013/09/16 07:11:33  kostitsin
// [$239370589]
//
// Revision 1.13  2013/08/12 07:10:30  morozov
// {RequestLink: 475475311}
//
// Revision 1.12  2013/08/09 11:31:38  morozov
// {RequestLink: 475475311}
//
// Revision 1.11  2013/06/27 08:37:59  morozov
// {RequestLink: 461713135}
//
// Revision 1.10  2013/04/24 09:35:57  lulin
// - ���������.
//
// Revision 1.9  2011/01/27 12:16:39  lulin
// {RequestLink:248195582}.
// - ����������� �� ����������� �������.
//
// Revision 1.8  2010/11/01 17:20:11  lulin
// {RequestLink:237994238}.
// - ������� ������ �� "������".
// - ������, ����� ���������� ������ �������.
//
// Revision 1.7  2010/11/01 13:20:46  lulin
// {RequestLink:237994238}.
//
// Revision 1.6  2010/10/25 09:55:24  lulin
// {RequestLink:237502802}.
// ��� �3.
//
// Revision 1.5  2010/10/12 11:11:51  oman
// - new: ��������� {RequestLink:235057812}
//
// Revision 1.4  2009/12/08 06:48:51  oman
// �� ����������
//
// Revision 1.3  2009/12/07 19:13:21  lulin
// - ������ �������� ������.
//
// Revision 1.2  2009/12/07 18:42:18  lulin
// - ��������� "���������� ������ �������" � ���������� �����.
//
// Revision 1.1  2009/11/06 14:44:33  lulin
// {RequestLink:169542133}.
//
// Revision 1.1  2009/10/29 14:36:07  lulin
// - ������ ����� �������� �� ������ �� ������� ����������� ����������.
//
// Revision 1.149  2009/09/15 16:32:54  lulin
// - �������� ������ ������������ ��������� �������� �� ������.
//
// Revision 1.148  2009/07/31 17:30:07  lulin
// - ������� �����.
//
// Revision 1.147  2009/06/08 07:25:39  oman
// - new: ���������� ���������� ������ - [$140286494]
//
// Revision 1.146  2009/02/10 19:04:03  lulin
// - <K>: 133891247. �������� �������� ���������� ������.
//
// Revision 1.145  2009/02/09 19:17:30  lulin
// - <K>: 133891247. �������� ���������� ������.
//
// Revision 1.144  2009/02/09 11:57:18  lulin
// - <K>: 133891247.
//
// Revision 1.143  2008/12/29 16:41:04  lulin
// - <K>: 134316705.
//
// Revision 1.142  2008/10/21 12:07:08  oman
// - fix: ������������ ��������� ������� (�-121157521)
//
// Revision 1.141  2008/08/04 11:56:11  oman
// - new: ��������� ������� ����� �������� (K-103449413)
//
// Revision 1.140  2008/08/04 11:27:31  oman
// - new: ��������� ������� ����� �������� (K-103449413)
//
// Revision 1.139  2008/04/16 11:24:23  mmorozov
// - ������� � ������ ����������.
//
// Revision 1.138  2008/04/02 11:42:51  mmorozov
// - ����� ����� ���������������� ������ (������� ����� ������);
//
// Revision 1.137  2008/03/26 14:29:03  lulin
// - <K>: 88080898.
//
// Revision 1.136  2008/03/26 11:37:16  lulin
// - �������� � ������ <K>: 88080898.
//
// Revision 1.135  2008/03/26 11:12:52  lulin
// - �������� � ������ <K>: 88080898.
//
// Revision 1.134  2008/02/14 17:08:49  lulin
// - cleanup.
//
// Revision 1.133  2008/01/24 12:13:00  oman
// - fix: ��������� '@' ������� � ����� ��������� (cq13934)
//
// Revision 1.132  2008/01/10 07:23:08  oman
// ������� �� ����� �������
//
// Revision 1.131  2007/12/25 11:32:05  mmorozov
// - new: �������� �� ���������� ������ ���������� (CQ: OIT5-27823);
//
// Revision 1.130  2007/12/21 07:12:12  mmorozov
// - new: �������� �� ����������� �� ���������� ������ (CQ: OIT5-27823);
//
// Revision 1.129  2007/10/09 11:21:50  mmorozov
// - new: � ��������� ����� ������ ��������� ���������� �������� ��������� (CQ: OIT5-26918) + ������������� �����������;
//
// Revision 1.128  2007/08/14 19:31:55  lulin
// - ������������ ������� ������.
//
// Revision 1.127  2007/08/14 14:29:57  lulin
// - ������������ ����������� ������ ������.
//
// Revision 1.126  2007/07/27 10:31:42  oman
// - new: ������ ������� �������� ������������ ��������� (cq26086)
//
// Revision 1.125  2007/07/16 09:01:43  oman
// - fix: ��������� ������ "_" � ����������� ������ (cq25917)
//
// Revision 1.124  2007/07/11 12:55:41  oman
// - fix: ��� ����������� ������ ������ ������� ������� ��������
//  ������� (cq25909)
//
// Revision 1.123  2007/06/28 13:32:32  lulin
// - cleanup.
//
// Revision 1.122  2007/06/19 12:01:48  lulin
// - ������� �������� ��������� (<K>-20218355).
//
// Revision 1.121  2007/06/05 12:26:05  oman
// - fix: ����� �������� �� �������� ����������� ������� �����
//  �������  (cq25518)
//
// Revision 1.120  2007/05/23 10:28:24  lulin
// - cleanup.
//
// Revision 1.119  2007/05/18 13:09:09  lulin
// - ���������� ���������������� ����� ���������.
//
// Revision 1.118  2007/05/18 12:49:22  lulin
// - �������� �����.
//
// Revision 1.117  2007/05/17 12:40:12  lulin
// - ������� �������� �� ������������.
//
// Revision 1.116  2007/04/05 13:42:52  lulin
// - ����������� �� ������ �������������� �����.
//
// Revision 1.115  2007/04/05 07:58:27  lulin
// - ����������� �� ������ �������������� ����� ��� ������ � ���������.
//
// Revision 1.114  2007/03/27 11:59:34  oman
// ��������� ��� ��������� �� ����������� ������
//
// Revision 1.113  2007/03/13 13:37:38  lulin
// - ����������� �� ������, ������������ � ���������� ������������� � ���������� ���������� �����.
//
// Revision 1.112  2007/02/19 12:37:27  lulin
// - bug fix: �������� ���� �������� ���������.
//
// Revision 1.111  2007/02/16 12:38:26  lulin
// - ���������� ��������� ����� �� ��������� � �����.
//
// Revision 1.110  2007/02/14 16:51:00  lulin
// - ����������� �� ������������� ����������� �����.
//
// Revision 1.109  2007/02/14 16:13:54  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.108  2007/02/14 14:24:20  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.107  2007/02/12 18:45:01  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.106  2007/02/12 09:58:51  lulin
// - bug fix: ���������� ������� ��������� ��������� ��������.
//
// Revision 1.105  2007/02/09 13:09:17  lulin
// - ������� ����� "�������+�����".
//
// Revision 1.104  2007/02/09 12:58:29  lulin
// - �������� ������� �������������� � ������� ������ ��������.
//
// Revision 1.103  2007/02/02 12:25:44  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.102  2007/02/02 08:39:25  lulin
// - ��������� �� ������ � ����������.
//
// Revision 1.101  2007/01/19 14:35:49  mmorozov
// - new: ����� �� ��������� � ������� �������� ��������� ���� (CQ: OIT5-23939);
//
// Revision 1.100  2006/12/07 08:32:16  lulin
// - cleanup.
//
// Revision 1.99  2006/11/03 09:46:21  oman
// Merge with B_NEMESIS_6_4_0
//
// Revision 1.98.2.3  2006/10/25 07:31:17  oman
// ����� ���������� �������� ���������
//
// Revision 1.98.2.2  2006/10/25 07:29:39  oman
// ���������� ���������� �� StdStr
//
// Revision 1.98.2.1  2006/10/19 07:34:02  oman
// - fix: �������� �������� ������������ ��������� (cq23105)
//
// Revision 1.98  2006/09/28 15:03:31  oman
// - new: �������� ������� ���������� �������� ��� �������
//  �� ��������� (cq22776)
//
// Revision 1.97  2006/09/27 13:42:15  mmorozov
// � ������ ������ ��� CQ: OIT500022679.
//
// - remove: TTagSearch, TTagSearchList, TAvailableTags. � ������ ���� �� ��������������, � ������������ ����� ��� ������ ��������������, ����� ���� �������� _IAttributeInfo;
// - remove: �������������� �������� � enSelectedAttributesForm (enSelectedList: opAdd, opDelete, opChangeOperation);
// - new: TnsTaggedTreeInfo ������� �������;
//
// Revision 1.96  2006/09/14 14:16:27  oman
// - new: ��������� � �� �� (cq22535)
//
// Revision 1.95  2006/09/05 09:59:38  oman
// - new beh: ��� ��������� � ����������� �������� ������
//  ������ "�" (cq22471)
//
// Revision 1.94  2006/06/29 11:56:13  mmorozov
// - change: ��������� � ����� � ��������� ���� GblAdapter.TDateTime;
//
// Revision 1.93  2006/05/15 15:35:53  dinishev
// Bug fix: �� ������� '-' ������������ ��������
//
// Revision 1.92  2006/05/12 11:41:41  dinishev
// Bug fix: ������� '/' � '-' ����� ���� ������������ � ����������� �������
//
// Revision 1.91  2006/04/18 14:06:55  oman
// - new beh: ������������� StdStr � _StdRes
//
// Revision 1.90  2006/03/28 11:56:45  oman
// - change: ������� %s � ���������� + ����������� �� ������ ��������� �� �������� � ����.
//
// Revision 1.89  2006/03/21 10:18:15  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr, DebugStr � SystemStr)
//
// Revision 1.88  2006/03/20 09:27:50  oman
// - new beh: ������������� ��� ��������� ��������� � ��� ����� (StdStr, DebugStr � SystemStr)
//
// Revision 1.87  2006/03/16 15:07:44  mmorozov
// - new: �������������� �������� ������������ ���������� (cq: 18871);
//
// Revision 1.86  2005/10/24 10:44:44  mmorozov
// bugfix: �� ����������� ����������� �������;
//
// Revision 1.85  2005/09/05 14:22:35  demon
// - new behavior: ������������� ����������� �������� �� �� ������ (������� ���� �� ��������)
//
// Revision 1.84  2005/08/30 12:49:03  dinishev
// Bug fix: ����������� ����� ������ ������ ����, ���� ��� �� �����������
//
// Revision 1.83  2005/08/11 12:51:01  dinishev
// ����� ������� ���������� ��� � ������
//
// Revision 1.82  2005/08/04 13:45:17  mmorozov
// new: methods AdapterToClient, nsGetOperations;
//
// Revision 1.81  2005/07/22 08:43:40  mmorozov
// - ������� �� ����� ������;
//
// Revision 1.80  2005/07/19 15:01:32  mmorozov
// new: procedures _SaveDateNew, SaveContextNew, SaveAttributeNew, LSelectionToLOperation;
//
// Revision 1.79  2005/06/30 07:48:26  cyberz
// READY FOR TIE-TEMPLATE GENERATION
//
// Revision 1.78  2005/02/28 09:33:58  demon
// - new behavior: ��� �������� ������� _IQuery �� �������� ����� ��������� ��� ���
// - new behavior: ���� _IQuery.Type ����� readonly
//
// Revision 1.77  2005/02/15 08:11:58  mmorozov
// new: ���������� ��������� CreateQuery;
// change: ��������� ��������� ������������� ���������� � ������ nsQuery � ������ resourcestring;
//
// Revision 1.76  2004/12/27 10:17:20  mmorozov
// - _format code;
//
// Revision 1.75  2004/11/30 13:37:07  mmorozov
// - GblAdapterDateToDateTime ���������� �� _nsAttributeSearch;
//
// Revision 1.74  2004/09/28 10:36:07  am
// change: ������ ����������
//
// Revision 1.73  2004/09/23 15:36:45  am
// bugfix: �������� ������ '&'
//
// Revision 1.72  2004/09/07 16:22:27  law
// - ������� Nemesis �� ������������ �������.
//
// Revision 1.71  2004/08/31 11:53:33  am
// change: ������ ������ �����������
//
// Revision 1.70  2004/08/06 14:42:04  demon
// - cleanup: remove warnings and hints
//
// Revision 1.69  2004/07/07 07:50:16  am
// change: Cleanup
//
// Revision 1.68  2004/07/05 06:06:45  am
// change: ������� "�" � ������ ����������� �������� (����� ����, ��� �� �� �������� � "�".."�")
//
// Revision 1.67  2004/06/23 11:31:13  mmorozov
// delete: ������ ���������� SaveAttribute;
//
// Revision 1.66  2004/06/15 14:57:57  mmorozov
// - ������ TLogicSelection �� TLogicOperation;
//
// Revision 1.65  2004/06/15 13:07:48  mmorozov
// delete: todo;
//
// Revision 1.64  2004/06/15 10:47:32  mmorozov
// new: ��� ������������� ������ SaveAttribute;
//
// Revision 1.63  2004/05/24 10:54:52  am
// change: ������� "*" � ������ ���������� �������� ��� ����� ���������. "*" ����� ������ ������ � ����� ����� (����� ���������-�������� ��������)
//
// Revision 1.62  2004/05/21 13:15:31  am
// bugfix: ���������� ������� ��� ����� ��������� �������� RP
//
// Revision 1.61  2004/04/06 09:43:06  nikitin75
// - ��������� �� IStringOld;
//
// Revision 1.60  2004/04/05 13:54:13  nikitin75
// - ��������� �� IStringOld;
//
// Revision 1.59  2004/03/22 14:25:12  demon
// - _move: FindQueryTagNode ���������� � nsQueryUtils
//
// Revision 1.58  2004/03/22 13:24:53  demon
// - _move: _LQOperationToLSelection to nsSearchClasses
//
// Revision 1.57  2004/03/03 08:50:26  demon
// - new: object and interface nsQueryContainer
//
// Revision 1.56  2004/02/04 13:31:46  demon
// - new behavior: �������� ������ � _IQuery ���������� �� ������ search\nsQuery � ������ nsQueryUtils
//
// Revision 1.55  2004/01/28 12:27:48  law
// - change: ��������� �� ����� � ���������������.
//
// Revision 1.54  2004/01/28 09:37:00  law
// - change: ������� �������� ���������.
//
// Revision 1.53  2004/01/28 08:23:44  law
// - change: ��� ������������� �������������� ��������� ����� ������ � ��� ������� � ���������, ���������� � MenuManager.
//
// Revision 1.52  2004/01/28 07:15:26  law
// - change: ��������� �� ����� � ����������.
//
// Revision 1.51  2004/01/27 15:57:26  law
// - change: ��������� �� _MessageDlg.
//
// Revision 1.50  2004/01/05 15:13:09  demon
// - fix: ��������� ������ ��� ������� �� ���������� ������
//
// Revision 1.49  2003/12/29 12:26:46  mmorozov
// new behaviour: ��-������� �������� �� IDictNode -> TDictRec;
//
// Revision 1.48  2003/12/26 14:16:22  mmorozov
// new: overload functon _LQOperationToLSelection;
//
// Revision 1.47  2003/12/23 08:25:10  demon
// - new behavior: ������� ������� �������� �������� � �������� Search. ������ ���������� IFilters.
// - new behavior: ���������� �������� ������ ���������� ������� (ApplyFilters)
//
// Revision 1.46  2003/12/11 09:32:07  mmorozov
// - ������ ����;
//
// Revision 1.45  2003/12/09 10:13:07  law
// - new method: TnsSearchTypeState.Make.
//
// Revision 1.44  2003/12/09 08:47:30  mmorozov
// - ��������� ElPack �������� �� TvtDateEdit;
//
// Revision 1.43  2003/12/04 13:44:41  demon
//
// Revision 1.42  2003/11/30 17:03:56  law
// - change: _ModuleOperation ��������� �� ���� � ���������������.
//
// Revision 1.41  2003/11/30 11:41:00  law
// - change: ���������� ������������������ ���� ���������������� ��������. �������� nsTypes.
//
// Revision 1.40  2003/11/25 14:00:55  demon
// - fix: �������� �������� ������������ ����� �������
//
// Revision 1.39  2003/11/21 13:02:14  law
// - change: �������� aMode ��������� � ����� � ������ ��������������.
//
// Revision 1.38  2003/11/18 09:31:12  am
// - new: ������ � ����� � ����� GblAdapter. ��������� DEFAULT_PRELOAD_CACHE (GblAdapter.inc)
//   ��������� �� ���������� ���������� �����.
//
// Revision 1.37  2003/11/12 15:16:16  mmorozov
// - ������������� ������ IQueryContextNode -> IQueryStringNode
//
// Revision 1.36  2003/11/04 16:42:20  demon
// - new: ��������� ��������� ��� ����� ������.
//
// Revision 1.35  2003/10/23 13:27:50  demon
// - fix: remove ����� (5.�)
//
// Revision 1.34  2003/10/22 08:24:56  mmorozov
// - �������� warnings �����������;
//
// Revision 1.33  2003/10/17 15:11:59  demon
// - new: �������� _IsQuerySaved - ��������� ������ isSaved ��� ���������� ������� Query
//
// Revision 1.32  2003/10/15 13:45:39  demon
// - add: �������� ������������ ����� �������
//
// Revision 1.31  2003/10/13 14:46:57  demon
// - new: ������ ��� ���������� �������� ������ � �� � �������
//
// Revision 1.30  2003/10/13 13:41:47  demon
// - new behavior: � �������� Search �������� �������������� �������� aList (��� ������ � ������)
//
// Revision 1.29  2003/10/09 11:25:16  demon
// - bug fix: ��� ���������� ������ ��� ����� �������� � ������ ���������� �������� �� ������������ �������.
//
// Revision 1.28  2003/10/09 09:09:21  mmorozov
// - � TQueryFormState.Set_Filter ���� ������ ��� ����������, �� ������� ����������� ���������;
//
// Revision 1.27  2003/10/09 08:37:11  demon
// - new behavior: � ������� TQueryFormState ��������� ���� ��� ���������� �������� �������.
//
// Revision 1.26  2003/10/06 11:20:53  mmorozov
// - ������� ����� ���������;
//
// Revision 1.25  2003/10/06 10:49:40  demon
// - fix: ����� ���������
//
// Revision 1.24  2003/10/06 08:48:57  demon
// - remove some syntax warnings
//
// Revision 1.23  2003/10/03 15:59:08  mmorozov
// - ������������� TElDateTimePicker ������ TDateTimePicker;
//
// Revision 1.22  2003/10/03 15:23:13  demon
// - new behavior: � �������� Search ����� ����� ���������� ��������� ��������.
//
// Revision 1.21  2003/10/03 11:06:35  migel
// - fix: temp fix for last version of dll and units for it
//
// Revision 1.20  2003/10/02 15:09:30  demon
// - new behavior: ������� ������� ��������� ������� � ��� �-�� 5�.
//
// Revision 1.19  2003/09/26 09:16:58  mmorozov
// - bug fix: �� ���������� ������ ����� ���������� ������
//
// Revision 1.18  2003/09/25 14:12:40  demon
// - new behavior: �������� Search �������� ����� �������������� �������� aFilter : INode. ���� ������ ����� �������� � ������ ����� ����� ������.
//
// Revision 1.17  2003/08/29 16:22:19  mmorozov
// + ��������� GetTagName;
// - �������� FindQueryTagNode;
//
// Revision 1.16  2003/08/29 09:07:19  mmorozov
// + ��������� FindQueryOperation;
//
// Revision 1.15  2003/08/29 08:32:41  mmorozov
// - ����������� procedure FindQueryTagNode;
//
// Revision 1.14  2003/08/29 07:56:55  demon
// - add: �������������� ����� ������ TagNode � Query (�������)
//
// Revision 1.13  2003/08/28 18:13:08  mmorozov
// no message
//
// Revision 1.12  2003/08/28 12:19:58  mmorozov
// + ��������� ��������� ��� ������ � ����������;
//
// Revision 1.11  2003/08/27 16:39:48  mmorozov
// - ��������� ������ SaveDate;
//
// Revision 1.10  2003/08/26 16:25:09  mmorozov
// - � CreateQueryTagNode ���� �������� �� ������� IQueryTagNode;
//
// Revision 1.9  2003/08/26 09:38:48  mmorozov
// no message
//
// Revision 1.8  2003/08/25 15:46:04  mmorozov
// + ��������� DateTimeToAdapterDate, SaveContext, SaveDate;
//
// Revision 1.7  2003/08/22 15:52:41  mmorozov
// + ���������: CreateOp, SaveAttribute, FindQueryTagNode, SetDictRec, CreateQueryTagNode, _LQOperationToLSelection, LSelectionToLQOperation;
//
// Revision 1.6  2003/08/21 16:03:23  demon
// - new: �������� ������ �� ���������� ������.
//
// Revision 1.5  2003/08/20 07:54:50  demon
// - new: ������ ��� ���������� ���������� �� � �������
//
// Revision 1.4  2003/08/11 18:14:20  demon
// - fix: ����������� � ����� � ���������� GblAdapter
//
// Revision 1.3  2003/08/04 17:33:44  demon
// - new behavior: �������� Search ��� ������� nil ������� ��� ��������� ����.
//
// Revision 1.2  2003/08/04 15:55:43  demon
// - add: ��������� ���������������� ��������� � ���, ��� ����� ����������� �� ���.
//
// Revision 1.1  2003/07/30 09:31:52  demon
// - new: ������ � ������ ���������� ��� ������ � �������� �� ��
//

interface

{$ifndef admin}

// <no_string>

uses
  ComCtrls,

  l3Interfaces,
  l3Base,
  l3String,
  l3CacheableBase,

  afwInterfaces,

  ElXPThemedControl,

  vtDateEdit,

  vcmBase,
  vcmExternalInterfaces,
  vcmInterfaces,

  BaseTreeSupportUnit,
  BaseTypesUnit,
  DynamicTreeUnit,
  SearchUnit,
  FiltersUnit,

  nsTypes,
  nsConst,

  nsQueryInterfaces,

  SearchDomainInterfaces,
  PrimPrimListInterfaces
  ;

type
  TProcCheckContextSimbol = Tl3CheckSimbolProc;

  _afwApplicationDataUpdate_Parent_ = Tl3CacheableBase;
  {$Include afwApplicationDataUpdate.imp.pas}
  TnsQueryContainer = class(_afwApplicationDataUpdate_,
                            IvcmBase,
                            InsQueryContainer)
  private
    f_Query: IQuery;
  private
  // property methods
    function  Get_Query : IQuery;
    procedure Set_Query(const aValue : IQuery);
      {-}
  protected
    procedure FinishDataUpdate;
      override;
      {* �������� �� ��������� ���������� }
   protected
   // methods
     procedure Cleanup;
       override;
       {-}
  end;//TnsQueryContainer

  TnsQueryFormState = class(TnsQueryContainer, InsQueryFormState)
  {*}
  private
  // fields
    f_Tag    : Il3CString;
    f_Filter : IFilterFromQuery;
  private
  // methods
    function  Get_Tag : Il3CString;
    procedure Set_Tag(const aValue : Il3CString);
      {-}
    function  Get_Filter : IFilterFromQuery;
    procedure Set_Filter(const aValue : IFilterFromQuery);
      {-}
  protected
    procedure FinishDataUpdate;
      override;
      {* �������� �� ��������� ���������� }
  protected
  // methods
    procedure Cleanup;
      override;
      {-}
  public
  // methods
    class function Make: InsQueryFormState;
      {-}
  end;//TnsQueryFormState

  TnsSearchType = (stNone, {stAllBaseOnly,} stAllBase, stInList);

  {$IfNDef Admin}
  InsSearchTypeState = interface(IvcmBase)
   ['{856C5A2C-CF03-4FB5-8445-2887E12005D3}']
    function  pm_getList : IdeList;
    procedure pm_setList(const aValue : IdeList);
    function  pm_getSearchType : TnsSearchType;
    procedure pm_setSearchType(aValue : TnsSearchType);

    property List : IdeList
      read pm_getList
      write pm_setList;
      {-}
    property SearchType : TnsSearchType
      read pm_getSearchType
      write pm_setSearchType;
      {-}
  end;//InsSearchTypeState

  TnsSearchTypeState = class(Tl3CacheableBase, IvcmBase, InsSearchTypeState)
   private
    f_List        : IdeList;
    f_SearchType  : TnsSearchType;

    function  pm_getList : IdeList;
    procedure pm_setList(const aValue : IdeList);
    function  pm_getSearchType : TnsSearchType;
    procedure pm_setSearchType(aValue : TnsSearchType);
   protected
    procedure Cleanup; override;
   public
    class function Make: InsSearchTypeState;
      {-}
  end;//TnsSearchTypeState
  {$EndIf}

function ClientToAdapter(const aLogicOperation : TLogicOperation) : TQueryLogicOperation;
  {* - TLogicOperation -> TQueryLogicOperation. }
function GblAdapterDateToDateTime(aDate : BaseTypesUnit.TDate) : System.TDateTime;
  {* - ����������� ���������� ����. }
function DateTimeToGblAdapterDate(aDate: System.TDateTime): BaseTypesUnit.TDate;
 {* - DateTimeToAdapterDate - ����������� TDateTime � BaseTypesUnit.TDate }
function CheckContext6x(const aContext : Il3CString;
                        var aError     : Il3CString): Integer;
  { CheckContext - ���������� ������������ ��������� ������������� ���������.
     Result: l3NotFound - �������� ����������, ����� aContext[Result] - �����������
      ��������� ������;
     aContext - ������������� ��������;
     aError - ����� ������; }
function CheckContext(const aContext : Il3CString;
                      var aError     : Il3CString;
                      aCheckSimbol   : TProcCheckContextSimbol) : Integer;
  { CheckContextSimbol6x - ���������� �������� �� ������ ���������� ���
    ��� 6� }
function CheckContextSimbol6x(aSimbol : AnsiChar) : Boolean;
  {-}
procedure CreateQuery(var aQuery : IQuery;
                      aType      : TQueryType);
  {* - ������ ������ ���������� ����, ���� IQuery �����, �� ��������������
       ����������� ���. }
procedure SaveAttributeNew(const aQuery   : IQuery;
                           const aTagName : Il3CString;
                           const aLO      : TLogicOperation;
                           const aValue   : INodeBase);
  {* - ��������� �������� ���� INodeBase. }
procedure SaveContextNew(const aQuery   : IQuery;
                         const aTagName : Il3CString;
                         const aValue   : Il3CString;
                         const ClearBeforeSave: Boolean = False); overload;
  {* - ��������� ����������� ��������. }

procedure SaveContextNew(const aQuery   : IQuery;
                         const aTagName : Il3CString;
                         const aValues  : Il3StringsEx;
                         const ClearBeforeSave: Boolean = False); overload;
  {* - ��������� ����������� ��������. }

procedure SaveDateNewEx(const aQuery   : IQuery;
                        const aTagName : Il3CString;
                        const aStart   : System.TDateTime;
                        const aEnd     : System.TDateTime);
  {* - ��������� � Query ������� �������� ���. }
procedure SavePhone(const aQuery   : IQuery;
                    const aTagName : Il3CString;
                    const aCode, aNumber : Il3CString);
  {* - ��������� � Query ������� ����� �������� }
function GetDefaultContext(const aTagName : Il3CString): Il3CString;
  {* - ���������� ��������� �������� ��� �������� }
function RepairContext6x(const aContext: Il3CString): Il3CString;
  {* - ������ �������� ���������� ������ ��� ��������� ������� }

{$endif}

implementation

{$ifndef admin}

uses
  Windows,

  SysUtils,

  Controls,
  Forms,
  Dialogs,

  l3Const,
  l3Chars,
  l3InterfacesMisc,
  l3Date,

  afwFacade,

  vcmForm,

  DataAdapter,
  StdRes,

  {$IfNDef Admin}
  nsSearchClasses,
  {$EndIf  Admin}
  nsNodes
  ;

{$Include afwApplicationDataUpdate.imp.pas}

const
// cAlphaNumSymbolsOnly = ['.', '/', '_']; // ������� ���������� ������ ����� ���� � ����
 cAtEndOfWordSymbols = ['*','!']; //������� ���������� ������ � ����� �����

procedure SaveDateNewEx(const aQuery   : IQuery;
                        const aTagName : Il3CString;
                        const aStart   : System.TDateTime;
                        const aEnd     : System.TDateTime);
  {* - ��������� � Query ������� �������� ���. }
var
 l_Node      : IQueryDateAttribute;
 l_StartDate : BaseTypesUnit.TDate;
 l_EndDate   : BaseTypesUnit.TDate;
begin
 l3FillChar(l_StartDate, SizeOf(l_StartDate), 0);
 l3FillChar(l_EndDate, SizeOf(l_EndDate), 0);
 aQuery.GetDateAttribute(nsAStr(aTagName).S, l_Node);
 try
  { ���� ������ }
  if (aStart <> NullDate) then
   l_StartDate := DateTimeToGblAdapterDate(aStart);
  { ���� ��������� }
  if (aEnd <> NullDate) then
   l_EndDate := DateTimeToGblAdapterDate(aEnd);
  { ��������� �������� }
  l_Node.AddValue(QLO_OR, l_StartDate, l_EndDate);
 finally
  l_Node := nil;
 end;//try..finally
end;

procedure SavePhone(const aQuery   : IQuery;
                    const aTagName : Il3CString;
                    const aCode, aNumber : Il3CString);
  {* - ��������� � Query ������� ����� �������� }
var
 l_Node: IQueryPhoneNumberAttribute;
begin
 aQuery.GetPhoneNumberAttribute(nsAStr(aTagName).S, l_Node);
 l_Node.SetCityCode(nsIStr(aCode));
 l_Node.SetPhoneNumber(nsIStr(aNumber));
end;

function GetDefaultContext(const aTagName : Il3CString): Il3CString;
  {* - ���������� ��������� �������� ��� �������� }
var
 l_AttrInfo: IAttributeInfo;
 l_Attr: IQueryAttribute;
 l_Context: IQueryContextAttribute;
 l_List: IContextValueList;
 l_Value: TContextValue;
begin
 Result := nil;
 try
  DefDataAdapter.Search.GetAttributeInfo(nsAStr(aTagName).S, l_AttrInfo);
  l_AttrInfo.GetDefaultValue(l_Attr);
  if Supports(l_Attr, IQueryContextAttribute, l_Context) then
  begin
   l_Context.GetValues(l_List);
   if (l_List.Count > 0) then
   begin
    l_List.pm_GetItem(0, l_Value);
    Result := nsCStr(l_Value.rContext);
   end;
  end;
 except
  on ECannotFindData do ;
  on ENoDefaultValue do ;
 end;
end;

procedure SaveAttributeNew(const aQuery   : IQuery;
                           const aTagName : Il3CString;
                           const aLO      : TLogicOperation;
                           const aValue   : INodeBase);
  {* - ��������� �������� ���� INodeBase. }
var
 lNode : IQueryNodeAttribute;
begin
 aQuery.GetNodeAttribute(nsAStr(aTagName).S, lNode);
 try
  lNode.AddValue(ClientToAdapter(aLO), aValue);
 finally
  lNode := nil;
 end;//try..finally
end;

procedure SaveContextNew(const aQuery   : IQuery;
                         const aTagName : Il3CString;
                         const aValue   : Il3CString;
                         const ClearBeforeSave: Boolean = False);
  {* - ��������� ����������� ��������. }
var
 l_Node : IQueryContextAttribute;
begin
 if Assigned(aQuery) then
 begin
  aQuery.GetContextAttribute(nsAStr(aTagName).S, l_Node);
  try
   if ClearBeforeSave then
    l_Node.Clear;
   l_Node.AddValue(QLO_AND, nsIStr(aValue));
  finally
   l_Node := nil;
  end;{try..finally}
 end;//if Assigned(aQuery) then
end;//SaveContextNew

procedure SaveContextNew(const aQuery   : IQuery;
                         const aTagName : Il3CString;
                         const aValues  : Il3StringsEx;
                         const ClearBeforeSave: Boolean = False); overload;
  {* - ��������� ����������� ��������. }
var
 l_Node : IQueryContextAttribute;
 l_Index: Integer;
begin
 if Assigned(aQuery) then
 begin
  aQuery.GetContextAttribute(nsAStr(aTagName).S, l_Node);
  try
   if ClearBeforeSave then
    l_Node.Clear;
   for l_Index := 0 to Pred(aValues.Count) do
    l_Node.AddValue(QLO_AND, nsIStr(aValues.ItemC[l_Index]));
  finally
   l_Node := nil;
  end;{try..finally}
 end;//if Assigned(aQuery) then
end;//SaveContextNew

function ClientToAdapter(const aLogicOperation : TLogicOperation) : TQueryLogicOperation;
  {* - �����������. }
begin
 Result := QLO_OR;
 case aLogicOperation of
  loAnd:
   Result := QLO_AND;
  loNot:
   Result := QLO_AND_NOT;
 end;
end;

procedure CreateQuery(var aQuery : IQuery;
                      aType      : TQueryType);
  {* - ������ ������ ���������� ����, ���� IQuery �����, �� ��������������
       ����������� ���. }
begin
 if Assigned(aQuery) then
  aQuery := nil;
 aQuery := DefDataAdapter.NativeAdapter.MakeQuery(aType);
end;

function CheckContextSimbol6x(aSimbol: AnsiChar): Boolean;
begin
 Result := True;
{ Result := aSimbol in ['a'..'z', 'A'..'Z', '�'..'�', '�'..'�',
  '0'..'9', '!', ';', ' ', '/', '-', '.', '"', '*', '�', '�', '�', '_', '@'];}
end;

function CheckContext6x(const aContext: Il3CString; var aError: Il3CString): Integer;
begin
 Result := CheckContext(aContext, aError, CheckContextSimbol6x);
end;

function CheckContext(const aContext : Il3CString;
                      var aError     : Il3CString;
                      aCheckSimbol   : TProcCheckContextSimbol): Integer;

 // http://mdp.garant.ru/pages/viewpage.action?pageId=461713135
 function lp_IsEndOfWord(aIndex: Integer): Boolean;

  function lp_IsFirstChar: Boolean;
  begin
   Result := (aIndex = 0);
  end;

  function lp_IsLastChar: Boolean;
  begin
   Result := (aIndex = (l3Len(aContext) - 1));
  end;

 begin
  // http://mdp.garant.ru/pages/viewpage.action?pageId=475475311
  Result := (lp_IsLastChar and ((not lp_IsFirstChar)
              and l3IsChar(aContext, aIndex - 1, cc_AlphaNum)
             and (not l3IsChar(aContext, aIndex - 1, cc_HardSpace))) OR
            (not lp_IsLastChar and ((not lp_IsFirstChar)
              and l3IsChar(aContext, aIndex + 1, cc_HardSpace)
             and (l3IsChar(aContext, aIndex - 1, cc_AlphaNum)))));
 end;

var
 l_Index : Integer;
 l_Error : Boolean;
const
 cFuckMagic = '&';
 cFuckMagic1 = '&&';
begin
 Result := l3NotFound;
 aError := nil;
 if not l3IsNil(l3Trim(aContext)) then
 begin
  l_Index := 0;
  while (Result = l3NotFound) and (l_Index < l3Len(aContext)) do
  begin
   { �������� ��� �������� }
   if not l3IsChar(aContext, l_Index, aCheckSimbol) then
   begin
    Result := l_Index;
    if l3IsChar(aContext, l_Index, cFuckMagic) then
     aError := vcmFmt(str_InvalidContextSymbol, [cFuckMagic1])
    else
     aError := vcmFmt(str_InvalidContextSymbol, [l3Char(aContext, l_Index)]);
   end//not l3IsChar(aContext, l_Index, aCheckSimbol)
   { �������� ������� ������� ����� ������������� ������ ����� ������� }
   else
   // ����� ������������. �.�. �� ��26086 ��������� ����� ������.
(*   if l3IsChar(aContext, l_Index, cAlphaNumSymbolsOnly) then
   begin
    l_Error := False;

    { ������ �������� ������ ��� ��������� }
    if (l_Index = 0) or (l_Index = l3Len(aContext) - 1) then
     l_Error := True;

    if not l_Error then
     if not l3IsChar(aContext, l_Index - 1, cc_AlphaNum) or
      not l3IsChar(aContext, l_Index + 1, cc_AlphaNum) then
       l_Error := True;

    if l_Error then
    begin
     Result := l_Index;
     if l3IsChar(aContext, l_Index, cFuckMagic) then
      aError := vcmFmt(str_ContextSymbolMustBeBetweenAlphanum, [cFuckMagic1])
     else
      aError := vcmFmt(str_ContextSymbolMustBeBetweenAlphanum, [l3Char(aContext, l_Index)]);
    end;//l_Error

   end//l3Char(aContext, l_Index) in cAlphaNumSymbolsOnly
   else*)
   if (l3IsChar(aContext, l_Index, cAtEndOfWordSymbols)) then
   begin
    if (l_Index = 0) or
       ((not l3IsChar(aContext, l_Index - 1, cc_AlphaNum)) and
        // http://mdp.garant.ru/pages/viewpage.action?pageId=461713135
        (not lp_IsEndOfWord(l_Index))) or
       ((l_Index < l3Len(aContext)) and
        l3IsChar(aContext, l_Index + 1, cc_AlphaNum)) then
    begin
     Result := l_Index;
     if l3IsChar(aContext, l_Index, cFuckMagic) then
      aError := vcmFmt(str_ContextSymbolMustBeAtEndOfWord, [cFuckMagic1])
     else
      aError := vcmFmt(str_ContextSymbolMustBeAtEndOfWord, [l3Char(aContext, l_Index)]);
    end;
   end;//l3IsChar(aContext, l_Index, cAtEndOfWordSymbols) 

   Inc(l_Index);
  end;
 end;//not l3IsNil(l3Trim(aContext))
end;

function GblAdapterDateToDateTime(aDate: BaseTypesUnit.TDate): System.TDateTime;
begin
  Result := EncodeDate(aDate.rYear, aDate.rMonth, aDate.rDay);
end;

function DateTimeToGblAdapterDate(aDate: System.TDateTime): BaseTypesUnit.TDate;
var
  l_Year, l_Month, l_Day: Word;
begin
  DecodeDate(aDate, l_Year, l_Month, l_Day);
  Result.rDay := l_Day;
  Result.rMonth := l_Month;
  Result.rYear := l_Year;
end;

function RepairContext6x(const aContext: Il3CString): Il3CString;
  {* - ������ �������� ���������� ������ ��� ��������� ������� }
const
 c_StripChars = ['*','!','&',';'];
var
 l_Idx        : Integer;
 l_ErrMessage : Il3CString;
begin
 Result := aContext;
 l3Replace(Result, c_StripChars, cc_HardSpace);
 l3Replace(Result, cc_PairDoubleQuotes, cc_DoubleQuote);
 l3Replace(Result, cc_PairSingleQuotes, cc_SingleQuote);
 repeat
  l_Idx := CheckContext6x(Result, l_ErrMessage);
  if (l_Idx >= 0) then
   l3SetChar(Result, l_Idx, cc_HardSpace);
 until (l_Idx < 0);
 Result := l3Trim(Result);
 Result := l3DeleteDoubleSpace(Result);
end;

// Start class TnsQueryContainer

procedure TnsQueryContainer.Cleanup;
begin
 f_Query := nil;

 inherited;
end;

procedure TnsQueryContainer.FinishDataUpdate;
begin
 inherited;
 f_Query := nil;
end;

function TnsQueryContainer.Get_Query : IQuery;
begin
 Result := f_Query;
end;

procedure TnsQueryContainer.Set_Query(const aValue : IQuery);
begin
 f_Query := aValue;
end;

// Start class TnsQueryFormState

procedure TnsQueryFormState.Cleanup;
begin
 f_Tag := nil;
 f_Filter := nil;
 inherited;
end;

procedure TnsQueryFormState.FinishDataUpdate;
begin
 f_Filter := nil;
 inherited;
end;//FinishDataUpdate

function TnsQueryFormState.Get_Tag : Il3CString;
begin
 Result := f_Tag;
end;

procedure TnsQueryFormState.Set_Tag(const aValue : Il3CString);
begin
 f_Tag := aValue;
end;

function TnsQueryFormState.Get_Filter : IFilterFromQuery;
begin
 Result := f_Filter;
end;

procedure TnsQueryFormState.Set_Filter(const aValue : IFilterFromQuery);
begin
 if f_Filter <> nil then
  f_Filter := nil;
 f_Filter := aValue;
end;

// Start class TnsSearchTypeState

{$IfNDef Admin}
class function TnsSearchTypeState.Make: InsSearchTypeState;
    {-}
var
 l_State : TnsSearchTypeState;    
begin
 l_State := Create;
 try
  Result := l_State; 
 finally
  vcmFree(l_State);
 end;//try..finally
end;
    
procedure TnsSearchTypeState.Cleanup;
begin
 f_SearchType := stNone;
 f_List := nil;
 inherited;
end;

function TnsSearchTypeState.pm_getList : IdeList;
begin
 Result := f_List;
end;

procedure TnsSearchTypeState.pm_setList(const aValue : IdeList);
begin
 f_List := aValue;
end;

function TnsSearchTypeState.pm_getSearchType : TnsSearchType;
begin
 Result := f_SearchType;
end;

procedure TnsSearchTypeState.pm_setSearchType(aValue : TnsSearchType);
begin
 f_SearchType := aValue;
end;
{$EndIf}

class function TnsQueryFormState.Make: InsQueryFormState;
var
 l_Class: TnsQueryFormState;
begin
 l_Class := Create;
 try
  Result := l_Class;
 finally
  FreeAndNil(l_Class);
 end;{try..finally}
end;//Make

{$endif}

end.
