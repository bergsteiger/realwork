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
  {* ����� ������� pop:Component:GetComponent
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 anIndex aComponent pop:Component:GetComponent >>> l_TComponent
[code]  }
  function GetComponent(const aCtx: TtfwContext;
   aComponent: TComponent;
   anIndex: Integer): TComponent;
   {* ���������� ����� ������� pop:Component:GetComponent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentGetComponent
 
 TkwPopComponentFindComponent = class(TtfwClassLike)
  {* ����� ������� pop:Component:FindComponent
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aName aComponent pop:Component:FindComponent >>> l_TComponent
[code]  }
  function FindComponent(const aCtx: TtfwContext;
   aComponent: TComponent;
   const aName: AnsiString): TComponent;
   {* ���������� ����� ������� pop:Component:FindComponent }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentFindComponent
 
 TkwPopComponentComponentCount = class(TtfwPropertyLike)
  {* ����� ������� pop:Component:ComponentCount
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aComponent pop:Component:ComponentCount >>> l_Integer
[code]  }
  function ComponentCount(const aCtx: TtfwContext;
   aComponent: TComponent): Integer;
   {* ���������� ����� ������� pop:Component:ComponentCount }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentComponentCount
 
 TkwPopComponentOwner = class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Owner
*��� ����������:* TComponent
*������:*
[code]
OBJECT VAR l_TComponent
 aComponent pop:Component:Owner >>> l_TComponent
[code]  }
  function Owner(const aCtx: TtfwContext;
   aComponent: TComponent): TComponent;
   {* ���������� ����� ������� pop:Component:Owner }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentOwner
 
 TkwPopComponentName = class(TtfwPropertyLike)
  {* ����� ������� pop:Component:Name
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aComponent pop:Component:Name >>> l_String
[code]  }
  function Name(const aCtx: TtfwContext;
   aComponent: TComponent): AnsiString;
   {* ���������� ����� ������� pop:Component:Name }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComponentName
 
end.
