unit GroupListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/GroupListKeywordsPack.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Администратор::Admin::View::Admin::Admin::GroupListKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы GroupList
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  eeTreeView,
  vtPanel,
  GroupList_Form,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator,
  l3Base {a},
  vcmBase {a},
  StdRes {a}
  ;

type
  Tkw_Form_GroupList = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы GroupList
----
*Пример использования*:
[code]
'aControl' форма::GroupList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_GroupList

// start class Tkw_Form_GroupList

class function Tkw_Form_GroupList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::GroupList';
end;//Tkw_Form_GroupList.GetWordNameForRegister

function Tkw_Form_GroupList.GetString: AnsiString;
 {-}
begin
 Result := 'efGroupList';
end;//Tkw_Form_GroupList.GetString

type
  Tkw_GroupList_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_GroupList_Control_BackgroundPanel

// start class Tkw_GroupList_Control_BackgroundPanel

class function Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_GroupList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_GroupList_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_GroupList_Control_BackgroundPanel.GetString

class procedure Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_GroupList_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_GroupList_Control_BackgroundPanel_Push

// start class Tkw_GroupList_Control_BackgroundPanel_Push

procedure Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_GroupList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_GroupList_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_GroupList_Control_GroupsTree = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола GroupsTree
----
*Пример использования*:
[code]
контрол::GroupsTree TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_GroupList_Control_GroupsTree

// start class Tkw_GroupList_Control_GroupsTree

class function Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::GroupsTree';
end;//Tkw_GroupList_Control_GroupsTree.GetWordNameForRegister

function Tkw_GroupList_Control_GroupsTree.GetString: AnsiString;
 {-}
begin
 Result := 'GroupsTree';
end;//Tkw_GroupList_Control_GroupsTree.GetString

class procedure Tkw_GroupList_Control_GroupsTree.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_GroupList_Control_GroupsTree.RegisterInEngine

type
  Tkw_GroupList_Control_GroupsTree_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола GroupsTree
----
*Пример использования*:
[code]
контрол::GroupsTree:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_GroupList_Control_GroupsTree_Push

// start class Tkw_GroupList_Control_GroupsTree_Push

procedure Tkw_GroupList_Control_GroupsTree_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('GroupsTree');
 inherited;
end;//Tkw_GroupList_Control_GroupsTree_Push.DoDoIt

class function Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::GroupsTree:push';
end;//Tkw_GroupList_Control_GroupsTree_Push.GetWordNameForRegister

type
  TkwEfGroupListBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefGroupList.BackgroundPanel
[panel]Контрол BackgroundPanel формы TefGroupList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefGroupList .TefGroupList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aefGroupList: TefGroupList): TvtPanel;
     {* Реализация слова скрипта .TefGroupList.BackgroundPanel }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfGroupListBackgroundPanel

// start class TkwEfGroupListBackgroundPanel

function TkwEfGroupListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aefGroupList: TefGroupList): TvtPanel;
 {-}
begin
 Result := aefGroupList.BackgroundPanel;
end;//TkwEfGroupListBackgroundPanel.BackgroundPanel

procedure TkwEfGroupListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupList : TefGroupList;
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
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aefGroupList)));
end;//TkwEfGroupListBackgroundPanel.DoDoIt

class function TkwEfGroupListBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupList.BackgroundPanel';
end;//TkwEfGroupListBackgroundPanel.GetWordNameForRegister

procedure TkwEfGroupListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEfGroupListBackgroundPanel.SetValuePrim

function TkwEfGroupListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfGroupListBackgroundPanel.GetResultTypeInfo

function TkwEfGroupListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupListBackgroundPanel.GetAllParamsCount

function TkwEfGroupListBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupList)]);
end;//TkwEfGroupListBackgroundPanel.ParamsTypes

type
  TkwEfGroupListGroupsTree = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefGroupList.GroupsTree
[panel]Контрол GroupsTree формы TefGroupList[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aefGroupList .TefGroupList.GroupsTree >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function GroupsTree(const aCtx: TtfwContext;
     aefGroupList: TefGroupList): TeeTreeView;
     {* Реализация слова скрипта .TefGroupList.GroupsTree }
  protected
  // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  public
  // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
  end;//TkwEfGroupListGroupsTree

// start class TkwEfGroupListGroupsTree

function TkwEfGroupListGroupsTree.GroupsTree(const aCtx: TtfwContext;
  aefGroupList: TefGroupList): TeeTreeView;
 {-}
begin
 Result := aefGroupList.GroupsTree;
end;//TkwEfGroupListGroupsTree.GroupsTree

procedure TkwEfGroupListGroupsTree.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefGroupList : TefGroupList;
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
 aCtx.rEngine.PushObj((GroupsTree(aCtx, l_aefGroupList)));
end;//TkwEfGroupListGroupsTree.DoDoIt

class function TkwEfGroupListGroupsTree.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefGroupList.GroupsTree';
end;//TkwEfGroupListGroupsTree.GetWordNameForRegister

procedure TkwEfGroupListGroupsTree.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству GroupsTree', aCtx);
end;//TkwEfGroupListGroupsTree.SetValuePrim

function TkwEfGroupListGroupsTree.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEfGroupListGroupsTree.GetResultTypeInfo

function TkwEfGroupListGroupsTree.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfGroupListGroupsTree.GetAllParamsCount

function TkwEfGroupListGroupsTree.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefGroupList)]);
end;//TkwEfGroupListGroupsTree.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_GroupList
 Tkw_Form_GroupList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupList_Control_BackgroundPanel
 Tkw_GroupList_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupList_Control_BackgroundPanel_Push
 Tkw_GroupList_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupList_Control_GroupsTree
 Tkw_GroupList_Control_GroupsTree.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_GroupList_Control_GroupsTree_Push
 Tkw_GroupList_Control_GroupsTree_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efGroupList_BackgroundPanel
 TkwEfGroupListBackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efGroupList_GroupsTree
 TkwEfGroupListGroupsTree.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа GroupList
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefGroupList));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //Admin AND not NoScripts

end.