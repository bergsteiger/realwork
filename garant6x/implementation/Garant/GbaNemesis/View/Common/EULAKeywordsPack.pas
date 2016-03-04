unit EULAKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� EULA }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\EULAKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtLabel
 , vtButton
 , eeMemoWithEditOperations
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EULA_Form
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
 Tkw_Form_EULA = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� EULA
----
*������ �������������*:
[code]
'aControl' �����::EULA TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EULA

 Tkw_EULA_Control_ShellCaptionLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel

 Tkw_EULA_Control_ShellCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� ShellCaptionLabel
----
*������ �������������*:
[code]
�������::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel_Push

 Tkw_EULA_Control_OkButton = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_OkButton

 Tkw_EULA_Control_OkButton_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� OkButton
----
*������ �������������*:
[code]
�������::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_OkButton_Push

 Tkw_EULA_Control_eeMemoWithEditOperations1 = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� eeMemoWithEditOperations1
----
*������ �������������*:
[code]
�������::eeMemoWithEditOperations1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1

 Tkw_EULA_Control_eeMemoWithEditOperations1_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� eeMemoWithEditOperations1
----
*������ �������������*:
[code]
�������::eeMemoWithEditOperations1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push

 TkwEfEULAShellCaptionLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.ShellCaptionLabel
[panel]������� ShellCaptionLabel ����� TefEULA[panel]
*��� ����������:* TvtLabel
*������:*
[code]
OBJECT VAR l_TvtLabel
 aefEULA .TefEULA.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function ShellCaptionLabel(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtLabel;
    {* ���������� ����� ������� .TefEULA.ShellCaptionLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAShellCaptionLabel

 TkwEfEULAOkButton = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.OkButton
[panel]������� OkButton ����� TefEULA[panel]
*��� ����������:* TvtButton
*������:*
[code]
OBJECT VAR l_TvtButton
 aefEULA .TefEULA.OkButton >>> l_TvtButton
[code]  }
  private
   function OkButton(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtButton;
    {* ���������� ����� ������� .TefEULA.OkButton }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAOkButton

 TkwEfEULAEeMemoWithEditOperations1 = {final} class(TtfwPropertyLike)
  {* ����� ������� .TefEULA.eeMemoWithEditOperations1
[panel]������� eeMemoWithEditOperations1 ����� TefEULA[panel]
*��� ����������:* TeeMemoWithEditOperations
*������:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aefEULA .TefEULA.eeMemoWithEditOperations1 >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function eeMemoWithEditOperations1(const aCtx: TtfwContext;
    aefEULA: TefEULA): TeeMemoWithEditOperations;
    {* ���������� ����� ������� .TefEULA.eeMemoWithEditOperations1 }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfEULAEeMemoWithEditOperations1

class function Tkw_Form_EULA.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::EULA';
end;//Tkw_Form_EULA.GetWordNameForRegister

function Tkw_Form_EULA.GetString: AnsiString;
begin
 Result := 'efEULA';
end;//Tkw_Form_EULA.GetString

class function Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel';
end;//Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister

function Tkw_EULA_Control_ShellCaptionLabel.GetString: AnsiString;
begin
 Result := 'ShellCaptionLabel';
end;//Tkw_EULA_Control_ShellCaptionLabel.GetString

class procedure Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine

procedure Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ShellCaptionLabel');
 inherited;
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::ShellCaptionLabel:push';
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister

class function Tkw_EULA_Control_OkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton';
end;//Tkw_EULA_Control_OkButton.GetWordNameForRegister

function Tkw_EULA_Control_OkButton.GetString: AnsiString;
begin
 Result := 'OkButton';
end;//Tkw_EULA_Control_OkButton.GetString

class procedure Tkw_EULA_Control_OkButton.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_EULA_Control_OkButton.RegisterInEngine

procedure Tkw_EULA_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('OkButton');
 inherited;
end;//Tkw_EULA_Control_OkButton_Push.DoDoIt

class function Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::OkButton:push';
end;//Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister

class function Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::eeMemoWithEditOperations1';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister

function Tkw_EULA_Control_eeMemoWithEditOperations1.GetString: AnsiString;
begin
 Result := 'eeMemoWithEditOperations1';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetString

class procedure Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine

procedure Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('eeMemoWithEditOperations1');
 inherited;
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt

class function Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::eeMemoWithEditOperations1:push';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister

function TkwEfEULAShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
 aefEULA: TefEULA): TvtLabel;
 {* ���������� ����� ������� .TefEULA.ShellCaptionLabel }
begin
 Result := aefEULA.ShellCaptionLabel;
end;//TkwEfEULAShellCaptionLabel.ShellCaptionLabel

procedure TkwEfEULAShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
var l_aefEULA: TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ShellCaptionLabel(aCtx, l_aefEULA));
end;//TkwEfEULAShellCaptionLabel.DoDoIt

class function TkwEfEULAShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.ShellCaptionLabel';
end;//TkwEfEULAShellCaptionLabel.GetWordNameForRegister

procedure TkwEfEULAShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ShellCaptionLabel', aCtx);
end;//TkwEfEULAShellCaptionLabel.SetValuePrim

function TkwEfEULAShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfEULAShellCaptionLabel.GetResultTypeInfo

function TkwEfEULAShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfEULAShellCaptionLabel.GetAllParamsCount

function TkwEfEULAShellCaptionLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAShellCaptionLabel.ParamsTypes

function TkwEfEULAOkButton.OkButton(const aCtx: TtfwContext;
 aefEULA: TefEULA): TvtButton;
 {* ���������� ����� ������� .TefEULA.OkButton }
begin
 Result := aefEULA.OkButton;
end;//TkwEfEULAOkButton.OkButton

procedure TkwEfEULAOkButton.DoDoIt(const aCtx: TtfwContext);
var l_aefEULA: TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(OkButton(aCtx, l_aefEULA));
end;//TkwEfEULAOkButton.DoDoIt

class function TkwEfEULAOkButton.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.OkButton';
end;//TkwEfEULAOkButton.GetWordNameForRegister

procedure TkwEfEULAOkButton.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� OkButton', aCtx);
end;//TkwEfEULAOkButton.SetValuePrim

function TkwEfEULAOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtButton);
end;//TkwEfEULAOkButton.GetResultTypeInfo

function TkwEfEULAOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfEULAOkButton.GetAllParamsCount

function TkwEfEULAOkButton.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAOkButton.ParamsTypes

function TkwEfEULAEeMemoWithEditOperations1.eeMemoWithEditOperations1(const aCtx: TtfwContext;
 aefEULA: TefEULA): TeeMemoWithEditOperations;
 {* ���������� ����� ������� .TefEULA.eeMemoWithEditOperations1 }
begin
 Result := aefEULA.eeMemoWithEditOperations1;
end;//TkwEfEULAEeMemoWithEditOperations1.eeMemoWithEditOperations1

procedure TkwEfEULAEeMemoWithEditOperations1.DoDoIt(const aCtx: TtfwContext);
var l_aefEULA: TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(eeMemoWithEditOperations1(aCtx, l_aefEULA));
end;//TkwEfEULAEeMemoWithEditOperations1.DoDoIt

class function TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefEULA.eeMemoWithEditOperations1';
end;//TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister

procedure TkwEfEULAEeMemoWithEditOperations1.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� eeMemoWithEditOperations1', aCtx);
end;//TkwEfEULAEeMemoWithEditOperations1.SetValuePrim

function TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo

function TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount

function TkwEfEULAEeMemoWithEditOperations1.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAEeMemoWithEditOperations1.ParamsTypes

initialization
 Tkw_Form_EULA.RegisterInEngine;
 {* ����������� Tkw_Form_EULA }
 Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_ShellCaptionLabel }
 Tkw_EULA_Control_ShellCaptionLabel_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_ShellCaptionLabel_Push }
 Tkw_EULA_Control_OkButton.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_OkButton }
 Tkw_EULA_Control_OkButton_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_OkButton_Push }
 Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_eeMemoWithEditOperations1 }
 Tkw_EULA_Control_eeMemoWithEditOperations1_Push.RegisterInEngine;
 {* ����������� Tkw_EULA_Control_eeMemoWithEditOperations1_Push }
 TkwEfEULAShellCaptionLabel.RegisterInEngine;
 {* ����������� efEULA_ShellCaptionLabel }
 TkwEfEULAOkButton.RegisterInEngine;
 {* ����������� efEULA_OkButton }
 TkwEfEULAEeMemoWithEditOperations1.RegisterInEngine;
 {* ����������� efEULA_eeMemoWithEditOperations1 }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefEULA));
 {* ����������� ���� EULA }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* ����������� ���� TvtButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* ����������� ���� TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
