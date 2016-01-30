unit GroupListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы GroupList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\GroupListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 , vtPanel
 , eeTreeView
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_GroupList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы GroupList
----
*Пример использования*:
[code]
'aControl' форма::GroupList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_GroupList

 Tkw_GroupList_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_GroupList_Control_BackgroundPanel

 Tkw_GroupList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupList_Control_BackgroundPanel_Push

 Tkw_GroupList_Control_GroupsTree = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола GroupsTree
----
*Пример использования*:
[code]
контрол::GroupsTree TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_GroupList_Control_GroupsTree

 Tkw_GroupList_Control_GroupsTree_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола GroupsTree
----
*Пример использования*:
[code]
контрол::GroupsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupList_Control_GroupsTree_Push

 TkwEfGroupListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefGroupList.BackgroundPanel
[panel]Контрол BackgroundPanel формы TefGroupList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefGroupList .TefGroupList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefGroupList: TefGroupList): TvtPanel;
    {* Реализация слова скрипта .TefGroupList.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfGroupListBackgroundPanel

 TkwEfGroupListGroupsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefGroupList.GroupsTree
[panel]Контрол GroupsTree формы TefGroupList[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aefGroupList .TefGroupList.GroupsTree >>> l_TeeTreeView
[code]  }
  private
   function GroupsTree(const aCtx: TtfwContext;
    aefGroupList: TefGroupList): TeeTreeView;
    {* Реализация слова скрипта .TefGroupList.GroupsTree }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfGroupListGroupsTree

class function Tkw_Form_GroupList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::GroupList';
end;//Tkw_Form_GroupList.GetWordNameForRegister

function Tkw_Form_GroupList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B88D22ADD23E_var*
//#UC END# *4DDFD2EA0116_B88D22ADD23E_var*
begin
//#UC START# *4DDFD2EA0116_B88D22ADD23E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B88D22ADD23E_impl*
end;//Tkw_Form_GroupList.GetString

class function Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_GroupList_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_CA886BB3DD53_var*
//#UC END# *4DDFD2EA0116_CA886BB3DD53_var*
begin
//#UC START# *4DDFD2EA0116_CA886BB3DD53_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_CA886BB3DD53_impl*
end;//Tkw_GroupList_Control_BackgroundPanel.GetString

class procedure Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_CA886BB3DD53_var*
//#UC END# *52A086150180_CA886BB3DD53_var*
begin
//#UC START# *52A086150180_CA886BB3DD53_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_CA886BB3DD53_impl*
end;//Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9A620B3E059C_var*
//#UC END# *4DAEEDE10285_9A620B3E059C_var*
begin
//#UC START# *4DAEEDE10285_9A620B3E059C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9A620B3E059C_impl*
end;//Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupsTree';
end;//Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister

function Tkw_GroupList_Control_GroupsTree.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F19187841A8C_var*
//#UC END# *4DDFD2EA0116_F19187841A8C_var*
begin
//#UC START# *4DDFD2EA0116_F19187841A8C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F19187841A8C_impl*
end;//Tkw_GroupList_Control_GroupsTree.GetString

class procedure Tkw_GroupList_Control_GroupsTree.RegisterInEngine;
//#UC START# *52A086150180_F19187841A8C_var*
//#UC END# *52A086150180_F19187841A8C_var*
begin
//#UC START# *52A086150180_F19187841A8C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F19187841A8C_impl*
end;//Tkw_GroupList_Control_GroupsTree.RegisterInEngine

procedure Tkw_GroupList_Control_GroupsTree_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C8C02444396B_var*
//#UC END# *4DAEEDE10285_C8C02444396B_var*
begin
//#UC START# *4DAEEDE10285_C8C02444396B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C8C02444396B_impl*
end;//Tkw_GroupList_Control_GroupsTree_Push.DoDoIt

class function Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupsTree:push';
end;//Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister

function TkwEfGroupListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefGroupList: TefGroupList): TvtPanel;
 {* Реализация слова скрипта .TefGroupList.BackgroundPanel }
