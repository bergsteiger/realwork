unit l3MarshalledTypes;

// Модуль: "w:\common\components\rtl\Garant\L3\l3MarshalledTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "l3MarshalledTypes" MUID: (57BEAF780201)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tm3DocPartSelector = (
  m3_dsMain
   {* основной поток }
  , m3_dsAnno
   {* аннотация }
  , m3_dsInfo
   {* информация о документе }
  , m3_dsObject
   {* объект в документе }
 );//Tm3DocPartSelector

 TDocPartSelector = (
  dpDoc
  , dpSpr
  , dpAnno
 );//TDocPartSelector

implementation

uses
 l3ImplUses
;

end.
