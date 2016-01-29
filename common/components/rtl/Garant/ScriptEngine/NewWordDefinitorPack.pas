unit NewWordDefinitorPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Axiomatics"
// Модуль: "NewWordDefinitorPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Words RTTI::NewWordDefinitorPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  kwCompiledVar,
  tfwClassLike,
  tfwPropertyLike
  ;

type
 TkwGlobalVar = class(TkwCompiledVar)
 public
 // overridden public methods
   function CanClearInRecursiveCalls: Boolean; override;
   function IsForHelp: Boolean; override;
 end;//TkwGlobalVar
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
 TkwPopNewWordDefinitorCheckWord = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckWord
*Тип результата:* TtfwKeyWord
*Пример:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aNewWordDefinitor pop:NewWordDefinitor:CheckWord >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function CheckWord(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    const aName: Il3CString): TtfwKeyWord;
     {* Реализация слова скрипта pop:NewWordDefinitor:CheckWord }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorCheckWord

// start class TkwPopNewWordDefinitorCheckWord

function TkwPopNewWordDefinitorCheckWord.CheckWord(const aCtx: TtfwContext;
  aNewWordDefinitor: TtfwNewWordDefinitor;
  const aName: Il3CString): TtfwKeyWord;
 {-}
begin
 Result := aNewWordDefinitor.CheckWord(aName);
end;//TkwPopNewWordDefinitorCheckWord.CheckWord

procedure TkwPopNewWordDefinitorCheckWord.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewWordDefinitor : TtfwNewWordDefinitor;
 l_aName : Il3CString;
begin
 try
  l_aNewWordDefinitor := TtfwNewWordDefinitor(aCtx.rEngine.PopObjAs(TtfwNewWordDefinitor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewWordDefinitor: TtfwNewWordDefinitor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CheckWord(aCtx, l_aNewWordDefinitor, l_aName)));
end;//TkwPopNewWordDefinitorCheckWord.DoDoIt

class function TkwPopNewWordDefinitorCheckWord.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:NewWordDefinitor:CheckWord';
end;//TkwPopNewWordDefinitorCheckWord.GetWordNameForRegister

function TkwPopNewWordDefinitorCheckWord.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopNewWordDefinitorCheckWord.GetResultTypeInfo

function TkwPopNewWordDefinitorCheckWord.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopNewWordDefinitorCheckWord.GetAllParamsCount

function TkwPopNewWordDefinitorCheckWord.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwNewWordDefinitor), @tfw_tiString]);
end;//TkwPopNewWordDefinitorCheckWord.ParamsTypes

type
 TkwPopNewWordDefinitorCheckVar = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:CheckVar
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aName aLocal aNewWordDefinitor pop:NewWordDefinitor:CheckVar >>> l_TtfwWord
[code]  }
 private
 // private methods
   function CheckVar(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    aLocal: Boolean;
    const aName: Il3CString): TtfwWord;
     {* Реализация слова скрипта pop:NewWordDefinitor:CheckVar }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorCheckVar

// start class TkwPopNewWordDefinitorCheckVar

function TkwPopNewWordDefinitorCheckVar.CheckVar(const aCtx: TtfwContext;
  aNewWordDefinitor: TtfwNewWordDefinitor;
  aLocal: Boolean;
  const aName: Il3CString): TtfwWord;
//#UC START# *D57528D8717B_0518A66C4F49_var*
var
 l_KW : TtfwKeyWord;
 l_W : TtfwWord;
//#UC END# *D57528D8717B_0518A66C4F49_var*
begin
//#UC START# *D57528D8717B_0518A66C4F49_impl*
 l_KW := aNewWordDefinitor.CheckWord(aName);
 l_W := l_KW.Word;
 if (l_W = nil) then
 begin
  if aLocal then
   l_W := TkwCompiledVar.Create(Self,
                                aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                                aCtx.rTypeInfo,
                                aCtx,
                                l_KW)
  else
   l_W := TkwGlobalVar.Create(Self,
                              aNewWordDefinitor.KeywordFinder(aCtx){PrevFinder},
                              aCtx.rTypeInfo,
                              aCtx,
                              l_KW);
  try
   l_KW.SetWord(aCtx, l_W);
   Result := l_W;
  finally
   FreeAndNil(l_W);
  end;//try..finally
 end//l_W = nil
 else
  Result := l_W;
