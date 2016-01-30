unit NOT_FINISHED_dt_AttrSchema;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dt_AttrSchema.pas"
// Стереотип: "UtilityPack"

{$Include ddDefine.inc}

interface

uses
 l3IntfUses
;

type
 TdtAttribute = (
  atNothing
  , atShortName
  , atFullName
  , atPriceLevel
  , atNotTM
  , atPriority
  , atSortDate
  , atRelated
  , atVerLink
  , atUrgency
  , atComment
  , atDateNums
  , atSources
  , atTypes
  , atPrefixes
  , atClasses
  , atKeyWords
  , atBases
  , atWarnings
  , atPublisheds
  , atTerritories
  , atNorms
  , atAccGroups
  , atAnnoClasses
  , atServiceInfo
  , atCorrects
  , atAlarms
  , atActiveIntervals
  , atStages
  , atJurLogRecords
  , atOrdLogRecords
  , atDoc2DocLink
  , atHLink
  , atSub
  , atRenum
  , atVersions
 );//TdtAttribute

 TDoc2DocLinkRec = record
 end;//TDoc2DocLinkRec

implementation

uses
 l3ImplUses
 , dt_Types
;

end.
