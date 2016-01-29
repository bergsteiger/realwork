unit EULAKeywordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Автор: Люлин А.В.
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Common/EULAKeywordsPack.pas"
// Начат: 24.08.2009 20:35
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> F1 Core::Common::View::Common::PrimF1Common::EULAKeywordsPack
//
// Набор слов словаря для доступа к экземплярам контролов формы EULA
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
  EULA_Form,
  eeMemoWithEditOperations,
  vtLabel,
  tfwScriptingInterfaces
  {$If not defined(NoScripts) AND not defined(NoVCL)}
  ,
  kwBynameControlPush
  {$IfEnd} //not NoScripts AND not NoVCL
  ,
  tfwControlString,
  vtButton,
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
  Tkw_Form_EULA = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора формы EULA
----
*Пример использования*:
[code]
'aControl' форма::EULA TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
  end;//Tkw_Form_EULA

// start class Tkw_Form_EULA

class function Tkw_Form_EULA.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'форма::EULA';
end;//Tkw_Form_EULA.GetWordNameForRegister

function Tkw_Form_EULA.GetString: AnsiString;
 {-}
begin
 Result := 'efEULA';
end;//Tkw_Form_EULA.GetString

type
  Tkw_EULA_Control_ShellCaptionLabel = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_EULA_Control_ShellCaptionLabel

// start class Tkw_EULA_Control_ShellCaptionLabel

class function Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellCaptionLabel';
end;//Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister

function Tkw_EULA_Control_ShellCaptionLabel.GetString: AnsiString;
 {-}
begin
 Result := 'ShellCaptionLabel';
end;//Tkw_EULA_Control_ShellCaptionLabel.GetString

class procedure Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtLabel);
end;//Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine

type
  Tkw_EULA_Control_ShellCaptionLabel_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_EULA_Control_ShellCaptionLabel_Push

// start class Tkw_EULA_Control_ShellCaptionLabel_Push

procedure Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('ShellCaptionLabel');
 inherited;
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.DoDoIt

class function Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::ShellCaptionLabel:push';
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister

type
  Tkw_EULA_Control_OkButton = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_EULA_Control_OkButton

// start class Tkw_EULA_Control_OkButton

class function Tkw_EULA_Control_OkButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OkButton';
end;//Tkw_EULA_Control_OkButton.GetWordNameForRegister

function Tkw_EULA_Control_OkButton.GetString: AnsiString;
 {-}
begin
 Result := 'OkButton';
end;//Tkw_EULA_Control_OkButton.GetString

class procedure Tkw_EULA_Control_OkButton.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TvtButton);
end;//Tkw_EULA_Control_OkButton.RegisterInEngine

type
  Tkw_EULA_Control_OkButton_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_EULA_Control_OkButton_Push

// start class Tkw_EULA_Control_OkButton_Push

procedure Tkw_EULA_Control_OkButton_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('OkButton');
 inherited;
end;//Tkw_EULA_Control_OkButton_Push.DoDoIt

class function Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::OkButton:push';
end;//Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister

type
  Tkw_EULA_Control_eeMemoWithEditOperations1 = {final scriptword} class(TtfwControlString)
   {* Слово словаря для идентификатора контрола eeMemoWithEditOperations1
----
*Пример использования*:
[code]
контрол::eeMemoWithEditOperations1 TryFocus ASSERT
[code] }
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
  end;//Tkw_EULA_Control_eeMemoWithEditOperations1

// start class Tkw_EULA_Control_eeMemoWithEditOperations1

class function Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::eeMemoWithEditOperations1';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister

function Tkw_EULA_Control_eeMemoWithEditOperations1.GetString: AnsiString;
 {-}
begin
 Result := 'eeMemoWithEditOperations1';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.GetString

class procedure Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
 {-}
begin
 inherited;
 TtfwClassRef.Register(TeeMemoWithEditOperations);
end;//Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine

type
  Tkw_EULA_Control_eeMemoWithEditOperations1_Push = {final scriptword} class(TkwBynameControlPush)
   {* Слово словаря для контрола eeMemoWithEditOperations1
----
*Пример использования*:
[code]
контрол::eeMemoWithEditOperations1:push pop:control:SetFocus ASSERT
[code] }
  protected
  // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push

// start class Tkw_EULA_Control_eeMemoWithEditOperations1_Push

procedure Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt(const aCtx: TtfwContext);
 {-}
begin
 aCtx.rEngine.PushString('eeMemoWithEditOperations1');
 inherited;
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.DoDoIt

class function Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'контрол::eeMemoWithEditOperations1:push';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister

type
  TkwEfEULAShellCaptionLabel = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefEULA.ShellCaptionLabel
[panel]Контрол ShellCaptionLabel формы TefEULA[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefEULA .TefEULA.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
  // private methods
   function ShellCaptionLabel(const aCtx: TtfwContext;
     aefEULA: TefEULA): TvtLabel;
     {* Реализация слова скрипта .TefEULA.ShellCaptionLabel }
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
  end;//TkwEfEULAShellCaptionLabel

// start class TkwEfEULAShellCaptionLabel

function TkwEfEULAShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
  aefEULA: TefEULA): TvtLabel;
 {-}
begin
 Result := aefEULA.ShellCaptionLabel;
end;//TkwEfEULAShellCaptionLabel.ShellCaptionLabel

procedure TkwEfEULAShellCaptionLabel.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefEULA : TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ShellCaptionLabel(aCtx, l_aefEULA)));
end;//TkwEfEULAShellCaptionLabel.DoDoIt

