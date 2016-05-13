unit PostingsListKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы PostingsList }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Monitorings\PostingsListKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PostingsListKeywordsPack" MUID: (1C12379D921C)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , eeTreeView
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , PostingsList_Form
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , TypInfo
 , tfwTypeInfo
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PostingsList

 Tkw_PostingsList_Control_tvPostings = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvPostings
----
*Пример использования*:
[code]
контрол::tvPostings TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PostingsList_Control_tvPostings

 Tkw_PostingsList_Control_tvPostings_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
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
  {* Слово скрипта .TenPostingsList.tvPostings }
  private
   function tvPostings(const aCtx: TtfwContext;
    aenPostingsList: TenPostingsList): TeeTreeView;
    {* Реализация слова скрипта .TenPostingsList.tvPostings }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnPostingsListTvPostings

function Tkw_Form_PostingsList.GetString: AnsiString;
begin
 Result := 'enPostingsList';
end;//Tkw_Form_PostingsList.GetString

class function Tkw_Form_PostingsList.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::PostingsList';
end;//Tkw_Form_PostingsList.GetWordNameForRegister

function Tkw_PostingsList_Control_tvPostings.GetString: AnsiString;
begin
 Result := 'tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetString

class procedure Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TeeTreeView);
end;//Tkw_PostingsList_Control_tvPostings.RegisterInEngine

class function Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvPostings';
end;//Tkw_PostingsList_Control_tvPostings.GetWordNameForRegister

procedure Tkw_PostingsList_Control_tvPostings_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('tvPostings');
 inherited;
end;//Tkw_PostingsList_Control_tvPostings_Push.DoDoIt

class function Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvPostings:push';
end;//Tkw_PostingsList_Control_tvPostings_Push.GetWordNameForRegister

function TkwEnPostingsListTvPostings.tvPostings(const aCtx: TtfwContext;
 aenPostingsList: TenPostingsList): TeeTreeView;
 {* Реализация слова скрипта .TenPostingsList.tvPostings }
begin
 Result := aenPostingsList.tvPostings;
end;//TkwEnPostingsListTvPostings.tvPostings

class function TkwEnPostingsListTvPostings.GetWordNameForRegister: AnsiString;
begin
 Result := '.TenPostingsList.tvPostings';
end;//TkwEnPostingsListTvPostings.GetWordNameForRegister

function TkwEnPostingsListTvPostings.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TeeTreeView);
end;//TkwEnPostingsListTvPostings.GetResultTypeInfo

function TkwEnPostingsListTvPostings.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPostingsListTvPostings.GetAllParamsCount

function TkwEnPostingsListTvPostings.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TenPostingsList)]);
end;//TkwEnPostingsListTvPostings.ParamsTypes

procedure TkwEnPostingsListTvPostings.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству tvPostings', aCtx);
end;//TkwEnPostingsListTvPostings.SetValuePrim

procedure TkwEnPostingsListTvPostings.DoDoIt(const aCtx: TtfwContext);
var l_aenPostingsList: TenPostingsList;
begin
 try
  l_aenPostingsList := TenPostingsList(aCtx.rEngine.PopObjAs(TenPostingsList));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aenPostingsList: TenPostingsList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(tvPostings(aCtx, l_aenPostingsList));
end;//TkwEnPostingsListTvPostings.DoDoIt

initialization
 Tkw_Form_PostingsList.RegisterInEngine;
 {* Регистрация Tkw_Form_PostingsList }
 Tkw_PostingsList_Control_tvPostings.RegisterInEngine;
 {* Регистрация Tkw_PostingsList_Control_tvPostings }
 Tkw_PostingsList_Control_tvPostings_Push.RegisterInEngine;
 {* Регистрация Tkw_PostingsList_Control_tvPostings_Push }
 TkwEnPostingsListTvPostings.RegisterInEngine;
 {* Регистрация enPostingsList_tvPostings }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TenPostingsList));
 {* Регистрация типа TenPostingsList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TeeTreeView));
 {* Регистрация типа TeeTreeView }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts)

end.
