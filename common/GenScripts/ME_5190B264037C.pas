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
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TFontWordsPackResNameGetter
 
 TkwFontColor = class(TtfwPropertyLike)
  {* Слово скрипта Font:Color
*Тип результата:* Tl3Color
*Пример:*
[code]
TColor VAR l_Tl3Color
 aFont Font:Color >>> l_Tl3Color
[code]  }
  function Color(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Tl3Color;
   {* Реализация слова скрипта Font:Color }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontColor
 
 TkwFontBackColor = class(TtfwPropertyLike)
  {* Слово скрипта Font:BackColor
*Тип результата:* Tl3Color
*Пример:*
[code]
TColor VAR l_Tl3Color
 aFont Font:BackColor >>> l_Tl3Color
[code]  }
  function BackColor(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Tl3Color;
   {* Реализация слова скрипта Font:BackColor }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontBackColor
 
 TkwFontIsBold = class(TtfwPropertyLike)
  {* Слово скрипта Font:IsBold
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsBold >>> l_Boolean
[code]  }
  function IsBold(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* Реализация слова скрипта Font:IsBold }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsBold
 
 TkwFontIsItalic = class(TtfwPropertyLike)
  {* Слово скрипта Font:IsItalic
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsItalic >>> l_Boolean
[code]  }
  function IsItalic(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* Реализация слова скрипта Font:IsItalic }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsItalic
 
 TkwFontIsUnderline = class(TtfwPropertyLike)
  {* Слово скрипта Font:IsUnderline
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsUnderline >>> l_Boolean
[code]  }
  function IsUnderline(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* Реализация слова скрипта Font:IsUnderline }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsUnderline
 
 TkwFontIsStrikeOut = class(TtfwPropertyLike)
  {* Слово скрипта Font:IsStrikeOut
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsStrikeOut >>> l_Boolean
[code]  }
  function IsStrikeOut(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Boolean;
   {* Реализация слова скрипта Font:IsStrikeOut }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontIsStrikeOut
 
 TkwFontName = class(TtfwPropertyLike)
  {* Слово скрипта Font:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aFont Font:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): AnsiString;
   {* Реализация слова скрипта Font:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontName
 
 TkwFontSize = class(TtfwPropertyLike)
  {* Слово скрипта Font:Size
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aFont Font:Size >>> l_Integer
[code]  }
  function Size(const aCtx: TtfwContext;
   const aFont: Il3FontInfo): Integer;
   {* Реализация слова скрипта Font:Size }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwFontSize
 
end.
