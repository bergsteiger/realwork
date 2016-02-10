unit DictionContainerKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы DictionContainer }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Diction\DictionContainerKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Diction_Module
 , vtProportionalPanel
 , vtSizeablePanel
 , vtPanel
 , vtLabel
 {$If NOT Defined(NoVCL)}
 , ExtCtrls
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
 Tkw_Form_DictionContainer = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы DictionContainer
----
*Пример использования*:
[code]
'aControl' форма::DictionContainer TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_DictionContainer

 Tkw_DictionContainer_Control_pnBackground = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnBackground
----
*Пример использования*:
[code]
контрол::pnBackground TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnBackground

 Tkw_DictionContainer_Control_pnBackground_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnBackground
----
*Пример использования*:
[code]
контрол::pnBackground:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnBackground_Push

 Tkw_DictionContainer_Control_NavigatorZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone

 Tkw_DictionContainer_Control_NavigatorZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NavigatorZone
----
*Пример использования*:
[code]
контрол::NavigatorZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_NavigatorZone_Push

 Tkw_DictionContainer_Control_pnWorkArea = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnWorkArea
----
*Пример использования*:
[code]
контрол::pnWorkArea TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea

 Tkw_DictionContainer_Control_pnWorkArea_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnWorkArea
----
*Пример использования*:
[code]
контрол::pnWorkArea:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnWorkArea_Push

 Tkw_DictionContainer_Control_ChildZone = {final} class(TtfwControlString)
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
 end;//Tkw_DictionContainer_Control_ChildZone

 Tkw_DictionContainer_Control_ChildZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ChildZone
----
*Пример использования*:
[code]
контрол::ChildZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ChildZone_Push

 Tkw_DictionContainer_Control_pnHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pnHeader

 Tkw_DictionContainer_Control_pnHeader_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pnHeader
----
*Пример использования*:
[code]
контрол::pnHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pnHeader_Push

 Tkw_DictionContainer_Control_lbHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_lbHeader

 Tkw_DictionContainer_Control_lbHeader_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола lbHeader
----
*Пример использования*:
[code]
контрол::lbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_lbHeader_Push

 Tkw_DictionContainer_Control_pbHeader = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_pbHeader

 Tkw_DictionContainer_Control_pbHeader_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола pbHeader
----
*Пример использования*:
[code]
контрол::pbHeader:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_pbHeader_Push

 Tkw_DictionContainer_Control_ParentZone = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_DictionContainer_Control_ParentZone

 Tkw_DictionContainer_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_DictionContainer_Control_ParentZone_Push

 TkwDictionContainerFormPnBackground = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.pnBackground
[panel]Контрол pnBackground формы TDictionContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnBackground >>> l_TvtProportionalPanel
[code]  }
  private
   function pnBackground(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TDictionContainerForm.pnBackground }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnBackground

 TkwDictionContainerFormNavigatorZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.NavigatorZone
[panel]Контрол NavigatorZone формы TDictionContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.NavigatorZone >>> l_TvtSizeablePanel
[code]  }
  private
   function NavigatorZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TDictionContainerForm.NavigatorZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormNavigatorZone

 TkwDictionContainerFormPnWorkArea = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.pnWorkArea
[panel]Контрол pnWorkArea формы TDictionContainerForm[panel]
*Тип результата:* TvtProportionalPanel
*Пример:*
[code]
OBJECT VAR l_TvtProportionalPanel
 aDictionContainerForm .TDictionContainerForm.pnWorkArea >>> l_TvtProportionalPanel
[code]  }
  private
   function pnWorkArea(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
    {* Реализация слова скрипта .TDictionContainerForm.pnWorkArea }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnWorkArea

 TkwDictionContainerFormChildZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.ChildZone
[panel]Контрол ChildZone формы TDictionContainerForm[panel]
*Тип результата:* TvtSizeablePanel
*Пример:*
[code]
OBJECT VAR l_TvtSizeablePanel
 aDictionContainerForm .TDictionContainerForm.ChildZone >>> l_TvtSizeablePanel
[code]  }
  private
   function ChildZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
    {* Реализация слова скрипта .TDictionContainerForm.ChildZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormChildZone

 TkwDictionContainerFormPnHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.pnHeader
[panel]Контрол pnHeader формы TDictionContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.pnHeader >>> l_TvtPanel
[code]  }
  private
   function pnHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* Реализация слова скрипта .TDictionContainerForm.pnHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPnHeader

 TkwDictionContainerFormLbHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.lbHeader
