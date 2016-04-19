unit ArrayProcessingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\ArrayProcessingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "ArrayProcessingPack" MUID: (4F50313101D1)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , l3PureMixIns
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwBeginLikeWord
 , kwCompiledWordPrim
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
 , tfwTypeInfo
 , tfwRegisterableWord
 , tfwPropertyLike
 , kwBeginLikeCompiledCode
 , kwCloseBracket
 , tfwRevertedArrayView
 , tfwFilteredArrayView
 , tfwMappedArrayView
 , tfwIteratorFromFunctor
 , tfwJoinIterator
 , tfwTruncatedArrayView
 , tfwSliceView
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , tfwArray
 , SysUtils
;

type
 TkwCompiledArray = class(TkwBeginLikeCompiledCode)
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function pm_GetResultTypeInfo(const aCtx: TtfwContext): TtfwWordInfo; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwCompiledArray

 TkwCloseArray = {final} class(TkwCloseBracket)
  protected
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwCloseArray

 TkwOpenArray = {final} class(TtfwBeginLikeWord)
  protected
   function EndBracket(const aContext: TtfwContext;
    aSilent: Boolean): RtfwWord; override;
   function CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim; override;
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwOpenArray

 //#UC START# *DB8D8DCA5554ci*
 //#UC END# *DB8D8DCA5554ci*
 //#UC START# *DB8D8DCA5554cit*
 //#UC END# *DB8D8DCA5554cit*
 TArrayProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 //#UC START# *DB8D8DCA5554publ*
 //#UC END# *DB8D8DCA5554publ*
 end;//TArrayProcessingPackResNameGetter

 TkwArrayClear = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Clear
*Пример:*
[code]
 aArray Array:Clear
[code]  }
  private
   procedure Clear(const aCtx: TtfwContext;
    const aArray: ItfwValueList);
    {* Реализация слова скрипта Array:Clear }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayClear

 TkwArrayItem = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Item
*Тип результата:* TtfwStackValue
*Пример:*
[code]
VAR l_TtfwStackValue
 anIndex aArray Array:Item >>> l_TtfwStackValue
[code]  }
  private
   function Item(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    anIndex: Integer): TtfwStackValue;
    {* Реализация слова скрипта Array:Item }
  protected
   class procedure DoSetValue(const aArray: ItfwValueList;
    anIndex: Integer;
    const aValue: TtfwStackValue);
    {* Метод установки значения свойства Item }
   procedure DoDoIt(const aCtx: TtfwContext); override;
   function BindParams: Boolean; override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayItem

 TkwArrayReverted = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Reverted
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aArray Array:Reverted >>> l_ItfwValueList
[code]  }
  private
   function Reverted(const aCtx: TtfwContext;
    const aArray: ItfwValueList): ItfwValueList;
    {* Реализация слова скрипта Array:Reverted }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayReverted

 TkwArrayFilter = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Filter
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Filter >>> l_ItfwValueList
[code]  }
  private
   function Filter(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Filter }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayFilter

 TkwArrayMap = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Map
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Map >>> l_ItfwValueList
[code]  }
  private
   function Map(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Map }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayMap

 TkwArrayIterate = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Iterate
*Пример:*
[code]
 aLambda aArray Array:Iterate
[code]  }
  private
   procedure Iterate(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord);
    {* Реализация слова скрипта Array:Iterate }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayIterate

 TkwArrayAdd = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Add
*Пример:*
[code]
 aValue aArray Array:Add
[code]  }
  private
   procedure Add(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта Array:Add }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayAdd

 TkwArrayFunctorToIterator = {final} class(TtfwRegisterableWord)
  {* Слово скрипта Array:FunctorToIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda Array:FunctorToIterator >>> l_ItfwValueList
[code]  }
  private
   function FunctorToIterator(const aCtx: TtfwContext;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:FunctorToIterator }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayFunctorToIterator

 TkwArrayJoin = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Join
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 anOther aArray Array:Join >>> l_ItfwValueList
[code]  }
  private
   function Join(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const anOther: ItfwValueList): ItfwValueList;
    {* Реализация слова скрипта Array:Join }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayJoin

 TkwArrayTrunc = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Trunc
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Trunc >>> l_ItfwValueList
[code]  }
  private
   function Trunc(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Trunc }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayTrunc

 TkwArraySlice = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Slice
