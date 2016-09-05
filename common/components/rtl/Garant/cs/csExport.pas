unit csExport;

interface

{$Include CsDefine.inc}

uses
 Classes,
 daTypes,
 dtIntf,
 CsDataPipe, csProcessTask, CsTaskTypes, dt_Sab,

 k2Base,

 csExportTaskPrim
 ;

type
  TcsExport = class(TcsExportTaskPrim)
  private
    //f_AdditionalProcess: AnsiString;
    //f_AnnoTopicFileName: AnsiString;
    //f_DiapasonType: TDiapType;
    //f_DocID: TDocID;
    f_DocSab: ISab;
    //f_DocumentFileNameMask: AnsiString;
(*    f_ExportAnnoTopics: Boolean;
    f_ExportDirectory: AnsiString;
    f_ExportDocImage: Boolean;
    f_ExportDocument: Boolean;
    f_ExportEditions: Boolean;
    f_ExportEmptyKW: Boolean;
    f_ExportKW: Boolean;
    f_ExportReferences: Boolean;
    f_ExportRTFBody: Boolean;
    f_Family: Integer;
    f_FormulaAsPicture: Boolean;
    f_InternalFormat: Boolean;
    f_KWFileName: AnsiString;
    f_MultiUser: Boolean;
    f_ObjTopicFileName: AnsiString;
    f_OnlyStructure: Boolean;
    f_OutFileType: LongInt;
    f_OutputFileSize: LongInt;
    f_ReferenceFileNameMask: AnsiString;*)
    //f_SABStream: TStream;
//    f_SeparateFiles: LongInt;
    //f_ServerSide: Boolean;
    //f_StartNumber: Integer;
//    f_ToRegion: TDictID;
    procedure pm_SetDocSab(Value: ISab);
