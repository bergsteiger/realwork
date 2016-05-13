unit ComponentsProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ComponentsProcessingPack" MUID: (54F452710048)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Classes
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwPopComponentGetComponent = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Component:GetComponent }
  private
   function GetComponent(const aCtx: TtfwContext;
    aComponent: TComponent;
    anIndex: Integer): TComponent;
    {* Реализация слова скрипта pop:Component:GetComponent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentGetComponent

 TkwPopComponentFindComponent = {final} class(TtfwClassLike)
  {* Слово скрипта pop:Component:FindComponent }
  private
   function FindComponent(const aCtx: TtfwContext;
    aComponent: TComponent;
    const aName: AnsiString): TComponent;
    {* Реализация слова скрипта pop:Component:FindComponent }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentFindComponent

 TkwPopComponentComponentCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:ComponentCount }
  private
   function ComponentCount(const aCtx: TtfwContext;
    aComponent: TComponent): Integer;
    {* Реализация слова скрипта pop:Component:ComponentCount }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopComponentComponentCount

 TkwPopComponentOwner = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:Owner }
  private
   function Owner(const aCtx: TtfwContext;
    aComponent: TComponent): TComponent;
    {* Реализация слова скрипта pop:Component:Owner }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopComponentOwner

 TkwPopComponentName = {final} class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:Name }
  private
   function Name(const aCtx: TtfwContext;
    aComponent: TComponent): AnsiString;
    {* Реализация слова скрипта pop:Component:Name }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopComponentName

function TkwPopComponentGetComponent.GetComponent(const aCtx: TtfwContext;
 aComponent: TComponent;
 anIndex: Integer): TComponent;
 {* Реализация слова скрипта pop:Component:GetComponent }
//#UC START# *54F9BCB401D4_54F9BCB401D4_479878FA0103_Word_var*
//#UC END# *54F9BCB401D4_54F9BCB401D4_479878FA0103_Word_var*
begin
//#UC START# *54F9BCB401D4_54F9BCB401D4_479878FA0103_Word_impl*
 Result := aComponent.Components[anIndex];
//#UC END# *54F9BCB401D4_54F9BCB401D4_479878FA0103_Word_impl*
end;//TkwPopComponentGetComponent.GetComponent

class function TkwPopComponentGetComponent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:GetComponent';
end;//TkwPopComponentGetComponent.GetWordNameForRegister

function TkwPopComponentGetComponent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComponent);
end;//TkwPopComponentGetComponent.GetResultTypeInfo

function TkwPopComponentGetComponent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComponentGetComponent.GetAllParamsCount

function TkwPopComponentGetComponent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TComponent), TypeInfo(Integer)]);
end;//TkwPopComponentGetComponent.ParamsTypes

procedure TkwPopComponentGetComponent.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
var l_anIndex: Integer;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetComponent(aCtx, l_aComponent, l_anIndex));
end;//TkwPopComponentGetComponent.DoDoIt

function TkwPopComponentFindComponent.FindComponent(const aCtx: TtfwContext;
 aComponent: TComponent;
 const aName: AnsiString): TComponent;
 {* Реализация слова скрипта pop:Component:FindComponent }
begin
 Result := aComponent.FindComponent(aName);
end;//TkwPopComponentFindComponent.FindComponent

class function TkwPopComponentFindComponent.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:FindComponent';
end;//TkwPopComponentFindComponent.GetWordNameForRegister

function TkwPopComponentFindComponent.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComponent);
end;//TkwPopComponentFindComponent.GetResultTypeInfo

function TkwPopComponentFindComponent.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopComponentFindComponent.GetAllParamsCount

function TkwPopComponentFindComponent.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TComponent), @tfw_tiString]);
end;//TkwPopComponentFindComponent.ParamsTypes

procedure TkwPopComponentFindComponent.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
var l_aName: AnsiString;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindComponent(aCtx, l_aComponent, l_aName));
end;//TkwPopComponentFindComponent.DoDoIt

function TkwPopComponentComponentCount.ComponentCount(const aCtx: TtfwContext;
 aComponent: TComponent): Integer;
 {* Реализация слова скрипта pop:Component:ComponentCount }
begin
 Result := aComponent.ComponentCount;
end;//TkwPopComponentComponentCount.ComponentCount

class function TkwPopComponentComponentCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:ComponentCount';
end;//TkwPopComponentComponentCount.GetWordNameForRegister

function TkwPopComponentComponentCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwPopComponentComponentCount.GetResultTypeInfo

function TkwPopComponentComponentCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComponentComponentCount.GetAllParamsCount

function TkwPopComponentComponentCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TComponent)]);
end;//TkwPopComponentComponentCount.ParamsTypes

procedure TkwPopComponentComponentCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству ComponentCount', aCtx);
end;//TkwPopComponentComponentCount.SetValuePrim

procedure TkwPopComponentComponentCount.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ComponentCount(aCtx, l_aComponent));
end;//TkwPopComponentComponentCount.DoDoIt

function TkwPopComponentOwner.Owner(const aCtx: TtfwContext;
 aComponent: TComponent): TComponent;
 {* Реализация слова скрипта pop:Component:Owner }
begin
 Result := aComponent.Owner;
end;//TkwPopComponentOwner.Owner

class function TkwPopComponentOwner.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:Owner';
end;//TkwPopComponentOwner.GetWordNameForRegister

function TkwPopComponentOwner.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TComponent);
end;//TkwPopComponentOwner.GetResultTypeInfo

function TkwPopComponentOwner.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComponentOwner.GetAllParamsCount

function TkwPopComponentOwner.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TComponent)]);
end;//TkwPopComponentOwner.ParamsTypes

procedure TkwPopComponentOwner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Owner', aCtx);
end;//TkwPopComponentOwner.SetValuePrim

procedure TkwPopComponentOwner.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Owner(aCtx, l_aComponent));
end;//TkwPopComponentOwner.DoDoIt

function TkwPopComponentName.Name(const aCtx: TtfwContext;
 aComponent: TComponent): AnsiString;
 {* Реализация слова скрипта pop:Component:Name }
begin
 Result := aComponent.Name;
end;//TkwPopComponentName.Name

class function TkwPopComponentName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:Name';
end;//TkwPopComponentName.GetWordNameForRegister

function TkwPopComponentName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwPopComponentName.GetResultTypeInfo

function TkwPopComponentName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopComponentName.GetAllParamsCount

function TkwPopComponentName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TComponent)]);
end;//TkwPopComponentName.ParamsTypes

procedure TkwPopComponentName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Name', aCtx);
end;//TkwPopComponentName.SetValuePrim

procedure TkwPopComponentName.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aComponent));
end;//TkwPopComponentName.DoDoIt

initialization
 TkwPopComponentGetComponent.RegisterInEngine;
 {* Регистрация pop_Component_GetComponent }
 TkwPopComponentFindComponent.RegisterInEngine;
 {* Регистрация pop_Component_FindComponent }
 TkwPopComponentComponentCount.RegisterInEngine;
 {* Регистрация pop_Component_ComponentCount }
 TkwPopComponentOwner.RegisterInEngine;
 {* Регистрация pop_Component_Owner }
 TkwPopComponentName.RegisterInEngine;
 {* Регистрация pop_Component_Name }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* Регистрация типа TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
