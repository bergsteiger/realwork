unit ddAutoLinker;

{ $Id: ddAutoLinker.pas,v 1.24 2016/10/13 13:17:20 lukyanets Exp $ }

// $Log: ddAutoLinker.pas,v $
// Revision 1.24  2016/10/13 13:17:20  lukyanets
// Готовимся переделывать автолинкер как задачу
//
// Revision 1.23  2016/07/26 09:26:00  fireton
// - переделка автолинкера
//
// Revision 1.22  2015/11/25 14:01:46  lukyanets
// Заготовки для выдачи номеров+переезд констант
//
// Revision 1.21  2015/04/07 07:37:06  lukyanets
// Изолируем HT
//
// Revision 1.20  2014/04/17 13:04:46  voba
// - перенес ISab из DT_Sab в dtIntf
//
// Revision 1.19  2014/04/17 08:37:40  fireton
// - отключаем запись в лог для "импортированного" документа
//
// Revision 1.18  2014/02/24 11:29:35  fireton
// - передаём атрибуты для выливки через property
//
// Revision 1.17  2014/02/14 15:33:53  lulin
// - избавляемся от ошибок молодости.
//
// Revision 1.16  2013/10/30 10:36:36  voba
// - отказ от fSrchList
//
// Revision 1.15  2013/03/22 04:37:49  fireton
// - не работала автопростановка на выборке
//
// Revision 1.14  2013/02/15 10:34:10  fireton
// - удалялись справки и названия документов при автопростановке ссылок
//
// Revision 1.13  2012/11/02 08:19:55  lulin
// - правим за Мишей.
//
// Revision 1.12  2012/11/01 09:43:24  lulin
// - забыл точку с запятой.
//
// Revision 1.11  2012/11/01 07:45:49  lulin
// - делаем возможность логирования процесса загрузки модулей.
//
// Revision 1.10  2012/10/31 18:38:03  kostitsin
// переименовал методы Notify на двух интерфейсах
//
// Revision 1.9  2012/10/26 08:37:29  narry
// Обновление
//
// Revision 1.8  2011/11/24 09:23:56  fireton
// - при простановке в выборке всегда используем внешние номера топиков
//
// Revision 1.7  2011/11/14 12:45:50  fireton
// - функция автопростановки ссылок с удалением старых, на выборке
//
// Revision 1.6  2010/09/24 12:10:35  voba
// - k : 235046326
//
// Revision 1.5  2010/09/23 11:30:53  fireton
// - все данные читаются из одного файла
// - не ставим ссылки на документы без источника, если их типа нет в списке
//
// Revision 1.4  2010/01/13 13:40:23  fireton
// - возможность не использовать списки кодексов и ФЗ
// - возможность фильтровать по источнику
//
// Revision 1.3  2009/12/24 14:49:34  fireton
// - Уточнённая простановка ссылок
//
// Revision 1.2  2009/12/04 09:01:10  fireton
// - исправление ошибок в линковке
//
// Revision 1.1  2009/12/02 08:31:37  fireton
// - автоматическая линковка документов
//

interface
uses
 l3Base,
 l3Types,
 l3Interfaces,

 DT_Types,
 DT_Const,
 DT_IFltr,
 dtIntf, DT_Sab,

 m3DBInterfaces,
 m3DB,

 k2TagGen,

 evdHyperlinkEliminator,

 SewerPipe,
 ddImportPipeKernel,
 ddAutoLinkFilter,
 ddProgressObj;

type
 TddAutoLinker = class(Tl3Base, Il3ItemNotifyRecipient)
 private
  f_OutPipe: TSewerPipe;
  f_InPipe : TddImportPipeFilter;
  f_LastClearLinks: Boolean;
  f_LinkFilter: TddAutoLinkFilter;
  f_HyperlinkEliminator: TevdHyperlinkEliminator;
  procedure KillPipe;
  procedure MakePipe(aClearLinks: Boolean);
 protected
  procedure Cleanup; override;
  procedure Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
 public
  constructor Create;
  procedure SetLinks(aDocList: ISab; aProgressor: TddProgressObject = nil; aClearLinks: Boolean = False);
  procedure AbortProcess;
  // aClearLinks - удалять ли все ссылки перед авторасстановкой
 end;

