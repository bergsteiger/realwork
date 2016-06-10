unit alcuConfig;

{ ������ ��� �������� �������� ��������� }

{ $Id: alcuConfig.pas,v 1.46 2016/06/03 09:28:30 fireton Exp $ }

// $Log: alcuConfig.pas,v $
// Revision 1.46  2016/06/03 09:28:30  fireton
// - �������� ������ ���������� � ��������
//
// Revision 1.45  2016/06/02 15:28:03  fireton
// - ������������� � �������� ������� ��������
//
// Revision 1.44  2016/05/27 08:27:40  fireton
// - ������������� ������ � ������
//
// Revision 1.43  2016/04/15 11:54:29  lukyanets
// ������ ��������� ���
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.42  2016/03/29 13:10:37  lukyanets
// Cleanup
//
// Revision 1.41  2016/03/16 09:15:34  lukyanets
// �������� �������� ���������� �� ���������
//
// Revision 1.40  2016/03/16 08:59:08  lukyanets
// �������� �������� ���������� �� ���������
//
// Revision 1.39  2016/02/17 12:57:53  lukyanets
// Cleanup
//
// Revision 1.38  2016/02/10 10:58:37  fireton
// - ����� "�������� ������ ������������" � ������������ ������ ����� �������
//
// Revision 1.37  2016/02/10 08:38:55  lukyanets
// ��������� ������� �����
//
// Revision 1.36  2016/01/21 10:47:18  lukyanets
// �� ��������� �������� ����������.
//
// Revision 1.35  2015/10/12 11:01:58  lukyanets
// ������ ������������ ��� ������� �� ������
//
// Revision 1.34  2015/10/09 13:01:52  lukyanets
// ����� � ��� �� ����� ����� ����������� ������
//
// Revision 1.33  2015/10/05 11:45:32  lukyanets
// ����������� ��������
//
// Revision 1.32  2015/09/11 10:41:56  lukyanets
// ����������� ���������
//
// Revision 1.31  2015/09/09 13:26:27  lukyanets
// ��������� ������� ����������
//
// Revision 1.30  2015/09/08 09:14:52  lukyanets
// ��������� ������� ����������
//
// Revision 1.29  2015/09/07 14:21:34  lukyanets
// ������������� ���
//
// Revision 1.28  2015/09/03 14:09:08  lukyanets
// ��������� ������������� �������� - ����� ����� ����
//
// Revision 1.27  2015/07/02 11:40:59  lukyanets
// ��������� �������
//
// Revision 1.26  2015/07/02 07:34:39  lukyanets
// ��������� �������
//
// Revision 1.25  2015/05/28 11:13:40  fireton
// - ��������� �������� ExpandEditions
//
// Revision 1.24  2015/05/08 07:52:49  lukyanets
// Cleanup
//
// Revision 1.23  2015/03/27 09:21:01  lukyanets
// ������� ��������� ������� �� ������ ��� HT
//
// Revision 1.22  2015/03/17 12:06:34  lukyanets
// ��������� ������ �� ������ ����
//
// Revision 1.21  2015/02/20 10:36:26  fireton
// - �������� ������� ��������� � ��. ������ � ��������� �������
//
// Revision 1.20  2015/02/16 13:48:22  lukyanets
// ������������ ����� ��� ��������� � ��������.
//
// Revision 1.19  2014/12/23 08:42:46  fireton
// - ��������� ������� ����������� ���� �� ���� ������
//
// Revision 1.18  2014/10/21 10:54:04  lukyanets
// ��������� ��������� "��� ����" �������
//
// Revision 1.17  2014/10/14 10:01:36  lukyanets
// �����/������ ��� ���������
//
// Revision 1.16  2014/10/14 08:17:12  lukyanets
// �����/������ ��� ���������
//
// Revision 1.15  2014/10/13 10:31:48  lukyanets
// ������� ������������� ���������
//
// Revision 1.14  2014/09/26 07:24:50  lukyanets
// {RequestLink:565502566}
//
// Revision 1.13  2014/09/23 08:01:15  lukyanets
// {RequestLink:565487518} - ��������� SSL
//
// Revision 1.12  2014/09/15 12:36:19  lukyanets
// �������� ���� �������� -1
//
// Revision 1.11  2014/09/11 12:45:39  lukyanets
// � ������� ����� ���� ����� ������� *�����* ���������
//
// Revision 1.10  2014/09/08 07:29:29  lukyanets
// ����������� ������� � ���� �������� ����� �������
//
// Revision 1.9  2014/09/05 12:38:57  lukyanets
// ������ RegionImportTask
//
// Revision 1.8  2014/09/04 07:44:58  lukyanets
// ������ ������������ ������ � ��������� �������
//
// Revision 1.7  2014/09/01 13:46:44  lukyanets
// �� ��������� ��������� ����������� ���������
//
// Revision 1.6  2014/08/25 12:02:09  lukyanets
// ������� ������� ��� ���
//
// Revision 1.5  2014/08/13 11:12:10  fireton
// - ������������ �������� ������������� �� (� 561547565)
//
// Revision 1.4  2014/08/07 14:02:20  lukyanets
// {Requestlink:556143119}. �������� ����� ��� ���������� ���������� ����� �����
//
// Revision 1.3  2014/08/04 09:33:42  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - MisspellCorrect
//
// Revision 1.2  2014/08/04 06:39:00  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - ddDossierMaker
//
// Revision 1.1  2014/07/28 15:18:17  lukyanets
// {Requestlink:557844282}. ���������� ���������� ProjectDefine.inc
//
// Revision 1.125  2014/07/28 11:45:23  lukyanets
// {Requestlink:557844282}. ������������ ��������� ddAppConfig
//
// Revision 1.124  2014/07/16 15:35:48  lulin
// - �������� ��������.
//
// Revision 1.123  2014/07/07 10:07:48  lukyanets
// {Requestlink:552022662}. ��� ������� �������������
//
// Revision 1.122  2014/02/10 07:54:05  GarikNet
// K:516189258
//
// Revision 1.121  2013/11/07 06:58:40  fireton
// - ������� ���������� � ������� ��������������� ������
//
// Revision 1.120  2013/09/12 06:51:34  kostitsin
// [$476838236] - ddAppConfigVersions
//
// Revision 1.119  2013/09/05 09:27:32  kostitsin
// [$476838236] - �������� c ddAppConfigTypes
//
// Revision 1.118  2013/09/05 09:22:59  kostitsin
// [$476838236] - �������� c ddAppConfigTypes
//
// Revision 1.117  2013/08/28 05:15:03  fireton
// - �� ����������
//
// Revision 1.116  2013/04/16 13:06:40  narry
// ����������
//
// Revision 1.115  2013/04/09 07:35:27  narry
// �������������� ������� �������������� (447390002)
//
// Revision 1.114  2013/04/08 07:04:59  narry
// �������������� ������� �������������� (447390002)
//
// Revision 1.113  2013/04/05 12:41:51  narry
// �������������� ������� �������������� (447390002)
//
// Revision 1.112  2013/04/04 11:22:27  narry
// ���������� ���� ������������� (447388742)
//
// Revision 1.111  2013/03/26 11:42:28  narry
// �� �������� Hang-��������� ��� ������ �� ����  (443842617)
//
// Revision 1.110  2013/02/12 11:35:46  narry
// ����������� ����������� ����������� � ���������� ��������� ��������
//
// Revision 1.109  2013/01/28 11:41:26  narry
// ��������� �����������  (425270949)
//
// Revision 1.108  2013/01/23 10:41:19  fireton
// - ������� �����������
//
// Revision 1.107  2013/01/11 12:14:40  narry
// * �������������� �������� ����������� �������� ���������� (��)
// * �������������� ���������� �� �� FTP
// * ������ �������� ����
//
// Revision 1.106  2012/12/06 06:24:00  narry
// ��������
//
// Revision 1.105  2012/10/18 07:37:18  narry
// ����������
//
// Revision 1.104  2012/10/02 07:38:44  narry
// ��������� ��������� ���������� � ����
//
// Revision 1.103  2012/09/07 13:36:43  narry
// ������� ��� ����������
//
// Revision 1.102  2012/08/02 13:18:15  narry
// ����������� ������� �� ���������� ���������� (380619133)
//
// Revision 1.101  2012/07/13 11:29:10  narry
// ����������� �������� �� ����
//
// Revision 1.100  2012/07/10 11:03:38  narry
// ��������� ������ run2 (375424291)
//
// Revision 1.99  2012/06/14 11:45:37  narry
// ����������� ������ ������ ���-������
//
// Revision 1.98  2012/06/14 11:00:35  narry
// ��� �������� ������ �������� ��������� ��������
//
// Revision 1.97  2012/05/24 04:43:14  narry
// ����������
//
// Revision 1.96  2012/04/19 09:28:49  narry
// ����������� ������� ������� (356073078)
//
// Revision 1.95  2012/04/17 13:23:15  narry
// ����������� ������� ������� (356073078)
//
// Revision 1.94  2012/04/16 10:00:43  narry
// ����������� ������ � ������� l3FileUtils.CopyFile
//
// Revision 1.93  2012/03/06 12:11:10  narry
// �� ����������
//
// Revision 1.92  2012/01/30 09:09:00  narry
// - ����������� ��������������
//
// Revision 1.91  2011/11/23 12:47:10  fireton
// - ������ ������ �� ��������� �������� ���������� ������� �� MDP
//
// Revision 1.90  2011/11/16 10:17:36  narry
// ���������� ������� �� � � ������ ������������� (298682480)
//
// Revision 1.89  2011/11/02 08:09:09  narry
// ��������� ����� �� ����� ���������� � �����
//
// Revision 1.88  2011/11/02 06:11:43  narry
// ����������� ������ ���-����� ��� 5000 �����
//
// Revision 1.87  2011/11/01 05:22:02  narry
// ��� ����������� ����� � ����� (147489953)
//
// Revision 1.86  2011/10/14 05:34:01  narry
// �� ����������
//
// Revision 1.85  2011/09/15 07:20:10  narry
// - ���������� �� �������� ����������
//
// Revision 1.84  2011/09/13 12:26:53  narry
// ����������� ����� � ���������� ��� (283613768)
//
// Revision 1.83  2011/08/09 09:28:01  narry
// ������� ���������� � ������� ������ ���� (266422146)
//
// Revision 1.82  2011/07/06 13:22:06  narry
// ������� ����� ���������� ����� (273583007)
//
// Revision 1.81  2011/07/04 06:00:55  narry
// �������������� ������� ������� ��� �������� �����
//
// Revision 1.80  2011/06/20 13:07:46  narry
// ���������� ��� ��������
//
// Revision 1.79  2011/06/20 11:17:31  narry
// ���������� ��� ��������
//
// Revision 1.78  2011/06/20 07:26:47  narry
// �� �������� ����������� ����� 20005 � 30005 (269080331)
//
// Revision 1.77  2011/06/14 07:36:15  narry
// ����������� ����������� ���������� (268338975)
//
// Revision 1.76  2011/06/02 13:21:05  narry
// ���������� ���������� ����� ����������������� � ����� (266406580)
//
// Revision 1.75  2011/05/12 05:21:21  narry
// �������� ���������� � ������� (������) (260447428)
//
// Revision 1.74  2011/05/05 13:19:19  narry
// ���������� ���� ������� �������� (265408970)
//
// Revision 1.73  2011/04/22 11:44:09  narry
// ������� �� ������ (262636470)
//
// Revision 1.72  2011/03/23 11:56:56  narry
// K254352041. ������� �������� rtf ��� doc � �������� �������� � ���� ������
//
// Revision 1.71  2011/03/16 10:41:55  narry
// K255979048. �������������� ����� �������� ����������
//
// Revision 1.70  2011/01/19 08:19:09  narry
// �������������� ���������
//
// Revision 1.69  2010/11/01 11:39:05  narry
// �238947202. �������� ������ "�������������� ���������" �� "��� ���������"
//
// Revision 1.68  2010/09/24 12:41:07  voba
// - k : 235046326
//
// Revision 1.67  2010/09/24 04:48:30  narry
// k235056975. ���������� ��-�� ��������� ������������� ������
//
// Revision 1.66  2010/08/18 11:29:07  narry
// - �� ���������� � ����� � ��������������� dt_Srch2
//
// Revision 1.65  2010/07/20 12:28:39  narry
// �226003904
//
// Revision 1.64  2010/07/19 09:53:01  narry
// �227477456. ���������������� ������ �������, �� ��������� ����� ����� ���������
//
// Revision 1.63  2010/04/20 09:36:34  narry
// - ��������� ������� ����� � ������� �������
//
// Revision 1.62  2010/04/02 12:11:26  narry
// - ��������� �� ������� ���������� �������
//
// Revision 1.61  2010/03/19 14:01:58  narry
// - ����� ��������, �������� �������� ��������� �������
// - ��������� ������� � ������������ � ������������
//
// Revision 1.60  2010/03/16 14:14:07  narry
// - ������� �������� �� ������
// - ������������� ������ ����� ���������� ��������
// - ���������� ���������� ��������� �������
//
// Revision 1.59  2010/03/04 07:47:16  narry
// - ���������� ������ �������������
// - ���� ���� ��� �������� ��������� � �������� ����
//
// Revision 1.58  2010/02/27 12:22:59  narry
// - ���������� ����� ���������
//
// Revision 1.57  2010/02/25 06:38:10  narry
// - �������� ����������� �������� �� �����
// - ���������� ��������� ������� ������� �� ����� ������������� ����������
//
// Revision 1.56  2009/11/10 08:20:06  narry
// - ����������
// - ������� ������������ ��������� � �����
//
// Revision 1.55  2009/05/27 12:29:20  narry
// - ����������
//
// Revision 1.54  2009/03/17 09:27:20  narry
// - �������� ���� ������������ ��� 800�600
//
// Revision 1.53  2009/02/20 13:27:50  narry
// - ��������� ���������� ��������
//
// Revision 1.52  2009/01/26 07:39:35  narry
// - ����������� ��������������� ���� ������
//
// Revision 1.51  2009/01/23 16:21:19  narry
// - ��������� � ������� ������
// - ������ ��������
//
// Revision 1.50  2008/11/24 15:05:23  narry
// - ����������
//
// Revision 1.49  2008/10/13 12:38:41  narry
// - ������������� ����������
//
// Revision 1.48  2008/08/20 14:42:20  narry
// - ����������
//
// Revision 1.47  2008/07/24 15:16:29  narry
// - ��������� �������� ������������
//
// Revision 1.46  2008/07/22 11:13:35  narry
// - ��������� �������� ������������
//
// Revision 1.45  2008/07/16 16:14:04  narry
// - ���������� �����������
//
// Revision 1.44  2008/06/24 07:41:55  narry
// - ���������� ����������������� � �������������� ���������
//
// Revision 1.43  2008/06/23 12:26:03  narry
// - ��������
//
// Revision 1.42  2008/06/10 14:15:27  narry
// - ������ � �� ���������� � ����������� ��
// - ����������� ������ ������� - ������ "��������" � ��������, ������ ����� �����������
//
// Revision 1.41  2008/05/16 13:30:53  narry
// - ����������
//
// Revision 1.40  2008/05/14 11:23:36  narry
// - ���������� ������ ���������� � ��� ���� ��� ��������
// - ����������� ������������
// - ��������� ������
//
// Revision 1.39  2008/04/23 10:43:15  narry
// - ����������
//
// Revision 1.38  2008/03/24 09:37:43  narry
// - ����������� ���������
//
// Revision 1.37  2008/03/13 13:57:56  narry
// - ���������� ������� ������ ��������� ����������
// - ��������� �������� ���
// - �������������� ������� ���������
//
// Revision 1.36  2008/03/04 11:34:04  narry
// - ���������� ����������� �������� ��������� ��� �����
//
// Revision 1.35  2008/02/27 15:55:22  narry
// - ����������� ��������� ���� ����� ��������
// - ������� ����������
// - ���� deleted.lst
// - ����� � ���
// - ������� ����������
// - ������
//
// Revision 1.34  2008/02/19 15:52:19  narry
// - ������� �������� �� garant\base.ini � ������������
//
// Revision 1.33  2008/02/06 09:27:11  narry
// - �� ���������������
// - ����� �������� � ������������ (���� ������ ��)
//
// Revision 1.32  2008/01/23 08:09:44  narry
// - ��������� �������� �����������������
//
// Revision 1.31  2008/01/17 13:01:02  narry
// - ������ �����������
//
// Revision 1.30  2007/12/25 12:04:20  narry
// - ���������� ��������� ������� ��������� �������� ����������
// - �������������� ������������� ����������
//
// Revision 1.29  2007/12/06 11:10:29  narry
// - ��������� �����������������
//
// Revision 1.28  2007/12/06 09:38:32  narry
// - ��������� �����������������
//
// Revision 1.27  2007/11/28 11:30:09  narry
// - ���������� ���� "� ���������"
// - �������������� ��������� ���� ������������
//
// Revision 1.26  2007/11/12 09:11:10  narry
// - ����������: ������ ����, ������ "� ���������",  ��������� ������� ��������, ����������� "����� 20005", "���������� ����"
//
// Revision 1.25  2007/09/11 12:22:39  narry
// - ����������� ����� 30005 � 20005. ����������
//
// Revision 1.24  2007/09/06 06:21:12  narry
// - ����������� ������ �������� ������� ������� ������������ (��������)
// - ����������� ����� 30005 � 20005
// - �������� ��������� ��������
//
// Revision 1.23  2007/07/25 10:44:19  narry
// - ��������� ������ � ��������
//
// Revision 1.22  2007/07/24 12:33:33  narry
// - ����������� ������� ���������
//
// Revision 1.21  2007/07/04 09:28:37  narry
// - ����������
//
// Revision 1.20  2007/03/27 12:21:12  narry
// - ����������
//
// Revision 1.19  2006/09/12 11:41:23  narry
// - ���������� ������ �������� ���
// - ���������� ������ ����� ��������
//
// Revision 1.18  2006/06/05 15:05:33  narry
// - �����: ������� �� ����� �������� �������� �����������
//
// Revision 1.17  2006/03/07 12:28:08  narry
// - ���������: ����� ���������� �������� �������
//
// Revision 1.16  2005/11/02 16:39:27  narry
// - ����������� � ���������
//
// Revision 1.15  2005/10/06 16:06:36  narry
// - ����������: ��������� ������ ����������� ���������� ���� ������
//
// Revision 1.14  2005/09/27 06:30:11  narry
// - ����������
//
// Revision 1.13  2005/09/14 12:54:00  narry
// - ������ ����
// - �����: ������������ ������� ��������
// - �����: ����� ������ �������� ���
//
// Revision 1.12  2005/09/09 12:36:26  narry
// - update: ����� ������� ���������� ��������� ����������� ����������� � ������������ �������
//
// Revision 1.11  2005/09/07 15:51:58  narry
// - new: ���������� ��������� ������
//
// Revision 1.10  2005/09/07 14:17:01  narry
// - New: ������ �������� ���������� ���� ������� ����������
//
// Revision 1.9  2005/07/22 06:23:56  narry
// - update
//
// Revision 1.8  2005/04/20 11:48:46  narry
// - update: ���������� �������, ������ ����������� ����������� � ���� �� UNC-����� � ���-�� ���
//
// Revision 1.7  2005/03/14 12:15:42  narry
// - update: ��������� �� ���� �� �����������
//
// Revision 1.6  2005/02/08 17:12:49  narry
// - update & cleanup
//
// Revision 1.5  2004/09/08 05:38:30  narry
// - update
//
// Revision 1.4  2004/08/25 12:50:22  narry
// - update: ���������� ��������� UpdateText - ���������� ��������� �����
//
// Revision 1.3  2004/07/01 15:39:31  narry
// - update
//
// Revision 1.2  2004/05/19 07:03:49  narry
// - update: ����������� � �������� ������
//
// Revision 1.1.2.1  2004/05/19 06:53:40  narry
// - prerelease
//
// Revision 1.1  2004/05/07 12:55:24  narry
// - first upload
//

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface
Uses
 ddAppConfig, ddConfigStorages, ddAppConfigDataAdapters;

