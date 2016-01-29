unit vcmTabsWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "VCM$Visual"
// Модуль: "w:/common/components/gui/Garant/VCM/vcmTabsWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi::VCM$Visual::TabsWords::vcmTabsWordsPack
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\VCM\vcmDefine.inc}

interface

{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
uses
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

implementation

{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
uses
  l3TabbedContainersDispatcher,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwVcmTabsCloseCurrent = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseCurrent
[panel]Закрыть текущую вкладку в активном окне. Не закрывает последнюю.[panel]
*Пример:*
[code]
 vcm:tabs:CloseCurrent
[code]  }
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
 end;//TkwVcmTabsCloseCurrent

// start class TkwVcmTabsCloseCurrent

procedure TkwVcmTabsCloseCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_137FD631C8A7_var*
//#UC END# *4DAEEDE10285_137FD631C8A7_var*
begin
//#UC START# *4DAEEDE10285_137FD631C8A7_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseSelectedTab;
//#UC END# *4DAEEDE10285_137FD631C8A7_impl*
end;//TkwVcmTabsCloseCurrent.DoDoIt

class function TkwVcmTabsCloseCurrent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:CloseCurrent';
end;//TkwVcmTabsCloseCurrent.GetWordNameForRegister

function TkwVcmTabsCloseCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseCurrent.GetResultTypeInfo

function TkwVcmTabsCloseCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsCloseCurrent.GetAllParamsCount

type
 TkwVcmTabsClose = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Close
[panel]Закрыть вкладку по индексу. Нумерация с нуля.[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Close
[code]  }
 private
 // private methods
   procedure VcmTabsClose(const aCtx: TtfwContext;
    aTabIndex: Integer);
     {* Реализация слова скрипта vcm:tabs:Close }
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
 end;//TkwVcmTabsClose

// start class TkwVcmTabsClose

procedure TkwVcmTabsClose.VcmTabsClose(const aCtx: TtfwContext;
  aTabIndex: Integer);
//#UC START# *6AA735B1AFE9_12F6A6736B71_var*
//#UC END# *6AA735B1AFE9_12F6A6736B71_var*
begin
//#UC START# *6AA735B1AFE9_12F6A6736B71_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  CloseTab(Tabs[aTabIndex]);
//#UC END# *6AA735B1AFE9_12F6A6736B71_impl*
end;//TkwVcmTabsClose.VcmTabsClose

procedure TkwVcmTabsClose.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTabIndex : Integer;
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
 VcmTabsClose(aCtx, l_aTabIndex);
end;//TkwVcmTabsClose.DoDoIt

class function TkwVcmTabsClose.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:Close';
end;//TkwVcmTabsClose.GetWordNameForRegister

function TkwVcmTabsClose.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsClose.GetResultTypeInfo

function TkwVcmTabsClose.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmTabsClose.GetAllParamsCount

function TkwVcmTabsClose.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsClose.ParamsTypes

type
 TkwVcmTabsCloseAllButCurrent = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CloseAllButCurrent
[panel]Закрыть все вкладки кроме текущей в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:CloseAllButCurrent
[code]  }
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
 end;//TkwVcmTabsCloseAllButCurrent

// start class TkwVcmTabsCloseAllButCurrent

procedure TkwVcmTabsCloseAllButCurrent.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_91294BF70EF7_var*
//#UC END# *4DAEEDE10285_91294BF70EF7_var*
begin
//#UC START# *4DAEEDE10285_91294BF70EF7_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CloseAllButActiveTab;
//#UC END# *4DAEEDE10285_91294BF70EF7_impl*
end;//TkwVcmTabsCloseAllButCurrent.DoDoIt

class function TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:CloseAllButCurrent';
end;//TkwVcmTabsCloseAllButCurrent.GetWordNameForRegister

function TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsCloseAllButCurrent.GetResultTypeInfo

function TkwVcmTabsCloseAllButCurrent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsCloseAllButCurrent.GetAllParamsCount

type
 TkwVcmTabsActive = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Active
