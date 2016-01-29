unit ArrayProcessingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "ScriptEngine$Axiomatics"
// Модуль: "ArrayProcessingPack.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::ArrayProcessing::ArrayProcessingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwBeginLikeWord,
  kwCloseBracket,
  kwBeginLikeCompiledCode,
  tfwRegisterableWord,
  tfwAxiomaticsResNameGetter,
  tfwTypeInfo,
  tfwClassLike,
  tfwPropertyLike,
  l3PureMixIns
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwArray,
  SysUtils,
  kwCompiledWordPrim,
  tfwRevertedArrayView,
  tfwFilteredArrayView,
  tfwMappedArrayView,
  tfwIteratorFromFunctor,
  tfwJoinIterator,
  tfwTruncatedArrayView,
  tfwSliceView,
  tfwScriptingTypes,
  TypInfo,
  tfwTypeRegistrator
  ;

type
 TkwCompiledArray = class(TkwBeginLikeCompiledCode)
 protected
 // overridden property methods
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
 protected
 // overridden protected methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwCompiledArray

 TkwOpenArray = {final scriptword} class(TtfwBeginLikeWord)
 protected
 // realized methods
   function EndBracket(const aContext: TtfwContext;
     aSilent: Boolean): RtfwWord; override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
 end;//TkwOpenArray

  TkwCloseArray = {final scriptword} class(TkwCloseBracket)
  protected
  // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
  end;//TkwCloseArray

// start class TkwCloseArray

class function TkwCloseArray.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := ']';
end;//TkwCloseArray.GetWordNameForRegister
// start class TkwCompiledArray

procedure TkwCompiledArray.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_52EB991C028F_var*
var
 l_A : TtfwArray;
 l_VC : Integer;
// l_V : TtfwStackValue;
//#UC END# *4DAEEDE10285_52EB991C028F_var*
begin
//#UC START# *4DAEEDE10285_52EB991C028F_impl*
 l_VC := aCtx.rEngine.ValuesCount;
 inherited;
 l_VC := aCtx.rEngine.ValuesCount - l_VC;
 RunnerAssert(l_VC >= 0, 'Со стека забрали лишние значения', aCtx);
 l_A := TtfwArray.Create;
 try
  try
   l_A.Count := l_VC;
   while (l_VC > 0) do
   begin
    Dec(l_VC);
    l_A.ItemSlot(l_VC)^ := aCtx.rEngine.Top^;
    aCtx.rEngine.Drop;
   end;//while l_VC > 0
  finally
   aCtx.rEngine.PushList(l_A);
  end;//try..finally
 finally
  FreeAndNil(l_A);
 end;//try..finally
