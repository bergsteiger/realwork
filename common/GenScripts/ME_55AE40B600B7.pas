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
 , tfwScriptingInterfaces
 , TypInfo
 , l3TabbedContainersDispatcher
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwVcmTabsCloseCurrent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseCurrent
[panel]Закрыть текущую вкладку в активном окне. Не закрывает последнюю.[panel]
*Пример:*
[code]
 vcm:tabs:CloseCurrent
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwVcmTabsCloseCurrent

 TkwVcmTabsClose = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Close
[panel]Закрыть вкладку по индексу. Нумерация с нуля.[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Close
[code]  }
  private
   procedure vcm_tabs_Close(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Close }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsClose

 TkwVcmTabsCloseAllButCurrent = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseAllButCurrent
[panel]Закрыть все вкладки кроме текущей в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:CloseAllButCurrent
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwVcmTabsCloseAllButCurrent

 TkwVcmTabsActive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Active
[panel]Номер активной вкладки в текущем окне. Нумерация с нуля.[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Active >>> l_Integer
[code]  }
  private
   function vcm_tabs_Active(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта vcm:tabs:Active }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsActive

 TkwVcmTabsSetActive = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:SetActive
[panel]Перейти на вкладку в активном окне (нумерация с нуля)[panel]
*Пример:*
[code]
 aValue vcm:tabs:SetActive
[code]  }
  private
   procedure vcm_tabs_SetActive(const aCtx: TtfwContext;
    aValue: Integer);
    {* Реализация слова скрипта vcm:tabs:SetActive }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsSetActive

 TkwVcmTabsCount = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Count
[panel]Количество вкладок в активном окне[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Count >>> l_Integer
[code]  }
  private
   function vcm_tabs_Count(const aCtx: TtfwContext): Integer;
    {* Реализация слова скрипта vcm:tabs:Count }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCount

 TkwVcmTabsOpenNewTab = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:OpenNewTab
[panel]Открыть новую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:OpenNewTab
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwVcmTabsOpenNewTab

 TkwVcmTabsCanOpenNewTab = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanOpenNewTab
[panel]Можно ли открыть новую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanOpenNewTab >>> l_Boolean
[code]  }
  private
   function vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanOpenNewTab

 TkwVcmTabsDuplicate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Duplicate
[panel]Дублировать вкладку в активном окне[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Duplicate
[code]  }
  private
   procedure vcm_tabs_Duplicate(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Duplicate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsDuplicate

 TkwVcmTabsCanDuplicate = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanDuplicate
[panel]Можно ли дублировать вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTabIndex vcm:tabs:CanDuplicate >>> l_Boolean
[code]  }
  private
   function vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
    aTabIndex: Integer): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanDuplicate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanDuplicate

 TkwVcmTabsReopen = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Reopen
[panel]Открыть закрытую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:Reopen
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwVcmTabsReopen

 TkwVcmTabsCanReopen = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanReopen
[panel]Можно ли открыть закрытую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanReopen >>> l_Boolean
[code]  }
  private
   function vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanReopen }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanReopen

 TkwVcmTabsGetIconIndex = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetIconIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTabIndex vcm:tabs:GetIconIndex >>> l_Integer
[code]  }
  private
   function vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
    aTabIndex: Integer): Integer;
    {* Реализация слова скрипта vcm:tabs:GetIconIndex }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsGetIconIndex

 TkwVcmTabsGetCaption = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aTabIndex vcm:tabs:GetCaption >>> l_String
[code]  }
  private
   function vcm_tabs_GetCaption(const aCtx: TtfwContext;
    aTabIndex: Integer): AnsiString;
    {* Реализация слова скрипта vcm:tabs:GetCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsGetCaption

 TkwVcmTabsCanUndock = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanUndock
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTabIndex vcm:tabs:CanUndock >>> l_Boolean
[code]  }
  private
   function vcm_tabs_CanUndock(const aCtx: TtfwContext;
    aTabIndex: Integer): Boolean;
    {* Реализация слова скрипта vcm:tabs:CanUndock }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsCanUndock

 TkwVcmTabsUndock = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Undock
*Пример:*
[code]
 aTabIndex vcm:tabs:Undock