[panel]Контрол lbHeader формы TDictionContainerForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aDictionContainerForm .TDictionContainerForm.lbHeader >>> l_TvtLabel
[code]  }
  private
   function lbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtLabel;
    {* Реализация слова скрипта .TDictionContainerForm.lbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormLbHeader

 TkwDictionContainerFormPbHeader = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.pbHeader
[panel]Контрол pbHeader формы TDictionContainerForm[panel]
*Тип результата:* TPaintBox
*Пример:*
[code]
OBJECT VAR l_TPaintBox
 aDictionContainerForm .TDictionContainerForm.pbHeader >>> l_TPaintBox
[code]  }
  private
   function pbHeader(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TPaintBox;
    {* Реализация слова скрипта .TDictionContainerForm.pbHeader }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormPbHeader

 TkwDictionContainerFormParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TDictionContainerForm.ParentZone
[panel]Контрол ParentZone формы TDictionContainerForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aDictionContainerForm .TDictionContainerForm.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aDictionContainerForm: TDictionContainerForm): TvtPanel;
    {* Реализация слова скрипта .TDictionContainerForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwDictionContainerFormParentZone

class function Tkw_Form_DictionContainer.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::DictionContainer';
end;//Tkw_Form_DictionContainer.GetWordNameForRegister

function Tkw_Form_DictionContainer.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EEB2DA51554F_var*
//#UC END# *4DDFD2EA0116_EEB2DA51554F_var*
begin
//#UC START# *4DDFD2EA0116_EEB2DA51554F_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EEB2DA51554F_impl*
end;//Tkw_Form_DictionContainer.GetString

class function Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBackground';
end;//Tkw_DictionContainer_Control_pnBackground.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnBackground.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AD74E154270A_var*
//#UC END# *4DDFD2EA0116_AD74E154270A_var*
begin
//#UC START# *4DDFD2EA0116_AD74E154270A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AD74E154270A_impl*
end;//Tkw_DictionContainer_Control_pnBackground.GetString

class procedure Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
//#UC START# *52A086150180_AD74E154270A_var*
//#UC END# *52A086150180_AD74E154270A_var*
begin
//#UC START# *52A086150180_AD74E154270A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AD74E154270A_impl*
end;//Tkw_DictionContainer_Control_pnBackground.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8549E87000FA_var*
//#UC END# *4DAEEDE10285_8549E87000FA_var*
begin
//#UC START# *4DAEEDE10285_8549E87000FA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8549E87000FA_impl*
end;//Tkw_DictionContainer_Control_pnBackground_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnBackground:push';
end;//Tkw_DictionContainer_Control_pnBackground_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorZone';
end;//Tkw_DictionContainer_Control_NavigatorZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_NavigatorZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_E351200FAF21_var*
//#UC END# *4DDFD2EA0116_E351200FAF21_var*
begin
//#UC START# *4DDFD2EA0116_E351200FAF21_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_E351200FAF21_impl*
end;//Tkw_DictionContainer_Control_NavigatorZone.GetString

class procedure Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
//#UC START# *52A086150180_E351200FAF21_var*
//#UC END# *52A086150180_E351200FAF21_var*
begin
//#UC START# *52A086150180_E351200FAF21_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_E351200FAF21_impl*
end;//Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1A0DECEDF2FC_var*
//#UC END# *4DAEEDE10285_1A0DECEDF2FC_var*
begin
//#UC START# *4DAEEDE10285_1A0DECEDF2FC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1A0DECEDF2FC_impl*
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NavigatorZone:push';
end;//Tkw_DictionContainer_Control_NavigatorZone_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnWorkArea';
end;//Tkw_DictionContainer_Control_pnWorkArea.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnWorkArea.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_1F9996954308_var*
//#UC END# *4DDFD2EA0116_1F9996954308_var*
begin
//#UC START# *4DDFD2EA0116_1F9996954308_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_1F9996954308_impl*
end;//Tkw_DictionContainer_Control_pnWorkArea.GetString

class procedure Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
//#UC START# *52A086150180_1F9996954308_var*
//#UC END# *52A086150180_1F9996954308_var*
begin
//#UC START# *52A086150180_1F9996954308_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_1F9996954308_impl*
end;//Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A85B0AA8D5E5_var*
//#UC END# *4DAEEDE10285_A85B0AA8D5E5_var*
begin
//#UC START# *4DAEEDE10285_A85B0AA8D5E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A85B0AA8D5E5_impl*
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnWorkArea:push';
end;//Tkw_DictionContainer_Control_pnWorkArea_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone';
end;//Tkw_DictionContainer_Control_ChildZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ChildZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_33257B63022B_var*
//#UC END# *4DDFD2EA0116_33257B63022B_var*
begin
//#UC START# *4DDFD2EA0116_33257B63022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_33257B63022B_impl*
end;//Tkw_DictionContainer_Control_ChildZone.GetString

class procedure Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
//#UC START# *52A086150180_33257B63022B_var*
//#UC END# *52A086150180_33257B63022B_var*
begin
//#UC START# *52A086150180_33257B63022B_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_33257B63022B_impl*
end;//Tkw_DictionContainer_Control_ChildZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_204C48D2F9AA_var*
//#UC END# *4DAEEDE10285_204C48D2F9AA_var*
begin
//#UC START# *4DAEEDE10285_204C48D2F9AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_204C48D2F9AA_impl*
end;//Tkw_DictionContainer_Control_ChildZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ChildZone:push';
end;//Tkw_DictionContainer_Control_ChildZone_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnHeader';
end;//Tkw_DictionContainer_Control_pnHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pnHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_8B36B41AF9E4_var*
//#UC END# *4DDFD2EA0116_8B36B41AF9E4_var*
begin
//#UC START# *4DDFD2EA0116_8B36B41AF9E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_8B36B41AF9E4_impl*
end;//Tkw_DictionContainer_Control_pnHeader.GetString

class procedure Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
//#UC START# *52A086150180_8B36B41AF9E4_var*
//#UC END# *52A086150180_8B36B41AF9E4_var*
begin
//#UC START# *52A086150180_8B36B41AF9E4_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_8B36B41AF9E4_impl*
end;//Tkw_DictionContainer_Control_pnHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_F33C85DBBDBA_var*
//#UC END# *4DAEEDE10285_F33C85DBBDBA_var*
begin
//#UC START# *4DAEEDE10285_F33C85DBBDBA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_F33C85DBBDBA_impl*
end;//Tkw_DictionContainer_Control_pnHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pnHeader:push';
end;//Tkw_DictionContainer_Control_pnHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbHeader';
end;//Tkw_DictionContainer_Control_lbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_lbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_3A502519FD58_var*
//#UC END# *4DDFD2EA0116_3A502519FD58_var*
begin
//#UC START# *4DDFD2EA0116_3A502519FD58_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_3A502519FD58_impl*
end;//Tkw_DictionContainer_Control_lbHeader.GetString

class procedure Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
//#UC START# *52A086150180_3A502519FD58_var*
//#UC END# *52A086150180_3A502519FD58_var*
begin
//#UC START# *52A086150180_3A502519FD58_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_3A502519FD58_impl*
end;//Tkw_DictionContainer_Control_lbHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_FEF8B5D3C17D_var*
//#UC END# *4DAEEDE10285_FEF8B5D3C17D_var*
begin
//#UC START# *4DAEEDE10285_FEF8B5D3C17D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_FEF8B5D3C17D_impl*
end;//Tkw_DictionContainer_Control_lbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::lbHeader:push';
end;//Tkw_DictionContainer_Control_lbHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbHeader';
end;//Tkw_DictionContainer_Control_pbHeader.GetWordNameForRegister

function Tkw_DictionContainer_Control_pbHeader.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_2FE6E23CDCF1_var*
//#UC END# *4DDFD2EA0116_2FE6E23CDCF1_var*
begin
//#UC START# *4DDFD2EA0116_2FE6E23CDCF1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_2FE6E23CDCF1_impl*
end;//Tkw_DictionContainer_Control_pbHeader.GetString

class procedure Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
//#UC START# *52A086150180_2FE6E23CDCF1_var*
//#UC END# *52A086150180_2FE6E23CDCF1_var*
begin
//#UC START# *52A086150180_2FE6E23CDCF1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_2FE6E23CDCF1_impl*
end;//Tkw_DictionContainer_Control_pbHeader.RegisterInEngine

procedure Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_3C9DDE54E2E5_var*
//#UC END# *4DAEEDE10285_3C9DDE54E2E5_var*
begin
//#UC START# *4DAEEDE10285_3C9DDE54E2E5_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_3C9DDE54E2E5_impl*
end;//Tkw_DictionContainer_Control_pbHeader_Push.DoDoIt

class function Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::pbHeader:push';
end;//Tkw_DictionContainer_Control_pbHeader_Push.GetWordNameForRegister

class function Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_DictionContainer_Control_ParentZone.GetWordNameForRegister

function Tkw_DictionContainer_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_EDD9BB0D42A2_var*
//#UC END# *4DDFD2EA0116_EDD9BB0D42A2_var*
begin
//#UC START# *4DDFD2EA0116_EDD9BB0D42A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_EDD9BB0D42A2_impl*
end;//Tkw_DictionContainer_Control_ParentZone.GetString

class procedure Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_EDD9BB0D42A2_var*
//#UC END# *52A086150180_EDD9BB0D42A2_var*
begin
//#UC START# *52A086150180_EDD9BB0D42A2_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_EDD9BB0D42A2_impl*
end;//Tkw_DictionContainer_Control_ParentZone.RegisterInEngine

procedure Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_900D7D7F4C95_var*
//#UC END# *4DAEEDE10285_900D7D7F4C95_var*
begin
//#UC START# *4DAEEDE10285_900D7D7F4C95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_900D7D7F4C95_impl*
end;//Tkw_DictionContainer_Control_ParentZone_Push.DoDoIt

class function Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_DictionContainer_Control_ParentZone_Push.GetWordNameForRegister

function TkwDictionContainerFormPnBackground.pnBackground(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TDictionContainerForm.pnBackground }
//#UC START# *03F386BBCA55_5C1D4B47DA1C_var*
//#UC END# *03F386BBCA55_5C1D4B47DA1C_var*
begin
//#UC START# *03F386BBCA55_5C1D4B47DA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *03F386BBCA55_5C1D4B47DA1C_impl*
end;//TkwDictionContainerFormPnBackground.pnBackground

procedure TkwDictionContainerFormPnBackground.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_5C1D4B47DA1C_var*
//#UC END# *4DAEEDE10285_5C1D4B47DA1C_var*
begin
//#UC START# *4DAEEDE10285_5C1D4B47DA1C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_5C1D4B47DA1C_impl*
end;//TkwDictionContainerFormPnBackground.DoDoIt

class function TkwDictionContainerFormPnBackground.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnBackground';
end;//TkwDictionContainerFormPnBackground.GetWordNameForRegister

procedure TkwDictionContainerFormPnBackground.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormPnBackground.SetValuePrim

function TkwDictionContainerFormPnBackground.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnBackground.GetResultTypeInfo

function TkwDictionContainerFormPnBackground.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnBackground.GetAllParamsCount

function TkwDictionContainerFormPnBackground.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormPnBackground.ParamsTypes

function TkwDictionContainerFormNavigatorZone.NavigatorZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TDictionContainerForm.NavigatorZone }
//#UC START# *DEACE4731502_B758545C6415_var*
//#UC END# *DEACE4731502_B758545C6415_var*
begin
//#UC START# *DEACE4731502_B758545C6415_impl*
 !!! Needs to be implemented !!!
