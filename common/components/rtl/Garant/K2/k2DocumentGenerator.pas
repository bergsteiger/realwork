unit k2DocumentGenerator;
{* ������ ��� ���������� ���������� ��������� � ������. }

{ ���������� "�������"  }
{ �����: ����� �.�. �   }
{ ������: k2DocumentGenerator - }
{ �����: 18.05.98 15:19 }
{ $Id: k2DocumentGenerator.pas,v 1.78 2014/06/24 14:53:34 lulin Exp $ }

// $Log: k2DocumentGenerator.pas,v $
// Revision 1.78  2014/06/24 14:53:34  lulin
// - ������ ����������� ��������� � ��������� ������.
//
// Revision 1.77  2014/05/16 14:29:47  lulin
// - bug fix: ����� ���� TK288010443.
//
// Revision 1.76  2014/04/29 13:38:56  lulin
// - �������� �������� �����������.
//
// Revision 1.75  2014/04/11 16:08:44  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.74  2014/04/09 14:19:32  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.73  2014/04/08 17:13:26  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.72  2014/04/08 14:17:06  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.71  2014/04/03 17:10:38  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.70  2014/03/27 14:20:07  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.69  2014/03/27 11:11:21  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.68  2014/03/25 11:53:36  lulin
// - ��������� �� ����������� � ��������.
//
// Revision 1.67  2014/03/24 14:13:53  lulin
// - ������ ����.
//
// Revision 1.66  2014/03/24 13:30:25  lulin
// - ������������ ��������.
//
// Revision 1.65  2014/03/24 13:17:47  lulin
// - ��������� �������� ����, ��� ��� �� ��������� ������ � ������ �������.
//
// Revision 1.64  2014/03/24 09:06:14  lulin
// - ������������� ������ � ������.
//
// Revision 1.63  2014/03/21 17:15:17  lulin
// - ������������� ������ � ������.
//
// Revision 1.62  2014/03/20 12:24:03  lulin
// - ������������� ������ � ������.
//
// Revision 1.61  2014/02/28 14:54:26  lulin
// - ������������� ����������.
//
// Revision 1.60  2014/02/21 16:28:28  lulin
// - ����������� �� ������ ��� ������.
//
// Revision 1.59  2014/02/20 10:49:49  lulin
// - ��������� ������� �� ����.
//
// Revision 1.58  2014/02/14 15:33:47  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.57  2013/11/06 12:41:08  lulin
// - ��������� ���� ������ ���� �� ����� ����������� �������������� ��� ���������� � �����.
//
// Revision 1.56  2013/10/21 17:31:10  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.55  2013/10/21 15:43:13  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.54  2013/10/21 10:31:01  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.53  2013/10/18 14:11:32  lulin
// - ���������� ����������� �� ������������� ��������������� ����� �����.
//
// Revision 1.52  2013/04/04 11:21:37  lulin
// - ���������.
//
// Revision 1.51  2012/10/26 17:42:53  lulin
// - �������� ��������� ����� ���������.
//
// Revision 1.50  2011/06/17 14:09:14  lulin
// - ����� ���������� �����������.
//
// Revision 1.49  2011/05/27 13:35:27  lulin
// {RequestLink:267325065}.
//
// Revision 1.48  2011/05/06 14:28:14  lulin
// - ������ IfDef'�.
//
// Revision 1.47  2011/03/22 12:02:45  lulin
// {RequestLink:257822084}.
//
// Revision 1.46  2009/12/25 14:57:06  lulin
// - ��� ������ �� ����� ������.
//
// Revision 1.45  2009/12/23 19:13:25  lulin
// - ������ ���� ���������� �� �������.
//
// Revision 1.44  2009/09/07 10:17:49  voba
// - opt. ������ �������� ������������ �������� ������
//
// Revision 1.43  2009/08/11 11:07:11  lulin
// {RequestLink:159356349}.
//
// Revision 1.42  2009/08/07 09:26:41  lulin
// {RequestLink:159354029}.
//
// Revision 1.41  2009/08/03 10:50:05  lulin
// {RequestLink:159351322}.
//
// Revision 1.40  2009/07/24 14:47:56  lulin
// - ������� ������ ������� �����.
//
// Revision 1.39  2009/07/22 07:47:46  lulin
// - ������������ ������ �����.
//
// Revision 1.38  2009/07/17 12:42:02  lulin
// {RequestLink:141264340}. �7, 32, 33.
//
// Revision 1.37  2009/07/15 16:24:30  lulin
// - ������� ������ ��������.
//
// Revision 1.36  2009/07/08 12:18:49  lulin
// - ��������, �������������� ������������� ����� � ��������.
//
// Revision 1.35  2009/07/08 11:01:04  lulin
// [$155030482]. ��������. ���������� ������ ������� ���������.
//
// Revision 1.34  2009/07/03 16:24:13  lulin
// - ��� � �������� �� ����������� � ��������.
//
// Revision 1.33  2008/07/16 12:16:43  lulin
// - ������� ���� ExternalNextVerLink, InternalNextVerLink.
//
// Revision 1.32  2008/05/23 16:04:47  lulin
// - <K>: 91848978.
//
// Revision 1.31  2008/03/21 16:07:36  lulin
// - ������� �������� ������ ����������������.
//
// Revision 1.30  2008/03/21 14:09:29  lulin
// - cleanup.
//
// Revision 1.29  2008/02/14 17:09:12  lulin
// - cleanup.
//
// Revision 1.28  2008/02/05 18:20:40  lulin
// - ������� �������� �������� �����.
//
// Revision 1.27  2007/10/09 13:09:13  lulin
// - ��������� ���� ��������� �������� � ����� ���������� �����.
//
// Revision 1.26  2007/09/14 13:26:19  lulin
// - ��������� � ������ B_Tag_Clean.
//
// Revision 1.25.2.2  2007/09/12 16:36:20  lulin
// - ������������� ��������.
//
// Revision 1.25.2.1  2007/09/12 16:14:12  lulin
// - ����� �������� �������� ��-���������.
//
// Revision 1.25  2007/09/11 18:50:04  lulin
// - ������ �������� ��������.
//
// Revision 1.24  2007/09/11 12:32:06  lulin
// - ����� ����������� ����� � ����, �.�. ����� ������-�� ������ ��������.
//
// Revision 1.23  2007/09/07 08:27:33  lulin
// - ������ ����� ����� ������������� �������� � ���� ��������.
//
// Revision 1.22  2007/09/06 09:37:45  lulin
// - ������������� ��������.
//
// Revision 1.21  2007/09/05 17:24:13  lulin
// - ������� �������� - ��� ��� ��� �� �����.
//
// Revision 1.20  2007/09/04 17:06:08  lulin
// - _cleanup.
//
// Revision 1.19  2007/08/31 13:37:23  lulin
// - ��������� �������� ����.
//
// Revision 1.18  2007/08/30 15:39:14  lulin
// - bug fix: ������ �� �������� �������� � �� (CQ OIT5-26566).
//
// Revision 1.17  2007/08/30 12:19:07  lulin
// - _cleanup.
//
// Revision 1.16  2007/08/29 12:22:46  lulin
// - cleanup.
//
// Revision 1.15  2007/08/14 11:24:38  lulin
// - cleanup.
//
// Revision 1.14  2007/08/10 18:27:17  lulin
// - ����������� �� ��������� ������������� �����������, �.�. ������������� ����� ���� ���������� ������� ��������.
//
// Revision 1.13  2007/08/10 15:05:29  lulin
// - ����������� �� ��������� ������������� �����������, �.�. ������������� ����� ���� ���������� ������� ��������.
//
// Revision 1.12  2007/08/09 14:55:28  lulin
// - ����������� �� ��������� ������������� �����������.
//
// Revision 1.11  2007/08/09 11:19:27  lulin
// - cleanup.
//
// Revision 1.10  2006/11/25 16:50:32  lulin
// - ������� ������,������ ����� ����������� �����.
//
// Revision 1.9  2006/06/16 13:58:23  lulin
// - cleanup.
//
// Revision 1.8  2006/04/12 09:41:44  narry
// - ���������: �������������� �������� SaveFirstAtom � RewriteAtoms
//
// Revision 1.7  2006/04/11 17:55:28  lulin
// - ������������ ��� ������ ��������� ����� (�� ������ ���� ��� ����� ������� � �������� 20% ������������������).
//
// Revision 1.6  2005/12/14 11:47:30  lulin
// - cleanup.
//
// Revision 1.5  2005/10/24 07:38:21  lulin
// - bug fix: ���� ��� ��� Children ��� ��������, � ������� �� ���������� ���� - �������� � AV.
//
// Revision 1.4  2005/10/18 07:19:46  lulin
// - new behavior: ������ ������ ������� � ���������� �������� ����� ����� ��������� ����������� ����.
//
// Revision 1.3  2005/07/04 07:39:46  lulin
// - ������������� ������ � ������� ��������� ���������� � "����������" ����������.
//
// Revision 1.2  2005/06/22 17:53:06  lulin
// - ���� ������������� � ������������ � ��������� ����������.
//
// Revision 1.1  2005/06/22 17:34:12  lulin
// - ��������� ��������� � ������ ��������� � "����������" ����������.
//
// Revision 1.112.4.5  2005/06/22 17:14:51  lulin
// - cleanup.
//
// Revision 1.112.4.4  2005/06/22 17:05:17  lulin
// - new unit: evHighLevelDocumentGenerator.
//
// Revision 1.112.4.3  2005/06/22 16:48:33  lulin
// - new unit: evCustomDocumentFilter.
//
// Revision 1.112.4.2  2005/06/22 16:42:24  lulin
// - bug fix: �� ������ ���� � ���� ���� ���������������� ��������.
//
// Revision 1.112.4.1  2005/05/18 12:42:46  lulin
// - ����� ����� �����.
//
// Revision 1.103.2.5  2005/05/18 12:32:08  lulin
// - ��������� ��� ��������� ����� � HEAD.
//
// Revision 1.103.2.4  2005/04/28 09:18:28  lulin
// - ��������� � ������ B_Tag_Box.
//
// Revision 1.103.2.3  2005/04/18 16:43:24  lulin
// - ���������� Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.103.2.2  2005/04/10 12:27:56  lulin
// - bug fix: ��� ���������� ��������� _evFormatOnDraw �� ������������ ��������� � ����������, ������� ���� �� ������ ������.
//
// Revision 1.103.2.1  2005/04/10 12:22:56  lulin
// - ������ ������ �����.
//
// Revision 1.110.2.14  2005/04/27 13:48:06  lulin
// - bug fix: �� ������ �� ����� ������� � ������ �����.
//
// Revision 1.110.2.13  2005/04/25 16:39:57  lulin
// - cleanup.
//
// Revision 1.110.2.12  2005/04/25 15:39:27  lulin
// - �� ���� ��������, ���� ��� ��� �� �����.
//
// Revision 1.110.2.11  2005/04/25 14:24:41  lulin
// - �������� ������ ��� Assert.
//
// Revision 1.110.2.10  2005/04/25 14:04:57  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.110.2.9  2005/04/23 16:33:04  lulin
// - ������ �������� �����.
//
// Revision 1.110.2.8  2005/04/23 16:23:00  lulin
// - remove prop: _Ik2Tag.AttrWP.
//
// Revision 1.110.2.7  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.110.2.6  2005/04/23 12:44:08  lulin
// - cleanup.
//
// Revision 1.110.2.5  2005/04/23 10:37:58  lulin
// - ��������� �� ������������� �������������� �����.
//
// Revision 1.110.2.4  2005/04/23 09:42:47  lulin
// - ��������� ���������� ��������� ��������� ������ �����������.
//
// Revision 1.110.2.3  2005/04/22 15:23:20  lulin
// - ������ ����������������� ���������� � ���������� � ������.
//
// Revision 1.110.2.2  2005/04/21 15:36:39  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.110.2.1  2005/04/21 14:46:54  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.110  2005/04/21 05:11:38  lulin
// - ���������� Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.109  2005/04/20 15:25:28  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.108  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.107  2005/04/20 13:17:54  lulin
// - ���������������� ������ ��� ����������� �� ��������������� ����� ����� � ����.
//
// Revision 1.106  2005/04/18 17:18:22  lulin
// - ���������� Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.105  2005/04/18 10:23:42  lulin
// - ������� "��-��������" ���, � �� ����������� Null.
//
// Revision 1.104  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.103.2.2  2005/04/10 12:27:56  lulin
// - bug fix: ��� ���������� ��������� _evFormatOnDraw �� ������������ ��������� � ����������, ������� ���� �� ������ ������.
//
// Revision 1.103.2.1  2005/04/10 12:22:56  lulin
// - ������ ������ �����.
//
// Revision 1.112  2005/04/28 15:03:37  lulin
// - ��������� ����� B_Tag_Box � HEAD.
//
// Revision 1.111  2005/04/26 09:55:49  lulin
// - ������� ��������� �� ����� - �.�. �� �������������� ����������.
//
// Revision 1.110.2.14  2005/04/27 13:48:06  lulin
// - bug fix: �� ������ �� ����� ������� � ������ �����.
//
// Revision 1.110.2.13  2005/04/25 16:39:57  lulin
// - cleanup.
//
// Revision 1.110.2.12  2005/04/25 15:39:27  lulin
// - �� ���� ��������, ���� ��� ��� �� �����.
//
// Revision 1.110.2.11  2005/04/25 14:24:41  lulin
// - �������� ������ ��� Assert.
//
// Revision 1.110.2.10  2005/04/25 14:04:57  lulin
// - bug fix: �� �������������� ����������.
//
// Revision 1.110.2.9  2005/04/23 16:33:04  lulin
// - ������ �������� �����.
//
// Revision 1.110.2.8  2005/04/23 16:23:00  lulin
// - remove prop: _Ik2Tag.AttrWP.
//
// Revision 1.110.2.7  2005/04/23 16:07:24  lulin
// - ������ ��������� ��������� Ik2TagBox.
//
// Revision 1.110.2.6  2005/04/23 12:44:08  lulin
// - cleanup.
//
// Revision 1.110.2.5  2005/04/23 10:37:58  lulin
// - ��������� �� ������������� �������������� �����.
//
// Revision 1.110.2.4  2005/04/23 09:42:47  lulin
// - ��������� ���������� ��������� ��������� ������ �����������.
//
// Revision 1.110.2.3  2005/04/22 15:23:20  lulin
// - ������ ����������������� ���������� � ���������� � ������.
//
// Revision 1.110.2.2  2005/04/21 15:36:39  lulin
// - ������������ ��������� �� ������������� �������.
//
// Revision 1.110.2.1  2005/04/21 14:46:54  lulin
// - ����������� �� ������� ��� ������ - ������ ������� ����������� �������� ���� ��������� ��������� _Ik2Tag.
//
// Revision 1.110  2005/04/21 05:11:38  lulin
// - ���������� Box (���� ��-�� ���������� �������������� ���� � ������� - �� �������� ����� ������ ����).
//
// Revision 1.109  2005/04/20 15:25:28  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.108  2005/04/20 14:19:44  lulin
// - ������� ������ ��������� � ����.
//
// Revision 1.107  2005/04/20 13:17:54  lulin
// - ���������������� ������ ��� ����������� �� ��������������� ����� ����� � ����.
//
// Revision 1.106  2005/04/18 17:18:22  lulin
// - ���������� Box, � �� _Ik2Tag (���� �������� � ������������������ �� ����).
//
// Revision 1.105  2005/04/18 10:23:42  lulin
// - ������� "��-��������" ���, � �� ����������� Null.
//
// Revision 1.104  2005/04/15 08:59:52  lulin
// - ������ ������ ������ �� ���, � �� ���������� ���.
//
// Revision 1.103.2.2  2005/04/10 12:27:56  lulin
// - bug fix: ��� ���������� ��������� _evFormatOnDraw �� ������������ ��������� � ����������, ������� ���� �� ������ ������.
//
// Revision 1.103.2.1  2005/04/10 12:22:56  lulin
// - ������ ������ �����.
//
// Revision 1.103  2005/03/29 15:04:35  lulin
// - ������� ����� ��������� ����������.
//
// Revision 1.102  2005/03/28 17:45:14  lulin
// - ��������� �� ��������� ��� ������������ ���������� ���������� ����� ����.
//
// Revision 1.101  2005/03/23 15:29:17  lulin
// - �������� �� ��������� ������ ���� �������� ���������� ���, � �� �����-�� ���������.
//
// Revision 1.100  2005/03/23 12:42:23  lulin
// - ������ ������ ������ ��������� �� ��������.
//
// Revision 1.99  2005/03/23 11:23:16  lulin
// - bug fix: �� ���������������.
//
// Revision 1.98  2005/03/23 11:16:29  lulin
// - ������� �������� ����������.
//
// Revision 1.97  2005/03/23 08:46:32  lulin
// - ������ ��� ��������� ������� ���������� �� _Ik2Tag.
//
// Revision 1.96  2005/03/22 15:45:27  lulin
// - ������ �������� ������.
//
// Revision 1.95  2005/03/21 10:04:49  lulin
// - new interface: _Ik2Type.
//
// Revision 1.94  2005/03/17 15:58:32  lulin
// - ����� ������ ��������/������� ��������� ����� ����������, � �� ������ Boolean'��.
//
// Revision 1.93  2005/03/16 19:21:53  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.92  2005/03/16 17:55:25  lulin
// - new prop: _TevStackAtom._Inst.
//
// Revision 1.91  2005/03/16 10:20:24  lulin
// - ��������� � _Ik2Tag.
//
// Revision 1.90  2005/03/15 15:30:02  lulin
// - cleanup.
//
// Revision 1.89  2005/03/09 18:40:19  lulin
// - remove method: Tk2AtomR._DeleteChild.
// - new method: _Ik2Tag._DeleteChild.
//
// Revision 1.88  2005/03/09 11:59:43  lulin
// - ������� ��������� ���������� ��� �������� ������� ������� ����� �����������.
//
// Revision 1.87  2005/03/04 15:49:02  lulin
// - �������� ��������� Tk2Type.New.
//
// Revision 1.86  2005/03/04 13:59:17  lulin
// - remove method: Tk2AtomR._AddChild.
//
// Revision 1.85  2005/01/25 11:33:47  lulin
// - bug fix: ��� ������� ������������ �� ������ ������ ��� �� ����������� � ��������� ���������.
//
// Revision 1.84  2005/01/20 12:16:11  lulin
// - new prop: IeeSub.InContents.
//
// Revision 1.83  2004/11/09 17:06:24  lulin
// - ��������� �� ������� � �����������.
//
// Revision 1.82  2004/11/09 13:37:56  lulin
// - ��������� �� ������� � �����������.
//
// Revision 1.81  2004/11/04 14:40:35  lulin
// - bug fix: �� ������ � AV ���� ����� �� ��� ��������� ������, � �������� �� ���� ������������.
//
// Revision 1.80  2004/10/08 14:57:57  lulin
// - new behavior: ���������� �� ���������� ������������� ����� (��� F1).
//
// Revision 1.79  2004/09/30 13:57:46  lulin
// - bug fix: �� �������������� ����� AllEverestComponents.
//
// Revision 1.78  2004/09/30 12:09:03  lulin
// - bug fix: �� ��������� ContentsLevel ��� ��������� ������.
//
// Revision 1.77  2004/09/29 13:19:57  lulin
// - bug fix: ����������� ��������� ���������� ��� ������� Contents � ����� (�� ���������).
//
// Revision 1.76  2004/09/21 12:55:40  lulin
// - Release ������� �� Cleanup.
//
// Revision 1.75  2004/09/20 16:53:08  lulin
// - bug fix: �� ������ ��������� ������������� ����������.
//
// Revision 1.74  2004/09/20 14:22:26  lulin
// - ��� �������� �� ��������� ����������, ��������� ����� � ������ ContentLevel (����� �������� �� ��������� � 2.5 ��� �� 2.0 ���).
//
// Revision 1.73  2004/09/20 12:42:49  lulin
// - ����������� - ����� ����������� ����� �������� � ���, ����� �������� �� (�� ������ ����������) ��������� � 3.5 ��� �� 2.6 ���.
//
// Revision 1.72  2004/07/29 14:27:48  law
// - �������� �������� define evCanReleaseBitmapStream - �.�. ������ � ��� �� �������� �������/����� � ����� ������.
//
// Revision 1.71  2004/07/29 05:46:47  law
// - �������� �������� aLimitWidth.
//
// Revision 1.70  2004/07/15 16:47:48  law
// - ������ StartWaiting/StopWaiting ���������� �� TextSource.
//
// Revision 1.69  2004/07/15 16:29:08  law
// - �������� �������� ����������� ����� ��������� � ���������� �� TextSource.
// - � ����� �� ��������� ��������� �������� ����������� ����� ���������.
//
// Revision 1.68  2004/07/15 15:28:09  law
// - change: ������ �������� TevDocumentGenerator.WaitingForSub ��������� ���� ������� StartWaiting/StopWaiting.
//
// Revision 1.67  2004/07/15 09:38:36  law
// - new behavior: ��������� ��� �������� ������ ����� �������� � �������� (��� �������� �� �������������� ������������).
//
// Revision 1.66  2004/07/15 08:54:33  law
// - change: ���������������� � ���������� ���������� �� ���������� �� ��������� ������������.
//
// Revision 1.65  2004/07/01 13:24:57  law
// - new behavior: ��������� ���������� ����������� �������� �� �����/��������.
// - bug fix: ��������� ������� ���������� � �������������� ����������.
//
// Revision 1.64  2004/06/01 09:40:53  law
// - change: _Tl3ObjectRefList ������ �� ������ ��� ���������.
//
// Revision 1.63  2004/05/31 11:01:56  law
// - new method: Ik2PropertyBag.SetMaskEx.
//
// Revision 1.62  2004/05/18 17:16:43  law
// - cleanup.
//
// Revision 1.61  2004/04/12 13:29:30  law
// - new: �������� ��� ���������� "��������� ������", �� �������� ShortName ������ �������������� �� �������, � �������� �����.
//
// Revision 1.60  2004/03/24 16:49:57  law
// - new behavior: ������� ����������� ����� ��������� � ������������� ������ �����.
// - new behavior: ������ ActiveIntervals � ��������� ��������� ����� ���������.
//
// Revision 1.59  2004/03/16 17:27:39  law
// - new behavior: ������ ���� ���������� ������-��������� ��������� � ���������� ���� ��������.
//
// Revision 1.58  2004/03/16 15:20:47  law
// - new unit: evDocumentBuffer.
//
// Revision 1.57  2004/01/15 18:16:21  law
// - new method: TevDocumentBuffer._RootChanged.
//
// Revision 1.56  2004/01/12 16:20:03  nikitin75
// + _default value: TevDocumentBuffer.Create(anOwner: Tk2TagGeneratorOwner = nil);
//
// Revision 1.55  2003/12/04 13:14:14  law
// - bug fix: �� ����������������� �� Sub, ����� �� ���������� ��� Layer'� (CQ OIT5-5406).
//
// Revision 1.54  2003/11/10 17:24:18  law
// - cleanup: "��������" ��������� �������� ����������� �������� �� �����.
//
// Revision 1.53  2003/11/10 16:16:06  law
// - cleanup.
//
// Revision 1.52  2003/11/10 15:42:10  law
// - new behavior: ������� �������� ������������� "����������" �����.
//
// Revision 1.51  2003/10/22 16:47:27  law
// - bug fix:
// demon (16.10.2003): ���� ��.
// 1. ��������� �������� - ����� �� �� 18 ������� 1991 �. N 1759-I
// "� �������� ������ � ���������� ���������"
// 2. � ������ "���������������" ������� - ����������� ����� �� 22 ������� 1995 �. N 151-�� "�� ��������-������������ ������� � ������� ����������" (� ���. � ���. �� 5, 7 �������, 7 ������ 2000 �.)
// 3. ��� ������ ����� �� 302 ��������, �� ��� �������� �������� ��������������� �� ������.
//
// Revision 1.50  2003/09/09 13:49:35  demon
// - bug fix: ��� �������� ��������� �� ������� ������� �� ��������.
//
// Revision 1.49  2003/09/08 13:08:23  law
// - new const: ev_sbtPara.
//
// Revision 1.48  2003/07/21 13:21:56  law
// - bug fix: � _Nemesis'� ��� �������� ��������� �� ���������� �� ������ �� Sub.
//
// Revision 1.47  2003/03/17 16:17:25  law
// - bug fix: new directive evNotNeedAddMask.
//
// Revision 1.46  2002/11/01 17:51:01  law
// - bug fix: ����� Redo ������� ����� �� ������ ���� ������� � �������� ������.
//
// Revision 1.45  2002/09/18 07:33:21  law
// - cleanup.
//
// Revision 1.44  2002/09/18 07:08:02  law
// - new units: k2StackGenerator, _k2Ver.
// - new behavior: Tk2CustomReader ������ ����������� �� Tk2CustomStackGenerator � �������������� ��������� ��� ���������.
//
// Revision 1.43  2002/09/18 06:03:32  law
// - cleanup: ������ �������� IsDefault.
//
// Revision 1.42  2002/08/29 08:07:12  voba
// -bug fix: ������� �� ���� �������������� �� �������
//
// Revision 1.41  2002/03/26 16:31:56  law
// - cleanup.
//
// Revision 1.40  2002/02/08 16:16:39  law
// - cleanup: ����� ���, �������������� ����� ������ ������� � ������������� ��������.
//
// Revision 1.39  2002/01/29 16:18:49  law
// - bug fix: Range Check Error ��� ����������� ������� �����.
//
// Revision 1.38  2001/10/25 16:32:13  law
// - new behavior: �������� ������ ��������� ��� ��������� ������ Sub'�� ��� ������� �� ������.
//
// Revision 1.37  2001/07/24 12:30:24  law
// - comments: xHelpGen.
//
// Revision 1.36  2001/05/31 09:23:40  law
// - cleanup: ������ ������ �� ������ ������� ����� �����.
//
// Revision 1.35  2001/05/30 09:11:18  law
// - new behavior: �������� �������������� ��������� ������ ������ ����������.
//
// Revision 1.34  2001/05/04 13:22:12  law
// - cleanup: �������� ������ TevDocumentFiler - �� _TevBaseParaList � Ik2TagWrap, � ����� ��������� �� �������� � �������.
//
// Revision 1.33  2001/04/18 13:25:23  law
// - comments: ��������� ����������� ��� xHelpGen.
//
// Revision 1.32  2001/03/27 11:04:57  law
// - �������� ������ ��� ����� ���������� � ���������.
//
// Revision 1.31  2001/03/14 13:24:54  law
// - some cleaup and tuning.
//
// Revision 1.30  2001/03/13 13:20:38  law
// - some tuning & comments.
//
// Revision 1.29  2001/01/31 10:37:29  law
// - �������������� ������������� QueryInterface.
//
// Revision 1.28  2001/01/26 13:26:13  law
// - bug fix: ����������� Capacity ������ > Count.
//
// Revision 1.27  2000/12/19 15:52:40  law
// - ������ �������� ��������� ����������.
//
// Revision 1.26  2000/12/18 15:58:34  narry
// - ��������� ������� _VariantAsInteger.
//
// Revision 1.25  2000/12/15 15:10:35  law
// - ��������� ��������� Log.
//

