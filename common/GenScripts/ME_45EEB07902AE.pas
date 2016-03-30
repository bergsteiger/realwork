unit DocTreeUnit;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocTreeUnit.pas"
// Стереотип: "Interfaces"
// Элемент модели: "DocTree" MUID: (45EEB07902AE)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , IOUnit
 , BaseTypesUnit
 , DynamicTreeUnit
 , ExternalObjectUnit
 , DynamicTreeDefinesUnit
;

type
 TTagHandle = Cardinal;
  {* EVD-тег ноды }

 IDocNodeFilter = interface(IFilterForTree)
  {* Фильтр для поиска ноды документа }
  ['{8BEEB7B1-6BD1-4BAF-8071-9A7FD1FF2E59}']
  function GetId: TTagHandle; stdcall;
  procedure SetId(aValue: TTagHandle); stdcall;
  function GetInheritable: ByteBool; stdcall;
  procedure SetInheritable(const aValue: ByteBool); stdcall;
  function GetType: TNodeType; stdcall;
  procedure SetType(aValue: TNodeType); stdcall;
  property Id: TTagHandle
   read GetId
   write SetId;
  property Inheritable: ByteBool
   read GetInheritable
   write SetInheritable;
  property Type: TNodeType
   read GetType
   write SetType;
 end;//IDocNodeFilter

 IContentsNode = interface(INodeBase)
  ['{1D59A8F6-CE4D-4737-B812-85904356F82B}']
 end;//IContentsNode

implementation

uses
 l3ImplUses
;

end.