[panel]Номер активной вкладки в текущем окне. Нумерация с нуля.[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Active >>> l_Integer
[code]  }
 private
 // private methods
   function VcmTabsActive(const aCtx: TtfwContext): Integer;
     {* Реализация слова скрипта vcm:tabs:Active }
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
 end;//TkwVcmTabsActive

// start class TkwVcmTabsActive

function TkwVcmTabsActive.VcmTabsActive(const aCtx: TtfwContext): Integer;
//#UC START# *BFE28234E0FC_EA6F3BD4A5CA_var*
//#UC END# *BFE28234E0FC_EA6F3BD4A5CA_var*
begin
//#UC START# *BFE28234E0FC_EA6F3BD4A5CA_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.ActiveTab.VisibleIndex;
//#UC END# *BFE28234E0FC_EA6F3BD4A5CA_impl*
end;//TkwVcmTabsActive.VcmTabsActive

procedure TkwVcmTabsActive.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((VcmTabsActive(aCtx)));
end;//TkwVcmTabsActive.DoDoIt

class function TkwVcmTabsActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:Active';
end;//TkwVcmTabsActive.GetWordNameForRegister

function TkwVcmTabsActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsActive.GetResultTypeInfo

function TkwVcmTabsActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsActive.GetAllParamsCount

function TkwVcmTabsActive.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsActive.ParamsTypes

type
 TkwVcmTabsSetActive = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:SetActive
[panel]Перейти на вкладку в активном окне (нумерация с нуля)[panel]
*Пример:*
[code]
 aValue vcm:tabs:SetActive
[code]  }
 private
 // private methods
   procedure VcmTabsSetActive(const aCtx: TtfwContext;
    aValue: Integer);
     {* Реализация слова скрипта vcm:tabs:SetActive }
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
 end;//TkwVcmTabsSetActive

// start class TkwVcmTabsSetActive

procedure TkwVcmTabsSetActive.VcmTabsSetActive(const aCtx: TtfwContext;
  aValue: Integer);
//#UC START# *4D8DA9C0F345_36E868893B0A_var*
//#UC END# *4D8DA9C0F345_36E868893B0A_var*
begin
//#UC START# *4D8DA9C0F345_36E868893B0A_impl*
 with Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer do
  ActiveTab := Tabs[aValue];
//#UC END# *4D8DA9C0F345_36E868893B0A_impl*
end;//TkwVcmTabsSetActive.VcmTabsSetActive

procedure TkwVcmTabsSetActive.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Integer;
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
 VcmTabsSetActive(aCtx, l_aValue);
end;//TkwVcmTabsSetActive.DoDoIt

class function TkwVcmTabsSetActive.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:SetActive';
end;//TkwVcmTabsSetActive.GetWordNameForRegister

function TkwVcmTabsSetActive.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsSetActive.GetResultTypeInfo

function TkwVcmTabsSetActive.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmTabsSetActive.GetAllParamsCount

function TkwVcmTabsSetActive.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsSetActive.ParamsTypes

type
 TkwVcmTabsCount = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Count
[panel]Количество вкладок в активном окне[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 vcm:tabs:Count >>> l_Integer
[code]  }
 private
 // private methods
   function VcmTabsCount(const aCtx: TtfwContext): Integer;
     {* Реализация слова скрипта vcm:tabs:Count }
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
 end;//TkwVcmTabsCount

// start class TkwVcmTabsCount

function TkwVcmTabsCount.VcmTabsCount(const aCtx: TtfwContext): Integer;
//#UC START# *D3D18ECCBD33_D1C0BD993D2F_var*
//#UC END# *D3D18ECCBD33_D1C0BD993D2F_var*
begin
//#UC START# *D3D18ECCBD33_D1C0BD993D2F_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.TabCount;
//#UC END# *D3D18ECCBD33_D1C0BD993D2F_impl*
end;//TkwVcmTabsCount.VcmTabsCount

procedure TkwVcmTabsCount.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushInt((VcmTabsCount(aCtx)));
end;//TkwVcmTabsCount.DoDoIt

class function TkwVcmTabsCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:Count';
end;//TkwVcmTabsCount.GetWordNameForRegister

function TkwVcmTabsCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsCount.GetResultTypeInfo

function TkwVcmTabsCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsCount.GetAllParamsCount

function TkwVcmTabsCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCount.ParamsTypes

type
 TkwVcmTabsOpenNewTab = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:OpenNewTab
[panel]Открыть новую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:OpenNewTab
[code]  }
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
 end;//TkwVcmTabsOpenNewTab

// start class TkwVcmTabsOpenNewTab

procedure TkwVcmTabsOpenNewTab.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_76B187B4575B_var*
//#UC END# *4DAEEDE10285_76B187B4575B_var*
begin
//#UC START# *4DAEEDE10285_76B187B4575B_impl*
 Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.OpenNewTab;
//#UC END# *4DAEEDE10285_76B187B4575B_impl*
end;//TkwVcmTabsOpenNewTab.DoDoIt

class function TkwVcmTabsOpenNewTab.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:OpenNewTab';
end;//TkwVcmTabsOpenNewTab.GetWordNameForRegister

function TkwVcmTabsOpenNewTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsOpenNewTab.GetResultTypeInfo

function TkwVcmTabsOpenNewTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsOpenNewTab.GetAllParamsCount

type
 TkwVcmTabsCanOpenNewTab = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanOpenNewTab
[panel]Можно ли открыть новую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanOpenNewTab >>> l_Boolean
[code]  }
 private
 // private methods
   function VcmTabsCanOpenNewTab(const aCtx: TtfwContext): Boolean;
     {* Реализация слова скрипта vcm:tabs:CanOpenNewTab }
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
 end;//TkwVcmTabsCanOpenNewTab

// start class TkwVcmTabsCanOpenNewTab

function TkwVcmTabsCanOpenNewTab.VcmTabsCanOpenNewTab(const aCtx: TtfwContext): Boolean;
//#UC START# *18CE39730151_D42D3E4F7AC2_var*
//#UC END# *18CE39730151_D42D3E4F7AC2_var*
begin
//#UC START# *18CE39730151_D42D3E4F7AC2_impl*
 Result := Tl3TabbedContainersDispatcher.Instance.GetActiveTabbedContainer.CanOpenNewTab;
//#UC END# *18CE39730151_D42D3E4F7AC2_impl*
end;//TkwVcmTabsCanOpenNewTab.VcmTabsCanOpenNewTab

procedure TkwVcmTabsCanOpenNewTab.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((VcmTabsCanOpenNewTab(aCtx)));
end;//TkwVcmTabsCanOpenNewTab.DoDoIt

class function TkwVcmTabsCanOpenNewTab.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:CanOpenNewTab';
end;//TkwVcmTabsCanOpenNewTab.GetWordNameForRegister

function TkwVcmTabsCanOpenNewTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanOpenNewTab.GetResultTypeInfo

function TkwVcmTabsCanOpenNewTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsCanOpenNewTab.GetAllParamsCount

function TkwVcmTabsCanOpenNewTab.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCanOpenNewTab.ParamsTypes

type
 TkwVcmTabsDuplicate = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Duplicate
[panel]Дублировать вкладку в активном окне[panel]
*Пример:*
[code]
 aTabIndex vcm:tabs:Duplicate
[code]  }
 private
 // private methods
   procedure VcmTabsDuplicate(const aCtx: TtfwContext;
    aTabIndex: Integer);
     {* Реализация слова скрипта vcm:tabs:Duplicate }
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
 end;//TkwVcmTabsDuplicate

// start class TkwVcmTabsDuplicate

procedure TkwVcmTabsDuplicate.VcmTabsDuplicate(const aCtx: TtfwContext;
  aTabIndex: Integer);
//#UC START# *A4A5C2458E8A_25BDB3DFEC33_var*
//#UC END# *A4A5C2458E8A_25BDB3DFEC33_var*
begin
//#UC START# *A4A5C2458E8A_25BDB3DFEC33_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  CloneTab(GetActiveTabbedContainer.Tabs[aTabIndex]);
//#UC END# *A4A5C2458E8A_25BDB3DFEC33_impl*
end;//TkwVcmTabsDuplicate.VcmTabsDuplicate

