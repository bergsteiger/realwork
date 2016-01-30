library RenderEVD;
 {* Библиотека для преобразования EVD-структур в картинки }

// Модуль: "w:\common\components\RenderEVD\RenderEVD.dpr"
// Стереотип: "AdapterTarget"

{$Include l3XE.inc}

interface

uses
 l3IntfUses
;

implementation

uses
 l3ImplUses
;

exports
//#UC START# *474AD1C7020Cexports*
  RenderFormulaPrim,
  RenderFormula,
  EVDtoRTF,
  EVDtoRTFWithoutCommentDecor,
  SetStyleTable
//#UC END# *474AD1C7020Cexports*
;

end.
