unit StyleEditorFontKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Settings/StyleEditorFontKeywordsPack.pas"
// Начат: 09.09.2009 16:29
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Основные прецеденты::Settings::View::Settings::Settings::StyleEditorFontKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы StyleEditorFont
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Forms
  {$IfEnd} //not NoVCL
  
  {$If not defined(NoVCL)}
  ,
  ExtCtrls
  {$IfEnd} //not NoVCL
  ,
  vtComboBoxQS,
  StyleEditorFont_Form,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtCheckBox,
  ElPopBtn,
  vtColorBox,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_StyleEditorFont = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы StyleEditorFont
----
*Пример использования*:
[code]
'aControl' форма::StyleEditorFont TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_StyleEditorFont

// start class Tkw_Form_StyleEditorFont

class function Tkw_Form_StyleEditorFont.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::StyleEditorFont';
end;//Tkw_Form_StyleEditorFont.GetWordNameForRegister

function Tkw_Form_StyleEditorFont.GetString: AnsiString;
 {-}
begin
 Result := 'StyleEditorFontForm';
end;//Tkw_Form_StyleEditorFont.GetString

type
  Tkw_StyleEditorFont_Control_FontScrollBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontScrollBox
----
*Пример использования*:
[code]
контрол::FontScrollBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontScrollBox

// start class Tkw_StyleEditorFont_Control_FontScrollBox

class function Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScrollBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontScrollBox';
end;//Tkw_StyleEditorFont_Control_FontScrollBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TScrollBox);
end;//Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontScrollBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontScrollBox
----
*Пример использования*:
[code]
контрол::FontScrollBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push

// start class Tkw_StyleEditorFont_Control_FontScrollBox_Push

procedure Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontScrollBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScrollBox:push';
end;//Tkw_StyleEditorFont_Control_FontScrollBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontUnderlineLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontUnderlineLabel
----
*Пример использования*:
[code]
контрол::FontUnderlineLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel

// start class Tkw_StyleEditorFont_Control_FontUnderlineLabel

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontUnderlineLabel';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontUnderlineLabel
----
*Пример использования*:
[code]
контрол::FontUnderlineLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push

// start class Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push

procedure Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontUnderlineLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineLabel:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontStrikeoutLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontStrikeoutLabel
----
*Пример использования*:
[code]
контрол::FontStrikeoutLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel

// start class Tkw_StyleEditorFont_Control_FontStrikeoutLabel

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontStrikeoutLabel';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontStrikeoutLabel
----
*Пример использования*:
[code]
контрол::FontStrikeoutLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push

// start class Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push

procedure Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontStrikeoutLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutLabel:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontSizeLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontSizeLabel
----
*Пример использования*:
[code]
контрол::FontSizeLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeLabel

// start class Tkw_StyleEditorFont_Control_FontSizeLabel

class function Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontSizeLabel';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontSizeLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontSizeLabel
----
*Пример использования*:
[code]
контрол::FontSizeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push

// start class Tkw_StyleEditorFont_Control_FontSizeLabel_Push

procedure Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontSizeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeLabel:push';
end;//Tkw_StyleEditorFont_Control_FontSizeLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontNameLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontNameLabel
----
*Пример использования*:
[code]
контрол::FontNameLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontNameLabel

// start class Tkw_StyleEditorFont_Control_FontNameLabel

class function Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontNameLabel';
end;//Tkw_StyleEditorFont_Control_FontNameLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontNameLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontNameLabel
----
*Пример использования*:
[code]
контрол::FontNameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push

// start class Tkw_StyleEditorFont_Control_FontNameLabel_Push

procedure Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontNameLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameLabel:push';
end;//Tkw_StyleEditorFont_Control_FontNameLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontItalicLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontItalicLabel
----
*Пример использования*:
[code]
контрол::FontItalicLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicLabel

// start class Tkw_StyleEditorFont_Control_FontItalicLabel

class function Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontItalicLabel';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontItalicLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontItalicLabel
----
*Пример использования*:
[code]
контрол::FontItalicLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push

// start class Tkw_StyleEditorFont_Control_FontItalicLabel_Push

procedure Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontItalicLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicLabel:push';
end;//Tkw_StyleEditorFont_Control_FontItalicLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontForeColorLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontForeColorLabel
----
*Пример использования*:
[code]
контрол::FontForeColorLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorLabel

// start class Tkw_StyleEditorFont_Control_FontForeColorLabel

class function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontForeColorLabel';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontForeColorLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontForeColorLabel
----
*Пример использования*:
[code]
контрол::FontForeColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push

// start class Tkw_StyleEditorFont_Control_FontForeColorLabel_Push

procedure Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontForeColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBoldLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBoldLabel
----
*Пример использования*:
[code]
контрол::FontBoldLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldLabel

// start class Tkw_StyleEditorFont_Control_FontBoldLabel

class function Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontBoldLabel';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBoldLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBoldLabel
----
*Пример использования*:
[code]
контрол::FontBoldLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push

// start class Tkw_StyleEditorFont_Control_FontBoldLabel_Push

procedure Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBoldLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBoldLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBackColorLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBackColorLabel
----
*Пример использования*:
[code]
контрол::FontBackColorLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorLabel

// start class Tkw_StyleEditorFont_Control_FontBackColorLabel

class function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontBackColorLabel';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBackColorLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBackColorLabel
----
*Пример использования*:
[code]
контрол::FontBackColorLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push

// start class Tkw_StyleEditorFont_Control_FontBackColorLabel_Push

procedure Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBackColorLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorLabel:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontScalableLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontScalableLabel
----
*Пример использования*:
[code]
контрол::FontScalableLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableLabel

// start class Tkw_StyleEditorFont_Control_FontScalableLabel

class function Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FontScalableLabel';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontScalableLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontScalableLabel
----
*Пример использования*:
[code]
контрол::FontScalableLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push

// start class Tkw_StyleEditorFont_Control_FontScalableLabel_Push

procedure Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontScalableLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableLabel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontScalableBevel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontScalableBevel
----
*Пример использования*:
[code]
контрол::FontScalableBevel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableBevel

// start class Tkw_StyleEditorFont_Control_FontScalableBevel

class function Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableBevel.GetString: AnsiString;
 {-}
begin
 Result := 'FontScalableBevel';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TBevel);
end;//Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontScalableBevel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontScalableBevel
----
*Пример использования*:
[code]
контрол::FontScalableBevel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push

// start class Tkw_StyleEditorFont_Control_FontScalableBevel_Push

procedure Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontScalableBevel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableBevel:push';
end;//Tkw_StyleEditorFont_Control_FontScalableBevel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]
контрол::FontStrikeoutInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontStrikeoutInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontStrikeoutInheritanceButton
----
*Пример использования*:
[code]
контрол::FontStrikeoutInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontStrikeoutInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontSizeInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]
контрол::FontSizeInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontSizeInheritanceButton

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontSizeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontSizeInheritanceButton
----
*Пример использования*:
[code]
контрол::FontSizeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontSizeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontNameInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontNameInheritanceButton
----
*Пример использования*:
[code]
контрол::FontNameInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontNameInheritanceButton

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontNameInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontNameInheritanceButton
----
*Пример использования*:
[code]
контрол::FontNameInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontNameInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontItalicInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]
контрол::FontItalicInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontItalicInheritanceButton

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontItalicInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontItalicInheritanceButton
----
*Пример использования*:
[code]
контрол::FontItalicInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontItalicInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontForeColorInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontForeColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontForeColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontForeColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontForeColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBoldInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBoldInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontBoldInheritanceButton

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontBoldInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBoldInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBoldInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBoldInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBackColorInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontBackColorInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBackColorInheritanceButton
----
*Пример использования*:
[code]
контрол::FontBackColorInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBackColorInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]
контрол::FontUnderlineInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton

