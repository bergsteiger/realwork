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
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , FiltersUnit
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
 //#UC START# *53B533CE01B6impl_uses*
 //#UC END# *53B533CE01B6impl_uses*
;

type
 TkwFilterNodeAutoApplied = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:AutoApplied }
  private
   function AutoApplied(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:AutoApplied }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFilterNodeAutoApplied

 TkwFilterNodeIsUsed = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsUsed }
  private
   function IsUsed(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsUsed }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFilterNodeIsUsed

 TkwFilterNodeIsDeleted = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsDeleted }
  private
   function IsDeleted(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsDeleted }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFilterNodeIsDeleted

 TkwFilterNodeIsChangeable = {final} class(TtfwPropertyLike)
  {* Слово скрипта FilterNode:IsChangeable }
  private
   function IsChangeable(const aCtx: TtfwContext;
    const aFilterNode: InsFilterNode): Boolean;
    {* Реализация слова скрипта FilterNode:IsChangeable }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwFilterNodeIsChangeable

 TInsFilterNodeWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TInsFilterNodeWordsPackResNameGetter

function TkwFilterNodeAutoApplied.AutoApplied(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:AutoApplied }
begin
 Result := aFilterNode.AutoApplied;
end;//TkwFilterNodeAutoApplied.AutoApplied

class function TkwFilterNodeAutoApplied.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:AutoApplied';
end;//TkwFilterNodeAutoApplied.GetWordNameForRegister

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

function TkwFilterNodeIsUsed.IsUsed(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsUsed }
//#UC START# *0B8C389F0B1C_0B8C389F0B1C_4991887A031F_Word_var*
//#UC END# *0B8C389F0B1C_0B8C389F0B1C_4991887A031F_Word_var*
begin
//#UC START# *0B8C389F0B1C_0B8C389F0B1C_4991887A031F_Word_impl*
 Result := aFilterNode.UsedStatus;
//#UC END# *0B8C389F0B1C_0B8C389F0B1C_4991887A031F_Word_impl*
end;//TkwFilterNodeIsUsed.IsUsed

class function TkwFilterNodeIsUsed.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsUsed';
end;//TkwFilterNodeIsUsed.GetWordNameForRegister

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

procedure TkwFilterNodeIsUsed.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsUsed', aCtx);
end;//TkwFilterNodeIsUsed.SetValuePrim

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

function TkwFilterNodeIsDeleted.IsDeleted(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsDeleted }
//#UC START# *B12C875B9E52_B12C875B9E52_4991887A031F_Word_var*
//#UC END# *B12C875B9E52_B12C875B9E52_4991887A031F_Word_var*
begin
//#UC START# *B12C875B9E52_B12C875B9E52_4991887A031F_Word_impl*
 Result := aFilterNode.DeletedStatus;
//#UC END# *B12C875B9E52_B12C875B9E52_4991887A031F_Word_impl*
end;//TkwFilterNodeIsDeleted.IsDeleted

class function TkwFilterNodeIsDeleted.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsDeleted';
end;//TkwFilterNodeIsDeleted.GetWordNameForRegister

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

procedure TkwFilterNodeIsDeleted.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsDeleted', aCtx);
end;//TkwFilterNodeIsDeleted.SetValuePrim

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

function TkwFilterNodeIsChangeable.IsChangeable(const aCtx: TtfwContext;
 const aFilterNode: InsFilterNode): Boolean;
 {* Реализация слова скрипта FilterNode:IsChangeable }
//#UC START# *CA5586C3178F_CA5586C3178F_4991887A031F_Word_var*
var
 l_F: IFilterFromQuery;
//#UC END# *CA5586C3178F_CA5586C3178F_4991887A031F_Word_var*
begin
//#UC START# *CA5586C3178F_CA5586C3178F_4991887A031F_Word_impl*
 Supports(aFilterNode, IFilterFromQuery, l_F);
 RunnerAssert(Assigned(l_F), 'Что-то не так с фильтром.', aCtx);
 try
  Result := l_F.GetChangeable;
 finally
  l_F := nil;
 end;//try..finally
//#UC END# *CA5586C3178F_CA5586C3178F_4991887A031F_Word_impl*
end;//TkwFilterNodeIsChangeable.IsChangeable

class function TkwFilterNodeIsChangeable.GetWordNameForRegister: AnsiString;
begin
 Result := 'FilterNode:IsChangeable';
end;//TkwFilterNodeIsChangeable.GetWordNameForRegister

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

procedure TkwFilterNodeIsChangeable.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsChangeable', aCtx);
end;//TkwFilterNodeIsChangeable.SetValuePrim

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

class function TInsFilterNodeWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'InsFilterNodeWordsPack';
end;//TInsFilterNodeWordsPackResNameGetter.ResName

 {$R InsFilterNodeWordsPack.res}

initialization
 TkwFilterNodeAutoApplied.RegisterInEngine;
 {* Регистрация FilterNode_AutoApplied }
 TkwFilterNodeIsUsed.RegisterInEngine;
 {* Регистрация FilterNode_IsUsed }
 TkwFilterNodeIsDeleted.RegisterInEngine;
 {* Регистрация FilterNode_IsDeleted }
 TkwFilterNodeIsChangeable.RegisterInEngine;
 {* Регистрация FilterNode_IsChangeable }
 TInsFilterNodeWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(InsFilterNode));
 {* Регистрация типа InsFilterNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings) AND NOT Defined(NoScripts)

end.
