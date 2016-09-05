unit alcuHavanskyExportTask;

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

{
  AddNode('PikPress', 'Экспорт для Пик Пресс');
   // Дата последней обработки
   AddDateItem('ppLast', 'Дата последней обработки');
   AddFolderNameItem('ppFolder', 'Папка');
   AddDivider('Включать документы');
   AddItem(TalcuDictionaryTreeItem.Make('ppinSource', 'Исходящие органы', da_dlSources, True));
    Hint:= '';
   // Sources
   AddDivider('Исключать документы');
   AddItem(TalcuDictionaryTreeItem.Make('ppexSource', 'Исходящие органы', da_dlSources, True));
   AddItem(TalcuDictionaryTreeItem.Make('ppexType', 'Тип', da_dlTypes, True));
  CloseChild;
}
interface

{$If defined(HavanskyExport) AND defined(ServerTasks)}
uses
  alcuExport, ddProgressObj,
  csProcessTask,
  ExportPipe,

  ddProcessTaskPrim,
  alcuHavanskyExportTaskPrim
  ;
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}
type
 TalcuHavanskyExportTask = class(TalcuHavanskyExportTaskPrim)
 private
{$If defined(AppServerSide)}
  procedure ZipResults;
{$IfEnd defined(AppServerSide)}
 protected
  function GetClearAttributes: TexpClearAttributes; override;
  {$If defined(AppServerSide)}
  procedure DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices); override;
  {$IfEnd defined(AppServerSide)}
  function AllowSimultaneousRun: Boolean; override;
 public
  constructor Create; reintroduce;
  {$If defined(AppServerSide)}
  procedure SetupServerSideConfigParams; override;
  {$IfEnd defined(AppServerSide)}
 end;
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}

{$IfEnd} //HavanskyExport AND ServerTasks

implementation

{$If defined(HavanskyExport) AND defined(ServerTasks)}
uses
  daInterfaces,
  daTypes,
  daSchemeConsts,
  dt_Query, dt_SrchQueries,
  dt_AttrSchema,
  {$If defined(AppServerSide)}
  ddAppConfig,
  {$IfEnd defined(AppServerSide)}
  l3LongintList, l3Date, csExport, DT_Types, dtIntf, DT_Sab,
  SysUtils, DT_Const, l3FileUtils, alcuZipUtils,
{$If defined(AppServerSide)}
  alcuFTPUtils,
{$IfEnd defined(AppServerSide)}
  ddServerTask,
  csTaskTypes
  ;
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}

function TalcuHavanskyExportTask.AllowSimultaneousRun: Boolean;
begin
  Result := False;
end;

constructor TalcuHavanskyExportTask.Create;
begin
  inherited Create(usServerService);
end;

  {$If defined(AppServerSide)}
procedure TalcuHavanskyExportTask.DoRunSuccessfullyFinished(const aServices: IcsRunTaskServices);
begin
 inherited;
 ZipResults;
 ddAppConfiguration.AsDateTime['ppLast'] := Date;
 ddAppConfiguration.Save;
end;
  {$IfEnd defined(AppServerSide)}

function TalcuHavanskyExportTask.GetClearAttributes: TexpClearAttributes;
begin
  Result := attrLevel2;
end;

{$If defined(AppServerSide)}
  {$If defined(AppServerSide)}
procedure TalcuHavanskyExportTask.SetupServerSideConfigParams;
var
 l_SourceInclude, l_Dates, l_Dates1,
 l_SourceExclude, l_TypeExclude: TdtQuery;
 l_Sab: ISab;
 l_Diapason: TDiapasonRec;
begin
  inherited;
  DiapasonType := tdNumList;
  MultiUser := True;
  Family := CurrentFamily;
  ExportDirectory := ddAppConfiguration.AsString['ppFolder'];
  ForceDirectories(ExportDirectory);
  ExportAnnoTopics := False;
  ExportDocImage := False;
  ExportDocument := True;
  ExportReferences := False;
  ExportKW := False;
  OutFileType := outXML;
  SeparateFiles := divNone;
  l_SourceInclude:= TdtDictQuery.Create(da_dlSources, Tl3LongintList(ddAppConfiguration.AsObject['ppinSource']), False, True);
  try
   l_Dates1:= TdtDateNumQuery.Create(DMYtoStDate(1, 1, 2010), CurrentDate, '*', dnPublish);
   SQAndF(l_SourceInclude, l_Dates1);
   l_Dates:= SQNewDocsFromLog(DateTimeToStDate(ddAppConfiguration.AsDateTime['ppLast']), CurrentDate, 1);
   SQAndF(l_SourceInclude, l_Dates);
   l_SourceExclude:= TdtDictQuery.Create(da_dlSources, Tl3LongintList(ddAppConfiguration.AsObject['ppexSource']));
   SQAndNotF(l_SourceInclude, l_SourceExclude);
   l_TypeExclude:= TdtDictQuery.Create(da_dlTypes, Tl3LongintList(ddAppConfiguration.AsObject['ppexType']));
   SQAndNotF(l_SourceInclude, l_TypeExclude);
   if not l_SourceInclude.IsEmpty then
   begin
    l_Sab := l_SourceInclude.GetDocIdList;
    try
     dtOutSabToStream(l_SourceInclude.GetDocIdList, SABStream);
    finally
     l_Sab := nil;
    end;
   end;
  finally
   FreeAndNil(l_SourceInclude);
  end;
end;
  {$IfEnd defined(AppServerSide)}

procedure TalcuHavanskyExportTask.ZipResults;
var
 l_FileName: String;
 l_DateStr : String;
begin
 // export_01-10-2012
 DateTimeToString(l_DateStr, 'dd-mm-yyyy', Date);
 l_FileName:= ConcatDirName(ddAppConfiguration.AsString['ppFolder'], 'export_'+l_DateStr) + '.zip';
 ZipFiles(l_FileName, ddAppConfiguration.AsString['ppFolder'], '*.xml');
 DeleteFilesByMaskRecur(ddAppConfiguration.AsString['ppFolder'], '*.xml');
 PutFileToFTP(l_FileName, 'ppex');
end;
{$IfEnd defined(AppServerSide)}
{$IfEnd} //HavanskyExport AND ServerTasks

{$If defined(HavanskyExport) AND defined(ServerTasks)}
initialization
 RegisterTaskClass(cs_ttHavanskyExport, TalcuHavanskyExportTask, 'Экспорт для ПИК Пресс');
{$IfEnd} //HavanskyExport AND ServerTasks


end.
