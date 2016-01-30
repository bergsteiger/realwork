unit PostingsListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы PostingsList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\PostingsListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , CommonPost_Module
 , eeTreeView
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_PostingsList = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы PostingsList
----
*Пример использования*:
[code]
'aControl' форма::PostingsList TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_PostingsList

 Tkw_PostingsList_Control_tvPostings = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvPostings
----
*Пример использования*:
[code]
контрол::tvPostings TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_PostingsList_Control_tvPostings

 Tkw_PostingsList_Control_tvPostings_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvPostings
----
*Пример использования*:
[code]
контрол::tvPostings:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings_Push

 TkwEnPostingsListTvPostings = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TenPostingsList.tvPostings
[panel]Контрол tvPostings формы TenPostingsList[panel]
*Тип результата:* TeeTreeView
*Пример:*
[code]
OBJECT VAR l_TeeTreeView
 aenPostingsList .TenPostingsList.tvPostings >>> l_TeeTreeView
[code]  }
  private
   function tvPostings(const aCtx: TtfwContext;
    aenPostingsList: TenPostingsList): TeeTreeView;
    {* Реализация слова скрипта .TenPostingsList.tvPostings }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEnPostingsListTvPostings

class function Tkw_Form_PostingsList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::PostingsList';
end;//Tkw_Form_PostingsList.GetWordNameForRegister

function Tkw_Form_PostingsList.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B32E48C9C5F6_var*
//#UC END# *4DDFD2EA0116_B32E48C9C5F6_var*
begin
//#UC START# *4DDFD2EA0116_B32E48C9C5F6_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B32E48C9C5F6_impl*
end;//Tkw_Form_PostingsList.GetString

class function Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister

function Tkw_PostingsList_Control_tvPostings.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_9246E180CAF0_var*
//#UC END# *4DDFD2EA0116_9246E180CAF0_var*
begin
//#UC START# *4DDFD2EA0116_9246E180CAF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_9246E180CAF0_impl*
end;//Tkw_PostingsList_Control_tvPostings.GetString

class procedure Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
//#UC START# *52A086150180_9246E180CAF0_var*
//#UC END# *52A086150180_9246E180CAF0_var*
begin
//#UC START# *52A086150180_9246E180CAF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_9246E180CAF0_impl*
end;//Tkw_PostingsList_Control_tvPostings.RegisterInEngine

procedure Tkw_PostingsList_Control_tvPostings_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7241BE7680A1_var*
//#UC END# *4DAEEDE10285_7241BE7680A1_var*
begin
//#UC START# *4DAEEDE10285_7241BE7680A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7241BE7680A1_impl*
end;//Tkw_PostingsList_Control_tvPostings_Push.DoDoIt

class function Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvPostings:push';
end;//Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister

function TkwEnPostingsListTvPostings.tvPostings(const aCtx: TtfwContext;
 aenPostingsList: TenPostingsList): TeeTreeView;
 {* Реализация слова скрипта .TenPostingsList.tvPostings }
//#UC START# *002683D39CEF_901756EC93AA_var*
//#UC END# *002683D39CEF_901756EC93AA_var*
begin
//#UC START# *002683D39CEF_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *002683D39CEF_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.tvPostings

procedure TkwEnPostingsListTvPostings.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_901756EC93AA_var*
//#UC END# *4DAEEDE10285_901756EC93AA_var*
begin
//#UC START# *4DAEEDE10285_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.DoDoIt

class function TkwEnPostingsListTvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenPostingsList.tvPostings';
end;//TkwEnPostingsListTvPostings.GetWordNameForRegister

procedure TkwEnPostingsListTvPostings.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_901756EC93AA_var*
//#UC END# *52D00B00031A_901756EC93AA_var*
begin
//#UC START# *52D00B00031A_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.SetValuePrim

function TkwEnPostingsListTvPostings.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_901756EC93AA_var*
//#UC END# *551544E2001A_901756EC93AA_var*
begin
//#UC START# *551544E2001A_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.GetResultTypeInfo

function TkwEnPostingsListTvPostings.GetAllParamsCount(const aCtx: TtfwContext): Integer;
//#UC START# *559687E6025A_901756EC93AA_var*
//#UC END# *559687E6025A_901756EC93AA_var*
begin
//#UC START# *559687E6025A_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *559687E6025A_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.GetAllParamsCount

function TkwEnPostingsListTvPostings.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_901756EC93AA_var*
//#UC END# *5617F4D00243_901756EC93AA_var*
begin
//#UC START# *5617F4D00243_901756EC93AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_901756EC93AA_impl*
end;//TkwEnPostingsListTvPostings.ParamsTypes

initialization
 Tkw_Form_PostingsList.RegisterInEngine;
 {* Регистрация Tkw_Form_PostingsList }
 Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
 {* Регистрация Tkw_PostingsList_Control_tvPostings }
 Tkw_PostingsList_Control_tvPostings_Push.RegisterInEngine;
 {* Регистрация Tkw_PostingsList_Control_tvPostings_Push }
 TkwEnPostingsListTvPostings.RegisterInEngine;
 {* Регистрация enPostingsList_tvPostings }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenPostingsList));
 {* Регистрация типа PostingsList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
