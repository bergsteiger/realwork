unit FontWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FontWordsPack" MUID: (5190B264037C)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Core
 , l3Interfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwFontColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Color }
  private
   function Color(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* Реализация слова скрипта Font:Color }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontColor

 TkwFontBackColor = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:BackColor }
  private
   function BackColor(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* Реализация слова скрипта Font:BackColor }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontBackColor

 TkwFontIsBold = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsBold }
  private
   function IsBold(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsBold }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontIsBold

 TkwFontIsItalic = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsItalic }
  private
   function IsItalic(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsItalic }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontIsItalic

 TkwFontIsUnderline = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsUnderline }
  private
   function IsUnderline(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsUnderline }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontIsUnderline

 TkwFontIsStrikeOut = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:IsStrikeOut }
  private
   function IsStrikeOut(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* Реализация слова скрипта Font:IsStrikeOut }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontIsStrikeOut

 TkwFontName = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Name }
  private
   function Name(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): AnsiString;
    {* Реализация слова скрипта Font:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontName

 TkwFontSize = {final} class(TtfwPropertyLike)
  {* Слово скрипта Font:Size }
  private
   function Size(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Integer;
    {* Реализация слова скрипта Font:Size }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFontSize

 TFontWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TFontWordsPackResNameGetter

function TkwFontColor.Color(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Tl3Color;
 {* Реализация слова скрипта Font:Color }
//#UC START# *556F27CA0030_556F27CA0030_46A60B17028B_Word_var*
//#UC END# *556F27CA0030_556F27CA0030_46A60B17028B_Word_var*
begin
//#UC START# *556F27CA0030_556F27CA0030_46A60B17028B_Word_impl*
 Result := aFont.ForeColor;
//#UC END# *556F27CA0030_556F27CA0030_46A60B17028B_Word_impl*
end;//TkwFontColor.Color

class function TkwFontColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Color';
end;//TkwFontColor.GetWordNameForRegister

function TkwFontColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Tl3Color);
end;//TkwFontColor.GetResultTypeInfo

function TkwFontColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontColor.GetAllParamsCount

function TkwFontColor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontColor.ParamsTypes

procedure TkwFontColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Color', aCtx);
end;//TkwFontColor.SetValuePrim

procedure TkwFontColor.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Color(aCtx, l_aFont)));
end;//TkwFontColor.DoDoIt

function TkwFontBackColor.BackColor(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Tl3Color;
 {* Реализация слова скрипта Font:BackColor }
//#UC START# *556F27D901F0_556F27D901F0_46A60B17028B_Word_var*
//#UC END# *556F27D901F0_556F27D901F0_46A60B17028B_Word_var*
begin
//#UC START# *556F27D901F0_556F27D901F0_46A60B17028B_Word_impl*
 Result := aFont.BackColor;
//#UC END# *556F27D901F0_556F27D901F0_46A60B17028B_Word_impl*
end;//TkwFontBackColor.BackColor

class function TkwFontBackColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:BackColor';
end;//TkwFontBackColor.GetWordNameForRegister

function TkwFontBackColor.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Tl3Color);
end;//TkwFontBackColor.GetResultTypeInfo

function TkwFontBackColor.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontBackColor.GetAllParamsCount

function TkwFontBackColor.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontBackColor.ParamsTypes

procedure TkwFontBackColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackColor', aCtx);
end;//TkwFontBackColor.SetValuePrim

procedure TkwFontBackColor.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(BackColor(aCtx, l_aFont)));
end;//TkwFontBackColor.DoDoIt

function TkwFontIsBold.IsBold(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsBold }
//#UC START# *556F27FE01C0_556F27FE01C0_46A60B17028B_Word_var*
//#UC END# *556F27FE01C0_556F27FE01C0_46A60B17028B_Word_var*
begin
//#UC START# *556F27FE01C0_556F27FE01C0_46A60B17028B_Word_impl*
 Result := aFont.Bold;
//#UC END# *556F27FE01C0_556F27FE01C0_46A60B17028B_Word_impl*
end;//TkwFontIsBold.IsBold

class function TkwFontIsBold.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsBold';
end;//TkwFontIsBold.GetWordNameForRegister

function TkwFontIsBold.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFontIsBold.GetResultTypeInfo

function TkwFontIsBold.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontIsBold.GetAllParamsCount

function TkwFontIsBold.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontIsBold.ParamsTypes

procedure TkwFontIsBold.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsBold', aCtx);
end;//TkwFontIsBold.SetValuePrim

procedure TkwFontIsBold.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsBold(aCtx, l_aFont));
end;//TkwFontIsBold.DoDoIt

function TkwFontIsItalic.IsItalic(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsItalic }
//#UC START# *556F280F0160_556F280F0160_46A60B17028B_Word_var*
//#UC END# *556F280F0160_556F280F0160_46A60B17028B_Word_var*
begin
//#UC START# *556F280F0160_556F280F0160_46A60B17028B_Word_impl*
 Result := aFont.Italic;
//#UC END# *556F280F0160_556F280F0160_46A60B17028B_Word_impl*
end;//TkwFontIsItalic.IsItalic

class function TkwFontIsItalic.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsItalic';
end;//TkwFontIsItalic.GetWordNameForRegister

