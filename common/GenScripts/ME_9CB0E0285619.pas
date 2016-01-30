unit RememberPasswordKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы RememberPassword }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\RememberPasswordKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 , vtLabel
 , ElPopBtn
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_RememberPassword = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы RememberPassword
----
*Пример использования*:
[code]
'aControl' форма::RememberPassword TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_RememberPassword

 Tkw_RememberPassword_Control_EMailLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RememberPassword_Control_EMailLabel

 Tkw_RememberPassword_Control_EMailLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола EMailLabel
----
*Пример использования*:
[code]
контрол::EMailLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_EMailLabel_Push

 Tkw_RememberPassword_Control_HintLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола HintLabel
----
*Пример использования*:
[code]
контрол::HintLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RememberPassword_Control_HintLabel

 Tkw_RememberPassword_Control_HintLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола HintLabel
----
*Пример использования*:
[code]
контрол::HintLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_HintLabel_Push

 Tkw_RememberPassword_Control_btnCancel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RememberPassword_Control_btnCancel

 Tkw_RememberPassword_Control_btnCancel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnCancel
----
*Пример использования*:
[code]
контрол::btnCancel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnCancel_Push

 Tkw_RememberPassword_Control_btnSend = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола btnSend
----
*Пример использования*:
[code]
контрол::btnSend TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RememberPassword_Control_btnSend

 Tkw_RememberPassword_Control_btnSend_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола btnSend
----
*Пример использования*:
[code]
контрол::btnSend:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_btnSend_Push

 Tkw_RememberPassword_Control_edEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_RememberPassword_Control_edEmail

 Tkw_RememberPassword_Control_edEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола edEmail
----
*Пример использования*:
[code]
контрол::edEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_RememberPassword_Control_edEmail_Push

 TkwRememberPasswordFormEMailLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TRememberPasswordForm.EMailLabel
[panel]Контрол EMailLabel формы TRememberPasswordForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRememberPasswordForm .TRememberPasswordForm.EMailLabel >>> l_TvtLabel
[code]  }
  private
   function EMailLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* Реализация слова скрипта .TRememberPasswordForm.EMailLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRememberPasswordFormEMailLabel

 TkwRememberPasswordFormHintLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TRememberPasswordForm.HintLabel