function GetAutoLinker: TddAutoLinker;

implementation
uses
 daInterfaces,
 daSchemeConsts,
 
 dt_AttrSchema,
 DT_Serv,
 Dt_Fam,
 DT_TblCacheDef,

 evdWriter,
 evEvdRd,

 k2Reader, evdLeafParaFilter,
 ddGeneralLawsLinkFinder;

const
 g_AutoLinker: TddAutoLinker = nil;

function GetAutoLinker: TddAutoLinker;
begin
 if g_AutoLinker = nil then
  g_AutoLinker := TddAutoLinker.Create;
 Result := g_AutoLinker;
end;


constructor TddAutoLinker.Create;
begin
 inherited Create;
 Il3ChangeNotifier(GlobalHtServer).Subscribe(Il3ItemNotifyRecipient(Self));
end;

procedure TddAutoLinker.Cleanup;
begin
 KillPipe;
 inherited;
end;

procedure TddAutoLinker.KillPipe;
begin
 l3Free(f_InPipe);
 l3Free(f_OutPipe);
 l3Free(f_LinkFilter);
 l3Free(f_HyperlinkEliminator);
end;

procedure TddAutoLinker.MakePipe(aClearLinks: Boolean);
begin
 f_OutPipe := TSewerPipe.Create;
 f_InPipe  := TddImportPipeFilter.Create(CurrentFamily);
 f_LinkFilter := TddAutoLinkFilter.Create(nil);
 f_LinkFilter.AddLinkFinder(ddGetGeneralLawsLinkFinderDef);

 if aClearLinks then
 begin
  f_HyperlinkEliminator := TevdHyperlinkEliminator.Create;
  f_OutPipe.Writer := f_HyperlinkEliminator;
  f_HyperlinkEliminator.Generator := f_LinkFilter;
 end
 else
  f_OutPipe.Writer := f_LinkFilter;

 f_LinkFilter.Generator := f_InPipe;

 //f_OutPipe.Writer := f_InPipe; debug code
 f_InPipe.UpdateTables:= False;
 f_InPipe.CheckDocuments:= False;
 f_InPipe.NeedLockBase:= False;
 f_InPipe.DocumentReaction:= sdrDelete;
 f_InPipe.DeleteConditions := [dcAny];
 f_InPipe.InternalFormat:= False;
 f_InPipe.UserID:= usServerService;
 f_InPipe.ImportFilter.ExcludeAttr := CctAllAttributes - [ctHLink];
 f_InPipe.ImportFilter.AddNewToLog := False;
 f_InPipe.ImportFilter.ExcludeMainRec := True;

 f_OutPipe.ExportDocument:= True;
 f_OutPipe.ExportReferences:= False;
 f_OutPipe.ExportAnnotation:= False;
end;

procedure TddAutoLinker.Notify(const aNotifier: Il3ChangeNotifier; aOperation: Integer; aIndex: Integer);
begin
 if aOperation = sni_Destroy then
  KillPipe;
end;

procedure TddAutoLinker.SetLinks(aDocList: ISab; aProgressor: TddProgressObject = nil; aClearLinks: Boolean = False);
var
 l_DR: TDiapasonRec;
begin
 if f_LastClearLinks <> aClearLinks then
  KillPipe;
 f_LastClearLinks := aClearLinks; 
 if f_OutPipe = nil then
  MakePipe(aClearLinks);
 f_LinkFilter.UseInternalNumForLink(False);
 f_OutPipe.DocSab:= aDocList;
 f_OutPipe.Progressor := aProgressor;
 f_OutPipe.Attributes := [atDateNums, atHLink, atSub];
 f_OutPipe.Execute;
end;

procedure TddAutoLinker.AbortProcess;
begin
 if Assigned(f_OutPipe) then
  f_OutPipe.Aborted := True;
end;

initialization
{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutoLinker.pas initialization enter'); {$EndIf}

{!touched!}{$IfDef LogInit} WriteLn('W:\common\components\rtl\Garant\dd\ddAutoLinker.pas initialization leave'); {$EndIf}
finalization
 l3Free(g_AutoLinker);
end.
