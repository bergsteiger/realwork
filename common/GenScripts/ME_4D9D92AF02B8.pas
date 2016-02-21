unit DocWithPid;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DocWithPid.pas"
// Стереотип: "SimpleClass"

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
;

type
 DocWithPid = {abstract} class
  public
   procedure get_document_pid; virtual; abstract;
 end;//DocWithPid

implementation

uses
 l3ImplUses
;

end.