(*    procedure pm_SetExportDirectory(const Value: AnsiString);*)
  protected
    function RequireDelivery: Boolean; override;
    procedure Cleanup; override;
    function GetDescription: AnsiString; override;
    procedure DoLoadFrom(aStream: TStream; aIsPipe: Boolean); override;
    function pm_GetTaskFolder: AnsiString; override;
  public
    constructor Create(aUserID: TdaUserID); override;
  {$If defined(AppServerSide)}
    procedure RunEnded(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
    procedure MakeSab;
    procedure DoSaveTo(aStream: TStream; aIsPipe: Boolean); override;
(*    procedure WriteResult(aStream: TStream); overload; override;*)
    procedure DoWriteResult(aPipe: TcsDataPipe); {overload; }override;
    function DefaultDescription: AnsiString;
(*    property AdditionalProcess: AnsiString
     read f_AdditionalProcess
     write f_AdditionalProcess;*)
(*    property AnnoTopicFileName: AnsiString read f_AnnoTopicFileName write
            f_AnnoTopicFileName;*)
(*    property DiapasonType: TDiapType read f_DiapasonType write f_DiapasonType;*)
//    property DocID: TDocID read f_DocID write f_DocID;
    property DocSab: ISab read f_DocSab write pm_SetDocSab;
(*    property DocumentFileNameMask: AnsiString read f_DocumentFileNameMask write
            f_DocumentFileNameMask;
    property ExportAnnoTopics: Boolean read f_ExportAnnoTopics write
            f_ExportAnnoTopics;
    property ExportDirectory: AnsiString read f_ExportDirectory write
        pm_SetExportDirectory;
    property ExportDocImage: Boolean read f_ExportDocImage write
            f_ExportDocImage;
    property ExportDocument: Boolean read f_ExportDocument write
            f_ExportDocument;
    property ExportEditions: Boolean read f_ExportEditions write f_ExportEditions;
    property ExportEmptyKW: Boolean read f_ExportEmptyKW write f_ExportEmptyKW;
    property ExportKW: Boolean read f_ExportKW write f_ExportKW;
    property ExportReferences: Boolean read f_ExportReferences write f_ExportReferences;
    property ExportRTFBody: Boolean read f_ExportRTFBody write f_ExportRTFBody;
    property Family: Integer read f_Family write f_Family;
    property FormulaAsPicture: Boolean read f_FormulaAsPicture write
        f_FormulaAsPicture;
    property InternalFormat: Boolean read f_InternalFormat write
            f_InternalFormat;
    property KWFileName: AnsiString read f_KWFileName write f_KWFileName;
    property MultiUser: Boolean read f_MultiUser write f_MultiUser;
    property ObjTopicFileName: AnsiString read f_ObjTopicFileName write
            f_ObjTopicFileName;
    property OnlyStructure: Boolean read f_OnlyStructure write f_OnlyStructure;
    property OutFileType: LongInt read f_OutFileType write f_OutFileType;
    property OutputFileSize: LongInt read f_OutputFileSize write
            f_OutputFileSize;
    property ReferenceFileNameMask: AnsiString read f_ReferenceFileNameMask write
            f_ReferenceFileNameMask;*)
//    property SABStream: TStream read f_SABStream{ write f_SABStream};
(*    property SeparateFiles: LongInt read f_SeparateFiles write f_SeparateFiles;
    //property ServerSide: Boolean read f_ServerSide write f_ServerSide;*)
//    property StartNumber: Integer read f_StartNumber write f_StartNumber;
(*    property ToRegion: TDictID read f_ToRegion write f_ToRegion;*)
  end;//TcsExport

implementation

uses
 l3TempMemoryStream,
 daSchemeConsts,
 SysUtils, ddUtils, L3FileUtils, dt_Types, DT_DictConst, dt_Doc, DT_Const, daInterfaces,

 k2Tags,

 Task_Const,
 ExportTask_Const
 ;

{
****************************** TcsExport *******************************
}

constructor TcsExport.Create(aUserID: TdaUserID);
begin
  inherited;
  //TaskType := cs_ttExport;
  VersionW := 4;
//  f_SABStream := Tl3TempMemoryStream.Create;
  //ServerSide:= False;
  ToRegion:= cUndefDictID;
  FormulaAsPicture:= False;
end;

procedure TcsExport.Cleanup;
begin
 f_DocSab:= nil;
// FreeAndNil(f_SABStream);
 inherited;
end;

function TcsExport.GetDescription: AnsiString;
var
  l_SR: TSearchRec;
  l_Mask, l_Descript: AnsiString;
  l_Total, l_Count: Int64;
begin
 Result := 'Экспорт ';
 if TepDivideBy(SeparateFiles) = divTopic then
  Result:= Result + 'по документам, '
 else
 begin
  if DocumentFileNameMask <> '' then
   Result := Result + SysUtils.Format('%s, ', [DocumentFileNameMask]);
  if TepDivideBy(SeparateFiles) = divSize then
   Result := Result + SysUtils.Format('размер части: %s, ', [Bytes2Str(OutputFileSize)]);
 end;
 Result := Result + SysUtils.Format('папка: %s, формат: %s',
                                     [ExportDirectory,
                                     SupportFileTypeNames[TepSupportFileType(OutFileType)]]);
 if ExportDocImage then
  Result := Result + ', с графическими образами';                                    
end;

procedure TcsExport.DoLoadFrom(aStream: TStream; aIsPipe: Boolean);
var
 l_Value : Integer;
begin
  inherited;
  //with aStream do
  begin
   AnnoTopicFileName := ReadString(aStream);
   DiapasonType := TDiapType(ReadInteger(aStream));
   DocID := ReadInteger(aStream);
   DocumentFileNameMask := ReadString(aStream);
   ExportAnnoTopics := ReadBoolean(aStream);
   ExportDirectory := ReadString(aStream);
   ExportDocImage := ReadBoolean(aStream);
   ExportDocument := ReadBoolean(aStream);
   ExportEmptyKW := ReadBoolean(aStream);
   ExportKW := ReadBoolean(aStream);
   ExportRTFBody := ReadBoolean(aStream);
   Family := ReadInteger(aStream);
   InternalFormat := ReadBoolean(aStream);
   KWFileName := ReadString(aStream);
   MultiUser := ReadBoolean(aStream);
   l_Value := ReadInteger(aStream);
   if l_Value > 0 then
   begin
    //f_SABStream.Seek(0, 0);
    {l_Value := }SABStream.CopyFrom(aStream, l_Value);
    //f_SABStream.Seek(0, 0);
   end;
   if not aIsPipe then // Нельзя использовать HyTech в другой нити :(
   begin
    (*TODO: extracted code
    f_DocSab:= MakeValueSet(DocumentServer(CurrentFamily).FileTbl, fID_Fld, SABStream);
    f_DocSab.Sort;
    *)
    //MakeSab;
   end; // not aIsPipe
   ObjTopicFileName := ReadString(aStream);
   OnlyStructure := ReadBoolean(aStream);
   OutFileType := TepSupportFileType(ReadInteger(aStream));
   OutputFileSize := ReadInteger(aStream);
   ReferenceFileNameMask := ReadString(aStream);
   SeparateFiles := TepDivideBy(ReadInteger(aStream));
   ToRegion := ReadCardinal(aStream);
   ExportReferences := ExportDocument;
   ExportEditions := False;
   FormulaAsPicture:= False;
   if Version > 1 then
    ExportReferences := ReadBoolean(aStream);
   if Version > 2 then
    ExportEditions := ReadBoolean(aStream);
   if Version > 3 then
    FormulaAsPicture := ReadBoolean(aStream);
  end; // with aStream
end;

procedure TcsExport.MakeSab;
begin
 f_DocSab:= MakeValueSet(DocumentServer(CurrentFamily).FileTbl, fID_Fld, SABStream);
 f_DocSab.Sort;
end;

procedure TcsExport.pm_SetDocSab(Value: ISab);
begin
 f_DocSab := Value;
end;

function TcsExport.pm_GetTaskFolder: AnsiString;
begin
 Result := ConcatDirName(TaggedData.StrA[k2_attrTaskFolder], 'Export\' + TaskID);
end;

procedure TcsExport.DoSaveTo(aStream: TStream; aIsPipe: Boolean);
var
 l_Value : Integer;
begin
  inherited;
  WriteString(aStream, AnnoTopicFileName);
  WriteInteger(aStream, Ord(DiapasonType));
  WriteInteger(aStream, DocID);
  WriteString(aStream, DocumentFileNameMask);
  WriteBoolean(aStream, ExportAnnoTopics);
  WriteString(aStream, ExportDirectory);
  WriteBoolean(aStream, ExportDocImage);
  WriteBoolean(aStream, ExportDocument);
  WriteBoolean(aStream, ExportEmptyKW);
  WriteBoolean(aStream, ExportKW);
  WriteBoolean(aStream, ExportRTFBody);
  writeInteger(aStream, Family);
  WriteBoolean(aStream, InternalFormat);
  WriteString(aStream, KWFileName);
  WriteBoolean(aStream, MultiUser);

  //if not aIsPipe and (DocSab <> nil) and not DocSab.IsEmpty then
  // dtOutSabToStream(DocSab, SABStream);

  (* %<---Потом нужно удалить--->% *)
  l_Value := SABStream.Size;
  WriteInteger(aStream, l_Value);
  //f_SABStream.Seek(0, 0);
  SABStream.CopyTo(aStream, l_Value);
  //aStream.CopyFrom(f_SABStream, l_Value);
  //f_SABStream.Seek(0, 0);
  (*=======================*)
  WriteString(aStream, ObjTopicFileName);
  WriteBoolean(aStream, OnlyStructure);
  WriteInteger(aStream, Ord(OutFileType));
  WriteInteger(aStream, OutputFileSize);
  WriteString(aStream, ReferenceFileNameMask);
  WriteInteger(aStream, Ord(SeparateFiles));
  WriteCardinal(aStream, ToRegion);
  if Version > 1 then
   WriteBoolean(aStream, ExportReferences);
  if Version > 2 then
  begin
   WriteBoolean(aStream, ExportEditions);
  end;
  if Version > 3 then
  begin
   WriteBoolean(aStream, FormulaAsPicture);
  end;
end;

procedure TcsExport.DoWriteResult(aPipe: TcsDataPipe);
begin
 aPipe.WriteFolder(TaskFolder);
 //PureDir(TaskFolder);
 //RemoveDir(TaskFolder);
end;

function TcsExport.RequireDelivery: Boolean;
begin
  Result := User <> usServerService;
end;

  {$If defined(AppServerSide)}
procedure TcsExport.RunEnded(const aServices: IcsRunTaskServices);
begin
 f_DocSab := nil;
 inherited;
end;
  {$IfEnd defined(AppServerSide)}

function TcsExport.DefaultDescription: AnsiString;
begin
 Result := GetDescription;
end;

end.
