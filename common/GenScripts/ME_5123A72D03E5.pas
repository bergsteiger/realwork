program AdminAppTest;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\AdminAppTest.dpr"
// Стереотип: "VCMTestTarget"

{$Include nsDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(Admin)

end.
