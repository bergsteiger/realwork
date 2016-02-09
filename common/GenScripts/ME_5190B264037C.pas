unit FontWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
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
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *9F904801EF08ci*
 //#UC END# *9F904801EF08ci*
 //#UC START# *9F904801EF08cit*
 //#UC END# *9F904801EF08cit*
 TFontWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *9F904801EF08publ*
 //#UC END# *9F904801EF08publ*
 end;//TFontWordsPackResNameGetter

 TkwFontColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Color
*Тип результата:* Tl3Color
*Пример:*
[code]
TColor VAR l_Tl3Color
 aFont Font:Color >>> l_Tl3Color
[code]  }
  private
   function Color(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* Реализация слова скрипта Font:Color }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontColor

 TkwFontBackColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:BackColor
*Тип результата:* Tl3Color
*Пример:*
[code]
TColor VAR l_Tl3Color
 aFont Font:BackColor >>> l_Tl3Color
[code]  }
  private
   function BackColor(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* Реализация слова скрипта Font:BackColor }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontBackColor

 TkwFontIsBold = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsBold
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsBold >>> l_Boolean
[code]  }
  private
   function IsBold(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsBold }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontIsBold

 TkwFontIsItalic = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsItalic
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsItalic >>> l_Boolean
[code]  }
  private
   function IsItalic(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsItalic }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontIsItalic

 TkwFontIsUnderline = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsUnderline
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsUnderline >>> l_Boolean
[code]  }
  private
   function IsUnderline(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsUnderline }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontIsUnderline

 TkwFontIsStrikeOut = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsStrikeOut
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsStrikeOut >>> l_Boolean
[code]  }
  private
   function IsStrikeOut(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsStrikeOut }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontIsStrikeOut

 TkwFontName = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aFont Font:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): AnsiString;
    {* Реализация слова скрипта Font:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontName

 TkwFontSize = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Size
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aFont Font:Size >>> l_Integer
[code]  }
  private
   function Size(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Integer;
    {* Реализация слова скрипта Font:Size }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFontSize

class function TFontWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'FontWordsPack';
end;//TFontWordsPackResNameGetter.ResName

 {$R FontWordsPack.res}

function TkwFontColor.Color(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Tl3Color;
 {* Реализация слова скрипта Font:Color }
//#UC START# *7040B1F6FD7B_B42B6353E972_var*
//#UC END# *7040B1F6FD7B_B42B6353E972_var*
begin
//#UC START# *7040B1F6FD7B_B42B6353E972_impl*
 Result := aFont.ForeColor;
//#UC END# *7040B1F6FD7B_B42B6353E972_impl*
end;//TkwFontColor.Color

procedure TkwFontColor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B42B6353E972_var*
//#UC END# *4DAEEDE10285_B42B6353E972_var*
begin
//#UC START# *4DAEEDE10285_B42B6353E972_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B42B6353E972_impl*
end;//TkwFontColor.DoDoIt

class function TkwFontColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Color';
end;//TkwFontColor.GetWordNameForRegister

procedure TkwFontColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B42B6353E972_var*
//#UC END# *52D00B00031A_B42B6353E972_var*
begin
//#UC START# *52D00B00031A_B42B6353E972_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B42B6353E972_impl*
end;//TkwFontColor.SetValuePrim

function TkwFontColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B42B6353E972_var*
//#UC END# *551544E2001A_B42B6353E972_var*
begin
//#UC START# *551544E2001A_B42B6353E972_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B42B6353E972_impl*
end;//TkwFontColor.GetResultTypeInfo

function TkwFontColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_B42B6353E972_var*
//#UC END# *559687E6025A_B42B6353E972_var*
begin
//#UC START# *559687E6025A_B42B6353E972_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_B42B6353E972_impl*
end;//TkwFontColor.GetAllParamsCount

function TkwFontColor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B42B6353E972_var*
//#UC END# *5617F4D00243_B42B6353E972_var*
begin
//#UC START# *5617F4D00243_B42B6353E972_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B42B6353E972_impl*
end;//TkwFontColor.ParamsTypes

function TkwFontBackColor.BackColor(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Tl3Color;
 {* Реализация слова скрипта Font:BackColor }
//#UC START# *85B9473C71C2_ADDA8C159EED_var*
//#UC END# *85B9473C71C2_ADDA8C159EED_var*
begin
//#UC START# *85B9473C71C2_ADDA8C159EED_impl*
 Result := aFont.BackColor;
//#UC END# *85B9473C71C2_ADDA8C159EED_impl*
end;//TkwFontBackColor.BackColor

procedure TkwFontBackColor.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ADDA8C159EED_var*
//#UC END# *4DAEEDE10285_ADDA8C159EED_var*
begin
//#UC START# *4DAEEDE10285_ADDA8C159EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ADDA8C159EED_impl*
end;//TkwFontBackColor.DoDoIt

class function TkwFontBackColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:BackColor';
end;//TkwFontBackColor.GetWordNameForRegister

procedure TkwFontBackColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_ADDA8C159EED_var*
//#UC END# *52D00B00031A_ADDA8C159EED_var*
begin
//#UC START# *52D00B00031A_ADDA8C159EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_ADDA8C159EED_impl*
end;//TkwFontBackColor.SetValuePrim

function TkwFontBackColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_ADDA8C159EED_var*
//#UC END# *551544E2001A_ADDA8C159EED_var*
begin
//#UC START# *551544E2001A_ADDA8C159EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_ADDA8C159EED_impl*
end;//TkwFontBackColor.GetResultTypeInfo

function TkwFontBackColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_ADDA8C159EED_var*
//#UC END# *559687E6025A_ADDA8C159EED_var*
begin
//#UC START# *559687E6025A_ADDA8C159EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_ADDA8C159EED_impl*
end;//TkwFontBackColor.GetAllParamsCount

function TkwFontBackColor.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_ADDA8C159EED_var*
//#UC END# *5617F4D00243_ADDA8C159EED_var*
begin
//#UC START# *5617F4D00243_ADDA8C159EED_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_ADDA8C159EED_impl*
end;//TkwFontBackColor.ParamsTypes

function TkwFontIsBold.IsBold(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsBold }
//#UC START# *F4864359618B_6426AF77D4E5_var*
//#UC END# *F4864359618B_6426AF77D4E5_var*
begin
//#UC START# *F4864359618B_6426AF77D4E5_impl*
 Result := aFont.Bold;
//#UC END# *F4864359618B_6426AF77D4E5_impl*
end;//TkwFontIsBold.IsBold

procedure TkwFontIsBold.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6426AF77D4E5_var*
//#UC END# *4DAEEDE10285_6426AF77D4E5_var*
begin
//#UC START# *4DAEEDE10285_6426AF77D4E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6426AF77D4E5_impl*
end;//TkwFontIsBold.DoDoIt

class function TkwFontIsBold.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsBold';
end;//TkwFontIsBold.GetWordNameForRegister

procedure TkwFontIsBold.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6426AF77D4E5_var*
//#UC END# *52D00B00031A_6426AF77D4E5_var*
begin
//#UC START# *52D00B00031A_6426AF77D4E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6426AF77D4E5_impl*
end;//TkwFontIsBold.SetValuePrim

function TkwFontIsBold.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6426AF77D4E5_var*
//#UC END# *551544E2001A_6426AF77D4E5_var*
begin
//#UC START# *551544E2001A_6426AF77D4E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6426AF77D4E5_impl*
end;//TkwFontIsBold.GetResultTypeInfo

function TkwFontIsBold.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6426AF77D4E5_var*
//#UC END# *559687E6025A_6426AF77D4E5_var*
begin
//#UC START# *559687E6025A_6426AF77D4E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6426AF77D4E5_impl*
end;//TkwFontIsBold.GetAllParamsCount

function TkwFontIsBold.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6426AF77D4E5_var*
//#UC END# *5617F4D00243_6426AF77D4E5_var*
begin
//#UC START# *5617F4D00243_6426AF77D4E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6426AF77D4E5_impl*
end;//TkwFontIsBold.ParamsTypes

function TkwFontIsItalic.IsItalic(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsItalic }
//#UC START# *3EC3A4D3FAB3_FAD60EB55765_var*
//#UC END# *3EC3A4D3FAB3_FAD60EB55765_var*
begin
//#UC START# *3EC3A4D3FAB3_FAD60EB55765_impl*
 Result := aFont.Italic;
//#UC END# *3EC3A4D3FAB3_FAD60EB55765_impl*
end;//TkwFontIsItalic.IsItalic

procedure TkwFontIsItalic.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FAD60EB55765_var*
//#UC END# *4DAEEDE10285_FAD60EB55765_var*
begin
//#UC START# *4DAEEDE10285_FAD60EB55765_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FAD60EB55765_impl*
end;//TkwFontIsItalic.DoDoIt

class function TkwFontIsItalic.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsItalic';
end;//TkwFontIsItalic.GetWordNameForRegister

procedure TkwFontIsItalic.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_FAD60EB55765_var*
//#UC END# *52D00B00031A_FAD60EB55765_var*
begin
//#UC START# *52D00B00031A_FAD60EB55765_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_FAD60EB55765_impl*
end;//TkwFontIsItalic.SetValuePrim

function TkwFontIsItalic.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_FAD60EB55765_var*
//#UC END# *551544E2001A_FAD60EB55765_var*
begin
//#UC START# *551544E2001A_FAD60EB55765_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_FAD60EB55765_impl*
end;//TkwFontIsItalic.GetResultTypeInfo

function TkwFontIsItalic.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_FAD60EB55765_var*
//#UC END# *559687E6025A_FAD60EB55765_var*
begin
//#UC START# *559687E6025A_FAD60EB55765_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_FAD60EB55765_impl*
end;//TkwFontIsItalic.GetAllParamsCount

function TkwFontIsItalic.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_FAD60EB55765_var*
//#UC END# *5617F4D00243_FAD60EB55765_var*
begin
//#UC START# *5617F4D00243_FAD60EB55765_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_FAD60EB55765_impl*
end;//TkwFontIsItalic.ParamsTypes

function TkwFontIsUnderline.IsUnderline(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsUnderline }
//#UC START# *F84904DE8371_0A56585439B0_var*
//#UC END# *F84904DE8371_0A56585439B0_var*
begin
//#UC START# *F84904DE8371_0A56585439B0_impl*
 Result := aFont.Underline;
//#UC END# *F84904DE8371_0A56585439B0_impl*
end;//TkwFontIsUnderline.IsUnderline

procedure TkwFontIsUnderline.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0A56585439B0_var*
//#UC END# *4DAEEDE10285_0A56585439B0_var*
begin
//#UC START# *4DAEEDE10285_0A56585439B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0A56585439B0_impl*
end;//TkwFontIsUnderline.DoDoIt

class function TkwFontIsUnderline.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsUnderline';
end;//TkwFontIsUnderline.GetWordNameForRegister

procedure TkwFontIsUnderline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_0A56585439B0_var*
//#UC END# *52D00B00031A_0A56585439B0_var*
begin
//#UC START# *52D00B00031A_0A56585439B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_0A56585439B0_impl*
end;//TkwFontIsUnderline.SetValuePrim

function TkwFontIsUnderline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_0A56585439B0_var*
//#UC END# *551544E2001A_0A56585439B0_var*
begin
//#UC START# *551544E2001A_0A56585439B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_0A56585439B0_impl*
end;//TkwFontIsUnderline.GetResultTypeInfo

function TkwFontIsUnderline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_0A56585439B0_var*
//#UC END# *559687E6025A_0A56585439B0_var*
begin
//#UC START# *559687E6025A_0A56585439B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_0A56585439B0_impl*
end;//TkwFontIsUnderline.GetAllParamsCount

function TkwFontIsUnderline.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_0A56585439B0_var*
//#UC END# *5617F4D00243_0A56585439B0_var*
begin
//#UC START# *5617F4D00243_0A56585439B0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_0A56585439B0_impl*
end;//TkwFontIsUnderline.ParamsTypes

function TkwFontIsStrikeOut.IsStrikeOut(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsStrikeOut }
//#UC START# *56B18ED23F7B_48690441DF69_var*
//#UC END# *56B18ED23F7B_48690441DF69_var*
begin
//#UC START# *56B18ED23F7B_48690441DF69_impl*
 Result := aFont.Strikeout;
//#UC END# *56B18ED23F7B_48690441DF69_impl*
end;//TkwFontIsStrikeOut.IsStrikeOut

procedure TkwFontIsStrikeOut.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_48690441DF69_var*
//#UC END# *4DAEEDE10285_48690441DF69_var*
begin
//#UC START# *4DAEEDE10285_48690441DF69_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_48690441DF69_impl*
end;//TkwFontIsStrikeOut.DoDoIt

class function TkwFontIsStrikeOut.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsStrikeOut';
end;//TkwFontIsStrikeOut.GetWordNameForRegister

procedure TkwFontIsStrikeOut.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_48690441DF69_var*
//#UC END# *52D00B00031A_48690441DF69_var*
begin
//#UC START# *52D00B00031A_48690441DF69_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_48690441DF69_impl*
end;//TkwFontIsStrikeOut.SetValuePrim

function TkwFontIsStrikeOut.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_48690441DF69_var*
//#UC END# *551544E2001A_48690441DF69_var*
begin
//#UC START# *551544E2001A_48690441DF69_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_48690441DF69_impl*
end;//TkwFontIsStrikeOut.GetResultTypeInfo

function TkwFontIsStrikeOut.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_48690441DF69_var*
//#UC END# *559687E6025A_48690441DF69_var*
begin
//#UC START# *559687E6025A_48690441DF69_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_48690441DF69_impl*
end;//TkwFontIsStrikeOut.GetAllParamsCount

function TkwFontIsStrikeOut.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_48690441DF69_var*
//#UC END# *5617F4D00243_48690441DF69_var*
begin
//#UC START# *5617F4D00243_48690441DF69_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_48690441DF69_impl*
end;//TkwFontIsStrikeOut.ParamsTypes

function TkwFontName.Name(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): AnsiString;
 {* Реализация слова скрипта Font:Name }
//#UC START# *5822CA56AAFA_7A73CF636A32_var*
//#UC END# *5822CA56AAFA_7A73CF636A32_var*
begin
//#UC START# *5822CA56AAFA_7A73CF636A32_impl*
 Result := aFont.Name;
//#UC END# *5822CA56AAFA_7A73CF636A32_impl*
end;//TkwFontName.Name

procedure TkwFontName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7A73CF636A32_var*
//#UC END# *4DAEEDE10285_7A73CF636A32_var*
begin
//#UC START# *4DAEEDE10285_7A73CF636A32_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7A73CF636A32_impl*
end;//TkwFontName.DoDoIt

class function TkwFontName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Name';
end;//TkwFontName.GetWordNameForRegister

procedure TkwFontName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7A73CF636A32_var*
//#UC END# *52D00B00031A_7A73CF636A32_var*
begin
//#UC START# *52D00B00031A_7A73CF636A32_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7A73CF636A32_impl*
end;//TkwFontName.SetValuePrim

function TkwFontName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7A73CF636A32_var*
//#UC END# *551544E2001A_7A73CF636A32_var*
begin
//#UC START# *551544E2001A_7A73CF636A32_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7A73CF636A32_impl*
end;//TkwFontName.GetResultTypeInfo

function TkwFontName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7A73CF636A32_var*
//#UC END# *559687E6025A_7A73CF636A32_var*
begin
//#UC START# *559687E6025A_7A73CF636A32_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7A73CF636A32_impl*
end;//TkwFontName.GetAllParamsCount

function TkwFontName.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7A73CF636A32_var*
//#UC END# *5617F4D00243_7A73CF636A32_var*
begin
//#UC START# *5617F4D00243_7A73CF636A32_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7A73CF636A32_impl*
end;//TkwFontName.ParamsTypes

function TkwFontSize.Size(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Integer;
 {* Реализация слова скрипта Font:Size }
//#UC START# *88C29661A1A9_F76B0EA46A07_var*
//#UC END# *88C29661A1A9_F76B0EA46A07_var*
begin
//#UC START# *88C29661A1A9_F76B0EA46A07_impl*
 Result := aFont.Size;
//#UC END# *88C29661A1A9_F76B0EA46A07_impl*
end;//TkwFontSize.Size

procedure TkwFontSize.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F76B0EA46A07_var*
//#UC END# *4DAEEDE10285_F76B0EA46A07_var*
begin
//#UC START# *4DAEEDE10285_F76B0EA46A07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F76B0EA46A07_impl*
end;//TkwFontSize.DoDoIt

class function TkwFontSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Size';
end;//TkwFontSize.GetWordNameForRegister

procedure TkwFontSize.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F76B0EA46A07_var*
//#UC END# *52D00B00031A_F76B0EA46A07_var*
begin
//#UC START# *52D00B00031A_F76B0EA46A07_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F76B0EA46A07_impl*
end;//TkwFontSize.SetValuePrim

function TkwFontSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F76B0EA46A07_var*
//#UC END# *551544E2001A_F76B0EA46A07_var*
begin
//#UC START# *551544E2001A_F76B0EA46A07_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F76B0EA46A07_impl*
end;//TkwFontSize.GetResultTypeInfo

function TkwFontSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F76B0EA46A07_var*
//#UC END# *559687E6025A_F76B0EA46A07_var*
begin
//#UC START# *559687E6025A_F76B0EA46A07_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F76B0EA46A07_impl*
end;//TkwFontSize.GetAllParamsCount

function TkwFontSize.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F76B0EA46A07_var*
//#UC END# *5617F4D00243_F76B0EA46A07_var*
begin
//#UC START# *5617F4D00243_F76B0EA46A07_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F76B0EA46A07_impl*
end;//TkwFontSize.ParamsTypes

initialization
 TFontWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwFontColor.RegisterInEngine;
 {* Регистрация Font_Color }
 TkwFontBackColor.RegisterInEngine;
 {* Регистрация Font_BackColor }
 TkwFontIsBold.RegisterInEngine;
 {* Регистрация Font_IsBold }
 TkwFontIsItalic.RegisterInEngine;
 {* Регистрация Font_IsItalic }
 TkwFontIsUnderline.RegisterInEngine;
 {* Регистрация Font_IsUnderline }
 TkwFontIsStrikeOut.RegisterInEngine;
 {* Регистрация Font_IsStrikeOut }
 TkwFontName.RegisterInEngine;
 {* Регистрация Font_Name }
 TkwFontSize.RegisterInEngine;
 {* Регистрация Font_Size }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
 {* Регистрация типа Il3FontInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3Color));
 {* Регистрация типа Tl3Color }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
