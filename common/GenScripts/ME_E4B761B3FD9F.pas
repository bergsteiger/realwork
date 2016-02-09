unit ForbidAutoregistrationKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ForbidAutoregistration }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\ForbidAutoregistrationKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 , vtLabel
 , vtGroupBox
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
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_ForbidAutoregistration = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ForbidAutoregistration
----
*Пример использования*:
[code]
'aControl' форма::ForbidAutoregistration TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ForbidAutoregistration

 Tkw_ForbidAutoregistration_Control_lblReference = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblReference
----
*Пример использования*:
[code]
контрол::lblReference TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_lblReference

 Tkw_ForbidAutoregistration_Control_lblReference_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblReference
----
*Пример использования*:
[code]
контрол::lblReference:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblReference_Push

 Tkw_ForbidAutoregistration_Control_gbInfo = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола gbInfo
----
*Пример использования*:
[code]
контрол::gbInfo TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_gbInfo

 Tkw_ForbidAutoregistration_Control_gbInfo_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола gbInfo
----
*Пример использования*:
[code]
контрол::gbInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push

 Tkw_ForbidAutoregistration_Control_lblPhone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblPhone
----
*Пример использования*:
[code]
контрол::lblPhone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_lblPhone

 Tkw_ForbidAutoregistration_Control_lblPhone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblPhone
----
*Пример использования*:
[code]
контрол::lblPhone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push

 Tkw_ForbidAutoregistration_Control_lblEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblEmail
----
*Пример использования*:
[code]
контрол::lblEmail TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_lblEmail

 Tkw_ForbidAutoregistration_Control_lblEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblEmail
----
*Пример использования*:
[code]
контрол::lblEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push

 Tkw_ForbidAutoregistration_Control_lblHint = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblHint
----
*Пример использования*:
[code]
контрол::lblHint TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_lblHint

 Tkw_ForbidAutoregistration_Control_lblHint_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lblHint
----
*Пример использования*:
[code]
контрол::lblHint:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblHint_Push

 Tkw_ForbidAutoregistration_Control_cbPhone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbPhone
----
*Пример использования*:
[code]
контрол::cbPhone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_cbPhone

 Tkw_ForbidAutoregistration_Control_cbPhone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола cbPhone
----
*Пример использования*:
[code]
контрол::cbPhone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push

 Tkw_ForbidAutoregistration_Control_cbEmail = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола cbEmail
----
*Пример использования*:
[code]
контрол::cbEmail TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ForbidAutoregistration_Control_cbEmail

 Tkw_ForbidAutoregistration_Control_cbEmail_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола cbEmail
----
*Пример использования*:
[code]
контрол::cbEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push

 TkwEfForbidAutoregistrationLblReference = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.lblReference
[panel]Контрол lblReference формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblReference >>> l_TvtLabel
[code]  }
  private
   function lblReference(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* Реализация слова скрипта .TefForbidAutoregistration.lblReference }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationLblReference

 TkwEfForbidAutoregistrationGbInfo = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.gbInfo
