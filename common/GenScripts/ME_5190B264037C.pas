unit FontWordsPack;

interface

uses
 l3IntfUses
 , l3Interfaces
 , l3Core
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TFontWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TFontWordsPackResNameGetter
 
 TkwFontColor = class(TtfwPropertyLike)
  {* ����� ������� Font:Color
*��� ����������:* Tl3Color
*������:*
[code]
TColor VAR l_Tl3Color
 aFont Font:Color >>> l_Tl3Color
[code]  }
  function Color(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Tl3Color;
   {* ���������� ����� ������� Font:Color }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontColor
 
 TkwFontBackColor = class(TtfwPropertyLike)
  {* ����� ������� Font:BackColor
*��� ����������:* Tl3Color
*������:*
[code]
TColor VAR l_Tl3Color
 aFont Font:BackColor >>> l_Tl3Color
[code]  }
  function BackColor(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Tl3Color;
   {* ���������� ����� ������� Font:BackColor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontBackColor
 
 TkwFontIsBold = class(TtfwPropertyLike)
  {* ����� ������� Font:IsBold
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsBold >>> l_Boolean
[code]  }
  function IsBold(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* ���������� ����� ������� Font:IsBold }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsBold
 
 TkwFontIsItalic = class(TtfwPropertyLike)
  {* ����� ������� Font:IsItalic
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsItalic >>> l_Boolean
[code]  }
  function IsItalic(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* ���������� ����� ������� Font:IsItalic }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsItalic
 
 TkwFontIsUnderline = class(TtfwPropertyLike)
  {* ����� ������� Font:IsUnderline
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsUnderline >>> l_Boolean
[code]  }
  function IsUnderline(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* ���������� ����� ������� Font:IsUnderline }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsUnderline
 
 TkwFontIsStrikeOut = class(TtfwPropertyLike)
  {* ����� ������� Font:IsStrikeOut
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsStrikeOut >>> l_Boolean
[code]  }
  function IsStrikeOut(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* ���������� ����� ������� Font:IsStrikeOut }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsStrikeOut
 
 TkwFontName = class(TtfwPropertyLike)
  {* ����� ������� Font:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aFont Font:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): AnsiString;
   {* ���������� ����� ������� Font:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontName
 
 TkwFontSize = class(TtfwPropertyLike)
  {* ����� ������� Font:Size
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aFont Font:Size >>> l_Integer
[code]  }
  function Size(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Integer;
   {* ���������� ����� ������� Font:Size }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontSize
 
end.