[code]  }
  private
   procedure vcm_tabs_Undock(const aCtx: TtfwContext;
    aTabIndex: Integer);
    {* Реализация слова скрипта vcm:tabs:Undock }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwVcmTabsUndock

procedure TkwVcmTabsCloseCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_137FD631C8A7_var*
//#UC END# *4DAEEDE10285_137FD631C8A7_var*
begin
//#UC START# *4DAEEDE10285_137FD631C8A7_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseSelectedTab;
//#UC END# *4DAEEDE10285_137FD631C8A7_impl*
end;//TkwVcmTabsCloseCurrent.DoDoIt

function TkwVcmTabsCloseCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseCurrent.GetResultTypeInfo

function TkwVcmTabsCloseCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCloseCurrent.GetAllParamsCount

class function TkwVcmTabsCloseCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CloseCurrent';
end;//TkwVcmTabsCloseCurrent.GetWordNameForRegister

procedure TkwVcmTabsClose.vcm_tabs_Close(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Close }
//#UC START# *6AA735B1AFE9_12F6A6736B71_var*
//#UC END# *6AA735B1AFE9_12F6A6736B71_var*
begin
//#UC START# *6AA735B1AFE9_12F6A6736B71_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  CloseTab(Tabs[aTabIndex]);
//#UC END# *6AA735B1AFE9_12F6A6736B71_impl*
end;//TkwVcmTabsClose.vcm_tabs_Close

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

class function TkwVcmTabsClose.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Close';
end;//TkwVcmTabsClose.GetWordNameForRegister

procedure TkwVcmTabsCloseAllButCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_91294BF70EF7_var*
//#UC END# *4DAEEDE10285_91294BF70EF7_var*
begin
//#UC START# *4DAEEDE10285_91294BF70EF7_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseAllButActiveTab;
//#UC END# *4DAEEDE10285_91294BF70EF7_impl*
end;//TkwVcmTabsCloseAllButCurrent.DoDoIt

function TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo

function TkwVcmTabsCloseAllButCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsCloseAllButCurrent.GetAllParamsCount

class function TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CloseAllButCurrent';
end;//TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister

function TkwVcmTabsActive.vcm_tabs_Active(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта vcm:tabs:Active }
//#UC START# *BFE28234E0FC_EA6F3BD4A5CA_var*
//#UC END# *BFE28234E0FC_EA6F3BD4A5CA_var*
begin
//#UC START# *BFE28234E0FC_EA6F3BD4A5CA_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.ActiveTab.VisibleIndex;
//#UC END# *BFE28234E0FC_EA6F3BD4A5CA_impl*
end;//TkwVcmTabsActive.vcm_tabs_Active

procedure TkwVcmTabsActive.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(vcm_tabs_Active(aCtx));
end;//TkwVcmTabsActive.DoDoIt

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

class function TkwVcmTabsActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Active';
end;//TkwVcmTabsActive.GetWordNameForRegister

procedure TkwVcmTabsSetActive.vcm_tabs_SetActive(const aCtx: TtfwContext;
 aValue: Integer);
 {* Реализация слова скрипта vcm:tabs:SetActive }
//#UC START# *4D8DA9C0F345_36E868893B0A_var*
//#UC END# *4D8DA9C0F345_36E868893B0A_var*
begin
//#UC START# *4D8DA9C0F345_36E868893B0A_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  ActiveTab := Tabs[aValue];
//#UC END# *4D8DA9C0F345_36E868893B0A_impl*
end;//TkwVcmTabsSetActive.vcm_tabs_SetActive

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

class function TkwVcmTabsSetActive.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:SetActive';
end;//TkwVcmTabsSetActive.GetWordNameForRegister

function TkwVcmTabsCount.vcm_tabs_Count(const aCtx: TtfwContext): Integer;
 {* Реализация слова скрипта vcm:tabs:Count }
//#UC START# *D3D18ECCBD33_D1C0BD993D2F_var*
//#UC END# *D3D18ECCBD33_D1C0BD993D2F_var*
begin
//#UC START# *D3D18ECCBD33_D1C0BD993D2F_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.TabCount;
//#UC END# *D3D18ECCBD33_D1C0BD993D2F_impl*
end;//TkwVcmTabsCount.vcm_tabs_Count

