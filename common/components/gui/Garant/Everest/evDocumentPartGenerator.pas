unit evDocumentPartGenerator;
{* ���������� ���������� ��� ������� ������ � �� ����� ���� ��������� ������. }

{ ���������� "�������"    }
{ �����: ����� �.�. �     }
{ ������: evCurGen -      }
{ �����: 09.02.1999 17:29 }
{ $Id: evDocumentPartGenerator.pas,v 1.83 2015/06/26 14:12:23 dinishev Exp $ }

// $Log: evDocumentPartGenerator.pas,v $
// Revision 1.83  2015/06/26 14:12:23  dinishev
// {Requestlink:278848257}
//
// Revision 1.82  2015/02/06 10:27:05  dinishev
// {Requestlink:588030721}
//
// Revision 1.81  2015/01/19 18:36:35  lulin
// {RequestLink:580710025}
//
// Revision 1.80  2014/11/19 10:55:19  dinishev
// {Requestlink:571646504}. ����� ���� ������� �������� ���� f_InsPara. :-(
//
// Revision 1.79  2014/10/24 11:04:45  dinishev
// {Requestlink:569235991}
//
// Revision 1.78  2014/10/20 08:57:13  dinishev
// {Requestlink:568162266}
//
// Revision 1.77  2014/10/03 09:49:00  dinishev
// {Requestlink:563191485}
//
// Revision 1.76  2014/04/30 11:23:52  lulin
// - ���������� �����������.
//
// Revision 1.75  2014/04/29 12:03:45  lulin
// - �������� �������� �����.
//
// Revision 1.74  2014/04/11 15:30:29  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.73  2014/04/09 14:19:24  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.72  2014/04/09 13:12:03  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.71  2014/04/08 17:13:19  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.70  2014/04/08 14:16:55  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.69  2014/04/08 12:35:09  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.68  2014/04/07 17:56:59  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.67  2014/04/04 17:53:34  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.66  2014/04/03 17:10:25  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.65  2014/03/28 12:15:22  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.64  2014/03/27 14:19:58  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.63  2014/03/25 11:53:27  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.62  2014/03/21 12:39:22  lulin
// - ������������� ������ � ������.
//
// Revision 1.61  2014/03/20 12:23:55  lulin
// - ������������� ������ � ������.
//
// Revision 1.60  2014/03/18 17:12:57  lulin
// - ������������� ������ � ������.
//
// Revision 1.59  2014/03/18 15:56:59  lulin
// - ������������� ������ � ������.
//
// Revision 1.58  2014/03/04 13:08:19  lulin
// - ��������� �������������� Sub'�� � ��������� �� ���������� Enum'�.
//
// Revision 1.57  2014/02/28 14:54:15  lulin
// - ������������� ����������.
//
// Revision 1.56  2014/02/18 17:15:07  lulin
// [$517488281]
//
// Revision 1.55  2013/12/25 15:35:18  lulin
// {RequestLink:509706011}
// - ����������� ������.
//
// Revision 1.54  2013/11/06 12:41:04  lulin
// - ��������� ���� ������ ���� �� ����� ����������� �������������� ��� ���������� � �����.
//
// Revision 1.53  2013/10/21 15:42:58  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.52  2013/10/21 10:30:41  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.51  2013/05/14 13:38:22  lulin
// {RequestLink:453166247}.
//
// Revision 1.50  2013/05/14 13:36:30  lulin
// {RequestLink:453166247}.
//
// Revision 1.49  2012/08/23 09:56:36  dinishev
// {Requestlink:382408222}
//
// Revision 1.48  2012/08/22 12:45:13  dinishev
// {Requestlink:382408222}
//
// Revision 1.47  2012/04/20 14:56:33  lulin
// {RequestLink:283610570}
//
// Revision 1.46  2012/03/22 13:18:22  dinishev
// {Requestlink:349116289}
//
// Revision 1.45  2012/03/02 12:27:27  dinishev
// {Requestlink:340175024}
//
// Revision 1.44  2012/02/22 13:32:37  dinishev
// {Requestlink:340165072}
//
// Revision 1.43  2011/10/14 17:18:19  lulin
// {RequestLink:292913355}.
//
// Revision 1.42  2011/10/14 17:17:53  lulin
// {RequestLink:292913355}.
//
// Revision 1.41  2011/05/19 12:17:32  lulin
// {RequestLink:266409354}.
//
// Revision 1.40  2011/03/30 18:11:21  lulin
// {RequestLink:255980970}.
//
// Revision 1.39  2010/11/22 12:00:03  lulin
// {RequestLink:242843924}.
// - ����� ����������.
//
// Revision 1.38  2010/09/13 11:02:13  dinishev
// [$234363360]
//
// Revision 1.37  2010/07/29 13:48:08  lulin
// {RequestLink:229213001}.
//
// Revision 1.36  2010/02/02 07:42:49  dinishev
// [$179077291]
//
// Revision 1.35  2009/12/21 09:52:49  dinishev
// [$170755419]
//
// Revision 1.34  2009/12/16 11:08:38  lulin
// {RequestLink:174293230}.
//
// Revision 1.33  2009/08/19 10:46:03  lulin
// - �������������� �������������� ��� ����������� �������.
//
// Revision 1.32  2009/07/23 13:42:10  lulin
// - ��������� ��������� �������� ���� ���� ����.
//
// Revision 1.31  2009/07/23 08:14:38  lulin
// - �������� �������� ������������� ���������� ��������.
//
// Revision 1.30  2009/07/14 14:56:26  lulin
// {RequestLink:141264340}. �25.
//
// Revision 1.29  2009/07/13 12:31:36  lulin
// {RequestLink:141264340}. �23ac.
//
// Revision 1.28  2009/07/11 17:11:05  lulin
// {RequestLink:141264340}. �19.
//
// Revision 1.27  2009/07/11 15:55:09  lulin
// {RequestLink:141264340}. �22.
//
// Revision 1.26  2009/07/11 09:24:41  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.25  2009/07/10 16:15:41  lulin
// - ����������� �� ������� ������� ��������� ������.
//
// Revision 1.24  2009/07/06 13:32:06  lulin
// - ������������ �� ����������� � ��������.
//
// Revision 1.23  2009/06/25 12:57:30  lulin
// - �������� �������� ��������.
//
// Revision 1.22  2009/06/02 16:12:53  lulin
// - �������� ���������� ���������� � ��������� ������.
//
// Revision 1.21  2009/04/14 18:11:54  lulin
// [$143396720]. ���������������� ������.
//
// Revision 1.20  2009/04/09 14:12:36  lulin
// [$140837386]. �15.
//
// Revision 1.19  2009/04/07 16:09:41  lulin
// [$140837386]. �13.
//
// Revision 1.18  2009/03/05 16:20:38  lulin
// - <K>: 137470629. ������ �������� ������ �� ��� �� ��������������.
//
// Revision 1.17  2009/03/04 13:32:46  lulin
// - <K>: 137470629. ���������� �������������� ����� � ������ � ������� �� �� ����� �������.
//
// Revision 1.16  2008/12/12 19:19:14  lulin
// - <K>: 129762414.
//
// Revision 1.15  2008/10/09 13:37:33  lulin
// - <K>: 121145547.
//
// Revision 1.14  2008/07/02 15:04:35  lulin
// - ������ ����.
//
// Revision 1.13  2008/06/09 12:16:49  lulin
// - bug fix: �� ��������� �������.
//
// Revision 1.12  2008/04/23 11:04:55  lulin
// - ������� "�������".
//
// Revision 1.11  2008/04/23 10:38:40  lulin
// - ��������� ���������� "�������".
//
// Revision 1.10  2008/04/16 07:34:53  lulin
// - cleanup.
//
// Revision 1.9  2008/04/15 08:23:45  lulin
// - ������� ��� � �������� ���������.
//
// Revision 1.8  2008/04/14 13:46:35  lulin
// - <K>: 89096854.
//
// Revision 1.7  2008/04/14 08:47:22  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.124  2008/04/09 17:57:07  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.123  2008/04/09 11:20:21  lulin
// - ������� ��� � ������ <K>: 89096854.
//
// Revision 1.122  2008/03/03 20:05:45  lulin
// - <K>: 85721135.
//
// Revision 1.121  2008/02/21 10:55:02  lulin
// - �������� ������������.
//
// Revision 1.120  2008/02/08 19:58:22  lulin
// - <TDN>: 55.
//
// Revision 1.119  2008/02/05 09:57:37  lulin
// - �������� ������� ������� � ��������� ����� � ��������� �� �� ������.
//
// Revision 1.118  2007/12/25 12:55:52  lulin
// - ������ �������� ������.
//
// Revision 1.117  2007/12/05 12:35:06  lulin
// - ������� �������� ���, ������������ ������� ����� � Head'�.
//
// Revision 1.116  2007/12/04 12:47:00  lulin
// - ������������� ����� � HEAD.
//
// Revision 1.112.4.48  2007/09/14 13:26:04  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.112.4.47.2.2  2007/09/12 17:51:48  lulin
// - cleanup.
//
// Revision 1.112.4.47.2.1  2007/09/12 15:23:00  lulin
// - ����������� �� ������, ������������ ���������������� ��������� ��������.
//
// Revision 1.112.4.47  2007/09/11 18:49:58  lulin
// - ������ �������� ��������.
//
// Revision 1.112.4.46  2007/09/04 17:06:00  lulin
// - cleanup.
//
// Revision 1.112.4.45  2007/06/25 13:29:06  lulin
// - cleanup.
//
// Revision 1.112.4.44  2007/06/22 19:24:51  lulin
// - cleanup.
//
// Revision 1.112.4.43  2007/06/22 19:18:56  lulin
// - cleanup.
//
// Revision 1.112.4.42  2007/06/20 09:25:21  dinishev
// bug fix: ������ ����������� ��� ���������
//
// Revision 1.112.4.41  2007/02/13 17:32:55  lulin
// - ����������� �� ������������� ����������� ������� ������ ��������� � ������.
//
// Revision 1.112.4.40  2007/01/05 14:37:18  lulin
// - cleanup.
//
// Revision 1.112.4.39  2006/11/21 09:55:23  lulin
// - cleanup.
//
// Revision 1.112.4.38  2006/11/10 17:15:54  lulin
// - ��������� � ������.
//
// Revision 1.112.4.37  2006/11/03 11:00:03  lulin
// - ��������� � ������ 6.4.
//
// Revision 1.112.4.36.2.2  2006/10/26 12:23:46  lulin
// - cleanup.
//
// Revision 1.112.4.36.2.1  2006/10/25 09:44:58  lulin
// - �������� ������������ ������� �� ������� �����.
//
// Revision 1.112.4.36  2006/10/10 12:06:12  lulin
// - cleanup.
//
// Revision 1.112.4.35  2006/10/10 07:45:24  oman
// - fix: ��� ������� �� ��������� � �� ������ �������� �������
//  (cq22805, 22828)
//
// Revision 1.112.4.34  2006/09/21 11:37:38  oman
// - fix: ���� ���� � �� ����� ������������� (cq22635)
//
// Revision 1.112.4.33  2006/06/09 12:41:55  lulin
// - cleanup.
//
// Revision 1.112.4.32  2006/05/24 07:06:44  lulin
// - cleanup.
//
// Revision 1.112.4.31  2006/03/29 13:03:07  dinishev
// Bug fix: �������� ������� �� ������ � ���� ���
//
// Revision 1.112.4.30  2006/03/24 14:57:29  dinishev
// ������� ���������� ����� �� ������ � ������������� ����.
//
// Revision 1.112.4.29  2005/12/14 13:15:40  lulin
// - bug fix: ���������� ��������� ������� �� ������ ������.
//
// Revision 1.112.4.28  2005/12/13 15:16:10  lulin
// - bug fix: "������" Undo.
//
// Revision 1.112.4.27  2005/12/02 18:23:27  lulin
// - �������� ������������ �� ��������/���������� ��������� ����������� ��������� ���������� �� ���������.
//
// Revision 1.112.4.26  2005/11/21 10:11:26  lulin
// - ������ �������� ���������� �����.
//
// Revision 1.112.4.25  2005/11/09 15:28:23  lulin
// - ������� ���������� ���������� � ���������� ������.
//
// Revision 1.112.4.24  2005/11/07 10:04:15  lulin
// - ����� ������������ �������� � ������������.
//
// Revision 1.112.4.23  2005/11/07 06:25:21  lulin
// - �������� � ����� � � ������� ����� ����������������.
//
// Revision 1.112.4.22  2005/11/05 09:03:13  lulin
// - �������� � ����� � � ������� ����� ����������������.
//
// Revision 1.112.4.21  2005/10/18 11:26:06  lulin
// - ���������� Undo-������ ��������/���������� ����� ����������, ���������� � ���������� �����.
//
// Revision 1.112.4.20  2005/10/18 07:19:39  lulin
// - new behavior: ������ ������ ������� � ���������� �������� ����� ����� ��������� ����������� ����.
//
// Revision 1.112.4.19  2005/10/12 14:13:22  dinishev
// �������� Inner �� nil
//
// Revision 1.112.4.18  2005/08/31 12:04:34  lulin
// - ������ �������� ������.
//
// Revision 1.112.4.17  2005/08/29 13:54:00  lulin
// - bug fix: ��� ��������� ��� ����������.
//
// Revision 1.112.4.16  2005/08/29 13:40:27  lulin
// - new behavior: ��������� ��������� � ������ � ���������� ���-������ �������� �� ���������.
//
// Revision 1.112.4.15  2005/07/20 18:21:13  lulin
// - ����� ���������� ���������.
//
// Revision 1.112.4.14  2005/07/18 15:10:26  lulin
// - ����������� �� ���������� ���������� ������ ���������� � �������.
//
// Revision 1.112.4.13  2005/07/07 13:09:27  lulin
// - ����������� �������� �����������.
//
// Revision 1.112.4.12  2005/06/22 17:53:03  lulin
// - ���� ������������� � ������������ � ��������� ����������.
//
// Revision 1.112.4.11  2005/06/22 17:34:08  lulin
// - ��������� ��������� � ������ ��������� � "����������" ����������.
//
// Revision 1.112.4.10  2005/06/22 17:05:17  lulin
// - new unit: evHighLevelDocumentGenerator.
//
// Revision 1.112.4.9  2005/06/15 17:23:51  lulin
// - remove proc: _evMoveCursor.
//
// Revision 1.112.4.8  2005/06/07 13:43:46  lulin
// - ������ �������� ������.
//
// Revision 1.112.4.7  2005/06/06 15:36:08  lulin
// - ���������� �������� �� ������� � ������� ���������� ��������.
//
// Revision 1.112.4.6  2005/06/01 16:22:24  lulin
// - remove unit: evIntf.
//
// Revision 1.112.4.5  2005/06/01 14:02:17  lulin
// - new unit: evCursor.
//
// Revision 1.112.4.4  2005/05/31 14:48:01  lulin
// - cleanup: ��� ������ � ��������� ���������� ����������, � �� �������.
//
// Revision 1.112.4.3  2005/05/31 12:06:29  lulin
// - cleanup: ��� ������ � ��������� ���������� ����������, � �� �������.
//
// Revision 1.112.4.2  2005/05/19 11:31:54  lulin
// - cleanup.
//
// Revision 1.112.4.1  2005/05/18 12:42:46  lulin
// - ����� ����� �����.
//
// Revision 1.106.2.4  2005/05/18 12:32:08  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.106.2.3  2005/04/28 09:18:28  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.106.2.2  2005/04/19 11:56:41  lulin
// - ������� ��� ������������.
//
// Revision 1.106.2.1  2005/04/11 13:42:25  lulin
// - bug fix: �� ��������� ������� �����, �.�. ����������� ��������� ��������� ��������.
//
// Revision 1.110.2.4  2005/04/25 15:39:27  lulin
// - �� ���� ��������, ���� ��� ��� �� �����.
//
// Revision 1.110.2.3  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.110.2.2  2005/04/21 15:36:39  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.110.2.1  2005/04/21 14:46:54  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.110  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.109  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.108  2005/04/19 08:27:45  lulin
// - �������� ������, ������� ������ �������� ��������.
//
// Revision 1.107  2005/04/11 13:44:05  lulin
// - ���� � ������.
//
// Revision 1.106.2.1  2005/04/11 13:42:25  lulin
// - bug fix: �� ��������� ������� �����, �.�. ����������� ��������� ��������� ��������.
//
// Revision 1.112  2005/04/28 15:03:37  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.111  2005/04/26 09:55:49  lulin
// - ������� ��������� �� ����� - �.�. �� �������������� ����������.
//
// Revision 1.110.2.4  2005/04/25 15:39:27  lulin
// - �� ���� ��������, ���� ��� ��� �� �����.
//
// Revision 1.110.2.3  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.110.2.2  2005/04/21 15:36:39  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.110.2.1  2005/04/21 14:46:54  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.110  2005/04/21 05:11:38  lulin
// - ���������� _Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.109  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.108  2005/04/19 08:27:45  lulin
// - �������� ������, ������� ������ �������� ��������.
//
// Revision 1.107  2005/04/11 13:44:05  lulin
// - ���� � ������.
//
// Revision 1.106.2.1  2005/04/11 13:42:25  lulin
// - bug fix: �� ��������� ������� �����, �.�. ����������� ��������� ��������� ��������.
//
// Revision 1.106  2005/04/07 16:05:04  lulin
// - new method: Ik2TagBoxQT._MakeInterface.
//
// Revision 1.105  2005/04/05 10:27:51  lulin
// - bug fix: ��� ����� ������ ��� ������� �� ��������� ������ �����������.
//
// Revision 1.104  2005/04/01 16:18:39  lulin
// - new behavior: ������ ��������� ���� �������� ��������� � ���, ��� ������� ����� ������ �����������.
//
// Revision 1.103  2005/04/01 14:35:22  lulin
// - ��������� �� �������� �������� � ������� ���������.
//
// Revision 1.102  2005/04/01 13:21:57  lulin
// - ��������� ���������� _InevPoint*.
//
// Revision 1.101  2005/04/01 11:05:19  lulin
// - �������� �������� � ������� ���������� ����������� ��������� �������.
//
// Revision 1.100  2005/04/01 09:53:06  lulin
// - �������� �� ��, ��� �������� ��� �������� � �����-�� ������ ���������� � ����� ���������� ����� - ����� � �������� ������� ���������.
//
// Revision 1.99  2005/04/01 08:35:29  lulin
// - remove proc: evDir_InsertPara (����������� ������������ InevParaList).
//
// Revision 1.98  2005/03/31 10:30:46  lulin
// - remove unit: evBase_TLB.
//
// Revision 1.97  2005/03/28 11:32:07  lulin
// - ���������� ��������� � "����������" ������.
//
// Revision 1.96  2005/03/24 18:39:21  lulin
// - remove object: Tk2AtomR.
//
// Revision 1.95  2005/03/24 15:25:51  lulin
// - ������� �������� ������.
//
// Revision 1.94  2005/03/24 12:08:12  lulin
// - remove method: Ik2TagBox._Tag.
// - new method: Ik2TagBox._Target.
//
// Revision 1.93  2005/03/21 13:42:58  lulin
// - ������ �������� ������.
//
// Revision 1.92  2005/03/21 06:44:53  lulin
// - ������ �������� ������.
//
// Revision 1.91  2005/03/17 17:57:02  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.90  2005/03/17 16:20:12  lulin
// - bug fix: ��� ���������� ��������� ���������� (��� ������� �� Clipboard) �������� ��������� ���� ����� ��������� ����������.
//
// Revision 1.89  2005/03/17 13:28:46  lulin
// - bug fix: ��������� AND � OR - � ����� AV ��� ������� �����.
//
// Revision 1.88  2005/03/17 12:50:58  lulin
// - bug fix: ��� ������� ����� � ���������� ��������� ��������� � �������������� - � ����� ����� ���������� ������������.
//
// Revision 1.87  2005/03/16 19:21:53  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.86  2005/03/16 15:05:50  lulin
// - bug fix: ��������� � �������������� ����������� ����������� �� ������ ������ - ������������ ��������.
//
// Revision 1.85  2005/03/16 12:16:51  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.84  2005/03/15 10:30:17  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.83  2005/03/11 12:49:10  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.82  2005/03/10 17:44:02  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.81  2005/03/09 19:06:06  lulin
// - �� Tk2AtomR ��������� � _Ik2Tag.
//
// Revision 1.80  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR.DeleteChild.
// - new method: _Ik2Tag.DeleteChild.
//
// Revision 1.79  2005/03/09 17:05:20  lulin
// - remove method: Tk2AtomR._InsertChild.
// - new method: _Ik2Tag._InsertChild.
//
// Revision 1.78  2005/03/04 13:59:17  lulin
// - remove method: Tk2AtomR._AddChild.
//
// Revision 1.77  2005/02/03 14:33:43  lulin
// - ��� Undo-������� ���������� ��������� ������ ToUndo, ������ �������������.
//
// Revision 1.76  2004/11/26 15:06:10  lulin
// - bug fix: �������� �� Clipboard'� �� �������������� � �����������.
//
// Revision 1.75  2004/11/10 12:13:25  lulin
// - cleanup: ������� ��������� � ���������� ����������� �� ���������� ������������.
//
// Revision 1.74  2004/11/09 13:37:56  lulin
// - ��������� �� ������� � �����������.
//
// Revision 1.73  2004/09/21 12:55:40  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.72  2004/08/02 09:36:59  law
// - bug fix: �� �������� "������" ��� ������� ������������, ��������� � ����� ������ �� ����� �� ������ (CQ OIT5-8343).
//
// Revision 1.71  2004/07/01 11:27:02  law
// - bug fix: ����� �� ��������� �����.
//
// Revision 1.70  2004/06/28 13:46:33  law
// - remove unit: k2IntfStub.
//
// Revision 1.69  2004/06/28 13:34:45  law
// - remove class: Il3Pointer.
//
// Revision 1.68  2004/06/17 16:20:40  law
// - ������������ � ������� _TevBaseParaList.
//
// Revision 1.67  2004/06/17 15:58:53  law
// - �������� Empty ������������� � ������ _Tl3Base �� ����� _Tl3SomeDataContainer.
//
// Revision 1.66  2004/06/17 10:19:15  law
// - remove method: _TevBaseParaList.Dir_InsertPara.
// - new proc: evDir_InsertPara.
//
// Revision 1.65  2004/05/25 13:08:49  law
// - change: Tk2AtomR.ArrayProp - ������ property, � �� �������.
// - bug fix: ��� ������� �� ������ ����������� "�����" �������� ����������.
//
// Revision 1.64  2004/03/16 17:27:39  law
// - new behavior: ������ ���� ���������� ������-��������� ��������� � ���������� ���� ��������.
//
// Revision 1.63  2003/10/02 16:33:23  law
// - rename unit: evBseCur -> evBaseCursor.
//
// Revision 1.62  2003/01/09 17:05:25  law
// - new behavior: ������� ����� ����� � ������� �� ������ ������.
//
// Revision 1.61  2003/01/09 16:15:49  law
// - new behavior: ������ ������� ������� ������� � ������� �� ������ ������.
//
// Revision 1.60  2003/01/09 14:18:18  law
// - new directive: evSmartTablePaste.
// - new behavior: ����� �� ����� ���������������� ������� ������ ������ ������.
//
// Revision 1.59  2002/12/26 16:56:06  law
// - cleanup.
//
// Revision 1.58  2002/12/26 16:31:28  law
// - new directive: evNeedEditableCursors.
//
// Revision 1.57  2002/12/16 15:23:19  law
// - new unit: evParaListCursor.
//
// Revision 1.56  2002/11/29 17:44:13  law
// - cleanup.
//
// Revision 1.55  2002/11/29 14:22:10  law
// - remove method: _TevBaseCursor.SetEntryPointHard.
// - new behavior: ��� "solid" ���������� ������������ High(Long).
//
// Revision 1.54  2002/11/06 16:35:08  law
// - new behavior: ������������ ����� ������� ��������� ��� ������� �� ���������� �������.
//
// Revision 1.53  2002/11/06 16:15:47  law
// - bug fix: ����������� �������������� ��������� ������ ������ � ������������ > 1 ��� ��������� (��. _TestSet\Block\1.evd).
//
// Revision 1.52  2002/11/06 13:44:53  law
// - bug fix: �� ���������������� ������� �������.
//
// Revision 1.51  2002/11/06 11:14:34  law
// - new behavior: ������ ���������� ����������� ��������� ������� �����.
//
// Revision 1.50  2002/11/01 17:51:01  law
// - bug fix: ����� Redo ������� ����� �� ������ ���� ������� � �������� ������.
//
// Revision 1.49  2002/10/17 14:52:30  law
// - cleanup.
//
// Revision 1.48  2002/10/17 06:51:07  law
// - new behavior: ��������� ������ ��� ����������� ����������.
//
// Revision 1.47  2002/10/16 16:06:28  law
// - new behavior: ���������� ���������, ����� ���������� ������ �� ���������� ����������.
//
// Revision 1.46  2002/09/12 16:07:35  narry
// - bug fix: ����������� ���������������� ������� ����� ������� ����� ����������.
//
// Revision 1.45  2002/09/12 13:40:45  narry
// - bug fix: �� �������������� ������� ��� �������� ������� ����������.
//
// Revision 1.44  2002/07/30 13:41:20  law
// - bug fix: ����� �������� ����� ��������� ������� �� �����.
//
// Revision 1.43  2002/07/30 13:08:08  law
// - bug fix: ����� Undo �������� ����� ������ ���� ��������� �����.
//
// Revision 1.42  2002/07/09 13:57:38  law
// - new unit: evMsgCode.
//
// Revision 1.41  2002/02/15 15:51:17  law
// - comments: xHelpGen.
//
// Revision 1.40  2002/02/08 15:04:51  law
// - rename unit: evDoc -> evDocument.
//
// Revision 1.39  2002/02/08 13:16:47  law
// - remove prop: _TevBaseParaList.ParaCount.
//
// Revision 1.38  2002/02/08 12:14:48  law
// - new unit: evParaList.
//
// Revision 1.37  2002/02/07 17:56:08  law
// - cleanup: �� _TevBasePara ������ ������ � _TevBaseParaList.
//
// Revision 1.36  2002/02/07 15:05:24  law
// - rename class: IevCursor -> _TevCursor, ��� ���� ����� �� ������ ��� � �����������.
//
// Revision 1.35  2002/01/10 15:23:59  law
// - bug fix: �� ��������������� � ���������� l3ConsoleApp.
//
// Revision 1.34  2001/09/05 08:58:01  law
// - change: ������� ������ ��������� M_evSplit.
//
// Revision 1.33  2001/07/26 12:49:40  law
// - bug fix: ��� ������� �� ��������� � ��������� ��������� ������ ���������������� ����� ����������� �������.
//
// Revision 1.32  2001/07/24 15:21:14  law
// - new behavior: ��� ����������� ����������, ��� ������� �� ������ ������, ����� �� ������� ��������� �� ��������� �� ������, ���� � ������� ��� ���� ����� (��. ������ �752).
//
// Revision 1.31  2001/07/24 08:01:30  law
// - new behavior: ��������� ��������� ��� ����� not Persistent ��� ������� ������.
//
// Revision 1.30  2001/06/18 14:32:48  law
// - cleanup.
//
// Revision 1.29  2001/06/15 14:38:48  law
// - new logic: ������ ��������� ev_msgInsertPara ���������� ������� _evInsertPara.
//
// Revision 1.28  2001/05/29 10:37:32  law
// - cleanup.
//
// Revision 1.27  2001/05/28 14:06:35  law
// - cleanup: ������ �������� ����������� ����� ��������.
//
// Revision 1.26  2001/05/04 13:22:12  law
// - cleanup: �������� ������ TevDocumentFiler - �� _TevBaseParaList � Ik2TagWrap, � ����� ��������� �� �������� � �������.
//
// Revision 1.25  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.24  2001/03/05 14:08:28  law
// - ��������� ������� � ������� _IterateChildren...
//
// Revision 1.23  2001/02/28 13:40:27  law
// - some tuning.
//
// Revision 1.22  2001/02/20 10:23:51  law
// - some tuning
//
// Revision 1.21  2001/01/31 10:37:29  law
// - �������������� ������������� QueryInterface.
//
// Revision 1.20  2000/12/15 15:10:34  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

