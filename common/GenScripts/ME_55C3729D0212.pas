unit tfwWordInfoWordsPack;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , l3Interfaces
 , tfwValueTypes
 , tfwScriptingTypes
 , tfwTypeInfo
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
;

implementation

uses
 l3ImplUses
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopWordInfoIncludeModifier = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeModifier
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aModifier aWordInfo pop:WordInfo:IncludeModifier >>> l_TtfwWordInfo
[code]  }
  function IncludeModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aModifier: TtfwWordModifier): TtfwWordInfo;
   {* Реализация слова скрипта pop:WordInfo:IncludeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeModifier
 
 TkwPopWordInfoEmpty = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Empty
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aWordInfo pop:WordInfo:Empty >>> l_Boolean
[code]  }
  function Empty(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Boolean;
   {* Реализация слова скрипта pop:WordInfo:Empty }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoEmpty
 
 TkwPopWordInfoHasWordModifier = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasWordModifier
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aModifier aWordInfo pop:WordInfo:HasWordModifier >>> l_Boolean
[code]  }
  function HasWordModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aModifier: TtfwWordModifier): Boolean;
   {* Реализация слова скрипта pop:WordInfo:HasWordModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasWordModifier
 
 TkwPopWordInfoIncludeTypeModifier = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeTypeModifier
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aType aWordInfo pop:WordInfo:IncludeTypeModifier >>> l_TtfwWordInfo
[code]  }
  function IncludeTypeModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aType: TtfwValueType): TtfwWordInfo;
   {* Реализация слова скрипта pop:WordInfo:IncludeTypeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeTypeModifier
 
 TkwPopWordInfoHasValueType = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasValueType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aType aWordInfo pop:WordInfo:HasValueType >>> l_Boolean
[code]  }
  function HasValueType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aType: TtfwValueType): Boolean;
   {* Реализация слова скрипта pop:WordInfo:HasValueType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasValueType
 
 TkwPopWordInfoAcceptsValue = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:AcceptsValue
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aValue aWordInfo pop:WordInfo:AcceptsValue >>> l_Boolean
[code]  }
  function AcceptsValue(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   const aValue: TtfwStackValue): Boolean;
   {* Реализация слова скрипта pop:WordInfo:AcceptsValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoAcceptsValue
 
 TkwPopWordInfoHasAccessType = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasAccessType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 anAccess aWordInfo pop:WordInfo:HasAccessType >>> l_Boolean
[code]  }
  function HasAccessType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anAccess: TtfwAccessType): Boolean;
   {* Реализация слова скрипта pop:WordInfo:HasAccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasAccessType
 
 TkwPopWordInfoIncludeAccesType = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeAccesType
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 anAccess aWordInfo pop:WordInfo:IncludeAccesType >>> l_TtfwWordInfo
[code]  }
  function IncludeAccesType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anAccess: TtfwAccessType): TtfwWordInfo;
   {* Реализация слова скрипта pop:WordInfo:IncludeAccesType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeAccesType
 
 TkwPopWordInfoValueTypes = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ValueTypes
*Тип результата:* TtfwValueTypes
*Пример:*
[code]
OBJECT VAR l_TtfwValueTypes
 aWordInfo pop:WordInfo:ValueTypes >>> l_TtfwValueTypes
[code]  }
  function ValueTypes(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwValueTypes;
   {* Реализация слова скрипта pop:WordInfo:ValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoValueTypes
 
 TkwPopWordInfoIncludeLinkType = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:IncludeLinkType
*Тип результата:* TtfwWordInfo
*Пример:*
[code]
OBJECT VAR l_TtfwWordInfo
 aLinkType aWordInfo pop:WordInfo:IncludeLinkType >>> l_TtfwWordInfo
[code]  }
  function IncludeLinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aLinkType: TtfwLinkType): TtfwWordInfo;
   {* Реализация слова скрипта pop:WordInfo:IncludeLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeLinkType
 
 TkwPopWordInfoHasLinkType = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:HasLinkType
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aLinkType aWordInfo pop:WordInfo:HasLinkType >>> l_Boolean
[code]  }
  function HasLinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aLinkType: TtfwLinkType): Boolean;
   {* Реализация слова скрипта pop:WordInfo:HasLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasLinkType
 
 TkwPopWordInfoCompare = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:Compare
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 anOther aWordInfo pop:WordInfo:Compare >>> l_Integer
[code]  }
  function Compare(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anOther: TtfwWordInfo): Integer;
   {* Реализация слова скрипта pop:WordInfo:Compare }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoCompare
 
 TkwPopWordInfoToString = class(TtfwClassLike)
  {* Слово скрипта pop:WordInfo:ToString
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:ToString >>> l_Il3CString
[code]  }
  function ToString(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Il3CString;
   {* Реализация слова скрипта pop:WordInfo:ToString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoToString
 
 TkwPopWordInfoTypeName = class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:TypeName
*Тип результата:* Il3CString
*Пример:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:TypeName >>> l_Il3CString
[code]  }
  function TypeName(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Il3CString;
   {* Реализация слова скрипта pop:WordInfo:TypeName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoTypeName
 
 TkwPopWordInfoLinkType = class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:LinkType
*Тип результата:* TtfwLinkType
*Пример:*
[code]
TtfwLinkType VAR l_TtfwLinkType
 aWordInfo pop:WordInfo:LinkType >>> l_TtfwLinkType
[code]  }
  function LinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwLinkType;
   {* Реализация слова скрипта pop:WordInfo:LinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoLinkType
 
 TkwPopWordInfoAccessType = class(TtfwPropertyLike)
  {* Слово скрипта pop:WordInfo:AccessType
*Тип результата:* TtfwAccessType
*Пример:*
[code]
TtfwAccessType VAR l_TtfwAccessType
 aWordInfo pop:WordInfo:AccessType >>> l_TtfwAccessType
[code]  }
  function AccessType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwAccessType;
   {* Реализация слова скрипта pop:WordInfo:AccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoAccessType
 
end.
