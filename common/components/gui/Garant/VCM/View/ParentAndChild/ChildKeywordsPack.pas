unit ChildKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� Child }

// ������: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ChildKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 {$If Defined(Nemesis)}
 , nscFormsPageControl
 {$IfEnd} // Defined(Nemesis)
 , ElPgCtl
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Child_Form
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
 Tkw_Form_Child = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� Child
----
*������ �������������*:
[code]
'aControl' �����::Child TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Child

 Tkw_Child_Control_ChildZone = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Child_Control_ChildZone

 Tkw_Child_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ChildZone
----
*������ �������������*:
[code]
�������::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_ChildZone_Push

 Tkw_Child_Control_MainPageTab = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Child_Control_MainPageTab

 Tkw_Child_Control_MainPageTab_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� MainPageTab
----
*������ �������������*:
[code]
�������::MainPageTab:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_MainPageTab_Push

 TkwChildFormChildZone = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChildForm.ChildZone
[panel]������� ChildZone ����� TChildForm[panel]
*��� ����������:* TnscFormsPageControl
*������:*
[code]
OBJECT VAR l_TnscFormsPageControl
 aChildForm .TChildForm.ChildZone >>> l_TnscFormsPageControl
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aChildForm: TChildForm): TnscFormsPageControl;
    {* ���������� ����� ������� .TChildForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChildFormChildZone

 TkwChildFormMainPageTab = {final} class(TtfwPropertyLike)
  {* ����� ������� .TChildForm.MainPageTab
[panel]������� MainPageTab ����� TChildForm[panel]
*��� ����������:* TElTabSheet
*������:*
[code]
OBJECT VAR l_TElTabSheet
 aChildForm .TChildForm.MainPageTab >>> l_TElTabSheet
[code]  }
  private
   function MainPageTab(const aCtx: TtfwContext;
    aChildForm: TChildForm): TElTabSheet;
    {* ���������� ����� ������� .TChildForm.MainPageTab }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChildFormMainPageTab

class function Tkw_Form_Child.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::Child';
end;//Tkw_Form_Child.GetWordNameForRegister

function Tkw_Form_Child.GetString: AnsiString;
begin
 Result := 'ChildForm';
end;//Tkw_Form_Child.GetString

class function Tkw_Child_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone';
end;//Tkw_Child_Control_ChildZone.GetWordNameForRegister

function Tkw_Child_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_Child_Control_ChildZone.GetString

class procedure Tkw_Child_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFormsPageControl);
end;//Tkw_Child_Control_ChildZone.RegisterInEngine

procedure Tkw_Child_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Child_Control_ChildZone_Push.DoDoIt

class function Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ChildZone:push';
end;//Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_Child_Control_MainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetWordNameForRegister

function Tkw_Child_Control_MainPageTab.GetString: AnsiString;
begin
 Result := 'MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetString

class procedure Tkw_Child_Control_MainPageTab.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElTabSheet);
end;//Tkw_Child_Control_MainPageTab.RegisterInEngine

procedure Tkw_Child_Control_MainPageTab_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainPageTab');
 inherited;
end;//Tkw_Child_Control_MainPageTab_Push.DoDoIt

class function Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::MainPageTab:push';
end;//Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister

function TkwChildFormChildZone.ChildZone(const aCtx: TtfwContext;
 aChildForm: TChildForm): TnscFormsPageControl;
 {* ���������� ����� ������� .TChildForm.ChildZone }
begin
 Result := aChildForm.ChildZone;
end;//TkwChildFormChildZone.ChildZone

procedure TkwChildFormChildZone.DoDoIt(const aCtx: TtfwContext);
var l_aChildForm: TChildForm;
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
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_aChildForm));
end;//TkwChildFormChildZone.DoDoIt

class function TkwChildFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.ChildZone';
end;//TkwChildFormChildZone.GetWordNameForRegister

procedure TkwChildFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ChildZone', aCtx);
end;//TkwChildFormChildZone.SetValuePrim

function TkwChildFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFormsPageControl);
end;//TkwChildFormChildZone.GetResultTypeInfo

function TkwChildFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormChildZone.GetAllParamsCount

function TkwChildFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormChildZone.ParamsTypes

function TkwChildFormMainPageTab.MainPageTab(const aCtx: TtfwContext;
 aChildForm: TChildForm): TElTabSheet;
 {* ���������� ����� ������� .TChildForm.MainPageTab }
begin
 Result := aChildForm.MainPageTab;
end;//TkwChildFormMainPageTab.MainPageTab

procedure TkwChildFormMainPageTab.DoDoIt(const aCtx: TtfwContext);
var l_aChildForm: TChildForm;
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
 aCtx.rEngine.PushObj(MainPageTab(aCtx, l_aChildForm));
end;//TkwChildFormMainPageTab.DoDoIt

class function TkwChildFormMainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.MainPageTab';
end;//TkwChildFormMainPageTab.GetWordNameForRegister

procedure TkwChildFormMainPageTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� MainPageTab', aCtx);
end;//TkwChildFormMainPageTab.SetValuePrim

function TkwChildFormMainPageTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElTabSheet);
end;//TkwChildFormMainPageTab.GetResultTypeInfo

function TkwChildFormMainPageTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormMainPageTab.GetAllParamsCount

function TkwChildFormMainPageTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormMainPageTab.ParamsTypes

initialization
 Tkw_Form_Child.RegisterInEngine;
 {* ����������� Tkw_Form_Child }
 Tkw_Child_Control_ChildZone.RegisterInEngine;
 {* ����������� Tkw_Child_Control_ChildZone }
 Tkw_Child_Control_ChildZone_Push.RegisterInEngine;
 {* ����������� Tkw_Child_Control_ChildZone_Push }
 Tkw_Child_Control_MainPageTab.RegisterInEngine;
 {* ����������� Tkw_Child_Control_MainPageTab }
 Tkw_Child_Control_MainPageTab_Push.RegisterInEngine;
 {* ����������� Tkw_Child_Control_MainPageTab_Push }
 TkwChildFormChildZone.RegisterInEngine;
 {* ����������� ChildForm_ChildZone }
 TkwChildFormMainPageTab.RegisterInEngine;
 {* ����������� ChildForm_MainPageTab }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChildForm));
 {* ����������� ���� Child }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFormsPageControl));
 {* ����������� ���� TnscFormsPageControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
 {* ����������� ���� TElTabSheet }
{$IfEnd} // NOT Defined(NoScripts)

end.