[panel]Возвращает итератор, который выдаёт наборы элементов по aCount штук[panel]
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aCount aArray Array:Slice >>> l_ItfwValueList
[code]  }
  private
   function Slice(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aCount: Integer): ItfwValueList;
    {* Реализация слова скрипта Array:Slice }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArraySlice

 TkwArrayCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта Array:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aArray Array:Count >>> l_Integer
[code]  }
  private
   function Count(const aCtx: TtfwContext;
    const aArray: ItfwValueList): Integer;
    {* Реализация слова скрипта Array:Count }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayCount

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

class function TkwCloseArray.GetWordNameForRegister: AnsiString;
begin
 Result := ']';
end;//TkwCloseArray.GetWordNameForRegister

function TkwOpenArray.EndBracket(const aContext: TtfwContext;
 aSilent: Boolean): RtfwWord;
//#UC START# *4DB6C99F026E_4F5037E30231_var*
//#UC END# *4DB6C99F026E_4F5037E30231_var*
begin
//#UC START# *4DB6C99F026E_4F5037E30231_impl*
 Result := TkwCloseArray;
//#UC END# *4DB6C99F026E_4F5037E30231_impl*
end;//TkwOpenArray.EndBracket

function TkwOpenArray.CompiledWordClass(const aCtx: TtfwContext): RkwCompiledWordPrim;
//#UC START# *4DBAEE0D028D_4F5037E30231_var*
//#UC END# *4DBAEE0D028D_4F5037E30231_var*
begin
//#UC START# *4DBAEE0D028D_4F5037E30231_impl*
 Result := TkwCompiledArray;
//#UC END# *4DBAEE0D028D_4F5037E30231_impl*
end;//TkwOpenArray.CompiledWordClass

class function TkwOpenArray.GetWordNameForRegister: AnsiString;
begin
 Result := '[';
end;//TkwOpenArray.GetWordNameForRegister

class function TArrayProcessingPackResNameGetter.ResName: AnsiString;
begin
  Result := 'ArrayProcessingPack';
end;//TArrayProcessingPackResNameGetter.ResName

 {$R ArrayProcessingPack.res}

procedure TkwArrayClear.Clear(const aCtx: TtfwContext;
 const aArray: ItfwValueList);
 {* Реализация слова скрипта Array:Clear }
//#UC START# *428D1CC30289_878FE88B604D_var*
//#UC END# *428D1CC30289_878FE88B604D_var*
begin
//#UC START# *428D1CC30289_878FE88B604D_impl*
 if (aArray <> nil) then
  aArray.Clear;
//#UC END# *428D1CC30289_878FE88B604D_impl*
end;//TkwArrayClear.Clear

procedure TkwArrayClear.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
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

function TkwArrayClear.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwArrayClear.GetResultTypeInfo

function TkwArrayClear.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwArrayClear.GetAllParamsCount

function TkwArrayClear.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayClear.ParamsTypes

class function TkwArrayClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Clear';
end;//TkwArrayClear.GetWordNameForRegister

function TkwArrayItem.Item(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 anIndex: Integer): TtfwStackValue;
 {* Реализация слова скрипта Array:Item }
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
 {* Метод установки значения свойства Item }
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
var l_aArray: ItfwValueList;
var l_anIndex: Integer;
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
 aCtx.rEngine.Push(Item(aCtx, l_aArray, l_anIndex));
end;//TkwArrayItem.DoDoIt

procedure TkwArrayItem.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
var l_Array: ItfwValueList;
var l_anIndex: Integer;
begin
 try
  l_Array := aCtx.rEngine.PopList;
 except
  on E: Exception do
  begin
   RunnerError('Ошибка при получении параметра Array: ItfwValueList : ' + E.Message, aCtx);
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
 DoSetValue(l_Array, l_anIndex, aValue);
end;//TkwArrayItem.SetValuePrim

function TkwArrayItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwArrayItem.GetResultTypeInfo

function TkwArrayItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayItem.GetAllParamsCount

