unit ProgressIndicatorKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� ProgressIndicator }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\ProgressIndicatorKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ProgressIndicatorKeywordsPack" MUID: (4A93F1CC01A8_Pack)

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
 , ProgressIndicator_Form
 , tfwPropertyLike
 , ComCtrls
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A93F1CC01A8_Packimpl_uses*
 //#UC END# *4A93F1CC01A8_Packimpl_uses*
;

type
 TkwEfProgressIndicatorProgressBar = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefProgressIndicator.ProgressBar }
  private
   function ProgressBar(const aCtx: TtfwContext;
    aefProgressIndicator: TefProgressIndicator): TProgressBar;
    {* ���������� ����� ������� .TefProgressIndicator.ProgressBar }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEfProgressIndicatorProgressBar

 Tkw_Form_ProgressIndicator = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� ProgressIndicator
----
*������ �������������*:
[code]�����::ProgressIndicator TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ProgressIndicator

 Tkw_ProgressIndicator_Control_ProgressBar = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ProgressBar
----
*������ �������������*:
[code]�������::ProgressBar TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ProgressIndicator_Control_ProgressBar

 Tkw_ProgressIndicator_Control_ProgressBar_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ProgressBar
----
*������ �������������*:
[code]�������::ProgressBar:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ProgressIndicator_Control_ProgressBar_Push

function TkwEfProgressIndicatorProgressBar.ProgressBar(const aCtx: TtfwContext;
 aefProgressIndicator: TefProgressIndicator): TProgressBar;
 {* ���������� ����� ������� .TefProgressIndicator.ProgressBar }
begin
 Result := aefProgressIndicator.ProgressBar;
end;//TkwEfProgressIndicatorProgressBar.ProgressBar

class function TkwEfProgressIndicatorProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefProgressIndicator.ProgressBar';
end;//TkwEfProgressIndicatorProgressBar.GetWordNameForRegister

function TkwEfProgressIndicatorProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TProgressBar);
end;//TkwEfProgressIndicatorProgressBar.GetResultTypeInfo

function TkwEfProgressIndicatorProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfProgressIndicatorProgressBar.GetAllParamsCount

function TkwEfProgressIndicatorProgressBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefProgressIndicator)]);
end;//TkwEfProgressIndicatorProgressBar.ParamsTypes

procedure TkwEfProgressIndicatorProgressBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ProgressBar', aCtx);
end;//TkwEfProgressIndicatorProgressBar.SetValuePrim

procedure TkwEfProgressIndicatorProgressBar.DoDoIt(const aCtx: TtfwContext);
var l_aefProgressIndicator: TefProgressIndicator;
begin
 try
  l_aefProgressIndicator := TefProgressIndicator(aCtx.rEngine.PopObjAs(TefProgressIndicator));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefProgressIndicator: TefProgressIndicator : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ProgressBar(aCtx, l_aefProgressIndicator));
end;//TkwEfProgressIndicatorProgressBar.DoDoIt

function Tkw_Form_ProgressIndicator.GetString: AnsiString;
begin
 Result := 'efProgressIndicator';
end;//Tkw_Form_ProgressIndicator.GetString

class procedure Tkw_Form_ProgressIndicator.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TefProgressIndicator);
end;//Tkw_Form_ProgressIndicator.RegisterInEngine

class function Tkw_Form_ProgressIndicator.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::ProgressIndicator';
end;//Tkw_Form_ProgressIndicator.GetWordNameForRegister

function Tkw_ProgressIndicator_Control_ProgressBar.GetString: AnsiString;
begin
 Result := 'ProgressBar';
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetString

class procedure Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TProgressBar);
end;//Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine

class function Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ProgressBar';
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister

procedure Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ProgressBar');
 inherited;
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt

class function Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ProgressBar:push';
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister

initialization
 TkwEfProgressIndicatorProgressBar.RegisterInEngine;
 {* ����������� efProgressIndicator_ProgressBar }
 Tkw_Form_ProgressIndicator.RegisterInEngine;
 {* ����������� Tkw_Form_ProgressIndicator }
 Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
 {* ����������� Tkw_ProgressIndicator_Control_ProgressBar }
 Tkw_ProgressIndicator_Control_ProgressBar_Push.RegisterInEngine;
 {* ����������� Tkw_ProgressIndicator_Control_ProgressBar_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefProgressIndicator));
 {* ����������� ���� TefProgressIndicator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TProgressBar));
 {* ����������� ���� TProgressBar }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
