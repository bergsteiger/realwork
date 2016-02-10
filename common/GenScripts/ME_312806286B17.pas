unit AttributesKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Attributes }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Document\AttributesKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Document_Module
 , nscTreeViewWithAdapterDragDrop
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
 Tkw_Form_Attributes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Attributes
----
*Пример использования*:
[code]
'aControl' форма::Attributes TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Attributes

 Tkw_Attributes_Control_tvAttributes = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола tvAttributes
----
*Пример использования*:
[code]
контрол::tvAttributes TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_Attributes_Control_tvAttributes

 Tkw_Attributes_Control_tvAttributes_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола tvAttributes
----
*Пример использования*:
[code]
контрол::tvAttributes:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Attributes_Control_tvAttributes_Push

 TkwAttributesFormTvAttributes = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TAttributesForm.tvAttributes
[panel]Контрол tvAttributes формы TAttributesForm[panel]
*Тип результата:* TnscTreeViewWithAdapterDragDrop
*Пример:*
[code]
OBJECT VAR l_TnscTreeViewWithAdapterDragDrop
 aAttributesForm .TAttributesForm.tvAttributes >>> l_TnscTreeViewWithAdapterDragDrop
[code]  }
  private
   function tvAttributes(const aCtx: TtfwContext;
    aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
    {* Реализация слова скрипта .TAttributesForm.tvAttributes }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAttributesFormTvAttributes

class function Tkw_Form_Attributes.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Attributes';
end;//Tkw_Form_Attributes.GetWordNameForRegister

function Tkw_Form_Attributes.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_0E3DBAA731F1_var*
//#UC END# *4DDFD2EA0116_0E3DBAA731F1_var*
begin
//#UC START# *4DDFD2EA0116_0E3DBAA731F1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_0E3DBAA731F1_impl*
end;//Tkw_Form_Attributes.GetString

class function Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvAttributes';
end;//Tkw_Attributes_Control_tvAttributes.GetWordNameForRegister

function Tkw_Attributes_Control_tvAttributes.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_7C2297E661A1_var*
//#UC END# *4DDFD2EA0116_7C2297E661A1_var*
begin
//#UC START# *4DDFD2EA0116_7C2297E661A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_7C2297E661A1_impl*
end;//Tkw_Attributes_Control_tvAttributes.GetString

class procedure Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
//#UC START# *52A086150180_7C2297E661A1_var*
//#UC END# *52A086150180_7C2297E661A1_var*
begin
//#UC START# *52A086150180_7C2297E661A1_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_7C2297E661A1_impl*
end;//Tkw_Attributes_Control_tvAttributes.RegisterInEngine

procedure Tkw_Attributes_Control_tvAttributes_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_7929088CC1B7_var*
//#UC END# *4DAEEDE10285_7929088CC1B7_var*
begin
//#UC START# *4DAEEDE10285_7929088CC1B7_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_7929088CC1B7_impl*
end;//Tkw_Attributes_Control_tvAttributes_Push.DoDoIt

class function Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::tvAttributes:push';
end;//Tkw_Attributes_Control_tvAttributes_Push.GetWordNameForRegister

function TkwAttributesFormTvAttributes.tvAttributes(const aCtx: TtfwContext;
 aAttributesForm: TAttributesForm): TnscTreeViewWithAdapterDragDrop;
 {* Реализация слова скрипта .TAttributesForm.tvAttributes }
//#UC START# *D963523A1B4B_C2DA991E7351_var*
//#UC END# *D963523A1B4B_C2DA991E7351_var*
begin
//#UC START# *D963523A1B4B_C2DA991E7351_impl*
 !!! Needs to be implemented !!!
//#UC END# *D963523A1B4B_C2DA991E7351_impl*
end;//TkwAttributesFormTvAttributes.tvAttributes

procedure TkwAttributesFormTvAttributes.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_C2DA991E7351_var*
//#UC END# *4DAEEDE10285_C2DA991E7351_var*
begin
//#UC START# *4DAEEDE10285_C2DA991E7351_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_C2DA991E7351_impl*
end;//TkwAttributesFormTvAttributes.DoDoIt

class function TkwAttributesFormTvAttributes.GetWordNameForRegister: AnsiString;
begin
 Result := '.TAttributesForm.tvAttributes';
end;//TkwAttributesFormTvAttributes.GetWordNameForRegister

procedure TkwAttributesFormTvAttributes.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
end;//TkwAttributesFormTvAttributes.SetValuePrim

function TkwAttributesFormTvAttributes.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscTreeViewWithAdapterDragDrop);
end;//TkwAttributesFormTvAttributes.GetResultTypeInfo

function TkwAttributesFormTvAttributes.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwAttributesFormTvAttributes.GetAllParamsCount

function TkwAttributesFormTvAttributes.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwAttributesFormTvAttributes.ParamsTypes

initialization
 Tkw_Form_Attributes.RegisterInEngine;
 {* Регистрация Tkw_Form_Attributes }
 Tkw_Attributes_Control_tvAttributes.RegisterInEngine;
 {* Регистрация Tkw_Attributes_Control_tvAttributes }
 Tkw_Attributes_Control_tvAttributes_Push.RegisterInEngine;
 {* Регистрация Tkw_Attributes_Control_tvAttributes_Push }
 TkwAttributesFormTvAttributes.RegisterInEngine;
 {* Регистрация AttributesForm_tvAttributes }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttributesForm));
 {* Регистрация типа Attributes }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscTreeViewWithAdapterDragDrop));
 {* Регистрация типа TnscTreeViewWithAdapterDragDrop }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
