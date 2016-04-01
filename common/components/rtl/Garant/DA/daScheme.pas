unit daScheme;

// Модуль: "w:\common\components\rtl\Garant\DA\daScheme.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TdaScheme" MUID: (552D07EB03CB)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , daTableDescription
;

const
 da_TreeTableKinds = [da_ftSources, da_ftTypes, da_ftClasses, da_ftKeywords, da_ftBelongs, da_ftWarnings, da_ftCoSources, da_ftPrefixes, da_ftTerritories, da_ftNorms, da_ftAccessGroups, da_ftAnnoClasses, da_ftServiceInfo];
 cStoredProcCount = 4;

type
 TFamilyDescriptions = array [TdaTables] of IdaTableDescription;

 TdaFillTableDescriptionProc = procedure(aTable: TdaTableDescription) of object;

 TdaScheme = class(Tl3ProtoObject)
  private
   f_Tables: TFamilyDescriptions;
  private
   procedure BuildMain;
   procedure BuildFamily;
   function MakeTableDescription(aKind: TdaTables;
    const aSQLName: AnsiString;
    const aDescription: AnsiString;
    aProc: TdaFillTableDescriptionProc;
    const aScheme: AnsiString = '';
    aDublicate: Boolean = False;
    aFake: Boolean = False): IdaTableDescription;
   procedure FillMainAccess(aTable: TdaTableDescription);
   procedure FillMainPassword(aTable: TdaTableDescription);
   procedure FillMainUsers(aTable: TdaTableDescription);
   procedure FillMainGroups(aTable: TdaTableDescription);
   procedure FillMainGroupMembers(aTable: TdaTableDescription);
   procedure FillMainFamily(aTable: TdaTableDescription);
   procedure FillMainFree(aTable: TdaTableDescription);
   procedure FillMainJournal(aTable: TdaTableDescription);
   procedure FillControl(aTable: TdaTableDescription);
   procedure FillMainRegions(aTable: TdaTableDescription);
   procedure FillFamilyDocuments(aTable: TdaTableDescription);
   procedure FillFamilyHyperlinks(aTable: TdaTableDescription);
   procedure FillFamilySubs(aTable: TdaTableDescription);
   procedure FillFamilyFree(aTable: TdaTableDescription);
   procedure FillFamilySources(aTable: TdaTableDescription);
   procedure FillFamilyTypes(aTable: TdaTableDescription);
   procedure FillFamilyClasses(aTable: TdaTableDescription);
   procedure FillFamilyKeywords(aTable: TdaTableDescription);
   procedure FillFamilyBelongs(aTable: TdaTableDescription);
   procedure FillFamilyDateCodes(aTable: TdaTableDescription);
   procedure FillFamilyWarnings(aTable: TdaTableDescription);
   procedure FillFamilyCorrections(aTable: TdaTableDescription);
   procedure FillFamilyCoSources(aTable: TdaTableDescription);
   procedure FillFamilyPublishedIn(aTable: TdaTableDescription);
   procedure FillFamilyPrefixes(aTable: TdaTableDescription);
   procedure FillFamilyTerritories(aTable: TdaTableDescription);
   procedure FillFamilyNorms(aTable: TdaTableDescription);
   procedure FillFamilyExtClasses(aTable: TdaTableDescription);
   procedure FillFamilyAccessGroups(aTable: TdaTableDescription);
   procedure FillFamilyAnnoClasses(aTable: TdaTableDescription);
   procedure FillFamilyServiceInfo(aTable: TdaTableDescription);
   procedure FillFamilyDocSources(aTable: TdaTableDescription);
   procedure FillFamilyDocTypes(aTable: TdaTableDescription);
   procedure FillFamilyDocClasses(aTable: TdaTableDescription);
   procedure FillFamilyDocKeywords(aTable: TdaTableDescription);
   procedure FillFamilyDocBelongs(aTable: TdaTableDescription);
   procedure FillFamilyDocDateCodes(aTable: TdaTableDescription);
   procedure FillFamilyDocWarnings(aTable: TdaTableDescription);
   procedure FillFamilyDocCorrections(aTable: TdaTableDescription);
   procedure FillFamilyDocPublishedIn(aTable: TdaTableDescription);
   procedure FillFamilyDocPrefixes(aTable: TdaTableDescription);
   procedure FillFamilyDocTerritories(aTable: TdaTableDescription);
   procedure FillFamilyDocNorms(aTable: TdaTableDescription);
   procedure FillFamilyDocAccessGroups(aTable: TdaTableDescription);
   procedure FillFamilyDocAnnoClasses(aTable: TdaTableDescription);
   procedure FillFamilyDocServiceInfo(aTable: TdaTableDescription);
   procedure FillFamilyDoc2DocLink(aTable: TdaTableDescription);
   procedure FillFamilyPriority(aTable: TdaTableDescription);
   procedure FillFamilyRenum(aTable: TdaTableDescription);
   procedure FillFamilyDocStages(aTable: TdaTableDescription);
   procedure FillFamilyDocLog(aTable: TdaTableDescription);
   procedure FillFamilyDocActivity(aTable: TdaTableDescription);
   procedure FillFamilyDocAlarm(aTable: TdaTableDescription);
   procedure FillFamilyAutolinkDoc(aTable: TdaTableDescription);
   procedure FillFamilyAutolinkEdition(aTable: TdaTableDescription);
  protected
   procedure Cleanup; override;
    {* Функция очистки полей объекта. }
  public
   procedure BuildScheme;
   function CheckScheme(const aSchemeName: AnsiString): AnsiString;
   function Table(aTableKind: TdaTables): IdaTableDescription;
   function StoredProcName(anIndex: Integer): AnsiString;
   function StoredProcsCount: Integer;
   class function Instance: TdaScheme;
    {* Метод получения экземпляра синглетона TdaScheme }
   class function Exists: Boolean;
    {* Проверяет создан экземпляр синглетона или нет }
 end;//TdaScheme

implementation

uses
 l3ImplUses
 , SysUtils
 , daFieldDescription
 , l3Base
;

var g_TdaScheme: TdaScheme = nil;
 {* Экземпляр синглетона TdaScheme }

procedure TdaSchemeFree;
 {* Метод освобождения экземпляра синглетона TdaScheme }
begin
 l3Free(g_TdaScheme);
end;//TdaSchemeFree

procedure TdaScheme.BuildScheme;
//#UC START# *552D0A31006D_552D07EB03CB_var*
var
 l_Idx : TdaTables;
//#UC END# *552D0A31006D_552D07EB03CB_var*
begin
//#UC START# *552D0A31006D_552D07EB03CB_impl*
 BuildMain;
 BuildFamily;
 for l_Idx := Low(f_Tables) to High(f_Tables) do
  Assert(Assigned(f_Tables[l_Idx]));
