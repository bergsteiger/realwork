unit AdminFormKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AdminForm }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\AdminFormKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "AdminFormKeywordsPack" MUID: (460F76F86341)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
;
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , Admin_Form
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
 Tkw_Form_AdminForm = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы AdminForm
----
*Пример использования*:
[code]
'aControl' форма::AdminForm TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_AdminForm

 Tkw_AdminForm_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_BackgroundPanel

 Tkw_AdminForm_Control_BackgroundPanel_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_BackgroundPanel_Push

 Tkw_AdminForm_Control_PropertyZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PropertyZone
----
*Пример использования*:
[code]
контрол::PropertyZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_PropertyZone

 Tkw_AdminForm_Control_PropertyZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола PropertyZone
----
*Пример использования*:
[code]
контрол::PropertyZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_PropertyZone_Push

 Tkw_AdminForm_Control_TreeZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола TreeZone
----
*Пример использования*:
[code]
контрол::TreeZone TryFocus ASSERT
[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_TreeZone

 Tkw_AdminForm_Control_TreeZone_Push = {final} class({$If NOT Defined(NoVCL)}
 TkwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 )
  {* Слово словаря для контрола TreeZone
----
*Пример использования*:
[code]
контрол::TreeZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_AdminForm_Control_TreeZone_Push

 TkwCfAdminFormBackgroundPanel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAdminForm.BackgroundPanel }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfAdminForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormBackgroundPanel

 TkwCfAdminFormPropertyZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAdminForm.PropertyZone }
  private
   function PropertyZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfAdminForm.PropertyZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormPropertyZone

 TkwCfAdminFormTreeZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAdminForm.TreeZone }
  private
   function TreeZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtPanel;
    {* Реализация слова скрипта .TcfAdminForm.TreeZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwCfAdminFormTreeZone

function Tkw_Form_AdminForm.GetString: AnsiString;
begin
 Result := 'cfAdminForm';
end;//Tkw_Form_AdminForm.GetString

class function Tkw_Form_AdminForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AdminForm';
end;//Tkw_Form_AdminForm.GetWordNameForRegister

function Tkw_AdminForm_Control_BackgroundPanel.GetString: AnsiString;
begin
 Result := 'BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetString

class procedure Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtProportionalPanel);
end;//Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine

class function Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister

procedure Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('BackgroundPanel');
 inherited;
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister

function Tkw_AdminForm_Control_PropertyZone.GetString: AnsiString;
begin
 Result := 'PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetString

class procedure Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtSizeablePanel);
end;//Tkw_AdminForm_Control_PropertyZone.RegisterInEngine

class function Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister

procedure Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PropertyZone');
 inherited;
end;//Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt

class function Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PropertyZone:push';
end;//Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister

function Tkw_AdminForm_Control_TreeZone.GetString: AnsiString;
begin
 Result := 'TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetString

class procedure Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtPanel);
end;//Tkw_AdminForm_Control_TreeZone.RegisterInEngine

class function Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister

procedure Tkw_AdminForm_Control_TreeZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('TreeZone');
 inherited;
end;//Tkw_AdminForm_Control_TreeZone_Push.DoDoIt

class function Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TreeZone:push';
end;//Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister

function TkwCfAdminFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfAdminForm.BackgroundPanel }
begin
 Result := acfAdminForm.BackgroundPanel;
end;//TkwCfAdminFormBackgroundPanel.BackgroundPanel

procedure TkwCfAdminFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(BackgroundPanel(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormBackgroundPanel.DoDoIt

class function TkwCfAdminFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.BackgroundPanel';
end;//TkwCfAdminFormBackgroundPanel.GetWordNameForRegister

function TkwCfAdminFormBackgroundPanel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwCfAdminFormBackgroundPanel.GetResultTypeInfo

function TkwCfAdminFormBackgroundPanel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormBackgroundPanel.GetAllParamsCount

function TkwCfAdminFormBackgroundPanel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormBackgroundPanel.ParamsTypes

procedure TkwCfAdminFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству BackgroundPanel', aCtx);
end;//TkwCfAdminFormBackgroundPanel.SetValuePrim

function TkwCfAdminFormPropertyZone.PropertyZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfAdminForm.PropertyZone }
begin
 Result := acfAdminForm.PropertyZone;
end;//TkwCfAdminFormPropertyZone.PropertyZone

procedure TkwCfAdminFormPropertyZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PropertyZone(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormPropertyZone.DoDoIt

class function TkwCfAdminFormPropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.PropertyZone';
end;//TkwCfAdminFormPropertyZone.GetWordNameForRegister

function TkwCfAdminFormPropertyZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwCfAdminFormPropertyZone.GetResultTypeInfo

function TkwCfAdminFormPropertyZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormPropertyZone.GetAllParamsCount

function TkwCfAdminFormPropertyZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormPropertyZone.ParamsTypes

procedure TkwCfAdminFormPropertyZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PropertyZone', aCtx);
end;//TkwCfAdminFormPropertyZone.SetValuePrim

function TkwCfAdminFormTreeZone.TreeZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtPanel;
 {* Реализация слова скрипта .TcfAdminForm.TreeZone }
begin
 Result := acfAdminForm.TreeZone;
end;//TkwCfAdminFormTreeZone.TreeZone

procedure TkwCfAdminFormTreeZone.DoDoIt(const aCtx: TtfwContext);
var l_acfAdminForm: TcfAdminForm;
begin
 try
  l_acfAdminForm := TcfAdminForm(aCtx.rEngine.PopObjAs(TcfAdminForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра acfAdminForm: TcfAdminForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(TreeZone(aCtx, l_acfAdminForm));
end;//TkwCfAdminFormTreeZone.DoDoIt

class function TkwCfAdminFormTreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.TreeZone';
end;//TkwCfAdminFormTreeZone.GetWordNameForRegister

function TkwCfAdminFormTreeZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwCfAdminFormTreeZone.GetResultTypeInfo

function TkwCfAdminFormTreeZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCfAdminFormTreeZone.GetAllParamsCount

function TkwCfAdminFormTreeZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TcfAdminForm)]);
end;//TkwCfAdminFormTreeZone.ParamsTypes

procedure TkwCfAdminFormTreeZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству TreeZone', aCtx);
end;//TkwCfAdminFormTreeZone.SetValuePrim

initialization
 Tkw_Form_AdminForm.RegisterInEngine;
 {* Регистрация Tkw_Form_AdminForm }
 Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_BackgroundPanel }
 Tkw_AdminForm_Control_BackgroundPanel_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_BackgroundPanel_Push }
 Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_PropertyZone }
 Tkw_AdminForm_Control_PropertyZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_PropertyZone_Push }
 Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_TreeZone }
 Tkw_AdminForm_Control_TreeZone_Push.RegisterInEngine;
 {* Регистрация Tkw_AdminForm_Control_TreeZone_Push }
 TkwCfAdminFormBackgroundPanel.RegisterInEngine;
 {* Регистрация cfAdminForm_BackgroundPanel }
 TkwCfAdminFormPropertyZone.RegisterInEngine;
 {* Регистрация cfAdminForm_PropertyZone }
 TkwCfAdminFormTreeZone.RegisterInEngine;
 {* Регистрация cfAdminForm_TreeZone }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAdminForm));
 {* Регистрация типа TcfAdminForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