function TkwFontIsItalic.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFontIsItalic.GetResultTypeInfo

function TkwFontIsItalic.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontIsItalic.GetAllParamsCount

function TkwFontIsItalic.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontIsItalic.ParamsTypes

procedure TkwFontIsItalic.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsItalic', aCtx);
end;//TkwFontIsItalic.SetValuePrim

procedure TkwFontIsItalic.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsItalic(aCtx, l_aFont));
end;//TkwFontIsItalic.DoDoIt

function TkwFontIsUnderline.IsUnderline(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsUnderline }
//#UC START# *556F281A0381_556F281A0381_46A60B17028B_Word_var*
//#UC END# *556F281A0381_556F281A0381_46A60B17028B_Word_var*
begin
//#UC START# *556F281A0381_556F281A0381_46A60B17028B_Word_impl*
 Result := aFont.Underline;
//#UC END# *556F281A0381_556F281A0381_46A60B17028B_Word_impl*
end;//TkwFontIsUnderline.IsUnderline

class function TkwFontIsUnderline.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsUnderline';
end;//TkwFontIsUnderline.GetWordNameForRegister

function TkwFontIsUnderline.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFontIsUnderline.GetResultTypeInfo

function TkwFontIsUnderline.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontIsUnderline.GetAllParamsCount

function TkwFontIsUnderline.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontIsUnderline.ParamsTypes

procedure TkwFontIsUnderline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsUnderline', aCtx);
end;//TkwFontIsUnderline.SetValuePrim

procedure TkwFontIsUnderline.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsUnderline(aCtx, l_aFont));
end;//TkwFontIsUnderline.DoDoIt

function TkwFontIsStrikeOut.IsStrikeOut(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* Реализация слова скрипта Font:IsStrikeOut }
//#UC START# *556F282902E9_556F282902E9_46A60B17028B_Word_var*
//#UC END# *556F282902E9_556F282902E9_46A60B17028B_Word_var*
begin
//#UC START# *556F282902E9_556F282902E9_46A60B17028B_Word_impl*
 Result := aFont.Strikeout;
//#UC END# *556F282902E9_556F282902E9_46A60B17028B_Word_impl*
end;//TkwFontIsStrikeOut.IsStrikeOut

class function TkwFontIsStrikeOut.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsStrikeOut';
end;//TkwFontIsStrikeOut.GetWordNameForRegister

function TkwFontIsStrikeOut.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFontIsStrikeOut.GetResultTypeInfo

function TkwFontIsStrikeOut.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontIsStrikeOut.GetAllParamsCount

function TkwFontIsStrikeOut.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontIsStrikeOut.ParamsTypes

procedure TkwFontIsStrikeOut.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsStrikeOut', aCtx);
end;//TkwFontIsStrikeOut.SetValuePrim

procedure TkwFontIsStrikeOut.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsStrikeOut(aCtx, l_aFont));
end;//TkwFontIsStrikeOut.DoDoIt

function TkwFontName.Name(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): AnsiString;
 {* Реализация слова скрипта Font:Name }
//#UC START# *556F2856019F_556F2856019F_46A60B17028B_Word_var*
//#UC END# *556F2856019F_556F2856019F_46A60B17028B_Word_var*
begin
//#UC START# *556F2856019F_556F2856019F_46A60B17028B_Word_impl*
 Result := aFont.Name;
//#UC END# *556F2856019F_556F2856019F_46A60B17028B_Word_impl*
end;//TkwFontName.Name

class function TkwFontName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Name';
end;//TkwFontName.GetWordNameForRegister

function TkwFontName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwFontName.GetResultTypeInfo

function TkwFontName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontName.GetAllParamsCount

function TkwFontName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontName.ParamsTypes

procedure TkwFontName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwFontName.SetValuePrim

procedure TkwFontName.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aFont));
end;//TkwFontName.DoDoIt

function TkwFontSize.Size(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Integer;
 {* Реализация слова скрипта Font:Size }
//#UC START# *556F2867022F_556F2867022F_46A60B17028B_Word_var*
//#UC END# *556F2867022F_556F2867022F_46A60B17028B_Word_var*
begin
//#UC START# *556F2867022F_556F2867022F_46A60B17028B_Word_impl*
 Result := aFont.Size;
//#UC END# *556F2867022F_556F2867022F_46A60B17028B_Word_impl*
end;//TkwFontSize.Size

class function TkwFontSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Size';
end;//TkwFontSize.GetWordNameForRegister

function TkwFontSize.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwFontSize.GetResultTypeInfo

function TkwFontSize.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFontSize.GetAllParamsCount

function TkwFontSize.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3FontInfo)]);
end;//TkwFontSize.ParamsTypes

procedure TkwFontSize.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Size', aCtx);
end;//TkwFontSize.SetValuePrim

procedure TkwFontSize.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Size(aCtx, l_aFont));
end;//TkwFontSize.DoDoIt

class function TFontWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'FontWordsPack';
end;//TFontWordsPackResNameGetter.ResName

{$R FontWordsPack.res}

initialization
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
 TFontWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
 {* Регистрация типа Il3FontInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3Color));
 {* Регистрация типа Tl3Color }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
