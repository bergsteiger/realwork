unit ContactListKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Chat/ContactListKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������� ��������::Chat::View::Chat::BaseChat::ContactListKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� ContactList
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  eeTreeView
  {$If defined(Nemesis)}
  ,
  nscContextFilter
  {$IfEnd} //Nemesis
  ,
  ContactList_Form,
  vtPanel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

implementation

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_ContactList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� ContactList
----
*������ �������������*:
[code]
'aControl' �����::ContactList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ContactList

// start class Tkw_Form_ContactList

class function Tkw_Form_ContactList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::ContactList';
end;//Tkw_Form_ContactList.GetWordNameForRegister

function Tkw_Form_ContactList.GetString: AnsiString;
 {-}
begin
 Result := 'ContactListForm';
end;//Tkw_Form_ContactList.GetString

type
  Tkw_ContactList_Control_BackgroundPanel = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_ContactList_Control_BackgroundPanel

// start class Tkw_ContactList_Control_BackgroundPanel

class function Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_ContactList_Control_BackgroundPanel.GetString: AnsiString;
 {-}
begin
 Result := 'BackgroundPanel';
end;//Tkw_ContactList_Control_BackgroundPanel.GetString

class procedure Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine

type
  Tkw_ContactList_Control_BackgroundPanel_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_ContactList_Control_BackgroundPanel_Push

// start class Tkw_ContactList_Control_BackgroundPanel_Push

procedure Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_ContactList_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::BackgroundPanel:push';
end;//Tkw_ContactList_Control_BackgroundPanel_Push.GetWordNameForRegister

type
  Tkw_ContactList_Control_ContextFilter = {final scriptword} class(TtfwControlString)
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
  end;//Tkw_ContactList_Control_ContextFilter

// start class Tkw_ContactList_Control_ContextFilter

class function Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetWordNameForRegister

function Tkw_ContactList_Control_ContextFilter.GetString: AnsiString;
 {-}
begin
 Result := 'ContextFilter';
end;//Tkw_ContactList_Control_ContextFilter.GetString

class procedure Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscContextFilter);
end;//Tkw_ContactList_Control_ContextFilter.RegisterInEngine

type
  Tkw_ContactList_Control_ContextFilter_Push = {final scriptword} class(TkwBynameControlPush)
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
  end;//Tkw_ContactList_Control_ContextFilter_Push

// start class Tkw_ContactList_Control_ContextFilter_Push

procedure Tkw_ContactList_Control_ContextFilter_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ContextFilter');
 inherited;
end;//Tkw_ContactList_Control_ContextFilter_Push.DoDoIt

class function Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ContextFilter:push';
end;//Tkw_ContactList_Control_ContextFilter_Push.GetWordNameForRegister

type
  Tkw_ContactList_Control_trContactList = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� trContactList
----
*������ �������������*:
[code]
�������::trContactList TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ContactList_Control_trContactList

// start class Tkw_ContactList_Control_trContactList

class function Tkw_ContactList_Control_trContactList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::trContactList';
end;//Tkw_ContactList_Control_trContactList.GetWordNameForRegister

function Tkw_ContactList_Control_trContactList.GetString: AnsiString;
 {-}
begin
 Result := 'trContactList';
end;//Tkw_ContactList_Control_trContactList.GetString

class procedure Tkw_ContactList_Control_trContactList.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_ContactList_Control_trContactList.RegisterInEngine

type
  Tkw_ContactList_Control_trContactList_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� trContactList
----
*������ �������������*:
[code]
�������::trContactList:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ContactList_Control_trContactList_Push

// start class Tkw_ContactList_Control_trContactList_Push

procedure Tkw_ContactList_Control_trContactList_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('trContactList');
 inherited;
end;//Tkw_ContactList_Control_trContactList_Push.DoDoIt

class function Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::trContactList:push';
end;//Tkw_ContactList_Control_trContactList_Push.GetWordNameForRegister

type
  TkwContactListFormBackgroundPanel = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContactListForm.BackgroundPanel
[panel]������� BackgroundPanel ����� TContactListForm[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aContactListForm .TContactListForm.BackgroundPanel >>> l_TvtPanel
[code]  }
  private
  // private methods
   function BackgroundPanel(const aCtx: TtfwContext;
     aContactListForm: TContactListForm): TvtPanel;
     {* ���������� ����� ������� .TContactListForm.BackgroundPanel }
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
  end;//TkwContactListFormBackgroundPanel

// start class TkwContactListFormBackgroundPanel

function TkwContactListFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
  aContactListForm: TContactListForm): TvtPanel;
 {-}
begin
 Result := aContactListForm.BackgroundPanel;
end;//TkwContactListFormBackgroundPanel.BackgroundPanel

procedure TkwContactListFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContactListForm : TContactListForm;
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
 aCtx.rEngine.PushObj((BackgroundPanel(aCtx, l_aContactListForm)));
end;//TkwContactListFormBackgroundPanel.DoDoIt