procedure TkwVcmTabsDuplicate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTabIndex : Integer;
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
 VcmTabsDuplicate(aCtx, l_aTabIndex);
end;//TkwVcmTabsDuplicate.DoDoIt

class function TkwVcmTabsDuplicate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:Duplicate';
end;//TkwVcmTabsDuplicate.GetWordNameForRegister

function TkwVcmTabsDuplicate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsDuplicate.GetResultTypeInfo

function TkwVcmTabsDuplicate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmTabsDuplicate.GetAllParamsCount

function TkwVcmTabsDuplicate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsDuplicate.ParamsTypes

type
 TkwVcmTabsCanDuplicate = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanDuplicate
[panel]Можно ли дублировать вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aTabIndex vcm:tabs:CanDuplicate >>> l_Boolean
[code]  }
 private
 // private methods
   function VcmTabsCanDuplicate(const aCtx: TtfwContext;
    aTabIndex: Integer): Boolean;
     {* Реализация слова скрипта vcm:tabs:CanDuplicate }
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
 end;//TkwVcmTabsCanDuplicate

// start class TkwVcmTabsCanDuplicate

function TkwVcmTabsCanDuplicate.VcmTabsCanDuplicate(const aCtx: TtfwContext;
  aTabIndex: Integer): Boolean;
//#UC START# *56B44CB5CD89_43C0563688C9_var*
//#UC END# *56B44CB5CD89_43C0563688C9_var*
begin
//#UC START# *56B44CB5CD89_43C0563688C9_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanCloneTab(GetActiveTabbedContainer.Tabs[aTabIndex]);
//#UC END# *56B44CB5CD89_43C0563688C9_impl*
end;//TkwVcmTabsCanDuplicate.VcmTabsCanDuplicate

procedure TkwVcmTabsCanDuplicate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTabIndex : Integer;
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
 aCtx.rEngine.PushBool((VcmTabsCanDuplicate(aCtx, l_aTabIndex)));
end;//TkwVcmTabsCanDuplicate.DoDoIt

class function TkwVcmTabsCanDuplicate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:CanDuplicate';
end;//TkwVcmTabsCanDuplicate.GetWordNameForRegister

function TkwVcmTabsCanDuplicate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanDuplicate.GetResultTypeInfo

function TkwVcmTabsCanDuplicate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmTabsCanDuplicate.GetAllParamsCount

function TkwVcmTabsCanDuplicate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsCanDuplicate.ParamsTypes

type
 TkwVcmTabsReopen = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:Reopen
[panel]Открыть закрытую вкладку в активном окне[panel]
*Пример:*
[code]
 vcm:tabs:Reopen
[code]  }
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
 end;//TkwVcmTabsReopen

// start class TkwVcmTabsReopen

procedure TkwVcmTabsReopen.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C449AC698640_var*
//#UC END# *4DAEEDE10285_C449AC698640_var*
begin
//#UC START# *4DAEEDE10285_C449AC698640_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  ReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *4DAEEDE10285_C449AC698640_impl*
end;//TkwVcmTabsReopen.DoDoIt

class function TkwVcmTabsReopen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:Reopen';
end;//TkwVcmTabsReopen.GetWordNameForRegister

function TkwVcmTabsReopen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwVcmTabsReopen.GetResultTypeInfo

function TkwVcmTabsReopen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsReopen.GetAllParamsCount

type
 TkwVcmTabsCanReopen = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:CanReopen
[panel]Можно ли открыть закрытую вкладку в активном окне[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 vcm:tabs:CanReopen >>> l_Boolean
[code]  }
 private
 // private methods
   function VcmTabsCanReopen(const aCtx: TtfwContext): Boolean;
     {* Реализация слова скрипта vcm:tabs:CanReopen }
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
 end;//TkwVcmTabsCanReopen

// start class TkwVcmTabsCanReopen

