unit evdStyleContainer;

interface

uses
 l3IntfUses
 , k2DictionaryEx
 , l3Variant
 , k2Base
 , evdStyles
;

type
 _ItemType_ = Tl3Variant;
  {* Это вообще-то хак, но без этого не находится тип элемента }
 
 TevStandardStylesArray = array [TevStandardCachedStyle] of Tl3Tag;
 
 TevdStyleContainer = class(Tk2DictionaryEx)
  {* описание базового контейнера стилей }
  procedure CheckValueTable(aType: Tk2Type);
   {* Проверяет таблицу значений. }
 end;//TevdStyleContainer
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Types
 , k2Tags
;

end.