//#UC END# *DEACE4731502_B758545C6415_impl*
end;//TkwDictionContainerFormNavigatorZone.NavigatorZone

procedure TkwDictionContainerFormNavigatorZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B758545C6415_var*
//#UC END# *4DAEEDE10285_B758545C6415_var*
begin
//#UC START# *4DAEEDE10285_B758545C6415_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B758545C6415_impl*
end;//TkwDictionContainerFormNavigatorZone.DoDoIt

class function TkwDictionContainerFormNavigatorZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.NavigatorZone';
end;//TkwDictionContainerFormNavigatorZone.GetWordNameForRegister

procedure TkwDictionContainerFormNavigatorZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormNavigatorZone.SetValuePrim

function TkwDictionContainerFormNavigatorZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormNavigatorZone.GetResultTypeInfo

function TkwDictionContainerFormNavigatorZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormNavigatorZone.GetAllParamsCount

function TkwDictionContainerFormNavigatorZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormNavigatorZone.ParamsTypes

function TkwDictionContainerFormPnWorkArea.pnWorkArea(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtProportionalPanel;
 {* Реализация слова скрипта .TDictionContainerForm.pnWorkArea }
//#UC START# *10775A502EB3_DA6459295537_var*
//#UC END# *10775A502EB3_DA6459295537_var*
begin
//#UC START# *10775A502EB3_DA6459295537_impl*
 !!! Needs to be implemented !!!
//#UC END# *10775A502EB3_DA6459295537_impl*
end;//TkwDictionContainerFormPnWorkArea.pnWorkArea

procedure TkwDictionContainerFormPnWorkArea.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DA6459295537_var*
//#UC END# *4DAEEDE10285_DA6459295537_var*
begin
//#UC START# *4DAEEDE10285_DA6459295537_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_DA6459295537_impl*
end;//TkwDictionContainerFormPnWorkArea.DoDoIt

class function TkwDictionContainerFormPnWorkArea.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnWorkArea';
end;//TkwDictionContainerFormPnWorkArea.GetWordNameForRegister

procedure TkwDictionContainerFormPnWorkArea.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormPnWorkArea.SetValuePrim

function TkwDictionContainerFormPnWorkArea.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtProportionalPanel);
end;//TkwDictionContainerFormPnWorkArea.GetResultTypeInfo

