unit InsFilterNodeWordsPack;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters\InsFilterNodeWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "InsFilterNodeWordsPack" MUID: (53B533CE01B6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 //#UC START# *53B533CE01B6intf_uses*
 //#UC END# *53B533CE01B6intf_uses*
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , nsFiltersInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
 , FiltersUnit
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
 //#UC START# *53B533CE01B6impl_uses*
 //#UC END# *53B533CE01B6impl_uses*
;

type
 TInsFilterNodeWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TInsFilterNodeWordsPackResNameGetter

 TkwFilterNodeAutoApplied = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:AutoApplied
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFilterNode FilterNode:AutoApplied >>> l_Boolean
[code]  }
  private
   function AutoApplied(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:AutoApplied }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterNodeAutoApplied

 TkwFilterNodeIsUsed = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsUsed
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFilterNode FilterNode:IsUsed >>> l_Boolean
[code]  }
  private
   function IsUsed(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsUsed }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterNodeIsUsed

 TkwFilterNodeIsDeleted = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsDeleted
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFilterNode FilterNode:IsDeleted >>> l_Boolean
[code]  }
  private
   function IsDeleted(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsDeleted }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterNodeIsDeleted

 TkwFilterNodeIsChangeable = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsChangeable
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aFilterNode FilterNode:IsChangeable >>> l_Boolean
[code]  }
  private
   function IsChangeable(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsChangeable }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwFilterNodeIsChangeable

class function TInsFilterNodeWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'InsFilterNodeWordsPack';
end;//TInsFilterNodeWordsPackResNameGetter.ResName

 {$R InsFilterNodeWordsPack.res}

function TkwFilterNodeAutoApplied.AutoApplied(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:AutoApplied }
begin
 Result := aFilterNode.AutoApplied;
end;//TkwFilterNodeAutoApplied.AutoApplied

procedure TkwFilterNodeAutoApplied.DoDoIt(const aCtx: TtfwContext);
var l_aFilterNode: InsFilterNode;
begin
 try
  l_aFilterNode := InsFilterNode(aCtx.rEngine.PopIntf(InsFilterNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFilterNode: InsFilterNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(AutoApplied(aCtx, l_aFilterNode));
end;//TkwFilterNodeAutoApplied.DoDoIt

procedure TkwFilterNodeAutoApplied.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_FilterNode: InsFilterNode;
begin
 try
  l_FilterNode := InsFilterNode(aCtx.rEngine.PopIntf(InsFilterNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра FilterNode: InsFilterNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 l_FilterNode.AutoApplied := aValue.AsBoolean;
end;//TkwFilterNodeAutoApplied.SetValuePrim

function TkwFilterNodeAutoApplied.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFilterNodeAutoApplied.GetResultTypeInfo

function TkwFilterNodeAutoApplied.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFilterNodeAutoApplied.GetAllParamsCount

function TkwFilterNodeAutoApplied.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InsFilterNode)]);
end;//TkwFilterNodeAutoApplied.ParamsTypes

class function TkwFilterNodeAutoApplied.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:AutoApplied';
end;//TkwFilterNodeAutoApplied.GetWordNameForRegister

function TkwFilterNodeIsUsed.IsUsed(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsUsed }
//#UC START# *93AE1E55C2B1_3EAB6B490CA4_var*
//#UC END# *93AE1E55C2B1_3EAB6B490CA4_var*
begin
//#UC START# *93AE1E55C2B1_3EAB6B490CA4_impl*
 Result := aFilterNode.UsedStatus;
//#UC END# *93AE1E55C2B1_3EAB6B490CA4_impl*
end;//TkwFilterNodeIsUsed.IsUsed

procedure TkwFilterNodeIsUsed.DoDoIt(const aCtx: TtfwContext);
var l_aFilterNode: InsFilterNode;
begin
 try
  l_aFilterNode := InsFilterNode(aCtx.rEngine.PopIntf(InsFilterNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFilterNode: InsFilterNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsUsed(aCtx, l_aFilterNode));
end;//TkwFilterNodeIsUsed.DoDoIt

procedure TkwFilterNodeIsUsed.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsUsed', aCtx);
end;//TkwFilterNodeIsUsed.SetValuePrim

function TkwFilterNodeIsUsed.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFilterNodeIsUsed.GetResultTypeInfo

function TkwFilterNodeIsUsed.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFilterNodeIsUsed.GetAllParamsCount

function TkwFilterNodeIsUsed.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InsFilterNode)]);
end;//TkwFilterNodeIsUsed.ParamsTypes

