unit ParentKeywordsPack;
 {* Набор слов словаря для доступа к экземплярам контролов формы Parent }

// Модуль: "w:\common\components\gui\Garant\VCM\View\ParentAndChild\ParentKeywordsPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include f1LikeAppDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , ParentAndChildPrim_Module
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
 Tkw_Form_Parent = {final} class(TtfwControlString)
  {* Слово словаря для идентификатора формы Parent
----
*Пример использования*:
[code]
'aControl' форма::Parent TryFocus ASSERT
[code] }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   function GetString: AnsiString; override;
 end;//Tkw_Form_Parent

 Tkw_Parent_Control_ParentZone = {final} class(TtfwControlString)
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
 end;//Tkw_Parent_Control_ParentZone

 Tkw_Parent_Control_ParentZone_Push = {final} class(TkwBynameControlPush)
  {* Слово словаря для контрола ParentZone
----
*Пример использования*:
[code]
контрол::ParentZone:push pop:control:SetFocus ASSERT
[code] }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//Tkw_Parent_Control_ParentZone_Push

 TkwParentFormParentZone = {final} class(TtfwPropertyLike)
  {* Слово скрипта .TParentForm.ParentZone
[panel]Контрол ParentZone формы TParentForm[panel]
*Тип результата:* TvtPanel
*Пример:*
[code]
OBJECT VAR l_TvtPanel
 aParentForm .TParentForm.ParentZone >>> l_TvtPanel
[code]  }
  private
   function ParentZone(const aCtx: TtfwContext;
    aParentForm: TParentForm): TvtPanel;
    {* Реализация слова скрипта .TParentForm.ParentZone }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwParentFormParentZone

class function Tkw_Form_Parent.GetWordNameForRegister: AnsiString;
begin
 Result := 'форма::Parent';
end;//Tkw_Form_Parent.GetWordNameForRegister

function Tkw_Form_Parent.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_6975EF93CBDF_var*
//#UC END# *4DDFD2EA0116_6975EF93CBDF_var*
begin
//#UC START# *4DDFD2EA0116_6975EF93CBDF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_6975EF93CBDF_impl*
end;//Tkw_Form_Parent.GetString

class function Tkw_Parent_Control_ParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone';
end;//Tkw_Parent_Control_ParentZone.GetWordNameForRegister

function Tkw_Parent_Control_ParentZone.GetString: AnsiString;
//#UC START# *4DDFD2EA0116_B90C8FAA769A_var*
//#UC END# *4DDFD2EA0116_B90C8FAA769A_var*
begin
//#UC START# *4DDFD2EA0116_B90C8FAA769A_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDFD2EA0116_B90C8FAA769A_impl*
end;//Tkw_Parent_Control_ParentZone.GetString

class procedure Tkw_Parent_Control_ParentZone.RegisterInEngine;
//#UC START# *52A086150180_B90C8FAA769A_var*
//#UC END# *52A086150180_B90C8FAA769A_var*
begin
//#UC START# *52A086150180_B90C8FAA769A_impl*
 !!! Needs to be implemented !!!
//#UC END# *52A086150180_B90C8FAA769A_impl*
end;//Tkw_Parent_Control_ParentZone.RegisterInEngine

procedure Tkw_Parent_Control_ParentZone_Push.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_B1138181AE50_var*
//#UC END# *4DAEEDE10285_B1138181AE50_var*
begin
//#UC START# *4DAEEDE10285_B1138181AE50_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_B1138181AE50_impl*
end;//Tkw_Parent_Control_ParentZone_Push.DoDoIt

class function Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister: AnsiString;
begin
 Result := 'контрол::ParentZone:push';
end;//Tkw_Parent_Control_ParentZone_Push.GetWordNameForRegister

function TkwParentFormParentZone.ParentZone(const aCtx: TtfwContext;
 aParentForm: TParentForm): TvtPanel;
 {* Реализация слова скрипта .TParentForm.ParentZone }
//#UC START# *A91CC17C63F7_E6FBE1D9F4EF_var*
//#UC END# *A91CC17C63F7_E6FBE1D9F4EF_var*
begin
//#UC START# *A91CC17C63F7_E6FBE1D9F4EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *A91CC17C63F7_E6FBE1D9F4EF_impl*
end;//TkwParentFormParentZone.ParentZone

procedure TkwParentFormParentZone.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_E6FBE1D9F4EF_var*
//#UC END# *4DAEEDE10285_E6FBE1D9F4EF_var*
begin
//#UC START# *4DAEEDE10285_E6FBE1D9F4EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_E6FBE1D9F4EF_impl*
end;//TkwParentFormParentZone.DoDoIt

class function TkwParentFormParentZone.GetWordNameForRegister: AnsiString;
begin
 Result := '.TParentForm.ParentZone';
end;//TkwParentFormParentZone.GetWordNameForRegister

procedure TkwParentFormParentZone.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
//#UC START# *52D00B00031A_E6FBE1D9F4EF_var*
//#UC END# *52D00B00031A_E6FBE1D9F4EF_var*
begin
//#UC START# *52D00B00031A_E6FBE1D9F4EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52D00B00031A_E6FBE1D9F4EF_impl*
end;//TkwParentFormParentZone.SetValuePrim

function TkwParentFormParentZone.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TvtPanel);
end;//TkwParentFormParentZone.GetResultTypeInfo

function TkwParentFormParentZone.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwParentFormParentZone.GetAllParamsCount

function TkwParentFormParentZone.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_E6FBE1D9F4EF_var*
//#UC END# *5617F4D00243_E6FBE1D9F4EF_var*
begin
//#UC START# *5617F4D00243_E6FBE1D9F4EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_E6FBE1D9F4EF_impl*
end;//TkwParentFormParentZone.ParamsTypes

initialization
 Tkw_Form_Parent.RegisterInEngine;
 {* Регистрация Tkw_Form_Parent }
 Tkw_Parent_Control_ParentZone.RegisterInEngine;
 {* Регистрация Tkw_Parent_Control_ParentZone }
 Tkw_Parent_Control_ParentZone_Push.RegisterInEngine;
 {* Регистрация Tkw_Parent_Control_ParentZone_Push }
 TkwParentFormParentZone.RegisterInEngine;
 {* Регистрация ParentForm_ParentZone }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TParentForm));
 {* Регистрация типа Parent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtPanel));
 {* Регистрация типа TvtPanel }
{$IfEnd} // NOT Defined(NoScripts)

end.
