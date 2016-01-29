unit ProgressIndicatorKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/ProgressIndicatorKeywordsPack.pas"
// �����: 24.08.2009 20:35
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::ProgressIndicatorKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� ProgressIndicator
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
  ProgressIndicator_Form
  {$If not defined(NoVCL)}
  ,
  ComCtrls
  {$IfEnd} //not NoVCL
  ,
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
  Tkw_Form_ProgressIndicator = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� ProgressIndicator
----
*������ �������������*:
[code]
'aControl' �����::ProgressIndicator TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ProgressIndicator

// start class Tkw_Form_ProgressIndicator

class function Tkw_Form_ProgressIndicator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::ProgressIndicator';
end;//Tkw_Form_ProgressIndicator.GetWordNameForRegister

function Tkw_Form_ProgressIndicator.GetString: AnsiString;
 {-}
begin
 Result := 'efProgressIndicator';
end;//Tkw_Form_ProgressIndicator.GetString

type
  Tkw_ProgressIndicator_Control_ProgressBar = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ProgressBar
----
*������ �������������*:
[code]
�������::ProgressBar TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ProgressIndicator_Control_ProgressBar

// start class Tkw_ProgressIndicator_Control_ProgressBar

class function Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ProgressBar';
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister

function Tkw_ProgressIndicator_Control_ProgressBar.GetString: AnsiString;
 {-}
begin
 Result := 'ProgressBar';
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetString

class procedure Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TProgressBar);
end;//Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine

type
  Tkw_ProgressIndicator_Control_ProgressBar_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ProgressBar
----
*������ �������������*:
[code]
�������::ProgressBar:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ProgressIndicator_Control_ProgressBar_Push

// start class Tkw_ProgressIndicator_Control_ProgressBar_Push

procedure Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ProgressBar');
 inherited;
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt

class function Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ProgressBar:push';
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister

type
  TkwEfProgressIndicatorProgressBar = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .TefProgressIndicator.ProgressBar
[panel]������� ProgressBar ����� TefProgressIndicator[panel]
*��� ����������:* TProgressBar
*������:*
[code]
OBJECT VAR l_TProgressBar
 aefProgressIndicator .TefProgressIndicator.ProgressBar >>> l_TProgressBar
[code]  }
  private
  // private methods
   function ProgressBar(const aCtx: TtfwContext;
     aefProgressIndicator: TefProgressIndicator): TProgressBar;
     {* ���������� ����� ������� .TefProgressIndicator.ProgressBar }
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
  end;//TkwEfProgressIndicatorProgressBar

// start class TkwEfProgressIndicatorProgressBar

function TkwEfProgressIndicatorProgressBar.ProgressBar(const aCtx: TtfwContext;
  aefProgressIndicator: TefProgressIndicator): TProgressBar;
 {-}
begin
 Result := aefProgressIndicator.ProgressBar;
end;//TkwEfProgressIndicatorProgressBar.ProgressBar

procedure TkwEfProgressIndicatorProgressBar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefProgressIndicator : TefProgressIndicator;
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
 aCtx.rEngine.PushObj((ProgressBar(aCtx, l_aefProgressIndicator)));
end;//TkwEfProgressIndicatorProgressBar.DoDoIt

class function TkwEfProgressIndicatorProgressBar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefProgressIndicator.ProgressBar';
end;//TkwEfProgressIndicatorProgressBar.GetWordNameForRegister

procedure TkwEfProgressIndicatorProgressBar.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ProgressBar', aCtx);
end;//TkwEfProgressIndicatorProgressBar.SetValuePrim

function TkwEfProgressIndicatorProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TProgressBar);
end;//TkwEfProgressIndicatorProgressBar.GetResultTypeInfo

function TkwEfProgressIndicatorProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfProgressIndicatorProgressBar.GetAllParamsCount

function TkwEfProgressIndicatorProgressBar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefProgressIndicator)]);
end;//TkwEfProgressIndicatorProgressBar.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_ProgressIndicator
 Tkw_Form_ProgressIndicator.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ProgressIndicator_Control_ProgressBar
 Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_ProgressIndicator_Control_ProgressBar_Push
 Tkw_ProgressIndicator_Control_ProgressBar_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� efProgressIndicator_ProgressBar
 TkwEfProgressIndicatorProgressBar.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� ProgressIndicator
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefProgressIndicator));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TProgressBar
 TtfwTypeRegistrator.RegisterType(TypeInfo(TProgressBar));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.