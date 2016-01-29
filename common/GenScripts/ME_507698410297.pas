unit ObjectFromstackWords;

interface

uses
 l3IntfUses
 , tfwScriptingInterfaces
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , TypInfo
;

implementation

uses
 l3ImplUses
 , kwPopClassInherits
 , SysUtils
 , l3RTTI
 , tfwScriptingTypes
 , tfwTypeRegistrator
;

type
 TObjectFromstackWordsResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//TObjectFromstackWordsResNameGetter
 
 TkwPopObjectInherits = class(TtfwClassLike)
  {* ����� ������� pop:Object:Inherits
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aClass aObject pop:Object:Inherits >>> l_Boolean
[code]  }
  function Inherits(const aCtx: TtfwContext;
   aObject: TObject;
   const aClass: TtfwStackValue): Boolean;
   {* ���������� ����� ������� pop:Object:Inherits }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectInherits
 
 TkwPopObjectClassName = class(TtfwClassLike)
  {* ����� ������� pop:Object:ClassName
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aObject pop:Object:ClassName >>> l_String
[code]  }
  function ClassName(const aCtx: TtfwContext;
   aObject: TObject): AnsiString;
   {* ���������� ����� ������� pop:Object:ClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectClassName
 
 TkwPopObjectGetFloatProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:GetFloatProp
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetFloatProp >>> l_Integer
[code]  }
  function GetFloatProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Integer;
   {* ���������� ����� ������� pop:Object:GetFloatProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetFloatProp
 
 TkwPopObjectGetInterfaceProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:GetInterfaceProp
*��� ����������:* IUnknown
*������:*
[code]
INTERFACE VAR l_IUnknown
 aName aObject pop:Object:GetInterfaceProp >>> l_IUnknown
[code]  }
  function GetInterfaceProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): IUnknown;
   {* ���������� ����� ������� pop:Object:GetInterfaceProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetInterfaceProp
 
 TkwPopObjectGetObjProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:GetObjProp
*��� ����������:* TObject
*������:*
[code]
OBJECT VAR l_TObject
 aName aObject pop:Object:GetObjProp >>> l_TObject
[code]  }
  function GetObjProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): TObject;
   {* ���������� ����� ������� pop:Object:GetObjProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetObjProp
 
 TkwPopObjectGetOrdProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:GetOrdProp
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetOrdProp >>> l_Integer
[code]  }
  function GetOrdProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Integer;
   {* ���������� ����� ������� pop:Object:GetOrdProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetOrdProp
 
 TkwPopObjectGetStrProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:GetStrProp
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aName aObject pop:Object:GetStrProp >>> l_String
[code]  }
  function GetStrProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): AnsiString;
   {* ���������� ����� ������� pop:Object:GetStrProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetStrProp
 
 TkwPopObjectHasProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:HasProp
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aName aObject pop:Object:HasProp >>> l_Boolean
[code]  }
  function HasProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Boolean;
   {* ���������� ����� ������� pop:Object:HasProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectHasProp
 
 TkwPopObjectRTTIInfo = class(TtfwClassLike)
  {* ����� ������� pop:Object:RTTIInfo
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aObject pop:Object:RTTIInfo >>> l_String
[code]  }
  function RTTIInfo(const aCtx: TtfwContext;
   aObject: TObject): AnsiString;
   {* ���������� ����� ������� pop:Object:RTTIInfo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectRTTIInfo
 
 TkwPopObjectSetFloatProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:SetFloatProp
*������:*
[code]
 aValue aName aObject pop:Object:SetFloatProp
[code]  }
  procedure SetFloatProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   aValue: Integer);
   {* ���������� ����� ������� pop:Object:SetFloatProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetFloatProp
 
 TkwPopObjectSetOrdProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:SetOrdProp
*������:*
[code]
 aValue aName aObject pop:Object:SetOrdProp
[code]  }
  procedure SetOrdProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   aValue: Integer);
   {* ���������� ����� ������� pop:Object:SetOrdProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetOrdProp
 
 TkwPopObjectSetStrProp = class(TtfwClassLike)
  {* ����� ������� pop:Object:SetStrProp
*������:*
[code]
 aValue aName aObject pop:Object:SetStrProp
[code]  }
  procedure SetStrProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   const aValue: AnsiString);
   {* ���������� ����� ������� pop:Object:SetStrProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetStrProp
 
end.