function CreateConfigEx(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil): TddAppConfiguration;
procedure DestroyConfig;

procedure CreateConfig(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil);

implementation

Uses
 SysUtils, Classes, Controls, Forms,
 l3Base, l3String,
 ddUtils,
 alcuHelpConst,
 alcuConfigTypes,
 alcuTypes,
 daTypes,
 daDataProviderSuperFactory,
 dt_Const, dt_Types, dt_AttrSchema,
 DateUtils,
 ddAppConfigLists, ddAppConfigConst, ddAppConfigStrings, ddAppConfigTypes,
 ddScheduler, l3Bits, alcuMailServer, ddAppConfigDates, ddIniStorage,
 alcuUtils, Math, idStack;

var
 mailAdapter: TalcuEmailAdapter;

procedure ConvertFAS(aStorage: IddConfigStorage; const aPrefix, aIndex, aCaption: String);
var
 i: Integer;
 l_Count: Integer;
 l_Enabled: Boolean;
 l_Source: Integer;
 l_Exclude: String;
 l_List: TStrings;
begin
 l_List:= TStringList.Create;
 try
  with aStorage do
  begin
   //������� ���������, ������� �������� �� ����� ������ � ������� � ���������-���������� ���������
   Section:= aPrefix+'Court';
   l_Enabled:= ReadBool(aPrefix+'_Enabled', False);
   l_Source:= ReadInteger(aPrefix+'Court_Source', -1);
   l_Exclude:= l3Str(ReadString(aPrefix+'COurt_Exclude', ''));
   l_Count:= ReadInteger(aPrefix+'Court_BeforeCount', 0);
   for i:= 0 to Pred(l_Count) do
    l_List.Add(l3Str(ReadString(aPrefix+'Court_Before'+IntToStr(i), '')));

   Section:= 'CourtListI'+aIndex;
   WriteString('Caption', aCaption);
   WriteBool('Court_Work', l_Enabled);
   WriteInteger('Court_Source', l_Source);
   WriteInteger('Court_BeforeCount', l_List.Count);
   for i:= 0 to Pred(l_List.Count) do
    WriteString('Court_Before'+IntToStr(i), l_List.Strings[i]);
   WriteString('Court_Exclude', l_Exclude);
  end; // with aStorage;
 finally
  l3Free(l_List);
 end;
