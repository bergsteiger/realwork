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
  {* Регистрация скриптованой аксиоматики }
  function ResName: AnsiString;
 end;//TObjectFromstackWordsResNameGetter
 
 TkwPopObjectInherits = class(TtfwClassLike)
  {* Слово скрипта pop:Object:Inherits
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aClass aObject pop:Object:Inherits >>> l_Boolean
[code]  }
  function Inherits(const aCtx: TtfwContext;
   aObject: TObject;
   const aClass: TtfwStackValue): Boolean;
   {* Реализация слова скрипта pop:Object:Inherits }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectInherits
 
 TkwPopObjectClassName = class(TtfwClassLike)
  {* Слово скрипта pop:Object:ClassName
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aObject pop:Object:ClassName >>> l_String
[code]  }
  function ClassName(const aCtx: TtfwContext;
   aObject: TObject): AnsiString;
   {* Реализация слова скрипта pop:Object:ClassName }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectClassName
 
 TkwPopObjectGetFloatProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetFloatProp
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetFloatProp >>> l_Integer
[code]  }
  function GetFloatProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Integer;
   {* Реализация слова скрипта pop:Object:GetFloatProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetFloatProp
 
 TkwPopObjectGetInterfaceProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetInterfaceProp
*Тип результата:* IUnknown
*Пример:*
[code]
INTERFACE VAR l_IUnknown
 aName aObject pop:Object:GetInterfaceProp >>> l_IUnknown
[code]  }
  function GetInterfaceProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): IUnknown;
   {* Реализация слова скрипта pop:Object:GetInterfaceProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetInterfaceProp
 
 TkwPopObjectGetObjProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetObjProp
*Тип результата:* TObject
*Пример:*
[code]
OBJECT VAR l_TObject
 aName aObject pop:Object:GetObjProp >>> l_TObject
[code]  }
  function GetObjProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): TObject;
   {* Реализация слова скрипта pop:Object:GetObjProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetObjProp
 
 TkwPopObjectGetOrdProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetOrdProp
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aName aObject pop:Object:GetOrdProp >>> l_Integer
[code]  }
  function GetOrdProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Integer;
   {* Реализация слова скрипта pop:Object:GetOrdProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetOrdProp
 
 TkwPopObjectGetStrProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:GetStrProp
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aName aObject pop:Object:GetStrProp >>> l_String
[code]  }
  function GetStrProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): AnsiString;
   {* Реализация слова скрипта pop:Object:GetStrProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectGetStrProp
 
 TkwPopObjectHasProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:HasProp
*Тип результата:* Boolean
*Пример:*
[code]
BOOLEAN VAR l_Boolean
 aName aObject pop:Object:HasProp >>> l_Boolean
[code]  }
  function HasProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString): Boolean;
   {* Реализация слова скрипта pop:Object:HasProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectHasProp
 
 TkwPopObjectRTTIInfo = class(TtfwClassLike)
  {* Слово скрипта pop:Object:RTTIInfo
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aObject pop:Object:RTTIInfo >>> l_String
[code]  }
  function RTTIInfo(const aCtx: TtfwContext;
   aObject: TObject): AnsiString;
   {* Реализация слова скрипта pop:Object:RTTIInfo }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectRTTIInfo
 
 TkwPopObjectSetFloatProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetFloatProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetFloatProp
[code]  }
  procedure SetFloatProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   aValue: Integer);
   {* Реализация слова скрипта pop:Object:SetFloatProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetFloatProp
 
 TkwPopObjectSetOrdProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetOrdProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetOrdProp
[code]  }
  procedure SetOrdProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   aValue: Integer);
   {* Реализация слова скрипта pop:Object:SetOrdProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetOrdProp
 
 TkwPopObjectSetStrProp = class(TtfwClassLike)
  {* Слово скрипта pop:Object:SetStrProp
*Пример:*
[code]
 aValue aName aObject pop:Object:SetStrProp
[code]  }
  procedure SetStrProp(const aCtx: TtfwContext;
   aObject: TObject;
   const aName: AnsiString;
   const aValue: AnsiString);
   {* Реализация слова скрипта pop:Object:SetStrProp }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopObjectSetStrProp
 
end.
