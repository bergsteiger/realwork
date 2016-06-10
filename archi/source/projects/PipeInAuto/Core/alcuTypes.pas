unit alcuTypes;
{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

Uses
  l3Base, l3LongintList,
  daInterfaces,
  dt_Types,
  Graphics, l3Types,
  ddCalendarEvents,
  Classes
  ,ddServerTask
  , csProcessTask;

type
 TalcuStatus       = (dd_apsRevert,  // ����� ������� �� ����������
                      dd_apsIdle,     // ����� ��������
                      dd_apsChecking, // ����� ����������� �������
                      dd_apsImport,
                      dd_apsQueryAdded,
                      dd_apsAutoClass,
                      dd_apsProcessQuery,
                      dd_apsExport,
                      dd_apsFound,
                      dd_apsSendMessage,
                      dd_apsCheckTextBase,
                      dd_apsBackup,
                      dd_apsUndoBackup,
                      dd_apsFullBackup,
                      dd_apsUndoFullBackup,
                      dd_apsLoadKW,
                      dd_apsPrepareKWFile,
                      dd_apsLoadNSRC,
                      dd_apsEverydayUpdate,
                      dd_apsLoadDelta,
                      dd_apsIndexHeaders,
                      dd_apsMailService,
                      dd_apsCompareStorages,
                      dd_apsCompileDictionary,
                      dd_apsCopyStageFile,
                      dd_apsBuildTextIndex,
                      dd_apsStartBaseEngine,
                      dd_apsStopBaseEngine,
                      dd_apsPreventiveUpdate,
                      dd_apsIndexDictEntry,
                      dd_apsUpdateTables,
                      dd_apsDelivery,
                      dd_apsSetAutoSub,
                      dd_apsDeleteDocs,
                      dd_apsMDPSync,
                      dd_apsDelivering,
                      dd_apsCopyBackupToVersion,
                      dd_apsCopyVersionToBackup);

 TddAutoPipeError = (dd_apeNoError, dd_apeCreateBackup, dd_apeCreateFullBackup,
                      dd_apeLoadKW, dd_apeLoadNSRC, dd_apeIndex);

 TddDeltaResult = (drOk, drBackupError, drTextIndexError, drImportError,
                   drPrepareError, drDelayed);

  TalcuStatusList = class(Tl3LongintList)
  public
    function Peek: TalcuStatus;
    function Pop: TalcuStatus;
    procedure Push(aStatus: TalcuStatus);
  end;

  TddUserListNotify = procedure(theUserName: IdaArchiUser; Active: Boolean) of object;
  TalcuStatusNotify = procedure (Status: TalcuStatus{; QueryLen: Integer}) of
          object;
  TddSendSMSNotify = procedure (aMessage, aPhoneNumber: String) of object;

 //TddTaskManagerStatus = (dd_tmsIdle, dd_tmsWorking, dd_tmsDone, dd_tmsDelivery);
 //TddTaskManagerStatusNotify = procedure (NewStatus : TalcuStatus) of object;
 TddProcessTaskEvent = TNotifyEvent;
 TTaskListDeleteEvent = procedure (Sender: TObject; TaskID: String) of object;
 TddTaskListChangedEvent = procedure (Task: TddProcessTask) of object;
 TTaskListRefreshEvent = TNotifyEvent;
 TSendEmailNotify = function (const aAddress, aMessage, aSubject: String;
                               const aError: Boolean; aAttach: TStrings = nil): Boolean of object;

const
 TalcuStatusNames : array[TalcuStatus] of String = (
  '����� �������', //dd_apsDefault,
  '��������', //dd_apsIdle,
  '����� �������', //dd_apsChecking,
  '������', //dd_apsImport,
  '�����������������',
  '������� ���������', // dd_apsQueryAdded
  '��������� �������', // dd_apsProcessQuery
  '�������', //dd_apsExport,
  '������� �������', //dd_apsFound,
  '�������� ���������', //dd_apsSendMessage,
  '�������� ��������� ����', //dd_apsCheckTextBase,
  '�������� ��������� �����', //dd_apsBackup,
  '�������������� �� ��������� �����', //dd_apsUndoBackup,
  '�������� ������ ����� ����', //dd_apsFullBackup,
  '�������������� �� ��������� ������ �����', //dd_apsUndoFullBackup,
  '������ �������� ����', //dd_apsLoadKW,
  '���������� ����� �������� ����',
  '������ NSRC-������', //dd_apsLoadNSRC,
  '���������� ����������',
  '������������ ����������', //dd_apsLoadDelta,
  '���������� ����������', //dd_apsIndexHeaders
  '��������� �����',
  '��������� ��������',
  '���������� ��������',
  '����������� ����� ������',
  '���������� ������� ����������',
  '����������� � ����',
  '���������� �� ����',
  '���������������� ����������',
  '���������� ������� ��������� ������',
  '���������� ������ ���� ������',
  '���������� ������� ������� �������� ������������',
  '����������� ����� � �������������� ����������� �����',
  '�������� ����������',
  '������������� � MDP',
  '�������� �����������',
  '���������� �� ������ � ���������� �����',
  '���������� �� ���������� ����� � �����'
  );

 TddAutoPipeErrorNames : array[TddAutoPipeError] of String = (
  '�������� ����������� �������', // dd_apeNoError,
  '������ �������� ���������� ��������� �����', // dd_apeCreateBackup,
  '������ �������� ������������ ��������� �����', // dd_apeCreateFullBackup,
  '������ ������� �������� ����', // dd_apeLoadKW,
  '������ ������� nsrc-������', // dd_apeLoadNSRC,
  '������ ���������� ���������� �������' // dd_apeIndex
  );

 TddDeltaResultNames : array[TddDeltaResult] of String = (
  '"������" ��������� �������. ��� �������� ��������� �������', // drOk
  '������ �������� ��������� �����', // drBackupError
  '� ���������� ����� ������� �����-�����', // drTextIndexError
  '������ ������� NSRC- ��� KW-������', // drImportError
  '������ �������� "������"', // drPrepareError
  '���������� ��������' // drDelayed
  );
 DeltaReadyMessage = 'SX weekly delta ready';

 alcuSilentUser = 68;
type
 TalcuMissedTask = (taskBackup, taskKW, taskUpdateBase, taskHeaderIndex,
                     taskTextIndex, taskCommitImg);
 TalcuMissedTasks = set of TalcuMissedTask;

const
{$IFDEF Region}
 alcuMessageLevel = l3_msgAll;
{$ELSE}
 alcuMessageLevel = l3_msgLevel1;
{$ENDIF}
var
 LegalShutdown : Boolean;

implementation



{ TalcuStatusList }

{
******************************* TalcuStatusList ********************************
}
function TalcuStatusList.Peek: TalcuStatus;
begin
 Assert(Count > 0, '������� ���������');

  Result:= TalcuStatus(Items[Hi]);
end;

function TalcuStatusList.Pop: TalcuStatus;
begin
 Assert(Count > 0, '������� ���������');

 Delete(Hi);
 Result:= Peek;
end;

procedure TalcuStatusList.Push(aStatus: TalcuStatus);
begin
  Add(Ord(aStatus));
end;

initialization
{$IF Defined(LUK) or Defined(SGC)}
 ddEnabledTasks := [ctUpdateTask, ctPreventiveTask, ctAutoExportTask, ctVersion, ctCompilation, ctContainer];
{$ELSE}
 {$IF Defined(Region)}
 ddEnabledTasks := [ctDeltaTask, ctUpdateTask, ctPreventiveTask, ctAutoExportTask, ctLoadRegions,
                     ctAutoSubs, ctAutoclassify, ctVersion, ctCompilation, ctUploadRegions, ctAnnoExport, ctContainer];

 {$ELSE}
 ddEnabledTasks := [ctDeltaTask, ctUpdateTask, ctBirthdayTask, ctHolidayTask, ctPreventiveTask,
                     ctAutoExportTask, ctLoadRegions, ctAutoSubs, ctAutoclassify,
                     ctVersion, ctCompilation, ctUploadRegions, ctRelPublish, ctHavansky, ctCloneBase,
                     ctExportAnonced, ctExportAnoncedEx, ctAnnoExport, ctContainer];
 {$IFEND}
 {$IFDEF MDPSyncIntegrated}
 ddEnabledTasks := ddEnabledTasks + [ctMdpSyncDicts, ctMdpSyncDocs, ctMdpSyncStages, ctMdpSyncImport];
 {$ENDIF MDPSyncIntegrated}
{$IFEND}

finalization
 (*
 if LegalShutdown then

 else
 *)
end.
