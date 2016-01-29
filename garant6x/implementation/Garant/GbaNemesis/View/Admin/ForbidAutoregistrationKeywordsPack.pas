unit ForbidAutoregistrationKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Admin/ForbidAutoregistrationKeywordsPack.pas"
// Начат: 07.09.2009 18:00
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Администратор::Admin::View::Admin::Admin::ForbidAutoregistrationKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы ForbidAutoregistration
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If defined(Admin) AND not defined(NoScripts)}
uses
  ForbidAutoregistration_Form,
  vtGroupBox
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
  tfwPropertyLike
  ;

{$IfEnd} //Admin AND not NoScripts

implementation

{$If defined(Admin) AND not defined(NoScripts)}
uses
  TtfwClassRef_Proxy,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
  Tkw_Form_ForbidAutoregistration = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы ForbidAutoregistration
----
*Пример использования*:
[code]
'aControl' форма::ForbidAutoregistration TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_ForbidAutoregistration

// start class Tkw_Form_ForbidAutoregistration

class function Tkw_Form_ForbidAutoregistration.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::ForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetWordNameForRegister

function Tkw_Form_ForbidAutoregistration.GetString: AnsiString;
 {-}
begin
 Result := 'efForbidAutoregistration';
end;//Tkw_Form_ForbidAutoregistration.GetString

type
  Tkw_ForbidAutoregistration_Control_lblReference = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblReference
----
*Пример использования*:
[code]
контрол::lblReference TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_lblReference

// start class Tkw_ForbidAutoregistration_Control_lblReference

class function Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblReference.GetString: AnsiString;
 {-}
begin
 Result := 'lblReference';
end;//Tkw_ForbidAutoregistration_Control_lblReference.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_lblReference_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblReference
----
*Пример использования*:
[code]
контрол::lblReference:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_lblReference_Push

// start class Tkw_ForbidAutoregistration_Control_lblReference_Push

procedure Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblReference');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblReference:push';
end;//Tkw_ForbidAutoregistration_Control_lblReference_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_gbInfo = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола gbInfo
----
*Пример использования*:
[code]
контрол::gbInfo TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_gbInfo

// start class Tkw_ForbidAutoregistration_Control_gbInfo

class function Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_gbInfo.GetString: AnsiString;
 {-}
begin
 Result := 'gbInfo';
end;//Tkw_ForbidAutoregistration_Control_gbInfo.GetString

class procedure Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_gbInfo_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола gbInfo
----
*Пример использования*:
[code]
контрол::gbInfo:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push

// start class Tkw_ForbidAutoregistration_Control_gbInfo_Push

procedure Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('gbInfo');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::gbInfo:push';
end;//Tkw_ForbidAutoregistration_Control_gbInfo_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_lblPhone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblPhone
----
*Пример использования*:
[code]
контрол::lblPhone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_lblPhone

// start class Tkw_ForbidAutoregistration_Control_lblPhone

class function Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblPhone.GetString: AnsiString;
 {-}
begin
 Result := 'lblPhone';
end;//Tkw_ForbidAutoregistration_Control_lblPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_lblPhone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblPhone
----
*Пример использования*:
[code]
контрол::lblPhone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push

// start class Tkw_ForbidAutoregistration_Control_lblPhone_Push

procedure Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblPhone:push';
end;//Tkw_ForbidAutoregistration_Control_lblPhone_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_lblEmail = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblEmail
----
*Пример использования*:
[code]
контрол::lblEmail TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_lblEmail

// start class Tkw_ForbidAutoregistration_Control_lblEmail

class function Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblEmail.GetString: AnsiString;
 {-}
begin
 Result := 'lblEmail';
end;//Tkw_ForbidAutoregistration_Control_lblEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_lblEmail_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblEmail
----
*Пример использования*:
[code]
контрол::lblEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push

// start class Tkw_ForbidAutoregistration_Control_lblEmail_Push

procedure Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblEmail:push';
end;//Tkw_ForbidAutoregistration_Control_lblEmail_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_lblHint = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола lblHint
----
*Пример использования*:
[code]
контрол::lblHint TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_lblHint

// start class Tkw_ForbidAutoregistration_Control_lblHint

class function Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_lblHint.GetString: AnsiString;
 {-}
begin
 Result := 'lblHint';
end;//Tkw_ForbidAutoregistration_Control_lblHint.GetString

class procedure Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_lblHint_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола lblHint
----
*Пример использования*:
[code]
контрол::lblHint:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_lblHint_Push