(* aCtx.rEngine.PushBracket;
 inherited;
 l_A := TtfwArray.Create;
 try
  try
   while true do
   begin
    l_V := aCtx.rEngine.Pop;
    if l_V.IsBracket then
     break;
    l_A.Insert(0, l_V);
   end;//while true
  finally
   aCtx.rEngine.PushList(l_A);
  end;//try..finally
 finally
  FreeAndNil(l_A);
 end;//try..finally*)
//#UC END# *4DAEEDE10285_52EB991C028F_impl*
end;//TkwCompiledArray.DoDoIt

function TkwCompiledArray.pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo;
//#UC START# *52CFC11603C8_52EB991C028Fget_var*
//#UC END# *52CFC11603C8_52EB991C028Fget_var*
begin
//#UC START# *52CFC11603C8_52EB991C028Fget_impl*
 Result := TtfwWordInfo.Make(GetResultTypeInfo(aCtx));
//#UC END# *52CFC11603C8_52EB991C028Fget_impl*
end;//TkwCompiledArray.pm_GetResultTypeInfo

function TkwCompiledArray.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_52EB991C028F_var*
//#UC END# *551544E2001A_52EB991C028F_var*
begin
//#UC START# *551544E2001A_52EB991C028F_impl*
 Result := TypeInfo(ItfwValueList);
//#UC END# *551544E2001A_52EB991C028F_impl*
end;//TkwCompiledArray.GetResultTypeInfo

function TkwOpenArray.EndBracket(const aContext: TtfwContext;
  aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F5037E30231_var*
//#UC END# *4DB6C99F026E_4F5037E30231_var*
begin
//#UC START# *4DB6C99F026E_4F5037E30231_impl*
 Result := TkwCloseArray;
//#UC END# *4DB6C99F026E_4F5037E30231_impl*
end;//TkwOpenArray.EndBracket

class function TkwOpenArray.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '[';
end;//TkwOpenArray.GetWordNameForRegister

function TkwOpenArray.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F5037E30231_var*
//#UC END# *4DBAEE0D028D_4F5037E30231_var*
begin
//#UC START# *4DBAEE0D028D_4F5037E30231_impl*
 Result := TkwCompiledArray;
//#UC END# *4DBAEE0D028D_4F5037E30231_impl*
end;//TkwOpenArray.CompiledWordClass

type
//#UC START# *DB8D8DCA5554ci*
//#UC END# *DB8D8DCA5554ci*
//#UC START# *DB8D8DCA5554cit*
//#UC END# *DB8D8DCA5554cit*
 TArrayProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
 public
 // realized methods
   class function ResName: AnsiString; override;
//#UC START# *DB8D8DCA5554publ*
//#UC END# *DB8D8DCA5554publ*
 end;//TArrayProcessingPackResNameGetter

// start class TArrayProcessingPackResNameGetter

class function TArrayProcessingPackResNameGetter.ResName: AnsiString;
 {-}
begin
 Result := 'ArrayProcessingPack';
end;//TArrayProcessingPackResNameGetter.ResName

 {$R ArrayProcessingPack.res}

type
 TkwArrayClear = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Clear
*Пример:*
[code]
 aArray Array:Clear
[code]  }
 private
 // private methods
   procedure Clear(const aCtx: TtfwContext;
    const aArray: ItfwValueList);
     {* Реализация слова скрипта Array:Clear }
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
 end;//TkwArrayClear

// start class TkwArrayClear

procedure TkwArrayClear.Clear(const aCtx: TtfwContext;
  const aArray: ItfwValueList);
 {-}
begin
 aArray.Clear;
end;//TkwArrayClear.Clear

procedure TkwArrayClear.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Clear(aCtx, l_aArray);
end;//TkwArrayClear.DoDoIt

class function TkwArrayClear.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Clear';
end;//TkwArrayClear.GetWordNameForRegister

function TkwArrayClear.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwArrayClear.GetResultTypeInfo

function TkwArrayClear.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwArrayClear.GetAllParamsCount

function TkwArrayClear.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayClear.ParamsTypes

type
 TkwArrayItem = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Item
*Тип результата:* TtfwStackValue
*Пример:*
[code]
VAR l_TtfwStackValue
 anIndex aArray Array:Item >>> l_TtfwStackValue
[code]  }
 private
 // private methods
   function Item(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    anIndex: Integer): TtfwStackValue;
     {* Реализация слова скрипта Array:Item }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
   function BindParams: Boolean; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 protected
 // protected methods
   class procedure DoSetValue(const aArray: ItfwValueList;
    anIndex: Integer;
    const aValue: TtfwStackValue);
     {* Метод установки значения свойства Item }
 end;//TkwArrayItem

// start class TkwArrayItem

function TkwArrayItem.Item(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  anIndex: Integer): TtfwStackValue;
//#UC START# *66E011EC054E_E14E90E5EF2D_var*
//#UC END# *66E011EC054E_E14E90E5EF2D_var*
begin
//#UC START# *66E011EC054E_E14E90E5EF2D_impl*
 RunnerAssert(anIndex >= 0, 'Мне нужно положительное число.', aCtx);
 RunnerAssert(anIndex < aArray.Count, 'В массиве нет столько элементов.', aCtx);
 Result := aArray.Items[anIndex];
//#UC END# *66E011EC054E_E14E90E5EF2D_impl*
end;//TkwArrayItem.Item

