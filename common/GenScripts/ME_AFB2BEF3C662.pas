unit DictionKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Diction }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\DictionKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Diction_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , nscTreeViewWithAdapterDragDrop
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Diction = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Diction
----
*Пример использования*:
[code]
'aControl' форма::Diction TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Diction

 Tkw_Diction_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_Diction_Control_BackgroundPanel

 Tkw_Diction_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_BackgroundPanel_Push

 Tkw_Diction_Control_ContextFilter = {final} class(TtfwControlString)
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
 end;//Tkw_Diction_Control_ContextFilter

 Tkw_Diction_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_ContextFilter_Push

 Tkw_Diction_Control_WordsTree = {final} class(TtfwControlString)
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
 end;//Tkw_Diction_Control_WordsTree

 Tkw_Diction_Control_WordsTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола WordsTree
----
*Пример использования*:
[code]
контрол::WordsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Diction_Control_WordsTree_Push

 TkwEnDictionBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.BackgroundPanel
[panel]Контрол BackgroundPanel формы TenDiction[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aenDiction .TenDiction.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aenDiction: TenDiction): TvtPanel;
    {* Реализация слова скрипта .TenDiction.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionBackgroundPanel

 TkwEnDictionContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.ContextFilter
[panel]Контрол ContextFilter формы TenDiction[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aenDiction .TenDiction.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscContextFilter;
    {* Реализация слова скрипта .TenDiction.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionContextFilter

 TkwEnDictionWordsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenDiction.WordsTree
[panel]Контрол WordsTree формы TenDiction[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenDiction .TenDiction.WordsTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function WordsTree(const aCtx: TtfwContext;
    aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenDiction.WordsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnDictionWordsTree

class function Tkw_Form_Diction.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Diction';
end;//Tkw_Form_Diction.GetWordNameForRegister

function Tkw_Form_Diction.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_13CB70E95F1B_var*
//#UC END# *4DDFD2EA0116_13CB70E95F1B_var*
begin
//#UC START# *4DDFD2EA0116_13CB70E95F1B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_13CB70E95F1B_impl*
end;//Tkw_Form_Diction.GetString

class function Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_Diction_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_Diction_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5FC0994E2F9E_var*
//#UC END# *4DDFD2EA0116_5FC0994E2F9E_var*
begin
//#UC START# *4DDFD2EA0116_5FC0994E2F9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5FC0994E2F9E_impl*
end;//Tkw_Diction_Control_BackgroundPanel.GetString

class procedure Tkw_Diction_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_5FC0994E2F9E_var*
//#UC END# *52A086150180_5FC0994E2F9E_var*
begin
//#UC START# *52A086150180_5FC0994E2F9E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5FC0994E2F9E_impl*
end;//Tkw_Diction_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_98F39DD7DA47_var*
//#UC END# *4DAEEDE10285_98F39DD7DA47_var*
begin
//#UC START# *4DAEEDE10285_98F39DD7DA47_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_98F39DD7DA47_impl*
end;//Tkw_Diction_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_Diction_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_Diction_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_Diction_Control_ContextFilter.GetWordNameForRegister

function Tkw_Diction_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D8E741EFA38A_var*
//#UC END# *4DDFD2EA0116_D8E741EFA38A_var*
begin
//#UC START# *4DDFD2EA0116_D8E741EFA38A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D8E741EFA38A_impl*
end;//Tkw_Diction_Control_ContextFilter.GetString

class procedure Tkw_Diction_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_D8E741EFA38A_var*
//#UC END# *52A086150180_D8E741EFA38A_var*
begin
//#UC START# *52A086150180_D8E741EFA38A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D8E741EFA38A_impl*
end;//Tkw_Diction_Control_ContextFilter.RegisterInEngine

procedure Tkw_Diction_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C4366A10CBC7_var*
//#UC END# *4DAEEDE10285_C4366A10CBC7_var*
begin
//#UC START# *4DAEEDE10285_C4366A10CBC7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C4366A10CBC7_impl*
end;//Tkw_Diction_Control_ContextFilter_Push.DoDoIt

class function Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_Diction_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_Diction_Control_WordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree';
end;//Tkw_Diction_Control_WordsTree.GetWordNameForRegister

function Tkw_Diction_Control_WordsTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_625384791C6F_var*
//#UC END# *4DDFD2EA0116_625384791C6F_var*
begin
//#UC START# *4DDFD2EA0116_625384791C6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_625384791C6F_impl*
end;//Tkw_Diction_Control_WordsTree.GetString

class procedure Tkw_Diction_Control_WordsTree.RegisterInEngine;
//#UC START# *52A086150180_625384791C6F_var*
//#UC END# *52A086150180_625384791C6F_var*
begin
//#UC START# *52A086150180_625384791C6F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_625384791C6F_impl*
end;//Tkw_Diction_Control_WordsTree.RegisterInEngine

procedure Tkw_Diction_Control_WordsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E8445581EFE7_var*
//#UC END# *4DAEEDE10285_E8445581EFE7_var*
begin
//#UC START# *4DAEEDE10285_E8445581EFE7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E8445581EFE7_impl*
end;//Tkw_Diction_Control_WordsTree_Push.DoDoIt

class function Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::WordsTree:push';
end;//Tkw_Diction_Control_WordsTree_Push.GetWordNameForRegister

function TkwEnDictionBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aenDiction: TenDiction): TvtPanel;
 {* Реализация слова скрипта .TenDiction.BackgroundPanel }
//#UC START# *8CA40CE18A4E_B2258800EAED_var*
//#UC END# *8CA40CE18A4E_B2258800EAED_var*
begin
//#UC START# *8CA40CE18A4E_B2258800EAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *8CA40CE18A4E_B2258800EAED_impl*
end;//TkwEnDictionBackgroundPanel.BackgroundPanel

procedure TkwEnDictionBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B2258800EAED_var*
//#UC END# *4DAEEDE10285_B2258800EAED_var*
begin
//#UC START# *4DAEEDE10285_B2258800EAED_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B2258800EAED_impl*
end;//TkwEnDictionBackgroundPanel.DoDoIt

class function TkwEnDictionBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.BackgroundPanel';
end;//TkwEnDictionBackgroundPanel.GetWordNameForRegister

procedure TkwEnDictionBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnDictionBackgroundPanel.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionBackgroundPanel.ParamsTypes

function TkwEnDictionContextFilter.ContextFilter(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscContextFilter;
 {* Реализация слова скрипта .TenDiction.ContextFilter }
//#UC START# *6271F0C92E13_B4EC4D5AF267_var*
//#UC END# *6271F0C92E13_B4EC4D5AF267_var*
begin
//#UC START# *6271F0C92E13_B4EC4D5AF267_impl*
 !!! Needs to be implemented !!!
//#UC END# *6271F0C92E13_B4EC4D5AF267_impl*
end;//TkwEnDictionContextFilter.ContextFilter

procedure TkwEnDictionContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B4EC4D5AF267_var*
//#UC END# *4DAEEDE10285_B4EC4D5AF267_var*
begin
//#UC START# *4DAEEDE10285_B4EC4D5AF267_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B4EC4D5AF267_impl*
end;//TkwEnDictionContextFilter.DoDoIt

class function TkwEnDictionContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.ContextFilter';
end;//TkwEnDictionContextFilter.GetWordNameForRegister

procedure TkwEnDictionContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnDictionContextFilter.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionContextFilter.ParamsTypes

function TkwEnDictionWordsTree.WordsTree(const aCtx: TtfwContext;
 aenDiction: TenDiction): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenDiction.WordsTree }
//#UC START# *EF711B8690BD_ED3545E875CA_var*
//#UC END# *EF711B8690BD_ED3545E875CA_var*
begin
//#UC START# *EF711B8690BD_ED3545E875CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *EF711B8690BD_ED3545E875CA_impl*
end;//TkwEnDictionWordsTree.WordsTree

procedure TkwEnDictionWordsTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ED3545E875CA_var*
//#UC END# *4DAEEDE10285_ED3545E875CA_var*
begin
//#UC START# *4DAEEDE10285_ED3545E875CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ED3545E875CA_impl*
end;//TkwEnDictionWordsTree.DoDoIt

class function TkwEnDictionWordsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenDiction.WordsTree';
end;//TkwEnDictionWordsTree.GetWordNameForRegister

procedure TkwEnDictionWordsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnDictionWordsTree.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEnDictionWordsTree.ParamsTypes

initialization
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
 TkwEnDictionBackgroundPanel.RegisterInEngine;
 {* Регистрация enDiction_BackgroundPanel }
 TkwEnDictionContextFilter.RegisterInEngine;
 {* Регистрация enDiction_ContextFilter }
 TkwEnDictionWordsTree.RegisterInEngine;
 {* Регистрация enDiction_WordsTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenDiction));
 {* Регистрация типа Diction }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
