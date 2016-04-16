unit PageSetupKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� PageSetup }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\PageSetupKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "PageSetupKeywordsPack" MUID: (0BBFEB6E713F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtGroupBox
 {$If Defined(Nemesis)}
 , nscPageControl
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , PageSetup_Form
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
 Tkw_Form_PageSetup = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� PageSetup
----
*������ �������������*:
[code]
'aControl' �����::PageSetup TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PageSetup

 Tkw_PageSetup_Control_PreviewGroupBox = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� PreviewGroupBox
----
*������ �������������*:
[code]
�������::PreviewGroupBox TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_PreviewGroupBox

 Tkw_PageSetup_Control_PreviewGroupBox_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� PreviewGroupBox
----
*������ �������������*:
[code]
�������::PreviewGroupBox:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_PreviewGroupBox_Push

 Tkw_PageSetup_Control_SettingsPageControl = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� SettingsPageControl
----
*������ �������������*:
[code]
�������::SettingsPageControl TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_SettingsPageControl

 Tkw_PageSetup_Control_SettingsPageControl_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* ����� ������� ��� �������� SettingsPageControl
----
*������ �������������*:
[code]
�������::SettingsPageControl:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_SettingsPageControl_Push

 TkwEnPageSetupPreviewGroupBox = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PageSetup.PreviewGroupBox
[panel]������� PreviewGroupBox ����� Ten_PageSetup[panel]
*��� ����������:* TvtGroupBox
*������:*
[code]
OBJECT VAR l_TvtGroupBox
 aen_PageSetup .Ten_PageSetup.PreviewGroupBox >>> l_TvtGroupBox
[code]  }
  private
   function PreviewGroupBox(const aCtx: TtfwContext;
    aen_PageSetup: Ten_PageSetup): TvtGroupBox;
    {* ���������� ����� ������� .Ten_PageSetup.PreviewGroupBox }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPageSetupPreviewGroupBox

 TkwEnPageSetupSettingsPageControl = {final} class(TtfwPropertyLike)
  {* ����� ������� .Ten_PageSetup.SettingsPageControl
[panel]������� SettingsPageControl ����� Ten_PageSetup[panel]
*��� ����������:* TnscPageControl
*������:*
[code]
OBJECT VAR l_TnscPageControl
 aen_PageSetup .Ten_PageSetup.SettingsPageControl >>> l_TnscPageControl
[code]  }
  private
   function SettingsPageControl(const aCtx: TtfwContext;
    aen_PageSetup: Ten_PageSetup): TnscPageControl;
    {* ���������� ����� ������� .Ten_PageSetup.SettingsPageControl }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPageSetupSettingsPageControl

function Tkw_Form_PageSetup.GetString: AnsiString;
begin
 Result := 'en_PageSetup';
end;//Tkw_Form_PageSetup.GetString

class procedure Tkw_Form_PageSetup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_PageSetup);
end;//Tkw_Form_PageSetup.RegisterInEngine

class function Tkw_Form_PageSetup.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::PageSetup';
end;//Tkw_Form_PageSetup.GetWordNameForRegister

function Tkw_PageSetup_Control_PreviewGroupBox.GetString: AnsiString;
begin
 Result := 'PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetString

class procedure Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine

class function Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister

procedure Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PreviewGroupBox');
 inherited;
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt

class function Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::PreviewGroupBox:push';
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister

function Tkw_PageSetup_Control_SettingsPageControl.GetString: AnsiString;
begin
 Result := 'SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetString

class procedure Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscPageControl);
end;//Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine

class function Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister

procedure Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SettingsPageControl');
 inherited;
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt

class function Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::SettingsPageControl:push';
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister

function TkwEnPageSetupPreviewGroupBox.PreviewGroupBox(const aCtx: TtfwContext;
 aen_PageSetup: Ten_PageSetup): TvtGroupBox;
 {* ���������� ����� ������� .Ten_PageSetup.PreviewGroupBox }
begin
 Result := aen_PageSetup.PreviewGroupBox;
end;//TkwEnPageSetupPreviewGroupBox.PreviewGroupBox

procedure TkwEnPageSetupPreviewGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aen_PageSetup: Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PreviewGroupBox(aCtx, l_aen_PageSetup));
end;//TkwEnPageSetupPreviewGroupBox.DoDoIt

procedure TkwEnPageSetupPreviewGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� PreviewGroupBox', aCtx);
end;//TkwEnPageSetupPreviewGroupBox.SetValuePrim

function TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo

function TkwEnPageSetupPreviewGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPageSetupPreviewGroupBox.GetAllParamsCount

function TkwEnPageSetupPreviewGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupPreviewGroupBox.ParamsTypes

class function TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PageSetup.PreviewGroupBox';
end;//TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister

function TkwEnPageSetupSettingsPageControl.SettingsPageControl(const aCtx: TtfwContext;
 aen_PageSetup: Ten_PageSetup): TnscPageControl;
 {* ���������� ����� ������� .Ten_PageSetup.SettingsPageControl }
begin
 Result := aen_PageSetup.SettingsPageControl;
end;//TkwEnPageSetupSettingsPageControl.SettingsPageControl

procedure TkwEnPageSetupSettingsPageControl.DoDoIt(const aCtx: TtfwContext);
var l_aen_PageSetup: Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SettingsPageControl(aCtx, l_aen_PageSetup));
end;//TkwEnPageSetupSettingsPageControl.DoDoIt

procedure TkwEnPageSetupSettingsPageControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� SettingsPageControl', aCtx);
end;//TkwEnPageSetupSettingsPageControl.SetValuePrim

function TkwEnPageSetupSettingsPageControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscPageControl);
end;//TkwEnPageSetupSettingsPageControl.GetResultTypeInfo

function TkwEnPageSetupSettingsPageControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPageSetupSettingsPageControl.GetAllParamsCount

function TkwEnPageSetupSettingsPageControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupSettingsPageControl.ParamsTypes

class function TkwEnPageSetupSettingsPageControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PageSetup.SettingsPageControl';
end;//TkwEnPageSetupSettingsPageControl.GetWordNameForRegister

initialization
 Tkw_Form_PageSetup.RegisterInEngine;
 {* ����������� Tkw_Form_PageSetup }
 Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
 {* ����������� Tkw_PageSetup_Control_PreviewGroupBox }
 Tkw_PageSetup_Control_PreviewGroupBox_Push.RegisterInEngine;
 {* ����������� Tkw_PageSetup_Control_PreviewGroupBox_Push }
 Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
 {* ����������� Tkw_PageSetup_Control_SettingsPageControl }
 Tkw_PageSetup_Control_SettingsPageControl_Push.RegisterInEngine;
 {* ����������� Tkw_PageSetup_Control_SettingsPageControl_Push }
 TkwEnPageSetupPreviewGroupBox.RegisterInEngine;
 {* ����������� en_PageSetup_PreviewGroupBox }
 TkwEnPageSetupSettingsPageControl.RegisterInEngine;
 {* ����������� en_PageSetup_SettingsPageControl }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PageSetup));
 {* ����������� ���� PageSetup }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* ����������� ���� TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPageControl));
 {* ����������� ���� TnscPageControl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
