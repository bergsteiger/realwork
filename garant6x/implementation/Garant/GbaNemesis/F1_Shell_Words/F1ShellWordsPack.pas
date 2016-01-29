unit F1ShellWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "F1 Shell Words"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Shell_Words/F1ShellWordsPack.pas"
// Начат: 11.05.2011 13:20
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Поддержка тестов::F1 Shell Words::F1 Shell Words::F1ShellWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  kwF1ImportConsultation,
  kwConfigRestore,
  kwStyleTableRestore,
  kwDiffIteratorHasNext,
  kwDiffIteratorNext,
  kwDiffIteratorHasPrev,
  kwDiffIteratorPrev
  {$If defined(nsTest) AND not defined(NoScripts)}
  ,
  kwTextFormSetNeedShowIntranetWarning
  {$IfEnd} //nsTest AND not NoScripts
  ,
  kwTextFormGetDocumentID,
  kwOpenSituationCard,
  kwOpenOldSituationCard,
  kwQueryCardSetCanSaveState,
  kwDocumentLikeState,
  kwGetEncryptedComplectId,
  kwOpenPrimeForm,
  nsExternalObjectPrim,
  nsUtils,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwBrowse = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта browse
*Пример:*
[code]
 aStr browse
[code]  }
 private
 // private methods
   procedure Browse(const aCtx: TtfwContext;
    const aStr: Il3CString);
     {* Реализация слова скрипта browse }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwBrowse

// start class TkwBrowse

procedure TkwBrowse.Browse(const aCtx: TtfwContext;
  const aStr: Il3CString);
//#UC START# *ADC7C02D00B5_3223F9BFFE72_var*
//#UC END# *ADC7C02D00B5_3223F9BFFE72_var*
begin
//#UC START# *ADC7C02D00B5_3223F9BFFE72_impl*
 nsDoShellExecute(aStr, False, nil, True);
//#UC END# *ADC7C02D00B5_3223F9BFFE72_impl*
end;//TkwBrowse.Browse

procedure TkwBrowse.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStr : Il3CString;
begin
 try
  l_aStr := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStr: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Browse(aCtx, l_aStr);
end;//TkwBrowse.DoDoIt

class function TkwBrowse.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'browse';
end;//TkwBrowse.GetWordNameForRegister

function TkwBrowse.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwBrowse.GetResultTypeInfo

function TkwBrowse.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwBrowse.GetAllParamsCount

function TkwBrowse.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([@tfw_tiString]);
end;//TkwBrowse.ParamsTypes

type
 TkwF1_WasBeep = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта f1::WasBeep
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 f1::WasBeep >>> l_Boolean
[code]  }
 private
 // private methods
   function F1_WasBeep(const aCtx: TtfwContext): Boolean;
     {* Реализация слова скрипта f1::WasBeep }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwF1_WasBeep

// start class TkwF1_WasBeep

function TkwF1_WasBeep.F1_WasBeep(const aCtx: TtfwContext): Boolean;
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
end;//TkwF1_WasBeep.F1_WasBeep

procedure TkwF1_WasBeep.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((F1_WasBeep(aCtx)));
end;//TkwF1_WasBeep.DoDoIt

class function TkwF1_WasBeep.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'f1::WasBeep';
end;//TkwF1_WasBeep.GetWordNameForRegister

function TkwF1_WasBeep.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwF1_WasBeep.GetResultTypeInfo

function TkwF1_WasBeep.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwF1_WasBeep.GetAllParamsCount

function TkwF1_WasBeep.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwF1_WasBeep.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация browse
 TkwBrowse.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация f1__WasBeep
 TkwF1_WasBeep.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts

end.