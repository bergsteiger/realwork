unit CreateFilterKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы CreateFilter$Form }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\CreateFilterKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Filters_Module
 , vtLabel
 {$If Defined(Nemesis)}
 , nscComboBox
 {$IfEnd} // Defined(Nemesis)
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
 Tkw_Form_CreateFilter = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы CreateFilter$Form
----
*Пример использования*:
[code]
'aControl' форма::CreateFilter TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_CreateFilter

 Tkw_CreateFilter_Control_NameLabel = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола NameLabel
----
*Пример использования*:
[code]
контрол::NameLabel TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CreateFilter_Control_NameLabel

 Tkw_CreateFilter_Control_NameLabel_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола NameLabel
----
*Пример использования*:
[code]
контрол::NameLabel:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_NameLabel_Push

 Tkw_CreateFilter_Control_FilterName = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора контрола FilterName
----
*Пример использования*:
[code]
контрол::FilterName TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
   class procedure RegisterInEngine; override;
 end;//Tkw_CreateFilter_Control_FilterName

 Tkw_CreateFilter_Control_FilterName_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола FilterName
----
*Пример использования*:
[code]
контрол::FilterName:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_CreateFilter_Control_FilterName_Push

 TkwCreateFilterFormNameLabel = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TCreateFilterForm.NameLabel
[panel]Контрол NameLabel формы TCreateFilterForm[panel]
*Тип результата:* TvtLabel
*Пример:*
[code]
OBJECT VAR l_TvtLabel
 aCreateFilterForm .TCreateFilterForm.NameLabel >>> l_TvtLabel
[code]  }
  private
   function NameLabel(const aCtx: TtfwContext;
    aCreateFilterForm: TCreateFilterForm): TvtLabel;
    {* Реализация слова скрипта .TCreateFilterForm.NameLabel }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateFilterFormNameLabel

 TkwCreateFilterFormFilterName = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TCreateFilterForm.FilterName
[panel]Контрол FilterName формы TCreateFilterForm[panel]
*Тип результата:* TnscEdit
*Пример:*
[code]
OBJECT VAR l_TnscEdit
 aCreateFilterForm .TCreateFilterForm.FilterName >>> l_TnscEdit
[code]  }
  private
   function FilterName(const aCtx: TtfwContext;
    aCreateFilterForm: TCreateFilterForm): TnscEdit;
    {* Реализация слова скрипта .TCreateFilterForm.FilterName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwCreateFilterFormFilterName

class function Tkw_Form_CreateFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::CreateFilter';
end;//Tkw_Form_CreateFilter.GetWordNameForRegister

function Tkw_Form_CreateFilter.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_5D16DB1881EC_var*
//#UC END# *4DDFD2EA0116_5D16DB1881EC_var*
begin
//#UC START# *4DDFD2EA0116_5D16DB1881EC_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_5D16DB1881EC_impl*
end;//Tkw_Form_CreateFilter.GetString

class function Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NameLabel';
end;//Tkw_CreateFilter_Control_NameLabel.GetWordNameForRegister

function Tkw_CreateFilter_Control_NameLabel.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_AD1738B646F9_var*
//#UC END# *4DDFD2EA0116_AD1738B646F9_var*
begin
//#UC START# *4DDFD2EA0116_AD1738B646F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_AD1738B646F9_impl*
end;//Tkw_CreateFilter_Control_NameLabel.GetString

class procedure Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
//#UC START# *52A086150180_AD1738B646F9_var*
//#UC END# *52A086150180_AD1738B646F9_var*
begin
//#UC START# *52A086150180_AD1738B646F9_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_AD1738B646F9_impl*
end;//Tkw_CreateFilter_Control_NameLabel.RegisterInEngine

procedure Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_44E18ABC1F46_var*
//#UC END# *4DAEEDE10285_44E18ABC1F46_var*
begin
//#UC START# *4DAEEDE10285_44E18ABC1F46_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_44E18ABC1F46_impl*
end;//Tkw_CreateFilter_Control_NameLabel_Push.DoDoIt

class function Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::NameLabel:push';
end;//Tkw_CreateFilter_Control_NameLabel_Push.GetWordNameForRegister

class function Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FilterName';
end;//Tkw_CreateFilter_Control_FilterName.GetWordNameForRegister

function Tkw_CreateFilter_Control_FilterName.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B0B6940E79AA_var*
//#UC END# *4DDFD2EA0116_B0B6940E79AA_var*
begin
//#UC START# *4DDFD2EA0116_B0B6940E79AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B0B6940E79AA_impl*
end;//Tkw_CreateFilter_Control_FilterName.GetString

class procedure Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
//#UC START# *52A086150180_B0B6940E79AA_var*
//#UC END# *52A086150180_B0B6940E79AA_var*
begin
//#UC START# *52A086150180_B0B6940E79AA_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B0B6940E79AA_impl*
end;//Tkw_CreateFilter_Control_FilterName.RegisterInEngine

procedure Tkw_CreateFilter_Control_FilterName_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_2DAD804284AD_var*
//#UC END# *4DAEEDE10285_2DAD804284AD_var*
begin
//#UC START# *4DAEEDE10285_2DAD804284AD_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_2DAD804284AD_impl*
end;//Tkw_CreateFilter_Control_FilterName_Push.DoDoIt

class function Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::FilterName:push';
end;//Tkw_CreateFilter_Control_FilterName_Push.GetWordNameForRegister

function TkwCreateFilterFormNameLabel.NameLabel(const aCtx: TtfwContext;
 aCreateFilterForm: TCreateFilterForm): TvtLabel;
 {* Реализация слова скрипта .TCreateFilterForm.NameLabel }
//#UC START# *C5517E6CB9C1_8D84CCE36454_var*
//#UC END# *C5517E6CB9C1_8D84CCE36454_var*
begin
//#UC START# *C5517E6CB9C1_8D84CCE36454_impl*
 !!! Needs to be implemented !!!
//#UC END# *C5517E6CB9C1_8D84CCE36454_impl*
end;//TkwCreateFilterFormNameLabel.NameLabel

procedure TkwCreateFilterFormNameLabel.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_8D84CCE36454_var*
//#UC END# *4DAEEDE10285_8D84CCE36454_var*
begin
//#UC START# *4DAEEDE10285_8D84CCE36454_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_8D84CCE36454_impl*
end;//TkwCreateFilterFormNameLabel.DoDoIt

class function TkwCreateFilterFormNameLabel.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCreateFilterForm.NameLabel';
end;//TkwCreateFilterFormNameLabel.GetWordNameForRegister

procedure TkwCreateFilterFormNameLabel.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_8D84CCE36454_var*
//#UC END# *52D00B00031A_8D84CCE36454_var*
begin
//#UC START# *52D00B00031A_8D84CCE36454_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_8D84CCE36454_impl*
end;//TkwCreateFilterFormNameLabel.SetValuePrim

function TkwCreateFilterFormNameLabel.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtLabel);
end;//TkwCreateFilterFormNameLabel.GetResultTypeInfo

