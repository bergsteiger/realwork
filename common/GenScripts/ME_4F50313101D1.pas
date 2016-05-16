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
 , tfwClassLike
 , TypInfo
 , tfwTypeInfo
 , tfwPropertyLike
 , tfwAxiomaticsResNameGetter
 , kwBeginLikeCompiledCode
 , kwCloseBracket
 , tfwRevertedArrayView
 , tfwFilteredArrayView
 , tfwMappedArrayView
 , tfwIteratorFromFunctor
 , tfwJoinIterator
 , tfwTruncatedArrayView
 , tfwSliceView
 , tfwArray
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
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

 TkwArrayClear = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Clear }
  private
   procedure Clear(const aCtx: TtfwContext;
    const aArray: ItfwValueList);
    {* Реализация слова скрипта Array:Clear }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayClear

 TkwArrayItem = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Item }
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
   class function GetWordNameForRegister: AnsiString; override;
   function BindParams: Boolean; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwArrayItem

 TkwArrayReverted = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Reverted }
  private
   function Reverted(const aCtx: TtfwContext;
    const aArray: ItfwValueList): ItfwValueList;
    {* Реализация слова скрипта Array:Reverted }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayReverted

 TkwArrayFilter = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Filter }
  private
   function Filter(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Filter }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayFilter

 TkwArrayMap = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Map }
  private
   function Map(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Map }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayMap

 TkwArrayIterate = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Iterate }
  private
   procedure Iterate(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord);
    {* Реализация слова скрипта Array:Iterate }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayIterate

 TkwArrayAdd = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Add }
  private
   procedure Add(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const aValue: TtfwStackValue);
    {* Реализация слова скрипта Array:Add }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayAdd

 TkwArrayFunctorToIterator = {final} class(TtfwClassLike)
  {* Слово скрипта Array:FunctorToIterator }
  private
   function FunctorToIterator(const aCtx: TtfwContext;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:FunctorToIterator }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayFunctorToIterator

 TkwArrayJoin = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Join }
  private
   function Join(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    const anOther: ItfwValueList): ItfwValueList;
    {* Реализация слова скрипта Array:Join }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayJoin

 TkwArrayTrunc = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Trunc }
  private
   function Trunc(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aLambda: TtfwWord): ItfwValueList;
    {* Реализация слова скрипта Array:Trunc }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArrayTrunc

 TkwArraySlice = {final} class(TtfwClassLike)
  {* Слово скрипта Array:Slice }
  private
   function Slice(const aCtx: TtfwContext;
    const aArray: ItfwValueList;
    aCount: Integer): ItfwValueList;
    {* Реализация слова скрипта Array:Slice }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwArraySlice

 TkwArrayCount = {final} class(TtfwPropertyLike)
  {* Слово скрипта Array:Count }
  private
   function Count(const aCtx: TtfwContext;
    const aArray: ItfwValueList): Integer;
    {* Реализация слова скрипта Array:Count }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
 end;//TkwArrayCount

 TArrayProcessingPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  public
   class function ResName: AnsiString; override;
 end;//TArrayProcessingPackResNameGetter

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

procedure TkwArrayClear.Clear(const aCtx: TtfwContext;
 const aArray: ItfwValueList);
 {* Реализация слова скрипта Array:Clear }
//#UC START# *551012E802AF_551012E802AF_4DCC12FC0125_Word_var*
//#UC END# *551012E802AF_551012E802AF_4DCC12FC0125_Word_var*
begin
//#UC START# *551012E802AF_551012E802AF_4DCC12FC0125_Word_impl*
 if (aArray <> nil) then
  aArray.Clear;
//#UC END# *551012E802AF_551012E802AF_4DCC12FC0125_Word_impl*
end;//TkwArrayClear.Clear

class function TkwArrayClear.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Clear';
end;//TkwArrayClear.GetWordNameForRegister

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

class procedure TkwArrayItem.DoSetValue(const aArray: ItfwValueList;
 anIndex: Integer;
 const aValue: TtfwStackValue);
 {* Метод установки значения свойства Item }
//#UC START# *551012F603D4_4DCC12FC0125_Word_DoSetValue_551012F603D4_4DCC12FC0125_Word_var*
//#UC END# *551012F603D4_4DCC12FC0125_Word_DoSetValue_551012F603D4_4DCC12FC0125_Word_var*
begin
//#UC START# *551012F603D4_4DCC12FC0125_Word_DoSetValue_551012F603D4_4DCC12FC0125_Word_impl*
 //RunnerAssert(anIndex >= 0, 'Мне нужно положительное число.', aCtx);
 //RunnerAssert(anIndex < aArray.Count, 'В массиве нет столько элементов.', aCtx);
 aArray.SetItem(anIndex, aValue);
//#UC END# *551012F603D4_4DCC12FC0125_Word_DoSetValue_551012F603D4_4DCC12FC0125_Word_impl*
end;//TkwArrayItem.DoSetValue

