unit F1_Schema;

// ������: "w:\common\components\gui\Garant\Everest_Engine\F1_Schema.pas"
// ���������: "TagTable"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , Everest_Schema
;

type
 // TF1Schema
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeDocument_Schema
 , F1_AttrValues
;

initialization
 TF1Schema.SetAsDefault;
{$IfEnd} // Defined(Nemesis)

end.
