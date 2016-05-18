unit SynchroViewKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� SynchroView }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\Forms\SynchroViewKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "SynchroViewKeywordsPack" MUID: (4AB1359700D9_Pack)

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
 , SynchroView_Form
 , tfwPropertyLike
 , vtPanel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwFcSynchroViewDocView = {final} class(TtfwPropertyLike)
  {* ����� ������� .TfcSynchroView.DocView }
  private
   function DocView(const aCtx: TtfwContext;
    afcSynchroView: TfcSynchroView): TvtPanel;
    {* ���������� ����� ������� .TfcSynchroView.DocView }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFcSynchroViewDocView

 Tkw_Form_SynchroView = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� SynchroView
----
*������ �������������*:
[code]�����::SynchroView TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_SynchroView

 Tkw_SynchroView_Control_DocView = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� DocView
----
*������ �������������*:
[code]�������::DocView TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SynchroView_Control_DocView

 Tkw_SynchroView_Control_DocView_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� DocView
----
*������ �������������*:
[code]�������::DocView:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SynchroView_Control_DocView_Push

function TkwFcSynchroViewDocView.DocView(const aCtx: TtfwContext;
 afcSynchroView: TfcSynchroView): TvtPanel;
 {* ���������� ����� ������� .TfcSynchroView.DocView }
begin
 Result := afcSynchroView.DocView;
end;//TkwFcSynchroViewDocView.DocView

class function TkwFcSynchroViewDocView.GetWordNameForRegister: AnsiString;
begin
 Result := '.TfcSynchroView.DocView';
end;//TkwFcSynchroViewDocView.GetWordNameForRegister

function TkwFcSynchroViewDocView.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwFcSynchroViewDocView.GetResultTypeInfo

function TkwFcSynchroViewDocView.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFcSynchroViewDocView.GetAllParamsCount

function TkwFcSynchroViewDocView.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TfcSynchroView)]);
end;//TkwFcSynchroViewDocView.ParamsTypes

procedure TkwFcSynchroViewDocView.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� DocView', aCtx);
end;//TkwFcSynchroViewDocView.SetValuePrim

procedure TkwFcSynchroViewDocView.DoDoIt(const aCtx: TtfwContext);
var l_afcSynchroView: TfcSynchroView;
begin
 try
  l_afcSynchroView := TfcSynchroView(aCtx.rEngine.PopObjAs(TfcSynchroView));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� afcSynchroView: TfcSynchroView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DocView(aCtx, l_afcSynchroView));
end;//TkwFcSynchroViewDocView.DoDoIt

function Tkw_Form_SynchroView.GetString: AnsiString;
begin
 Result := 'fcSynchroView';
end;//Tkw_Form_SynchroView.GetString

class procedure Tkw_Form_SynchroView.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TfcSynchroView);
end;//Tkw_Form_SynchroView.RegisterInEngine

class function Tkw_Form_SynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::SynchroView';
end;//Tkw_Form_SynchroView.GetWordNameForRegister

function Tkw_SynchroView_Control_DocView.GetString: AnsiString;
begin
 Result := 'DocView';
end;//Tkw_SynchroView_Control_DocView.GetString

class procedure Tkw_SynchroView_Control_DocView.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SynchroView_Control_DocView.RegisterInEngine

class function Tkw_SynchroView_Control_DocView.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DocView';
end;//Tkw_SynchroView_Control_DocView.GetWordNameForRegister

procedure Tkw_SynchroView_Control_DocView_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('DocView');
 inherited;
end;//Tkw_SynchroView_Control_DocView_Push.DoDoIt

class function Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::DocView:push';
end;//Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister

initialization
 TkwFcSynchroViewDocView.RegisterInEngine;
 {* ����������� fcSynchroView_DocView }
 Tkw_Form_SynchroView.RegisterInEngine;
 {* ����������� Tkw_Form_SynchroView }
 Tkw_SynchroView_Control_DocView.RegisterInEngine;
 {* ����������� Tkw_SynchroView_Control_DocView }
 Tkw_SynchroView_Control_DocView_Push.RegisterInEngine;
 {* ����������� Tkw_SynchroView_Control_DocView_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TfcSynchroView));
 {* ����������� ���� TfcSynchroView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* ����������� ���� TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
