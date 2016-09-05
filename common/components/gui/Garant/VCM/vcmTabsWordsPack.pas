unit vcmTabsWordsPack;

// Модуль: "w:\common\components\gui\Garant\VCM\vcmTabsWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vcmTabsWordsPack" MUID: (55AE40B600B7)

{$Include w:\common\components\gui\Garant\VCM\vcmDefine.inc}

interface

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

implementation

{$If NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , TypInfo
 , tfwScriptingInterfaces
 , l3TabbedContainersDispatcher
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *55AE40B600B7impl_uses*
 //#UC END# *55AE40B600B7impl_uses*
;

type
 TkwVcmTabsCloseCurrent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseCurrent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCloseCurrent

 TkwVcmTabsClose = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Close }
  private
   procedure vcm_tabs_Close(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Close }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsClose

 TkwVcmTabsCloseAllButCurrent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseAllButCurrent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCloseAllButCurrent

 TkwVcmTabsActive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Active }
  private
   function vcm_tabs_Active(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта vcm:tabs:Active }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsActive

 TkwVcmTabsSetActive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:SetActive }
  private
   procedure vcm_tabs_SetActive(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта vcm:tabs:SetActive }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsSetActive

 TkwVcmTabsCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Count }
  private
   function vcm_tabs_Count(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта vcm:tabs:Count }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCount

 TkwVcmTabsOpenNewTab = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:OpenNewTab }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsOpenNewTab

 TkwVcmTabsCanOpenNewTab = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanOpenNewTab }
  private
   function vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanOpenNewTab

 TkwVcmTabsDuplicate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Duplicate }
  private
   procedure vcm_tabs_Duplicate(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Duplicate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsDuplicate

 TkwVcmTabsCanDuplicate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanDuplicate }
  private
   function vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
    aTabIndex: Integer): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanDuplicate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanDuplicate

 TkwVcmTabsReopen = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Reopen }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsReopen

 TkwVcmTabsCanReopen = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanReopen }
  private
   function vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanReopen }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanReopen

 TkwVcmTabsGetIconIndex = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetIconIndex }
  private
   function vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
    aTabIndex: Integer): Integer;
    {* Реализация слова скрипта vcm:tabs:GetIconIndex }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsGetIconIndex

 TkwVcmTabsGetCaption = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetCaption }
  private
   function vcm_tabs_GetCaption(const aCtx: TtfwContext;
    aTabIndex: Integer): AnsiString;
    {* Реализация слова скрипта vcm:tabs:GetCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsGetCaption

 TkwVcmTabsCanUndock = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanUndock }
  private
   function vcm_tabs_CanUndock(const aCtx: TtfwContext;
    aTabIndex: Integer): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanUndock }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanUndock

 TkwVcmTabsUndock = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Undock }
  private
   procedure vcm_tabs_Undock(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Undock }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsUndock

class function TkwVcmTabsCloseCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CloseCurrent';
end;//TkwVcmTabsCloseCurrent.GetWordNameForRegister

function TkwVcmTabsCloseCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseCurrent.GetResultTypeInfo

function TkwVcmTabsCloseCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCloseCurrent.GetAllParamsCount

function TkwVcmTabsCloseCurrent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCloseCurrent.ParamsTypes

procedure TkwVcmTabsCloseCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55AE4C31002C_Word_var*
//#UC END# *4DAEEDE10285_55AE4C31002C_Word_var*
begin
//#UC START# *4DAEEDE10285_55AE4C31002C_Word_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseSelectedTab;
//#UC END# *4DAEEDE10285_55AE4C31002C_Word_impl*
end;//TkwVcmTabsCloseCurrent.DoDoIt

procedure TkwVcmTabsClose.vcm_tabs_Close(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Close }
//#UC START# *55AE4C470082_55AE4C470082_Word_var*
//#UC END# *55AE4C470082_55AE4C470082_Word_var*
begin
//#UC START# *55AE4C470082_55AE4C470082_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  CloseTab(Tabs[aTabIndex]);
//#UC END# *55AE4C470082_55AE4C470082_Word_impl*
end;//TkwVcmTabsClose.vcm_tabs_Close

