unit daScheme;

// ������: "w:\common\components\rtl\Garant\DA\daScheme.pas"
// ���������: "SimpleClass"
// ������� ������: "TdaScheme" MUID: (552D07EB03CB)

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
    {* ������� ������� ����� �������. }
  public
   procedure BuildScheme;
   function CheckScheme(const aSchemeName: AnsiString): AnsiString;
   function Table(aTableKind: TdaTables): IdaTableDescription;
   function StoredProcName(anIndex: Integer): AnsiString;
   function StoredProcsCount: Integer;
   class function Instance: TdaScheme;
    {* ����� ��������� ���������� ���������� TdaScheme }
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
 end;//TdaScheme

implementation

uses
 l3ImplUses
 , SysUtils
 , daFieldDescription
 , l3Base
;

var g_TdaScheme: TdaScheme = nil;
 {* ��������� ���������� TdaScheme }

procedure TdaSchemeFree;
 {* ����� ������������ ���������� ���������� TdaScheme }
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
 f_Tables[da_mtAccess] := MakeTableDescription(da_mtAccess, 'access_rights', '����� ������� � ����������', FillMainAccess);
 f_Tables[da_mtPassword] := MakeTableDescription(da_mtPassword, 'user_passwords', '������ �������������', FillMainPassword);
 f_Tables[da_mtUsers] := MakeTableDescription(da_mtUsers, 'users', '������������', FillMainUsers);
 f_Tables[da_mtGroups] := MakeTableDescription(da_mtGroups, 'user_groups', '������ (mtGUDt)', FillMainGroups);
 f_Tables[da_mtGroupMembers] := MakeTableDescription(da_mtGroupMembers, 'group_members', '����� ������ (mtGULnk)', FillMainGroupMembers);
 f_Tables[da_mtFamily] := MakeTableDescription(da_mtFamily, 'mfamily', '��������� (�� ���������)', FillMainFamily);
 f_Tables[da_mtFree] := MakeTableDescription(da_mtFree, 'mfree', '������ ���������� ��� ID', FillMainFree);
 f_Tables[da_mtJournal] := MakeTableDescription(da_mtJournal, 'system_log', '������ ������ (mtBBLog)', FillMainJournal);
 f_Tables[da_mtControl] := MakeTableDescription(da_mtControl, 'mctrl', '������ ������������� ������� (mtCtrl)', FillControl);
 f_Tables[da_mtRegions] := MakeTableDescription(da_mtRegions, 'regions', '������� ��������', FillMainRegions);
//#UC END# *55364525020F_552D07EB03CB_impl*
end;//TdaScheme.BuildMain

