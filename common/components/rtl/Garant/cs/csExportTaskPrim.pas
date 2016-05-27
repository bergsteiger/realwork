unit csExportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csExportTaskPrim.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TcsExportTaskPrim" MUID: (53ABFB2C005A)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , csProcessTask
 , evdDTTypes
 , evdTasksHelpers
 , k2Base
;

type
 TcsExportTaskPrim = class(TddProcessTask)
  protected
   function pm_GetAnnoTopicFileName: AnsiString;
   procedure pm_SetAnnoTopicFileName(const aValue: AnsiString);
   function pm_GetDiapasonType: TDiapType;
   procedure pm_SetDiapasonType(aValue: TDiapType);
   function pm_GetDocID: Integer;
   procedure pm_SetDocID(aValue: Integer);
   function pm_GetDocumentFileNameMask: AnsiString;
   procedure pm_SetDocumentFileNameMask(const aValue: AnsiString);
   function pm_GetExportAnnoTopics: Boolean;
   procedure pm_SetExportAnnoTopics(aValue: Boolean);
   function pm_GetExportDirectory: AnsiString;
   procedure pm_SetExportDirectory(const aValue: AnsiString);
   function pm_GetExportDocImage: Boolean;
   procedure pm_SetExportDocImage(aValue: Boolean);
   function pm_GetExportDocument: Boolean;
   procedure pm_SetExportDocument(aValue: Boolean);
   function pm_GetExportEmptyKW: Boolean;
   procedure pm_SetExportEmptyKW(aValue: Boolean);
   function pm_GetExportKW: Boolean;
   procedure pm_SetExportKW(aValue: Boolean);
   function pm_GetExportRTFBody: Boolean;
   procedure pm_SetExportRTFBody(aValue: Boolean);
   function pm_GetFamily: Integer;
   procedure pm_SetFamily(aValue: Integer);
   function pm_GetInternalFormat: Boolean;
   procedure pm_SetInternalFormat(aValue: Boolean);
   function pm_GetKWFileName: AnsiString;
   procedure pm_SetKWFileName(const aValue: AnsiString);
   function pm_GetMultiUser: Boolean;
   procedure pm_SetMultiUser(aValue: Boolean);
   function pm_GetObjTopicFileName: AnsiString;
   procedure pm_SetObjTopicFileName(const aValue: AnsiString);
   function pm_GetOnlyStructure: Boolean;
   procedure pm_SetOnlyStructure(aValue: Boolean);
   function pm_GetOutFileType: TepSupportFileType;
   procedure pm_SetOutFileType(aValue: TepSupportFileType);
   function pm_GetOutputFileSize: Integer;
   procedure pm_SetOutputFileSize(aValue: Integer);
   function pm_GetReferenceFileNameMask: AnsiString;
   procedure pm_SetReferenceFileNameMask(const aValue: AnsiString);
   function pm_GetSeparateFiles: TepDivideBy;
   procedure pm_SetSeparateFiles(aValue: TepDivideBy);
   function pm_GetToRegion: Cardinal;
   procedure pm_SetToRegion(aValue: Cardinal);
   function pm_GetExportReference: Boolean;
   procedure pm_SetExportReference(aValue: Boolean);
   function pm_GetExportEditions: Boolean;
   procedure pm_SetExportEditions(aValue: Boolean);
   function pm_GetFormulaAsPicture: Boolean;
   procedure pm_SetFormulaAsPicture(aValue: Boolean);
   function pm_GetExportReferences: Boolean;
   procedure pm_SetExportReferences(aValue: Boolean);
   function pm_GetSABStream: SABStreamHelper;
   function pm_GetAdditionalProcess: AnsiString;
   procedure pm_SetAdditionalProcess(const aValue: AnsiString);
   function pm_GetRegionIDList: RegionIDListHelper;
  public
   class function GetTaggedDataType: Tk2Type; override;
  public
   property AnnoTopicFileName: AnsiString
    read pm_GetAnnoTopicFileName
    write pm_SetAnnoTopicFileName;
   property DiapasonType: TDiapType
    read pm_GetDiapasonType
    write pm_SetDiapasonType;
   property DocID: Integer
    read pm_GetDocID
    write pm_SetDocID;
   property DocumentFileNameMask: AnsiString
    read pm_GetDocumentFileNameMask
    write pm_SetDocumentFileNameMask;
   property ExportAnnoTopics: Boolean
    read pm_GetExportAnnoTopics
    write pm_SetExportAnnoTopics;
   property ExportDirectory: AnsiString
    read pm_GetExportDirectory
    write pm_SetExportDirectory;
   property ExportDocImage: Boolean
    read pm_GetExportDocImage
    write pm_SetExportDocImage;
   property ExportDocument: Boolean
    read pm_GetExportDocument
    write pm_SetExportDocument;
   property ExportEmptyKW: Boolean
    read pm_GetExportEmptyKW
    write pm_SetExportEmptyKW;
   property ExportKW: Boolean
    read pm_GetExportKW
    write pm_SetExportKW;
   property ExportRTFBody: Boolean
    read pm_GetExportRTFBody
    write pm_SetExportRTFBody;
   property Family: Integer
    read pm_GetFamily
    write pm_SetFamily;
   property InternalFormat: Boolean
    read pm_GetInternalFormat
    write pm_SetInternalFormat;
   property KWFileName: AnsiString
    read pm_GetKWFileName
    write pm_SetKWFileName;
   property MultiUser: Boolean
    read pm_GetMultiUser
    write pm_SetMultiUser;
   property ObjTopicFileName: AnsiString
    read pm_GetObjTopicFileName
    write pm_SetObjTopicFileName;
   property OnlyStructure: Boolean
    read pm_GetOnlyStructure
    write pm_SetOnlyStructure;
   property OutFileType: TepSupportFileType
    read pm_GetOutFileType
    write pm_SetOutFileType;
   property OutputFileSize: Integer
    read pm_GetOutputFileSize
    write pm_SetOutputFileSize;
   property ReferenceFileNameMask: AnsiString
    read pm_GetReferenceFileNameMask
    write pm_SetReferenceFileNameMask;
   property SeparateFiles: TepDivideBy
    read pm_GetSeparateFiles
    write pm_SetSeparateFiles;
   property ToRegion: Cardinal
    read pm_GetToRegion
    write pm_SetToRegion;
   property ExportReference: Boolean
    read pm_GetExportReference
    write pm_SetExportReference;
   property ExportEditions: Boolean
    read pm_GetExportEditions
    write pm_SetExportEditions;
   property FormulaAsPicture: Boolean
    read pm_GetFormulaAsPicture
    write pm_SetFormulaAsPicture;
   property ExportReferences: Boolean
    read pm_GetExportReferences
    write pm_SetExportReferences;
   property SABStream: SABStreamHelper
    read pm_GetSABStream;
   property AdditionalProcess: AnsiString
    read pm_GetAdditionalProcess
    write pm_SetAdditionalProcess;
   property RegionIDList: RegionIDListHelper
    read pm_GetRegionIDList;
 end;//TcsExportTaskPrim
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ExportTask_Const
;

