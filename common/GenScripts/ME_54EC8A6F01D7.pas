unit vtHintWordsPack;

interface

uses
 l3IntfUses
 , l3Interfaces
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;

implementation

uses
 l3ImplUses
 , vtHintManager
 , Windows
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwApplicationCancelHint = class(TtfwGlobalKeyWord)
  {* ����� ������� application:CancelHint
*������:*
[code]
 application:CancelHint
[code]  }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationCancelHint
 
 TkwApplicationIsHintVisible = class(TtfwGlobalKeyWord)
  {* ����� ������� application:IsHintVisible
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 application:IsHintVisible >>> l_Boolean
[code]  }
  function application_IsHintVisible(const aCtx: TtfwContext): Boolean;
   {* ���������� ����� ������� application:IsHintVisible }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationIsHintVisible
 
 TkwApplicationGetLastHint = class(TtfwGlobalKeyWord)
  {* ����� ������� application:GetLastHint
*��� ����������:* Il3CString
*������:*
[code]
STRING VAR l_Il3CString
 application:GetLastHint >>> l_Il3CString
[code]  }
  function application_GetLastHint(const aCtx: TtfwContext): Il3CString;
   {* ���������� ����� ������� application:GetLastHint }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwApplicationGetLastHint
 
end.
