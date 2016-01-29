unit evTextParaPainter;

interface

uses
 l3IntfUses
 , evTextParaPainterPrim
 , l3Interfaces
 , nevBase
;

type
 TevTextParaPainter = class(TevTextParaPainterPrim)
  {* Рисователь текстового параграфа }
  procedure AssignFontFromStyle(const aFont: Il3Font;
   const aStyle: Tl3Variant);
  function NeedCalcSpace: Boolean;
   {* Проверка для срабатывания примеси. }
  function HeaderOwnSpace: Boolean;
  function GetSpaceTop(anInc: Boolean): Integer;
 end;//TevTextParaPainter
 
implementation

uses
 l3ImplUses
 , evParaTools
 , k2Tags
 , l3MinMax
 , l3String
 , l3Chars
 , l3Const
 , evParaString
 , SysUtils
;

end.