function TkwArrayItem.BindParams: Boolean;
//#UC START# *5617C8A30023_E14E90E5EF2D_var*
//#UC END# *5617C8A30023_E14E90E5EF2D_var*
begin
//#UC START# *5617C8A30023_E14E90E5EF2D_impl*
 Result := true;
//#UC END# *5617C8A30023_E14E90E5EF2D_impl*
end;//TkwArrayItem.BindParams

function TkwArrayItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(Integer)]);
end;//TkwArrayItem.ParamsTypes

class function TkwArrayItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Item';
end;//TkwArrayItem.GetWordNameForRegister

function TkwArrayReverted.Reverted(const aCtx: TtfwContext;
 const aArray: ItfwValueList): ItfwValueList;
 {* Реализация слова скрипта Array:Reverted }
//#UC START# *155569C67894_68189B4B7D71_var*
//#UC END# *155569C67894_68189B4B7D71_var*
begin
//#UC START# *155569C67894_68189B4B7D71_impl*
 Result := TtfwRevertedArrayView.Make(aArray);
//#UC END# *155569C67894_68189B4B7D71_impl*
end;//TkwArrayReverted.Reverted

procedure TkwArrayReverted.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
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
 aCtx.rEngine.PushList(Reverted(aCtx, l_aArray));
end;//TkwArrayReverted.DoDoIt

function TkwArrayReverted.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayReverted.GetResultTypeInfo

function TkwArrayReverted.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwArrayReverted.GetAllParamsCount

function TkwArrayReverted.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayReverted.ParamsTypes

class function TkwArrayReverted.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Reverted';
end;//TkwArrayReverted.GetWordNameForRegister

function TkwArrayFilter.Filter(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Filter }
//#UC START# *781431CE844D_BE2AD2FE44CF_var*
//#UC END# *781431CE844D_BE2AD2FE44CF_var*
begin
//#UC START# *781431CE844D_BE2AD2FE44CF_impl*
 Result := TtfwFilteredArrayView.Make(aArray, aLambda);
//#UC END# *781431CE844D_BE2AD2FE44CF_impl*
end;//TkwArrayFilter.Filter

procedure TkwArrayFilter.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aLambda: TtfwWord;
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
 aCtx.rEngine.PushList(Filter(aCtx, l_aArray, l_aLambda));
end;//TkwArrayFilter.DoDoIt

function TkwArrayFilter.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayFilter.GetResultTypeInfo

function TkwArrayFilter.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayFilter.GetAllParamsCount

function TkwArrayFilter.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayFilter.ParamsTypes

class function TkwArrayFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Filter';
end;//TkwArrayFilter.GetWordNameForRegister

function TkwArrayMap.Map(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Map }
//#UC START# *7FA64661B5E5_4D82A8E4E72B_var*
//#UC END# *7FA64661B5E5_4D82A8E4E72B_var*
begin
//#UC START# *7FA64661B5E5_4D82A8E4E72B_impl*
 Result := TtfwMappedArrayView.Make(aArray, aLambda);
//#UC END# *7FA64661B5E5_4D82A8E4E72B_impl*
end;//TkwArrayMap.Map

procedure TkwArrayMap.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aLambda: TtfwWord;
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
 aCtx.rEngine.PushList(Map(aCtx, l_aArray, l_aLambda));
end;//TkwArrayMap.DoDoIt

function TkwArrayMap.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayMap.GetResultTypeInfo

function TkwArrayMap.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayMap.GetAllParamsCount

function TkwArrayMap.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayMap.ParamsTypes

class function TkwArrayMap.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Map';
end;//TkwArrayMap.GetWordNameForRegister

procedure TkwArrayIterate.Iterate(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord);
 {* Реализация слова скрипта Array:Iterate }
//#UC START# *78836988FFF5_67F9FD4545C9_var*
//#UC END# *78836988FFF5_67F9FD4545C9_var*
begin
//#UC START# *78836988FFF5_67F9FD4545C9_impl*
 aArray.ForEach(aLambda, aCtx);
//#UC END# *78836988FFF5_67F9FD4545C9_impl*
end;//TkwArrayIterate.Iterate

procedure TkwArrayIterate.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aLambda: TtfwWord;
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

