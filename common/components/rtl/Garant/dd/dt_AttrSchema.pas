unit dt_AttrSchema;
{ $Id: dt_AttrSchema.pas,v 1.31 2015/11/30 11:31:03 lukyanets Exp $ }

// $Log: dt_AttrSchema.pas,v $
// Revision 1.31  2015/11/30 11:31:03  lukyanets
// ����������� ������� ����������
//
// Revision 1.30  2015/10/13 12:55:55  fireton
// - ��������� ExportPipe �� ����� filer dispatcher
//
// Revision 1.29  2015/07/02 11:41:28  lukyanets
// ��������� �������
//
// Revision 1.28  2015/07/02 07:36:05  lukyanets
// ��������� �������
//
// Revision 1.27  2015/04/30 11:52:28  voba
// - k:597356978
//
// Revision 1.26  2015/04/29 09:09:37  voba
// - k:597356978
//
// Revision 1.25  2015/04/17 13:39:33  lukyanets
// ��������� ��������� �������
//
// Revision 1.24  2015/04/17 11:21:48  lukyanets
// ��������� ��������� �������
//
// Revision 1.23  2014/11/25 14:14:44  voba
// -bug fix  ����������� VerLink �� ������������
//
// Revision 1.22  2014/07/01 10:40:43  voba
//  k:236721575 (�������� � EVD)
//
// Revision 1.21  2014/06/18 16:55:18  voba
// - bugfix �������� ����-���
//
// Revision 1.20  2013/04/11 16:46:29  lulin
// - ���������� ��� XE3.
//
// Revision 1.19  2013/02/01 09:47:27  fireton
// - "��������" -> "��� ����������"
//
// Revision 1.18  2013/01/28 09:20:46  fireton
// - "��������" -> "��� ����������"
//
// Revision 1.17  2012/11/30 14:59:06  voba
// - add function DocIDField
//
// Revision 1.16  2012/04/23 08:54:58  narry
// ������� ���-������� � ��������
//
// Revision 1.15  2012/03/27 09:04:20  voba
// - k : 344753123
//
// Revision 1.14  2012/03/06 13:00:31  fireton
// - ������� � ������ B_archi_base132
//
// Revision 1.13.6.2  2012/02/16 11:13:58  fireton
// - ������ ����� ���� � �������
//
// Revision 1.13.6.1  2012/02/13 06:24:10  fireton
// - ��������� Flags � ���������� ������������� ���������
//
// Revision 1.13  2011/10/03 08:29:26  voba
// - k : 281525254
//
// Revision 1.12  2011/06/29 16:02:54  fireton
// - ��� ����������� ������������� ID �������� ������� ��� ��������
//
// Revision 1.11  2011/06/20 09:33:16  voba
// - k : 236721575
//
// Revision 1.10  2011/06/10 12:49:48  voba
// - k : 236721575
//
// Revision 1.9  2011/06/06 15:25:35  voba
// - k : 236721575
//
// Revision 1.8  2011/06/01 07:34:47  voba
// - k : 236721575
//
// Revision 1.7  2010/12/28 10:04:45  voba
// [k:249331906]
//
// Revision 1.6  2010/11/12 08:51:54  voba
// - K : 236721575
//
// Revision 1.5  2010/10/20 10:06:38  voba
// - K : 236720571
//
// Revision 1.4  2010/10/13 09:03:34  voba
// - k:235865224
//
// Revision 1.3  2010/09/29 12:26:29  voba
// - k : 235046326
//
// Revision 1.2  2010/09/28 13:04:33  voba
// - k : 235046326
//
// Revision 1.1  2010/09/24 17:04:45  lulin
// - bug fix: �� ���������� �����.
//
// Revision 1.1  2010/09/24 16:13:58  voba
// [$235058492].
//

{$I DtDefine.inc}
interface
 uses
  k2Tags,
  l3Date,
  dt_Types,
  daTypes;

