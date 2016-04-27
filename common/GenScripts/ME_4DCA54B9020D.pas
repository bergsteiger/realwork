unit F1ShellWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Common\F1ShellWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "F1ShellWordsPack" MUID: (4DCA54B9020D)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , l3Interfaces
 , TypInfo
 , nsExternalObjectPrim
 , nsUtils
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwBrowse = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта browse
*Пример:*
[code]
 aStr browse
[code]  }
  private
   procedure browse(const aCtx: TtfwContext;
    const aStr: Il3CString);
    {* Реализация слова скрипта browse }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBrowse

 TkwF1_WasBeep = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта f1::WasBeep
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 f1::WasBeep >>> l_Boolean
[code]  }
  private
   function f1_WasBeep(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта f1::WasBeep }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1_WasBeep

procedure TkwBrowse.browse(const aCtx: TtfwContext;
 const aStr: Il3CString);
 {* Реализация слова скрипта browse }
//#UC START# *ADC7C02D00B5_3223F9BFFE72_var*
//#UC END# *ADC7C02D00B5_3223F9BFFE72_var*
begin
//#UC START# *ADC7C02D00B5_3223F9BFFE72_impl*
 nsDoShellExecute(aStr, False, nil, True);
//#UC END# *ADC7C02D00B5_3223F9BFFE72_impl*
end;//TkwBrowse.browse

procedure TkwBrowse.DoDoIt(const aCtx: TtfwContext);
var l_aStr: Il3CString;
begin
 try
  l_aStr := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 browse(aCtx, l_aStr);
end;//TkwBrowse.DoDoIt

function TkwBrowse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwBrowse.GetResultTypeInfo

function TkwBrowse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwBrowse.GetAllParamsCount

function TkwBrowse.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwBrowse.ParamsTypes

class function TkwBrowse.GetWordNameForRegister: AnsiString;
begin
 Result := 'browse';
end;//TkwBrowse.GetWordNameForRegister

function TkwF1_WasBeep.f1_WasBeep(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта f1::WasBeep }
//#UC START# *3C50E0D2B358_5888E53B751F_var*
//#UC END# *3C50E0D2B358_5888E53B751F_var*
begin
//#UC START# *3C50E0D2B358_5888E53B751F_impl*
 {$IfDef InsiderTest}
 Result := g_WasBeep;
 g_WasBeep := false;
 {$Else  InsiderTest}
 Result := false;
 {$EndIf InsiderTest}
//#UC END# *3C50E0D2B358_5888E53B751F_impl*
end;//TkwF1_WasBeep.f1_WasBeep

procedure TkwF1_WasBeep.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(f1_WasBeep(aCtx));
end;//TkwF1_WasBeep.DoDoIt

function TkwF1_WasBeep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwF1_WasBeep.GetResultTypeInfo

function TkwF1_WasBeep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwF1_WasBeep.GetAllParamsCount

function TkwF1_WasBeep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwF1_WasBeep.ParamsTypes

class function TkwF1_WasBeep.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::WasBeep';
end;//TkwF1_WasBeep.GetWordNameForRegister

initialization
 TkwBrowse.RegisterInEngine;
 {* Регистрация browse }
 TkwF1_WasBeep.RegisterInEngine;
 {* Регистрация f1__WasBeep }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
