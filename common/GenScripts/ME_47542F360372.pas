unit NOT_FINISHED_eeTextSource;

// ������: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eeTextSource.pas"
// ���������: "SimpleClass"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTextSourceExport
;

type
 TeeTextSource = class(TeeTextSourceExport)
 end;//TeeTextSource
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(Nemesis)

end.
