unit eeDocument_Schema;

// ������: "w:\common\components\gui\Garant\Everest_Engine\eeDocument_Schema.pas"
// ���������: "TagTable"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , F1_Schema
;

type
 // TeeDocumentSchema
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;

initialization
 TeeDocumentSchema.SetAsDefault;
{$IfEnd} // Defined(Nemesis)

end.
