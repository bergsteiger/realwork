unit alcuTaskManager;
{ $Id: alcuTaskManager.pas,v 1.118 2015/10/19 12:55:30 lukyanets Exp $ }

// $Log: alcuTaskManager.pas,v $
// Revision 1.118  2015/10/19 12:55:30  lukyanets
// �������������� ������� � ������� �����
//
// Revision 1.117  2015/10/19 11:13:53  lukyanets
// �� ��������� ������ � �� ��������������� ��� ��������� �������� �������
//
// Revision 1.116  2015/10/13 14:10:55  lukyanets
// ������������� ��������� �� �������� ����
//
// Revision 1.115  2015/10/13 09:02:29  lukyanets
// Cleanup
//
// Revision 1.114  2015/10/05 14:08:17  lukyanets
// �� �� ������
//
// Revision 1.113  2015/09/11 08:31:27  lukyanets
// �������� �������� ������
//
// Revision 1.112  2015/09/10 13:42:26  lukyanets
// ��������� �������� ������ �� �������
//
// Revision 1.111  2015/09/10 13:03:05  lukyanets
// ��������� �������� ������ �� �������
//
// Revision 1.110  2015/09/10 12:45:31  lukyanets
// �������� ������ � ����
//
// Revision 1.109  2015/09/08 14:38:11  lukyanets
// ��������� ������� ����������
//
// Revision 1.108  2015/09/08 06:46:13  lukyanets
// ������������� ���
//
// Revision 1.107  2015/09/07 14:21:34  lukyanets
// ������������� ���
//
// Revision 1.106  2015/07/02 07:34:39  lukyanets
// ��������� �������
//
// Revision 1.105  2015/05/08 07:52:49  lukyanets
// Cleanup
//
// Revision 1.104  2015/04/16 06:59:18  lukyanets
// ����� � ����
//
// Revision 1.103  2015/04/15 13:56:11  lukyanets
// ���� ������� ����������� �������� ���� �������
//
// Revision 1.102  2015/04/07 07:35:53  lukyanets
// ��������� HT
//
// Revision 1.101  2015/03/10 11:12:21  lukyanets
// �� ��������� Assert
//
// Revision 1.100  2015/03/02 12:42:59  lukyanets
// ��������� ������ � �������
//
// Revision 1.99  2015/02/26 17:48:47  kostitsin
// Mult*y -> Multi
//
// Revision 1.98  2015/02/25 08:48:34  lukyanets
// MDPSync ���������� ����� ����� ������.
//
// Revision 1.97  2015/02/19 11:07:21  lukyanets
// ��������� ��� �������� ��������������� �������
//
// Revision 1.96  2015/02/19 09:40:12  lukyanets
// ��������� ��� �������� ��������������� �������
//
// Revision 1.95  2015/02/18 17:17:10  lulin
// - bug fix: �� ����������.
//
// Revision 1.94  2015/02/18 14:44:04  lukyanets
// ��������� ��� �������� ��������������� �������
//
// Revision 1.93  2015/01/30 12:58:44  lukyanets
// ����� �����������
//
// Revision 1.92  2015/01/30 12:10:10  lukyanets
// ������ ����������� �� ��������� ������ �����
//
// Revision 1.91  2015/01/23 13:18:46  lukyanets
// ����� � ����
//
// Revision 1.90  2015/01/22 14:31:12  lukyanets
// ��������� ������� ������ � ����� ���������� �����
//
// Revision 1.89  2015/01/21 12:10:24  lukyanets
// ��������� deadlock
//
// Revision 1.88  2015/01/20 15:18:44  lukyanets
// ��������� ����������� Deadlock
//
// Revision 1.87  2014/12/24 14:35:47  lukyanets
// ��������� ��������� � ������������� ��������
//
// Revision 1.86  2014/12/19 14:24:26  lukyanets
// ������� �����
//
// Revision 1.85  2014/12/19 12:36:36  lukyanets
// ��������� ������� ��������� ���������
//
// Revision 1.84  2014/12/19 11:48:52  lukyanets
// ��������� ������� ��������� ���������
//
// Revision 1.83  2014/12/18 15:02:37  lukyanets
// �������� ������� � �������� �����
//
// Revision 1.82  2014/12/17 11:02:54  lukyanets
// ��� �������� ������� ��� � ������� �����
//
// Revision 1.81  2014/12/12 12:13:23  lukyanets
// ���������� � 2 ���� � �����������
//
// Revision 1.80  2014/12/08 15:02:26  lukyanets
// ���������
//
// Revision 1.79  2014/12/02 13:07:14  lukyanets
// ���������� �������� �� ������������
//
// Revision 1.78  2014/12/02 07:30:27  lukyanets
// ������ ���������
//
// Revision 1.77  2014/11/28 15:18:43  lukyanets
// �������� ����������
//
// Revision 1.76  2014/11/27 14:00:13  lukyanets
// ���������� ���� ������� ������
//
// Revision 1.75  2014/11/26 14:40:54  lukyanets
// ������� � �������� �����
//
// Revision 1.74  2014/11/26 12:26:33  lukyanets
// � ������ �����
//
// Revision 1.73  2014/11/25 15:36:58  lukyanets
// ��������� �������
//
// Revision 1.72  2014/11/19 07:49:21  lukyanets
// �������� ��������� �������� ��������
//
// Revision 1.71  2014/11/14 14:20:09  lukyanets
// ������� ��������������
//
// Revision 1.70  2014/11/14 12:42:44  lukyanets
// �������� ������ ����� ��� ������ ����������
//
// Revision 1.69  2014/11/14 10:21:36  lukyanets
// ������������� ���
//
// Revision 1.68  2014/11/14 09:12:48  lukyanets
// ������������� ���
//
// Revision 1.67  2014/11/13 15:08:14  lukyanets
// ������������ �������������������� ���������
//
// Revision 1.66  2014/11/07 14:07:21  lukyanets
// ��������� ����������
//
// Revision 1.65  2014/10/23 11:40:24  lukyanets
// ���������� �������� ���������
//
// Revision 1.64  2014/10/22 07:01:57  lukyanets
// Cleanup
//
// Revision 1.63  2014/10/22 06:50:40  lukyanets
// ���������� ����������� ������
//
// Revision 1.62  2014/10/21 13:32:50  lukyanets
// ������� �� ����������� ������� �� ����� ���������� ������
//
// Revision 1.61  2014/10/02 07:45:58  lukyanets
// �� ������ ��������� ������� �����
//
// Revision 1.60  2014/09/24 07:16:22  lukyanets
// {RequestLink:565271071}
//
// Revision 1.59  2014/09/23 11:04:44  lukyanets
// Cleanup
//
// Revision 1.58  2014/09/18 13:37:41  lukyanets
// {RequestLink:565271071} - ��������� �����������
//
// Revision 1.57  2014/09/18 10:05:58  lukyanets
// {RequestLink:565263723}
//
// Revision 1.56  2014/09/15 12:36:19  lukyanets
// �������� ���� �������� -1
//
// Revision 1.55  2014/09/15 11:56:16  lukyanets
// ��������� ���������� ������ �� ������� ����������� �������
//
// Revision 1.54  2014/09/15 09:32:43  lukyanets
// Cleanup
//
// Revision 1.53  2014/09/11 12:45:39  lukyanets
// � ������� ����� ���� ����� ������� *�����* ���������
//
// Revision 1.52  2014/09/11 12:16:56  lukyanets
// ���������/���������� �� ���� ���������� ���������� ������.
//
// Revision 1.51  2014/09/11 10:32:47  lukyanets
// ������ ������ ����� ������
//
// Revision 1.50  2014/09/10 06:38:21  lukyanets
// ����� ����������� + ������ ����� ��� ������������� AACImport
//
// Revision 1.49  2014/09/10 06:18:38  lukyanets
// ����� ���������� �������� ������
//
// Revision 1.48  2014/09/09 08:19:01  lukyanets
// Cleanup
//
// Revision 1.47  2014/09/04 08:15:41  lukyanets
// Cleanup
//
// Revision 1.46  2014/09/02 12:14:29  lukyanets
// �� �������������� � ���������� ������
//
// Revision 1.45  2014/09/02 07:48:05  lukyanets
// ��������� ������� � �������
//
// Revision 1.44  2014/09/01 08:17:36  lukyanets
// Cleanup
//
// Revision 1.43  2014/08/29 13:03:18  lukyanets
// Cleanup
//
// Revision 1.42  2014/08/29 12:47:00  lukyanets
// ���������� ���� � �������
//
// Revision 1.41  2014/08/29 12:25:05  lukyanets
// ��� �������� ������� ������� ����������� ������, ����� ��� ��������������
//
// Revision 1.40  2014/08/29 10:07:41  lukyanets
// Cleanup
//
// Revision 1.39  2014/08/27 12:05:47  lukyanets
// ��������� ������ � ������� � ���� alcuAutoExport
//
// Revision 1.38  2014/08/27 09:41:45  lukyanets
// Cleanup
//
// Revision 1.37  2014/08/25 13:38:50  lukyanets
// ��������� ������ � ����
//
// Revision 1.36  2014/08/25 12:02:09  lukyanets
// ������� ������� ��� ���
//
// Revision 1.35  2014/08/22 12:54:27  lukyanets
// {Requestlink:563199760}. ��������� ������� ������
//
// Revision 1.34  2014/08/21 12:23:31  lukyanets
// {Requestlink:563199760}. ��������� ������ cs_ttAnnoExport � ����
//
// Revision 1.33  2014/08/21 10:17:55  lukyanets
// ���������� ������ �� �������� ������.
//
// Revision 1.32  2014/08/21 09:24:28  lukyanets
// {Requestlink:563199760}. ��������� ������������
//
// Revision 1.31  2014/08/21 07:05:46  lukyanets
// Cleanup
//
// Revision 1.30  2014/08/20 13:45:11  lukyanets
// {Requestlink:558466572}. ����������� ����������� ������������ ������
//
// Revision 1.29  2014/08/19 14:29:54  lukyanets
// {Requestlink:558466572}. ���������� alcuMDP � ������
//
// Revision 1.28  2014/08/19 12:20:32  lukyanets
// Cleanup
//
// Revision 1.27  2014/08/19 11:57:28  lukyanets
// ��������� ������������ cs_tsFrozenRun
//
// Revision 1.26  2014/08/19 11:11:20  lukyanets
// Cleanup
//
// Revision 1.25  2014/08/19 07:55:03  lukyanets
// {Requestlink:560730919}. ���������� �� TaskWithCustomRun
//
// Revision 1.24  2014/08/18 10:56:03  lukyanets
// {Requestlink:562611471}. ������� ����
//
// Revision 1.23  2014/08/15 11:55:40  fireton
// - �� ����������� ������� �� �������
//
// Revision 1.22  2014/08/14 07:09:06  lukyanets
// {Requestlink:560730919}. ���������� ��������� ������������ ������� �����
//
// Revision 1.21  2014/08/11 09:26:28  lukyanets
// ������
//
// Revision 1.20  2014/08/08 12:09:42  lukyanets
// {Requestlink:560730919}. �������� Progressor �� �������
//
// Revision 1.19  2014/08/07 14:02:20  lukyanets
// {Requestlink:556143119}. �������� ����� ��� ���������� ���������� ����� �����
//
// Revision 1.18  2014/08/07 06:40:11  lukyanets
// {Requestlink:556143119}. ��������� � ������� ������������ ������� �� AppConfig
//
// Revision 1.17  2014/08/06 12:35:59  lukyanets
// {Requestlink:556143119}. �������� ������
//
// Revision 1.16  2014/08/06 11:29:11  lukyanets
// {Requestlink:556143119}. �������� ���������� �� ����
//
// Revision 1.15  2014/08/06 10:28:27  lukyanets
// {Requestlink:556143119}. ��������� � ���������� �����
//
// Revision 1.14  2014/08/06 07:55:22  lukyanets
// {Requestlink:556143119}. ������� TaskResult
//
// Revision 1.13  2014/08/05 07:38:13  lukyanets
// Cleanup
//
// Revision 1.12  2014/08/05 06:30:30  lukyanets
// {Requestlink:558466572}. ���������� Define
//
// Revision 1.11  2014/08/04 14:29:43  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - PrimeLite
//
// Revision 1.10  2014/08/04 13:12:39  lukyanets
// {Requestlink:558466572}. ��������� HavanskyExport
//
// Revision 1.9  2014/08/04 09:33:42  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - MisspellCorrect
//
// Revision 1.8  2014/08/04 06:39:00  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - ddDossierMaker
//
// Revision 1.7  2014/08/01 10:22:38  lukyanets
// {Requestlink:558466572}. ��������� ddAppConfiguration
//
// Revision 1.6  2014/07/31 14:05:07  lukyanets
// {Requestlink:558466572}. ��������� ddAppConfiguration
//
// Revision 1.5  2014/07/31 10:16:13  lukyanets
// ������������ ����� ���������� ��� �����
//
// Revision 1.4  2014/07/30 13:29:18  lukyanets
// {Requestlink:556143119}. ��������� TalcuAutoAnnoExport
//
// Revision 1.3  2014/07/30 06:43:42  lukyanets
// {Requestlink:556143119}. ����������� ����������� �����������
//
// Revision 1.2  2014/07/29 08:14:34  lukyanets
// {Requestlink:557844282}. ���� ����������
//
// Revision 1.1  2014/07/28 15:18:17  lukyanets
// {Requestlink:557844282}. ���������� ���������� ProjectDefine.inc
//
// Revision 1.216  2014/07/25 09:45:28  lukyanets
// {Requestlink:557844282}. ��������� dt_mail � �����������
//
// Revision 1.215  2014/07/25 07:33:53  lukyanets
// {Requestlink:557844282}. ��������� dt_mail ����� ����� ������������ ��������� ����� ������
//
// Revision 1.214  2014/07/24 12:05:17  lukyanets
// {Requestlink:556730516}. ����������� � ���������� ������
//
// Revision 1.213  2014/07/24 11:15:50  lulin
// - bug fix: �� ����������.
//
// Revision 1.212  2014/07/24 10:06:08  lukyanets
// {Requestlink:556730516}. ����� ���������� ��������
//
// Revision 1.211  2014/07/24 08:15:53  lukyanets
// {Requestlink:556730516}. ��������� ������������� ���������� �� ������ UserID
//
// Revision 1.210  2014/07/23 12:49:20  lukyanets
// {Requestlink:556730516}. ����������� ����������� ���������
//
// Revision 1.209  2014/07/23 12:11:57  lukyanets
// {Requestlink:556730516}. ���� ����������� �� ����
//
// Revision 1.208  2014/07/23 07:57:29  lukyanets
// {Requestlink:556730516}. ��������� ����
//
// Revision 1.207  2014/07/21 09:26:36  lulin
// - ��������� ������.
//
// Revision 1.206  2014/07/21 06:23:36  lulin
// - ������������ ����.
//
// Revision 1.205  2014/07/21 06:03:05  lulin
// - ���������� ������ � ������� �������.
//
// Revision 1.204  2014/07/18 13:46:15  lukyanets
// {Requestlink:556730516}. ����� ��� ���������� ��������
//
// Revision 1.203  2014/07/17 13:11:56  lukyanets
// {Requestlink:555415882}. � ������ ���������� ���������� ����������� �����
//
// Revision 1.202  2014/07/17 13:02:16  lukyanets
// {Requestlink:555415882}. ���������� � ������ ������������ ����������
//
// Revision 1.201  2014/07/16 15:35:48  lulin
// - �������� ��������.
//
// Revision 1.200  2014/07/16 14:13:02  lulin
// - ���������� "������������" ��������.
//
// Revision 1.199  2014/07/16 13:29:11  lulin
// - ���������� "����������� �������".
// - ����� ���� �� ������ � ������� ������.
//
// Revision 1.198  2014/07/16 10:39:48  lukyanets
// {Requestlink:553422280}. �������� �������
//
// Revision 1.197  2014/07/16 10:16:24  lukyanets
// {Requestlink:553422280}. �� ������������ ������ ��� �������
//
// Revision 1.196  2014/07/16 07:48:08  lukyanets
// {Requestlink:553422280}. �������������� ����������� ����������
//
// Revision 1.195  2014/07/15 07:23:39  lukyanets
// {Requestlink:553422280}. ������������ ������ �� �����
//
// Revision 1.194  2014/07/14 11:47:06  lukyanets
// {Requestlink:553422280}. ���� ����������� ��� ������������ ��������� �����
//
// Revision 1.193  2014/07/11 10:14:40  lukyanets
// {Requestlink:553422280}. ���������� ��������� �� ��������� ������
//
// Revision 1.192  2014/07/11 08:03:33  lukyanets
// {Requestlink:553422280}. �� ��������� ����� ����� ������
//
// Revision 1.191  2014/07/10 13:09:32  lukyanets
// {Requestlink:553422280}. ����������� ��������
//
// Revision 1.190  2014/07/09 13:13:05  lulin
// - ������������ ������ ������� ���������� � ����.
//
// Revision 1.189  2014/07/09 10:42:28  lukyanets
// {Requestlink:553422280}. ��������� ��������� � �������.
//
// Revision 1.188  2014/07/09 08:45:35  lukyanets
// {Requestlink:553422280}. ���������� ����������� �����.
//
// Revision 1.187  2014/07/09 08:00:06  lukyanets
// {Requestlink:553422280}. �� �����.
//
// Revision 1.186  2014/07/09 07:04:29  lukyanets
// {Requestlink:553422280}. ���� ��� ������������ ��������.
//
// Revision 1.185  2014/07/09 06:53:04  lukyanets
// {Requestlink:553422280}. ����� ���������� ��������.
//
// Revision 1.184  2014/07/08 13:57:49  lukyanets
// {Requestlink:553422280}. ����������� � ���������� ���������
//
// Revision 1.183  2014/07/08 11:51:16  lukyanets
// {Requestlink:552022662}. ��������.
//
// Revision 1.182  2014/07/08 09:44:33  lukyanets
// {Requestlink:552022662}. ��������� ������������� ���������� ����� ������ ������������
//
// Revision 1.181  2014/07/08 07:06:25  lukyanets
// {Requestlink:552022662}. ������ ����
//
// Revision 1.180  2014/07/08 07:02:52  lukyanets
// {Requestlink:552022662}. ������ ����
//
// Revision 1.179  2014/07/07 12:10:47  lulin
// - �������� � ������������� TaskType.
//
// Revision 1.178  2014/07/04 09:01:13  lukyanets
// {Requestlink:552022662}. ����� ������������
//
// Revision 1.177  2014/07/03 15:25:22  lulin
// - ������ ���.
//
// Revision 1.176  2014/07/03 13:47:22  lukyanets
// {Requestlink:552022662}. ����� �������
//
// Revision 1.175  2014/07/02 17:13:07  lulin
// - �������� ��� ��������������� ������������� ����� � �����.
//
// Revision 1.174  2014/07/02 14:51:00  lukyanets
// {Requestlink:552022662}. �������� �������
//
// Revision 1.173  2014/07/02 13:15:44  lukyanets
// {Requestlink:552022662}. ����� ������ ������
//
// Revision 1.172  2014/07/01 11:53:48  lulin
// - �� ������ ����� ������ ������ ��� ��� ����������.
//
// Revision 1.171  2014/06/25 14:19:51  lulin
// - ������ ����������� ��������� � ��������� ������.
//
// Revision 1.170  2014/06/24 14:41:07  lulin
// - �������� ������� ��������� ������� � �������� �������������� ���������.
//
// Revision 1.169  2014/06/24 12:35:12  lulin
// - ����������� �������� �������� �������������� �������.
//
// Revision 1.168  2014/06/23 11:36:00  lulin
// - ������� ������ ������ ��������.
//
// Revision 1.166  2014/06/23 10:58:00  lulin
// - ������� ��������� �� �������� ������������ �����������.
//
// Revision 1.165  2014/06/23 10:20:59  lulin
// - ������� ��������� �� �������� �����������.
//
// Revision 1.164  2014/06/23 09:48:05  lulin
// - ������ ���.
//
// Revision 1.163  2014/06/20 14:10:11  lulin
// - ������ ���.
//
// Revision 1.160  2014/06/20 12:32:54  lulin
// - ������ ���.
//
// Revision 1.159  2014/06/20 12:12:43  lulin
// - ������� ����������� ������ �� �������� �����������.
//
// Revision 1.158  2014/06/20 11:33:11  lulin
// - �� �� ���������� ������������ ��������� - ����� �� ����� ����� ���������, �� ����������.
//
// Revision 1.157  2014/06/20 11:24:17  lulin
// - ����� �� ������� �� �� ������������ �� ��������� �������.
//
// Revision 1.156  2014/06/20 10:47:47  lulin
// - ������� � deadlock'���.
//
// Revision 1.155  2014/06/19 17:32:22  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.154  2014/06/19 16:22:27  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.153  2014/06/19 12:07:00  lulin
// - ������ ���������������� ������ �������������.
//
// Revision 1.152  2014/06/18 16:01:38  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.151  2014/06/18 15:54:24  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.150  2014/06/18 15:09:02  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.149  2014/06/18 14:59:46  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.148  2014/06/18 14:35:09  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.147  2014/06/18 14:09:17  lulin
// - ���������� ����������� ������� �������.
//
// Revision 1.146  2014/06/18 12:47:21  lulin
// - ������ ������ ������� �� ������.
//
// Revision 1.145  2014/06/18 12:36:02  lulin
// - ������ ������ ������� �� ������.
//
// Revision 1.144  2014/06/18 12:29:52  lulin
// - ������ ������ ������� �� ������.
//
// Revision 1.143  2014/06/18 11:57:43  lulin
// - ����������� � ���������, ����� ������ ������� �� ����������.
//
// Revision 1.142  2014/06/18 11:44:57  lulin
// - ��������� ������ ������� �� �������� ������.
//
// Revision 1.141  2014/06/18 10:02:15  lulin
// - ������� �������� ����������� ������.
//
// Revision 1.140  2014/06/17 17:49:33  lulin
// - ��������� ���������������� ������ �������.
//
// Revision 1.139  2014/06/17 17:12:52  lulin
// - ��������� ���������������� ������ �������.
//
// Revision 1.138  2014/06/17 17:01:09  lulin
// - ��������� ���������������� ������ �������.
//
// Revision 1.137  2014/06/17 12:32:50  lulin
// - ������ ���.
//
// Revision 1.135  2014/06/17 11:50:59  lulin
// - ������� �������� ��������, �� � ��� ����� �� ������ ��������.
//
// Revision 1.134  2014/06/17 10:33:23  lulin
// - ��������������� �����, ����� �������� �������� ��� ����.
//
// Revision 1.133  2014/06/16 15:53:16  lulin
// - ������ ���.
//
// Revision 1.132  2014/06/16 13:45:09  lulin
// - ������ ���.
//
// Revision 1.129  2014/06/11 08:59:33  lulin
// - ������ ���.
//
// Revision 1.128  2014/06/11 07:22:31  lulin
// - ���������� ����������� �������� ������, � �� ���������������� �.
//
// Revision 1.127  2014/06/11 07:09:13  lulin
// - ���������� �������� ������, � �� ������ � ������������.
//
// Revision 1.126  2014/06/11 07:01:06  lulin
// - ������ ���.
//
// Revision 1.125  2014/06/10 17:57:45  lulin
// - �������������� "�������" ����������� ������.
//
// Revision 1.124  2014/06/10 16:55:37  lulin
// - ������ ��� � �������� �����������.
//
// Revision 1.123  2014/06/09 12:05:58  lulin
// - ������� � ��� ����� � ������������.
//
// Revision 1.122  2014/06/06 15:58:53  lulin
// - �������� �����������.
//
// Revision 1.121  2014/06/06 11:27:26  lulin
// - ���������� ���������� ������, ����� ��� �� ���� �������� ������������.
//
// Revision 1.120  2014/06/06 11:20:01  lulin
// - ������ ���.
// - ���������� ������.
//
// Revision 1.119  2014/06/05 14:59:00  lulin
// - ������ ���.
// - �������� �����������.
//
// Revision 1.118  2014/06/05 12:09:12  lulin
// - ������ ���.
//
// Revision 1.117  2014/06/05 12:01:12  lulin
// - ����������� � ����������� ��������� � �������� �������.
//
// Revision 1.116  2014/06/04 16:03:17  lulin
// [$540613122]
//
// Revision 1.115  2014/06/03 15:34:10  lulin
// - ������ ��� ������������ ������� ��������� �������� ������ ����.
//
// Revision 1.114  2014/06/02 10:16:16  lulin
// - �������� �����.
//
// Revision 1.113  2014/05/30 17:28:02  lulin
// - ���������� ��������� ������.
//
// Revision 1.112  2014/05/29 17:08:59  lulin
// - ������ ���.
//
// Revision 1.111  2014/05/29 16:39:59  lulin
// - ��������������� �������� ��������.
//
// Revision 1.110  2014/05/29 09:22:51  lulin
// - ������ ���.
//
// Revision 1.108  2014/05/29 08:19:04  lulin
// - ������ ���.
//
// Revision 1.107  2014/05/29 07:47:59  lulin
// - ����������� �� "���� �� ���".
//
// Revision 1.106  2014/05/28 12:45:49  lulin
// - ������������ ����������� �� ��������� ��������� �������.
//
// Revision 1.105  2014/05/28 07:58:50  lulin
// - ������ ���.
//
// Revision 1.104  2014/05/28 07:38:19  lulin
// - ������� �������� �������� ����� �������� �������.
//
// Revision 1.103  2014/05/27 09:50:35  lulin
// - ������ ����.
//
// Revision 1.102  2014/05/15 17:52:45  lulin
// {RequestLink:517789752}.
//
// Revision 1.101  2014/05/14 13:56:33  lulin
// {RequestLink:517789752}.
//
// Revision 1.100  2014/05/13 12:35:17  lulin
// - ����������� ���������� �������.
//
// Revision 1.99  2014/04/17 13:07:50  voba
// - ������� ISab �� DT_Sab � dtIntf
//
// Revision 1.98  2014/02/17 13:03:46  GarikNet
// K:516544010
//
// Revision 1.97  2014/02/17 12:24:11  GarikNet
// K:516544010
//
// Revision 1.96  2014/02/17 10:28:42  GarikNet
// K:516544010
//
// Revision 1.95  2014/02/14 17:45:49  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.94  2014/02/14 17:42:37  lulin
// - ����������� �� ������ ���������.
//
// Revision 1.93  2014/02/14 10:57:21  GarikNet
// K:516544010
//
// Revision 1.92  2014/02/12 15:32:12  lulin
// - ������������ �������� ������� ������ ������� �� ����� ���������� ��������.
//
// Revision 1.91  2014/02/12 14:55:22  lulin
// - ������ ��� ������.
//
// Revision 1.90  2014/02/12 12:39:12  lulin
// - ���������� ������ �������.
//
// Revision 1.89  2014/02/12 10:15:35  GarikNet
// K:515862135
//
// Revision 1.88  2014/02/12 06:04:38  GarikNet
// K:516544010
//
// Revision 1.87  2014/02/11 15:46:10  lulin
// {RequestLink:516544329}
//
// Revision 1.86  2014/02/10 16:27:59  lulin
// {RequestLink:516533785}.
// - ���������� ���������� �������� ������� ��� {RequestLink:515862135}.
//
// Revision 1.85  2014/02/10 14:50:35  lulin
// {RequestLink:516533785}.
//
// Revision 1.84  2014/02/10 11:00:00  GarikNet
// K:515862135
//
// Revision 1.83  2014/02/10 07:54:06  GarikNet
// K:516189258
//
// Revision 1.82  2014/02/10 06:27:07  GarikNet
// K:515862135
//
// Revision 1.81  2014/02/04 11:29:17  GarikNet
// �������� �������
//
// Revision 1.80  2014/02/03 12:13:41  GarikNet
// K:515529250
// ������ ��������� � ������ �������� ����� ��� �� ����������
// �� ��������� ���� (�������� ��������� ����������� �������
// � ������ �������)
//
// Revision 1.79  2013/04/04 11:22:27  narry
// ���������� ���� ������������� (447388742)
//
// Revision 1.78  2013/04/03 09:50:41  fireton
// - ������ ����������� VANONCED
//
// Revision 1.77  2013/02/21 07:35:01  narry
// �������������� ���������� ��������
//
// Revision 1.76  2013/02/12 11:35:46  narry
// ����������� ����������� ����������� � ���������� ��������� ��������
//
// Revision 1.75  2013/02/05 10:13:46  narry
// �� �������� ��������� ���� ���� (��� �������� ������� ������ � ������)
//
// Revision 1.74  2013/01/28 11:41:26  narry
// ��������� �����������  (425270949)
//
// Revision 1.73  2013/01/11 12:14:40  narry
// * �������������� �������� ����������� �������� ���������� (��)
// * �������������� ���������� �� �� FTP
// * ������ �������� ����
//
// Revision 1.72  2012/10/18 07:15:27  narry
// ������ pipeout2, ������� ������� ������ ����� � ���������� (383583730)
//
// Revision 1.71  2012/10/02 07:39:35  narry
// ��������� ��������� ���������� � ����
//
// Revision 1.70  2012/08/28 10:07:09  narry
// ������ �� ���������� ������ ��� ���������� ������� � ������� �������
//
// Revision 1.69  2012/08/13 12:46:08  narry
// ����������
//
// Revision 1.68  2012/08/02 13:16:28  narry
// ����������� ������� �� ���������� ���������� (380619133)
//
// Revision 1.67  2012/07/13 11:29:10  narry
// ����������� �������� �� ����
//
// Revision 1.66  2012/07/10 11:01:36  narry
// ����������� �� ������� ��������� (375424179)
//
// Revision 1.65  2012/07/10 09:31:08  narry
// ����������� � ������� ���������������� ������� (274847170)
//
// Revision 1.64  2012/05/28 10:58:56  narry
// ����������
//
// Revision 1.63  2012/05/14 09:28:41  narry
// �������������� ������� (269063217)
//
// Revision 1.62  2012/05/12 12:21:05  narry
// �� ������������ _MessageManager
//
// Revision 1.61  2012/05/11 13:05:14  narry
// �� ������������� ��������� ���� (363566409)
//
// Revision 1.60  2012/04/17 13:23:15  narry
// ����������� ������� ������� (356073078)
//
// Revision 1.59  2012/03/06 09:16:40  narry
// �������� � ������� ������ ����� ������� ���������� � ������ (273581950)
//
// Revision 1.58  2012/02/10 11:33:49  narry
// �� ����������� ������� ��� ����������� (336665219)
//
// Revision 1.57  2011/12/08 11:15:52  narry
// ������ ����������
//
// Revision 1.56  2011/11/23 09:21:36  narry
// ������� ��������� ������ (302744313)
//
// Revision 1.55  2011/11/17 05:11:28  narry
// �� ����������
//
// Revision 1.54  2011/11/16 10:17:36  narry
// ���������� ������� �� � � ������ ������������� (298682480)
//
// Revision 1.53  2011/10/10 10:43:25  narry
// �� �������� �������� ���������� � �������
//
// Revision 1.52  2011/05/16 13:37:00  narry
// ��������� ������� �� ������ "��������������" ������������� (266409024)
//
// Revision 1.51  2011/05/13 09:28:45  narry
// �������� ���������� ���������� ������� (������)  (260447411)
//
// Revision 1.50  2011/05/12 08:55:57  narry
// �������� ���������� ���������� ������� (������)  (260447411)
//
// Revision 1.49  2011/05/12 05:21:21  narry
// �������� ���������� � ������� (������) (260447428)
//
// Revision 1.48  2011/04/22 11:44:09  narry
// ������� �� ������ (262636470)
//
// Revision 1.47  2011/04/08 07:04:15  narry
// �260442621. ������� ������ ������������� ��� ��������
//
// Revision 1.46  2011/03/11 11:18:54  narry
// K255975299. �� ������������� ������
//
// Revision 1.45  2011/01/19 08:18:41  narry
// ������������ ����� � ��� ����� ������ ���������� �������
// ���������� ������ ��� ����� �������, ��� ������� ������
//
// Revision 1.44  2010/09/24 12:41:08  voba
// - k : 235046326
//
// Revision 1.43  2010/08/18 11:29:07  narry
// - �� ���������� � ����� � ��������������� dt_Srch2
//
// Revision 1.42  2010/07/27 06:49:59  narry
// �228690493
//
// Revision 1.41  2010/07/21 09:14:53  narry
// �91850862
//
// Revision 1.40  2010/07/20 14:21:25  narry
// �214599203
//
// Revision 1.39  2010/07/15 14:21:09  narry
// - K226005135. ��������� �������� ����������� � ����������� ��������
//
// Revision 1.38  2010/07/06 12:27:02  narry
// - �222759027
//
// Revision 1.36  2010/05/19 10:59:30  narry
// - K211878089
//
// Revision 1.35  2010/05/17 10:37:25  narry
// - K211878122
//
// Revision 1.34  2010/05/14 13:18:05  narry
// - K211878137
// - ��������� ��� ���
//
// Revision 1.33  2010/04/20 09:49:29  narry
// - ����������
//
// Revision 1.32  2010/04/02 12:11:26  narry
// - ��������� �� ������� ���������� �������
//
// Revision 1.31  2010/03/24 05:57:02  narry
// - �� �������������� ������� ������� ��� �����
//
// Revision 1.30  2010/03/19 14:01:58  narry
// - ����� ��������, �������� �������� ��������� �������
// - ��������� ������� � ������������ � ������������
//
// Revision 1.29  2010/02/25 06:38:10  narry
// - �������� ����������� �������� �� �����
// - ���������� ��������� ������� ������� �� ����� ������������� ����������
//
// Revision 1.28  2009/11/10 08:20:06  narry
// - ����������
// - ������� ������������ ��������� � �����
//
// Revision 1.27  2009/06/24 13:12:59  narry
// - ��������� ��� ����� LinkServer
//
// Revision 1.26  2009/06/16 13:20:53  narry
// - ���� ������� ������ ���������� ��������, ������ ��������� ��� ���������� �� �����������
//
// Revision 1.25  2009/05/27 12:29:20  narry
// - ����������
//
// Revision 1.24  2009/03/17 09:30:01  narry
// - ��������� ������ � ���� ���������� �� �������� ����� � ����������
//
// Revision 1.23  2009/02/20 13:29:35  narry
// - ����������
//
// Revision 1.22  2009/02/16 14:33:13  narry
// - ����������
//
// Revision 1.21  2009/01/30 10:04:35  narry
// - ����������
//
// Revision 1.20  2009/01/26 08:59:44  fireton
// - ������� � ������ b_archi_NewSrch2 (����� ��-������)
//
// Revision 1.19  2009/01/23 16:27:47  narry
// - �����������
//
// Revision 1.18.2.1  2009/01/23 14:07:40  fireton
// - ������� ����� �� Query
//
// Revision 1.18  2008/11/24 15:09:58  narry
// - ������ ��� �������� ��� ������� � �������
//
// Revision 1.17  2008/10/30 12:56:59  narry
// - ������ ��
// - ����������
//
// Revision 1.16  2008/10/29 10:03:25  narry
// - ������� ����������� "�������� � �������" �� ISab
//
// Revision 1.15  2008/10/13 12:38:41  narry
// - ������������� ����������
//
// Revision 1.14  2008/09/25 08:25:11  narry
// - ���������� ���������� ���� ������, ������������ �� ���� ����������
//
// Revision 1.13  2008/08/20 14:43:36  narry
// - ������ � "��������� ������"
//
// Revision 1.12  2008/07/24 11:50:46  fireton
// - ����������� ������� �� ���������� ������� � ������������
//
// Revision 1.11  2008/07/21 11:46:09  fireton
// - ������ (������ � ����������)
//
// Revision 1.10  2008/07/16 16:14:04  narry
// - ���������� �����������
//
// Revision 1.9  2008/07/14 08:08:42  narry
// - ������������� ���������� ������� ��
//
// Revision 1.8  2008/07/10 13:01:13  fireton
// - refactoring: ���� ����������� ������� ��������� "������"
//
// Revision 1.7  2008/06/06 15:08:03  narry
// - ����������
//
// Revision 1.6  2008/05/27 06:55:20  narry
// - �������������� �����
//
// Revision 1.5  2008/05/14 11:23:36  narry
// - ���������� ������ ���������� � ��� ���� ��� ��������
// - ����������� ������������
// - ��������� ������
//
// Revision 1.4  2008/04/23 10:43:15  narry
// - ����������
//
// Revision 1.3  2008/03/24 09:41:51  narry
// - ��� �������� ��������� � ����� �� ���������� ��������� ��� ����������
//
// Revision 1.2  2008/03/13 14:02:24  narry
// - �����������
//
// Revision 1.1  2008/03/04 12:09:52  narry
// - ������� ddServerTaskManager � ������
//
// Revision 1.58  2008/03/04 11:43:58  narry
// - ������� ��������� ��������� � ��������� ������
//
// Revision 1.57  2008/02/27 15:46:55  narry
// - ����������� ��������� ���� ����� ��������
// - ������� ����������
// - ���� deleted.lst
//
// Revision 1.56  2008/02/19 16:01:51  narry
// - ������� �������� �� garant\base.ini � ������������
//
// Revision 1.55  2008/02/06 09:27:36  narry
// - �� ���������������
//
// Revision 1.54  2008/02/01 16:41:32  lulin
// - ���������� �������� ������.
//
// Revision 1.53  2008/02/01 13:38:21  narry
// - �� ���������������
//
// Revision 1.52  2008/01/30 09:20:35  narry
// - �� ��������� ����������������� ����������� ���������� � ����� ����
//
// Revision 1.51  2007/12/25 12:03:21  narry
// - ����������
//
// Revision 1.50  2007/12/07 08:44:57  narry
// - ������ � ��� �� ��������� ������� ������ ����� ����� �������������
//
// Revision 1.49  2007/12/06 11:11:58  narry
// - ��������� �����������������
//

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
 Windows, Classes, SyncObjs, SysUtils, Messages, ExtCtrls,
 {$IFNDEf Service}Forms,{$ENDIF}
 l3Base, l3Date, l3LongintList, l3Interfaces, 
 dt_Types,
 //dt_Tasks,
 dt_Doc, dt_Mail, l3BaseStream, l3Memory,
 ht_Const, CsQueryTypes,
 csProcessTask, ddImportPipe, ExportPipe, ddProgressObj,
 l3IniFile, l3ObjectRefList,
 CSDataPipe, csMessageManager,
 ddServerTaskList, alcuDictManager, ddScheduler, dtIntf, dt_Sab, alcuTypes,
 csServerCommandsManager, csTaskTypes, ddServerTask, DT_AskList, alcuTaskList,

 l3ProtoObject,
 alcuTaskListPrim,
 ddServerTaskManagerPrim,
 alcuNotSortedTaskList,
 alcuTaskListBase,
 l3MultiThreadSortedIntegerList,
 dtUserIDList,
 l3Types,
 alcuSubmitterWorkPool,
 alcuBaseEngineHolder,
 alcuServerAsyncExecutionInterfaces,
 ncsServerTransporterPool,
 ncsMessageInterfaces,
 ncsMessage, csCommon, alcuDeliveryInterfaces,
 alcuDetachedExecutorPool
 ;

