unit FormsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\FormsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
 , Forms
 , Menus
 , ActnList
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwGlobalKeyWord
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , l3ObjectList
 , Classes
 , CustomFormProcessingPack
 , Controls
 , ActionListWordsPack
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *38481B365F20ci*
 //#UC END# *38481B365F20ci*
 //#UC START# *38481B365F20cit*
 //#UC END# *38481B365F20cit*
 TFormsProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *38481B365F20publ*
 //#UC END# *38481B365F20publ*
 end;//TFormsProcessingPackResNameGetter

 TkwPopFormActiveMDIChild = {final} class(TtfwClassLike)
  {* Слово скрипта pop:form:ActiveMDIChild
*Тип результата:* TForm
*Пример:*
[code]
OBJECT VAR l_TForm
 aForm pop:form:ActiveMDIChild >>> l_TForm
[code]  }
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
  {* Слово скрипта pop:form:Close
*Пример:*
[code]
 aForm pop:form:Close
[code]  }
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
  {* Слово скрипта pop:form:FindMenuItem
*Тип результата:* TMenuItem
*Пример:*
[code]
OBJECT VAR l_TMenuItem
 aName aForm pop:form:FindMenuItem >>> l_TMenuItem
[code]  }
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
  {* Слово скрипта pop:form:GetWindowState
*Тип результата:* TWindowState
*Пример:*
[code]
TWindowState VAR l_TWindowState
 aForm pop:form:GetWindowState >>> l_TWindowState
[code]  }
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
  {* Слово скрипта pop:form:HasControl
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName aForm pop:form:HasControl >>> l_Boolean
[code]  }
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
  {* Слово скрипта pop:form:MDIChildCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:MDIChildCount >>> l_Integer
[code]  }
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
  {* Слово скрипта pop:form:MDIChildren
*Тип результата:* TForm
*Пример:*
[code]
OBJECT VAR l_TForm
 anIndex aForm pop:form:MDIChildren >>> l_TForm
[code]  }
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
  {* Слово скрипта pop:form:ModalResult
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aForm pop:form:ModalResult >>> l_Integer
[code]  }
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
  {* Слово скрипта pop:form:Next
*Пример:*
[code]
 aForm pop:form:Next
[code]  }
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
  {* Слово скрипта pop:form:SetWindowState
*Пример:*
[code]
 aValue aForm pop:form:SetWindowState
[code]  }
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
  {* Слово скрипта pop:form:FindActionList
*Тип результата:* TActionList
*Пример:*
[code]
OBJECT VAR l_TActionList
 aListName aForm pop:form:FindActionList >>> l_TActionList
[code]  }
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
  {* Слово скрипта IterateForms
*Пример:*
[code]
 aLambda IterateForms
[code]  }
  private
   procedure IterateForms(const aCtx: TtfwContext;
    aLambda: TtfwWord);
    {* Реализация слова скрипта IterateForms }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIterateForms

class function TFormsProcessingPackResNameGetter.ResName: AnsiString;
begin
  Result := 'FormsProcessingPack';
end;//TFormsProcessingPackResNameGetter.ResName

 {$R FormsProcessingPack.res}

function TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild(const aCtx: TtfwContext;
 aForm: TForm): TForm;
 {* Реализация слова скрипта pop:form:ActiveMDIChild }
//#UC START# *8AB0508CEF4C_90DD5B736D00_var*
//#UC END# *8AB0508CEF4C_90DD5B736D00_var*
begin
//#UC START# *8AB0508CEF4C_90DD5B736D00_impl*
 Result := aForm.ActiveMDIChild;
//#UC END# *8AB0508CEF4C_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.pop_form_ActiveMDIChild

procedure TkwPopFormActiveMDIChild.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_90DD5B736D00_var*
//#UC END# *4DAEEDE10285_90DD5B736D00_var*
begin
//#UC START# *4DAEEDE10285_90DD5B736D00_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.DoDoIt

class function TkwPopFormActiveMDIChild.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ActiveMDIChild';
end;//TkwPopFormActiveMDIChild.GetWordNameForRegister

function TkwPopFormActiveMDIChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_90DD5B736D00_var*
//#UC END# *551544E2001A_90DD5B736D00_var*
begin
//#UC START# *551544E2001A_90DD5B736D00_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.GetResultTypeInfo

function TkwPopFormActiveMDIChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_90DD5B736D00_var*
//#UC END# *559687E6025A_90DD5B736D00_var*
begin
//#UC START# *559687E6025A_90DD5B736D00_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.GetAllParamsCount

function TkwPopFormActiveMDIChild.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_90DD5B736D00_var*
//#UC END# *5617F4D00243_90DD5B736D00_var*
begin
//#UC START# *5617F4D00243_90DD5B736D00_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_90DD5B736D00_impl*
end;//TkwPopFormActiveMDIChild.ParamsTypes

procedure TkwPopFormClose.pop_form_Close(const aCtx: TtfwContext;
 aForm: TForm);
 {* Реализация слова скрипта pop:form:Close }
//#UC START# *2435574FF0DB_EF68563BBDE0_var*
//#UC END# *2435574FF0DB_EF68563BBDE0_var*
begin
//#UC START# *2435574FF0DB_EF68563BBDE0_impl*
 aForm.Close;
//#UC END# *2435574FF0DB_EF68563BBDE0_impl*
end;//TkwPopFormClose.pop_form_Close

procedure TkwPopFormClose.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EF68563BBDE0_var*
//#UC END# *4DAEEDE10285_EF68563BBDE0_var*
begin
//#UC START# *4DAEEDE10285_EF68563BBDE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EF68563BBDE0_impl*
end;//TkwPopFormClose.DoDoIt

class function TkwPopFormClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Close';
end;//TkwPopFormClose.GetWordNameForRegister

function TkwPopFormClose.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_EF68563BBDE0_var*
//#UC END# *551544E2001A_EF68563BBDE0_var*
begin
//#UC START# *551544E2001A_EF68563BBDE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_EF68563BBDE0_impl*
end;//TkwPopFormClose.GetResultTypeInfo

function TkwPopFormClose.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_EF68563BBDE0_var*
//#UC END# *559687E6025A_EF68563BBDE0_var*
begin
//#UC START# *559687E6025A_EF68563BBDE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_EF68563BBDE0_impl*
end;//TkwPopFormClose.GetAllParamsCount

function TkwPopFormClose.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_EF68563BBDE0_var*
//#UC END# *5617F4D00243_EF68563BBDE0_var*
begin
//#UC START# *5617F4D00243_EF68563BBDE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_EF68563BBDE0_impl*
end;//TkwPopFormClose.ParamsTypes

function TkwPopFormFindMenuItem.pop_form_FindMenuItem(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): TMenuItem;
 {* Реализация слова скрипта pop:form:FindMenuItem }
//#UC START# *91740A9F6F65_CCC0609B3BF5_var*
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
//#UC END# *91740A9F6F65_CCC0609B3BF5_var*
begin
//#UC START# *91740A9F6F65_CCC0609B3BF5_impl*
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
//#UC END# *91740A9F6F65_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.pop_form_FindMenuItem

procedure TkwPopFormFindMenuItem.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CCC0609B3BF5_var*
//#UC END# *4DAEEDE10285_CCC0609B3BF5_var*
begin
//#UC START# *4DAEEDE10285_CCC0609B3BF5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.DoDoIt

class function TkwPopFormFindMenuItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindMenuItem';
end;//TkwPopFormFindMenuItem.GetWordNameForRegister

function TkwPopFormFindMenuItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_CCC0609B3BF5_var*
//#UC END# *551544E2001A_CCC0609B3BF5_var*
begin
//#UC START# *551544E2001A_CCC0609B3BF5_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.GetResultTypeInfo

function TkwPopFormFindMenuItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_CCC0609B3BF5_var*
//#UC END# *559687E6025A_CCC0609B3BF5_var*
begin
//#UC START# *559687E6025A_CCC0609B3BF5_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.GetAllParamsCount

function TkwPopFormFindMenuItem.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_CCC0609B3BF5_var*
//#UC END# *5617F4D00243_CCC0609B3BF5_var*
begin
//#UC START# *5617F4D00243_CCC0609B3BF5_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_CCC0609B3BF5_impl*
end;//TkwPopFormFindMenuItem.ParamsTypes

