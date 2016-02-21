unit CommonDictionKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CommonDiction }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\CommonDictionKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Diction_Module
 , vtPanel
 , nscTreeViewWithAdapterDragDrop
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_CommonDiction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы CommonDiction
----
*Пример использования*:
[code]
'aControl' форма::CommonDiction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CommonDiction

 Tkw_CommonDiction_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CommonDiction_Control_BackgroundPanel

 Tkw_CommonDiction_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_BackgroundPanel_Push

 Tkw_CommonDiction_Control_WordsTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола WordsTree
----
*Пример использования*:
[code]
контрол::WordsTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CommonDiction_Control_WordsTree

 Tkw_CommonDiction_Control_WordsTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WordsTree
----
*Пример использования*:
[code]
контрол::WordsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_WordsTree_Push

 Tkw_CommonDiction_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CommonDiction_Control_ContextFilter

 Tkw_CommonDiction_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CommonDiction_Control_ContextFilter_Push

 TkwEnCommonDictionBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_CommonDiction.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_CommonDiction[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_CommonDiction .Ten_CommonDiction.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TvtPanel;
    {* Реализация слова скрипта .Ten_CommonDiction.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCommonDictionBackgroundPanel

 TkwEnCommonDictionWordsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_CommonDiction.WordsTree
[panel]Контрол WordsTree формы Ten_CommonDiction[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_CommonDiction .Ten_CommonDiction.WordsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function WordsTree(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_CommonDiction.WordsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCommonDictionWordsTree

 TkwEnCommonDictionContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_CommonDiction.ContextFilter
[panel]Контрол ContextFilter формы Ten_CommonDiction[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_CommonDiction .Ten_CommonDiction.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
    {* Реализация слова скрипта .Ten_CommonDiction.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnCommonDictionContextFilter

class function Tkw_Form_CommonDiction.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::CommonDiction';
end;//Tkw_Form_CommonDiction.GetWordNameForRegister

function Tkw_Form_CommonDiction.GetString: AnsiString;
begin
 Result := 'en_CommonDiction';
end;//Tkw_Form_CommonDiction.GetString

class function Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_CommonDiction_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_CommonDiction_Control_BackgroundPanel.GetString

class procedure Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D69C6A3ADF1F_var*
//#UC END# *4DAEEDE10285_D69C6A3ADF1F_var*
begin
//#UC START# *4DAEEDE10285_D69C6A3ADF1F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D69C6A3ADF1F_impl*
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_CommonDiction_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetWordNameForRegister

function Tkw_CommonDiction_Control_WordsTree.GetString: AnsiString;
begin
 Result := 'WordsTree';
end;//Tkw_CommonDiction_Control_WordsTree.GetString

class procedure Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscTreeViewWithAdapterDragDrop);
end;//Tkw_CommonDiction_Control_WordsTree.RegisterInEngine

procedure Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A9A24A24F286_var*
//#UC END# *4DAEEDE10285_A9A24A24F286_var*
begin
//#UC START# *4DAEEDE10285_A9A24A24F286_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A9A24A24F286_impl*
end;//Tkw_CommonDiction_Control_WordsTree_Push.DoDoIt

class function Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree:push';
end;//Tkw_CommonDiction_Control_WordsTree_Push.GetWordNameForRegister

class function Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetWordNameForRegister

function Tkw_CommonDiction_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_CommonDiction_Control_ContextFilter.GetString

class procedure Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine

procedure Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CB5CFCE2C18A_var*
//#UC END# *4DAEEDE10285_CB5CFCE2C18A_var*
begin
//#UC START# *4DAEEDE10285_CB5CFCE2C18A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CB5CFCE2C18A_impl*
end;//Tkw_CommonDiction_Control_ContextFilter_Push.DoDoIt

class function Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_CommonDiction_Control_ContextFilter_Push.GetWordNameForRegister

function TkwEnCommonDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TvtPanel;
 {* Реализация слова скрипта .Ten_CommonDiction.BackgroundPanel }
begin
 Result := aen_CommonDiction.BackgroundPanel;
end;//TkwEnCommonDictionBackgroundPanel.BackgroundPanel

procedure TkwEnCommonDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionBackgroundPanel.DoDoIt

class function TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.BackgroundPanel';
end;//TkwEnCommonDictionBackgroundPanel.GetWordNameForRegister

procedure TkwEnCommonDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEnCommonDictionBackgroundPanel.SetValuePrim

function TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnCommonDictionBackgroundPanel.GetResultTypeInfo

function TkwEnCommonDictionBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionBackgroundPanel.GetAllParamsCount

function TkwEnCommonDictionBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionBackgroundPanel.ParamsTypes

function TkwEnCommonDictionWordsTree.WordsTree(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_CommonDiction.WordsTree }
begin
 Result := aen_CommonDiction.WordsTree;
end;//TkwEnCommonDictionWordsTree.WordsTree

procedure TkwEnCommonDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(WordsTree(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionWordsTree.DoDoIt

class function TkwEnCommonDictionWordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.WordsTree';
end;//TkwEnCommonDictionWordsTree.GetWordNameForRegister

procedure TkwEnCommonDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству WordsTree', aCtx);
end;//TkwEnCommonDictionWordsTree.SetValuePrim

function TkwEnCommonDictionWordsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnCommonDictionWordsTree.GetResultTypeInfo

function TkwEnCommonDictionWordsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionWordsTree.GetAllParamsCount

function TkwEnCommonDictionWordsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionWordsTree.ParamsTypes

function TkwEnCommonDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_CommonDiction: Ten_CommonDiction): TnscContextFilter;
 {* Реализация слова скрипта .Ten_CommonDiction.ContextFilter }
begin
 Result := aen_CommonDiction.ContextFilter;
end;//TkwEnCommonDictionContextFilter.ContextFilter

procedure TkwEnCommonDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aen_CommonDiction: Ten_CommonDiction;
begin
 try
  l_aen_CommonDiction := Ten_CommonDiction(aCtx.rEngine.PopObjAs(Ten_CommonDiction));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_CommonDiction: Ten_CommonDiction : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aen_CommonDiction));
end;//TkwEnCommonDictionContextFilter.DoDoIt

class function TkwEnCommonDictionContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_CommonDiction.ContextFilter';
end;//TkwEnCommonDictionContextFilter.GetWordNameForRegister

procedure TkwEnCommonDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEnCommonDictionContextFilter.SetValuePrim

function TkwEnCommonDictionContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnCommonDictionContextFilter.GetResultTypeInfo

function TkwEnCommonDictionContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnCommonDictionContextFilter.GetAllParamsCount

function TkwEnCommonDictionContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_CommonDiction)]);
end;//TkwEnCommonDictionContextFilter.ParamsTypes

initialization
 Tkw_Form_CommonDiction.RegisterInEngine;
 {* Регистрация Tkw_Form_CommonDiction }
 Tkw_CommonDiction_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_BackgroundPanel }
 Tkw_CommonDiction_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_BackgroundPanel_Push }
 Tkw_CommonDiction_Control_WordsTree.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_WordsTree }
 Tkw_CommonDiction_Control_WordsTree_Push.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_WordsTree_Push }
 Tkw_CommonDiction_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_ContextFilter }
 Tkw_CommonDiction_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_CommonDiction_Control_ContextFilter_Push }
 TkwEnCommonDictionBackgroundPanel.RegisterInEngine;
 {* Регистрация en_CommonDiction_BackgroundPanel }
 TkwEnCommonDictionWordsTree.RegisterInEngine;
 {* Регистрация en_CommonDiction_WordsTree }
 TkwEnCommonDictionContextFilter.RegisterInEngine;
 {* Регистрация en_CommonDiction_ContextFilter }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_CommonDiction));
 {* Регистрация типа CommonDiction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
