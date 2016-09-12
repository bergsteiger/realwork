unit csTaskTypes;
{ ���� ����� }

{ $Id: csTaskTypes.pas,v 1.54 2016/09/12 12:29:55 lukyanets Exp $ }

// $Log: csTaskTypes.pas,v $
// Revision 1.54  2016/09/12 12:29:55  lukyanets
// ��������� � ���������
//
// Revision 1.53  2016/08/29 12:51:56  lukyanets
// ��������� ������ � ��������� �������� ����
//
// Revision 1.52  2016/06/02 15:23:09  fireton
// - ������������� � �������� ������� ��������
//
// Revision 1.51  2016/05/27 11:14:25  fireton
// - ������������� ������ � ������
//
// Revision 1.50  2016/05/20 09:50:09  lukyanets
// ������ ��������� "������ �����������"
//
// Revision 1.49  2016/04/15 11:57:02  lukyanets
// ������ ��������� ���
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.48  2016/04/12 08:24:38  lukyanets
// ���������� ������������ ������
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.47  2016/04/11 12:47:55  lukyanets
// ���������� ������������ ������
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.46  2016/04/07 13:52:49  lukyanets
// ��������� ������ ������
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.45  2016/04/01 12:07:04  lukyanets
// ��������� ������������ ������
// Committed on the Free edition of March Hare Software CVSNT Server.
// Upgrade to CVS Suite for more features and support:
// http://march-hare.com/cvsnt/
//
// Revision 1.44  2015/09/08 14:38:27  lukyanets
// ��������� ������� ����������
//
// Revision 1.43  2015/09/04 13:03:58  lukyanets
// ��������� ������
//
// Revision 1.42  2015/04/15 13:56:40  lukyanets
// ���� ������� ����������� �������� ���� �������
//
// Revision 1.41  2014/12/02 13:07:43  lukyanets
// ���������� �������� �� ������������
//
// Revision 1.40  2014/10/23 13:35:39  lukyanets
// ���������� �������� ���������
//
// Revision 1.39  2014/09/05 12:39:33  lukyanets
// ������ RegionImportTask
//
// Revision 1.38  2014/09/01 08:18:36  lukyanets
// ��������� �������� FTPBrowser
//
// Revision 1.37  2014/08/29 12:25:22  lukyanets
// ��� �������� ������� ������� ����������� ������, ����� ��� ��������������
//
// Revision 1.36  2014/08/25 12:02:30  lukyanets
// ������� ������� ��� ���
//
// Revision 1.35  2014/08/19 14:30:13  lukyanets
// {Requestlink:558466572}. ���������� alcuMDP � ������
//
// Revision 1.34  2014/08/19 11:57:43  lukyanets
// ��������� ������������ cs_tsFrozenRun
//
// Revision 1.33  2014/08/04 14:30:04  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - PrimeLite
//
// Revision 1.32  2014/08/04 13:13:11  lukyanets
// {Requestlink:558466572}. ��������� HavanskyExport
//
// Revision 1.31  2014/08/04 09:34:03  lukyanets
// {Requestlink:558466572}. ������ ��������� ������ - MisspellCorrect
//
// Revision 1.30  2014/08/01 10:23:07  lukyanets
// {Requestlink:558466572}. ��������� ddAppConfiguration
//
// Revision 1.29  2014/07/29 11:21:19  lukyanets
// {Requestlink:556143119}. ������ ���� ����� �������
//
// Revision 1.28  2014/07/24 10:05:51  lukyanets
// {Requestlink:556730516}. ����� ���������� ��������
//
// Revision 1.27  2014/07/16 15:35:40  lulin
// - �������� ��������.
//
// Revision 1.26  2014/07/14 11:06:18  lukyanets
// {Requestlink:553422280}. �������� ������ ���������� ���������
//
// Revision 1.25  2014/07/09 06:52:42  lukyanets
// {Requestlink:553422280}. ����� ���������� ��������.
//
// Revision 1.24  2014/07/08 13:58:58  lukyanets
// {Requestlink:553422280}. ����������� � ���������� ���������
//
// Revision 1.23  2014/07/03 06:36:40  lukyanets
// {Requestlink:552022662}. ���������
//
// Revision 1.22  2014/07/02 13:31:36  lulin
// - ����������� � ��������� �����.
//
// Revision 1.21  2014/06/24 11:38:52  lulin
// - ������������ ������ ����� � ����.
//
// Revision 1.20  2014/06/11 12:07:51  lulin
// - ������ ���.
//
// Revision 1.19  2014/06/11 11:58:28  lulin
// - ������ ���.
//
// Revision 1.18  2014/06/11 11:52:28  lulin
// - ������ ���.
//
// Revision 1.17  2014/06/09 09:37:40  lulin
// - bug fix: �� ��������� ������ �����������.
//
// Revision 1.16  2014/05/27 15:12:19  lulin
// - ������ ���.
//
// Revision 1.14  2012/10/12 10:50:20  narry
// ����������
//
// Revision 1.13  2012/10/02 08:01:56  narry
// ��������� ��������� ���������� � ����
//
// Revision 1.12  2012/07/13 11:27:26  narry
// ����������� �������� �� ����
//
// Revision 1.11  2012/04/17 13:21:56  narry
// ����������� ������� ������� (356073078)
//
// Revision 1.10  2011/11/16 10:20:12  narry
// ���������� ������� �� � � ������ ������������� (298682480)
//
// Revision 1.9  2011/08/09 09:31:20  narry
// ������� ���������� � ������� ������ ���� (266422146)
//

