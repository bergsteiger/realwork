unit AACImport_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/AACImport_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::AACImport
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега AACImport .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typAACImport_SourceIDList: AACImport_SourceIDList_Tag;

function k2_typAACImport_DossierSourceIDList: AACImport_DossierSourceIDList_Tag;

function k2_typAACImport_DocTypesIDList: AACImport_DocTypesIDList_Tag;

function k2_typAACImport_FASSourceIDList: AACImport_FASSourceIDList_Tag;

function k2_attrManualMode: Integer;

function k2_attrCreatedByServer: Integer;

function k2_attrLogsFolder: Integer;

function k2_attrDestinationFolder: Integer;

function k2_attrZippedLogsFolder: Integer;

function k2_attrMailToLog: Integer;

function k2_attrDuplicatesFolder: Integer;

function k2_attrLinkDataFile: Integer;

function k2_attrKeyThemesFile: Integer;

function k2_attrSourceIDList: Integer;

function k2_attrBaseArchiveName: Integer;

function k2_attrDossierSourceIDList: Integer;

function k2_attrMisspellsFileName: Integer;

function k2_attrFASCorrectFileName: Integer;

function k2_attrDocTypesIDList: Integer;

function k2_attrFASSourceIDList: Integer;

function k2_attrSourceConvertFileName: Integer;

function k2_attrTypeRecodeFileName: Integer;

function k2_attrSourceFileName: Integer;

function k2_attrPartialLoadPackSize: Integer;

function k2_attrCourtDecisionSabCheckerParams: Integer;

function k2_attrTaskCountBeforeRun: Integer;
function k2_typAACImport: AACImportTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_AACImport : AACImportTag = nil;

// start class AACImportTag

