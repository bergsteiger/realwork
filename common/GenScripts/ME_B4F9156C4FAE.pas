unit MedicFirmListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы MedicFirmList$Form }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Inpharm\MedicFirmListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Inpharm_Module
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
 Tkw_Form_MedicFirmList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы MedicFirmList$Form
----
*Пример использования*:
[code]
'aControl' форма::MedicFirmList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_MedicFirmList

 Tkw_MedicFirmList_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_MedicFirmList_Control_BackgroundPanel

 Tkw_MedicFirmList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push

 Tkw_MedicFirmList_Control_ContextFilter = {final} class(TtfwControlString)
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
 end;//Tkw_MedicFirmList_Control_ContextFilter

 Tkw_MedicFirmList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ContextFilter_Push

 Tkw_MedicFirmList_Control_ListTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ListTree
----
*Пример использования*:
[code]
контрол::ListTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_MedicFirmList_Control_ListTree

 Tkw_MedicFirmList_Control_ListTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ListTree
----
*Пример использования*:
[code]
контрол::ListTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_MedicFirmList_Control_ListTree_Push

 TkwEnMedicFirmListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.BackgroundPanel
[panel]Контрол BackgroundPanel формы Ten_MedicFirmList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicFirmList .Ten_MedicFirmList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
    {* Реализация слова скрипта .Ten_MedicFirmList.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicFirmListBackgroundPanel

 TkwEnMedicFirmListContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.ContextFilter
[panel]Контрол ContextFilter формы Ten_MedicFirmList[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aen_MedicFirmList .Ten_MedicFirmList.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
    {* Реализация слова скрипта .Ten_MedicFirmList.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicFirmListContextFilter

 TkwEnMedicFirmListListTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_MedicFirmList.ListTree
[panel]Контрол ListTree формы Ten_MedicFirmList[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_MedicFirmList .Ten_MedicFirmList.ListTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function ListTree(const aCtx: TtfwContext;
    aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_MedicFirmList.ListTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnMedicFirmListListTree

class function Tkw_Form_MedicFirmList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::MedicFirmList';
end;//Tkw_Form_MedicFirmList.GetWordNameForRegister

function Tkw_Form_MedicFirmList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9FA2A7743D59_var*
//#UC END# *4DDFD2EA0116_9FA2A7743D59_var*
begin
//#UC START# *4DDFD2EA0116_9FA2A7743D59_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9FA2A7743D59_impl*
end;//Tkw_Form_MedicFirmList.GetString

class function Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_MedicFirmList_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F63188E40F08_var*
//#UC END# *4DDFD2EA0116_F63188E40F08_var*
begin
//#UC START# *4DDFD2EA0116_F63188E40F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F63188E40F08_impl*
end;//Tkw_MedicFirmList_Control_BackgroundPanel.GetString

class procedure Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_F63188E40F08_var*
//#UC END# *52A086150180_F63188E40F08_var*
begin
//#UC START# *52A086150180_F63188E40F08_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F63188E40F08_impl*
end;//Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_82354F1D2C49_var*
//#UC END# *4DAEEDE10285_82354F1D2C49_var*
begin
//#UC START# *4DAEEDE10285_82354F1D2C49_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_82354F1D2C49_impl*
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_MedicFirmList_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_MedicFirmList_Control_ContextFilter.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0E25968661B6_var*
//#UC END# *4DDFD2EA0116_0E25968661B6_var*
begin
//#UC START# *4DDFD2EA0116_0E25968661B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0E25968661B6_impl*
end;//Tkw_MedicFirmList_Control_ContextFilter.GetString

class procedure Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_0E25968661B6_var*
//#UC END# *52A086150180_0E25968661B6_var*
begin
//#UC START# *52A086150180_0E25968661B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0E25968661B6_impl*
end;//Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine

procedure Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2A735885925E_var*
//#UC END# *4DAEEDE10285_2A735885925E_var*
begin
//#UC START# *4DAEEDE10285_2A735885925E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2A735885925E_impl*
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_MedicFirmList_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree';
end;//Tkw_MedicFirmList_Control_ListTree.GetWordNameForRegister

function Tkw_MedicFirmList_Control_ListTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_671089D6F4B3_var*
//#UC END# *4DDFD2EA0116_671089D6F4B3_var*
begin
//#UC START# *4DDFD2EA0116_671089D6F4B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_671089D6F4B3_impl*
end;//Tkw_MedicFirmList_Control_ListTree.GetString

class procedure Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
//#UC START# *52A086150180_671089D6F4B3_var*
//#UC END# *52A086150180_671089D6F4B3_var*
begin
//#UC START# *52A086150180_671089D6F4B3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_671089D6F4B3_impl*
end;//Tkw_MedicFirmList_Control_ListTree.RegisterInEngine

procedure Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_249C7444CA07_var*
//#UC END# *4DAEEDE10285_249C7444CA07_var*
begin
//#UC START# *4DAEEDE10285_249C7444CA07_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_249C7444CA07_impl*
end;//Tkw_MedicFirmList_Control_ListTree_Push.DoDoIt

class function Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ListTree:push';
end;//Tkw_MedicFirmList_Control_ListTree_Push.GetWordNameForRegister

function TkwEnMedicFirmListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TvtPanel;
 {* Реализация слова скрипта .Ten_MedicFirmList.BackgroundPanel }
//#UC START# *2F052D812AE6_F45A6F3A6877_var*
//#UC END# *2F052D812AE6_F45A6F3A6877_var*
begin
//#UC START# *2F052D812AE6_F45A6F3A6877_impl*
 !!! Needs to be implemented !!!
//#UC END# *2F052D812AE6_F45A6F3A6877_impl*
end;//TkwEnMedicFirmListBackgroundPanel.BackgroundPanel

procedure TkwEnMedicFirmListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F45A6F3A6877_var*
//#UC END# *4DAEEDE10285_F45A6F3A6877_var*
begin
//#UC START# *4DAEEDE10285_F45A6F3A6877_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F45A6F3A6877_impl*
end;//TkwEnMedicFirmListBackgroundPanel.DoDoIt

class function TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.BackgroundPanel';
end;//TkwEnMedicFirmListBackgroundPanel.GetWordNameForRegister

procedure TkwEnMedicFirmListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_F45A6F3A6877_var*
//#UC END# *52D00B00031A_F45A6F3A6877_var*
begin
//#UC START# *52D00B00031A_F45A6F3A6877_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_F45A6F3A6877_impl*
end;//TkwEnMedicFirmListBackgroundPanel.SetValuePrim

function TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicFirmListBackgroundPanel.GetResultTypeInfo

function TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListBackgroundPanel.GetAllParamsCount

function TkwEnMedicFirmListBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_F45A6F3A6877_var*
//#UC END# *5617F4D00243_F45A6F3A6877_var*
begin
//#UC START# *5617F4D00243_F45A6F3A6877_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_F45A6F3A6877_impl*
end;//TkwEnMedicFirmListBackgroundPanel.ParamsTypes

function TkwEnMedicFirmListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscContextFilter;
 {* Реализация слова скрипта .Ten_MedicFirmList.ContextFilter }
//#UC START# *FE1EC808F555_2F2BD8918036_var*
//#UC END# *FE1EC808F555_2F2BD8918036_var*
begin
//#UC START# *FE1EC808F555_2F2BD8918036_impl*
 !!! Needs to be implemented !!!
//#UC END# *FE1EC808F555_2F2BD8918036_impl*
end;//TkwEnMedicFirmListContextFilter.ContextFilter

procedure TkwEnMedicFirmListContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2F2BD8918036_var*
//#UC END# *4DAEEDE10285_2F2BD8918036_var*
begin
//#UC START# *4DAEEDE10285_2F2BD8918036_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2F2BD8918036_impl*
end;//TkwEnMedicFirmListContextFilter.DoDoIt

class function TkwEnMedicFirmListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ContextFilter';
end;//TkwEnMedicFirmListContextFilter.GetWordNameForRegister

procedure TkwEnMedicFirmListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_2F2BD8918036_var*
//#UC END# *52D00B00031A_2F2BD8918036_var*
begin
//#UC START# *52D00B00031A_2F2BD8918036_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_2F2BD8918036_impl*
end;//TkwEnMedicFirmListContextFilter.SetValuePrim

function TkwEnMedicFirmListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEnMedicFirmListContextFilter.GetResultTypeInfo

function TkwEnMedicFirmListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListContextFilter.GetAllParamsCount

function TkwEnMedicFirmListContextFilter.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_2F2BD8918036_var*
//#UC END# *5617F4D00243_2F2BD8918036_var*
begin
//#UC START# *5617F4D00243_2F2BD8918036_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_2F2BD8918036_impl*
end;//TkwEnMedicFirmListContextFilter.ParamsTypes

function TkwEnMedicFirmListListTree.ListTree(const aCtx: TtfwContext;
 aen_MedicFirmList: Ten_MedicFirmList): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_MedicFirmList.ListTree }
//#UC START# *CD712C6E8A53_9D0DDC3CED67_var*
//#UC END# *CD712C6E8A53_9D0DDC3CED67_var*
begin
//#UC START# *CD712C6E8A53_9D0DDC3CED67_impl*
 !!! Needs to be implemented !!!
//#UC END# *CD712C6E8A53_9D0DDC3CED67_impl*
end;//TkwEnMedicFirmListListTree.ListTree

procedure TkwEnMedicFirmListListTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9D0DDC3CED67_var*
//#UC END# *4DAEEDE10285_9D0DDC3CED67_var*
begin
//#UC START# *4DAEEDE10285_9D0DDC3CED67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9D0DDC3CED67_impl*
end;//TkwEnMedicFirmListListTree.DoDoIt

class function TkwEnMedicFirmListListTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_MedicFirmList.ListTree';
end;//TkwEnMedicFirmListListTree.GetWordNameForRegister

procedure TkwEnMedicFirmListListTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9D0DDC3CED67_var*
//#UC END# *52D00B00031A_9D0DDC3CED67_var*
begin
//#UC START# *52D00B00031A_9D0DDC3CED67_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9D0DDC3CED67_impl*
end;//TkwEnMedicFirmListListTree.SetValuePrim

function TkwEnMedicFirmListListTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnMedicFirmListListTree.GetResultTypeInfo

function TkwEnMedicFirmListListTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnMedicFirmListListTree.GetAllParamsCount

function TkwEnMedicFirmListListTree.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9D0DDC3CED67_var*
//#UC END# *5617F4D00243_9D0DDC3CED67_var*
begin
//#UC START# *5617F4D00243_9D0DDC3CED67_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9D0DDC3CED67_impl*
end;//TkwEnMedicFirmListListTree.ParamsTypes

initialization
 Tkw_Form_MedicFirmList.RegisterInEngine;
 {* Регистрация Tkw_Form_MedicFirmList }
 Tkw_MedicFirmList_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_BackgroundPanel }
 Tkw_MedicFirmList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_BackgroundPanel_Push }
 Tkw_MedicFirmList_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ContextFilter }
 Tkw_MedicFirmList_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ContextFilter_Push }
 Tkw_MedicFirmList_Control_ListTree.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ListTree }
 Tkw_MedicFirmList_Control_ListTree_Push.RegisterInEngine;
 {* Регистрация Tkw_MedicFirmList_Control_ListTree_Push }
 TkwEnMedicFirmListBackgroundPanel.RegisterInEngine;
 {* Регистрация en_MedicFirmList_BackgroundPanel }
 TkwEnMedicFirmListContextFilter.RegisterInEngine;
 {* Регистрация en_MedicFirmList_ContextFilter }
 TkwEnMedicFirmListListTree.RegisterInEngine;
 {* Регистрация en_MedicFirmList_ListTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicFirmList));
 {* Регистрация типа MedicFirmList$Form }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