//# �������
 type
  TDLTypeSet      = Set of TdaDictionaryType;

  // TDLPassport
  TAttrClass  = ( atcDict,    // ��������� �������
                  atcDepDict, // ��������� ������� ���������� �������
                  atcSingle,  //����������� ������ (���������������� - �������+�����)
                  atcRecord   //����������� ������ (���������������� - ������� ��� ������)
               );

  TDLPassportRec  = record
   rClass : TAttrClass;
   rDict  : TFamTbls;
   rLink  : TFamTbls;
   rDepDictID : TdaDictionaryType; // ��������� �������
   rDepFldOfs : Integer; // �������� ����-������ � ������, ����� ����-������ ���������� ������ DWORD
   rDefValue : TDictID; // �������� ��-��������� ��� �������, -1 ���� �������� �� �������� ���
   rName : AnsiString;
  end;

 const
  sUsualDicts      = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords,
                      da_dlBases, da_dlWarnings, da_dlCorSources, da_dlPrefixes,
                      da_dlTerritories, da_dlNorms, da_dlAccGroups,
                      da_dlAnnoClasses, da_dlServiceInfo];

  sSubLinkDicts    = [da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlPrefixes, da_dlServiceInfo];
  sUnsortedDicts   = [da_dlBases, da_dlAccGroups];
  sWithShortName   = [da_dlSources, da_dlBases, da_dlAccGroups, da_dlCorSources];
  sWithIsPrivateField  = [da_dlCorSources];
  sWithNonperiodicField = [da_dlCorSources];
  sNotExportedNames = [da_dlDateNums, da_dlCorrects, da_dlPublisheds];
  sDoNotGetNames   = [da_dlDateNums, da_dlCorrects, da_dlPublisheds];
  sWithEquals      = [da_dlClasses, da_dlKeyWords];
  sJournaled       = [];//
  sTreeDictsForImpEx = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases, da_dlAnnoClasses, da_dlServiceInfo,
                        da_dlCorSources, da_dlPrefixes, da_dlTerritories, da_dlAccGroups];

  sUsualDictsForImpEx = sUsualDicts{ - [da_dlNewClasses_Deprecated]};
   // "�������" ������� ��� ����� ��������/�������

  GlAttrWithCodeSet = [da_dlBases, da_dlAccGroups, da_dlCorSources];
  {* - ������� � ������� ���� ���� "���". }

  GlAttrCodeNeedFillSet = [da_dlBases, da_dlAccGroups];
  {* - ������� � ������� ���� "���" ����������� �����������. }

  GlAttrWithPrivateSet = [da_dlCorSources];
  {* - ������� � ������� ���� ���� "��� ����������� �������������". }

  GlAttrWithNonPeriodicSet = [da_dlCorSources];
  {* - ������� � ������� ���� ���� "��������������� �������". }

  GlAttrWithIDEdit = [da_dlWarnings];
  {* - ������� � ������� ���� ���� �������������� ID. }

  c_DictWithEquals = [da_dlClasses, da_dlKeyWords];
  {* - ������� � ������� ���� �������������. }

  cNoDefValue = High(TDictID);
  cDLPassports : Array [da_dlSources..High(TdaDictionaryType)] of TDLPassportRec = (
  {da_dlSources}     (rClass : atcDict;    rDict: ftDt1;  rLink: ftLnk1; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '��������� ������'),
  {da_dlTypes}       (rClass : atcDict;    rDict: ftDt2;  rLink: ftLnk2; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '����'),
  {da_dlClasses}     (rClass : atcDict;    rDict: ftDt3;  rLink: ftLnk3; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������'),
  {da_dlKeyWords}    (rClass : atcDict;    rDict: ftDt5;  rLink: ftLnk5; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '�������� �����'),
  {da_dlBases}       (rClass : atcDict;    rDict: ftDt6;  rLink: ftLnk6; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������ ����������'),
  {da_dlDateNums}    (rClass : atcSingle;  rDict: ftDt7;  rLink: ftLnk7; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '����, ������'),
  {da_dlWarnings}    (rClass : atcDict;    rDict: ftDt8;  rLink: ftLnk8; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '��������������'),
  {da_dlCorrects}    (rClass : atcSingle;  rDict: ftDt9;  rLink: ftLnk9; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '�������'),
  {da_dlCorSources}  (rClass : atcDict;    rDict: ftDtA;  rLink: ftDtB;  rDepDictID : da_dlPublisheds; rDepFldOfs : 4; rDefValue : cNoDefValue; rName: '�������'),
  {da_dlPublisheds}  (rClass : atcDepDict; rDict: ftDtB;  rLink: ftLnkB; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '��������� �������������'),
  {da_dlPrefixes}    (rClass : atcDict;    rDict: ftDtC;  rLink: ftLnkC; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '��� ����������'),
  {da_dlTerritories} (rClass : atcDict;    rDict: ftDtD;  rLink: ftLnkD; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '����������'),
  {da_dlNorms}       (rClass : atcDict;    rDict: ftDtE;  rLink: ftLnkE; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue :  1;          rName: '����� �����'),
  {da_dlAccGroups}   (rClass : atcDict;    rDict: ftDtF;  rLink: ftLnkF; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������ �������'),
  {da_dlNewClasses_Deprecated}  (rClass : atcDict;    rDict: ftNone; rLink: ftNone; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������ ��������������'),
  {da_dlAnnoClasses} (rClass : atcDict;    rDict: ftDtI;  rLink: ftLnkI; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������ ���������'),
  {da_dlServiceInfo} (rClass : atcDict;    rDict: ftDtJ;  rLink: ftLnkJ; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '��� ���������� ����������'),
  {da_dlTextInsert}  (rClass : atcSingle;  rDict: ftNone; rLink: ftNone; rDepDictID : da_dlNone;       rDepFldOfs : 0; rDefValue : cNoDefValue; rName: '������� �������')
  );

  DictionCommands : Array [da_dlSources..High(TdaDictionaryType)] of String =
                               ('!SOURCE','!TYPE','!CLASS','!KEY','!BELONGS',''{da_dlDateNums},'!WARNING',
                                ''{da_dlCorrects},''{da_dlCorSources},''{da_dlPublisheds},
                                '!PREFIX','!TERRITORY','!NORM','!MAIN','!CLASS'{da_dlNewClasses_Deprecated},
                                '!ANNOCLASS','!SERVICEINFO', ''{da_dlTextInsert});

//# ��������
type
(* ������ ��������� ���������, ������ ������� ����� ������������� ������������� *)
  TdtAttribute   = (atNothing,
                    atShortName, atFullName, atPriceLevel, atNotTM, atPriority, atSortDate,
                    atRelated, atVerLink, atUrgency, atComment,
                    atDateNums,
                    atSources, atTypes, atPrefixes, atClasses, atKeyWords, atBases {edBelongs},
                    atWarnings, atPublisheds, atTerritories, atNorms,
                    atAccGroups, atAnnoClasses, atServiceInfo,
                    atCorrects, atAlarms, atActiveIntervals, atStages, atJurLogRecords, atOrdLogRecords,
                    atDoc2DocLink,
                    atHLink, atSub,
                    atRenum,
                    atVersions
                   );

  TAttrType = (atUnknown, atInteger, atDate, atString, atRecord, atList);

  TAttributeDescriptorRec = record
                             AttrID : TdtAttribute;
                             AttrName : AnsiString;
                             AttrType : TAttrType;
                             //GetAttrNameLength
                             Flags : Longword;
                            end;

  TdtAttributeSet = set of TdtAttribute;

  TdtFilterAttributes = TdtAttribute;
  TdtFilterAttributesSet = set of TdtFilterAttributes;

  TAllExpData     = TdtAttribute;

  TExpDictData        = atDateNums .. atDoc2DocLink;
   {* - C����� ��������� ���������}
  TExpExtData         = atDateNums .. atDoc2DocLink;
   {* - C����� ��������� (����� MainRec) ���������}
  //TExpDictDataSet  = Set of TExpDictData;

  TAttrPassportRec  = record
   rLink  : TFamTbls;
   rDict  : TdaDictionaryType; //���������� �������, ���� ����
   rMultiValue  : boolean;
   rName : AnsiString;
  end;

const
  OrdAttrSet = [atInteger, atDate, atString];

  atLogRecords = atJurLogRecords;

  EditableDict = [da_dlSources, da_dlTypes, da_dlClasses, da_dlKeyWords, da_dlBases,
                  da_dlWarnings, da_dlPrefixes, da_dlTerritories, da_dlNorms, da_dlAccGroups,
                  da_dlCorSources, da_dlAnnoClasses, da_dlServiceInfo, da_dlTextInsert];
 {* - ����� DictDisign}


  cDLType2Attributes : array[da_dlSources .. da_dlServiceInfo] of TdtAttribute =
                     (atSources, atTypes, atClasses, atKeyWords, atBases,
                     atDateNums, atWarnings, atCorrects, atPublisheds{atCorSources}, atPublisheds,
                     atPrefixes, atTerritories, atNorms, atAccGroups, atClasses{atNewClasses},
                     atAnnoClasses, atServiceInfo{, atDoc2DocLink});


  cAttr2k2Tag : array[TdtAttribute] of Longint =
                    (0{atNothing},
                     0{atShortName}, 0{atFullName}, 0{atPriceLevel}, 0{atNotTM}, 0{atPriority}, 0{atSortDate},
                     0{atRelated}, {k2_tiInternalVerLink}k2_tiExternalVerLink{atVerLink}, 0{atUrgency}, 0{atComment},
                     k2_tiNumANDDates,
                     k2_tiSources, k2_tiTypes, k2_tiPrefix, k2_tiClasses, k2_tiKeyWords, k2_tiGroups,
                     k2_tiWarnings, k2_tiPublishedIn,k2_tiTerritory, k2_tiNorm,
                     k2_tiAccGroups, k2_tiAnnoClasses, k2_tiServiceInfo,
                     k2_tiChecks, k2_tiAlarms, k2_tiActiveIntervals, k2_tiStages, k2_tiLogRecords, k2_tiSysLogRecords,
                     k2_tiLinkedDocuments {atDoc2DocLink},
                     0{atHLink}, 0{atSub},
                     0{atRenum},
                     k2_tiVersions{atVersions}
                     );
  //�������� �������������� - TagID2AttrID

  {* - ������ ������ ��������� ���������, ������� ����� �������� }
  CdtAllAttributes = [Low(TdtAttribute) .. High(TdtAttribute)];

  CdtAllFilterAttributes = CdtAllAttributes;

  {* - c����� ��������� �� FileTbl}
  cAllMainRecData  = [atShortName .. atVerLink];
  {* - ������ ������ ��������� (����� MainRec) ���������, ������� ����� �������� }
  //cAllExpData      = [Low(TExpData) .. High(TExpData)];

  cSubDictExpData  = [atTypes, atPrefixes, atClasses, atKeyWords, atServiceInfo];  //!! ��. cctSubDictExpData ������� ������!!
                                                      //{atKeyWords,����� �� �������� � ����?}
                                                      //- !!!��� �� �������, ������������ ��� ���������� ����� � ��� ����������� ��� ��� ������� � ������!!!

  cDictExpData     = [atSources, atBases, atWarnings, atTerritories,
                      atNorms, atAccGroups, atAnnoClasses] + cSubDictExpData;
  cDocExpData      = CdtAllAttributes - [atAnnoClasses]; //cAllMainRecData + cAllExpData;
                                                      //{atKeyWords,����� �� �������� � ����?}
                                                      //- !!!��� �� �������, ������������ ��� ���������� ����� � ��� ����������� ��� ��� ������� � ������!!!
  cSprExpData      = [atBases, atAccGroups, atDateNums];

  cAnnoExpData     = [atTypes, atAccGroups, atAnnoClasses, atJurLogRecords, atOrdLogRecords];
  cExtAnnoExpData  = cAnnoExpData + [atDateNums];

  {for DocEdit}
  cAnnoAttrs    = [atAnnoClasses{, atJurLogRecords, atOrdLogRecords}];
  cDocAttrs     = CdtAllAttributes - [atAnnoClasses];
  cReadOnlyAttrs  = [atVersions];

  AttrIDOrder : array[0 .. 23] of TdtAttribute =
                              (atSources, atTypes, atTerritories,
                               atDateNums,
                               atAccGroups, atBases, atNorms,
                               atVerLink, atActiveIntervals, atAlarms,
                               atWarnings, atDoc2DocLink,

                               atClasses, atPrefixes, atKeyWords,
                               atAnnoClasses, atServiceInfo,
                               atPublisheds, atCorrects,

                               atJurLogRecords, atOrdLogRecords,
                               atStages,
                               atRenum,
                               atVersions);
{* - ������� ���������� ���������}

  RealAttrSet  = [atSources, atTypes,
                 atClasses, atPrefixes,
                 atAnnoClasses, atServiceInfo,
                 atKeyWords, atBases,
                 atDateNums,
                 atWarnings, atTerritories, atNorms, atAccGroups,
                 atVerLink, atActiveIntervals, atAlarms,
                 atPublisheds, atCorrects,
                 atJurLogRecords,
                 atRenum, atDoc2DocLink];
 {* - ��������, ������� ������������ ����������� ��������}


  StdDictAttrSet  = [atSources, atTypes, atClasses, atBases, atKeyWords,
                     atWarnings, atPrefixes, atTerritories, atNorms, atAccGroups,
                     atAnnoClasses, atServiceInfo
                    ];
  {* - ����������� (� ������ ��������������) ��������� ���������}

  _DictAttrSet  = [atSources, atTypes, atClasses, atBases,
                  atWarnings, atPrefixes, atTerritories, atNorms, atAccGroups,
                  atServiceInfo
                  {, atTextInsert}];
  {- for d_Export}

  HiddenAttr : TdtAttributeSet = [];

  GlMainAttrSet = [atTypes, atSources, atTerritories, atAccGroups, atBases, atDateNums,
                   atNorms, atWarnings, atVerLink, atActiveIntervals, atAlarms, atAnnoClasses, atServiceInfo
                   ,atPublisheds, atCorrects, {atPaperWhere,} atDoc2DocLink
                   ];
  {* - �������� ��� ������������ ���������. }

  GlMainAttrSetForObject = [atAccGroups, atBases];
  {* - �������� ��� "����������" ���������. }

  GlMainAttrSetForDictEntry = [atAccGroups, atBases, atRenum];
  {* - �������� ��� ��������� - ��������� ������. }

  GlSubAttrSet = [atTypes, atClasses, atPrefixes, atKeyWords,atServiceInfo];
  {* - �������� ��� ����� ������������ ���������. }

  GlSearchAttrSet = [atTypes, atSources, atTerritories, atAccGroups, atBases,
                    atNorms, atClasses, atPrefixes, atKeyWords, atWarnings, atAnnoClasses,atServiceInfo, atPublisheds];
  {* - �������� ��� ������. }

  GlGroupUnSupport = [atVerLink, atActiveIntervals, atAlarms, {atPublisheds,} atCorrects{, atPaperWhere}];
  {* - �������� �� �������������� � ��������� ���������. }

  GlGroupDelUnSupport = [atDateNums, {atWarnings,} atJurLogRecords];
  {* - �������� �� �������������� � ��������� ��������� ��������. }

  GlGroupOnly      = [atJurLogRecords];
  {* - �������� �������������� ������ � ��������� ���������. }

  GlMainAttrSetForGroupAdd = GlMainAttrSet + GlSubAttrSet + GlGroupOnly - GlGroupUnSupport;
  GlMainAttrSetForGroupDel = GlMainAttrSetForGroupAdd - GlGroupDelUnSupport;

  //GlSingleItemLinkAttrSet = [atAccGroups, atNorms, atWarnings, atVerLink];
  //������������ cAttrPassport[].rMultiValue
  {* - �������� ��� ������� ���� ����������� �� ���������� ������������� � ��������� �������� (1 ��������) }

  {������������ ��� ����������� ReadOnly  � DocData.LogRec}
  GlDocGroupSet  = [atAccGroups];
  GlClassDictSet = [atClasses, atPrefixes, atTerritories, atNorms];
  GlKWDictSet    = [atKeyWords];
  GlAnnoDictSet  = [atAnnoClasses];
  GlDocJurSet    = [atVerLink, atActiveIntervals, atWarnings, atServiceInfo];
  GlDocPublSet   = [atPublisheds];

  GlAttrInMainRecSet   = [atShortName, atFullName, atPriceLevel, atNotTM, atPriority, atSortDate, atRelated, atVerLink, atUrgency, atComment];
  // �������� � MainRec

  // �������� [atCorrects, atCorSources, atPublisheds, atPaperWhere, atTextInsert]

 // ������ � ��������� ����, ��� ������� ��������� �� ����� ���� ����� ������ ������ �� ��������
 // � ��������� ��������� � �������-�� ���, � ������������ ������ � ��������� ����� ���� ������� �� 0 �� n > 1 ��������
 // � � ����� �������� ����� ���� ������� 0 �� n > 1 ���������
 // ������� ������ ��������� �������� �� ��������� �� ������� ���������
 // ���� cDLPassports ������� ��� ����, �� ���������� �������� ��� �� ����� ������

  cAttrPassport : Array [Low(TdtAttribute)..High(TdtAttribute)] of TAttrPassportRec = (
  {atNothing        } (rLink: ftNone ; rDict: da_dlNone;        rMultiValue: false;  rName: 'Nothing'),
  {main record}
  {atShortName      } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '�������� ��������'),
  {atFullName       } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '��������'),
  {atPriceLevel     } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '����������'),
  {atNotTM          } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '�� ��������� � ������ �������'),
  {atPriority       } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '��������'),
  {atSortDate       } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '���� ��� ����������'),
  {atRelated        } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '����� �������'),
  {atVerLink        } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '���������� �������� ���������'),
  {atUrgency        } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '���������'),
  {atComment        } (rLink: ftFile ; rDict: da_dlNone;        rMultiValue: false; rName: '����������'),

  {atDateNums       } (rLink: ftLnk7 ; rDict: da_dlDateNums;    rMultiValue: true; rName: '����, ������'),

  {atSources        } (rLink: ftLnk1 ; rDict: da_dlSources;     rMultiValue: true; rName: '��������� ������'),
  {atTypes          } (rLink: ftLnk2 ; rDict: da_dlTypes;       rMultiValue: true; rName: '����'),
  {atPrefixes       } (rLink: ftLnkC ; rDict: da_dlPrefixes;    rMultiValue: true; rName: '��� ����������'),
  {atClasses        } (rLink: ftLnk3 ; rDict: da_dlClasses;     rMultiValue: true; rName: '������'),
  {atKeyWords       } (rLink: ftLnk5 ; rDict: da_dlKeyWords;    rMultiValue: true; rName: '�������� �����'),
  {atBases  Belongs } (rLink: ftLnk6 ; rDict: da_dlBases;       rMultiValue: true; rName: '������ ����������'),
  {atWarnings       } (rLink: ftLnk8 ; rDict: da_dlWarnings;    rMultiValue: false;  rName: '��������������'),
  {atPublisheds     } (rLink: ftLnkB ; rDict: da_dlPublisheds;  rMultiValue: true; rName: '��������� �������������'),
  {atTerritories    } (rLink: ftLnkD ; rDict: da_dlTerritories; rMultiValue: true; rName: '����������'),
  {atNorms          } (rLink: ftLnkE ; rDict: da_dlNorms;       rMultiValue: false;  rName: '����� �����'),
  {atAccGroups      } (rLink: ftLnkF ; rDict: da_dlAccGroups;   rMultiValue: false;  rName: '������ �������'),
  {atAnnoClasses    } (rLink: ftLnkI ; rDict: da_dlAnnoClasses; rMultiValue: true; rName: '������ ���������'),
  {atServiceInfo    } (rLink: ftLnkJ ; rDict: da_dlServiceInfo; rMultiValue: true; rName: '��� ���������� ����������'),
  {atCorrects       } (rLink: ftLnk9 ; rDict: da_dlCorrects;    rMultiValue: true; rName: '�������'),
  {atAlarms         } (rLink: ftAlarm; rDict: da_dlNone;        rMultiValue: true; rName: '�����������'),
  {atActiveIntervals} (rLink: ftActiv; rDict: da_dlNone;        rMultiValue: true; rName: '��������� ��������'),
  {atStages         } (rLink: ftStage; rDict: da_dlNone;        rMultiValue: true; rName: '�����'),
  {atLogRecords     } (rLink: ftLog  ; rDict: da_dlNone;        rMultiValue: true; rName: '������ ����������� ��������'),
  {atLogRecords     } (rLink: ftLog  ; rDict: da_dlNone;        rMultiValue: true; rName: '��������� ������'),
  {atDoc2DocLink    } (rLink: ftLnkK ; rDict: da_dlNone;        rMultiValue: true; rName: '����� ����� �����������'),
  {atHLink          } (rLink: ftHLink; rDict: da_dlNone;        rMultiValue: true; rName: '�����������'),
  {atSub            } (rLink: ftSub  ; rDict: da_dlNone;        rMultiValue: true; rName: '�����'),
  {atRenum          } (rLink: ftRenum; rDict: da_dlNone;        rMultiValue: true; rName: '������� ID'),
  {atVersions       } (rLink: ftNone ; rDict: da_dlNone;        rMultiValue: true; rName: '������ ������ ���������')
  );