//#UC START# *68F14766C616_6BCC2CEE5EC2_var*
//#UC END# *68F14766C616_6BCC2CEE5EC2_var*
begin
//#UC START# *68F14766C616_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *68F14766C616_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.BackgroundPanel

procedure TkwEfGroupListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6BCC2CEE5EC2_var*
//#UC END# *4DAEEDE10285_6BCC2CEE5EC2_var*
begin
//#UC START# *4DAEEDE10285_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.DoDoIt

class function TkwEfGroupListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupList.BackgroundPanel';
end;//TkwEfGroupListBackgroundPanel.GetWordNameForRegister

procedure TkwEfGroupListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6BCC2CEE5EC2_var*
//#UC END# *52D00B00031A_6BCC2CEE5EC2_var*
begin
//#UC START# *52D00B00031A_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.SetValuePrim

function TkwEfGroupListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6BCC2CEE5EC2_var*
//#UC END# *551544E2001A_6BCC2CEE5EC2_var*
begin
//#UC START# *551544E2001A_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.GetResultTypeInfo

function TkwEfGroupListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_6BCC2CEE5EC2_var*
//#UC END# *559687E6025A_6BCC2CEE5EC2_var*
begin
//#UC START# *559687E6025A_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.GetAllParamsCount

function TkwEfGroupListBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6BCC2CEE5EC2_var*
//#UC END# *5617F4D00243_6BCC2CEE5EC2_var*
begin
//#UC START# *5617F4D00243_6BCC2CEE5EC2_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6BCC2CEE5EC2_impl*
end;//TkwEfGroupListBackgroundPanel.ParamsTypes

function TkwEfGroupListGroupsTree.GroupsTree(const aCtx: TtfwContext;
 aefGroupList: TefGroupList): TeeTreeView;
 {* Реализация слова скрипта .TefGroupList.GroupsTree }
//#UC START# *9DA094A70502_682D3079A453_var*
//#UC END# *9DA094A70502_682D3079A453_var*
begin
//#UC START# *9DA094A70502_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *9DA094A70502_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.GroupsTree

procedure TkwEfGroupListGroupsTree.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_682D3079A453_var*
//#UC END# *4DAEEDE10285_682D3079A453_var*
begin
//#UC START# *4DAEEDE10285_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.DoDoIt

class function TkwEfGroupListGroupsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupList.GroupsTree';
end;//TkwEfGroupListGroupsTree.GetWordNameForRegister

procedure TkwEfGroupListGroupsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_682D3079A453_var*
//#UC END# *52D00B00031A_682D3079A453_var*
begin
//#UC START# *52D00B00031A_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.SetValuePrim

function TkwEfGroupListGroupsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_682D3079A453_var*
//#UC END# *551544E2001A_682D3079A453_var*
begin
//#UC START# *551544E2001A_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.GetResultTypeInfo

function TkwEfGroupListGroupsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_682D3079A453_var*
//#UC END# *559687E6025A_682D3079A453_var*
begin
//#UC START# *559687E6025A_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.GetAllParamsCount

function TkwEfGroupListGroupsTree.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_682D3079A453_var*
//#UC END# *5617F4D00243_682D3079A453_var*
begin
//#UC START# *5617F4D00243_682D3079A453_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_682D3079A453_impl*
end;//TkwEfGroupListGroupsTree.ParamsTypes

initialization
 Tkw_Form_GroupList.RegisterInEngine;
 {* Регистрация Tkw_Form_GroupList }
 Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_GroupList_Control_BackgroundPanel }
 Tkw_GroupList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_GroupList_Control_BackgroundPanel_Push }
 Tkw_GroupList_Control_GroupsTree.RegisterInEngine;
 {* Регистрация Tkw_GroupList_Control_GroupsTree }
 Tkw_GroupList_Control_GroupsTree_Push.RegisterInEngine;
 {* Регистрация Tkw_GroupList_Control_GroupsTree_Push }
 TkwEfGroupListBackgroundPanel.RegisterInEngine;
 {* Регистрация efGroupList_BackgroundPanel }
 TkwEfGroupListGroupsTree.RegisterInEngine;
 {* Регистрация efGroupList_GroupsTree }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupList));
 {* Регистрация типа GroupList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
