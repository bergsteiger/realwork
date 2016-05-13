unit UserListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UserList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\UserListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "UserListKeywordsPack" MUID: (551DFEBFD5FA)

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
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 Tkw_Form_UserList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� UserList
----
*������ �������������*:
[code]
'aControl' �����::UserList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_UserList

 Tkw_UserList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_BackgroundPanel

 Tkw_UserList_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_BackgroundPanel_Push

 Tkw_UserList_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_ContextFilter

 Tkw_UserList_Control_ContextFilter_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]
�������::ContextFilter:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_ContextFilter_Push

 Tkw_UserList_Control_trUserList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� trUserList
----
*������ �������������*:
[code]
�������::trUserList TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_trUserList

 Tkw_UserList_Control_trUserList_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� trUserList
----
*������ �������������*:
[code]
�������::trUserList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_UserList_Control_trUserList_Push

 TkwEfUserListBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefUserList.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefUserList: TefUserList): TvtPanel;
    {* ���������� ����� ������� .TefUserList.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserListBackgroundPanel

 TkwEfUserListContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefUserList.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefUserList: TefUserList): TnscContextFilter;
    {* ���������� ����� ������� .TefUserList.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserListContextFilter

 TkwEfUserListTrUserList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefUserList.trUserList }
  private
   function trUserList(const aCtx: TtfwContext;
    aefUserList: TefUserList): TeeTreeView;
    {* ���������� ����� ������� .TefUserList.trUserList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfUserListTrUserList

function Tkw_Form_UserList.GetString: AnsiString;
begin
 Result := 'efUserList';
end;//Tkw_Form_UserList.GetString

class function Tkw_Form_UserList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserList';
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
 Result := '�������::BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
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
 Result := '�������::ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_UserList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_UserList_Control_ContextFilter_Push.DoDoIt

class function Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
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
 Result := '�������::trUserList';
end;//Tkw_UserList_Control_trUserList.GetWordNameForRegister

procedure Tkw_UserList_Control_trUserList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('trUserList');
 inherited;
end;//Tkw_UserList_Control_trUserList_Push.DoDoIt

class function Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::trUserList:push';
end;//Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister

function TkwEfUserListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefUserList: TefUserList): TvtPanel;
 {* ���������� ����� ������� .TefUserList.BackgroundPanel }
begin
 Result := aefUserList.BackgroundPanel;
end;//TkwEfUserListBackgroundPanel.BackgroundPanel

class function TkwEfUserListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.BackgroundPanel';
end;//TkwEfUserListBackgroundPanel.GetWordNameForRegister

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

procedure TkwEfUserListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwEfUserListBackgroundPanel.SetValuePrim

procedure TkwEfUserListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
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
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aefUserList));
end;//TkwEfUserListBackgroundPanel.DoDoIt

function TkwEfUserListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefUserList: TefUserList): TnscContextFilter;
 {* ���������� ����� ������� .TefUserList.ContextFilter }
begin
 Result := aefUserList.ContextFilter;
end;//TkwEfUserListContextFilter.ContextFilter

class function TkwEfUserListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.ContextFilter';
end;//TkwEfUserListContextFilter.GetWordNameForRegister

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

procedure TkwEfUserListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwEfUserListContextFilter.SetValuePrim

procedure TkwEfUserListContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
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
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aefUserList));
end;//TkwEfUserListContextFilter.DoDoIt

function TkwEfUserListTrUserList.trUserList(const aCtx: TtfwContext;
 aefUserList: TefUserList): TeeTreeView;
 {* ���������� ����� ������� .TefUserList.trUserList }
begin
 Result := aefUserList.trUserList;
end;//TkwEfUserListTrUserList.trUserList

class function TkwEfUserListTrUserList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.trUserList';
end;//TkwEfUserListTrUserList.GetWordNameForRegister

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

procedure TkwEfUserListTrUserList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� trUserList', aCtx);
end;//TkwEfUserListTrUserList.SetValuePrim

procedure TkwEfUserListTrUserList.DoDoIt(const aCtx: TtfwContext);
var l_aefUserList: TefUserList;
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
 aCtx.rEngine.PushObj(trUserList(aCtx, l_aefUserList));
end;//TkwEfUserListTrUserList.DoDoIt

initialization
 Tkw_Form_UserList.RegisterInEngine;
 {* ����������� Tkw_Form_UserList }
 Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_BackgroundPanel }
 Tkw_UserList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_BackgroundPanel_Push }
 Tkw_UserList_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_ContextFilter }
 Tkw_UserList_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_ContextFilter_Push }
 Tkw_UserList_Control_trUserList.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_trUserList }
 Tkw_UserList_Control_trUserList_Push.RegisterInEngine;
 {* ����������� Tkw_UserList_Control_trUserList_Push }
 TkwEfUserListBackgroundPanel.RegisterInEngine;
 {* ����������� efUserList_BackgroundPanel }
 TkwEfUserListContextFilter.RegisterInEngine;
 {* ����������� efUserList_ContextFilter }
 TkwEfUserListTrUserList.RegisterInEngine;
 {* ����������� efUserList_trUserList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserList));
 {* ����������� ���� TefUserList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