// start class Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FontUnderlineInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontUnderlineInheritanceButton
----
*Пример использования*:
[code]
контрол::FontUnderlineInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontUnderlineInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontUnderlineCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]
контрол::FontUnderlineCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox

// start class Tkw_StyleEditorFont_Control_FontUnderlineCheckBox

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontUnderlineCheckBox';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontUnderlineCheckBox
----
*Пример использования*:
[code]
контрол::FontUnderlineCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push

// start class Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push

procedure Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontUnderlineCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontUnderlineCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]
контрол::FontStrikeoutCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox

// start class Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontStrikeoutCheckBox';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontStrikeoutCheckBox
----
*Пример использования*:
[code]
контрол::FontStrikeoutCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push

// start class Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push

procedure Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontStrikeoutCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontStrikeoutCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontSizeComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontSizeComboBox
----
*Пример использования*:
[code]
контрол::FontSizeComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeComboBox

// start class Tkw_StyleEditorFont_Control_FontSizeComboBox

class function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontSizeComboBox';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontSizeComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontSizeComboBox
----
*Пример использования*:
[code]
контрол::FontSizeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push

// start class Tkw_StyleEditorFont_Control_FontSizeComboBox_Push

procedure Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontSizeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontSizeComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontNameComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontNameComboBox
----
*Пример использования*:
[code]
контрол::FontNameComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontNameComboBox

// start class Tkw_StyleEditorFont_Control_FontNameComboBox

class function Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontNameComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontNameComboBox';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontNameComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontNameComboBox
----
*Пример использования*:
[code]
контрол::FontNameComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push

// start class Tkw_StyleEditorFont_Control_FontNameComboBox_Push

procedure Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontNameComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontNameComboBox:push';
end;//Tkw_StyleEditorFont_Control_FontNameComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontItalicCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontItalicCheckBox
----
*Пример использования*:
[code]
контрол::FontItalicCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox

// start class Tkw_StyleEditorFont_Control_FontItalicCheckBox

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontItalicCheckBox';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontItalicCheckBox
----
*Пример использования*:
[code]
контрол::FontItalicCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push

// start class Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push

procedure Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontItalicCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontItalicCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontForeColorBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontForeColorBox
----
*Пример использования*:
[code]
контрол::FontForeColorBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorBox

// start class Tkw_StyleEditorFont_Control_FontForeColorBox

class function Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontForeColorBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontForeColorBox';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtColorBox);
end;//Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontForeColorBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontForeColorBox
----
*Пример использования*:
[code]
контрол::FontForeColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push

// start class Tkw_StyleEditorFont_Control_FontForeColorBox_Push

procedure Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontForeColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontForeColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontForeColorBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBoldCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBoldCheckBox
----
*Пример использования*:
[code]
контрол::FontBoldCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox

// start class Tkw_StyleEditorFont_Control_FontBoldCheckBox

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontBoldCheckBox';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBoldCheckBox
----
*Пример использования*:
[code]
контрол::FontBoldCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push

// start class Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push

procedure Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBoldCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBoldCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontBackColorBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontBackColorBox
----
*Пример использования*:
[code]
контрол::FontBackColorBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorBox

// start class Tkw_StyleEditorFont_Control_FontBackColorBox

class function Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontBackColorBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontBackColorBox';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtColorBox);
end;//Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontBackColorBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontBackColorBox
----
*Пример использования*:
[code]
контрол::FontBackColorBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push

// start class Tkw_StyleEditorFont_Control_FontBackColorBox_Push

procedure Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontBackColorBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontBackColorBox:push';
end;//Tkw_StyleEditorFont_Control_FontBackColorBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FontScalableCheckBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FontScalableCheckBox
----
*Пример использования*:
[code]
контрол::FontScalableCheckBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox

// start class Tkw_StyleEditorFont_Control_FontScalableCheckBox

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString: AnsiString;
 {-}
begin
 Result := 'FontScalableCheckBox';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.GetString

class procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtCheckBox);
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FontScalableCheckBox
----
*Пример использования*:
[code]
контрол::FontScalableCheckBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push

// start class Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push

procedure Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FontScalableCheckBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FontScalableCheckBox:push';
end;//Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_LeftIndentLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LeftIndentLabel
----
*Пример использования*:
[code]
контрол::LeftIndentLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentLabel

// start class Tkw_StyleEditorFont_Control_LeftIndentLabel

class function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString: AnsiString;
 {-}
begin
 Result := 'LeftIndentLabel';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_LeftIndentLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LeftIndentLabel
----
*Пример использования*:
[code]
контрол::LeftIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push

// start class Tkw_StyleEditorFont_Control_LeftIndentLabel_Push

procedure Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_LeftIndentComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LeftIndentComboBox
----
*Пример использования*:
[code]
контрол::LeftIndentComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox

// start class Tkw_StyleEditorFont_Control_LeftIndentComboBox

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'LeftIndentComboBox';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LeftIndentComboBox
----
*Пример использования*:
[code]
контрол::LeftIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push

// start class Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push

procedure Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_RightIndentLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RightIndentLabel
----
*Пример использования*:
[code]
контрол::RightIndentLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentLabel

// start class Tkw_StyleEditorFont_Control_RightIndentLabel

class function Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentLabel.GetString: AnsiString;
 {-}
begin
 Result := 'RightIndentLabel';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_RightIndentLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RightIndentLabel
----
*Пример использования*:
[code]
контрол::RightIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push

// start class Tkw_StyleEditorFont_Control_RightIndentLabel_Push

procedure Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_RightIndentLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_RightIndentComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RightIndentComboBox
----
*Пример использования*:
[code]
контрол::RightIndentComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentComboBox

// start class Tkw_StyleEditorFont_Control_RightIndentComboBox

class function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'RightIndentComboBox';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_RightIndentComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RightIndentComboBox
----
*Пример использования*:
[code]
контрол::RightIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push

// start class Tkw_StyleEditorFont_Control_RightIndentComboBox_Push

procedure Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FirstIndentLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FirstIndentLabel
----
*Пример использования*:
[code]
контрол::FirstIndentLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentLabel

// start class Tkw_StyleEditorFont_Control_FirstIndentLabel

class function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString: AnsiString;
 {-}
begin
 Result := 'FirstIndentLabel';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FirstIndentLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FirstIndentLabel
----
*Пример использования*:
[code]
контрол::FirstIndentLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push

// start class Tkw_StyleEditorFont_Control_FirstIndentLabel_Push

procedure Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FirstIndentLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentLabel:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FirstIndentComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FirstIndentComboBox
----
*Пример использования*:
[code]
контрол::FirstIndentComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox

// start class Tkw_StyleEditorFont_Control_FirstIndentComboBox

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'FirstIndentComboBox';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FirstIndentComboBox
----
*Пример использования*:
[code]
контрол::FirstIndentComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push

// start class Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push

