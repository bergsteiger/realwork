unit EULAKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы EULA }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\EULAKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

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
  {* Слово словаря для идентификатора формы EULA
----
*Пример использования*:
[code]
'aControl' форма::EULA TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_EULA

 Tkw_EULA_Control_ShellCaptionLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel

 Tkw_EULA_Control_ShellCaptionLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ShellCaptionLabel
----
*Пример использования*:
[code]
контрол::ShellCaptionLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_ShellCaptionLabel_Push

 Tkw_EULA_Control_OkButton = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_OkButton

 Tkw_EULA_Control_OkButton_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола OkButton
----
*Пример использования*:
[code]
контрол::OkButton:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_OkButton_Push

 Tkw_EULA_Control_eeMemoWithEditOperations1 = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола eeMemoWithEditOperations1
----
*Пример использования*:
[code]
контрол::eeMemoWithEditOperations1 TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1

 Tkw_EULA_Control_eeMemoWithEditOperations1_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола eeMemoWithEditOperations1
----
*Пример использования*:
[code]
контрол::eeMemoWithEditOperations1:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push

 TkwEfEULAShellCaptionLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefEULA.ShellCaptionLabel
[panel]Контрол ShellCaptionLabel формы TefEULA[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aefEULA .TefEULA.ShellCaptionLabel >>> l_TvtLabel
[code]  }
  private
   function ShellCaptionLabel(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtLabel;
    {* Реализация слова скрипта .TefEULA.ShellCaptionLabel }
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
  {* Слово скрипта .TefEULA.OkButton
[panel]Контрол OkButton формы TefEULA[panel]
*Тип результата:* TvtButton
*Пример:*
[code]
OBJECT VAR l_TvtButton
 aefEULA .TefEULA.OkButton >>> l_TvtButton
[code]  }
  private
   function OkButton(const aCtx: TtfwContext;
    aefEULA: TefEULA): TvtButton;
    {* Реализация слова скрипта .TefEULA.OkButton }
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
  {* Слово скрипта .TefEULA.eeMemoWithEditOperations1
[panel]Контрол eeMemoWithEditOperations1 формы TefEULA[panel]
*Тип результата:* TeeMemoWithEditOperations
*Пример:*
[code]
OBJECT VAR l_TeeMemoWithEditOperations
 aefEULA .TefEULA.eeMemoWithEditOperations1 >>> l_TeeMemoWithEditOperations
[code]  }
  private
   function eeMemoWithEditOperations1(const aCtx: TtfwContext;
    aefEULA: TefEULA): TeeMemoWithEditOperations;
    {* Реализация слова скрипта .TefEULA.eeMemoWithEditOperations1 }
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
 Result := 'форма::EULA';
end;//Tkw_Form_EULA.GetWordNameForRegister

function Tkw_Form_EULA.GetString: AnsiString;
begin
 Result := 'efEULA';
end;//Tkw_Form_EULA.GetString

class function Tkw_EULA_Control_ShellCaptionLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ShellCaptionLabel';
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
 Result := 'контрол::ShellCaptionLabel:push';
end;//Tkw_EULA_Control_ShellCaptionLabel_Push.GetWordNameForRegister

class function Tkw_EULA_Control_OkButton.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::OkButton';
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
 Result := 'контрол::OkButton:push';
end;//Tkw_EULA_Control_OkButton_Push.GetWordNameForRegister

class function Tkw_EULA_Control_eeMemoWithEditOperations1.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::eeMemoWithEditOperations1';
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
 Result := 'контрол::eeMemoWithEditOperations1:push';
end;//Tkw_EULA_Control_eeMemoWithEditOperations1_Push.GetWordNameForRegister

function TkwEfEULAShellCaptionLabel.ShellCaptionLabel(const aCtx: TtfwContext;
 aefEULA: TefEULA): TvtLabel;
 {* Реализация слова скрипта .TefEULA.ShellCaptionLabel }
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
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству ShellCaptionLabel', aCtx);
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
 {* Реализация слова скрипта .TefEULA.OkButton }
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
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству OkButton', aCtx);
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
 {* Реализация слова скрипта .TefEULA.eeMemoWithEditOperations1 }
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
   RunnerError('Ошибка при получении параметра aefEULA: TefEULA : ' + E.Message, aCtx);
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
 RunnerError('Нельзя присваивать значение readonly свойству eeMemoWithEditOperations1', aCtx);
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
 {* Регистрация Tkw_Form_EULA }
 Tkw_EULA_Control_ShellCaptionLabel.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_ShellCaptionLabel }
 Tkw_EULA_Control_ShellCaptionLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_ShellCaptionLabel_Push }
 Tkw_EULA_Control_OkButton.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_OkButton }
 Tkw_EULA_Control_OkButton_Push.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_OkButton_Push }
 Tkw_EULA_Control_eeMemoWithEditOperations1.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_eeMemoWithEditOperations1 }
 Tkw_EULA_Control_eeMemoWithEditOperations1_Push.RegisterInEngine;
 {* Регистрация Tkw_EULA_Control_eeMemoWithEditOperations1_Push }
 TkwEfEULAShellCaptionLabel.RegisterInEngine;
 {* Регистрация efEULA_ShellCaptionLabel }
 TkwEfEULAOkButton.RegisterInEngine;
 {* Регистрация efEULA_OkButton }
 TkwEfEULAEeMemoWithEditOperations1.RegisterInEngine;
 {* Регистрация efEULA_eeMemoWithEditOperations1 }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefEULA));
 {* Регистрация типа EULA }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtButton));
 {* Регистрация типа TvtButton }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeMemoWithEditOperations));
 {* Регистрация типа TeeMemoWithEditOperations }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
