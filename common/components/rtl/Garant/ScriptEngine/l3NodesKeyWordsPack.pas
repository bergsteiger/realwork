unit l3NodesKeyWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$L3"
// Модуль: "l3NodesKeyWordsPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$L3::l3SimpleNodeWords::l3NodesKeyWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  l3TreeInterfaces,
  tfwScriptingInterfaces,
  tfwAxiomaticsResNameGetter,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
//#UC START# *FCED2C4D2DBAci*
//#UC END# *FCED2C4D2DBAci*
//#UC START# *FCED2C4D2DBAcit*
//#UC END# *FCED2C4D2DBAcit*
 Tl3NodesKeyWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *FCED2C4D2DBApubl*
//#UC END# *FCED2C4D2DBApubl*
 end;//Tl3NodesKeyWordsPackResNameGetter

// start class Tl3NodesKeyWordsPackResNameGetter

class function Tl3NodesKeyWordsPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'l3NodesKeyWordsPack';
end;//Tl3NodesKeyWordsPackResNameGetter.ResName

 {$R l3NodesKeyWordsPack.res}

type
 TkwNodeIsFirst = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта Node:IsFirst
[panel]Узел первый?[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsFirst >>> l_Boolean
[code]  }
 private
 // private methods
   function IsFirst(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Boolean;
     {* Реализация слова скрипта Node:IsFirst }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIsFirst

// start class TkwNodeIsFirst

function TkwNodeIsFirst.IsFirst(const aCtx: TtfwContext;
  const aNode: Il3SimpleNode): Boolean;
 {-}
begin
 Result := aNode.IsFirst;
end;//TkwNodeIsFirst.IsFirst

procedure TkwNodeIsFirst.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3SimpleNode;
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
 aCtx.rEngine.PushBool((IsFirst(aCtx, l_aNode)));
end;//TkwNodeIsFirst.DoDoIt

class function TkwNodeIsFirst.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:IsFirst';
end;//TkwNodeIsFirst.GetWordNameForRegister

procedure TkwNodeIsFirst.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsFirst', aCtx);
end;//TkwNodeIsFirst.SetValuePrim

function TkwNodeIsFirst.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwNodeIsFirst.GetResultTypeInfo

function TkwNodeIsFirst.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeIsFirst.GetAllParamsCount

function TkwNodeIsFirst.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeIsFirst.ParamsTypes

type
 TkwNodeIsLast = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта Node:IsLast
[panel]Узел последний?[panel]
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsLast >>> l_Boolean
[code]  }
 private
 // private methods
   function IsLast(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Boolean;
     {* Реализация слова скрипта Node:IsLast }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeIsLast

// start class TkwNodeIsLast

function TkwNodeIsLast.IsLast(const aCtx: TtfwContext;
  const aNode: Il3SimpleNode): Boolean;
 {-}
begin
 Result := aNode.IsLast;
end;//TkwNodeIsLast.IsLast

procedure TkwNodeIsLast.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3SimpleNode;
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
 aCtx.rEngine.PushBool((IsLast(aCtx, l_aNode)));
end;//TkwNodeIsLast.DoDoIt

class function TkwNodeIsLast.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:IsLast';
end;//TkwNodeIsLast.GetWordNameForRegister

procedure TkwNodeIsLast.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству IsLast', aCtx);
end;//TkwNodeIsLast.SetValuePrim

function TkwNodeIsLast.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Boolean);
end;//TkwNodeIsLast.GetResultTypeInfo

function TkwNodeIsLast.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeIsLast.GetAllParamsCount

function TkwNodeIsLast.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeIsLast.ParamsTypes

type
 TkwNodeFlags = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта Node:Flags
[panel]Флаги узла[panel]
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aNode Node:Flags >>> l_Integer
[code]  }
 private
 // private methods
   function Flags(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Integer;
     {* Реализация слова скрипта Node:Flags }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeFlags

// start class TkwNodeFlags

function TkwNodeFlags.Flags(const aCtx: TtfwContext;
  const aNode: Il3SimpleNode): Integer;
 {-}
begin
 Result := aNode.Flags;
end;//TkwNodeFlags.Flags

procedure TkwNodeFlags.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3SimpleNode;
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
 aCtx.rEngine.PushInt((Flags(aCtx, l_aNode)));
end;//TkwNodeFlags.DoDoIt

class function TkwNodeFlags.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:Flags';
end;//TkwNodeFlags.GetWordNameForRegister

procedure TkwNodeFlags.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Flags', aCtx);
end;//TkwNodeFlags.SetValuePrim

function TkwNodeFlags.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwNodeFlags.GetResultTypeInfo

function TkwNodeFlags.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeFlags.GetAllParamsCount

function TkwNodeFlags.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeFlags.ParamsTypes

type
 TkwNodeText = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта Node:Text
[panel]Текст узла[panel]
*Тип результата:* Tl3WString
*Пример:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Text >>> l_Tl3WString
[code]  }
 private
 // private methods
   function Text(const aCtx: TtfwContext;
    const aNode: Il3SimpleNode): Tl3WString;
     {* Реализация слова скрипта Node:Text }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwNodeText

// start class TkwNodeText

function TkwNodeText.Text(const aCtx: TtfwContext;
  const aNode: Il3SimpleNode): Tl3WString;
 {-}
begin
 Result := aNode.Text;
end;//TkwNodeText.Text

procedure TkwNodeText.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNode : Il3SimpleNode;
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
 aCtx.rEngine.PushString((Text(aCtx, l_aNode)));
end;//TkwNodeText.DoDoIt

class function TkwNodeText.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Node:Text';
end;//TkwNodeText.GetWordNameForRegister

procedure TkwNodeText.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Text', aCtx);
end;//TkwNodeText.SetValuePrim

function TkwNodeText.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiString;
end;//TkwNodeText.GetResultTypeInfo

function TkwNodeText.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwNodeText.GetAllParamsCount

function TkwNodeText.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Il3SimpleNode)]);
end;//TkwNodeText.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 Tl3NodesKeyWordsPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Node_IsFirst
 TkwNodeIsFirst.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Node_IsLast
 TkwNodeIsLast.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Node_Flags
 TkwNodeFlags.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Node_Text
 TkwNodeText.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Il3SimpleNode
 TtfwTypeRegistrator.RegisterType(TypeInfo(Il3SimpleNode));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Tl3WString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts

end.