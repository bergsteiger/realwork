program AutoPipeServerTest;
 {* ����� ������� ������������� ����������� }

// ������: "w:\archi\source\projects\PipeInAuto\AutoPipeServerTest.dpr"
// ���������: "TestTarget"

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