//#UC END# *552D0A31006D_552D07EB03CB_impl*
end;//TdaScheme.BuildScheme

procedure TdaScheme.BuildMain;
//#UC START# *55364525020F_552D07EB03CB_var*
//#UC END# *55364525020F_552D07EB03CB_var*
begin
//#UC START# *55364525020F_552D07EB03CB_impl*
 f_Tables[da_mtAccess] := MakeTableDescription(da_mtAccess, 'access_rights', 'Права доступа к документам', FillMainAccess);
 f_Tables[da_mtPassword] := MakeTableDescription(da_mtPassword, 'user_passwords', 'Пароли пользователей', FillMainPassword);
 f_Tables[da_mtUsers] := MakeTableDescription(da_mtUsers, 'users', 'Пользователи', FillMainUsers);
 f_Tables[da_mtGroups] := MakeTableDescription(da_mtGroups, 'user_groups', 'Группы (mtGUDt)', FillMainGroups);
 f_Tables[da_mtGroupMembers] := MakeTableDescription(da_mtGroupMembers, 'group_members', 'Члены группы (mtGULnk)', FillMainGroupMembers);
 f_Tables[da_mtFamily] := MakeTableDescription(da_mtFamily, 'mfamily', 'Семейства (не прижилось)', FillMainFamily);
 f_Tables[da_mtFree] := MakeTableDescription(da_mtFree, 'mfree', 'Список диапазонов для ID', FillMainFree);
 f_Tables[da_mtJournal] := MakeTableDescription(da_mtJournal, 'system_log', 'Журнал работы (mtBBLog)', FillMainJournal);
 f_Tables[da_mtControl] := MakeTableDescription(da_mtControl, 'mctrl', 'Флажок эксклюзивного доступа (mtCtrl)', FillControl);
 f_Tables[da_mtRegions] := MakeTableDescription(da_mtRegions, 'regions', 'Словарь регионов', FillMainRegions);
//#UC END# *55364525020F_552D07EB03CB_impl*
end;//TdaScheme.BuildMain

