unit GroupListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы GroupList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\GroupListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "GroupListKeywordsPack" MUID: (4A5C120B9AE0)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 , eeTreeView
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , GroupList_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_GroupList

 Tkw_GroupList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupList_Control_BackgroundPanel

 Tkw_GroupList_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_GroupList_Control_GroupsTree

 Tkw_GroupList_Control_GroupsTree_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* Слово скрипта .TefGroupList.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefGroupList: TefGroupList): TvtPanel;
    {* Реализация слова скрипта .TefGroupList.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupListBackgroundPanel

 TkwEfGroupListGroupsTree = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefGroupList.GroupsTree }
  private
   function GroupsTree(const aCtx: TtfwContext;
    aefGroupList: TefGroupList): TeeTreeView;
    {* Реализация слова скрипта .TefGroupList.GroupsTree }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfGroupListGroupsTree

function Tkw_Form_GroupList.GetString: AnsiString;
begin
 Result := 'efGroupList';
end;//Tkw_Form_GroupList.GetString

class function Tkw_Form_GroupList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::GroupList';
end;//Tkw_Form_GroupList.GetWordNameForRegister

function Tkw_GroupList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_GroupList_Control_BackgroundPanel.GetString

class procedure Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_GroupList_Control_GroupsTree.GetString: AnsiString;
begin
 Result := 'GroupsTree';
end;//Tkw_GroupList_Control_GroupsTree.GetString

class procedure Tkw_GroupList_Control_GroupsTree.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_GroupList_Control_GroupsTree.RegisterInEngine

class function Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupsTree';
end;//Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister

procedure Tkw_GroupList_Control_GroupsTree_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('GroupsTree');
 inherited;
end;//Tkw_GroupList_Control_GroupsTree_Push.DoDoIt

class function Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::GroupsTree:push';
end;//Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister

function TkwEfGroupListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefGroupList: TefGroupList): TvtPanel;
 {* Реализация слова скрипта .TefGroupList.BackgroundPanel }
begin
 Result := aefGroupList.BackgroundPanel;
end;//TkwEfGroupListBackgroundPanel.BackgroundPanel

class function TkwEfGroupListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupList.BackgroundPanel';
end;//TkwEfGroupListBackgroundPanel.GetWordNameForRegister

function TkwEfGroupListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfGroupListBackgroundPanel.GetResultTypeInfo

function TkwEfGroupListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupListBackgroundPanel.GetAllParamsCount

function TkwEfGroupListBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupList)]);
end;//TkwEfGroupListBackgroundPanel.ParamsTypes

procedure TkwEfGroupListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEfGroupListBackgroundPanel.SetValuePrim

procedure TkwEfGroupListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupList: TefGroupList;
begin
 try
  l_aefGroupList := TefGroupList(aCtx.rEngine.PopObjAs(TefGroupList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefGroupList: TefGroupList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aefGroupList));
end;//TkwEfGroupListBackgroundPanel.DoDoIt

function TkwEfGroupListGroupsTree.GroupsTree(const aCtx: TtfwContext;
 aefGroupList: TefGroupList): TeeTreeView;
 {* Реализация слова скрипта .TefGroupList.GroupsTree }
begin
 Result := aefGroupList.GroupsTree;
end;//TkwEfGroupListGroupsTree.GroupsTree

class function TkwEfGroupListGroupsTree.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefGroupList.GroupsTree';
end;//TkwEfGroupListGroupsTree.GetWordNameForRegister

function TkwEfGroupListGroupsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEfGroupListGroupsTree.GetResultTypeInfo

function TkwEfGroupListGroupsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfGroupListGroupsTree.GetAllParamsCount

function TkwEfGroupListGroupsTree.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupList)]);
end;//TkwEfGroupListGroupsTree.ParamsTypes

procedure TkwEfGroupListGroupsTree.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству GroupsTree', aCtx);
end;//TkwEfGroupListGroupsTree.SetValuePrim

procedure TkwEfGroupListGroupsTree.DoDoIt(const aCtx: TtfwContext);
var l_aefGroupList: TefGroupList;
begin
 try
  l_aefGroupList := TefGroupList(aCtx.rEngine.PopObjAs(TefGroupList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefGroupList: TefGroupList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GroupsTree(aCtx, l_aefGroupList));
end;//TkwEfGroupListGroupsTree.DoDoIt

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupList));
 {* Регистрация типа TefGroupList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