interface

uses
  evdTaskTypes
  ;

type
 TcsTaskStatus = evdTaskTypes.TcsTaskStatus;

const
 cs_tsNone = evdTaskTypes.cs_tsNone;
 cs_tsQuery = evdTaskTypes.cs_tsQuery;       { � ������� }
 cs_tsRun = evdTaskTypes.cs_tsRun;         { ����������� }
 cs_tsFrozen = evdTaskTypes.cs_tsFrozen;      { ���������� }
 cs_tsFrozenRun = evdTaskTypes.cs_tsFrozenRun;      { ���������� }
 cs_tsReadyToDelivery = evdTaskTypes.cs_tsReadyToDelivery;    { �������� �������� ������������ }
 cs_tsDone = evdTaskTypes.cs_tsDone;        { ���������� }
 cs_tsDeleted = evdTaskTypes.cs_tsDeleted;     { ������� }
 cs_tsError = evdTaskTypes.cs_tsError;       { ���������� ������� � ������ }
 cs_tsDelayed = evdTaskTypes.cs_tsDelayed;     { ���������� �������� �� �� }
 cs_tsDelivering = evdTaskTypes.cs_tsDelivering;  { ����������� �������� ����������� }
 cs_tsAsyncRun = evdTaskTypes.cs_tsAsyncRun; { ���������� � ����������� �������� }
 cs_tsAsyncError = evdTaskTypes.cs_tsAsyncError; { ���������� � ����������� �������� ������� � ������ }
 cs_tsAborting = evdTaskTypes.cs_tsAborting; { ���������� ����������� }

 cs_tsErrorStatuses = evdTaskTypes.cs_tsErrorStatuses;
 cs_tsRunningStatuses = evdTaskTypes.cs_tsRunningStatuses;
 cs_tsKeepProcessingStatuses = evdTaskTypes.cs_tsKeepProcessingStatuses;
 cs_tsStatusesWithProgress = evdTaskTypes.cs_tsStatusesWithProgress;
 cs_tsCanDeleteStatuses = evdTaskTypes.cs_tsCanDeleteStatuses;
 cs_tsFinishedStatuses = evdTaskTypes.cs_tsFinishedStatuses;

type 
 TcsTaskType = evdTaskTypes.TcsTaskType;

