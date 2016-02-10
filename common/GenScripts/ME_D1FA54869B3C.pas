unit ChildKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Child }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ChildKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ParentAndChildPrim_Module
 {$If Defined(Nemesis)}
 , nscFormsPageControl
 {$IfEnd} // Defined(Nemesis)
 , ElPgCtl
 , tfwControlString
 {$If NOT Defined(NoVCL)}
 , kwBynameControlPush
 {$IfEnd} // NOT Defined(NoVCL)
 , tfwScriptingInterfaces
 , tfwPropertyLike
 , tfwTypeInfo
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
;

type
 Tkw_Form_Child = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Child
----
*Пример использования*:
[code]
'aControl' форма::Child TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Child

 Tkw_Child_Control_ChildZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Child_Control_ChildZone

 Tkw_Child_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_ChildZone_Push

 Tkw_Child_Control_MainPageTab = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола MainPageTab
----
*Пример использования*:
[code]
контрол::MainPageTab TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Child_Control_MainPageTab

 Tkw_Child_Control_MainPageTab_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола MainPageTab
----
*Пример использования*:
[code]
контрол::MainPageTab:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Child_Control_MainPageTab_Push

 TkwChildFormChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.ChildZone
[panel]Контрол ChildZone формы TChildForm[panel]
*Тип результата:* TnscFormsPageControl
*Пример:*
[code]
OBJECT VAR l_TnscFormsPageControl
 aChildForm .TChildForm.ChildZone >>> l_TnscFormsPageControl
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aChildForm: TChildForm): TnscFormsPageControl;
    {* Реализация слова скрипта .TChildForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChildFormChildZone

 TkwChildFormMainPageTab = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TChildForm.MainPageTab
[panel]Контрол MainPageTab формы TChildForm[panel]
*Тип результата:* TElTabSheet
*Пример:*
[code]
OBJECT VAR l_TElTabSheet
 aChildForm .TChildForm.MainPageTab >>> l_TElTabSheet
[code]  }
  private
   function MainPageTab(const aCtx: TtfwContext;
    aChildForm: TChildForm): TElTabSheet;
    {* Реализация слова скрипта .TChildForm.MainPageTab }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwChildFormMainPageTab

class function Tkw_Form_Child.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Child';
end;//Tkw_Form_Child.GetWordNameForRegister

function Tkw_Form_Child.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AB3A39A6155F_var*
//#UC END# *4DDFD2EA0116_AB3A39A6155F_var*
begin
//#UC START# *4DDFD2EA0116_AB3A39A6155F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AB3A39A6155F_impl*
end;//Tkw_Form_Child.GetString

class function Tkw_Child_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_Child_Control_ChildZone.GetWordNameForRegister

function Tkw_Child_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_75A5E92F5203_var*
//#UC END# *4DDFD2EA0116_75A5E92F5203_var*
begin
//#UC START# *4DDFD2EA0116_75A5E92F5203_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_75A5E92F5203_impl*
end;//Tkw_Child_Control_ChildZone.GetString

class procedure Tkw_Child_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_75A5E92F5203_var*
//#UC END# *52A086150180_75A5E92F5203_var*
begin
//#UC START# *52A086150180_75A5E92F5203_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_75A5E92F5203_impl*
end;//Tkw_Child_Control_ChildZone.RegisterInEngine

procedure Tkw_Child_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2C415D2A7542_var*
//#UC END# *4DAEEDE10285_2C415D2A7542_var*
begin
//#UC START# *4DAEEDE10285_2C415D2A7542_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2C415D2A7542_impl*
end;//Tkw_Child_Control_ChildZone_Push.DoDoIt

class function Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_Child_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_Child_Control_MainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainPageTab';
end;//Tkw_Child_Control_MainPageTab.GetWordNameForRegister

function Tkw_Child_Control_MainPageTab.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0FFE16CCAC95_var*
//#UC END# *4DDFD2EA0116_0FFE16CCAC95_var*
begin
//#UC START# *4DDFD2EA0116_0FFE16CCAC95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0FFE16CCAC95_impl*
end;//Tkw_Child_Control_MainPageTab.GetString

class procedure Tkw_Child_Control_MainPageTab.RegisterInEngine;
//#UC START# *52A086150180_0FFE16CCAC95_var*
//#UC END# *52A086150180_0FFE16CCAC95_var*
begin
//#UC START# *52A086150180_0FFE16CCAC95_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_0FFE16CCAC95_impl*
end;//Tkw_Child_Control_MainPageTab.RegisterInEngine

