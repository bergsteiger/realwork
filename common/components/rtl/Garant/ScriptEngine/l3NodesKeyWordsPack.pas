unit l3NodesKeyWordsPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\l3NodesKeyWordsPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "l3NodesKeyWordsPack" MUID: (54EF449A0213)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3Interfaces
 , l3TreeInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwTypeInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwNodeIsFirst = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:IsFirst }
  private
   function IsFirst(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Boolean;
    {* Реализация слова скрипта Node:IsFirst }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeIsFirst

 TkwNodeIsLast = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:IsLast }
  private
   function IsLast(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Boolean;
    {* Реализация слова скрипта Node:IsLast }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeIsLast

 TkwNodeFlags = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Flags }
  private
   function Flags(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Integer;
    {* Реализация слова скрипта Node:Flags }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeFlags

 TkwNodeText = {final} class(TtfwPropertyLike)
  {* Слово скрипта Node:Text }
  private
   function Text(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Tl3WString;
    {* Реализация слова скрипта Node:Text }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwNodeText

 Tl3NodesKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//Tl3NodesKeyWordsPackResNameGetter

function TkwNodeIsFirst.IsFirst(const aCtx: TtfwContext;
 const aNode: Il3SimpleNode): Boolean;
 {* Реализация слова скрипта Node:IsFirst }
begin
 Result := aNode.IsFirst;
end;//TkwNodeIsFirst.IsFirst

procedure TkwNodeIsFirst.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3SimpleNode;
begin
 try
  l_aNode := Il3SimpleNode(aCtx.rEngine.PopIntf(Il3SimpleNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3SimpleNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsFirst(aCtx, l_aNode));
end;//TkwNodeIsFirst.DoDoIt

class function TkwNodeIsFirst.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:IsFirst';
end;//TkwNodeIsFirst.GetWordNameForRegister

function TkwNodeIsFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwNodeIsFirst.GetResultTypeInfo

function TkwNodeIsFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIsFirst.GetAllParamsCount

function TkwNodeIsFirst.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeIsFirst.ParamsTypes

procedure TkwNodeIsFirst.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFirst', aCtx);
end;//TkwNodeIsFirst.SetValuePrim

function TkwNodeIsLast.IsLast(const aCtx: TtfwContext;
 const aNode: Il3SimpleNode): Boolean;
 {* Реализация слова скрипта Node:IsLast }
begin
 Result := aNode.IsLast;
end;//TkwNodeIsLast.IsLast

procedure TkwNodeIsLast.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3SimpleNode;
begin
 try
  l_aNode := Il3SimpleNode(aCtx.rEngine.PopIntf(Il3SimpleNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3SimpleNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsLast(aCtx, l_aNode));
end;//TkwNodeIsLast.DoDoIt

class function TkwNodeIsLast.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:IsLast';
end;//TkwNodeIsLast.GetWordNameForRegister

function TkwNodeIsLast.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwNodeIsLast.GetResultTypeInfo

function TkwNodeIsLast.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeIsLast.GetAllParamsCount

function TkwNodeIsLast.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeIsLast.ParamsTypes

procedure TkwNodeIsLast.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsLast', aCtx);
end;//TkwNodeIsLast.SetValuePrim

function TkwNodeFlags.Flags(const aCtx: TtfwContext;
 const aNode: Il3SimpleNode): Integer;
 {* Реализация слова скрипта Node:Flags }
begin
 Result := aNode.Flags;
end;//TkwNodeFlags.Flags

procedure TkwNodeFlags.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3SimpleNode;
begin
 try
  l_aNode := Il3SimpleNode(aCtx.rEngine.PopIntf(Il3SimpleNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3SimpleNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt(Flags(aCtx, l_aNode));
end;//TkwNodeFlags.DoDoIt

class function TkwNodeFlags.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Flags';
end;//TkwNodeFlags.GetWordNameForRegister

function TkwNodeFlags.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwNodeFlags.GetResultTypeInfo

function TkwNodeFlags.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeFlags.GetAllParamsCount

function TkwNodeFlags.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeFlags.ParamsTypes

procedure TkwNodeFlags.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Flags', aCtx);
end;//TkwNodeFlags.SetValuePrim

function TkwNodeText.Text(const aCtx: TtfwContext;
 const aNode: Il3SimpleNode): Tl3WString;
 {* Реализация слова скрипта Node:Text }
begin
 Result := aNode.Text;
end;//TkwNodeText.Text

procedure TkwNodeText.DoDoIt(const aCtx: TtfwContext);
var l_aNode: Il3SimpleNode;
begin
 try
  l_aNode := Il3SimpleNode(aCtx.rEngine.PopIntf(Il3SimpleNode));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNode: Il3SimpleNode : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushString(Text(aCtx, l_aNode));
end;//TkwNodeText.DoDoIt

class function TkwNodeText.GetWordNameForRegister: AnsiString;
begin
 Result := 'Node:Text';
end;//TkwNodeText.GetWordNameForRegister

function TkwNodeText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiString;
end;//TkwNodeText.GetResultTypeInfo

function TkwNodeText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwNodeText.GetAllParamsCount

function TkwNodeText.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeText.ParamsTypes

procedure TkwNodeText.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwNodeText.SetValuePrim

class function Tl3NodesKeyWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'l3NodesKeyWordsPack';
end;//Tl3NodesKeyWordsPackResNameGetter.ResName

 {$R l3NodesKeyWordsPack.res}

initialization
 TkwNodeIsFirst.RegisterInEngine;
 {* Регистрация Node_IsFirst }
 TkwNodeIsLast.RegisterInEngine;
 {* Регистрация Node_IsLast }
 TkwNodeFlags.RegisterInEngine;
 {* Регистрация Node_Flags }
 TkwNodeText.RegisterInEngine;
 {* Регистрация Node_Text }
 Tl3NodesKeyWordsPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
 {* Регистрация типа Il3SimpleNode }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* Регистрация типа Boolean }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* Регистрация типа Tl3WString }
{$IfEnd} // NOT Defined(NoScripts)

end.
