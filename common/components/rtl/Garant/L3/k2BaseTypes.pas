unit k2BaseTypes;
 {* Базовые типы библиотеки. На них опирается описание интерфейсов }

// Модуль: "w:\common\components\rtl\Garant\L3\k2BaseTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "k2BaseTypes" MUID: (49A6646B0044)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

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

 Tk2AssignMode = (
  {* Режим копирования спецзначений тегов. }
  k2_amNull
  , k2_amTransparent
 );//Tk2AssignMode

 Tk2AssignModes = set of Tk2AssignMode;
  {* Режимы копирования спецзначений тегов. }

const
 {* режим сохранения всех типов тегов. }
 l3_spfAll = [Low(Tk2StorePropertyFlag) .. High(Tk2StorePropertyFlag)];
 {* режим сохранения всех вложенных тегов целиком. }
 l3_spfInner = l3_spfAll;
 {* режим копирования всех значений тегов. }
 k2_amAll = [Low(Tk2AssignMode) .. High(Tk2AssignMode)];

implementation

uses
 l3ImplUses
;

end.
