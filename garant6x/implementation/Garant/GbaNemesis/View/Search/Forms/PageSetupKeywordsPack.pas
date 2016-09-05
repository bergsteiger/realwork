unit PageSetupKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы PageSetup }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Search\Forms\PageSetupKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "PageSetupKeywordsPack" MUID: (4AAF86650309_Pack)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , PageSetup_Form
 , tfwPropertyLike
 , vtGroupBox
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 {$If Defined(Nemesis)}
 , nscPageControl
 {$IfEnd} // Defined(Nemesis)
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4AAF86650309_Packimpl_uses*
 //#UC END# *4AAF86650309_Packimpl_uses*
;

type
 TkwEnPageSetupPreviewGroupBox = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_PageSetup.PreviewGroupBox }
  private
   function PreviewGroupBox(const aCtx: TtfwContext;
    aen_PageSetup: Ten_PageSetup): TvtGroupBox;
    {* Реализация слова скрипта .Ten_PageSetup.PreviewGroupBox }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnPageSetupPreviewGroupBox

 TkwEnPageSetupSettingsPageControl = {final} class(TtfwPropertyLike)
  {* Слово скрипта .Ten_PageSetup.SettingsPageControl }
  private
   function SettingsPageControl(const aCtx: TtfwContext;
    aen_PageSetup: Ten_PageSetup): TnscPageControl;
    {* Реализация слова скрипта .Ten_PageSetup.SettingsPageControl }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwEnPageSetupSettingsPageControl

 Tkw_Form_PageSetup = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы PageSetup
----
*Пример использования*:
[code]форма::PageSetup TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_PageSetup

 Tkw_PageSetup_Control_PreviewGroupBox = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола PreviewGroupBox
----
*Пример использования*:
[code]контрол::PreviewGroupBox TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_PreviewGroupBox

 Tkw_PageSetup_Control_PreviewGroupBox_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола PreviewGroupBox
----
*Пример использования*:
[code]контрол::PreviewGroupBox:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_PreviewGroupBox_Push

 Tkw_PageSetup_Control_SettingsPageControl = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола SettingsPageControl
----
*Пример использования*:
[code]контрол::SettingsPageControl TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_SettingsPageControl

 Tkw_PageSetup_Control_SettingsPageControl_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола SettingsPageControl
----
*Пример использования*:
[code]контрол::SettingsPageControl:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_PageSetup_Control_SettingsPageControl_Push

function TkwEnPageSetupPreviewGroupBox.PreviewGroupBox(const aCtx: TtfwContext;
 aen_PageSetup: Ten_PageSetup): TvtGroupBox;
 {* Реализация слова скрипта .Ten_PageSetup.PreviewGroupBox }
begin
 Result := aen_PageSetup.PreviewGroupBox;
end;//TkwEnPageSetupPreviewGroupBox.PreviewGroupBox

class function TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PageSetup.PreviewGroupBox';
end;//TkwEnPageSetupPreviewGroupBox.GetWordNameForRegister

function TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtGroupBox);
end;//TkwEnPageSetupPreviewGroupBox.GetResultTypeInfo

function TkwEnPageSetupPreviewGroupBox.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPageSetupPreviewGroupBox.GetAllParamsCount

function TkwEnPageSetupPreviewGroupBox.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupPreviewGroupBox.ParamsTypes

procedure TkwEnPageSetupPreviewGroupBox.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству PreviewGroupBox', aCtx);
end;//TkwEnPageSetupPreviewGroupBox.SetValuePrim

procedure TkwEnPageSetupPreviewGroupBox.DoDoIt(const aCtx: TtfwContext);
var l_aen_PageSetup: Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(PreviewGroupBox(aCtx, l_aen_PageSetup));
end;//TkwEnPageSetupPreviewGroupBox.DoDoIt

function TkwEnPageSetupSettingsPageControl.SettingsPageControl(const aCtx: TtfwContext;
 aen_PageSetup: Ten_PageSetup): TnscPageControl;
 {* Реализация слова скрипта .Ten_PageSetup.SettingsPageControl }
begin
 Result := aen_PageSetup.SettingsPageControl;
end;//TkwEnPageSetupSettingsPageControl.SettingsPageControl