function TkwVcmTabsCanReopen.VcmTabsCanReopen(const aCtx: TtfwContext): Boolean;
//#UC START# *6BFDCF32FEC5_B8D479345CBE_var*
//#UC END# *6BFDCF32FEC5_B8D479345CBE_var*
begin
//#UC START# *6BFDCF32FEC5_B8D479345CBE_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := CanReopenClosedTab(GetActiveTabbedContainer);
//#UC END# *6BFDCF32FEC5_B8D479345CBE_impl*
end;//TkwVcmTabsCanReopen.VcmTabsCanReopen

procedure TkwVcmTabsCanReopen.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushBool((VcmTabsCanReopen(aCtx)));
end;//TkwVcmTabsCanReopen.DoDoIt

class function TkwVcmTabsCanReopen.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:CanReopen';
end;//TkwVcmTabsCanReopen.GetWordNameForRegister

function TkwVcmTabsCanReopen.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwVcmTabsCanReopen.GetResultTypeInfo

function TkwVcmTabsCanReopen.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwVcmTabsCanReopen.GetAllParamsCount

function TkwVcmTabsCanReopen.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([]);
end;//TkwVcmTabsCanReopen.ParamsTypes

type
 TkwVcmTabsGetIconIndex = {final scriptword} class(TtfwGlobalKeyWord)
  {* Слово скрипта vcm:tabs:GetIconIndex
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aTabIndex vcm:tabs:GetIconIndex >>> l_Integer
[code]  }
 private
 // private methods
   function VcmTabsGetIconIndex(const aCtx: TtfwContext;
    aTabIndex: Integer): Integer;
     {* Реализация слова скрипта vcm:tabs:GetIconIndex }
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
 end;//TkwVcmTabsGetIconIndex

// start class TkwVcmTabsGetIconIndex

function TkwVcmTabsGetIconIndex.VcmTabsGetIconIndex(const aCtx: TtfwContext;
  aTabIndex: Integer): Integer;
//#UC START# *5F70A124CAC6_1F0AD0312C05_var*
//#UC END# *5F70A124CAC6_1F0AD0312C05_var*
begin
//#UC START# *5F70A124CAC6_1F0AD0312C05_impl*
 with Tl3TabbedContainersDispatcher.Instance do
  Result := GetTabIcon(GetActiveTabbedContainer.Tabs[aTabIndex]);
//#UC END# *5F70A124CAC6_1F0AD0312C05_impl*
end;//TkwVcmTabsGetIconIndex.VcmTabsGetIconIndex

procedure TkwVcmTabsGetIconIndex.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aTabIndex : Integer;
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
 aCtx.rEngine.PushInt((VcmTabsGetIconIndex(aCtx, l_aTabIndex)));
end;//TkwVcmTabsGetIconIndex.DoDoIt

class function TkwVcmTabsGetIconIndex.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'vcm:tabs:GetIconIndex';
end;//TkwVcmTabsGetIconIndex.GetWordNameForRegister

function TkwVcmTabsGetIconIndex.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwVcmTabsGetIconIndex.GetResultTypeInfo

function TkwVcmTabsGetIconIndex.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwVcmTabsGetIconIndex.GetAllParamsCount

function TkwVcmTabsGetIconIndex.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Integer)]);
end;//TkwVcmTabsGetIconIndex.ParamsTypes
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

initialization
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_CloseCurrent
 TkwVcmTabsCloseCurrent.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_Close
 TkwVcmTabsClose.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_CloseAllButCurrent
 TkwVcmTabsCloseAllButCurrent.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_Active
 TkwVcmTabsActive.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_SetActive
 TkwVcmTabsSetActive.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_Count
 TkwVcmTabsCount.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_OpenNewTab
 TkwVcmTabsOpenNewTab.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_CanOpenNewTab
 TkwVcmTabsCanOpenNewTab.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_Duplicate
 TkwVcmTabsDuplicate.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_CanDuplicate
 TkwVcmTabsCanDuplicate.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_Reopen
 TkwVcmTabsReopen.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_CanReopen
 TkwVcmTabsCanReopen.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация vcm_tabs_GetIconIndex
 TkwVcmTabsGetIconIndex.RegisterInEngine;
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM
{$If not defined(NoScripts) AND not defined(NoTabs) AND not defined(NoVCM)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts AND not NoTabs AND not NoVCM

end.