function TkwArrayItem.Item(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 anIndex: Integer): TtfwStackValue;
 {* Реализация слова скрипта Array:Item }
//#UC START# *551012F603D4_551012F603D4_4DCC12FC0125_Word_var*
//#UC END# *551012F603D4_551012F603D4_4DCC12FC0125_Word_var*
begin
//#UC START# *551012F603D4_551012F603D4_4DCC12FC0125_Word_impl*
 RunnerAssert(anIndex >= 0, 'Мне нужно положительное число.', aCtx);
 RunnerAssert(anIndex < aArray.Count, 'В массиве нет столько элементов.', aCtx);
 Result := aArray.Items[anIndex];
//#UC END# *551012F603D4_551012F603D4_4DCC12FC0125_Word_impl*
end;//TkwArrayItem.Item

class function TkwArrayItem.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Item';
end;//TkwArrayItem.GetWordNameForRegister

function TkwArrayItem.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiStruct;
end;//TkwArrayItem.GetResultTypeInfo

function TkwArrayItem.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwArrayItem.GetAllParamsCount

function TkwArrayItem.BindParams: Boolean;
begin
 Result := true;
end;//TkwArrayItem.BindParams

function TkwArrayItem.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(ItfwValueList), TypeInfo(Integer)]);
end;//TkwArrayItem.ParamsTypes

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

function TkwArrayReverted.Reverted(const aCtx: TtfwContext;
 const aArray: ItfwValueList): ItfwValueList;
 {* Реализация слова скрипта Array:Reverted }
//#UC START# *5510147F0057_5510147F0057_4DCC12FC0125_Word_var*
//#UC END# *5510147F0057_5510147F0057_4DCC12FC0125_Word_var*
begin
//#UC START# *5510147F0057_5510147F0057_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := nil
 else
  Result := TtfwRevertedArrayView.Make(aArray);
//#UC END# *5510147F0057_5510147F0057_4DCC12FC0125_Word_impl*
end;//TkwArrayReverted.Reverted

class function TkwArrayReverted.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Reverted';
end;//TkwArrayReverted.GetWordNameForRegister

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

function TkwArrayFilter.Filter(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Filter }
//#UC START# *55101ABC0102_55101ABC0102_4DCC12FC0125_Word_var*
//#UC END# *55101ABC0102_55101ABC0102_4DCC12FC0125_Word_var*
begin
//#UC START# *55101ABC0102_55101ABC0102_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := nil
 else
  Result := TtfwFilteredArrayView.Make(aArray, aLambda);
//#UC END# *55101ABC0102_55101ABC0102_4DCC12FC0125_Word_impl*
end;//TkwArrayFilter.Filter

class function TkwArrayFilter.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Filter';
end;//TkwArrayFilter.GetWordNameForRegister

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

function TkwArrayMap.Map(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Map }
//#UC START# *55101AE0033E_55101AE0033E_4DCC12FC0125_Word_var*
//#UC END# *55101AE0033E_55101AE0033E_4DCC12FC0125_Word_var*
begin
//#UC START# *55101AE0033E_55101AE0033E_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := nil
 else
  Result := TtfwMappedArrayView.Make(aArray, aLambda);
//#UC END# *55101AE0033E_55101AE0033E_4DCC12FC0125_Word_impl*
end;//TkwArrayMap.Map

class function TkwArrayMap.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Map';
end;//TkwArrayMap.GetWordNameForRegister

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

procedure TkwArrayIterate.Iterate(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord);
 {* Реализация слова скрипта Array:Iterate }
//#UC START# *55101BDF0235_55101BDF0235_4DCC12FC0125_Word_var*
//#UC END# *55101BDF0235_55101BDF0235_4DCC12FC0125_Word_var*
begin
//#UC START# *55101BDF0235_55101BDF0235_4DCC12FC0125_Word_impl*
 if (aArray <> nil) then
  aArray.ForEach(aLambda, aCtx);
//#UC END# *55101BDF0235_55101BDF0235_4DCC12FC0125_Word_impl*
end;//TkwArrayIterate.Iterate

class function TkwArrayIterate.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Iterate';
end;//TkwArrayIterate.GetWordNameForRegister

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

procedure TkwArrayAdd.Add(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 const aValue: TtfwStackValue);
 {* Реализация слова скрипта Array:Add }
begin
 aArray.Add(aValue);
end;//TkwArrayAdd.Add

class function TkwArrayAdd.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Add';
end;//TkwArrayAdd.GetWordNameForRegister

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

function TkwArrayFunctorToIterator.FunctorToIterator(const aCtx: TtfwContext;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:FunctorToIterator }
//#UC START# *551038F0003A_551038F0003A_4DCC12FC0125_Word_var*
//#UC END# *551038F0003A_551038F0003A_4DCC12FC0125_Word_var*
begin
//#UC START# *551038F0003A_551038F0003A_4DCC12FC0125_Word_impl*
 Result := TtfwIteratorFromFunctor.Make(aLambda);
