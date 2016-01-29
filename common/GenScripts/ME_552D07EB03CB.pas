unit daScheme;

interface

uses
 l3IntfUses
 , l3ProtoObject
 , daInterfaces
 , daTypes
 , daTableDescription
;

type
 TFamilyDescriptions = array [TdaTables] of IdaTableDescription;
 
 TdaFillTableDescriptionProc = procedure(aTable: TdaTableDescription) of object;
 
 TdaScheme = class(Tl3ProtoObject)
  procedure BuildScheme;
  procedure BuildMain;
  procedure BuildFamily;
  function MakeTableDescription(aKind: TdaTables;
   const aCode: AnsiString;
   const aName: AnsiString;
   const aDescription: AnsiString;
   aProc: TdaFillTableDescriptionProc;
   const aScheme: AnsiString;
   aDublicate: Boolean;
   aFake: Boolean): IdaTableDescription;
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
  function CheckScheme(const aSchemeName: AnsiString): AnsiString;
  function Table(aTableKind: TdaTables): IdaTableDescription;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TdaScheme
 
implementation

uses
 l3ImplUses
 , SysUtils
 , daFieldDescription
;

end.
