unit ComponentsProcessingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ComponentsProcessingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ComponentsProcessingPack" MUID: (54F452710048)

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
  {* ����� ������� pop:Component:GetComponent }
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
  {* ����� ������� pop:Component:FindComponent }
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
  {* ����� ������� pop:Component:ComponentCount }
  private
   function ComponentCount(const aCtx: TtfwContext;
    aComponent: TComponent): Integer;
    {* ���������� ����� ������� pop:Component:ComponentCount }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopComponentComponentCount

 TkwPopComponentOwner = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Owner }
  private
   function Owner(const aCtx: TtfwContext;
    aComponent: TComponent): TComponent;
    {* ���������� ����� ������� pop:Component:Owner }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwPopComponentOwner

 TkwPopComponentName = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Name }
  private
   function Name(const aCtx: TtfwContext;
    aComponent: TComponent): AnsiString;
    {* ���������� ����� ������� pop:Component:Name }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
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
 {* ���������� ����� ������� pop:Component:GetComponent }
//#UC START# *54F9BCB401D4_D0FE9D22441B_var*
//#UC END# *54F9BCB401D4_D0FE9D22441B_var*
begin
//#UC START# *54F9BCB401D4_D0FE9D22441B_impl*
 Result := aComponent.Components[anIndex];
//#UC END# *54F9BCB401D4_D0FE9D22441B_impl*
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
begin
 Result := aComponent.FindComponent(aName);
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
begin
 Result := aComponent.ComponentCount;
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
 RunnerError('������ ����������� �������� readonly �������� ComponentCount', aCtx);
end;//TkwPopComponentComponentCount.SetValuePrim

function TkwPopComponentOwner.Owner(const aCtx: TtfwContext;
 aComponent: TComponent): TComponent;
 {* ���������� ����� ������� pop:Component:Owner }
begin
 Result := aComponent.Owner;
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
 RunnerError('������ ����������� �������� readonly �������� Owner', aCtx);
end;//TkwPopComponentOwner.SetValuePrim

function TkwPopComponentName.Name(const aCtx: TtfwContext;
 aComponent: TComponent): AnsiString;
 {* ���������� ����� ������� pop:Component:Name }
begin
 Result := aComponent.Name;
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
 RunnerError('������ ����������� �������� readonly �������� Name', aCtx);
end;//TkwPopComponentName.SetValuePrim

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
 TtfwTypeRegistrator.RegisterType(TypeInfo(TComponent));
 {* ����������� ���� TComponent }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* ����������� ���� Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� AnsiString }
{$IfEnd} // NOT Defined(NoScripts)

end.
