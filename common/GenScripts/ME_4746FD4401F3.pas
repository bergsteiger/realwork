unit ServerFacade;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ServerFacade.pas"
// ���������: "SimpleClass"
// ������� ������: "ServerFacade" MUID: (4746FD4401F3)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 ServerFacade = {abstract} class
  public
   procedure get_server_interface(facet: PAnsiChar); virtual; abstract;
 end;//ServerFacade

implementation

uses
 l3ImplUses
;

end.
