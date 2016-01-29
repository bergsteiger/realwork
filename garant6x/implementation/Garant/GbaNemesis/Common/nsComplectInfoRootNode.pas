unit nsComplectInfoRootNode;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Common$Lib"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Common/nsComplectInfoRootNode.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> F1 Core::Common::Common$Lib::ComplectInfo::TnsComplectInfoRootNode
//
// �������� ���� ������ � ����������� � ���������
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsINodeRootWrap,
  nsINodeWrapBase
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
type
 TnsComplectInfoRootNode = class(TnsINodeRootWrap)
  {* �������� ���� ������ � ����������� � ��������� }
 protected
 // overridden protected methods
   function GetChildNodeClass: RnsINodeWrap; override;
     {* ���������� ������� ��������� ������ ���������� ��������� ���� }
 end;//TnsComplectInfoRootNode
{$IfEnd} //not Admin AND not Monitorings

implementation

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  nsComplectInfoNode
  ;
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}

// start class TnsComplectInfoRootNode

function TnsComplectInfoRootNode.GetChildNodeClass: RnsINodeWrap;
//#UC START# *490989330020_468276240241_var*
//#UC END# *490989330020_468276240241_var*
begin
//#UC START# *490989330020_468276240241_impl*
 Result := TnsComplectInfoNode;
//#UC END# *490989330020_468276240241_impl*
end;//TnsComplectInfoRootNode.GetChildNodeClass

{$IfEnd} //not Admin AND not Monitorings

end.