unit NOT_FINISHED_dt_AttrSchema;

// Модуль: "w:\common\components\rtl\Garant\dd\NOT_FINISHED_dt_AttrSchema.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "dt_AttrSchema" MUID: (4C9CD0E8038A)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

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
 //#UC START# *4C9CD0E8038Aimpl_uses*
 //#UC END# *4C9CD0E8038Aimpl_uses*
;

end.
