unit FormsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "FormsProcessingPack" MUID: (50741A1F028C)

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
 , Forms
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , Menus
 , ActnList
 , tfwGlobalKeyWord
 , tfwAxiomaticsResNameGetter
 , l3ObjectList
 , Classes
 , CustomFormProcessingPack
 , Controls
 , ActionListWordsPack
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopFormActiveMDIChild = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:ActiveMDIChild }
  private
   function pop_form_ActiveMDIChild(const aCtx: TtfwContext;
    aForm: TForm): TForm;
    {* Реализация слова скрипта pop:form:ActiveMDIChild }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormActiveMDIChild

 TkwPopFormClose = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:Close }
  private
   procedure pop_form_Close(const aCtx: TtfwContext;
    aForm: TForm);
    {* Реализация слова скрипта pop:form:Close }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormClose

 TkwPopFormFindMenuItem = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:FindMenuItem }
  private
   function pop_form_FindMenuItem(const aCtx: TtfwContext;
    aForm: TForm;
    const aName: AnsiString): TMenuItem;
    {* Реализация слова скрипта pop:form:FindMenuItem }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFindMenuItem

 TkwPopFormGetWindowState = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:GetWindowState }
  private
   function pop_form_GetWindowState(const aCtx: TtfwContext;
    aForm: TForm): TWindowState;
    {* Реализация слова скрипта pop:form:GetWindowState }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormGetWindowState

 TkwPopFormHasControl = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:HasControl }
  private
   function pop_form_HasControl(const aCtx: TtfwContext;
    aForm: TForm;
    const aName: AnsiString): Boolean;
    {* Реализация слова скрипта pop:form:HasControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormHasControl

 TkwPopFormMDIChildCount = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:MDIChildCount }
  private
   function pop_form_MDIChildCount(const aCtx: TtfwContext;
    aForm: TForm): Integer;
    {* Реализация слова скрипта pop:form:MDIChildCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormMDIChildCount

 TkwPopFormMDIChildren = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:MDIChildren }
  private
   function pop_form_MDIChildren(const aCtx: TtfwContext;
    aForm: TForm;
    anIndex: Integer): TForm;
    {* Реализация слова скрипта pop:form:MDIChildren }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormMDIChildren

 TkwPopFormModalResult = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:ModalResult }
  private
   function pop_form_ModalResult(const aCtx: TtfwContext;
    aForm: TForm): Integer;
    {* Реализация слова скрипта pop:form:ModalResult }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormModalResult

 TkwPopFormNext = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:Next }
  private
   procedure pop_form_Next(const aCtx: TtfwContext;
    aForm: TForm);
    {* Реализация слова скрипта pop:form:Next }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormNext

 TkwPopFormSetWindowState = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:SetWindowState }
  private
   procedure pop_form_SetWindowState(const aCtx: TtfwContext;
    aForm: TForm;
    aValue: TWindowState);
    {* Реализация слова скрипта pop:form:SetWindowState }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormSetWindowState

 TkwPopFormFindActionList = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:FindActionList }
  private
   function pop_form_FindActionList(const aCtx: TtfwContext;
    aForm: TForm;
    const aListName: AnsiString): TActionList;
    {* Реализация слова скрипта pop:form:FindActionList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopFormFindActionList

 TkwIterateForms = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта IterateForms }
  private
   procedure IterateForms(const aCtx: TtfwContext;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateForms }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateForms

 TFormsProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TFormsProcessingPackResNameGetter

function TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild(const aCtx: TtfwContext;
 aForm: TForm): TForm;
 {* Реализация слова скрипта pop:form:ActiveMDIChild }
//#UC START# *55324FF900D2_90DD5B736D00_var*
//#UC END# *55324FF900D2_90DD5B736D00_var*
begin
//#UC START# *55324FF900D2_90DD5B736D00_impl*
 Result := aForm.ActiveMDIChild;
//#UC END# *55324FF900D2_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild

procedure TkwPopFormActiveMDIChild.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_ActiveMDIChild(aCtx, l_aForm));
end;//TkwPopFormActiveMDIChild.DoDoIt

class function TkwPopFormActiveMDIChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ActiveMDIChild';
end;//TkwPopFormActiveMDIChild.GetWordNameForRegister

function TkwPopFormActiveMDIChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TForm);
end;//TkwPopFormActiveMDIChild.GetResultTypeInfo

function TkwPopFormActiveMDIChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormActiveMDIChild.GetAllParamsCount

function TkwPopFormActiveMDIChild.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormActiveMDIChild.ParamsTypes

procedure TkwPopFormClose.pop_form_Close(const aCtx: TtfwContext;
 aForm: TForm);
 {* Реализация слова скрипта pop:form:Close }
//#UC START# *5532502900D6_EF68563BBDE0_var*
//#UC END# *5532502900D6_EF68563BBDE0_var*
begin
//#UC START# *5532502900D6_EF68563BBDE0_impl*
 aForm.Close;
//#UC END# *5532502900D6_EF68563BBDE0_impl*
end;//TkwPopFormClose.pop_form_Close

procedure TkwPopFormClose.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_Close(aCtx, l_aForm);
end;//TkwPopFormClose.DoDoIt

class function TkwPopFormClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Close';
end;//TkwPopFormClose.GetWordNameForRegister

function TkwPopFormClose.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormClose.GetResultTypeInfo

function TkwPopFormClose.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormClose.GetAllParamsCount

function TkwPopFormClose.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormClose.ParamsTypes

function TkwPopFormFindMenuItem.pop_form_FindMenuItem(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): TMenuItem;
 {* Реализация слова скрипта pop:form:FindMenuItem }
//#UC START# *5532506100DC_CCC0609B3BF5_var*
const
 cDelimiter = '/';

 function FindMainMenu(aComponent: TComponent): TMainMenu;
 var
  I: Integer;
 begin
  Result := nil;
  for I := 0 to aComponent.ComponentCount - 1 do
   if aComponent.Components[I] is TMainMenu then
   begin
    Result := aComponent.Components[I] as TMainMenu;
    Exit;
   end;    
  for I := 0 to aComponent.ComponentCount - 1 do
  begin
   Result := FindMainMenu(aComponent.Components[I]);
   if Assigned(Result) then
    Exit;
  end;
 end;

 function GetNextItem(var anItem: TMenuItem; var aPath: AnsiString): Boolean;
 var
  I: Integer;
  l_DelimiterIndex: Integer;
  l_Name: AnsiString;
  l_FindItem: TMenuItem;
 begin
  l_DelimiterIndex := Pos(cDelimiter, aPath);
  if l_DelimiterIndex = 0 then
   l_Name := aPath
  else
  begin
   l_Name := Copy(aPath, 1, l_DelimiterIndex - 1);
   aPath := Copy(aPath, l_DelimiterIndex + 1, MaxInt);
  end;
  l_FindItem := anItem.Find(l_Name);
  Result := Assigned(l_FindItem);
  if Result then
   anItem := l_FindItem;
 end;
               
var
 l_Path: AnsiString;
 l_Menu: TMainMenu;
 l_Item: TMenuItem;
//#UC END# *5532506100DC_CCC0609B3BF5_var*
begin
//#UC START# *5532506100DC_CCC0609B3BF5_impl*
 l_Menu := FindMainMenu(aForm);
 RunnerAssert(Assigned(l_Menu), 'На форме нет меню', aCtx);
 {$IfDef l3HackedVCL}
 l_Menu.Items.CallInitiateActions;
 {$EndIf l3HackedVCL}
 l_Menu.Items.RethinkHotkeys;
 l_Menu.Items.RethinkLines;
 l_Path := aName;
 l_Item := l_Menu.Items;
 {$IfDef l3HackedVCL}
 while GetNextItem(l_Item, l_Path) do
  l_Item.CallInitiateActions;
 {$EndIf l3HackedVCL}
 l_Item.RethinkHotkeys;
 l_Item.RethinkLines;
 Result := l_Item;
//#UC END# *5532506100DC_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.pop_form_FindMenuItem

procedure TkwPopFormFindMenuItem.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_FindMenuItem(aCtx, l_aForm, l_aName));
end;//TkwPopFormFindMenuItem.DoDoIt

class function TkwPopFormFindMenuItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindMenuItem';
end;//TkwPopFormFindMenuItem.GetWordNameForRegister

function TkwPopFormFindMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TMenuItem);
end;//TkwPopFormFindMenuItem.GetResultTypeInfo

function TkwPopFormFindMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormFindMenuItem.GetAllParamsCount

function TkwPopFormFindMenuItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormFindMenuItem.ParamsTypes