//# ������� ������ ���������
 type
  TIDKind = (idkDocExternal, idkDocInternal, idkSprExternal, idkSprInternal);
  PDocIDsRec = ^TDocIDsRec;
  TDocIDsRec = packed record
   rIDKind : TIDKind;
   rId : TDocID;
  end;

  TDictExtParam = (depCode, depPrivate, depNonPeriodic, depID);
  TDictExtParams = set of TDictExtParam;

  PPublishFullRec = ^TPublishFullRec;
  TPublishFullRec = packed record
                     ID          : Longword;
                     Sour        : TDictID;
                     SDate       : TStDate;
                     EDate       : TStDate;
                     Num         : array[1..30] of AnsiChar;
                     Comment     : array[1..70] of AnsiChar;

                     Pages       : array[1..128] of AnsiChar;
                     LinkComment : array[1..255] of AnsiChar;
                     Flags       : Byte;
                    end;
   // ��������! ��������� TPublishDataRec ������ ����� ������ ���� ���������
   // ����������� � ������ ��������� TPublishFullRec
   // ������ ������� ���� ���������� ��� dt_EFltr.TexpPublishDataRec
  PPublishDataRec = ^TPublishDataRec;
  TPublishDataRec = packed record
   DictID       : Longword;                // DT#B.Id
   SourId       : TDictID; // word         // DT#B.Source = DT#A.Id
   SDate        : TStDate;                 // DT#B.StartDate
   EDate        : TStDate;                 // DT#B.EndDate
   Num          : array[1..30] of AnsiChar;    // DT#B.Number
   Comment      : array[1..70] of AnsiChar;    // DT#B.Coment

   Pages        : array[1..128] of AnsiChar;   // LNK#B.Pages
   LinkComment  : array[1..255] of AnsiChar;   // LNK#B.Coment
   Flags        : Byte;                    // LNK#B.Flags
   //----------------------------------------------------------
   DocId        : TDocID;                  // LNK#B.DocId
   ShName       : TCorSrcShortName;        // DT#A.ShName
   IsPrivate    : TIsPrivate;              // DT#A.Private
   IsNonperiodic: TIsNonperiodic;          // DT#A.Nonperiod
  end;

  PPublishLinkRec = ^TPublishLinkRec;
  TPublishLinkRec = packed record
   Doc_ID : Longword;
   Dict_ID: Longword;
   Pages  : array[1..128] of AnsiChar;
   Comment: array[1..255] of AnsiChar;
   Flags  : Byte;
  end;

  PDoc2DocLinkRec = ^TDoc2DocLinkRec;
  TDoc2DocLinkRec = packed record
   rLinkType    : Byte;
   rLinkedDocID : TDocID;
  end;