type
 TddServerTaskManager = class(TddServerTaskManagerPrim, IalcuAsyncTaskFinishedNotifier, IcsRunTaskServices,
                              IncsMessageExecutorFactory, IalcuTaskFinisher, Il3ChangeRecipient)
 private
    //FOnProcessTask: TddProcessTaskEvent;
    f_Actions: TcsServerCommandsManager; // ������ ���������� �� ������ ��������� �������
    f_ActiveTaskList: TalcuTaskList; // ������ �������, ��������� ����������
    f_ActiveTask: TddProcessTask;
    f_Busy: Boolean;
    f_CommonDataList: TalcuNotSortedTaskList;
    //f_CS: TCriticalSection;
    f_BaseEngineHolder: TalcuBaseEngineHolder; // ������
    //f_CurTaskValue: Int64;
    f_DelayedList: TalcuTaskList;
    //f_DeleteEvent: TTaskListDeleteEvent;
    //f_DeleteQuery: Boolean;
    f_DictManager: TalcuDictionaryManager;
    //f_DoWorkup: Boolean;
    f_EnabledTaskTypes: TcsTaskTypes; // ���� ����� ������� ����� ����������
    f_TaskExecutionEnabled: Boolean; // ���������� "�� ���" ��������� ��� �������
    //f_LastTaskID: string;
    f_LastUpdate: TDateTime;
    f_LastChangedTask: TddProcessTask;
    f_LastChangedStatus: TcsTaskStatus;
    f_LastDelivering: TDateTime;
    f_LockProcessingCounter: Integer; // ������� ��������� ������� ������������� ��� f_LockProcessingCounter > 0
    f_MessageManager: TcsMessageManager;
    f_MonitorUsers: Tl3MultiThreadSortedIntegerList;
    f_PrivateMonitorUsers: Tl3MultiThreadSortedIntegerList;
    {$IFNDEF Service}
    f_OnException: TExceptionEvent;
    {$ENDIF}
    f_OnSendEmail: TSendEmailNotify;
    f_OnStatusChanged: TalcuStatusNotify;
    f_OnTaskListChanged: TddTaskListChangedEvent; // ������� ��������� ������� ������� ��� ��� ����������
    f_Processing: Boolean; // ������� ��������� ������ ������� �� ������� �������
    f_Progressor: TddProgressObject;
    f_IncomingTasks : TddServerTaskList; // ������ ����� ������� ������� ��������� ����������� � f_ActiveTaskList
    f_ChangedTasks : TddServerTaskList;
    f_NeedUpdateAllTask: Boolean;
    //f_RefreshEvent: TTaskListRefreshEvent;
    f_RequestList: TddServerTaskList;
    f_RootTaskFolder: string; // ����� � ��������
    f_StartDate: TDateTime;
    f_Status: TalcuStatus;
    //f_Status: TddTaskManagerStatus;
    f_TaskList: TalcuNotSortedTaskList; // ������ ��� ����������� ���� ����� �� ������� �����
    f_UpdatePeriod: LongInt;
    f_UserQueries: TQueryList;
    f_WorkPool: TalcuSubmitterWorkPool;
    f_WorkPoolManager: IalcuAsyncSubmitterManager;
    f_AddedActiveTaskCount: Integer;
    //f_CanMakeSaveActivTaskList: boolean;
    f_TransporterPool: TncsServerTransporterPool;
    f_DetachedExecutorPool: TalcuDetachedExecutorPool;
    f_LockTaskExecution: Integer;
    f_ServerStarted: Boolean;
    procedure AddDelayedTask(aTask: TddProcessTask);
    procedure ChangeServerStatus(atask: TddProcessTask);
    procedure CheckDeliveringTasks;
    procedure ClearTask(aTask: TddProcessTask);
    procedure DoCommand(aTask: TddProcessTask);
    procedure DoChangeDictItem(aTask: TddProcessTask);
    procedure DoRemoteChangeDictItem(aTask: TddProcessTask);
    procedure DoChangeUserItem(aTask: TddProcessTask);
    procedure DoSaveUserDefinedExport(aTask: TddProcessTask);
    procedure DoDeleteDocs(aTask: TddProcessTask);
    function pm_GetActiveTaskListCount: Integer; // ���������� ����� ��������� ����������
    function pm_GetCurrentUserName: string;
    function pm_GetLineLen: Integer;
    function pm_GetProcessingLocked: Boolean; // TRUE - ��������� ������� ������� �������������
    procedure pm_SetTaskExecutionEnabled(const Value: Boolean); // ��������� ���������� ��������� ��� �������
    procedure pm_SetEnabledTaskTypes(const Value: TcsTaskTypes);
