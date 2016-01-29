unit evDefaultStylesFontSizesPrim;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
;

type
 TevDefaultStyleFontSize = object
 end;//TevDefaultStyleFontSize
 
 TevDefaultStylesFontSizesPrim = class(Tl3ProtoDataContainer)
  {* Размеры шрифтов для стилей по-умолчанию }
  procedure AssignItem(const aTo: _ItemType_;
   const aFrom: _ItemType_);
  function CompareExistingItems(const CI: CompareItemsRec): Integer;
   {* Сравнивает два существующих элемента. }
 end;//TevDefaultStylesFontSizesPrim
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
