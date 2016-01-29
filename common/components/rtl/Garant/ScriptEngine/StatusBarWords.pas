unit StatusBarWords;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$F1"
// Модуль: "StatusBarWords.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi For F1::ScriptEngine$F1::StatusBarWords::StatusBarWords
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If defined(Nemesis) AND not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCL)}
  ,
  Controls
  {$IfEnd} //not NoVCL
  ,
  tfwScriptingInterfaces,
  nscStatusBar,
  tfwAxiomaticsResNameGetter,
  tfwClassLike
  ;

{$IfEnd} //Nemesis AND not NoScripts

implementation

{$If defined(Nemesis) AND not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *98311E435825ci*
//#UC END# *98311E435825ci*
//#UC START# *98311E435825cit*
//#UC END# *98311E435825cit*
 TStatusBarWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *98311E435825publ*
//#UC END# *98311E435825publ*
 end;//TStatusBarWordsResNameGetter

// start class TStatusBarWordsResNameGetter

class function TStatusBarWordsResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'StatusBarWords';
end;//TStatusBarWordsResNameGetter.ResName

 {$R StatusBarWords.res}

type
 TkwStatusBarOrderedControl = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControl
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 anIndex aStatusBar StatusBar:OrderedControl >>> l_TControl
[code]  }
 private
 // private methods
   function OrderedControl(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar;
    anIndex: Integer): TControl;
     {* Реализация слова скрипта StatusBar:OrderedControl }
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
 end;//TkwStatusBarOrderedControl

// start class TkwStatusBarOrderedControl

function TkwStatusBarOrderedControl.OrderedControl(const aCtx: TtfwContext;
  aStatusBar: TnscStatusBar;
  anIndex: Integer): TControl;
//#UC START# *FE371E175914_6A3FD2C52DF9_var*
//#UC END# *FE371E175914_6A3FD2C52DF9_var*
begin
//#UC START# *FE371E175914_6A3FD2C52DF9_impl*
 Result := aStatusBar.OrderedControls[anIndex];
//#UC END# *FE371E175914_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.OrderedControl

procedure TkwStatusBarOrderedControl.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStatusBar : TnscStatusBar;
 l_anIndex : Integer;
begin
 try
  l_aStatusBar := TnscStatusBar(aCtx.rEngine.PopObjAs(TnscStatusBar));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStatusBar: TnscStatusBar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OrderedControl(aCtx, l_aStatusBar, l_anIndex)));
end;//TkwStatusBarOrderedControl.DoDoIt

class function TkwStatusBarOrderedControl.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StatusBar:OrderedControl';
end;//TkwStatusBarOrderedControl.GetWordNameForRegister

function TkwStatusBarOrderedControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TControl);
end;//TkwStatusBarOrderedControl.GetResultTypeInfo

function TkwStatusBarOrderedControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStatusBarOrderedControl.GetAllParamsCount

function TkwStatusBarOrderedControl.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar), TypeInfo(Integer)]);
end;//TkwStatusBarOrderedControl.ParamsTypes

type
 TkwStatusBarOrderedControlsCount = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControlsCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aStatusBar StatusBar:OrderedControlsCount >>> l_Integer
[code]  }
 private
 // private methods
   function OrderedControlsCount(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar): Integer;
     {* Реализация слова скрипта StatusBar:OrderedControlsCount }
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
 end;//TkwStatusBarOrderedControlsCount

// start class TkwStatusBarOrderedControlsCount

function TkwStatusBarOrderedControlsCount.OrderedControlsCount(const aCtx: TtfwContext;
  aStatusBar: TnscStatusBar): Integer;
//#UC START# *3F6B70526DE3_C8B065596342_var*
//#UC END# *3F6B70526DE3_C8B065596342_var*
begin
//#UC START# *3F6B70526DE3_C8B065596342_impl*
 Result := aStatusBar.OrderedControlsCount; 
//#UC END# *3F6B70526DE3_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.OrderedControlsCount

procedure TkwStatusBarOrderedControlsCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStatusBar : TnscStatusBar;
begin
 try
  l_aStatusBar := TnscStatusBar(aCtx.rEngine.PopObjAs(TnscStatusBar));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStatusBar: TnscStatusBar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((OrderedControlsCount(aCtx, l_aStatusBar)));
end;//TkwStatusBarOrderedControlsCount.DoDoIt

class function TkwStatusBarOrderedControlsCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StatusBar:OrderedControlsCount';
end;//TkwStatusBarOrderedControlsCount.GetWordNameForRegister

function TkwStatusBarOrderedControlsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStatusBarOrderedControlsCount.GetResultTypeInfo

function TkwStatusBarOrderedControlsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwStatusBarOrderedControlsCount.GetAllParamsCount

function TkwStatusBarOrderedControlsCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar)]);
end;//TkwStatusBarOrderedControlsCount.ParamsTypes

type
 TkwStatusBarOrderIndex = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl aStatusBar StatusBar:OrderIndex >>> l_Integer
[code]  }
 private
 // private methods
   function OrderIndex(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar;
    aControl: TControl): Integer;
     {* Реализация слова скрипта StatusBar:OrderIndex }
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
 end;//TkwStatusBarOrderIndex

// start class TkwStatusBarOrderIndex

function TkwStatusBarOrderIndex.OrderIndex(const aCtx: TtfwContext;
  aStatusBar: TnscStatusBar;
  aControl: TControl): Integer;
//#UC START# *BD703176FDE6_F7D061E9FD6E_var*
//#UC END# *BD703176FDE6_F7D061E9FD6E_var*
begin
//#UC START# *BD703176FDE6_F7D061E9FD6E_impl*
 Result := aStatusBar.OrderIndex[aControl];
//#UC END# *BD703176FDE6_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.OrderIndex

procedure TkwStatusBarOrderIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aStatusBar : TnscStatusBar;
 l_aControl : TControl;
begin
 try
  l_aStatusBar := TnscStatusBar(aCtx.rEngine.PopObjAs(TnscStatusBar));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStatusBar: TnscStatusBar : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aControl := TControl(aCtx.rEngine.PopObjAs(TControl));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aControl: TControl : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((OrderIndex(aCtx, l_aStatusBar, l_aControl)));
end;//TkwStatusBarOrderIndex.DoDoIt

class function TkwStatusBarOrderIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'StatusBar:OrderIndex';
end;//TkwStatusBarOrderIndex.GetWordNameForRegister

function TkwStatusBarOrderIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwStatusBarOrderIndex.GetResultTypeInfo

function TkwStatusBarOrderIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwStatusBarOrderIndex.GetAllParamsCount

function TkwStatusBarOrderIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar), TypeInfo(TControl)]);
end;//TkwStatusBarOrderIndex.ParamsTypes
{$IfEnd} //Nemesis AND not NoScripts

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TStatusBarWordsResNameGetter.Register;
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация StatusBar_OrderedControl
 TkwStatusBarOrderedControl.RegisterInEngine;
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация StatusBar_OrderedControlsCount
 TkwStatusBarOrderedControlsCount.RegisterInEngine;
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация StatusBar_OrderIndex
 TkwStatusBarOrderIndex.RegisterInEngine;
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация типа TnscStatusBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //Nemesis AND not NoScripts
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация типа TControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
{$IfEnd} //Nemesis AND not NoScripts

end.