function TkwPopFormGetWindowState.pop_form_GetWindowState(const aCtx: TtfwContext;
 aForm: TForm): TWindowState;
 {* Реализация слова скрипта pop:form:GetWindowState }
//#UC START# *55325098003C_DA5ACD40FDF6_var*
//#UC END# *55325098003C_DA5ACD40FDF6_var*
begin
//#UC START# *55325098003C_DA5ACD40FDF6_impl*
 Result := aForm.WindowState;
//#UC END# *55325098003C_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.pop_form_GetWindowState

procedure TkwPopFormGetWindowState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Ord(pop_form_GetWindowState(aCtx, l_aForm)));
end;//TkwPopFormGetWindowState.DoDoIt

class function TkwPopFormGetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:GetWindowState';
end;//TkwPopFormGetWindowState.GetWordNameForRegister

function TkwPopFormGetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TWindowState);
end;//TkwPopFormGetWindowState.GetResultTypeInfo

function TkwPopFormGetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormGetWindowState.GetAllParamsCount

function TkwPopFormGetWindowState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormGetWindowState.ParamsTypes

function TkwPopFormHasControl.pop_form_HasControl(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): Boolean;
 {* Реализация слова скрипта pop:form:HasControl }
//#UC START# *553250E10218_AF277B657685_var*
//#UC END# *553250E10218_AF277B657685_var*
begin
//#UC START# *553250E10218_AF277B657685_impl*
 Result := (aForm.FindChildControl(aName) <> nil);
//#UC END# *553250E10218_AF277B657685_impl*
end;//TkwPopFormHasControl.pop_form_HasControl

procedure TkwPopFormHasControl.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(pop_form_HasControl(aCtx, l_aForm, l_aName));
end;//TkwPopFormHasControl.DoDoIt

class function TkwPopFormHasControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:HasControl';
end;//TkwPopFormHasControl.GetWordNameForRegister

function TkwPopFormHasControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopFormHasControl.GetResultTypeInfo

function TkwPopFormHasControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormHasControl.GetAllParamsCount

function TkwPopFormHasControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormHasControl.ParamsTypes

function TkwPopFormMDIChildCount.pop_form_MDIChildCount(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* Реализация слова скрипта pop:form:MDIChildCount }
//#UC START# *553251110023_2C52284D1B9B_var*
//#UC END# *553251110023_2C52284D1B9B_var*
begin
//#UC START# *553251110023_2C52284D1B9B_impl*
 Result := aForm.MDIChildCount;
//#UC END# *553251110023_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.pop_form_MDIChildCount

procedure TkwPopFormMDIChildCount.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(pop_form_MDIChildCount(aCtx, l_aForm));
end;//TkwPopFormMDIChildCount.DoDoIt

class function TkwPopFormMDIChildCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildCount';
end;//TkwPopFormMDIChildCount.GetWordNameForRegister

function TkwPopFormMDIChildCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormMDIChildCount.GetResultTypeInfo

function TkwPopFormMDIChildCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormMDIChildCount.GetAllParamsCount

function TkwPopFormMDIChildCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormMDIChildCount.ParamsTypes

function TkwPopFormMDIChildren.pop_form_MDIChildren(const aCtx: TtfwContext;
 aForm: TForm;
 anIndex: Integer): TForm;
 {* Реализация слова скрипта pop:form:MDIChildren }
//#UC START# *5532513202C9_8D30B82D3D31_var*
//#UC END# *5532513202C9_8D30B82D3D31_var*
begin
//#UC START# *5532513202C9_8D30B82D3D31_impl*
 Result := aForm.MDIChildren[anIndex];
//#UC END# *5532513202C9_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.pop_form_MDIChildren

procedure TkwPopFormMDIChildren.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_anIndex: Integer;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
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
 aCtx.rEngine.PushObj(pop_form_MDIChildren(aCtx, l_aForm, l_anIndex));
end;//TkwPopFormMDIChildren.DoDoIt

class function TkwPopFormMDIChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildren';
end;//TkwPopFormMDIChildren.GetWordNameForRegister

function TkwPopFormMDIChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TForm);
end;//TkwPopFormMDIChildren.GetResultTypeInfo

function TkwPopFormMDIChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormMDIChildren.GetAllParamsCount

function TkwPopFormMDIChildren.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), TypeInfo(Integer)]);
end;//TkwPopFormMDIChildren.ParamsTypes

