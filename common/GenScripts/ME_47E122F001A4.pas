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
  {* ����� � QueryInterface. }
 end;//TafwCastableFont
 
 TafwFontI = class(_l3Unknown_, IafwFont)
  procedure Create;
  function Make: IafwFont;
  function ForeColor: Tl3Color;
   {* ���� ������. }
  function BackColor: Tl3Color;
   {* ���� ����. }
  function Name: TFontName;
   {* ��� ������. }
  function Pitch: TFontPitch;
   {* �������. }
  function Size: Integer;
   {* ������ �����. }
  function Index: Tl3FontIndex;
   {* ������ ������. }
  function Style: TFontStyles;
  function Bold: Boolean;
   {* ������. }
  function Italic: Boolean;
   {* ������. }
  function Underline: Boolean;
   {* �������������. }
  function Strikeout: Boolean;
   {* ������������. }
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
