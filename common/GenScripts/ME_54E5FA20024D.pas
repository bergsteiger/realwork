unit vtHideFieldWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtHideFieldWords.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , vtHideField
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopHideFieldIsExpanded = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:IsExpanded
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aHideField pop:HideField:IsExpanded >>> l_Boolean
[code]  }
  private
   function IsExpanded(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField): Boolean;
    {* Реализация слова скрипта pop:HideField:IsExpanded }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldIsExpanded

 TkwPopHideFieldSetExpanded = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:SetExpanded
*Пример:*
[code]
 aValue aHideField pop:HideField:SetExpanded
[code]  }
  private
   procedure SetExpanded(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField;
    aValue: Boolean);
    {* Реализация слова скрипта pop:HideField:SetExpanded }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldSetExpanded

 TkwPopHideFieldGetCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:GetCaption
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aHideField pop:HideField:GetCaption >>> l_String
[code]  }
  private
   function GetCaption(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField): AnsiString;
    {* Реализация слова скрипта pop:HideField:GetCaption }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldGetCaption

function TkwPopHideFieldIsExpanded.IsExpanded(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField): Boolean;
 {* Реализация слова скрипта pop:HideField:IsExpanded }
//#UC START# *4A3348F91BD7_A0AE99A180FB_var*
//#UC END# *4A3348F91BD7_A0AE99A180FB_var*
begin
//#UC START# *4A3348F91BD7_A0AE99A180FB_impl*
 Result := (aHideField.State = hfsShow);
//#UC END# *4A3348F91BD7_A0AE99A180FB_impl*
end;//TkwPopHideFieldIsExpanded.IsExpanded

procedure TkwPopHideFieldIsExpanded.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_A0AE99A180FB_var*
//#UC END# *4DAEEDE10285_A0AE99A180FB_var*
begin
//#UC START# *4DAEEDE10285_A0AE99A180FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_A0AE99A180FB_impl*
end;//TkwPopHideFieldIsExpanded.DoDoIt

class function TkwPopHideFieldIsExpanded.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:IsExpanded';
end;//TkwPopHideFieldIsExpanded.GetWordNameForRegister

function TkwPopHideFieldIsExpanded.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_A0AE99A180FB_var*
//#UC END# *551544E2001A_A0AE99A180FB_var*
begin
//#UC START# *551544E2001A_A0AE99A180FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_A0AE99A180FB_impl*
end;//TkwPopHideFieldIsExpanded.GetResultTypeInfo

function TkwPopHideFieldIsExpanded.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopHideFieldIsExpanded.GetAllParamsCount

function TkwPopHideFieldIsExpanded.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_A0AE99A180FB_var*
//#UC END# *5617F4D00243_A0AE99A180FB_var*
begin
//#UC START# *5617F4D00243_A0AE99A180FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_A0AE99A180FB_impl*
end;//TkwPopHideFieldIsExpanded.ParamsTypes

procedure TkwPopHideFieldSetExpanded.SetExpanded(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField;
 aValue: Boolean);
 {* Реализация слова скрипта pop:HideField:SetExpanded }
//#UC START# *438029106CF0_D92EF59DAD00_var*
//#UC END# *438029106CF0_D92EF59DAD00_var*
begin
//#UC START# *438029106CF0_D92EF59DAD00_impl*
 if aValue then
  aHideField.State := hfsShow
 else
  aHideField.State := hfsHide;
//#UC END# *438029106CF0_D92EF59DAD00_impl*
end;//TkwPopHideFieldSetExpanded.SetExpanded

procedure TkwPopHideFieldSetExpanded.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D92EF59DAD00_var*
//#UC END# *4DAEEDE10285_D92EF59DAD00_var*
begin
//#UC START# *4DAEEDE10285_D92EF59DAD00_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D92EF59DAD00_impl*
end;//TkwPopHideFieldSetExpanded.DoDoIt

class function TkwPopHideFieldSetExpanded.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:SetExpanded';
end;//TkwPopHideFieldSetExpanded.GetWordNameForRegister

function TkwPopHideFieldSetExpanded.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D92EF59DAD00_var*
//#UC END# *551544E2001A_D92EF59DAD00_var*
begin
//#UC START# *551544E2001A_D92EF59DAD00_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D92EF59DAD00_impl*
end;//TkwPopHideFieldSetExpanded.GetResultTypeInfo

function TkwPopHideFieldSetExpanded.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopHideFieldSetExpanded.GetAllParamsCount

function TkwPopHideFieldSetExpanded.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D92EF59DAD00_var*
//#UC END# *5617F4D00243_D92EF59DAD00_var*
begin
//#UC START# *5617F4D00243_D92EF59DAD00_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D92EF59DAD00_impl*
end;//TkwPopHideFieldSetExpanded.ParamsTypes

function TkwPopHideFieldGetCaption.GetCaption(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField): AnsiString;
 {* Реализация слова скрипта pop:HideField:GetCaption }
//#UC START# *8FFF95B683E4_D34E3A240E95_var*
//#UC END# *8FFF95B683E4_D34E3A240E95_var*
begin
//#UC START# *8FFF95B683E4_D34E3A240E95_impl*
 Result := aHideField.Caption;
//#UC END# *8FFF95B683E4_D34E3A240E95_impl*
end;//TkwPopHideFieldGetCaption.GetCaption

procedure TkwPopHideFieldGetCaption.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_D34E3A240E95_var*
//#UC END# *4DAEEDE10285_D34E3A240E95_var*
begin
//#UC START# *4DAEEDE10285_D34E3A240E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_D34E3A240E95_impl*
end;//TkwPopHideFieldGetCaption.DoDoIt

class function TkwPopHideFieldGetCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:GetCaption';
end;//TkwPopHideFieldGetCaption.GetWordNameForRegister

function TkwPopHideFieldGetCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_D34E3A240E95_var*
//#UC END# *551544E2001A_D34E3A240E95_var*
begin
//#UC START# *551544E2001A_D34E3A240E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_D34E3A240E95_impl*
end;//TkwPopHideFieldGetCaption.GetResultTypeInfo

function TkwPopHideFieldGetCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopHideFieldGetCaption.GetAllParamsCount

function TkwPopHideFieldGetCaption.ParamsTypes: PTypeInfoArray;
//#UC START# *5617F4D00243_D34E3A240E95_var*
//#UC END# *5617F4D00243_D34E3A240E95_var*
begin
//#UC START# *5617F4D00243_D34E3A240E95_impl*
 !!! Needs to be implemented !!!
//#UC END# *5617F4D00243_D34E3A240E95_impl*
end;//TkwPopHideFieldGetCaption.ParamsTypes

initialization
 TkwPopHideFieldIsExpanded.RegisterInEngine;
 {* Регистрация pop_HideField_IsExpanded }
 TkwPopHideFieldSetExpanded.RegisterInEngine;
 {* Регистрация pop_HideField_SetExpanded }
 TkwPopHideFieldGetCaption.RegisterInEngine;
 {* Регистрация pop_HideField_GetCaption }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCustomHideField));
 {* Регистрация типа TvtCustomHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа String }
{$IfEnd} // NOT Defined(NoScripts)

end.