procedure TdaScheme.BuildFamily;
//#UC START# *5536453001FD_552D07EB03CB_var*
//#UC END# *5536453001FD_552D07EB03CB_var*
begin
//#UC START# *5536453001FD_552D07EB03CB_impl*
 f_Tables[da_ftNone] := MakeTableDescription(da_ftNone, '', 'Фэйковая таблица', nil, '', False, True);
 f_Tables[da_ftDocuments] := MakeTableDescription(da_ftDocuments, 'documents', 'Документы (ftFile)', FillFamilyDocuments);
 f_Tables[da_ftHyperlinks] := MakeTableDescription(da_ftHyperlinks, 'hyperlinks', 'Гиперссылки (ftHLink)', FillFamilyHyperlinks);
 f_Tables[da_ftSubs] := MakeTableDescription(da_ftSubs, 'subs', 'Сабы (ftSub)', FillFamilySubs);
 f_Tables[da_ftFree] := MakeTableDescription(da_ftFree, 'free', 'Список диапазонов для ID', FillFamilyFree);
 f_Tables[da_ftSources] := MakeTableDescription(da_ftSources, 'sources', 'Словарь Исходящие органы (ftDt1)', FillFamilySources);
 f_Tables[da_ftTypes] := MakeTableDescription(da_ftTypes, 'types', 'Словарь Типы (ftDt2)', FillFamilyTypes);
 f_Tables[da_ftClasses] := MakeTableDescription(da_ftClasses, 'classes', 'Словарь Классы (ftDt3)', FillFamilyClasses);
 f_Tables[da_ftKeywords] := MakeTableDescription(da_ftKeywords, 'keywords', 'Словарь Ключевые слова (ftDt5)', FillFamilyKeyWords);
 f_Tables[da_ftBelongs] := MakeTableDescription(da_ftBelongs, 'belongs', 'Словарь Группы (ftDt6)', FillFamilyBelongs);
 f_Tables[da_ftDateCodes] := MakeTableDescription(da_ftDateCodes, 'date_codes', 'Словарь Номеров и Дат (ftDt7)', FillFamilyDateCodes);
 f_Tables[da_ftWarnings] := MakeTableDescription(da_ftWarnings, 'warnings', 'Словарь Предупреждений (ftDt8)', FillFamilyWarnings);
 f_Tables[da_ftCorrections] := MakeTableDescription(da_ftCorrections, 'corrects', 'Словарь Вычитка (ftDt9)', FillFamilyCorrections);
 f_Tables[da_ftCoSources] := MakeTableDescription(da_ftCoSources, 'issues', 'Словарь Изданий (ftDtA)', FillFamilyCoSources);
 f_Tables[da_ftPiblishedIn] := MakeTableDescription(da_ftPiblishedIn, 'published_issue', 'Словарь Источников опубликования (ftDtB)', FillFamilyPublishedIn);
 f_Tables[da_ftPrefixes] := MakeTableDescription(da_ftPrefixes, 'prefixes', 'Словарь Видов информации (ftDtC)', FillFamilyPrefixes);
 f_Tables[da_ftTerritories] := MakeTableDescription(da_ftTerritories, 'territories', 'Словарь Территорий (ftDtD)', FillFamilyTerritories);
 f_Tables[da_ftNorms] := MakeTableDescription(da_ftNorms, 'norms', 'Словарь Нормы права (ftDtE)', FillFamilyNorms);
 f_Tables[da_ftExtClasses] := MakeTableDescription(da_ftExtClasses, 'ext_classes', 'Дополнение Словаря Классов (ftDt3E)', FillFamilyExtClasses);
 f_Tables[da_ftAccessGroups] := MakeTableDescription(da_ftAccessGroups, 'access_groups', 'Словарь Группы доступа (ftDtF)', FillFamilyAccessGroups);
 f_Tables[da_ftAnnoClasses] := MakeTableDescription(da_ftAnnoClasses, 'anno_classes', 'Словарь Классы аннотаций (ftDtI)', FillFamilyAnnoClasses);
 f_Tables[da_ftServiceInfo] := MakeTableDescription(da_ftServiceInfo, 'service_info', 'Словарь Вид справочной информации (ftDtJ)', FillFamilyServiceInfo);
 f_Tables[da_ftDocSources] := MakeTableDescription(da_ftDocSources, 'doc_source', 'Исходящие органы документа (ftLnk1)', FillFamilyDocSources);
 f_Tables[da_ftDocTypes] := MakeTableDescription(da_ftDocTypes, 'doc_type', 'Типы документа (ftLnk2)', FillFamilyDocTypes);
 f_Tables[da_ftDocClasses] := MakeTableDescription(da_ftDocClasses, 'doc_class', 'Классы документа (ftLnk3)', FillFamilyDocClasses);
 f_Tables[da_ftDocKeywords] := MakeTableDescription(da_ftDocKeywords, 'doc_keyword', 'Ключевые слова документа (ftLnk5)', FillFamilyDocKeywords);
 f_Tables[da_ftDocBelongs] := MakeTableDescription(da_ftDocBelongs, 'doc_belong', 'Группы документа (ftLnk6)', FillFamilyDocBelongs);
 f_Tables[da_ftDocDateCodes] := MakeTableDescription(da_ftDocDateCodes, 'doc_data_code', 'Номера и даты документа (ftLnk7) - не нужен', FillFamilyDocDateCodes);
 f_Tables[da_ftDocWarnings] := MakeTableDescription(da_ftDocWarnings, 'doc_warning', 'Предупреждения документа (ftLnk8)', FillFamilyDocWarnings);
 f_Tables[da_ftDocCorrections] := MakeTableDescription(da_ftDocCorrections, 'doc_correction', 'Вычитка документа (ftLnk9) - не нужен', FillFamilyDocCorrections);
 f_Tables[da_ftDocPublishedIn] := MakeTableDescription(da_ftDocPublishedIn, 'doc_published_issue', 'Источники опубликования документа (ftLnkB)', FillFamilyDocPublishedIn);
 f_Tables[da_ftDocPrefixes] := MakeTableDescription(da_ftDocPrefixes, 'doc_prefix', 'Виды информации документа (ftLnkC)', FillFamilyDocPrefixes);
 f_Tables[da_ftDocTerritories] := MakeTableDescription(da_ftDocTerritories, 'doc_territory', 'Территория документа (ftLnkD)', FillFamilyDocTerritories);
 f_Tables[da_ftDocNorms] := MakeTableDescription(da_ftDocNorms, 'doc_norm', 'Нормы права документа (ftLnkE)', FillFamilyDocNorms);
 f_Tables[da_ftDocAccessGroups] := MakeTableDescription(da_ftDocAccessGroups, 'doc_access_group', 'Группы доступа документа (ftLnkF)', FillFamilyDocAccessGroups);
 f_Tables[da_ftDocAnnoClasses] := MakeTableDescription(da_ftDocAnnoClasses, 'doc_anno_class', 'Классы аннотации документа (ftLnkI)', FillFamilyDocAnnoClasses);
 f_Tables[da_ftDocServiceInfo] := MakeTableDescription(da_ftDocServiceInfo, 'doc_service_info', 'Вид справочной информации документа (ftLnkJ)', FillFamilyDocServiceInfo);
 f_Tables[da_ftDoc2DocLink] := MakeTableDescription(da_ftDoc2DocLink, 'doc_doc_link', 'Связи между документами (ftLnkK)', FillFamilyDoc2DocLink);
 f_Tables[da_ftPriority] := MakeTableDescription(da_ftPriority, 'priority', 'Словарь приоритетов (ftPriority)', FillFamilyPriority);
 f_Tables[da_ftRenum] := MakeTableDescription(da_ftRenum, 'renum', 'Соответствие внешних и внутренних номеров (ftRenum)', FillFamilyRenum);
 f_Tables[da_ftDocStages] := MakeTableDescription(da_ftDocStages, 'doc_stage', 'Этапы обработки документа (ftStage)', FillFamilyDocStages);
 f_Tables[da_ftDocLog] := MakeTableDescription(da_ftDocLog, 'doc_log', 'Журнал изменения документа (ftLog)', FillFamilyDocLog);
 f_Tables[da_ftDocActivity] := MakeTableDescription(da_ftDocActivity, 'doc_active', 'Интервалы действия документа (ftActiv)', FillFamilyDocActivity);
 f_Tables[da_ftDocAlarm] := MakeTableDescription(da_ftDocAlarm, 'doc_alarm', 'Служебные предупреждения к документу (ftAlarm)', FillFamilyDocAlarm);
 f_Tables[da_ftControl] := MakeTableDescription(da_ftControl, 'ctrl', 'Флажок эксклюзивного доступа (ftCtrl)', FillControl);
 f_Tables[da_ftDocumentsDub1] := MakeTableDescription(da_ftDocumentsDub1, 'documents', 'Дубликат таблицы документов - для связывания в запросах (ftFileDup1)', FillFamilyDocuments, '', True);
 f_Tables[da_ftDocumentsDub2] := MakeTableDescription(da_ftDocumentsDub2, 'documents', 'Дубликат таблицы документов - для связывания в запросах (ftFileDup2)', FillFamilyDocuments, '', True);
 f_Tables[da_ftAutolinkDocumentsLocal] := MakeTableDescription(da_ftAutolinkDocumentsLocal, 'autolink_doc_local', 'Автопростановщик - локальные документы', FillFamilyAutolinkDoc);
 f_Tables[da_ftAutolinkEditionsLocal] := MakeTableDescription(da_ftAutolinkEditionsLocal, 'autolink_editions_local', 'Автопростановщик - локальные редакции', FillFamilyAutolinkEdition);
 f_Tables[da_ftAutolinkDocumentsRemote] := MakeTableDescription(da_ftAutolinkDocumentsRemote, 'autolink_doc_remote', 'Автопростановщик - внешние документы', FillFamilyAutolinkDoc);
 f_Tables[da_ftAutolinkEditionsRemote] := MakeTableDescription(da_ftAutolinkEditionsRemote, 'autolink_editions_remote', 'Автопростановщик - внешние редакции', FillFamilyAutolinkEdition);
//#UC END# *5536453001FD_552D07EB03CB_impl*
end;//TdaScheme.BuildFamily

function TdaScheme.MakeTableDescription(aKind: TdaTables;
 const aSQLName: AnsiString;
 const aDescription: AnsiString;
 aProc: TdaFillTableDescriptionProc;
 const aScheme: AnsiString = '';
 aDublicate: Boolean = False;
 aFake: Boolean = False): IdaTableDescription;
//#UC START# *5539EF2000FF_552D07EB03CB_var*
var
 l_Table: TdaTableDescription;
//#UC END# *5539EF2000FF_552D07EB03CB_var*
begin
//#UC START# *5539EF2000FF_552D07EB03CB_impl*
 l_Table := TdaTableDescription.Create(aKind, aSQLName, aDescription, aScheme, aDublicate, aFake, aKind in da_TreeTableKinds);
 try
  Result := l_Table;
  if Assigned(aProc) then
   aProc(l_Table);
  if aKind in da_TreeTableKinds then
  begin
   l_Table.AddField(TdaFieldDescription.Make('Parentid', 'ID родителя', False, da_dtQWord));
   l_Table.AddField(TdaFieldDescription.Make('Ordernum', 'Порядок сортировки', False, da_dtQWord));
  end;
 finally
  FreeAndNil(l_Table);
 end;
//#UC END# *5539EF2000FF_552D07EB03CB_impl*
end;//TdaScheme.MakeTableDescription

