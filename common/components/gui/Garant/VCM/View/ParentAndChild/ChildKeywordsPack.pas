unit ChildKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// ������: "w:/common/components/gui/Garant/VCM/View/ParentAndChild/ChildKeywordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> Shared Delphi F1 Like Application::F1Like::View::ParentAndChild::ParentAndChildPrim::ChildKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� Child
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  ElPgCtl
  {$If defined(Nemesis)}
  ,
  nscFormsPageControl
  {$IfEnd} //Nemesis
  ,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  Child_Form,
  tfwControlString,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_Child = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� Child
----
*������ �������������*:
[code]
'aControl' �����::Child TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_Child

// start class Tkw_Form_Child

class function Tkw_Form_Child.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::Child';
end;//Tkw_Form_Child.GetWordNameForRegister

function Tkw_Form_Child.GetString: AnsiString;
 {-}
begin
 Result := 'ChildForm';
end;//Tkw_Form_Child.GetString

type
  Tkw_Child_Control_ChildZone = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Child_Control_ChildZone

// start class Tkw_Child_Control_ChildZone

class function Tkw_Child_Control_ChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone';
end;//Tkw_Child_Control_ChildZone.GetWordNameForRegister

function Tkw_Child_Control_ChildZone.GetString: AnsiString;
 {-}
begin
 Result := 'ChildZone';
end;//Tkw_Child_Control_ChildZone.GetString

class procedure Tkw_Child_Control_ChildZone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscFormsPageControl);
end;//Tkw_Child_Control_ChildZone.RegisterInEngine

type
  Tkw_Child_Control_ChildZone_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Child_Control_ChildZone_Push

// start class Tkw_Child_Control_ChildZone_Push

procedure Tkw_Child_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Child_Control_ChildZone_Push.DoDoIt

class function Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ChildZone:push';
end;//Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister

type
  Tkw_Child_Control_MainPageTab = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_Child_Control_MainPageTab

// start class Tkw_Child_Control_MainPageTab

class function Tkw_Child_Control_MainPageTab.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetWordNameForRegister

function Tkw_Child_Control_MainPageTab.GetString: AnsiString;
 {-}
begin
 Result := 'MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetString

class procedure Tkw_Child_Control_MainPageTab.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElTabSheet);
end;//Tkw_Child_Control_MainPageTab.RegisterInEngine

type
  Tkw_Child_Control_MainPageTab_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_Child_Control_MainPageTab_Push

// start class Tkw_Child_Control_MainPageTab_Push

procedure Tkw_Child_Control_MainPageTab_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('MainPageTab');
 inherited;
end;//Tkw_Child_Control_MainPageTab_Push.DoDoIt

class function Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::MainPageTab:push';
end;//Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister

type
  TkwChildFormChildZone = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TChildForm.ChildZone
[panel]������� ChildZone ����� TChildForm[panel]
*��� ����������:* TnscFormsPageControl
*������:*
[code]
OBJECT VAR l_TnscFormsPageControl
 aChildForm .TChildForm.ChildZone >>> l_TnscFormsPageControl
[code]  }
  private
  // private methods
   function ChildZone(const aCtx: TtfwContext;
     aChildForm: TChildForm): TnscFormsPageControl;
     {* ���������� ����� ������� .TChildForm.ChildZone }
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
  end;//TkwChildFormChildZone

// start class TkwChildFormChildZone

function TkwChildFormChildZone.ChildZone(const aCtx: TtfwContext;
  aChildForm: TChildForm): TnscFormsPageControl;
 {-}
begin
 Result := aChildForm.ChildZone;
end;//TkwChildFormChildZone.ChildZone

procedure TkwChildFormChildZone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChildForm : TChildForm;
begin
 try
  l_aChildForm := TChildForm(aCtx.rEngine.PopObjAs(TChildForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChildForm: TChildForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ChildZone(aCtx, l_aChildForm)));
end;//TkwChildFormChildZone.DoDoIt

class function TkwChildFormChildZone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChildForm.ChildZone';
end;//TkwChildFormChildZone.GetWordNameForRegister

procedure TkwChildFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwChildFormChildZone.SetValuePrim

function TkwChildFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscFormsPageControl);
end;//TkwChildFormChildZone.GetResultTypeInfo

function TkwChildFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChildFormChildZone.GetAllParamsCount

function TkwChildFormChildZone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormChildZone.ParamsTypes

type
  TkwChildFormMainPageTab = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TChildForm.MainPageTab
[panel]������� MainPageTab ����� TChildForm[panel]
*��� ����������:* TElTabSheet
*������:*
[code]
OBJECT VAR l_TElTabSheet
 aChildForm .TChildForm.MainPageTab >>> l_TElTabSheet
[code]  }
  private
  // private methods
   function MainPageTab(const aCtx: TtfwContext;
     aChildForm: TChildForm): TElTabSheet;
     {* ���������� ����� ������� .TChildForm.MainPageTab }
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
  end;//TkwChildFormMainPageTab

// start class TkwChildFormMainPageTab

function TkwChildFormMainPageTab.MainPageTab(const aCtx: TtfwContext;
  aChildForm: TChildForm): TElTabSheet;
 {-}
begin
 Result := aChildForm.MainPageTab;
end;//TkwChildFormMainPageTab.MainPageTab

procedure TkwChildFormMainPageTab.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aChildForm : TChildForm;
begin
 try
  l_aChildForm := TChildForm(aCtx.rEngine.PopObjAs(TChildForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aChildForm: TChildForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((MainPageTab(aCtx, l_aChildForm)));
end;//TkwChildFormMainPageTab.DoDoIt

class function TkwChildFormMainPageTab.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TChildForm.MainPageTab';
end;//TkwChildFormMainPageTab.GetWordNameForRegister

procedure TkwChildFormMainPageTab.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� MainPageTab', aCtx);
end;//TkwChildFormMainPageTab.SetValuePrim

function TkwChildFormMainPageTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElTabSheet);
end;//TkwChildFormMainPageTab.GetResultTypeInfo

function TkwChildFormMainPageTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwChildFormMainPageTab.GetAllParamsCount

function TkwChildFormMainPageTab.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormMainPageTab.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� Tkw_Form_Child
 Tkw_Form_Child.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Child_Control_ChildZone
 Tkw_Child_Control_ChildZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Child_Control_ChildZone_Push
 Tkw_Child_Control_ChildZone_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Child_Control_MainPageTab
 Tkw_Child_Control_MainPageTab.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� Tkw_Child_Control_MainPageTab_Push
 Tkw_Child_Control_MainPageTab_Push.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ChildForm_ChildZone
 TkwChildFormChildZone.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ChildForm_MainPageTab
 TkwChildFormMainPageTab.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Child
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChildForm));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TnscFormsPageControl
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFormsPageControl));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TElTabSheet
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
{$IfEnd} //not NoScripts

end.