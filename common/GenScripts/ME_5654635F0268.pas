unit daSchemeConsts;

// Модуль: "w:\common\components\rtl\Garant\DA\daSchemeConsts.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "daSchemeConsts" MUID: (5654635F0268)

{$Include w:\common\components\rtl\Garant\DA\daDefine.inc}

interface

uses
 l3IntfUses
;

const
 {* Free Table Names }
 ftnDocIDExternal = 'DOCIDEXT';
 ftnDocIDForLists = 'DOCIDLST';
  {* для выделения DocID при обработке реестра (К:119473985) }
 ftnDocIDLawCase = 'LAWCASE';
  {* диапазон номеров для Постановлений АС }
 ftnDocIDVAS = 'VASCASE';
  {* постановления ВАС }
 ftnDocID1st = 'SPBDOC';
  {* Документы судов первой инстанции }
 ftnDocIDFAS1 = 'FAS1';
  {* ФАС ДВО }
 ftnDocIDFAS2 = 'FAS2';
  {* ФАС ВСО }
 ftnDocIDFAS3 = 'FAS3';
  {* ФАС ЗСО }
 ftnDocIDFAS4 = 'FAS4';
  {* ФАС УРО }
 ftnDocIDFAS5 = 'FAS5';
  {* ФАС ПО }
 ftnDocIDFAS6 = 'FAS6';
  {* ФАС ВВО }
 ftnDocIDFAS7 = 'FAS7';
  {* ФАС ЦО }
 ftnDocIDFAS8 = 'FAS8';
  {* ФАС СКО }
 ftnDocIDFAS9 = 'FAS9';
  {* ФАС СЗО }
 ftnDocIDFAS10 = 'FAS10';
  {* ФАС МО }
 ftnImgHandle = 'HIMAGE';
  {* для получения ID используйте function GlobalDataProvider.GetFreeExtObjID(aFamily : TFamilyID): TDocID; }
 NameDictExternalNumber = 'DictExtN';
 MainTblsFamily = 0;
 CurrentFamily = 1;

implementation

uses
 l3ImplUses
;

end.