(*    procedure pm_SetProcessing(const Value: Boolean);*)
    procedure pm_SetRootTaskFolder(const Value: string); // ��������� ����� � �������� f_RootTaskFolder
    procedure pm_SetStatus(const Value: TalcuStatus);
    procedure RunTask(aTask: TddProcessTask);
    procedure SaveQuery;
    procedure SchedulerClientNotify(aTask: TddSchedulerTask);
    procedure pm_SetProgressor(const Value: TddProgressObject);
    procedure pm_SetMessageManager(const Value: TcsMessageManager);
    function pm_GetWorkThreadCount: Integer;
    procedure pm_SetWorkThreadCount(const Value: Integer);
  protected
    procedure TaskDone(aTask: TddProcessTask); // �������� ������ �� ������ f_ActiveTaskList
    procedure DoTaskChanged(aTask: TddTaskItem; PrevStatus: TcsTaskStatus); override;
  private
    procedure TaskListUpdated(aTask: TddProcessTask);
    procedure WorkupRequests;
    procedure SubmitAsyncTasks;
    procedure CancelDelivering(aCLientID: TcsClientID);
  {$IFDEF InsiderTest}
    procedure TrySimulateTaskDone(const aTask: TddProcessTask);
  {$ENDIF InsiderTest}
    function AllowTaskExecution: Boolean;
 protected
    procedure AbortTask(const aTask: TddProcessTask);
    procedure FreezeTask(const aTask: TddProcessTask);
    procedure CalculatePriority(aTask: TddProcessTask);
    procedure Cleanup; override;
    procedure Exception2Log(E: Exception);
    function AllowAsyncRunTask(const aTask: TddProcessTask): Boolean;
 public
    function WorkupTaskByIDF(const ID: String; anAction: alcuTasksIterator_ForOneF_Action): Boolean;
 protected
    function MakeTaskFileName(aTask: TddProcessTask): string;
 protected
   // IalcuAsyncTaskFinishedNotifier
   procedure TaskFinished(const aTask: TddProcessTask);
   // IcsRunTaskServices
   procedure SendTextMessage(anUserID: TUserID;
    const aMessage: AnsiString);
   // IncsMessageExecutorFactory
   function MakeExecutor(aMessage: TncsMessage): IncsExecutor;
   // Il3ChangeRecipient
   procedure Changing;
     {* �������� ���������. }
   procedure Changed;
     {* ����������� ���������. }
     {$If defined(InsiderTest)}
 public
   CanSimulateTaskDone : Boolean;
 protected
   procedure SimulateTaskDone(aTask: TddProcessTask); virtual;
     {* ��������� �������� ���������� ������������ ����� ���������� ������� }
     {$IfEnd} //InsiderTest
     {$If defined(InsiderTest)}
   procedure BeforeSaveQuery; virtual;
     {* ��������� ������ BeforeSaveQuery }
     {$IfEnd} //InsiderTest
     {$If defined(InsiderTest)}
   function NeedRaiseInProcessQuery: Boolean; virtual;
     {$IfEnd} //InsiderTest
 public
    constructor Create(const aRootTaskFolder: String; const aBaseEngineHolder: TalcuBaseEngineHolder);
    procedure AddUserInMonitor(Stream: Tl3Stream);
    procedure AddUserInPrivateMonitor(Stream: Tl3Stream);
    procedure DeleteUserOfMonitorS(Stream: Tl3Stream);
    function AddTaskFromStreamToIncoming(Stream: Tl3Stream; const aRootTaskFolder: String; aisPipe: Boolean): integer;
    function AddTaskToIncoming(const aTask: TddProcessTask): integer;