function TkwPopFormModalResult.pop_form_ModalResult(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* Реализация слова скрипта pop:form:ModalResult }
//#UC START# *5532516A0153_320C0D058217_var*
//#UC END# *5532516A0153_320C0D058217_var*
begin
//#UC START# *5532516A0153_320C0D058217_impl*
 RunnerAssert(fsModal in aForm.FormState, 'Это не модальная форма!', aCtx);
 Result := aForm.ModalResult;
//#UC END# *5532516A0153_320C0D058217_impl*
end;//TkwPopFormModalResult.pop_form_ModalResult

procedure TkwPopFormModalResult.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(pop_form_ModalResult(aCtx, l_aForm));
end;//TkwPopFormModalResult.DoDoIt

class function TkwPopFormModalResult.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ModalResult';
end;//TkwPopFormModalResult.GetWordNameForRegister

function TkwPopFormModalResult.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopFormModalResult.GetResultTypeInfo

function TkwPopFormModalResult.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormModalResult.GetAllParamsCount

function TkwPopFormModalResult.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormModalResult.ParamsTypes

procedure TkwPopFormNext.pop_form_Next(const aCtx: TtfwContext;
 aForm: TForm);
 {* Реализация слова скрипта pop:form:Next }
//#UC START# *5532518700A2_12E2A5A1963A_var*
//#UC END# *5532518700A2_12E2A5A1963A_var*
begin
//#UC START# *5532518700A2_12E2A5A1963A_impl*
 aForm.Next;
//#UC END# *5532518700A2_12E2A5A1963A_impl*
end;//TkwPopFormNext.pop_form_Next

procedure TkwPopFormNext.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_Next(aCtx, l_aForm);
end;//TkwPopFormNext.DoDoIt

class function TkwPopFormNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Next';
end;//TkwPopFormNext.GetWordNameForRegister

function TkwPopFormNext.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormNext.GetResultTypeInfo

function TkwPopFormNext.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopFormNext.GetAllParamsCount

function TkwPopFormNext.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm)]);
end;//TkwPopFormNext.ParamsTypes

procedure TkwPopFormSetWindowState.pop_form_SetWindowState(const aCtx: TtfwContext;
 aForm: TForm;
 aValue: TWindowState);
 {* Реализация слова скрипта pop:form:SetWindowState }
//#UC START# *553251B101E3_062C119864B2_var*
//#UC END# *553251B101E3_062C119864B2_var*
begin
//#UC START# *553251B101E3_062C119864B2_impl*
 aForm.WindowState := aValue;
//#UC END# *553251B101E3_062C119864B2_impl*
end;//TkwPopFormSetWindowState.pop_form_SetWindowState

procedure TkwPopFormSetWindowState.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aValue: TWindowState;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := TWindowState(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TWindowState : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 pop_form_SetWindowState(aCtx, l_aForm, l_aValue);
end;//TkwPopFormSetWindowState.DoDoIt

class function TkwPopFormSetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:SetWindowState';
end;//TkwPopFormSetWindowState.GetWordNameForRegister

function TkwPopFormSetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopFormSetWindowState.GetResultTypeInfo

function TkwPopFormSetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormSetWindowState.GetAllParamsCount

function TkwPopFormSetWindowState.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), TypeInfo(TWindowState)]);
end;//TkwPopFormSetWindowState.ParamsTypes

function TkwPopFormFindActionList.pop_form_FindActionList(const aCtx: TtfwContext;
 aForm: TForm;
 const aListName: AnsiString): TActionList;
 {* Реализация слова скрипта pop:form:FindActionList }
//#UC START# *55B8E3B403B6_76B7945239DF_var*
var
 l_Component : TComponent;
 i : Integer;
 l_Control : TControl;
//#UC END# *55B8E3B403B6_76B7945239DF_var*
begin
//#UC START# *55B8E3B403B6_76B7945239DF_impl*
 Result := nil;
 l_Component := aForm.FindComponent(aListName);
 if (l_Component = nil) then
 // Попробуем спросить у дочерних фреймов...
 begin
  for i := 0 to aForm.ControlCount - 1 do
  begin
   l_Control := aForm.Controls[i];
   if (l_Control is TFrame) then
   begin
    l_Component := l_Control.FindComponent(aListName);
    if (l_Component <> nil) then
     Break;
   end // if l_Control is TFrame then
  end; // for i := 0 to aForm.ControlCount - 1 do
 end; // if l_Component = nil then
 Result := l_Component As TActionList;
