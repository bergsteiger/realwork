unit afwFont;

interface

uses
 l3IntfUses
 , Graphics
 , afwInterfaces
 , l3Interfaces
;

type
 TafwCastableFont = class(_l3Castable_)
  {* Шрифт с QueryInterface. }
 end;//TafwCastableFont
 
 TafwFontI = class(_l3Unknown_, IafwFont)
  procedure Create;
  function Make: IafwFont;
  function ForeColor: Tl3Color;
   {* цвет шрифта. }
  function BackColor: Tl3Color;
   {* цвет фона. }
  function Name: TFontName;
   {* имя шрифта. }
  function Pitch: TFontPitch;
   {* Кернинг. }
  function Size: Integer;
   {* размер кегля. }
  function Index: Tl3FontIndex;
   {* индекс шрифта. }
  function Style: TFontStyles;
  function Bold: Boolean;
   {* жирный. }
  function Italic: Boolean;
   {* курсив. }
  function Underline: Boolean;
   {* подчеркивание. }
  function Strikeout: Boolean;
   {* зачеркивание. }
  procedure Assign2Font(aFont: TFont);
 end;//TafwFontI
 
 TafwFont = class(TafwFontI)
  function NameStored: Boolean;
  function HeightStored: Boolean;
 end;//TafwFont
 
 RafwFont = class of TafwFont;
 
implementation

uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3Core
 , Windows
 , Classes
 , l3MemUtils
 , l3Interlocked
 , Forms
;

end.
