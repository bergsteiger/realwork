unit MenuWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\MenuWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "MenuWordsPack" MUID: (4FC7292F02EA)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Menus
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , Controls
 , Forms
 , l3ScreenService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TMenuItemFriend = {abstract} class(TMenuItem)
  {* Друг к классу TMenuItem }
 end;//TMenuItemFriend

 TkwMenuItemClick = {final} class(TtfwClassLike)
  {* Слово скрипта menuitem:Click }
  private
   procedure Click(const aCtx: TtfwContext;
    aMenuItem: TMenuItem);
    {* Реализация слова скрипта menuitem:Click }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemClick

 TkwMenuItemGetItem = {final} class(TtfwClassLike)
  {* Слово скрипта menuitem:GetItem }
  private
   function GetItem(const aCtx: TtfwContext;
    aMenuItem: TMenuItem;
    anIndex: Integer): TMenuItem;
    {* Реализация слова скрипта menuitem:GetItem }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemGetItem

 TkwMenuItemGetMenuHeight = {final} class(TtfwClassLike)
  {* Слово скрипта menuitem:GetMenuHeight }
  private
   function GetMenuHeight(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
    {* Реализация слова скрипта menuitem:GetMenuHeight }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwMenuItemGetMenuHeight

 TkwMenuItemCaption = {final} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCaption }
  private
   function Caption(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): AnsiString;
    {* Реализация слова скрипта menuitem:GetCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMenuItemCaption

 TkwMenuItemCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:GetCount }
  private
   function Count(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Integer;
    {* Реализация слова скрипта menuitem:GetCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMenuItemCount

 TkwMenuItemEnabled = {final} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsEnabled }
  private
   function Enabled(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
    {* Реализация слова скрипта menuitem:IsEnabled }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMenuItemEnabled

 TkwMenuItemVisible = {final} class(TtfwPropertyLike)
  {* Слово скрипта menuitem:IsVisible }
  private
   function Visible(const aCtx: TtfwContext;
    aMenuItem: TMenuItem): Boolean;
    {* Реализация слова скрипта menuitem:IsVisible }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwMenuItemVisible

 TMenuWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TMenuWordsPackResNameGetter

procedure TkwMenuItemClick.Click(const aCtx: TtfwContext;
 aMenuItem: TMenuItem);
 {* Реализация слова скрипта menuitem:Click }
begin
 aMenuItem.Click;
end;//TkwMenuItemClick.Click

class function TkwMenuItemClick.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:Click';
end;//TkwMenuItemClick.GetWordNameForRegister

function TkwMenuItemClick.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwMenuItemClick.GetResultTypeInfo

function TkwMenuItemClick.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemClick.GetAllParamsCount

function TkwMenuItemClick.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemClick.ParamsTypes

procedure TkwMenuItemClick.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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

function TkwMenuItemGetItem.GetItem(const aCtx: TtfwContext;
 aMenuItem: TMenuItem;
 anIndex: Integer): TMenuItem;
 {* Реализация слова скрипта menuitem:GetItem }
//#UC START# *552E570E0302_552E570E0302_47E7ABCB0296_Word_var*
//#UC END# *552E570E0302_552E570E0302_47E7ABCB0296_Word_var*
begin
//#UC START# *552E570E0302_552E570E0302_47E7ABCB0296_Word_impl*
 Result := aMenuItem.Items[anIndex];
 Result.InitiateAction;
//#UC END# *552E570E0302_552E570E0302_47E7ABCB0296_Word_impl*
end;//TkwMenuItemGetItem.GetItem

class function TkwMenuItemGetItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetItem';
end;//TkwMenuItemGetItem.GetWordNameForRegister

function TkwMenuItemGetItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwMenuItemGetItem.GetResultTypeInfo

function TkwMenuItemGetItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwMenuItemGetItem.GetAllParamsCount

function TkwMenuItemGetItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem), TypeInfo(Integer)]);
end;//TkwMenuItemGetItem.ParamsTypes

procedure TkwMenuItemGetItem.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
var l_anIndex: Integer;
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
 aCtx.rEngine.PushObj(GetItem(aCtx, l_aMenuItem, l_anIndex));
end;//TkwMenuItemGetItem.DoDoIt

