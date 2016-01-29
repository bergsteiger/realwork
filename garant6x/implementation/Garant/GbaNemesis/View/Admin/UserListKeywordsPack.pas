unit UserListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/UserListKeywordsPack.pas"
// �����: 07.09.2009 18:00
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 �������������::Admin::View::Admin::Admin::UserListKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� UserList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  eeTreeView
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  vtPanel,
  UserList_Form,
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
  tfwTypeRegistrator
  ;

type
  Tkw_Form_UserList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� UserList
----
*������ �������������*:
[code]
'aControl' �����::UserList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_UserList

// start class Tkw_Form_UserList

class function Tkw_Form_UserList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::UserList';
end;//Tkw_Form_UserList.GetWordNameForRegister

function Tkw_Form_UserList.GetString: AnsiString;
 {-}
begin
 Result := 'efUserList';
end;//Tkw_Form_UserList.GetString

type
  Tkw_UserList_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserList_Control_BackgroundPanel

// start class Tkw_UserList_Control_BackgroundPanel

class function Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_UserList_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetString

class procedure Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_UserList_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_UserList_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserList_Control_BackgroundPanel_Push

// start class Tkw_UserList_Control_BackgroundPanel_Push

procedure Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_UserList_Control_ContextFilter = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserList_Control_ContextFilter

// start class Tkw_UserList_Control_ContextFilter

class function Tkw_UserList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetWordNameForRegister

function Tkw_UserList_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetString

class procedure Tkw_UserList_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_UserList_Control_ContextFilter.RegisterInEngine

type
  Tkw_UserList_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserList_Control_ContextFilter_Push

// start class Tkw_UserList_Control_ContextFilter_Push

procedure Tkw_UserList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_UserList_Control_ContextFilter_Push.DoDoIt

class function Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_UserList_Control_trUserList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� trUserList
----
*������ �������������*:
[code]
�������::trUserList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_UserList_Control_trUserList

// start class Tkw_UserList_Control_trUserList

class function Tkw_UserList_Control_trUserList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::trUserList';
end;//Tkw_UserList_Control_trUserList.GetWordNameForRegister

function Tkw_UserList_Control_trUserList.GetString: AnsiString;
 {-}
begin
 Result := 'trUserList';
end;//Tkw_UserList_Control_trUserList.GetString

class procedure Tkw_UserList_Control_trUserList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_UserList_Control_trUserList.RegisterInEngine

type
  Tkw_UserList_Control_trUserList_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� trUserList
----
*������ �������������*:
[code]
�������::trUserList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_UserList_Control_trUserList_Push

// start class Tkw_UserList_Control_trUserList_Push

procedure Tkw_UserList_Control_trUserList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('trUserList');
 inherited;
end;//Tkw_UserList_Control_trUserList_Push.DoDoIt

class function Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::trUserList:push';
end;//Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister

type
  TkwEfUserListBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserList.BackgroundPanel
[panel]������� BackgroundPanel ����� TefUserList[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserList .TefUserList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aefUserList: TefUserList): TvtPanel;
     {* ���������� ����� ������� .TefUserList.BackgroundPanel }
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
  end;//TkwEfUserListBackgroundPanel

// start class TkwEfUserListBackgroundPanel

function TkwEfUserListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aefUserList: TefUserList): TvtPanel;
 {-}
begin
 Result := aefUserList.BackgroundPanel;
end;//TkwEfUserListBackgroundPanel.BackgroundPanel

procedure TkwEfUserListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserList : TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aefUserList)));
end;//TkwEfUserListBackgroundPanel.DoDoIt

class function TkwEfUserListBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserList.BackgroundPanel';
end;//TkwEfUserListBackgroundPanel.GetWordNameForRegister

procedure TkwEfUserListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEfUserListBackgroundPanel.SetValuePrim

function TkwEfUserListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEfUserListBackgroundPanel.GetResultTypeInfo

function TkwEfUserListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserListBackgroundPanel.GetAllParamsCount

function TkwEfUserListBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListBackgroundPanel.ParamsTypes

type
  TkwEfUserListContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserList.ContextFilter
[panel]������� ContextFilter ����� TefUserList[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aefUserList .TefUserList.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aefUserList: TefUserList): TnscContextFilter;
     {* ���������� ����� ������� .TefUserList.ContextFilter }
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
  end;//TkwEfUserListContextFilter

// start class TkwEfUserListContextFilter

function TkwEfUserListContextFilter.ContextFilter(const aCtx: TtfwContext;
  aefUserList: TefUserList): TnscContextFilter;
 {-}
begin
 Result := aefUserList.ContextFilter;
end;//TkwEfUserListContextFilter.ContextFilter

procedure TkwEfUserListContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserList : TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aefUserList)));
end;//TkwEfUserListContextFilter.DoDoIt

class function TkwEfUserListContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserList.ContextFilter';
end;//TkwEfUserListContextFilter.GetWordNameForRegister

procedure TkwEfUserListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEfUserListContextFilter.SetValuePrim

function TkwEfUserListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwEfUserListContextFilter.GetResultTypeInfo

function TkwEfUserListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserListContextFilter.GetAllParamsCount

function TkwEfUserListContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListContextFilter.ParamsTypes

type
  TkwEfUserListTrUserList = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefUserList.trUserList
[panel]������� trUserList ����� TefUserList[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aefUserList .TefUserList.trUserList >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TrUserList(const aCtx: TtfwContext;
     aefUserList: TefUserList): TeeTreeView;
     {* ���������� ����� ������� .TefUserList.trUserList }
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
  end;//TkwEfUserListTrUserList

// start class TkwEfUserListTrUserList

function TkwEfUserListTrUserList.TrUserList(const aCtx: TtfwContext;
  aefUserList: TefUserList): TeeTreeView;
 {-}
begin
 Result := aefUserList.trUserList;
end;//TkwEfUserListTrUserList.TrUserList

procedure TkwEfUserListTrUserList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefUserList : TefUserList;
begin
 try
  l_aefUserList := TefUserList(aCtx.rEngine.PopObjAs(TefUserList));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefUserList: TefUserList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((TrUserList(aCtx, l_aefUserList)));
end;//TkwEfUserListTrUserList.DoDoIt

class function TkwEfUserListTrUserList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefUserList.trUserList';
end;//TkwEfUserListTrUserList.GetWordNameForRegister

procedure TkwEfUserListTrUserList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� trUserList', aCtx);
end;//TkwEfUserListTrUserList.SetValuePrim

function TkwEfUserListTrUserList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEfUserListTrUserList.GetResultTypeInfo

function TkwEfUserListTrUserList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfUserListTrUserList.GetAllParamsCount

function TkwEfUserListTrUserList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefUserList)]);
end;//TkwEfUserListTrUserList.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_Form_UserList
 Tkw_Form_UserList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_BackgroundPanel
 Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_BackgroundPanel_Push
 Tkw_UserList_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_ContextFilter
 Tkw_UserList_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_ContextFilter_Push
 Tkw_UserList_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_trUserList
 Tkw_UserList_Control_trUserList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� Tkw_UserList_Control_trUserList_Push
 Tkw_UserList_Control_trUserList_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserList_BackgroundPanel
 TkwEfUserListBackgroundPanel.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserList_ContextFilter
 TkwEfUserListContextFilter.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� efUserList_trUserList
 TkwEfUserListTrUserList.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� UserList
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserList));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //Admin AND not NoScripts

end.