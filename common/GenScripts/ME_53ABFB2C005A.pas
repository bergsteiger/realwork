unit csExportTaskPrim;

// Модуль: "w:\common\components\rtl\Garant\cs\csExportTaskPrim.pas"
// Стереотип: "SimpleClass"

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
//#UC START# *7E624E775E8C_53ABFB2C005Aget_var*
//#UC END# *7E624E775E8C_53ABFB2C005Aget_var*
begin
//#UC START# *7E624E775E8C_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *7E624E775E8C_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetAnnoTopicFileName

procedure TcsExportTaskPrim.pm_SetAnnoTopicFileName(const aValue: AnsiString);
//#UC START# *7E624E775E8C_53ABFB2C005Aset_var*
//#UC END# *7E624E775E8C_53ABFB2C005Aset_var*
begin
//#UC START# *7E624E775E8C_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *7E624E775E8C_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetAnnoTopicFileName

function TcsExportTaskPrim.pm_GetDiapasonType: TDiapType;
//#UC START# *59CE3DC51DF9_53ABFB2C005Aget_var*
//#UC END# *59CE3DC51DF9_53ABFB2C005Aget_var*
begin
//#UC START# *59CE3DC51DF9_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *59CE3DC51DF9_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetDiapasonType

procedure TcsExportTaskPrim.pm_SetDiapasonType(aValue: TDiapType);
//#UC START# *59CE3DC51DF9_53ABFB2C005Aset_var*
//#UC END# *59CE3DC51DF9_53ABFB2C005Aset_var*
begin
//#UC START# *59CE3DC51DF9_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *59CE3DC51DF9_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetDiapasonType

function TcsExportTaskPrim.pm_GetDocID: Integer;
//#UC START# *F783B77F0C4D_53ABFB2C005Aget_var*
//#UC END# *F783B77F0C4D_53ABFB2C005Aget_var*
begin
//#UC START# *F783B77F0C4D_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *F783B77F0C4D_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetDocID

procedure TcsExportTaskPrim.pm_SetDocID(aValue: Integer);
//#UC START# *F783B77F0C4D_53ABFB2C005Aset_var*
//#UC END# *F783B77F0C4D_53ABFB2C005Aset_var*
begin
//#UC START# *F783B77F0C4D_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *F783B77F0C4D_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetDocID

function TcsExportTaskPrim.pm_GetDocumentFileNameMask: AnsiString;
//#UC START# *88923A90F575_53ABFB2C005Aget_var*
//#UC END# *88923A90F575_53ABFB2C005Aget_var*
begin
//#UC START# *88923A90F575_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *88923A90F575_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetDocumentFileNameMask

procedure TcsExportTaskPrim.pm_SetDocumentFileNameMask(const aValue: AnsiString);
//#UC START# *88923A90F575_53ABFB2C005Aset_var*
//#UC END# *88923A90F575_53ABFB2C005Aset_var*
begin
//#UC START# *88923A90F575_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *88923A90F575_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetDocumentFileNameMask

function TcsExportTaskPrim.pm_GetExportAnnoTopics: Boolean;
//#UC START# *710BC7CB9376_53ABFB2C005Aget_var*
//#UC END# *710BC7CB9376_53ABFB2C005Aget_var*
begin
//#UC START# *710BC7CB9376_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *710BC7CB9376_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportAnnoTopics

procedure TcsExportTaskPrim.pm_SetExportAnnoTopics(aValue: Boolean);
//#UC START# *710BC7CB9376_53ABFB2C005Aset_var*
//#UC END# *710BC7CB9376_53ABFB2C005Aset_var*
begin
//#UC START# *710BC7CB9376_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *710BC7CB9376_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportAnnoTopics

function TcsExportTaskPrim.pm_GetExportDirectory: AnsiString;
//#UC START# *29AA186E5527_53ABFB2C005Aget_var*
//#UC END# *29AA186E5527_53ABFB2C005Aget_var*
begin
//#UC START# *29AA186E5527_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *29AA186E5527_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportDirectory

