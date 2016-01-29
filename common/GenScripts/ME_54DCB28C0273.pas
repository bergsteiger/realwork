unit VCMFormsProcessingPack;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , tfwPropertyLike
 , tfwScriptingInterfaces
 , tfwTypeInfo
 , TypInfo
;

implementation

uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopFormIsFloatingStateAndParentNotVisible = class(TtfwPropertyLike)
  {* ����� ������� pop:Form:IsFloatingStateAndParentNotVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingStateAndParentNotVisible >>> l_Boolean
[code]  }
  function IsFloatingStateAndParentNotVisible(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Boolean;
   {* ���������� ����� ������� pop:Form:IsFloatingStateAndParentNotVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormIsFloatingStateAndParentNotVisible
 
 TkwPopFormIsFloatingState = class(TtfwPropertyLike)
  {* ����� ������� pop:Form:IsFloatingState
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aForm pop:Form:IsFloatingState >>> l_Boolean
[code]  }
  function IsFloatingState(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Boolean;
   {* ���������� ����� ������� pop:Form:IsFloatingState }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormIsFloatingState
 
 TkwPopFormUserType = class(TtfwPropertyLike)
  {* ����� ������� pop:Form:UserType
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aForm pop:Form:UserType >>> l_Integer
[code]  }
  function UserType(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): Integer;
   {* ���������� ����� ������� pop:Form:UserType }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormUserType
 
 TkwPopFormFormID = class(TtfwPropertyLike)
  {* ����� ������� pop:Form:FormID
*��� ����������:* String
*������:*
[code]
STRING VAR l_String
 aForm pop:Form:FormID >>> l_String
[code]  }
  function FormID(const aCtx: TtfwContext;
   aForm: TvcmEntityForm): AnsiString;
   {* ���������� ����� ������� pop:Form:FormID }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopFormFormID
 
end.
