unit l3NodesKeyWordsPack;

interface

uses
 l3IntfUses
 , l3TreeInterfaces
 , l3Interfaces
 , tfwAxiomaticsResNameGetter
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
 Tl3NodesKeyWordsPackResNameGetter = class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  function ResName: AnsiString;
 end;//Tl3NodesKeyWordsPackResNameGetter
 
 TkwNodeIsFirst = class(TtfwPropertyLike)
  {* ����� ������� Node:IsFirst
[panel]���� ������?[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsFirst >>> l_Boolean
[code]  }
  function IsFirst(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����� ������� Node:IsFirst }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIsFirst
 
 TkwNodeIsLast = class(TtfwPropertyLike)
  {* ����� ������� Node:IsLast
[panel]���� ���������?[panel]
*��� ����������:* Boolean
*������:*
[code]
BOOLEAN VAR l_Boolean
 aNode Node:IsLast >>> l_Boolean
[code]  }
  function IsLast(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Boolean;
   {* ���������� ����� ������� Node:IsLast }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeIsLast
 
 TkwNodeFlags = class(TtfwPropertyLike)
  {* ����� ������� Node:Flags
[panel]����� ����[panel]
*��� ����������:* Integer
*������:*
[code]
INTEGER VAR l_Integer
 aNode Node:Flags >>> l_Integer
[code]  }
  function Flags(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Integer;
   {* ���������� ����� ������� Node:Flags }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeFlags
 
 TkwNodeText = class(TtfwPropertyLike)
  {* ����� ������� Node:Text
[panel]����� ����[panel]
*��� ����������:* Tl3WString
*������:*
[code]
STRING VAR l_Tl3WString
 aNode Node:Text >>> l_Tl3WString
[code]  }
  function Text(const aCtx: TtfwContext;
   const aNode: Il3SimpleNode): Tl3WString;
   {* ���������� ����� ������� Node:Text }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwNodeText
 
end.