//#
  function DocIDField(aAttr : TdtAttribute) : Integer;
  function AttrID2DLType(aAttrID: TdtAttribute): TdaDictionaryType;
  function DLType2AttrID(aDL : TdaDictionaryType): TdtAttribute;
  function TagID2AttrID(aTagId: Integer) : TdtAttribute;

  function GetMasterDict(aDict : TdaDictionaryType) : TdaDictionaryType;
  function IsDictClass(aDict : TdaDictionaryType): Boolean;
  function IsStdDictAttr(aAttrID : TdtAttribute): Boolean;

  procedure AddDLClassToSet(var theSet: TDLTypeSet; aClass: TAttrClass);

  function IsTableHasPassport(aTable: TFamTbls): Boolean;

implementation

function TagID2AttrID(aTagId: Integer) : TdtAttribute;
begin
 case aTagId of
  k2_tiTypes           : Result := atTypes;
  k2_tiSources         : Result := atSources;
  k2_tiClasses         : Result := atClasses;
  k2_tiKeyWords        : Result := atKeyWords;
  k2_tiPrefix          : Result := atPrefixes;
  k2_tiAnnoClasses     : Result := atAnnoClasses;
  k2_tiTerritory       : Result := atTerritories;
  k2_tiGroups          : Result := atBases;
  k2_tiAccGroups       : Result := atAccGroups;
  k2_tiNorm            : Result := atNorms;
  k2_tiWarnings        : Result := atWarnings;
  k2_tiPublishedIn     : Result := atPublisheds;
  k2_tiServiceInfo     : Result := atServiceInfo;
  k2_tiNumANDDates     : Result := atDateNums;
  k2_tiSysLogRecords   : Result := atOrdLogRecords;
  k2_tiLogRecords      : Result := atJurLogRecords;
  k2_tiStages          : Result := atStages;
  k2_tiActiveIntervals : Result := atActiveIntervals;
  k2_tiChecks          : Result := atCorrects;
  k2_tiAlarms          : Result := atAlarms;
  k2_tiLinkedDocuments : Result := atDoc2DocLink
  else
   Assert(false, 'dt_AttrSchema.TagID2AttrID: invalid tag');
 end;
 {ctHLink, ctSub,
  }
