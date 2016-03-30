unit evNative_Schema;
 {* Родная схема EVD-документов }

// Модуль: "w:\common\components\gui\Garant\Everest\evNative_Schema.pas"
// Стереотип: "TagTable"
// Элемент модели: "evNative" MUID: (484CD009023D)
// Имя типа: "TevNativeSchema"

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , evdNative_Schema
 //#UC START# *484CD009023D_48492FC0029Dintf_uses*
 //#UC END# *484CD009023D_48492FC0029Dintf_uses*
;

type
 // TevNativeSchema

implementation

uses
 l3ImplUses
 , Bookmark_Const
 , Mark_Const
 , evQueryCardInt
 {$If Defined(k2ForEditor)}
 , evParaTools
 {$IfEnd} // Defined(k2ForEditor)
 , evNative_AttrValues
 //#UC START# *484CD009023D_48492FC0029Dimpl_uses*
 //#UC END# *484CD009023D_48492FC0029Dimpl_uses*
;

initialization
 TevNativeSchema.SetAsDefault;

end.