function TkwArrayIterate.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwArrayIterate.GetResultTypeInfo

function TkwArrayIterate.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayIterate.GetAllParamsCount

function TkwArrayIterate.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayIterate.ParamsTypes

class function TkwArrayIterate.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Iterate';
end;//TkwArrayIterate.GetWordNameForRegister

procedure TkwArrayAdd.Add(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта Array:Add }
begin
 aArray.Add(aValue);
end;//TkwArrayAdd.Add

procedure TkwArrayAdd.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aValue: TtfwStackValue;
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

function TkwArrayAdd.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwArrayAdd.GetResultTypeInfo

function TkwArrayAdd.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayAdd.GetAllParamsCount

function TkwArrayAdd.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), @tfw_tiStruct]);
end;//TkwArrayAdd.ParamsTypes

class function TkwArrayAdd.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Add';
end;//TkwArrayAdd.GetWordNameForRegister

function TkwArrayFunctorToIterator.FunctorToIterator(const aCtx: TtfwContext;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:FunctorToIterator }
//#UC START# *D84558AB12E8_AC4DA64FB94F_var*
//#UC END# *D84558AB12E8_AC4DA64FB94F_var*
begin
//#UC START# *D84558AB12E8_AC4DA64FB94F_impl*
 Result := TtfwIteratorFromFunctor.Make(aLambda);
//#UC END# *D84558AB12E8_AC4DA64FB94F_impl*
end;//TkwArrayFunctorToIterator.FunctorToIterator

procedure TkwArrayFunctorToIterator.DoDoIt(const aCtx: TtfwContext);
var l_aLambda: TtfwWord;
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
 aCtx.rEngine.PushList(FunctorToIterator(aCtx, l_aLambda));
end;//TkwArrayFunctorToIterator.DoDoIt

function TkwArrayFunctorToIterator.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayFunctorToIterator.GetResultTypeInfo

function TkwArrayFunctorToIterator.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwArrayFunctorToIterator.GetAllParamsCount

function TkwArrayFunctorToIterator.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayFunctorToIterator.ParamsTypes

class function TkwArrayFunctorToIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:FunctorToIterator';
end;//TkwArrayFunctorToIterator.GetWordNameForRegister

function TkwArrayJoin.Join(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 const anOther: ItfwValueList): ItfwValueList;
 {* Реализация слова скрипта Array:Join }
//#UC START# *AE1CCBE76617_F83E51FB5EAA_var*
//#UC END# *AE1CCBE76617_F83E51FB5EAA_var*
begin
//#UC START# *AE1CCBE76617_F83E51FB5EAA_impl*
 Result := TtfwJoinIterator.Make(aArray, anOther);
//#UC END# *AE1CCBE76617_F83E51FB5EAA_impl*
end;//TkwArrayJoin.Join

procedure TkwArrayJoin.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_anOther: ItfwValueList;
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
 aCtx.rEngine.PushList(Join(aCtx, l_aArray, l_anOther));
end;//TkwArrayJoin.DoDoIt

function TkwArrayJoin.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayJoin.GetResultTypeInfo

function TkwArrayJoin.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayJoin.GetAllParamsCount

function TkwArrayJoin.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(ItfwValueList)]);
end;//TkwArrayJoin.ParamsTypes

class function TkwArrayJoin.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Join';
end;//TkwArrayJoin.GetWordNameForRegister

function TkwArrayTrunc.Trunc(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Trunc }
//#UC START# *3CA55B4BDAA5_BD92B7361A83_var*
//#UC END# *3CA55B4BDAA5_BD92B7361A83_var*
begin
//#UC START# *3CA55B4BDAA5_BD92B7361A83_impl*
 Result := TtfwTruncatedArrayView.Make(aArray, aLambda);
//#UC END# *3CA55B4BDAA5_BD92B7361A83_impl*
end;//TkwArrayTrunc.Trunc

procedure TkwArrayTrunc.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aLambda: TtfwWord;
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
 aCtx.rEngine.PushList(Trunc(aCtx, l_aArray, l_aLambda));
end;//TkwArrayTrunc.DoDoIt