function TkwPopFormGetWindowState.pop_form_GetWindowState(const aCtx: TtfwContext;
 aForm: TForm): TWindowState;
 {* Реализация слова скрипта pop:form:GetWindowState }
//#UC START# *1AF6E71E5FCF_DA5ACD40FDF6_var*
//#UC END# *1AF6E71E5FCF_DA5ACD40FDF6_var*
begin
//#UC START# *1AF6E71E5FCF_DA5ACD40FDF6_impl*
 Result := aForm.WindowState;
//#UC END# *1AF6E71E5FCF_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.pop_form_GetWindowState

procedure TkwPopFormGetWindowState.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DA5ACD40FDF6_var*
//#UC END# *4DAEEDE10285_DA5ACD40FDF6_var*
begin
//#UC START# *4DAEEDE10285_DA5ACD40FDF6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.DoDoIt

class function TkwPopFormGetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:GetWindowState';
end;//TkwPopFormGetWindowState.GetWordNameForRegister

function TkwPopFormGetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DA5ACD40FDF6_var*
//#UC END# *551544E2001A_DA5ACD40FDF6_var*
begin
//#UC START# *551544E2001A_DA5ACD40FDF6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.GetResultTypeInfo

function TkwPopFormGetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_DA5ACD40FDF6_var*
//#UC END# *559687E6025A_DA5ACD40FDF6_var*
begin
//#UC START# *559687E6025A_DA5ACD40FDF6_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.GetAllParamsCount

function TkwPopFormGetWindowState.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DA5ACD40FDF6_var*
//#UC END# *5617F4D00243_DA5ACD40FDF6_var*
begin
//#UC START# *5617F4D00243_DA5ACD40FDF6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DA5ACD40FDF6_impl*
end;//TkwPopFormGetWindowState.ParamsTypes

function TkwPopFormHasControl.pop_form_HasControl(const aCtx: TtfwContext;
 aForm: TForm;
 const aName: AnsiString): Boolean;
 {* Реализация слова скрипта pop:form:HasControl }
//#UC START# *1040311EDE6F_AF277B657685_var*
//#UC END# *1040311EDE6F_AF277B657685_var*
begin
//#UC START# *1040311EDE6F_AF277B657685_impl*
 Result := (aForm.FindChildControl(aName) <> nil);
//#UC END# *1040311EDE6F_AF277B657685_impl*
end;//TkwPopFormHasControl.pop_form_HasControl

procedure TkwPopFormHasControl.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AF277B657685_var*
//#UC END# *4DAEEDE10285_AF277B657685_var*
begin
//#UC START# *4DAEEDE10285_AF277B657685_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AF277B657685_impl*
end;//TkwPopFormHasControl.DoDoIt

class function TkwPopFormHasControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:HasControl';
end;//TkwPopFormHasControl.GetWordNameForRegister

function TkwPopFormHasControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AF277B657685_var*
//#UC END# *551544E2001A_AF277B657685_var*
begin
//#UC START# *551544E2001A_AF277B657685_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AF277B657685_impl*
end;//TkwPopFormHasControl.GetResultTypeInfo

function TkwPopFormHasControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_AF277B657685_var*
//#UC END# *559687E6025A_AF277B657685_var*
begin
//#UC START# *559687E6025A_AF277B657685_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_AF277B657685_impl*
end;//TkwPopFormHasControl.GetAllParamsCount

function TkwPopFormHasControl.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AF277B657685_var*
//#UC END# *5617F4D00243_AF277B657685_var*
begin
//#UC START# *5617F4D00243_AF277B657685_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AF277B657685_impl*
end;//TkwPopFormHasControl.ParamsTypes

function TkwPopFormMDIChildCount.pop_form_MDIChildCount(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* Реализация слова скрипта pop:form:MDIChildCount }
//#UC START# *12B749ECF277_2C52284D1B9B_var*
//#UC END# *12B749ECF277_2C52284D1B9B_var*
begin
//#UC START# *12B749ECF277_2C52284D1B9B_impl*
 Result := aForm.MDIChildCount;
//#UC END# *12B749ECF277_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.pop_form_MDIChildCount

