unit vcmNodes;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmExternalInterfaces
;

type
 TvcmNodes = class(_l3InterfaceRefList_, IvcmNodes)
  {* ������ ���. }
  function MakeI: IvcmNodes;
  function Current: IvcmNode;
   {* ������� ����. }
  function PlainLevel: Integer;
  function ShowRoot: Boolean;
  function Tree: IvcmTree;
  function Count: Integer;
   {* ����� ���������. }
 end;//TvcmNodes
 
implementation

uses
 l3ImplUses
 , l3Base
 , l3MinMax
 , RTLConsts
 , SysUtils
;

end.