procedure TkwVcmTabsCount.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushInt(vcm_tabs_Count(aCtx));
end;//TkwVcmTabsCount.DoDoIt

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

class function TkwVcmTabsCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Count';
end;//TkwVcmTabsCount.GetWordNameForRegister

procedure TkwVcmTabsOpenNewTab.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76B187B4575B_var*
//#UC END# *4DAEEDE10285_76B187B4575B_var*
begin
//#UC START# *4DAEEDE10285_76B187B4575B_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.OpenNewTab;
//#UC END# *4DAEEDE10285_76B187B4575B_impl*
end;//TkwVcmTabsOpenNewTab.DoDoIt

function TkwVcmTabsOpenNewTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsOpenNewTab.GetResultTypeInfo

function TkwVcmTabsOpenNewTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsOpenNewTab.GetAllParamsCount

class function TkwVcmTabsOpenNewTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:OpenNewTab';
end;//TkwVcmTabsOpenNewTab.GetWordNameForRegister

function TkwVcmTabsCanOpenNewTab.vcm_tabs_CanOpenNewTab(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
//#UC START# *18CE39730151_D42D3E4F7AC2_var*
//#UC END# *18CE39730151_D42D3E4F7AC2_var*
begin
//#UC START# *18CE39730151_D42D3E4F7AC2_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CanOpenNewTab;
//#UC END# *18CE39730151_D42D3E4F7AC2_impl*
end;//TkwVcmTabsCanOpenNewTab.vcm_tabs_CanOpenNewTab

procedure TkwVcmTabsCanOpenNewTab.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(vcm_tabs_CanOpenNewTab(aCtx));
end;//TkwVcmTabsCanOpenNewTab.DoDoIt

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

class function TkwVcmTabsCanOpenNewTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanOpenNewTab';
end;//TkwVcmTabsCanOpenNewTab.GetWordNameForRegister

procedure TkwVcmTabsDuplicate.vcm_tabs_Duplicate(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Duplicate }
//#UC START# *A4A5C2458E8A_25BDB3DFEC33_var*
//#UC END# *A4A5C2458E8A_25BDB3DFEC33_var*
begin
//#UC START# *A4A5C2458E8A_25BDB3DFEC33_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  CloneTab(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *A4A5C2458E8A_25BDB3DFEC33_impl*
end;//TkwVcmTabsDuplicate.vcm_tabs_Duplicate

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

class function TkwVcmTabsDuplicate.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Duplicate';
end;//TkwVcmTabsDuplicate.GetWordNameForRegister

function TkwVcmTabsCanDuplicate.vcm_tabs_CanDuplicate(const aCtx: TtfwContext;
 aTabIndex: Integer): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanDuplicate }
//#UC START# *56B44CB5CD89_43C0563688C9_var*
//#UC END# *56B44CB5CD89_43C0563688C9_var*
begin
//#UC START# *56B44CB5CD89_43C0563688C9_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanCloneTab(GetActiveTabbedContainer.Tabs[aTabIndex]);
//#UC END# *56B44CB5CD89_43C0563688C9_impl*
end;//TkwVcmTabsCanDuplicate.vcm_tabs_CanDuplicate

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

class function TkwVcmTabsCanDuplicate.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanDuplicate';
end;//TkwVcmTabsCanDuplicate.GetWordNameForRegister

procedure TkwVcmTabsReopen.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C449AC698640_var*
//#UC END# *4DAEEDE10285_C449AC698640_var*
begin
//#UC START# *4DAEEDE10285_C449AC698640_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  ReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *4DAEEDE10285_C449AC698640_impl*
end;//TkwVcmTabsReopen.DoDoIt

function TkwVcmTabsReopen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsReopen.GetResultTypeInfo

function TkwVcmTabsReopen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwVcmTabsReopen.GetAllParamsCount

class function TkwVcmTabsReopen.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Reopen';
end;//TkwVcmTabsReopen.GetWordNameForRegister

