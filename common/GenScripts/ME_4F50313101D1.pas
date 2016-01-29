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
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TArrayProcessingPackResNameGetter
 
 TkwArrayClear = class(TtfwClassLike)
  {* ����� ������� Array:Clear
*������:*
[code]
 aArray Array:Clear
[code]  }
  procedure Clear(const aCtx: TtfwContext;
   const aArray: ItfwValueList);
   {* ���������� ����� ������� Array:Clear }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayClear
 
 TkwArrayItem = class(TtfwClassLike)
  {* ����� ������� Array:Item
*��� ����������:* TtfwStackValue
*������:*
[code]
VAR l_TtfwStackValue
 anIndex aArray Array:Item >>> l_TtfwStackValue
[code]  }
  function Item(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   anIndex: Integer): TtfwStackValue;
   {* ���������� ����� ������� Array:Item }
  procedure DoSetValue(const aArray: ItfwValueList;
   anIndex: Integer;
   const aValue: TtfwStackValue);
   {* ����� ��������� �������� �������� Item }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayItem
 
 TkwArrayReverted = class(TtfwClassLike)
  {* ����� ������� Array:Reverted
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aArray Array:Reverted >>> l_ItfwValueList
[code]  }
  function Reverted(const aCtx: TtfwContext;
   const aArray: ItfwValueList): ItfwValueList;
   {* ���������� ����� ������� Array:Reverted }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayReverted
 
 TkwArrayFilter = class(TtfwClassLike)
  {* ����� ������� Array:Filter
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Filter >>> l_ItfwValueList
[code]  }
  function Filter(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� Array:Filter }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayFilter
 
 TkwArrayMap = class(TtfwClassLike)
  {* ����� ������� Array:Map
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Map >>> l_ItfwValueList
[code]  }
  function Map(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� Array:Map }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayMap
 
 TkwArrayIterate = class(TtfwClassLike)
  {* ����� ������� Array:Iterate
*������:*
[code]
 aLambda aArray Array:Iterate
[code]  }
  procedure Iterate(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord);
   {* ���������� ����� ������� Array:Iterate }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayIterate
 
 TkwArrayAdd = class(TtfwClassLike)
  {* ����� ������� Array:Add
*������:*
[code]
 aValue aArray Array:Add
[code]  }
  procedure Add(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   const aValue: TtfwStackValue);
   {* ���������� ����� ������� Array:Add }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayAdd
 
 TkwArrayFunctorToIterator = class(TtfwRegisterableWord)
  {* ����� ������� Array:FunctorToIterator
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda Array:FunctorToIterator >>> l_ItfwValueList
[code]  }
  function FunctorToIterator(const aCtx: TtfwContext;
   aLambda: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� Array:FunctorToIterator }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayFunctorToIterator
 
 TkwArrayJoin = class(TtfwClassLike)
  {* ����� ������� Array:Join
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 anOther aArray Array:Join >>> l_ItfwValueList
[code]  }
  function Join(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   const anOther: ItfwValueList): ItfwValueList;
   {* ���������� ����� ������� Array:Join }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayJoin
 
 TkwArrayTrunc = class(TtfwClassLike)
  {* ����� ������� Array:Trunc
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aLambda aArray Array:Trunc >>> l_ItfwValueList
[code]  }
  function Trunc(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aLambda: TtfwWord): ItfwValueList;
   {* ���������� ����� ������� Array:Trunc }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayTrunc
 
 TkwArraySlice = class(TtfwClassLike)
  {* ����� ������� Array:Slice
[panel]���������� ��������, ������� ����� ������ ��������� �� aCount ����[panel]
*��� ����������:* ItfwValueList
*������:*
[code]
ARRAY VAR l_ItfwValueList
 aCount aArray Array:Slice >>> l_ItfwValueList
[code]  }
  function Slice(const aCtx: TtfwContext;
   const aArray: ItfwValueList;
   aCount: Integer): ItfwValueList;
   {* ���������� ����� ������� Array:Slice }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArraySlice
 
 TkwArrayCount = class(TtfwPropertyLike)
  {* ����� ������� Array:Count
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aArray Array:Count >>> l_Integer
[code]  }
  function Count(const aCtx: TtfwContext;
   const aArray: ItfwValueList): Integer;
   {* ���������� ����� ������� Array:Count }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwArrayCount
 
end.