{$IfDef evNeedEditableCursors}
uses
  l3Types,
  l3Base,
  l3IID,
  l3Interfaces,
  l3Tree_TLB,
  l3Variant,

  k2Types,
  k2Interfaces,
  k2InternalInterfaces,
  k2TagGen,
  k2DocumentGenerator,

  evConst,

  evInternalInterfaces,
  evHighLevelDocumentGenerator,

  evParaPackOperation,

  evEditorInterfaces,

  nevTools,
  evGeneratorsInterfaces,
  evDocumentPartGeneratorPrim
  ;

type
  TevDocumentPartGenerator = class(TevDocumentPartGeneratorPrim
                                   {$IfDef evNeedEditableCursors}
                                   ,
                                   IedRangeSource
                                   {$EndIf evNeedEditableCursors}
                                   )
   {* ���������, ����������� ����� � �����, ����������� ��������. }
    private
    // internal fields
      f_FirstPara : Long;
    protected
      f_InsPara   : Long;
    private  
      f_Inserted  : Ok2AddChildren;
      f_Tail      : Tl3Variant;
      f_View      : InevView;
    private
    // property fields
      f_Cursor             : InevBasePoint;
      f_ParaList           : InevParaList;
      f_InsBlock           : Tl3Variant;
      f_NextNode           : Il3Node;
      f_NeedNodeCorrection : Bool;
      f_InsCursor          : InevBasePoint;
      f_JoinCursor         : InevPoint;
      {$IfDef evNeedEditableCursors}
      f_Range              : IedRange;
      {$EndIf evNeedEditableCursors}
      {$IfDef evSmartTablePaste}
      f_WasTableCheck      : Bool;
      {$EndIf evSmartTablePaste}
    protected
    // property methods
      procedure pm_SetInsBlock(aValue: Tl3Variant);
        {-}
      procedure pm_SetCursor(const Value: InevBasePoint);
        {-}
      function pm_GetCursor: InevBasePoint;
        {-}
      // IevJoinGenerator
      procedure AtEndChanged; override;
        {-}
      {$IfDef evNeedEditableCursors}
      function  pm_GetRange: IedRange;
      procedure pm_SetRange(const aValue: IedRange);
        {-}
      {$EndIf evNeedEditableCursors}
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
      function  AddChild(var aChild: Tk2StackAtom): Long;
        override;
        {-}
      procedure InsertPara(aChild: Tl3Variant);
        virtual;
        {-}
      procedure StartInsertion;
        virtual;
        {-}
      procedure SetInsertionPoint(const aPoint: InevBasePoint; aPID : Integer);
        virtual;
        {-}
      procedure FinishInsertion;
        virtual;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-���������� ���� ��� � ����� ���������}
      procedure ValidateCursors;
        {-}
      procedure EnableUndo;
        {-}
      procedure DisableUndo;
        {-}
      function  DoBeforeFinishAtom(var Atom: Tk2StackAtom): Bool;
        override;
        {-}
      procedure SaveInserted;
        {-}
      procedure DoAddAtom(const Atom : Tk2StackAtom;
                          Prop       : Integer;
                          aSource: Tl3Variant);
        override;
        {-}
      {$IfDef evSmartTablePaste}
      function  InsertTable(aChild: Tl3Variant): Bool;
        virtual;
        {-}
      {$EndIf evSmartTablePaste}
    protected
    // protected properties
      property ParaList: InevParaList
        read f_ParaList
        write f_ParaList;
        {-}
      property InsBlock: Tl3Variant
        read f_InsBlock
        write pm_SetInsBlock;
        {-}
      property NeedNodeCorrection: Bool
        read f_NeedNodeCorrection
        write f_NeedNodeCorrection;
        {-}
      property NextNode: Il3Node
        read f_NextNode
        write f_NextNode;
        {-}
      property View: InevView
        read f_View;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      class function Make(const aView : InevView;
                          const aCursor: InevBasePoint;
                          const anOp : InevOp): Ik2TagGeneratorWrap;
        reintroduce;
        {-}
      function COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
        override;
        {-}
    public
    // public properties
      property Cursor: InevBasePoint
        read f_Cursor
        write pm_SetCursor;
        {* - ������ ��� ������� ������. }
      property InsCursor: InevBasePoint
        read f_InsCursor;
        {-}
      {$IfDef evNeedEditableCursors}
      property Range: IedRange
        read f_Range
        write f_Range;
        {* - �������� ���������. }
      {$EndIf evNeedEditableCursors}
  end;//TevDocumentPartGenerator
{$EndIf evNeedEditableCursors}