[panel]Контрол HintLabel формы TRememberPasswordForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aRememberPasswordForm .TRememberPasswordForm.HintLabel >>> l_TvtLabel
[code]  }
  private
   function HintLabel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
    {* Реализация слова скрипта .TRememberPasswordForm.HintLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRememberPasswordFormHintLabel

 TkwRememberPasswordFormBtnCancel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TRememberPasswordForm.btnCancel
[panel]Контрол btnCancel формы TRememberPasswordForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aRememberPasswordForm .TRememberPasswordForm.btnCancel >>> l_TElPopupButton
[code]  }
  private
   function btnCancel(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* Реализация слова скрипта .TRememberPasswordForm.btnCancel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRememberPasswordFormBtnCancel

 TkwRememberPasswordFormBtnSend = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TRememberPasswordForm.btnSend
[panel]Контрол btnSend формы TRememberPasswordForm[panel]
*Тип результата:* TElPopupButton
*Пример:*
[code]
OBJECT VAR l_TElPopupButton
 aRememberPasswordForm .TRememberPasswordForm.btnSend >>> l_TElPopupButton
[code]  }
  private
   function btnSend(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
    {* Реализация слова скрипта .TRememberPasswordForm.btnSend }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRememberPasswordFormBtnSend

 TkwRememberPasswordFormEdEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TRememberPasswordForm.edEmail
[panel]Контрол edEmail формы TRememberPasswordForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aRememberPasswordForm .TRememberPasswordForm.edEmail >>> l_TnscEdit
[code]  }
  private
   function edEmail(const aCtx: TtfwContext;
    aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
    {* Реализация слова скрипта .TRememberPasswordForm.edEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwRememberPasswordFormEdEmail

class function Tkw_Form_RememberPassword.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::RememberPassword';
end;//Tkw_Form_RememberPassword.GetWordNameForRegister

function Tkw_Form_RememberPassword.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_44A0C15F4915_var*
//#UC END# *4DDFD2EA0116_44A0C15F4915_var*
begin
//#UC START# *4DDFD2EA0116_44A0C15F4915_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_44A0C15F4915_impl*
end;//Tkw_Form_RememberPassword.GetString

class function Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel';
end;//Tkw_RememberPassword_Control_EMailLabel.GetWordNameForRegister

function Tkw_RememberPassword_Control_EMailLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_32691366400B_var*
//#UC END# *4DDFD2EA0116_32691366400B_var*
begin
//#UC START# *4DDFD2EA0116_32691366400B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_32691366400B_impl*
end;//Tkw_RememberPassword_Control_EMailLabel.GetString

class procedure Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine;
//#UC START# *52A086150180_32691366400B_var*
//#UC END# *52A086150180_32691366400B_var*
begin
//#UC START# *52A086150180_32691366400B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_32691366400B_impl*
end;//Tkw_RememberPassword_Control_EMailLabel.RegisterInEngine

procedure Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D1D89139FBA9_var*
//#UC END# *4DAEEDE10285_D1D89139FBA9_var*
begin
//#UC START# *4DAEEDE10285_D1D89139FBA9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D1D89139FBA9_impl*
end;//Tkw_RememberPassword_Control_EMailLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::EMailLabel:push';
end;//Tkw_RememberPassword_Control_EMailLabel_Push.GetWordNameForRegister

class function Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HintLabel';
end;//Tkw_RememberPassword_Control_HintLabel.GetWordNameForRegister

function Tkw_RememberPassword_Control_HintLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EC23CE3EBFB0_var*
//#UC END# *4DDFD2EA0116_EC23CE3EBFB0_var*
begin
//#UC START# *4DDFD2EA0116_EC23CE3EBFB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EC23CE3EBFB0_impl*
end;//Tkw_RememberPassword_Control_HintLabel.GetString

class procedure Tkw_RememberPassword_Control_HintLabel.RegisterInEngine;
//#UC START# *52A086150180_EC23CE3EBFB0_var*
//#UC END# *52A086150180_EC23CE3EBFB0_var*
begin
//#UC START# *52A086150180_EC23CE3EBFB0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EC23CE3EBFB0_impl*
end;//Tkw_RememberPassword_Control_HintLabel.RegisterInEngine

procedure Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_ACB988022C21_var*
//#UC END# *4DAEEDE10285_ACB988022C21_var*
begin
//#UC START# *4DAEEDE10285_ACB988022C21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_ACB988022C21_impl*
end;//Tkw_RememberPassword_Control_HintLabel_Push.DoDoIt

class function Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::HintLabel:push';
end;//Tkw_RememberPassword_Control_HintLabel_Push.GetWordNameForRegister

class function Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel';
end;//Tkw_RememberPassword_Control_btnCancel.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnCancel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_01ECB74311B2_var*
//#UC END# *4DDFD2EA0116_01ECB74311B2_var*
begin
//#UC START# *4DDFD2EA0116_01ECB74311B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_01ECB74311B2_impl*
end;//Tkw_RememberPassword_Control_btnCancel.GetString

class procedure Tkw_RememberPassword_Control_btnCancel.RegisterInEngine;
//#UC START# *52A086150180_01ECB74311B2_var*
//#UC END# *52A086150180_01ECB74311B2_var*
begin
//#UC START# *52A086150180_01ECB74311B2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_01ECB74311B2_impl*
end;//Tkw_RememberPassword_Control_btnCancel.RegisterInEngine

procedure Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B9F8C1B8D657_var*
//#UC END# *4DAEEDE10285_B9F8C1B8D657_var*
begin
//#UC START# *4DAEEDE10285_B9F8C1B8D657_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B9F8C1B8D657_impl*
end;//Tkw_RememberPassword_Control_btnCancel_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnCancel:push';
end;//Tkw_RememberPassword_Control_btnCancel_Push.GetWordNameForRegister

class function Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnSend';
end;//Tkw_RememberPassword_Control_btnSend.GetWordNameForRegister

function Tkw_RememberPassword_Control_btnSend.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_13BD53EBA825_var*
//#UC END# *4DDFD2EA0116_13BD53EBA825_var*
begin
//#UC START# *4DDFD2EA0116_13BD53EBA825_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_13BD53EBA825_impl*
end;//Tkw_RememberPassword_Control_btnSend.GetString

class procedure Tkw_RememberPassword_Control_btnSend.RegisterInEngine;
//#UC START# *52A086150180_13BD53EBA825_var*
//#UC END# *52A086150180_13BD53EBA825_var*
begin
//#UC START# *52A086150180_13BD53EBA825_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_13BD53EBA825_impl*
end;//Tkw_RememberPassword_Control_btnSend.RegisterInEngine

procedure Tkw_RememberPassword_Control_btnSend_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_96E7D8DC4FBA_var*
//#UC END# *4DAEEDE10285_96E7D8DC4FBA_var*
begin
//#UC START# *4DAEEDE10285_96E7D8DC4FBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_96E7D8DC4FBA_impl*
end;//Tkw_RememberPassword_Control_btnSend_Push.DoDoIt

class function Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::btnSend:push';
end;//Tkw_RememberPassword_Control_btnSend_Push.GetWordNameForRegister

class function Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail';
end;//Tkw_RememberPassword_Control_edEmail.GetWordNameForRegister

function Tkw_RememberPassword_Control_edEmail.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F761753E0B78_var*
//#UC END# *4DDFD2EA0116_F761753E0B78_var*
begin
//#UC START# *4DDFD2EA0116_F761753E0B78_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F761753E0B78_impl*
end;//Tkw_RememberPassword_Control_edEmail.GetString

class procedure Tkw_RememberPassword_Control_edEmail.RegisterInEngine;
//#UC START# *52A086150180_F761753E0B78_var*
//#UC END# *52A086150180_F761753E0B78_var*
begin
//#UC START# *52A086150180_F761753E0B78_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F761753E0B78_impl*
end;//Tkw_RememberPassword_Control_edEmail.RegisterInEngine

procedure Tkw_RememberPassword_Control_edEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_80F8CFC665A3_var*
//#UC END# *4DAEEDE10285_80F8CFC665A3_var*
begin
//#UC START# *4DAEEDE10285_80F8CFC665A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_80F8CFC665A3_impl*
end;//Tkw_RememberPassword_Control_edEmail_Push.DoDoIt

class function Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::edEmail:push';
end;//Tkw_RememberPassword_Control_edEmail_Push.GetWordNameForRegister

function TkwRememberPasswordFormEMailLabel.EMailLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* Реализация слова скрипта .TRememberPasswordForm.EMailLabel }
//#UC START# *A8128A72BDDD_8762FC4AA6B6_var*
//#UC END# *A8128A72BDDD_8762FC4AA6B6_var*
begin
//#UC START# *A8128A72BDDD_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *A8128A72BDDD_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.EMailLabel

procedure TkwRememberPasswordFormEMailLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8762FC4AA6B6_var*
//#UC END# *4DAEEDE10285_8762FC4AA6B6_var*
begin
//#UC START# *4DAEEDE10285_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.DoDoIt

class function TkwRememberPasswordFormEMailLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.EMailLabel';
end;//TkwRememberPasswordFormEMailLabel.GetWordNameForRegister

procedure TkwRememberPasswordFormEMailLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8762FC4AA6B6_var*
//#UC END# *52D00B00031A_8762FC4AA6B6_var*
begin
//#UC START# *52D00B00031A_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.SetValuePrim

function TkwRememberPasswordFormEMailLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_8762FC4AA6B6_var*
//#UC END# *551544E2001A_8762FC4AA6B6_var*
begin
//#UC START# *551544E2001A_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.GetResultTypeInfo

function TkwRememberPasswordFormEMailLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_8762FC4AA6B6_var*
//#UC END# *559687E6025A_8762FC4AA6B6_var*
begin
//#UC START# *559687E6025A_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.GetAllParamsCount

function TkwRememberPasswordFormEMailLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_8762FC4AA6B6_var*
//#UC END# *5617F4D00243_8762FC4AA6B6_var*
begin
//#UC START# *5617F4D00243_8762FC4AA6B6_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_8762FC4AA6B6_impl*
end;//TkwRememberPasswordFormEMailLabel.ParamsTypes

function TkwRememberPasswordFormHintLabel.HintLabel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TvtLabel;
 {* Реализация слова скрипта .TRememberPasswordForm.HintLabel }
//#UC START# *F1E98B821E19_E057630A6AF4_var*
//#UC END# *F1E98B821E19_E057630A6AF4_var*
begin
//#UC START# *F1E98B821E19_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *F1E98B821E19_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.HintLabel

procedure TkwRememberPasswordFormHintLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E057630A6AF4_var*
//#UC END# *4DAEEDE10285_E057630A6AF4_var*
begin
//#UC START# *4DAEEDE10285_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.DoDoIt

class function TkwRememberPasswordFormHintLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.HintLabel';
end;//TkwRememberPasswordFormHintLabel.GetWordNameForRegister

procedure TkwRememberPasswordFormHintLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E057630A6AF4_var*
//#UC END# *52D00B00031A_E057630A6AF4_var*
begin
//#UC START# *52D00B00031A_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.SetValuePrim

function TkwRememberPasswordFormHintLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_E057630A6AF4_var*
//#UC END# *551544E2001A_E057630A6AF4_var*
begin
//#UC START# *551544E2001A_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.GetResultTypeInfo

function TkwRememberPasswordFormHintLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_E057630A6AF4_var*
//#UC END# *559687E6025A_E057630A6AF4_var*
begin
//#UC START# *559687E6025A_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.GetAllParamsCount

function TkwRememberPasswordFormHintLabel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E057630A6AF4_var*
//#UC END# *5617F4D00243_E057630A6AF4_var*
begin
//#UC START# *5617F4D00243_E057630A6AF4_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E057630A6AF4_impl*
end;//TkwRememberPasswordFormHintLabel.ParamsTypes

function TkwRememberPasswordFormBtnCancel.btnCancel(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* Реализация слова скрипта .TRememberPasswordForm.btnCancel }
//#UC START# *2BA8120DD293_1DAD0A24AD05_var*
//#UC END# *2BA8120DD293_1DAD0A24AD05_var*
begin
//#UC START# *2BA8120DD293_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *2BA8120DD293_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.btnCancel

procedure TkwRememberPasswordFormBtnCancel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1DAD0A24AD05_var*
//#UC END# *4DAEEDE10285_1DAD0A24AD05_var*
begin
//#UC START# *4DAEEDE10285_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.DoDoIt

class function TkwRememberPasswordFormBtnCancel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.btnCancel';
end;//TkwRememberPasswordFormBtnCancel.GetWordNameForRegister

procedure TkwRememberPasswordFormBtnCancel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_1DAD0A24AD05_var*
//#UC END# *52D00B00031A_1DAD0A24AD05_var*
begin
//#UC START# *52D00B00031A_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.SetValuePrim

function TkwRememberPasswordFormBtnCancel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_1DAD0A24AD05_var*
//#UC END# *551544E2001A_1DAD0A24AD05_var*
begin
//#UC START# *551544E2001A_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.GetResultTypeInfo

function TkwRememberPasswordFormBtnCancel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_1DAD0A24AD05_var*
//#UC END# *559687E6025A_1DAD0A24AD05_var*
begin
//#UC START# *559687E6025A_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.GetAllParamsCount

function TkwRememberPasswordFormBtnCancel.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_1DAD0A24AD05_var*
//#UC END# *5617F4D00243_1DAD0A24AD05_var*
begin
//#UC START# *5617F4D00243_1DAD0A24AD05_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_1DAD0A24AD05_impl*
end;//TkwRememberPasswordFormBtnCancel.ParamsTypes

function TkwRememberPasswordFormBtnSend.btnSend(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TElPopupButton;
 {* Реализация слова скрипта .TRememberPasswordForm.btnSend }
//#UC START# *63F9C17CB819_9D168AD23177_var*
//#UC END# *63F9C17CB819_9D168AD23177_var*
begin
//#UC START# *63F9C17CB819_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *63F9C17CB819_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.btnSend

procedure TkwRememberPasswordFormBtnSend.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_9D168AD23177_var*
//#UC END# *4DAEEDE10285_9D168AD23177_var*
begin
//#UC START# *4DAEEDE10285_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.DoDoIt

class function TkwRememberPasswordFormBtnSend.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.btnSend';
end;//TkwRememberPasswordFormBtnSend.GetWordNameForRegister

procedure TkwRememberPasswordFormBtnSend.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_9D168AD23177_var*
//#UC END# *52D00B00031A_9D168AD23177_var*
begin
//#UC START# *52D00B00031A_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.SetValuePrim

function TkwRememberPasswordFormBtnSend.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_9D168AD23177_var*
//#UC END# *551544E2001A_9D168AD23177_var*
begin
//#UC START# *551544E2001A_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.GetResultTypeInfo

function TkwRememberPasswordFormBtnSend.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_9D168AD23177_var*
//#UC END# *559687E6025A_9D168AD23177_var*
begin
//#UC START# *559687E6025A_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.GetAllParamsCount

function TkwRememberPasswordFormBtnSend.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_9D168AD23177_var*
//#UC END# *5617F4D00243_9D168AD23177_var*
begin
//#UC START# *5617F4D00243_9D168AD23177_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_9D168AD23177_impl*
end;//TkwRememberPasswordFormBtnSend.ParamsTypes

function TkwRememberPasswordFormEdEmail.edEmail(const aCtx: TtfwContext;
 aRememberPasswordForm: TRememberPasswordForm): TnscEdit;
 {* Реализация слова скрипта .TRememberPasswordForm.edEmail }
//#UC START# *62396A4E6064_AA3BE956D240_var*
//#UC END# *62396A4E6064_AA3BE956D240_var*
begin
//#UC START# *62396A4E6064_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *62396A4E6064_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.edEmail

procedure TkwRememberPasswordFormEdEmail.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AA3BE956D240_var*
//#UC END# *4DAEEDE10285_AA3BE956D240_var*
begin
//#UC START# *4DAEEDE10285_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.DoDoIt

class function TkwRememberPasswordFormEdEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TRememberPasswordForm.edEmail';
end;//TkwRememberPasswordFormEdEmail.GetWordNameForRegister

procedure TkwRememberPasswordFormEdEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AA3BE956D240_var*
//#UC END# *52D00B00031A_AA3BE956D240_var*
begin
//#UC START# *52D00B00031A_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.SetValuePrim

function TkwRememberPasswordFormEdEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_AA3BE956D240_var*
//#UC END# *551544E2001A_AA3BE956D240_var*
begin
//#UC START# *551544E2001A_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.GetResultTypeInfo

function TkwRememberPasswordFormEdEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_AA3BE956D240_var*
//#UC END# *559687E6025A_AA3BE956D240_var*
begin
//#UC START# *559687E6025A_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.GetAllParamsCount

function TkwRememberPasswordFormEdEmail.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_AA3BE956D240_var*
//#UC END# *5617F4D00243_AA3BE956D240_var*
begin
//#UC START# *5617F4D00243_AA3BE956D240_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_AA3BE956D240_impl*
end;//TkwRememberPasswordFormEdEmail.ParamsTypes

initialization
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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TRememberPasswordForm));
 {* Регистрация типа RememberPassword }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElPopupButton));
 {* Регистрация типа TElPopupButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