class function TkwFilterNodeIsUsed.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsUsed';
end;//TkwFilterNodeIsUsed.GetWordNameForRegister

function TkwFilterNodeIsDeleted.IsDeleted(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsDeleted }
//#UC START# *9653DAAB38C3_2F875C7C1CA3_var*
//#UC END# *9653DAAB38C3_2F875C7C1CA3_var*
begin
//#UC START# *9653DAAB38C3_2F875C7C1CA3_impl*
 Result := aFilterNode.DeletedStatus;
//#UC END# *9653DAAB38C3_2F875C7C1CA3_impl*
end;//TkwFilterNodeIsDeleted.IsDeleted

procedure TkwFilterNodeIsDeleted.DoDoIt(const aCtx: TtfwContext);
var l_aFilterNode: InsFilterNode;
begin
 try
  l_aFilterNode := InsFilterNode(aCtx.rEngine.PopIntf(InsFilterNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFilterNode: InsFilterNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsDeleted(aCtx, l_aFilterNode));
end;//TkwFilterNodeIsDeleted.DoDoIt

procedure TkwFilterNodeIsDeleted.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsDeleted', aCtx);
end;//TkwFilterNodeIsDeleted.SetValuePrim

function TkwFilterNodeIsDeleted.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFilterNodeIsDeleted.GetResultTypeInfo

function TkwFilterNodeIsDeleted.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFilterNodeIsDeleted.GetAllParamsCount

function TkwFilterNodeIsDeleted.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InsFilterNode)]);
end;//TkwFilterNodeIsDeleted.ParamsTypes

class function TkwFilterNodeIsDeleted.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsDeleted';
end;//TkwFilterNodeIsDeleted.GetWordNameForRegister

function TkwFilterNodeIsChangeable.IsChangeable(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsChangeable }
//#UC START# *8AEEC707FD9D_008D699CFE74_var*
var
 l_F: IFilterFromQuery;
//#UC END# *8AEEC707FD9D_008D699CFE74_var*
begin
//#UC START# *8AEEC707FD9D_008D699CFE74_impl*
 Supports(aFilterNode, IFilterFromQuery, l_F);
 RunnerAssert(Assigned(l_F), 'Что-то не так с фильтром.', aCtx);
 try
  Result := l_F.GetChangeable;
 finally
  l_F := nil;
 end;//try..finally
//#UC END# *8AEEC707FD9D_008D699CFE74_impl*
end;//TkwFilterNodeIsChangeable.IsChangeable

procedure TkwFilterNodeIsChangeable.DoDoIt(const aCtx: TtfwContext);
var l_aFilterNode: InsFilterNode;
begin
 try
  l_aFilterNode := InsFilterNode(aCtx.rEngine.PopIntf(InsFilterNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aFilterNode: InsFilterNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsChangeable(aCtx, l_aFilterNode));
end;//TkwFilterNodeIsChangeable.DoDoIt

procedure TkwFilterNodeIsChangeable.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsChangeable', aCtx);
end;//TkwFilterNodeIsChangeable.SetValuePrim

function TkwFilterNodeIsChangeable.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwFilterNodeIsChangeable.GetResultTypeInfo

function TkwFilterNodeIsChangeable.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwFilterNodeIsChangeable.GetAllParamsCount

function TkwFilterNodeIsChangeable.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(InsFilterNode)]);
end;//TkwFilterNodeIsChangeable.ParamsTypes

class function TkwFilterNodeIsChangeable.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsChangeable';
end;//TkwFilterNodeIsChangeable.GetWordNameForRegister

initialization
 TInsFilterNodeWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwFilterNodeAutoApplied.RegisterInEngine;
 {* Регистрация FilterNode_AutoApplied }
 TkwFilterNodeIsUsed.RegisterInEngine;
 {* Регистрация FilterNode_IsUsed }
 TkwFilterNodeIsDeleted.RegisterInEngine;
 {* Регистрация FilterNode_IsDeleted }
 TkwFilterNodeIsChangeable.RegisterInEngine;
 {* Регистрация FilterNode_IsChangeable }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InsFilterNode));
 {* Регистрация типа InsFilterNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