(*    procedure AddMonitoringUser(aUserID: TUserID);*)
    procedure AddRequest(const aRequest: TddProcessTask);
    procedure AddActiveTask(const aTask: TddProcessTask);
//    procedure CheckTaskType(var aTask: TddProcessTask);
//    procedure ClearQueryQueue(aSendMessage: Boolean);
    procedure FreezeQueryQueue;
    procedure FreezeRunningSyncTask;
    procedure cs_ExecuteCommand(aPipe: TCSDataPipe);
    procedure cs_GetActiveUsers(aPipe: TCSDataPipe);
    procedure cs_GetNextVersionDate(aPipe: TCSDataPipe);
    procedure cs_GetCommonData(aPipe: TCSDataPipe);
    procedure cs_GetTime(aPipe: TCSDataPipe);
    procedure cs_LineRequestReply(aPipe: TCSDataPipe);
    procedure cs_ReturnResult(aPipe: TCSDataPipe);
    procedure cs_ReturnTask(aPipe: TCSDataPipe);
    procedure cs_SendMail(aPipe: TCSDataPipe);
    procedure cs_ServerTaskReply(aPipe: TCSDataPipe);
    procedure cs_StartMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_StartMyMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_StopMonitoringReply(aPipe: TCSDataPipe);
    procedure cs_AsyncProgress(aPipe: TCSDataPipe);
    procedure cs_ReceiveTaskResult(aPipe: TCSDataPipe);
    procedure cs_RequestDeliveryTaskList(aPipe: TCSDataPipe);
    procedure cs_ExportResultProcessing(aPipe: TCSDataPipe);
    procedure cs_TransporterHandshake(aPipe: TCSDataPipe);
    procedure cs_TaskSend(aPipe: TCSDataPipe);
    procedure cs_TerminateTask(aPipe: TCSDataPipe);
    procedure DeleteTask(aTask: TddProcessTask; aSendMessage: Boolean);
    procedure LoadQuery; // ��������� ������� �� �����
    procedure LockProcessing; // inc(f_LockProcessingCounter) - ���������� ������� ������� �������
    procedure ProcessQuery; // ��������� �������� ��������� �������
    procedure ProcessIncomingTasks;
    procedure WaitForAsyncRunningTasks;
    procedure cs_GetExecuteStatus(aPipe: TcsDataPipe);
    procedure cs_GetDictChangeFileName(aPipe: TCSDataPipe);
    procedure cs_GetCompileDate(aPipe: TCSDataPipe);
    procedure cs_GetToRegionList(aPipe: TcsDataPipe);
    procedure ExcludeTaskType(aTaskType: TcsTaskType);
    procedure IncludeTaskType(aTaskType: TcsTaskType);
    procedure MakeCaseCodeGenerateTask;
(*    procedure SetTaskPriority(aTaskID: ShortString; aPriority: Integer);*)
    procedure StopProcessQuery(aTask: TddProcessTask);
(*    procedure TaskListChanged(aTask: TddProcessTask);*)
    procedure UnLockProcessing; // dec(f_LockProcessingCounter). ��� f_LockProcessingCounter = 0 ������ ������� ������� �������������
    procedure WorkupDelayed;
    procedure NotifyProgress(TotalPercent: Long; const TotalCaption: AnsiString);
    procedure LockAsyncRun;
    procedure UnLockAsyncRun;
    procedure LockTaskExecution;
    procedure UnlockTaskExecution;
    function TaskExecutionLocked: Boolean;
    function ExecutingTask: Boolean;
    procedure SignalServerStarted;
    property Actions: TcsServerCommandsManager read f_Actions write f_Actions;
    property ActiveTaskList: TalcuTaskList read f_ActiveTaskList;
    property ActiveTaskListCount: Integer read pm_GetActiveTaskListCount; // ���������� ����� ��������� ����������
    property CurrentUserName: string read pm_GetCurrentUserName;
//    property DeleteQuery: Boolean read f_DeleteQuery write f_DeleteQuery;
    property DictManager: TalcuDictionaryManager read f_DictManager;
    property TaskExecutionEnabled: Boolean read f_TaskExecutionEnabled write pm_SetTaskExecutionEnabled; // ���������� "�� ���" ��������� ��� �������
    property EnabledTaskTypes: TcsTaskTypes read f_EnabledTaskTypes write pm_SetEnabledTaskTypes;
    property LineLen: Integer read pm_GetLineLen;
    property MessageManager: TcsMessageManager read f_MessageManager write pm_SetMessageManager;
    property Processing: Boolean read f_Processing{ write pm_SetProcessing};
    property Progressor: TddProgressObject read f_Progressor write pm_SetProgressor;
    property ProcessingLocked: Boolean read pm_GetProcessingLocked;  // TRUE - ��������� ������� ������� �������������
    property RootTaskFolder: string read f_RootTaskFolder write pm_SetRootTaskFolder;
    property Status: TalcuStatus read f_Status write pm_SetStatus;
    property TaskList: TalcuNotSortedTaskList read f_TaskList;
    property UpdatePeriod: LongInt read f_UpdatePeriod write f_UpdatePeriod;
    property UserQueries: TQueryList read f_UserQueries;
    property AddedActiveTaskCount: Integer read f_AddedActiveTaskCount;
    property WorkThreadCount: Integer read pm_GetWorkThreadCount write pm_SetWorkThreadCount;
(*    property OnDelete: TTaskListDeleteEvent read f_DeleteEvent write
            f_DeleteEvent;*)
    {$IFNDEF Service}
    property OnException: TExceptionEvent read f_OnException write f_OnException;
    {$ENDIF}
(*    property OnProcessTask: TddProcessTaskEvent read FOnProcessTask write
            FOnProcessTask;
    property OnRefresh: TTaskListRefreshEvent read f_RefreshEvent write
            f_RefreshEvent;*)
    property OnSendEmail: TSendEmailNotify read f_OnSendEmail write f_OnSendEmail;
    property OnStatusChanged: TalcuStatusNotify read f_OnStatusChanged write
        f_OnStatusChanged;
    property OnTaskListChanged: TddTaskListChangedEvent read
            f_OnTaskListChanged write f_OnTaskListChanged;
  end;//TddServerTaskManager

(*var
 ddEnableMonitoring: Boolean = False;*)

const
 alcuAllTaskTypes = [cs_ttImport, cs_ttExport, {$IFDEF AutoClass}cs_ttAutoClass,{$ENDIF AutoClass}
                  cs_ttAnnoExport, cs_ttAExportAnno, cs_ttAExportDoc, cs_ttRegionAutoExport,
                  cs_ttDossierMake, cs_ttCaseCode, cs_ttSpellCheck, cs_ttAutoSpellCheck{$IFDEF UpdateAsTask},
                  cs_ttEverydayUpdate, cs_ttLoaddelta{$ENDIF}, cs_ttAACImport, cs_ttUnregistered,
                  cs_ttRelPublish, cs_ttAnoncedExport, cs_ttHavanskyExport, cs_ttMdpSyncDicts,
                  cs_ttMdpImportDocs];
 alcuRequests = [cs_ttUserEdit, cs_ttDictEdit, cs_ttDeleteDocs, cs_ttRemoteDictEdit, cs_ttRunCommand, cs_ttUserDefinedExport];

implementation
Uses
 ht_Dll, l3StopWatch, ncsProfile,
 DateUtils, Math, {$IFNDEF Service}Dialogs,{$ENDIF} Controls, Types,
 ddAppConfig, ddKW_r, ddUtils, ddProgressTypes, ddCalendarEvents,
 Base_CFG,
 daInterfaces,
 daTypes,
 dt_User, dt_Const, dt_AttrSchema, dt_IFltr, dt_Serv,  dt_Stage,
 dt_Dict, dt_Table, dt_Link, dt_Lock, dt_Query, DT_SrchQueries,
 l3Filer, l3FileUtils, l3Stream, l3String, l3TempMemoryStream,
 l3ProcessingEnabledService,
 CSNotification, csActiveClients, CsNotifier,
 alcuMailServer, alcuUtils, alcuAutoClassifier, rxStrUtils, l3ShellUtils, vtLogFile, alcuPrime,
 alcuStrings, StrUtils, alcuAutoExport, ddAppConfigDataAdapters,
 ddAppConfigTypes, l3LongintListPrim, dt_UserTypes, dt_UserConst, dt_DictTypes,
 dt_LinkServ, DT_DictConst, ddCaseCodeMaker, csImport, csServerTaskTypes, DT_Utils,
 csUserDefinedExport,
 alcuSpellCorrectTask,
 alcuExport,
 csCommandsTypes, m3StorageElementIDList, alcuSpellChecker,
 ncsServerTransporter,
 TypInfo,
 alcuRelCorrector,
 l3MultiThreadIntegerList,
 l3CardinalList,

 ddProcessTaskPrim,
 alcuAsyncSubmitterManager,
 l3Variant,
 TaskResult_Const,
 csTaskResult,
 ncsFileTransferReg,
 ncsMessageExecutorFactory,
 ncsGetReadyToDeliveryTasks,
 alcuGetReadyToDeliveryTasksExecutor,
 ncsGetTaskDescription,
 alcuGetTaskDescriptionExecutor,
 ncsTaskProgress,
 alcuTaskProgressExecutor,
 ncsGetFilePart,
 alcuGetFilePartExecutor,
 ncsDeliveryResult,
 alcuDeliveryResultExecutor,
 ncsTaskSendReg,
 ncsSendTask,
 alcuSendTaskExecutor,
 ncsCorrectFolder,
 alcuCorrectFolderExecutor,
 alcuDetachedExecutor,
 ncsSynchroServerTransporter
 ;             //

const
 cNoActiveTask = '��� �������� ������';

