unit ServerFacade;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\ServerFacade.pas"
// ���������: "SimpleClass"

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