procedure TcsExportTaskPrim.pm_SetExportDirectory(const aValue: AnsiString);
//#UC START# *29AA186E5527_53ABFB2C005Aset_var*
//#UC END# *29AA186E5527_53ABFB2C005Aset_var*
begin
//#UC START# *29AA186E5527_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *29AA186E5527_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportDirectory

function TcsExportTaskPrim.pm_GetExportDocImage: Boolean;
//#UC START# *0130817C59B6_53ABFB2C005Aget_var*
//#UC END# *0130817C59B6_53ABFB2C005Aget_var*
begin
//#UC START# *0130817C59B6_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0130817C59B6_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportDocImage

procedure TcsExportTaskPrim.pm_SetExportDocImage(aValue: Boolean);
//#UC START# *0130817C59B6_53ABFB2C005Aset_var*
//#UC END# *0130817C59B6_53ABFB2C005Aset_var*
begin
//#UC START# *0130817C59B6_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *0130817C59B6_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportDocImage

function TcsExportTaskPrim.pm_GetExportDocument: Boolean;
//#UC START# *EEE971EC9CAB_53ABFB2C005Aget_var*
//#UC END# *EEE971EC9CAB_53ABFB2C005Aget_var*
begin
//#UC START# *EEE971EC9CAB_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEE971EC9CAB_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportDocument

procedure TcsExportTaskPrim.pm_SetExportDocument(aValue: Boolean);
//#UC START# *EEE971EC9CAB_53ABFB2C005Aset_var*
//#UC END# *EEE971EC9CAB_53ABFB2C005Aset_var*
begin
//#UC START# *EEE971EC9CAB_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *EEE971EC9CAB_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportDocument

function TcsExportTaskPrim.pm_GetExportEmptyKW: Boolean;
//#UC START# *0519949F15BF_53ABFB2C005Aget_var*
//#UC END# *0519949F15BF_53ABFB2C005Aget_var*
begin
//#UC START# *0519949F15BF_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0519949F15BF_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportEmptyKW

procedure TcsExportTaskPrim.pm_SetExportEmptyKW(aValue: Boolean);
//#UC START# *0519949F15BF_53ABFB2C005Aset_var*
//#UC END# *0519949F15BF_53ABFB2C005Aset_var*
begin
//#UC START# *0519949F15BF_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *0519949F15BF_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportEmptyKW

function TcsExportTaskPrim.pm_GetExportKW: Boolean;
//#UC START# *D6DB35F844BA_53ABFB2C005Aget_var*
//#UC END# *D6DB35F844BA_53ABFB2C005Aget_var*
begin
//#UC START# *D6DB35F844BA_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6DB35F844BA_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportKW

procedure TcsExportTaskPrim.pm_SetExportKW(aValue: Boolean);
//#UC START# *D6DB35F844BA_53ABFB2C005Aset_var*
//#UC END# *D6DB35F844BA_53ABFB2C005Aset_var*
begin
//#UC START# *D6DB35F844BA_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6DB35F844BA_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportKW

function TcsExportTaskPrim.pm_GetExportRTFBody: Boolean;
//#UC START# *3845FBC84464_53ABFB2C005Aget_var*
//#UC END# *3845FBC84464_53ABFB2C005Aget_var*
begin
//#UC START# *3845FBC84464_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3845FBC84464_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportRTFBody

procedure TcsExportTaskPrim.pm_SetExportRTFBody(aValue: Boolean);
//#UC START# *3845FBC84464_53ABFB2C005Aset_var*
//#UC END# *3845FBC84464_53ABFB2C005Aset_var*
begin
//#UC START# *3845FBC84464_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *3845FBC84464_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportRTFBody

function TcsExportTaskPrim.pm_GetFamily: Integer;
//#UC START# *A668156113A4_53ABFB2C005Aget_var*
//#UC END# *A668156113A4_53ABFB2C005Aget_var*
begin
//#UC START# *A668156113A4_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A668156113A4_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetFamily

