unit StatusBarWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "StatusBarWords" MUID: (505C855C024A)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

implementation

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nscStatusBar
 , tfwClassLike
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwStatusBarOrderedControl = {final} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControl }
  private
   function OrderedControl(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar;
    anIndex: Integer): TControl;
    {* Реализация слова скрипта StatusBar:OrderedControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStatusBarOrderedControl

 TkwStatusBarOrderedControlsCount = {final} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControlsCount }
  private
   function OrderedControlsCount(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar): Integer;
    {* Реализация слова скрипта StatusBar:OrderedControlsCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStatusBarOrderedControlsCount

 TkwStatusBarOrderIndex = {final} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderIndex }
  private
   function OrderIndex(const aCtx: TtfwContext;
    aStatusBar: TnscStatusBar;
    aControl: TControl): Integer;
    {* Реализация слова скрипта StatusBar:OrderIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwStatusBarOrderIndex

 TStatusBarWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TStatusBarWordsResNameGetter

function TkwStatusBarOrderedControl.OrderedControl(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar;
 anIndex: Integer): TControl;
 {* Реализация слова скрипта StatusBar:OrderedControl }
//#UC START# *552FC8E1023A_6A3FD2C52DF9_var*
//#UC END# *552FC8E1023A_6A3FD2C52DF9_var*
begin
//#UC START# *552FC8E1023A_6A3FD2C52DF9_impl*
 Result := aStatusBar.OrderedControls[anIndex];
//#UC END# *552FC8E1023A_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.OrderedControl

procedure TkwStatusBarOrderedControl.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBar: TnscStatusBar;
var l_anIndex: Integer;
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
 aCtx.rEngine.PushObj(OrderedControl(aCtx, l_aStatusBar, l_anIndex));
end;//TkwStatusBarOrderedControl.DoDoIt

class function TkwStatusBarOrderedControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderedControl';
end;//TkwStatusBarOrderedControl.GetWordNameForRegister

function TkwStatusBarOrderedControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TControl);
end;//TkwStatusBarOrderedControl.GetResultTypeInfo

function TkwStatusBarOrderedControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStatusBarOrderedControl.GetAllParamsCount

function TkwStatusBarOrderedControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar), TypeInfo(Integer)]);
end;//TkwStatusBarOrderedControl.ParamsTypes

function TkwStatusBarOrderedControlsCount.OrderedControlsCount(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar): Integer;
 {* Реализация слова скрипта StatusBar:OrderedControlsCount }
//#UC START# *552FC91301BD_C8B065596342_var*
//#UC END# *552FC91301BD_C8B065596342_var*
begin
//#UC START# *552FC91301BD_C8B065596342_impl*
 Result := aStatusBar.OrderedControlsCount; 
//#UC END# *552FC91301BD_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.OrderedControlsCount

procedure TkwStatusBarOrderedControlsCount.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBar: TnscStatusBar;
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
 aCtx.rEngine.PushInt(OrderedControlsCount(aCtx, l_aStatusBar));
end;//TkwStatusBarOrderedControlsCount.DoDoIt

class function TkwStatusBarOrderedControlsCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderedControlsCount';
end;//TkwStatusBarOrderedControlsCount.GetWordNameForRegister

function TkwStatusBarOrderedControlsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStatusBarOrderedControlsCount.GetResultTypeInfo

function TkwStatusBarOrderedControlsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwStatusBarOrderedControlsCount.GetAllParamsCount

function TkwStatusBarOrderedControlsCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar)]);
end;//TkwStatusBarOrderedControlsCount.ParamsTypes

function TkwStatusBarOrderIndex.OrderIndex(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar;
 aControl: TControl): Integer;
 {* Реализация слова скрипта StatusBar:OrderIndex }
//#UC START# *552FC94F0188_F7D061E9FD6E_var*
//#UC END# *552FC94F0188_F7D061E9FD6E_var*
begin
//#UC START# *552FC94F0188_F7D061E9FD6E_impl*
 Result := aStatusBar.OrderIndex[aControl];
//#UC END# *552FC94F0188_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.OrderIndex

procedure TkwStatusBarOrderIndex.DoDoIt(const aCtx: TtfwContext);
var l_aStatusBar: TnscStatusBar;
var l_aControl: TControl;
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
 aCtx.rEngine.PushInt(OrderIndex(aCtx, l_aStatusBar, l_aControl));
end;//TkwStatusBarOrderIndex.DoDoIt

class function TkwStatusBarOrderIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderIndex';
end;//TkwStatusBarOrderIndex.GetWordNameForRegister

function TkwStatusBarOrderIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwStatusBarOrderIndex.GetResultTypeInfo

function TkwStatusBarOrderIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwStatusBarOrderIndex.GetAllParamsCount

function TkwStatusBarOrderIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TnscStatusBar), TypeInfo(TControl)]);
end;//TkwStatusBarOrderIndex.ParamsTypes

class function TStatusBarWordsResNameGetter.ResName: AnsiString;
begin
 Result := 'StatusBarWords';
end;//TStatusBarWordsResNameGetter.ResName

 {$R StatusBarWords.res}

initialization
 TkwStatusBarOrderedControl.RegisterInEngine;
 {* Регистрация StatusBar_OrderedControl }
 TkwStatusBarOrderedControlsCount.RegisterInEngine;
 {* Регистрация StatusBar_OrderedControlsCount }
 TkwStatusBarOrderIndex.RegisterInEngine;
 {* Регистрация StatusBar_OrderIndex }
 TStatusBarWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* Регистрация типа TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

end.
