unit EverestLiteTests_TestLibrary;

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\Tests\EverestLiteTests_TestLibrary.pas"
// ���������: "TestLibrary"
// ������� ������: "EverestLiteTests" MUID: (512B1731031D)

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , EverestLiteTests_FileFormatTests_TestUnit
 , EverestLiteTests_PreivewTests_TestUnit
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

end.