class function TkwVcmTabsClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Close';
end;//TkwVcmTabsClose.GetWordNameForRegister

function TkwVcmTabsClose.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsClose.GetResultTypeInfo

function TkwVcmTabsClose.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsClose.GetAllParamsCount

function TkwVcmTabsClose.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsClose.ParamsTypes

procedure TkwVcmTabsClose.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_tabs_Close(aCtx, l_aTabIndex);
end;//TkwVcmTabsClose.DoDoIt

class function TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CloseAllButCurrent';
end;//TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister

function TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo

function TkwVcmTabsCloseAllButCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCloseAllButCurrent.GetAllParamsCount

function TkwVcmTabsCloseAllButCurrent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCloseAllButCurrent.ParamsTypes

procedure TkwVcmTabsCloseAllButCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55AE4C630229_Word_var*
//#UC END# *4DAEEDE10285_55AE4C630229_Word_var*
begin
//#UC START# *4DAEEDE10285_55AE4C630229_Word_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseAllButActiveTab;
//#UC END# *4DAEEDE10285_55AE4C630229_Word_impl*
end;//TkwVcmTabsCloseAllButCurrent.DoDoIt

function TkwVcmTabsActive.vcm_tabs_Active(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта vcm:tabs:Active }
//#UC START# *55AE78F700E1_55AE78F700E1_Word_var*
//#UC END# *55AE78F700E1_55AE78F700E1_Word_var*
begin
//#UC START# *55AE78F700E1_55AE78F700E1_Word_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.ActiveTab.VisibleIndex;
//#UC END# *55AE78F700E1_55AE78F700E1_Word_impl*
end;//TkwVcmTabsActive.vcm_tabs_Active

class function TkwVcmTabsActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Active';
end;//TkwVcmTabsActive.GetWordNameForRegister

function TkwVcmTabsActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsActive.GetResultTypeInfo

function TkwVcmTabsActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsActive.GetAllParamsCount

function TkwVcmTabsActive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsActive.ParamsTypes

procedure TkwVcmTabsActive.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(vcm_tabs_Active(aCtx));
end;//TkwVcmTabsActive.DoDoIt

procedure TkwVcmTabsSetActive.vcm_tabs_SetActive(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта vcm:tabs:SetActive }
//#UC START# *55AE790302E8_55AE790302E8_Word_var*
//#UC END# *55AE790302E8_55AE790302E8_Word_var*
begin
//#UC START# *55AE790302E8_55AE790302E8_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  ActiveTab := Tabs[aValue];
//#UC END# *55AE790302E8_55AE790302E8_Word_impl*
end;//TkwVcmTabsSetActive.vcm_tabs_SetActive

class function TkwVcmTabsSetActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:SetActive';
end;//TkwVcmTabsSetActive.GetWordNameForRegister

function TkwVcmTabsSetActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsSetActive.GetResultTypeInfo

function TkwVcmTabsSetActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsSetActive.GetAllParamsCount

function TkwVcmTabsSetActive.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsSetActive.ParamsTypes

procedure TkwVcmTabsSetActive.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Integer;
begin
 try
  l_aValue := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_tabs_SetActive(aCtx, l_aValue);
end;//TkwVcmTabsSetActive.DoDoIt

function TkwVcmTabsCount.vcm_tabs_Count(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта vcm:tabs:Count }
//#UC START# *55AE79190270_55AE79190270_Word_var*
//#UC END# *55AE79190270_55AE79190270_Word_var*
begin
//#UC START# *55AE79190270_55AE79190270_Word_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.TabCount;
//#UC END# *55AE79190270_55AE79190270_Word_impl*
end;//TkwVcmTabsCount.vcm_tabs_Count

class function TkwVcmTabsCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Count';
end;//TkwVcmTabsCount.GetWordNameForRegister

function TkwVcmTabsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsCount.GetResultTypeInfo

function TkwVcmTabsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCount.GetAllParamsCount

function TkwVcmTabsCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCount.ParamsTypes

procedure TkwVcmTabsCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(vcm_tabs_Count(aCtx));
end;//TkwVcmTabsCount.DoDoIt

class function TkwVcmTabsOpenNewTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:OpenNewTab';
end;//TkwVcmTabsOpenNewTab.GetWordNameForRegister

function TkwVcmTabsOpenNewTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsOpenNewTab.GetResultTypeInfo

function TkwVcmTabsOpenNewTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsOpenNewTab.GetAllParamsCount

function TkwVcmTabsOpenNewTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsOpenNewTab.ParamsTypes

procedure TkwVcmTabsOpenNewTab.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55AE7931034C_Word_var*
//#UC END# *4DAEEDE10285_55AE7931034C_Word_var*
begin
//#UC START# *4DAEEDE10285_55AE7931034C_Word_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.OpenNewTab;
//#UC END# *4DAEEDE10285_55AE7931034C_Word_impl*
end;//TkwVcmTabsOpenNewTab.DoDoIt

function TkwVcmTabsCanOpenNewTab.vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
//#UC START# *55AE794F0259_55AE794F0259_Word_var*
//#UC END# *55AE794F0259_55AE794F0259_Word_var*
begin
//#UC START# *55AE794F0259_55AE794F0259_Word_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CanOpenNewTab;
//#UC END# *55AE794F0259_55AE794F0259_Word_impl*
end;//TkwVcmTabsCanOpenNewTab.vcm_tabs_CanOpenNewTab

class function TkwVcmTabsCanOpenNewTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanOpenNewTab';
end;//TkwVcmTabsCanOpenNewTab.GetWordNameForRegister

function TkwVcmTabsCanOpenNewTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanOpenNewTab.GetResultTypeInfo

function TkwVcmTabsCanOpenNewTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCanOpenNewTab.GetAllParamsCount

function TkwVcmTabsCanOpenNewTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCanOpenNewTab.ParamsTypes

procedure TkwVcmTabsCanOpenNewTab.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(vcm_tabs_CanOpenNewTab(aCtx));
end;//TkwVcmTabsCanOpenNewTab.DoDoIt

procedure TkwVcmTabsDuplicate.vcm_tabs_Duplicate(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Duplicate }
//#UC START# *55DB1AF403B8_55DB1AF403B8_Word_var*
//#UC END# *55DB1AF403B8_55DB1AF403B8_Word_var*
begin
//#UC START# *55DB1AF403B8_55DB1AF403B8_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  CloneTab(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *55DB1AF403B8_55DB1AF403B8_Word_impl*
end;//TkwVcmTabsDuplicate.vcm_tabs_Duplicate

class function TkwVcmTabsDuplicate.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Duplicate';
end;//TkwVcmTabsDuplicate.GetWordNameForRegister

function TkwVcmTabsDuplicate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsDuplicate.GetResultTypeInfo

function TkwVcmTabsDuplicate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsDuplicate.GetAllParamsCount

function TkwVcmTabsDuplicate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsDuplicate.ParamsTypes

procedure TkwVcmTabsDuplicate.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_tabs_Duplicate(aCtx, l_aTabIndex);
end;//TkwVcmTabsDuplicate.DoDoIt

function TkwVcmTabsCanDuplicate.vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
 aTabIndex: Integer): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanDuplicate }
//#UC START# *55DB1BAC0203_55DB1BAC0203_Word_var*
//#UC END# *55DB1BAC0203_55DB1BAC0203_Word_var*
begin
//#UC START# *55DB1BAC0203_55DB1BAC0203_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanCloneTab(GetActiveTabbedContainer.Tabs[aTabIndex]);
//#UC END# *55DB1BAC0203_55DB1BAC0203_Word_impl*
end;//TkwVcmTabsCanDuplicate.vcm_tabs_CanDuplicate

class function TkwVcmTabsCanDuplicate.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanDuplicate';
end;//TkwVcmTabsCanDuplicate.GetWordNameForRegister

function TkwVcmTabsCanDuplicate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanDuplicate.GetResultTypeInfo

function TkwVcmTabsCanDuplicate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsCanDuplicate.GetAllParamsCount

function TkwVcmTabsCanDuplicate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsCanDuplicate.ParamsTypes

procedure TkwVcmTabsCanDuplicate.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(vcm_tabs_CanDuplicate(aCtx, l_aTabIndex));
end;//TkwVcmTabsCanDuplicate.DoDoIt

