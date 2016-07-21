unit m3DBTypes;

// Модуль: "w:\common\components\rtl\Garant\m3\m3DBTypes.pas"
// Стереотип: "Interfaces"
// Элемент модели: "m3DBTypes" MUID: (578F46AF0276)

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

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

const
 m3_AllDocParts = [Low(Tm3DocPartSelector) .. High(Tm3DocPartSelector)];

implementation

uses
 l3ImplUses
;

end.
