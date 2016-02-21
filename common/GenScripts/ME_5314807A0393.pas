unit l3FontManagerPrim;

// Модуль: "w:\common\components\rtl\Garant\L3\l3FontManagerPrim.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , l3FontManagerPrimPrim
 , l3LogFont
 , l3Interfaces
 , l3Types
;

type
 _StringType_ = Tl3LogFont;
 _l3DictionaryPrimPrim_Parent_ = Tl3FontManagerPrimPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrimPrim.imp.pas}
 Tl3FontManagerPrim = class(_l3DictionaryPrimPrim_)
 end;//Tl3FontManagerPrim

implementation

uses
 l3ImplUses
 , l3String
 , l3Memory
;

{$If not Declared(_ItemType_)}type _ItemType_ = Tl3LogFont;{$IfEnd}

{$If not Declared(_DataType_)}type _DataType_ = Tl3Ptr;{$IfEnd}

{$If not Declared(_FindDataType_)}type _FindDataType_ = _ItemType_;{$IfEnd}

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_5314807A0393_var*
//#UC END# *5304D6C5002B_5314807A0393_var*
begin
//#UC START# *5304D6C5002B_5314807A0393_impl*
 Result := anItem.AsWStr;
//#UC END# *5304D6C5002B_5314807A0393_impl*
end;//ItemToWStr

type _Instance_R_ = Tl3FontManagerPrim;

{$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrimPrim.imp.pas}

end.
