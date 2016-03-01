unit k2Dictionary;
 {* Словарь. }

// Модуль: "w:\common\components\rtl\Garant\K2\k2Dictionary.pas"
// Стереотип: "SimpleClass"

{$Include w:\common\components\rtl\Garant\K2\k2Define.inc}

interface

uses
 l3IntfUses
 , k2DictionaryPrim
 , k2DictionaryIDIndex
 , l3Variant
 , l3Interfaces
 , l3Types
;

type
 _IDIndexType_ = Tk2DictionaryIDIndex;
 _StringType_ = Tl3Variant;
 _l3DictionaryPrim_Parent_ = Tk2DictionaryPrim;
 {$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}
 Tk2Dictionary = class(_l3DictionaryPrim_)
  {* Словарь. }
 end;//Tk2Dictionary

implementation

uses
 l3ImplUses
 , l3String
 , k2Tags
 , k2BaseTypes
 , l3Base
 , SysUtils
 , l3Memory
;

function ItemToWStr(const anItem: _ItemType_): Tl3WString;
//#UC START# *5304D6C5002B_4860AF86034F_var*
//#UC END# *5304D6C5002B_4860AF86034F_var*
begin
//#UC START# *5304D6C5002B_4860AF86034F_impl*
 Result := anItem.PCharLenA[k2_tiName];
//#UC END# *5304D6C5002B_4860AF86034F_impl*
end;//ItemToWStr

type _Instance_R_ = Tk2Dictionary;

{$Include w:\common\components\rtl\Garant\L3\l3DictionaryPrim.imp.pas}

end.
