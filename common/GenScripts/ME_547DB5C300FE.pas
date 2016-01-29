unit evCustomFont;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 TevCustomFont = class(Il3FontInfo, Il3Font)
  function Size: Integer; overload;
   {* кегль. }
  function Name: TFontName; overload;
   {* гаринитура. }
  function Bold: Boolean; overload;
   {* жирный? }
  function Italic: Boolean; overload;
   {* курсив? }
  function Underline: Boolean; overload;
   {* подчеркнутый? }
  function Strikeout: Boolean; overload;
   {* зачеркнытый. }
  function ForeColor: Tl3Color; overload;
   {* цвет шрифта. }
  function BackColor: Tl3Color; overload;
   {* цвет фона. }
  function Pitch: TFontPitch; overload;
   {* кернинг. }
  function Index: Tl3FontIndex; overload;
   {* индекс. }
  function ForeColor: Tl3Color; overload;
   {* цвет шрифта. }
  function BackColor: Tl3Color; overload;
   {* цвет фона. }
  function Name: TFontName; overload;
   {* имя шрифта. }
  function Pitch: TFontPitch; overload;
   {* Кернинг. }
  function Size: Integer; overload;
   {* размер кегля. }
  function Index: Tl3FontIndex; overload;
   {* индекс шрифта. }
  function Style: TFontStyles;
  function Bold: Boolean; overload;
   {* жирный. }
  function Italic: Boolean; overload;
   {* курсив. }
  function Underline: Boolean; overload;
   {* подчеркивание. }
  function Strikeout: Boolean; overload;
   {* зачеркивание. }
  function AssignFont(Font: TFont): Boolean;
  procedure Assign2Font(const aFont: Il3Font);
  procedure Lock;
  procedure Unlock;
  function HF: hFont;
  function IsAtomic: Boolean;
   {* Строка для нанного шрифта представляет собой единый объект? }
  function FM: Il3FontMetrics;
   {* Метрики шрифта. }
 end;//TevCustomFont
 
implementation

uses
 l3ImplUses
;

end.
