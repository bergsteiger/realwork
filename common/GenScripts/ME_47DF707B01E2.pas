unit vcmNodes;

interface

uses
 l3IntfUses
 , l3ProtoDataContainer
 , vcmExternalInterfaces
;

type
 TvcmNodes = class(_l3InterfaceRefList_, IvcmNodes)
  {* Список нод. }
  function MakeI: IvcmNodes;
  function Current: IvcmNode;
   {* Текущая нода. }
  function PlainLevel: Integer;
  function ShowRoot: Boolean;
  function Tree: IvcmTree;
  function Count: Integer;
   {* Число элементов. }
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
