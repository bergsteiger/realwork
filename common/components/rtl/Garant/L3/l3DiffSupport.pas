unit l3DiffSupport;

{ $Id: l3DiffSupport.pas,v 1.1 2015/11/16 09:34:36 fireton Exp $ }

interface
uses
 l3Base,
 l3Diff;

function l3L2RP(aLocalProcAddr: Pointer): Tl3DiffReportProc;
procedure l3FreeRP(var theFunc: Tl3DiffReportProc);

function l3L2CF(aLocalProcAddr: Pointer): Tl3DiffCompareFunc;
procedure l3FreeCF(var theFunc: Tl3DiffCompareFunc);

implementation

function l3L2RP(aLocalProcAddr: Pointer): Tl3DiffReportProc; register;
asm
 jmp  l3LocalStub
end;

procedure l3FreeRP(var theFunc: Tl3DiffReportProc); register;
asm
 jmp  l3FreeLocalStub
end;

function l3L2CF(aLocalProcAddr: Pointer): Tl3DiffCompareFunc; register;
asm
 jmp  l3LocalStub
end;

procedure l3FreeCF(var theFunc: Tl3DiffCompareFunc); register;
asm
 jmp  l3FreeLocalStub
end;


end.