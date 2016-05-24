unit vtHideFieldWords;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\vtHideFieldWords.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "vtHideFieldWords" MUID: (54E5FA20024D)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

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
 , vtHideField
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopHideFieldIsExpanded = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:IsExpanded }
  private
   function IsExpanded(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField): Boolean;
    {* Реализация слова скрипта pop:HideField:IsExpanded }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldIsExpanded

 TkwPopHideFieldSetExpanded = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:SetExpanded }
  private
   procedure SetExpanded(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField;
    aValue: Boolean);
    {* Реализация слова скрипта pop:HideField:SetExpanded }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldSetExpanded

 TkwPopHideFieldGetCaption = {final} class(TtfwClassLike)
  {* Слово скрипта pop:HideField:GetCaption }
  private
   function GetCaption(const aCtx: TtfwContext;
    aHideField: TvtCustomHideField): AnsiString;
    {* Реализация слова скрипта pop:HideField:GetCaption }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopHideFieldGetCaption

function TkwPopHideFieldIsExpanded.IsExpanded(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField): Boolean;
 {* Реализация слова скрипта pop:HideField:IsExpanded }
//#UC START# *552FB05F003F_552FB05F003F_4E732D8B0291_Word_var*
//#UC END# *552FB05F003F_552FB05F003F_4E732D8B0291_Word_var*
begin
//#UC START# *552FB05F003F_552FB05F003F_4E732D8B0291_Word_impl*
 Result := (aHideField.State = hfsShow);
//#UC END# *552FB05F003F_552FB05F003F_4E732D8B0291_Word_impl*
end;//TkwPopHideFieldIsExpanded.IsExpanded

class function TkwPopHideFieldIsExpanded.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:IsExpanded';
end;//TkwPopHideFieldIsExpanded.GetWordNameForRegister

function TkwPopHideFieldIsExpanded.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwPopHideFieldIsExpanded.GetResultTypeInfo

function TkwPopHideFieldIsExpanded.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopHideFieldIsExpanded.GetAllParamsCount

function TkwPopHideFieldIsExpanded.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomHideField)]);
end;//TkwPopHideFieldIsExpanded.ParamsTypes

procedure TkwPopHideFieldIsExpanded.DoDoIt(const aCtx: TtfwContext);
var l_aHideField: TvtCustomHideField;
begin
 try
  l_aHideField := TvtCustomHideField(aCtx.rEngine.PopObjAs(TvtCustomHideField));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHideField: TvtCustomHideField : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsExpanded(aCtx, l_aHideField));
end;//TkwPopHideFieldIsExpanded.DoDoIt

procedure TkwPopHideFieldSetExpanded.SetExpanded(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField;
 aValue: Boolean);
 {* Реализация слова скрипта pop:HideField:SetExpanded }
//#UC START# *552FB071025A_552FB071025A_4E732D8B0291_Word_var*
//#UC END# *552FB071025A_552FB071025A_4E732D8B0291_Word_var*
begin
//#UC START# *552FB071025A_552FB071025A_4E732D8B0291_Word_impl*
 if aValue then
  aHideField.State := hfsShow
 else
  aHideField.State := hfsHide;
//#UC END# *552FB071025A_552FB071025A_4E732D8B0291_Word_impl*
end;//TkwPopHideFieldSetExpanded.SetExpanded

class function TkwPopHideFieldSetExpanded.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:SetExpanded';
end;//TkwPopHideFieldSetExpanded.GetWordNameForRegister

function TkwPopHideFieldSetExpanded.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwPopHideFieldSetExpanded.GetResultTypeInfo

function TkwPopHideFieldSetExpanded.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopHideFieldSetExpanded.GetAllParamsCount

function TkwPopHideFieldSetExpanded.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomHideField), TypeInfo(Boolean)]);
end;//TkwPopHideFieldSetExpanded.ParamsTypes

procedure TkwPopHideFieldSetExpanded.DoDoIt(const aCtx: TtfwContext);
var l_aHideField: TvtCustomHideField;
var l_aValue: Boolean;
begin
 try
  l_aHideField := TvtCustomHideField(aCtx.rEngine.PopObjAs(TvtCustomHideField));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHideField: TvtCustomHideField : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 SetExpanded(aCtx, l_aHideField, l_aValue);
end;//TkwPopHideFieldSetExpanded.DoDoIt

function TkwPopHideFieldGetCaption.GetCaption(const aCtx: TtfwContext;
 aHideField: TvtCustomHideField): AnsiString;
 {* Реализация слова скрипта pop:HideField:GetCaption }
//#UC START# *552FB09D0396_552FB09D0396_4E732D8B0291_Word_var*
//#UC END# *552FB09D0396_552FB09D0396_4E732D8B0291_Word_var*
begin
//#UC START# *552FB09D0396_552FB09D0396_4E732D8B0291_Word_impl*
 Result := aHideField.Caption;
//#UC END# *552FB09D0396_552FB09D0396_4E732D8B0291_Word_impl*
end;//TkwPopHideFieldGetCaption.GetCaption

class function TkwPopHideFieldGetCaption.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:HideField:GetCaption';
end;//TkwPopHideFieldGetCaption.GetWordNameForRegister

function TkwPopHideFieldGetCaption.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopHideFieldGetCaption.GetResultTypeInfo

function TkwPopHideFieldGetCaption.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopHideFieldGetCaption.GetAllParamsCount

function TkwPopHideFieldGetCaption.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TvtCustomHideField)]);
end;//TkwPopHideFieldGetCaption.ParamsTypes

procedure TkwPopHideFieldGetCaption.DoDoIt(const aCtx: TtfwContext);
var l_aHideField: TvtCustomHideField;
begin
 try
  l_aHideField := TvtCustomHideField(aCtx.rEngine.PopObjAs(TvtCustomHideField));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aHideField: TvtCustomHideField : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(GetCaption(aCtx, l_aHideField));
end;//TkwPopHideFieldGetCaption.DoDoIt

initialization
 TkwPopHideFieldIsExpanded.RegisterInEngine;
 {* Регистрация pop_HideField_IsExpanded }
 TkwPopHideFieldSetExpanded.RegisterInEngine;
 {* Регистрация pop_HideField_SetExpanded }
 TkwPopHideFieldGetCaption.RegisterInEngine;
 {* Регистрация pop_HideField_GetCaption }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TvtCustomHideField));
 {* Регистрация типа TvtCustomHideField }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts) AND NOT Defined(NoVCL)

end.