implementation

{$IfNDef k2ForEditor}
  !!! ������: �� ���������� ��������� k2ForEditor.
{$EndIf  k2ForEditor}

{$IfDef evNeedEditableCursors}
uses
  SysUtils,

  l3MinMax,
  l3Chars,
  l3InternalInterfaces,
  l3InterfacesMisc,
  l3String,
  l3InterfacedString,

  CommentPara_Const,
  LeafParaDecorationsHolder_Const,

  k2Facade,
  k2Base,
  k2Tags,
  k2Except,

  {$IfDef evKillMarksFromClipboard}
  evdTypes,
  {$EndIf evKillMarksFromClipboard}
  evExcept,

  nevBase,
  
  evOp,
  evMsgCode,

  evNode,
  evSubNode,
  evCursorTools,
  {$IfDef evSmartTablePaste}
  evParaTools,
  {$EndIf evSmartTablePaste}
  Block_Const,
  Table_Const,
  Document_Const,
  Para_Const,
  Mark_Const,
  LeafPara_Const
  ;

// start class TevDocumentPartGenerator 

constructor TevDocumentPartGenerator.Create(anOwner: Tk2TagGeneratorOwner);
  //override;
  {-}
begin
 inherited;
 pm_SetNeedJoin(true);
 pm_SetNeedSkipSubdocuments(false);