function TkwVcmTabsCanReopen.vcm_tabs_CanReopen(const aCtx: TtfwContext): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanReopen }
//#UC START# *6BFDCF32FEC5_B8D479345CBE_var*
//#UC END# *6BFDCF32FEC5_B8D479345CBE_var*
begin
//#UC START# *6BFDCF32FEC5_B8D479345CBE_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *6BFDCF32FEC5_B8D479345CBE_impl*
end;//TkwVcmTabsCanReopen.vcm_tabs_CanReopen

procedure TkwVcmTabsCanReopen.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushBool(vcm_tabs_CanReopen(aCtx));
end;//TkwVcmTabsCanReopen.DoDoIt

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

class function TkwVcmTabsCanReopen.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanReopen';
end;//TkwVcmTabsCanReopen.GetWordNameForRegister

function TkwVcmTabsGetIconIndex.vcm_tabs_GetIconIndex(const aCtx: TtfwContext;
 aTabIndex: Integer): Integer;
 {* Реализация слова скрипта vcm:tabs:GetIconIndex }
//#UC START# *5F70A124CAC6_1F0AD0312C05_var*
//#UC END# *5F70A124CAC6_1F0AD0312C05_var*
begin
//#UC START# *5F70A124CAC6_1F0AD0312C05_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := GetTabIcon(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *5F70A124CAC6_1F0AD0312C05_impl*
end;//TkwVcmTabsGetIconIndex.vcm_tabs_GetIconIndex

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

class function TkwVcmTabsGetIconIndex.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:GetIconIndex';
end;//TkwVcmTabsGetIconIndex.GetWordNameForRegister

function TkwVcmTabsGetCaption.vcm_tabs_GetCaption(const aCtx: TtfwContext;
 aTabIndex: Integer): AnsiString;
 {* Реализация слова скрипта vcm:tabs:GetCaption }
//#UC START# *8DA64904FF22_27CA2643776F_var*
//#UC END# *8DA64904FF22_27CA2643776F_var*
begin
//#UC START# *8DA64904FF22_27CA2643776F_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := GetTabCaption(GetActiveTabbedContainer.TabByVisibleIndex[aTabIndex]);
//#UC END# *8DA64904FF22_27CA2643776F_impl*
end;//TkwVcmTabsGetCaption.vcm_tabs_GetCaption

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

class function TkwVcmTabsGetCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:GetCaption';
end;//TkwVcmTabsGetCaption.GetWordNameForRegister

function TkwVcmTabsCanUndock.vcm_tabs_CanUndock(const aCtx: TtfwContext;
 aTabIndex: Integer): Boolean;
 {* Реализация слова скрипта vcm:tabs:CanUndock }
//#UC START# *4B3F5E37FD4C_C1A0F850A859_var*
//#UC END# *4B3F5E37FD4C_C1A0F850A859_var*
begin
//#UC START# *4B3F5E37FD4C_C1A0F850A859_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  Result := CanUndockFormFromTab(aTabIndex);
//#UC END# *4B3F5E37FD4C_C1A0F850A859_impl*
end;//TkwVcmTabsCanUndock.vcm_tabs_CanUndock

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

class function TkwVcmTabsCanUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:CanUndock';
end;//TkwVcmTabsCanUndock.GetWordNameForRegister

procedure TkwVcmTabsUndock.vcm_tabs_Undock(const aCtx: TtfwContext;
 aTabIndex: Integer);
 {* Реализация слова скрипта vcm:tabs:Undock }
//#UC START# *38AB4FF25C84_DB5208478590_var*
//#UC END# *38AB4FF25C84_DB5208478590_var*
begin
//#UC START# *38AB4FF25C84_DB5208478590_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  UndockFormFromTab(aTabIndex);
//#UC END# *38AB4FF25C84_DB5208478590_impl*
end;//TkwVcmTabsUndock.vcm_tabs_Undock

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

class function TkwVcmTabsUndock.GetWordNameForRegister: AnsiString;
begin
 Result := 'vcm:tabs:Undock';
end;//TkwVcmTabsUndock.GetWordNameForRegister

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoVCM) AND NOT Defined(NoScripts) AND NOT Defined(NoTabs)

end.
