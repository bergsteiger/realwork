unit daSchemeConsts;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DA"
// Модуль: "w:/common/components/rtl/Garant/DA/daSchemeConsts.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi For Archi::DA::DataScheme::daSchemeConsts
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\DA\daDefine.inc}

interface

const
  { Free Table Names }
 ftnDocIDExternal = 'DOCIDEXT';
 ftnDocIDForLists = 'DOCIDLST';
  { для выделения DocID при обработке реестра (К:119473985) }
 ftnDocIDLawCase = 'LAWCASE';
  { диапазон номеров для Постановлений АС }
 ftnDocIDVAS = 'VASCASE';
  { постановления ВАС }
 ftnDocID1st = 'SPBDOC';
  { Документы судов первой инстанции }
 ftnDocIDFAS1 = 'FAS1';
  { ФАС ДВО }
 ftnDocIDFAS2 = 'FAS2';
  { ФАС ВСО }
 ftnDocIDFAS3 = 'FAS3';
  { ФАС ЗСО }
 ftnDocIDFAS4 = 'FAS4';
  { ФАС УРО }
 ftnDocIDFAS5 = 'FAS5';
  { ФАС ПО }
 ftnDocIDFAS6 = 'FAS6';
  { ФАС ВВО }
 ftnDocIDFAS7 = 'FAS7';
  { ФАС ЦО }
 ftnDocIDFAS8 = 'FAS8';
  { ФАС СКО }
 ftnDocIDFAS9 = 'FAS9';
  { ФАС СЗО }
 ftnDocIDFAS10 = 'FAS10';
  { ФАС МО }
 ftnImgHandle = 'HIMAGE';
  { для получения ID используйте function GlobalDataProvider.GetFreeExtObjID(aFamily : TFamilyID): TDocID; }
 NameDictExternalNumber = 'DictExtN';
  { cFamilies }
 MainTblsFamily = 0;
 CurrentFamily = 1;

implementation

end.