unit NewsLineKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы NewsLine }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\NewsLineKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , PrimMonitorings_Module
 , nscTreeViewForNewsLine
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
 Tkw_Form_NewsLine = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы NewsLine
----
*Пример использования*:
[code]
'aControl' форма::NewsLine TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_NewsLine

 Tkw_NewsLine_Control_DateList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DateList
----
*Пример использования*:
[code]
контрол::DateList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_NewsLine_Control_DateList

 Tkw_NewsLine_Control_DateList_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола DateList
----
*Пример использования*:
[code]
контрол::DateList:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_NewsLine_Control_DateList_Push

 TkwEnNewsLineDateList = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenNewsLine.DateList
[panel]Контрол DateList формы TenNewsLine[panel]
*Тип результата:* TnscTreeViewForNewsLine
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewForNewsLine
 aenNewsLine .TenNewsLine.DateList >>> l_TnscTreeViewForNewsLine
[code]  }
  private
   function DateList(const aCtx: TtfwContext;
    aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
    {* Реализация слова скрипта .TenNewsLine.DateList }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnNewsLineDateList

class function Tkw_Form_NewsLine.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::NewsLine';
end;//Tkw_Form_NewsLine.GetWordNameForRegister

function Tkw_Form_NewsLine.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_338085479364_var*
//#UC END# *4DDFD2EA0116_338085479364_var*
begin
//#UC START# *4DDFD2EA0116_338085479364_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_338085479364_impl*
end;//Tkw_Form_NewsLine.GetString

class function Tkw_NewsLine_Control_DateList.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DateList';
end;//Tkw_NewsLine_Control_DateList.GetWordNameForRegister

function Tkw_NewsLine_Control_DateList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_94273552B114_var*
//#UC END# *4DDFD2EA0116_94273552B114_var*
begin
//#UC START# *4DDFD2EA0116_94273552B114_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_94273552B114_impl*
end;//Tkw_NewsLine_Control_DateList.GetString

class procedure Tkw_NewsLine_Control_DateList.RegisterInEngine;
//#UC START# *52A086150180_94273552B114_var*
//#UC END# *52A086150180_94273552B114_var*
begin
//#UC START# *52A086150180_94273552B114_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_94273552B114_impl*
end;//Tkw_NewsLine_Control_DateList.RegisterInEngine

procedure Tkw_NewsLine_Control_DateList_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AC6143611DF2_var*
//#UC END# *4DAEEDE10285_AC6143611DF2_var*
begin
//#UC START# *4DAEEDE10285_AC6143611DF2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AC6143611DF2_impl*
end;//Tkw_NewsLine_Control_DateList_Push.DoDoIt

class function Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DateList:push';
end;//Tkw_NewsLine_Control_DateList_Push.GetWordNameForRegister

function TkwEnNewsLineDateList.DateList(const aCtx: TtfwContext;
 aenNewsLine: TenNewsLine): TnscTreeViewForNewsLine;
 {* Реализация слова скрипта .TenNewsLine.DateList }
//#UC START# *B7B4CDD07AC3_A7F619520F52_var*
//#UC END# *B7B4CDD07AC3_A7F619520F52_var*
begin
//#UC START# *B7B4CDD07AC3_A7F619520F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *B7B4CDD07AC3_A7F619520F52_impl*
end;//TkwEnNewsLineDateList.DateList

procedure TkwEnNewsLineDateList.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A7F619520F52_var*
//#UC END# *4DAEEDE10285_A7F619520F52_var*
begin
//#UC START# *4DAEEDE10285_A7F619520F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A7F619520F52_impl*
end;//TkwEnNewsLineDateList.DoDoIt

class function TkwEnNewsLineDateList.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenNewsLine.DateList';
end;//TkwEnNewsLineDateList.GetWordNameForRegister

procedure TkwEnNewsLineDateList.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_A7F619520F52_var*
//#UC END# *52D00B00031A_A7F619520F52_var*
begin
//#UC START# *52D00B00031A_A7F619520F52_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_A7F619520F52_impl*
end;//TkwEnNewsLineDateList.SetValuePrim

function TkwEnNewsLineDateList.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewForNewsLine);
end;//TkwEnNewsLineDateList.GetResultTypeInfo

function TkwEnNewsLineDateList.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnNewsLineDateList.GetAllParamsCount

function TkwEnNewsLineDateList.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEnNewsLineDateList.ParamsTypes

initialization
 Tkw_Form_NewsLine.RegisterInEngine;
 {* Регистрация Tkw_Form_NewsLine }
 Tkw_NewsLine_Control_DateList.RegisterInEngine;
 {* Регистрация Tkw_NewsLine_Control_DateList }
 Tkw_NewsLine_Control_DateList_Push.RegisterInEngine;
 {* Регистрация Tkw_NewsLine_Control_DateList_Push }
 TkwEnNewsLineDateList.RegisterInEngine;
 {* Регистрация enNewsLine_DateList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenNewsLine));
 {* Регистрация типа NewsLine }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewForNewsLine));
 {* Регистрация типа TnscTreeViewForNewsLine }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
