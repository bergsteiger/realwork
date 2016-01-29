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
  {* ����� ������� pop:WordInfo:IncludeModifier
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aModifier aWordInfo pop:WordInfo:IncludeModifier >>> l_TtfwWordInfo
[code]  }
  function IncludeModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aModifier: TtfwWordModifier): TtfwWordInfo;
   {* ���������� ����� ������� pop:WordInfo:IncludeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeModifier
 
 TkwPopWordInfoEmpty = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:Empty
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aWordInfo pop:WordInfo:Empty >>> l_Boolean
[code]  }
  function Empty(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Boolean;
   {* ���������� ����� ������� pop:WordInfo:Empty }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoEmpty
 
 TkwPopWordInfoHasWordModifier = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasWordModifier
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aModifier aWordInfo pop:WordInfo:HasWordModifier >>> l_Boolean
[code]  }
  function HasWordModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aModifier: TtfwWordModifier): Boolean;
   {* ���������� ����� ������� pop:WordInfo:HasWordModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasWordModifier
 
 TkwPopWordInfoIncludeTypeModifier = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeTypeModifier
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aType aWordInfo pop:WordInfo:IncludeTypeModifier >>> l_TtfwWordInfo
[code]  }
  function IncludeTypeModifier(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aType: TtfwValueType): TtfwWordInfo;
   {* ���������� ����� ������� pop:WordInfo:IncludeTypeModifier }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeTypeModifier
 
 TkwPopWordInfoHasValueType = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasValueType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aType aWordInfo pop:WordInfo:HasValueType >>> l_Boolean
[code]  }
  function HasValueType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aType: TtfwValueType): Boolean;
   {* ���������� ����� ������� pop:WordInfo:HasValueType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasValueType
 
 TkwPopWordInfoAcceptsValue = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:AcceptsValue
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aValue aWordInfo pop:WordInfo:AcceptsValue >>> l_Boolean
[code]  }
  function AcceptsValue(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   const aValue: TtfwStackValue): Boolean;
   {* ���������� ����� ������� pop:WordInfo:AcceptsValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoAcceptsValue
 
 TkwPopWordInfoHasAccessType = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasAccessType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anAccess aWordInfo pop:WordInfo:HasAccessType >>> l_Boolean
[code]  }
  function HasAccessType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anAccess: TtfwAccessType): Boolean;
   {* ���������� ����� ������� pop:WordInfo:HasAccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasAccessType
 
 TkwPopWordInfoIncludeAccesType = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeAccesType
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 anAccess aWordInfo pop:WordInfo:IncludeAccesType >>> l_TtfwWordInfo
[code]  }
  function IncludeAccesType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anAccess: TtfwAccessType): TtfwWordInfo;
   {* ���������� ����� ������� pop:WordInfo:IncludeAccesType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeAccesType
 
 TkwPopWordInfoValueTypes = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:ValueTypes
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 aWordInfo pop:WordInfo:ValueTypes >>> l_TtfwValueTypes
[code]  }
  function ValueTypes(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwValueTypes;
   {* ���������� ����� ������� pop:WordInfo:ValueTypes }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoValueTypes
 
 TkwPopWordInfoIncludeLinkType = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:IncludeLinkType
*��� ����������:* TtfwWordInfo
*������:*
[code]
OBJECT VAR l_TtfwWordInfo
 aLinkType aWordInfo pop:WordInfo:IncludeLinkType >>> l_TtfwWordInfo
[code]  }
  function IncludeLinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aLinkType: TtfwLinkType): TtfwWordInfo;
   {* ���������� ����� ������� pop:WordInfo:IncludeLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoIncludeLinkType
 
 TkwPopWordInfoHasLinkType = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:HasLinkType
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aLinkType aWordInfo pop:WordInfo:HasLinkType >>> l_Boolean
[code]  }
  function HasLinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   aLinkType: TtfwLinkType): Boolean;
   {* ���������� ����� ������� pop:WordInfo:HasLinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoHasLinkType
 
 TkwPopWordInfoCompare = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:Compare
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aWordInfo pop:WordInfo:Compare >>> l_Integer
[code]  }
  function Compare(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo;
   anOther: TtfwWordInfo): Integer;
   {* ���������� ����� ������� pop:WordInfo:Compare }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoCompare
 
 TkwPopWordInfoToString = class(TtfwClassLike)
  {* ����� ������� pop:WordInfo:ToString
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:ToString >>> l_Il3CString
[code]  }
  function ToString(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Il3CString;
   {* ���������� ����� ������� pop:WordInfo:ToString }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoToString
 
 TkwPopWordInfoTypeName = class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:TypeName
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aWordInfo pop:WordInfo:TypeName >>> l_Il3CString
[code]  }
  function TypeName(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): Il3CString;
   {* ���������� ����� ������� pop:WordInfo:TypeName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoTypeName
 
 TkwPopWordInfoLinkType = class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:LinkType
*��� ����������:* TtfwLinkType
*������:*
[code]
TtfwLinkType VAR l_TtfwLinkType
 aWordInfo pop:WordInfo:LinkType >>> l_TtfwLinkType
[code]  }
  function LinkType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwLinkType;
   {* ���������� ����� ������� pop:WordInfo:LinkType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoLinkType
 
 TkwPopWordInfoAccessType = class(TtfwPropertyLike)
  {* ����� ������� pop:WordInfo:AccessType
*��� ����������:* TtfwAccessType
*������:*
[code]
TtfwAccessType VAR l_TtfwAccessType
 aWordInfo pop:WordInfo:AccessType >>> l_TtfwAccessType
[code]  }
  function AccessType(const aCtx: TtfwContext;
   aWordInfo: TtfwWordInfo): TtfwAccessType;
   {* ���������� ����� ������� pop:WordInfo:AccessType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopWordInfoAccessType
 
end.
