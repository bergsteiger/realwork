unit nsComplectInfoRootNode;
 {* �������� ���� ������ � ����������� � ��������� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\Common\nsComplectInfoRootNode.pas"
// ���������: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsINodeRootWrap
 , nsINodeWrapBase
;

type
 TnsComplectInfoRootNode = class(TnsINodeRootWrap)
  {* �������� ���� ������ � ����������� � ��������� }
  protected
   function GetChildNodeClass: RnsINodeWrap; override;
    {* ���������� ������� ��������� ������ ���������� ��������� ���� }
 end;//TnsComplectInfoRootNode
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsComplectInfoNode
;

function TnsComplectInfoRootNode.GetChildNodeClass: RnsINodeWrap;
 {* ���������� ������� ��������� ������ ���������� ��������� ���� }
//#UC START# *490989330020_468276240241_var*
//#UC END# *490989330020_468276240241_var*
begin
//#UC START# *490989330020_468276240241_impl*
 Result := TnsComplectInfoNode;
//#UC END# *490989330020_468276240241_impl*
end;//TnsComplectInfoRootNode.GetChildNodeClass
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