class function TkwContactListFormBackgroundPanel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContactListForm.BackgroundPanel';
end;//TkwContactListFormBackgroundPanel.GetWordNameForRegister

procedure TkwContactListFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� BackgroundPanel', aCtx);
end;//TkwContactListFormBackgroundPanel.SetValuePrim

function TkwContactListFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwContactListFormBackgroundPanel.GetResultTypeInfo

function TkwContactListFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContactListFormBackgroundPanel.GetAllParamsCount

function TkwContactListFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormBackgroundPanel.ParamsTypes

type
  TkwContactListFormContextFilter = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContactListForm.ContextFilter
[panel]������� ContextFilter ����� TContactListForm[panel]
*��� ����������:* TnscContextFilter
*������:*
[code]
OBJECT VAR l_TnscContextFilter
 aContactListForm .TContactListForm.ContextFilter >>> l_TnscContextFilter
[code]  }
  private
  // private methods
   function ContextFilter(const aCtx: TtfwContext;
     aContactListForm: TContactListForm): TnscContextFilter;
     {* ���������� ����� ������� .TContactListForm.ContextFilter }
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
  end;//TkwContactListFormContextFilter

// start class TkwContactListFormContextFilter

function TkwContactListFormContextFilter.ContextFilter(const aCtx: TtfwContext;
  aContactListForm: TContactListForm): TnscContextFilter;
 {-}
begin
 Result := aContactListForm.ContextFilter;
end;//TkwContactListFormContextFilter.ContextFilter

procedure TkwContactListFormContextFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContactListForm : TContactListForm;
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
 aCtx.rEngine.PushObj((ContextFilter(aCtx, l_aContactListForm)));
end;//TkwContactListFormContextFilter.DoDoIt

class function TkwContactListFormContextFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContactListForm.ContextFilter';
end;//TkwContactListFormContextFilter.GetWordNameForRegister

procedure TkwContactListFormContextFilter.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ContextFilter', aCtx);
end;//TkwContactListFormContextFilter.SetValuePrim

function TkwContactListFormContextFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscContextFilter);
end;//TkwContactListFormContextFilter.GetResultTypeInfo

function TkwContactListFormContextFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContactListFormContextFilter.GetAllParamsCount

function TkwContactListFormContextFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormContextFilter.ParamsTypes

type
  TkwContactListFormTrContactList = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TContactListForm.trContactList
[panel]������� trContactList ����� TContactListForm[panel]
*��� ����������:* TeeTreeView
*������:*
[code]
OBJECT VAR l_TeeTreeView
 aContactListForm .TContactListForm.trContactList >>> l_TeeTreeView
[code]  }
  private
  // private methods
   function TrContactList(const aCtx: TtfwContext;
     aContactListForm: TContactListForm): TeeTreeView;
     {* ���������� ����� ������� .TContactListForm.trContactList }
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
  end;//TkwContactListFormTrContactList

// start class TkwContactListFormTrContactList

function TkwContactListFormTrContactList.TrContactList(const aCtx: TtfwContext;
  aContactListForm: TContactListForm): TeeTreeView;
 {-}
begin
 Result := aContactListForm.trContactList;
end;//TkwContactListFormTrContactList.TrContactList

procedure TkwContactListFormTrContactList.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aContactListForm : TContactListForm;
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
 aCtx.rEngine.PushObj((TrContactList(aCtx, l_aContactListForm)));
end;//TkwContactListFormTrContactList.DoDoIt

class function TkwContactListFormTrContactList.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TContactListForm.trContactList';
end;//TkwContactListFormTrContactList.GetWordNameForRegister

procedure TkwContactListFormTrContactList.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� trContactList', aCtx);
end;//TkwContactListFormTrContactList.SetValuePrim

function TkwContactListFormTrContactList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwContactListFormTrContactList.GetResultTypeInfo

function TkwContactListFormTrContactList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwContactListFormTrContactList.GetAllParamsCount

function TkwContactListFormTrContactList.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TContactListForm)]);
end;//TkwContactListFormTrContactList.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_ContactList
 Tkw_Form_ContactList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_BackgroundPanel
 Tkw_ContactList_Control_BackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_BackgroundPanel_Push
 Tkw_ContactList_Control_BackgroundPanel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_ContextFilter
 Tkw_ContactList_Control_ContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_ContextFilter_Push
 Tkw_ContactList_Control_ContextFilter_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_trContactList
 Tkw_ContactList_Control_trContactList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ContactList_Control_trContactList_Push
 Tkw_ContactList_Control_trContactList_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContactListForm_BackgroundPanel
 TkwContactListFormBackgroundPanel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContactListForm_ContextFilter
 TkwContactListFormContextFilter.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ContactListForm_trContactList
 TkwContactListFormTrContactList.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� ContactList
 TtfwTypeRegistrator.RegisterType(TypeInfo(TContactListForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TnscContextFilter
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscContextFilter));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TeeTreeView
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.