function TcsExportTaskPrim.pm_GetAnnoTopicFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAnnoTopicFileName]);
end;//TcsExportTaskPrim.pm_GetAnnoTopicFileName

procedure TcsExportTaskPrim.pm_SetAnnoTopicFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrAnnoTopicFileName, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetAnnoTopicFileName

function TcsExportTaskPrim.pm_GetDiapasonType: TDiapType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TDiapType(TaggedData.IntA[k2_attrDiapasonType]);
end;//TcsExportTaskPrim.pm_GetDiapasonType

procedure TcsExportTaskPrim.pm_SetDiapasonType(aValue: TDiapType);
begin
 TaggedData.IntW[k2_attrDiapasonType, nil] := Ord(aValue);
end;//TcsExportTaskPrim.pm_SetDiapasonType

function TcsExportTaskPrim.pm_GetDocID: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrDocID]);
end;//TcsExportTaskPrim.pm_GetDocID

procedure TcsExportTaskPrim.pm_SetDocID(aValue: Integer);
begin
 TaggedData.IntW[k2_attrDocID, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetDocID

function TcsExportTaskPrim.pm_GetDocumentFileNameMask: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrDocumentFileNameMask]);
end;//TcsExportTaskPrim.pm_GetDocumentFileNameMask

procedure TcsExportTaskPrim.pm_SetDocumentFileNameMask(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrDocumentFileNameMask, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetDocumentFileNameMask

function TcsExportTaskPrim.pm_GetExportAnnoTopics: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportAnnoTopics]);
end;//TcsExportTaskPrim.pm_GetExportAnnoTopics