{$Include evDefine.inc }

interface

uses
  TypInfo,

  l3IID,
  l3Types,
  l3Base,
  l3CacheableBase,
  l3Variant,
  
  k2Types,
  k2Interfaces,
  k2Base,
  k2TagGen,
  k2StackGenerator
  ;

type
  TevStackAtomFlag = (ev_safChild, ev_safTop, ev_safBottom, ev_safWasAdded, ev_safWasFrame);
  TevStackAtomFlagSet = set of TevStackAtomFlag;

  PevStackAtom = ^Tk2StackAtom;
  Tk2StackAtom = object
    private
    // internal fields
      f_Flags  : TevStackAtomFlagSet;
      f_Type   : Tk2Type;
      f_Inst   : Tl3Variant;
    public
    // public fields
      TagID    : Long;
    protected
    // internal methods
      procedure pm_SetBox(aValue: Tl3Variant);
        {-}
      procedure IncludeFlag(aFlag: TevStackAtomFlag);
        {-}
    public
    // public methods
      procedure Init(aType  : Tk2Type;
                     anAtom : Tl3Variant;
                     aFlags : TevStackAtomFlagSet;
                     aTagID : Long);
        {-}
(*      {$IfDef Nemesis}
      procedure SetFlags(aFlags: TevStackAtomFlagSet);
        {-}
      {$EndIf Nemesis}*)  
      procedure ExcludeFlag(aFlag: TevStackAtomFlag);
        {-}
      function  IsChild : Bool;
        {-}
      function  WasAdded: Bool;
        {-}
      function  IsKindOf(ID: Tk2TypePrim): Boolean;
        overload;
        {* - ��������� ������������ ������� ���� �� ���� � ��������������� ID. }
      function  IsKindOf(const anIDs : array of Tl3VariantDef): Bool;
        overload;
        {* - ��������� ������������. }
      function  IsKindOf(anAtomTypeID  : Tk2TypePrim;
                             const Exclude : array of Tl3VariantDef): Bool;
        overload;
        {* - ��������� ������������. }
      function  Parent: PevStackAtom;
        {-}
      function WasFrame: Boolean;
        {-}
    public
    // public properties
      property Box: Tl3Variant
        read f_Inst
        write pm_SetBox;
        {* - ��� �� ������� ��������� ������ ����. }
      property TagType   : Tk2Type
        read f_Type;
        {-}
  end;//Tk2StackAtom
  TevAtoms = array [0..100] of Tk2StackAtom;
  TevAtomsCount = Low(TevAtoms) .. Succ(High(TevAtoms));

  TevAtomStack = class(Tl3CacheableBase)
    private
    // private fields
      f_Atoms : TevAtoms;
      f_Count : TevAtomsCount;
    protected
    // internal methods
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      function  Push(aType    : Tk2Type;
                     anAtom   : Tl3Variant;
                     _IsChild : Bool;
                     aTagID   : Long): PevStackAtom;
        {-}
      procedure Drop;
        {-}
      function  Top: PevStackAtom;
        {-}
      function  Empty: Bool;
        {-}
    public
    // public properties
      property Count: TevAtomsCount
        read f_Count;
        {-}
  end;//TevAtomStack

  Tk2DocumentGenerator = class;
  
  TevAtomEvent = function(G        : Tk2DocumentGenerator;
                          var Atom : Tk2StackAtom): Bool of object;
   {* - ������� ��� ����������� ��������� ��������� ���������� ����. }
  TevAddAtomEvent = procedure(G          : Tk2TagGenerator;
                              const Atom : Tk2StackAtom;
                              Prop       : Integer;
                              aSource    : Tl3Variant) of object;
   {* - ������� ��� ����������� ���������� �����. }

  Tk2DocumentGenerator = class(Tk2BaseStackGenerator)
   {* ��������� ������ ��������� � ����������� ������. }
    protected
    // property fields
      f_Tags          : TevAtomStack;
    private
    // property fields
      f_RewriteAtoms : Bool;
      f_Target       : Ik2GeneratorTarget;
    private
    // event fields
      f_OnStartAtom       : TevAtomEvent;
      f_BeforeFinishAtom  : TevAtomEvent;
      f_OnFinishAtom      : TevAtomEvent;
      f_OnAddAtom         : TevAddAtomEvent;
    protected
    // property methods
      function  pm_GetTopObject(Index: Long): Tk2Base;
        override;
        {-}
    protected
    // internal methods
      procedure DoStartAtom(var Atom: Tk2StackAtom);
        virtual;
        {-}
      procedure DoFinishAtom(var anAtom: Tk2StackAtom);
        virtual;
        {-}
      function  DoBeforeFinishAtom(var Atom: Tk2StackAtom): Bool;
        virtual;
        {-}
      procedure DoAddAtom(const Atom : Tk2StackAtom;
                          Prop       : Integer;
                          aSource    : Tl3Variant);
        virtual;
        {-}                  
      function AddChild(var aChild: Tk2StackAtom): Long;
        virtual;
        {-}
      function DeleteChild(const aChild: Tk2StackAtom): Bool;
        virtual;
        {-}
      procedure OpenStream;
        override;
        {-}
      procedure CloseStream(NeedUndo: Bool);
        override;
        {-���������� ���� ��� � ����� ���������}
      procedure CloseStructure(NeedUndo: Bool);
        override;
        {-���������� �� ������������� ������}
      function  NeedPreAddChild(const aChild: Tk2StackAtom): Bool;
        virtual;
        {-}
      {procedure ChildWasPreAdded(const aChild: _Ik2Tag);
        virtual;}
        {-}
      procedure Cleanup;
        override;
        {-}
    public
    // public methods
      constructor Create(anOwner: Tk2TagGeneratorOwner = nil);
        override;
        {-}
      procedure StartChild(TypeID: Tl3VariantDef);
        override;
        {-}
      procedure PushChild(aType  : Tk2Type;
                          aChild : Tl3Variant);
        {-}
      procedure StartTag(TagID: Long);
        override;
        {-}
      procedure AddAtomToDocument(AtomIndex: Long; aSource: Tl3Variant);
        {-}
      procedure AddAtom(AtomIndex: Long; aSource: Tl3Variant);
        override;
        {-}
    protected
    // protected properties
      property Tags: TevAtomStack
        read f_Tags;
    public
    // public properties
      property Target: Ik2GeneratorTarget
        read f_Target
        write f_Target;
        {-}
      property RewriteAtoms: Bool
       read f_RewriteAtoms
       write f_RewriteAtoms;
        {-}
    public
    // public events
      property OnStartAtom: TevAtomEvent
        read f_OnStartAtom
        write f_OnStartAtom;
        {* - ����������� �� �������� ���������� ����. }
      property BeforeFinishAtom: TevAtomEvent
        read f_BeforeFinishAtom
        write f_BeforeFinishAtom;
        {* - ����������� ����� ��������� ���������� ����. }
      property OnFinishAtom: TevAtomEvent
        read f_OnFinishAtom
        write f_OnFinishAtom;
        {* - ����������� � �������� ���������� ����. }
      property OnAddAtom: TevAddAtomEvent
        read f_OnAddAtom
        write f_OnAddAtom;
        {* - ����������� � ���������� �����. }
  end;//Tk2DocumentGenerator