[panel]Контрол gbInfo формы TefForbidAutoregistration[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aefForbidAutoregistration .TefForbidAutoregistration.gbInfo >>> l_TvtGroupBox
[code]  }
  private
   function gbInfo(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
    {* Реализация слова скрипта .TefForbidAutoregistration.gbInfo }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationGbInfo

 TkwEfForbidAutoregistrationLblPhone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.lblPhone
[panel]Контрол lblPhone формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblPhone >>> l_TvtLabel
[code]  }
  private
   function lblPhone(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* Реализация слова скрипта .TefForbidAutoregistration.lblPhone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationLblPhone

 TkwEfForbidAutoregistrationLblEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.lblEmail
[panel]Контрол lblEmail формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblEmail >>> l_TvtLabel
[code]  }
  private
   function lblEmail(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* Реализация слова скрипта .TefForbidAutoregistration.lblEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationLblEmail

 TkwEfForbidAutoregistrationLblHint = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.lblHint
[panel]Контрол lblHint формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblHint >>> l_TvtLabel
[code]  }
  private
   function lblHint(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
    {* Реализация слова скрипта .TefForbidAutoregistration.lblHint }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationLblHint

 TkwEfForbidAutoregistrationCbPhone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.cbPhone
[panel]Контрол cbPhone формы TefForbidAutoregistration[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefForbidAutoregistration .TefForbidAutoregistration.cbPhone >>> l_TnscEdit
[code]  }
  private
   function cbPhone(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
    {* Реализация слова скрипта .TefForbidAutoregistration.cbPhone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationCbPhone

 TkwEfForbidAutoregistrationCbEmail = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefForbidAutoregistration.cbEmail
[panel]Контрол cbEmail формы TefForbidAutoregistration[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefForbidAutoregistration .TefForbidAutoregistration.cbEmail >>> l_TnscEdit
[code]  }
  private
   function cbEmail(const aCtx: TtfwContext;
    aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
    {* Реализация слова скрипта .TefForbidAutoregistration.cbEmail }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfForbidAutoregistrationCbEmail

class function Tkw_Form_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetWordNameForRegister

function Tkw_Form_ForbidAutoregistration.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_86D5B3CF0FCC_var*
//#UC END# *4DDFD2EA0116_86D5B3CF0FCC_var*
begin
//#UC START# *4DDFD2EA0116_86D5B3CF0FCC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_86D5B3CF0FCC_impl*
end;//Tkw_Form_ForbidAutoregistration.GetString

class function Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblReference.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_C10C17DD2367_var*
//#UC END# *4DDFD2EA0116_C10C17DD2367_var*
begin
//#UC START# *4DDFD2EA0116_C10C17DD2367_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_C10C17DD2367_impl*
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
//#UC START# *52A086150180_C10C17DD2367_var*
//#UC END# *52A086150180_C10C17DD2367_var*
begin
//#UC START# *52A086150180_C10C17DD2367_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_C10C17DD2367_impl*
end;//Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_05519E0B783D_var*
//#UC END# *4DAEEDE10285_05519E0B783D_var*
begin
//#UC START# *4DAEEDE10285_05519E0B783D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_05519E0B783D_impl*
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblReference:push';
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_gbInfo.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D4A823A3B21E_var*
//#UC END# *4DDFD2EA0116_D4A823A3B21E_var*
begin
//#UC START# *4DDFD2EA0116_D4A823A3B21E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D4A823A3B21E_impl*
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetString

class procedure Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
//#UC START# *52A086150180_D4A823A3B21E_var*
//#UC END# *52A086150180_D4A823A3B21E_var*
begin
//#UC START# *52A086150180_D4A823A3B21E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D4A823A3B21E_impl*
end;//Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5F41C1545D19_var*
//#UC END# *4DAEEDE10285_5F41C1545D19_var*
begin
//#UC START# *4DAEEDE10285_5F41C1545D19_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5F41C1545D19_impl*
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbInfo:push';
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblPhone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_103C29A6AD49_var*
//#UC END# *4DDFD2EA0116_103C29A6AD49_var*
begin
//#UC START# *4DDFD2EA0116_103C29A6AD49_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_103C29A6AD49_impl*
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
//#UC START# *52A086150180_103C29A6AD49_var*
//#UC END# *52A086150180_103C29A6AD49_var*
begin
//#UC START# *52A086150180_103C29A6AD49_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_103C29A6AD49_impl*
end;//Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3767D248436F_var*
//#UC END# *4DAEEDE10285_3767D248436F_var*
begin
//#UC START# *4DAEEDE10285_3767D248436F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3767D248436F_impl*
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPhone:push';
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblEmail.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_922D0A952657_var*
//#UC END# *4DDFD2EA0116_922D0A952657_var*
begin
//#UC START# *4DDFD2EA0116_922D0A952657_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_922D0A952657_impl*
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
//#UC START# *52A086150180_922D0A952657_var*
//#UC END# *52A086150180_922D0A952657_var*
begin
//#UC START# *52A086150180_922D0A952657_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_922D0A952657_impl*
end;//Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_954C2765C606_var*
//#UC END# *4DAEEDE10285_954C2765C606_var*
begin
//#UC START# *4DAEEDE10285_954C2765C606_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_954C2765C606_impl*
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblEmail:push';
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblHint.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5FF3712A469F_var*
//#UC END# *4DDFD2EA0116_5FF3712A469F_var*
begin
//#UC START# *4DDFD2EA0116_5FF3712A469F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5FF3712A469F_impl*
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
//#UC START# *52A086150180_5FF3712A469F_var*
//#UC END# *52A086150180_5FF3712A469F_var*
begin
//#UC START# *52A086150180_5FF3712A469F_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_5FF3712A469F_impl*
end;//Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1ED3E40D3CBA_var*
//#UC END# *4DAEEDE10285_1ED3E40D3CBA_var*
begin
//#UC START# *4DAEEDE10285_1ED3E40D3CBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1ED3E40D3CBA_impl*
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblHint:push';
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbPhone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F83D3B870D64_var*
//#UC END# *4DDFD2EA0116_F83D3B870D64_var*
begin
//#UC START# *4DDFD2EA0116_F83D3B870D64_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F83D3B870D64_impl*
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
//#UC START# *52A086150180_F83D3B870D64_var*
//#UC END# *52A086150180_F83D3B870D64_var*
begin
//#UC START# *52A086150180_F83D3B870D64_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_F83D3B870D64_impl*
end;//Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_24968EDE10C3_var*
//#UC END# *4DAEEDE10285_24968EDE10C3_var*
begin
//#UC START# *4DAEEDE10285_24968EDE10C3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_24968EDE10C3_impl*
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbPhone:push';
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister

class function Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbEmail.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_211726275097_var*
//#UC END# *4DDFD2EA0116_211726275097_var*
begin
//#UC START# *4DDFD2EA0116_211726275097_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_211726275097_impl*
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
//#UC START# *52A086150180_211726275097_var*
//#UC END# *52A086150180_211726275097_var*
begin
//#UC START# *52A086150180_211726275097_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_211726275097_impl*
end;//Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine

procedure Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4FF7C438CB62_var*
//#UC END# *4DAEEDE10285_4FF7C438CB62_var*
begin
//#UC START# *4DAEEDE10285_4FF7C438CB62_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_4FF7C438CB62_impl*
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbEmail:push';
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblReference.lblReference(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblReference }
//#UC START# *27EC676DE288_A8ED3F2A32F9_var*
//#UC END# *27EC676DE288_A8ED3F2A32F9_var*
begin
//#UC START# *27EC676DE288_A8ED3F2A32F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *27EC676DE288_A8ED3F2A32F9_impl*
end;//TkwEfForbidAutoregistrationLblReference.lblReference

procedure TkwEfForbidAutoregistrationLblReference.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A8ED3F2A32F9_var*
//#UC END# *4DAEEDE10285_A8ED3F2A32F9_var*
begin
//#UC START# *4DAEEDE10285_A8ED3F2A32F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A8ED3F2A32F9_impl*
end;//TkwEfForbidAutoregistrationLblReference.DoDoIt

class function TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblReference';
end;//TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblReference.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A8ED3F2A32F9_var*
//#UC END# *52D00B00031A_A8ED3F2A32F9_var*
begin
//#UC START# *52D00B00031A_A8ED3F2A32F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A8ED3F2A32F9_impl*
end;//TkwEfForbidAutoregistrationLblReference.SetValuePrim

function TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A8ED3F2A32F9_var*
//#UC END# *551544E2001A_A8ED3F2A32F9_var*
begin
//#UC START# *551544E2001A_A8ED3F2A32F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A8ED3F2A32F9_impl*
end;//TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblReference.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblReference.GetAllParamsCount

function TkwEfForbidAutoregistrationLblReference.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A8ED3F2A32F9_var*
//#UC END# *5617F4D00243_A8ED3F2A32F9_var*
begin
//#UC START# *5617F4D00243_A8ED3F2A32F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A8ED3F2A32F9_impl*
end;//TkwEfForbidAutoregistrationLblReference.ParamsTypes

function TkwEfForbidAutoregistrationGbInfo.gbInfo(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
 {* Реализация слова скрипта .TefForbidAutoregistration.gbInfo }
//#UC START# *BF7F25F4C374_B434E42C072E_var*
//#UC END# *BF7F25F4C374_B434E42C072E_var*
begin
//#UC START# *BF7F25F4C374_B434E42C072E_impl*
 !!! Needs to be implemented !!!
//#UC END# *BF7F25F4C374_B434E42C072E_impl*
end;//TkwEfForbidAutoregistrationGbInfo.gbInfo

procedure TkwEfForbidAutoregistrationGbInfo.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B434E42C072E_var*
//#UC END# *4DAEEDE10285_B434E42C072E_var*
begin
//#UC START# *4DAEEDE10285_B434E42C072E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B434E42C072E_impl*
end;//TkwEfForbidAutoregistrationGbInfo.DoDoIt

class function TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.gbInfo';
end;//TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationGbInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B434E42C072E_var*
//#UC END# *52D00B00031A_B434E42C072E_var*
begin
//#UC START# *52D00B00031A_B434E42C072E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B434E42C072E_impl*
end;//TkwEfForbidAutoregistrationGbInfo.SetValuePrim

function TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_B434E42C072E_var*
//#UC END# *551544E2001A_B434E42C072E_var*
begin
//#UC START# *551544E2001A_B434E42C072E_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_B434E42C072E_impl*
end;//TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo

function TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount

function TkwEfForbidAutoregistrationGbInfo.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B434E42C072E_var*
//#UC END# *5617F4D00243_B434E42C072E_var*
begin
//#UC START# *5617F4D00243_B434E42C072E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B434E42C072E_impl*
end;//TkwEfForbidAutoregistrationGbInfo.ParamsTypes

function TkwEfForbidAutoregistrationLblPhone.lblPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblPhone }
//#UC START# *E4F6FAAED1A7_20A0A124DABA_var*
//#UC END# *E4F6FAAED1A7_20A0A124DABA_var*
begin
//#UC START# *E4F6FAAED1A7_20A0A124DABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *E4F6FAAED1A7_20A0A124DABA_impl*
end;//TkwEfForbidAutoregistrationLblPhone.lblPhone

procedure TkwEfForbidAutoregistrationLblPhone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_20A0A124DABA_var*
//#UC END# *4DAEEDE10285_20A0A124DABA_var*
begin
//#UC START# *4DAEEDE10285_20A0A124DABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_20A0A124DABA_impl*
end;//TkwEfForbidAutoregistrationLblPhone.DoDoIt

class function TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblPhone';
end;//TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_20A0A124DABA_var*
//#UC END# *52D00B00031A_20A0A124DABA_var*
begin
//#UC START# *52D00B00031A_20A0A124DABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_20A0A124DABA_impl*
end;//TkwEfForbidAutoregistrationLblPhone.SetValuePrim

function TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_20A0A124DABA_var*
//#UC END# *551544E2001A_20A0A124DABA_var*
begin
//#UC START# *551544E2001A_20A0A124DABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_20A0A124DABA_impl*
end;//TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationLblPhone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_20A0A124DABA_var*
//#UC END# *5617F4D00243_20A0A124DABA_var*
begin
//#UC START# *5617F4D00243_20A0A124DABA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_20A0A124DABA_impl*
end;//TkwEfForbidAutoregistrationLblPhone.ParamsTypes

function TkwEfForbidAutoregistrationLblEmail.lblEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblEmail }
//#UC START# *3714B65D73E1_D03F48103D05_var*
//#UC END# *3714B65D73E1_D03F48103D05_var*
begin
//#UC START# *3714B65D73E1_D03F48103D05_impl*
 !!! Needs to be implemented !!!
//#UC END# *3714B65D73E1_D03F48103D05_impl*
end;//TkwEfForbidAutoregistrationLblEmail.lblEmail

procedure TkwEfForbidAutoregistrationLblEmail.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D03F48103D05_var*
//#UC END# *4DAEEDE10285_D03F48103D05_var*
begin
//#UC START# *4DAEEDE10285_D03F48103D05_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D03F48103D05_impl*
end;//TkwEfForbidAutoregistrationLblEmail.DoDoIt

class function TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblEmail';
end;//TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D03F48103D05_var*
//#UC END# *52D00B00031A_D03F48103D05_var*
begin
//#UC START# *52D00B00031A_D03F48103D05_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D03F48103D05_impl*
end;//TkwEfForbidAutoregistrationLblEmail.SetValuePrim

function TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D03F48103D05_var*
//#UC END# *551544E2001A_D03F48103D05_var*
begin
//#UC START# *551544E2001A_D03F48103D05_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D03F48103D05_impl*
end;//TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationLblEmail.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D03F48103D05_var*
//#UC END# *5617F4D00243_D03F48103D05_var*
begin
//#UC START# *5617F4D00243_D03F48103D05_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D03F48103D05_impl*
end;//TkwEfForbidAutoregistrationLblEmail.ParamsTypes

function TkwEfForbidAutoregistrationLblHint.lblHint(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblHint }
//#UC START# *77AE4C70FA73_D20CEB956674_var*
//#UC END# *77AE4C70FA73_D20CEB956674_var*
begin
//#UC START# *77AE4C70FA73_D20CEB956674_impl*
 !!! Needs to be implemented !!!
//#UC END# *77AE4C70FA73_D20CEB956674_impl*
end;//TkwEfForbidAutoregistrationLblHint.lblHint

procedure TkwEfForbidAutoregistrationLblHint.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D20CEB956674_var*
//#UC END# *4DAEEDE10285_D20CEB956674_var*
begin
//#UC START# *4DAEEDE10285_D20CEB956674_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D20CEB956674_impl*
end;//TkwEfForbidAutoregistrationLblHint.DoDoIt

class function TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblHint';
end;//TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_D20CEB956674_var*
//#UC END# *52D00B00031A_D20CEB956674_var*
begin
//#UC START# *52D00B00031A_D20CEB956674_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_D20CEB956674_impl*
end;//TkwEfForbidAutoregistrationLblHint.SetValuePrim

function TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D20CEB956674_var*
//#UC END# *551544E2001A_D20CEB956674_var*
begin
//#UC START# *551544E2001A_D20CEB956674_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D20CEB956674_impl*
end;//TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblHint.GetAllParamsCount

function TkwEfForbidAutoregistrationLblHint.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D20CEB956674_var*
//#UC END# *5617F4D00243_D20CEB956674_var*
begin
//#UC START# *5617F4D00243_D20CEB956674_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D20CEB956674_impl*
end;//TkwEfForbidAutoregistrationLblHint.ParamsTypes

function TkwEfForbidAutoregistrationCbPhone.cbPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* Реализация слова скрипта .TefForbidAutoregistration.cbPhone }
//#UC START# *DA8753F80704_6AD1645F5DAC_var*
//#UC END# *DA8753F80704_6AD1645F5DAC_var*
begin
//#UC START# *DA8753F80704_6AD1645F5DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *DA8753F80704_6AD1645F5DAC_impl*
end;//TkwEfForbidAutoregistrationCbPhone.cbPhone

procedure TkwEfForbidAutoregistrationCbPhone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_6AD1645F5DAC_var*
//#UC END# *4DAEEDE10285_6AD1645F5DAC_var*
begin
//#UC START# *4DAEEDE10285_6AD1645F5DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_6AD1645F5DAC_impl*
end;//TkwEfForbidAutoregistrationCbPhone.DoDoIt

class function TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbPhone';
end;//TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationCbPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_6AD1645F5DAC_var*
//#UC END# *52D00B00031A_6AD1645F5DAC_var*
begin
//#UC START# *52D00B00031A_6AD1645F5DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_6AD1645F5DAC_impl*
end;//TkwEfForbidAutoregistrationCbPhone.SetValuePrim

function TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_6AD1645F5DAC_var*
//#UC END# *551544E2001A_6AD1645F5DAC_var*
begin
//#UC START# *551544E2001A_6AD1645F5DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_6AD1645F5DAC_impl*
end;//TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationCbPhone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_6AD1645F5DAC_var*
//#UC END# *5617F4D00243_6AD1645F5DAC_var*
begin
//#UC START# *5617F4D00243_6AD1645F5DAC_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_6AD1645F5DAC_impl*
end;//TkwEfForbidAutoregistrationCbPhone.ParamsTypes

function TkwEfForbidAutoregistrationCbEmail.cbEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* Реализация слова скрипта .TefForbidAutoregistration.cbEmail }
//#UC START# *EBD8824729C5_444FFAC43ABB_var*
//#UC END# *EBD8824729C5_444FFAC43ABB_var*
begin
//#UC START# *EBD8824729C5_444FFAC43ABB_impl*
 !!! Needs to be implemented !!!
//#UC END# *EBD8824729C5_444FFAC43ABB_impl*
end;//TkwEfForbidAutoregistrationCbEmail.cbEmail

procedure TkwEfForbidAutoregistrationCbEmail.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_444FFAC43ABB_var*
//#UC END# *4DAEEDE10285_444FFAC43ABB_var*
begin
//#UC START# *4DAEEDE10285_444FFAC43ABB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_444FFAC43ABB_impl*
end;//TkwEfForbidAutoregistrationCbEmail.DoDoIt

class function TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbEmail';
end;//TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationCbEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_444FFAC43ABB_var*
//#UC END# *52D00B00031A_444FFAC43ABB_var*
begin
//#UC START# *52D00B00031A_444FFAC43ABB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_444FFAC43ABB_impl*
end;//TkwEfForbidAutoregistrationCbEmail.SetValuePrim

function TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_444FFAC43ABB_var*
//#UC END# *551544E2001A_444FFAC43ABB_var*
begin
//#UC START# *551544E2001A_444FFAC43ABB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_444FFAC43ABB_impl*
end;//TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationCbEmail.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_444FFAC43ABB_var*
//#UC END# *5617F4D00243_444FFAC43ABB_var*
begin
//#UC START# *5617F4D00243_444FFAC43ABB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_444FFAC43ABB_impl*
end;//TkwEfForbidAutoregistrationCbEmail.ParamsTypes

initialization
 Tkw_Form_ForbidAutoregistration.RegisterInEngine;
 {* Регистрация Tkw_Form_ForbidAutoregistration }
 Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblReference }
 Tkw_ForbidAutoregistration_Control_lblReference_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblReference_Push }
 Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_gbInfo }
 Tkw_ForbidAutoregistration_Control_gbInfo_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_gbInfo_Push }
 Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblPhone }
 Tkw_ForbidAutoregistration_Control_lblPhone_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblPhone_Push }
 Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblEmail }
 Tkw_ForbidAutoregistration_Control_lblEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblEmail_Push }
 Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblHint }
 Tkw_ForbidAutoregistration_Control_lblHint_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_lblHint_Push }
 Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_cbPhone }
 Tkw_ForbidAutoregistration_Control_cbPhone_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_cbPhone_Push }
 Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_cbEmail }
 Tkw_ForbidAutoregistration_Control_cbEmail_Push.RegisterInEngine;
 {* Регистрация Tkw_ForbidAutoregistration_Control_cbEmail_Push }
 TkwEfForbidAutoregistrationLblReference.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_lblReference }
 TkwEfForbidAutoregistrationGbInfo.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_gbInfo }
 TkwEfForbidAutoregistrationLblPhone.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_lblPhone }
 TkwEfForbidAutoregistrationLblEmail.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_lblEmail }
 TkwEfForbidAutoregistrationLblHint.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_lblHint }
 TkwEfForbidAutoregistrationCbPhone.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_cbPhone }
 TkwEfForbidAutoregistrationCbEmail.RegisterInEngine;
 {* Регистрация efForbidAutoregistration_cbEmail }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefForbidAutoregistration));
 {* Регистрация типа ForbidAutoregistration }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* Регистрация типа TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
