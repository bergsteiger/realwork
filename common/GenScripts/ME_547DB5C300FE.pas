unit evCustomFont;

interface

uses
 l3IntfUses
 , l3Interfaces
;

type
 TevCustomFont = class(Il3FontInfo, Il3Font)
  function Size: Integer; overload;
   {* �����. }
  function Name: TFontName; overload;
   {* ����������. }
  function Bold: Boolean; overload;
   {* ������? }
  function Italic: Boolean; overload;
   {* ������? }
  function Underline: Boolean; overload;
   {* ������������? }
  function Strikeout: Boolean; overload;
   {* �����������. }
  function ForeColor: Tl3Color; overload;
   {* ���� ������. }
  function BackColor: Tl3Color; overload;
   {* ���� ����. }
  function Pitch: TFontPitch; overload;
   {* �������. }
  function Index: Tl3FontIndex; overload;
   {* ������. }
  function ForeColor: Tl3Color; overload;
   {* ���� ������. }
  function BackColor: Tl3Color; overload;
   {* ���� ����. }
  function Name: TFontName; overload;
   {* ��� ������. }
  function Pitch: TFontPitch; overload;
   {* �������. }
  function Size: Integer; overload;
   {* ������ �����. }
  function Index: Tl3FontIndex; overload;
   {* ������ ������. }
  function Style: TFontStyles;
  function Bold: Boolean; overload;
   {* ������. }
  function Italic: Boolean; overload;
   {* ������. }
  function Underline: Boolean; overload;
   {* �������������. }
  function Strikeout: Boolean; overload;
   {* ������������. }
  function AssignFont(Font: TFont): Boolean;
  procedure Assign2Font(const aFont: Il3Font);
  procedure Lock;
  procedure Unlock;
  function HF: hFont;
  function IsAtomic: Boolean;
   {* ������ ��� ������� ������ ������������ ����� ������ ������? }
  function FM: Il3FontMetrics;
   {* ������� ������. }
 end;//TevCustomFont
 
implementation

uses
 l3ImplUses
;

end.