//#UC END# *D57528D8717B_0518A66C4F49_impl*
end;//TkwPopNewWordDefinitorCheckVar.CheckVar

procedure TkwPopNewWordDefinitorCheckVar.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewWordDefinitor : TtfwNewWordDefinitor;
 l_aLocal : Boolean;
 l_aName : Il3CString;
begin
 try
  l_aNewWordDefinitor := TtfwNewWordDefinitor(aCtx.rEngine.PopObjAs(TtfwNewWordDefinitor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewWordDefinitor: TtfwNewWordDefinitor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLocal := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLocal: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((CheckVar(aCtx, l_aNewWordDefinitor, l_aLocal, l_aName)));
end;//TkwPopNewWordDefinitorCheckVar.DoDoIt

class function TkwPopNewWordDefinitorCheckVar.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:NewWordDefinitor:CheckVar';
end;//TkwPopNewWordDefinitorCheckVar.GetWordNameForRegister

function TkwPopNewWordDefinitorCheckVar.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopNewWordDefinitorCheckVar.GetResultTypeInfo

function TkwPopNewWordDefinitorCheckVar.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwPopNewWordDefinitorCheckVar.GetAllParamsCount

function TkwPopNewWordDefinitorCheckVar.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwNewWordDefinitor), TypeInfo(Boolean), @tfw_tiString]);
end;//TkwPopNewWordDefinitorCheckVar.ParamsTypes

type
 TkwPopNewWordDefinitorDefineInParameter = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта pop:NewWordDefinitor:DefineInParameter
*Тип результата:* TtfwWord
*Пример:*
[code]
OBJECT VAR l_TtfwWord
 aStereo aParamName aNewWordDefinitor pop:NewWordDefinitor:DefineInParameter >>> l_TtfwWord
[code]  }
 private
 // private methods
   function DefineInParameter(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor;
    const aParamName: Il3CString;
    aStereo: TtfwWord): TtfwWord;
     {* Реализация слова скрипта pop:NewWordDefinitor:DefineInParameter }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopNewWordDefinitorDefineInParameter

// start class TkwPopNewWordDefinitorDefineInParameter

function TkwPopNewWordDefinitorDefineInParameter.DefineInParameter(const aCtx: TtfwContext;
  aNewWordDefinitor: TtfwNewWordDefinitor;
  const aParamName: Il3CString;
  aStereo: TtfwWord): TtfwWord;
//#UC START# *B2F36CF00AB7_CDFCC0A90AF7_var*
//#UC END# *B2F36CF00AB7_CDFCC0A90AF7_var*
begin
//#UC START# *B2F36CF00AB7_CDFCC0A90AF7_impl*
 Result := aNewWordDefinitor.DefineInParameter(aCtx, aParamName, aStereo, aCtx.rTypeInfo);
//#UC END# *B2F36CF00AB7_CDFCC0A90AF7_impl*
end;//TkwPopNewWordDefinitorDefineInParameter.DefineInParameter

procedure TkwPopNewWordDefinitorDefineInParameter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewWordDefinitor : TtfwNewWordDefinitor;
 l_aParamName : Il3CString;
 l_aStereo : TtfwWord;
begin
 try
  l_aNewWordDefinitor := TtfwNewWordDefinitor(aCtx.rEngine.PopObjAs(TtfwNewWordDefinitor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewWordDefinitor: TtfwNewWordDefinitor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aParamName := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aParamName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aStereo := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord, true));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aStereo: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((DefineInParameter(aCtx, l_aNewWordDefinitor, l_aParamName, l_aStereo)));
end;//TkwPopNewWordDefinitorDefineInParameter.DoDoIt

class function TkwPopNewWordDefinitorDefineInParameter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:NewWordDefinitor:DefineInParameter';
end;//TkwPopNewWordDefinitorDefineInParameter.GetWordNameForRegister

function TkwPopNewWordDefinitorDefineInParameter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwWord);
end;//TkwPopNewWordDefinitorDefineInParameter.GetResultTypeInfo

function TkwPopNewWordDefinitorDefineInParameter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 2 + 1;
end;//TkwPopNewWordDefinitorDefineInParameter.GetAllParamsCount

