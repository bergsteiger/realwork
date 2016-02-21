unit FontWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\FontWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , l3Interfaces
 , l3Core
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
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
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *9F904801EF08publ*
 //#UC END# *9F904801EF08publ*
 end;//TFontWordsPackResNameGetter

 TkwFontColor = {final} class(TtfwPropertyLike)
  {* ����� ������� Font:Color
*��� ����������:* Tl3Color
*������:*
[code]
TColor VAR l_Tl3Color
 aFont Font:Color >>> l_Tl3Color
[code]  }
  private
   function Color(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* ���������� ����� ������� Font:Color }
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
  {* ����� ������� Font:BackColor
*��� ����������:* Tl3Color
*������:*
[code]
TColor VAR l_Tl3Color
 aFont Font:BackColor >>> l_Tl3Color
[code]  }
  private
   function BackColor(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Tl3Color;
    {* ���������� ����� ������� Font:BackColor }
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
  {* ����� ������� Font:IsBold
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsBold >>> l_Boolean
[code]  }
  private
   function IsBold(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* ���������� ����� ������� Font:IsBold }
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
  {* ����� ������� Font:IsItalic
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsItalic >>> l_Boolean
[code]  }
  private
   function IsItalic(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* ���������� ����� ������� Font:IsItalic }
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
  {* ����� ������� Font:IsUnderline
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsUnderline >>> l_Boolean
[code]  }
  private
   function IsUnderline(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* ���������� ����� ������� Font:IsUnderline }
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
  {* ����� ������� Font:IsStrikeOut
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aFont Font:IsStrikeOut >>> l_Boolean
[code]  }
  private
   function IsStrikeOut(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Boolean;
    {* ���������� ����� ������� Font:IsStrikeOut }
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
  {* ����� ������� Font:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aFont Font:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): AnsiString;
    {* ���������� ����� ������� Font:Name }
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
  {* ����� ������� Font:Size
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aFont Font:Size >>> l_Integer
[code]  }
  private
   function Size(const aCtx: TtfwContext;
    const aFont: Il3FontInfo): Integer;
    {* ���������� ����� ������� Font:Size }
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
 {* ���������� ����� ������� Font:Color }
//#UC START# *7040B1F6FD7B_B42B6353E972_var*
//#UC END# *7040B1F6FD7B_B42B6353E972_var*
begin
//#UC START# *7040B1F6FD7B_B42B6353E972_impl*
 Result := aFont.ForeColor;
//#UC END# *7040B1F6FD7B_B42B6353E972_impl*
end;//TkwFontColor.Color

procedure TkwFontColor.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(Color(aCtx, l_aFont)));
end;//TkwFontColor.DoDoIt

class function TkwFontColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Color';
end;//TkwFontColor.GetWordNameForRegister

procedure TkwFontColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Color', aCtx);
end;//TkwFontColor.SetValuePrim

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

function TkwFontBackColor.BackColor(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Tl3Color;
 {* ���������� ����� ������� Font:BackColor }
//#UC START# *85B9473C71C2_ADDA8C159EED_var*
//#UC END# *85B9473C71C2_ADDA8C159EED_var*
begin
//#UC START# *85B9473C71C2_ADDA8C159EED_impl*
 Result := aFont.BackColor;
//#UC END# *85B9473C71C2_ADDA8C159EED_impl*
end;//TkwFontBackColor.BackColor

procedure TkwFontBackColor.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Integer(BackColor(aCtx, l_aFont)));
end;//TkwFontBackColor.DoDoIt

class function TkwFontBackColor.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:BackColor';
end;//TkwFontBackColor.GetWordNameForRegister

procedure TkwFontBackColor.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackColor', aCtx);
end;//TkwFontBackColor.SetValuePrim

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

function TkwFontIsBold.IsBold(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* ���������� ����� ������� Font:IsBold }
//#UC START# *F4864359618B_6426AF77D4E5_var*
//#UC END# *F4864359618B_6426AF77D4E5_var*
begin
//#UC START# *F4864359618B_6426AF77D4E5_impl*
 Result := aFont.Bold;
//#UC END# *F4864359618B_6426AF77D4E5_impl*
end;//TkwFontIsBold.IsBold

procedure TkwFontIsBold.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsBold(aCtx, l_aFont));
end;//TkwFontIsBold.DoDoIt

class function TkwFontIsBold.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsBold';
end;//TkwFontIsBold.GetWordNameForRegister

procedure TkwFontIsBold.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� IsBold', aCtx);
end;//TkwFontIsBold.SetValuePrim

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

function TkwFontIsItalic.IsItalic(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* ���������� ����� ������� Font:IsItalic }
//#UC START# *3EC3A4D3FAB3_FAD60EB55765_var*
//#UC END# *3EC3A4D3FAB3_FAD60EB55765_var*
begin
//#UC START# *3EC3A4D3FAB3_FAD60EB55765_impl*
 Result := aFont.Italic;
//#UC END# *3EC3A4D3FAB3_FAD60EB55765_impl*
end;//TkwFontIsItalic.IsItalic