implementation

uses
  SysUtils,
  Classes,

  l3MinMax,
  l3InterfacesMisc,

  k2Const,
  k2Except,
  k2Tags,
  k2Strings,
  k2TagList,
  k2Attributes
  ;

// start class Tk2DocumentGenerator

constructor Tk2DocumentGenerator.Create(anOwner: Tk2TagGeneratorOwner = nil);
  //override;
  {-}
begin
 inherited;
 f_RewriteAtoms := True;
end;

procedure Tk2DocumentGenerator.Cleanup;
  //override;
  {-}
begin
 inherited;
 FreeAndNil(f_Tags);
 f_Target := nil;
end;

function Tk2DocumentGenerator.pm_GetTopObject(Index: Long): Tk2Base;
  {override;}
  {-}
var
 A: PevStackAtom;
begin
 with f_Tags do
 begin
  if (f_Count > Index) then
   A := @f_Atoms[f_Count - 1 - Index]
  else
   A := nil;
  if (A = nil) then
   Result := nil
  else
  begin
   if A.IsChild then
    Result := A.TagType
   else
    Result := A.Parent.TagType.Prop[A.TagID]; 
  end;
 end;//with f_Atoms
end;

procedure Tk2DocumentGenerator.OpenStream;
  {override;}
  {-}
