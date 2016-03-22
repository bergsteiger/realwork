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
 l3String,
 csTaskTypes, csExport,
 daTypes, daSchemeConsts,
 dt_Const, dt_Query, l3Date, dt_AttrSchema, dt_Renum, dt_LinkServ, dt_SrchQueries,
 StrUtils, SysUtils, {$If defined(AppServerSide)} ddAppConfig, {$IfEnd defined(AppServerSide)} ddServerTask,
 l3Stream, l3FileUtils, l3Types, l3Base, l3Filer, l3DateSt,
 ddUtils, alcuMailServer, alcuExport;

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

  l_Q := TdtStatusMaskQuery.Create(dstatHang);
  SQNot(l_Q);
  l_AndQuery.AddQueryF(l_Q);

  {
  l_Q := TdtDocListQuery.Create;
  TdtDocListQuery(l_Q).AddID(16391988);
  TdtDocListQuery(l_Q).AddID(16391989);
  l_AndQuery.addQueryF(l_Q);
  {}
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
 l_HasErrors : Boolean;
 l_Msg       : AnsiString;

 function lRecAccessProc(aItemPtr : Pointer) : Boolean;
 begin
  Result := True;
  l_Msg := l_Msg + IntToStr(PLongint(aItemPtr)^) + #13#10;
 end;

begin
 if DocSab.Count > 0 then
 begin
  l_HasErrors := ErrorList.Count > 0;
  l_Msg := 'В дельту анонсированы следующие топики' + IfThen(l_HasErrors, ' (ошибки ниже):'#13#10, ':'#13#10);
  l_Sab:= MakeSabCopy(DocSab);
  l_Sab.TransferToPhoto(rnRealID_fld, LinkServer(CurrentFamily).Attribute[atRenum]);
  l_Sab.ValuesOfKey(rnImportID_fld);
  lRAProcStub := L2RecAccessProc(@lRecAccessProc);
  try
   l_Sab.IterateRecords(lRAProcStub);
  finally
   FreeRecAccessProc(lRAProcStub);
  end;
  if l_HasErrors then
   l_Msg := l_Msg + #13#10'ОШИБКИ:'#13#10 + l3StringListToStr(ErrorList);
  alcuMail.SendEmail(NotifyEMailList,
                     l_Msg,
                     Format('Анонсированные в дельту %s', [l3DateSt.l3DateToStr(AnoncedDate, 'dd mmmm yyyy г.')]) +
                       IfThen(l_HasErrors, ' (ОШИБКИ)'),
                     l_HasErrors);
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
