unit RememberPasswordKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/RememberPasswordKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::RememberPasswordKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы RememberPassword
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
uses
  RememberPassword_Form
  {$If defined(Nemesis)}
  ,
  nscComboBox
  {$IfEnd} //Nemesis
  ,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  ElPopBtn,
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
  Tkw_Form_RememberPassword = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы RememberPassword
----
*Пример использования*:
[code]
'aControl' форма::RememberPassword TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_RememberPassword

// start class Tkw_Form_RememberPassword

class function Tkw_Form_RememberPassword.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::RememberPassword';
end;//Tkw_Form_RememberPassword.GetWordNameForRegister

function Tkw_Form_RememberPassword.GetString: AnsiString;
 {-}
begin
 Result := 'RememberPasswordForm';
end;//Tkw_Form_RememberPassword.GetString

type
  Tkw_RememberPassword_Control_EMailLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RememberPassword_Control_EMailLabel

// start class Tkw_RememberPassword_Control_EMailLabel

class function Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister

function Tkw_RememberPassword_Control_EMailLabel.GetString: AnsiString;
 {-}
begin
 Result := 'EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetString

class procedure Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine

type
  Tkw_RememberPassword_Control_EMailLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RememberPassword_Control_EMailLabel_Push

// start class Tkw_RememberPassword_Control_EMailLabel_Push

procedure Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('EMailLabel');
 inherited;
end;//Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister

type
  Tkw_RememberPassword_Control_HintLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола HintLabel
----
*Пример использования*:
[code]
контрол::HintLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RememberPassword_Control_HintLabel

// start class Tkw_RememberPassword_Control_HintLabel

class function Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister

function Tkw_RememberPassword_Control_HintLabel.GetString: AnsiString;
 {-}
begin
 Result := 'HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetString

class procedure Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_RememberPassword_Control_HintLabel.RegisterInEngine

type
  Tkw_RememberPassword_Control_HintLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола HintLabel
----
*Пример использования*:
[code]
контрол::HintLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RememberPassword_Control_HintLabel_Push

// start class Tkw_RememberPassword_Control_HintLabel_Push

procedure Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('HintLabel');
 inherited;
end;//Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::HintLabel:push';
end;//Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister

type
  Tkw_RememberPassword_Control_btnCancel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RememberPassword_Control_btnCancel

// start class Tkw_RememberPassword_Control_btnCancel

class function Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnCancel.GetString: AnsiString;
 {-}
begin
 Result := 'btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetString

class procedure Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_RememberPassword_Control_btnCancel.RegisterInEngine

type
  Tkw_RememberPassword_Control_btnCancel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RememberPassword_Control_btnCancel_Push

// start class Tkw_RememberPassword_Control_btnCancel_Push

procedure Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnCancel');
 inherited;
end;//Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister

type
  Tkw_RememberPassword_Control_btnSend = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола btnSend
----
*Пример использования*:
[code]
контрол::btnSend TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RememberPassword_Control_btnSend

// start class Tkw_RememberPassword_Control_btnSend

class function Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnSend.GetString: AnsiString;
 {-}
begin
 Result := 'btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetString

class procedure Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TElPopupButton);
end;//Tkw_RememberPassword_Control_btnSend.RegisterInEngine

type
  Tkw_RememberPassword_Control_btnSend_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола btnSend
----
*Пример использования*:
[code]
контрол::btnSend:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RememberPassword_Control_btnSend_Push

// start class Tkw_RememberPassword_Control_btnSend_Push

procedure Tkw_RememberPassword_Control_btnSend_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('btnSend');
 inherited;
end;//Tkw_RememberPassword_Control_btnSend_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::btnSend:push';
end;//Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister

type
  Tkw_RememberPassword_Control_edEmail = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_RememberPassword_Control_edEmail

// start class Tkw_RememberPassword_Control_edEmail

class function Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister

function Tkw_RememberPassword_Control_edEmail.GetString: AnsiString;
 {-}
begin
 Result := 'edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetString

class procedure Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_RememberPassword_Control_edEmail.RegisterInEngine

type
  Tkw_RememberPassword_Control_edEmail_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_RememberPassword_Control_edEmail_Push

// start class Tkw_RememberPassword_Control_edEmail_Push

procedure Tkw_RememberPassword_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('edEmail');
 inherited;
end;//Tkw_RememberPassword_Control_edEmail_Push.DoDoIt

class function Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister

type
  TkwRememberPasswordFormEMailLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRememberPasswordForm.EMailLabel
