unit CsQueryTypes;

{ $Id: CsQueryTypes.pas,v 1.42 2015/06/05 11:50:09 lukyanets Exp $ }

// $Log: CsQueryTypes.pas,v $
// Revision 1.42  2015/06/05 11:50:09  lukyanets
// ��������� ������� ��� �������� ����
//
// Revision 1.41  2015/04/15 13:56:40  lukyanets
// ���� ������� ����������� �������� ���� �������
//
// Revision 1.40  2015/04/01 07:17:39  lukyanets
// Cleanup
//
// Revision 1.39  2015/03/25 11:07:13  lukyanets
// �������� ���������
//
// Revision 1.38  2015/01/27 09:53:15  lukyanets
// Cleanup
//
// Revision 1.37  2014/12/18 15:02:56  lukyanets
// �������� ������� � �������� �����
//
// Revision 1.36  2014/12/08 15:03:29  lukyanets
// ���������
//
// Revision 1.35  2014/11/07 11:54:44  lukyanets
// ��������� ���������� � �������
//
// Revision 1.34  2014/10/28 11:52:23  lukyanets
// ��������� ���������� ���������� ������. ������ � ������� ������.
//
// Revision 1.33  2014/09/24 07:16:40  lukyanets
// {RequestLink:565271071}
//
// Revision 1.32  2014/08/12 09:33:58  lukyanets
// {Requestlink:560730919}. ������� �������� ������
//
// Revision 1.31  2014/08/12 07:33:53  lukyanets
// {Requestlink:560730919}. ����������� ����� ����
//
// Revision 1.30  2014/08/06 11:28:48  lukyanets
// {Requestlink:556143119}. �������� ���������� �� ����
//
// Revision 1.29  2014/07/29 08:14:51  lukyanets
// {Requestlink:557844282}. ���� ����������
//
// Revision 1.28  2014/07/25 09:45:57  lukyanets
// {Requestlink:557844282}. ��������� dt_mail � �����������
//
// Revision 1.27  2014/07/25 07:33:38  lukyanets
// {Requestlink:557844282}. ��������� dt_mail ����� ����� ������������ ��������� ����� ������
//
// Revision 1.26  2014/07/15 07:23:18  lukyanets
// {Requestlink:553422280}. ������������ ������ �� �����
//
// Revision 1.25  2014/07/10 13:08:50  lukyanets
// {Requestlink:553422280}. ����������� ��������
//
// Revision 1.24  2014/05/21 13:57:35  lulin
// - ������ ���.
//
// Revision 1.23  2013/04/03 09:51:26  fireton
// - ������ ����������� VANONCED
//
// Revision 1.22  2012/10/18 06:49:55  narry
// ������ pipeout2, ������� ������� ������ ����� � ���������� (383583730)
//
// Revision 1.21  2012/03/06 09:17:14  narry
// �������� � ������� ������ ����� ������� ���������� � ������ (273581950)
//
// Revision 1.20  2010/03/02 08:24:16  narry
// - ��������� splash
//
// Revision 1.19  2009/07/22 08:20:23  narry
// - ����� ��������� _KeepAlive
// - cleanup
//
// Revision 1.18  2009/03/13 15:15:40  narry
// - ��������� ������ � ���� ���������� �� �������� ����� � ����������
//
// Revision 1.17  2009/01/13 16:18:23  narry
// - ���������� ���������
//
// Revision 1.16  2008/11/25 12:59:34  narry
// - ����������
//
// Revision 1.15  2008/07/10 13:02:24  fireton
// - ����� ��� ������� - ��������� ������� ���� ���������� ����
//
// Revision 1.14  2008/03/21 17:32:22  narry
// - ����� ��� ����������� ����� � ������
//
// Revision 1.13  2007/10/04 07:53:59  narry
// - ���������� ��������� ����������� �������
//
// Revision 1.12  2007/07/24 12:32:27  narry
// - ����������� ������� ���������
//
// Revision 1.11  2006/09/01 13:55:01  narry
// - ��� ����������� ������� � ������� ����������� ������ ������� � �������
//
// Revision 1.10  2006/08/02 12:18:46  narry
// - ������� ��� ��������� � �������
//
// Revision 1.9  2006/06/26 12:12:32  narry
// - ����������
//
// Revision 1.8  2006/06/22 11:41:21  fireton
// - ����� ����������� ����� �������� � ��������
//
// Revision 1.7  2006/06/05 14:52:55  narry
// - ����������: ���������� ������ �����
//
// Revision 1.6  2006/03/31 12:46:18  narry
// - ����������
//
// Revision 1.5  2006/03/16 15:50:16  narry
// - ��� ���� ����� � ������� ������-�������
//
// Revision 1.4  2006/03/09 11:47:12  narry
// - ���������: ����� ���������� �������� �������
//
// Revision 1.3  2006/02/08 17:24:29  step
// ���������� �������� ���������� �� �������-�������� � ��������� ��������
//

{$I CsDefine.inc}

interface

type
 TCsQueryId = (qtTest,
               qtClientIp,
               qtReLogin,
               qtLogout,
               qtFile,
               qtDirectory,
               qtTask,
               // ���� ������������ �������
               qtServerStatus,
               qtAllLine,
               qtMyLine_Deprecated,
               qtDeleteTask,
               qtTaskChanged,
               qtStartMonitoring,
               qtStartMyMonitoring,
               qtEndMonitoring,
               qtServerTask,
               qtTaskResult,
               qtGetTask,
               qtGetActiveUsersList,
               qtSendMail,
               qtDictEdit,
               qtGetDictEdit,
               qtGetMyMessages,
               qtGetTime,
               qtPrepareDocument,
               qtGetPreparedDocument,
               qtReturnChangedDocument,
               qtGetProtocolVersion,
               qtDeleteDocs,
               qtGetCommonData, // ��������� ����� ������ � ������� N
               qtGetBaseConfig,
               qtLoginEx,
               qtGetCommands,
               qtExecuteCommand,
               qtGetVersionDate,
               qtGetBaseStatus,
               qtGetNonEditableDicts,
               qtGetAllUsersList,
               qtGetExecuteStatus,
               qtGetDictChangeFileName,
               qtKeepAlive,
               qtGetLogo,
               qtGetToRegionList,
               qtGetAEParams,
               qtGetCompileDate,
               qtGetAnouncedDate,
               qtAsyncProgress,
               qtalcuGetServerUser, // �������� UserID ��� ������� ��������� ������
               qtalcuSendEMail, // ����������� ��������� ����� alcuMail.SendEmail
               qtalcuSendEMailNotify, // ����������� ��������� ����� alcuMail.SendEmailNotify
               qtalcuSendSMSNotify, // ����������� ��������� ����� alcuMail.SendSMSNotify
               qtalcuSendTaskResult, // ����������� ��������� ���������� �� ������� � ������
               qtRequestDeliveryTaskList, // �������� ������ ����� �� ������� ������ ����������
               qtalcuAACNeedTerminate, // ���� �� ��������� AACImport - ������ �������
               qtalcuExportResultProcessing, // ���������� ������������ �������� � �������� � ������ ������ (CRC etc).
               qtalcuSendTask, // �������� ������ � ������� �������������� ������ � �������� � ������ ������ (CRC etc).
               qtalcuHandShake, // ���������� ��������� ������
               qtalcuTerminateTask // �������� ���� ������.
             );

implementation

end.
