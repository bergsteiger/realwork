unit SynchroViewKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы SynchroView }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\SynchroViewKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , vtPanel
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
 Tkw_Form_SynchroView = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы SynchroView
----
*Пример использования*:
[code]
'aControl' форма::SynchroView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_SynchroView

 Tkw_SynchroView_Control_DocView = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола DocView
----
*Пример использования*:
[code]
контрол::DocView TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_SynchroView_Control_DocView

 Tkw_SynchroView_Control_DocView_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола DocView
----
*Пример использования*:
[code]
контрол::DocView:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_SynchroView_Control_DocView_Push

 TkwFcSynchroViewDocView = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TfcSynchroView.DocView
[panel]Контрол DocView формы TfcSynchroView[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 afcSynchroView .TfcSynchroView.DocView >>> l_TvtPanel
[code]  }
  private
   function DocView(const aCtx: TtfwContext;
    afcSynchroView: TfcSynchroView): TvtPanel;
    {* Реализация слова скрипта .TfcSynchroView.DocView }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFcSynchroViewDocView

class function Tkw_Form_SynchroView.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::SynchroView';
end;//Tkw_Form_SynchroView.GetWordNameForRegister

function Tkw_Form_SynchroView.GetString: AnsiString;
begin
 Result := 'fcSynchroView';
end;//Tkw_Form_SynchroView.GetString

class function Tkw_SynchroView_Control_DocView.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DocView';
end;//Tkw_SynchroView_Control_DocView.GetWordNameForRegister

function Tkw_SynchroView_Control_DocView.GetString: AnsiString;
begin
 Result := 'DocView';
end;//Tkw_SynchroView_Control_DocView.GetString

class procedure Tkw_SynchroView_Control_DocView.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_SynchroView_Control_DocView.RegisterInEngine

procedure Tkw_SynchroView_Control_DocView_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AAC0F3937C1E_var*
//#UC END# *4DAEEDE10285_AAC0F3937C1E_var*
begin
//#UC START# *4DAEEDE10285_AAC0F3937C1E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AAC0F3937C1E_impl*
end;//Tkw_SynchroView_Control_DocView_Push.DoDoIt

class function Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::DocView:push';
end;//Tkw_SynchroView_Control_DocView_Push.GetWordNameForRegister

function TkwFcSynchroViewDocView.DocView(const aCtx: TtfwContext;
 afcSynchroView: TfcSynchroView): TvtPanel;
 {* Реализация слова скрипта .TfcSynchroView.DocView }
begin
 Result := afcSynchroView.DocView;
end;//TkwFcSynchroViewDocView.DocView

procedure TkwFcSynchroViewDocView.DoDoIt(const aCtx: TtfwContext);
var l_afcSynchroView: TfcSynchroView;
begin
 try
  l_afcSynchroView := TfcSynchroView(aCtx.rEngine.PopObjAs(TfcSynchroView));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра afcSynchroView: TfcSynchroView : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(DocView(aCtx, l_afcSynchroView));
end;//TkwFcSynchroViewDocView.DoDoIt

class function TkwFcSynchroViewDocView.GetWordNameForRegister: AnsiString;
begin
 Result := '.TfcSynchroView.DocView';
end;//TkwFcSynchroViewDocView.GetWordNameForRegister

procedure TkwFcSynchroViewDocView.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству DocView', aCtx);
end;//TkwFcSynchroViewDocView.SetValuePrim

function TkwFcSynchroViewDocView.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwFcSynchroViewDocView.GetResultTypeInfo

function TkwFcSynchroViewDocView.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFcSynchroViewDocView.GetAllParamsCount

function TkwFcSynchroViewDocView.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TfcSynchroView)]);
end;//TkwFcSynchroViewDocView.ParamsTypes

initialization
 Tkw_Form_SynchroView.RegisterInEngine;
 {* Регистрация Tkw_Form_SynchroView }
 Tkw_SynchroView_Control_DocView.RegisterInEngine;
 {* Регистрация Tkw_SynchroView_Control_DocView }
 Tkw_SynchroView_Control_DocView_Push.RegisterInEngine;
 {* Регистрация Tkw_SynchroView_Control_DocView_Push }
 TkwFcSynchroViewDocView.RegisterInEngine;
 {* Регистрация fcSynchroView_DocView }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TfcSynchroView));
 {* Регистрация типа SynchroView }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
