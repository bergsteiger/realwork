unit dt_DictConst;

interface
Uses
 dt_Types, l3TreeInterfaces;

const
  cUndefDictID  = High(TDictID);
  cUndefDictIDByte = High(Byte);

{Common ID field}
  dtIDFld      = 1;

{Standart _Dictionary fields}
  dtNameFld   = 2;
  dtNameRFld   = 2;
  dtNameEFld   = 3;
  dtShNameFld  = 4;
  dtIsPrivate  = 5;
  dtIsNonperiodic = 6;

{Source Dict aditional field}
  dtSinonimsFld = 5;

{Journal Dict aditional field}
  dtOperationFld = 4;
  dtNewIDFld     = 5;
  dtCommentFld   = 6;

{Date & Number diction}
  dnIDFld      = 1;
  dnDateFld    = 2;
  dnNumFld     = 3;
  dnTypFld     = 4;
  dnLinkDocIDFld = 5;
  dnLinkSubIDFld = 6;

{Correction diction}
  crIDFld      = 1;
  crDateFld    = 2;
  crPSourFld   = 3;
  crTypFld     = 4;
  crAuthorFld  = 5;
  crCommentFld = 6;

{CorSources fields}
  csID_fld          = 1;
  csNameR_fld       = 2;
  csNameE_fld       = 3;
  csShName_fld      = 4;
  csPrivate_fld     = 5;
  csNonPeriodic_fld = 6;

{PublishedIn diction}
  piIDFld      = 1;
  piSourFld    = 2;
  piSDateFld   = 3;
  piEDateFld   = 4;
  piNumberFld  = 5;
  piCommentFld = 6;
  piUniqKeyNum = 7;

  gLinesLevelSlash = #13;

{Suffix Tree branch Name}
  SuffixBranch = 'Суффиксы';

{Журнал изменений словарей}
  DictJourName = 'DictLog.dt';
  FamilySectionPref = 'Family';
  DictChangePref = 'Dict';

  gDictChangesDir = 'DictChng';

{Константы для древовидного представления}
  TreeCashSize = 48*1024;
  BrokenLeaf = '* Потерянный элемент *';

{Константы флагов для работы с EqualNodes}
  cNodeHasEquals = nfUserDefined2;
  cEqualNode     = nfUserDefined1;

{Константы длин полей}
  cPublInNumLen = 30;

  cSourceNameLen      = 200;
  cSourceShortNameLen = 70;
  cSourceSynonimsLen  = 800;

const
 DictChangeFileName: String = 'DictChanges.dat';


implementation

end.