//#UC END# *551038F0003A_551038F0003A_4DCC12FC0125_Word_impl*
end;//TkwArrayFunctorToIterator.FunctorToIterator

class function TkwArrayFunctorToIterator.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:FunctorToIterator';
end;//TkwArrayFunctorToIterator.GetWordNameForRegister

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

function TkwArrayJoin.Join(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 const anOther: ItfwValueList): ItfwValueList;
 {* Реализация слова скрипта Array:Join }
//#UC START# *55E02C110223_55E02C110223_4DCC12FC0125_Word_var*
//#UC END# *55E02C110223_55E02C110223_4DCC12FC0125_Word_var*
begin
//#UC START# *55E02C110223_55E02C110223_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
 begin
  if (anOther = nil) then
   Result := nil
  else
   Result := anOther; 
 end//aArray = nil
 else
 if (anOther = nil) then
  Result := aArray
 else 
  Result := TtfwJoinIterator.Make(aArray, anOther);
//#UC END# *55E02C110223_55E02C110223_4DCC12FC0125_Word_impl*
end;//TkwArrayJoin.Join

class function TkwArrayJoin.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Join';
end;//TkwArrayJoin.GetWordNameForRegister

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

function TkwArrayTrunc.Trunc(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aLambda: TtfwWord): ItfwValueList;
 {* Реализация слова скрипта Array:Trunc }
//#UC START# *55E0410603CA_55E0410603CA_4DCC12FC0125_Word_var*
//#UC END# *55E0410603CA_55E0410603CA_4DCC12FC0125_Word_var*
begin
//#UC START# *55E0410603CA_55E0410603CA_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := nil
 else
  Result := TtfwTruncatedArrayView.Make(aArray, aLambda);
//#UC END# *55E0410603CA_55E0410603CA_4DCC12FC0125_Word_impl*
end;//TkwArrayTrunc.Trunc

class function TkwArrayTrunc.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Trunc';
end;//TkwArrayTrunc.GetWordNameForRegister

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

function TkwArraySlice.Slice(const aCtx: TtfwContext;
 const aArray: ItfwValueList;
 aCount: Integer): ItfwValueList;
 {* Реализация слова скрипта Array:Slice }
//#UC START# *55E59002038C_55E59002038C_4DCC12FC0125_Word_var*
//#UC END# *55E59002038C_55E59002038C_4DCC12FC0125_Word_var*
begin
//#UC START# *55E59002038C_55E59002038C_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := nil
 else
  Result := TtfwSliceView.Make(aArray, aCount);
//#UC END# *55E59002038C_55E59002038C_4DCC12FC0125_Word_impl*
end;//TkwArraySlice.Slice

class function TkwArraySlice.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Slice';
end;//TkwArraySlice.GetWordNameForRegister

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

function TkwArrayCount.Count(const aCtx: TtfwContext;
 const aArray: ItfwValueList): Integer;
 {* Реализация слова скрипта Array:Count }
//#UC START# *5510142301A5_5510142301A5_4DCC12FC0125_Word_var*
//#UC END# *5510142301A5_5510142301A5_4DCC12FC0125_Word_var*
begin
//#UC START# *5510142301A5_5510142301A5_4DCC12FC0125_Word_impl*
 if (aArray = nil) then
  Result := 0
 else
  Result := aArray.Count; 
//#UC END# *5510142301A5_5510142301A5_4DCC12FC0125_Word_impl*
end;//TkwArrayCount.Count

class function TkwArrayCount.GetWordNameForRegister: AnsiString;
begin
 Result := 'Array:Count';
end;//TkwArrayCount.GetWordNameForRegister

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

procedure TkwArrayCount.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('Нельзя присваивать значение readonly свойству Count', aCtx);
end;//TkwArrayCount.SetValuePrim

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

class function TArrayProcessingPackResNameGetter.ResName: AnsiString;
begin
 Result := 'ArrayProcessingPack';
end;//TArrayProcessingPackResNameGetter.ResName

 {$R ArrayProcessingPack.res}

initialization
 TkwCompiledArray.RegisterClass;
 {* Регистрация TkwCompiledArray }
 TkwCloseArray.RegisterInEngine;
 {* Регистрация CloseArray }
 TkwOpenArray.RegisterInEngine;
 {* Регистрация OpenArray }
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
 TArrayProcessingPackResNameGetter.Register;
 {* Регистрация скриптованой аксиоматики }
 TtfwTypeRegistrator.RegisterType(TypeInfo(ItfwValueList));
 {* Регистрация типа ItfwValueList }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* Регистрация типа TtfwStackValue }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Integer));
 {* Регистрация типа Integer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwWord));
 {* Регистрация типа TtfwWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