function TkwDictionContainerFormPnWorkArea.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnWorkArea.GetAllParamsCount

function TkwDictionContainerFormPnWorkArea.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormPnWorkArea.ParamsTypes

function TkwDictionContainerFormChildZone.ChildZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtSizeablePanel;
 {* Реализация слова скрипта .TDictionContainerForm.ChildZone }
//#UC START# *F773BF03CE12_83F1D2A5B92D_var*
//#UC END# *F773BF03CE12_83F1D2A5B92D_var*
begin
//#UC START# *F773BF03CE12_83F1D2A5B92D_impl*
 !!! Needs to be implemented !!!
//#UC END# *F773BF03CE12_83F1D2A5B92D_impl*
end;//TkwDictionContainerFormChildZone.ChildZone

procedure TkwDictionContainerFormChildZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_83F1D2A5B92D_var*
//#UC END# *4DAEEDE10285_83F1D2A5B92D_var*
begin
//#UC START# *4DAEEDE10285_83F1D2A5B92D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_83F1D2A5B92D_impl*
end;//TkwDictionContainerFormChildZone.DoDoIt

class function TkwDictionContainerFormChildZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ChildZone';
end;//TkwDictionContainerFormChildZone.GetWordNameForRegister

procedure TkwDictionContainerFormChildZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormChildZone.SetValuePrim

function TkwDictionContainerFormChildZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtSizeablePanel);
end;//TkwDictionContainerFormChildZone.GetResultTypeInfo

function TkwDictionContainerFormChildZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormChildZone.GetAllParamsCount

function TkwDictionContainerFormChildZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormChildZone.ParamsTypes

function TkwDictionContainerFormPnHeader.pnHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* Реализация слова скрипта .TDictionContainerForm.pnHeader }
//#UC START# *8AA2A3629DDA_279A8001124C_var*
//#UC END# *8AA2A3629DDA_279A8001124C_var*
begin
//#UC START# *8AA2A3629DDA_279A8001124C_impl*
 !!! Needs to be implemented !!!
//#UC END# *8AA2A3629DDA_279A8001124C_impl*
end;//TkwDictionContainerFormPnHeader.pnHeader

procedure TkwDictionContainerFormPnHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_279A8001124C_var*
//#UC END# *4DAEEDE10285_279A8001124C_var*
begin
//#UC START# *4DAEEDE10285_279A8001124C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_279A8001124C_impl*
end;//TkwDictionContainerFormPnHeader.DoDoIt

class function TkwDictionContainerFormPnHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pnHeader';
end;//TkwDictionContainerFormPnHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPnHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormPnHeader.SetValuePrim

function TkwDictionContainerFormPnHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormPnHeader.GetResultTypeInfo

function TkwDictionContainerFormPnHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPnHeader.GetAllParamsCount

function TkwDictionContainerFormPnHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormPnHeader.ParamsTypes

function TkwDictionContainerFormLbHeader.lbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtLabel;
 {* Реализация слова скрипта .TDictionContainerForm.lbHeader }
//#UC START# *6D906F16EA27_1C8B99EC88F7_var*
//#UC END# *6D906F16EA27_1C8B99EC88F7_var*
begin
//#UC START# *6D906F16EA27_1C8B99EC88F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *6D906F16EA27_1C8B99EC88F7_impl*
end;//TkwDictionContainerFormLbHeader.lbHeader

procedure TkwDictionContainerFormLbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_1C8B99EC88F7_var*
//#UC END# *4DAEEDE10285_1C8B99EC88F7_var*
begin
//#UC START# *4DAEEDE10285_1C8B99EC88F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_1C8B99EC88F7_impl*
end;//TkwDictionContainerFormLbHeader.DoDoIt

class function TkwDictionContainerFormLbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.lbHeader';
end;//TkwDictionContainerFormLbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormLbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormLbHeader.SetValuePrim

function TkwDictionContainerFormLbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwDictionContainerFormLbHeader.GetResultTypeInfo

function TkwDictionContainerFormLbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormLbHeader.GetAllParamsCount

function TkwDictionContainerFormLbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormLbHeader.ParamsTypes

function TkwDictionContainerFormPbHeader.pbHeader(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TPaintBox;
 {* Реализация слова скрипта .TDictionContainerForm.pbHeader }
//#UC START# *92D95963053C_78B0474AA39B_var*
//#UC END# *92D95963053C_78B0474AA39B_var*
begin
//#UC START# *92D95963053C_78B0474AA39B_impl*
 !!! Needs to be implemented !!!
//#UC END# *92D95963053C_78B0474AA39B_impl*
end;//TkwDictionContainerFormPbHeader.pbHeader

procedure TkwDictionContainerFormPbHeader.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_78B0474AA39B_var*
//#UC END# *4DAEEDE10285_78B0474AA39B_var*
begin
//#UC START# *4DAEEDE10285_78B0474AA39B_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_78B0474AA39B_impl*
end;//TkwDictionContainerFormPbHeader.DoDoIt

class function TkwDictionContainerFormPbHeader.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.pbHeader';
end;//TkwDictionContainerFormPbHeader.GetWordNameForRegister

procedure TkwDictionContainerFormPbHeader.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormPbHeader.SetValuePrim

function TkwDictionContainerFormPbHeader.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TPaintBox);
end;//TkwDictionContainerFormPbHeader.GetResultTypeInfo

function TkwDictionContainerFormPbHeader.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormPbHeader.GetAllParamsCount

function TkwDictionContainerFormPbHeader.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormPbHeader.ParamsTypes

function TkwDictionContainerFormParentZone.ParentZone(const aCtx: TtfwContext;
 aDictionContainerForm: TDictionContainerForm): TvtPanel;
 {* Реализация слова скрипта .TDictionContainerForm.ParentZone }
