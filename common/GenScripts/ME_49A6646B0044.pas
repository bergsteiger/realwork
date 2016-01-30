unit k2BaseTypes;
 {* Базовые типы библиотеки. На них опирается описание интерфейсов }

// Модуль: "w:\common\components\rtl\Garant\L3\k2BaseTypes.pas"
// Стереотип: "Interfaces"

{$Include l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tk2StorePropertyFlag = (
  {* Режим сохранения типов тегов. }
  l3_spfScalars
  , l3_spfObjects
  , l3_spfChildren
  , l3_spfRawData
 );//Tk2StorePropertyFlag

 Tk2StorePropertyFlags = set of Tk2StorePropertyFlag;
  {* Режимы сохранения типов тегов. }

 // l3_spfAll

 // l3_spfInner

 Tk2AssignMode = (
  {* Режим копирования спецзначений тегов. }
  k2_amNull
  , k2_amTransparent
 );//Tk2AssignMode

 Tk2AssignModes = set of Tk2AssignMode;
  {* Режимы копирования спецзначений тегов. }

 // k2_amAll

implementation

uses
 l3ImplUses
;

end.