begin
 inherited;
 f_Tags := TevAtomStack.Create;
end;

function Tk2DocumentGenerator.AddChild(var aChild: Tk2StackAtom): Long;
  {virtual;}
  {-}
var
 l_Parent : PevStackAtom;
begin
 l_Parent := aChild.Parent;
 if (l_Parent = nil) then
  Result := -1
 else
 begin
  try
   Result := l_Parent.Box.AddChild(aChild.f_Inst, Context);
   if (Result >= 0) then
    aChild.Box := l_Parent.Box.Child[Result];
(*   if (Result >= 0) then
    Assert(l_Parent.Box.Child[Result].IsSame(aChild.f_Inst));*)
  except
   {$If Defined(Nemesis) AND (not Defined(nsTest) OR Defined(InsiderTest))}
   on Ek2CannotAddChild do
    Result := -1;
   {$Else  Nemesis}
   raise;
   {$IfEnd}
  end;//try..except
  aChild.IncludeFlag(ev_safWasAdded);
 end;//Parent = nil
end;

function Tk2DocumentGenerator.DeleteChild(const aChild: Tk2StackAtom): Bool;
  //virtual;
  {-}
var
 l_Parent : PevStackAtom;
 l_Index  : Long;
begin
 l_Parent := aChild.Parent;
 if (l_Parent = nil) then
  Result := false
 else
 begin
  l_Index := l_Parent.Box.IndexOfChild(aChild.Box);
  if (l_Index < 0) then
   Result := false
  else
  begin
   aChild.ExcludeFlag(ev_safWasAdded);
   l_Parent.Box.DeleteChild(l_Index, Context);
   Result := true;
  end;//l_Index < 0
 end;//l_Parent = nil
