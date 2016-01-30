unit nsINodeOneLevelRootWrap;
 {* ������ �������������� ������ }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Data\Tree\nsINodeOneLevelRootWrap.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

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
