unit ComponentsProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Classes
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
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
 TkwPopComponentGetComponent = {final} class(TtfwClassLike)
  {* ����� ������� pop:Component:GetComponent
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 anIndex aComponent pop:Component:GetComponent >>> l_TComponent
[code]  }
  private
   function GetComponent(const aCtx: TtfwContext;
    aComponent: TComponent;
    anIndex: Integer): TComponent;
    {* ���������� ����� ������� pop:Component:GetComponent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentGetComponent

 TkwPopComponentFindComponent = {final} class(TtfwClassLike)
  {* ����� ������� pop:Component:FindComponent
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aName aComponent pop:Component:FindComponent >>> l_TComponent
[code]  }
  private
   function FindComponent(const aCtx: TtfwContext;
    aComponent: TComponent;
    const aName: AnsiString): TComponent;
    {* ���������� ����� ������� pop:Component:FindComponent }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentFindComponent

 TkwPopComponentComponentCount = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Component:ComponentCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComponent pop:Component:ComponentCount >>> l_Integer
[code]  }
  private
   function ComponentCount(const aCtx: TtfwContext;
    aComponent: TComponent): Integer;
    {* ���������� ����� ������� pop:Component:ComponentCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentComponentCount

 TkwPopComponentOwner = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Owner
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aComponent pop:Component:Owner >>> l_TComponent
[code]  }
  private
   function Owner(const aCtx: TtfwContext;
    aComponent: TComponent): TComponent;
    {* ���������� ����� ������� pop:Component:Owner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentOwner

 TkwPopComponentName = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aComponent pop:Component:Name >>> l_String
[code]  }
  private
   function Name(const aCtx: TtfwContext;
    aComponent: TComponent): AnsiString;
    {* ���������� ����� ������� pop:Component:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopComponentName

function TkwPopComponentGetComponent.GetComponent(const aCtx: TtfwContext;
 aComponent: TComponent;
 anIndex: Integer): TComponent;
 {* ���������� ����� ������� pop:Component:GetComponent }
//#UC START# *2E270C931823_D0FE9D22441B_var*
//#UC END# *2E270C931823_D0FE9D22441B_var*
begin
//#UC START# *2E270C931823_D0FE9D22441B_impl*
 Result := aComponent.Components[anIndex];
//#UC END# *2E270C931823_D0FE9D22441B_impl*
end;//TkwPopComponentGetComponent.GetComponent

procedure TkwPopComponentGetComponent.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
var l_anIndex: Integer;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anIndex := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anIndex: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(GetComponent(aCtx, l_aComponent, l_anIndex));
end;//TkwPopComponentGetComponent.DoDoIt

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

function TkwPopComponentFindComponent.FindComponent(const aCtx: TtfwContext;
 aComponent: TComponent;
 const aName: AnsiString): TComponent;
 {* ���������� ����� ������� pop:Component:FindComponent }
//#UC START# *61724DDB4B2B_4F10E1D50761_var*
//#UC END# *61724DDB4B2B_4F10E1D50761_var*
begin
//#UC START# *61724DDB4B2B_4F10E1D50761_impl*
 !!! Needs to be implemented !!!
//#UC END# *61724DDB4B2B_4F10E1D50761_impl*
end;//TkwPopComponentFindComponent.FindComponent

procedure TkwPopComponentFindComponent.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
var l_aName: AnsiString;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopDelphiString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: AnsiString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(FindComponent(aCtx, l_aComponent, l_aName));
end;//TkwPopComponentFindComponent.DoDoIt

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

function TkwPopComponentComponentCount.ComponentCount(const aCtx: TtfwContext;
 aComponent: TComponent): Integer;
 {* ���������� ����� ������� pop:Component:ComponentCount }
//#UC START# *A4B08EBFFC24_3B829E298F09_var*
//#UC END# *A4B08EBFFC24_3B829E298F09_var*
begin
//#UC START# *A4B08EBFFC24_3B829E298F09_impl*
 !!! Needs to be implemented !!!
//#UC END# *A4B08EBFFC24_3B829E298F09_impl*
end;//TkwPopComponentComponentCount.ComponentCount

procedure TkwPopComponentComponentCount.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(ComponentCount(aCtx, l_aComponent));
end;//TkwPopComponentComponentCount.DoDoIt

class function TkwPopComponentComponentCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:ComponentCount';
end;//TkwPopComponentComponentCount.GetWordNameForRegister

procedure TkwPopComponentComponentCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ComponentCount', aCtx);
end;//TkwPopComponentComponentCount.SetValuePrim

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

function TkwPopComponentOwner.Owner(const aCtx: TtfwContext;
 aComponent: TComponent): TComponent;
 {* ���������� ����� ������� pop:Component:Owner }
//#UC START# *9E2CF131AE8C_722F6A69957B_var*
//#UC END# *9E2CF131AE8C_722F6A69957B_var*
begin
//#UC START# *9E2CF131AE8C_722F6A69957B_impl*
 !!! Needs to be implemented !!!
//#UC END# *9E2CF131AE8C_722F6A69957B_impl*
end;//TkwPopComponentOwner.Owner

procedure TkwPopComponentOwner.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(Owner(aCtx, l_aComponent));
end;//TkwPopComponentOwner.DoDoIt

class function TkwPopComponentOwner.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:Owner';
end;//TkwPopComponentOwner.GetWordNameForRegister

procedure TkwPopComponentOwner.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Owner', aCtx);
end;//TkwPopComponentOwner.SetValuePrim

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

function TkwPopComponentName.Name(const aCtx: TtfwContext;
 aComponent: TComponent): AnsiString;
 {* ���������� ����� ������� pop:Component:Name }
//#UC START# *FDA0EFB1E431_4DE6AA14F838_var*
//#UC END# *FDA0EFB1E431_4DE6AA14F838_var*
begin
//#UC START# *FDA0EFB1E431_4DE6AA14F838_impl*
 !!! Needs to be implemented !!!
//#UC END# *FDA0EFB1E431_4DE6AA14F838_impl*
end;//TkwPopComponentName.Name

procedure TkwPopComponentName.DoDoIt(const aCtx: TtfwContext);
var l_aComponent: TComponent;
begin
 try
  l_aComponent := TComponent(aCtx.rEngine.PopObjAs(TComponent));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aComponent: TComponent : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Name(aCtx, l_aComponent));
end;//TkwPopComponentName.DoDoIt

class function TkwPopComponentName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:Component:Name';
end;//TkwPopComponentName.GetWordNameForRegister

procedure TkwPopComponentName.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� Name', aCtx);
end;//TkwPopComponentName.SetValuePrim

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

initialization
 TkwPopComponentGetComponent.RegisterInEngine;
 {* ����������� pop_Component_GetComponent }
 TkwPopComponentFindComponent.RegisterInEngine;
 {* ����������� pop_Component_FindComponent }
 TkwPopComponentComponentCount.RegisterInEngine;
 {* ����������� pop_Component_ComponentCount }
 TkwPopComponentOwner.RegisterInEngine;
 {* ����������� pop_Component_Owner }
 TkwPopComponentName.RegisterInEngine;
 {* ����������� pop_Component_Name }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* ����������� ���� TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� String }
{$IfEnd} // NOT Defined(NoScripts)

end.
