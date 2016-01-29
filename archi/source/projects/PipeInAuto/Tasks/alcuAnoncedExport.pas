unit alcuAnoncedExport;

interface

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

uses
  alcuAnoncedExportPrim, ddProgressObj, dtIntf, dt_Sab, l3LongintList, ddProcessTaskPrim,
  dt_Types;

type
 TalcuAnoncedExport = class(TalcuAnoncedExportPrim)
 private
  {$If defined(AppServerSide)}
  function MakeAnoncedSab: ISab;
  {$IfEnd defined(AppServerSide)}
  procedure WriteDoneFile;
  procedure MakeDocFile;
 protected
  function RequireDelivery: Boolean; override;
  procedure DoRun(const aContext: TddRunContext); override;
  function GetFinalExportDirectory: AnsiString; override;
  function AllowSimultaneousRun: Boolean; override;
  function GetDescription: AnsiString; override;
 public
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;

implementation

uses
 csTaskTypes, csExport,
 daTypes,
 dt_Const, dt_Query, l3Date, dt_AttrSchema, dt_Renum, dt_LinkServ,
 SysUtils, {$If defined(AppServerSide)} ddAppConfig, {$IfEnd defined(AppServerSide)} ddServerTask,
 l3Stream, l3FileUtils, l3Types, l3Base, l3Filer, l3DateSt,
 ddUtils, alcuMailServer;

function TalcuAnoncedExport.GetFinalExportDirectory: AnsiString;
begin
 Result := ExportDirectory;
end;

{$If defined(AppServerSide)}
function TalcuAnoncedExport.MakeAnoncedSab: ISab;
var
 l_AndQuery : TdtAndQuery;
 l_NotQuery : TdtNOTQuery;
 l_LogQuery : TdtQuery;
 l_Q: TdtQuery;
 l_Start, l_Finish: TstDate;
 l_List: Tl3LongintList;
begin
 Result:= nil;
 l_AndQuery := TdtAndQuery.Create;
 try
  // Нужно уточнить даты

  //AnoncedDate := DMYToStDate(10, 7, 2015); /// *** ОТЛАДОЧНЫЙ КОД!!!!

  l_LogQuery := TdtLogByActionQuery.Create(acAnonced, AnoncedDate, AnoncedDate);
  try
   l_AndQuery.AddQuery(l_LogQuery);
  finally
   FreeAndNil(l_LogQuery);
  end;

  l_NotQuery := TdtNOTQuery.Create;
  try
   l_LogQuery := TdtLogByActionQuery.Create(acIncluded, 0, 0);
   try
    l_NotQuery.SubQuery := l_LogQuery;
   finally
    FreeAndNil(l_LogQuery);
   end;
   l_AndQuery.AddQuery(l_NotQuery);
  finally
   FreeAndNil(l_NotQuery);
  end;

  // фильтруем по группам доступа
  l_List := Tl3LongintList.Make;
  try
    AccGroupsIDList.ToList(l_List);

    l_Q := TdtDictQuery.Create(da_dlAccGroups, l_List);
  finally
    FreeAndNil(l_List);
  end;
  l_AndQuery.addQueryF(l_Q);
  {
  l_Q := TdtDocListQuery.Create;
  TdtDocListQuery(l_Q).AddID(16391988);
  TdtDocListQuery(l_Q).AddID(16391989);
  l_AndQuery.addQueryF(l_Q);
  }
  Result := l_AndQuery.GetDocIdList;
  l3System.Msg2Log('Найдено %d анонсированных в дельту %s', [Result.Count, l3DateSt.l3DateToStr(AnoncedDate, 'dd mmm yyyy г')]);
 finally
  FreeAndNil(l_AndQuery);
 end;
end;
{$IfEnd defined(AppServerSide)}

procedure TalcuAnoncedExport.MakeDocFile;
 var
  l_Sab       : ISab;
  lRAProcStub : TdtRecAccessProc;
  l_Filer     : Tl3DOSFiler;
  l_FileName  : String;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  l_Filer.WriteLn(IntToStr(PLongint(aItemPtr)^));
 end;

begin
 if DocSab.Count > 0 then
 begin
  l_Sab:= MakeSabCopy(DocSab);
  l_Sab.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Attribute[atRenum]);
  l_Sab.ValuesOfKey(rnImportID_fld);
  l_FileName:= GetAppFolderFileName('anonnced.txt', False);
  l_Filer:= Tl3DOSFiler.Make(l_FileName, l3_fmWrite);
  try
   l_Filer.Open;
   lRAProcStub := L2RecAccessProc(@lRecAccessProc);
   try
    l_Sab.IterateRecords(lRAProcStub);
   finally
    FreeRecAccessProc(lRAProcStub);
   end;
  finally
   FreeAndNil(l_Filer);
  end;
  alcuMail.SendEmail(NotifyEMailList,
                     'Во вложении перечислены документы, анонсированные в указанную дельту',
                     Format('Анонсированные в дельту %s', [l3DateSt.l3DateToStr(AnoncedDate, 'dd mmm yyyy г')]), l_FileName)
 end;
end;

procedure TalcuAnoncedExport.WriteDoneFile;
begin
 with Tl3FileStream.Create(ConcatDirname(ExportDirectory, 'done.txt'), l3_fmWrite) do
 try
 finally
  Free;
 end;
end;

procedure TalcuAnoncedExport.DoRun(const aContext: TddRunContext);
begin
 inherited DoRun(aContext);
 MakeDir(ExportDirectory);
 MakeDocFile;
 WriteDoneFile;
end;

{$If defined(AppServerSide)}
procedure TalcuAnoncedExport.SetupServerSideConfigParams;
var
 l_Sab: ISab;
begin
 inherited;
 if OnThursdayMode then
 begin
   SeparateFiles := divNone;
   DocumentFileNameMask:= ddAppConfiguration.AsString['anonThuFileName'];
   AccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['anonAccGroupsEx']));
 end
 else
 begin
   SeparateFiles := divTopic;
   DocumentFileNameMask:= '';
   AccGroupsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['anonAccGroups']));
 end;
 NotifyEMailList := ddAppConfiguration.AsString['anonEmail'];
 ExportDocument:= True;
 ExportReferences:= True;
 ExportAnnoTopics:= False;
 OutFileType:= outNSRC;
 ExportDirectory := ddAppConfiguration.AsString['anonFolder'];
 DiapasonType := tdNumList;
 DocSab := MakeAnoncedSab;
 l_Sab := MakeSabCopy(DocSab);
 dtCopyValuesSabToList(l_Sab, SabStream);
end;
{$IfEnd defined(AppServerSide)}

function TalcuAnoncedExport.RequireDelivery: Boolean;
begin
  Result := False;
end;

function TalcuAnoncedExport.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

function TalcuAnoncedExport.GetDescription: AnsiString;
begin
 Result := 'Экспорт анонсированных';
end;

initialization
 RegisterTaskClass(cs_ttAnoncedExport, TalcuAnoncedExport, 'Экспорт анонсированных');

end.
