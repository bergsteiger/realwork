unit ConfigurationListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ConfigurationList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Settings\ConfigurationListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Settings_Module
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
 Tkw_Form_ConfigurationList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ConfigurationList
----
*Пример использования*:
[code]
'aControl' форма::ConfigurationList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ConfigurationList

 Tkw_ConfigurationList_Control_tvConfs = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvConfs
----
*Пример использования*:
[code]
контрол::tvConfs TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ConfigurationList_Control_tvConfs

 Tkw_ConfigurationList_Control_tvConfs_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvConfs
----
*Пример использования*:
[code]
контрол::tvConfs:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ConfigurationList_Control_tvConfs_Push

 TkwEnConfigurationListTvConfs = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_ConfigurationList.tvConfs
[panel]Контрол tvConfs формы Ten_ConfigurationList[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aen_ConfigurationList .Ten_ConfigurationList.tvConfs >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvConfs(const aCtx: TtfwContext;
    aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .Ten_ConfigurationList.tvConfs }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnConfigurationListTvConfs

class function Tkw_Form_ConfigurationList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ConfigurationList';
end;//Tkw_Form_ConfigurationList.GetWordNameForRegister

function Tkw_Form_ConfigurationList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_36BF1866FE37_var*
//#UC END# *4DDFD2EA0116_36BF1866FE37_var*
begin
//#UC START# *4DDFD2EA0116_36BF1866FE37_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_36BF1866FE37_impl*
end;//Tkw_Form_ConfigurationList.GetString

class function Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvConfs';
end;//Tkw_ConfigurationList_Control_tvConfs.GetWordNameForRegister

function Tkw_ConfigurationList_Control_tvConfs.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C38331BD077F_var*
//#UC END# *4DDFD2EA0116_C38331BD077F_var*
begin
//#UC START# *4DDFD2EA0116_C38331BD077F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C38331BD077F_impl*
end;//Tkw_ConfigurationList_Control_tvConfs.GetString

class procedure Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
//#UC START# *52A086150180_C38331BD077F_var*
//#UC END# *52A086150180_C38331BD077F_var*
begin
//#UC START# *52A086150180_C38331BD077F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C38331BD077F_impl*
end;//Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine

procedure Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_93DA20A404E5_var*
//#UC END# *4DAEEDE10285_93DA20A404E5_var*
begin
//#UC START# *4DAEEDE10285_93DA20A404E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_93DA20A404E5_impl*
end;//Tkw_ConfigurationList_Control_tvConfs_Push.DoDoIt

class function Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvConfs:push';
end;//Tkw_ConfigurationList_Control_tvConfs_Push.GetWordNameForRegister

function TkwEnConfigurationListTvConfs.tvConfs(const aCtx: TtfwContext;
 aen_ConfigurationList: Ten_ConfigurationList): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .Ten_ConfigurationList.tvConfs }
//#UC START# *B81DC20ABA44_05D945CE3B09_var*
//#UC END# *B81DC20ABA44_05D945CE3B09_var*
begin
//#UC START# *B81DC20ABA44_05D945CE3B09_impl*
 !!! Needs to be implemented !!!
//#UC END# *B81DC20ABA44_05D945CE3B09_impl*
end;//TkwEnConfigurationListTvConfs.tvConfs

procedure TkwEnConfigurationListTvConfs.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_05D945CE3B09_var*
//#UC END# *4DAEEDE10285_05D945CE3B09_var*
begin
//#UC START# *4DAEEDE10285_05D945CE3B09_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_05D945CE3B09_impl*
end;//TkwEnConfigurationListTvConfs.DoDoIt

class function TkwEnConfigurationListTvConfs.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_ConfigurationList.tvConfs';
end;//TkwEnConfigurationListTvConfs.GetWordNameForRegister

procedure TkwEnConfigurationListTvConfs.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_05D945CE3B09_var*
//#UC END# *52D00B00031A_05D945CE3B09_var*
begin
//#UC START# *52D00B00031A_05D945CE3B09_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_05D945CE3B09_impl*
end;//TkwEnConfigurationListTvConfs.SetValuePrim

function TkwEnConfigurationListTvConfs.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnConfigurationListTvConfs.GetResultTypeInfo

function TkwEnConfigurationListTvConfs.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnConfigurationListTvConfs.GetAllParamsCount

function TkwEnConfigurationListTvConfs.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnConfigurationListTvConfs.ParamsTypes

initialization
 Tkw_Form_ConfigurationList.RegisterInEngine;
 {* Регистрация Tkw_Form_ConfigurationList }
 Tkw_ConfigurationList_Control_tvConfs.RegisterInEngine;
 {* Регистрация Tkw_ConfigurationList_Control_tvConfs }
 Tkw_ConfigurationList_Control_tvConfs_Push.RegisterInEngine;
 {* Регистрация Tkw_ConfigurationList_Control_tvConfs_Push }
 TkwEnConfigurationListTvConfs.RegisterInEngine;
 {* Регистрация en_ConfigurationList_tvConfs }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_ConfigurationList));
 {* Регистрация типа ConfigurationList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
