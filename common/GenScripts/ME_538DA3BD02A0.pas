unit NOT_FINISHED_CsQueryRequester;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_CsQueryRequester.pas"
// Стереотип: "UtilityPack"

{$Include CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
;

type
 TCsQueryProc = procedure;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , CsQueryRequesterTool
;
{$IfEnd} // NOT Defined(Nemesis)

end.
