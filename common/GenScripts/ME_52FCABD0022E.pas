unit NOT_FINISHED_SavedQuery;

// ������: "w:\common\components\rtl\Garant\DT\NOT_FINISHED_SavedQuery.pas"
// ���������: "SimpleClass"

{$Include DtDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , l3ProtoObject
;

type
 TSavedQuery = class(Tl3ProtoObject)
 end;//TSavedQuery
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Nemesis)

end.