procedure TkwPopFormMDIChildCount.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2C52284D1B9B_var*
//#UC END# *4DAEEDE10285_2C52284D1B9B_var*
begin
//#UC START# *4DAEEDE10285_2C52284D1B9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.DoDoIt

class function TkwPopFormMDIChildCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildCount';
end;//TkwPopFormMDIChildCount.GetWordNameForRegister

function TkwPopFormMDIChildCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_2C52284D1B9B_var*
//#UC END# *551544E2001A_2C52284D1B9B_var*
begin
//#UC START# *551544E2001A_2C52284D1B9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.GetResultTypeInfo

function TkwPopFormMDIChildCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_2C52284D1B9B_var*
//#UC END# *559687E6025A_2C52284D1B9B_var*
begin
//#UC START# *559687E6025A_2C52284D1B9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.GetAllParamsCount

function TkwPopFormMDIChildCount.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2C52284D1B9B_var*
//#UC END# *5617F4D00243_2C52284D1B9B_var*
begin
//#UC START# *5617F4D00243_2C52284D1B9B_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2C52284D1B9B_impl*
end;//TkwPopFormMDIChildCount.ParamsTypes

function TkwPopFormMDIChildren.pop_form_MDIChildren(const aCtx: TtfwContext;
 aForm: TForm;
 anIndex: Integer): TForm;
 {* Реализация слова скрипта pop:form:MDIChildren }
//#UC START# *3639BFFF59A0_8D30B82D3D31_var*
//#UC END# *3639BFFF59A0_8D30B82D3D31_var*
begin
//#UC START# *3639BFFF59A0_8D30B82D3D31_impl*
 Result := aForm.MDIChildren[anIndex];
//#UC END# *3639BFFF59A0_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.pop_form_MDIChildren

procedure TkwPopFormMDIChildren.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8D30B82D3D31_var*
//#UC END# *4DAEEDE10285_8D30B82D3D31_var*
begin
//#UC START# *4DAEEDE10285_8D30B82D3D31_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.DoDoIt

class function TkwPopFormMDIChildren.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:MDIChildren';
end;//TkwPopFormMDIChildren.GetWordNameForRegister

function TkwPopFormMDIChildren.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8D30B82D3D31_var*
//#UC END# *551544E2001A_8D30B82D3D31_var*
begin
//#UC START# *551544E2001A_8D30B82D3D31_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.GetResultTypeInfo

function TkwPopFormMDIChildren.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8D30B82D3D31_var*
//#UC END# *559687E6025A_8D30B82D3D31_var*
begin
//#UC START# *559687E6025A_8D30B82D3D31_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.GetAllParamsCount

function TkwPopFormMDIChildren.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8D30B82D3D31_var*
//#UC END# *5617F4D00243_8D30B82D3D31_var*
begin
//#UC START# *5617F4D00243_8D30B82D3D31_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8D30B82D3D31_impl*
end;//TkwPopFormMDIChildren.ParamsTypes

function TkwPopFormModalResult.pop_form_ModalResult(const aCtx: TtfwContext;
 aForm: TForm): Integer;
 {* Реализация слова скрипта pop:form:ModalResult }
//#UC START# *258A2F5BBDB1_320C0D058217_var*
//#UC END# *258A2F5BBDB1_320C0D058217_var*
begin
//#UC START# *258A2F5BBDB1_320C0D058217_impl*
 RunnerAssert(fsModal in aForm.FormState, 'Это не модальная форма!', aCtx);
 Result := aForm.ModalResult;
//#UC END# *258A2F5BBDB1_320C0D058217_impl*
end;//TkwPopFormModalResult.pop_form_ModalResult

procedure TkwPopFormModalResult.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_320C0D058217_var*
//#UC END# *4DAEEDE10285_320C0D058217_var*
begin
//#UC START# *4DAEEDE10285_320C0D058217_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_320C0D058217_impl*
end;//TkwPopFormModalResult.DoDoIt

class function TkwPopFormModalResult.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:ModalResult';
end;//TkwPopFormModalResult.GetWordNameForRegister

function TkwPopFormModalResult.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_320C0D058217_var*
//#UC END# *551544E2001A_320C0D058217_var*
begin
//#UC START# *551544E2001A_320C0D058217_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_320C0D058217_impl*
end;//TkwPopFormModalResult.GetResultTypeInfo

