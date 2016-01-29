unit MenuWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$RTLandVCL"
// Модуль: "MenuWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$RTLandVCL::MenuWords::MenuWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Menus,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts AND not NoVCL

implementation

{$If not defined(NoScripts) AND not defined(NoVCL)}
uses
  Controls,
  Forms,
  l3ScreenService,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *B4809E50CD0Fci*
//#UC END# *B4809E50CD0Fci*
//#UC START# *B4809E50CD0Fcit*
//#UC END# *B4809E50CD0Fcit*
 TMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *B4809E50CD0Fpubl*
//#UC END# *B4809E50CD0Fpubl*
 end;//TMenuWordsPackResNameGetter

// start class TMenuWordsPackResNameGetter

class function TMenuWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'MenuWordsPack';
end;//TMenuWordsPackResNameGetter.ResName

 {$R MenuWordsPack.res}

type
 TMenuItemFriend = {abstract} class(TMenuItem)
  {* Друг для TMenuItem }
 end;//TMenuItemFriend

 TkwMenuItemClick = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта menuitem:Click
*Пример:*
[code]
 aMenuItem menuitem:Click
[code]  }
 private
 // private methods
   procedure Click(const aCtx: TtfwContext;
    aMenuItem: TMenuItem);
     {* Реализация слова скрипта menuitem:Click }
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
 end;//TkwMenuItemClick

// start class TkwMenuItemClick

procedure TkwMenuItemClick.Click(const aCtx: TtfwContext;
  aMenuItem: TMenuItem);
 {-}
begin
 aMenuItem.Click;
end;//TkwMenuItemClick.Click

procedure TkwMenuItemClick.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Click(aCtx, l_aMenuItem);
end;//TkwMenuItemClick.DoDoIt

class function TkwMenuItemClick.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:Click';
end;//TkwMenuItemClick.GetWordNameForRegister

function TkwMenuItemClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwMenuItemClick.GetResultTypeInfo

function TkwMenuItemClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemClick.GetAllParamsCount

function TkwMenuItemClick.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemClick.ParamsTypes

type
 TkwMenuItemGetItem = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта menuitem:GetItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 anIndex aMenuItem menuitem:GetItem >>> l_TMenuItem
[code]  }
 private
 // private methods
   function GetItem(const aCtx: TtfwContext;
    aMenuItem: TMenuItem;
    anIndex: Integer): TMenuItem;
     {* Реализация слова скрипта menuitem:GetItem }
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
 end;//TkwMenuItemGetItem

// start class TkwMenuItemGetItem

function TkwMenuItemGetItem.GetItem(const aCtx: TtfwContext;
  aMenuItem: TMenuItem;
  anIndex: Integer): TMenuItem;
//#UC START# *E7D62A88975C_89C28B4155A9_var*
//#UC END# *E7D62A88975C_89C28B4155A9_var*
begin
//#UC START# *E7D62A88975C_89C28B4155A9_impl*
 Result := aMenuItem.Items[anIndex];
 Result.InitiateAction;
//#UC END# *E7D62A88975C_89C28B4155A9_impl*
end;//TkwMenuItemGetItem.GetItem

procedure TkwMenuItemGetItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
 l_anIndex : Integer;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj((GetItem(aCtx, l_aMenuItem, l_anIndex)));
end;//TkwMenuItemGetItem.DoDoIt

class function TkwMenuItemGetItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:GetItem';
end;//TkwMenuItemGetItem.GetWordNameForRegister

function TkwMenuItemGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TMenuItem);
end;//TkwMenuItemGetItem.GetResultTypeInfo

function TkwMenuItemGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwMenuItemGetItem.GetAllParamsCount

function TkwMenuItemGetItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem), TypeInfo(Integer)]);
end;//TkwMenuItemGetItem.ParamsTypes

type
 TkwMenuItemGetMenuHeight = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта menuitem:GetMenuHeight
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetMenuHeight >>> l_Integer
[code]  }
 private
 // private methods
   function GetMenuHeight(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
     {* Реализация слова скрипта menuitem:GetMenuHeight }
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
 end;//TkwMenuItemGetMenuHeight

// start class TkwMenuItemGetMenuHeight

function TkwMenuItemGetMenuHeight.GetMenuHeight(const aCtx: TtfwContext;
  aMenuItem: TMenuItem): Integer;
//#UC START# *F09CA18F756D_F44EDB26B480_var*
var
 I: Integer;
 l_Width, l_Height, l_TotalHeight: Integer;
 l_Canvas: TControlCanvas;
//#UC END# *F09CA18F756D_F44EDB26B480_var*
begin
//#UC START# *F09CA18F756D_F44EDB26B480_impl*
 l_TotalHeight := 0;
 l_Canvas := TControlCanvas.Create;
 try
  l_Canvas.Handle := Tl3ScreenService.Instance.IC.DC;
  l_Canvas.Font := Screen.MenuFont;
  for I := 0 to aMenuItem.Count - 1 do
  begin
   l_Height := 0;
   TMenuItemFriend(aMenuItem.Items[I]).MeasureItem(l_Canvas, l_Width, l_Height);
   l_TotalHeight := l_TotalHeight + l_Height;
  end;//for I
 finally
  FreeAndNil(l_Canvas);
 end;//try..finally
 Result := l_TotalHeight;
//#UC END# *F09CA18F756D_F44EDB26B480_impl*
end;//TkwMenuItemGetMenuHeight.GetMenuHeight

procedure TkwMenuItemGetMenuHeight.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((GetMenuHeight(aCtx, l_aMenuItem)));
end;//TkwMenuItemGetMenuHeight.DoDoIt

class function TkwMenuItemGetMenuHeight.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:GetMenuHeight';
end;//TkwMenuItemGetMenuHeight.GetWordNameForRegister

function TkwMenuItemGetMenuHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemGetMenuHeight.GetResultTypeInfo

function TkwMenuItemGetMenuHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemGetMenuHeight.GetAllParamsCount

function TkwMenuItemGetMenuHeight.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemGetMenuHeight.ParamsTypes

type
 TkwMenuItemCaption = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aMenuItem menuitem:GetCaption >>> l_String
[code]  }
 private
 // private methods
   function Caption(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): AnsiString;
     {* Реализация слова скрипта menuitem:GetCaption }
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
 end;//TkwMenuItemCaption

