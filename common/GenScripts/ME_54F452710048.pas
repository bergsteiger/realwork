unit ComponentsProcessingPack;

interface

uses
 l3IntfUses
 , Classes
 , tfwClassLike
 , tfwScriptingInterfaces
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
 TkwPopComponentGetComponent = class(TtfwClassLike)
  {* Слово скрипта pop:Component:GetComponent
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 anIndex aComponent pop:Component:GetComponent >>> l_TComponent
[code]  }
  function GetComponent(const aCtx: TtfwContext;
   aComponent: TComponent;
   anIndex: Integer): TComponent;
   {* Реализация слова скрипта pop:Component:GetComponent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentGetComponent
 
 TkwPopComponentFindComponent = class(TtfwClassLike)
  {* Слово скрипта pop:Component:FindComponent
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aName aComponent pop:Component:FindComponent >>> l_TComponent
[code]  }
  function FindComponent(const aCtx: TtfwContext;
   aComponent: TComponent;
   const aName: AnsiString): TComponent;
   {* Реализация слова скрипта pop:Component:FindComponent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentFindComponent
 
 TkwPopComponentComponentCount = class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:ComponentCount
*Тип результата:* Integer
*Пример:*
[code]
INTEGER VAR l_Integer
 aComponent pop:Component:ComponentCount >>> l_Integer
[code]  }
  function ComponentCount(const aCtx: TtfwContext;
   aComponent: TComponent): Integer;
   {* Реализация слова скрипта pop:Component:ComponentCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentComponentCount
 
 TkwPopComponentOwner = class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:Owner
*Тип результата:* TComponent
*Пример:*
[code]
OBJECT VAR l_TComponent
 aComponent pop:Component:Owner >>> l_TComponent
[code]  }
  function Owner(const aCtx: TtfwContext;
   aComponent: TComponent): TComponent;
   {* Реализация слова скрипта pop:Component:Owner }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentOwner
 
 TkwPopComponentName = class(TtfwPropertyLike)
  {* Слово скрипта pop:Component:Name
*Тип результата:* String
*Пример:*
[code]
STRING VAR l_String
 aComponent pop:Component:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aComponent: TComponent): AnsiString;
   {* Реализация слова скрипта pop:Component:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentName
 
end.
