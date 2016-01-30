unit StatusBarWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\StatusBarWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , nscStatusBar
 {$If NOT Defined(NoVCL)}
 , Controls
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

implementation

{$If Defined(Nemesis) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *98311E435825ci*
 //#UC END# *98311E435825ci*
 //#UC START# *98311E435825cit*
 //#UC END# *98311E435825cit*
 TStatusBarWordsResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *98311E435825publ*
 //#UC END# *98311E435825publ*
 end;//TStatusBarWordsResNameGetter

 TkwStatusBarOrderedControl = {final} class(TtfwClassLike)
  {* Слово скрипта StatusBar:OrderedControl
*Тип результата:* TControl
*Пример:*
[code]
OBJECT VAR l_TControl
 anIndex aStatusBar StatusBar:OrderedControl >>> l_TControl
[code]  }
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
  {* Слово скрипта StatusBar:OrderedControlsCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aStatusBar StatusBar:OrderedControlsCount >>> l_Integer
[code]  }
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
  {* Слово скрипта StatusBar:OrderIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aControl aStatusBar StatusBar:OrderIndex >>> l_Integer
[code]  }
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

class function TStatusBarWordsResNameGetter.ResName: AnsiString;
begin
  Result := 'StatusBarWords';
end;//TStatusBarWordsResNameGetter.ResName

 {$R StatusBarWords.res}

function TkwStatusBarOrderedControl.OrderedControl(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar;
 anIndex: Integer): TControl;
 {* Реализация слова скрипта StatusBar:OrderedControl }
//#UC START# *FE371E175914_6A3FD2C52DF9_var*
//#UC END# *FE371E175914_6A3FD2C52DF9_var*
begin
//#UC START# *FE371E175914_6A3FD2C52DF9_impl*
 Result := aStatusBar.OrderedControls[anIndex];
//#UC END# *FE371E175914_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.OrderedControl

procedure TkwStatusBarOrderedControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6A3FD2C52DF9_var*
//#UC END# *4DAEEDE10285_6A3FD2C52DF9_var*
begin
//#UC START# *4DAEEDE10285_6A3FD2C52DF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.DoDoIt

class function TkwStatusBarOrderedControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderedControl';
end;//TkwStatusBarOrderedControl.GetWordNameForRegister

function TkwStatusBarOrderedControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6A3FD2C52DF9_var*
//#UC END# *551544E2001A_6A3FD2C52DF9_var*
begin
//#UC START# *551544E2001A_6A3FD2C52DF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.GetResultTypeInfo

function TkwStatusBarOrderedControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6A3FD2C52DF9_var*
//#UC END# *559687E6025A_6A3FD2C52DF9_var*
begin
//#UC START# *559687E6025A_6A3FD2C52DF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.GetAllParamsCount

function TkwStatusBarOrderedControl.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6A3FD2C52DF9_var*
//#UC END# *5617F4D00243_6A3FD2C52DF9_var*
begin
//#UC START# *5617F4D00243_6A3FD2C52DF9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6A3FD2C52DF9_impl*
end;//TkwStatusBarOrderedControl.ParamsTypes

function TkwStatusBarOrderedControlsCount.OrderedControlsCount(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar): Integer;
 {* Реализация слова скрипта StatusBar:OrderedControlsCount }
//#UC START# *3F6B70526DE3_C8B065596342_var*
//#UC END# *3F6B70526DE3_C8B065596342_var*
begin
//#UC START# *3F6B70526DE3_C8B065596342_impl*
 Result := aStatusBar.OrderedControlsCount; 
//#UC END# *3F6B70526DE3_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.OrderedControlsCount

procedure TkwStatusBarOrderedControlsCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C8B065596342_var*
//#UC END# *4DAEEDE10285_C8B065596342_var*
begin
//#UC START# *4DAEEDE10285_C8B065596342_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.DoDoIt

class function TkwStatusBarOrderedControlsCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderedControlsCount';
end;//TkwStatusBarOrderedControlsCount.GetWordNameForRegister

function TkwStatusBarOrderedControlsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_C8B065596342_var*
//#UC END# *551544E2001A_C8B065596342_var*
begin
//#UC START# *551544E2001A_C8B065596342_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.GetResultTypeInfo

function TkwStatusBarOrderedControlsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_C8B065596342_var*
//#UC END# *559687E6025A_C8B065596342_var*
begin
//#UC START# *559687E6025A_C8B065596342_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.GetAllParamsCount

function TkwStatusBarOrderedControlsCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_C8B065596342_var*
//#UC END# *5617F4D00243_C8B065596342_var*
begin
//#UC START# *5617F4D00243_C8B065596342_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_C8B065596342_impl*
end;//TkwStatusBarOrderedControlsCount.ParamsTypes

function TkwStatusBarOrderIndex.OrderIndex(const aCtx: TtfwContext;
 aStatusBar: TnscStatusBar;
 aControl: TControl): Integer;
 {* Реализация слова скрипта StatusBar:OrderIndex }
//#UC START# *BD703176FDE6_F7D061E9FD6E_var*
//#UC END# *BD703176FDE6_F7D061E9FD6E_var*
begin
//#UC START# *BD703176FDE6_F7D061E9FD6E_impl*
 Result := aStatusBar.OrderIndex[aControl];
//#UC END# *BD703176FDE6_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.OrderIndex

procedure TkwStatusBarOrderIndex.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F7D061E9FD6E_var*
//#UC END# *4DAEEDE10285_F7D061E9FD6E_var*
begin
//#UC START# *4DAEEDE10285_F7D061E9FD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.DoDoIt

class function TkwStatusBarOrderIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'StatusBar:OrderIndex';
end;//TkwStatusBarOrderIndex.GetWordNameForRegister

function TkwStatusBarOrderIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_F7D061E9FD6E_var*
//#UC END# *551544E2001A_F7D061E9FD6E_var*
begin
//#UC START# *551544E2001A_F7D061E9FD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.GetResultTypeInfo

function TkwStatusBarOrderIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_F7D061E9FD6E_var*
//#UC END# *559687E6025A_F7D061E9FD6E_var*
begin
//#UC START# *559687E6025A_F7D061E9FD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.GetAllParamsCount

function TkwStatusBarOrderIndex.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F7D061E9FD6E_var*
//#UC END# *5617F4D00243_F7D061E9FD6E_var*
begin
//#UC START# *5617F4D00243_F7D061E9FD6E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F7D061E9FD6E_impl*
end;//TkwStatusBarOrderIndex.ParamsTypes

initialization
 TStatusBarWordsResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwStatusBarOrderedControl.RegisterInEngine;
 {* Регистрация StatusBar_OrderedControl }
 TkwStatusBarOrderedControlsCount.RegisterInEngine;
 {* Регистрация StatusBar_OrderedControlsCount }
 TkwStatusBarOrderIndex.RegisterInEngine;
 {* Регистрация StatusBar_OrderIndex }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscStatusBar));
 {* Регистрация типа TnscStatusBar }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TControl));
 {* Регистрация типа TControl }
{$IfEnd} // Defined(Nemesis) AND NOT Defined(NoScripts)

end.