// start class Tkw_ForbidAutoregistration_Control_lblHint_Push

procedure Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('lblHint');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::lblHint:push';
end;//Tkw_ForbidAutoregistration_Control_lblHint_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_cbPhone = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbPhone
----
*Пример использования*:
[code]
контрол::cbPhone TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_cbPhone

// start class Tkw_ForbidAutoregistration_Control_cbPhone

class function Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbPhone.GetString: AnsiString;
 {-}
begin
 Result := 'cbPhone';
end;//Tkw_ForbidAutoregistration_Control_cbPhone.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_cbPhone_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbPhone
----
*Пример использования*:
[code]
контрол::cbPhone:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push

// start class Tkw_ForbidAutoregistration_Control_cbPhone_Push

procedure Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbPhone');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbPhone:push';
end;//Tkw_ForbidAutoregistration_Control_cbPhone_Push.GetWordNameForRegister

type
  Tkw_ForbidAutoregistration_Control_cbEmail = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола cbEmail
----
*Пример использования*:
[code]
контрол::cbEmail TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_ForbidAutoregistration_Control_cbEmail

// start class Tkw_ForbidAutoregistration_Control_cbEmail

class function Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetWordNameForRegister

function Tkw_ForbidAutoregistration_Control_cbEmail.GetString: AnsiString;
 {-}
begin
 Result := 'cbEmail';
end;//Tkw_ForbidAutoregistration_Control_cbEmail.GetString

class procedure Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TnscEdit);
end;//Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine

type
  Tkw_ForbidAutoregistration_Control_cbEmail_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола cbEmail
----
*Пример использования*:
[code]
контрол::cbEmail:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push

// start class Tkw_ForbidAutoregistration_Control_cbEmail_Push

procedure Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('cbEmail');
 inherited;
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.DoDoIt

class function Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::cbEmail:push';
end;//Tkw_ForbidAutoregistration_Control_cbEmail_Push.GetWordNameForRegister

type
  TkwEfForbidAutoregistrationLblReference = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.lblReference
