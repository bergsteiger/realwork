unit dt_TblCacheDef;
{ $Id: dt_TblCacheDef.pas,v 1.2 2014/10/21 13:56:49 voba Exp $ }

interface
uses
//Dt_Types, Dt_const,
     dt_AttrSchema;

type
  TCacheType      = ({ctDoc,}
                     ctHLink, ctSub,
                     ctSour, ctBase, ctTerritory, ctNorm, ctAccGroup, ctAnnoClasses,
                     ctType, ctKW, ctClass, ctPrefix,
                     ctWarning, ctStage, ctActive, ctAlarm,
                     ctLog_Doc, ctLog_Anno,
                     ctDateNum,
                     ctCorrects,
                     ctPublisheds,
                     ctServiceInfo,
                     ctDoc2DocLink);

  TCacheTypeSet   = set of TCacheType;

const
 {* - ѕолный список атрибутов документа, которые можно прочесть }
 CctAllAttributes = [Low(TCacheType) .. High(TCacheType)];
 cctSubDictExpData  = [ctType, ctPrefix, ctClass, {ctKW, ¬се равно такой команды нет} ctServiceInfo];  //!! см. cSubDictExpData править вместе!!

 cAttrInAnno = [ctAnnoClasses, ctLog_Anno];
 cAttrInDoc  = [Low(TCacheType) .. High(TCacheType)] - cAttrInAnno;
   // принадлежность атрибутов к типам документов (дл€ импорта)

const
  cCacheType2Attr : array[TCacheType] of TdtAttribute = (
                    atHLink, atSub,
                    atSources, atBases, atTerritories, atNorms, atAccGroups, atAnnoClasses,
                    atTypes, atKeyWords, atClasses, atPrefixes,
                    atWarnings, atStages, atActiveIntervals, atAlarms,
                    atLogRecords, atLogRecords,
                    atDateNums,
                    atCorrects,
                    atPublisheds,
                    atServiceInfo,
                    atDoc2DocLink);



 function AttributeToCacheType(aAttrID : TdtAttribute) : TCacheType;
 function TagIDToCacheType(aTagId: Integer; aIsAnnoTopic : boolean = false) : TCacheType;

implementation

uses
 k2Tags;

const
cNothingCacheType : TCacheType = TCacheType(-1);

function TagIDToCacheType(aTagId: Integer; aIsAnnoTopic : boolean = false) : TCacheType;
begin
 case aTagId of
  k2Tags.k2_tiTypes           : Result := ctType;
  k2Tags.k2_tiSources         : Result := ctSour;
  k2Tags.k2_tiClasses         : Result := ctClass;
  k2Tags.k2_tiKeyWords        : Result := ctKW;
  k2Tags.k2_tiPrefix          : Result := ctPrefix;
  k2Tags.k2_tiAnnoClasses     : Result := ctAnnoClasses;
  k2Tags.k2_tiTerritory       : Result := ctTerritory;
  k2Tags.k2_tiGroups          : Result := ctBase;
  k2Tags.k2_tiAccGroups       : Result := ctAccGroup;
  k2Tags.k2_tiNorm            : Result := ctNorm;
  k2Tags.k2_tiWarnings        : Result := ctWarning;
  k2Tags.k2_tiPublishedIn     : Result := ctPublisheds;
  k2Tags.k2_tiServiceInfo     : Result := ctServiceInfo;
  k2Tags.k2_tiNumANDDates     : Result := ctDateNum;
  k2Tags.k2_tiSysLogRecords,
  k2Tags.k2_tiLogRecords      : if aIsAnnoTopic then Result := ctLog_Anno else Result := ctLog_Doc;
  k2Tags.k2_tiStages          : Result := ctStage;
  k2Tags.k2_tiActiveIntervals : Result := ctActive;
  k2Tags.k2_tiChecks          : Result := ctCorrects;
  k2Tags.k2_tiAlarms          : Result := ctAlarm;
  k2Tags.k2_tiLinkedDocuments : Result := ctDoc2DocLink
  else
   Assert(false, 'dt_TblCacheDef.TagIDToCacheType: invalid tag');
 end;
 {ctHLink, ctSub,
  }
end;
function AttributeToCacheType(aAttrID : TdtAttribute) : TCacheType;
 const
  cConvSet : TdtAttributeSet = [atDateNums .. atSub];

  cAttr2CacheType  : array[atDateNums .. atSub] of TCacheType =
                   (ctDateNum,
                    ctSour, ctType, ctPrefix, ctClass, ctKW, ctBase {edBelongs},
                    ctWarning, ctPublisheds, ctTerritory, ctNorm,
                    ctAccGroup, ctAnnoClasses, ctServiceInfo,
                    ctCorrects, ctAlarm, ctActive, ctStage, ctLog_Doc, ctLog_Doc,
                    ctDoc2DocLink,
                    ctHLink, ctSub);

 begin
  if aAttrID in cConvSet then
   if aAttrID in [atJurLogRecords, atOrdLogRecords] then
    Result := ctLog_Doc
   else
    Result := cAttr2CacheType[aAttrID]
  else
   Result := cNothingCacheType;
 end;
end.