procedure TdaScheme.FillMainAccess(aTable: TdaTableDescription);
//#UC START# *5539EFC3037B_552D07EB03CB_var*
//#UC END# *5539EFC3037B_552D07EB03CB_var*
begin
//#UC START# *5539EFC3037B_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('User_Gr', 'ID группы пользователей', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('FamilyID', 'ID семейства', True, da_dtWord));           //
 aTable.AddField(TdaFieldDescription.Make('Docum_Gr', 'ID группы доступа документа', True, da_dtQWord));  //
 aTable.AddField(TdaFieldDescription.Make('Mask', 'Маска прав', True, da_dtQWord));
//#UC END# *5539EFC3037B_552D07EB03CB_impl*
end;//TdaScheme.FillMainAccess

procedure TdaScheme.FillMainPassword(aTable: TdaTableDescription);
//#UC START# *5539FF9001C0_552D07EB03CB_var*
//#UC END# *5539FF9001C0_552D07EB03CB_var*
begin
//#UC START# *5539FF9001C0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ShortName', 'Логин', True, da_dtChar, 15)); //
 aTable.AddField(TdaFieldDescription.Make('Password', 'Пароль', True, da_dtChar, 10));
 aTable.AddField(TdaFieldDescription.Make('User_ID', 'ID Пользователя', True, da_dtQWord)); // AK
//#UC END# *5539FF9001C0_552D07EB03CB_impl*
end;//TdaScheme.FillMainPassword

procedure TdaScheme.FillMainUsers(aTable: TdaTableDescription);
//#UC START# *5539FFA400F0_552D07EB03CB_var*
//#UC END# *5539FFA400F0_552D07EB03CB_var*
begin
//#UC START# *5539FFA400F0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('id', 'ID Пользователя', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('user_name', 'ФИО', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('name_length', 'Длина ФИО', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('active', 'Флаги (активность, админскость)', True, da_dtByte)); 
//#UC END# *5539FFA400F0_552D07EB03CB_impl*
end;//TdaScheme.FillMainUsers

procedure TdaScheme.FillMainGroups(aTable: TdaTableDescription);
//#UC START# *5539FFBC0157_552D07EB03CB_var*
//#UC END# *5539FFBC0157_552D07EB03CB_var*
begin
//#UC START# *5539FFBC0157_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('id', 'ID Группы', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('group_name', 'Название', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('name_length', 'Длина названия', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('import_priority', 'Приоритет импорта', True, da_dtInteger));
 aTable.AddField(TdaFieldDescription.Make('export_priority', 'Приоритет экспорта', True, da_dtInteger));
//#UC END# *5539FFBC0157_552D07EB03CB_impl*
end;//TdaScheme.FillMainGroups

procedure TdaScheme.FillMainGroupMembers(aTable: TdaTableDescription);
//#UC START# *5539FFDC022E_552D07EB03CB_var*
//#UC END# *5539FFDC022E_552D07EB03CB_var*
begin
//#UC START# *5539FFDC022E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('user_id', 'ID Пользователя', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('group_id', 'ID Группы', True, da_dtWord)); //
//#UC END# *5539FFDC022E_552D07EB03CB_impl*
end;//TdaScheme.FillMainGroupMembers

procedure TdaScheme.FillMainFamily(aTable: TdaTableDescription);
//#UC START# *5539FFFB0143_552D07EB03CB_var*
//#UC END# *5539FFFB0143_552D07EB03CB_var*
begin
//#UC START# *5539FFFB0143_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Семейства', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('FamilyName', 'Название', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Doc_Group', '???', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('PathToTbl', 'Путь на диске (HT)', True, da_dtChar, 128));
 aTable.AddField(TdaFieldDescription.Make('Attributes', '???', True, da_dtQWord));
//#UC END# *5539FFFB0143_552D07EB03CB_impl*
end;//TdaScheme.FillMainFamily

procedure TdaScheme.FillMainFree(aTable: TdaTableDescription);
//#UC START# *553A000C0379_552D07EB03CB_var*
//#UC END# *553A000C0379_552D07EB03CB_var*
begin
//#UC START# *553A000C0379_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('table_name', 'Код таблицы (HT)', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('start_num', 'Начало свободного диапазона', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('last_num', 'Конец диапазона', True, da_dtQWord));
//#UC END# *553A000C0379_552D07EB03CB_impl*
end;//TdaScheme.FillMainFree

