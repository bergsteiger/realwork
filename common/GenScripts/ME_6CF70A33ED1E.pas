unit TreeAttributeSelectKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы TreeAttributeSelect }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\LiteSearch\TreeAttributeSelectKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , LiteSearch_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 {$If Defined(Nemesis)}
 , nscTreeViewHotTruck
 {$IfEnd} // Defined(Nemesis)
 , SearchLite_Strange_Controls
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_TreeAttributeSelect = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы TreeAttributeSelect
----
*Пример использования*:
[code]
'aControl' форма::TreeAttributeSelect TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_TreeAttributeSelect

 Tkw_TreeAttributeSelect_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel

 Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push

 Tkw_TreeAttributeSelect_Control_ContextFilter = {final} class(TtfwControlString)
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
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter

 Tkw_TreeAttributeSelect_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push

 Tkw_TreeAttributeSelect_Control_AttributeTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола AttributeTree
----
*Пример использования*:
[code]
контрол::AttributeTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree

 Tkw_TreeAttributeSelect_Control_AttributeTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола AttributeTree
----
*Пример использования*:
[code]
контрол::AttributeTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push

 TkwEfTreeAttributeSelectBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.BackgroundPanel
[panel]Контрол BackgroundPanel формы TefTreeAttributeSelect[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefTreeAttributeSelect .TefTreeAttributeSelect.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
    {* Реализация слова скрипта .TefTreeAttributeSelect.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectBackgroundPanel

 TkwEfTreeAttributeSelectContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.ContextFilter
[panel]Контрол ContextFilter формы TefTreeAttributeSelect[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aefTreeAttributeSelect .TefTreeAttributeSelect.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
    {* Реализация слова скрипта .TefTreeAttributeSelect.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectContextFilter

 TkwEfTreeAttributeSelectAttributeTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefTreeAttributeSelect.AttributeTree
[panel]Контрол AttributeTree формы TefTreeAttributeSelect[panel]
*Тип результата:* TnscTreeViewHotTruck
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewHotTruck
 aefTreeAttributeSelect .TefTreeAttributeSelect.AttributeTree >>> l_TnscTreeViewHotTruck
[code]  }
  private
   function AttributeTree(const aCtx: TtfwContext;
    aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
    {* Реализация слова скрипта .TefTreeAttributeSelect.AttributeTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfTreeAttributeSelectAttributeTree

class function Tkw_Form_TreeAttributeSelect.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::TreeAttributeSelect';
end;//Tkw_Form_TreeAttributeSelect.GetWordNameForRegister

function Tkw_Form_TreeAttributeSelect.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_59373E93C0F0_var*
//#UC END# *4DDFD2EA0116_59373E93C0F0_var*
begin
//#UC START# *4DDFD2EA0116_59373E93C0F0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_59373E93C0F0_impl*
end;//Tkw_Form_TreeAttributeSelect.GetString

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6CD93724FAAB_var*
//#UC END# *4DDFD2EA0116_6CD93724FAAB_var*
begin
//#UC START# *4DDFD2EA0116_6CD93724FAAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6CD93724FAAB_impl*
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.GetString

class procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_6CD93724FAAB_var*
//#UC END# *52A086150180_6CD93724FAAB_var*
begin
//#UC START# *52A086150180_6CD93724FAAB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6CD93724FAAB_impl*
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_95E80DC828A3_var*
//#UC END# *4DAEEDE10285_95E80DC828A3_var*
begin
//#UC START# *4DAEEDE10285_95E80DC828A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_95E80DC828A3_impl*
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_TreeAttributeSelect_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_74BE38D9483A_var*
//#UC END# *4DDFD2EA0116_74BE38D9483A_var*
begin
//#UC START# *4DDFD2EA0116_74BE38D9483A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_74BE38D9483A_impl*
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.GetString

class procedure Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_74BE38D9483A_var*
//#UC END# *52A086150180_74BE38D9483A_var*
begin
//#UC START# *52A086150180_74BE38D9483A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_74BE38D9483A_impl*
end;//Tkw_TreeAttributeSelect_Control_ContextFilter.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_BF89704B3469_var*
//#UC END# *4DAEEDE10285_BF89704B3469_var*
begin
//#UC START# *4DAEEDE10285_BF89704B3469_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_BF89704B3469_impl*
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_TreeAttributeSelect_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AttributeTree';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetWordNameForRegister

function Tkw_TreeAttributeSelect_Control_AttributeTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F3ED8A525597_var*
//#UC END# *4DDFD2EA0116_F3ED8A525597_var*
begin
//#UC START# *4DDFD2EA0116_F3ED8A525597_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F3ED8A525597_impl*
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.GetString

class procedure Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine;
//#UC START# *52A086150180_F3ED8A525597_var*
//#UC END# *52A086150180_F3ED8A525597_var*
begin
//#UC START# *52A086150180_F3ED8A525597_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F3ED8A525597_impl*
end;//Tkw_TreeAttributeSelect_Control_AttributeTree.RegisterInEngine

procedure Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1774552B0AC8_var*
//#UC END# *4DAEEDE10285_1774552B0AC8_var*
begin
//#UC START# *4DAEEDE10285_1774552B0AC8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1774552B0AC8_impl*
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.DoDoIt

class function Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::AttributeTree:push';
end;//Tkw_TreeAttributeSelect_Control_AttributeTree_Push.GetWordNameForRegister

function TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TvtPanel;
 {* Реализация слова скрипта .TefTreeAttributeSelect.BackgroundPanel }
//#UC START# *D91532FFDBC3_3C4C01C8C1CC_var*
//#UC END# *D91532FFDBC3_3C4C01C8C1CC_var*
begin
//#UC START# *D91532FFDBC3_3C4C01C8C1CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *D91532FFDBC3_3C4C01C8C1CC_impl*
end;//TkwEfTreeAttributeSelectBackgroundPanel.BackgroundPanel

procedure TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3C4C01C8C1CC_var*
//#UC END# *4DAEEDE10285_3C4C01C8C1CC_var*
begin
//#UC START# *4DAEEDE10285_3C4C01C8C1CC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3C4C01C8C1CC_impl*
end;//TkwEfTreeAttributeSelectBackgroundPanel.DoDoIt

class function TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.BackgroundPanel';
end;//TkwEfTreeAttributeSelectBackgroundPanel.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEfTreeAttributeSelectBackgroundPanel.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEfTreeAttributeSelectBackgroundPanel.ParamsTypes

function TkwEfTreeAttributeSelectContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscContextFilter;
 {* Реализация слова скрипта .TefTreeAttributeSelect.ContextFilter }
//#UC START# *C58360F49EE0_3EBF063E3680_var*
//#UC END# *C58360F49EE0_3EBF063E3680_var*
begin
//#UC START# *C58360F49EE0_3EBF063E3680_impl*
 !!! Needs to be implemented !!!
//#UC END# *C58360F49EE0_3EBF063E3680_impl*
end;//TkwEfTreeAttributeSelectContextFilter.ContextFilter

procedure TkwEfTreeAttributeSelectContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3EBF063E3680_var*
//#UC END# *4DAEEDE10285_3EBF063E3680_var*
begin
//#UC START# *4DAEEDE10285_3EBF063E3680_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3EBF063E3680_impl*
end;//TkwEfTreeAttributeSelectContextFilter.DoDoIt

class function TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.ContextFilter';
end;//TkwEfTreeAttributeSelectContextFilter.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEfTreeAttributeSelectContextFilter.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEfTreeAttributeSelectContextFilter.ParamsTypes

function TkwEfTreeAttributeSelectAttributeTree.AttributeTree(const aCtx: TtfwContext;
 aefTreeAttributeSelect: TefTreeAttributeSelect): TnscTreeViewHotTruck;
 {* Реализация слова скрипта .TefTreeAttributeSelect.AttributeTree }
//#UC START# *C635215DBD0B_E3BEF01A8948_var*
//#UC END# *C635215DBD0B_E3BEF01A8948_var*
begin
//#UC START# *C635215DBD0B_E3BEF01A8948_impl*
 !!! Needs to be implemented !!!
//#UC END# *C635215DBD0B_E3BEF01A8948_impl*
end;//TkwEfTreeAttributeSelectAttributeTree.AttributeTree

procedure TkwEfTreeAttributeSelectAttributeTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E3BEF01A8948_var*
//#UC END# *4DAEEDE10285_E3BEF01A8948_var*
begin
//#UC START# *4DAEEDE10285_E3BEF01A8948_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E3BEF01A8948_impl*
end;//TkwEfTreeAttributeSelectAttributeTree.DoDoIt

class function TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefTreeAttributeSelect.AttributeTree';
end;//TkwEfTreeAttributeSelectAttributeTree.GetWordNameForRegister

procedure TkwEfTreeAttributeSelectAttributeTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEfTreeAttributeSelectAttributeTree.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwEfTreeAttributeSelectAttributeTree.ParamsTypes

initialization
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
 TkwEfTreeAttributeSelectBackgroundPanel.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_BackgroundPanel }
 TkwEfTreeAttributeSelectContextFilter.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_ContextFilter }
 TkwEfTreeAttributeSelectAttributeTree.RegisterInEngine;
 {* Регистрация efTreeAttributeSelect_AttributeTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefTreeAttributeSelect));
 {* Регистрация типа TreeAttributeSelect }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewHotTruck));
 {* Регистрация типа TnscTreeViewHotTruck }
{$IfEnd} // NOT Defined(NoScripts)

end.