//#UC START# *E12FBB9C38DC_0F3761C98BE0_var*
//#UC END# *E12FBB9C38DC_0F3761C98BE0_var*
begin
//#UC START# *E12FBB9C38DC_0F3761C98BE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *E12FBB9C38DC_0F3761C98BE0_impl*
end;//TkwDictionContainerFormParentZone.ParentZone

procedure TkwDictionContainerFormParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0F3761C98BE0_var*
//#UC END# *4DAEEDE10285_0F3761C98BE0_var*
begin
//#UC START# *4DAEEDE10285_0F3761C98BE0_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_0F3761C98BE0_impl*
end;//TkwDictionContainerFormParentZone.DoDoIt

class function TkwDictionContainerFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TDictionContainerForm.ParentZone';
end;//TkwDictionContainerFormParentZone.GetWordNameForRegister

procedure TkwDictionContainerFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ', aCtx);
end;//TkwDictionContainerFormParentZone.SetValuePrim

function TkwDictionContainerFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwDictionContainerFormParentZone.GetResultTypeInfo

function TkwDictionContainerFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwDictionContainerFormParentZone.GetAllParamsCount

function TkwDictionContainerFormParentZone.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwDictionContainerFormParentZone.ParamsTypes

initialization
 Tkw_Form_DictionContainer.RegisterInEngine;
 {* Регистрация Tkw_Form_DictionContainer }
 Tkw_DictionContainer_Control_pnBackground.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnBackground }
 Tkw_DictionContainer_Control_pnBackground_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnBackground_Push }
 Tkw_DictionContainer_Control_NavigatorZone.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_NavigatorZone }
 Tkw_DictionContainer_Control_NavigatorZone_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_NavigatorZone_Push }
 Tkw_DictionContainer_Control_pnWorkArea.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnWorkArea }
 Tkw_DictionContainer_Control_pnWorkArea_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnWorkArea_Push }
 Tkw_DictionContainer_Control_ChildZone.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_ChildZone }
 Tkw_DictionContainer_Control_ChildZone_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_ChildZone_Push }
 Tkw_DictionContainer_Control_pnHeader.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnHeader }
 Tkw_DictionContainer_Control_pnHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pnHeader_Push }
 Tkw_DictionContainer_Control_lbHeader.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_lbHeader }
 Tkw_DictionContainer_Control_lbHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_lbHeader_Push }
 Tkw_DictionContainer_Control_pbHeader.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pbHeader }
 Tkw_DictionContainer_Control_pbHeader_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_pbHeader_Push }
 Tkw_DictionContainer_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_ParentZone }
 Tkw_DictionContainer_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_DictionContainer_Control_ParentZone_Push }
 TkwDictionContainerFormPnBackground.RegisterInEngine;
 {* Регистрация DictionContainerForm_pnBackground }
 TkwDictionContainerFormNavigatorZone.RegisterInEngine;
 {* Регистрация DictionContainerForm_NavigatorZone }
 TkwDictionContainerFormPnWorkArea.RegisterInEngine;
 {* Регистрация DictionContainerForm_pnWorkArea }
 TkwDictionContainerFormChildZone.RegisterInEngine;
 {* Регистрация DictionContainerForm_ChildZone }
 TkwDictionContainerFormPnHeader.RegisterInEngine;
 {* Регистрация DictionContainerForm_pnHeader }
 TkwDictionContainerFormLbHeader.RegisterInEngine;
 {* Регистрация DictionContainerForm_lbHeader }
 TkwDictionContainerFormPbHeader.RegisterInEngine;
 {* Регистрация DictionContainerForm_pbHeader }
 TkwDictionContainerFormParentZone.RegisterInEngine;
 {* Регистрация DictionContainerForm_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TDictionContainerForm));
 {* Регистрация типа DictionContainer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtProportionalPanel));
 {* Регистрация типа TvtProportionalPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtSizeablePanel));
 {* Регистрация типа TvtSizeablePanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TPaintBox));
 {* Регистрация типа TPaintBox }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