class procedure TkwArrayItem.DoSetValue(const aArray: ItfwValueList;
  anIndex: Integer;
  const aValue: TtfwStackValue);
//#UC START# *2550EECFAAC1_E14E90E5EF2D_var*
//#UC END# *2550EECFAAC1_E14E90E5EF2D_var*
begin
//#UC START# *2550EECFAAC1_E14E90E5EF2D_impl*
 //RunnerAssert(anIndex >= 0, 'Мне нужно положительное число.', aCtx);
 //RunnerAssert(anIndex < aArray.Count, 'В массиве нет столько элементов.', aCtx);
 aArray.SetItem(anIndex, aValue);
//#UC END# *2550EECFAAC1_E14E90E5EF2D_impl*
end;//TkwArrayItem.DoSetValue

procedure TkwArrayItem.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_anIndex : Integer;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
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
 aCtx.rEngine.Push((Item(aCtx, l_aArray, l_anIndex)));
end;//TkwArrayItem.DoDoIt

class function TkwArrayItem.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Item';
end;//TkwArrayItem.GetWordNameForRegister

procedure TkwArrayItem.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
var
 l_Array: ItfwValueList;
 l_anIndex : Integer;
begin
 try
  l_Array := (aCtx.rEngine.PopList);
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра l_Array: ItfwValueList : ' + E.Message, aCtx);
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
 DoSetValue(l_Array, l_anIndex, (aValue));
end;//TkwArrayItem.SetValuePrim

function TkwArrayItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiStruct;
end;//TkwArrayItem.GetResultTypeInfo

function TkwArrayItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayItem.GetAllParamsCount

function TkwArrayItem.BindParams: Boolean;
 {-}
begin
 Result := true;
end;//TkwArrayItem.BindParams

function TkwArrayItem.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(Integer)]);
end;//TkwArrayItem.ParamsTypes

type
 TkwArrayReverted = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Reverted
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aArray Array:Reverted >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Reverted(const aCtx: TtfwContext;
    const aArray: ItfwValueList): ItfwValueList;
     {* Реализация слова скрипта Array:Reverted }
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
 end;//TkwArrayReverted

// start class TkwArrayReverted

function TkwArrayReverted.Reverted(const aCtx: TtfwContext;
  const aArray: ItfwValueList): ItfwValueList;
//#UC START# *155569C67894_68189B4B7D71_var*
//#UC END# *155569C67894_68189B4B7D71_var*
begin
//#UC START# *155569C67894_68189B4B7D71_impl*
 Result := TtfwRevertedArrayView.Make(aArray);
//#UC END# *155569C67894_68189B4B7D71_impl*
end;//TkwArrayReverted.Reverted

procedure TkwArrayReverted.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Reverted(aCtx, l_aArray)));
end;//TkwArrayReverted.DoDoIt

class function TkwArrayReverted.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Reverted';
end;//TkwArrayReverted.GetWordNameForRegister

function TkwArrayReverted.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayReverted.GetResultTypeInfo

function TkwArrayReverted.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwArrayReverted.GetAllParamsCount

function TkwArrayReverted.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayReverted.ParamsTypes

type
 TkwArrayFilter = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Filter
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Filter >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Filter(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
     {* Реализация слова скрипта Array:Filter }
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
 end;//TkwArrayFilter

// start class TkwArrayFilter

function TkwArrayFilter.Filter(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  aLambda: TtfwWord): ItfwValueList;
//#UC START# *781431CE844D_BE2AD2FE44CF_var*
//#UC END# *781431CE844D_BE2AD2FE44CF_var*
begin
//#UC START# *781431CE844D_BE2AD2FE44CF_impl*
 Result := TtfwFilteredArrayView.Make(aArray, aLambda);
//#UC END# *781431CE844D_BE2AD2FE44CF_impl*
end;//TkwArrayFilter.Filter

procedure TkwArrayFilter.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aLambda : TtfwWord;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Filter(aCtx, l_aArray, l_aLambda)));
end;//TkwArrayFilter.DoDoIt