end;

procedure Tk2DocumentGenerator.CloseStream(NeedUndo: Bool);
  {override;}
  {-���������� ���� ��� � ����� ���������}
begin
 l3Free(f_Tags);
 inherited;
end;

(*procedure Tk2DocumentGenerator.ChildWasPreAdded(const aChild: _Ik2Tag);
  //virtual;
  {-}
begin
end;*)

procedure Tk2DocumentGenerator.CloseStructure(NeedUndo: Bool);
  {override;}
  {-���������� �� ������������� ������}
var
 l_Child : PevStackAtom;
 l_NeedFinish : Boolean;
begin
 if (f_Tags <> nil) then
 begin
  try
   if NeedUndo then
   begin
    //l_Child := f_Tags.Top;
    //DoBeforeFinishAtom(l_Child^);
    if (Generator <> nil) then
     Generator.Finish(NeedUndo);
    { DoRollbackAtom }
   end//NeedUndo
   else
   begin
    l_Child := f_Tags.Top;
    if DoBeforeFinishAtom(l_Child^) then
    begin
     l_NeedFinish := true;
     if l_Child.IsChild then
     begin
      if l_Child.WasAdded then
      begin
       //ChildWasPreAdded(l_Child.Box)
      end 
      else
       AddChild(l_Child^);
     end;//l_Child.IsChild
    end//DoBeforeFinishAtom(l_Child)
    else
    begin
     l_NeedFinish := false;
     if l_Child.IsChild then
     begin
      if l_Child.WasAdded then
       DeleteChild(l_Child^);
     end//l_Child.IsChild
     else
     if (l_Child.Parent <> nil) then
      l_Child.Parent.Box.AttrW[l_Child.TagID, nil] := nil;
    end;//DoBeforeFinishAtom(l_Child)
    if l_NeedFinish then
    begin
     DoFinishAtom(l_Child^);
     if (l_Child.TagID = k2_tiFrame) then
      if not l_Child.Box.HasSubAtom(k2_tiHandle) then
      begin
       if l_Child.Box.HasSubAtom(k2_tiFrameUp) AND
          l_Child.Box.HasSubAtom(k2_tiFrameDown) AND
          l_Child.Box.HasSubAtom(k2_tiFrameLeft) AND
          l_Child.Box.HasSubAtom(k2_tiFrameRight) AND
          not l_Child.Box.HasSubAtom(k2_tiForeColor) then
        l_Child.Parent.Box.IntA[k2_tiFrame] := 1111
       else
       if not l_Child.Box.HasSubAtom(k2_tiFrameUp) AND
          not l_Child.Box.HasSubAtom(k2_tiFrameDown) AND
          not l_Child.Box.HasSubAtom(k2_tiFrameLeft) AND
          not l_Child.Box.HasSubAtom(k2_tiFrameRight) AND
          not l_Child.Box.HasSubAtom(k2_tiForeColor) then
       l_Child.Parent.Box.IntA[k2_tiFrame] := 0;
      end;//not l_Child.Box.HasSubAtom(k2_tiHandle)
    end;//l_NeedFinish
   end;//NeedUndo
  finally
   f_Tags.Drop;
  end;//try..finally
 end;//f_Tags <> nil
 inherited;