procedure TdaScheme.BuildFamily;
//#UC START# *5536453001FD_552D07EB03CB_var*
//#UC END# *5536453001FD_552D07EB03CB_var*
begin
//#UC START# *5536453001FD_552D07EB03CB_impl*
 f_Tables[da_ftNone] := MakeTableDescription(da_ftNone, '', '�������� �������', nil, '', False, True);
 f_Tables[da_ftDocuments] := MakeTableDescription(da_ftDocuments, 'documents', '��������� (ftFile)', FillFamilyDocuments);
 f_Tables[da_ftHyperlinks] := MakeTableDescription(da_ftHyperlinks, 'hyperlinks', '����������� (ftHLink)', FillFamilyHyperlinks);
 f_Tables[da_ftSubs] := MakeTableDescription(da_ftSubs, 'subs', '���� (ftSub)', FillFamilySubs);
 f_Tables[da_ftFree] := MakeTableDescription(da_ftFree, 'free', '������ ���������� ��� ID', FillFamilyFree);
 f_Tables[da_ftSources] := MakeTableDescription(da_ftSources, 'sources', '������� ��������� ������ (ftDt1)', FillFamilySources);
 f_Tables[da_ftTypes] := MakeTableDescription(da_ftTypes, 'types', '������� ���� (ftDt2)', FillFamilyTypes);
 f_Tables[da_ftClasses] := MakeTableDescription(da_ftClasses, 'classes', '������� ������ (ftDt3)', FillFamilyClasses);
 f_Tables[da_ftKeywords] := MakeTableDescription(da_ftKeywords, 'keywords', '������� �������� ����� (ftDt5)', FillFamilyKeyWords);
 f_Tables[da_ftBelongs] := MakeTableDescription(da_ftBelongs, 'belongs', '������� ������ (ftDt6)', FillFamilyBelongs);
 f_Tables[da_ftDateCodes] := MakeTableDescription(da_ftDateCodes, 'date_codes', '������� ������� � ��� (ftDt7)', FillFamilyDateCodes);
 f_Tables[da_ftWarnings] := MakeTableDescription(da_ftWarnings, 'warnings', '������� �������������� (ftDt8)', FillFamilyWarnings);
 f_Tables[da_ftCorrections] := MakeTableDescription(da_ftCorrections, 'corrects', '������� ������� (ftDt9)', FillFamilyCorrections);
 f_Tables[da_ftCoSources] := MakeTableDescription(da_ftCoSources, 'issues', '������� ������� (ftDtA)', FillFamilyCoSources);
 f_Tables[da_ftPiblishedIn] := MakeTableDescription(da_ftPiblishedIn, 'published_issue', '������� ���������� ������������� (ftDtB)', FillFamilyPublishedIn);
 f_Tables[da_ftPrefixes] := MakeTableDescription(da_ftPrefixes, 'prefixes', '������� ����� ���������� (ftDtC)', FillFamilyPrefixes);
 f_Tables[da_ftTerritories] := MakeTableDescription(da_ftTerritories, 'territories', '������� ���������� (ftDtD)', FillFamilyTerritories);
 f_Tables[da_ftNorms] := MakeTableDescription(da_ftNorms, 'norms', '������� ����� ����� (ftDtE)', FillFamilyNorms);
 f_Tables[da_ftExtClasses] := MakeTableDescription(da_ftExtClasses, 'ext_classes', '���������� ������� ������� (ftDt3E)', FillFamilyExtClasses);
 f_Tables[da_ftAccessGroups] := MakeTableDescription(da_ftAccessGroups, 'access_groups', '������� ������ ������� (ftDtF)', FillFamilyAccessGroups);
 f_Tables[da_ftAnnoClasses] := MakeTableDescription(da_ftAnnoClasses, 'anno_classes', '������� ������ ��������� (ftDtI)', FillFamilyAnnoClasses);
 f_Tables[da_ftServiceInfo] := MakeTableDescription(da_ftServiceInfo, 'service_info', '������� ��� ���������� ���������� (ftDtJ)', FillFamilyServiceInfo);
 f_Tables[da_ftDocSources] := MakeTableDescription(da_ftDocSources, 'doc_source', '��������� ������ ��������� (ftLnk1)', FillFamilyDocSources);
 f_Tables[da_ftDocTypes] := MakeTableDescription(da_ftDocTypes, 'doc_type', '���� ��������� (ftLnk2)', FillFamilyDocTypes);
 f_Tables[da_ftDocClasses] := MakeTableDescription(da_ftDocClasses, 'doc_class', '������ ��������� (ftLnk3)', FillFamilyDocClasses);
 f_Tables[da_ftDocKeywords] := MakeTableDescription(da_ftDocKeywords, 'doc_keyword', '�������� ����� ��������� (ftLnk5)', FillFamilyDocKeywords);
 f_Tables[da_ftDocBelongs] := MakeTableDescription(da_ftDocBelongs, 'doc_belong', '������ ��������� (ftLnk6)', FillFamilyDocBelongs);
 f_Tables[da_ftDocDateCodes] := MakeTableDescription(da_ftDocDateCodes, 'doc_data_code', '������ � ���� ��������� (ftLnk7) - �� �����', FillFamilyDocDateCodes);
 f_Tables[da_ftDocWarnings] := MakeTableDescription(da_ftDocWarnings, 'doc_warning', '�������������� ��������� (ftLnk8)', FillFamilyDocWarnings);
 f_Tables[da_ftDocCorrections] := MakeTableDescription(da_ftDocCorrections, 'doc_correction', '������� ��������� (ftLnk9) - �� �����', FillFamilyDocCorrections);
 f_Tables[da_ftDocPublishedIn] := MakeTableDescription(da_ftDocPublishedIn, 'doc_published_issue', '��������� ������������� ��������� (ftLnkB)', FillFamilyDocPublishedIn);
 f_Tables[da_ftDocPrefixes] := MakeTableDescription(da_ftDocPrefixes, 'doc_prefix', '���� ���������� ��������� (ftLnkC)', FillFamilyDocPrefixes);
 f_Tables[da_ftDocTerritories] := MakeTableDescription(da_ftDocTerritories, 'doc_territory', '���������� ��������� (ftLnkD)', FillFamilyDocTerritories);
 f_Tables[da_ftDocNorms] := MakeTableDescription(da_ftDocNorms, 'doc_norm', '����� ����� ��������� (ftLnkE)', FillFamilyDocNorms);
 f_Tables[da_ftDocAccessGroups] := MakeTableDescription(da_ftDocAccessGroups, 'doc_access_group', '������ ������� ��������� (ftLnkF)', FillFamilyDocAccessGroups);
 f_Tables[da_ftDocAnnoClasses] := MakeTableDescription(da_ftDocAnnoClasses, 'doc_anno_class', '������ ��������� ��������� (ftLnkI)', FillFamilyDocAnnoClasses);
 f_Tables[da_ftDocServiceInfo] := MakeTableDescription(da_ftDocServiceInfo, 'doc_service_info', '��� ���������� ���������� ��������� (ftLnkJ)', FillFamilyDocServiceInfo);
 f_Tables[da_ftDoc2DocLink] := MakeTableDescription(da_ftDoc2DocLink, 'doc_doc_link', '����� ����� ����������� (ftLnkK)', FillFamilyDoc2DocLink);
 f_Tables[da_ftPriority] := MakeTableDescription(da_ftPriority, 'priority', '������� ����������� (ftPriority)', FillFamilyPriority);
 f_Tables[da_ftRenum] := MakeTableDescription(da_ftRenum, 'renum', '������������ ������� � ���������� ������� (ftRenum)', FillFamilyRenum);
 f_Tables[da_ftDocStages] := MakeTableDescription(da_ftDocStages, 'doc_stage', '����� ��������� ��������� (ftStage)', FillFamilyDocStages);
 f_Tables[da_ftDocLog] := MakeTableDescription(da_ftDocLog, 'doc_log', '������ ��������� ��������� (ftLog)', FillFamilyDocLog);
 f_Tables[da_ftDocActivity] := MakeTableDescription(da_ftDocActivity, 'doc_active', '��������� �������� ��������� (ftActiv)', FillFamilyDocActivity);
 f_Tables[da_ftDocAlarm] := MakeTableDescription(da_ftDocAlarm, 'doc_alarm', '��������� �������������� � ��������� (ftAlarm)', FillFamilyDocAlarm);
 f_Tables[da_ftControl] := MakeTableDescription(da_ftControl, 'ctrl', '������ ������������� ������� (ftCtrl)', FillControl);
 f_Tables[da_ftDocumentsDub1] := MakeTableDescription(da_ftDocumentsDub1, 'documents', '�������� ������� ���������� - ��� ���������� � �������� (ftFileDup1)', FillFamilyDocuments, '', True);
 f_Tables[da_ftDocumentsDub2] := MakeTableDescription(da_ftDocumentsDub2, 'documents', '�������� ������� ���������� - ��� ���������� � �������� (ftFileDup2)', FillFamilyDocuments, '', True);
 f_Tables[da_ftAutolinkDocumentsLocal] := MakeTableDescription(da_ftAutolinkDocumentsLocal, 'autolink_doc_local', '���������������� - ��������� ���������', FillFamilyAutolinkDoc);
 f_Tables[da_ftAutolinkEditionsLocal] := MakeTableDescription(da_ftAutolinkEditionsLocal, 'autolink_editions_local', '���������������� - ��������� ��������', FillFamilyAutolinkEdition);
 f_Tables[da_ftAutolinkDocumentsRemote] := MakeTableDescription(da_ftAutolinkDocumentsRemote, 'autolink_doc_remote', '���������������� - ������� ���������', FillFamilyAutolinkDoc);
 f_Tables[da_ftAutolinkEditionsRemote] := MakeTableDescription(da_ftAutolinkEditionsRemote, 'autolink_editions_remote', '���������������� - ������� ��������', FillFamilyAutolinkEdition);
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
   l_Table.AddField(TdaFieldDescription.Make('Parentid', 'ID ��������', False, da_dtQWord));
   l_Table.AddField(TdaFieldDescription.Make('Ordernum', '������� ����������', False, da_dtQWord));
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
 aTable.AddField(TdaFieldDescription.Make('User_Gr', 'ID ������ �������������', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('FamilyID', 'ID ���������', True, da_dtWord));           //
 aTable.AddField(TdaFieldDescription.Make('Docum_Gr', 'ID ������ ������� ���������', True, da_dtQWord));  //
 aTable.AddField(TdaFieldDescription.Make('Mask', '����� ����', True, da_dtQWord));
//#UC END# *5539EFC3037B_552D07EB03CB_impl*
end;//TdaScheme.FillMainAccess

procedure TdaScheme.FillMainPassword(aTable: TdaTableDescription);
//#UC START# *5539FF9001C0_552D07EB03CB_var*
//#UC END# *5539FF9001C0_552D07EB03CB_var*
begin
//#UC START# *5539FF9001C0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ShortName', '�����', True, da_dtChar, 15)); //
 aTable.AddField(TdaFieldDescription.Make('Password', '������', True, da_dtChar, 10));
 aTable.AddField(TdaFieldDescription.Make('User_ID', 'ID ������������', True, da_dtQWord)); // AK
//#UC END# *5539FF9001C0_552D07EB03CB_impl*
end;//TdaScheme.FillMainPassword

procedure TdaScheme.FillMainUsers(aTable: TdaTableDescription);
//#UC START# *5539FFA400F0_552D07EB03CB_var*
//#UC END# *5539FFA400F0_552D07EB03CB_var*
begin
//#UC START# *5539FFA400F0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('id', 'ID ������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('user_name', '���', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('name_length', '����� ���', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('active', '����� (����������, �����������)', True, da_dtByte)); 
//#UC END# *5539FFA400F0_552D07EB03CB_impl*
end;//TdaScheme.FillMainUsers

procedure TdaScheme.FillMainGroups(aTable: TdaTableDescription);
//#UC START# *5539FFBC0157_552D07EB03CB_var*
//#UC END# *5539FFBC0157_552D07EB03CB_var*
begin
//#UC START# *5539FFBC0157_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('id', 'ID ������', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('group_name', '��������', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('name_length', '����� ��������', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('import_priority', '��������� �������', True, da_dtInteger));
 aTable.AddField(TdaFieldDescription.Make('export_priority', '��������� ��������', True, da_dtInteger));
//#UC END# *5539FFBC0157_552D07EB03CB_impl*
end;//TdaScheme.FillMainGroups

procedure TdaScheme.FillMainGroupMembers(aTable: TdaTableDescription);
//#UC START# *5539FFDC022E_552D07EB03CB_var*
//#UC END# *5539FFDC022E_552D07EB03CB_var*
begin
//#UC START# *5539FFDC022E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('user_id', 'ID ������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('group_id', 'ID ������', True, da_dtWord)); //
//#UC END# *5539FFDC022E_552D07EB03CB_impl*
end;//TdaScheme.FillMainGroupMembers

procedure TdaScheme.FillMainFamily(aTable: TdaTableDescription);
//#UC START# *5539FFFB0143_552D07EB03CB_var*
//#UC END# *5539FFFB0143_552D07EB03CB_var*
begin
//#UC START# *5539FFFB0143_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ���������', True, da_dtWord)); //
 aTable.AddField(TdaFieldDescription.Make('FamilyName', '��������', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Doc_Group', '???', True, da_dtWord));
 aTable.AddField(TdaFieldDescription.Make('PathToTbl', '���� �� ����� (HT)', True, da_dtChar, 128));
 aTable.AddField(TdaFieldDescription.Make('Attributes', '???', True, da_dtQWord));
//#UC END# *5539FFFB0143_552D07EB03CB_impl*
end;//TdaScheme.FillMainFamily

procedure TdaScheme.FillMainFree(aTable: TdaTableDescription);
//#UC START# *553A000C0379_552D07EB03CB_var*
//#UC END# *553A000C0379_552D07EB03CB_var*
begin
//#UC START# *553A000C0379_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('table_name', '��� ������� (HT)', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('start_num', '������ ���������� ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('last_num', '����� ���������', True, da_dtQWord));
//#UC END# *553A000C0379_552D07EB03CB_impl*
end;//TdaScheme.FillMainFree

procedure TdaScheme.FillMainJournal(aTable: TdaTableDescription);
//#UC START# *553A0020004E_552D07EB03CB_var*
//#UC END# *553A0020004E_552D07EB03CB_var*
begin
//#UC START# *553A0020004E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('session_id', 'ID ������', True, da_dtQWord)); // ����������� ��� ���������� ����� �� ������� � ��������� ������������ � �������
 aTable.AddField(TdaFieldDescription.Make('operation_id', 'ID ��������', True, da_dtWord)); // ��������� ������� ��. TBBOperation
 aTable.AddField(TdaFieldDescription.Make('family_id', 'ID ���������', True, da_dtWord)); // 0 = null
 aTable.AddField(TdaFieldDescription.Make('ext_id', 'ID ����-��', True, da_dtQWord)); // 0 = null ������� �� �������� - ��� �������� ��� ������������
 aTable.AddField(TdaFieldDescription.Make('date', '����', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('time', '�����', True, da_dtTime));
 aTable.AddField(TdaFieldDescription.Make('additional', '���. ����������', True, da_dtQWord)); // 0 = null ������� �� �������� - ��. TBBOperation
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
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID �������', True, da_dtByte));
 aTable.AddField(TdaFieldDescription.Make('Name', '��������', True, da_dtChar, 50));
//#UC END# *553A00440110_552D07EB03CB_impl*
end;//TdaScheme.FillMainRegions

procedure TdaScheme.FillFamilyDocuments(aTable: TdaTableDescription);
//#UC START# *553DE6E1033B_552D07EB03CB_var*
//#UC END# *553DE6E1033B_552D07EB03CB_var*
begin
//#UC START# *553DE6E1033B_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('ShortName', '������� ��������', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('FullName', '������ ��������', True, da_dtChar, 1000));
 aTable.AddField(TdaFieldDescription.Make('Status', '����� �������', True, da_dtWord)); // ��. dstatXXX � dt_Const
 aTable.AddField(TdaFieldDescription.Make('Priority', '���������', True, da_dtWord)); // �������������� �� da_ftPriority � ����������� �� ��������� ������� � ����� (�������� �����������)
 aTable.AddField(TdaFieldDescription.Make('SortDate', '���� ��� ����������', True, da_dtDate)); // �������������� �� da_ftDocDateCodes (�������� �����������)
 aTable.AddField(TdaFieldDescription.Make('Typ', 'ID ����������� ����', True, da_dtByte)); // ��������� ������� ��. TDocType � dt_Types
 aTable.AddField(TdaFieldDescription.Make('Flag', 'ID ����������������� ����', True, da_dtByte)); // ��������� ������� ��. TUserType � dt_Types
 aTable.AddField(TdaFieldDescription.Make('Related', 'ID ������� � ���������', True, da_dtQWord)); // ��� �� ����
 aTable.AddField(TdaFieldDescription.Make('PaperUser', '��������� ������� ����� - ������', True, da_dtWord)); // ������!!!
 aTable.AddField(TdaFieldDescription.Make('PaperPlace', '����� �������� ������� ����� - ������', True, da_dtChar, 100)); // ������!!!
 aTable.AddField(TdaFieldDescription.Make('PriorFlag', '������ ��������� ����������', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('StageMask', '??? - ������', True, da_dtWord)); // ������
 aTable.AddField(TdaFieldDescription.Make('VerLink', 'ID ���������� ��������', True, da_dtQWord)); // ��� �� ����
 aTable.AddField(TdaFieldDescription.Make('HasAnno', '���� �� ���������', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('Urgency', 'ID ���������', True, da_dtByte)); // ������ ��������� ������� ��. cUrgencyCaption � dt_Doc
 aTable.AddField(TdaFieldDescription.Make('Comment', '�����������', True, da_dtChar, 100));
//#UC END# *553DE6E1033B_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocuments

procedure TdaScheme.FillFamilyHyperlinks(aTable: TdaTableDescription);
//#UC START# *553DE7080233_552D07EB03CB_var*
//#UC END# *553DE7080233_552D07EB03CB_var*
begin
//#UC START# *553DE7080233_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SourDoc', 'ID ��������� � ������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('DestDoc', 'ID �������� ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSubs
 aTable.AddField(TdaFieldDescription.Make('DestSub', 'ID �������� ����', True, da_dtQWord)); // // ����� ������ �� da_ftSubs
//#UC END# *553DE7080233_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyHyperlinks

procedure TdaScheme.FillFamilySubs(aTable: TdaTableDescription);
//#UC START# *553DE72B011F_552D07EB03CB_var*
//#UC END# *553DE72B011F_552D07EB03CB_var*
begin
//#UC START# *553DE72B011F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SubID', 'ID ����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RealFlag', '������ ������� �����', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('SubName', '��������', True, da_dtChar, 800));
//#UC END# *553DE72B011F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilySubs

procedure TdaScheme.FillFamilyFree(aTable: TdaTableDescription);
//#UC START# *553DE749014E_552D07EB03CB_var*
//#UC END# *553DE749014E_552D07EB03CB_var*
begin
//#UC START# *553DE749014E_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('table_name', '��� ������� (HT)', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('start_num', '������ ���������� ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('last_num', '����� ���������', True, da_dtQWord));
//#UC END# *553DE749014E_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyFree

procedure TdaScheme.FillFamilySources(aTable: TdaTableDescription);
//#UC START# *553DE77003DF_552D07EB03CB_var*
//#UC END# *553DE77003DF_552D07EB03CB_var*
begin
//#UC START# *553DE77003DF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ���������� ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('ShortName', '������� ��������', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('Sinonims', '��������', True, da_dtChar, 800));
//#UC END# *553DE77003DF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilySources

procedure TdaScheme.FillFamilyTypes(aTable: TdaTableDescription);
//#UC START# *553DE7850036_552D07EB03CB_var*
//#UC END# *553DE7850036_552D07EB03CB_var*
begin
//#UC START# *553DE7850036_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE7850036_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyTypes

procedure TdaScheme.FillFamilyClasses(aTable: TdaTableDescription);
//#UC START# *553DE79F0210_552D07EB03CB_var*
//#UC END# *553DE79F0210_552D07EB03CB_var*
begin
//#UC START# *553DE79F0210_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE79F0210_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyClasses

procedure TdaScheme.FillFamilyKeywords(aTable: TdaTableDescription);
//#UC START# *553DE7B101D5_552D07EB03CB_var*
//#UC END# *553DE7B101D5_552D07EB03CB_var*
begin
//#UC START# *553DE7B101D5_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ��������� �����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE7B101D5_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyKeywords

procedure TdaScheme.FillFamilyBelongs(aTable: TdaTableDescription);
//#UC START# *553DE7C8025D_552D07EB03CB_var*
//#UC END# *553DE7C8025D_552D07EB03CB_var*
begin
//#UC START# *553DE7C8025D_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('ShName', '������� ��������', True, da_dtChar, 10));
//#UC END# *553DE7C8025D_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyBelongs

procedure TdaScheme.FillFamilyDateCodes(aTable: TdaTableDescription);
//#UC START# *553DE7E401C4_552D07EB03CB_var*
//#UC END# *553DE7E401C4_552D07EB03CB_var*
begin
//#UC START# *553DE7E401C4_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������ � ����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Date', '����', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('No', '�����', True, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Tip', 'ID ���� ����������', True, da_dtByte)); // ��������� ������� ��. TDNType � dt_Types
 aTable.AddField(TdaFieldDescription.Make('LDocID', 'ID ��������� ��������� ���������', True, da_dtQWord)); // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('LSubID', 'ID ���� ��������� ���������', True, da_dtQWord)); // ����� ������ �� da_ftSub
//#UC END# *553DE7E401C4_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDateCodes

procedure TdaScheme.FillFamilyWarnings(aTable: TdaTableDescription);
//#UC START# *553DE8070027_552D07EB03CB_var*
//#UC END# *553DE8070027_552D07EB03CB_var*
begin
//#UC START# *553DE8070027_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ��������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 1000));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 1000));
//#UC END# *553DE8070027_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyWarnings

procedure TdaScheme.FillFamilyCorrections(aTable: TdaTableDescription);
//#UC START# *553DE8170107_552D07EB03CB_var*
//#UC END# *553DE8170107_552D07EB03CB_var*
begin
//#UC START# *553DE8170107_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID �������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Date', '���� �������', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Source', 'ID ��������� ������������� ���������� ���������', True, da_dtQWord)); // !!! ��������� ������ �� ��������� �������������, ������� ������ ��� ��������� !!!
 aTable.AddField(TdaFieldDescription.Make('Type', 'ID ���� �������', True, da_dtByte)); // ������ ��������� ������� (D_SrcChk) = 0 - ��������, 1 - ���������
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID ������������-����������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Coment', '�����������', True, da_dtChar, 70));
//#UC END# *553DE8170107_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyCorrections

procedure TdaScheme.FillFamilyCoSources(aTable: TdaTableDescription);
//#UC START# *553DE82E0028_552D07EB03CB_var*
//#UC END# *553DE82E0028_552D07EB03CB_var*
begin
//#UC START# *553DE82E0028_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID �������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('ShName', '������� ��������', False, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('Private', '�� �������� �������������', True, da_dtBoolean));
 aTable.AddField(TdaFieldDescription.Make('NonPeriod', '�� �������������', True, da_dtBoolean));
//#UC END# *553DE82E0028_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyCoSources

procedure TdaScheme.FillFamilyPublishedIn(aTable: TdaTableDescription);
//#UC START# *553DE83D011A_552D07EB03CB_var*
//#UC END# *553DE83D011A_552D07EB03CB_var*
begin
//#UC START# *553DE83D011A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ��������� �������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Source', 'ID �������', True, da_dtQWord)); // AK
 aTable.AddField(TdaFieldDescription.Make('StartDate', '������ �������', True, da_dtQWord)); // AK // ����������� ������ = 1.�� �� 31.��
 aTable.AddField(TdaFieldDescription.Make('EndDate', '����� �������', True, da_dtQWord)); // AK // ���������� = xx.yy �� xx.yy
 aTable.AddField(TdaFieldDescription.Make('Number', '�����', True, da_dtChar, 30)); // AK
 aTable.AddField(TdaFieldDescription.Make('Coment', 'Name', True, da_dtChar, 70));
//#UC END# *553DE83D011A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPublishedIn

procedure TdaScheme.FillFamilyPrefixes(aTable: TdaTableDescription);
//#UC START# *553DE862036A_552D07EB03CB_var*
//#UC END# *553DE862036A_552D07EB03CB_var*
begin
//#UC START# *553DE862036A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ���� ����������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE862036A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPrefixes

procedure TdaScheme.FillFamilyTerritories(aTable: TdaTableDescription);
//#UC START# *553DE875037C_552D07EB03CB_var*
//#UC END# *553DE875037C_552D07EB03CB_var*
begin
//#UC START# *553DE875037C_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ����������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE875037C_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyTerritories

procedure TdaScheme.FillFamilyNorms(aTable: TdaTableDescription);
//#UC START# *553DE88902FF_552D07EB03CB_var*
//#UC END# *553DE88902FF_552D07EB03CB_var*
begin
//#UC START# *553DE88902FF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ����� �����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE88902FF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyNorms

procedure TdaScheme.FillFamilyExtClasses(aTable: TdaTableDescription);
//#UC START# *553DE89701FF_552D07EB03CB_var*
//#UC END# *553DE89701FF_552D07EB03CB_var*
begin
//#UC START# *553DE89701FF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('FirstID', 'ID ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('SecondID', 'ID �����������', True, da_dtQWord)); // // ������ FirstID ������������ SecondID, �� �� ��������
//#UC END# *553DE89701FF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyExtClasses

procedure TdaScheme.FillFamilyAccessGroups(aTable: TdaTableDescription);
//#UC START# *553DE8C3038F_552D07EB03CB_var*
//#UC END# *553DE8C3038F_552D07EB03CB_var*
begin
//#UC START# *553DE8C3038F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������ �������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 70));
 aTable.AddField(TdaFieldDescription.Make('ShName', '������� ��������', True, da_dtChar, 10));
//#UC END# *553DE8C3038F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAccessGroups

procedure TdaScheme.FillFamilyAnnoClasses(aTable: TdaTableDescription);
//#UC START# *553DE8D60075_552D07EB03CB_var*
//#UC END# *553DE8D60075_552D07EB03CB_var*
begin
//#UC START# *553DE8D60075_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ������ ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 200));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 200));
//#UC END# *553DE8D60075_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAnnoClasses

procedure TdaScheme.FillFamilyServiceInfo(aTable: TdaTableDescription);
//#UC START# *553DE8FE01AD_552D07EB03CB_var*
//#UC END# *553DE8FE01AD_552D07EB03CB_var*
begin
//#UC START# *553DE8FE01AD_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('ID', 'ID ���� ���������� ����������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('NameR', '��������', True, da_dtChar, 100));
 aTable.AddField(TdaFieldDescription.Make('NameE', 'Name', True, da_dtChar, 100));
//#UC END# *553DE8FE01AD_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyServiceInfo

procedure TdaScheme.FillFamilyDocSources(aTable: TdaTableDescription);
//#UC START# *553F2E94021D_552D07EB03CB_var*
//#UC END# *553F2E94021D_552D07EB03CB_var*
begin
//#UC START# *553F2E94021D_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ���������� ������', True, da_dtQWord)); //
//#UC END# *553F2E94021D_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocSources

procedure TdaScheme.FillFamilyDocTypes(aTable: TdaTableDescription);
//#UC START# *553F2EE802EF_552D07EB03CB_var*
//#UC END# *553F2EE802EF_552D07EB03CB_var*
begin
//#UC START# *553F2EE802EF_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID ����', True, da_dtQWord)); // // ����� ������ �� da_ftSub - �� Sub = 0 ��� ���� �������� � ��� ��� � da_ftSub!!!
//#UC END# *553F2EE802EF_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocTypes

procedure TdaScheme.FillFamilyDocClasses(aTable: TdaTableDescription);
//#UC START# *553F2F0D0100_552D07EB03CB_var*
//#UC END# *553F2F0D0100_552D07EB03CB_var*
begin
//#UC START# *553F2F0D0100_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID ����', True, da_dtQWord)); // // ����� ������ �� da_ftSub - �� Sub = 0 ��� ���� �������� � ��� ��� � da_ftSub!!!
//#UC END# *553F2F0D0100_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocClasses

procedure TdaScheme.FillFamilyDocKeywords(aTable: TdaTableDescription);
//#UC START# *553F2F34011F_552D07EB03CB_var*
//#UC END# *553F2F34011F_552D07EB03CB_var*
begin
//#UC START# *553F2F34011F_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ��������� �����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID ����', True, da_dtQWord)); // // ����� ������ �� da_ftSub - �� Sub = 0 ��� ���� �������� � ��� ��� � da_ftSub!!!
//#UC END# *553F2F34011F_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocKeywords

procedure TdaScheme.FillFamilyDocBelongs(aTable: TdaTableDescription);
//#UC START# *553F2F5E0169_552D07EB03CB_var*
//#UC END# *553F2F5E0169_552D07EB03CB_var*
begin
//#UC START# *553F2F5E0169_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ������', True, da_dtQWord)); //
//#UC END# *553F2F5E0169_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocBelongs

procedure TdaScheme.FillFamilyDocDateCodes(aTable: TdaTableDescription);
//#UC START# *553F2F8300A1_552D07EB03CB_var*
//#UC END# *553F2F8300A1_552D07EB03CB_var*
begin
//#UC START# *553F2F8300A1_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ����������', True, da_dtQWord)); //
//#UC END# *553F2F8300A1_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocDateCodes

procedure TdaScheme.FillFamilyDocWarnings(aTable: TdaTableDescription);
//#UC START# *553F2FA00207_552D07EB03CB_var*
//#UC END# *553F2FA00207_552D07EB03CB_var*
begin
//#UC START# *553F2FA00207_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ��������������', True, da_dtQWord)); //
//#UC END# *553F2FA00207_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocWarnings

procedure TdaScheme.FillFamilyDocCorrections(aTable: TdaTableDescription);
//#UC START# *553F2FC40156_552D07EB03CB_var*
//#UC END# *553F2FC40156_552D07EB03CB_var*
begin
//#UC START# *553F2FC40156_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID �������', True, da_dtQWord)); //
//#UC END# *553F2FC40156_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocCorrections

procedure TdaScheme.FillFamilyDocPublishedIn(aTable: TdaTableDescription);
//#UC START# *553F2FE300DC_552D07EB03CB_var*
//#UC END# *553F2FE300DC_552D07EB03CB_var*
begin
//#UC START# *553F2FE300DC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ��������� �������������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Pages', '��������', True, da_dtChar, 128));
 aTable.AddField(TdaFieldDescription.Make('Coment', '�����������', True, da_dtChar, 255));
 aTable.AddField(TdaFieldDescription.Make('Flags', '�����', True, da_dtByte)); // �� pinfClone � ��. � dt_Const
//#UC END# *553F2FE300DC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocPublishedIn

procedure TdaScheme.FillFamilyDocPrefixes(aTable: TdaTableDescription);
//#UC START# *553F300C00A1_552D07EB03CB_var*
//#UC END# *553F300C00A1_552D07EB03CB_var*
begin
//#UC START# *553F300C00A1_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ���� ����������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID ����', True, da_dtQWord)); // // ����� ������ �� da_ftSub - �� Sub = 0 ��� ���� �������� � ��� ��� � da_ftSub!!!
//#UC END# *553F300C00A1_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocPrefixes

procedure TdaScheme.FillFamilyDocTerritories(aTable: TdaTableDescription);
//#UC START# *553F302E0091_552D07EB03CB_var*
//#UC END# *553F302E0091_552D07EB03CB_var*
begin
//#UC START# *553F302E0091_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ����������', True, da_dtQWord)); //
//#UC END# *553F302E0091_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocTerritories

procedure TdaScheme.FillFamilyDocNorms(aTable: TdaTableDescription);
//#UC START# *553F304E00E0_552D07EB03CB_var*
//#UC END# *553F304E00E0_552D07EB03CB_var*
begin
//#UC START# *553F304E00E0_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ����� �����', True, da_dtQWord)); //
//#UC END# *553F304E00E0_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocNorms

procedure TdaScheme.FillFamilyDocAccessGroups(aTable: TdaTableDescription);
//#UC START# *553F306E01DA_552D07EB03CB_var*
//#UC END# *553F306E01DA_552D07EB03CB_var*
begin
//#UC START# *553F306E01DA_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ������ �������', True, da_dtQWord)); //
//#UC END# *553F306E01DA_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocAccessGroups

procedure TdaScheme.FillFamilyDocAnnoClasses(aTable: TdaTableDescription);
//#UC START# *553F308901D3_552D07EB03CB_var*
//#UC END# *553F308901D3_552D07EB03CB_var*
begin
//#UC START# *553F308901D3_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ������ ���������', True, da_dtQWord)); //
//#UC END# *553F308901D3_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocAnnoClasses

procedure TdaScheme.FillFamilyDocServiceInfo(aTable: TdaTableDescription);
//#UC START# *553F30A901C5_552D07EB03CB_var*
//#UC END# *553F30A901C5_552D07EB03CB_var*
begin
//#UC START# *553F30A901C5_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); // // ����� ������ �� da_ftSub
 aTable.AddField(TdaFieldDescription.Make('Dict_ID', 'ID ���� ���������� ����������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Sub_ID', 'ID ����', True, da_dtQWord)); // // ����� ������ �� da_ftSub - �� Sub = 0 ��� ���� �������� � ��� ��� � da_ftSub!!!
//#UC END# *553F30A901C5_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocServiceInfo

procedure TdaScheme.FillFamilyDoc2DocLink(aTable: TdaTableDescription);
//#UC START# *553F30C7024A_552D07EB03CB_var*
//#UC END# *553F30C7024A_552D07EB03CB_var*
begin
//#UC START# *553F30C7024A_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Doc_ID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('LinkType', 'ID ���� �����', True, da_dtByte)); // // ������ ��������� ������� (D_Doc2DocLinkEdit) 0-�������� �������, 1-�������� ������� ����
 aTable.AddField(TdaFieldDescription.Make('LinkDocID', 'ID ��������� �����', True, da_dtQWord)); //
//#UC END# *553F30C7024A_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDoc2DocLink

procedure TdaScheme.FillFamilyPriority(aTable: TdaTableDescription);
//#UC START# *553F30E70209_552D07EB03CB_var*
//#UC END# *553F30E70209_552D07EB03CB_var*
begin
//#UC START# *553F30E70209_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('Sour_ID', 'ID ���������� ������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Type_ID', 'ID ����', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Priority', '���������', True, da_dtWord));
//#UC END# *553F30E70209_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyPriority

procedure TdaScheme.FillFamilyRenum(aTable: TdaTableDescription);
//#UC START# *553F310900AC_552D07EB03CB_var*
//#UC END# *553F310900AC_552D07EB03CB_var*
begin
//#UC START# *553F310900AC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('RealID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('ImportID', '������� ID ���������', True, da_dtQWord)); // AK
//#UC END# *553F310900AC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyRenum

procedure TdaScheme.FillFamilyDocStages(aTable: TdaTableDescription);
//#UC START# *553F312A001C_552D07EB03CB_var*
//#UC END# *553F312A001C_552D07EB03CB_var*
begin
//#UC START# *553F312A001C_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Type', 'ID ���� �����', True, da_dtByte)); // // ��. TStageType � dt_Types
 aTable.AddField(TdaFieldDescription.Make('B_Date', '���� ������', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('E_Date', '���� ���������', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID ������������', True, da_dtQWord));
//#UC END# *553F312A001C_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocStages

procedure TdaScheme.FillFamilyDocLog(aTable: TdaTableDescription);
//#UC START# *553F315000CD_552D07EB03CB_var*
//#UC END# *553F315000CD_552D07EB03CB_var*
begin
//#UC START# *553F315000CD_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('Action', 'ID ��������', True, da_dtByte)); // ��������� ������� ��. TLogActionType � dt_Types
 aTable.AddField(TdaFieldDescription.Make('Date', '����', True, da_dtDate)); //
 aTable.AddField(TdaFieldDescription.Make('Time', '�����', True, da_dtTime)); //
 aTable.AddField(TdaFieldDescription.Make('ActionFlag', '', True, da_dtByte)); // ��������� ������� ��. TLogActionFlags � dt_Types
 aTable.AddField(TdaFieldDescription.Make('Station', '������� HT', True, da_dtChar, 8));
 aTable.AddField(TdaFieldDescription.Make('UserID', 'ID ������������', True, da_dtQWord)); 
//#UC END# *553F315000CD_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocLog

procedure TdaScheme.FillFamilyDocActivity(aTable: TdaTableDescription);
//#UC START# *553F316B01AC_552D07EB03CB_var*
//#UC END# *553F316B01AC_552D07EB03CB_var*
begin
//#UC START# *553F316B01AC_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RecID', '���������� �����', True, da_dtByte)); // // �������� � ������ DocID
 aTable.AddField(TdaFieldDescription.Make('Typ', 'ID ����', True, da_dtByte)); // ������ ��������� ������� 1-������ �������������, 0-�����
 aTable.AddField(TdaFieldDescription.Make('Start', '���� ������ (�)', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Finish', '���� ��������� (��)', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Comment', '�����������', True, da_dtChar, 1000));
//#UC END# *553F316B01AC_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyDocActivity

procedure TdaScheme.FillFamilyDocAlarm(aTable: TdaTableDescription);
//#UC START# *553F318A0380_552D07EB03CB_var*
//#UC END# *553F318A0380_552D07EB03CB_var*
begin
//#UC START# *553F318A0380_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('DocID', 'ID ���������', True, da_dtQWord)); //
 aTable.AddField(TdaFieldDescription.Make('RecID', '���������� �����', True, da_dtByte)); // // �������� � ������ DocID
 aTable.AddField(TdaFieldDescription.Make('Start', '����', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Comment', '�����������', True, da_dtChar, 1000));
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
 aTable.AddField(TdaFieldDescription.Make('ExtDocID', '������� ID ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('IntDocID', '���������� ID ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('DType', '��� ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Source', '��������� �����', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Date', '���� �������������', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Num', '����� �������������', False, da_dtChar, 50));
 aTable.AddField(TdaFieldDescription.Make('LawCase', '����� ��������� ����', False, da_dtChar, 50));
//#UC END# *569F44020026_552D07EB03CB_impl*
end;//TdaScheme.FillFamilyAutolinkDoc

procedure TdaScheme.FillFamilyAutolinkEdition(aTable: TdaTableDescription);
//#UC START# *569F444D0185_552D07EB03CB_var*
//#UC END# *569F444D0185_552D07EB03CB_var*
begin
//#UC START# *569F444D0185_552D07EB03CB_impl*
 aTable.AddField(TdaFieldDescription.Make('MDocID', '������� ID ���������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('IntDocID', '���������� ID ��������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('ExtDocID', '������� ID ��������', True, da_dtQWord));
 aTable.AddField(TdaFieldDescription.Make('Start', '���� ������ ��������', True, da_dtDate));
 aTable.AddField(TdaFieldDescription.Make('Finish', '���� ��������� ��������', True, da_dtDate));
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
 {* ����� ��������� ���������� ���������� TdaScheme }
begin
 if (g_TdaScheme = nil) then
 begin
  l3System.AddExitProc(TdaSchemeFree);
  g_TdaScheme := Create;
 end;
 Result := g_TdaScheme;
end;//TdaScheme.Instance

class function TdaScheme.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TdaScheme <> nil;
end;//TdaScheme.Exists

procedure TdaScheme.Cleanup;
 {* ������� ������� ����� �������. }
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
