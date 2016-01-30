unit DocTreeUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocTreeUnit.pas"
// Стереотип: "Interfaces"

{$Include nsDefine.inc}

interface

uses
 l3IntfUses
 , DynamicTreeUnit
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeDefinesUnit
;

type
 TTagHandle = Cardinal;
  {* EVD-тег ноды }

 IDocNodeFilter = interface(IFilterForTree)
  {* Фильтр для поиска ноды документа }
  ['{8BEEB7B1-6BD1-4BAF-8071-9A7FD1FF2E59}']
  function Get_id: TTagHandle;
  procedure Set_id(aValue: TTagHandle);
  function Get_inheritable: Boolean;
  procedure Set_inheritable(aValue: Boolean);
  function Get_type: TNodeType;
  procedure Set_type(aValue: TNodeType);
  property id: TTagHandle
   read Get_id
   write Set_id;
  property inheritable: Boolean
   read Get_inheritable
   write Set_inheritable;
  property type: TNodeType
   read Get_type
   write Set_type;
 end;//IDocNodeFilter

 IContentsNode = interface(INodeBase)
  ['{1D59A8F6-CE4D-4737-B812-85904356F82B}']
 end;//IContentsNode

class function make: BadFactoryType;

implementation

uses
 l3ImplUses
;

class function make: BadFactoryType;
var
 l_Inst : IContentsNode;
begin
 l_Inst := Create;
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//make

end.
