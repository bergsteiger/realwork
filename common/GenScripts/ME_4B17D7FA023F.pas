unit bsBase;
 {* ������� ����� ������ ���� }

// ������: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\bsBase.pas"
// ���������: "SimpleClass"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3ProtoObject
 , l3IID
 , l3Interfaces
;

type
 _l3COMQueryInterface_Parent_ = Tl3ProtoObject;
 {$Include l3COMQueryInterface.imp.pas}
 TbsBase = class(_l3COMQueryInterface_)
  {* ������� ����� ������ ���� }
 end;//TbsBase
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , l3InterfacesMisc
;

{$Include l3COMQueryInterface.imp.pas}
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
