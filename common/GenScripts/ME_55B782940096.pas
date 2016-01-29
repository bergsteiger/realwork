unit vtComboTreeWordsPack;

interface

uses
 l3IntfUses
 , vtComboTree
 , l3TreeInterfaces
 , tfwClassLike
 , tfwScriptingInterfaces
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
 TkwPopComboTreeCurrentNode = class(TtfwClassLike)
  {* ����� ������� pop:ComboTree:CurrentNode
*��� ����������:* Il3SimpleNode
*������:*
[code]
INTERFACE VAR l_Il3SimpleNode
 aComboTree pop:ComboTree:CurrentNode >>> l_Il3SimpleNode
[code]  }
  function CurrentNode(const aCtx: TtfwContext;
   aComboTree: TvtComboTree): Il3SimpleNode;
   {* ���������� ����� ������� pop:ComboTree:CurrentNode }
  procedure DoDoIt(const aCtx: TtfwContext);
 end;//TkwPopComboTreeCurrentNode
 
end.