{
***************************** TddServerTaskManager *****************************
}
constructor TddServerTaskManager.Create(const aRootTaskFolder: String; const aBaseEngineHolder: TalcuBaseEngineHolder);
begin
  inherited Create;
  f_AddedActiveTaskCount := 0;
  Assert(Assigned(aBaseEngineHolder));
  aBaseEngineHolder.SetRefTo(f_BaseEngineHolder);
  //f_CS:= TCriticalSection.Create;
  RootTaskFolder := aRootTaskFolder;
  f_IncomingTasks := TddServerTaskList.Create;
  f_ChangedTasks := TddServerTaskList.Create;
  f_TaskList := TalcuNotSortedTaskList.Create;
  (f_TaskList as Il3ChangeNotifier).Subscribe(Self as Il3ChangeRecipient);
  f_ActiveTaskList := TalcuTaskList.Create{MakeSorted(l3_dupIgnore)};
  f_ActiveTaskList.FileName:= ConcatDirName(RootTaskFolder, 'UserTasks.dat');
  f_MonitorUsers := Tl3MultiThreadSortedIntegerList.Create;
  f_PrivateMonitorUsers := Tl3MultiThreadSortedIntegerList.Create;
  //f_DeleteQuery:= False;
  f_CommonDataList:= TalcuNotSortedTaskList.Create;
  f_RequestList:= TddServerTaskList.Create;
  f_DelayedList:= TalcuTaskList.Create;
  f_DelayedList.Filename:= ConcatDirName(RootTaskFolder, 'DelayedTasks.dat');
  {$IFDEF RemoteDict}
  f_DictManager:= TalcuDictionaryManager.Make(ddAppConfiguration.AsInteger['Dict_List'],
                                              TalcuDictionaryManagerMode(Succ(ddAppConfiguration.AsInteger['Dict_Mode'])));
  {$ENDIF RemoteDict}

  with (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler) do
  begin
   // ����������� �������������
   AddExecuteHandler(ctVersion, SchedulerClientNotify);
   AddChangeHandler(ctVersion, SchedulerClientNotify);
  end;
  {$IFDEF UserQuery}
  f_UserQueries := TQueryList.Create();
  f_UserQueries.QueriesPath:= ddAppConfiguration.AsString['sqFolder'];
  f_UserQueries.LoadAsksList;
  {$ENDIF}
  f_Busy := False;
  f_LockProcessingCounter:= 0;
  f_WorkPoolManager := TalcuAsyncSubmitterManager.Make(f_BaseEngineHolder);
  f_WorkPool := TalcuSubmitterWorkPool.Create(f_WorkPoolManager);
  f_WorkPool.RegisterNotifier(Self);
  f_TransporterPool := TncsServerTransporterPool.Create;
  f_DetachedExecutorPool := TalcuDetachedExecutorPool.Create;

  ncsFileTransferReg.ncsServerRegister;
  ncsTaskSendReg.ncsServerRegister;
  TncsMessageExecutorFactory.Instance.Register(Self);
end;

procedure TddServerTaskManager.AbortTask(const aTask: TddProcessTask);
begin
 if (f_ActiveTask = aTask) and (aTask.Status <> cs_tsAsyncRun) then
  f_ActiveTask.Abort
 else
  if aTask.CanAsyncRun and (aTask.Status = cs_tsAsyncRun) then
   aTask.Abort;
end;

procedure TddServerTaskManager.AddDelayedTask(aTask: TddProcessTask);
begin
 f_DelayedList.AddTask(aTask);
end;

(*procedure TddServerTaskManager.AddMonitoringUser(aUserID: TUserID);
begin
 f_MonitorUsers.Add(aUserID);
end;*)

procedure TddServerTaskManager.AddRequest(const aRequest: TddProcessTask);
begin
 f_RequestList.Push(aRequest);
end;

procedure TddServerTaskManager.AddActiveTask(const aTask: TddProcessTask);
begin
// ���� ����� ������� ����� ������ - ������� ����� ������ ��� �������� ������
 if (aTask <> nil) then
 begin
  l3System.Msg2Log('���������� %s ������: %s', [IfThen(true{aIsNew}, '�����', '�����������'), atask.Description]);
  ActiveTaskList.Lock;
  try
    CalculatePriority(aTask);
    //aTask.OnChange := TaskStatusChanged;
    aTask.SetupServerSideConfigParams;
    f_TaskList.Add(aTask); // ��� ����������� ���������� ������
    aTask.CanNotifyChange := true;
    aTask.RequestQuery;
    ActiveTaskList.AddTask(aTask); // ������ �������, ��������� ����������
    Inc(f_AddedActiveTaskCount);
    MessageManager.SendNotify(aTask.UserID, ntTaskAdded, 0{aTask.TaskIndex}, aTask.TaskID, usServerService);
  finally
   ActiveTaskList.Unlock;
  end;//try..finally
  l3System.Msg2Log('������ ���������');
 end;//aTask <> nil
end;


procedure TddServerTaskManager.CalculatePriority(aTask: TddProcessTask);
var
 l_AU: TArchiUser;
begin
 l_AU := UserManager.UserByID(aTask.UserID);
 if l_AU <> nil then
 begin
  case aTask.TaskType of
   cs_ttImport : aTask.Priority := CorrectPriorities[l_AU.ImportPriority];
   cs_ttExport : aTask.Priority := CorrectPriorities[l_AU.ExportPriority];
   cs_ttAnnoExport: aTask.Priority := dd_tpHighest;
   cs_ttRelPublish: aTask.Priority := dd_tpHigh;
  end; // case
 end; // l_AU <> nil
end;

procedure TddServerTaskManager.ChangeServerStatus(atask: TddProcessTask);
begin
 case aTask.Status of
  cs_tsRun,
  cs_tsAsyncRun:
   Status := dd_apsProcessQuery;         { ����������� }
  cs_tsDelivering:
   Status:= dd_apsDelivering;
  cs_tsDone:
   Status:= dd_apsRevert;       { ���������� }
  else
   Status:= dd_apsIdle
 end;//case aTask.Status
end;

procedure TddServerTaskManager.CheckDeliveringTasks;
var
 l_List: TdtUserIDList;


 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) then
   if l_List.IndexOf(anItem.UserID) = -1 then
    l_List.Add(anItem.UserID);
 end;

 function DoSend(anUserID: PUserID; Index: Integer): Boolean;
 begin//AddLineDelta
  MessageManager.SendNotify(anUserID^, ntResultsReadyForDelivery, 0, '', usServerService);
  Result := True;
 end;//AddLineDelta

begin
 // ��������� ������� �� ������� �������������� ������� � ������������ �����������
 if (SecondsBetween(f_LastDelivering, Now) > UpdatePeriod * 3) then
 begin
  f_LastDelivering := Now;
  l_List := TdtUserIDList.Make;
  try
   f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   l_List.IterateAllF(l3L2IA(@DoSend));
  finally
   FreeAndNil(l_List);
  end;
 end;//SecondsBetween(f_LastDelivering, Now) > UpdatePeriod
end;

procedure TddServerTaskManager.Cleanup;
begin
 TncsMessageExecutorFactory.Instance.UnRegister(Self);
 SaveQuery;
 {$IFDEF RemoteDict}
 l3Free(f_DictManager);
 {$ENDIF RemoteDict}
 FreeAndNil(f_DelayedList);
 {$IFDEF UserQuery}
 FreeAndNil(f_UserQueries);
 {$ENDIF}
 l3Free(f_RequestList);
 l3Free(f_CommonDataList);
 l3Free(f_MonitorUsers);
 l3Free(f_PrivateMonitorUsers);
 l3Free(f_ActiveTaskList);
 l3Free(f_IncomingTasks);
 FreeAndNil(f_ChangedTasks);
 (f_TaskList as Il3ChangeNotifier).UnSubscribe(Self as Il3ChangeRecipient);
 l3Free(f_TaskList);
 f_WorkPoolManager := nil;
 f_WorkPool.UnRegisterNotifier(Self);
 l3Free(f_WorkPool);
 l3Free(f_BaseEngineHolder);
 l3Free(f_TransporterPool);
 l3Free(f_DetachedExecutorPool);
 inherited;
end;

procedure TddServerTaskManager.ClearTask(aTask: TddProcessTask);
begin
 DeleteFile(MakeTaskFileName(aTask));
// f_QueryFile.Section := rsSavedTaskList;
// f_QueryFile.WriteParamStr(aTask.TaskID, '');
// aTask.Clear;
end;

procedure TddServerTaskManager.cs_ExecuteCommand(aPipe: TCSDataPipe);
var
 l_CommandID: Integer;
 l_Command: TcsCommand;
 l_Task: TddRunCommandTask;
 l_User: TUserID;
begin
(* f_CS.Acquire;
 try*)
  try
   l_User:= aPipe.ReadCardinal;
   { ��������� ID � ������� ������ ��� ���������� � �������� ���� }
   l_CommandID:= aPipe.ReadInteger;
  except
   l_CommandID:= 0;
  end;
  if Actions.CommandExists(l_CommandID, l_Command) then
  begin
   l_Task:= TddRunCommandTask.Create(l_User, l_Command);
   try
    //l_task.Command:= l_Command;
    AddRequest(l_Task);
   finally
    FreeAndNil(l_Task);
   end;//try..finally
  end;//Actions.CommandExists(l_CommandID, l_Command)
(* finally
  f_CS.Leave;
 end;//try..finally*)
end;

procedure TddServerTaskManager.cs_GetActiveUsers(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_List: TdtUserIDList;
begin
(* f_CS.Acquire;
 try*)
  l_Stream:= Tl3MemoryStream.Create;
  try
   l_List:= TdtUserIDList.Make;
   try
    f_BaseEngineHolder.BaseEngine.CSServer.ActiveClients.AllClientIds(l_List);
    l_List.Save(l_Stream);
    l_Stream.Seek(0, 0);
    aPipe.WriteStream(l_Stream);
   finally
    l3Free(l_List);
   end;
  finally
   l3Free(l_Stream);
  end;
(* finally
  f_CS.Leave;
 end;//try..finally*)
end;

procedure TddServerTaskManager.cs_GetNextVersionDate(aPipe: TCSDataPipe);
var
 l_Date, l_NextDate: TDateTime;
 l_TaskV, l_TaskC: TddSchedulerTask;
begin
(* f_CS.Acquire;
 try*)
  l_TaskC := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctCompilation);
  Assert(l_TaskC <> nil);
  l_TaskV := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctVersion);
  Assert(l_TaskV <> nil);
  l_Date := l_TaskV.FullDateTime[l_TaskC.FullDateTime[Now]];
  l_NextDate:= l_TaskV.FullDateTime[IncDay(l_Date)];
  aPipe.WriteDateTime(l_Date);
  aPipe.WriteDateTime(l_NextDate);
(* finally
  f_CS.Leave;
 end;//try..finally*)
end;

procedure TddServerTaskManager.cs_GetCommonData(aPipe: TCSDataPipe);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  anItem.SaveTaskToPipe(aPipe);
 end;

var
 l_Index: Integer;
begin
  l_Index:= aPipe.ReadInteger;
  f_CommonDataList.ForOneF(L2AlcuTasksIteratorForOneFAction(@DoIt), l_Index);
end;

procedure TddServerTaskManager.cs_GetTime(aPipe: TCSDataPipe);
begin
 aPipe.WriteDateTime(Now);
end;

procedure TddServerTaskManager.cs_LineRequestReply(aPipe: TCSDataPipe);

var
 l_Stream: Tl3MemoryStream;
 l_Count: Integer;

 function CalcCount(anItem: TddProcessTask): Boolean;
 var
  l_TaskSize: Integer;
  l_Pos: Integer;
 begin
  Result := true;
  if not anItem.IsHiddenFromUser then
   inc(l_Count);
 end;

 function WriteTask(anItem: TddProcessTask): Boolean;
 var
  l_TaskSize: Integer;
  l_Pos: Integer;
 begin
  Result := true;
  if anItem.IsHiddenFromUser then
   Exit;
  l_Pos := l_Stream.Position;
  anItem.SaveTo(l_Stream, False);
  l_TaskSize := l_Stream.Size - l_Pos;
  aPipe.WriteInteger(l_TaskSize);
 end;

begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  f_TaskList.Lock;
  try
   l_Count := 0;
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@CalcCount));

   aPipe.WriteInteger(l_Count); // ���������� �����
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@WriteTask));
   aPipe.WriteStream(l_Stream);
  finally
   f_TaskList.Unlock;
  end;//try..finally
 finally
  l3Free(l_Stream);
 end;//try..finally
end;

procedure TddServerTaskManager.cs_ReturnResult(aPipe: TCSDataPipe);

var
 l_TaskID: String;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  l3System.Msg2Log('������ �� ������������: ' + UserNameByID(anItem.UserID));
  if anItem.ReadyToDelivery then
  begin
  end//anItem.ReadyToDelivery
  else
  begin
   l3System.Msg2Log('������ � ��������������� ' + l_TaskID + '/' + anItem.TaskID + ' ��� ����� ����������. ������ ������: ' + GetEnumName(TypeInfo(TcsTaskStatus), ord(anItem.Status)));
   l3System.Msg2Log('����� � ������������: ' + anItem.TaskFolder);
  end;//anItem.ReadyToDelivery
  anItem.RequestDelivering;
  anItem.WriteResult(aPipe);
  TaskDone(anItem);
 end;

begin
 l3System.Msg2Log('�������� ������������ ����������� ��������');
 // ������ ������������� ������, ������� ������ � ���������� �� ��������� � �����
 l_taskID := aPipe.ReadLn;
 if not WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt)) then
  l3System.Msg2Log('������ � ��������������� ' + l_TaskID + ' �� ������� (�������� �����������)');
 l3System.Msg2Log('�������� ����������� ���������');
end;

procedure TddServerTaskManager.cs_ReturnTask(aPipe: TCSDataPipe);

  function DoIt(anItem: TddProcessTask): Boolean;
  var
   l_Stream: Tl3MemoryStream;
  begin
   Result := true;
   l3System.Msg2Log('������ �� ������������: ' + UserNameByID(anItem.UserID));
   l_Stream := Tl3MemoryStream.Create;
   try
    anItem.SaveTo(l_Stream, False);
    l_Stream.Seek(0, 0);
    aPipe.WriteStream(l_Stream);
   finally
    l3Free(l_Stream);
   end;//try..finally
  end;

var
 l_TaskID : String;
begin
 l3System.Msg2Log('�������� ������������ ���������� � ������');
 // ������ ������������� ������, ������� ������ � ���������� �� � �����
 l_TaskID := aPipe.ReadLn;
 if not WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt)) then
  l3System.Msg2Log('������ � ��������������� ' + l_TaskID + ' �� ������� (�������� �����������)');
 l3System.Msg2Log('�������� ���������� ���������');
end;

procedure TddServerTaskManager.cs_SendMail(aPipe: TCSDataPipe);
var
 l_Recepient: Integer;
 l_MailNumber: Integer;
begin
(* f_CS.Acquire;
 try*)
  l_Recepient := aPipe.ReadInteger;
  l_MailNumber := aPipe.ReadInteger;
  MessageManager.SendNotify(l_Recepient, ntMailArrived, l_MailNumber, '', usServerService);
