unit ExportTask_Const;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "EVD"
// Модуль: "w:/common/components/rtl/Garant/EVD/ExportTask_Const.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Tag::Class>> Shared Delphi::EVD::Standard::evdTasks::ExportTask
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Константы для значений тега ExportTask .
// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\EVD\evdDefine.inc}

interface

uses
  k2Base {a},
  evdTasks_Schema
  ;

function k2_typExportTask_DiapasonType: ExportTask_DiapasonType_Tag;

function k2_typExportTask_OutFileType: ExportTask_OutFileType_Tag;

function k2_typExportTask_SeparateFiles: ExportTask_SeparateFiles_Tag;

function k2_typExportTask_SABStream: ExportTask_SABStream_Tag;

function k2_typExportTask_RegionIDList: ExportTask_RegionIDList_Tag;

function k2_attrAnnoTopicFileName: Integer;

function k2_attrDiapasonType: Integer;

function k2_attrDocID: Integer;

function k2_attrDocumentFileNameMask: Integer;

function k2_attrExportAnnoTopics: Integer;

function k2_attrExportDirectory: Integer;

function k2_attrExportDocImage: Integer;

function k2_attrExportDocument: Integer;

function k2_attrExportEmptyKW: Integer;

function k2_attrExportKW: Integer;

function k2_attrExportRTFBody: Integer;

function k2_attrFamily: Integer;

function k2_attrInternalFormat: Integer;

function k2_attrKWFileName: Integer;

function k2_attrMultiUser: Integer;

function k2_attrObjTopicFileName: Integer;

function k2_attrOnlyStructure: Integer;

function k2_attrOutFileType: Integer;

function k2_attrOutputFileSize: Integer;

function k2_attrReferenceFileNameMask: Integer;

function k2_attrSeparateFiles: Integer;

function k2_attrToRegion: Integer;

function k2_attrExportReference: Integer;

function k2_attrExportEditions: Integer;

function k2_attrFormulaAsPicture: Integer;

function k2_attrExportReferences: Integer;

function k2_attrSABStream: Integer;

function k2_attrAdditionalProcess: Integer;

function k2_attrRegionIDList: Integer;
function k2_typExportTask: ExportTaskTag;

implementation

uses
  k2Facade {a},
  k2Attributes {a}
  ;

var
 g_ExportTask : ExportTaskTag = nil;

// start class ExportTaskTag

