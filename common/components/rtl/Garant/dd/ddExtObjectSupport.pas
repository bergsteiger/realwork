unit ddExtObjectSupport;
 {* Читает/пишет содержимое объектов из/в хранилища }

// Модуль: "w:\common\components\rtl\Garant\dd\ddExtObjectSupport.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddExtObjectSupport" MUID: (57987C120048)

{$Include w:\common\components\rtl\Garant\dd\ddDefine.inc}

interface

uses
 l3IntfUses
 , ddExtObjInserter
 , ddExtObjExtractor
;

type
 TddExtObjInserter = ddExtObjInserter.TddExtObjInserter;

 TddExtObjExtractor = ddExtObjExtractor.TddExtObjExtractor;

implementation

uses
 l3ImplUses
;

end.