class function TkwEfEULAShellCaptionLabel.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefEULA.ShellCaptionLabel';
end;//TkwEfEULAShellCaptionLabel.GetWordNameForRegister

procedure TkwEfEULAShellCaptionLabel.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству ShellCaptionLabel', aCtx);
end;//TkwEfEULAShellCaptionLabel.SetValuePrim

function TkwEfEULAShellCaptionLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtLabel);
end;//TkwEfEULAShellCaptionLabel.GetResultTypeInfo

function TkwEfEULAShellCaptionLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfEULAShellCaptionLabel.GetAllParamsCount

function TkwEfEULAShellCaptionLabel.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAShellCaptionLabel.ParamsTypes

type
  TkwEfEULAOkButton = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefEULA.OkButton
[panel]Контрол OkButton формы TefEULA[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aefEULA .TefEULA.OkButton >>> l_TvtButton
[code]  }
  private
  // private methods
   function OkButton(const aCtx: TtfwContext;
     aefEULA: TefEULA): TvtButton;
     {* Реализация слова скрипта .TefEULA.OkButton }
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
  end;//TkwEfEULAOkButton

// start class TkwEfEULAOkButton

function TkwEfEULAOkButton.OkButton(const aCtx: TtfwContext;
  aefEULA: TefEULA): TvtButton;
 {-}
begin
 Result := aefEULA.OkButton;
end;//TkwEfEULAOkButton.OkButton

procedure TkwEfEULAOkButton.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefEULA : TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((OkButton(aCtx, l_aefEULA)));
end;//TkwEfEULAOkButton.DoDoIt

class function TkwEfEULAOkButton.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefEULA.OkButton';
end;//TkwEfEULAOkButton.GetWordNameForRegister

procedure TkwEfEULAOkButton.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству OkButton', aCtx);
end;//TkwEfEULAOkButton.SetValuePrim

function TkwEfEULAOkButton.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TvtButton);
end;//TkwEfEULAOkButton.GetResultTypeInfo

function TkwEfEULAOkButton.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfEULAOkButton.GetAllParamsCount

function TkwEfEULAOkButton.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAOkButton.ParamsTypes

type
  TkwEfEULAEeMemoWithEditOperations1 = {final scriptword} class(TtfwPropertyLike)
   {* Слово скрипта .TefEULA.eeMemoWithEditOperations1
[panel]Контрол eeMemoWithEditOperations1 формы TefEULA[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aefEULA .TefEULA.eeMemoWithEditOperations1 >>> l_TeeMemoWithEditOperations
[code]  }
  private
  // private methods
   function EeMemoWithEditOperations1(const aCtx: TtfwContext;
     aefEULA: TefEULA): TeeMemoWithEditOperations;
     {* Реализация слова скрипта .TefEULA.eeMemoWithEditOperations1 }
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
  end;//TkwEfEULAEeMemoWithEditOperations1

// start class TkwEfEULAEeMemoWithEditOperations1

function TkwEfEULAEeMemoWithEditOperations1.EeMemoWithEditOperations1(const aCtx: TtfwContext;
  aefEULA: TefEULA): TeeMemoWithEditOperations;
 {-}
begin
 Result := aefEULA.eeMemoWithEditOperations1;
end;//TkwEfEULAEeMemoWithEditOperations1.EeMemoWithEditOperations1

procedure TkwEfEULAEeMemoWithEditOperations1.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aefEULA : TefEULA;
begin
 try
  l_aefEULA := TefEULA(aCtx.rEngine.PopObjAs(TefEULA));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((EeMemoWithEditOperations1(aCtx, l_aefEULA)));
end;//TkwEfEULAEeMemoWithEditOperations1.DoDoIt

class function TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '.TefEULA.eeMemoWithEditOperations1';
end;//TkwEfEULAEeMemoWithEditOperations1.GetWordNameForRegister

procedure TkwEfEULAEeMemoWithEditOperations1.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству eeMemoWithEditOperations1', aCtx);
end;//TkwEfEULAEeMemoWithEditOperations1.SetValuePrim

function TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TeeMemoWithEditOperations);
end;//TkwEfEULAEeMemoWithEditOperations1.GetResultTypeInfo

function TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwEfEULAEeMemoWithEditOperations1.GetAllParamsCount

function TkwEfEULAEeMemoWithEditOperations1.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TefEULA)]);
end;//TkwEfEULAEeMemoWithEditOperations1.ParamsTypes
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

initialization
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_Form_EULA
 Tkw_Form_EULA.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_ShellCaptionLabel
 Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_ShellCaptionLabel_Push
 Tkw_EULA_Control_ShellCaptionLabel_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_OkButton
 Tkw_EULA_Control_OkButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_OkButton_Push
 Tkw_EULA_Control_OkButton_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_eeMemoWithEditOperations1
 Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация Tkw_EULA_Control_eeMemoWithEditOperations1_Push
 Tkw_EULA_Control_eeMemoWithEditOperations1_Push.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efEULA_ShellCaptionLabel
 TkwEfEULAShellCaptionLabel.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efEULA_OkButton
 TkwEfEULAOkButton.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация efEULA_eeMemoWithEditOperations1
 TkwEfEULAEeMemoWithEditOperations1.RegisterInEngine;
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа EULA
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefEULA));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtLabel
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TvtButton
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts
{$If not defined(Admin) AND not defined(Monitorings) AND not defined(NoScripts)}
// Регистрация типа TeeMemoWithEditOperations
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
{$IfEnd} //not Admin AND not Monitorings AND not NoScripts

end.