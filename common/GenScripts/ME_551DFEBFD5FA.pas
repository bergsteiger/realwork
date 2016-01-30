unit UserListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� UserList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\UserListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 , vtPanel
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_UserList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� UserList
----
*������ �������������*:
[code]
'aControl' �����::UserList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_UserList

 Tkw_UserList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]
�������::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserList_Control_BackgroundPanel

 Tkw_UserList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserList_Control_ContextFilter

 Tkw_UserList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_UserList_Control_trUserList

 Tkw_UserList_Control_trUserList_Push = {final} class(TkwBynameControlPush)
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
  {* ����� ������� .TefUserList.BackgroundPanel
[panel]������� BackgroundPanel ����� TefUserList[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aefUserList .TefUserList.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aefUserList: TefUserList): TvtPanel;
    {* ���������� ����� ������� .TefUserList.BackgroundPanel }
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
  {* ����� ������� .TefUserList.ContextFilter
[panel]������� ContextFilter ����� TefUserList[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aefUserList .TefUserList.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aefUserList: TefUserList): TnscContextFilter;
    {* ���������� ����� ������� .TefUserList.ContextFilter }
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
  {* ����� ������� .TefUserList.trUserList
[panel]������� trUserList ����� TefUserList[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aefUserList .TefUserList.trUserList >>> l_TeeTreeView
[code]  }
  private
   function trUserList(const aCtx: TtfwContext;
    aefUserList: TefUserList): TeeTreeView;
    {* ���������� ����� ������� .TefUserList.trUserList }
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

class function Tkw_Form_UserList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::UserList';
end;//Tkw_Form_UserList.GetWordNameForRegister

function Tkw_Form_UserList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_FE7337DC1EA7_var*
//#UC END# *4DDFD2EA0116_FE7337DC1EA7_var*
begin
//#UC START# *4DDFD2EA0116_FE7337DC1EA7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_FE7337DC1EA7_impl*
end;//Tkw_Form_UserList.GetString

class function Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_UserList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_UserList_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7443532241B2_var*
//#UC END# *4DDFD2EA0116_7443532241B2_var*
begin
//#UC START# *4DDFD2EA0116_7443532241B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7443532241B2_impl*
end;//Tkw_UserList_Control_BackgroundPanel.GetString

class procedure Tkw_UserList_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_7443532241B2_var*
//#UC END# *52A086150180_7443532241B2_var*
begin
//#UC START# *52A086150180_7443532241B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7443532241B2_impl*
end;//Tkw_UserList_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D43B5AB3BD3E_var*
//#UC END# *4DAEEDE10285_D43B5AB3BD3E_var*
begin
//#UC START# *4DAEEDE10285_D43B5AB3BD3E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D43B5AB3BD3E_impl*
end;//Tkw_UserList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_UserList_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_UserList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_UserList_Control_ContextFilter.GetWordNameForRegister

function Tkw_UserList_Control_ContextFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F1B2952D2F3B_var*
//#UC END# *4DDFD2EA0116_F1B2952D2F3B_var*
begin
//#UC START# *4DDFD2EA0116_F1B2952D2F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F1B2952D2F3B_impl*
end;//Tkw_UserList_Control_ContextFilter.GetString

class procedure Tkw_UserList_Control_ContextFilter.RegisterInEngine;
//#UC START# *52A086150180_F1B2952D2F3B_var*
//#UC END# *52A086150180_F1B2952D2F3B_var*
begin
//#UC START# *52A086150180_F1B2952D2F3B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F1B2952D2F3B_impl*
end;//Tkw_UserList_Control_ContextFilter.RegisterInEngine

procedure Tkw_UserList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_294600AAB9A4_var*
//#UC END# *4DAEEDE10285_294600AAB9A4_var*
begin
//#UC START# *4DAEEDE10285_294600AAB9A4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_294600AAB9A4_impl*
end;//Tkw_UserList_Control_ContextFilter_Push.DoDoIt

class function Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_UserList_Control_ContextFilter_Push.GetWordNameForRegister

class function Tkw_UserList_Control_trUserList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::trUserList';
end;//Tkw_UserList_Control_trUserList.GetWordNameForRegister

function Tkw_UserList_Control_trUserList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_57F121607540_var*
//#UC END# *4DDFD2EA0116_57F121607540_var*
begin
//#UC START# *4DDFD2EA0116_57F121607540_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_57F121607540_impl*
end;//Tkw_UserList_Control_trUserList.GetString

class procedure Tkw_UserList_Control_trUserList.RegisterInEngine;
//#UC START# *52A086150180_57F121607540_var*
//#UC END# *52A086150180_57F121607540_var*
begin
//#UC START# *52A086150180_57F121607540_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_57F121607540_impl*
end;//Tkw_UserList_Control_trUserList.RegisterInEngine

procedure Tkw_UserList_Control_trUserList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_97004F7182CA_var*
//#UC END# *4DAEEDE10285_97004F7182CA_var*
begin
//#UC START# *4DAEEDE10285_97004F7182CA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_97004F7182CA_impl*
end;//Tkw_UserList_Control_trUserList_Push.DoDoIt

class function Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::trUserList:push';
end;//Tkw_UserList_Control_trUserList_Push.GetWordNameForRegister

function TkwEfUserListBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aefUserList: TefUserList): TvtPanel;
 {* ���������� ����� ������� .TefUserList.BackgroundPanel }
//#UC START# *547B1A2B396D_7D8AACEB42CB_var*
//#UC END# *547B1A2B396D_7D8AACEB42CB_var*
begin
//#UC START# *547B1A2B396D_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *547B1A2B396D_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.BackgroundPanel

procedure TkwEfUserListBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7D8AACEB42CB_var*
//#UC END# *4DAEEDE10285_7D8AACEB42CB_var*
begin
//#UC START# *4DAEEDE10285_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.DoDoIt

class function TkwEfUserListBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.BackgroundPanel';
end;//TkwEfUserListBackgroundPanel.GetWordNameForRegister

procedure TkwEfUserListBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_7D8AACEB42CB_var*
//#UC END# *52D00B00031A_7D8AACEB42CB_var*
begin
//#UC START# *52D00B00031A_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.SetValuePrim

function TkwEfUserListBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_7D8AACEB42CB_var*
//#UC END# *551544E2001A_7D8AACEB42CB_var*
begin
//#UC START# *551544E2001A_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.GetResultTypeInfo

function TkwEfUserListBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_7D8AACEB42CB_var*
//#UC END# *559687E6025A_7D8AACEB42CB_var*
begin
//#UC START# *559687E6025A_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.GetAllParamsCount

function TkwEfUserListBackgroundPanel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_7D8AACEB42CB_var*
//#UC END# *5617F4D00243_7D8AACEB42CB_var*
begin
//#UC START# *5617F4D00243_7D8AACEB42CB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_7D8AACEB42CB_impl*
end;//TkwEfUserListBackgroundPanel.ParamsTypes

function TkwEfUserListContextFilter.ContextFilter(const aCtx: TtfwContext;
 aefUserList: TefUserList): TnscContextFilter;
 {* ���������� ����� ������� .TefUserList.ContextFilter }
//#UC START# *BA68B9155831_396FC976959E_var*
//#UC END# *BA68B9155831_396FC976959E_var*
begin
//#UC START# *BA68B9155831_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *BA68B9155831_396FC976959E_impl*
end;//TkwEfUserListContextFilter.ContextFilter

procedure TkwEfUserListContextFilter.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_396FC976959E_var*
//#UC END# *4DAEEDE10285_396FC976959E_var*
begin
//#UC START# *4DAEEDE10285_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_396FC976959E_impl*
end;//TkwEfUserListContextFilter.DoDoIt

class function TkwEfUserListContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.ContextFilter';
end;//TkwEfUserListContextFilter.GetWordNameForRegister

procedure TkwEfUserListContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_396FC976959E_var*
//#UC END# *52D00B00031A_396FC976959E_var*
begin
//#UC START# *52D00B00031A_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_396FC976959E_impl*
end;//TkwEfUserListContextFilter.SetValuePrim

function TkwEfUserListContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_396FC976959E_var*
//#UC END# *551544E2001A_396FC976959E_var*
begin
//#UC START# *551544E2001A_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_396FC976959E_impl*
end;//TkwEfUserListContextFilter.GetResultTypeInfo

function TkwEfUserListContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_396FC976959E_var*
//#UC END# *559687E6025A_396FC976959E_var*
begin
//#UC START# *559687E6025A_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_396FC976959E_impl*
end;//TkwEfUserListContextFilter.GetAllParamsCount

function TkwEfUserListContextFilter.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_396FC976959E_var*
//#UC END# *5617F4D00243_396FC976959E_var*
begin
//#UC START# *5617F4D00243_396FC976959E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_396FC976959E_impl*
end;//TkwEfUserListContextFilter.ParamsTypes

function TkwEfUserListTrUserList.trUserList(const aCtx: TtfwContext;
 aefUserList: TefUserList): TeeTreeView;
 {* ���������� ����� ������� .TefUserList.trUserList }
//#UC START# *BC6960408CDC_4AE7B910728D_var*
//#UC END# *BC6960408CDC_4AE7B910728D_var*
begin
//#UC START# *BC6960408CDC_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *BC6960408CDC_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.trUserList

procedure TkwEfUserListTrUserList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4AE7B910728D_var*
//#UC END# *4DAEEDE10285_4AE7B910728D_var*
begin
//#UC START# *4DAEEDE10285_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.DoDoIt

class function TkwEfUserListTrUserList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefUserList.trUserList';
end;//TkwEfUserListTrUserList.GetWordNameForRegister

procedure TkwEfUserListTrUserList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_4AE7B910728D_var*
//#UC END# *52D00B00031A_4AE7B910728D_var*
begin
//#UC START# *52D00B00031A_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.SetValuePrim

function TkwEfUserListTrUserList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4AE7B910728D_var*
//#UC END# *551544E2001A_4AE7B910728D_var*
begin
//#UC START# *551544E2001A_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.GetResultTypeInfo

function TkwEfUserListTrUserList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_4AE7B910728D_var*
//#UC END# *559687E6025A_4AE7B910728D_var*
begin
//#UC START# *559687E6025A_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.GetAllParamsCount

function TkwEfUserListTrUserList.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_4AE7B910728D_var*
//#UC END# *5617F4D00243_4AE7B910728D_var*
begin
//#UC START# *5617F4D00243_4AE7B910728D_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_4AE7B910728D_impl*
end;//TkwEfUserListTrUserList.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefUserList));
 {* ����������� ���� UserList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