function TkwPopFormModalResult.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_320C0D058217_var*
//#UC END# *559687E6025A_320C0D058217_var*
begin
//#UC START# *559687E6025A_320C0D058217_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_320C0D058217_impl*
end;//TkwPopFormModalResult.GetAllParamsCount

function TkwPopFormModalResult.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_320C0D058217_var*
//#UC END# *5617F4D00243_320C0D058217_var*
begin
//#UC START# *5617F4D00243_320C0D058217_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_320C0D058217_impl*
end;//TkwPopFormModalResult.ParamsTypes

procedure TkwPopFormNext.pop_form_Next(const aCtx: TtfwContext;
 aForm: TForm);
 {* Реализация слова скрипта pop:form:Next }
//#UC START# *BE561C1EA571_12E2A5A1963A_var*
//#UC END# *BE561C1EA571_12E2A5A1963A_var*
begin
//#UC START# *BE561C1EA571_12E2A5A1963A_impl*
 aForm.Next;
//#UC END# *BE561C1EA571_12E2A5A1963A_impl*
end;//TkwPopFormNext.pop_form_Next

procedure TkwPopFormNext.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_12E2A5A1963A_var*
//#UC END# *4DAEEDE10285_12E2A5A1963A_var*
begin
//#UC START# *4DAEEDE10285_12E2A5A1963A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_12E2A5A1963A_impl*
end;//TkwPopFormNext.DoDoIt

class function TkwPopFormNext.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:Next';
end;//TkwPopFormNext.GetWordNameForRegister

function TkwPopFormNext.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_12E2A5A1963A_var*
//#UC END# *551544E2001A_12E2A5A1963A_var*
begin
//#UC START# *551544E2001A_12E2A5A1963A_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_12E2A5A1963A_impl*
end;//TkwPopFormNext.GetResultTypeInfo

function TkwPopFormNext.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_12E2A5A1963A_var*
//#UC END# *559687E6025A_12E2A5A1963A_var*
begin
//#UC START# *559687E6025A_12E2A5A1963A_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_12E2A5A1963A_impl*
end;//TkwPopFormNext.GetAllParamsCount

function TkwPopFormNext.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_12E2A5A1963A_var*
//#UC END# *5617F4D00243_12E2A5A1963A_var*
begin
//#UC START# *5617F4D00243_12E2A5A1963A_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_12E2A5A1963A_impl*
end;//TkwPopFormNext.ParamsTypes

procedure TkwPopFormSetWindowState.pop_form_SetWindowState(const aCtx: TtfwContext;
 aForm: TForm;
 aValue: TWindowState);
 {* Реализация слова скрипта pop:form:SetWindowState }
//#UC START# *84606C12BBFD_062C119864B2_var*
//#UC END# *84606C12BBFD_062C119864B2_var*
begin
//#UC START# *84606C12BBFD_062C119864B2_impl*
 aForm.WindowState := aValue;
//#UC END# *84606C12BBFD_062C119864B2_impl*
end;//TkwPopFormSetWindowState.pop_form_SetWindowState

procedure TkwPopFormSetWindowState.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_062C119864B2_var*
//#UC END# *4DAEEDE10285_062C119864B2_var*
begin
//#UC START# *4DAEEDE10285_062C119864B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_062C119864B2_impl*
end;//TkwPopFormSetWindowState.DoDoIt

class function TkwPopFormSetWindowState.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:SetWindowState';
end;//TkwPopFormSetWindowState.GetWordNameForRegister

function TkwPopFormSetWindowState.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_062C119864B2_var*
//#UC END# *551544E2001A_062C119864B2_var*
begin
//#UC START# *551544E2001A_062C119864B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_062C119864B2_impl*
end;//TkwPopFormSetWindowState.GetResultTypeInfo

function TkwPopFormSetWindowState.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_062C119864B2_var*
//#UC END# *559687E6025A_062C119864B2_var*
begin
//#UC START# *559687E6025A_062C119864B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_062C119864B2_impl*
end;//TkwPopFormSetWindowState.GetAllParamsCount

function TkwPopFormSetWindowState.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_062C119864B2_var*
//#UC END# *5617F4D00243_062C119864B2_var*
begin
//#UC START# *5617F4D00243_062C119864B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_062C119864B2_impl*
end;//TkwPopFormSetWindowState.ParamsTypes