procedure TdaScheme.FillMainJournal(aTable: TdaTableDescription);
//#UC START# *553A0020004E_552D07EB03CB_var*
//#UC END# *553A0020004E_552D07EB03CB_var*
begin
//#UC START# *553A0020004E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('session_id', 'ID сессии', True, da_dtQWord)); // Формируется как уникальное число на клиенте с проверкой уникальности в таблице
 aTable.AddField(TdaFieldDescription.Make('operation_id', 'ID операции', True, da_dtWord)); // Хардкодед словарь см. TBBOperation
 aTable.AddField(TdaFieldDescription.Make('family_id', 'ID Семейства', True, da_dtWord)); // 0 = null
 aTable.AddField(TdaFieldDescription.Make('ext_id', 'ID чего-то', True, da_dtQWord)); // 0 = null Зависит от операции - или документ или пользователь
 aTable.AddField(TdaFieldDescription.Make('date', 'Дата', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('time', 'Время', True, da_dtTime));
 aTable.AddField(TdaFieldDescription.Make('additional', 'Доп. информация', True, da_dtQWord)); // 0 = null Зависит от операции - см. TBBOperation
//#UC END# *553A0020004E_552D07EB03CB_impl*
end;//TdaScheme.FillMainJournal

procedure TdaScheme.FillControl(aTable: TdaTableDescription);
//#UC START# *553A003200BF_552D07EB03CB_var*
//#UC END# *553A003200BF_552D07EB03CB_var*
begin
//#UC START# *553A003200BF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Attributes', '???', True, da_dtQWord)); //
//#UC END# *553A003200BF_552D07EB03CB_impl*
end;//TdaScheme.FillControl

procedure TdaScheme.FillMainRegions(aTable: TdaTableDescription);
//#UC START# *553A00440110_552D07EB03CB_var*
//#UC END# *553A00440110_552D07EB03CB_var*
begin
//#UC START# *553A00440110_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Региона', True, da_dtByte));
 aTable.AddField(TdaFieldDescription.Make('Name', 'Название', True, da_dtChar, 50));
//#UC END# *553A00440110_552D07EB03CB_impl*
end;//TdaScheme.FillMainRegions

procedure TdaScheme.FillFamilyDocuments(aTable: TdaTableDescription);
//#UC START# *553DE6E1033B_552D07EB03CB_var*
//#UC END# *553DE6E1033B_552D07EB03CB_var*
begin
//#UC START# *553DE6E1033B_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID документа', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('ShortName', 'Кратное название', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('FullName', 'Полное название', True, da_dtChar, 1000));
 aTable.AddField(TdaFieldDescription.Make('Status', 'Флаги статуса', True, da_dtWord)); // см. dstatXXX в dt_Const
 aTable.AddField(TdaFieldDescription.Make('Priority', 'Приоритет', True, da_dtWord)); // Денормализация от da_ftPriority в зависимости от Исходящих органов и Типов (береться минимальный)
 aTable.AddField(TdaFieldDescription.Make('SortDate', 'Дата для сортировки', True, da_dtDate)); // Денормализация от da_ftDocDateCodes (береться минимальный)
 aTable.AddField(TdaFieldDescription.Make('Typ', 'ID внутреннего типа', True, da_dtByte)); // Хардкодед словарь см. TDocType в dt_Types
 aTable.AddField(TdaFieldDescription.Make('Flag', 'ID пользовательского типа', True, da_dtByte)); // Хардкодед словарь см. TUserType в dt_Types
 aTable.AddField(TdaFieldDescription.Make('Related', 'ID справки к документу', True, da_dtQWord)); // Сам на себя
 aTable.AddField(TdaFieldDescription.Make('PaperUser', 'Хранитель твердой копии - умерло', True, da_dtWord)); // умерло!!!
 aTable.AddField(TdaFieldDescription.Make('PaperPlace', 'Место хранения твердой копии - умерло', True, da_dtChar, 100)); // умерло!!!
 aTable.AddField(TdaFieldDescription.Make('PriorFlag', 'Ручное изменение приоритета', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('StageMask', '??? - умерло', True, da_dtWord)); // умерло
 aTable.AddField(TdaFieldDescription.Make('VerLink', 'ID предыдущую редакцию', True, da_dtQWord)); // Сам на себя
 aTable.AddField(TdaFieldDescription.Make('HasAnno', 'Есть ли аннотация', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('Urgency', 'ID Срочности', True, da_dtByte)); // Совсем Хардкодед словарь см. cUrgencyCaption в dt_Doc
 aTable.AddField(TdaFieldDescription.Make('Comment', 'Комментарий', True, da_dtChar, 100));
//#UC END# *553DE6E1033B_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocuments

procedure TdaScheme.FillFamilyHyperlinks(aTable: TdaTableDescription);
//#UC START# *553DE7080233_552D07EB03CB_var*
//#UC END# *553DE7080233_552D07EB03CB_var*
begin
//#UC START# *553DE7080233_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID гиперссылкой', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SourDoc', 'ID документа с гиперссылкой', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('DestDoc', 'ID целевого документа', True, da_dtQWord)); // // Часть ссылки на da_ftSubs
 aTable.AddField(TdaFieldDescription.Make('DestSub', 'ID целевого саба', True, da_dtQWord)); // // Часть ссылки на da_ftSubs
//#UC END# *553DE7080233_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyHyperlinks

procedure TdaScheme.FillFamilySubs(aTable: TdaTableDescription);
//#UC START# *553DE72B011F_552D07EB03CB_var*
//#UC END# *553DE72B011F_552D07EB03CB_var*
begin
//#UC START# *553DE72B011F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SubID', 'ID Саба', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RealFlag', 'Ручное задание имени', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('SubName', 'Название', True, da_dtChar, 800));
//#UC END# *553DE72B011F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilySubs

procedure TdaScheme.FillFamilyFree(aTable: TdaTableDescription);
//#UC START# *553DE749014E_552D07EB03CB_var*
//#UC END# *553DE749014E_552D07EB03CB_var*
begin
//#UC START# *553DE749014E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('table_name', 'Код таблицы (HT)', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('start_num', 'Начало свободного диапазона', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('last_num', 'Конец диапазона', True, da_dtQWord));
//#UC END# *553DE749014E_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyFree

procedure TdaScheme.FillFamilySources(aTable: TdaTableDescription);
//#UC START# *553DE77003DF_552D07EB03CB_var*
//#UC END# *553DE77003DF_552D07EB03CB_var*
begin
//#UC START# *553DE77003DF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Исходящего органа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('ShortName', 'Краткое занвание', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('Sinonims', 'Синонимы', True, da_dtChar, 800));
//#UC END# *553DE77003DF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilySources

procedure TdaScheme.FillFamilyTypes(aTable: TdaTableDescription);
//#UC START# *553DE7850036_552D07EB03CB_var*
//#UC END# *553DE7850036_552D07EB03CB_var*
begin
//#UC START# *553DE7850036_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Типа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE7850036_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyTypes

procedure TdaScheme.FillFamilyClasses(aTable: TdaTableDescription);
//#UC START# *553DE79F0210_552D07EB03CB_var*
//#UC END# *553DE79F0210_552D07EB03CB_var*
begin
//#UC START# *553DE79F0210_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Класса', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE79F0210_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyClasses

procedure TdaScheme.FillFamilyKeywords(aTable: TdaTableDescription);
//#UC START# *553DE7B101D5_552D07EB03CB_var*
//#UC END# *553DE7B101D5_552D07EB03CB_var*
begin
//#UC START# *553DE7B101D5_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Ключевого слова', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE7B101D5_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyKeywords

procedure TdaScheme.FillFamilyBelongs(aTable: TdaTableDescription);
//#UC START# *553DE7C8025D_552D07EB03CB_var*
//#UC END# *553DE7C8025D_552D07EB03CB_var*
begin
//#UC START# *553DE7C8025D_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Группы', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('ShName', 'Краткое название', True, da_dtChar, 10));
//#UC END# *553DE7C8025D_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyBelongs

procedure TdaScheme.FillFamilyDateCodes(aTable: TdaTableDescription);
//#UC START# *553DE7E401C4_552D07EB03CB_var*
//#UC END# *553DE7E401C4_552D07EB03CB_var*
begin
//#UC START# *553DE7E401C4_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Номера и даты', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Date', 'Дата', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('No', 'Номер', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Tip', 'ID типа Датономера', True, da_dtByte)); // Хардкодед словарь см. TDNType в dt_Types
 aTable.AddField(TdaFieldDescription.Make('LDocID', 'ID документа вносящего изменения', True, da_dtQWord)); // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('LSubID', 'ID саба вносящего изменения', True, da_dtQWord)); // Часть ссылки на da_ftSub
//#UC END# *553DE7E401C4_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDateCodes

procedure TdaScheme.FillFamilyWarnings(aTable: TdaTableDescription);
//#UC START# *553DE8070027_552D07EB03CB_var*
//#UC END# *553DE8070027_552D07EB03CB_var*
begin
//#UC START# *553DE8070027_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Предупреждения', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 1000));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 1000));
//#UC END# *553DE8070027_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyWarnings

procedure TdaScheme.FillFamilyCorrections(aTable: TdaTableDescription);
//#UC START# *553DE8170107_552D07EB03CB_var*
//#UC END# *553DE8170107_552D07EB03CB_var*
begin
//#UC START# *553DE8170107_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Вычитки', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Date', 'Дата вычитки', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Source', 'ID Источника опубликования связанного документа', True, da_dtQWord)); // !!! Допустимы только те источники опубликования, которые укзаны для документа !!!
 aTable.AddField(TdaFieldDescription.Make('Type', 'ID типа вычитки', True, da_dtByte)); // Совсем Хардкодед словарь (D_SrcChk) = 0 - Документ, 1 - Изменения
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID пользователя-корректора', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Coment', 'Комментарий', True, da_dtChar, 70));
//#UC END# *553DE8170107_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyCorrections

procedure TdaScheme.FillFamilyCoSources(aTable: TdaTableDescription);
//#UC START# *553DE82E0028_552D07EB03CB_var*
//#UC END# *553DE82E0028_552D07EB03CB_var*
begin
//#UC START# *553DE82E0028_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Издания', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('ShName', 'Краткое название', False, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Private', 'Не отдавать пользователям', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('NonPeriod', 'Не переодическое', True, da_dtBoolean));
//#UC END# *553DE82E0028_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyCoSources

procedure TdaScheme.FillFamilyPublishedIn(aTable: TdaTableDescription);
//#UC START# *553DE83D011A_552D07EB03CB_var*
//#UC END# *553DE83D011A_552D07EB03CB_var*
begin
//#UC START# *553DE83D011A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Источника опубликования', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Source', 'ID Издания', True, da_dtQWord)); // AK
 aTable.AddField(TdaFieldDescription.Make('StartDate', 'Начало периода', True, da_dtQWord)); // AK // ежемесячный журнал = 1.хх по 31.хх
 aTable.AddField(TdaFieldDescription.Make('EndDate', 'Конец периода', True, da_dtQWord)); // AK // ежедневный = xx.yy по xx.yy
 aTable.AddField(TdaFieldDescription.Make('Number', 'Номер', True, da_dtChar, 30)); // AK
 aTable.AddField(TdaFieldDescription.Make('Coment', 'Name', True, da_dtChar, 70));
//#UC END# *553DE83D011A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPublishedIn

procedure TdaScheme.FillFamilyPrefixes(aTable: TdaTableDescription);
//#UC START# *553DE862036A_552D07EB03CB_var*
//#UC END# *553DE862036A_552D07EB03CB_var*
begin
//#UC START# *553DE862036A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Вида информации', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE862036A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPrefixes

procedure TdaScheme.FillFamilyTerritories(aTable: TdaTableDescription);
//#UC START# *553DE875037C_552D07EB03CB_var*
//#UC END# *553DE875037C_552D07EB03CB_var*
begin
//#UC START# *553DE875037C_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Территории', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE875037C_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyTerritories

procedure TdaScheme.FillFamilyNorms(aTable: TdaTableDescription);
//#UC START# *553DE88902FF_552D07EB03CB_var*
//#UC END# *553DE88902FF_552D07EB03CB_var*
begin
//#UC START# *553DE88902FF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Нормы права', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE88902FF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyNorms

procedure TdaScheme.FillFamilyExtClasses(aTable: TdaTableDescription);
//#UC START# *553DE89701FF_552D07EB03CB_var*
//#UC END# *553DE89701FF_552D07EB03CB_var*
begin
//#UC START# *553DE89701FF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('FirstID', 'ID класса', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SecondID', 'ID суперкласса', True, da_dtQWord)); // // скорее FirstID подмножество SecondID, но не наоборот
//#UC END# *553DE89701FF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyExtClasses

procedure TdaScheme.FillFamilyAccessGroups(aTable: TdaTableDescription);
//#UC START# *553DE8C3038F_552D07EB03CB_var*
//#UC END# *553DE8C3038F_552D07EB03CB_var*
begin
//#UC START# *553DE8C3038F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Группы доступа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('ShName', 'Краткое название', True, da_dtChar, 10));
//#UC END# *553DE8C3038F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAccessGroups

procedure TdaScheme.FillFamilyAnnoClasses(aTable: TdaTableDescription);
//#UC START# *553DE8D60075_552D07EB03CB_var*
//#UC END# *553DE8D60075_552D07EB03CB_var*
begin
//#UC START# *553DE8D60075_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Класса аннотаций', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE8D60075_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAnnoClasses

procedure TdaScheme.FillFamilyServiceInfo(aTable: TdaTableDescription);
//#UC START# *553DE8FE01AD_552D07EB03CB_var*
//#UC END# *553DE8FE01AD_552D07EB03CB_var*
begin
//#UC START# *553DE8FE01AD_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID Вида справочной информации', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', 'Название', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 100));
//#UC END# *553DE8FE01AD_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyServiceInfo

procedure TdaScheme.FillFamilyDocSources(aTable: TdaTableDescription);
//#UC START# *553F2E94021D_552D07EB03CB_var*
//#UC END# *553F2E94021D_552D07EB03CB_var*
begin
//#UC START# *553F2E94021D_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Исходящего органа', True, da_dtQWord)); //
//#UC END# *553F2E94021D_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocSources

procedure TdaScheme.FillFamilyDocTypes(aTable: TdaTableDescription);
//#UC START# *553F2EE802EF_552D07EB03CB_var*
//#UC END# *553F2EE802EF_552D07EB03CB_var*
begin
//#UC START# *553F2EE802EF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); // // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Типа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID саба', True, da_dtQWord)); // // Часть ссылки на da_ftSub - НО Sub = 0 это весь документ и его НЕТ в da_ftSub!!!
//#UC END# *553F2EE802EF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocTypes

procedure TdaScheme.FillFamilyDocClasses(aTable: TdaTableDescription);
//#UC START# *553F2F0D0100_552D07EB03CB_var*
//#UC END# *553F2F0D0100_552D07EB03CB_var*
begin
//#UC START# *553F2F0D0100_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); // // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Класса', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID саба', True, da_dtQWord)); // // Часть ссылки на da_ftSub - НО Sub = 0 это весь документ и его НЕТ в da_ftSub!!!
//#UC END# *553F2F0D0100_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocClasses

procedure TdaScheme.FillFamilyDocKeywords(aTable: TdaTableDescription);
//#UC START# *553F2F34011F_552D07EB03CB_var*
//#UC END# *553F2F34011F_552D07EB03CB_var*
begin
//#UC START# *553F2F34011F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); // // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Ключевого слова', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID саба', True, da_dtQWord)); // // Часть ссылки на da_ftSub - НО Sub = 0 это весь документ и его НЕТ в da_ftSub!!!
//#UC END# *553F2F34011F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocKeywords

procedure TdaScheme.FillFamilyDocBelongs(aTable: TdaTableDescription);
//#UC START# *553F2F5E0169_552D07EB03CB_var*
//#UC END# *553F2F5E0169_552D07EB03CB_var*
begin
//#UC START# *553F2F5E0169_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Группы', True, da_dtQWord)); //
//#UC END# *553F2F5E0169_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocBelongs

procedure TdaScheme.FillFamilyDocDateCodes(aTable: TdaTableDescription);
//#UC START# *553F2F8300A1_552D07EB03CB_var*
//#UC END# *553F2F8300A1_552D07EB03CB_var*
begin
//#UC START# *553F2F8300A1_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Номеродаты', True, da_dtQWord)); //
//#UC END# *553F2F8300A1_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocDateCodes

procedure TdaScheme.FillFamilyDocWarnings(aTable: TdaTableDescription);
//#UC START# *553F2FA00207_552D07EB03CB_var*
//#UC END# *553F2FA00207_552D07EB03CB_var*
begin
//#UC START# *553F2FA00207_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Предупраждения', True, da_dtQWord)); //
//#UC END# *553F2FA00207_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocWarnings

procedure TdaScheme.FillFamilyDocCorrections(aTable: TdaTableDescription);
//#UC START# *553F2FC40156_552D07EB03CB_var*
//#UC END# *553F2FC40156_552D07EB03CB_var*
begin
//#UC START# *553F2FC40156_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Вычитки', True, da_dtQWord)); //
//#UC END# *553F2FC40156_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocCorrections

procedure TdaScheme.FillFamilyDocPublishedIn(aTable: TdaTableDescription);
//#UC START# *553F2FE300DC_552D07EB03CB_var*
//#UC END# *553F2FE300DC_552D07EB03CB_var*
begin
//#UC START# *553F2FE300DC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Источника опубликования', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Pages', 'Страницы', True, da_dtChar, 128));
 aTable.AddField(TdaFieldDescription.Make('Coment', 'Комментарий', True, da_dtChar, 255));
 aTable.AddField(TdaFieldDescription.Make('Flags', 'Флаги', True, da_dtByte)); // см pinfClone и пр. в dt_Const
//#UC END# *553F2FE300DC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocPublishedIn

procedure TdaScheme.FillFamilyDocPrefixes(aTable: TdaTableDescription);
//#UC START# *553F300C00A1_552D07EB03CB_var*
//#UC END# *553F300C00A1_552D07EB03CB_var*
begin
//#UC START# *553F300C00A1_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); // // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Вида информации', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID саба', True, da_dtQWord)); // // Часть ссылки на da_ftSub - НО Sub = 0 это весь документ и его НЕТ в da_ftSub!!!
//#UC END# *553F300C00A1_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocPrefixes

procedure TdaScheme.FillFamilyDocTerritories(aTable: TdaTableDescription);
//#UC START# *553F302E0091_552D07EB03CB_var*
//#UC END# *553F302E0091_552D07EB03CB_var*
begin
//#UC START# *553F302E0091_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Территории', True, da_dtQWord)); //
//#UC END# *553F302E0091_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocTerritories

procedure TdaScheme.FillFamilyDocNorms(aTable: TdaTableDescription);
//#UC START# *553F304E00E0_552D07EB03CB_var*
//#UC END# *553F304E00E0_552D07EB03CB_var*
begin
//#UC START# *553F304E00E0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Нормы права', True, da_dtQWord)); //
//#UC END# *553F304E00E0_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocNorms

procedure TdaScheme.FillFamilyDocAccessGroups(aTable: TdaTableDescription);
//#UC START# *553F306E01DA_552D07EB03CB_var*
//#UC END# *553F306E01DA_552D07EB03CB_var*
begin
//#UC START# *553F306E01DA_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Группы доступа', True, da_dtQWord)); //
//#UC END# *553F306E01DA_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocAccessGroups

procedure TdaScheme.FillFamilyDocAnnoClasses(aTable: TdaTableDescription);
//#UC START# *553F308901D3_552D07EB03CB_var*
//#UC END# *553F308901D3_552D07EB03CB_var*
begin
//#UC START# *553F308901D3_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Класса аннотации', True, da_dtQWord)); //
//#UC END# *553F308901D3_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocAnnoClasses

procedure TdaScheme.FillFamilyDocServiceInfo(aTable: TdaTableDescription);
//#UC START# *553F30A901C5_552D07EB03CB_var*
//#UC END# *553F30A901C5_552D07EB03CB_var*
begin
//#UC START# *553F30A901C5_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); // // Часть ссылки на da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID Вида справочной информации', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID саба', True, da_dtQWord)); // // Часть ссылки на da_ftSub - НО Sub = 0 это весь документ и его НЕТ в da_ftSub!!!
//#UC END# *553F30A901C5_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocServiceInfo

procedure TdaScheme.FillFamilyDoc2DocLink(aTable: TdaTableDescription);
//#UC START# *553F30C7024A_552D07EB03CB_var*
//#UC END# *553F30C7024A_552D07EB03CB_var*
begin
//#UC START# *553F30C7024A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID Документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('LinkType', 'ID типа связи', True, da_dtByte)); // // совсем хардкодед словарь (D_Doc2DocLinkEdit) 0-документ изменен, 1-документ утратил силу
 aTable.AddField(TdaFieldDescription.Make('LinkDocID', 'ID документа связи', True, da_dtQWord)); //
//#UC END# *553F30C7024A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDoc2DocLink

procedure TdaScheme.FillFamilyPriority(aTable: TdaTableDescription);
//#UC START# *553F30E70209_552D07EB03CB_var*
//#UC END# *553F30E70209_552D07EB03CB_var*
begin
//#UC START# *553F30E70209_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Sour_ID', 'ID Исходящего органа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Type_ID', 'ID Типа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Priority', 'Приоритет', True, da_dtWord));
//#UC END# *553F30E70209_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPriority

procedure TdaScheme.FillFamilyRenum(aTable: TdaTableDescription);
//#UC START# *553F310900AC_552D07EB03CB_var*
//#UC END# *553F310900AC_552D07EB03CB_var*
begin
//#UC START# *553F310900AC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('RealID', 'ID документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('ImportID', 'Внешнее ID документа', True, da_dtQWord)); // AK
//#UC END# *553F310900AC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyRenum

procedure TdaScheme.FillFamilyDocStages(aTable: TdaTableDescription);
//#UC START# *553F312A001C_552D07EB03CB_var*
//#UC END# *553F312A001C_552D07EB03CB_var*
begin
//#UC START# *553F312A001C_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Type', 'ID типа этапа', True, da_dtByte)); // // см. TStageType в dt_Types
 aTable.AddField(TdaFieldDescription.Make('B_Date', 'Дата начала', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('E_Date', 'Дата окончания', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID Пользователя', True, da_dtQWord));
//#UC END# *553F312A001C_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocStages

procedure TdaScheme.FillFamilyDocLog(aTable: TdaTableDescription);
//#UC START# *553F315000CD_552D07EB03CB_var*
//#UC END# *553F315000CD_552D07EB03CB_var*
begin
//#UC START# *553F315000CD_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Action', 'ID действия', True, da_dtByte)); // Хардкодед словарь см. TLogActionType в dt_Types
 aTable.AddField(TdaFieldDescription.Make('Date', 'Дата', True, da_dtDate)); //
 aTable.AddField(TdaFieldDescription.Make('Time', 'Время', True, da_dtTime)); //
 aTable.AddField(TdaFieldDescription.Make('ActionFlag', '', True, da_dtByte)); // Хардкодед словарь см. TLogActionFlags в dt_Types
 aTable.AddField(TdaFieldDescription.Make('Station', 'Станция HT', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID Пользователя', True, da_dtQWord)); 
//#UC END# *553F315000CD_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocLog

procedure TdaScheme.FillFamilyDocActivity(aTable: TdaTableDescription);
//#UC START# *553F316B01AC_552D07EB03CB_var*
//#UC END# *553F316B01AC_552D07EB03CB_var*
begin
//#UC START# *553F316B01AC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RecID', 'Порядковый номер', True, da_dtByte)); // // Уникален в рамках DocID
 aTable.AddField(TdaFieldDescription.Make('Typ', 'ID типа', True, da_dtByte)); // Совсем хардкодед словарь 1-Период неуверенности, 0-иначе
 aTable.AddField(TdaFieldDescription.Make('Start', 'Дата начала (с)', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Finish', 'Дата окончания (по)', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Comment', 'Комментарий', True, da_dtChar, 1000));
//#UC END# *553F316B01AC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocActivity

procedure TdaScheme.FillFamilyDocAlarm(aTable: TdaTableDescription);
//#UC START# *553F318A0380_552D07EB03CB_var*
//#UC END# *553F318A0380_552D07EB03CB_var*
begin
//#UC START# *553F318A0380_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID документа', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RecID', 'Порядковый номер', True, da_dtByte)); // // Уникален в рамках DocID
 aTable.AddField(TdaFieldDescription.Make('Start', 'Дата', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Comment', 'Комментарий', True, da_dtChar, 1000));
//#UC END# *553F318A0380_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocAlarm

function TdaScheme.CheckScheme(const aSchemeName: AnsiString): AnsiString;
//#UC START# *56654FC70181_552D07EB03CB_var*
//#UC END# *56654FC70181_552D07EB03CB_var*
begin
//#UC START# *56654FC70181_552D07EB03CB_impl*
 if Trim(aSchemeName) = '' then
  Result := 'archi'
 else
  Result := Trim(aSchemeName);
//#UC END# *56654FC70181_552D07EB03CB_impl*
end;//TdaScheme.CheckScheme

procedure TdaScheme.FillFamilyAutolinkDoc(aTable: TdaTableDescription);
//#UC START# *569F44020026_552D07EB03CB_var*
//#UC END# *569F44020026_552D07EB03CB_var*
begin
//#UC START# *569F44020026_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ExtDocID', 'Внешний ID документа', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('IntDocID', 'Внутренний ID документа', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('DType', 'Тип документа', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Source', 'Исходящий Орган', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Date', 'Дата опубликования', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Num', 'Номер опубликования', False, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('LawCase', 'Номер судебного дела', False, da_dtChar, 50));
//#UC END# *569F44020026_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAutolinkDoc

procedure TdaScheme.FillFamilyAutolinkEdition(aTable: TdaTableDescription);
//#UC START# *569F444D0185_552D07EB03CB_var*
//#UC END# *569F444D0185_552D07EB03CB_var*
begin
//#UC START# *569F444D0185_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('MDocID', 'Внешний ID документа', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('IntDocID', 'Внутренний ID редакции', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('ExtDocID', 'Внешний ID редакции', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Start', 'Дата начала действия', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Finish', 'Дата окончания действия', True, da_dtDate));
//#UC END# *569F444D0185_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAutolinkEdition

function TdaScheme.Table(aTableKind: TdaTables): IdaTableDescription;
//#UC START# *552FBDF700C9_552D07EB03CB_var*
//#UC END# *552FBDF700C9_552D07EB03CB_var*
begin
//#UC START# *552FBDF700C9_552D07EB03CB_impl*
 Result := f_Tables[aTableKind];
//#UC END# *552FBDF700C9_552D07EB03CB_impl*
end;//TdaScheme.Table

function TdaScheme.StoredProcName(anIndex: Integer): AnsiString;
//#UC START# *56A60A740072_552D07EB03CB_var*
const
 cMap: array [0..cStoredProcCount - 1] of String = (
  'get_free_num',
  'get_admin_free_num',
  'delete_admin_free_interval',
  'delete_free_interval'
 );
//#UC END# *56A60A740072_552D07EB03CB_var*
begin
//#UC START# *56A60A740072_552D07EB03CB_impl*
 Assert((anIndex >= 0) and (anIndex < StoredProcsCount));
 Result := cMap[anIndex];
//#UC END# *56A60A740072_552D07EB03CB_impl*
end;//TdaScheme.StoredProcName

function TdaScheme.StoredProcsCount: Integer;
//#UC START# *56A60AA70045_552D07EB03CB_var*
//#UC END# *56A60AA70045_552D07EB03CB_var*
begin
//#UC START# *56A60AA70045_552D07EB03CB_impl*
 Result := cStoredProcCount;
//#UC END# *56A60AA70045_552D07EB03CB_impl*
end;//TdaScheme.StoredProcsCount

class function TdaScheme.Instance: TdaScheme;
 {* Метод получения экземпляра синглетона TdaScheme }
begin
 if (g_TdaScheme = nil) then
 begin
  l3System.AddExitProc(TdaSchemeFree);
  g_TdaScheme := Create;
 end;
 Result := g_TdaScheme;
end;//TdaScheme.Instance

class function TdaScheme.Exists: Boolean;
 {* Проверяет создан экземпляр синглетона или нет }
begin
 Result := g_TdaScheme <> nil;
end;//TdaScheme.Exists

procedure TdaScheme.Cleanup;
 {* Функция очистки полей объекта. }
//#UC START# *479731C50290_552D07EB03CB_var*
var
 l_Idx : TdaTables;
//#UC END# *479731C50290_552D07EB03CB_var*
begin
//#UC START# *479731C50290_552D07EB03CB_impl*
 for l_Idx := Low(f_Tables) to High(f_Tables) do
  f_Tables[l_Idx] := nil;
 inherited;
//#UC END# *479731C50290_552D07EB03CB_impl*
end;//TdaScheme.Cleanup

end.