end;

class function TevDocumentPartGenerator.Make(const aView : InevView;
                                             const aCursor: InevBasePoint;
                                             const anOp : InevOp): Ik2TagGeneratorWrap;
  {-}
var
 G : TevDocumentPartGenerator;
begin
 Assert(aCursor <> nil);
 aCursor.CheckPos(anOp);
 G := Create;
 try
  G.f_View := aView;
  G.Context := anOp;
  G.Cursor := aCursor;
  Result := G;
 finally
  l3Free(G);
 end;//try..finally
end;

function TevDocumentPartGenerator.pm_GetCursor: InevBasePoint;
begin
 Result := f_Cursor;
end;

procedure TevDocumentPartGenerator.pm_SetInsBlock(aValue: Tl3Variant);
  {-}
begin
 aValue.SetRef(f_InsBlock);
end;

procedure TevDocumentPartGenerator.pm_SetCursor(const Value: InevBasePoint);
  {-}
var
 C       : InevBasePoint;
 PC      : Long;
 l_Block : Tl3Variant;
 l_List  : InevParaList;
 l_Proc  : InevProcessor;
begin
 f_Cursor := Value;
 if (f_Cursor = nil) then
 begin
  ParaList := nil;
  InsBlock := nil;
  NextNode := nil;
 end//f_Cursor = nil
 else
 begin
  C := Cursor.MostInner;
  if not l3IEQ(C, Cursor) AND not C.Obj.AsObject.IsKindOf(k2_typBlock) then
   C := C.ParentPoint;
  f_InsCursor := C;
  if f_InsCursor.Obj^.AsObject.IsKindOf(k2_typLeafPara) then
  begin
   f_InsCursor := f_InsCursor.PointToParent;
   Assert(f_InsCursor <> nil);
  end;//f_InsCursor.Obj^.IsKindOf(k2_typLeafPara)
  l_Block := InsCursor.Obj^.AsObject;
  Assert(Context <> nil);
  l_Proc := Context.Processor;
  //Supports(Self, InevProcessor, l_Proc);
  if l_Block.QT(InevParaList, l_List, l_Proc) then
  begin
   if (f_ParaList = nil) OR not f_ParaList.AsObject.IsSame(l_List.AsObject) then
    f_ParaList := l_List;
  end//l_Block.QT(InevParaList
  else
   Assert(false, Format('��������� InevParaList �� �������������� [%s]',
                        [ClassName]));
  while l_Block.IsValid AND not l_Block.IsKindOf(k2_typBlock) do
   l_Block := l_Block.Owner;
  InsBlock := l_Block; 
  f_FirstPara := InsCursor.Position;
  if (ev_lfAtEnd in Flags) then
   Inc(f_FirstPara)
  else 
  begin
   // - ������ �� ���� �������� f_AtEnd - ��������, �����
   // ����� ��������� ������ ������, �� ����� ������� ������ ������ ������� ���
   // �������� - ������� ���� ���������. ����� ��� ���-�� ���-�� � ��������.
   // �� ���� ���� ������������� ������� �� ������ ������ � ������� �����.
   { ��������� ��� ��������� ������� ������ ���������� � ��������� ��������: }
   PC := ParaList.ParaCount;
   if (PC < f_FirstPara) then f_FirstPara := PC;
  end;//f_AtEnd
  f_InsPara := f_FirstPara;
 end;//f_Cursor = nil
