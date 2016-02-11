unit ProgressIndicatorKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы ProgressIndicator }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Common\ProgressIndicatorKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimF1Common_Module
 {$If NOT Defined(NoVCL)}
 , ComCtrls
 {$IfEnd} // NOT Defined(NoVCL)
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
 Tkw_Form_ProgressIndicator = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы ProgressIndicator
----
*Пример использования*:
[code]
'aControl' форма::ProgressIndicator TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_ProgressIndicator

 Tkw_ProgressIndicator_Control_ProgressBar = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ProgressBar
----
*Пример использования*:
[code]
контрол::ProgressBar TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_ProgressIndicator_Control_ProgressBar

 Tkw_ProgressIndicator_Control_ProgressBar_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ProgressBar
----
*Пример использования*:
[code]
контрол::ProgressBar:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_ProgressIndicator_Control_ProgressBar_Push

 TkwEfProgressIndicatorProgressBar = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TefProgressIndicator.ProgressBar
[panel]Контрол ProgressBar формы TefProgressIndicator[panel]
*Тип результата:* TProgressBar
*Пример:*
[code]
OBJECT VAR l_TProgressBar
 aefProgressIndicator .TefProgressIndicator.ProgressBar >>> l_TProgressBar
[code]  }
  private
   function ProgressBar(const aCtx: TtfwContext;
    aefProgressIndicator: TefProgressIndicator): TProgressBar;
    {* Реализация слова скрипта .TefProgressIndicator.ProgressBar }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEfProgressIndicatorProgressBar

class function Tkw_Form_ProgressIndicator.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::ProgressIndicator';
end;//Tkw_Form_ProgressIndicator.GetWordNameForRegister

function Tkw_Form_ProgressIndicator.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_37B8325BAA5C_var*
//#UC END# *4DDFD2EA0116_37B8325BAA5C_var*
begin
//#UC START# *4DDFD2EA0116_37B8325BAA5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_37B8325BAA5C_impl*
end;//Tkw_Form_ProgressIndicator.GetString

class function Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar';
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetWordNameForRegister

function Tkw_ProgressIndicator_Control_ProgressBar.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_D7DC3FFE5333_var*
//#UC END# *4DDFD2EA0116_D7DC3FFE5333_var*
begin
//#UC START# *4DDFD2EA0116_D7DC3FFE5333_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_D7DC3FFE5333_impl*
end;//Tkw_ProgressIndicator_Control_ProgressBar.GetString

class procedure Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
//#UC START# *52A086150180_D7DC3FFE5333_var*
//#UC END# *52A086150180_D7DC3FFE5333_var*
begin
//#UC START# *52A086150180_D7DC3FFE5333_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_D7DC3FFE5333_impl*
end;//Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine

procedure Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D12519600B94_var*
//#UC END# *4DAEEDE10285_D12519600B94_var*
begin
//#UC START# *4DAEEDE10285_D12519600B94_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D12519600B94_impl*
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.DoDoIt

class function Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ProgressBar:push';
end;//Tkw_ProgressIndicator_Control_ProgressBar_Push.GetWordNameForRegister

function TkwEfProgressIndicatorProgressBar.ProgressBar(const aCtx: TtfwContext;
 aefProgressIndicator: TefProgressIndicator): TProgressBar;
 {* Реализация слова скрипта .TefProgressIndicator.ProgressBar }
//#UC START# *2984FEE345A9_048590F2C0A3_var*
//#UC END# *2984FEE345A9_048590F2C0A3_var*
begin
//#UC START# *2984FEE345A9_048590F2C0A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *2984FEE345A9_048590F2C0A3_impl*
end;//TkwEfProgressIndicatorProgressBar.ProgressBar

procedure TkwEfProgressIndicatorProgressBar.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_048590F2C0A3_var*
//#UC END# *4DAEEDE10285_048590F2C0A3_var*
begin
//#UC START# *4DAEEDE10285_048590F2C0A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_048590F2C0A3_impl*
end;//TkwEfProgressIndicatorProgressBar.DoDoIt

class function TkwEfProgressIndicatorProgressBar.GetWordNameForRegister: AnsiString;
begin
 Result := '.TefProgressIndicator.ProgressBar';
end;//TkwEfProgressIndicatorProgressBar.GetWordNameForRegister

procedure TkwEfProgressIndicatorProgressBar.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_048590F2C0A3_var*
//#UC END# *52D00B00031A_048590F2C0A3_var*
begin
//#UC START# *52D00B00031A_048590F2C0A3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_048590F2C0A3_impl*
end;//TkwEfProgressIndicatorProgressBar.SetValuePrim

function TkwEfProgressIndicatorProgressBar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TProgressBar);
end;//TkwEfProgressIndicatorProgressBar.GetResultTypeInfo

function TkwEfProgressIndicatorProgressBar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEfProgressIndicatorProgressBar.GetAllParamsCount

function TkwEfProgressIndicatorProgressBar.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEfProgressIndicatorProgressBar.ParamsTypes

initialization
 Tkw_Form_ProgressIndicator.RegisterInEngine;
 {* Регистрация Tkw_Form_ProgressIndicator }
 Tkw_ProgressIndicator_Control_ProgressBar.RegisterInEngine;
 {* Регистрация Tkw_ProgressIndicator_Control_ProgressBar }
 Tkw_ProgressIndicator_Control_ProgressBar_Push.RegisterInEngine;
 {* Регистрация Tkw_ProgressIndicator_Control_ProgressBar_Push }
 TkwEfProgressIndicatorProgressBar.RegisterInEngine;
 {* Регистрация efProgressIndicator_ProgressBar }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TefProgressIndicator));
 {* Регистрация типа ProgressIndicator }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TProgressBar));
 {* Регистрация типа TProgressBar }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