procedure Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FirstIndentComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentComboBox:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceBeforeLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceBeforeLabel
----
*Пример использования*:
[code]
контрол::SpaceBeforeLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel

// start class Tkw_StyleEditorFont_Control_SpaceBeforeLabel

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceBeforeLabel';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceBeforeLabel
----
*Пример использования*:
[code]
контрол::SpaceBeforeLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push

// start class Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push

procedure Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceBeforeLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceBeforeComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]
контрол::SpaceBeforeComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox

// start class Tkw_StyleEditorFont_Control_SpaceBeforeComboBox

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceBeforeComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceBeforeComboBox
----
*Пример использования*:
[code]
контрол::SpaceBeforeComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push

// start class Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push

procedure Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceBeforeComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceAfterLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceAfterLabel
----
*Пример использования*:
[code]
контрол::SpaceAfterLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel

// start class Tkw_StyleEditorFont_Control_SpaceAfterLabel

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceAfterLabel';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceAfterLabel
----
*Пример использования*:
[code]
контрол::SpaceAfterLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push

// start class Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push

procedure Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceAfterLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterLabel:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceAfterComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceAfterComboBox
----
*Пример использования*:
[code]
контрол::SpaceAfterComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox

// start class Tkw_StyleEditorFont_Control_SpaceAfterComboBox

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceAfterComboBox';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceAfterComboBox
----
*Пример использования*:
[code]
контрол::SpaceAfterComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push

// start class Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push

procedure Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceAfterComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterComboBox:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::LeftIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton

// start class Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'LeftIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола LeftIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::LeftIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('LeftIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::LeftIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_RightIndentInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::RightIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton

// start class Tkw_StyleEditorFont_Control_RightIndentInheritanceButton

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'RightIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола RightIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::RightIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('RightIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::RightIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::FirstIndentInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton

// start class Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'FirstIndentInheritanceButton';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола FirstIndentInheritanceButton
----
*Пример использования*:
[code]
контрол::FirstIndentInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('FirstIndentInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::FirstIndentInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceBeforeInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton

// start class Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceBeforeInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceBeforeInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceBeforeInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceBeforeInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceBeforeInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceAfterInheritanceButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton

// start class Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString: AnsiString;
 {-}
begin
 Result := 'SpaceAfterInheritanceButton';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.GetString

class procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола SpaceAfterInheritanceButton
----
*Пример использования*:
[code]
контрол::SpaceAfterInheritanceButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push

// start class Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push

procedure Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('SpaceAfterInheritanceButton');
 inherited;
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::SpaceAfterInheritanceButton:push';
end;//Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_StyleCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола StyleCaptionLabel
----
*Пример использования*:
[code]
контрол::StyleCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel

// start class Tkw_StyleEditorFont_Control_StyleCaptionLabel

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'StyleCaptionLabel';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола StyleCaptionLabel
----
*Пример использования*:
[code]
контрол::StyleCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push

// start class Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push

procedure Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StyleCaptionLabel');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StyleCaptionLabel:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_StyleEditorFont_Control_StyleCaptionComboBox = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола StyleCaptionComboBox
----
*Пример использования*:
[code]
контрол::StyleCaptionComboBox TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox

// start class Tkw_StyleEditorFont_Control_StyleCaptionComboBox

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetWordNameForRegister

function Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString: AnsiString;
 {-}
begin
 Result := 'StyleCaptionComboBox';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.GetString

class procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtComboBoxQS);
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine

type
  Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола StyleCaptionComboBox
----
*Пример использования*:
[code]
контрол::StyleCaptionComboBox:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push

// start class Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push

procedure Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('StyleCaptionComboBox');
 inherited;
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.DoDoIt

class function Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::StyleCaptionComboBox:push';
end;//Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.GetWordNameForRegister

type
  TkwStyleEditorFontFormFontScrollBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontScrollBox
[panel]Контрол FontScrollBox формы TStyleEditorFontForm[panel]
*Тип результата:* TScrollBox
*Пример:*
[code]
OBJECT VAR l_TScrollBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScrollBox >>> l_TScrollBox
[code]  }
  private
  // private methods
   function FontScrollBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontScrollBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontScrollBox

// start class TkwStyleEditorFontFormFontScrollBox

function TkwStyleEditorFontFormFontScrollBox.FontScrollBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TScrollBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontScrollBox;
end;//TkwStyleEditorFontFormFontScrollBox.FontScrollBox

procedure TkwStyleEditorFontFormFontScrollBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontScrollBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontScrollBox.DoDoIt

class function TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontScrollBox';
end;//TkwStyleEditorFontFormFontScrollBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScrollBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScrollBox', aCtx);
end;//TkwStyleEditorFontFormFontScrollBox.SetValuePrim

function TkwStyleEditorFontFormFontScrollBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TScrollBox);
end;//TkwStyleEditorFontFormFontScrollBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontScrollBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontScrollBox.GetAllParamsCount

function TkwStyleEditorFontFormFontScrollBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScrollBox.ParamsTypes

type
  TkwStyleEditorFontFormFontUnderlineLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontUnderlineLabel
[panel]Контрол FontUnderlineLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontUnderlineLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontUnderlineLabel

// start class TkwStyleEditorFontFormFontUnderlineLabel

function TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontUnderlineLabel;
end;//TkwStyleEditorFontFormFontUnderlineLabel.FontUnderlineLabel

procedure TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontUnderlineLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontUnderlineLabel.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontUnderlineLabel';
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineLabel', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineLabel.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontUnderlineLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontStrikeoutLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutLabel
[panel]Контрол FontStrikeoutLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontStrikeoutLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontStrikeoutLabel

// start class TkwStyleEditorFontFormFontStrikeoutLabel

function TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontStrikeoutLabel;
end;//TkwStyleEditorFontFormFontStrikeoutLabel.FontStrikeoutLabel

procedure TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontStrikeoutLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontStrikeoutLabel.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutLabel';
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutLabel', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontStrikeoutLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontSizeLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontSizeLabel
[panel]Контрол FontSizeLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontSizeLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontSizeLabel

// start class TkwStyleEditorFontFormFontSizeLabel

function TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontSizeLabel;
end;//TkwStyleEditorFontFormFontSizeLabel.FontSizeLabel

procedure TkwStyleEditorFontFormFontSizeLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontSizeLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontSizeLabel.DoDoIt

class function TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontSizeLabel';
end;//TkwStyleEditorFontFormFontSizeLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeLabel', aCtx);
end;//TkwStyleEditorFontFormFontSizeLabel.SetValuePrim

function TkwStyleEditorFontFormFontSizeLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontSizeLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontSizeLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontNameLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontNameLabel
[panel]Контрол FontNameLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontNameLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontNameLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontNameLabel

// start class TkwStyleEditorFontFormFontNameLabel

function TkwStyleEditorFontFormFontNameLabel.FontNameLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontNameLabel;
end;//TkwStyleEditorFontFormFontNameLabel.FontNameLabel

procedure TkwStyleEditorFontFormFontNameLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontNameLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontNameLabel.DoDoIt

class function TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontNameLabel';
end;//TkwStyleEditorFontFormFontNameLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameLabel', aCtx);
end;//TkwStyleEditorFontFormFontNameLabel.SetValuePrim

function TkwStyleEditorFontFormFontNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontNameLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontNameLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontNameLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontItalicLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontItalicLabel
[panel]Контрол FontItalicLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontItalicLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontItalicLabel

// start class TkwStyleEditorFontFormFontItalicLabel

function TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontItalicLabel;
end;//TkwStyleEditorFontFormFontItalicLabel.FontItalicLabel

procedure TkwStyleEditorFontFormFontItalicLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontItalicLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontItalicLabel.DoDoIt

class function TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontItalicLabel';
end;//TkwStyleEditorFontFormFontItalicLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicLabel', aCtx);
end;//TkwStyleEditorFontFormFontItalicLabel.SetValuePrim

function TkwStyleEditorFontFormFontItalicLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontItalicLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontItalicLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontForeColorLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontForeColorLabel
[panel]Контрол FontForeColorLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontForeColorLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontForeColorLabel

// start class TkwStyleEditorFontFormFontForeColorLabel

function TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontForeColorLabel;
end;//TkwStyleEditorFontFormFontForeColorLabel.FontForeColorLabel

procedure TkwStyleEditorFontFormFontForeColorLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontForeColorLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontForeColorLabel.DoDoIt

class function TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontForeColorLabel';
end;//TkwStyleEditorFontFormFontForeColorLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontForeColorLabel.SetValuePrim

function TkwStyleEditorFontFormFontForeColorLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontForeColorLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontForeColorLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontBoldLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBoldLabel
[panel]Контрол FontBoldLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontBoldLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBoldLabel

// start class TkwStyleEditorFontFormFontBoldLabel

function TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontBoldLabel;
end;//TkwStyleEditorFontFormFontBoldLabel.FontBoldLabel

procedure TkwStyleEditorFontFormFontBoldLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBoldLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBoldLabel.DoDoIt

class function TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBoldLabel';
end;//TkwStyleEditorFontFormFontBoldLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldLabel', aCtx);
end;//TkwStyleEditorFontFormFontBoldLabel.SetValuePrim

function TkwStyleEditorFontFormFontBoldLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontBoldLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBoldLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontBackColorLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBackColorLabel
[panel]Контрол FontBackColorLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontBackColorLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBackColorLabel

// start class TkwStyleEditorFontFormFontBackColorLabel

function TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontBackColorLabel;
end;//TkwStyleEditorFontFormFontBackColorLabel.FontBackColorLabel

procedure TkwStyleEditorFontFormFontBackColorLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBackColorLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBackColorLabel.DoDoIt

class function TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBackColorLabel';
end;//TkwStyleEditorFontFormFontBackColorLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorLabel', aCtx);
end;//TkwStyleEditorFontFormFontBackColorLabel.SetValuePrim

function TkwStyleEditorFontFormFontBackColorLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontBackColorLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBackColorLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontScalableLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontScalableLabel
[panel]Контрол FontScalableLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FontScalableLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontScalableLabel

// start class TkwStyleEditorFontFormFontScalableLabel

function TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FontScalableLabel;
end;//TkwStyleEditorFontFormFontScalableLabel.FontScalableLabel

procedure TkwStyleEditorFontFormFontScalableLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontScalableLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontScalableLabel.DoDoIt

class function TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontScalableLabel';
end;//TkwStyleEditorFontFormFontScalableLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableLabel', aCtx);
end;//TkwStyleEditorFontFormFontScalableLabel.SetValuePrim

function TkwStyleEditorFontFormFontScalableLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFontScalableLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontScalableLabel.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableLabel.ParamsTypes

type
  TkwStyleEditorFontFormFontScalableBevel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontScalableBevel
[panel]Контрол FontScalableBevel формы TStyleEditorFontForm[panel]
*Тип результата:* TBevel
*Пример:*
[code]
OBJECT VAR l_TBevel
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableBevel >>> l_TBevel
[code]  }
  private
  // private methods
   function FontScalableBevel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableBevel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontScalableBevel

// start class TkwStyleEditorFontFormFontScalableBevel

function TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TBevel;
 {-}
begin
 Result := aStyleEditorFontForm.FontScalableBevel;
end;//TkwStyleEditorFontFormFontScalableBevel.FontScalableBevel

procedure TkwStyleEditorFontFormFontScalableBevel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontScalableBevel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontScalableBevel.DoDoIt

class function TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontScalableBevel';
end;//TkwStyleEditorFontFormFontScalableBevel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableBevel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableBevel', aCtx);
end;//TkwStyleEditorFontFormFontScalableBevel.SetValuePrim

function TkwStyleEditorFontFormFontScalableBevel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TBevel);
end;//TkwStyleEditorFontFormFontScalableBevel.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableBevel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontScalableBevel.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableBevel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableBevel.ParamsTypes

type
  TkwStyleEditorFontFormFontStrikeoutInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton
[panel]Контрол FontStrikeoutInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton

// start class TkwStyleEditorFontFormFontStrikeoutInheritanceButton

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontStrikeoutInheritanceButton;
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.FontStrikeoutInheritanceButton

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontStrikeoutInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutInheritanceButton';
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontSizeInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontSizeInheritanceButton
[panel]Контрол FontSizeInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontSizeInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontSizeInheritanceButton

// start class TkwStyleEditorFontFormFontSizeInheritanceButton

function TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontSizeInheritanceButton;
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.FontSizeInheritanceButton

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontSizeInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontSizeInheritanceButton';
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontSizeInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontNameInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontNameInheritanceButton
[panel]Контрол FontNameInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontNameInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontNameInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontNameInheritanceButton

// start class TkwStyleEditorFontFormFontNameInheritanceButton

function TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontNameInheritanceButton;
end;//TkwStyleEditorFontFormFontNameInheritanceButton.FontNameInheritanceButton

procedure TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontNameInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontNameInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontNameInheritanceButton';
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontNameInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontNameInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontNameInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontItalicInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontItalicInheritanceButton
[panel]Контрол FontItalicInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontItalicInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontItalicInheritanceButton

// start class TkwStyleEditorFontFormFontItalicInheritanceButton

function TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontItalicInheritanceButton;
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.FontItalicInheritanceButton

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontItalicInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontItalicInheritanceButton';
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontItalicInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontForeColorInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton
[panel]Контрол FontForeColorInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontForeColorInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontForeColorInheritanceButton

// start class TkwStyleEditorFontFormFontForeColorInheritanceButton

function TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontForeColorInheritanceButton;
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.FontForeColorInheritanceButton

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontForeColorInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontForeColorInheritanceButton';
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontBoldInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBoldInheritanceButton
[panel]Контрол FontBoldInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontBoldInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBoldInheritanceButton

// start class TkwStyleEditorFontFormFontBoldInheritanceButton

function TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontBoldInheritanceButton;
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.FontBoldInheritanceButton

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBoldInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBoldInheritanceButton';
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontBoldInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontBackColorInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton
[panel]Контрол FontBackColorInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontBackColorInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBackColorInheritanceButton

// start class TkwStyleEditorFontFormFontBackColorInheritanceButton

function TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontBackColorInheritanceButton;
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.FontBackColorInheritanceButton

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBackColorInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBackColorInheritanceButton';
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontUnderlineInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton
[panel]Контрол FontUnderlineInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FontUnderlineInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton

// start class TkwStyleEditorFontFormFontUnderlineInheritanceButton

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FontUnderlineInheritanceButton;
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.FontUnderlineInheritanceButton

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontUnderlineInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontUnderlineInheritanceButton';
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFontUnderlineCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontUnderlineCheckBox
[panel]Контрол FontUnderlineCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontUnderlineCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function FontUnderlineCheckBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontUnderlineCheckBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontUnderlineCheckBox

// start class TkwStyleEditorFontFormFontUnderlineCheckBox

function TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontUnderlineCheckBox;
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.FontUnderlineCheckBox

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontUnderlineCheckBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontUnderlineCheckBox';
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontUnderlineCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontUnderlineCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontUnderlineCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontUnderlineCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontUnderlineCheckBox.ParamsTypes

type
  TkwStyleEditorFontFormFontStrikeoutCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox
[panel]Контрол FontStrikeoutCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontStrikeoutCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function FontStrikeoutCheckBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontStrikeoutCheckBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontStrikeoutCheckBox

// start class TkwStyleEditorFontFormFontStrikeoutCheckBox

function TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontStrikeoutCheckBox;
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.FontStrikeoutCheckBox

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontStrikeoutCheckBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontStrikeoutCheckBox';
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontStrikeoutCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontStrikeoutCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontStrikeoutCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontStrikeoutCheckBox.ParamsTypes

type
  TkwStyleEditorFontFormFontSizeComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontSizeComboBox
[panel]Контрол FontSizeComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontSizeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function FontSizeComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontSizeComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontSizeComboBox

// start class TkwStyleEditorFontFormFontSizeComboBox

function TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.FontSizeComboBox;
end;//TkwStyleEditorFontFormFontSizeComboBox.FontSizeComboBox

procedure TkwStyleEditorFontFormFontSizeComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontSizeComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontSizeComboBox.DoDoIt

class function TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontSizeComboBox';
end;//TkwStyleEditorFontFormFontSizeComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontSizeComboBox', aCtx);
end;//TkwStyleEditorFontFormFontSizeComboBox.SetValuePrim

function TkwStyleEditorFontFormFontSizeComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFontSizeComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontSizeComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontSizeComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFontSizeComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontSizeComboBox.ParamsTypes

type
  TkwStyleEditorFontFormFontNameComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontNameComboBox
[panel]Контрол FontNameComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FontNameComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function FontNameComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontNameComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontNameComboBox

// start class TkwStyleEditorFontFormFontNameComboBox

function TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.FontNameComboBox;
end;//TkwStyleEditorFontFormFontNameComboBox.FontNameComboBox

procedure TkwStyleEditorFontFormFontNameComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontNameComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontNameComboBox.DoDoIt

class function TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontNameComboBox';
end;//TkwStyleEditorFontFormFontNameComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontNameComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontNameComboBox', aCtx);
end;//TkwStyleEditorFontFormFontNameComboBox.SetValuePrim

function TkwStyleEditorFontFormFontNameComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFontNameComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontNameComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontNameComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFontNameComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontNameComboBox.ParamsTypes

type
  TkwStyleEditorFontFormFontItalicCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontItalicCheckBox
[panel]Контрол FontItalicCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontItalicCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function FontItalicCheckBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontItalicCheckBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontItalicCheckBox

// start class TkwStyleEditorFontFormFontItalicCheckBox

function TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontItalicCheckBox;
end;//TkwStyleEditorFontFormFontItalicCheckBox.FontItalicCheckBox

procedure TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontItalicCheckBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontItalicCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontItalicCheckBox';
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontItalicCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontItalicCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontItalicCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontItalicCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontItalicCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontItalicCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontItalicCheckBox.ParamsTypes

type
  TkwStyleEditorFontFormFontForeColorBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontForeColorBox
[panel]Контрол FontForeColorBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtColorBox
*Пример:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontForeColorBox >>> l_TvtColorBox
[code]  }
  private
  // private methods
   function FontForeColorBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontForeColorBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontForeColorBox

// start class TkwStyleEditorFontFormFontForeColorBox

function TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontForeColorBox;
end;//TkwStyleEditorFontFormFontForeColorBox.FontForeColorBox

procedure TkwStyleEditorFontFormFontForeColorBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontForeColorBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontForeColorBox.DoDoIt

class function TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontForeColorBox';
end;//TkwStyleEditorFontFormFontForeColorBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontForeColorBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontForeColorBox', aCtx);
end;//TkwStyleEditorFontFormFontForeColorBox.SetValuePrim

function TkwStyleEditorFontFormFontForeColorBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtColorBox);
end;//TkwStyleEditorFontFormFontForeColorBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontForeColorBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontForeColorBox.GetAllParamsCount

function TkwStyleEditorFontFormFontForeColorBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontForeColorBox.ParamsTypes

type
  TkwStyleEditorFontFormFontBoldCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBoldCheckBox
[panel]Контрол FontBoldCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBoldCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function FontBoldCheckBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBoldCheckBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBoldCheckBox

// start class TkwStyleEditorFontFormFontBoldCheckBox

function TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontBoldCheckBox;
end;//TkwStyleEditorFontFormFontBoldCheckBox.FontBoldCheckBox

procedure TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBoldCheckBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBoldCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBoldCheckBox';
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBoldCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontBoldCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontBoldCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontBoldCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBoldCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontBoldCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBoldCheckBox.ParamsTypes

type
  TkwStyleEditorFontFormFontBackColorBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontBackColorBox
[panel]Контрол FontBackColorBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtColorBox
*Пример:*
[code]
OBJECT VAR l_TvtColorBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontBackColorBox >>> l_TvtColorBox
[code]  }
  private
  // private methods
   function FontBackColorBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontBackColorBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontBackColorBox

// start class TkwStyleEditorFontFormFontBackColorBox

function TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtColorBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontBackColorBox;
end;//TkwStyleEditorFontFormFontBackColorBox.FontBackColorBox

procedure TkwStyleEditorFontFormFontBackColorBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontBackColorBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontBackColorBox.DoDoIt

class function TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontBackColorBox';
end;//TkwStyleEditorFontFormFontBackColorBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontBackColorBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontBackColorBox', aCtx);
end;//TkwStyleEditorFontFormFontBackColorBox.SetValuePrim

function TkwStyleEditorFontFormFontBackColorBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtColorBox);
end;//TkwStyleEditorFontFormFontBackColorBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontBackColorBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontBackColorBox.GetAllParamsCount

function TkwStyleEditorFontFormFontBackColorBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontBackColorBox.ParamsTypes

type
  TkwStyleEditorFontFormFontScalableCheckBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FontScalableCheckBox
[panel]Контрол FontScalableCheckBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtCheckBox
*Пример:*
[code]
OBJECT VAR l_TvtCheckBox
 aStyleEditorFontForm .TStyleEditorFontForm.FontScalableCheckBox >>> l_TvtCheckBox
[code]  }
  private
  // private methods
   function FontScalableCheckBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
     {* Реализация слова скрипта .TStyleEditorFontForm.FontScalableCheckBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFontScalableCheckBox

// start class TkwStyleEditorFontFormFontScalableCheckBox

function TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtCheckBox;
 {-}
begin
 Result := aStyleEditorFontForm.FontScalableCheckBox;
end;//TkwStyleEditorFontFormFontScalableCheckBox.FontScalableCheckBox

procedure TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FontScalableCheckBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFontScalableCheckBox.DoDoIt

class function TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FontScalableCheckBox';
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FontScalableCheckBox', aCtx);
end;//TkwStyleEditorFontFormFontScalableCheckBox.SetValuePrim

function TkwStyleEditorFontFormFontScalableCheckBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtCheckBox);
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetResultTypeInfo

function TkwStyleEditorFontFormFontScalableCheckBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFontScalableCheckBox.GetAllParamsCount

function TkwStyleEditorFontFormFontScalableCheckBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFontScalableCheckBox.ParamsTypes

type
  TkwStyleEditorFontFormLeftIndentLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.LeftIndentLabel
[panel]Контрол LeftIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LeftIndentLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormLeftIndentLabel

// start class TkwStyleEditorFontFormLeftIndentLabel

function TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.LeftIndentLabel;
end;//TkwStyleEditorFontFormLeftIndentLabel.LeftIndentLabel

procedure TkwStyleEditorFontFormLeftIndentLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftIndentLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormLeftIndentLabel.DoDoIt

class function TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.LeftIndentLabel';
end;//TkwStyleEditorFontFormLeftIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentLabel', aCtx);
end;//TkwStyleEditorFontFormLeftIndentLabel.SetValuePrim

function TkwStyleEditorFontFormLeftIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormLeftIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormLeftIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentLabel.ParamsTypes

type
  TkwStyleEditorFontFormLeftIndentComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.LeftIndentComboBox
[panel]Контрол LeftIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function LeftIndentComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormLeftIndentComboBox

// start class TkwStyleEditorFontFormLeftIndentComboBox

function TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.LeftIndentComboBox;
end;//TkwStyleEditorFontFormLeftIndentComboBox.LeftIndentComboBox

procedure TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftIndentComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormLeftIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.LeftIndentComboBox';
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormLeftIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormLeftIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormLeftIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentComboBox.ParamsTypes

type
  TkwStyleEditorFontFormRightIndentLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.RightIndentLabel
[panel]Контрол RightIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function RightIndentLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormRightIndentLabel

// start class TkwStyleEditorFontFormRightIndentLabel

function TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.RightIndentLabel;
end;//TkwStyleEditorFontFormRightIndentLabel.RightIndentLabel

procedure TkwStyleEditorFontFormRightIndentLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightIndentLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormRightIndentLabel.DoDoIt

class function TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.RightIndentLabel';
end;//TkwStyleEditorFontFormRightIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentLabel', aCtx);
end;//TkwStyleEditorFontFormRightIndentLabel.SetValuePrim

function TkwStyleEditorFontFormRightIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormRightIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormRightIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentLabel.ParamsTypes

type
  TkwStyleEditorFontFormRightIndentComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.RightIndentComboBox
[panel]Контрол RightIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function RightIndentComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormRightIndentComboBox

// start class TkwStyleEditorFontFormRightIndentComboBox

function TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.RightIndentComboBox;
end;//TkwStyleEditorFontFormRightIndentComboBox.RightIndentComboBox

procedure TkwStyleEditorFontFormRightIndentComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightIndentComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormRightIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.RightIndentComboBox';
end;//TkwStyleEditorFontFormRightIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormRightIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormRightIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormRightIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormRightIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentComboBox.ParamsTypes

type
  TkwStyleEditorFontFormFirstIndentLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FirstIndentLabel
[panel]Контрол FirstIndentLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function FirstIndentLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFirstIndentLabel

// start class TkwStyleEditorFontFormFirstIndentLabel

function TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.FirstIndentLabel;
end;//TkwStyleEditorFontFormFirstIndentLabel.FirstIndentLabel

procedure TkwStyleEditorFontFormFirstIndentLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FirstIndentLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFirstIndentLabel.DoDoIt

class function TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FirstIndentLabel';
end;//TkwStyleEditorFontFormFirstIndentLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentLabel', aCtx);
end;//TkwStyleEditorFontFormFirstIndentLabel.SetValuePrim

function TkwStyleEditorFontFormFirstIndentLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormFirstIndentLabel.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFirstIndentLabel.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentLabel.ParamsTypes

type
  TkwStyleEditorFontFormFirstIndentComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FirstIndentComboBox
[panel]Контрол FirstIndentComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function FirstIndentComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFirstIndentComboBox

// start class TkwStyleEditorFontFormFirstIndentComboBox

function TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.FirstIndentComboBox;
end;//TkwStyleEditorFontFormFirstIndentComboBox.FirstIndentComboBox

procedure TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FirstIndentComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFirstIndentComboBox.DoDoIt

class function TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FirstIndentComboBox';
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentComboBox', aCtx);
end;//TkwStyleEditorFontFormFirstIndentComboBox.SetValuePrim

function TkwStyleEditorFontFormFirstIndentComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFirstIndentComboBox.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentComboBox.ParamsTypes

type
  TkwStyleEditorFontFormSpaceBeforeLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeLabel
[panel]Контрол SpaceBeforeLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function SpaceBeforeLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceBeforeLabel

// start class TkwStyleEditorFontFormSpaceBeforeLabel

function TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceBeforeLabel;
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SpaceBeforeLabel

procedure TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceBeforeLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceBeforeLabel.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeLabel';
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceBeforeLabel.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeLabel.ParamsTypes

type
  TkwStyleEditorFontFormSpaceBeforeComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeComboBox
[panel]Контрол SpaceBeforeComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function SpaceBeforeComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceBeforeComboBox

// start class TkwStyleEditorFontFormSpaceBeforeComboBox

function TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceBeforeComboBox;
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SpaceBeforeComboBox

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceBeforeComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeComboBox';
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeComboBox.ParamsTypes

type
  TkwStyleEditorFontFormSpaceAfterLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceAfterLabel
[panel]Контрол SpaceAfterLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function SpaceAfterLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceAfterLabel

// start class TkwStyleEditorFontFormSpaceAfterLabel

function TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceAfterLabel;
end;//TkwStyleEditorFontFormSpaceAfterLabel.SpaceAfterLabel

procedure TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceAfterLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceAfterLabel.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceAfterLabel';
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterLabel', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterLabel.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceAfterLabel.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterLabel.ParamsTypes

type
  TkwStyleEditorFontFormSpaceAfterComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceAfterComboBox
[panel]Контрол SpaceAfterComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function SpaceAfterComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceAfterComboBox

// start class TkwStyleEditorFontFormSpaceAfterComboBox

function TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceAfterComboBox;
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SpaceAfterComboBox

procedure TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceAfterComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceAfterComboBox.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceAfterComboBox';
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterComboBox', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceAfterComboBox.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterComboBox.ParamsTypes

type
  TkwStyleEditorFontFormLeftIndentInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton
[panel]Контрол LeftIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.LeftIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function LeftIndentInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.LeftIndentInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormLeftIndentInheritanceButton

// start class TkwStyleEditorFontFormLeftIndentInheritanceButton

function TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.LeftIndentInheritanceButton;
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.LeftIndentInheritanceButton

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((LeftIndentInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.LeftIndentInheritanceButton';
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству LeftIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormLeftIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormLeftIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormLeftIndentInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormRightIndentInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.RightIndentInheritanceButton
[panel]Контрол RightIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.RightIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function RightIndentInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.RightIndentInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormRightIndentInheritanceButton

// start class TkwStyleEditorFontFormRightIndentInheritanceButton

function TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.RightIndentInheritanceButton;
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.RightIndentInheritanceButton

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((RightIndentInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.RightIndentInheritanceButton';
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству RightIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormRightIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormRightIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormRightIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormRightIndentInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormFirstIndentInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton
[panel]Контрол FirstIndentInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.FirstIndentInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function FirstIndentInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.FirstIndentInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormFirstIndentInheritanceButton

// start class TkwStyleEditorFontFormFirstIndentInheritanceButton

function TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.FirstIndentInheritanceButton;
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.FirstIndentInheritanceButton

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((FirstIndentInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.FirstIndentInheritanceButton';
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству FirstIndentInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormFirstIndentInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormFirstIndentInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormFirstIndentInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormSpaceBeforeInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton
[panel]Контрол SpaceBeforeInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceBeforeInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceBeforeInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton

// start class TkwStyleEditorFontFormSpaceBeforeInheritanceButton

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceBeforeInheritanceButton;
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SpaceBeforeInheritanceButton

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceBeforeInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceBeforeInheritanceButton';
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceBeforeInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormSpaceBeforeInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceBeforeInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormSpaceAfterInheritanceButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton
[panel]Контрол SpaceAfterInheritanceButton формы TStyleEditorFontForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aStyleEditorFontForm .TStyleEditorFontForm.SpaceAfterInheritanceButton >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function SpaceAfterInheritanceButton(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
     {* Реализация слова скрипта .TStyleEditorFontForm.SpaceAfterInheritanceButton }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton

// start class TkwStyleEditorFontFormSpaceAfterInheritanceButton

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TElPopupButton;
 {-}
begin
 Result := aStyleEditorFontForm.SpaceAfterInheritanceButton;
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SpaceAfterInheritanceButton

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((SpaceAfterInheritanceButton(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.DoDoIt

class function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.SpaceAfterInheritanceButton';
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetWordNameForRegister

procedure TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству SpaceAfterInheritanceButton', aCtx);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.SetValuePrim

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetResultTypeInfo

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.GetAllParamsCount

function TkwStyleEditorFontFormSpaceAfterInheritanceButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormSpaceAfterInheritanceButton.ParamsTypes

type
  TkwStyleEditorFontFormStyleCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.StyleCaptionLabel
[panel]Контрол StyleCaptionLabel формы TStyleEditorFontForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function StyleCaptionLabel(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
     {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionLabel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormStyleCaptionLabel

// start class TkwStyleEditorFontFormStyleCaptionLabel

function TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtLabel;
 {-}
begin
 Result := aStyleEditorFontForm.StyleCaptionLabel;
end;//TkwStyleEditorFontFormStyleCaptionLabel.StyleCaptionLabel

procedure TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((StyleCaptionLabel(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormStyleCaptionLabel.DoDoIt

class function TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.StyleCaptionLabel';
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetWordNameForRegister

procedure TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StyleCaptionLabel', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionLabel.SetValuePrim

function TkwStyleEditorFontFormStyleCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetResultTypeInfo

function TkwStyleEditorFontFormStyleCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormStyleCaptionLabel.GetAllParamsCount

function TkwStyleEditorFontFormStyleCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormStyleCaptionLabel.ParamsTypes

type
  TkwStyleEditorFontFormStyleCaptionComboBox = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TStyleEditorFontForm.StyleCaptionComboBox
[panel]Контрол StyleCaptionComboBox формы TStyleEditorFontForm[panel]
*Тип результата:* TvtComboBoxQS
*Пример:*
[code]
OBJECT VAR l_TvtComboBoxQS
 aStyleEditorFontForm .TStyleEditorFontForm.StyleCaptionComboBox >>> l_TvtComboBoxQS
[code]  }
  private
  // private methods
   function StyleCaptionComboBox(const aCtx: TtfwContext;
     aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
     {* Реализация слова скрипта .TStyleEditorFontForm.StyleCaptionComboBox }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwStyleEditorFontFormStyleCaptionComboBox

// start class TkwStyleEditorFontFormStyleCaptionComboBox

function TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox(const aCtx: TtfwContext;
  aStyleEditorFontForm: TStyleEditorFontForm): TvtComboBoxQS;
 {-}
begin
 Result := aStyleEditorFontForm.StyleCaptionComboBox;
end;//TkwStyleEditorFontFormStyleCaptionComboBox.StyleCaptionComboBox

procedure TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStyleEditorFontForm : TStyleEditorFontForm;
begin
 try
  l_aStyleEditorFontForm := TStyleEditorFontForm(aCtx.rEngine.PopObjAs(TStyleEditorFontForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStyleEditorFontForm: TStyleEditorFontForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((StyleCaptionComboBox(aCtx, l_aStyleEditorFontForm)));
end;//TkwStyleEditorFontFormStyleCaptionComboBox.DoDoIt

class function TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TStyleEditorFontForm.StyleCaptionComboBox';
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetWordNameForRegister

procedure TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству StyleCaptionComboBox', aCtx);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.SetValuePrim

function TkwStyleEditorFontFormStyleCaptionComboBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtComboBoxQS);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetResultTypeInfo

function TkwStyleEditorFontFormStyleCaptionComboBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStyleEditorFontFormStyleCaptionComboBox.GetAllParamsCount

function TkwStyleEditorFontFormStyleCaptionComboBox.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TStyleEditorFontForm)]);
end;//TkwStyleEditorFontFormStyleCaptionComboBox.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_StyleEditorFont
 Tkw_Form_StyleEditorFont.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScrollBox
 Tkw_StyleEditorFont_Control_FontScrollBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScrollBox_Push
 Tkw_StyleEditorFont_Control_FontScrollBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineLabel
 Tkw_StyleEditorFont_Control_FontUnderlineLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push
 Tkw_StyleEditorFont_Control_FontUnderlineLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutLabel
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push
 Tkw_StyleEditorFont_Control_FontStrikeoutLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeLabel
 Tkw_StyleEditorFont_Control_FontSizeLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeLabel_Push
 Tkw_StyleEditorFont_Control_FontSizeLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameLabel
 Tkw_StyleEditorFont_Control_FontNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameLabel_Push
 Tkw_StyleEditorFont_Control_FontNameLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicLabel
 Tkw_StyleEditorFont_Control_FontItalicLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicLabel_Push
 Tkw_StyleEditorFont_Control_FontItalicLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorLabel
 Tkw_StyleEditorFont_Control_FontForeColorLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorLabel_Push
 Tkw_StyleEditorFont_Control_FontForeColorLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldLabel
 Tkw_StyleEditorFont_Control_FontBoldLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldLabel_Push
 Tkw_StyleEditorFont_Control_FontBoldLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorLabel
 Tkw_StyleEditorFont_Control_FontBackColorLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorLabel_Push
 Tkw_StyleEditorFont_Control_FontBackColorLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableLabel
 Tkw_StyleEditorFont_Control_FontScalableLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableLabel_Push
 Tkw_StyleEditorFont_Control_FontScalableLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableBevel
 Tkw_StyleEditorFont_Control_FontScalableBevel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableBevel_Push
 Tkw_StyleEditorFont_Control_FontScalableBevel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontStrikeoutInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeInheritanceButton
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontSizeInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameInheritanceButton
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontNameInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicInheritanceButton
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontItalicInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontForeColorInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldInheritanceButton
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontBoldInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontBackColorInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FontUnderlineInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineCheckBox
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push
 Tkw_StyleEditorFont_Control_FontUnderlineCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push
 Tkw_StyleEditorFont_Control_FontStrikeoutCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeComboBox
 Tkw_StyleEditorFont_Control_FontSizeComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontSizeComboBox_Push
 Tkw_StyleEditorFont_Control_FontSizeComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameComboBox
 Tkw_StyleEditorFont_Control_FontNameComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontNameComboBox_Push
 Tkw_StyleEditorFont_Control_FontNameComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicCheckBox
 Tkw_StyleEditorFont_Control_FontItalicCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push
 Tkw_StyleEditorFont_Control_FontItalicCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorBox
 Tkw_StyleEditorFont_Control_FontForeColorBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontForeColorBox_Push
 Tkw_StyleEditorFont_Control_FontForeColorBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldCheckBox
 Tkw_StyleEditorFont_Control_FontBoldCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push
 Tkw_StyleEditorFont_Control_FontBoldCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorBox
 Tkw_StyleEditorFont_Control_FontBackColorBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontBackColorBox_Push
 Tkw_StyleEditorFont_Control_FontBackColorBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableCheckBox
 Tkw_StyleEditorFont_Control_FontScalableCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push
 Tkw_StyleEditorFont_Control_FontScalableCheckBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentLabel
 Tkw_StyleEditorFont_Control_LeftIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentLabel_Push
 Tkw_StyleEditorFont_Control_LeftIndentLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentComboBox
 Tkw_StyleEditorFont_Control_LeftIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push
 Tkw_StyleEditorFont_Control_LeftIndentComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentLabel
 Tkw_StyleEditorFont_Control_RightIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentLabel_Push
 Tkw_StyleEditorFont_Control_RightIndentLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentComboBox
 Tkw_StyleEditorFont_Control_RightIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentComboBox_Push
 Tkw_StyleEditorFont_Control_RightIndentComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentLabel
 Tkw_StyleEditorFont_Control_FirstIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentLabel_Push
 Tkw_StyleEditorFont_Control_FirstIndentLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentComboBox
 Tkw_StyleEditorFont_Control_FirstIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push
 Tkw_StyleEditorFont_Control_FirstIndentComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeLabel
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push
 Tkw_StyleEditorFont_Control_SpaceBeforeLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeComboBox
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push
 Tkw_StyleEditorFont_Control_SpaceBeforeComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterLabel
 Tkw_StyleEditorFont_Control_SpaceAfterLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push
 Tkw_StyleEditorFont_Control_SpaceAfterLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterComboBox
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push
 Tkw_StyleEditorFont_Control_SpaceAfterComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push
 Tkw_StyleEditorFont_Control_LeftIndentInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentInheritanceButton
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push
 Tkw_StyleEditorFont_Control_RightIndentInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push
 Tkw_StyleEditorFont_Control_FirstIndentInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push
 Tkw_StyleEditorFont_Control_SpaceBeforeInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push
 Tkw_StyleEditorFont_Control_SpaceAfterInheritanceButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_StyleCaptionLabel
 Tkw_StyleEditorFont_Control_StyleCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push
 Tkw_StyleEditorFont_Control_StyleCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_StyleCaptionComboBox
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push
 Tkw_StyleEditorFont_Control_StyleCaptionComboBox_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontScrollBox
 TkwStyleEditorFontFormFontScrollBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontUnderlineLabel
 TkwStyleEditorFontFormFontUnderlineLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontStrikeoutLabel
 TkwStyleEditorFontFormFontStrikeoutLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontSizeLabel
 TkwStyleEditorFontFormFontSizeLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontNameLabel
 TkwStyleEditorFontFormFontNameLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontItalicLabel
 TkwStyleEditorFontFormFontItalicLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontForeColorLabel
 TkwStyleEditorFontFormFontForeColorLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBoldLabel
 TkwStyleEditorFontFormFontBoldLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBackColorLabel
 TkwStyleEditorFontFormFontBackColorLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontScalableLabel
 TkwStyleEditorFontFormFontScalableLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontScalableBevel
 TkwStyleEditorFontFormFontScalableBevel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontStrikeoutInheritanceButton
 TkwStyleEditorFontFormFontStrikeoutInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontSizeInheritanceButton
 TkwStyleEditorFontFormFontSizeInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontNameInheritanceButton
 TkwStyleEditorFontFormFontNameInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontItalicInheritanceButton
 TkwStyleEditorFontFormFontItalicInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontForeColorInheritanceButton
 TkwStyleEditorFontFormFontForeColorInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBoldInheritanceButton
 TkwStyleEditorFontFormFontBoldInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBackColorInheritanceButton
 TkwStyleEditorFontFormFontBackColorInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontUnderlineInheritanceButton
 TkwStyleEditorFontFormFontUnderlineInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontUnderlineCheckBox
 TkwStyleEditorFontFormFontUnderlineCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontStrikeoutCheckBox
 TkwStyleEditorFontFormFontStrikeoutCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontSizeComboBox
 TkwStyleEditorFontFormFontSizeComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontNameComboBox
 TkwStyleEditorFontFormFontNameComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontItalicCheckBox
 TkwStyleEditorFontFormFontItalicCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontForeColorBox
 TkwStyleEditorFontFormFontForeColorBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBoldCheckBox
 TkwStyleEditorFontFormFontBoldCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontBackColorBox
 TkwStyleEditorFontFormFontBackColorBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FontScalableCheckBox
 TkwStyleEditorFontFormFontScalableCheckBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_LeftIndentLabel
 TkwStyleEditorFontFormLeftIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_LeftIndentComboBox
 TkwStyleEditorFontFormLeftIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_RightIndentLabel
 TkwStyleEditorFontFormRightIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_RightIndentComboBox
 TkwStyleEditorFontFormRightIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FirstIndentLabel
 TkwStyleEditorFontFormFirstIndentLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FirstIndentComboBox
 TkwStyleEditorFontFormFirstIndentComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceBeforeLabel
 TkwStyleEditorFontFormSpaceBeforeLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceBeforeComboBox
 TkwStyleEditorFontFormSpaceBeforeComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceAfterLabel
 TkwStyleEditorFontFormSpaceAfterLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceAfterComboBox
 TkwStyleEditorFontFormSpaceAfterComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_LeftIndentInheritanceButton
 TkwStyleEditorFontFormLeftIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_RightIndentInheritanceButton
 TkwStyleEditorFontFormRightIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_FirstIndentInheritanceButton
 TkwStyleEditorFontFormFirstIndentInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceBeforeInheritanceButton
 TkwStyleEditorFontFormSpaceBeforeInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_SpaceAfterInheritanceButton
 TkwStyleEditorFontFormSpaceAfterInheritanceButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_StyleCaptionLabel
 TkwStyleEditorFontFormStyleCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация StyleEditorFontForm_StyleCaptionComboBox
 TkwStyleEditorFontFormStyleCaptionComboBox.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа StyleEditorFont
 TtfwTypeRegistrator.RegisterType(TypeInfo(TStyleEditorFontForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TScrollBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TScrollBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TBevel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TBevel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TElPopupButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtCheckBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCheckBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtComboBoxQS
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtComboBoxQS));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtColorBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtColorBox));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.