const
 cs_ttImport = evdTaskTypes.cs_ttImport;        // ������
 cs_ttExport = evdTaskTypes.cs_ttExport;        // ������� ����������
 cs_ttAutoClass = evdTaskTypes.cs_ttAutoClass;     // �����������������
 cs_ttAnnoExport = evdTaskTypes.cs_ttAnnoExport;     // ������� ����������� ���������
 cs_ttDictEdit = evdTaskTypes.cs_ttDictEdit;
 cs_ttRequest = evdTaskTypes.cs_ttRequest;
 cs_ttGetTask = evdTaskTypes.cs_ttGetTask;
 cs_ttLine = evdTaskTypes.cs_ttLine;
 cs_ttServerStatus = evdTaskTypes.cs_ttServerStatus;
 cs_ttTaskResult = evdTaskTypes.cs_ttTaskResult;
 cs_ttUserEdit = evdTaskTypes.cs_ttUserEdit;
 cs_ttDeleteDocs = evdTaskTypes.cs_ttDeleteDocs;
 cs_ttCommonData = evdTaskTypes.cs_ttCommonData;
 cs_ttAExportDoc = evdTaskTypes.cs_ttAExportDoc;
 cs_ttAExportAnno = evdTaskTypes.cs_ttAExportAnno;
 cs_ttRegionAutoExport = evdTaskTypes.cs_ttRegionAutoExport;
 cs_ttRunCommand = evdTaskTypes.cs_ttRunCommand;
 cs_ttDossierMake = evdTaskTypes.cs_ttDossierMake;
 cs_ttCaseCode = evdTaskTypes.cs_ttCaseCode;
 cs_ttUserDefinedExport = evdTaskTypes.cs_ttUserDefinedExport;
 cs_ttSpellCheck = evdTaskTypes.cs_ttSpellCheck;
 cs_ttAutoSpellCheck = evdTaskTypes.cs_ttAutoSpellCheck;
 cs_ttAACImport = evdTaskTypes.cs_ttAACImport;
 cs_ttRelPublish = evdTaskTypes.cs_ttRelPublish;
 cs_ttUnregistered = evdTaskTypes.cs_ttUnregistered;
 cs_ttAnoncedExport = evdTaskTypes.cs_ttAnoncedExport;
 cs_ttHavanskyExport = evdTaskTypes.cs_ttHavanskyExport;
 cs_ttRegionImport = evdTaskTypes.cs_ttRegionImport;
 cs_ttMdpSyncDicts = evdTaskTypes.cs_ttMdpSyncDicts;
 cs_ttMdpSyncStages = evdTaskTypes.cs_ttMdpSyncStages;
 cs_ttMdpSyncImport = evdTaskTypes.cs_ttMdpSyncImport;
 cs_ttMdpImportDocs = evdTaskTypes.cs_ttMdpImportDocs;
 cs_ttContainer = evdTaskTypes.cs_ttContainer;
 cs_ttSchedulerProxy = evdTaskTypes.cs_ttSchedulerProxy;
 cs_ttDownloadDoc = evdTaskTypes.cs_ttDownloadDoc;
 cs_ttUploadDoc = evdTaskTypes.cs_ttUploadDoc;

(*  TcsFileRenameMode = (cs_frmUnique//, // ������� ���������� ��� ��� ������ �����
                       //cs_frmBackup, // ������� bak-����� ������� �����
                       //cs_frmAdd,    // �������� � ������������
                       //cs_frmReplace // �������� ������������
                       );*)

type
  TcsTaskTypes = set of TcsTaskType;
  //TcsTaskNotifyEvent = procedure (Sender: TObject; PrevStatus : TcsTaskStatus) of object;


const
   { TcsExecutionStatus }
  cs_arsSuccess = 0;
  cs_arsAborted = 1;
  cs_arsGeneralError = 2;
  cs_arsUtilityNotFound = 3;
   { ������� �� ������� }
  cs_arsTaskUnregistered = 4;

implementation

end.