end;

procedure TevDocumentPartGenerator.AtEndChanged;
  {-}
begin
 if (f_Cursor <> nil) then
  Cursor := f_Cursor;
 // - ������������ �������� �� �������
end;

{$IfDef evNeedEditableCursors}
function TevDocumentPartGenerator.pm_GetRange: IedRange;
  {-}
begin
 Result := Range;
end;

procedure TevDocumentPartGenerator.pm_SetRange(const aValue: IedRange);
  {-}
begin
 Range := aValue;
end;
{$EndIf evNeedEditableCursors}

{$IfDef evSmartTablePaste}
function TevDocumentPartGenerator.InsertTable(aChild: Tl3Variant): Bool;
  {-}
var
 l_Flags             : TevInsertParaFlags;
 l_NewTable          : Tl3Variant;
 l_OldTableCursor    : InevBasePoint;
 l_PrevCursor        : InevBasePoint;
 l_RowIndex          : Long;
 l_PrevChildrenCount : Integer;
begin
 Result := False;
 // - �� ���������� � �� ��������, ��� ��������� �������
 if not f_WasTableCheck then 
 begin
  // - ��� �� ��������� �� ������� �������
  f_WasTableCheck := True;
  // - ������ ��������� �� ����
  if evInPara(aChild.AsObject, k2_typTable, l_NewTable) AND
     evInPara(Cursor, k2_typTable, l_OldTableCursor) AND
     l_OldTableCursor.HasInner then
  begin
   // - ����� ����������, ��� ��������� ������� � �������
   // - ����� �������� ��������� ������� � ������
   l_OldTableCursor := l_OldTableCursor.ClonePoint(f_View);
   // - �������� ������ ������ - ��� ��� ���������� ��� �������
   try
    if (l_OldTableCursor.Inner.Position <= 1) AND
       // - ������ ����� � ������ ������ ������ ��� ��� ��������� ������...
       (l_OldTableCursor.Inner.Obj.AsObject.ChildrenCount = l_NewTable.Child[0].ChildrenCount) then 
    begin
       // - ����� ����� � ������ ������� ��������� � ������ ����� � ����� �������
       // - ������ ���� ��������� �� �������, � ������
     with l_NewTable do
      while (ChildrenCount > 0) do
       // - ���������� ������ ������� � �����, � ������ ����, ��� ��������
       //   ������� ������� ��������� �� ����������� ��������
       evInsertPara(Context, l_OldTableCursor, Child[0], []);
    end 
    else 
    begin
     // - ����� ��������� �������
     { TODO -o����� �. �. -c��������� : ��� ���� �� ��� ������� �������� ����, ��� ��� �� ������ ������ �������, � ����� ���� ������� ������ ����������� ����� � ���������� ����������� �����. }
     l_PrevCursor := l_OldTableCursor.ClonePoint(f_View);
     if (l_OldTableCursor.Inner.Position = 0) then // ��������� ��������, ��������, � ���������� �������� ������: http://mdp.garant.ru/pages/viewpage.action?pageId=569232703
      l_OldTableCursor.Inner.Move(f_View, ev_ocBottomRight);
     for l_RowIndex := 0 to Pred(l_NewTable.ChildrenCount) do
     begin
      // - ���������� ����� ������� �� ��������� ������
      l_PrevCursor.Move(f_View, ev_ocParaDownWithEmptyRow, Context);
                               // ^ - http://mdp.garant.ru/pages/viewpage.action?pageId=340175024
      // - ���������� ������ ����� �������
      with l_NewTable.Child[l_RowIndex] do
       while (ChildrenCount > 0) do
       begin
        l_PrevChildrenCount := ChildrenCount;
        // - ���������� ������ ������ ������� � ������, � ������ ����, ��� ��������
        //   ������� ������� ��������� �� ����������� ��������
        //l_OldTableCursor.Inner.Obj.Chil
        l_Flags := [ev_ipfCheckPrev];
        if (l_OldTableCursor.Inner.Obj.ChildrenCount = 0) and (l_OldTableCursor.Inner.Position = 0) then
         l_Flags := l_Flags + [ev_ipfAtEnd];
        if not evInsertPara(Context, l_OldTableCursor.Inner, Child[0], l_Flags) then
        // - �������� ������ �������
         break;
         // - �������, ���� �� ������� ��������
        Assert(l_PrevChildrenCount > ChildrenCount, '�����������');
       end;//ChildrenCount > 0
      l_OldTableCursor := l_PrevCursor.ClonePoint(f_View);
     end;//for l_RowIndex
    end;//l_OldTableCursor.ChildCursor.Position = 1..
    Result := True;
    // - �������, ��� �������� ������� � �� �� ���� ���������
   finally
    l_OldTableCursor := nil;
   end;//try..finally
  end;//evSomeParentInherits(aChild, k2_idTable)
 end;//not f_WasTableCheck