class function TkwArrayFilter.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Filter';
end;//TkwArrayFilter.GetWordNameForRegister

function TkwArrayFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayFilter.GetResultTypeInfo

function TkwArrayFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayFilter.GetAllParamsCount

function TkwArrayFilter.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayFilter.ParamsTypes

type
 TkwArrayMap = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Map
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Map >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Map(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
     {* Реализация слова скрипта Array:Map }
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
 end;//TkwArrayMap

// start class TkwArrayMap

function TkwArrayMap.Map(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  aLambda: TtfwWord): ItfwValueList;
//#UC START# *7FA64661B5E5_4D82A8E4E72B_var*
//#UC END# *7FA64661B5E5_4D82A8E4E72B_var*
begin
//#UC START# *7FA64661B5E5_4D82A8E4E72B_impl*
 Result := TtfwMappedArrayView.Make(aArray, aLambda);
//#UC END# *7FA64661B5E5_4D82A8E4E72B_impl*
end;//TkwArrayMap.Map

procedure TkwArrayMap.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aLambda : TtfwWord;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Map(aCtx, l_aArray, l_aLambda)));
end;//TkwArrayMap.DoDoIt

class function TkwArrayMap.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Map';
end;//TkwArrayMap.GetWordNameForRegister

function TkwArrayMap.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayMap.GetResultTypeInfo

function TkwArrayMap.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayMap.GetAllParamsCount

function TkwArrayMap.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayMap.ParamsTypes

type
 TkwArrayIterate = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Iterate
*Пример:*
[code]
 aLambda aArray Array:Iterate
[code]  }
 private
 // private methods
   procedure Iterate(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord);
     {* Реализация слова скрипта Array:Iterate }
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
 end;//TkwArrayIterate

// start class TkwArrayIterate

procedure TkwArrayIterate.Iterate(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  aLambda: TtfwWord);
//#UC START# *78836988FFF5_67F9FD4545C9_var*
//#UC END# *78836988FFF5_67F9FD4545C9_var*
begin
//#UC START# *78836988FFF5_67F9FD4545C9_impl*
 aArray.ForEach(aLambda, aCtx);
//#UC END# *78836988FFF5_67F9FD4545C9_impl*
end;//TkwArrayIterate.Iterate

procedure TkwArrayIterate.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aLambda : TtfwWord;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Iterate(aCtx, l_aArray, l_aLambda);
end;//TkwArrayIterate.DoDoIt

class function TkwArrayIterate.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Iterate';
end;//TkwArrayIterate.GetWordNameForRegister

function TkwArrayIterate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwArrayIterate.GetResultTypeInfo

function TkwArrayIterate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayIterate.GetAllParamsCount

function TkwArrayIterate.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayIterate.ParamsTypes

type
 TkwArrayAdd = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Add
*Пример:*
[code]
 aValue aArray Array:Add
[code]  }
 private
 // private methods
   procedure Add(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const aValue: TtfwStackValue);
     {* Реализация слова скрипта Array:Add }
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
 end;//TkwArrayAdd

// start class TkwArrayAdd

procedure TkwArrayAdd.Add(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  const aValue: TtfwStackValue);
 {-}
begin
 aArray.Add(aValue);
end;//TkwArrayAdd.Add

procedure TkwArrayAdd.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aValue : TtfwStackValue;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aValue := aCtx.rEngine.Pop;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aValue: TtfwStackValue : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 Add(aCtx, l_aArray, l_aValue);
end;//TkwArrayAdd.DoDoIt

class function TkwArrayAdd.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Add';
end;//TkwArrayAdd.GetWordNameForRegister

function TkwArrayAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwArrayAdd.GetResultTypeInfo

function TkwArrayAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayAdd.GetAllParamsCount

function TkwArrayAdd.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), @tfw_tiStruct]);
end;//TkwArrayAdd.ParamsTypes