//#UC END# *55B8E3B403B6_76B7945239DF_impl*
end;//TkwPopFormFindActionList.pop_form_FindActionList

procedure TkwPopFormFindActionList.DoDoIt(const aCtx: TtfwContext);
var l_aForm: TForm;
var l_aListName: AnsiString;
begin
 try
  l_aForm := TForm(aCtx.rEngine.PopObjAs(TForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aForm: TForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aListName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aListName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(pop_form_FindActionList(aCtx, l_aForm, l_aListName));
end;//TkwPopFormFindActionList.DoDoIt

class function TkwPopFormFindActionList.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindActionList';
end;//TkwPopFormFindActionList.GetWordNameForRegister

function TkwPopFormFindActionList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TActionList);
end;//TkwPopFormFindActionList.GetResultTypeInfo

function TkwPopFormFindActionList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopFormFindActionList.GetAllParamsCount

function TkwPopFormFindActionList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TForm), @tfw_tiString]);
end;//TkwPopFormFindActionList.ParamsTypes

procedure TkwIterateForms.IterateForms(const aCtx: TtfwContext;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateForms }
//#UC START# *5532520C033E_5532520C033E_Word_var*
var
 l_Obj: TObject;
 I: Integer;
 l_FormsList: Tl3ObjectList;
//#UC END# *5532520C033E_5532520C033E_Word_var*
begin
//#UC START# *5532520C033E_5532520C033E_Word_impl*
 l_FormsList := Tl3ObjectList.Create;
 try
  for I := 0 to Screen.CustomFormCount - 1 do
   l_FormsList.Add(Screen.CustomForms[I]);

  for I := 0 to l_FormsList.Count - 1 do
  try
   aCtx.rEngine.PushObj(l_FormsList[I]);
   aLambda.DoIt(aCtx);
  except
   on EtfwBreakIterator do
    Exit;
  end;//try..except
 finally
  l_FormsList.Free;
 end;
//#UC END# *5532520C033E_5532520C033E_Word_impl*
end;//TkwIterateForms.IterateForms

class function TkwIterateForms.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateForms';
end;//TkwIterateForms.GetWordNameForRegister

function TkwIterateForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwIterateForms.GetResultTypeInfo

function TkwIterateForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIterateForms.GetAllParamsCount

function TkwIterateForms.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwIterateForms.ParamsTypes

procedure TkwIterateForms.DoDoIt(const aCtx: TtfwContext);
var l_aLambda: TtfwWord;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 IterateForms(aCtx, l_aLambda);
end;//TkwIterateForms.DoDoIt

class function TFormsProcessingPackResNameGetter.ResName: AnsiString;
begin
 Result := 'FormsProcessingPack';
end;//TFormsProcessingPackResNameGetter.ResName

 {$R FormsProcessingPack.res}

initialization
 TkwPopFormActiveMDIChild.RegisterInEngine;
 {* Регистрация pop_form_ActiveMDIChild }
 TkwPopFormClose.RegisterInEngine;
 {* Регистрация pop_form_Close }
 TkwPopFormFindMenuItem.RegisterInEngine;
 {* Регистрация pop_form_FindMenuItem }
 TkwPopFormGetWindowState.RegisterInEngine;
 {* Регистрация pop_form_GetWindowState }
 TkwPopFormHasControl.RegisterInEngine;
 {* Регистрация pop_form_HasControl }
 TkwPopFormMDIChildCount.RegisterInEngine;
 {* Регистрация pop_form_MDIChildCount }
 TkwPopFormMDIChildren.RegisterInEngine;
 {* Регистрация pop_form_MDIChildren }
 TkwPopFormModalResult.RegisterInEngine;
 {* Регистрация pop_form_ModalResult }
 TkwPopFormNext.RegisterInEngine;
 {* Регистрация pop_form_Next }
 TkwPopFormSetWindowState.RegisterInEngine;
 {* Регистрация pop_form_SetWindowState }
 TkwPopFormFindActionList.RegisterInEngine;
 {* Регистрация pop_form_FindActionList }
 TkwIterateForms.RegisterInEngine;
 {* Регистрация IterateForms }
 TFormsProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TForm));
 {* Регистрация типа TForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TMenuItem));
 {* Регистрация типа TMenuItem }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TWindowState));
 {* Регистрация типа TWindowState }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TActionList));
 {* Регистрация типа TActionList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
