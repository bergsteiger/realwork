program AutoPipeServerTest;
 {* ����� ������� ������������� ����������� }

// ������: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTest.dpr"
// ���������: "TestTarget"
// ������� ������: "AutoPipeServer" MUID: (52F24F6103AB)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(AppServerSide)

implementation

{$If Defined(AppServerSide)}
uses
 l3ImplUses
;
{$IfEnd} // Defined(AppServerSide)

end.