class function TkwEnPageSetupSettingsPageControl.GetWordNameForRegister: AnsiString;
begin
 Result := '.Ten_PageSetup.SettingsPageControl';
end;//TkwEnPageSetupSettingsPageControl.GetWordNameForRegister

function TkwEnPageSetupSettingsPageControl.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscPageControl);
end;//TkwEnPageSetupSettingsPageControl.GetResultTypeInfo

function TkwEnPageSetupSettingsPageControl.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEnPageSetupSettingsPageControl.GetAllParamsCount

function TkwEnPageSetupSettingsPageControl.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Ten_PageSetup)]);
end;//TkwEnPageSetupSettingsPageControl.ParamsTypes

procedure TkwEnPageSetupSettingsPageControl.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству SettingsPageControl', aCtx);
end;//TkwEnPageSetupSettingsPageControl.SetValuePrim

procedure TkwEnPageSetupSettingsPageControl.DoDoIt(const aCtx: TtfwContext);
var l_aen_PageSetup: Ten_PageSetup;
begin
 try
  l_aen_PageSetup := Ten_PageSetup(aCtx.rEngine.PopObjAs(Ten_PageSetup));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aen_PageSetup: Ten_PageSetup : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(SettingsPageControl(aCtx, l_aen_PageSetup));
end;//TkwEnPageSetupSettingsPageControl.DoDoIt

function Tkw_Form_PageSetup.GetString: AnsiString;
begin
 Result := 'en_PageSetup';
end;//Tkw_Form_PageSetup.GetString

class procedure Tkw_Form_PageSetup.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(Ten_PageSetup);
end;//Tkw_Form_PageSetup.RegisterInEngine

class function Tkw_Form_PageSetup.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::PageSetup';
end;//Tkw_Form_PageSetup.GetWordNameForRegister

function Tkw_PageSetup_Control_PreviewGroupBox.GetString: AnsiString;
begin
 Result := 'PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetString

class procedure Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TvtGroupBox);
end;//Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine

class function Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PreviewGroupBox';
end;//Tkw_PageSetup_Control_PreviewGroupBox.GetWordNameForRegister

procedure Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('PreviewGroupBox');
 inherited;
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.DoDoIt

class function Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PreviewGroupBox:push';
end;//Tkw_PageSetup_Control_PreviewGroupBox_Push.GetWordNameForRegister

function Tkw_PageSetup_Control_SettingsPageControl.GetString: AnsiString;
begin
 Result := 'SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetString

class procedure Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscPageControl);
end;//Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine

class function Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SettingsPageControl';
end;//Tkw_PageSetup_Control_SettingsPageControl.GetWordNameForRegister

procedure Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('SettingsPageControl');
 inherited;
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.DoDoIt

class function Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::SettingsPageControl:push';
end;//Tkw_PageSetup_Control_SettingsPageControl_Push.GetWordNameForRegister

initialization
 TkwEnPageSetupPreviewGroupBox.RegisterInEngine;
 {* Регистрация en_PageSetup_PreviewGroupBox }
 TkwEnPageSetupSettingsPageControl.RegisterInEngine;
 {* Регистрация en_PageSetup_SettingsPageControl }
 Tkw_Form_PageSetup.RegisterInEngine;
 {* Регистрация Tkw_Form_PageSetup }
 Tkw_PageSetup_Control_PreviewGroupBox.RegisterInEngine;
 {* Регистрация Tkw_PageSetup_Control_PreviewGroupBox }
 Tkw_PageSetup_Control_PreviewGroupBox_Push.RegisterInEngine;
 {* Регистрация Tkw_PageSetup_Control_PreviewGroupBox_Push }
 Tkw_PageSetup_Control_SettingsPageControl.RegisterInEngine;
 {* Регистрация Tkw_PageSetup_Control_SettingsPageControl }
 Tkw_PageSetup_Control_SettingsPageControl_Push.RegisterInEngine;
 {* Регистрация Tkw_PageSetup_Control_SettingsPageControl_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Ten_PageSetup));
 {* Регистрация типа Ten_PageSetup }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtGroupBox));
 {* Регистрация типа TvtGroupBox }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscPageControl));
 {* Регистрация типа TnscPageControl }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
