unit evDefaultStylesFontSizes;

interface

uses
 l3IntfUses
 , evDefaultStylesFontSizesPrim1
 , l3Variant
;

type
 TevDefaultStylesFontSizes = class(TevDefaultStylesFontSizesPrim1)
  {* Размеры шрифтов для стилей по-умолчанию }
  function FontSizeForTag(aTag: Tl3Variant): Integer;
  procedure SaveStylesFontSizes;
  function FontSizeForStyle(aStyle: Integer): Integer;
  function Exists: Boolean;
   {* Проверяет создан экземпляр синглетона или нет }
 end;//TevDefaultStylesFontSizes
 
implementation

uses
 l3ImplUses
 , l3Math
 , evdStyles
 , l3MinMax
 , k2Tags
 , evDef
 , evStyleInterface
 , evDefaultStylesFontSizesPrim
 , l3Types
 , SysUtils
;

end.