procedure TcsExportTaskPrim.pm_SetExportAnnoTopics(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportAnnoTopics, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportAnnoTopics

function TcsExportTaskPrim.pm_GetExportDirectory: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrExportDirectory]);
end;//TcsExportTaskPrim.pm_GetExportDirectory

procedure TcsExportTaskPrim.pm_SetExportDirectory(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrExportDirectory, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportDirectory

function TcsExportTaskPrim.pm_GetExportDocImage: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportDocImage]);
end;//TcsExportTaskPrim.pm_GetExportDocImage

procedure TcsExportTaskPrim.pm_SetExportDocImage(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportDocImage, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportDocImage

function TcsExportTaskPrim.pm_GetExportDocument: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportDocument]);
end;//TcsExportTaskPrim.pm_GetExportDocument

procedure TcsExportTaskPrim.pm_SetExportDocument(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportDocument, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportDocument

function TcsExportTaskPrim.pm_GetExportEmptyKW: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportEmptyKW]);
end;//TcsExportTaskPrim.pm_GetExportEmptyKW

procedure TcsExportTaskPrim.pm_SetExportEmptyKW(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportEmptyKW, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportEmptyKW

function TcsExportTaskPrim.pm_GetExportKW: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportKW]);
end;//TcsExportTaskPrim.pm_GetExportKW

procedure TcsExportTaskPrim.pm_SetExportKW(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportKW, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportKW

function TcsExportTaskPrim.pm_GetExportRTFBody: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportRTFBody]);
end;//TcsExportTaskPrim.pm_GetExportRTFBody

procedure TcsExportTaskPrim.pm_SetExportRTFBody(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportRTFBody, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportRTFBody

function TcsExportTaskPrim.pm_GetFamily: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrFamily]);
end;//TcsExportTaskPrim.pm_GetFamily

procedure TcsExportTaskPrim.pm_SetFamily(aValue: Integer);
begin
 TaggedData.IntW[k2_attrFamily, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetFamily

function TcsExportTaskPrim.pm_GetInternalFormat: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrInternalFormat]);
end;//TcsExportTaskPrim.pm_GetInternalFormat

procedure TcsExportTaskPrim.pm_SetInternalFormat(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrInternalFormat, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetInternalFormat

function TcsExportTaskPrim.pm_GetKWFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrKWFileName]);
end;//TcsExportTaskPrim.pm_GetKWFileName

procedure TcsExportTaskPrim.pm_SetKWFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrKWFileName, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetKWFileName

function TcsExportTaskPrim.pm_GetMultiUser: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrMultiUser]);
end;//TcsExportTaskPrim.pm_GetMultiUser

procedure TcsExportTaskPrim.pm_SetMultiUser(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrMultiUser, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetMultiUser

function TcsExportTaskPrim.pm_GetObjTopicFileName: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrObjTopicFileName]);
end;//TcsExportTaskPrim.pm_GetObjTopicFileName

procedure TcsExportTaskPrim.pm_SetObjTopicFileName(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrObjTopicFileName, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetObjTopicFileName

function TcsExportTaskPrim.pm_GetOnlyStructure: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrOnlyStructure]);
end;//TcsExportTaskPrim.pm_GetOnlyStructure

procedure TcsExportTaskPrim.pm_SetOnlyStructure(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrOnlyStructure, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetOnlyStructure

function TcsExportTaskPrim.pm_GetOutFileType: TepSupportFileType;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TepSupportFileType(TaggedData.IntA[k2_attrOutFileType]);
end;//TcsExportTaskPrim.pm_GetOutFileType

procedure TcsExportTaskPrim.pm_SetOutFileType(aValue: TepSupportFileType);
begin
 TaggedData.IntW[k2_attrOutFileType, nil] := Ord(aValue);
end;//TcsExportTaskPrim.pm_SetOutFileType

function TcsExportTaskPrim.pm_GetOutputFileSize: Integer;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.IntA[k2_attrOutputFileSize]);
end;//TcsExportTaskPrim.pm_GetOutputFileSize