(* finally
  f_CS.Leave;
 end;//try..finally*)
end;

procedure TddServerTaskManager.cs_ServerTaskReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
 l_Index : Integer;
begin
 Assert(aPipe <> nil, '����������� ������ ��� ���������');
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Index := AddTaskFromStreamToIncoming(l_Stream, RootTaskFolder{GetUniqFileName(RootTaskFolder, 'Task', '')}, True);
 finally
  l3Free(l_Stream);
 end;//try..finally
 aPipe.WriteInteger(l_Index);
end;

procedure TddServerTaskManager.cs_StartMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  AddUserInMonitor(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.cs_StartMyMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  AddUserInPrivateMonitor(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.cs_StopMonitoringReply(aPipe: TCSDataPipe);
var
 l_Stream: Tl3MemoryStream;
begin
 l_Stream:= Tl3MemoryStream.Create;
 try
  aPipe.ReadStream(l_Stream);
  l_Stream.Seek(0, 0);
  DeleteUserOfMonitorS(l_Stream);
 finally
  l3Free(l_Stream);
 end;
end;

procedure TddServerTaskManager.DeleteTask(aTask: TddProcessTask; aSendMessage: Boolean);
begin
 aTask.Use;
 try
  AbortTask(aTask);
 (* if not aSendMessage then
   aTask.OnChange:= nil;*)
  if not aSendMessage then
   aTask.CanNotifyChange := false;
  aTask.RequestDeleted;
  f_ActiveTaskList.RemoveTask(aTask);
  TaskListUpdated(aTask);
  ClearTask(aTask);
 finally
  aTask.Free;
 end;//try..finally
end;

procedure TddServerTaskManager.DoChangeDictItem(aTask: TddProcessTask);
var
 l_Rec: TDictMessageRec;
begin
 aTask.RequestRun;
 with (aTask as TDictEditQuery){.DictInfo} do
 begin
  l_Rec.Family := Word(Family);
  l_rec.DictType := TdaDictionaryType(DictType);
  l_Rec.Operation:= TOperActionType(Operation);
  l_Rec.ID := ID;
  l_Rec.NextID := NextID;
  l_Rec.ParentID := ParentID;
 end;
 DictServer(CurrentFamily).ProcessDictEdit(l_Rec, aTask.UserID);
end;

procedure TddServerTaskManager.DoRemoteChangeDictItem(aTask: TddProcessTask);
var
 l_Rec: TDictMessageRec;
begin
{$IFDEF RemoteDict}
 aTask.RequestRun;

// ������ ������ �������� ������
 with (aTask as TRemoteDictEditQuery) do
 begin
  l_Rec.Family := Word(Family);
  l_rec.DictType := TdaDictionaryType(DictType);
  l_Rec.Operation:= TOperActionType(Operation);
  l_Rec.ID := ID;
  l_Rec.NextID := NextID;
  l_Rec.ParentID := ParentID;
 end;
 f_DictManager.SaveDictInfo(aTask as TRemoteDictEditQuery);
 DictServer(rec.Family).ProcessRemoteDictEdit(aTask as TRemoteDictEditQuery);
{$ENDIF}
 aTask.Done;
end;

procedure TddServerTaskManager.DoChangeUserItem(aTask: TddProcessTask);
begin
 with (aTask as TUserEditQuery) do
  UserManager.UpdateUserInfo(ID, IsGroup);
 aTask.Done;
end;

procedure TddServerTaskManager.DoDeleteDocs(aTask: TddProcessTask);
var
 l_Index: Integer;
 l_Sab: ISab;
begin
 // ������� � ����
 DocumentServer.Family:= CurrentFamily;
 l_Sab:= MakeValueSet(DocumentServer.FileTbl, fId_fld, aTask.DocumentIDList);
 try
  DocumentServer.DelDocs(l_Sab);
  l3System.Msg2Log('������������ %s ������ ��������� (������� (#����������) ������):', [UserManager.UserName(aTask.UserID)]);
  for l_Index:= 0 to Pred(aTask.DocumentIDList.Count) do
   l3System.Msg2Log('%d (#%d)', [LinkServer(CurrentFamily).ReNum.GetExtDocID(aTask.DocumentIDList.Items[l_Index]), aTask.DocumentIDList.Items[l_Index]]); 
  // ��������� ���� ������������� ���������� �� ��������� ����������
  l_Index:= f_CommonDataList.Add(aTask);
  MessageManager.SendNotify(c_AllClients, ntDelDoc, l_Index, '', aTask.UserID);
 except
  on E: Exception do
  begin
   Exception2Log(E);
   alcuMail.SendEmailNotify(eventDeleteDocuments, True, E.Message, dd_apsDeleteDocs);
  end;
 end;
end;

procedure TddServerTaskManager.Exception2Log(E: Exception);
begin
 {$IFNDEF Service}
 if Assigned(f_OnException) then
  f_OnException(Self, E)
 else
 {$ENDIF}
  l3System.Exception2Log(E);
end;

function TddServerTaskManager.WorkupTaskByIDF(const ID: String; anAction: alcuTasksIterator_ForOneF_Action): Boolean{: TddProcessTask};

var
 l_Found : TddProcessTask;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  if anItem.TaskID = ID then
  begin
   anItem.SetRefTo(l_Found);
   //anAction(anItem);
   WorkupTaskByIDF := true;
   Result := false;
  end//anItem.TaskID = aTaskID
  else
   Result := true;
 end;

var
 Hack : Pointer absolute anAction;
begin
 Result := false;
 l_Found := nil;
 try
 // Result := nil;
  try
   f_TaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   if (l_Found <> nil) then
    anAction(l_Found);
  finally
   l3FreeLocalStub(Hack);
  end;//try..finally
 finally
  FreeAndNil(l_Found);
 end;//try..finally
end;

procedure TddServerTaskManager.LoadQuery;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  anItem.CanNotifyChange := true;
  if not f_TaskList.Has(anItem) then
    f_TaskList.Add(anItem);
 end;//DoIt

begin
 f_ActiveTaskList.Lock;
 try
  f_ActiveTaskList.Load;
  f_TaskList.LockNotification;
  try
   f_TaskList.Lock;
   try
    f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   finally
    f_TaskList.Unlock;
   end;//try..finally
  finally
   f_TaskList.UnlockNotification;
  end;

  if not f_ServerStarted then
    TaskExecutionEnabled := (ActiveTaskListCount = 0);
  f_DelayedList.Load;
 finally
  f_ActiveTaskList.Unlock;
 end;//try..finally
end;

procedure TddServerTaskManager.LockProcessing;
begin
 inc(f_LockProcessingCounter);
 if f_LockProcessingCounter = 1 then
  WaitForAsyncRunningTasks;
end;

function TddServerTaskManager.MakeTaskFileName(aTask: TddProcessTask): string;
begin
 if not DirExists(RootTaskFolder) then
 begin
  l3System.Msg2Log('����-�� ������� ����� ��� ���������� �������', l3_msgLevel1);
  ForceDirectories(RootTaskFolder);
 end; // not DirExists(RootTaskFolder)
 Result := ConcatDirName(RootTaskFolder, aTask.TaskID + '.query');
end;

function TddServerTaskManager.pm_GetActiveTaskListCount: Integer;
begin
 Result:= ActiveTaskList.ActiveTaskCount(EnabledTaskTypes);
end;

function TddServerTaskManager.pm_GetCurrentUserName: string;
begin
 if (f_ActiveTask = nil) or AllowAsyncRunTask(f_ActiveTask) then
  Result := cNoActiveTask
 else
  Result := UserNameByID(f_ActiveTask.UserID);
end;

function TddServerTaskManager.pm_GetLineLen: Integer;
begin
  Result := f_ActiveTaskList.Count;
end;

function TddServerTaskManager.pm_GetProcessingLocked: Boolean;
begin
 Result := (f_LockProcessingCounter > 0) and Tl3ProcessingEnabledService.Instance.Enabled;
end;

procedure TddServerTaskManager.pm_SetTaskExecutionEnabled(const Value: Boolean);
begin
 if f_TaskExecutionEnabled <> Value then
 begin
  f_TaskExecutionEnabled := Value;
  if f_TaskExecutionEnabled and not Processing then
   ProcessQuery;
 end;
end;

procedure TddServerTaskManager.pm_SetEnabledTaskTypes(const Value: TcsTaskTypes);
begin
  if f_EnabledTaskTypes <> Value then
  begin
   f_EnabledTaskTypes := Value;
  end;
end;

(*procedure TddServerTaskManager.pm_SetProcessing(const Value: Boolean);
begin
 if f_Processing <> Value then
 begin
  f_Processing := Value;
 end;
end;*)

procedure TddServerTaskManager.pm_SetRootTaskFolder(const Value: string);
begin
 if f_RootTaskFolder <> Value then
 begin
  f_RootTaskFolder := ExpandFileName(Value);
  if f_RootTaskFolder <> '' then
   ForceDirectories(f_RootTaskFolder);
 end;
end;

procedure TddServerTaskManager.pm_SetStatus(const Value: TalcuStatus);
begin
 f_Status:= Value;
 if Assigned(f_OnStatusChanged) then
  f_OnStatusChanged(Value{, LineLen});
end;

{$If defined(InsiderTest)}
procedure TddServerTaskManager.SimulateTaskDone(aTask: TddProcessTask);
 {* ��������� �������� ���������� ������������ ����� ���������� ������� }
begin
end;
{$IfEnd} //InsiderTest

{$If defined(InsiderTest)}
procedure TddServerTaskManager.BeforeSaveQuery;
 {* ��������� ������ BeforeSaveQuery }
begin
end;
{$IfEnd} //InsiderTest

{$If defined(InsiderTest)}
function TddServerTaskManager.NeedRaiseInProcessQuery: Boolean;
begin
 Result := false;
end;
{$IfEnd} //InsiderTest

procedure TddServerTaskManager.ProcessQuery;

var
 l_NeedRepeat : Boolean;
 l_DoneCount  : Integer;
 l_TaskToRun: TddProcessTask;

 procedure lp_DoSyncRun(const anItem: TddProcessTask);
 begin//DoIt
  {$IFNDEF Service}
  Application.ProcessMessages;
  {$ENDIF}
  if AllowTaskExecution then // ��������� ����� ��������� �����
   try
    if anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes) and not (f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem)) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then
      try
        RunTask(anItem);
        TaskFinished(anItem);
        if not (anItem.Status in [cs_tsQuery, cs_tsAsyncRun]) then
        begin
          l_NeedRepeat := true;
          Inc(l_DoneCount);
        end;
      finally
        f_WorkPoolManager.LeaveTaskExecution(anItem);
      end;// try
    end; // anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end;
  WorkupRequests;
 end;//DoSyncRun

 function DoSearch(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  {$IFNDEF Service}
  Application.ProcessMessages;
  {$ENDIF}
  if AllowTaskExecution then // ��������� ����� ��������� �����
   try
    if anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes) and not (f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem)) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then  // Leave ����� �������
     begin
      anItem.SetRefTo(l_TaskToRun);
      Result := False;
      Exit;
     end;
    end; // anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end;
  WorkupRequests;
 end;//DoSyncRun

begin
 f_DetachedExecutorPool.Pack;
 f_TaskList.PackUnimportant;
 f_WorkPool.CheckExecution(Self);
 if not ProcessingLocked then
 begin
  if AllowTaskExecution then
  begin
   WorkupRequests;
   CheckDeliveringTasks;
   SubmitAsyncTasks;
   if not f_Processing then
   begin
    f_Processing := True;
    try
     WorkupRequests;
     l_DoneCount := 0;
     l_TaskToRun := nil;
     while true do
     begin
      f_ActiveTaskList.Sort;
      l_NeedRepeat := false;
      try
       f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoSearch));
       if Assigned(l_TaskToRun) then
        lp_DoSyncRun(l_TaskToRun);
      finally
       if Assigned(l_TaskToRun) then
        f_WorkPoolManager.LeaveTaskExecution(l_TaskToRun);
       FreeAndNil(l_TaskToRun);
      end;
      if not l_NeedRepeat then
       break;
      if (l_DoneCount > 5) then
      // - ����� �� ������� ���� �� ��������� ���������
       break;
     end;//while true
    finally
     f_Processing := False;
    end; // try..finally
   end;
  end;
 end; // not ProcessingLocked
end;

procedure TddServerTaskManager.ProcessIncomingTasks;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  l3System.Msg2Log('������� ������ %s', [anItem.Description], alcuMessageLevel);
  if (anItem.TaskType in alcuRequests) then
   AddRequest(anItem)
  else
  begin
   if anItem.Delayed then
    AddDelayedTask(anItem)
   else
    AddActiveTask(anItem);
  end;//anItem.TaskType in alcuRequests
 end;//DoIt

 function DoChanged(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  TaskListUpdated(anItem);
 end;

begin
 if (GetCurrentThreadID = MainThreadID) then
 begin
  f_ChangedTasks.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoChanged));
  if f_NeedUpdateAllTask then
   TaskListUpdated(nil);
  f_NeedUpdateAllTask := False;
 end;
 // ��������� ���� ������ �������� �������
 f_IncomingTasks.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoIt));
 ProcessQuery;
end;

procedure TddServerTaskManager.RunTask(aTask: TddProcessTask);
begin
 aTask.SetRefTo(f_ActiveTask);
 //f_UserID := aTask.UserID;
 try
  aTask.Run(TddRunContext_C(Progressor));
  aTask.RunSuccessfullyFinished(Self);
  {$IFDEF InsiderTest}
  TrySimulateTaskDone(aTask);
  {$ENDIF InsiderTest}
 finally
  aTask.RunEnded(Self);
  FreeAndNil(f_ActiveTask);
  //f_UserID := 0;
 end;//try..finally
 if not (aTask.Status in cs_tsErrorStatuses) then
 begin
  {$IFDEF InsiderTest}
  BeforeSaveQuery;
  {$ENDIF}
  SaveQuery;
 end//aTask.Status <> cs_tsError
 else
  if aTask.Status = cs_tsError then
    ExcludeTaskType(aTask.TaskType);
end;

procedure TddServerTaskManager.SchedulerClientNotify(aTask: TddSchedulerTask);
begin
 MessageManager.SendNotify(c_AllClients, ntCalendar, Ord(aTask.TaskType), '', usServerService);
end;

procedure TddServerTaskManager.cs_GetExecuteStatus(aPipe: TcsDataPipe);
var
 i: TcsTaskType;
