unit l3CastablePersistent;
 {* TPersistent � ������� QueryInterface. }

// ������: "w:\common\components\rtl\Garant\L3\l3CastablePersistent.pas"
// ���������: "SimpleClass"
// ������� ������: "Tl3CastablePersistent" MUID: (47A0D67B03E2)

{$Include w:\common\components\rtl\Garant\L3\l3Define.inc}

interface

uses
 l3IntfUses
 , Classes
 , l3Interfaces
;

type
 _l3Castable_Parent_ = TPersistent;
 {$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}
 Tl3CastablePersistent = {abstract} class(_l3Castable_)
  {* TPersistent � ������� QueryInterface. }
 end;//Tl3CastablePersistent

implementation

uses
 l3ImplUses
;

{$Include w:\common\components\rtl\Garant\L3\l3Castable.imp.pas}

end.
