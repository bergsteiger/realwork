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
 //#UC START# *57987C120048impl_uses*
 , ActiveX
 , Classes
 
 , l3Base
 , l3Stream

 , k2Tags
 , k2Interfaces
 
 , Document_Const
 , BitmapPara_Const
 , ExtDataPara_Const

 , m2ComLib

 , m3StorageInterfaces

 , daSchemeConsts
 
 , Dt_Serv
 //#UC END# *57987C120048impl_uses*
;

end.
