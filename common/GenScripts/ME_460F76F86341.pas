unit AdminFormKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы AdminForm }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Admin\AdminFormKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Admin_Module
 , vtProportionalPanel
 , vtSizeablePanel
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
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

implementation

{$If Defined(Admin) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , TtfwClassRef_Proxy
 , SysUtils
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_AdminForm

 Tkw_AdminForm_Control_BackgroundPanel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола BackgroundPanel
----
*Пример использования*:
[code]
контрол::BackgroundPanel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminForm_Control_BackgroundPanel

 Tkw_AdminForm_Control_BackgroundPanel_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminForm_Control_PropertyZone

 Tkw_AdminForm_Control_PropertyZone_Push = {final} class(TkwBynameControlPush)
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
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_AdminForm_Control_TreeZone

 Tkw_AdminForm_Control_TreeZone_Push = {final} class(TkwBynameControlPush)
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
  {* Слово скрипта .TcfAdminForm.BackgroundPanel
[panel]Контрол BackgroundPanel формы TcfAdminForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 acfAdminForm .TcfAdminForm.BackgroundPanel >>> l_TvtProportionalPanel
[code]  }
  private
   function BackgroundPanel(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TcfAdminForm.BackgroundPanel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAdminFormBackgroundPanel

 TkwCfAdminFormPropertyZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAdminForm.PropertyZone
[panel]Контрол PropertyZone формы TcfAdminForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 acfAdminForm .TcfAdminForm.PropertyZone >>> l_TvtSizeablePanel
[code]  }
  private
   function PropertyZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TcfAdminForm.PropertyZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAdminFormPropertyZone

 TkwCfAdminFormTreeZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TcfAdminForm.TreeZone
[panel]Контрол TreeZone формы TcfAdminForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 acfAdminForm .TcfAdminForm.TreeZone >>> l_TvtPanel
[code]  }
  private
   function TreeZone(const aCtx: TtfwContext;
    acfAdminForm: TcfAdminForm): TvtPanel;
    {* Реализация слова скрипта .TcfAdminForm.TreeZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCfAdminFormTreeZone

class function Tkw_Form_AdminForm.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::AdminForm';
end;//Tkw_Form_AdminForm.GetWordNameForRegister

function Tkw_Form_AdminForm.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_F4A92FC5FEBA_var*
//#UC END# *4DDFD2EA0116_F4A92FC5FEBA_var*
begin
//#UC START# *4DDFD2EA0116_F4A92FC5FEBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_F4A92FC5FEBA_impl*
end;//Tkw_Form_AdminForm.GetString

class function Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel';
end;//Tkw_AdminForm_Control_BackgroundPanel.GetWordNameForRegister

function Tkw_AdminForm_Control_BackgroundPanel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_89693E060DE9_var*
//#UC END# *4DDFD2EA0116_89693E060DE9_var*
begin
//#UC START# *4DDFD2EA0116_89693E060DE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_89693E060DE9_impl*
end;//Tkw_AdminForm_Control_BackgroundPanel.GetString

class procedure Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine;
//#UC START# *52A086150180_89693E060DE9_var*
//#UC END# *52A086150180_89693E060DE9_var*
begin
//#UC START# *52A086150180_89693E060DE9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_89693E060DE9_impl*
end;//Tkw_AdminForm_Control_BackgroundPanel.RegisterInEngine

procedure Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_94E74DE6B54B_var*
//#UC END# *4DAEEDE10285_94E74DE6B54B_var*
begin
//#UC START# *4DAEEDE10285_94E74DE6B54B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_94E74DE6B54B_impl*
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.DoDoIt

class function Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::BackgroundPanel:push';
end;//Tkw_AdminForm_Control_BackgroundPanel_Push.GetWordNameForRegister

class function Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PropertyZone';
end;//Tkw_AdminForm_Control_PropertyZone.GetWordNameForRegister

function Tkw_AdminForm_Control_PropertyZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_71F3EE1BBFD3_var*
//#UC END# *4DDFD2EA0116_71F3EE1BBFD3_var*
begin
//#UC START# *4DDFD2EA0116_71F3EE1BBFD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_71F3EE1BBFD3_impl*
end;//Tkw_AdminForm_Control_PropertyZone.GetString

class procedure Tkw_AdminForm_Control_PropertyZone.RegisterInEngine;
//#UC START# *52A086150180_71F3EE1BBFD3_var*
//#UC END# *52A086150180_71F3EE1BBFD3_var*
begin
//#UC START# *52A086150180_71F3EE1BBFD3_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_71F3EE1BBFD3_impl*
end;//Tkw_AdminForm_Control_PropertyZone.RegisterInEngine

procedure Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7BA2C418A8AC_var*
//#UC END# *4DAEEDE10285_7BA2C418A8AC_var*
begin
//#UC START# *4DAEEDE10285_7BA2C418A8AC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7BA2C418A8AC_impl*
end;//Tkw_AdminForm_Control_PropertyZone_Push.DoDoIt

class function Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::PropertyZone:push';
end;//Tkw_AdminForm_Control_PropertyZone_Push.GetWordNameForRegister

class function Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TreeZone';
end;//Tkw_AdminForm_Control_TreeZone.GetWordNameForRegister

function Tkw_AdminForm_Control_TreeZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6E390D96FE2B_var*
//#UC END# *4DDFD2EA0116_6E390D96FE2B_var*
begin
//#UC START# *4DDFD2EA0116_6E390D96FE2B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6E390D96FE2B_impl*
end;//Tkw_AdminForm_Control_TreeZone.GetString

class procedure Tkw_AdminForm_Control_TreeZone.RegisterInEngine;
//#UC START# *52A086150180_6E390D96FE2B_var*
//#UC END# *52A086150180_6E390D96FE2B_var*
begin
//#UC START# *52A086150180_6E390D96FE2B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_6E390D96FE2B_impl*
end;//Tkw_AdminForm_Control_TreeZone.RegisterInEngine

procedure Tkw_AdminForm_Control_TreeZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D9E0DEB3CCF0_var*
//#UC END# *4DAEEDE10285_D9E0DEB3CCF0_var*
begin
//#UC START# *4DAEEDE10285_D9E0DEB3CCF0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D9E0DEB3CCF0_impl*
end;//Tkw_AdminForm_Control_TreeZone_Push.DoDoIt

class function Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::TreeZone:push';
end;//Tkw_AdminForm_Control_TreeZone_Push.GetWordNameForRegister

function TkwCfAdminFormBackgroundPanel.BackgroundPanel(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TcfAdminForm.BackgroundPanel }
//#UC START# *0F1520A3D8B8_C4515223E983_var*
//#UC END# *0F1520A3D8B8_C4515223E983_var*
begin
//#UC START# *0F1520A3D8B8_C4515223E983_impl*
 !!! Needs to be implemented !!!
//#UC END# *0F1520A3D8B8_C4515223E983_impl*
end;//TkwCfAdminFormBackgroundPanel.BackgroundPanel

procedure TkwCfAdminFormBackgroundPanel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C4515223E983_var*
//#UC END# *4DAEEDE10285_C4515223E983_var*
begin
//#UC START# *4DAEEDE10285_C4515223E983_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C4515223E983_impl*
end;//TkwCfAdminFormBackgroundPanel.DoDoIt

class function TkwCfAdminFormBackgroundPanel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.BackgroundPanel';
end;//TkwCfAdminFormBackgroundPanel.GetWordNameForRegister

procedure TkwCfAdminFormBackgroundPanel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_C4515223E983_var*
//#UC END# *52D00B00031A_C4515223E983_var*
begin
//#UC START# *52D00B00031A_C4515223E983_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_C4515223E983_impl*
end;//TkwCfAdminFormBackgroundPanel.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfAdminFormBackgroundPanel.ParamsTypes

function TkwCfAdminFormPropertyZone.PropertyZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TcfAdminForm.PropertyZone }
//#UC START# *C3D524687333_AFA25E6606C9_var*
//#UC END# *C3D524687333_AFA25E6606C9_var*
begin
//#UC START# *C3D524687333_AFA25E6606C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *C3D524687333_AFA25E6606C9_impl*
end;//TkwCfAdminFormPropertyZone.PropertyZone

procedure TkwCfAdminFormPropertyZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_AFA25E6606C9_var*
//#UC END# *4DAEEDE10285_AFA25E6606C9_var*
begin
//#UC START# *4DAEEDE10285_AFA25E6606C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_AFA25E6606C9_impl*
end;//TkwCfAdminFormPropertyZone.DoDoIt

class function TkwCfAdminFormPropertyZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.PropertyZone';
end;//TkwCfAdminFormPropertyZone.GetWordNameForRegister

procedure TkwCfAdminFormPropertyZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_AFA25E6606C9_var*
//#UC END# *52D00B00031A_AFA25E6606C9_var*
begin
//#UC START# *52D00B00031A_AFA25E6606C9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_AFA25E6606C9_impl*
end;//TkwCfAdminFormPropertyZone.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfAdminFormPropertyZone.ParamsTypes

function TkwCfAdminFormTreeZone.TreeZone(const aCtx: TtfwContext;
 acfAdminForm: TcfAdminForm): TvtPanel;
 {* Реализация слова скрипта .TcfAdminForm.TreeZone }
//#UC START# *7F4CA87D95FF_CE662E9AFEBF_var*
//#UC END# *7F4CA87D95FF_CE662E9AFEBF_var*
begin
//#UC START# *7F4CA87D95FF_CE662E9AFEBF_impl*
 !!! Needs to be implemented !!!
//#UC END# *7F4CA87D95FF_CE662E9AFEBF_impl*
end;//TkwCfAdminFormTreeZone.TreeZone

procedure TkwCfAdminFormTreeZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_CE662E9AFEBF_var*
//#UC END# *4DAEEDE10285_CE662E9AFEBF_var*
begin
//#UC START# *4DAEEDE10285_CE662E9AFEBF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_CE662E9AFEBF_impl*
end;//TkwCfAdminFormTreeZone.DoDoIt

class function TkwCfAdminFormTreeZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TcfAdminForm.TreeZone';
end;//TkwCfAdminFormTreeZone.GetWordNameForRegister

procedure TkwCfAdminFormTreeZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_CE662E9AFEBF_var*
//#UC END# *52D00B00031A_CE662E9AFEBF_var*
begin
//#UC START# *52D00B00031A_CE662E9AFEBF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_CE662E9AFEBF_impl*
end;//TkwCfAdminFormTreeZone.SetValuePrim

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
 Result := OpenTypesToTypes([]);
end;//TkwCfAdminFormTreeZone.ParamsTypes

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
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TcfAdminForm));
 {* Регистрация типа AdminForm }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // Defined(Admin) AND NOT Defined(NoScripts)

end.