procedure Tkw_Child_Control_MainPageTab_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A451665A611_var*
//#UC END# *4DAEEDE10285_1A451665A611_var*
begin
//#UC START# *4DAEEDE10285_1A451665A611_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A451665A611_impl*
end;//Tkw_Child_Control_MainPageTab_Push.DoDoIt

class function Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::MainPageTab:push';
end;//Tkw_Child_Control_MainPageTab_Push.GetWordNameForRegister

function TkwChildFormChildZone.ChildZone(const aCtx: TtfwContext;
 aChildForm: TChildForm): TnscFormsPageControl;
 {* Реализация слова скрипта .TChildForm.ChildZone }
//#UC START# *C5C282D0C8E1_310E6CF39C5E_var*
//#UC END# *C5C282D0C8E1_310E6CF39C5E_var*
begin
//#UC START# *C5C282D0C8E1_310E6CF39C5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5C282D0C8E1_310E6CF39C5E_impl*
end;//TkwChildFormChildZone.ChildZone

procedure TkwChildFormChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_310E6CF39C5E_var*
//#UC END# *4DAEEDE10285_310E6CF39C5E_var*
begin
//#UC START# *4DAEEDE10285_310E6CF39C5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_310E6CF39C5E_impl*
end;//TkwChildFormChildZone.DoDoIt

class function TkwChildFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.ChildZone';
end;//TkwChildFormChildZone.GetWordNameForRegister

procedure TkwChildFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_310E6CF39C5E_var*
//#UC END# *52D00B00031A_310E6CF39C5E_var*
begin
//#UC START# *52D00B00031A_310E6CF39C5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_310E6CF39C5E_impl*
end;//TkwChildFormChildZone.SetValuePrim

function TkwChildFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscFormsPageControl);
end;//TkwChildFormChildZone.GetResultTypeInfo

function TkwChildFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormChildZone.GetAllParamsCount

function TkwChildFormChildZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_310E6CF39C5E_var*
//#UC END# *5617F4D00243_310E6CF39C5E_var*
begin
//#UC START# *5617F4D00243_310E6CF39C5E_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_310E6CF39C5E_impl*
end;//TkwChildFormChildZone.ParamsTypes

function TkwChildFormMainPageTab.MainPageTab(const aCtx: TtfwContext;
 aChildForm: TChildForm): TElTabSheet;
 {* Реализация слова скрипта .TChildForm.MainPageTab }
//#UC START# *2A8075647382_B752FF576E67_var*
//#UC END# *2A8075647382_B752FF576E67_var*
begin
//#UC START# *2A8075647382_B752FF576E67_impl*
 !!! Needs to be implemented !!!
//#UC END# *2A8075647382_B752FF576E67_impl*
end;//TkwChildFormMainPageTab.MainPageTab

procedure TkwChildFormMainPageTab.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B752FF576E67_var*
//#UC END# *4DAEEDE10285_B752FF576E67_var*
begin
//#UC START# *4DAEEDE10285_B752FF576E67_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B752FF576E67_impl*
end;//TkwChildFormMainPageTab.DoDoIt

class function TkwChildFormMainPageTab.GetWordNameForRegister: AnsiString;
begin
 Result := '.TChildForm.MainPageTab';
end;//TkwChildFormMainPageTab.GetWordNameForRegister

procedure TkwChildFormMainPageTab.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_B752FF576E67_var*
//#UC END# *52D00B00031A_B752FF576E67_var*
begin
//#UC START# *52D00B00031A_B752FF576E67_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_B752FF576E67_impl*
end;//TkwChildFormMainPageTab.SetValuePrim

function TkwChildFormMainPageTab.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TElTabSheet);
end;//TkwChildFormMainPageTab.GetResultTypeInfo

function TkwChildFormMainPageTab.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwChildFormMainPageTab.GetAllParamsCount

function TkwChildFormMainPageTab.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_B752FF576E67_var*
//#UC END# *5617F4D00243_B752FF576E67_var*
begin
//#UC START# *5617F4D00243_B752FF576E67_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_B752FF576E67_impl*
end;//TkwChildFormMainPageTab.ParamsTypes

initialization
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
 TkwChildFormChildZone.RegisterInEngine;
 {* Регистрация ChildForm_ChildZone }
 TkwChildFormMainPageTab.RegisterInEngine;
 {* Регистрация ChildForm_MainPageTab }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TChildForm));
 {* Регистрация типа Child }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscFormsPageControl));
 {* Регистрация типа TnscFormsPageControl }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TElTabSheet));
 {* Регистрация типа TElTabSheet }
{$IfEnd} // NOT Defined(NoScripts)

end.