end;

procedure Upgrade1To2(const aStorage: IddConfigStorage);
var
 i, l_Count: Integer;
 l_ID: Integer;
 l_DateTime: TDateTime;
 l_DayOW: TddSchedulerDayOfWeek;
 l_Section: string;
 l_IsTime: Boolean;
 l_IsDate: Boolean;
 l_NumStr: string;
 l_TempTaskType: Integer;
 l_WrongDays: Integer;
 l_Caption: String;
 l_Day: Integer;
 l_Periodicity: integer;
begin
 // ���������� �������� ����� ��������
 with aStorage do
 begin
  Section:= 'Scheduler';
  l_Count:= ReadInteger('Count', 0); // ���������� �����
  for i:= 0 to Pred(l_Count) do
  begin
   // ������ ������ ����������
   Section:= 'Scheduler';
   l_NumStr := IntToStr(i);
   l_TempTaskType := ReadInteger(l_NumStr+'.ID', -1);
   if l_TempTaskType < 0 then
    raise Exception.CreateFmt('������������ ������� �%d', [i]);
   l_Caption:= l3Str(ReadString(l_NumStr+'.Caption', ''));
   l_DateTime:= ReadDateTime(l_NumStr+'.DateTime', 0);
   l_Day:= ReadInteger(l_NumStr+'.Day', 0);
   l_Periodicity:= ReadInteger(l_NumStr+'.TaskType', -1);
   l_WrongDays := 0;
   for l_DayOW := Low(TddSchedulerDayOfWeek) to High(TddSchedulerDayOfWeek) do
    if ReadBool(l_NumStr+'.'+ IntToStr(Ord(l_DayOW)), False) then
     l3SetBit(l_WrongDays, Pred(Ord(l_DayOW)));
   // ���������� �����
   Section:= 'SchedulerTask'+IntToStr(i);
   WriteString('Caption', l_Caption);
   WriteInteger('Type', l_TempTaskType);
   WriteDateTime('Time', TimeOf(l_DateTime));
   WriteInteger('Pereodicity', l_Periodicity);

   case TddSchedulerTaskPeriodicity(l_Periodicity) of
    stOnce:
     WriteDateTime('Date', DateOf(l_DateTime));
    stEveryDay:
     WriteInteger('WrongDays', l_WrongDays);
    stEveryWeek:
     WriteInteger('WeekDay', Pred(l_Day));
    stEveryMonth:
     WriteInteger('MonthDay', DayOf(l_DateTime));
    stEveryYear:
     begin
      WriteInteger('YearDay', DayOf(l_DateTime));
      WriteInteger('YearMOnth', MonthOf(l_DateTime));
     end;
   end; // case
  end; // for i
 end; // with aStorage
 // ����� � �����
 aStorage.Section:= 'CourtDecisions';
 aStorage.WriteInteger('CourtList.Count', 3);
 ConvertFAS(aStorage, 'RF', '0', '������ ����������� ��� ��');
 ConvertFAS(aStorage, 'MO', '1', '����������� ����������� ��� ����������� ������');
 ConvertFAS(aStorage, 'WS', '2', '����������� ����������� ��� �������-���������� ������');
end;

procedure Upgrade2To3(const aStorage: IddConfigStorage);
var
 l_AccGroups: String;
 l_FullAccGroups: String;
 l_Bases: String;
begin
 with aStorage do
 begin
  // ������
  Section:= 'AutoIncluded';
  l_AccGroups:= l3Str(ReadString('aiAccGroups', ''));
  l_FullAccGroups:= l3Str(ReadString('aiFullAccGroups', ''));
  l_Bases:= l3Str(ReadString('aiBases', ''));
  // �����
  Section:= 'aiDocuments';
  WriteString('aiAccGroups', l_AccGroups);
  WriteString('aiFullAccGroups', l_FullAccGroups);
  Section:= 'aiAnnotation';
  WriteString('aiBases', l_Bases);
 end; // aStorage
end;

procedure Upgrade3To4(const aStorage: IddConfigStorage);
var
 l_FullAccGroups: String;
 l_FileSize: String;
begin
 with aStorage do
 begin
  // ������
  Section:= 'aiDocuments';
  l_FileSize:= l3Str(ReadString('AutoIncludedSize', ''));
  l_FullAccGroups:= l3Str(ReadString('aiFullAccGroups', ''));
  // �����
  Section:= 'AutoIncluded';
  WriteString('AutoIncudedSize', l_FileSize);
  Section:= 'aiFullGroups';
  WriteString('aiFullAccGroups', l_FullAccGroups);
 end; // aStorage
end;

procedure Upgrade4To5(const aStorage: IddConfigStorage);
var
 l_FreeLimit: Int64;
 l_BaseSize: Int64;
 l_Delta: Int64;
begin
 with aStorage do
 begin
  Section:= 'Archi';
  l_FreeLimit:= ReadInteger('FreeSpaceLimit', 10000)* ddUtils.dd_KiloByte; // � ����������
  Section:= 'General';
  l_BaseSize:= GetFolderSize(l3Str(ReadString('UNCBasePath', '')));
  l_Delta:= l_FreeLimit div l_BaseSize;
  if l_Delta < 1 then
   l_Delta:= 1
  else
   l_Delta:= Max(3, l_delta);
  Section:= 'Archi';
  WriteInteger('FreeSpaceLimit', l_Delta);
 end;
end;

procedure Upgrade5To6(const aStorage: IddConfigStorage);
begin
 with aStorage do
 begin
  Section:= 'General';
  WriteString('ServerName', l3Str(ReadString('ServerIP', '')));
  WriteString('ServerIP', '');
 end;
end;