type
 TkwArrayFunctorToIterator = {final scriptword} class(TtfwRegisterableWord)
  {* Слово скрипта Array:FunctorToIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda Array:FunctorToIterator >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function FunctorToIterator(const aCtx: TtfwContext;
    aLambda: TtfwWord): ItfwValueList;
     {* Реализация слова скрипта Array:FunctorToIterator }
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
 end;//TkwArrayFunctorToIterator

// start class TkwArrayFunctorToIterator

function TkwArrayFunctorToIterator.FunctorToIterator(const aCtx: TtfwContext;
  aLambda: TtfwWord): ItfwValueList;
//#UC START# *D84558AB12E8_AC4DA64FB94F_var*
//#UC END# *D84558AB12E8_AC4DA64FB94F_var*
begin
//#UC START# *D84558AB12E8_AC4DA64FB94F_impl*
 Result := TtfwIteratorFromFunctor.Make(aLambda);
//#UC END# *D84558AB12E8_AC4DA64FB94F_impl*
end;//TkwArrayFunctorToIterator.FunctorToIterator

procedure TkwArrayFunctorToIterator.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aLambda : TtfwWord;
begin
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((FunctorToIterator(aCtx, l_aLambda)));
end;//TkwArrayFunctorToIterator.DoDoIt

class function TkwArrayFunctorToIterator.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:FunctorToIterator';
end;//TkwArrayFunctorToIterator.GetWordNameForRegister

function TkwArrayFunctorToIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayFunctorToIterator.GetResultTypeInfo

function TkwArrayFunctorToIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayFunctorToIterator.GetAllParamsCount

function TkwArrayFunctorToIterator.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwWord)]);
end;//TkwArrayFunctorToIterator.ParamsTypes

type
 TkwArrayJoin = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Join
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 anOther aArray Array:Join >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Join(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const anOther: ItfwValueList): ItfwValueList;
     {* Реализация слова скрипта Array:Join }
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
 end;//TkwArrayJoin

// start class TkwArrayJoin

function TkwArrayJoin.Join(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  const anOther: ItfwValueList): ItfwValueList;
//#UC START# *AE1CCBE76617_F83E51FB5EAA_var*
//#UC END# *AE1CCBE76617_F83E51FB5EAA_var*
begin
//#UC START# *AE1CCBE76617_F83E51FB5EAA_impl*
 Result := TtfwJoinIterator.Make(aArray, anOther);
//#UC END# *AE1CCBE76617_F83E51FB5EAA_impl*
end;//TkwArrayJoin.Join

procedure TkwArrayJoin.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_anOther : ItfwValueList;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anOther := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра anOther: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Join(aCtx, l_aArray, l_anOther)));
end;//TkwArrayJoin.DoDoIt

class function TkwArrayJoin.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Join';
end;//TkwArrayJoin.GetWordNameForRegister

function TkwArrayJoin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayJoin.GetResultTypeInfo

function TkwArrayJoin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayJoin.GetAllParamsCount

function TkwArrayJoin.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(ItfwValueList)]);
end;//TkwArrayJoin.ParamsTypes

type
 TkwArrayTrunc = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Trunc
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Trunc >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Trunc(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
     {* Реализация слова скрипта Array:Trunc }
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
 end;//TkwArrayTrunc

// start class TkwArrayTrunc

function TkwArrayTrunc.Trunc(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  aLambda: TtfwWord): ItfwValueList;
//#UC START# *3CA55B4BDAA5_BD92B7361A83_var*
//#UC END# *3CA55B4BDAA5_BD92B7361A83_var*
begin
//#UC START# *3CA55B4BDAA5_BD92B7361A83_impl*
 Result := TtfwTruncatedArrayView.Make(aArray, aLambda);
//#UC END# *3CA55B4BDAA5_BD92B7361A83_impl*
end;//TkwArrayTrunc.Trunc

procedure TkwArrayTrunc.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aLambda : TtfwWord;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aLambda := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aLambda: TtfwWord : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Trunc(aCtx, l_aArray, l_aLambda)));
end;//TkwArrayTrunc.DoDoIt

class function TkwArrayTrunc.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Trunc';
end;//TkwArrayTrunc.GetWordNameForRegister

