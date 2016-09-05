unit RememberPasswordKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы RememberPassword }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\Forms\RememberPasswordKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "RememberPasswordKeywordsPack" MUID: (4A93EC78039E_Pack)

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
  {* Слово скрипта .TRememberPasswordForm.EMailLabel }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* Реализация слова скрипта .TRememberPasswordForm.EMailLabel }
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
  {* Слово скрипта .TRememberPasswordForm.HintLabel }
  private
   function HintLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* Реализация слова скрипта .TRememberPasswordForm.HintLabel }
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
  {* Слово скрипта .TRememberPasswordForm.btnCancel }
  private
   function btnCancel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* Реализация слова скрипта .TRememberPasswordForm.btnCancel }
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
  {* Слово скрипта .TRememberPasswordForm.btnSend }
  private
   function btnSend(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* Реализация слова скрипта .TRememberPasswordForm.btnSend }
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
  {* Слово скрипта .TRememberPasswordForm.edEmail }
  private
   function edEmail(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
    {* Реализация слова скрипта .TRememberPasswordForm.edEmail }
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
  {* Слово словаря для идентификатора формы RememberPassword
----
*Пример использования*:
[code]форма::RememberPassword TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_RememberPassword

 Tkw_RememberPassword_Control_EMailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]контрол::EMailLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_EMailLabel

 Tkw_RememberPassword_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]контрол::EMailLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_EMailLabel_Push

 Tkw_RememberPassword_Control_HintLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HintLabel
----
*Пример использования*:
[code]контрол::HintLabel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_HintLabel

 Tkw_RememberPassword_Control_HintLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HintLabel
----
*Пример использования*:
[code]контрол::HintLabel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_HintLabel_Push

 Tkw_RememberPassword_Control_btnCancel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]контрол::btnCancel TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnCancel

 Tkw_RememberPassword_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]контрол::btnCancel:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnCancel_Push

 Tkw_RememberPassword_Control_btnSend = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnSend
----
*Пример использования*:
[code]контрол::btnSend TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnSend

 Tkw_RememberPassword_Control_btnSend_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnSend
----
*Пример использования*:
[code]контрол::btnSend:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnSend_Push

 Tkw_RememberPassword_Control_edEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]контрол::edEmail TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_edEmail

 Tkw_RememberPassword_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]контрол::edEmail:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_edEmail_Push

function TkwRememberPasswordFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* Реализация слова скрипта .TRememberPasswordForm.EMailLabel }
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
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwRememberPasswordFormEMailLabel.SetValuePrim

procedure TkwRememberPasswordFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(EMailLabel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormEMailLabel.DoDoIt

function TkwRememberPasswordFormHintLabel.HintLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* Реализация слова скрипта .TRememberPasswordForm.HintLabel }
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
 RunnerError('Нельзя присваивать значение readonly свойству HintLabel', aCtx);
end;//TkwRememberPasswordFormHintLabel.SetValuePrim

procedure TkwRememberPasswordFormHintLabel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(HintLabel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormHintLabel.DoDoIt

function TkwRememberPasswordFormBtnCancel.btnCancel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* Реализация слова скрипта .TRememberPasswordForm.btnCancel }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnCancel', aCtx);
end;//TkwRememberPasswordFormBtnCancel.SetValuePrim

procedure TkwRememberPasswordFormBtnCancel.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnCancel(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormBtnCancel.DoDoIt

function TkwRememberPasswordFormBtnSend.btnSend(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* Реализация слова скрипта .TRememberPasswordForm.btnSend }
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
 RunnerError('Нельзя присваивать значение readonly свойству btnSend', aCtx);
end;//TkwRememberPasswordFormBtnSend.SetValuePrim

procedure TkwRememberPasswordFormBtnSend.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(btnSend(aCtx, l_aRememberPasswordForm));
end;//TkwRememberPasswordFormBtnSend.DoDoIt

function TkwRememberPasswordFormEdEmail.edEmail(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
 {* Реализация слова скрипта .TRememberPasswordForm.edEmail }
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
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwRememberPasswordFormEdEmail.SetValuePrim

procedure TkwRememberPasswordFormEdEmail.DoDoIt(const aCtx: TtfwContext);
var l_aRememberPasswordForm: TRememberPasswordForm;
begin
 try
  l_aRememberPasswordForm := TRememberPasswordForm(aCtx.rEngine.PopObjAs(TRememberPasswordForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aRememberPasswordForm: TRememberPasswordForm : ' + E.Message, aCtx);
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
 Result := 'форма::RememberPassword';
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
 Result := 'контрол::EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
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
 Result := 'контрол::HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('HintLabel');
 inherited;
end;//Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HintLabel:push';
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
 Result := 'контрол::btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel:push';
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
 Result := 'контрол::btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_btnSend_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('btnSend');
 inherited;
end;//Tkw_RememberPassword_Control_btnSend_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnSend:push';
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
 Result := 'контрол::edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister

procedure Tkw_RememberPassword_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_RememberPassword_Control_edEmail_Push.DoDoIt

class function Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister

initialization
 TkwRememberPasswordFormEMailLabel.RegisterInEngine;
 {* Регистрация RememberPasswordForm_EMailLabel }
 TkwRememberPasswordFormHintLabel.RegisterInEngine;
 {* Регистрация RememberPasswordForm_HintLabel }
 TkwRememberPasswordFormBtnCancel.RegisterInEngine;
 {* Регистрация RememberPasswordForm_btnCancel }
 TkwRememberPasswordFormBtnSend.RegisterInEngine;
 {* Регистрация RememberPasswordForm_btnSend }
 TkwRememberPasswordFormEdEmail.RegisterInEngine;
 {* Регистрация RememberPasswordForm_edEmail }
 Tkw_Form_RememberPassword.RegisterInEngine;
 {* Регистрация Tkw_Form_RememberPassword }
 Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_EMailLabel }
 Tkw_RememberPassword_Control_EMailLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_EMailLabel_Push }
 Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_HintLabel }
 Tkw_RememberPassword_Control_HintLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_HintLabel_Push }
 Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_btnCancel }
 Tkw_RememberPassword_Control_btnCancel_Push.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_btnCancel_Push }
 Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_btnSend }
 Tkw_RememberPassword_Control_btnSend_Push.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_btnSend_Push }
 Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_edEmail }
 Tkw_RememberPassword_Control_edEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_RememberPassword_Control_edEmail_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRememberPasswordForm));
 {* Регистрация типа TRememberPasswordForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
