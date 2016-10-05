unit ChildKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Child }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\Forms\ChildKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ChildKeywordsPack" MUID: (4F6B66DB0384_Pack)

{$Include w:\common\components\gui\f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoScripts) AND NOT Defined(NoVCL)}
uses
 l3ImplUses
 , Child_Form
 , tfwPropertyLike
 {$If Defined(Nemesis)}
 , nscFormsPageControl
 {$IfEnd} // Defined(Nemesis)
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , ElPgCtl
 , tfwControlString
 , kwBynameControlPush
 , TtfwClassRef_Proxy
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *4F6B66DB0384_Packimpl_uses*
 //#UC END# *4F6B66DB0384_Packimpl_uses*
;

type
 TkwChildFormChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.ChildZone }
  private
   function ChildZone(const aCtx: TtfwContext;
    aChildForm: TChildForm): TnscFormsPageControl;
    {* Реализация слова скрипта .TChildForm.ChildZone }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChildFormChildZone

 TkwChildFormMainPageTab = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.MainPageTab }
  private
   function MainPageTab(const aCtx: TtfwContext;
    aChildForm: TChildForm): TElTabSheet;
    {* Реализация слова скрипта .TChildForm.MainPageTab }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwChildFormMainPageTab

 Tkw_Form_Child = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Child
----
*Пример использования*:
[code]форма::Child TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Form_Child

 Tkw_Child_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]контрол::ChildZone TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_ChildZone

 Tkw_Child_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]контрол::ChildZone:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_ChildZone_Push

 Tkw_Child_Control_MainPageTab = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainPageTab
----
*Пример использования*:
[code]контрол::MainPageTab TryFocus ASSERT[code] }
  protected
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_MainPageTab

 Tkw_Child_Control_MainPageTab_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainPageTab
----
*Пример использования*:
[code]контрол::MainPageTab:push pop:control:SetFocus ASSERT[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_MainPageTab_Push

function TkwChildFormChildZone.ChildZone(const aCtx: TtfwContext;
 aChildForm: TChildForm): TnscFormsPageControl;
 {* Реализация слова скрипта .TChildForm.ChildZone }
begin
 Result := aChildForm.ChildZone;
end;//TkwChildFormChildZone.ChildZone

class function TkwChildFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.ChildZone';
end;//TkwChildFormChildZone.GetWordNameForRegister

function TkwChildFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFormsPageControl);
end;//TkwChildFormChildZone.GetResultTypeInfo

function TkwChildFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormChildZone.GetAllParamsCount

function TkwChildFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormChildZone.ParamsTypes

procedure TkwChildFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ChildZone', aCtx);
end;//TkwChildFormChildZone.SetValuePrim

procedure TkwChildFormChildZone.DoDoIt(const aCtx: TtfwContext);
var l_aChildForm: TChildForm;
begin
 try
  l_aChildForm := TChildForm(aCtx.rEngine.PopObjAs(TChildForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChildForm: TChildForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ChildZone(aCtx, l_aChildForm));
end;//TkwChildFormChildZone.DoDoIt

function TkwChildFormMainPageTab.MainPageTab(const aCtx: TtfwContext;
 aChildForm: TChildForm): TElTabSheet;
 {* Реализация слова скрипта .TChildForm.MainPageTab }
begin
 Result := aChildForm.MainPageTab;
end;//TkwChildFormMainPageTab.MainPageTab

class function TkwChildFormMainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.MainPageTab';
end;//TkwChildFormMainPageTab.GetWordNameForRegister

function TkwChildFormMainPageTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElTabSheet);
end;//TkwChildFormMainPageTab.GetResultTypeInfo

function TkwChildFormMainPageTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormMainPageTab.GetAllParamsCount

function TkwChildFormMainPageTab.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TChildForm)]);
end;//TkwChildFormMainPageTab.ParamsTypes

procedure TkwChildFormMainPageTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству MainPageTab', aCtx);
end;//TkwChildFormMainPageTab.SetValuePrim

procedure TkwChildFormMainPageTab.DoDoIt(const aCtx: TtfwContext);
var l_aChildForm: TChildForm;
begin
 try
  l_aChildForm := TChildForm(aCtx.rEngine.PopObjAs(TChildForm));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aChildForm: TChildForm : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(MainPageTab(aCtx, l_aChildForm));
end;//TkwChildFormMainPageTab.DoDoIt

function Tkw_Form_Child.GetString: AnsiString;
begin
 Result := 'ChildForm';
end;//Tkw_Form_Child.GetString

class procedure Tkw_Form_Child.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TChildForm);
end;//Tkw_Form_Child.RegisterInEngine

class function Tkw_Form_Child.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Child';
end;//Tkw_Form_Child.GetWordNameForRegister

function Tkw_Child_Control_ChildZone.GetString: AnsiString;
begin
 Result := 'ChildZone';
end;//Tkw_Child_Control_ChildZone.GetString

class procedure Tkw_Child_Control_ChildZone.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TnscFormsPageControl);
end;//Tkw_Child_Control_ChildZone.RegisterInEngine

class function Tkw_Child_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_Child_Control_ChildZone.GetWordNameForRegister

procedure Tkw_Child_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('ChildZone');
 inherited;
end;//Tkw_Child_Control_ChildZone_Push.DoDoIt

class function Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister

function Tkw_Child_Control_MainPageTab.GetString: AnsiString;
begin
 Result := 'MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetString

class procedure Tkw_Child_Control_MainPageTab.RegisterInEngine;
begin
 inherited;
 TtfwClassRef.Register(TElTabSheet);
end;//Tkw_Child_Control_MainPageTab.RegisterInEngine

class function Tkw_Child_Control_MainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetWordNameForRegister

procedure Tkw_Child_Control_MainPageTab_Push.DoDoIt(const aCtx: TtfwContext);
begin
 aCtx.rEngine.PushString('MainPageTab');
 inherited;
end;//Tkw_Child_Control_MainPageTab_Push.DoDoIt

class function Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainPageTab:push';
end;//Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister

initialization
 TkwChildFormChildZone.RegisterInEngine;
 {* Регистрация ChildForm_ChildZone }
 TkwChildFormMainPageTab.RegisterInEngine;
 {* Регистрация ChildForm_MainPageTab }
 Tkw_Form_Child.RegisterInEngine;
 {* Регистрация Tkw_Form_Child }
 Tkw_Child_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_Child_Control_ChildZone }
 Tkw_Child_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Child_Control_ChildZone_Push }
 Tkw_Child_Control_MainPageTab.RegisterInEngine;
 {* Регистрация Tkw_Child_Control_MainPageTab }
 Tkw_Child_Control_MainPageTab_Push.RegisterInEngine;
 {* Регистрация Tkw_Child_Control_MainPageTab_Push }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChildForm));
 {* Регистрация типа TChildForm }
{$If Defined(Nemesis)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFormsPageControl));
 {* Регистрация типа TnscFormsPageControl }
{$IfEnd} // Defined(Nemesis)
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
 {* Регистрация типа TElTabSheet }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