function TkwArrayTrunc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayTrunc.GetResultTypeInfo

function TkwArrayTrunc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArrayTrunc.GetAllParamsCount

function TkwArrayTrunc.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayTrunc.ParamsTypes

type
 TkwArraySlice = {final scriptword} class(TtfwClassLike)
  {* Слово скрипта Array:Slice
[panel]Возвращает итератор, который выдаёт наборы элементов по aCount штук[panel]
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aCount aArray Array:Slice >>> l_ItfwValueList
[code]  }
 private
 // private methods
   function Slice(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aCount: Integer): ItfwValueList;
     {* Реализация слова скрипта Array:Slice }
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
 end;//TkwArraySlice

// start class TkwArraySlice

function TkwArraySlice.Slice(const aCtx: TtfwContext;
  const aArray: ItfwValueList;
  aCount: Integer): ItfwValueList;
//#UC START# *A24C2DBFCDED_2892AD069398_var*
//#UC END# *A24C2DBFCDED_2892AD069398_var*
begin
//#UC START# *A24C2DBFCDED_2892AD069398_impl*
 Result := TtfwSliceView.Make(aArray, aCount);
//#UC END# *A24C2DBFCDED_2892AD069398_impl*
end;//TkwArraySlice.Slice

procedure TkwArraySlice.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
 l_aCount : Integer;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aCount := aCtx.rEngine.PopInt;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aCount: Integer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushList((Slice(aCtx, l_aArray, l_aCount)));
end;//TkwArraySlice.DoDoIt

class function TkwArraySlice.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Slice';
end;//TkwArraySlice.GetWordNameForRegister

function TkwArraySlice.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArraySlice.GetResultTypeInfo

function TkwArraySlice.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwArraySlice.GetAllParamsCount

function TkwArraySlice.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(Integer)]);
end;//TkwArraySlice.ParamsTypes

type
 TkwArrayCount = {final scriptword} class(TtfwPropertyLike)
  {* Слово скрипта Array:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aArray Array:Count >>> l_Integer
[code]  }
 private
 // private methods
   function Count(const aCtx: TtfwContext;
    const aArray: ItfwValueList): Integer;
     {* Реализация слова скрипта Array:Count }
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
 end;//TkwArrayCount

// start class TkwArrayCount

function TkwArrayCount.Count(const aCtx: TtfwContext;
  const aArray: ItfwValueList): Integer;
 {-}
begin
 Result := aArray.Count;
end;//TkwArrayCount.Count

procedure TkwArrayCount.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aArray : ItfwValueList;
begin
 try
  l_aArray := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра aArray: ItfwValueList : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushInt((Count(aCtx, l_aArray)));
end;//TkwArrayCount.DoDoIt

class function TkwArrayCount.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'Array:Count';
end;//TkwArrayCount.GetWordNameForRegister

procedure TkwArrayCount.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwArrayCount.SetValuePrim

function TkwArrayCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(Integer);
end;//TkwArrayCount.GetResultTypeInfo

function TkwArrayCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwArrayCount.GetAllParamsCount

function TkwArrayCount.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayCount.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// Регистрация TkwCompiledArray
 TkwCompiledArray.RegisterClass;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация CloseArray
 TkwCloseArray.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация OpenArray
 TkwOpenArray.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация скриптованой аксиоматики
 TArrayProcessingPackResNameGetter.Register;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Clear
 TkwArrayClear.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Item
 TkwArrayItem.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Reverted
 TkwArrayReverted.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Filter
 TkwArrayFilter.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Map
 TkwArrayMap.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Iterate
 TkwArrayIterate.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Add
 TkwArrayAdd.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_FunctorToIterator
 TkwArrayFunctorToIterator.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Join
 TkwArrayJoin.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Trunc
 TkwArrayTrunc.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Slice
 TkwArraySlice.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация Array_Count
 TkwArrayCount.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа ItfwValueList
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа Integer
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwStackValue
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// Регистрация типа TtfwWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
{$IfEnd} //not NoScripts

end.