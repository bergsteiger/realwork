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
    f_DocSab: ISab;
    procedure pm_SetDocSab(Value: ISab);
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
    procedure DoWriteResult(aPipe: TcsDataPipe); {overload; }override;
    function DefaultDescription: AnsiString;
    function DeliverySourceFolder: AnsiString; override;
    function DeliveryTargetFolder: AnsiString; override;
    property DocSab: ISab read f_DocSab write pm_SetDocSab;
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
  VersionW := 4;
  ToRegion:= cUndefDictID;
  FormulaAsPicture:= False;
end;

procedure TcsExport.Cleanup;
begin
 f_DocSab:= nil;
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

function TcsExport.DeliverySourceFolder: AnsiString;
begin
 Result := TaskFolder;
end;

function TcsExport.DeliveryTargetFolder: AnsiString;
begin
 Result := ExportDirectory;
end;

end.