end;
{$EndIf evSmartTablePaste}

procedure TevDocumentPartGenerator.InsertPara(aChild: Tl3Variant);
  {-}

 procedure _DoJoin;
 var
  l_Space : Tl3InterfacedString;
 begin//_DoJoin
  f_JoinCursor.Move(f_View, ev_ocBottomRight);
  l_Space := Tl3InterfacedString.Make(sp_HardSpace[False]);
  try
   f_JoinCursor.Text.Modify.InsertString(f_View, l_Space, Context);
  finally
   l3Free(l_Space);
  end;//try..finally
  f_JoinCursor.Move(f_View, ev_ocBottomRight);
  try
   f_JoinCursor.Text.Modify.JoinWith(f_View, aChild, Context, False);
  except
   on EevLimitReached do
   // http://mdp.garant.ru/pages/viewpage.action?pageId=292913355
    Exit;
  end;//try..except
 end;//_DoJoin

 function lp_CheckParaList(var aInsetPos: Long): InevParaList;

  procedure lp_CorrectResult(aIndex: Integer);
  begin
   Result.Child[aIndex].QT(InevParaList, Result);
   aInsetPos := Result.ChildrenCount - 1;
   Assert(Result <> nil);
  end;
  
 var
  l_PrevInsPara: Integer;
 begin
  Result := ParaList;
  {$IFDEF Nemesis}
  if aChild.IsKindOf(k2_typCommentPara) and not Result.IsKindOf(k2_typLeafParaDecorationsHolder) then
   if (aInsetPos >= Result.ChildrenCount) and Result.Child[Result.ChildrenCount - 1].IsKindOf(k2_typLeafParaDecorationsHolder) then // http://mdp.garant.ru/pages/viewpage.action?pageId=563191485
    lp_CorrectResult(Result.ChildrenCount - 1)
   else
    if not Result.Child[aInsetPos].IsKindOf(k2_typLeafParaDecorationsHolder) then // ��, �� �� �� ����� ������: http://mdp.garant.ru/pages/viewpage.action?pageId=515518310
    begin
     l_PrevInsPara := aInsetPos;
     while l_PrevInsPara >= 0 do
     begin
      if Result.Child[l_PrevInsPara].IsKindOf(k2_typLeafParaDecorationsHolder) then Break;
      Dec(l_PrevInsPara);
     end; // while aInsetPos >= 0 do
     if l_PrevInsPara >= 0 then
     begin
      aInsetPos := l_PrevInsPara;
      lp_CorrectResult(l_PrevInsPara)
     end // if l_PrevInsPara >= 0 then
     else
      begin
       l_PrevInsPara := aInsetPos;
       while l_PrevInsPara < Result.ChildrenCount do
       begin
        if Result.Child[l_PrevInsPara].IsKindOf(k2_typLeafParaDecorationsHolder) then Break;
        Inc(l_PrevInsPara);
       end; // while l_PrevInsPara < l_PrevInsPara.ChildrenCount do
       if l_PrevInsPara < Result.ChildrenCount then
       begin
        aInsetPos := l_PrevInsPara;
        lp_CorrectResult(l_PrevInsPara);
       end // if l_PrevInsPara < l_PrevInsPara.ChildrenCount then
       else
        Assert(False); // � ���� � ��� �� ����� ���������?!
      end;
    end;    
  {$ENDIF Nemesis}
 end;

