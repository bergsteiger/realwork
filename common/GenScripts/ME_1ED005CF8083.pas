unit FoldersTreeKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы FoldersTree }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Folders\FoldersTreeKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimFolders_Module
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
 Tkw_Form_FoldersTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы FoldersTree
----
*Пример использования*:
[code]
'aControl' форма::FoldersTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_FoldersTree_Control_FoldersTree

 Tkw_FoldersTree_Control_FoldersTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FoldersTree
----
*Пример использования*:
[code]
контрол::FoldersTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_FoldersTree_Control_FoldersTree_Push

 TkwEnFoldersTreeFoldersTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenFoldersTree.FoldersTree
[panel]Контрол FoldersTree формы TenFoldersTree[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aenFoldersTree .TenFoldersTree.FoldersTree >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function FoldersTree(const aCtx: TtfwContext;
    aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TenFoldersTree.FoldersTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnFoldersTreeFoldersTree

class function Tkw_Form_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::FoldersTree';
end;//Tkw_Form_FoldersTree.GetWordNameForRegister

function Tkw_Form_FoldersTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C806163015DD_var*
//#UC END# *4DDFD2EA0116_C806163015DD_var*
begin
//#UC START# *4DDFD2EA0116_C806163015DD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C806163015DD_impl*
end;//Tkw_Form_FoldersTree.GetString

class function Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoldersTree';
end;//Tkw_FoldersTree_Control_FoldersTree.GetWordNameForRegister

function Tkw_FoldersTree_Control_FoldersTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_93FE3A926428_var*
//#UC END# *4DDFD2EA0116_93FE3A926428_var*
begin
//#UC START# *4DDFD2EA0116_93FE3A926428_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_93FE3A926428_impl*
end;//Tkw_FoldersTree_Control_FoldersTree.GetString

class procedure Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
//#UC START# *52A086150180_93FE3A926428_var*
//#UC END# *52A086150180_93FE3A926428_var*
begin
//#UC START# *52A086150180_93FE3A926428_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_93FE3A926428_impl*
end;//Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine

procedure Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_EF0DEE51AEA8_var*
//#UC END# *4DAEEDE10285_EF0DEE51AEA8_var*
begin
//#UC START# *4DAEEDE10285_EF0DEE51AEA8_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_EF0DEE51AEA8_impl*
end;//Tkw_FoldersTree_Control_FoldersTree_Push.DoDoIt

class function Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FoldersTree:push';
end;//Tkw_FoldersTree_Control_FoldersTree_Push.GetWordNameForRegister

function TkwEnFoldersTreeFoldersTree.FoldersTree(const aCtx: TtfwContext;
 aenFoldersTree: TenFoldersTree): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TenFoldersTree.FoldersTree }
//#UC START# *3DBC8AEEF2BE_6BEE06997D28_var*
//#UC END# *3DBC8AEEF2BE_6BEE06997D28_var*
begin
//#UC START# *3DBC8AEEF2BE_6BEE06997D28_impl*
 !!! Needs to be implemented !!!
//#UC END# *3DBC8AEEF2BE_6BEE06997D28_impl*
end;//TkwEnFoldersTreeFoldersTree.FoldersTree

procedure TkwEnFoldersTreeFoldersTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6BEE06997D28_var*
//#UC END# *4DAEEDE10285_6BEE06997D28_var*
begin
//#UC START# *4DAEEDE10285_6BEE06997D28_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6BEE06997D28_impl*
end;//TkwEnFoldersTreeFoldersTree.DoDoIt

class function TkwEnFoldersTreeFoldersTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenFoldersTree.FoldersTree';
end;//TkwEnFoldersTreeFoldersTree.GetWordNameForRegister

procedure TkwEnFoldersTreeFoldersTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwEnFoldersTreeFoldersTree.SetValuePrim

function TkwEnFoldersTreeFoldersTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwEnFoldersTreeFoldersTree.GetResultTypeInfo

function TkwEnFoldersTreeFoldersTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnFoldersTreeFoldersTree.GetAllParamsCount

function TkwEnFoldersTreeFoldersTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnFoldersTreeFoldersTree.ParamsTypes

initialization
 Tkw_Form_FoldersTree.RegisterInEngine;
 {* Регистрация Tkw_Form_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree.RegisterInEngine;
 {* Регистрация Tkw_FoldersTree_Control_FoldersTree }
 Tkw_FoldersTree_Control_FoldersTree_Push.RegisterInEngine;
 {* Регистрация Tkw_FoldersTree_Control_FoldersTree_Push }
 TkwEnFoldersTreeFoldersTree.RegisterInEngine;
 {* Регистрация enFoldersTree_FoldersTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenFoldersTree));
 {* Регистрация типа FoldersTree }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