end;

procedure Tk2DocumentGenerator.DoStartAtom(var Atom: Tk2StackAtom);
  {virtual;}
  {-}
begin
 if Assigned(f_OnStartAtom) then f_OnStartAtom(Self, Atom);
end;

procedure Tk2DocumentGenerator.DoFinishAtom(var anAtom: Tk2StackAtom);
  {virtual;}
  {-}
begin
 if Assigned(f_OnFinishAtom) then f_OnFinishAtom(Self, anAtom);
end;

function Tk2DocumentGenerator.DoBeforeFinishAtom(var Atom: Tk2StackAtom): Bool;
  {virtual;}
  {-}
begin
 if not Atom.IsChild AND
    ((Atom.TagID = k2_tiSegments) OR (Atom.TagID = k2_tiSubs)) then
 begin
  if (Atom.Box.ChildrenCount = 0) then
  begin
   Result := false;
   Exit;
  end;//Atom.Box.ChildrenCount = 0
 end;//not Atom.IsChild
 Result := true;
 if Assigned(f_BeforeFinishAtom) then
  Result := f_BeforeFinishAtom(Self, Atom);
end;

procedure Tk2DocumentGenerator.StartChild(TypeID: Tl3VariantDef);
  {override;}
  {-}
  
 procedure RaiseDocumentHeaderMissing;
 begin//RaiseDocumentHeaderMissing
  raise Exception.Create(k2_errDocumentHeaderMissing)
 end;//RaiseDocumentHeaderMissing

