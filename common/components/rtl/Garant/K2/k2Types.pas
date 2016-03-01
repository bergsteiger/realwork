unit k2Types;
 {* Базовые типы. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2Types.pas"
// Стереотип: "Interfaces"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , l3Variant
 , k2Interfaces
;

const
 {* Алиасы для значений l3Variant.Tk2VarKind }
 k2_vkInteger = l3Variant.k2_vkInteger;
 k2_vkString = l3Variant.k2_vkString;
 k2_vkTransparent = l3Variant.k2_vkTransparent;
 k2_vkStream = l3Variant.k2_vkStream;
 {* Алиасы для значений k2Interfaces.Tk2TypeKind }
 k2_tkInteger = k2Interfaces.k2_tkInteger;
 k2_tkBool = k2Interfaces.k2_tkBool;
 k2_tkObject = k2Interfaces.k2_tkObject;
 k2_tkTransparent = k2Interfaces.k2_tkTransparent;
 k2_tkStream = k2Interfaces.k2_tkStream;

type
 Tk2TypeKind = k2Interfaces.Tk2TypeKind;

 Tk2VarKind = l3Variant.Tk2VarKind;

 Tk2Variant = k2Interfaces.Tk2Variant;

implementation

uses
 l3ImplUses
;

end.
