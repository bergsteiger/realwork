unit TreeAttributeSelectKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TreeAttributeSelect }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\Forms\TreeAttributeSelectKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "TreeAttributeSelectKeywordsPack" MUID: (4AAF487F03BC_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

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
 , TreeAttributeSelect_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AAF487F03BC_Packimpl_uses*
 //#UC END# *4AAF487F03BC_Packimpl_uses*
;

type
 TkwEfTreeAttributeSelectBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
    {* Реализация слова скрипта .TefTreeAttributeSelect.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectBackgroundPanel

 TkwEfTreeAttributeSelectContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
    {* Реализация слова скрипта .TefTreeAttributeSelect.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectContextFilter

 TkwEfTreeAttributeSelectAttributeTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.AttributeTree }
  private
   function AttributeTree(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .TefTreeAttributeSelect.AttributeTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfTreeAttributeSelectAttributeTree

 Tkw_Form_TreeAttributeSelect = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TreeAttributeSelect
----
*Пример использования*:
[code]форма::TreeAttributeSelect TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect

 Tkw_TreeAttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel

 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

 Tkw_TreeAttributeSelect_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter

 Tkw_TreeAttributeSelect_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push

 Tkw_TreeAttributeSelect_Control_AttributeTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола AttributeTree
----
*Пример использования*:
[code]контрол::AttributeTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree

 Tkw_TreeAttributeSelect_Control_AttributeTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола AttributeTree
----
*Пример использования*:
[code]контрол::AttributeTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push

function TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
 {* Реализация слова скрипта .TefTreeAttributeSelect.BackgroundPanel }
begin
 Result := aefTreeAttributeSelect.BackgroundPanel;
end;//TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel

class function TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.BackgroundPanel';
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister

function TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetResultTypeInfo

function TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetAllParamsCount

function TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes

procedure TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim

procedure TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt

function TkwEfTreeAttributeSelectContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
 {* Реализация слова скрипта .TefTreeAttributeSelect.ContextFilter }
begin
 Result := aefTreeAttributeSelect.ContextFilter;
end;//TkwEfTreeAttributeSelectContextFilter.ContextFilter

class function TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.ContextFilter';
end;//TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister

function TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfTreeAttributeSelectContextFilter.GetResultTypeInfo

function TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectContextFilter.GetAllParamsCount

function TkwEfTreeAttributeSelectContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectContextFilter.ParamsTypes

procedure TkwEfTreeAttributeSelectContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEfTreeAttributeSelectContextFilter.SetValuePrim

procedure TkwEfTreeAttributeSelectContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectContextFilter.DoDoIt

function TkwEfTreeAttributeSelectAttributeTree.AttributeTree(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .TefTreeAttributeSelect.AttributeTree }
begin
 Result := aefTreeAttributeSelect.AttributeTree;
end;//TkwEfTreeAttributeSelectAttributeTree.AttributeTree

class function TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.AttributeTree';
end;//TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister

function TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewHotTruck);
end;//TkwEfTreeAttributeSelectAttributeTree.GetResultTypeInfo

function TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfTreeAttributeSelectAttributeTree.GetAllParamsCount

function TkwEfTreeAttributeSelectAttributeTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefTreeAttributeSelect)]);
end;//TkwEfTreeAttributeSelectAttributeTree.ParamsTypes

procedure TkwEfTreeAttributeSelectAttributeTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству AttributeTree', aCtx);
end;//TkwEfTreeAttributeSelectAttributeTree.SetValuePrim

procedure TkwEfTreeAttributeSelectAttributeTree.DoDoIt(const aCtx: TtfwContext);
var l_aefTreeAttributeSelect: TefTreeAttributeSelect;
begin
 try
  l_aefTreeAttributeSelect := TefTreeAttributeSelect(aCtx.rEngine.PopObjAs(TefTreeAttributeSelect));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefTreeAttributeSelect: TefTreeAttributeSelect : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(AttributeTree(aCtx, l_aefTreeAttributeSelect));
end;//TkwEfTreeAttributeSelectAttributeTree.DoDoIt

function Tkw_Form_TreeAttributeSelect.GetString: AnsiString;
begin
 Result := 'efTreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetString

class procedure Tkw_Form_TreeAttributeSelect.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefTreeAttributeSelect);
end;//Tkw_Form_TreeAttributeSelect.RegisterInEngine

class function Tkw_Form_TreeAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetString

class procedure Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_AttributeTree.GetString: AnsiString;
begin
 Result := 'AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetString

class procedure Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewHotTruck);
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine

class function Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister

procedure Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('AttributeTree');
 inherited;
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AttributeTree:push';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister

initialization
 TkwEfTreeAttributeSelectBackgroundPanel.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_BackgroundPanel }
 TkwEfTreeAttributeSelectContextFilter.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_ContextFilter }
 TkwEfTreeAttributeSelectAttributeTree.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_AttributeTree }
 Tkw_Form_TreeAttributeSelect.RegisterInEngine;
 {* Регистрация Tkw_Form_TreeAttributeSelect }
 Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_BackgroundPanel }
 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push }
 Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_ContextFilter }
 Tkw_TreeAttributeSelect_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_ContextFilter_Push }
 Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_AttributeTree }
 Tkw_TreeAttributeSelect_Control_AttributeTree_Push.RegisterInEngine;
 {* Регистрация Tkw_TreeAttributeSelect_Control_AttributeTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeSelect));
 {* Регистрация типа TefTreeAttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* Регистрация типа TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