var
// A     : _Ik2Tag;
 l_Top : PevStackAtom;
 l_T   : Tk2Type;
begin
 inherited;
 if (f_Tags = nil) then
  RaiseDocumentHeaderMissing;
(* A := TypeTable[TypeID].MakeTag;
 try*)
(*  with A.TagType do
   if HasProperty[k2_tiChildren] then
    A.CheckSort(ArrayProp[k2_tiChildren]);*)
  { TODO -o����� �.�. -c��������� : �������� ����������������. }
  l_T := Tk2Type(TypeID);
  l_Top := f_Tags.Push(l_T, l_T.MakeTag.AsObject, true, -1);
  DoStartAtom(l_Top^);
  if NeedPreAddChild(l_Top^) then
   AddChild(l_Top^);
(* finally
  A := nil;
 end;//try..finally*)
end;

function Tk2DocumentGenerator.NeedPreAddChild(const aChild: Tk2StackAtom): Bool;
  {-}
begin
 Result := false; 
end;

procedure Tk2DocumentGenerator.PushChild(aType  : Tk2Type;
                                         aChild : Tl3Variant);
  {-}
begin
 Inc(f_Starts);
 DoStartAtom(f_Tags.Push(aType, aChild, true, -1)^);
end;

procedure Tk2DocumentGenerator.StartTag(TagID: Long);
  {override;}
  {-}
var
 l_Prop : Tk2CustomPropertyPrim;
 l_P : Tk2Base;
begin
 Assert(CurrentType <> nil);
 l_P := FindProperty(TagID);
 if (l_P = nil) then
  l_Prop := nil
 else
  l_Prop := l_P.AsProp;
 Assert(l_Prop <> nil,
        Format('�� ������� �������� "%s"(�%d) � ���� %s ��� ��������� ��������� ������� %s',
        [Tk2Attributes.Instance.NameByID(TagID),
         //GetEnumName(TypeInfo(_Tk2TagID), TagID),
         TagID,
         CurrentType.AsString, ClassName]));
 inherited;
 DoStartAtom(f_Tags.Push(Tk2Type(l_Prop.AtomType),
                         f_Tags.Top.Box.cAtom(l_Prop.TagIndex, Context),
                         false, TagID)^);
end;

procedure Tk2DocumentGenerator.DoAddAtom(const Atom : Tk2StackAtom;
                                         Prop       : Integer;
                                         aSource    : Tl3Variant);
  //virtual;
  {-}
begin
 if Assigned(f_OnAddAtom) then
  f_OnAddAtom(Self, Atom, Prop, aSource);
end;

procedure Tk2DocumentGenerator.AddAtomToDocument(AtomIndex: Long; aSource: Tl3Variant);
  {-}
var
 l_Atom : PevStackAtom;
 l_Prop : Tk2Prop;
begin
 inherited AddAtom(AtomIndex, aSource);
 // - ������� ������ ������ �����, ��� ������ � ���������� ������ (!!!)
 if (AtomIndex >= 0) then
 begin
  l_Atom := f_Tags.Top;
  if (AtomIndex = k2_tiChildren) then
  begin
   l_Atom.Box.cAtom(k2_tiChildren, Context).ChildrenCapacity := aSource.AsLong;
  end//AtomIndex = k2_tiChildren
  else
   try
    if (AtomIndex = k2_tiFrame) AND
       (aSource.AsLong = 0) AND
       f_Tags.Top.WasFrame then
     Exit;  
    if RewriteAtoms OR f_Tags.Top.Box.rOwnAtom(AtomIndex).IsNull then
    begin
     try
      {$IfDef Nemesis}
      {$If not Defined(nsTest) OR Defined(InsiderTest)}
      if (AtomIndex <> Ord(_k2_tiExternalNextVerLink)) then
      // - ������� ��� �� ����������� �������
      {$IfEnd}
      {$EndIf Nemesis}
       f_Tags.Top.Box.AttrW[AtomIndex, Context] := aSource;
     except
      on Ek2ReadOnlyProperty do Exit;
     end;//try..except
     DoAddAtom(l_Atom^, AtomIndex, aSource);
    end;//RewriteAtoms..
   except
    on Ek2ConversionError do ;
   end;{try..except}
 end;//AtomIndex >= 0
end;

procedure Tk2DocumentGenerator.AddAtom(AtomIndex: Long; aSource: Tl3Variant);
  {override;}
  {-}
begin
 AddAtomToDocument(AtomIndex, aSource);
end;

// start class TevAtomStack

procedure TevAtomStack.Cleanup;
  //override;
  {-}
var
 l_Index : Integer;  
begin
 for l_Index := Low(f_Atoms) to High(f_Atoms) do
  f_Atoms[l_Index].Box := nil;
 Finalize(f_Atoms);
 f_Count := 0;
 inherited;
end;

function TevAtomStack.Push(aType    : Tk2Type;
                           anAtom   : Tl3Variant;
                           _IsChild : Bool;
                           aTagID   : Long): PevStackAtom;
  {-}
begin
 Assert(anAtom.IsValid);
 Assert(f_Count <= High(f_Atoms));
 Result := @f_Atoms[f_Count];
 Result.Init(aType, anAtom, [ev_safBottom], aTagID);
 if _IsChild then Include(Result.f_Flags, ev_safChild);
 if Empty then
  Include(Result.f_Flags, ev_safTop)
 else
  Exclude(f_Atoms[Pred(f_Count)].f_Flags, ev_safBottom);
 Inc(f_Count);
 if (aTagID = k2_tiFrame) then
  Include(Result.Parent.f_Flags, ev_safWasFrame);
end;

procedure TevAtomStack.Drop;
  {-}
begin
 Dec(f_Count);
 f_Atoms[f_Count].Box := nil;
 if (f_Count > 0) then
  Include(f_Atoms[Pred(f_Count)].f_Flags, ev_safBottom);
end;

function  TevAtomStack.Top: PevStackAtom;
  {-}
begin
 Assert(not Empty);
 Result := @f_Atoms[Pred(f_Count)];
end;

function  TevAtomStack.Empty: Bool;
  {-}
begin
 Result := (f_Count <= 0);
end;

// start object Tk2StackAtom 

procedure Tk2StackAtom.Init(aType  : Tk2Type;
                            anAtom : Tl3Variant;
                            aFlags : TevStackAtomFlagSet;
                            aTagID : Long);
  {-}
begin
 f_Type := aType;
 f_Inst := anAtom.Use;
 f_Flags := aFlags;
 TagID := aTagID;
end;

(*{$IfDef Nemesis}
procedure Tk2StackAtom.SetFlags(aFlags: TevStackAtomFlagSet);
  {-}
begin
 f_Flags := aFlags;
end;
{$EndIf Nemesis}*)

procedure Tk2StackAtom.pm_SetBox(aValue: Tl3Variant);
  {-}
begin
 aValue.SetRef(f_Inst);
end;

procedure Tk2StackAtom.IncludeFlag(aFlag: TevStackAtomFlag);
  {-}
begin
 Include(f_Flags, aFlag);
end;

procedure Tk2StackAtom.ExcludeFlag(aFlag: TevStackAtomFlag);
  {-}
begin
 Exclude(f_Flags, aFlag);
end;

function Tk2StackAtom.IsChild : Bool;
  {-}
begin
 Result := ev_safChild In f_Flags;
end;

function Tk2StackAtom.WasAdded: Bool;
  {-}
begin
 Result := ev_safWasAdded In f_Flags;
end;

function Tk2StackAtom.IsKindOf(ID: Tk2TypePrim): Boolean;
  //overload;
  {* - ��������� ������������ ������� ���� �� ���� � ��������������� ID. }
begin
 Result := f_Inst.IsKindOf(ID);
end;

function Tk2StackAtom.IsKindOf(const anIDs : array of Tl3VariantDef): Bool;
  //overload;
  {* - ��������� ������������. }
begin
 Result := f_Inst.IsKindOf(anIDs);
end;

function Tk2StackAtom.IsKindOf(anAtomTypeID  : Tk2TypePrim;
                                   const Exclude : array of Tl3VariantDef): Bool;
  //overload;
  {* - ��������� ������������. }
begin
 Result := f_Inst.IsKindOf(anAtomTypeID, Exclude);
end;

function Tk2StackAtom.Parent: PevStackAtom;
  {-}
begin
 if ev_safTop in f_Flags then
  Result := nil
 else
  Result := PevStackAtom(PAnsiChar(@Self) - SizeOf(Tk2StackAtom));
end;

function Tk2StackAtom.WasFrame: Boolean;
  {-}
begin
 Result := (ev_safWasFrame in f_Flags);
end;

end.

