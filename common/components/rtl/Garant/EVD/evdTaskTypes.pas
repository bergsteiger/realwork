unit evdTaskTypes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "EVD"
// ������: "w:/common/components/rtl/Garant/EVD/NOT_FINISHED_evdTaskTypes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi::EVD::Standard::evdTaskTypes
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\EVD\evdDefine.inc}

interface

type
 TcsTaskStatus = (cs_tsNone,
                  cs_tsQuery,       { � ������� }
                  cs_tsRun,         { ����������� }
                  cs_tsFrozen,      { ���������� }
                  cs_tsFrozenRun,   { ���������� �������������� }
                  cs_tsDelivery,    { �������� �������� ������������ }
                  cs_tsDone,        { ���������� }
                  cs_tsDeleted,     { ������� }
                  cs_tsError,       { ���������� ������� � ������ }
                  cs_tsDelayed,     { ���������� �������� �� �� }
                  cs_tsDelivering,  { ����������� �������� ����������� }
                  cs_tsAsyncRun,    { ���������� � ����������� �������� }
                  cs_tsAsyncError   { ���������� � ����������� �������� ������� � ������ }
                  );
const
  cs_tsReadyToDelivery = cs_tsDelivery;
  cs_tsErrorStatuses = [cs_tsError, cs_tsAsyncError];
  cs_tsRunningStatuses = [cs_tsRun, cs_tsAsyncRun];
  cs_tsKeepProcessingStatuses = [cs_tsFrozen, cs_tsFrozenRun, cs_tsDeleted, cs_tsReadyToDelivery, cs_tsDelivering, cs_tsAsyncRun, cs_tsQuery];
  cs_tsStatusesWithProgress = cs_tsRunningStatuses + [cs_tsDelivering];
  cs_tsCanDeleteStatuses = [cs_tsRun, cs_tsAsyncRun, cs_tsQuery, cs_tsFrozen, cs_tsReadyToDelivery];

type
 TcsTaskType = (cs_ttImport,        // ������
                cs_ttExport,        // ������� ����������
                cs_ttAutoClass,     // �����������������
                cs_ttAnnoExport,     // ������� ����������� ���������
                cs_ttDictEdit,
                cs_ttRequest,
                cs_ttGetTask,
                cs_ttLine,
                cs_ttServerStatus,
                cs_ttTaskResult,
                cs_tt_Deprecated_FNSExport,
                cs_ttUserEdit,
                cs_ttDeleteDocs,
                cs_ttCommonData,
                cs_ttAExportDoc,
                cs_ttAExportAnno,
                cs_ttRemoteDictEdit,
                cs_ttRegionAutoExport,
                cs_ttRunCommand,
                cs_ttDossierMake,
                cs_ttCaseCode,
                cs_tt_Deprecated_PrimeExport,
                cs_ttUserDefinedExport,
                cs_ttSpellCheck,
                cs_ttAutoSpellCheck,
                cs_ttAACImport,
                cs_ttRelPublish,
                cs_ttUnregistered,
                cs_tt_Deprecated_MDPSync,
                cs_tt_Deprecated_AACRelExport,
                cs_tt_Deprecated_MisspellCorrect,
                cs_tt_Deprecated_NCFRExport,
                cs_ttUnknown,
                cs_ttClientMessage,
                cs_ttAsEVD,
                cs_ttProcess,
                cs_ttAnoncedExport,
                cs_ttHavanskyExport,
                cs_ttRegionImport,
                cs_ttMdpSyncDicts,
                cs_ttMdpImportDocs
                );

 TCsNotificationType = (ntEmpty,
                        ntServerStarted,
                        ntServerStopped,
                        ntTaskChanged,
                        ntTaskProgress,
                        ntRepeatLogin,
                        ntAutoLogoff,
                        ntInformation,
                        ntUserLogin,
                        ntUserLogout,
                        ntMailArrived,
                        ntTaskAdded,
                        ntDictEdit,
                        ntHaveNewMessages,
                        ntExportDone,
                        ntImportDone,
                        ntDelDoc,
                        ntCalendar,
                        ntAnouncedDateChanged,
                        ntAbortAsyncRun,
                        ntResultsReadyForDelivery);

 TCsNotificationTypes = set of TCsNotificationType;                       
                        
const
  usServerService = 65000;
  SomeFixedDate = usServerService;
                        
implementation

end.