begin
 with aPipe do
 begin
  WriteSmallInt(SmallInt(Ord(TaskExecutionEnabled)));
  for i:= Low(TcsTaskType) to High(TcsTaskType) do
   WriteSmallInt(SmallInt(Ord(i in EnabledTaskTypes)));
 end;
end;

procedure TddServerTaskManager.cs_GetDictChangeFileName(aPipe: TCSDataPipe);
begin
 aPipe.WriteLn(ddAppConfiguration.AsString['DictUpdateFileName']);
end;

procedure TddServerTaskManager.cs_GetCompileDate(aPipe: TCSDataPipe);
var
 l_Date: TDateTime;
 l_TaskC: TddSchedulerTask;
begin
 l_TaskC := (ddAppConfiguration.AsObject[SalcuAutoPipeServer_Scheduler] as TddSCheduler).GetTaskByTaskType(ctCompilation);
 l_Date := l_TaskC.FullDateTime[Now];
 aPipe.WriteDateTime(l_Date);
end;

procedure TddServerTaskManager.cs_GetToRegionList(aPipe: TcsDataPipe);
var
 i: Integer;
begin
 with Tl3LongintList(ddAppConfiguration.AsObject['utRegionID']) do
 begin
  aPipe.WriteInteger(Count);
  for i:= 0 to Hi do
   aPipe.WriteInteger(Items[i]);
 end;
end;

procedure TddServerTaskManager.DoCommand(aTask: TddProcessTask);
begin
 l3System.Msg2Log('���������� ������� (%d)', [GetCurrentThreadId]);
 aTask.Run(TddRunContext_C(f_Progressor));
end;

procedure TddServerTaskManager.ExcludeTaskType(aTaskType: TcsTaskType);
begin
 Exclude(f_EnabledTaskTypes, aTaskType);
end;

procedure TddServerTaskManager.IncludeTaskType(aTaskType: TcsTaskType);
begin
 Include(f_EnabledTaskTypes, aTaskType);
end;

procedure TddServerTaskManager.MakeCaseCodeGenerateTask;
var
 l_Task: TddCaseCodeTask;
 lDocSab : ISab;
 lDossSab : ISab;
 lSab    : ISab;
 lSabWOSpr    : ISab;
 l_ResQuery: TdtAndQuery;
 l_Q       : TdtQuery;
 l_StartDate, l_EndDate: TDateTime;
 l_List: Tl3LongintList;
 lValue : Integer;
 lCCSab : ISab;

const
 cCaseCodeType : TDNType = dnLawCaseNum;
begin

 l3System.Msg2Log('������������ ������� �� �������� ������� ��� ��� ������������� ���');
 l_StartDate:= ddAppConfiguration.AsDateTime['ccDate'];
 l_EndDate:= Now;

 l_ResQuery := TdtAndQuery.Create;
 try
  (*
  l_Q := SQChangedDocsFromLog(StDateToDemon(DateTimeToStDate(l_StartDate)),
                              StDateToDemon(DateTimeToStDate(l_EndDate)),
                              0
                             );

  l_ResQuery.AddQueryF(l_Q);
    *)
  l_List := Tl3LongintList(ddAppConfiguration.AsObject['ccSource']); // ��������� ������ ����������
  l_Q := TdtDictQuery.Create(da_dlSources, l_List, False, True {WithSubTree});
  l_ResQuery.AddQueryF(l_Q);

   l_List := Tl3LongintList(ddAppConfiguration.AsObject['ccType']);
   l_Q := TdtDictQuery.Create(da_dlTypes, l_List, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);
  lDocSab:= l_ResQuery.FoundList;
 finally
  l3Free(l_ResQuery);
 end;
 if lDocSab.Count > 0 then
 begin
  // lDocSab - ��� ������ �������������, ���������� �� ������
  // ����� ����� ����� ��� ��, ��� ��� ������� ���


  //������ ���� � ����������
  lCCSab := MakeSab(DictServer(CurrentFamily).GroupTbl[da_dlDateNums]);
  lCCSab.Select(dnTypFld, cCaseCodeType);
  lCCSab.ValuesOfKey(dnIDFld);
  lCCSab.TransferToPhoto(lnkDictIDFld, LinkServer(CurrentFamily).Attribute[atDateNums]);
  lCCSab.ValuesOfKey(lnkDocIDFld);
  lCCSab.TransferToPhoto(fId_Fld, lDocSab);


  lDocSab.ValuesOfKey(fId_Fld);
  lDocSab.SubtractSab(lCCSab);

  if not lDocSab.IsEmpty then
  begin

   l_Task:= TddCaseCodeTask.Create({nil,} usServerService);
   try
    dtOutSabToStream(lDocSab, l_Task.SABStream);
    AddActiveTask(l_Task);
   finally
    l3Free(l_Task);
   end;
   l3System.Msg2Log('������� ������������ (%d �������������)', [lDocSab.Count]);

  end // not l_ResQuery.IsEmpty
  else
   l3System.Msg2Log('�� ������� ������������� ��� ������� ���');
 end
 else
  l3System.Msg2Log('�� ������� ������������� ��� ������� ���');
 ddAppConfiguration.AsDateTime['ccDate']:= l_EndDate;
end;

procedure TddServerTaskManager.SaveQuery;
begin
  ActiveTaskList.Save;
end;

procedure TddServerTaskManager.StopProcessQuery(aTask: TddProcessTask);
begin
 if (aTask <> nil) then
 begin
  if (aTask.Status = cs_tsFrozen) then
   aTask.RequestQuery
  else
  begin
   AbortTask(aTask);
   aTask.RequestFrozen;
  end;//aTask.Status = cs_tsFrozen
 end//aTask <> nil
end;

procedure TddServerTaskManager.TaskDone(aTask: TddProcessTask);
begin
 if not (aTask.Status in cs_tsErrorStatuses) then
   aTask.Done;
 // �������� �� ��������� ����������� �� ���������? ��-�����, �� � ��� ��� �������... ��� ������ � ������ ���������� �� ��������?
 // aTask.OnChange := nil;
 aTask.CanNotifyChange := false;
 ClearTask(aTask);
 f_ActiveTaskList.RemoveTask(aTask);
 TaskListUpdated(aTask);
end;

procedure TddServerTaskManager.TaskListUpdated(aTask: TddProcessTask);
begin
 if (GetCurrentThreadID = MainThreadID) then
 begin
  if Assigned(f_OnTaskListChanged) then
   f_OnTaskListChanged(aTask);
 end//GetCurrentThreadID = MainThreadID
 else
 begin
  if Assigned(aTask) then
   f_ChangedTasks.Push(aTask)
  else
   f_NeedUpdateAllTask := True;
 end;
end;

procedure TddServerTaskManager.DoTaskChanged(aTask: TddTaskItem; PrevStatus: TcsTaskStatus);

var
 l_Task : TddProcessTask;

 function SendTaskProgress(anItem: Integer): Boolean;
 begin
  Result := true;
  MessageManager.SendNotify(anItem, ntTaskProgress, l_Task.RunProgress, l_Task.TaskID, usServerService);
 end;

 function SendTaskChanged(anItem: Integer): Boolean;
 begin
  Result := true;
  MessageManager.SendNotify(anItem, ntTaskChanged, Ord(l_Task.Status), l_Task.TaskID, usServerService);
 end;

begin
 if (aTask is TddProcesstask) then
 begin
  l_Task := TddProcesstask(aTask);
  ChangeServerStatus(l_task);

  if (l_Task.Status <> cs_tsDelivering) then
  begin
   if (l_Task.Status <> cs_tsReadyToDelivery) then
   begin
    WorkupRequests; // ��������� �������� � �������� ���������� ������� ������
    //f_ActiveTaskList.Sort;
    //f_ActiveTaskList.Save; <- �� �������� � ����������� ������
   end;//l_Task.Status <> cs_tsReadyToDelivery
   TaskListUpdated(l_Task);

   // �� ���� ����� ��������� ������� ������ ������������ �������...
   if (l_Task.Status <> PrevStatus) then
   begin
    l3System.Msg2Log('������ ������ "%s" -> "%s"', [TaskStatusNames[PrevStatus], TaskStatusNames[l_Task.Status]], l3_msgLevel3);

    if (l_Task.Status = cs_tsReadyToDelivery) then
    begin
     f_LastDelivering := Now;
     MessageManager.SendNotify(l_Task.UserID, ntResultsReadyForDelivery, 0, '', usServerService);
    end;

    MessageManager.SendNotify(l_Task.UserID, ntTaskChanged, Ord(l_Task.Status), l_Task.TaskID, usServerService);
    if (l_Task.Status = cs_tsReadyToDelivery) then
     // - ������� ��������� ��������������
     MessageManager.SendNotify(l_Task.UserID, ntResultsReadyForDelivery, 0, '', usServerService);

   end;//l_Task.Status <> PrevStatus
  end // (l_Task.Status <> cs_tsDelivering)
  else
   TaskListUpdated(l_Task);

  if (SecondsBetween(f_LastUpdate, Now) > UpdatePeriod) or (f_LastChangedTask <> l_Task) or (f_LastChangedStatus <> l_Task.Status) then
  begin
   f_LastUpdate := Now;
   f_LastChangedTask := l_Task;
   if not l_Task.IsHiddenFromUser then
   begin
    if (l_Task.Status in cs_tsStatusesWithProgress) then
    begin
     f_MonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskProgress));
     f_PrivateMonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskProgress));
    end; // (l_Task.Status in cs_tsRunningStatuses) then
    if not (l_Task.Status in cs_tsStatusesWithProgress) or (l_Task.Status <> f_LastChangedStatus) then
    begin
     f_MonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskChanged));
     f_PrivateMonitorUsers.ForEachF(L2IntegerIteratorForEachFAction(@SendTaskChanged));
    end; // not (l_Task.Status in cs_tsStatusesWithProgress) or (l_Task.Status <> PrevStatus)
   end;
   f_LastChangedStatus := l_Task.Status;
  end; // (SecondsBetween(f_LastUpdate, Now) > UpdatePeriod) or (f_LastChangedTask <> l_Task)
 end; // Sende is Task
end;

procedure TddServerTaskManager.UnLockProcessing;
begin
 Dec(f_LockProcessingCounter);
 if f_LockProcessingCounter < 0 then
  f_LockProcessingCounter := 0;
end;

procedure TddServerTaskManager.WorkupDelayed;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  AddActiveTask(anItem);
 end;

begin
 f_ActiveTaskList.Lock;
 try
  f_DelayedList.Lock;
  try
   f_DelayedList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
   f_DelayedList.Clear;
  finally
   f_DelayedList.Unlock;
  end;//try..finally
 finally
  f_ActiveTaskList.Unlock;
 end;//try..finally
end;

procedure TddServerTaskManager.WorkupRequests;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin//DoIt
  Result := true;
  case anItem.TaskType of
   cs_ttDictEdit:
    DoChangeDictItem(anItem);
   cs_ttUserEdit:
    DoChangeUserItem(anItem);
   cs_ttDeleteDocs:
    DoDeleteDocs(anItem);
   cs_ttRemoteDictEdit:
    DoRemoteChangeDictItem(anItem);
   cs_ttRunCommand:
    DoCommand(anItem);
   cs_ttUserDefinedExport:
    DoSaveUserDefinedExport(anItem);
   else
    Assert(false, 'WorkupRequests. ����������� ��� ������: ' + GetEnumName(TypeInfo(TcsTaskType), Ord(anItem.TaskType)));
  end;//case anItem.TaskType
 end;//DoIt

begin
 if (not f_Busy) and not ProcessingLocked then
 begin
  f_Busy := True;
  try
   f_RequestList.WorkupF(L2CsProcessTaskWorkuperWorkupFAction(@DoIt));
  finally
   f_Busy := False;
  end;//try..finally
 end;//not f_Busy
end;

function TddServerTaskManager.AddTaskToIncoming(const aTask: TddProcessTask): integer;
begin
 Assert(aTask <> nil);
 Result := f_IncomingTasks.Push(aTask)
end;

function TddServerTaskManager.AddTaskFromStreamToIncoming(Stream: Tl3Stream; const aRootTaskFolder: String; aisPipe: Boolean): integer;
var
 l_Task: TddTaskItem;
begin
 Assert(Stream <> nil, '����������� ������ ������� ��� ��� ���������� � RawList');
 Result := 0;
 Stream.Seek(0, 0);
 l_Task := TddTaskItem.MakeFrom(Stream, aRootTaskFolder, aisPipe);
 try
  if (l_Task <> nil) then
   Result := AddTaskToIncoming(l_Task as TddProcessTask)
  else
   l3System.Msg2Log('����������� ������');
 finally
  l3Free(l_Task);
 end;
end;