function TkwMenuItemGetMenuHeight.GetMenuHeight(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Integer;
 {* Реализация слова скрипта menuitem:GetMenuHeight }
//#UC START# *552E57E00346_552E57E00346_47E7ABCB0296_Word_var*
var
 I: Integer;
 l_Width, l_Height, l_TotalHeight: Integer;
 l_Canvas: TControlCanvas;
//#UC END# *552E57E00346_552E57E00346_47E7ABCB0296_Word_var*
begin
//#UC START# *552E57E00346_552E57E00346_47E7ABCB0296_Word_impl*
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
//#UC END# *552E57E00346_552E57E00346_47E7ABCB0296_Word_impl*
end;//TkwMenuItemGetMenuHeight.GetMenuHeight

class function TkwMenuItemGetMenuHeight.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetMenuHeight';
end;//TkwMenuItemGetMenuHeight.GetWordNameForRegister

function TkwMenuItemGetMenuHeight.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemGetMenuHeight.GetResultTypeInfo

function TkwMenuItemGetMenuHeight.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemGetMenuHeight.GetAllParamsCount

function TkwMenuItemGetMenuHeight.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemGetMenuHeight.ParamsTypes

procedure TkwMenuItemGetMenuHeight.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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
 aCtx.rEngine.PushInt(GetMenuHeight(aCtx, l_aMenuItem));
end;//TkwMenuItemGetMenuHeight.DoDoIt

function TkwMenuItemCaption.Caption(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): AnsiString;
 {* Реализация слова скрипта menuitem:GetCaption }
begin
 Result := aMenuItem.Caption;
end;//TkwMenuItemCaption.Caption

class function TkwMenuItemCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetCaption';
end;//TkwMenuItemCaption.GetWordNameForRegister

function TkwMenuItemCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwMenuItemCaption.GetResultTypeInfo

function TkwMenuItemCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemCaption.GetAllParamsCount

function TkwMenuItemCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemCaption.ParamsTypes

procedure TkwMenuItemCaption.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Caption', aCtx);
end;//TkwMenuItemCaption.SetValuePrim

procedure TkwMenuItemCaption.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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
 aCtx.rEngine.PushString(Caption(aCtx, l_aMenuItem));
end;//TkwMenuItemCaption.DoDoIt

function TkwMenuItemCount.Count(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Integer;
 {* Реализация слова скрипта menuitem:GetCount }
begin
 Result := aMenuItem.Count;
end;//TkwMenuItemCount.Count

class function TkwMenuItemCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:GetCount';
end;//TkwMenuItemCount.GetWordNameForRegister

function TkwMenuItemCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwMenuItemCount.GetResultTypeInfo

function TkwMenuItemCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemCount.GetAllParamsCount

function TkwMenuItemCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemCount.ParamsTypes

procedure TkwMenuItemCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwMenuItemCount.SetValuePrim

procedure TkwMenuItemCount.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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
 aCtx.rEngine.PushInt(Count(aCtx, l_aMenuItem));
end;//TkwMenuItemCount.DoDoIt

function TkwMenuItemEnabled.Enabled(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Boolean;
 {* Реализация слова скрипта menuitem:IsEnabled }
begin
 Result := aMenuItem.Enabled;
end;//TkwMenuItemEnabled.Enabled

class function TkwMenuItemEnabled.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:IsEnabled';
end;//TkwMenuItemEnabled.GetWordNameForRegister

function TkwMenuItemEnabled.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemEnabled.GetResultTypeInfo

function TkwMenuItemEnabled.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemEnabled.GetAllParamsCount

function TkwMenuItemEnabled.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemEnabled.ParamsTypes

procedure TkwMenuItemEnabled.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Enabled', aCtx);
end;//TkwMenuItemEnabled.SetValuePrim

procedure TkwMenuItemEnabled.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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
 aCtx.rEngine.PushBool(Enabled(aCtx, l_aMenuItem));
end;//TkwMenuItemEnabled.DoDoIt

function TkwMenuItemVisible.Visible(const aCtx: TtfwContext;
 aMenuItem: TMenuItem): Boolean;
 {* Реализация слова скрипта menuitem:IsVisible }
begin
 Result := aMenuItem.Visible;
end;//TkwMenuItemVisible.Visible

class function TkwMenuItemVisible.GetWordNameForRegister: AnsiString;
begin
 Result := 'menuitem:IsVisible';
end;//TkwMenuItemVisible.GetWordNameForRegister

function TkwMenuItemVisible.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwMenuItemVisible.GetResultTypeInfo

function TkwMenuItemVisible.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwMenuItemVisible.GetAllParamsCount

function TkwMenuItemVisible.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TMenuItem)]);
end;//TkwMenuItemVisible.ParamsTypes

procedure TkwMenuItemVisible.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Visible', aCtx);
end;//TkwMenuItemVisible.SetValuePrim

procedure TkwMenuItemVisible.DoDoIt(const aCtx: TtfwContext);
var l_aMenuItem: TMenuItem;
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
 aCtx.rEngine.PushBool(Visible(aCtx, l_aMenuItem));
end;//TkwMenuItemVisible.DoDoIt

class function TMenuWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'MenuWordsPack';
end;//TMenuWordsPackResNameGetter.ResName

 {$R MenuWordsPack.res}

initialization
 TkwMenuItemClick.RegisterInEngine;
 {* Регистрация MenuItem_Click }
 TkwMenuItemGetItem.RegisterInEngine;
 {* Регистрация MenuItem_GetItem }
 TkwMenuItemGetMenuHeight.RegisterInEngine;
 {* Регистрация MenuItem_GetMenuHeight }
 TkwMenuItemCaption.RegisterInEngine;
 {* Регистрация MenuItem_Caption }
 TkwMenuItemCount.RegisterInEngine;
 {* Регистрация MenuItem_Count }
 TkwMenuItemEnabled.RegisterInEngine;
 {* Регистрация MenuItem_Enabled }
 TkwMenuItemVisible.RegisterInEngine;
 {* Регистрация MenuItem_Visible }
 TMenuWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
