unit ContactListKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ContactList }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Chat\Forms\ContactListKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ContactListKeywordsPack" MUID: (4A6971D00157_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , ContactList_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscContextFilter
 {$IfEnd} // Defined(Nemesis)
 , eeTreeView
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwContactListFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContactListForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TvtPanel;
    {* ���������� ����� ������� .TContactListForm.BackgroundPanel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormBackgroundPanel

 TkwContactListFormContextFilter = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContactListForm.ContextFilter }
  private
   function ContextFilter(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TnscContextFilter;
    {* ���������� ����� ������� .TContactListForm.ContextFilter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormContextFilter

 TkwContactListFormTrContactList = {final} class(TtfwPropertyLike)
  {* ����� ������� .TContactListForm.trContactList }
  private
   function trContactList(const aCtx: TtfwContext;
    aContactListForm: TContactListForm): TeeTreeView;
    {* ���������� ����� ������� .TContactListForm.trContactList }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwContactListFormTrContactList

 Tkw_Form_ContactList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ContactList
----
*������ �������������*:
[code]�����::ContactList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ContactList

 Tkw_ContactList_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_BackgroundPanel

 Tkw_ContactList_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� BackgroundPanel
----
*������ �������������*:
[code]�������::BackgroundPanel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_BackgroundPanel_Push

 Tkw_ContactList_Control_ContextFilter = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_ContextFilter

 Tkw_ContactList_Control_ContextFilter_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ContextFilter
----
*������ �������������*:
[code]�������::ContextFilter:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_ContextFilter_Push

 Tkw_ContactList_Control_trContactList = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� trContactList
----
*������ �������������*:
[code]�������::trContactList TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_trContactList

 Tkw_ContactList_Control_trContactList_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� trContactList
----
*������ �������������*:
[code]�������::trContactList:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ContactList_Control_trContactList_Push

function TkwContactListFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TvtPanel;
 {* ���������� ����� ������� .TContactListForm.BackgroundPanel }
begin
 Result := aContactListForm.BackgroundPanel;
end;//TkwContactListFormBackgroundPanel.BackgroundPanel

class function TkwContactListFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.BackgroundPanel';
end;//TkwContactListFormBackgroundPanel.GetWordNameForRegister

function TkwContactListFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContactListFormBackgroundPanel.GetResultTypeInfo

function TkwContactListFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormBackgroundPanel.GetAllParamsCount

function TkwContactListFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormBackgroundPanel.ParamsTypes

procedure TkwContactListFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwContactListFormBackgroundPanel.SetValuePrim

procedure TkwContactListFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_aContactListForm));
end;//TkwContactListFormBackgroundPanel.DoDoIt

function TkwContactListFormContextFilter.ContextFilter(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TnscContextFilter;
 {* ���������� ����� ������� .TContactListForm.ContextFilter }
begin
 Result := aContactListForm.ContextFilter;
end;//TkwContactListFormContextFilter.ContextFilter

class function TkwContactListFormContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.ContextFilter';
end;//TkwContactListFormContextFilter.GetWordNameForRegister

function TkwContactListFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContactListFormContextFilter.GetResultTypeInfo

function TkwContactListFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormContextFilter.GetAllParamsCount

function TkwContactListFormContextFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormContextFilter.ParamsTypes

procedure TkwContactListFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwContactListFormContextFilter.SetValuePrim

procedure TkwContactListFormContextFilter.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ContextFilter(aCtx, l_aContactListForm));
end;//TkwContactListFormContextFilter.DoDoIt

function TkwContactListFormTrContactList.trContactList(const aCtx: TtfwContext;
 aContactListForm: TContactListForm): TeeTreeView;
 {* ���������� ����� ������� .TContactListForm.trContactList }
begin
 Result := aContactListForm.trContactList;
end;//TkwContactListFormTrContactList.trContactList

class function TkwContactListFormTrContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TContactListForm.trContactList';
end;//TkwContactListFormTrContactList.GetWordNameForRegister

function TkwContactListFormTrContactList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwContactListFormTrContactList.GetResultTypeInfo

function TkwContactListFormTrContactList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwContactListFormTrContactList.GetAllParamsCount

function TkwContactListFormTrContactList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormTrContactList.ParamsTypes

procedure TkwContactListFormTrContactList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� trContactList', aCtx);
end;//TkwContactListFormTrContactList.SetValuePrim

procedure TkwContactListFormTrContactList.DoDoIt(const aCtx: TtfwContext);
var l_aContactListForm: TContactListForm;
begin
 try
  l_aContactListForm := TContactListForm(aCtx.rEngine.PopObjAs(TContactListForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aContactListForm: TContactListForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(trContactList(aCtx, l_aContactListForm));
end;//TkwContactListFormTrContactList.DoDoIt

function Tkw_Form_ContactList.GetString: AnsiString;
begin
 Result := 'ContactListForm';
end;//Tkw_Form_ContactList.GetString

class procedure Tkw_Form_ContactList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TContactListForm);
end;//Tkw_Form_ContactList.RegisterInEngine

class function Tkw_Form_ContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ContactList';
end;//Tkw_Form_ContactList.GetWordNameForRegister

function Tkw_ContactList_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetString

class procedure Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine

class function Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_ContactList_Control_ContextFilter.GetString: AnsiString;
begin
 Result := 'ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetString

class procedure Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_ContactList_Control_ContextFilter.RegisterInEngine

class function Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister

procedure Tkw_ContactList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_ContactList_Control_ContextFilter_Push.DoDoIt

class function Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister

function Tkw_ContactList_Control_trContactList.GetString: AnsiString;
begin
 Result := 'trContactList';
end;//Tkw_ContactList_Control_trContactList.GetString

class procedure Tkw_ContactList_Control_trContactList.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_ContactList_Control_trContactList.RegisterInEngine

class function Tkw_ContactList_Control_trContactList.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::trContactList';
end;//Tkw_ContactList_Control_trContactList.GetWordNameForRegister

procedure Tkw_ContactList_Control_trContactList_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('trContactList');
 inherited;
end;//Tkw_ContactList_Control_trContactList_Push.DoDoIt

class function Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::trContactList:push';
end;//Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister

initialization
 TkwContactListFormBackgroundPanel.RegisterInEngine;
 {* ����������� ContactListForm_BackgroundPanel }
 TkwContactListFormContextFilter.RegisterInEngine;
 {* ����������� ContactListForm_ContextFilter }
 TkwContactListFormTrContactList.RegisterInEngine;
 {* ����������� ContactListForm_trContactList }
 Tkw_Form_ContactList.RegisterInEngine;
 {* ����������� Tkw_Form_ContactList }
 Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_BackgroundPanel }
 Tkw_ContactList_Control_BackgroundPanel_Push.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_BackgroundPanel_Push }
 Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_ContextFilter }
 Tkw_ContactList_Control_ContextFilter_Push.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_ContextFilter_Push }
 Tkw_ContactList_Control_trContactList.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_trContactList }
 Tkw_ContactList_Control_trContactList_Push.RegisterInEngine;
 {* ����������� Tkw_ContactList_Control_trContactList_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContactListForm));
 {* ����������� ���� TContactListForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
 {* ����������� ���� TnscContextFilter }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* ����������� ���� TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