procedure TddServerTaskManager.AddUserInMonitor(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_MonitorUsers.Add(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.AddUserInPrivateMonitor(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_PrivateMonitorUsers.Add(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.DeleteUserOfMonitorS(Stream: Tl3Stream);
var
 l_Task: TddTaskItem;
begin
 l_Task := TddTaskItem.MakeFrom(Stream, RootTaskFolder, True);
 if l_Task <> nil then
 begin
  try
   f_MonitorUsers.Remove(l_task.UserID);
   f_PrivateMonitorUsers.Remove(l_task.UserID);
  finally
   l3Free(l_Task);
  end;
 end;
end;

procedure TddServerTaskManager.pm_SetProgressor(
  const Value: TddProgressObject);
begin
  f_Progressor := Value;
end;

procedure TddServerTaskManager.NotifyProgress(TotalPercent: Long;
  const TotalCaption: AnsiString);
begin
  if Assigned(f_ActiveTask) and not AllowAsyncRunTask(f_ActiveTask) then
  begin
    f_ActiveTask.SetProgress(TotalPercent, TotalCaption);
  end;
end;

procedure TddServerTaskManager.cs_AsyncProgress(aPipe: TCSDataPipe);
var
  l_TaskID: AnsiString;
  l_Progress: Long;
  l_Message: AnsiString;

  function DoIt(anItem: TddProcessTask): Boolean;
  begin
   Result := true;
   anItem.SetProgress(l_Progress, l_Message);
  end;

begin
  l_TaskID := aPipe.ReadLn;
  l_Progress := aPipe.ReadCardinal;
  l_Message := aPipe.ReadLn;
  WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt))
end;

procedure TddServerTaskManager.WaitForAsyncRunningTasks;
begin
  while f_WorkPool.HasRunningTask(Self) do
  begin
   {$IFNDEF Service}
    Application.ProcessMessages;
   {$ENDIF Service}
   Sleep(10);
  end;
end;

{$IFDEF InsiderTest}
procedure TddServerTaskManager.TrySimulateTaskDone(
  const aTask: TddProcessTask);
begin
  if CanSimulateTaskDone then
  begin
   while aTask.Status = cs_tsAsyncRun do
   begin
    f_WorkPool.CheckExecution(Self);
 {$IFNDEF Service}
    Application.ProcessMessages;
 {$ENDIF Service}
    Sleep(10);
   end;
   SimulateTaskDone(aTask);
  end;
  CanSimulateTaskDone := false;
end;
{$ENDIF}

procedure TddServerTaskManager.TaskFinished(const aTask: TddProcessTask);
begin
 if not (aTask.Status in cs_tsKeepProcessingStatuses) then
  TaskDone(aTask);
end;

procedure TddServerTaskManager.pm_SetMessageManager(
  const Value: TcsMessageManager);
begin
  f_MessageManager := Value;
end;

procedure TddServerTaskManager.cs_ReceiveTaskResult(aPipe: TCSDataPipe);
var
  l_Stream: TStream;
  l_Tag: Tl3Tag;

  function DoIt(anItem: TddProcessTask): Boolean;
  begin
   Result := true;
   anItem.TaskResult.SetTaggedData(l_Tag);
  end;

begin
  l_Stream := Tl3TempMemoryStream.Create;
  try
    aPipe.ReadStream(l_Stream);
    l_Stream.Seek(0, soFromBeginning);
    l_Tag := TcsTaskResult.CreateTaggedDataFromEVD(l_Stream);
    try
      Assert(l_Tag.IsKindOf(k2_typTaskResult));
      WorkupTaskByIDF(l_Tag.StrA[TaskResult_Const.k2_attrTaskID], L2AlcuTasksIteratorForOneFAction(@DoIt))
    finally
      FreeAndNil(l_Tag);
    end;
  finally
    FreeAndNil(l_Stream);
  end;
end;

function TddServerTaskManager.AllowAsyncRunTask(const aTask: TddProcessTask): Boolean;
begin
  Result := aTask.CanAsyncRun and (Tl3LongintList(ddAppConfiguration.AsObject['AsyncRunTaskType']).IndexOf(aTask.TaskTaggedDataType.ID) <> -1);
end;

procedure TddServerTaskManager.SendTextMessage(anUserID: TUserID;
  const aMessage: AnsiString);
begin
  MessageManager.SendTextMessage(anUserID, aMessage);
end;

procedure TddServerTaskManager.FreezeQueryQueue;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  FreezeTask(anItem);
 end;

begin
 FreezeRunningSyncTask;
 f_OnTaskListChanged := nil;
 f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
 WaitForAsyncRunningTasks;
 f_TransporterPool.TerminateAll;
end;

procedure TddServerTaskManager.DoSaveUserDefinedExport(
  aTask: TddProcessTask);
var
 l_Source, l_Dest: String;
begin
 try
  l_Source := TcsUserDefinedExport(aTask).QueryFile;
  l_Dest := GetUniqFileName(ddAppConfiguration.AsString['sqFolder'],'q','.sqr');
  CopyFile(l_Source, l_Dest);
  f_UserQueries.LoadAsksList;
 except
  l3System.Msg2Log('������ ����������� ����� �������');
 end;//try..except
 aTask.Done;
end;

procedure TddServerTaskManager.LockAsyncRun;
begin
  f_WorkPool.LockSubmitTask;
end;

procedure TddServerTaskManager.UnLockAsyncRun;
begin
  f_WorkPool.UnLockSubmitTask;
end;

procedure TddServerTaskManager.SubmitAsyncTasks;

 function DoAsyncRun(anItem: TddProcessTask): Boolean;
 begin//DoIt
  if not AllowTaskExecution then
   Result := false
  else
  begin
   Result := true;
 //     l3System.Msg2Log(rsNaaloobrabotkioeredizadaniy);
   try
    if anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes) and f_WorkPool.HasWorkThreads and AllowAsyncRunTask(anItem) then
    begin
     if f_WorkPoolManager.EnterTaskExecution(anItem) then
       try
        Result := f_WorkPool.SubmitTask(anItem);
{$IFDEF InsiderTest}
        if Result then
          TrySimulateTaskDone(anItem);
{$ENDIF InsiderTest}
       finally
         f_WorkPoolManager.LeaveTaskExecution(anItem);
       end;// try
    end; // anItem.NeedProcess and (anItem.TaskType in EnabledTaskTypes)
   except
    on E: Exception do
    begin
     Exception2Log(E);
//     Inc(l_CurTaskIndex); // ����� ������������� ����� � ���
     {$IFDEF InsiderTest}
     if NeedRaiseInProcessQuery then
      raise;
     {$ENDIF}
    end;
   end; // except
  end; // not AllowTaskExecution
 end;//DoAsyncRun

begin
  if f_WorkPool.HasWorkThreads then
  begin
   f_ActiveTaskList.Sort;
   f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoAsyncRun));
  end;
end;

function TddServerTaskManager.pm_GetWorkThreadCount: Integer;
begin
 Result := f_WorkPool.WorkThreadCount
end;

procedure TddServerTaskManager.pm_SetWorkThreadCount(const Value: Integer);
var
 l_RealCount: Integer;
 l_Info: TSystemInfo;
begin
 if Value < 0 then
 begin
   GetSystemInfo(l_Info);
   l_RealCount := l_Info.dwNumberOfProcessors * 2;
 end
 else
  l_RealCount := Value;
 if f_WorkPool.WorkThreadCount <> l_RealCount then
 begin
  LockProcessing;
  try
   f_WorkPool.WorkThreadCount := l_RealCount
  finally
   UnLockProcessing;
  end;
 end; 
end;

function TddServerTaskManager.ExecutingTask: Boolean;
begin
  Result := Assigned(f_ActiveTask) and (f_ActiveTask.Status in cs_tsRunningStatuses) or
    f_WorkPool.HasRunningTask(Self);
end;

procedure TddServerTaskManager.FreezeRunningSyncTask;
begin
 if Assigned(f_ActiveTask) then
   FreezeTask(f_ActiveTask);
end;

procedure TddServerTaskManager.FreezeTask(const aTask: TddProcessTask);
begin
 if (aTask.Status in cs_tsRunningStatuses) then
 begin
  aTask.CanNotifyChange := false;
  AbortTask(aTask);
  aTask.RequestFrozenRun;
 end;
end;

procedure TddServerTaskManager.cs_RequestDeliveryTaskList(
  aPipe: TCSDataPipe);
var
 l_UserID: TUserID;
 l_List: TStringList;
 l_IDX: Integer;

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsReadyToDelivery) and (anItem.UserID = l_UserID) then
   l_List.Add(anItem.TaskID);
 end;

begin
 l_UserID := aPipe.ReadCardinal;
 l_List := TStringList.Create;
 try
  f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
  aPipe.WriteInteger(l_List.Count);
  for l_IDX := 0 to l_List.Count - 1 do
   aPipe.WRiteLn(l_List[l_IDX]);
 finally
  FreeAndNil(l_List);
 end;
end;

procedure TddServerTaskManager.cs_ExportResultProcessing(
  aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
 l_Watch: Tl3StopWatch;
begin
 l_Watch.Reset;

 g_SaveMessage.ReSet;
 g_LoadMessage.ReSet;
 g_SendMessage.ReSet;
 g_ReveiveMessage.ReSet;
 g_WaitFile.ReSet;
 g_ReceivePartFile.ReSet;
 g_SaveControl.ReSet;
 g_WriteFile.ReSet;
 g_SaveControl.ReSet;

 l_Watch.Start;
 try
{$IFDEF csSynchroTransport}
  l_Transporter := TncsSynchroServerTransporter.Make(aPipe.IOHandler);
  l_IsMainSocket := True;
{$ELSE csSynchroTransport}
  l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
{$ENDIF csSynchroTransport}
  try
   Assert(l_IsMainSocket);
   f_TransporterPool.Register(l_Transporter);
   try
    l_Transporter.ProcessMessages(l_IsMainSocket);
   finally
    CancelDelivering(l_Transporter.ClientID);
    f_TransporterPool.UnRegister(l_Transporter);
   end;
  finally
   l_Transporter := nil;
  end;
 finally
  l_Watch.Stop;
 end;

 l3System.Msg2Log('����������� ����� - %s ms', [FormatFloat('0,###.000', l_Watch.Time * 1000)]);
{$IFDEF ncsProfile}
 l3System.Msg2Log('SAVE MESSAGE = %s', [FormatFloat('0,###.000', g_SaveMessage.Time * 1000)]);
 l3System.Msg2Log('SEND MESSAGE = %s', [FormatFloat('0,###.000', g_SendMessage.Time * 1000)]);
 l3System.Msg2Log('SEND MESSAGE FLUSH = %s', [FormatFloat('0,###.000', g_SaveControl.Time * 1000)]);
 l3System.Msg2Log('LOAD MESSAGE = %s', [FormatFloat('0,###.000', g_LoadMessage.Time * 1000)]);
 l3System.Msg2Log('RECEIVE MESSAGE = %s', [FormatFloat('0,###.000', g_ReveiveMessage.Time * 1000)]);
 l3System.Msg2Log('WAIT FILE = %s', [FormatFloat('0,###.000', g_WaitFile.Time * 1000)]);
 l3System.Msg2Log('SEND FILE = %s', [FormatFloat('0,###.000', g_ReceivePartFile.Time * 1000)]);
 l3System.Msg2Log('WRITE FILE = %s', [FormatFloat('0,###.000', g_WriteFile.Time * 1000)]);
 l3System.Msg2Log('TOTAL = %s', [FormatFloat('0,###.000', l_Watch.Time * 1000)]);
{$ENDIF ncsProfile}
end;

function TddServerTaskManager.MakeExecutor(
  aMessage: TncsMessage): IncsExecutor;
begin
 if aMessage is TncsGetReadyToDeliveryTasks then
  Result := TalcuGetReadyToDeliveryTasksExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsGetTaskDescription then
  Result := TalcuGetTaskDescriptionExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsTaskProgress then
  Result := TalcuTaskProgressExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsGetFilePart then
  Result := TalcuGetFilePartExecutor.Make(f_ActiveTaskList)
 else if aMessage is TncsDeliveryResult then
  Result := TalcuDeliveryResultExecutor.Make(f_ActiveTaskList, Self)
 else if aMessage is TncsSendTask then
{$IFDEF csSynchroTransport}
  Result := TalcuSendTaskExecutor.Make(f_IncomingTasks, RootTaskFolder)
{$ELSE csSynchroTransport}
  Result := TalcuDetachedExecutor.Make(f_DetachedExecutorPool, TalcuSendTaskExecutor.Make(f_IncomingTasks, RootTaskFolder))
{$ENDIF csSynchroTransport}
 else if aMessage is TncsCorrectFolder then
  Result := TalcuCorrectFolderExecutor.Make(f_ActiveTaskList)
 else
  Result := nil;
end;

procedure TddServerTaskManager.CancelDelivering(aCLientID: TcsClientID);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status = cs_tsDelivering) and (anItem.UserID = aClientID) then
   anItem.CorrectStatus;
 end;

begin
 f_ActiveTaskList.ForEachF(L2AlcuTasksIteratorForEachFAction(@DoIt));
end;

procedure TddServerTaskManager.cs_TaskSend(aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
begin
{$IFDEF csSynchroTransport}
 l_Transporter := TncsSynchroServerTransporter.Make(aPipe.IOHandler);
 l_IsMainSocket := True;
{$ELSE csSynchroTransport}
 l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
{$ENDIF csSynchroTransport}
 try
  Assert(l_IsMainSocket);
  f_TransporterPool.Register(l_Transporter);
  try
   l_Transporter.ProcessMessages(l_IsMainSocket);
  finally
   f_TransporterPool.UnRegister(l_Transporter);
   f_DetachedExecutorPool.Pack;
  end;
 finally
  l_Transporter := nil;
 end;
end;

procedure TddServerTaskManager.cs_TransporterHandshake(aPipe: TCSDataPipe);
var
 l_Transporter: IncsServerTransporter;
 l_IsMainSocket: Boolean;
begin
{$IFDEF csSynchroTransport}
 Assert(False);
{$ENDIF csSynchroTransport}
 l_Transporter := TncsServerTransporter.Make(aPipe.IOHandler, l_IsMainSocket);
 try
  Assert(not l_IsMainSocket);
  l_Transporter.ProcessMessages(l_IsMainSocket);
 finally
  l_Transporter := nil;
 end;
end;

procedure TddServerTaskManager.Changed;
begin
 TaskListUpdated(nil);
end;

procedure TddServerTaskManager.Changing;
begin
// DoNothing;
end;

procedure TddServerTaskManager.cs_TerminateTask(aPipe: TCSDataPipe);

 function DoIt(anItem: TddProcessTask): Boolean;
 begin
  Result := true;
  if (anItem.Status in cs_tsCanDeleteStatuses) and (aPipe.ClientID = anItem.UserID) then
  begin
   DeleteTask(anItem, True);
   l3System.Msg2Log('������ � ��������������� ' + anItem.TaskID + ' �������� �������������');
  end
  else
   l3System.Msg2Log('������ � ��������������� ' + anItem.TaskID + ' �� ����� ���� �������');
 end;

var
 l_TaskID: AnsiString;

begin
 l_TaskID := aPipe.ReadLn;
 if not WorkupTaskByIDF(l_TaskID, L2AlcuTasksIteratorForOneFAction(@DoIt)) then
  l3System.Msg2Log('������ � ��������������� ' + l_TaskID + ' �� ������� (��������)');
end;

procedure TddServerTaskManager.LockTaskExecution;
begin
 Inc(f_LockTaskExecution);
end;

function TddServerTaskManager.TaskExecutionLocked: Boolean;
begin
 Result := f_LockTaskExecution > 0;
end;

procedure TddServerTaskManager.UnlockTaskExecution;
begin
 Dec(f_LockTaskExecution);
 if f_LockTaskExecution < 0 then
  f_LockTaskExecution := 0;
end;

function TddServerTaskManager.AllowTaskExecution: Boolean;
begin
 Result := TaskExecutionEnabled and not TaskExecutionLocked and Tl3ProcessingEnabledService.Instance.Enabled; 
end;

procedure TddServerTaskManager.SignalServerStarted;
begin
  f_ServerStarted := True;
end;

end.

