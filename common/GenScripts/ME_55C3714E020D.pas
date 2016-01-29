unit tfwValueTypesWordsPack;

interface

uses
 l3IntfUses
 , tfwValueTypes
 , l3Interfaces
 , tfwScriptingInterfaces
 , tfwClassLike
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopValueTypesCompare = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:Compare
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 anOther aValueTypes pop:ValueTypes:Compare >>> l_Integer
[code]  }
  function Compare(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   anOther: TtfwValueTypes): Integer;
   {* ���������� ����� ������� pop:ValueTypes:Compare }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesCompare
 
 TkwPopValueTypesAcceptsValue = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:AcceptsValue
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aValue aValueTypes pop:ValueTypes:AcceptsValue >>> l_Boolean
[code]  }
  function AcceptsValue(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   const aValue: TtfwStackValue): Boolean;
   {* ���������� ����� ������� pop:ValueTypes:AcceptsValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesAcceptsValue
 
 TkwPopValueTypesAdd = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:Add
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 anOther aValueTypes pop:ValueTypes:Add >>> l_TtfwValueTypes
[code]  }
  function Add(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   anOther: TtfwValueTypes): TtfwValueTypes;
   {* ���������� ����� ������� pop:ValueTypes:Add }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesAdd
 
 TkwPopValueTypesHas = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:Has
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aType aValueTypes pop:ValueTypes:Has >>> l_Boolean
[code]  }
  function Has(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   aType: TtfwValueType): Boolean;
   {* ���������� ����� ������� pop:ValueTypes:Has }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesHas
 
 TkwPopValueTypesEQ = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:EQ
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 anOther aValueTypes pop:ValueTypes:EQ >>> l_Boolean
[code]  }
  function EQ(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   anOther: TtfwValueTypes): Boolean;
   {* ���������� ����� ������� pop:ValueTypes:EQ }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesEQ
 
 TkwPopValueTypesDefaultValue = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:DefaultValue
*��� ����������:* TtfwStackValue
*������:*
[code]
VAR l_TtfwStackValue
 aValueTypes pop:ValueTypes:DefaultValue >>> l_TtfwStackValue
[code]  }
  function DefaultValue(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes): TtfwStackValue;
   {* ���������� ����� ������� pop:ValueTypes:DefaultValue }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesDefaultValue
 
 TkwPopValueTypesMakeCustomName = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:MakeCustomName
*��� ����������:* TtfwValueTypes
*������:*
[code]
OBJECT VAR l_TtfwValueTypes
 aName aValueTypes pop:ValueTypes:MakeCustomName >>> l_TtfwValueTypes
[code]  }
  function MakeCustomName(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   const aName: Il3CString): TtfwValueTypes;
   {* ���������� ����� ������� pop:ValueTypes:MakeCustomName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesMakeCustomName
 
 TkwPopValueTypesAccepts = class(TtfwClassLike)
  {* ����� ������� pop:ValueTypes:Accepts
*��� ����������:* TtfwValueTypesAccepts
*������:*
[code]
TtfwValueTypesAccepts VAR l_TtfwValueTypesAccepts
 anOther aValueTypes pop:ValueTypes:Accepts >>> l_TtfwValueTypesAccepts
[code]  }
  function Accepts(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes;
   anOther: TtfwValueTypes): TtfwValueTypesAccepts;
   {* ���������� ����� ������� pop:ValueTypes:Accepts }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesAccepts
 
 TkwPopValueTypesName = class(TtfwPropertyLike)
  {* ����� ������� pop:ValueTypes:Name
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 aValueTypes pop:ValueTypes:Name >>> l_Il3CString
[code]  }
  function Name(const aCtx: TtfwContext;
   aValueTypes: TtfwValueTypes): Il3CString;
   {* ���������� ����� ������� pop:ValueTypes:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopValueTypesName
 
end.