end;


 function AttrID2DLType(aAttrID: TdtAttribute): TdaDictionaryType;
 const
  cAttr2DLType : array[atDateNums .. atCorrects] of TdaDictionaryType =
                      (da_dlDateNums,
                       da_dlSources, da_dlTypes, da_dlPrefixes, da_dlClasses, da_dlKeyWords, da_dlBases,
                       da_dlWarnings, da_dlPublisheds, da_dlTerritories, da_dlNorms,
                       da_dlAccGroups, da_dlAnnoClasses, da_dlServiceInfo,
                       da_dlCorrects);
 begin
  if aAttrID in [atDateNums .. atCorrects] then
   Result := cAttr2DLType[aAttrID]
  else
   Result := da_dlNone;
 end;

 function DLType2AttrID(aDL : TdaDictionaryType): TdtAttribute;
 begin
  Assert(aDL in [da_dlSources .. da_dlServiceInfo], '���������� ��������� ��� ������� � ��� ��������');

  Result := cDLType2Attributes[aDL];
 end;

function GetMasterDict(aDict : TdaDictionaryType) : TdaDictionaryType;
 var
  I : TdaDictionaryType;
 begin
  Result := da_dlNone;
  for I := Succ(da_dlNone) to High(TdaDictionaryType) do
   with cDLPassports[I] do
    if rDepDictID = aDict then
    begin
     Result := I;
     Exit;
    end;
 end;

 function IsDictClass(aDict : TdaDictionaryType): Boolean;
 begin
  if aDict = da_dlNone then
   Result := False
  else
   Result := cDLPassports[aDict].rClass = atcDict;
 end;

 function IsStdDictAttr(aAttrID : TdtAttribute): Boolean;
 begin
  Result := aAttrID in StdDictAttrSet;
 end;

 procedure AddDLClassToSet(var theSet: TDLTypeSet; aClass: TAttrClass);
 var
  I : TdaDictionaryType;
 begin
  for I := da_dlSources to High(TdaDictionaryType) do
   if cDLPassports[I].rClass = aClass then
    Include(theSet, I);
 end;

function DocIDField(aAttr : TdtAttribute) : Integer;
begin
 if aAttr = atHLink then
  Result := 2
 else
  Result := 1;
end;

function IsTableHasPassport(aTable: TFamTbls): Boolean;
var
 l_IDX: TdaDictionaryType;
begin
 Result := False;
 for l_IDX := Low(cDLPassports) to High(cDLPassports) do
 begin
  if cDLPassports[l_IDX].rDict = aTable then
  begin
   Result := True;
   Exit;
  end;
 end;
end;

end.
