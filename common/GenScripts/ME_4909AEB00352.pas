unit nsINodeWrap;
 {* ���������� ���� ������ � ���������� ���������� � �������� ����� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeWrap.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsINodeWrap" MUID: (4909AEB00352)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeWrapBase
;

type
 TnsINodeWrap = class;

 InsNodeImplementationInfo = interface
  ['{93EEF340-A8DC-4727-A03A-E109D044C685}']
  function ChildNodeClass: RnsINodeWrap;
 end;//InsNodeImplementationInfo

 TnsINodeWrap = class(TnsINodeWrapBase, InsNodeImplementationInfo)
  {* ���������� ���� ������ � ���������� ���������� � �������� ����� }
  protected
   function ChildNodeClass: RnsINodeWrap;
 end;//TnsINodeWrap

implementation

uses
 l3ImplUses
;

function TnsINodeWrap.ChildNodeClass: RnsINodeWrap;
//#UC START# *48FEE3B402EB_4909AEB00352_var*
//#UC END# *48FEE3B402EB_4909AEB00352_var*
begin
//#UC START# *48FEE3B402EB_4909AEB00352_impl*
 Result := GetChildNodeClass;
//#UC END# *48FEE3B402EB_4909AEB00352_impl*
end;//TnsINodeWrap.ChildNodeClass

end.
