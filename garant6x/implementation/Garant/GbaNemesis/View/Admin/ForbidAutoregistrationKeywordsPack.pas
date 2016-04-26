unit ForbidAutoregistrationKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ForbidAutoregistration }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\ForbidAutoregistrationKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ForbidAutoregistrationKeywordsPack" MUID: (E4B761B3FD9F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtLabel
 , vtGroupBox
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , ForbidAutoregistration_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_ForbidAutoregistration

 Tkw_ForbidAutoregistration_Control_lblReference = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lblReference
----
*Пример использования*:
[code]
контрол::lblReference TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblReference

 Tkw_ForbidAutoregistration_Control_lblReference_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_gbInfo

 Tkw_ForbidAutoregistration_Control_gbInfo_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblPhone

 Tkw_ForbidAutoregistration_Control_lblPhone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblEmail

 Tkw_ForbidAutoregistration_Control_lblEmail_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_lblHint

 Tkw_ForbidAutoregistration_Control_lblHint_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbPhone

 Tkw_ForbidAutoregistration_Control_cbPhone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ForbidAutoregistration_Control_cbEmail

 Tkw_ForbidAutoregistration_Control_cbEmail_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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

function Tkw_Form_ForbidAutoregistration.GetString: AnsiString;
begin
 Result := 'efForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetString

class function Tkw_Form_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblReference.GetString: AnsiString;
begin
 Result := 'lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblReference');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblReference:push';
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_gbInfo.GetString: AnsiString;
begin
 Result := 'gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetString

class procedure Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('gbInfo');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::gbInfo:push';
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblPhone.GetString: AnsiString;
begin
 Result := 'lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblPhone:push';
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblEmail.GetString: AnsiString;
begin
 Result := 'lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblEmail:push';
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblHint.GetString: AnsiString;
begin
 Result := 'lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('lblHint');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lblHint:push';
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbPhone.GetString: AnsiString;
begin
 Result := 'cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbPhone:push';
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbEmail.GetString: AnsiString;
begin
 Result := 'cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine

class function Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister

procedure Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('cbEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::cbEmail:push';
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblReference.lblReference(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblReference }
begin
 Result := aefForbidAutoregistration.lblReference;
end;//TkwEfForbidAutoregistrationLblReference.lblReference

procedure TkwEfForbidAutoregistrationLblReference.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblReference(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblReference.DoDoIt

procedure TkwEfForbidAutoregistrationLblReference.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblReference', aCtx);
end;//TkwEfForbidAutoregistrationLblReference.SetValuePrim

function TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblReference.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblReference.GetAllParamsCount

function TkwEfForbidAutoregistrationLblReference.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblReference.ParamsTypes

class function TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblReference';
end;//TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister

function TkwEfForbidAutoregistrationGbInfo.gbInfo(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
 {* Реализация слова скрипта .TefForbidAutoregistration.gbInfo }
begin
 Result := aefForbidAutoregistration.gbInfo;
end;//TkwEfForbidAutoregistrationGbInfo.gbInfo

procedure TkwEfForbidAutoregistrationGbInfo.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(gbInfo(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationGbInfo.DoDoIt

procedure TkwEfForbidAutoregistrationGbInfo.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbInfo', aCtx);
end;//TkwEfForbidAutoregistrationGbInfo.SetValuePrim

function TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo

function TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount

function TkwEfForbidAutoregistrationGbInfo.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationGbInfo.ParamsTypes

class function TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.gbInfo';
end;//TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblPhone.lblPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblPhone }
begin
 Result := aefForbidAutoregistration.lblPhone;
end;//TkwEfForbidAutoregistrationLblPhone.lblPhone

procedure TkwEfForbidAutoregistrationLblPhone.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblPhone(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblPhone.DoDoIt

procedure TkwEfForbidAutoregistrationLblPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblPhone', aCtx);
end;//TkwEfForbidAutoregistrationLblPhone.SetValuePrim

function TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationLblPhone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblPhone.ParamsTypes

class function TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblPhone';
end;//TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblEmail.lblEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblEmail }
begin
 Result := aefForbidAutoregistration.lblEmail;
end;//TkwEfForbidAutoregistrationLblEmail.lblEmail

procedure TkwEfForbidAutoregistrationLblEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblEmail(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblEmail.DoDoIt

procedure TkwEfForbidAutoregistrationLblEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblEmail', aCtx);
end;//TkwEfForbidAutoregistrationLblEmail.SetValuePrim

function TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationLblEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblEmail.ParamsTypes

class function TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblEmail';
end;//TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister

function TkwEfForbidAutoregistrationLblHint.lblHint(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {* Реализация слова скрипта .TefForbidAutoregistration.lblHint }
begin
 Result := aefForbidAutoregistration.lblHint;
end;//TkwEfForbidAutoregistrationLblHint.lblHint

procedure TkwEfForbidAutoregistrationLblHint.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(lblHint(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationLblHint.DoDoIt

procedure TkwEfForbidAutoregistrationLblHint.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblHint', aCtx);
end;//TkwEfForbidAutoregistrationLblHint.SetValuePrim

function TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationLblHint.GetAllParamsCount

function TkwEfForbidAutoregistrationLblHint.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblHint.ParamsTypes

class function TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.lblHint';
end;//TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister

function TkwEfForbidAutoregistrationCbPhone.cbPhone(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* Реализация слова скрипта .TefForbidAutoregistration.cbPhone }
begin
 Result := aefForbidAutoregistration.cbPhone;
end;//TkwEfForbidAutoregistrationCbPhone.cbPhone

procedure TkwEfForbidAutoregistrationCbPhone.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbPhone(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationCbPhone.DoDoIt

procedure TkwEfForbidAutoregistrationCbPhone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbPhone', aCtx);
end;//TkwEfForbidAutoregistrationCbPhone.SetValuePrim

function TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationCbPhone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbPhone.ParamsTypes

class function TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbPhone';
end;//TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister

function TkwEfForbidAutoregistrationCbEmail.cbEmail(const aCtx: TtfwContext;
 aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {* Реализация слова скрипта .TefForbidAutoregistration.cbEmail }
begin
 Result := aefForbidAutoregistration.cbEmail;
end;//TkwEfForbidAutoregistrationCbEmail.cbEmail

procedure TkwEfForbidAutoregistrationCbEmail.DoDoIt(const aCtx: TtfwContext);
var l_aefForbidAutoregistration: TefForbidAutoregistration;
begin
 try
  l_aefForbidAutoregistration := TefForbidAutoregistration(aCtx.rEngine.PopObjAs(TefForbidAutoregistration));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefForbidAutoregistration: TefForbidAutoregistration : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(cbEmail(aCtx, l_aefForbidAutoregistration));
end;//TkwEfForbidAutoregistrationCbEmail.DoDoIt

procedure TkwEfForbidAutoregistrationCbEmail.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbEmail', aCtx);
end;//TkwEfForbidAutoregistrationCbEmail.SetValuePrim

function TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationCbEmail.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbEmail.ParamsTypes

class function TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefForbidAutoregistration.cbEmail';
end;//TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister

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