function TkwPopFormFindActionList.pop_form_FindActionList(const aCtx: TtfwContext;
 aForm: TForm;
 const aListName: AnsiString): TActionList;
 {* Реализация слова скрипта pop:form:FindActionList }
//#UC START# *2D6AE1A8E910_76B7945239DF_var*
var
 l_Component : TComponent;
 i : Integer;
 l_Control : TControl;
//#UC END# *2D6AE1A8E910_76B7945239DF_var*
begin
//#UC START# *2D6AE1A8E910_76B7945239DF_impl*
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
//#UC END# *2D6AE1A8E910_76B7945239DF_impl*
end;//TkwPopFormFindActionList.pop_form_FindActionList

procedure TkwPopFormFindActionList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76B7945239DF_var*
//#UC END# *4DAEEDE10285_76B7945239DF_var*
begin
//#UC START# *4DAEEDE10285_76B7945239DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_76B7945239DF_impl*
end;//TkwPopFormFindActionList.DoDoIt

class function TkwPopFormFindActionList.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:form:FindActionList';
end;//TkwPopFormFindActionList.GetWordNameForRegister

function TkwPopFormFindActionList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_76B7945239DF_var*
//#UC END# *551544E2001A_76B7945239DF_var*
begin
//#UC START# *551544E2001A_76B7945239DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_76B7945239DF_impl*
end;//TkwPopFormFindActionList.GetResultTypeInfo

function TkwPopFormFindActionList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_76B7945239DF_var*
//#UC END# *559687E6025A_76B7945239DF_var*
begin
//#UC START# *559687E6025A_76B7945239DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_76B7945239DF_impl*
end;//TkwPopFormFindActionList.GetAllParamsCount

function TkwPopFormFindActionList.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_76B7945239DF_var*
//#UC END# *5617F4D00243_76B7945239DF_var*
begin
//#UC START# *5617F4D00243_76B7945239DF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_76B7945239DF_impl*
end;//TkwPopFormFindActionList.ParamsTypes

procedure TkwIterateForms.IterateForms(const aCtx: TtfwContext;
 aLambda: TtfwWord);
 {* Реализация слова скрипта IterateForms }
//#UC START# *B1D8BF8B68F8_DBFEA799BB20_var*
var
 l_Obj: TObject;
 I: Integer;
 l_FormsList: Tl3ObjectList;
//#UC END# *B1D8BF8B68F8_DBFEA799BB20_var*
begin
//#UC START# *B1D8BF8B68F8_DBFEA799BB20_impl*
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
//#UC END# *B1D8BF8B68F8_DBFEA799BB20_impl*
end;//TkwIterateForms.IterateForms

procedure TkwIterateForms.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DBFEA799BB20_var*
//#UC END# *4DAEEDE10285_DBFEA799BB20_var*
begin
//#UC START# *4DAEEDE10285_DBFEA799BB20_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DBFEA799BB20_impl*
end;//TkwIterateForms.DoDoIt

class function TkwIterateForms.GetWordNameForRegister: AnsiString;
begin
 Result := 'IterateForms';
end;//TkwIterateForms.GetWordNameForRegister

function TkwIterateForms.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DBFEA799BB20_var*
//#UC END# *551544E2001A_DBFEA799BB20_var*
begin
//#UC START# *551544E2001A_DBFEA799BB20_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DBFEA799BB20_impl*
end;//TkwIterateForms.GetResultTypeInfo

function TkwIterateForms.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_DBFEA799BB20_var*
//#UC END# *559687E6025A_DBFEA799BB20_var*
begin
//#UC START# *559687E6025A_DBFEA799BB20_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_DBFEA799BB20_impl*
end;//TkwIterateForms.GetAllParamsCount

function TkwIterateForms.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_DBFEA799BB20_var*
//#UC END# *5617F4D00243_DBFEA799BB20_var*
begin
//#UC START# *5617F4D00243_DBFEA799BB20_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_DBFEA799BB20_impl*
end;//TkwIterateForms.ParamsTypes

initialization
 TFormsProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TForm));
 {* Регистрация типа TForm }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