var
 l_Pos: Long;

 function lp_EmptyComment: Boolean;
 begin
  Result := (l_Pos = -2) and ParaList.IsKindOf(k2_typCommentPara) and (ParaList.ChildrenCount = 1);
 end;

 procedure lp_CheckModified;
 begin
  if lp_EmptyComment then
   ParaList.MarkModified;
 end;   

var
 {$IfDef evKillMarksFromClipboard}
 l_Index  : Long;
 {$EndIf evKillMarksFromClipboard}
 l_ParaList : InevParaList;
 l_Cursor   : InevPoint;
 l_InsetPos : Long;
begin
 if (f_JoinCursor <> nil) then
 begin
  _DoJoin;
  Exit;
 end;//f_JoinCursor <> nil
 {$IfDef evKillMarksFromClipboard}
 with aChild.Attr[k2_tiSubs] do
  if IsValid then
   if rAtomEx([k2_tiChildren, k2_tiHandle, Ord(ev_sbtMark)], @l_Index).IsValid then
    DeleteChild(l_Index);
 {$EndIf evKillMarksFromClipboard}
 {$IfDef evSmartTablePaste}
 if InsertTable(aChild) then
  // - ��������� ������� �������
  Exit;
 {$EndIf evSmartTablePaste}
 if (ev_lfNeedJoin in Flags) then
 begin
  { - ���������� ���������� ������� �������� �� ���������. }
  pm_SetNeedJoin(false);
  { - ������ ����������� �� ����� �� ��� ����� ���������. }
  try
   l_Pos := Cursor.Text.Modify.JoinWith(f_View, aChild, Context, False);
  except
   on EevReadOnly do
   // http://mdp.garant.ru/pages/viewpage.action?pageId=453166247
   // ������ ����� - ����� ����� �� �������� ���������� � ���
   begin
    FreeAndNil(f_Tail);
    raise;
   end;//on EevReadOnly
  end;//try..except
  if (l_Pos >= 0) then
   Exit
   { - ������� ���������� ������� � Para -> ������ ������ ������. }
  else
  if (l_Pos = -2) then
  begin
   if lp_EmptyComment then
    evDeletePara(Context, InsCursor, [ev_dpfInternal, ev_dpfForce])
   else
    evDeletePara(Context, InsCursor, [ev_dpfInternal]);
   f_FirstPara := InsCursor.Position;
   if (ev_lfAtEnd in Flags) then
    Inc(f_FirstPara);
   f_FirstPara := Max(0, Min(f_FirstPara, ParaList.ParaCount));
   f_InsPara := f_FirstPara;
  end;//l_Pos = -2
 end;//f_NeedJoin
 try
  Context.SaveUndo := False;
  try
   ParaList.Modify.InsertPara(f_InsPara, aChild, Context, []);
   lp_CheckModified;
  finally
   Context.SaveUndo := True;
  end;//try..finally
 except
  on Ek2CannotAddChild do
   Exit;
   // - ������ �� ���� � Undo ������
  on EevLimitReached do
  begin
   SaveInserted;
   l_Cursor := ParaList[Pred(f_InsPara)].MakePoint;
   try
    f_JoinCursor := l_Cursor;
   finally
    l_Cursor := nil;
   end;//try..finally
   _DoJoin;
   Exit;
  end;//EevLimitReached
 end;
 if (f_Inserted = nil) then
 begin
  f_Inserted := Ok2AddChildren.Create;
  l_InsetPos := f_InsPara;
  l_ParaList := lp_CheckParaList(l_InsetPos);
  try
   f_Inserted.SetParam(l_ParaList.AsObject.Box,
                       Tk2Type(l_ParaList.AsObject.TagType).Prop[k2_tiChildren],
                       l_InsetPos);
  finally
   l_ParaList := nil;
  end;
  { - �������������� �������� ������� ����������. }
 end;//f_Inserted = nil
 f_Inserted.Deleted.Add(aChild);
 { - ���������� ���� ������� ��������� Para. }
 Inc(f_InsPara);
 { - ���������� ��������� �������. }
end;

procedure TevDocumentPartGenerator.Cleanup;
  {override;}
  {-}
begin
 inherited;
 f_View := nil;
 f_InsCursor := nil;
 f_JoinCursor := nil;
 Cursor := nil;
 InsBlock := nil;
 FreeAndNil(f_Tail);
end;

function TevDocumentPartGenerator.AddChild(var aChild: Tk2StackAtom): Long;
  {override;}
  {-}
var
 l_Parent : PevStackAtom;
begin
 Result := -1;
 l_Parent := aChild.Parent;
 if aChild.IsKindOf(k2_typDocument) then
 begin
  if (ev_lfSkipSubdocuments in Flags) OR
     ((l_Parent = nil) OR not l_Parent.IsKindOf(k2_typPara)) then
   // - ��� �� ��������� ��������
   Exit;
   // - ��� ����������
 end;//aChild.IsKindOf(k2_typDocument)
 if not (ev_lfSkipSubdocuments in Flags) then
 begin
  if (l_Parent <> nil) AND l_Parent.IsKindOf(k2_typDocument) AND
     (l_Parent.Parent <> nil) AND l_Parent.Parent.IsKindOf(k2_typPara) then
  begin
   // - ���� �������� �������� � �����������
   Result := inherited AddChild(aChild);
   // - ��������� ��� ��� ������� ������������
   Exit;
  end;//(l_Parent <> nil) AND l_Parent.IsKindOf(k2_typDocument) AND..
 end;//not f_NeedSkipSubdocuments
 if (l_Parent = nil) OR l_Parent.IsKindOf(k2_typDocument) then
 begin
  { - ������������ ������� ��������� � ������� ������� �������, � �� � ��������. }
  if (ev_lfSkipSubdocuments in Flags) then
  begin
   while (l_Parent <> nil) do
   begin
    if not l_Parent.IsKindOf(k2_typDocument) then
    begin
     l_Parent.Box.AddChild(aChild.Box, Context);
     Exit;
    end;//not l_Parent.IsKindOf(k2_typDocument)
    l_Parent := l_Parent.Parent;
   end;//l_Parent <> nil
  end;//f_NeedSkipSubdocuments
  if not (ev_lfSkipSubdocuments in Flags) OR
     not aChild.IsKindOf(k2_typDocument) then
  // - !!! ������ ��� �����! �.�. ��������� ����� �� ���������� �����������
  // - ��� �������� �� �����, �.�. ����� ������� �������� �� ������� ����
  begin
   { - �� ����� ��������� ���������� ��������. }
   EnableUndo;
   { - ��������� ���������� ��������. }
   try
    InsertPara(aChild.Box);
    { - ��������� ��������� ��������. }
   finally
    DisableUndo;
    { - ��������� ���������� ��������. }
   end;//try..finally
  end;//not..k2_idDocument..
 end//(l_Parent = nil) OR l_Parent^.IsKindOf(k2_typDocument)
 else
  Result := inherited AddChild(aChild);
end;

procedure TevDocumentPartGenerator.StartInsertion;
  {-}