class function TkwVcmTabsReopen.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Reopen';
end;//TkwVcmTabsReopen.GetWordNameForRegister

function TkwVcmTabsReopen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsReopen.GetResultTypeInfo

function TkwVcmTabsReopen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsReopen.GetAllParamsCount

function TkwVcmTabsReopen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsReopen.ParamsTypes

procedure TkwVcmTabsReopen.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_55DB1B1500D4_Word_var*
//#UC END# *4DAEEDE10285_55DB1B1500D4_Word_var*
begin
//#UC START# *4DAEEDE10285_55DB1B1500D4_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  ReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *4DAEEDE10285_55DB1B1500D4_Word_impl*
end;//TkwVcmTabsReopen.DoDoIt

function TkwVcmTabsCanReopen.vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanReopen }
//#UC START# *55DB1B7A0137_55DB1B7A0137_Word_var*
//#UC END# *55DB1B7A0137_55DB1B7A0137_Word_var*
begin
//#UC START# *55DB1B7A0137_55DB1B7A0137_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *55DB1B7A0137_55DB1B7A0137_Word_impl*
end;//TkwVcmTabsCanReopen.vcm_tabs_CanReopen

class function TkwVcmTabsCanReopen.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanReopen';
end;//TkwVcmTabsCanReopen.GetWordNameForRegister

function TkwVcmTabsCanReopen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanReopen.GetResultTypeInfo

function TkwVcmTabsCanReopen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCanReopen.GetAllParamsCount

function TkwVcmTabsCanReopen.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCanReopen.ParamsTypes

procedure TkwVcmTabsCanReopen.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(vcm_tabs_CanReopen(aCtx));
end;//TkwVcmTabsCanReopen.DoDoIt

function TkwVcmTabsGetIconIndex.vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
 aTabIndex: Integer): Integer;
 {* Реализация слова скрипта vcm:tabs:GetIconIndex }
//#UC START# *560168780139_560168780139_Word_var*
//#UC END# *560168780139_560168780139_Word_var*
begin
//#UC START# *560168780139_560168780139_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := GetTabIcon(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *560168780139_560168780139_Word_impl*
end;//TkwVcmTabsGetIconIndex.vcm_tabs_GetIconIndex

class function TkwVcmTabsGetIconIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:GetIconIndex';
end;//TkwVcmTabsGetIconIndex.GetWordNameForRegister

function TkwVcmTabsGetIconIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsGetIconIndex.GetResultTypeInfo

function TkwVcmTabsGetIconIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsGetIconIndex.GetAllParamsCount

function TkwVcmTabsGetIconIndex.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsGetIconIndex.ParamsTypes

procedure TkwVcmTabsGetIconIndex.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(vcm_tabs_GetIconIndex(aCtx, l_aTabIndex));
end;//TkwVcmTabsGetIconIndex.DoDoIt

function TkwVcmTabsGetCaption.vcm_tabs_GetCaption(const aCtx: TtfwContext;
 aTabIndex: Integer): AnsiString;
 {* Реализация слова скрипта vcm:tabs:GetCaption }
//#UC START# *56727DFE03B2_56727DFE03B2_Word_var*
//#UC END# *56727DFE03B2_56727DFE03B2_Word_var*
begin
//#UC START# *56727DFE03B2_56727DFE03B2_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := GetTabCaption(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *56727DFE03B2_56727DFE03B2_Word_impl*
end;//TkwVcmTabsGetCaption.vcm_tabs_GetCaption

class function TkwVcmTabsGetCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:GetCaption';
end;//TkwVcmTabsGetCaption.GetWordNameForRegister

function TkwVcmTabsGetCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwVcmTabsGetCaption.GetResultTypeInfo

function TkwVcmTabsGetCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsGetCaption.GetAllParamsCount

function TkwVcmTabsGetCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsGetCaption.ParamsTypes

procedure TkwVcmTabsGetCaption.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(vcm_tabs_GetCaption(aCtx, l_aTabIndex));
end;//TkwVcmTabsGetCaption.DoDoIt

function TkwVcmTabsCanUndock.vcm_tabs_CanUndock(const aCtx: TtfwContext;
 aTabIndex: Integer): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanUndock }
//#UC START# *5698FB1801C8_5698FB1801C8_Word_var*
//#UC END# *5698FB1801C8_5698FB1801C8_Word_var*
begin
//#UC START# *5698FB1801C8_5698FB1801C8_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  Result := CanUndockFormFromTab(aTabIndex);
//#UC END# *5698FB1801C8_5698FB1801C8_Word_impl*
end;//TkwVcmTabsCanUndock.vcm_tabs_CanUndock

class function TkwVcmTabsCanUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanUndock';
end;//TkwVcmTabsCanUndock.GetWordNameForRegister

function TkwVcmTabsCanUndock.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanUndock.GetResultTypeInfo

function TkwVcmTabsCanUndock.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsCanUndock.GetAllParamsCount

function TkwVcmTabsCanUndock.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsCanUndock.ParamsTypes

procedure TkwVcmTabsCanUndock.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(vcm_tabs_CanUndock(aCtx, l_aTabIndex));
end;//TkwVcmTabsCanUndock.DoDoIt

procedure TkwVcmTabsUndock.vcm_tabs_Undock(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Undock }
//#UC START# *5698FB610250_5698FB610250_Word_var*
//#UC END# *5698FB610250_5698FB610250_Word_var*
begin
//#UC START# *5698FB610250_5698FB610250_Word_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  UndockFormFromTab(aTabIndex);
//#UC END# *5698FB610250_5698FB610250_Word_impl*
end;//TkwVcmTabsUndock.vcm_tabs_Undock

class function TkwVcmTabsUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Undock';
end;//TkwVcmTabsUndock.GetWordNameForRegister

function TkwVcmTabsUndock.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsUndock.GetResultTypeInfo

function TkwVcmTabsUndock.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwVcmTabsUndock.GetAllParamsCount

function TkwVcmTabsUndock.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsUndock.ParamsTypes

procedure TkwVcmTabsUndock.DoDoIt(const aCtx: TtfwContext);
var l_aTabIndex: Integer;
begin
 try
  l_aTabIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aTabIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 vcm_tabs_Undock(aCtx, l_aTabIndex);
end;//TkwVcmTabsUndock.DoDoIt

initialization
 TkwVcmTabsCloseCurrent.RegisterInEngine;
 {* Регистрация vcm_tabs_CloseCurrent }
 TkwVcmTabsClose.RegisterInEngine;
 {* Регистрация vcm_tabs_Close }
 TkwVcmTabsCloseAllButCurrent.RegisterInEngine;
 {* Регистрация vcm_tabs_CloseAllButCurrent }
 TkwVcmTabsActive.RegisterInEngine;
 {* Регистрация vcm_tabs_Active }
 TkwVcmTabsSetActive.RegisterInEngine;
 {* Регистрация vcm_tabs_SetActive }
 TkwVcmTabsCount.RegisterInEngine;
 {* Регистрация vcm_tabs_Count }
 TkwVcmTabsOpenNewTab.RegisterInEngine;
 {* Регистрация vcm_tabs_OpenNewTab }
 TkwVcmTabsCanOpenNewTab.RegisterInEngine;
 {* Регистрация vcm_tabs_CanOpenNewTab }
 TkwVcmTabsDuplicate.RegisterInEngine;
 {* Регистрация vcm_tabs_Duplicate }
 TkwVcmTabsCanDuplicate.RegisterInEngine;
 {* Регистрация vcm_tabs_CanDuplicate }
 TkwVcmTabsReopen.RegisterInEngine;
 {* Регистрация vcm_tabs_Reopen }
 TkwVcmTabsCanReopen.RegisterInEngine;
 {* Регистрация vcm_tabs_CanReopen }
 TkwVcmTabsGetIconIndex.RegisterInEngine;
 {* Регистрация vcm_tabs_GetIconIndex }
 TkwVcmTabsGetCaption.RegisterInEngine;
 {* Регистрация vcm_tabs_GetCaption }
 TkwVcmTabsCanUndock.RegisterInEngine;
 {* Регистрация vcm_tabs_CanUndock }
 TkwVcmTabsUndock.RegisterInEngine;
 {* Регистрация vcm_tabs_Undock }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

end.