procedure TcsExportTaskPrim.pm_SetOutputFileSize(aValue: Integer);
begin
 TaggedData.IntW[k2_attrOutputFileSize, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetOutputFileSize

function TcsExportTaskPrim.pm_GetReferenceFileNameMask: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrReferenceFileNameMask]);
end;//TcsExportTaskPrim.pm_GetReferenceFileNameMask

procedure TcsExportTaskPrim.pm_SetReferenceFileNameMask(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrReferenceFileNameMask, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetReferenceFileNameMask

function TcsExportTaskPrim.pm_GetSeparateFiles: TepDivideBy;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TepDivideBy(TaggedData.IntA[k2_attrSeparateFiles]);
end;//TcsExportTaskPrim.pm_GetSeparateFiles

procedure TcsExportTaskPrim.pm_SetSeparateFiles(aValue: TepDivideBy);
begin
 TaggedData.IntW[k2_attrSeparateFiles, nil] := Ord(aValue);
end;//TcsExportTaskPrim.pm_SetSeparateFiles

function TcsExportTaskPrim.pm_GetToRegion: Cardinal;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := Cardinal(TaggedData.IntA[k2_attrToRegion]);
end;//TcsExportTaskPrim.pm_GetToRegion

procedure TcsExportTaskPrim.pm_SetToRegion(aValue: Cardinal);
begin
 TaggedData.IntW[k2_attrToRegion, nil] := Integer(aValue);
end;//TcsExportTaskPrim.pm_SetToRegion

function TcsExportTaskPrim.pm_GetExportReference: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportReference]);
end;//TcsExportTaskPrim.pm_GetExportReference

procedure TcsExportTaskPrim.pm_SetExportReference(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportReference, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportReference

function TcsExportTaskPrim.pm_GetExportEditions: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportEditions]);
end;//TcsExportTaskPrim.pm_GetExportEditions

procedure TcsExportTaskPrim.pm_SetExportEditions(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportEditions, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportEditions

function TcsExportTaskPrim.pm_GetFormulaAsPicture: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrFormulaAsPicture]);
end;//TcsExportTaskPrim.pm_GetFormulaAsPicture

procedure TcsExportTaskPrim.pm_SetFormulaAsPicture(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrFormulaAsPicture, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetFormulaAsPicture

function TcsExportTaskPrim.pm_GetExportReferences: Boolean;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.BoolA[k2_attrExportReferences]);
end;//TcsExportTaskPrim.pm_GetExportReferences

procedure TcsExportTaskPrim.pm_SetExportReferences(aValue: Boolean);
begin
 TaggedData.BoolW[k2_attrExportReferences, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetExportReferences

function TcsExportTaskPrim.pm_GetSABStream: SABStreamHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TSABStreamHelper.Make(TaggedData.cAtom(k2_attrSABStream));
end;//TcsExportTaskPrim.pm_GetSABStream

function TcsExportTaskPrim.pm_GetAdditionalProcess: AnsiString;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := (TaggedData.StrA[k2_attrAdditionalProcess]);
end;//TcsExportTaskPrim.pm_GetAdditionalProcess

procedure TcsExportTaskPrim.pm_SetAdditionalProcess(const aValue: AnsiString);
begin
 TaggedData.StrW[k2_attrAdditionalProcess, nil] := (aValue);
end;//TcsExportTaskPrim.pm_SetAdditionalProcess

function TcsExportTaskPrim.pm_GetRegionIDList: RegionIDListHelper;
begin
 Assert(Self <> nil);
 Assert(TaggedData <> nil);
 Result := TRegionIDListHelper.Make(TaggedData.cAtom(k2_attrRegionIDList));
end;//TcsExportTaskPrim.pm_GetRegionIDList

class function TcsExportTaskPrim.GetTaggedDataType: Tk2Type;
begin
 Result := k2_typExportTask;
end;//TcsExportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