procedure TcsExportTaskPrim.pm_SetFamily(aValue: Integer);
//#UC START# *A668156113A4_53ABFB2C005Aset_var*
//#UC END# *A668156113A4_53ABFB2C005Aset_var*
begin
//#UC START# *A668156113A4_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *A668156113A4_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetFamily

function TcsExportTaskPrim.pm_GetInternalFormat: Boolean;
//#UC START# *AD29466FCA04_53ABFB2C005Aget_var*
//#UC END# *AD29466FCA04_53ABFB2C005Aget_var*
begin
//#UC START# *AD29466FCA04_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD29466FCA04_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetInternalFormat

procedure TcsExportTaskPrim.pm_SetInternalFormat(aValue: Boolean);
//#UC START# *AD29466FCA04_53ABFB2C005Aset_var*
//#UC END# *AD29466FCA04_53ABFB2C005Aset_var*
begin
//#UC START# *AD29466FCA04_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *AD29466FCA04_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetInternalFormat

function TcsExportTaskPrim.pm_GetKWFileName: AnsiString;
//#UC START# *DD2CDD11018D_53ABFB2C005Aget_var*
//#UC END# *DD2CDD11018D_53ABFB2C005Aget_var*
begin
//#UC START# *DD2CDD11018D_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *DD2CDD11018D_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetKWFileName

procedure TcsExportTaskPrim.pm_SetKWFileName(const aValue: AnsiString);
//#UC START# *DD2CDD11018D_53ABFB2C005Aset_var*
//#UC END# *DD2CDD11018D_53ABFB2C005Aset_var*
begin
//#UC START# *DD2CDD11018D_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *DD2CDD11018D_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetKWFileName

function TcsExportTaskPrim.pm_GetMultiUser: Boolean;
//#UC START# *180EB0ED7C16_53ABFB2C005Aget_var*
//#UC END# *180EB0ED7C16_53ABFB2C005Aget_var*
begin
//#UC START# *180EB0ED7C16_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *180EB0ED7C16_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetMultiUser

procedure TcsExportTaskPrim.pm_SetMultiUser(aValue: Boolean);
//#UC START# *180EB0ED7C16_53ABFB2C005Aset_var*
//#UC END# *180EB0ED7C16_53ABFB2C005Aset_var*
begin
//#UC START# *180EB0ED7C16_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *180EB0ED7C16_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetMultiUser

function TcsExportTaskPrim.pm_GetObjTopicFileName: AnsiString;
//#UC START# *C4748DEEBB7E_53ABFB2C005Aget_var*
//#UC END# *C4748DEEBB7E_53ABFB2C005Aget_var*
begin
//#UC START# *C4748DEEBB7E_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4748DEEBB7E_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetObjTopicFileName

procedure TcsExportTaskPrim.pm_SetObjTopicFileName(const aValue: AnsiString);
//#UC START# *C4748DEEBB7E_53ABFB2C005Aset_var*
//#UC END# *C4748DEEBB7E_53ABFB2C005Aset_var*
begin
//#UC START# *C4748DEEBB7E_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *C4748DEEBB7E_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetObjTopicFileName

function TcsExportTaskPrim.pm_GetOnlyStructure: Boolean;
//#UC START# *0596AE5D4612_53ABFB2C005Aget_var*
//#UC END# *0596AE5D4612_53ABFB2C005Aget_var*
begin
//#UC START# *0596AE5D4612_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *0596AE5D4612_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetOnlyStructure

procedure TcsExportTaskPrim.pm_SetOnlyStructure(aValue: Boolean);
//#UC START# *0596AE5D4612_53ABFB2C005Aset_var*
//#UC END# *0596AE5D4612_53ABFB2C005Aset_var*
begin
//#UC START# *0596AE5D4612_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *0596AE5D4612_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetOnlyStructure

function TcsExportTaskPrim.pm_GetOutFileType: TepSupportFileType;
//#UC START# *26C313C1E1C2_53ABFB2C005Aget_var*
//#UC END# *26C313C1E1C2_53ABFB2C005Aget_var*
begin
//#UC START# *26C313C1E1C2_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *26C313C1E1C2_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetOutFileType

procedure TcsExportTaskPrim.pm_SetOutFileType(aValue: TepSupportFileType);
//#UC START# *26C313C1E1C2_53ABFB2C005Aset_var*
//#UC END# *26C313C1E1C2_53ABFB2C005Aset_var*
begin
//#UC START# *26C313C1E1C2_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *26C313C1E1C2_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetOutFileType

function TcsExportTaskPrim.pm_GetOutputFileSize: Integer;
//#UC START# *CCCE10C13631_53ABFB2C005Aget_var*
//#UC END# *CCCE10C13631_53ABFB2C005Aget_var*
begin
//#UC START# *CCCE10C13631_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *CCCE10C13631_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetOutputFileSize

procedure TcsExportTaskPrim.pm_SetOutputFileSize(aValue: Integer);
//#UC START# *CCCE10C13631_53ABFB2C005Aset_var*
//#UC END# *CCCE10C13631_53ABFB2C005Aset_var*
begin
//#UC START# *CCCE10C13631_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *CCCE10C13631_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetOutputFileSize

function TcsExportTaskPrim.pm_GetReferenceFileNameMask: AnsiString;
//#UC START# *EE32A5B4C551_53ABFB2C005Aget_var*
//#UC END# *EE32A5B4C551_53ABFB2C005Aget_var*
begin
//#UC START# *EE32A5B4C551_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *EE32A5B4C551_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetReferenceFileNameMask

procedure TcsExportTaskPrim.pm_SetReferenceFileNameMask(const aValue: AnsiString);
//#UC START# *EE32A5B4C551_53ABFB2C005Aset_var*
//#UC END# *EE32A5B4C551_53ABFB2C005Aset_var*
begin
//#UC START# *EE32A5B4C551_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *EE32A5B4C551_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetReferenceFileNameMask

function TcsExportTaskPrim.pm_GetSeparateFiles: TepDivideBy;
//#UC START# *D6FD74AB8316_53ABFB2C005Aget_var*
//#UC END# *D6FD74AB8316_53ABFB2C005Aget_var*
begin
//#UC START# *D6FD74AB8316_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6FD74AB8316_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetSeparateFiles

procedure TcsExportTaskPrim.pm_SetSeparateFiles(aValue: TepDivideBy);
//#UC START# *D6FD74AB8316_53ABFB2C005Aset_var*
//#UC END# *D6FD74AB8316_53ABFB2C005Aset_var*
begin
//#UC START# *D6FD74AB8316_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *D6FD74AB8316_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetSeparateFiles

function TcsExportTaskPrim.pm_GetToRegion: Cardinal;
//#UC START# *E89BF65EAF64_53ABFB2C005Aget_var*
//#UC END# *E89BF65EAF64_53ABFB2C005Aget_var*
begin
//#UC START# *E89BF65EAF64_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *E89BF65EAF64_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetToRegion

procedure TcsExportTaskPrim.pm_SetToRegion(aValue: Cardinal);
//#UC START# *E89BF65EAF64_53ABFB2C005Aset_var*
//#UC END# *E89BF65EAF64_53ABFB2C005Aset_var*
begin
//#UC START# *E89BF65EAF64_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *E89BF65EAF64_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetToRegion

function TcsExportTaskPrim.pm_GetExportReference: Boolean;
//#UC START# *4A455E657325_53ABFB2C005Aget_var*
//#UC END# *4A455E657325_53ABFB2C005Aget_var*
begin
//#UC START# *4A455E657325_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A455E657325_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportReference

procedure TcsExportTaskPrim.pm_SetExportReference(aValue: Boolean);
//#UC START# *4A455E657325_53ABFB2C005Aset_var*
//#UC END# *4A455E657325_53ABFB2C005Aset_var*
begin
//#UC START# *4A455E657325_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *4A455E657325_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportReference

function TcsExportTaskPrim.pm_GetExportEditions: Boolean;
//#UC START# *A324D874D765_53ABFB2C005Aget_var*
//#UC END# *A324D874D765_53ABFB2C005Aget_var*
begin
//#UC START# *A324D874D765_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *A324D874D765_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportEditions

