unit RememberPasswordKeywordsPack;
 {* ����� ���� ������� ��� ������� � ����������� ��������� ����� RememberPassword }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPasswordKeywordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "RememberPasswordKeywordsPack" MUID: (4A93EC78039E_Pack)

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
 , RememberPassword_Form
 , tfwPropertyLike
 , vtLabel
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , ElPopBtn
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4A93EC78039E_Packimpl_uses*
 //#UC END# *4A93EC78039E_Packimpl_uses*
;

type
 TkwRememberPasswordFormEMailLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRememberPasswordForm.EMailLabel }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* ���������� ����� ������� .TRememberPasswordForm.EMailLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRememberPasswordFormEMailLabel

 TkwRememberPasswordFormHintLabel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRememberPasswordForm.HintLabel }
  private
   function HintLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* ���������� ����� ������� .TRememberPasswordForm.HintLabel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRememberPasswordFormHintLabel

 TkwRememberPasswordFormBtnCancel = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRememberPasswordForm.btnCancel }
  private
   function btnCancel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* ���������� ����� ������� .TRememberPasswordForm.btnCancel }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRememberPasswordFormBtnCancel

 TkwRememberPasswordFormBtnSend = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRememberPasswordForm.btnSend }
  private
   function btnSend(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* ���������� ����� ������� .TRememberPasswordForm.btnSend }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRememberPasswordFormBtnSend

 TkwRememberPasswordFormEdEmail = {final} class(TtfwPropertyLike)
  {* ����� ������� .TRememberPasswordForm.edEmail }
  private
   function edEmail(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
    {* ���������� ����� ������� .TRememberPasswordForm.edEmail }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwRememberPasswordFormEdEmail

 Tkw_Form_RememberPassword = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� ����� RememberPassword
----
*������ �������������*:
[code]�����::RememberPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_RememberPassword

 Tkw_RememberPassword_Control_EMailLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� EMailLabel
----
*������ �������������*:
[code]�������::EMailLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_EMailLabel

 Tkw_RememberPassword_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� EMailLabel
----
*������ �������������*:
[code]�������::EMailLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_EMailLabel_Push

 Tkw_RememberPassword_Control_HintLabel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� HintLabel
----
*������ �������������*:
[code]�������::HintLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_HintLabel

 Tkw_RememberPassword_Control_HintLabel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� HintLabel
----
*������ �������������*:
[code]�������::HintLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_HintLabel_Push

 Tkw_RememberPassword_Control_btnCancel = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnCancel
----
*������ �������������*:
[code]�������::btnCancel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnCancel

 Tkw_RememberPassword_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnCancel
----
*������ �������������*:
[code]�������::btnCancel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnCancel_Push

 Tkw_RememberPassword_Control_btnSend = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� btnSend
----
*������ �������������*:
[code]�������::btnSend TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnSend

 Tkw_RememberPassword_Control_btnSend_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� btnSend
----
*������ �������������*:
[code]�������::btnSend:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnSend_Push

 Tkw_RememberPassword_Control_edEmail = {final} class(TtfwControlString)
  {* ����� ������� ��� �������������� �������� edEmail
----
*������ �������������*:
[code]�������::edEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_edEmail

 Tkw_RememberPassword_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* ����� ������� ��� �������� edEmail
----
*������ �������������*:
[code]�������::edEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_edEmail_Push

function TkwRememberPasswordFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* ���������� ����� ������� .TRememberPasswordForm.EMailLabel }
begin
 Result := aRememberPasswordForm.EMailLabel;
end;//TkwRememberPasswordFormEMailLabel.EMailLabel

class function TkwRememberPasswordFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.EMailLabel';
end;//TkwRememberPasswordFormEMailLabel.GetWordNameForRegister

function TkwRememberPasswordFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRememberPasswordFormEMailLabel.GetResultTypeInfo

function TkwRememberPasswordFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRememberPasswordFormEMailLabel.GetAllParamsCount

function TkwRememberPasswordFormEMailLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormEMailLabel.ParamsTypes

procedure TkwRememberPasswordFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� EMailLabel', aCtx);
end;//TkwRememberPasswordFormEMailLabel.SetValuePrim

procedure TkwRememberPasswordFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormEMailLabel.DoDoIt

function TkwRememberPasswordFormHintLabel.HintLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* ���������� ����� ������� .TRememberPasswordForm.HintLabel }
begin
 Result := aRememberPasswordForm.HintLabel;
end;//TkwRememberPasswordFormHintLabel.HintLabel

class function TkwRememberPasswordFormHintLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.HintLabel';
end;//TkwRememberPasswordFormHintLabel.GetWordNameForRegister

function TkwRememberPasswordFormHintLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRememberPasswordFormHintLabel.GetResultTypeInfo

function TkwRememberPasswordFormHintLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRememberPasswordFormHintLabel.GetAllParamsCount

function TkwRememberPasswordFormHintLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormHintLabel.ParamsTypes

procedure TkwRememberPasswordFormHintLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� HintLabel', aCtx);
end;//TkwRememberPasswordFormHintLabel.SetValuePrim

procedure TkwRememberPasswordFormHintLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HintLabel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormHintLabel.DoDoIt

function TkwRememberPasswordFormBtnCancel.btnCancel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* ���������� ����� ������� .TRememberPasswordForm.btnCancel }
begin
 Result := aRememberPasswordForm.btnCancel;
end;//TkwRememberPasswordFormBtnCancel.btnCancel

class function TkwRememberPasswordFormBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.btnCancel';
end;//TkwRememberPasswordFormBtnCancel.GetWordNameForRegister

function TkwRememberPasswordFormBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwRememberPasswordFormBtnCancel.GetResultTypeInfo

function TkwRememberPasswordFormBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRememberPasswordFormBtnCancel.GetAllParamsCount

function TkwRememberPasswordFormBtnCancel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormBtnCancel.ParamsTypes

procedure TkwRememberPasswordFormBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnCancel', aCtx);
end;//TkwRememberPasswordFormBtnCancel.SetValuePrim

procedure TkwRememberPasswordFormBtnCancel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnCancel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormBtnCancel.DoDoIt

function TkwRememberPasswordFormBtnSend.btnSend(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* ���������� ����� ������� .TRememberPasswordForm.btnSend }
begin
 Result := aRememberPasswordForm.btnSend;
end;//TkwRememberPasswordFormBtnSend.btnSend

class function TkwRememberPasswordFormBtnSend.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.btnSend';
end;//TkwRememberPasswordFormBtnSend.GetWordNameForRegister

function TkwRememberPasswordFormBtnSend.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwRememberPasswordFormBtnSend.GetResultTypeInfo

function TkwRememberPasswordFormBtnSend.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRememberPasswordFormBtnSend.GetAllParamsCount

function TkwRememberPasswordFormBtnSend.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormBtnSend.ParamsTypes

procedure TkwRememberPasswordFormBtnSend.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� btnSend', aCtx);
end;//TkwRememberPasswordFormBtnSend.SetValuePrim

procedure TkwRememberPasswordFormBtnSend.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnSend(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormBtnSend.DoDoIt

function TkwRememberPasswordFormEdEmail.edEmail(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
 {* ���������� ����� ������� .TRememberPasswordForm.edEmail }
begin
 Result := aRememberPasswordForm.edEmail;
end;//TkwRememberPasswordFormEdEmail.edEmail

class function TkwRememberPasswordFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.edEmail';
end;//TkwRememberPasswordFormEdEmail.GetWordNameForRegister

function TkwRememberPasswordFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwRememberPasswordFormEdEmail.GetResultTypeInfo

function TkwRememberPasswordFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwRememberPasswordFormEdEmail.GetAllParamsCount

function TkwRememberPasswordFormEdEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormEdEmail.ParamsTypes

procedure TkwRememberPasswordFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� edEmail', aCtx);
end;//TkwRememberPasswordFormEdEmail.SetValuePrim

procedure TkwRememberPasswordFormEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(edEmail(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormEdEmail.DoDoIt

function Tkw_Form_RememberPassword.GetString: AnsiString;
begin
 Result := 'RememberPasswordForm';
end;//Tkw_Form_RememberPassword.GetString

class procedure Tkw_Form_RememberPassword.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TRememberPasswordForm);
end;//Tkw_Form_RememberPassword.RegisterInEngine

class function Tkw_Form_RememberPassword.GetWordNameForRegister: AnsiString;
begin
 Result := '�����::RememberPassword';
end;//Tkw_Form_RememberPassword.GetWordNameForRegister

function Tkw_RememberPassword_Control_EMailLabel.GetString: AnsiString;
begin
 Result := 'EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetString

class procedure Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine

class function Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::EMailLabel:push';
end;//Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister

function Tkw_RememberPassword_Control_HintLabel.GetString: AnsiString;
begin
 Result := 'HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetString

class procedure Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RememberPassword_Control_HintLabel.RegisterInEngine

class function Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HintLabel');
 inherited;
end;//Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::HintLabel:push';
end;//Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnCancel.GetString: AnsiString;
begin
 Result := 'btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetString

class procedure Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_RememberPassword_Control_btnCancel.RegisterInEngine

class function Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnCancel:push';
end;//Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnSend.GetString: AnsiString;
begin
 Result := 'btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetString

class procedure Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_RememberPassword_Control_btnSend.RegisterInEngine

class function Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_btnSend_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnSend');
 inherited;
end;//Tkw_RememberPassword_Control_btnSend_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::btnSend:push';
end;//Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister

function Tkw_RememberPassword_Control_edEmail.GetString: AnsiString;
begin
 Result := 'edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetString

class procedure Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_RememberPassword_Control_edEmail.RegisterInEngine

class function Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_RememberPassword_Control_edEmail_Push.DoDoIt

class function Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := '�������::edEmail:push';
end;//Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister

initialization
 TkwRememberPasswordFormEMailLabel.RegisterInEngine;
 {* ����������� RememberPasswordForm_EMailLabel }
 TkwRememberPasswordFormHintLabel.RegisterInEngine;
 {* ����������� RememberPasswordForm_HintLabel }
 TkwRememberPasswordFormBtnCancel.RegisterInEngine;
 {* ����������� RememberPasswordForm_btnCancel }
 TkwRememberPasswordFormBtnSend.RegisterInEngine;
 {* ����������� RememberPasswordForm_btnSend }
 TkwRememberPasswordFormEdEmail.RegisterInEngine;
 {* ����������� RememberPasswordForm_edEmail }
 Tkw_Form_RememberPassword.RegisterInEngine;
 {* ����������� Tkw_Form_RememberPassword }
 Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_EMailLabel }
 Tkw_RememberPassword_Control_EMailLabel_Push.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_EMailLabel_Push }
 Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_HintLabel }
 Tkw_RememberPassword_Control_HintLabel_Push.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_HintLabel_Push }
 Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_btnCancel }
 Tkw_RememberPassword_Control_btnCancel_Push.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_btnCancel_Push }
 Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_btnSend }
 Tkw_RememberPassword_Control_btnSend_Push.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_btnSend_Push }
 Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_edEmail }
 Tkw_RememberPassword_Control_edEmail_Push.RegisterInEngine;
 {* ����������� Tkw_RememberPassword_Control_edEmail_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRememberPasswordForm));
 {* ����������� ���� TRememberPasswordForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* ����������� ���� TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* ����������� ���� TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* ����������� ���� TnscEdit }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
