unit MedicListSynchroViewKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "View"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/View/Inpharm/MedicListSynchroViewKeywordsPack.pas"
// �����: 04.09.2009 12:57
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 ���������� ��������::Inpharm::View::Inpharm::Inpharm::MedicListSynchroViewKeywordsPack
//
// ����� ���� ������� ��� ������� � ����������� ��������� ����� MedicListSynchroView
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
  vtPanel,
  MedicListSynchroView_Form,
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
  Tkw_Form_MedicListSynchroView = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� ����� MedicListSynchroView
----
*������ �������������*:
[code]
'aControl' �����::MedicListSynchroView TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_MedicListSynchroView

// start class Tkw_Form_MedicListSynchroView

class function Tkw_Form_MedicListSynchroView.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�����::MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetWordNameForRegister

function Tkw_Form_MedicListSynchroView.GetString: AnsiString;
 {-}
begin
 Result := 'en_MedicListSynchroView';
end;//Tkw_Form_MedicListSynchroView.GetString

type
  Tkw_MedicListSynchroView_Control_ztChild = {final scriptword} class(TtfwControlString)
   {* ����� ������� ��� �������������� �������� ztChild
----
*������ �������������*:
[code]
�������::ztChild TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_MedicListSynchroView_Control_ztChild

// start class Tkw_MedicListSynchroView_Control_ztChild

class function Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetWordNameForRegister

function Tkw_MedicListSynchroView_Control_ztChild.GetString: AnsiString;
 {-}
begin
 Result := 'ztChild';
end;//Tkw_MedicListSynchroView_Control_ztChild.GetString

class procedure Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine

type
  Tkw_MedicListSynchroView_Control_ztChild_Push = {final scriptword} class(TkwBynameControlPush)
   {* ����� ������� ��� �������� ztChild
----
*������ �������������*:
[code]
�������::ztChild:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_MedicListSynchroView_Control_ztChild_Push

// start class Tkw_MedicListSynchroView_Control_ztChild_Push

procedure Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ztChild');
 inherited;
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.DoDoIt

class function Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '�������::ztChild:push';
end;//Tkw_MedicListSynchroView_Control_ztChild_Push.GetWordNameForRegister

type
  TkwEnMedicListSynchroViewZtChild = {final scriptword} class(TtfwPropertyLike)
   {* ����� ������� .Ten_MedicListSynchroView.ztChild
[panel]������� ztChild ����� Ten_MedicListSynchroView[panel]
*��� ����������:* TvtPanel
*������:*
[code]
OBJECT VAR l_TvtPanel
 aen_MedicListSynchroView .Ten_MedicListSynchroView.ztChild >>> l_TvtPanel
[code]  }
  private
  // private methods
   function ZtChild(const aCtx: TtfwContext;
     aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
     {* ���������� ����� ������� .Ten_MedicListSynchroView.ztChild }
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
  end;//TkwEnMedicListSynchroViewZtChild

// start class TkwEnMedicListSynchroViewZtChild

function TkwEnMedicListSynchroViewZtChild.ZtChild(const aCtx: TtfwContext;
  aen_MedicListSynchroView: Ten_MedicListSynchroView): TvtPanel;
 {-}
begin
 Result := aen_MedicListSynchroView.ztChild;
end;//TkwEnMedicListSynchroViewZtChild.ZtChild

procedure TkwEnMedicListSynchroViewZtChild.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aen_MedicListSynchroView : Ten_MedicListSynchroView;
begin
 try
  l_aen_MedicListSynchroView := Ten_MedicListSynchroView(aCtx.rEngine.PopObjAs(Ten_MedicListSynchroView));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_MedicListSynchroView: Ten_MedicListSynchroView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ZtChild(aCtx, l_aen_MedicListSynchroView)));
end;//TkwEnMedicListSynchroViewZtChild.DoDoIt

class function TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.Ten_MedicListSynchroView.ztChild';
end;//TkwEnMedicListSynchroViewZtChild.GetWordNameForRegister

procedure TkwEnMedicListSynchroViewZtChild.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ztChild', aCtx);
end;//TkwEnMedicListSynchroViewZtChild.SetValuePrim

function TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtPanel);
end;//TkwEnMedicListSynchroViewZtChild.GetResultTypeInfo

function TkwEnMedicListSynchroViewZtChild.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEnMedicListSynchroViewZtChild.GetAllParamsCount

function TkwEnMedicListSynchroViewZtChild.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_MedicListSynchroView)]);
end;//TkwEnMedicListSynchroViewZtChild.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_Form_MedicListSynchroView
 Tkw_Form_MedicListSynchroView.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MedicListSynchroView_Control_ztChild
 Tkw_MedicListSynchroView_Control_ztChild.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� Tkw_MedicListSynchroView_Control_ztChild_Push
 Tkw_MedicListSynchroView_Control_ztChild_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� en_MedicListSynchroView_ztChild
 TkwEnMedicListSynchroViewZtChild.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� MedicListSynchroView
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_MedicListSynchroView));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// ����������� ���� TvtPanel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.