function TkwCreateFilterFormNameLabel.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCreateFilterFormNameLabel.GetAllParamsCount

function TkwCreateFilterFormNameLabel.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCreateFilterFormNameLabel.ParamsTypes

function TkwCreateFilterFormFilterName.FilterName(const aCtx: TtfwContext;
 aCreateFilterForm: TCreateFilterForm): TnscEdit;
 {* Реализация слова скрипта .TCreateFilterForm.FilterName }
//#UC START# *573263BE04D8_E0C49BDE3F5C_var*
//#UC END# *573263BE04D8_E0C49BDE3F5C_var*
begin
//#UC START# *573263BE04D8_E0C49BDE3F5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *573263BE04D8_E0C49BDE3F5C_impl*
end;//TkwCreateFilterFormFilterName.FilterName

procedure TkwCreateFilterFormFilterName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E0C49BDE3F5C_var*
//#UC END# *4DAEEDE10285_E0C49BDE3F5C_var*
begin
//#UC START# *4DAEEDE10285_E0C49BDE3F5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E0C49BDE3F5C_impl*
end;//TkwCreateFilterFormFilterName.DoDoIt

class function TkwCreateFilterFormFilterName.GetWordNameForRegister: AnsiString;
begin
 Result := '.TCreateFilterForm.FilterName';
end;//TkwCreateFilterFormFilterName.GetWordNameForRegister

procedure TkwCreateFilterFormFilterName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E0C49BDE3F5C_var*
//#UC END# *52D00B00031A_E0C49BDE3F5C_var*
begin
//#UC START# *52D00B00031A_E0C49BDE3F5C_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E0C49BDE3F5C_impl*
end;//TkwCreateFilterFormFilterName.SetValuePrim

function TkwCreateFilterFormFilterName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TnscEdit);
end;//TkwCreateFilterFormFilterName.GetResultTypeInfo

function TkwCreateFilterFormFilterName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwCreateFilterFormFilterName.GetAllParamsCount

function TkwCreateFilterFormFilterName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwCreateFilterFormFilterName.ParamsTypes

initialization
 Tkw_Form_CreateFilter.RegisterInEngine;
 {* Регистрация Tkw_Form_CreateFilter }
 Tkw_CreateFilter_Control_NameLabel.RegisterInEngine;
 {* Регистрация Tkw_CreateFilter_Control_NameLabel }
 Tkw_CreateFilter_Control_NameLabel_Push.RegisterInEngine;
 {* Регистрация Tkw_CreateFilter_Control_NameLabel_Push }
 Tkw_CreateFilter_Control_FilterName.RegisterInEngine;
 {* Регистрация Tkw_CreateFilter_Control_FilterName }
 Tkw_CreateFilter_Control_FilterName_Push.RegisterInEngine;
 {* Регистрация Tkw_CreateFilter_Control_FilterName_Push }
 TkwCreateFilterFormNameLabel.RegisterInEngine;
 {* Регистрация CreateFilterForm_NameLabel }
 TkwCreateFilterFormFilterName.RegisterInEngine;
 {* Регистрация CreateFilterForm_FilterName }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TCreateFilterForm));
 {* Регистрация типа CreateFilter$Form }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtLabel));
 {* Регистрация типа TvtLabel }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TnscEdit));
 {* Регистрация типа TnscEdit }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