var
 //l_Processor : InevProcessor;
 l_ParaCount : Long;
begin
 Assert(Context <> nil);
(* l_Processor := Self As InevProcessor;
 try
  Context := l_Processor.StartOp(ev_msgInsertBlock);
 finally
  l_Processor := nil;
 end;//try..finally*)
 { - ��������� ����� ��������. }
 EnableUndo;
 {$IfDef evNeedEditableCursors}
 if (Range <> nil) then
 begin
  Range.Delete;
  // - ������� ��������� ���� ��� ����
  Cursor := Cursor;
 end;//Range <> nil
 {$EndIf evNeedEditableCursors}
 if (ev_lfNeedJoin in Flags) then
  Cursor.Text.Modify.Split(f_View, [], Context).AsObject.SetRef(f_Tail)
  // - ��������� ������� ��������. ��� ����� -> f_Tail
 else
 begin
  FreeAndNil(f_Tail);
  l_ParaCount := ParaList.ParaCount;
  if (f_FirstPara > 0) AND (f_FirstPara <=  l_ParaCount + 1) then 
  begin
   // - ������ ���� f_FirstPara < ParaList._AsTag.ChildrenCount - ��������, �����
   // ����� ��������� ������ ������, �� ����� ������� ������ ������ ������� ���
   // �������� - ������� ���� ���������. ����� ��� ���-�� ���-�� � ��������.
   // �� ���� ���� ������������� ������� �� ������ ������ � ������� �����.
   Dec(f_FirstPara);
  end;//f_FirstPara > 0..
  f_InsPara := Min(f_FirstPara, l_ParaCount);
 end;//f_NeedJoin
 DisableUndo;
 { - �� ��������� �������� ��� ������ ������. }
 Context.DeleteMapped := False;
 { - �� ������� ������������ ��������. }
end;

procedure TevDocumentPartGenerator.ValidateCursors;
  {-}
begin//ValidateCursors
 with ParaList do
  k2.SignalEvent(Self.ParaList.AsObject,
                 k2_eidChildrenInserted,
                 AsObject.Box,
                 Context,
                 f_FirstPara,
                 f_InsPara - f_FirstPara,
                 ParaCount);
end;//ValidateCursors

procedure TevDocumentPartGenerator.DoAddAtom(const Atom : Tk2StackAtom;
                                             Prop       : Integer;
                                             aSource    : Tl3Variant);
  //override;
  {-}
begin
 if Atom.IsKindOf(k2_typBlock) AND (Prop = k2_tiHandle) then
 begin
  EnableUndo;
  try
   inherited;
  finally
   DisableUndo;
  end;//try..finally
 end//Atom.IsKindOf(k2_typBlock)
 else
  inherited;
end;

procedure TevDocumentPartGenerator.EnableUndo;
  {-}
begin
 with Context do 
 begin
  SaveUndo := True;
  InIOProcess := False;
 end;
end;

procedure TevDocumentPartGenerator.DisableUndo;
  {-}
begin
 with Context do 
 begin
  SaveUndo := False;
  InIOProcess := True;
 end; 
end;

function TevDocumentPartGenerator.DoBeforeFinishAtom(var Atom: Tk2StackAtom): Bool;
  //override;
  {-}
begin
 EnableUndo;
 try
  {$IfDef evKillMarksFromClipboard}
  if Atom.IsKindOf(k2_typMark) then
   Result := False
  else
  {$EndIf evKillMarksFromClipboard}
   Result := inherited DoBeforeFinishAtom(Atom);
 finally
  DisableUndo;
 end;//try..finally
end;

function TevDocumentPartGenerator.COMQueryInterface(const IID: Tl3GUID; out Obj): Tl3HResult;
  {override;}
  {-}
begin
 if IID.EQ(InevProcessor) then
 begin
  if Supports(Cursor, IID.IID, Obj) then
   Result.SetOk
  else
   Result.SetNoInterface;
  if Result.Fail AND (Context <> nil) then
   Result := Tl3HResult_C(Context.QueryInterface(IID.IID, Obj))
 end//IID.EQ(InevProcessor)
 else
  Result := inherited COMQueryInterface(IID, Obj);
end;

procedure TevDocumentPartGenerator.SaveInserted;
  {-}
begin
 if (f_Inserted <> nil) AND not f_Inserted.Deleted.Empty then 
 begin
  EnableUndo;
  try
   f_Inserted.Put(Context, True);
  finally
   DisableUndo;
  end;//try..finally
 end;
 { - ���������� ����������� ���������. }
 l3Free(f_Inserted);
 { - ����������� ����� ����������� ����������. }
end;

procedure TevDocumentPartGenerator.SetInsertionPoint(const aPoint: InevBasePoint; aPID : Integer);
  //virtual;
  {-}
begin
 with aPoint do
 begin
  SetEntryPoint(aPID, Context);
  { - ������������ ������ �� ����������� ���������. }
  if HasInner then
   Inner.Move(f_View, ev_ocBottomRight);
  { - ��������� ��� ������������ ������� �����, }
  {   � ����� - � ����� ���������� ������������ ���������. }
 end;//with aPoint
end;

procedure TevDocumentPartGenerator.FinishInsertion;
  {-}
var
 BCP              : InevBasePoint;
 l_ParaListCursor : InevPoint;
 l_Tail           : Tl3Variant;
begin
 SaveInserted;

 EnableUndo;
 { - ��������� ���������� ��������. }

 ValidateCursors;

 SetInsertionPoint(f_InsCursor, f_InsPara);

 BCP := InsCursor;
 if (f_Tail <> nil) then 
 begin
  l_Tail := f_Tail.Box;
  if evHasText(l_Tail) then
  begin
   if (BCP.Obj.AsObject.IsSame(ParaList.AsObject.Box)) AND
      l3IEQ(BCP.MostInner.ParentPoint, BCP) then
   begin
    try
     if (BCP.Text.Modify.JoinWith(f_View, l_Tail, Context) < 0) then
     { - �� ������� ���������� ������� � f_Tail -> �������� ��������}
      evInsertPara(Context, BCP, l_Tail, [ev_ipfAtEnd]);
    except
     on EevLimitReached do ;
     // - ������ �� ������
     // http://mdp.garant.ru/pages/viewpage.action?pageId=242843924
    end;//try..except
   end//BCP.Obj.IsSame(ParaList.Box)
   else
   begin
    l_ParaListCursor := ParaList.MakePoint;
    try
     l_ParaListCursor.SetEntryPoint(f_InsPara);
     evInsertPara(Context, l_ParaListCursor, l_Tail, [ev_ipfAtEnd]);
    finally
     l_ParaListCursor := nil;
    end;//try..finally
   end;//BCP.Obj.IsSame(ParaList)..
  end;//evHasText(l_Tail)
  if not l_Tail.Owner.IsValid then
   // - ���� �������� � ���, ��� ������ �������� �� ���������
   Context.Processor.NotifyDelete(ParaList.AsObject.Box,
                                  Tk2Type(ParaList.AsObject.TagType).ArrayProp[k2_tiChildren],
                                  l_Tail.AsObject, -1, Context);
 end;//f_Tail <> nil
 BCP.Refresh;
 { - ��������� ������. }

 FreeAndNil(f_Tail);
 { - ����������� ����� ���������. }
end;

procedure TevDocumentPartGenerator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 StartInsertion;
end;

procedure TevDocumentPartGenerator.CloseStream(NeedUndo: Bool);
  {override;}
  {-}
begin
 FinishInsertion;
 inherited;
 Context := nil;
 { - ����������� ��������. }
end;

{$EndIf evNeedEditableCursors}

end.

