unit alcuAutoAnnoExportTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(ServerTasks)}
uses
  csProcessTask,
  ddProcessTaskPrim,
  alcuAutoAnnoExportTaskPrim
  ;
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
type
 TalcuAutoAnnoExportTask = class(TalcuAutoAnnoExportTaskPrim)
 protected
  function RequireDelivery: Boolean; override;
  function AllowSimultaneousRun: Boolean; override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
 public
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;//TalcuAutoAnnoExportTask
{$IfEnd} //ServerTasks

implementation

{$If defined(ServerTasks)}
uses
 SysUtils,

 l3Base,
 l3Date,
 l3LongintList,

 daTypes,
 daSchemeConsts,
 
 dt_Types,
 dt_Const,
 dt_AttrSchema,
 dt_Doc,
 dt_Sab,
 dt_Query,
 dt_SrchQueries,

 {$If defined(AppServerSide)}
 ddAppConfig,
 {$IfEnd defined(AppServerSide)}
 ddServerTask,
 ddUtils,

 csTaskTypes
 ;
{$IfEnd} //ServerTasks


{$If defined(ServerTasks)}

{ TalcuAutoAnnoExportTask }

function TalcuAutoAnnoExportTask.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

{$If defined(AppServerSide)}
procedure TalcuAutoAnnoExportTask.DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices);
begin
 inherited;
 ddAppConfiguration.AsDateTime['aaStartDate']:= EndDate;
 ddAppConfiguration.Save;
end;
{$IfEnd defined(AppServerSide)}

function TalcuAutoAnnoExportTask.RequireDelivery: Boolean;
begin
  Result := False;
end;

{$If defined(AppServerSide)}
procedure TalcuAutoAnnoExportTask.SetupServerSideConfigParams;
var
  l_ResQuery: TdtAndQuery;
  l_Q       : TdtQuery;
  l_List: Tl3LongintList;
  l_Var : Boolean;
begin
 inherited;
 DiapasonType          := tdNumList;
 ExportEmptyKW         := False;
 ExportDocument        := False;
 ExportReferences      := False;
 ExportRTFBody         := False;
 ExportKW              := False;
 ExportDocImage        := False;
 MultiUser             := True;
 Family                := CurrentFamily;
 InternalFormat        := False;
 OutFileType           := outNSRC;
 SeparateFiles         := divNone;
 DocumentFileNameMask  := '';
 ReferenceFileNameMask := '';
 ObjTopicFileName      := '';
 KWFileName            := '';
 OutputFileSize        := 0;
 ExportAnnoTopics      := True;
 AnnoTopicFileName     := 'Archianno.nsr';
 StartDate             := ddAppConfiguration.AsDateTime['aaStartDate'];
 EndDate               := Now;
 ExportDirectory       := SafeValidFolder(ddAppConfiguration.AsString['aaFolder']);
 AdditionalProcess     := ddAppConfiguration.AsString['aaExecute'];
 BelongsIDList.FromList(Tl3LongintList(ddAppConfiguration.AsObject['annoBelongs']));


 l3System.Msg2Log('Формирование задания на экспорт аннотаций для дельты (с %s по %s)',
                  [DateToStr(StartDate), DateToStr(EndDate)]);
 l_ResQuery := TdtAndQuery.Create;
 try
  l_Q := SQLogByActionsQuery(StDateToDemon(DateTimeToStDate(StartDate)),
                             StDateToDemon(DateTimeToStDate(EndDate)),
                             [acAnnoDate, acAnnoWork, acAnnoWasImported]);
  l_ResQuery.AddQueryF(l_Q);
  l_List := Tl3LongintList.Create;
  try
   BelongsIDList.ToList(l_List);
   l_Q := TdtDictQuery.Create(da_dlBases, l_List, False, True {WithSubTree});
   l_ResQuery.AddQueryF(l_Q);

   l_Var:= True;
   l_Q:= TdtMainAttrQuery.Create(fHasAnno_fld, l_Var);
   l_ResQuery.AddQueryF(l_Q);

   // Выкидываем доки с меткой "зависших"
   l_Q := TdtStatusMaskQuery.Create(dstatHang);
   SQNot(l_Q);
   l_ResQuery.AddQueryF(l_Q);

   if not l_ResQuery.IsEmpty then
   begin
    dtOutSabToStream(l_ResQuery.GetDocIdList, SABStream);
    l3System.Msg2Log('Задание сформировано (%d Аннотаций)', [l_ResQuery.FoundList.Count]);
   end // not l_ResQuery.IsEmpty
   else
    l3System.Msg2Log('Подключенных аннотаций не найдено');
  finally
   FreeAndNil(l_List);
  end;
 finally
  l3Free(l_ResQuery);
 end;

end;
  {$IfEnd defined(AppServerSide)}
{$IfEnd} //ServerTasks

{$If defined(ServerTasks)}
initialization
 RegisterTaskClass(cs_ttAExportAnno, TalcuAutoAnnoExportTask, 'Экспорт аннотаций для дельты');
{$IfEnd} //ServerTasks

end.