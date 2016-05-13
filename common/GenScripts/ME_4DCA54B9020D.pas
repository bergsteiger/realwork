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
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwBrowse = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта browse }
  private
   procedure browse(const aCtx: TtfwContext;
    const aStr: Il3CString);
    {* Реализация слова скрипта browse }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBrowse

 TkwF1WasBeep = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта f1::WasBeep }
  private
   function f1_WasBeep(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта f1::WasBeep }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1WasBeep

procedure TkwBrowse.browse(const aCtx: TtfwContext;
 const aStr: Il3CString);
 {* Реализация слова скрипта browse }
//#UC START# *556C08A80212_556C08A80212_Word_var*
//#UC END# *556C08A80212_556C08A80212_Word_var*
begin
//#UC START# *556C08A80212_556C08A80212_Word_impl*
 nsDoShellExecute(aStr, False, nil, True);
//#UC END# *556C08A80212_556C08A80212_Word_impl*
end;//TkwBrowse.browse

class function TkwBrowse.GetWordNameForRegister: AnsiString;
begin
 Result := 'browse';
end;//TkwBrowse.GetWordNameForRegister

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

function TkwF1WasBeep.f1_WasBeep(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта f1::WasBeep }
//#UC START# *556C08EF0058_556C08EF0058_Word_var*
//#UC END# *556C08EF0058_556C08EF0058_Word_var*
begin
//#UC START# *556C08EF0058_556C08EF0058_Word_impl*
 {$IfDef InsiderTest}
 Result := g_WasBeep;
 g_WasBeep := false;
 {$Else  InsiderTest}
 Result := false;
 {$EndIf InsiderTest}
//#UC END# *556C08EF0058_556C08EF0058_Word_impl*
end;//TkwF1WasBeep.f1_WasBeep

class function TkwF1WasBeep.GetWordNameForRegister: AnsiString;
begin
 Result := 'f1::WasBeep';
end;//TkwF1WasBeep.GetWordNameForRegister

function TkwF1WasBeep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwF1WasBeep.GetResultTypeInfo

function TkwF1WasBeep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwF1WasBeep.GetAllParamsCount

function TkwF1WasBeep.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwF1WasBeep.ParamsTypes

procedure TkwF1WasBeep.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(f1_WasBeep(aCtx));
end;//TkwF1WasBeep.DoDoIt

initialization
 TkwBrowse.RegisterInEngine;
 {* Регистрация browse }
 TkwF1WasBeep.RegisterInEngine;
 {* Регистрация f1__WasBeep }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Il3CString }
{$IfEnd} // NOT Defined(NoScripts)

end.