procedure TcsExportTaskPrim.pm_SetExportEditions(aValue: Boolean);
//#UC START# *A324D874D765_53ABFB2C005Aset_var*
//#UC END# *A324D874D765_53ABFB2C005Aset_var*
begin
//#UC START# *A324D874D765_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *A324D874D765_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportEditions

function TcsExportTaskPrim.pm_GetFormulaAsPicture: Boolean;
//#UC START# *3536A8138409_53ABFB2C005Aget_var*
//#UC END# *3536A8138409_53ABFB2C005Aget_var*
begin
//#UC START# *3536A8138409_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *3536A8138409_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetFormulaAsPicture

procedure TcsExportTaskPrim.pm_SetFormulaAsPicture(aValue: Boolean);
//#UC START# *3536A8138409_53ABFB2C005Aset_var*
//#UC END# *3536A8138409_53ABFB2C005Aset_var*
begin
//#UC START# *3536A8138409_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *3536A8138409_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetFormulaAsPicture

function TcsExportTaskPrim.pm_GetExportReferences: Boolean;
//#UC START# *DB31ADFC7A08_53ABFB2C005Aget_var*
//#UC END# *DB31ADFC7A08_53ABFB2C005Aget_var*
begin
//#UC START# *DB31ADFC7A08_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB31ADFC7A08_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetExportReferences

procedure TcsExportTaskPrim.pm_SetExportReferences(aValue: Boolean);
//#UC START# *DB31ADFC7A08_53ABFB2C005Aset_var*
//#UC END# *DB31ADFC7A08_53ABFB2C005Aset_var*
begin
//#UC START# *DB31ADFC7A08_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *DB31ADFC7A08_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetExportReferences

function TcsExportTaskPrim.pm_GetSABStream: SABStreamHelper;
//#UC START# *D489CADC5DD7_53ABFB2C005Aget_var*
//#UC END# *D489CADC5DD7_53ABFB2C005Aget_var*
begin
//#UC START# *D489CADC5DD7_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *D489CADC5DD7_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetSABStream

function TcsExportTaskPrim.pm_GetAdditionalProcess: AnsiString;
//#UC START# *5C2BA219836B_53ABFB2C005Aget_var*
//#UC END# *5C2BA219836B_53ABFB2C005Aget_var*
begin
//#UC START# *5C2BA219836B_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C2BA219836B_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetAdditionalProcess

procedure TcsExportTaskPrim.pm_SetAdditionalProcess(const aValue: AnsiString);
//#UC START# *5C2BA219836B_53ABFB2C005Aset_var*
//#UC END# *5C2BA219836B_53ABFB2C005Aset_var*
begin
//#UC START# *5C2BA219836B_53ABFB2C005Aset_impl*
 !!! Needs to be implemented !!!
//#UC END# *5C2BA219836B_53ABFB2C005Aset_impl*
end;//TcsExportTaskPrim.pm_SetAdditionalProcess

function TcsExportTaskPrim.pm_GetRegionIDList: RegionIDListHelper;
//#UC START# *90DCF727B40F_53ABFB2C005Aget_var*
//#UC END# *90DCF727B40F_53ABFB2C005Aget_var*
begin
//#UC START# *90DCF727B40F_53ABFB2C005Aget_impl*
 !!! Needs to be implemented !!!
//#UC END# *90DCF727B40F_53ABFB2C005Aget_impl*
end;//TcsExportTaskPrim.pm_GetRegionIDList

class function TcsExportTaskPrim.GetTaggedDataType: Tk2Type;
//#UC START# *53AC03EE01FD_53ABFB2C005A_var*
//#UC END# *53AC03EE01FD_53ABFB2C005A_var*
begin
//#UC START# *53AC03EE01FD_53ABFB2C005A_impl*
 !!! Needs to be implemented !!!
//#UC END# *53AC03EE01FD_53ABFB2C005A_impl*
end;//TcsExportTaskPrim.GetTaggedDataType
{$IfEnd} // NOT Defined(Nemesis)

end.
