unit NOT_FINISHED_nsNodes;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Data"
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/Data/Tree/NOT_FINISHED_nsNodes.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> F1 ������� ����������� ���������� �������::LegalDomain::Data::OldTree::nsNodes
//
// ���� �������� �������.
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ���� ���� ������������ ������ ��� �������������, � �� ��� ����������. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  Classes
  {$If not defined(Admin)}
  ,
  nsWrapperNode
  {$IfEnd} //not Admin
  ,
  nsBaseNode,
  l3Tree_TLB
  ;

type
 RnsCacheableNode = class of TnsCacheableNode;

 TnsCacheableNode = class(TnsBaseNode)
 protected
 // realized methods
   function Get_IsFirst: Boolean;
   function Get_IsLast: Boolean;
 end;//TnsCacheableNode

 TnsRootNode = nsWrapperNode.TnsWrapperNode;

procedure NsGetCaption; overload; 
   {* �������� �������� ����������� ����. }
procedure NsMakeTreeLevel;
   {* ��������� ������ nsMakeTreeLevel }
procedure NsGetCaption; overload; 
   {* ��������� ������ nsGetCaption }
procedure NsGetHint;
   {* ��������� ������ nsGetHint }

implementation

// unit methods

procedure NsMakeTreeLevel;
//#UC START# *4ABB8B1B031D_47F60E8E019C_var*
//#UC END# *4ABB8B1B031D_47F60E8E019C_var*
begin
//#UC START# *4ABB8B1B031D_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ABB8B1B031D_47F60E8E019C_impl*
end;//NsMakeTreeLevel
// start class TnsCacheableNode

function TnsCacheableNode.Get_IsFirst: Boolean;
//#UC START# *5481A1DD0225_4ADDF46000A4get_var*
//#UC END# *5481A1DD0225_4ADDF46000A4get_var*
begin
//#UC START# *5481A1DD0225_4ADDF46000A4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1DD0225_4ADDF46000A4get_impl*
end;//TnsCacheableNode.Get_IsFirst

function TnsCacheableNode.Get_IsLast: Boolean;
//#UC START# *5481A1EA00F3_4ADDF46000A4get_var*
//#UC END# *5481A1EA00F3_4ADDF46000A4get_var*
begin
//#UC START# *5481A1EA00F3_4ADDF46000A4get_impl*
 !!! Needs to be implemented !!!
//#UC END# *5481A1EA00F3_4ADDF46000A4get_impl*
end;//TnsCacheableNode.Get_IsLast

procedure NsGetCaption;
//#UC START# *4ADDF529018F_47F60E8E019C_var*
//#UC END# *4ADDF529018F_47F60E8E019C_var*
begin
//#UC START# *4ADDF529018F_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDF529018F_47F60E8E019C_impl*
end;//NsGetCaption

procedure NsGetHint;
//#UC START# *4ADDF53403CA_47F60E8E019C_var*
//#UC END# *4ADDF53403CA_47F60E8E019C_var*
begin
//#UC START# *4ADDF53403CA_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADDF53403CA_47F60E8E019C_impl*
end;//NsGetHint

procedure NsGetCaption;
//#UC START# *47F60EC50128_47F60E8E019C_var*
//#UC END# *47F60EC50128_47F60E8E019C_var*
begin
//#UC START# *47F60EC50128_47F60E8E019C_impl*
 !!! Needs to be implemented !!!
//#UC END# *47F60EC50128_47F60E8E019C_impl*
end;//NsGetCaption

end.