unit Block_Const;
 {* Элемент структуры документа }

// Модуль: "w:\common\components\gui\Garant\Everest\Block_Const.pas"
// Стереотип: "Tag"
// Элемент модели: "Block" MUID: (4857A87D0337)
// Имя типа: "BlockTag"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , ParaList_Const
 , k2Handle_Const
 , k2Long_Const
 , k2Bool_Const
 , evdTypes
 , evdTextStyle_Const
 , Font_Const
;

 // BlockTag

implementation

uses
 l3ImplUses
 {$If Defined(k2ForEditor)}
 , evDocumentPart
 {$IfEnd} // Defined(k2ForEditor)
 , l3Defaults
;

end.
