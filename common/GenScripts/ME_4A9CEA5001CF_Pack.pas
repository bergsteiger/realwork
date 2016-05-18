unit DictionKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Diction }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\Forms\DictionKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "DictionKeywordsPack" MUID: (4A9CEA5001CF_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Diction_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEnDictionBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aenDiction: TenDiction): TvtPanel;
    {* Реализация слова скрипта .TenDiction.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDictionBackgroundPanel

 TkwEnDictionContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscContextFilter;
    {* Реализация слова скрипта .TenDiction.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDictionContextFilter

 TkwEnDictionWordsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.WordsTree }
  private
   function WordsTree(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenDiction.WordsTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnDictionWordsTree

 Tkw_Form_Diction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Diction
----
*Пример использования*:
[code]форма::Diction TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Diction

 Tkw_Diction_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_BackgroundPanel

 Tkw_Diction_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]контрол::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_BackgroundPanel_Push

 Tkw_Diction_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_ContextFilter

 Tkw_Diction_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]контрол::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_ContextFilter_Push

 Tkw_Diction_Control_WordsTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WordsTree
----
*Пример использования*:
[code]контрол::WordsTree TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_WordsTree

 Tkw_Diction_Control_WordsTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WordsTree
----
*Пример использования*:
[code]контрол::WordsTree:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_WordsTree_Push

function TkwEnDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aenDiction: TenDiction): TvtPanel;
 {* Реализация слова скрипта .TenDiction.BackgroundPanel }
begin
 Result := aenDiction.BackgroundPanel;
end;//TkwEnDictionBackgroundPanel.BackgroundPanel

class function TkwEnDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.BackgroundPanel';
end;//TkwEnDictionBackgroundPanel.GetWordNameForRegister

function TkwEnDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnDictionBackgroundPanel.GetResultTypeInfo

function TkwEnDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionBackgroundPanel.GetAllParamsCount

function TkwEnDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionBackgroundPanel.ParamsTypes

procedure TkwEnDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnDictionBackgroundPanel.SetValuePrim

procedure TkwEnDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aenDiction: TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aenDiction));
end;//TkwEnDictionBackgroundPanel.DoDoIt

function TkwEnDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscContextFilter;
 {* Реализация слова скрипта .TenDiction.ContextFilter }
begin
 Result := aenDiction.ContextFilter;
end;//TkwEnDictionContextFilter.ContextFilter

class function TkwEnDictionContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.ContextFilter';
end;//TkwEnDictionContextFilter.GetWordNameForRegister

function TkwEnDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnDictionContextFilter.GetResultTypeInfo

function TkwEnDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionContextFilter.GetAllParamsCount

function TkwEnDictionContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionContextFilter.ParamsTypes

procedure TkwEnDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnDictionContextFilter.SetValuePrim

procedure TkwEnDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aenDiction: TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aenDiction));
end;//TkwEnDictionContextFilter.DoDoIt

function TkwEnDictionWordsTree.WordsTree(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenDiction.WordsTree }
begin
 Result := aenDiction.WordsTree;
end;//TkwEnDictionWordsTree.WordsTree

class function TkwEnDictionWordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.WordsTree';
end;//TkwEnDictionWordsTree.GetWordNameForRegister

function TkwEnDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnDictionWordsTree.GetResultTypeInfo

function TkwEnDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnDictionWordsTree.GetAllParamsCount

function TkwEnDictionWordsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenDiction)]);
end;//TkwEnDictionWordsTree.ParamsTypes

procedure TkwEnDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству WordsTree', aCtx);
end;//TkwEnDictionWordsTree.SetValuePrim

procedure TkwEnDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
var l_aenDiction: TenDiction;
begin
 try
  l_aenDiction := TenDiction(aCtx.rEngine.PopObjAs(TenDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenDiction: TenDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WordsTree(aCtx, l_aenDiction));
end;//TkwEnDictionWordsTree.DoDoIt

function Tkw_Form_Diction.GetString: AnsiString;
begin
 Result := 'enDiction';
end;//Tkw_Form_Diction.GetString

class procedure Tkw_Form_Diction.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TenDiction);
end;//Tkw_Form_Diction.RegisterInEngine

class function Tkw_Form_Diction.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Diction';
end;//Tkw_Form_Diction.GetWordNameForRegister

function Tkw_Diction_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetString

class procedure Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_Diction_Control_BackgroundPanel.RegisterInEngine

class function Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_Diction_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetString

class procedure Tkw_Diction_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_Diction_Control_ContextFilter.RegisterInEngine

class function Tkw_Diction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_Diction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_Diction_Control_ContextFilter_Push.DoDoIt

class function Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_Diction_Control_WordsTree.GetString: AnsiString;
begin
 Result := 'WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetString

class procedure Tkw_Diction_Control_WordsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_Diction_Control_WordsTree.RegisterInEngine

class function Tkw_Diction_Control_WordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetWordNameForRegister

procedure Tkw_Diction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('WordsTree');
 inherited;
end;//Tkw_Diction_Control_WordsTree_Push.DoDoIt

class function Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree:push';
end;//Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister

initialization
 TkwEnDictionBackgroundPanel.RegisterInEngine;
 {* Регистрация enDiction_BackgroundPanel }
 TkwEnDictionContextFilter.RegisterInEngine;
 {* Регистрация enDiction_ContextFilter }
 TkwEnDictionWordsTree.RegisterInEngine;
 {* Регистрация enDiction_WordsTree }
 Tkw_Form_Diction.RegisterInEngine;
 {* Регистрация Tkw_Form_Diction }
 Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_BackgroundPanel }
 Tkw_Diction_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_BackgroundPanel_Push }
 Tkw_Diction_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_ContextFilter }
 Tkw_Diction_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_ContextFilter_Push }
 Tkw_Diction_Control_WordsTree.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_WordsTree }
 Tkw_Diction_Control_WordsTree_Push.RegisterInEngine;
 {* Регистрация Tkw_Diction_Control_WordsTree_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenDiction));
 {* Регистрация типа TenDiction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