function TkwPopNewWordDefinitorDefineInParameter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwNewWordDefinitor), @tfw_tiString, TypeInfo(TtfwWord)]);
end;//TkwPopNewWordDefinitorDefineInParameter.ParamsTypes

type
 TkwPopNewWordDefinitorKeywordFinder = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта pop:NewWordDefinitor:KeywordFinder
*Тип результата:* TtfwKeywordFinder
*Пример:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aNewWordDefinitor pop:NewWordDefinitor:KeywordFinder >>> l_TtfwKeywordFinder
[code]  }
 private
 // private methods
   function KeywordFinder(const aCtx: TtfwContext;
    aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
     {* Реализация слова скрипта pop:NewWordDefinitor:KeywordFinder }
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
 end;//TkwPopNewWordDefinitorKeywordFinder

// start class TkwPopNewWordDefinitorKeywordFinder

function TkwPopNewWordDefinitorKeywordFinder.KeywordFinder(const aCtx: TtfwContext;
  aNewWordDefinitor: TtfwNewWordDefinitor): TtfwKeywordFinder;
//#UC START# *2EA08C0CC8B4_C919B8A4B92C_var*
//#UC END# *2EA08C0CC8B4_C919B8A4B92C_var*
begin
//#UC START# *2EA08C0CC8B4_C919B8A4B92C_impl*
 Result := aNewWordDefinitor.KeywordFinder(aCtx);
//#UC END# *2EA08C0CC8B4_C919B8A4B92C_impl*
end;//TkwPopNewWordDefinitorKeywordFinder.KeywordFinder

procedure TkwPopNewWordDefinitorKeywordFinder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aNewWordDefinitor : TtfwNewWordDefinitor;
begin
 try
  l_aNewWordDefinitor := TtfwNewWordDefinitor(aCtx.rEngine.PopObjAs(TtfwNewWordDefinitor));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aNewWordDefinitor: TtfwNewWordDefinitor : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((KeywordFinder(aCtx, l_aNewWordDefinitor)));
end;//TkwPopNewWordDefinitorKeywordFinder.DoDoIt

class function TkwPopNewWordDefinitorKeywordFinder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:NewWordDefinitor:KeywordFinder';
end;//TkwPopNewWordDefinitorKeywordFinder.GetWordNameForRegister

procedure TkwPopNewWordDefinitorKeywordFinder.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству KeywordFinder', aCtx);
end;//TkwPopNewWordDefinitorKeywordFinder.SetValuePrim

function TkwPopNewWordDefinitorKeywordFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopNewWordDefinitorKeywordFinder.GetResultTypeInfo

function TkwPopNewWordDefinitorKeywordFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopNewWordDefinitorKeywordFinder.GetAllParamsCount

function TkwPopNewWordDefinitorKeywordFinder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwNewWordDefinitor)]);
end;//TkwPopNewWordDefinitorKeywordFinder.ParamsTypes
// start class TkwGlobalVar

function TkwGlobalVar.CanClearInRecursiveCalls: Boolean;
//#UC START# *559A470F0288_559A4C070092_var*
//#UC END# *559A470F0288_559A4C070092_var*
begin
//#UC START# *559A470F0288_559A4C070092_impl*
 Result := false;
//#UC END# *559A470F0288_559A4C070092_impl*
end;//TkwGlobalVar.CanClearInRecursiveCalls

function TkwGlobalVar.IsForHelp: Boolean;
//#UC START# *55C399C9009B_559A4C070092_var*
//#UC END# *55C399C9009B_559A4C070092_var*
begin
//#UC START# *55C399C9009B_559A4C070092_impl*
 Result := false;
//#UC END# *55C399C9009B_559A4C070092_impl*
end;//TkwGlobalVar.IsForHelp
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwGlobalVar
 TkwGlobalVar.RegisterClass;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация pop_NewWordDefinitor_CheckWord
 TkwPopNewWordDefinitorCheckWord.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация pop_NewWordDefinitor_CheckVar
 TkwPopNewWordDefinitorCheckVar.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация pop_NewWordDefinitor_DefineInParameter
 TkwPopNewWordDefinitorDefineInParameter.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация pop_NewWordDefinitor_KeywordFinder
 TkwPopNewWordDefinitorKeywordFinder.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwNewWordDefinitor
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwNewWordDefinitor));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwKeyWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwKeywordFinder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
{$IfEnd} //not NoScripts

end.