function TkwArrayTrunc.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArrayTrunc.GetResultTypeInfo

function TkwArrayTrunc.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayTrunc.GetAllParamsCount

function TkwArrayTrunc.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(TtfwWord)]);
end;//TkwArrayTrunc.ParamsTypes

class function TkwArrayTrunc.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Trunc';
end;//TkwArrayTrunc.GetWordNameForRegister

function TkwArraySlice.Slice(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aCount: Integer): ItfwValueList;
 {* Реализация слова скрипта Array:Slice }
//#UC START# *A24C2DBFCDED_2892AD069398_var*
//#UC END# *A24C2DBFCDED_2892AD069398_var*
begin
//#UC START# *A24C2DBFCDED_2892AD069398_impl*
 Result := TtfwSliceView.Make(aArray, aCount);
//#UC END# *A24C2DBFCDED_2892AD069398_impl*
end;//TkwArraySlice.Slice

procedure TkwArraySlice.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
var l_aCount: Integer;
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
 aCtx.rEngine.PushList(Slice(aCtx, l_aArray, l_aCount));
end;//TkwArraySlice.DoDoIt

function TkwArraySlice.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(ItfwValueList);
end;//TkwArraySlice.GetResultTypeInfo

function TkwArraySlice.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArraySlice.GetAllParamsCount

function TkwArraySlice.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(Integer)]);
end;//TkwArraySlice.ParamsTypes

class function TkwArraySlice.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Slice';
end;//TkwArraySlice.GetWordNameForRegister

function TkwArrayCount.Count(const aCtx: TtfwContext;
 const aArray: ItfwValueList): Integer;
 {* Реализация слова скрипта Array:Count }
//#UC START# *87ED8662D31C_F4E1D8EB306A_var*
//#UC END# *87ED8662D31C_F4E1D8EB306A_var*
begin
//#UC START# *87ED8662D31C_F4E1D8EB306A_impl*
 if (aArray = nil) then
  Result := 0
 else
  Result := aArray.Count; 
//#UC END# *87ED8662D31C_F4E1D8EB306A_impl*
end;//TkwArrayCount.Count

procedure TkwArrayCount.DoDoIt(const aCtx: TtfwContext);
var l_aArray: ItfwValueList;
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
 aCtx.rEngine.PushInt(Count(aCtx, l_aArray));
end;//TkwArrayCount.DoDoIt

procedure TkwArrayCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwArrayCount.SetValuePrim

function TkwArrayCount.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Integer);
end;//TkwArrayCount.GetResultTypeInfo

function TkwArrayCount.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwArrayCount.GetAllParamsCount

function TkwArrayCount.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList)]);
end;//TkwArrayCount.ParamsTypes

class function TkwArrayCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Count';
end;//TkwArrayCount.GetWordNameForRegister

initialization
 TkwCompiledArray.RegisterClass;
 {* Регистрация TkwCompiledArray }
 TkwCloseArray.RegisterInEngine;
 {* Регистрация CloseArray }
 TkwOpenArray.RegisterInEngine;
 {* Регистрация OpenArray }
 TArrayProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TkwArrayClear.RegisterInEngine;
 {* Регистрация Array_Clear }
 TkwArrayItem.RegisterInEngine;
 {* Регистрация Array_Item }
 TkwArrayReverted.RegisterInEngine;
 {* Регистрация Array_Reverted }
 TkwArrayFilter.RegisterInEngine;
 {* Регистрация Array_Filter }
 TkwArrayMap.RegisterInEngine;
 {* Регистрация Array_Map }
 TkwArrayIterate.RegisterInEngine;
 {* Регистрация Array_Iterate }
 TkwArrayAdd.RegisterInEngine;
 {* Регистрация Array_Add }
 TkwArrayFunctorToIterator.RegisterInEngine;
 {* Регистрация Array_FunctorToIterator }
 TkwArrayJoin.RegisterInEngine;
 {* Регистрация Array_Join }
 TkwArrayTrunc.RegisterInEngine;
 {* Регистрация Array_Trunc }
 TkwArraySlice.RegisterInEngine;
 {* Регистрация Array_Slice }
 TkwArrayCount.RegisterInEngine;
 {* Регистрация Array_Count }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