procedure AddMDPSyncChild(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
begin
 {$IFNDEF LUK}
 with aConfig do
 begin
  AddChild('mdpSync', 'C������������ � ������');
   AddGroupItem('mdpDocSync', '������ ���������� �� �������');
    AddStringItem('mdpMail', '���������� �����������');
    AddStringItem('mdpErrorMail', '���������� ������ ������');
    AddIntegerItem(l3CStr('mdpMaxCount'), l3CStr('�������� ���������� �� ���� ���'), 70);
    AddItem(TalcuUserListComboItem.Make('mdpImportUser', '������������ ��� �������'));
     Hint := '������������ �� ����� ����� ����� ������������� ���������';
   CloseGroup;
   AddGroupItem('mdpDictSync', 'C������������ ��������, ������ � ������� ������� � ������');
    LabelTop:= False;
    AddStringItem('dsURL', 'URL �������������','http://gardoc.garant.ru/plugins/servlet/gar-rest/ogv-synonyms');
    l_Item := AddBooleanItem(l3CStr('dsUseProxy'), l3CStr('������������ ������'));
    //Enabled := False;
     AddStringItem('dsProxyServer', '������ ������','',l_Item);
     AddIntegerItem(l3CStr('dsProxyPort'), l3CStr('���� ������'), 8080, l_Item);
      MinValue:= 1;
      MaxValue:= 65000;
     AddStringItem('dsProxyLogin', '�����', '', l_Item);
     AddStringItem('dsProxyPassword', '������', '', l_Item);
     PasswordChar:= '*';
    AddFolderNameItem('dsSyncFolder', '����� ��� �������� ������', CorrectArchiveWarehousePath('', 'MDPSync'), nil, False);
     Hint := '� ���� ����� �������� ��������� ����� ��� �������� � ������';
     PathFill:= dd_ftFull;
   CloseGroup;
 end; // with
 {$ENDIF}
end;

procedure AddUserTasksChild(aConfig: TddAppConfiguration);
var
 l_Item: TalcuDictionaryTreeItem;
begin
 with aConfig do
 begin
  AddChild('UserTasks', '������� �������������');
   HelpContext:= hcZadaniya_polzovatelej;
   LabelTop:= False;

   AddIntegerItem(l3CStr('WorkThreadCount'), l3CStr('���������� ����������� �������'), 0);
    Hint:= '���������� ������������� ����������� �������.'#13#10' 0 - ����������� ��������� ���������,'#13#10' -1 - ���������� ��������� ����������';
    MinValue := -1;
    MaxValue := 9999;

   AddItem(TalcuAsyncRunTaskItem.Make('AsyncRunTaskType', '���� ����������� �������', 6));
    Hint:= '���� ������� ������� ����� ��������� ����������.';

   AddFileNameItem('MessagesFileName', '���� � ����������� �������������', 'usersMessages.dat');
    Hint:= '� ���� ���� ����� ����������� ���������, ������������ ��������������';

   AddFolderNameItem('RootTaskFolder', '����� ��� �������� ���������� �������', 'TaskRoot', nil, False);
    Hint := '� ���� ����� �������� ���������� ������� �� �� ���������';
    PathFill:= dd_ftFull;

   AddIntegerItem(l3CStr('MaxExportAge'), l3CStr('������� ����������� �������|����'), 7);
    Hint := '������� ���� ����� ��������� ���������� ��������, ������������ ������������';
    MinValue := 3;
    MaxValue := 30;
   //AddItem(TalcuDictComboTreeItem.Make('utRegionID', '������ ������� "�������� � �������"', da_dlAccGroups, False));
   l_Item:= TalcuDictionaryTreeItem.Make('utRegionID', '������ ������� "�������� � �������"', da_dlAccGroups, True);
   AddItem(l_Item);
    Hint:= '���� �� ���� ����� ������� ����� ������������� ����������, "���������� �� ��������� � �������"';
   AddDivider('������');
    AddFolderNameItem('SafeDirName', '����� � ���������������� �������', '', nil, False);
     Hint:= '� ��� ����� ����� ������������ �����, ������������ �������������� �� ������';
    AddIntegerItem(l3CStr('MaxImportAge'), l3CStr('������� ����������� ������|����'), 7);
     Hint := '������� ���� ����� ��������� ����� �������, ������������ ��������������';
     MinValue := 3;
     MaxValue := 30;
    AddFolderNameItem('BadImportDir', '����� � ������������� ���������', '', nil, False);
     Hint:= '� ��� ����� ����� ������������ �����, ������������ �������������� �� ������ � ��������� ����';
   AddDivider('����������');
    AddStringItem('asNotify', '����������� � �������� ����������');
     Hint:= '�� ��������� ������ ����� ��������� ����� � ��������� �������';
    AddFileNameItem('MisspellsFile', '������� ������� ��������'); // ����� �� ������������
     Filter:= '��������� ����� (*.txt)|*.txt';
     Hint:= '��������� ����, ���������� ������ ������� ��������. ������������ ��� ����������� ��������';
  CloseChild;
 end;
end;

procedure AddAutoAnnoChild(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddChild('AutoAnno', '������� ��������� � ���������� ������');
   LabelTop:= False;
   AddDateItem('aaStartDate', '���������, ���������� �');
    Hint:= '����� �������������� ���������, ���������� � ��������� ���� �� ���� ������� ������������';
   AddFolderNameItem('aaFolder', '����� ��� ����������� ��������', '', nil, False);
    Hint:= '� ��� ����� ������������ �������������� �������';
   AddFileNameItem('aaExecute', '��������� �� ��������� ��������');
    Hint:= '��������� ��������� ���� (<����> <����� ��������>) �� ��������� �������� � ����� � ������.';
    Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
  CloseChild;
 end;
end;

procedure AddAutoExportNode(aConfig: TddAppConfiguration);
var
 l_C: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('AutoIncluded', '�������������� ������� ����������');
   LabelTop:= False;
   // Hint:= '������ � ������������� ����� �������������� ����� � ������������ ��������';
   AddDivider('�������� ���');
   l_C:= AddContainerGroup('aeStartDate', '�������|�� �������') as TddContainerConfigItem;
    l_C.AddCase('� ���� ���������� ����������');
    l_C.AddCase('�� �����');
    l_C.AddCase('� ���������� ��������');
     l_C.Add(TddDateConfigItem.Create('aeLastDate', '', MakeDateValue(IncDay(Now, -1))));
    l_C.AddCase('�� ��������� ��� ���');
    l_C.AddCase('� ������������ ����');
     l_C.Add(TddDateConfigItem.Create('aeCustomStartDate', '', MakeDateValue(IncDay(Now, -1))));
   CloseGroup;

   AddDivider('����');
   AddFolderNameItem('AutoIncludedFolder', '����� ��� ����������� ��������', '', nil, False);
    Hint:= '� ��� ����� ������������ �������������� �������';

   AddIntegerItem(l3CStr('AutoIncludedSize'), l3CStr('������������ ������ �����|�����'), 4*1024);
    Hint:= '��� ���������� ����� ������� ����� ����������� ����� ����';
    MinValue := 2*1024;
    MaxValue := 10*1024;
   {$IFNDEF AEByBelongs}
   AddStringItem('DoneFileName', '����-������');
    Hint := '��������� ���� ��������� � ������ ��������� ��������� ��������������� ��������';
   {$ENDIF}
   AddDivider('�������������� ���������');
    {$IF Defined(SGC) or Defined(LUK)}
    AddFileNameItem('aiExecute', '���������� ���� ������');
    {$ELSE}
    AddFileNameItem('aiExecute', '��������� �� ��������� ��������');
    {$IFEND}
     Hint:= '��������� ��������� ���� �� ��������� ��������. � �������� ������� ����� ������������ ����� � ���������� ������.';
     Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    AddStringItem('aiParams', '��������� �������');
     Hint:= '��������� ��������� ������ ��� ������� ������������ �����';
    {$IF Defined(SGC) or Defined(LUK)}
    AddFileNameItem('aiExecute2', '���������� ���� ������');
     Hint:= '��������� ��������� ���� ��� ���������� ���� ������. � �������� ������� ����� ������������ ����� � ���������� ������.';
     Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    {$IFEND}
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddDivider('�����������');
    AddStringItem('aiNotifyList', '������ ��� �������� �����������');
     Hint:= '�������� ������, ����������� ";", �� ������� ����� ������� ����������� �� ��������� ��������';
    {$IFDEF aiSMSNotify}
    AddstringItem('aiSMSNotify', '������ ��� ����������� �� ���');
     Hint:= '������ �� �������� ����������, �������������� ������ mail2sms. ������ ������� ������� ��� ������: <�����_�������� Beeline>@sms.beemail.ru[;<�����_�������� Beeline>@sms.beemail.ru]';
    {$ENDIF}
    AddIntegerItem(l3CStr('aiTotalCount'), l3CStr('���������� ���������� ����������'), 5000);
     Hint:= '���� ���������� ���������� ��� �������� �������� �������� �����, ����� ���������� �����������';
   {$IFEND}
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddChild('aiDocuments', '����� � ������������ ������������ ���������');
    LabelTop:= False;
    {$IFDEF AEByBelongs}
    AddItem(TalcuDictionaryTreeItem.Make('aiChangedBases', '������ ����������', da_dlBases, True, 10));
     Hint:= '������ ����������, ��������� ������� ��������� � ������������ �������';
    {$ELSE}
    AddItem(TalcuDictionaryTreeItem.Make('aiAccGroups', '������ �������', da_dlAccGroups, True, 10));
     Hint:= '������ �������, ��������� ������� ��������� � ����������� �������';
    {$ENDIF}
    AddDivider('������� ���� ������');
     AddStringItem('aiNewDocTemplate', '����� ���������', 'new%main%~%date%');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiNewRelTemplate', '����� �������', 'rel%main%');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiChangedDocTemplate', '������������ ���������', '%main%~%number%');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiChangedRelTemplate', '������������ �������', 'rel%main%2');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
    AddDivider('�������������');
     AddBooleanItem(l3CStr('aiExpandEditions'), l3CStr('�������������� �� ����� ����������'));
      Hint := '����� �������������� ��� �������� ����� � ������������ ����������';
   CloseChild;
   {$IFEND}
   AddChild('aiFullGroups', '��� ���������');
    LabelTop:= False;
    {$IFDEF AEByBelongs}
    AddItem(TalcuDictionaryTreeItem.Make('aiFullBases', '������ ����������', da_dlBases, True, 10));
    {$ELSE}
    AddItem(TalcuDictionaryTreeItem.Make('aiFullAccGroups', '������ �������', da_dlAccGroups, True, 10));
      Hint:= '���������� ������� �� ������ ������ ������� "���������� � ����������� ����������"';
    {$ENDIF}
    AddDivider('������� ���� ������');
     AddStringItem('aiAllDocTemplate', '���������', '%main%%number%');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
     AddStringItem('aiAllRelTemplate', '�������', 'rel_%main%');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
      LabelTop:= False;
    {$IF not Defined(LUK) and not Defined(SGC)}
    AddDivider('������ ���������');
     AddBooleanItem(l3CStr('aiAllExportIncluded'), l3CStr('�������������� ������ ������������ ���������'));
    {$IFEND}
   CloseChild;
   //AddIntegerItem(l3CStr('DeltaStartNumber'), l3CStr('����� ������� �����'), 1);
   // Hint:= '�����, � �������� ���������� ��������� ������';
   // MinValue:= 1;
   // MaxValue:= 100;
   {$IF not Defined(LUK) and not Defined(SGC)}
   AddChild('aiAnnotation', '���������');
    LabelTop:= False;
    AddItem(TalcuDictionaryTreeItem.Make('aiBases', '������ ����������', da_dlBases, True, 10));
     Hint:= '������ ����������, ��������� ������� ��������� � ����������� �������';
    AddDivider('������ ����� �����');
     AddStringItem('aiAnnoTemplate', '���������', 'monit');
      Hint:= '� �������� �������������� �������� ����� ������������ %main% - �������� �������� ������ �������,'+
             '%number% - ����� �����, %date% - ������� ���� � ������� YYYYMMDD';
   CloseChild;
   {$IFEND}
  CloseChild;
 end;
end;

{$IFDEF AutoSP}
procedure AddPublInRel(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('aiPublInRel', '���������� �������');
   LabelTop:= False;
   AddFolderNameItem('aiRelFolder', '����� � ������� � ����������', '', nil, False);
    Hint:= '� ���� ����� ������ ���������� ����� � ����������� � ����������';
   AddStringItem('aiRelNotifyList', '������ ��� �������� �����������');
    Hint:= '�������� ������, ����������� ";", �� ������� ����� ������� ����������� �� ��������� ����������� �������';
  CloseChild;
 end;
end;
{$ENDIF}

{$IFDEF Courts}
procedure AddCourtDesNode(aConfig: TddAppConfiguration);
var
 l_Main: TddBaseConfigItem;
 l_List: TddSimpleListConfigItem;
begin
 with aConfig do
 begin
  AddNode('CourtDecisions', '�������� �������');
   LabelTop:= False;
   AddItem(TalcuDictComboTreeItem.Make('DocType', '��� ���������', da_dlTypes, False{, '�������������'}));
    Hint:= '������������ ��������� ������ � ��������� �����. �� ��������� - "�������������"';
   {$IFNDEF Region}
   AddDateItem('CD_FromDate', '���� ��������� ���������');
    Hint:= '����� �������������� ��������� � ��������� ���� �� �������';
   {$ENDIF}
   AddStringItem('CD_Email', '������ ��� �����������');
    Hint:= '�������� ������, ����������� ";", �� ������� ����� ������� ����������� �� ��������� ����������� �����';
   with TddSimpleListConfigItem(AddSimpleListItem('CourtList', '����������� ����')).Config do
   begin
    AddItem(TddBooleanConfigItem.Create('Court_Work', '������������ ���������', ddEmptyValue));
    AddItem(TalcuDictComboTreeItem.Make('Court_Source', '��������� �����', da_dlSources, False, 6{, l_Main}));
    AddItem(TddStringListConfigItem.Make('Court_Before', '������ ��������� ���������'{, l_Main}));
   end; // with TddSimpleListConfigItem(AddSimpleListItem('CourtList', '����������� ����')).Config
  CloseChild;
 end;
end;
{$ENDIF Courts}

procedure AddAutoClassNode(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('AutoClass', '�����������������');
   LabelTop:= False;
   //AddDivider('�');
   AddFileNameItem('ac_Builder', '������ �����������������');
    Hint:= '������ ���� � �����, ������� ������������ �������� ��������� � ������ ������������ �� �����������������';
    Filter:= '��������� ����� (*.cmd, *.bat)|*.cmd;*.bat';
   AddFolderNameItem('ac_Folder', '����� ��� �������� ����������', '', nil, False);
    Hint:= '����� ��� ������� �������� ���������� �� �����������';
   AddFileNameItem('ac_FileName', '��������� �����������������');
    Hint:= '����, ���������� ������������ �� ����������� ������� � ����������';
    Filter:= '��������� ����������������� (*.result)|*.result';
   AddFileNameItem('ac_LogFileName', '���-���� �����������������');
    Hint:= '����, ����� � ����������� �����������������';
    Filter:= '���-���� ����������������� (*.log)|*.log';
   AddStringItem('ac_email', '������ ��� �����������');
    Hint:= '�������� ������, ����������� ";", �� ������� ����� ������� ����������� �� ��������� �����������������';
   AddDivider('����������� ����������');
   AddStringItem('ac_iemail', '����� ��� ��������');
    Required:= True;
    Hint:= '�� ���� ����� ����� ������ ����� � ��������� ��������� �����������������';
  CloseChild;
 end;
end;

procedure AddArchiChild(aConfig: TddAppConfiguration);
var
 l_File: TddFileNameConfigItem;
 l_Folder: TddFolderNameConfigItem;
begin
 with aConfig do
 begin
  AddChild('Archi', '"����������"');
   LabelTop:= False;
   AddFileNameItem('ArchiLogFileName', '���� ���� "�����������"');
    Filter:= '����� ���� ������ (*.log)|*.log';
    Hint:= '������ ���� � �����, � ������� ��������� ����� � ������ "�����������"';
   AddIntegerItem(l3CStr('MaxArchiLogFileSize'), l3CStr('������������ ������ ����� ����|�����'));
    MinValue:= 5;
    MaxValue:= 10;
    Hint:= '�� ���������� ����� ������� ���� ���� ����� ������������ � ������ ����������� ������.';
   AddBooleanItem(l3CStr('ZipLogFiles'), l3CStr('������� ��� �������� ��������� ������������'), True);
    Hint:= '��� �������� ����� �� ����� ���-���� ����� ���� � zip-�����';
   AddIntegerItem(l3CStr('FreeSpaceLimit'), l3CStr('������� ���������� ����� �� �����|������� ����'), 3);
    MinValue:= 1;
    Hint:= '��� ���������� ���������� ����� �� ����� � ����� ������ ���� ���������� ������� ����� ���������� ��������������';
   //AddFileNameItem('DeletedFileList', '���� ������ ��������� NODOC');
   // Hint:= '� ���� ���� ��������� ������ ��������� ���������� � ����� NoDoc, ������������ � ��������� ��������� ������� NSRC';
   AddDivider('������������');
    AddIntegerItem(l3CStr('WaitTime'), l3CStr('�������� ������|���'), 15);
     MinValue:= 1;
     MaxValue:= 30;
     Hint:= '����� �������� ������ ������������� � ������� ����� ������ ������������';
    AddStringItem('NotifyAddress', '����� �����������'{, 'jurotd@garant.ru'});
     Hint:= '�������� �����, �� ������� ����� ������� ����������� �� ��������� ������������';
     LabelTop:= False;

   AddIntegerItem(l3CStr('UpdateInterval'), l3CStr('�������� ���������� ������� �������|������'), 10);
    MinValue := 10;
    maxValue := 120;
    Hint := '��� ����� ����� ������������ ������������� ���������� �� ��������� ������� �������';

   with TddSimpleListConfigItem(AddSimpleListItem('LogoList', '������ ������� �����������')).Config do
   begin
    l_File:= TddFileNameConfigItem.Make('logo_File', '���� �����������');
    l_File.FilterMask:= '��� ����� ����������� (*.jpg, *.png, *.bmp)|*.jpg;*.png;*.bmp|JPG (*.jpg)|*.jpg|PNG (*.png)|*.png|BMP (*.bmp)|*.bmp';
    AddItem(l_File);
    AddItem(TddDateConfigItem.Create('Logo_Start', '������ ��������', ddEmptyDateValue));
    AddItem(TddDateConfigItem.Create('Logo_Finish', '��������� ��������', ddEmptyDateValue));
    AddItem(TddBooleanConfigItem.Create('Logo_Once', '���� ���', ddEmptyValue));
   end;
   {$IFDEF UserQuery}
   AddDivider('��������� �������');
    l_Folder:= AddFolderNameItem('sqFolder', '����� ��� �������� ��������', 'UserQueries', nil, False) as TddFolderNameConfigItem;
     Required:= True;
     l_Folder.PathFill:= dd_ftFull;
     Hint:= '����� ��� �������� ���������������� ��������� ��������';
   CloseChild;
   {$ENDIF}
  CloseChild;
 end;
end;

procedure AddUserMessagesChild(aConfig: TddAppConfiguration);
var
 l_List: TddSimpleListConfigItem;
begin
 with aConfig do
 begin
  AddChild('UserMessages', '��������� �������������');
   LabelTop:= False;
   AddStringsItem('InfoMessages', '�������������� ���������');
    Hint:= '��������� �� ������� ������ ������������ � �������� �������������� ���������';
   AddStringsItem('LockMessages', '��������� � �������� ����');
    Hint:= '��������� �� ������� ������ ������������ ��� �������� ����';
   l_List:= TddSimpleListConfigItem(AddSimpleListItem('EmailNotifications', '����������� �������������'));
    l_List.TitleCaption := '��������� ���������';
    l_List.Config.AddItem(TddTextConfigItem.Make('Body', '���������'));
  CloseChild;
 end;
end;

procedure AddMainConfig(aConfig: TddAppConfiguration);
var
 l_Node: TddCustomConfigNode;
 l_Main: TddBaseConfigItem;
 l_Dict: TdaDictionaryType;
 l_S: String;
begin
 with aConfig do
 begin
  l_Node:= AddNode('General', '��������');
   LabelTop:= False;
   AddStringItem('BaseID', '�������� ���� ������', '������ ������������� �����������');
    Hint:= '��������� �������� ���� ������ ������������ � �������� ������ ������ � ���������';
   AddDivider('���� ������');
   TdaDataProviderSuperFactory.Instance.BuildConfig(aConfig);
   AddDivider('������������');
   TIdStack.IncUsage;
   l_S:= GStack.LocalAddress;
   TIdStack.DecUsage;
   AddStringItem('ServerName', '����� �������', l_S);
    Hint:= '����� �������';
    Required:= True;
   AddIntegerItem(l3CStr('ServerPort'), l3CStr('���� �������'), 32100);
    Hint:= '���� �������';
    Required:= True;

   AddDivider('������');
    AddTimeItem('WorkDayStart', '������� ���� ���������� �|�����', EncodeTime(8, 0, 0, 0));
     Hint:= '�� ����� ������� ������ ����������� ���������� ������������������ ��������';
    AddBooleanItem(l3CStr('ExcludeWeekEnd'), l3CStr('������� � ����������� ���������'), True);
     Hint:= '�������� ����� ��������� ����� ���� ��� ������� ������� ��������� �������� ����������.';
    {$IFDEF UseArchiCopyFile}
    AddBooleanItem(l3CStr('UseSystemCopy'), l3CStr('��������� ������� �����������'), True);
     Hint:= '������������ ��� ����������� ������� ������������ �������';
    {$ENDIF}
    {$IFDEF UseCommandFile}
    AddFileNameItem('exUpdater', '������� ���������� ����');
     Hint:= '��������� ���� ��� ���������� ���� ������';
    {$ENDIF}
    AddIntegerItem(l3CStr('l3LogLevel'), l3CStr('������� �����������'), alcuMessageLevel);
     Hint:= '����������� - 0, ����� ��������� - 10';
     MinValue := 0;
     MaxValue := 10;

   AddUserTasksChild(aConfig);

   AddArchiChild(aConfig);

   AddUserMessagesChild(aConfig);
 end;
end;

procedure AddPrimeConfig(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
  AddNode('Annotations', '��������� ��� �����');
   LabelTop:= False;
   AddDivider('�������������� ���������');
   AddDateItem('annoDate',  '���������, ������������ �');
    Hint:= '��������� ���� ���������, �� ������� �������������� ���������';
   l_Item:= AddComboBoxItem(l3CStr('annoEndDate'), l3CStr('�� '), 0);
    Hint:= '��������� ��������� ���� ������. �� ��� ��������� ����������� �������� ���� ���������, �� ������� ������������� ���������. ';
    with TddComboBoxConfigItem(l_Item) do
    begin
     AddMapValue('�������', 0);
     AddMapValue('�����������', DayMonday);
     AddMapvalue('�������', DayTuesday);
     AddMapValue('�����', DayWednesday);
     AddMapvalue('�������', DayThursday);
     AddMapvalue('�������', DayFriday);
     AddMapValue('�������', DaySaturday);
     AddMapvalue('�����������', DaySunday);
    end;
   //CloseGroup;
   AddFolderNameItem('AnnoFolder', '����� ��� ���������', '', nil, False);
    Hint:= '� ��� ����� ����� ����������� ���������';
   AddStringItem('AnnoInfoList', '������ ��������');
    Hint:= '�������� ������, ����������� ";", �� ������� ����� ������������ ����������� �� ��������� �������� ���������';
   AddDivider('�������������');
    AddItem(TalcuDictionaryTreeItem.Make('annoBelongs', '������ ����������', da_dlBases, True));
     Hint:= '������ �� ��������� ����� ���������� ������������ � ������������ ����� �����';
    AddFileNameItem('annoExecute', '��������� �� ��������� ��������');
     Hint:= '��������� ��������� ���� (<����> <����� ��������> <����� ����������>) �� ��������� �������� � ����� � ������.';
     Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
    AddFolderNameItem('annoOutFolder', '����� ��� ���������� ������ �����', 'out', nil, False);
     Hint:= '� ��� ����� ����� �������� ���������� ������ �����, ������� ����� ����� ��������� �� �����';
    l_Main:= AddBooleanItem(l3CStr('annoAnalyzeLog'), l3CStr('������������� ���-����'), True);
     Hint:= '������������� ���������� ������ �����. ������� � ����� �������� ��������� ����� YYYY-MM-DD_BELONGS.nsr.log ��������� �������';
    AddStringItem('annoPrimeEmail', '����� ������ ������', 'reganno_archi@garant.ru');
     Hint:= '���� ������ ���, ��������� �������� ����� ��������� �� ��������� �����';
   AddChild('PrimeDocs','��������� �� ���������');
   LabelTop:= False;
   l_Main:= AddBooleanItem(l3CStr('annoNeedDocs'), l3CStr('�������������� ���������'), True);
    AddFolderNameItem('AnnoDocFolder', '����� ��� ����������', '', l_Main, False);
     Hint := '� ��� ����� ����� ����������� ���������, ����������� � ����������';
    AddStringItem('AnnoDocListFile', '���� �� ������� ����������', '', l_Main);
     Hint := '����, � ������� ����� ������� ������ ����������� ����������. ��������� � ����� ��� ����������';
    // ������� ����������
    // �����������
    AddGroupItem('annoCommentGroup', '��������� "����������� � �����������"', l_Main);
     AddItem(TalcuDictComboTreeItem.Make('annoProjects', '������ �������', da_dlAccGroups, False, 6, l_Main));
      Hint:= '��������� �� ��������� ������ ������� ���������������� �� �����';
     AddItem(TalcuDictComboTreeItem.Make('annoComments', '���', da_dlTypes, False, 6, l_Main));
      Hint:= '��������� ��������� ����� ���������������� �� �����';
    CloseGroup;
    // �������
    AddGroupItem('annoProjectsGroup', '��������� "������� �������"', l_Main);
     AddItem(TalcuDictComboTreeItem.Make('annoProjects2', '������ ����������', da_dlBases, False, 6, l_Main));
      Hint:= '��������� �� ��������� ������ ���������� ���������������� �� �����';
     AddItem(TalcuDictionaryTreeItem.Make('annoProjects3', '����', da_dlTypes, True, 6, l_Main));
      Hint:= '��������� ��������� ����� ���������������� �� �����';
    CloseGroup;
    {$IFNDEF Region}
    AddItem(TalcuDictionaryTreeItem.Make('annoAccGroup', '��������� ������ �������', da_dlAccGroups, True));
     Hint:= '��������� �� ��������� ����� ������� ���������������� �� �����';
    {$ENDIF} 
  CloseChild;
 end;
end;

procedure AddAutoLinkNode(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddChild('alcAutoLink', '������������ ������');
    AddRadioGroupItem('alcMode', '����� ������', 1);
     Add('������');
     Add('������');

     AddStringItem('alcFTPHost', 'FTP ������', 'partner.garant.ru');
     LabelTop:= False;
    AddIntegerItem(l3CStr('alcFTPPort'), l3CStr('����'), 21);
     MinValue:= 1;
     MaxValue:= 65000;
    AddStringItem('alcFTPUser', '��� ������������', '');
     LabelTop:= False;
    AddStringItem('alcFTPPassword', '������', '');
     PasswordChar:= '*';
     LabelTop:= False;
    AddStringItem('alcFTPFolder', '����� �� �������', '');
     LabelTop:= False;
    AddBooleanItem(l3CStr('alcFTPPassive'), l3CStr('��������� �����'));
     LabelTop:= False;
  CloseChild;
 end;
end;


procedure AddDailyConfig(aConfig: TddAppConfiguration; AutolinkEnabled: Boolean);
var
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
   AddNode('Everyday', '���������� ����������');
    LabelTop:= False;
    l_Main:= AddBooleanItem(l3CStr('DoEverydayUpdate'), l3CStr('��������� ���������� ����������'));
    AddDivider('��������� �����������');
     AddFolderNameItem('FamilyBackup', '����� ��� ���������', 'Yesterday', l_Main, False);
      Hint:= '� ��������� ����� ���������� ������ ����� � ����������� � ����������';
     AddIntegerItem(l3CStr('EveryDayBackupCount'), l3CStr('�������|����� ���������'), 3, l_Main);
      MinValue:= 1;
      MaxValue:= 7;
     l_Item:= AddBooleanItem(l3CStr('DoFullBackup'), l3CStr('��������� ������ ����������� ���� � �����'), False, l_Main);
     AddFolderNameItem('FullBackup', '', GetWindowsTempFolder, l_Item, False);
      Hint:= '���������� ��� ����� ����. ����� ����� �������� ����������';
     AddItem(TalcuWeekChecklineItem.Make('FullBackupAtDays', '', l_Item));
      Hint:= '��������� ����������� � ��������� ��� ������';

    AddDivider('����������');
    {$IFNDEF LUK}
    l_Item:= AddBooleanItem(l3CStr('DoImportKW'), l3CStr('������������� ���� �������� ����'), False, l_Main);
    AddFileNameItem('KWFileName', '', '', l_Item);
     Filter:= '����� �������� ���� (*.kw)|*.kw';
    {$ENDIF}
    AddBooleanItem(l3CStr('DoUpdateBase'), l3CStr('��������� ������� ���� ������'), True, l_Main);
    AddBooleanItem(l3CStr('DoHeaderIndex'), l3CStr('������������� ��������� ����������'), True, l_Main);
    {$IFNDEF LUK}
    AddBooleanItem(l3CStr('DoDictEntryIndex'), l3CStr('������������� ��������� ������'), True, l_Main);
    {$ENDIF}
    AddBooleanItem(l3CStr('DoUpdateIndex'), l3CStr('��������� ��������� ������'), True, l_Main);
    AddBooleanItem(l3CStr('DoUpdateText'), l3CStr('��������� ��������� �����'), True, l_Main);
    {$IFDEF KWSending}
    AddChild('KWMailList', '�������� ����� �������� ����');
     LabelTop:= False;
     //AddFilenameItem('KWArchiveMaker', '����, ��������� ����� �������� ����');
     //AddFileNameItem('KWArchivename', '���� � ������� �������� ����');
     AddStringItem('KWRecepients', '���������� ������ �������� ����');
    CloseChild;
    {$ENDIF KWSending}

    {$IFDEF AAC}
    AddChild('Dossier', '�������� ����� ��� ������������� ���');
     LabelTop:= False;
     AddItem(TalcuDictComboTreeItem.Make('dosType', '��� ����������', da_dlTypes, False));
      Hint:= '���������� ������� �� ������ ��� ��������� "�������������"';  // ����� ����� ������ �� ������������
     AddItem(TalcuDictionaryTreeItem.Make('dosSource', '��������� ������', da_dlSources, True));
      Hint:= '���������� ������� ������� ���� ����������� ���';
     AddDateItem('dosDate', '���� ��������� ���������');
      Hint:= '����� ����� ������� ��� �������������, ����������� ������� � ��������� ����';
    CloseChild;

    AddChild('CaseCodes', '�������� ������� ��� ��� ������������� ���');
     LabelTop:= False;
     AddItem(TalcuDictionaryTreeItem.Make('ccType', '��� ����������', da_dlTypes, True));
      Hint:= '���������� ������� �� ������ ��� ��������� "�������������" � "�����������"';
     AddItem(TalcuDictionaryTreeItem.Make('ccSource', '��������� ������', da_dlSources, True));
      Hint:= '���������� ������� ������� ���� ����������� ���';
     AddDateItem('ccDate', '���� ��������� ���������');
      Hint:= '����� ����� ������� ��� �������������, ����������� ������� � ��������� ����';
    CloseChild;

    AddChild('LawCaseUpdate', '���������� ������������� ��');
     LabelTop:= False;
     AddItem(TalcuDictionaryTreeItem.Make('lcType', '��� ����������', da_dlTypes, True, 6));
      Hint:= '���������� ������� �� ������ ��� ��������� "�������������" � "�����������"';
     AddItem(TalcuDictionaryTreeItem.Make('lcSource', '��������� ������', da_dlSources, True, 6));
      Hint:= '���������� ������� ������� ���� ����������� ���. ��������� ���� ��������� ������� ������������ ��� ������ ��������.';
     AddItem(TalcuDictionaryTreeItem.Make('lcFASSource', '��������� ������ ���', da_dlSources, True, 6));
      Hint:= '���������� ������� ������� ���� ����������� ����������� ���. ��������� ���� ��������� ������� ������������ ��� ������ ��������.';
     AddItem(TalcuDictComboTreeItem.Make('lcPublished', '�������� �������������', da_dlCorSources, False));
      Hint:= '���������� ������� �������� ������������� ����������. ������ ��� "�������� �� ��������".';
     AddStringItem('lcNotify', '��������� �����');

     AddChild('lcFiles', '����� �������������');
      LabelTop:= False;
      AddFileNameItem('lcSourceFile', '��������� ������');
       Filter:= '��������, ����������� ��������|*.csv';
      AddFileNameItem('lcLinkDataFile', '������ ��� ����������� ������');
       Filter:= '��������, ����������� ��������|*.csv';
      AddFileNameItem('lcKeyThemes', '������ �������� ���');
       Filter:= '��������, ����������� ��������|*.csv';
      AddFileNameItem('lcMisspells', '������ ��������');
       Hint:= '���� � �������� ����������, ��� ����������� �� ����� �������';
       Filter:= '��������, ����������� ��������|*.csv';
      AddFileNameItem('lcTypeSyno', '������ ������������� �����');
       Filter:= '��������, ����������� ��������|*.csv';
      AddFileNameItem('lcSourceConvertFile', '"������� � �������������"');
       Filter:= '��������� �����|*.txt';
      AddFileNameItem('lcFASCorrect', '������ ��������� ������� ���');
       Filter:= '��������, ����������� ��������|*.csv';
     CloseChild; //lcFiles

     AddChild('lcFolders', '��������� �����');
      LabelTop:= False;
      AddFolderNameItem('lcSourceFolder', '����� � ��������� �������', '', nil, False);
       Hint:= '� ���� ����� ��������� ������������� ��� � ������� �������';
      AddIntegerItem(l3CStr('lcMaxFileCount'), l3CStr('������������ ��|������'), 10000);
       Hint:= '��������� ����� ����� ���������� �� ��������� ��������';
      AddFolderNameItem('lcDestFolder', '����� ��� ������������ ������', '', nil, False);
       Hint:= '� ��� ����� ����� ����������� ������� ������������ �����';
      AddFolderNameItem('lcDuplicateFolder', '����� ��� �������� ����������', '', nil, False);
       Hint:= '� ��� ����� ����� ����������� ��������� ��������� �������������';
      AddFolderNameItem('lcArchive', '����� ��� �������� ������������ �����', CorrectArchiveWarehousePath('', 'AAC Update Logs'), nil, False);
       Hint := '� ���� ����� �������� ������������ ����';
       PathFill:= dd_ftFull;
      AddIntegerItem(l3CStr('lcMaxLogAge'), l3CStr('������� ���� ������������ �������|����'), 0);
       Hint := '������� ���� ����� ��������� ���� ������������ ��������������� �������';
       MinValue := 0;
       MaxValue := 1200;
     CloseChild; // lcfolders

     AddChild('lcRelated', '������� �������');
      LabelTop:= False;
      AddItem(TalcuDictionaryComboItem.Make('lcRelAccGroup', '������ �������', da_dlAccGroups));
       Hint:= '���������� ������� ������ �������, ��� ������� ����� ���������������� �������';
      AddFolderNameItem('lcRelFolder', '����� ��� �������', '', nil, False);
       Hint:= '� ��� ����� ����� �������������� ������������ �������';
      AddFileNameItem('lcRelDoneFile', '��������� �� ���������');
       Hint:= '����� ��������� �������� ����� �������� ��������� ����';
     CloseChild;
    CloseChild; // CaseCodes
    {$ENDIF AAC}
    {$IFDEF SubDeletedNotify}
    AddChild('DictUpdate', '��������� �����');
     LabelTop:= False;
     AddFileNameItem('DictUpdateFileName', '���� ��������� �����', 'changed_anchors.txt');
      Hint:= '� ���� ���� ����� �������� ���������� � ��������� ������ � ����������. ������ ���� UNC � ������������ ������ � ������� �������';
      Required:= True;
     AddStringItem('DictUpdateMail', '����������� �� �������� �����');
      Hint:= '�� ���� ����� ����� ����������� ������ ��������� ����� � ����������';
    CloseChild;
    {$ENDIF}
    if AutolinkEnabled then
     AddAutoLinkNode(aConfig);
 end;
end;



procedure AddDeltaConfig(aConfig: TddAppConfiguration);
var
 l_Node: TddCustomConfigNode;
 l_Item: TddBaseConfigItem;
 l_Main: TddBaseConfigItem;
begin
 with aConfig do
 begin
  l_Node:= AddNode('Everyweek', '������ ������ ����������');
   LabelTop:= False;
   l_Main:= AddBooleanItem(l3CStr('DoEveryweekUpdate'), l3CStr('��������� ������ ������ ����������'));
    Hint:= '������������ ��� ������� �������� ������ ����������, �������������� ��� "�����������"';
   AddFolderNameItem('BackupRoot', '����� ��� �������� ��������� �����', '', l_Main, False);
    Hint:= '� ���� ����� ����� ����������� ��������� ����� ���� ������ ����� �������� ������ ����������';
   AddIntegerItem(l3CStr('BackupCount'), l3CStr('�������|��������� �����'), 3, l_Main);
    MinValue:= 1;
    MaxValue:= 8;
   AddFolderNameItem('SourceFolder', '����� � ������� "������"', '', l_Main, False);
    Hint:= '� ���� ����� ����� ���������� NSR-����� ����� � ������������ ����������';
   AddFolderNameItem('PictureFolder', '����� � ������������ �������', '', l_Main, False);
    Hint:= '����� � ������� ��� ��������� ���������� (!OBJTOPIC)';
 //  AddFolderNameItem('KWFileName2', '���� �������� ����', '', l_Main, nil);
 //   Filter:= '����� �������� ���� (*.kw)|*.kw';
   {$IFDEF CheckPriority}
   AddFileNameItem('PriorityFileName', '���� ��������� ������� ��������', '', l_Main);
    Filter:= '��������� ����� (*.txt)|*.txt';
    Hint:= '�� ��������� ������ �� ����� ����� ����� ����������� �������� (����������� ����) ����������';
   {$ENDIF}
   AddBooleanItem(l3CStr('DoUpdateTextIndex'), l3CStr('��������� ��������� ������'), False, l_Main);
    Hint:= '���������� ���������� ������� ��� ��������������� ����������';

   AddChild('Delta', '�������� ������');
    LabelTop:= False;
    l_Item := AddBooleanItem(l3CStr('CheckLogFile'), l3CStr('��������� ���������� ������ ��� ������'), True, l_Main);
     Hint := '� �������� ����, ��������� �� �������� "��������� �����" ������ ������ ������ � ������������';
    AddStringItem('DeltaPattern', '������� ����������� ����������', 'SX weekly delta ready', l_Item);
     Hint := '���� ��������� ����� ����� ����������� � ������ ������, ���������, ��� ��� �����������';
    AddIntegerItem(l3CStr('NotifyAge'), l3CStr('��������� ������ �� ������|�����'), 12, l_Item);
     MinValue  := 1;
     MaxValue  := 24;
     Hint := '������, ���������� ������, ��� �� ��������� ����� ����� �� ��������, �� ������������ �����������';
    l_Item:= AddBooleanItem(l3CStr('DoMakeDelta'), l3CStr('�������������� "������" ��������������'), False, l_Main);
    AddFileNameItem('DeltaCreator', '', '', l_Item);
     Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
     Hint:= '����, ��������� ������ ���������� �� ������';
    AddFileNameItem('SpravkiFileName', '���� � ������������ ���������', '', l_Item);
     Hint:= '� �������� ���� ������������ ������ �������, ���������� � "������"';
   CloseChild;
  {$IFNDEF Region}
   AddChild('AddionalDelta', '�������������');
    //l_Item:= AddBooleanItem(l3CStr('DoHolidayBase'), l3CStr('��������� ���� "��������� ���"'), False);
    //AddFolderNameItem('HolidayFolder', '', '', l_Item, nil);
    l_Main:= AddBooleanItem(l3CStr('DoAddionalDelta'), l3CStr('��������� �������������� "������"'));
    AddFileNameItem('AddDeltaCreator', '', '', l_Main);
     Filter:= '����������� ����� (*.bat, *.cmd, *.exe)|*.bat;*.cmd;*.exe';
     Hint:= '����, ��������� �������������� ������ ����������';
    AddStringItem('AddEmailNotfy', '����� ����������� ����������', '', l_Main);
     Hint := '�� ��������� ����� ����� ���������� ������ �� ��������� ���������� �������������� ������';
    AddStringItem('AddDeltaPattern', '����� �����������', 'SX weekly delta ready', l_Main);
     Hint := '����� ������ � ������������ �� ��������� ���������� �������������� ������';
    AddFileNameItem('DiffList', '���� �������', '\\archi3\archi\incoming\Spravki\diff.lst');
     Hint := '����, ���������� ������� ����� ������� � ���������������� �����������';
  {$ENDIF Region};   
   CloseChild;
 
 end;
end;

procedure AddNotifyConfig(aConfig: TddAppConfiguration);
var
 l_Item: TddBaseConfigItem;
begin
 with aConfig do
 begin
  AddNode('Notification', '�����������');
  LabelTop:= False;
  AddStringItem('SMTPAddress', '�������� �����');
  l_Item:= AddBooleanItem(l3CStr('SMTPReply'), l3CStr('����������� ������'));
   AddStringItem('SMTPForward', '����� ���������', '', l_Item);
  AddStringItem('SMTPHost', '������ SMTP');
  LabelTop:= False;
  AddIntegerItem(l3CStr('SMTPPort'), l3CStr('���� SMTP'), 25);
   MinValue:= 1;
   MaxValue:= 65000;
  l_Item:= AddBooleanItem(l3CStr('Authentication'), l3CStr('��������� �����������'));
  AddStringItem('SMTPLogin', '�����', '', l_Item);
   LabelTop:= False;
  AddStringItem('SMTPPassword', '������', '', l_Item);
   PasswordChar:= '*';
   LabelTop:= False;
  AddBooleanItem(l3CStr('SMTPRequireSSL'), l3CStr('������������ ���������� SSL'));
  AddFolderNameItem('SmtpSendQueueFolder', '����� ��� �������� �������������� �����', IncludeTrailingPathDelimiter(ChangeFileExt(ParamStr(0),'.mail')), nil, False);
  mailAdapter:= TalcuEmailAdapter.Create;
  try
   AddListItem('NotifyList', '������ �����������', mailAdapter);
  finally
   l3Free(mailAdapter);
  end;
  l_Item:= AddBooleanItem(l3CStr('EnableSMS'), l3CStr('���������� ���'), False);
   Hint := '� ������ ������ �� ������������� ������ ����� ���������� SMS � ��������� ������';
   AddStringItem('SMSList', '������ ��������', ''{'6246622@sms.beemail.ru;1118255@sms.beemail.ru'}, l_Item);
    Hint := '������ �� �������� ����������, �������������� ������ mail2sms. ������ ������� ������� ��� ������: <�����_�������� Beeline>@sms.beemail.ru[;<�����_�������� Beeline>@sms.beemail.ru]';
  AddChild('RecieveMail', '��������� �����');
   AddStringItem('POPHost', '������ POP3');
   LabelTop:= False;
   AddIntegerItem(l3CStr('POPPort'), l3CStr('���� POP3'), 110);
    MinValue:= 1;
    MaxValue:= 65000;
   AddStringItem('POPLogin', '�����');
    LabelTop:= False;
   AddStringItem('POPPassword', '������');
    PasswordChar:= '*';
    LabelTop:= False;
   AddBooleanItem(l3CStr('POPRequireSSL'), l3CStr('������������ ���������� SSL'));

   AddIntegerItem(l3CStr('POPInterval'), l3CStr('��������� ����� ������|�����'));
    MinValue := 0;
    MaxValue := 30;
    Hint := '���� �������� �������� ����� ����� 0, �������� �������������� �� �����';

  CloseChild;
  CloseChild;
 end;
end;

{$IFDEF ExchangeDocs}
procedure AddExternalDeltas(aConfig: TddAppConfiguration);
var
 l_G: TddGroupConfigItem;
 l_List: TddSimpleListConfigItem;
 l_I: TddVisualConfigItem;
 l_C: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('ExtDeltas', '������� ������');
  // ���������
   AddGroupItem('regSourcesGroup', '�������� ������');
    l_List:= TddSimpleListConfigItem(AddSimpleListItem('regSources', '��������� �����'));
    l_List.Config.LabelTop:= False;
    l_List.TitleCaption:= '�������� ���������';
    l_List.Config.AddItem(TddDividerConfigItem.Create('regFTP', '��������� FTP', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPServer', '������'));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPLogin', '������������'));
      l_I:= l_List.Config.AddItem(TddStringConfigItem.Make('FTPPassword', '������')) as TddVisualConfigItem;
      TddStringConfigItem(l_I).PasswordChar:= '*';
      l_List.Config.AddItem(TddBooleanConfigItem.Create('FTPPassive', '��������� �����', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPFolder', '����� �� �������'));
     l_List.Config.AddItem(TddDividerConfigItem.Create('regDocs', '�������������', ddEmptyValue));
     l_List.Config.AddItem(TddStringConfigItem.Make('FileNameMask', '������ ����� �����'));
     l_List.Config.AddItem(TddStringConfigItem.Make('NotifyAddress', '����� �����������'));
    AddFolderNameItem('regSourcesArchive', '����� ��� �������� �������� �����', CorrectArchiveWarehousePath('', 'Region deltas\Import'), nil, False);
     Hint := '� ���� ����� �������� �������� ������ � ��������';
     PathFill:= dd_ftFull;
   CloseGroup;
   // �����������
   AddGroupItem('regDestinationsGroup', '��������� ������');
    l_List:= TddSimpleListConfigItem(AddSimpleListItem('regDestinations', '����������� �����'));
    l_List.Config.LabelTop:= False;
    l_List.TitleCaption:= '�������� �����������';
     l_List.Config.AddItem(TddDividerConfigItem.Create('regFTPDest', '��������� FTP', ddEmptyValue));
     l_List.Config.AddItem(TddStringConfigItem.Make('FTPServerDest', '������'));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPLoginDest', '������������'));
      l_I:= l_List.Config.AddItem(TddStringConfigItem.Make('FTPPasswordDest', '������')) as TddVisualConfigItem;
      TddStringConfigItem(l_I).PasswordChar:= '*';
      l_List.Config.AddItem(TddBooleanConfigItem.Create('FTPPassiveDest', '��������� �����', ddEmptyValue));
      l_List.Config.AddItem(TddStringConfigItem.Make('FTPFolderDest', '����� �� �������'));
     l_List.Config.AddItem(TddDividerConfigItem.Create('regDocsDest', '��������� ��������', ddEmptyValue));
     l_C:= TddContainerConfigItem(l_List.Config.AddItem(TddContainerConfigItem.SimpleCreate('DataTypeDest', '���������')));
      l_C.AddCase('�� ������� �������');
       l_C.Add(TalcuDictionaryTreeItem.Make('AccGroupsDest', '', da_dlAccGroups, True));
      l_C.AddCase('�������');
       l_C.Add(TalcuQueryComboboxItem.make('QueryDest', ''));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withAnnoDest', '�������� ���������', makeBoolValue(True)));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withEditionDest', '�������� ��������', makeBoolValue(False)));
     l_List.Config.AddItem(TddBooleanConfigItem.Create('withNotIncDest', '�������� ��������������', makeBoolValue(False)));
     l_List.Config.AddItem(TddStringConfigItem.Make('FileNameMaskDest', '������ ����� �����'));
     l_List.Config.AddItem(TddStringConfigItem.Make('NotifyAddressDest', '����� �����������'));
    AddFolderNameItem('regDestinationsArchive', '����� ��� �������� ������������ �����', CorrectArchiveWarehousePath('', 'Region deltas\Export'), nil, False);
     Hint := '� ���� ����� �������� ������������ ������ � ��������';
     PathFill:= dd_ftFull;
   CloseGroup;
  CloseChild;
 end; // with ddAppConfiguration
end;
{$ENDIF ExchangeDocs}

procedure AddQueryExportNode(aConfig: TddAppConfiguration);
var
 l_Main: TddBaseConfigItem;
 l_List: TddSimpleListConfigItem;
 l_Item: TddBaseConfigItem;
begin
(*
 with aConfig do
 begin
  AddNode('QueriedExport', '������� �� �������');
   with TddSimpleListConfigItem(AddSimpleListItem('ExportList', '������ �������')).Config do
   begin
    //AddItem(TalcuDictComboTreeItem.Make('qe_Query', '��������� ������', da_dlSources, False, 6{, l_Main}));
   l_Item:= TddComboBoxConfigItem.Create(l3CStr('annoEndDate'), l3CStr('�� '), 0);
    Hint:= '��������� ��������� ���� ������. �� ��� ��������� ����������� �������� ���� ���������, �� ������� ������������� ���������. ';
    with TddComboBoxConfigItem(l_Item) do
    begin
     AddMapValue('�������', 0);
     AddMapValue('�����������', DayMonday);
     AddMapvalue('�������', DayTuesday);
     AddMapValue('�����', DayWednesday);
     AddMapvalue('�������', DayThursday);
     AddMapvalue('�������', DayFriday);
     AddMapValue('�������', DaySaturday);
     AddMapvalue('�����������', DaySunday);
    end;

    AddItem(TddStringListConfigItem.Make('qe_Format', '������ �����'{, l_Main}));
    AddItem(TddStringConfigItem.Create('qe_Split', '������ �����', ddEmptyValue{, l_Main}));
    AddItem(TddFolderNameConfigItem.Create('qe_Folder', '����� ����������', ddEmptyValue));
   end;
  CloseChild;
 end;
*)
end;
(*
procedure AddSectionMakerNode(aConfig: TddAppConfiguration);
begin
 // TODO -cMM: AddSectionMakerNode ���������� �������� ����������
 with aConfig do
 begin
  AddNode('SectionMaker', '����������� ��������');
   // ���� ��������� ���������
   AddDateItem('smLast', '���� ��������� ���������');
   // ��� ����
   AddRadioGroupItem('smDates', '������������ ���������',1);
    Add('� ���� ��������� ���������');
    Add('� ���� ����������');
   // ����� �����������
   AddStringItem('smNotify', '�� ��������� ���������');
  CloseChild;
 end;
end;
*)
procedure AddHavanskyExportChild(aConfig: TddAppConfiguration);
begin
 with aConfig do
 begin
  AddNode('PikPress', '������� ��� ��� �����');
   LabelTop:= False;
  // ���� ��������� ���������
   AddDateItem('ppLast', '���� ��������� ���������');
   AddFolderNameItem('ppFolder', '�����', '', nil, False);
   AddDivider('�������� ���������');
   AddItem(TalcuDictionaryTreeItem.Make('ppinSource', '��������� ������', da_dlSources, True));
    Hint:= '';
   // Sources
   AddDivider('��������� ���������');
   AddItem(TalcuDictionaryTreeItem.Make('ppexSource', '��������� ������', da_dlSources, True));
   AddItem(TalcuDictionaryTreeItem.Make('ppexType', '���', da_dlTypes, True));
   AddItem(FTPParams('ppex', '��������� FTP'));
   CloseGroup;
  CloseChild;
 end;
end;

procedure AddAnoncedChild(aConfig: TddAppConfiguration);
var
 l_C, l_C2: TddContainerConfigItem;
begin
 with aConfig do
 begin
  AddNode('Anonced', '������������� ����������');
   LabelTop:= False;
   {$IFDEF AnoncedExport}
   AddDivider('������� ��������������');
   AddFolderNameItem('anonFolder', '����� ��� ��������', '', nil, False);
   l_C:= AddContainerGroup('anonExport', '��������� ��������') as TddContainerConfigItem;
    l_C.AddCase('���������, ����� ��������');
     l_C.Add(TalcuDictionaryTreeItem.Make('anonAccGroups', '������ �������', da_dlAccGroups, True, 10));
    l_c.AddCase('� �������');
     l_C.Add(TalcuDictionaryTreeItem.Make('anonAccGroupsEx', '������ �������', da_dlAccGroups, True, 10));
     l_C.Add(TddStringConfigItem.Make('anonThuFileName', '��� �����', 'anonsm.nsr'));
   CloseGroup;
   (*
   AddItem(TalcuDictionaryTreeItem.Make('anonAccGroups', '������ �������', da_dlAccGroups, True, 10));
    Hint:= '������ �������, ��������� ������� ��������� � ����������� �������';
   AddItem(TalcuDictionaryTreeItem.Make('anonAccGroupsEx', '������ ������� �� ���', da_dlAccGroups, True, 10));
    Hint:= '������ �������, ��������� ������� ��������� � ����������� �������';
   *)
   AddStringItem('anonEmail', '����� ��� �����������');
   
   AddDivider('�������������');
   {$ENDIF}
   l_C:= AddContainerGroup('anonDate', '������������ �����') as TddContainerConfigItem;
    l_C.AddCase('����������� �������������');
     // ������� ���������� �� ���� ������ - �����-����
     //l_C2:= AddContainerGroup('anonDateRules', '������� ����������') as TddContainerConfigItem;
     //l_C.Add(l_C2
    l_C.AddCase('�������� �������');
     l_C.Add(TddDateConfigItem.Create('anonCustomDate', '����', MakeDateValue(IncDay(Today))));
     (* �������� ���������
     l_C.Add(TddDateConfigItem.Create('anonFromDate',   '������� �', MakeDateValue(IncDay(Today))));
     l_C.Add(TddTimeConfigItem.Create('anonFromTime',   '�', MakeDateValue(IncDay(Today))));
     l_C.Add(TddDateConfigItem.Create('anonToDate',     '����������', MakeDateValue(IncDay(Today))));
     l_C.Add(TddTimeConfigItem.Create('anonToTime',     '�', MakeDateValue(IncDay(Today))));
     *)
   CloseGroup;
  CloseChild;
 end;
end;


function CreateConfigEx(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil): TddAppConfiguration;
var
 l_Node: TddCustomConfigNode;
 l_Item, l_Main: TddBaseConfigItem;
 l_Dict: TdaDictionaryType;
begin
 l_Main:= nil;
 Result:= TddAppConfiguration.Create(aStorage);
 with Result do
 begin
  AutoSize:= True;
{$IFDEF ServerAssistantSide}
  AutoSave:= False;
{$ELSE ServerAssistantSide}
  AutoSave:= True;
{$ENDIF ServerAssistantSide}
  LabelTop:= False;
  Version:= 6;
  AddVersionHandler(1, 2, Upgrade1To2);
  AddVersionHandler(2, 3, Upgrade2To3);
  AddVersionHandler(3, 4, Upgrade3To4);
  AddVersionHandler(4, 5, Upgrade4To5);
  AddVersionHandler(5, 6, Upgrade5To6);
  { ������������ ���������. ��� ���� �� ���������� }
  AddBooleanItem(l3CStr('ShowSplash'), l3CStr('���������� ���� ��� ����������� � ����'), False);
  AddBooleanItem(l3CStr('DictEnglish'), l3CStr('������������ ���������� �������� ��������� �������� ������ �������'), False);
  AddBooleanItem(l3CStr('LegalShutdown'), l3CStr('������ ����������� ���������'), True);
  { �������� ��������� }
  AddMainConfig(Result);
  { �������������� ������� }
  AddAutoExportNode(Result);
  AddAutoAnnoChild(Result);
  {$IFDEF AutoSP}
  AddPublInRel(Result);
  {$ENDIF}
  AddAnoncedChild(Result);
  {$IFDEF AutoClass}
  { ����������������� }
  AddAutoClassNode(Result);
  {$ENDIF}
  {$IFDEF Prime}
  { ����� }
  AddPrimeConfig(Result);
  {$ENDIF}
  {$IFDEF Courts}
  { ���� }
  AddCourtDesNode(Result);
  {$ENDIF Courts}
  { ���������� ���������� }
  AddDailyConfig(Result, AutolinkEnabled);
  {$IFDEF EveryWeek}
  { ������������ ���������� }
  AddDeltaConfig(Result);
  {$ENDIF}
  {$IFDEF ExchangeDocs}
  { ������� ������������ ����� }
  AddExternalDeltas(Result);
  {$ENDIF}
  {$IFDEF UserQuery}
  AddQueryExportNode(Result); // ������������ �������
  {$ENDIF}
  {$IFDEF HavanskyExport}
  AddHavanskyExportChild(Result);
  {$ENDIF}
  {$IFDEF MakeSections}
  �������� ��� ����������
//  AddSectionMakerNode(Result);
  {$ENDIF}
  { ����������� � �������� }
  AddNotifyConfig(Result);
  {$IFDEF MDPSyncIntegrated}
  AddMDPSyncChild(Result);
  {$ENDIF MDPSyncIntegrated}
  { ������ ������� }
  AddUserNode(TalcuSchedulerNode.Create('Scheduler', '��������������� �������'));
  Load;
 end;
end;

procedure DestroyConfig;
begin
 l3Free(ddAppConfiguration);
 l3Free(mailAdapter);
end;

procedure CreateConfig(AutolinkEnabled: Boolean; const aStorage: IddConfigStorage = nil);
var
 l_Storage: TddIniStorage;
begin
 ddAppConfiguration := CreateConfigEx(AutolinkEnabled, aStorage);
end;





end.
