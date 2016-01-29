unit ArrayProcessingPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , l3PureMixIns
 , tfwBeginLikeWord
 , kwCompiledWordPrim
 , kwBeginLikeCompiledCode
 , TypInfo
 , kwCloseBracket
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwRegisterableWord
 , tfwPropertyLike
;

type
 TkwCompiledArray = class(TkwBeginLikeCompiledCode)
 end;//TkwCompiledArray
 
implementation

uses
 l3ImplUses
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
 TkwCloseArray = class(TkwCloseBracket)
 end;//TkwCloseArray
 
 TkwOpenArray = class(TtfwBeginLikeWord)
  function EndBracket(const aContext: TtfwContext;
   aSilent: Boolean): RtfwWord;
 end;//TkwOpenArray
 
 TArrayProcessingPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TArrayProcessingPackResNameGetter
 
 TkwArrayClear = class(TtfwClassLike)
  {* Слово скрипта Array:Clear
*Пример:*
[code]
 aArray Array:Clear
[code]  }
  procedure Clear(const aCtx: TtfwContext;
   const aArray: ItfwValueList);
   {* Реализация слова скрипта Array:Clear }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayClear
 
 TkwArrayItem = class(TtfwClassLike)
  {* Слово скрипта Array:Item
*Тип результата:* TtfwStackValue
*Пример:*
[code]
VAR l_TtfwStackValue
 anIndex aArray Array:Item >>> l_TtfwStackValue
[code]  }
  function Item(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   anIndex: Integer): TtfwStackValue;
   {* Реализация слова скрипта Array:Item }
  procedure DoSetValue(const aArray: ItfwValueList;
   anIndex: Integer;
   const aValue: TtfwStackValue);
   {* Метод установки значения свойства Item }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayItem
 
 TkwArrayReverted = class(TtfwClassLike)
  {* Слово скрипта Array:Reverted
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aArray Array:Reverted >>> l_ItfwValueList
[code]  }
  function Reverted(const aCtx: TtfwContext;
   const aArray: ItfwValueList): ItfwValueList;
   {* Реализация слова скрипта Array:Reverted }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayReverted
 
 TkwArrayFilter = class(TtfwClassLike)
  {* Слово скрипта Array:Filter
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Filter >>> l_ItfwValueList
[code]  }
  function Filter(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта Array:Filter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayFilter
 
 TkwArrayMap = class(TtfwClassLike)
  {* Слово скрипта Array:Map
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Map >>> l_ItfwValueList
[code]  }
  function Map(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта Array:Map }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayMap
 
 TkwArrayIterate = class(TtfwClassLike)
  {* Слово скрипта Array:Iterate
*Пример:*
[code]
 aLambda aArray Array:Iterate
[code]  }
  procedure Iterate(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord);
   {* Реализация слова скрипта Array:Iterate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayIterate
 
 TkwArrayAdd = class(TtfwClassLike)
  {* Слово скрипта Array:Add
*Пример:*
[code]
 aValue aArray Array:Add
[code]  }
  procedure Add(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   const aValue: TtfwStackValue);
   {* Реализация слова скрипта Array:Add }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayAdd
 
 TkwArrayFunctorToIterator = class(TtfwRegisterableWord)
  {* Слово скрипта Array:FunctorToIterator
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda Array:FunctorToIterator >>> l_ItfwValueList
[code]  }
  function FunctorToIterator(const aCtx: TtfwContext;
   aLambda: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта Array:FunctorToIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayFunctorToIterator
 
 TkwArrayJoin = class(TtfwClassLike)
  {* Слово скрипта Array:Join
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 anOther aArray Array:Join >>> l_ItfwValueList
[code]  }
  function Join(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   const anOther: ItfwValueList): ItfwValueList;
   {* Реализация слова скрипта Array:Join }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayJoin
 
 TkwArrayTrunc = class(TtfwClassLike)
  {* Слово скрипта Array:Trunc
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Trunc >>> l_ItfwValueList
[code]  }
  function Trunc(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* Реализация слова скрипта Array:Trunc }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayTrunc
 
 TkwArraySlice = class(TtfwClassLike)
  {* Слово скрипта Array:Slice
[panel]Возвращает итератор, который выдаёт наборы элементов по aCount штук[panel]
*Тип результата:* ItfwValueList
*Пример:*
[code]
ARRAY VAR l_ItfwValueList
 aCount aArray Array:Slice >>> l_ItfwValueList
[code]  }
  function Slice(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aCount: Integer): ItfwValueList;
   {* Реализация слова скрипта Array:Slice }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArraySlice
 
 TkwArrayCount = class(TtfwPropertyLike)
  {* Слово скрипта Array:Count
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aArray Array:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   const aArray: ItfwValueList): Integer;
   {* Реализация слова скрипта Array:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayCount
 
end.
