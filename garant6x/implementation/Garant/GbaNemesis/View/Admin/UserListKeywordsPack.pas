unit UserListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы UserList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\UserListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "UserListKeywordsPack" MUID: (551DFEBFD5FA)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , UserList_Form
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
 Tkw_Form_UserList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы UserList
----
*Пример использования*:
[code]
'aControl' форма::UserList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UserList

 Tkw_UserList_Control_BackgroundPanel = {final} class(TtfwControlString)
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
 end;//Tkw_UserList_Control_BackgroundPanel

 Tkw_UserList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_BackgroundPanel_Push

 Tkw_UserList_Control_ContextFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_ContextFilter

 Tkw_UserList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ContextFilter
----
*Пример использования*:
[code]
контрол::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_ContextFilter_Push

 Tkw_UserList_Control_trUserList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола trUserList
----
*Пример использования*:
[code]
контрол::trUserList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_trUserList

 Tkw_UserList_Control_trUserList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола trUserList
----
*Пример использования*:
[code]
контрол::trUserList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_trUserList_Push

 TkwEfUserListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserList.BackgroundPanel
[panel]Контрол BackgroundPanel формы TefUserList[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aefUserList .TefUserList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefUserList: TefUserList): TvtPanel;
    {* Реализация слова скрипта .TefUserList.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserListBackgroundPanel

 TkwEfUserListContextFilter = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserList.ContextFilter
[panel]Контрол ContextFilter формы TefUserList[panel]
*Тип результата:* TnscContextFilter
*Пример:*
[code]
OBJECT VAR l_TnscContextFilter
 aefUserList .TefUserList.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefUserList: TefUserList): TnscContextFilter;
    {* Реализация слова скрипта .TefUserList.ContextFilter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserListContextFilter

 TkwEfUserListTrUserList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefUserList.trUserList
[panel]Контрол trUserList формы TefUserList[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aefUserList .TefUserList.trUserList >>> l_TeeTreeView
[code]  }
  private
   function trUserList(const aCtx: TtfwContext;
    aefUserList: TefUserList): TeeTreeView;
    {* Реализация слова скрипта .TefUserList.trUserList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfUserListTrUserList

function Tkw_Form_UserList.GetString: AnsiString;
begin
 Result := 'efUserList';
end;//Tkw_Form_UserList.GetString

class function Tkw_Form_UserList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::UserList';
end;//Tkw_Form_UserList.GetWordNameForRegister

function Tkw_UserList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetString

class procedure Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_UserList_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetString

class procedure Tkw_UserList_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_UserList_Control_ContextFilter.RegisterInEngine

class function Tkw_UserList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_UserList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_UserList_Control_ContextFilter_Push.DoDoIt

class function Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ContextFilter:push';
end;//Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_UserList_Control_trUserList.GetString: AnsiString;
begin
 Result := 'trUserList';
end;//Tkw_UserList_Control_trUserList.GetString

class procedure Tkw_UserList_Control_trUserList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_UserList_Control_trUserList.RegisterInEngine

class function Tkw_UserList_Control_trUserList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trUserList';
end;//Tkw_UserList_Control_trUserList.GetWordNameForRegister

procedure Tkw_UserList_Control_trUserList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('trUserList');
 inherited;
end;//Tkw_UserList_Control_trUserList_Push.DoDoIt

class function Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::trUserList:push';
end;//Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister

function TkwEfUserListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefUserList: TefUserList): TvtPanel;
 {* Реализация слова скрипта .TefUserList.BackgroundPanel }
begin
 Result := aefUserList.BackgroundPanel;
end;//TkwEfUserListBackgroundPanel.BackgroundPanel

procedure TkwEfUserListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aefUserList));
end;//TkwEfUserListBackgroundPanel.DoDoIt

procedure TkwEfUserListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwEfUserListBackgroundPanel.SetValuePrim

function TkwEfUserListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserListBackgroundPanel.GetResultTypeInfo

function TkwEfUserListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserListBackgroundPanel.GetAllParamsCount

function TkwEfUserListBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListBackgroundPanel.ParamsTypes

class function TkwEfUserListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.BackgroundPanel';
end;//TkwEfUserListBackgroundPanel.GetWordNameForRegister

function TkwEfUserListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefUserList: TefUserList): TnscContextFilter;
 {* Реализация слова скрипта .TefUserList.ContextFilter }
begin
 Result := aefUserList.ContextFilter;
end;//TkwEfUserListContextFilter.ContextFilter

procedure TkwEfUserListContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aefUserList));
end;//TkwEfUserListContextFilter.DoDoIt

procedure TkwEfUserListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ContextFilter', aCtx);
end;//TkwEfUserListContextFilter.SetValuePrim

function TkwEfUserListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfUserListContextFilter.GetResultTypeInfo

function TkwEfUserListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserListContextFilter.GetAllParamsCount

function TkwEfUserListContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListContextFilter.ParamsTypes

class function TkwEfUserListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.ContextFilter';
end;//TkwEfUserListContextFilter.GetWordNameForRegister

function TkwEfUserListTrUserList.trUserList(const aCtx: TtfwContext;
 aefUserList: TefUserList): TeeTreeView;
 {* Реализация слова скрипта .TefUserList.trUserList }
begin
 Result := aefUserList.trUserList;
end;//TkwEfUserListTrUserList.trUserList

procedure TkwEfUserListTrUserList.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(trUserList(aCtx, l_aefUserList));
end;//TkwEfUserListTrUserList.DoDoIt

procedure TkwEfUserListTrUserList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству trUserList', aCtx);
end;//TkwEfUserListTrUserList.SetValuePrim

function TkwEfUserListTrUserList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEfUserListTrUserList.GetResultTypeInfo

function TkwEfUserListTrUserList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfUserListTrUserList.GetAllParamsCount

function TkwEfUserListTrUserList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListTrUserList.ParamsTypes

class function TkwEfUserListTrUserList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.trUserList';
end;//TkwEfUserListTrUserList.GetWordNameForRegister

initialization
 Tkw_Form_UserList.RegisterInEngine;
 {* Регистрация Tkw_Form_UserList }
 Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_BackgroundPanel }
 Tkw_UserList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_BackgroundPanel_Push }
 Tkw_UserList_Control_ContextFilter.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_ContextFilter }
 Tkw_UserList_Control_ContextFilter_Push.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_ContextFilter_Push }
 Tkw_UserList_Control_trUserList.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_trUserList }
 Tkw_UserList_Control_trUserList_Push.RegisterInEngine;
 {* Регистрация Tkw_UserList_Control_trUserList_Push }
 TkwEfUserListBackgroundPanel.RegisterInEngine;
 {* Регистрация efUserList_BackgroundPanel }
 TkwEfUserListContextFilter.RegisterInEngine;
 {* Регистрация efUserList_ContextFilter }
 TkwEfUserListTrUserList.RegisterInEngine;
 {* Регистрация efUserList_trUserList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserList));
 {* Регистрация типа UserList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* Регистрация типа TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