// start class TkwMenuItemCaption

function TkwMenuItemCaption.Caption(const aCtx: TtfwContext;
  aMenuItem: TMenuItem): AnsiString;
 {-}
begin
 Result := aMenuItem.Caption;
end;//TkwMenuItemCaption.Caption

procedure TkwMenuItemCaption.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString((Caption(aCtx, l_aMenuItem)));
end;//TkwMenuItemCaption.DoDoIt

class function TkwMenuItemCaption.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:GetCaption';
end;//TkwMenuItemCaption.GetWordNameForRegister

procedure TkwMenuItemCaption.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwMenuItemCaption.SetValuePrim

function TkwMenuItemCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(AnsiString);
end;//TkwMenuItemCaption.GetResultTypeInfo

function TkwMenuItemCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemCaption.GetAllParamsCount

function TkwMenuItemCaption.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemCaption.ParamsTypes

type
 TkwMenuItemCount = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aMenuItem menuitem:GetCount >>> l_Integer
[code]  }
 private
 // private methods
   function Count(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
     {* Реализация слова скрипта menuitem:GetCount }
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
 end;//TkwMenuItemCount

// start class TkwMenuItemCount

function TkwMenuItemCount.Count(const aCtx: TtfwContext;
  aMenuItem: TMenuItem): Integer;
 {-}
begin
 Result := aMenuItem.Count;
end;//TkwMenuItemCount.Count

procedure TkwMenuItemCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Count(aCtx, l_aMenuItem)));
end;//TkwMenuItemCount.DoDoIt

class function TkwMenuItemCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:GetCount';
end;//TkwMenuItemCount.GetWordNameForRegister

procedure TkwMenuItemCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwMenuItemCount.SetValuePrim

function TkwMenuItemCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemCount.GetResultTypeInfo

function TkwMenuItemCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemCount.GetAllParamsCount

function TkwMenuItemCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemCount.ParamsTypes

type
 TkwMenuItemEnabled = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsEnabled
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsEnabled >>> l_Boolean
[code]  }
 private
 // private methods
   function Enabled(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
     {* Реализация слова скрипта menuitem:IsEnabled }
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
 end;//TkwMenuItemEnabled

// start class TkwMenuItemEnabled

function TkwMenuItemEnabled.Enabled(const aCtx: TtfwContext;
  aMenuItem: TMenuItem): Boolean;
 {-}
begin
 Result := aMenuItem.Enabled;
end;//TkwMenuItemEnabled.Enabled

procedure TkwMenuItemEnabled.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Enabled(aCtx, l_aMenuItem)));
end;//TkwMenuItemEnabled.DoDoIt

class function TkwMenuItemEnabled.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:IsEnabled';
end;//TkwMenuItemEnabled.GetWordNameForRegister

procedure TkwMenuItemEnabled.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwMenuItemEnabled.SetValuePrim

function TkwMenuItemEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemEnabled.GetResultTypeInfo

function TkwMenuItemEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemEnabled.GetAllParamsCount

function TkwMenuItemEnabled.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemEnabled.ParamsTypes

type
 TkwMenuItemVisible = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsVisible
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aMenuItem menuitem:IsVisible >>> l_Boolean
[code]  }
 private
 // private methods
   function Visible(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
     {* Реализация слова скрипта menuitem:IsVisible }
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
 end;//TkwMenuItemVisible

// start class TkwMenuItemVisible

function TkwMenuItemVisible.Visible(const aCtx: TtfwContext;
  aMenuItem: TMenuItem): Boolean;
 {-}
begin
 Result := aMenuItem.Visible;
end;//TkwMenuItemVisible.Visible

procedure TkwMenuItemVisible.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aMenuItem : TMenuItem;
begin
 try
  l_aMenuItem := TMenuItem(aCtx.rEngine.PopObjAs(TMenuItem));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aMenuItem: TMenuItem : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool((Visible(aCtx, l_aMenuItem)));
end;//TkwMenuItemVisible.DoDoIt

class function TkwMenuItemVisible.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'menuitem:IsVisible';
end;//TkwMenuItemVisible.GetWordNameForRegister

procedure TkwMenuItemVisible.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwMenuItemVisible.SetValuePrim

function TkwMenuItemVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemVisible.GetResultTypeInfo

function TkwMenuItemVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwMenuItemVisible.GetAllParamsCount

function TkwMenuItemVisible.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemVisible.ParamsTypes
{$IfEnd} //not NoScripts AND not NoVCL

initialization
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация скриптованой аксиоматики
 TMenuWordsPackResNameGetter.Register;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_Click
 TkwMenuItemClick.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_GetItem
 TkwMenuItemGetItem.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_GetMenuHeight
 TkwMenuItemGetMenuHeight.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_Caption
 TkwMenuItemCaption.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_Count
 TkwMenuItemCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_Enabled
 TkwMenuItemEnabled.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация MenuItem_Visible
 TkwMenuItemVisible.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа TMenuItem
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа String
 TtfwTypeRegistrator.RegisterType(TypeInfo(AnsiString));
{$IfEnd} //not NoScripts AND not NoVCL
{$If not defined(NoScripts) AND not defined(NoVCL)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoVCL

end.