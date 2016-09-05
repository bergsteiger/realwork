unit nsINodeOneLevelRootWrap;
 {* ������ �������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelRootWrap.pas"
// ���������: "SimpleClass"
// ������� ������: "TnsINodeOneLevelRootWrap" MUID: (468275C903C6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , nsINodeRootWrap
 , nsINodeWrapBase
;

type
 TnsINodeOneLevelRootWrap = class(TnsINodeRootWrap)
  {* ������ �������������� ������ }
  protected
   function GetChildNodeClass: RnsINodeWrap; override;
    {* ���������� ������� ��������� ������ ���������� ��������� ���� }
 end;//TnsINodeOneLevelRootWrap

implementation

uses
 l3ImplUses
 , nsINodeOneLevelWrap
 //#UC START# *468275C903C6impl_uses*
 //#UC END# *468275C903C6impl_uses*
;

function TnsINodeOneLevelRootWrap.GetChildNodeClass: RnsINodeWrap;
 {* ���������� ������� ��������� ������ ���������� ��������� ���� }
//#UC START# *490989330020_468275C903C6_var*
//#UC END# *490989330020_468275C903C6_var*
begin
//#UC START# *490989330020_468275C903C6_impl*
 Result := TnsINodeOneLevelWrap;
//#UC END# *490989330020_468275C903C6_impl*
end;//TnsINodeOneLevelRootWrap.GetChildNodeClass

end.