[panel]Контрол EMailLabel формы TRememberPasswordForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRememberPasswordForm .TRememberPasswordForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function EMailLabel(const aCtx: TtfwContext;
     aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
     {* Реализация слова скрипта .TRememberPasswordForm.EMailLabel }
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
  end;//TkwRememberPasswordFormEMailLabel

// start class TkwRememberPasswordFormEMailLabel

function TkwRememberPasswordFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
  aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {-}
begin
 Result := aRememberPasswordForm.EMailLabel;
end;//TkwRememberPasswordFormEMailLabel.EMailLabel

procedure TkwRememberPasswordFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRememberPasswordForm : TRememberPasswordForm;
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
 aCtx.rEngine.PushObj((EMailLabel(aCtx, l_aRememberPasswordForm)));
end;//TkwRememberPasswordFormEMailLabel.DoDoIt

class function TkwRememberPasswordFormEMailLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRememberPasswordForm.EMailLabel';
end;//TkwRememberPasswordFormEMailLabel.GetWordNameForRegister

procedure TkwRememberPasswordFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству EMailLabel', aCtx);
end;//TkwRememberPasswordFormEMailLabel.SetValuePrim

function TkwRememberPasswordFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRememberPasswordFormEMailLabel.GetResultTypeInfo

function TkwRememberPasswordFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRememberPasswordFormEMailLabel.GetAllParamsCount

function TkwRememberPasswordFormEMailLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormEMailLabel.ParamsTypes

type
  TkwRememberPasswordFormHintLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRememberPasswordForm.HintLabel
[panel]Контрол HintLabel формы TRememberPasswordForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRememberPasswordForm .TRememberPasswordForm.HintLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function HintLabel(const aCtx: TtfwContext;
     aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
     {* Реализация слова скрипта .TRememberPasswordForm.HintLabel }
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
  end;//TkwRememberPasswordFormHintLabel

// start class TkwRememberPasswordFormHintLabel

function TkwRememberPasswordFormHintLabel.HintLabel(const aCtx: TtfwContext;
  aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {-}
begin
 Result := aRememberPasswordForm.HintLabel;
end;//TkwRememberPasswordFormHintLabel.HintLabel

procedure TkwRememberPasswordFormHintLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRememberPasswordForm : TRememberPasswordForm;
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
 aCtx.rEngine.PushObj((HintLabel(aCtx, l_aRememberPasswordForm)));
end;//TkwRememberPasswordFormHintLabel.DoDoIt

class function TkwRememberPasswordFormHintLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRememberPasswordForm.HintLabel';
end;//TkwRememberPasswordFormHintLabel.GetWordNameForRegister

procedure TkwRememberPasswordFormHintLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству HintLabel', aCtx);
end;//TkwRememberPasswordFormHintLabel.SetValuePrim

function TkwRememberPasswordFormHintLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwRememberPasswordFormHintLabel.GetResultTypeInfo

function TkwRememberPasswordFormHintLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRememberPasswordFormHintLabel.GetAllParamsCount

function TkwRememberPasswordFormHintLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormHintLabel.ParamsTypes

type
  TkwRememberPasswordFormBtnCancel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRememberPasswordForm.btnCancel
[panel]Контрол btnCancel формы TRememberPasswordForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aRememberPasswordForm .TRememberPasswordForm.btnCancel >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function BtnCancel(const aCtx: TtfwContext;
     aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
     {* Реализация слова скрипта .TRememberPasswordForm.btnCancel }
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
  end;//TkwRememberPasswordFormBtnCancel

// start class TkwRememberPasswordFormBtnCancel

function TkwRememberPasswordFormBtnCancel.BtnCancel(const aCtx: TtfwContext;
  aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {-}
begin
 Result := aRememberPasswordForm.btnCancel;
end;//TkwRememberPasswordFormBtnCancel.BtnCancel

procedure TkwRememberPasswordFormBtnCancel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRememberPasswordForm : TRememberPasswordForm;
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
 aCtx.rEngine.PushObj((BtnCancel(aCtx, l_aRememberPasswordForm)));
end;//TkwRememberPasswordFormBtnCancel.DoDoIt

class function TkwRememberPasswordFormBtnCancel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRememberPasswordForm.btnCancel';
end;//TkwRememberPasswordFormBtnCancel.GetWordNameForRegister

procedure TkwRememberPasswordFormBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnCancel', aCtx);
end;//TkwRememberPasswordFormBtnCancel.SetValuePrim

function TkwRememberPasswordFormBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwRememberPasswordFormBtnCancel.GetResultTypeInfo

function TkwRememberPasswordFormBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRememberPasswordFormBtnCancel.GetAllParamsCount

function TkwRememberPasswordFormBtnCancel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormBtnCancel.ParamsTypes

type
  TkwRememberPasswordFormBtnSend = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRememberPasswordForm.btnSend
[panel]Контрол btnSend формы TRememberPasswordForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aRememberPasswordForm .TRememberPasswordForm.btnSend >>> l_TElPopupButton
[code]  }
  private
  // private methods
   function BtnSend(const aCtx: TtfwContext;
     aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
     {* Реализация слова скрипта .TRememberPasswordForm.btnSend }
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
  end;//TkwRememberPasswordFormBtnSend

// start class TkwRememberPasswordFormBtnSend

function TkwRememberPasswordFormBtnSend.BtnSend(const aCtx: TtfwContext;
  aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {-}
begin
 Result := aRememberPasswordForm.btnSend;
end;//TkwRememberPasswordFormBtnSend.BtnSend

procedure TkwRememberPasswordFormBtnSend.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRememberPasswordForm : TRememberPasswordForm;
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
 aCtx.rEngine.PushObj((BtnSend(aCtx, l_aRememberPasswordForm)));
end;//TkwRememberPasswordFormBtnSend.DoDoIt

class function TkwRememberPasswordFormBtnSend.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRememberPasswordForm.btnSend';
end;//TkwRememberPasswordFormBtnSend.GetWordNameForRegister

procedure TkwRememberPasswordFormBtnSend.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству btnSend', aCtx);
end;//TkwRememberPasswordFormBtnSend.SetValuePrim

function TkwRememberPasswordFormBtnSend.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TElPopupButton);
end;//TkwRememberPasswordFormBtnSend.GetResultTypeInfo

function TkwRememberPasswordFormBtnSend.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRememberPasswordFormBtnSend.GetAllParamsCount

function TkwRememberPasswordFormBtnSend.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormBtnSend.ParamsTypes

type
  TkwRememberPasswordFormEdEmail = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TRememberPasswordForm.edEmail
[panel]Контрол edEmail формы TRememberPasswordForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aRememberPasswordForm .TRememberPasswordForm.edEmail >>> l_TnscEdit
[code]  }
  private
  // private methods
   function EdEmail(const aCtx: TtfwContext;
     aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
     {* Реализация слова скрипта .TRememberPasswordForm.edEmail }
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
  end;//TkwRememberPasswordFormEdEmail

// start class TkwRememberPasswordFormEdEmail

function TkwRememberPasswordFormEdEmail.EdEmail(const aCtx: TtfwContext;
  aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
 {-}
begin
 Result := aRememberPasswordForm.edEmail;
end;//TkwRememberPasswordFormEdEmail.EdEmail

procedure TkwRememberPasswordFormEdEmail.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aRememberPasswordForm : TRememberPasswordForm;
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
 aCtx.rEngine.PushObj((EdEmail(aCtx, l_aRememberPasswordForm)));
end;//TkwRememberPasswordFormEdEmail.DoDoIt

class function TkwRememberPasswordFormEdEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TRememberPasswordForm.edEmail';
end;//TkwRememberPasswordFormEdEmail.GetWordNameForRegister

procedure TkwRememberPasswordFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству edEmail', aCtx);
end;//TkwRememberPasswordFormEdEmail.SetValuePrim

function TkwRememberPasswordFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwRememberPasswordFormEdEmail.GetResultTypeInfo

function TkwRememberPasswordFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwRememberPasswordFormEdEmail.GetAllParamsCount

function TkwRememberPasswordFormEdEmail.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TRememberPasswordForm)]);
end;//TkwRememberPasswordFormEdEmail.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_RememberPassword
 Tkw_Form_RememberPassword.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_EMailLabel
 Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_EMailLabel_Push
 Tkw_RememberPassword_Control_EMailLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_HintLabel
 Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_HintLabel_Push
 Tkw_RememberPassword_Control_HintLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_btnCancel
 Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_btnCancel_Push
 Tkw_RememberPassword_Control_btnCancel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_btnSend
 Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_btnSend_Push
 Tkw_RememberPassword_Control_btnSend_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_edEmail
 Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_RememberPassword_Control_edEmail_Push
 Tkw_RememberPassword_Control_edEmail_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RememberPasswordForm_EMailLabel
 TkwRememberPasswordFormEMailLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RememberPasswordForm_HintLabel
 TkwRememberPasswordFormHintLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RememberPasswordForm_btnCancel
 TkwRememberPasswordFormBtnCancel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RememberPasswordForm_btnSend
 TkwRememberPasswordFormBtnSend.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация RememberPasswordForm_edEmail
 TkwRememberPasswordFormEdEmail.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа RememberPassword
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRememberPasswordForm));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TElPopupButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.