function k2_typAACImport: AACImportTag;
begin
 if (g_AACImport = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImport := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImport;
 end;//g_AACImport = nil
 Result := g_AACImport;
end;
var
 g_k2_attrManualMode: Integer = -1;

function k2_attrManualMode: Integer;
begin
 if (g_k2_attrManualMode = -1) then
  g_k2_attrManualMode :=  Tk2Attributes.Instance.CheckIDByName('ManualMode');
 Result := g_k2_attrManualMode;
end;

var
 g_k2_attrCreatedByServer: Integer = -1;

function k2_attrCreatedByServer: Integer;
begin
 if (g_k2_attrCreatedByServer = -1) then
  g_k2_attrCreatedByServer :=  Tk2Attributes.Instance.CheckIDByName('CreatedByServer');
 Result := g_k2_attrCreatedByServer;
end;

var
 g_k2_attrLogsFolder: Integer = -1;

function k2_attrLogsFolder: Integer;
begin
 if (g_k2_attrLogsFolder = -1) then
  g_k2_attrLogsFolder :=  Tk2Attributes.Instance.CheckIDByName('LogsFolder');
 Result := g_k2_attrLogsFolder;
end;

var
 g_k2_attrDestinationFolder: Integer = -1;

function k2_attrDestinationFolder: Integer;
begin
 if (g_k2_attrDestinationFolder = -1) then
  g_k2_attrDestinationFolder :=  Tk2Attributes.Instance.CheckIDByName('DestinationFolder');
 Result := g_k2_attrDestinationFolder;
end;

var
 g_k2_attrZippedLogsFolder: Integer = -1;

function k2_attrZippedLogsFolder: Integer;
begin
 if (g_k2_attrZippedLogsFolder = -1) then
  g_k2_attrZippedLogsFolder :=  Tk2Attributes.Instance.CheckIDByName('ZippedLogsFolder');
 Result := g_k2_attrZippedLogsFolder;
end;

var
 g_k2_attrMailToLog: Integer = -1;

function k2_attrMailToLog: Integer;
begin
 if (g_k2_attrMailToLog = -1) then
  g_k2_attrMailToLog :=  Tk2Attributes.Instance.CheckIDByName('MailToLog');
 Result := g_k2_attrMailToLog;
end;

var
 g_k2_attrDuplicatesFolder: Integer = -1;

function k2_attrDuplicatesFolder: Integer;
begin
 if (g_k2_attrDuplicatesFolder = -1) then
  g_k2_attrDuplicatesFolder :=  Tk2Attributes.Instance.CheckIDByName('DuplicatesFolder');
 Result := g_k2_attrDuplicatesFolder;
end;

var
 g_k2_attrLinkDataFile: Integer = -1;

function k2_attrLinkDataFile: Integer;
begin
 if (g_k2_attrLinkDataFile = -1) then
  g_k2_attrLinkDataFile :=  Tk2Attributes.Instance.CheckIDByName('LinkDataFile');
 Result := g_k2_attrLinkDataFile;
end;

var
 g_k2_attrKeyThemesFile: Integer = -1;

function k2_attrKeyThemesFile: Integer;
begin
 if (g_k2_attrKeyThemesFile = -1) then
  g_k2_attrKeyThemesFile :=  Tk2Attributes.Instance.CheckIDByName('KeyThemesFile');
 Result := g_k2_attrKeyThemesFile;
end;

var
 g_k2_attrSourceIDList: Integer = -1;

function k2_attrSourceIDList: Integer;
begin
 if (g_k2_attrSourceIDList = -1) then
  g_k2_attrSourceIDList :=  Tk2Attributes.Instance.CheckIDByName('SourceIDList');
 Result := g_k2_attrSourceIDList;
end;

var
 g_k2_attrBaseArchiveName: Integer = -1;

function k2_attrBaseArchiveName: Integer;
begin
 if (g_k2_attrBaseArchiveName = -1) then
  g_k2_attrBaseArchiveName :=  Tk2Attributes.Instance.CheckIDByName('BaseArchiveName');
 Result := g_k2_attrBaseArchiveName;
end;

var
 g_k2_attrDossierSourceIDList: Integer = -1;

function k2_attrDossierSourceIDList: Integer;
begin
 if (g_k2_attrDossierSourceIDList = -1) then
  g_k2_attrDossierSourceIDList :=  Tk2Attributes.Instance.CheckIDByName('DossierSourceIDList');
 Result := g_k2_attrDossierSourceIDList;
end;

var
 g_k2_attrMisspellsFileName: Integer = -1;

function k2_attrMisspellsFileName: Integer;
begin
 if (g_k2_attrMisspellsFileName = -1) then
  g_k2_attrMisspellsFileName :=  Tk2Attributes.Instance.CheckIDByName('MisspellsFileName');
 Result := g_k2_attrMisspellsFileName;
end;

var
 g_k2_attrFASCorrectFileName: Integer = -1;

function k2_attrFASCorrectFileName: Integer;
begin
 if (g_k2_attrFASCorrectFileName = -1) then
  g_k2_attrFASCorrectFileName :=  Tk2Attributes.Instance.CheckIDByName('FASCorrectFileName');
 Result := g_k2_attrFASCorrectFileName;
end;

var
 g_k2_attrDocTypesIDList: Integer = -1;

function k2_attrDocTypesIDList: Integer;
begin
 if (g_k2_attrDocTypesIDList = -1) then
  g_k2_attrDocTypesIDList :=  Tk2Attributes.Instance.CheckIDByName('DocTypesIDList');
 Result := g_k2_attrDocTypesIDList;
end;

var
 g_k2_attrFASSourceIDList: Integer = -1;

function k2_attrFASSourceIDList: Integer;
begin
 if (g_k2_attrFASSourceIDList = -1) then
  g_k2_attrFASSourceIDList :=  Tk2Attributes.Instance.CheckIDByName('FASSourceIDList');
 Result := g_k2_attrFASSourceIDList;
end;

var
 g_k2_attrSourceConvertFileName: Integer = -1;

function k2_attrSourceConvertFileName: Integer;
begin
 if (g_k2_attrSourceConvertFileName = -1) then
  g_k2_attrSourceConvertFileName :=  Tk2Attributes.Instance.CheckIDByName('SourceConvertFileName');
 Result := g_k2_attrSourceConvertFileName;
end;

var
 g_k2_attrTypeRecodeFileName: Integer = -1;

function k2_attrTypeRecodeFileName: Integer;
begin
 if (g_k2_attrTypeRecodeFileName = -1) then
  g_k2_attrTypeRecodeFileName :=  Tk2Attributes.Instance.CheckIDByName('TypeRecodeFileName');
 Result := g_k2_attrTypeRecodeFileName;
end;

var
 g_k2_attrSourceFileName: Integer = -1;

function k2_attrSourceFileName: Integer;
begin
 if (g_k2_attrSourceFileName = -1) then
  g_k2_attrSourceFileName :=  Tk2Attributes.Instance.CheckIDByName('SourceFileName');
 Result := g_k2_attrSourceFileName;
end;

var
 g_k2_attrPartialLoadPackSize: Integer = -1;

function k2_attrPartialLoadPackSize: Integer;
begin
 if (g_k2_attrPartialLoadPackSize = -1) then
  g_k2_attrPartialLoadPackSize :=  Tk2Attributes.Instance.CheckIDByName('PartialLoadPackSize');
 Result := g_k2_attrPartialLoadPackSize;
end;

var
 g_k2_attrCourtDecisionSabCheckerParams: Integer = -1;

function k2_attrCourtDecisionSabCheckerParams: Integer;
begin
 if (g_k2_attrCourtDecisionSabCheckerParams = -1) then
  g_k2_attrCourtDecisionSabCheckerParams :=  Tk2Attributes.Instance.CheckIDByName('CourtDecisionSabCheckerParams');
 Result := g_k2_attrCourtDecisionSabCheckerParams;
end;

var
 g_k2_attrTaskCountBeforeRun: Integer = -1;

function k2_attrTaskCountBeforeRun: Integer;
begin
 if (g_k2_attrTaskCountBeforeRun = -1) then
  g_k2_attrTaskCountBeforeRun :=  Tk2Attributes.Instance.CheckIDByName('TaskCountBeforeRun');
 Result := g_k2_attrTaskCountBeforeRun;
end;


var
 g_AACImport_SourceIDList : AACImport_SourceIDList_Tag = nil;

// start class SourceIDList

function k2_typAACImport_SourceIDList: AACImport_SourceIDList_Tag;
begin
 if (g_AACImport_SourceIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImport_SourceIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImport_SourceIDList;
 end;//g_AACImport = nil
 Result := g_AACImport_SourceIDList;
end;

var
 g_AACImport_DossierSourceIDList : AACImport_DossierSourceIDList_Tag = nil;

// start class DossierSourceIDList

function k2_typAACImport_DossierSourceIDList: AACImport_DossierSourceIDList_Tag;
begin
 if (g_AACImport_DossierSourceIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImport_DossierSourceIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImport_DossierSourceIDList;
 end;//g_AACImport = nil
 Result := g_AACImport_DossierSourceIDList;
end;

var
 g_AACImport_DocTypesIDList : AACImport_DocTypesIDList_Tag = nil;

// start class DocTypesIDList

function k2_typAACImport_DocTypesIDList: AACImport_DocTypesIDList_Tag;
begin
 if (g_AACImport_DocTypesIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImport_DocTypesIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImport_DocTypesIDList;
 end;//g_AACImport = nil
 Result := g_AACImport_DocTypesIDList;
end;

var
 g_AACImport_FASSourceIDList : AACImport_FASSourceIDList_Tag = nil;

// start class FASSourceIDList

function k2_typAACImport_FASSourceIDList: AACImport_FASSourceIDList_Tag;
begin
 if (g_AACImport_FASSourceIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_AACImport_FASSourceIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_AACImport_FASSourceIDList;
 end;//g_AACImport = nil
 Result := g_AACImport_FASSourceIDList;
end;


end.