function k2_typExportTask: ExportTaskTag;
begin
 if (g_ExportTask = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask;
 end;//g_ExportTask = nil
 Result := g_ExportTask;
end;
var
 g_k2_attrAnnoTopicFileName: Integer = -1;

function k2_attrAnnoTopicFileName: Integer;
begin
 if (g_k2_attrAnnoTopicFileName = -1) then
  g_k2_attrAnnoTopicFileName :=  Tk2Attributes.Instance.CheckIDByName('AnnoTopicFileName');
 Result := g_k2_attrAnnoTopicFileName;
end;

var
 g_k2_attrDiapasonType: Integer = -1;

function k2_attrDiapasonType: Integer;
begin
 if (g_k2_attrDiapasonType = -1) then
  g_k2_attrDiapasonType :=  Tk2Attributes.Instance.CheckIDByName('DiapasonType');
 Result := g_k2_attrDiapasonType;
end;

var
 g_k2_attrDocID: Integer = -1;

function k2_attrDocID: Integer;
begin
 if (g_k2_attrDocID = -1) then
  g_k2_attrDocID :=  Tk2Attributes.Instance.CheckIDByName('DocID');
 Result := g_k2_attrDocID;
end;

var
 g_k2_attrDocumentFileNameMask: Integer = -1;

function k2_attrDocumentFileNameMask: Integer;
begin
 if (g_k2_attrDocumentFileNameMask = -1) then
  g_k2_attrDocumentFileNameMask :=  Tk2Attributes.Instance.CheckIDByName('DocumentFileNameMask');
 Result := g_k2_attrDocumentFileNameMask;
end;

var
 g_k2_attrExportAnnoTopics: Integer = -1;

function k2_attrExportAnnoTopics: Integer;
begin
 if (g_k2_attrExportAnnoTopics = -1) then
  g_k2_attrExportAnnoTopics :=  Tk2Attributes.Instance.CheckIDByName('ExportAnnoTopics');
 Result := g_k2_attrExportAnnoTopics;
end;

var
 g_k2_attrExportDirectory: Integer = -1;

function k2_attrExportDirectory: Integer;
begin
 if (g_k2_attrExportDirectory = -1) then
  g_k2_attrExportDirectory :=  Tk2Attributes.Instance.CheckIDByName('ExportDirectory');
 Result := g_k2_attrExportDirectory;
end;

var
 g_k2_attrExportDocImage: Integer = -1;

function k2_attrExportDocImage: Integer;
begin
 if (g_k2_attrExportDocImage = -1) then
  g_k2_attrExportDocImage :=  Tk2Attributes.Instance.CheckIDByName('ExportDocImage');
 Result := g_k2_attrExportDocImage;
end;

var
 g_k2_attrExportDocument: Integer = -1;

function k2_attrExportDocument: Integer;
begin
 if (g_k2_attrExportDocument = -1) then
  g_k2_attrExportDocument :=  Tk2Attributes.Instance.CheckIDByName('ExportDocument');
 Result := g_k2_attrExportDocument;
end;

var
 g_k2_attrExportEmptyKW: Integer = -1;

function k2_attrExportEmptyKW: Integer;
begin
 if (g_k2_attrExportEmptyKW = -1) then
  g_k2_attrExportEmptyKW :=  Tk2Attributes.Instance.CheckIDByName('ExportEmptyKW');
 Result := g_k2_attrExportEmptyKW;
end;

var
 g_k2_attrExportKW: Integer = -1;

function k2_attrExportKW: Integer;
begin
 if (g_k2_attrExportKW = -1) then
  g_k2_attrExportKW :=  Tk2Attributes.Instance.CheckIDByName('ExportKW');
 Result := g_k2_attrExportKW;
end;

var
 g_k2_attrExportRTFBody: Integer = -1;

function k2_attrExportRTFBody: Integer;
begin
 if (g_k2_attrExportRTFBody = -1) then
  g_k2_attrExportRTFBody :=  Tk2Attributes.Instance.CheckIDByName('ExportRTFBody');
 Result := g_k2_attrExportRTFBody;
end;

var
 g_k2_attrFamily: Integer = -1;

function k2_attrFamily: Integer;
begin
 if (g_k2_attrFamily = -1) then
  g_k2_attrFamily :=  Tk2Attributes.Instance.CheckIDByName('Family');
 Result := g_k2_attrFamily;
end;

var
 g_k2_attrInternalFormat: Integer = -1;

function k2_attrInternalFormat: Integer;
begin
 if (g_k2_attrInternalFormat = -1) then
  g_k2_attrInternalFormat :=  Tk2Attributes.Instance.CheckIDByName('InternalFormat');
 Result := g_k2_attrInternalFormat;
end;

var
 g_k2_attrKWFileName: Integer = -1;

function k2_attrKWFileName: Integer;
begin
 if (g_k2_attrKWFileName = -1) then
  g_k2_attrKWFileName :=  Tk2Attributes.Instance.CheckIDByName('KWFileName');
 Result := g_k2_attrKWFileName;
end;

var
 g_k2_attrMultiUser: Integer = -1;

function k2_attrMultiUser: Integer;
begin
 if (g_k2_attrMultiUser = -1) then
  g_k2_attrMultiUser :=  Tk2Attributes.Instance.CheckIDByName('MultiUser');
 Result := g_k2_attrMultiUser;
end;

var
 g_k2_attrObjTopicFileName: Integer = -1;

function k2_attrObjTopicFileName: Integer;
begin
 if (g_k2_attrObjTopicFileName = -1) then
  g_k2_attrObjTopicFileName :=  Tk2Attributes.Instance.CheckIDByName('ObjTopicFileName');
 Result := g_k2_attrObjTopicFileName;
end;

var
 g_k2_attrOnlyStructure: Integer = -1;

function k2_attrOnlyStructure: Integer;
begin
 if (g_k2_attrOnlyStructure = -1) then
  g_k2_attrOnlyStructure :=  Tk2Attributes.Instance.CheckIDByName('OnlyStructure');
 Result := g_k2_attrOnlyStructure;
end;

var
 g_k2_attrOutFileType: Integer = -1;

function k2_attrOutFileType: Integer;
begin
 if (g_k2_attrOutFileType = -1) then
  g_k2_attrOutFileType :=  Tk2Attributes.Instance.CheckIDByName('OutFileType');
 Result := g_k2_attrOutFileType;
end;

var
 g_k2_attrOutputFileSize: Integer = -1;

function k2_attrOutputFileSize: Integer;
begin
 if (g_k2_attrOutputFileSize = -1) then
  g_k2_attrOutputFileSize :=  Tk2Attributes.Instance.CheckIDByName('OutputFileSize');
 Result := g_k2_attrOutputFileSize;
end;

var
 g_k2_attrReferenceFileNameMask: Integer = -1;

function k2_attrReferenceFileNameMask: Integer;
begin
 if (g_k2_attrReferenceFileNameMask = -1) then
  g_k2_attrReferenceFileNameMask :=  Tk2Attributes.Instance.CheckIDByName('ReferenceFileNameMask');
 Result := g_k2_attrReferenceFileNameMask;
end;

var
 g_k2_attrSeparateFiles: Integer = -1;

function k2_attrSeparateFiles: Integer;
begin
 if (g_k2_attrSeparateFiles = -1) then
  g_k2_attrSeparateFiles :=  Tk2Attributes.Instance.CheckIDByName('SeparateFiles');
 Result := g_k2_attrSeparateFiles;
end;

var
 g_k2_attrToRegion: Integer = -1;

function k2_attrToRegion: Integer;
begin
 if (g_k2_attrToRegion = -1) then
  g_k2_attrToRegion :=  Tk2Attributes.Instance.CheckIDByName('ToRegion');
 Result := g_k2_attrToRegion;
end;

var
 g_k2_attrExportReference: Integer = -1;

function k2_attrExportReference: Integer;
begin
 if (g_k2_attrExportReference = -1) then
  g_k2_attrExportReference :=  Tk2Attributes.Instance.CheckIDByName('ExportReference');
 Result := g_k2_attrExportReference;
end;

var
 g_k2_attrExportEditions: Integer = -1;

function k2_attrExportEditions: Integer;
begin
 if (g_k2_attrExportEditions = -1) then
  g_k2_attrExportEditions :=  Tk2Attributes.Instance.CheckIDByName('ExportEditions');
 Result := g_k2_attrExportEditions;
end;

var
 g_k2_attrFormulaAsPicture: Integer = -1;

function k2_attrFormulaAsPicture: Integer;
begin
 if (g_k2_attrFormulaAsPicture = -1) then
  g_k2_attrFormulaAsPicture :=  Tk2Attributes.Instance.CheckIDByName('FormulaAsPicture');
 Result := g_k2_attrFormulaAsPicture;
end;

var
 g_k2_attrExportReferences: Integer = -1;

function k2_attrExportReferences: Integer;
begin
 if (g_k2_attrExportReferences = -1) then
  g_k2_attrExportReferences :=  Tk2Attributes.Instance.CheckIDByName('ExportReferences');
 Result := g_k2_attrExportReferences;
end;

var
 g_k2_attrSABStream: Integer = -1;

function k2_attrSABStream: Integer;
begin
 if (g_k2_attrSABStream = -1) then
  g_k2_attrSABStream :=  Tk2Attributes.Instance.CheckIDByName('SABStream');
 Result := g_k2_attrSABStream;
end;

var
 g_k2_attrAdditionalProcess: Integer = -1;

function k2_attrAdditionalProcess: Integer;
begin
 if (g_k2_attrAdditionalProcess = -1) then
  g_k2_attrAdditionalProcess :=  Tk2Attributes.Instance.CheckIDByName('AdditionalProcess');
 Result := g_k2_attrAdditionalProcess;
end;

var
 g_k2_attrRegionIDList: Integer = -1;

function k2_attrRegionIDList: Integer;
begin
 if (g_k2_attrRegionIDList = -1) then
  g_k2_attrRegionIDList :=  Tk2Attributes.Instance.CheckIDByName('RegionIDList');
 Result := g_k2_attrRegionIDList;
end;


var
 g_ExportTask_DiapasonType : ExportTask_DiapasonType_Tag = nil;

// start class DiapasonType

function k2_typExportTask_DiapasonType: ExportTask_DiapasonType_Tag;
begin
 if (g_ExportTask_DiapasonType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask_DiapasonType := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask_DiapasonType;
 end;//g_ExportTask = nil
 Result := g_ExportTask_DiapasonType;
end;

var
 g_ExportTask_OutFileType : ExportTask_OutFileType_Tag = nil;

// start class OutFileType

function k2_typExportTask_OutFileType: ExportTask_OutFileType_Tag;
begin
 if (g_ExportTask_OutFileType = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask_OutFileType := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask_OutFileType;
 end;//g_ExportTask = nil
 Result := g_ExportTask_OutFileType;
end;

var
 g_ExportTask_SeparateFiles : ExportTask_SeparateFiles_Tag = nil;

// start class SeparateFiles

function k2_typExportTask_SeparateFiles: ExportTask_SeparateFiles_Tag;
begin
 if (g_ExportTask_SeparateFiles = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask_SeparateFiles := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask_SeparateFiles;
 end;//g_ExportTask = nil
 Result := g_ExportTask_SeparateFiles;
end;

var
 g_ExportTask_SABStream : ExportTask_SABStream_Tag = nil;

// start class SABStream

function k2_typExportTask_SABStream: ExportTask_SABStream_Tag;
begin
 if (g_ExportTask_SABStream = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask_SABStream := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask_SABStream;
 end;//g_ExportTask = nil
 Result := g_ExportTask_SABStream;
end;

var
 g_ExportTask_RegionIDList : ExportTask_RegionIDList_Tag = nil;

// start class RegionIDList

function k2_typExportTask_RegionIDList: ExportTask_RegionIDList_Tag;
begin
 if (g_ExportTask_RegionIDList = nil) then
 begin
  Assert(Tk2TypeTable.GetInstance Is TevdTasksSchema);
  g_ExportTask_RegionIDList := TevdTasksSchema(Tk2TypeTable.GetInstance).t_ExportTask_RegionIDList;
 end;//g_ExportTask = nil
 Result := g_ExportTask_RegionIDList;
end;


end.