[panel]Контрол lblReference формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblReference >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblReference(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
     {* Реализация слова скрипта .TefForbidAutoregistration.lblReference }
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
  end;//TkwEfForbidAutoregistrationLblReference

// start class TkwEfForbidAutoregistrationLblReference

function TkwEfForbidAutoregistrationLblReference.LblReference(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {-}
begin
 Result := aefForbidAutoregistration.lblReference;
end;//TkwEfForbidAutoregistrationLblReference.LblReference

procedure TkwEfForbidAutoregistrationLblReference.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((LblReference(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationLblReference.DoDoIt

class function TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.lblReference';
end;//TkwEfForbidAutoregistrationLblReference.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblReference.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblReference', aCtx);
end;//TkwEfForbidAutoregistrationLblReference.SetValuePrim

function TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblReference.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblReference.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationLblReference.GetAllParamsCount

function TkwEfForbidAutoregistrationLblReference.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblReference.ParamsTypes

type
  TkwEfForbidAutoregistrationGbInfo = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.gbInfo
[panel]Контрол gbInfo формы TefForbidAutoregistration[panel]
*Тип результата:* TvtGroupBox
*Пример:*
[code]
OBJECT VAR l_TvtGroupBox
 aefForbidAutoregistration .TefForbidAutoregistration.gbInfo >>> l_TvtGroupBox
[code]  }
  private
  // private methods
   function GbInfo(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
     {* Реализация слова скрипта .TefForbidAutoregistration.gbInfo }
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
  end;//TkwEfForbidAutoregistrationGbInfo

// start class TkwEfForbidAutoregistrationGbInfo

function TkwEfForbidAutoregistrationGbInfo.GbInfo(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TvtGroupBox;
 {-}
begin
 Result := aefForbidAutoregistration.gbInfo;
end;//TkwEfForbidAutoregistrationGbInfo.GbInfo

procedure TkwEfForbidAutoregistrationGbInfo.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((GbInfo(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationGbInfo.DoDoIt

class function TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.gbInfo';
end;//TkwEfForbidAutoregistrationGbInfo.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationGbInfo.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству gbInfo', aCtx);
end;//TkwEfForbidAutoregistrationGbInfo.SetValuePrim

function TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEfForbidAutoregistrationGbInfo.GetResultTypeInfo

function TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationGbInfo.GetAllParamsCount

function TkwEfForbidAutoregistrationGbInfo.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationGbInfo.ParamsTypes

type
  TkwEfForbidAutoregistrationLblPhone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.lblPhone
[panel]Контрол lblPhone формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblPhone >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblPhone(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
     {* Реализация слова скрипта .TefForbidAutoregistration.lblPhone }
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
  end;//TkwEfForbidAutoregistrationLblPhone

// start class TkwEfForbidAutoregistrationLblPhone

function TkwEfForbidAutoregistrationLblPhone.LblPhone(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {-}
begin
 Result := aefForbidAutoregistration.lblPhone;
end;//TkwEfForbidAutoregistrationLblPhone.LblPhone

procedure TkwEfForbidAutoregistrationLblPhone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((LblPhone(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationLblPhone.DoDoIt

class function TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.lblPhone';
end;//TkwEfForbidAutoregistrationLblPhone.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblPhone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblPhone', aCtx);
end;//TkwEfForbidAutoregistrationLblPhone.SetValuePrim

function TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationLblPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationLblPhone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblPhone.ParamsTypes

type
  TkwEfForbidAutoregistrationLblEmail = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.lblEmail
[panel]Контрол lblEmail формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblEmail >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblEmail(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
     {* Реализация слова скрипта .TefForbidAutoregistration.lblEmail }
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
  end;//TkwEfForbidAutoregistrationLblEmail

// start class TkwEfForbidAutoregistrationLblEmail

function TkwEfForbidAutoregistrationLblEmail.LblEmail(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {-}
begin
 Result := aefForbidAutoregistration.lblEmail;
end;//TkwEfForbidAutoregistrationLblEmail.LblEmail

procedure TkwEfForbidAutoregistrationLblEmail.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((LblEmail(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationLblEmail.DoDoIt

class function TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.lblEmail';
end;//TkwEfForbidAutoregistrationLblEmail.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblEmail.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblEmail', aCtx);
end;//TkwEfForbidAutoregistrationLblEmail.SetValuePrim

function TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationLblEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationLblEmail.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblEmail.ParamsTypes

type
  TkwEfForbidAutoregistrationLblHint = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.lblHint
[panel]Контрол lblHint формы TefForbidAutoregistration[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefForbidAutoregistration .TefForbidAutoregistration.lblHint >>> l_TvtLabel
[code]  }
  private
  // private methods
   function LblHint(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
     {* Реализация слова скрипта .TefForbidAutoregistration.lblHint }
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
  end;//TkwEfForbidAutoregistrationLblHint

// start class TkwEfForbidAutoregistrationLblHint

function TkwEfForbidAutoregistrationLblHint.LblHint(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TvtLabel;
 {-}
begin
 Result := aefForbidAutoregistration.lblHint;
end;//TkwEfForbidAutoregistrationLblHint.LblHint

procedure TkwEfForbidAutoregistrationLblHint.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((LblHint(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationLblHint.DoDoIt

class function TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.lblHint';
end;//TkwEfForbidAutoregistrationLblHint.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationLblHint.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству lblHint', aCtx);
end;//TkwEfForbidAutoregistrationLblHint.SetValuePrim

function TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfForbidAutoregistrationLblHint.GetResultTypeInfo

function TkwEfForbidAutoregistrationLblHint.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationLblHint.GetAllParamsCount

function TkwEfForbidAutoregistrationLblHint.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationLblHint.ParamsTypes

type
  TkwEfForbidAutoregistrationCbPhone = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.cbPhone
[panel]Контрол cbPhone формы TefForbidAutoregistration[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefForbidAutoregistration .TefForbidAutoregistration.cbPhone >>> l_TnscEdit
[code]  }
  private
  // private methods
   function CbPhone(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
     {* Реализация слова скрипта .TefForbidAutoregistration.cbPhone }
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
  end;//TkwEfForbidAutoregistrationCbPhone

// start class TkwEfForbidAutoregistrationCbPhone

function TkwEfForbidAutoregistrationCbPhone.CbPhone(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {-}
begin
 Result := aefForbidAutoregistration.cbPhone;
end;//TkwEfForbidAutoregistrationCbPhone.CbPhone

procedure TkwEfForbidAutoregistrationCbPhone.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((CbPhone(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationCbPhone.DoDoIt

class function TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.cbPhone';
end;//TkwEfForbidAutoregistrationCbPhone.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationCbPhone.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbPhone', aCtx);
end;//TkwEfForbidAutoregistrationCbPhone.SetValuePrim

function TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbPhone.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationCbPhone.GetAllParamsCount

function TkwEfForbidAutoregistrationCbPhone.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbPhone.ParamsTypes

type
  TkwEfForbidAutoregistrationCbEmail = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefForbidAutoregistration.cbEmail
[panel]Контрол cbEmail формы TefForbidAutoregistration[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aefForbidAutoregistration .TefForbidAutoregistration.cbEmail >>> l_TnscEdit
[code]  }
  private
  // private methods
   function CbEmail(const aCtx: TtfwContext;
     aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
     {* Реализация слова скрипта .TefForbidAutoregistration.cbEmail }
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
  end;//TkwEfForbidAutoregistrationCbEmail

// start class TkwEfForbidAutoregistrationCbEmail

function TkwEfForbidAutoregistrationCbEmail.CbEmail(const aCtx: TtfwContext;
  aefForbidAutoregistration: TefForbidAutoregistration): TnscEdit;
 {-}
begin
 Result := aefForbidAutoregistration.cbEmail;
end;//TkwEfForbidAutoregistrationCbEmail.CbEmail

procedure TkwEfForbidAutoregistrationCbEmail.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefForbidAutoregistration : TefForbidAutoregistration;
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
 aCtx.rEngine.PushObj((CbEmail(aCtx, l_aefForbidAutoregistration)));
end;//TkwEfForbidAutoregistrationCbEmail.DoDoIt

class function TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefForbidAutoregistration.cbEmail';
end;//TkwEfForbidAutoregistrationCbEmail.GetWordNameForRegister

procedure TkwEfForbidAutoregistrationCbEmail.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству cbEmail', aCtx);
end;//TkwEfForbidAutoregistrationCbEmail.SetValuePrim

function TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TnscEdit);
end;//TkwEfForbidAutoregistrationCbEmail.GetResultTypeInfo

function TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfForbidAutoregistrationCbEmail.GetAllParamsCount

function TkwEfForbidAutoregistrationCbEmail.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefForbidAutoregistration)]);
end;//TkwEfForbidAutoregistrationCbEmail.ParamsTypes
{$IfEnd} //Admin AND not NoScripts

initialization
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_Form_ForbidAutoregistration
 Tkw_Form_ForbidAutoregistration.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblReference
 Tkw_ForbidAutoregistration_Control_lblReference.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblReference_Push
 Tkw_ForbidAutoregistration_Control_lblReference_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_gbInfo
 Tkw_ForbidAutoregistration_Control_gbInfo.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_gbInfo_Push
 Tkw_ForbidAutoregistration_Control_gbInfo_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblPhone
 Tkw_ForbidAutoregistration_Control_lblPhone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblPhone_Push
 Tkw_ForbidAutoregistration_Control_lblPhone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblEmail
 Tkw_ForbidAutoregistration_Control_lblEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblEmail_Push
 Tkw_ForbidAutoregistration_Control_lblEmail_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblHint
 Tkw_ForbidAutoregistration_Control_lblHint.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_lblHint_Push
 Tkw_ForbidAutoregistration_Control_lblHint_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_cbPhone
 Tkw_ForbidAutoregistration_Control_cbPhone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_cbPhone_Push
 Tkw_ForbidAutoregistration_Control_cbPhone_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_cbEmail
 Tkw_ForbidAutoregistration_Control_cbEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация Tkw_ForbidAutoregistration_Control_cbEmail_Push
 Tkw_ForbidAutoregistration_Control_cbEmail_Push.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_lblReference
 TkwEfForbidAutoregistrationLblReference.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_gbInfo
 TkwEfForbidAutoregistrationGbInfo.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_lblPhone
 TkwEfForbidAutoregistrationLblPhone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_lblEmail
 TkwEfForbidAutoregistrationLblEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_lblHint
 TkwEfForbidAutoregistrationLblHint.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_cbPhone
 TkwEfForbidAutoregistrationCbPhone.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация efForbidAutoregistration_cbEmail
 TkwEfForbidAutoregistrationCbEmail.RegisterInEngine;
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа ForbidAutoregistration
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefForbidAutoregistration));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TvtGroupBox
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
{$IfEnd} //Admin AND not NoScripts
{$If defined(Admin) AND not defined(NoScripts)}
// Регистрация типа TnscEdit
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
{$IfEnd} //Admin AND not NoScripts

end.