procedure TkwFontIsItalic.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsItalic(aCtx, l_aFont));
end;//TkwFontIsItalic.DoDoIt

class function TkwFontIsItalic.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsItalic';
end;//TkwFontIsItalic.GetWordNameForRegister

procedure TkwFontIsItalic.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� IsItalic', aCtx);
end;//TkwFontIsItalic.SetValuePrim

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

function TkwFontIsUnderline.IsUnderline(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* ���������� ����� ������� Font:IsUnderline }
//#UC START# *F84904DE8371_0A56585439B0_var*
//#UC END# *F84904DE8371_0A56585439B0_var*
begin
//#UC START# *F84904DE8371_0A56585439B0_impl*
 Result := aFont.Underline;
//#UC END# *F84904DE8371_0A56585439B0_impl*
end;//TkwFontIsUnderline.IsUnderline

procedure TkwFontIsUnderline.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsUnderline(aCtx, l_aFont));
end;//TkwFontIsUnderline.DoDoIt

class function TkwFontIsUnderline.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsUnderline';
end;//TkwFontIsUnderline.GetWordNameForRegister

procedure TkwFontIsUnderline.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� IsUnderline', aCtx);
end;//TkwFontIsUnderline.SetValuePrim

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

function TkwFontIsStrikeOut.IsStrikeOut(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Boolean;
 {* ���������� ����� ������� Font:IsStrikeOut }
//#UC START# *56B18ED23F7B_48690441DF69_var*
//#UC END# *56B18ED23F7B_48690441DF69_var*
begin
//#UC START# *56B18ED23F7B_48690441DF69_impl*
 Result := aFont.Strikeout;
//#UC END# *56B18ED23F7B_48690441DF69_impl*
end;//TkwFontIsStrikeOut.IsStrikeOut

procedure TkwFontIsStrikeOut.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsStrikeOut(aCtx, l_aFont));
end;//TkwFontIsStrikeOut.DoDoIt

class function TkwFontIsStrikeOut.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:IsStrikeOut';
end;//TkwFontIsStrikeOut.GetWordNameForRegister

procedure TkwFontIsStrikeOut.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� IsStrikeOut', aCtx);
end;//TkwFontIsStrikeOut.SetValuePrim

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

function TkwFontName.Name(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): AnsiString;
 {* ���������� ����� ������� Font:Name }
//#UC START# *5822CA56AAFA_7A73CF636A32_var*
//#UC END# *5822CA56AAFA_7A73CF636A32_var*
begin
//#UC START# *5822CA56AAFA_7A73CF636A32_impl*
 Result := aFont.Name;
//#UC END# *5822CA56AAFA_7A73CF636A32_impl*
end;//TkwFontName.Name

procedure TkwFontName.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aFont));
end;//TkwFontName.DoDoIt

class function TkwFontName.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Name';
end;//TkwFontName.GetWordNameForRegister

procedure TkwFontName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Name', aCtx);
end;//TkwFontName.SetValuePrim

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

function TkwFontSize.Size(const aCtx: TtfwContext;
 const aFont: Il3FontInfo): Integer;
 {* ���������� ����� ������� Font:Size }
//#UC START# *88C29661A1A9_F76B0EA46A07_var*
//#UC END# *88C29661A1A9_F76B0EA46A07_var*
begin
//#UC START# *88C29661A1A9_F76B0EA46A07_impl*
 Result := aFont.Size;
//#UC END# *88C29661A1A9_F76B0EA46A07_impl*
end;//TkwFontSize.Size

procedure TkwFontSize.DoDoIt(const aCtx: TtfwContext);
var l_aFont: Il3FontInfo;
begin
 try
  l_aFont := Il3FontInfo(aCtx.rEngine.PopIntf(Il3FontInfo));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aFont: Il3FontInfo : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Size(aCtx, l_aFont));
end;//TkwFontSize.DoDoIt

class function TkwFontSize.GetWordNameForRegister: AnsiString;
begin
 Result := 'Font:Size';
end;//TkwFontSize.GetWordNameForRegister

procedure TkwFontSize.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Size', aCtx);
end;//TkwFontSize.SetValuePrim

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

initialization
 TFontWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwFontColor.RegisterInEngine;
 {* ����������� Font_Color }
 TkwFontBackColor.RegisterInEngine;
 {* ����������� Font_BackColor }
 TkwFontIsBold.RegisterInEngine;
 {* ����������� Font_IsBold }
 TkwFontIsItalic.RegisterInEngine;
 {* ����������� Font_IsItalic }
 TkwFontIsUnderline.RegisterInEngine;
 {* ����������� Font_IsUnderline }
 TkwFontIsStrikeOut.RegisterInEngine;
 {* ����������� Font_IsStrikeOut }
 TkwFontName.RegisterInEngine;
 {* ����������� Font_Name }
 TkwFontSize.RegisterInEngine;
 {* ����������� Font_Size }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3FontInfo));
 {* ����������� ���� Il3FontInfo }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Tl3Color));
 {* ����������� ���� Tl3Color }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
{$IfEnd} // NOT Defined(NoScripts)

end.
