unit memmgr;

interface

implementation

function malloc(size:integer):pointer;stdcall;external 'memmgr.dll' name 'alp_malloc';
procedure free(blk:pointer);stdcall;external 'memmgr.dll' name 'alp_free';
function realloc(blk:pointer;newsize:integer):pointer;stdcall;external 'memmgr.dll' name 'alp_realloc';

function dmalloc(size:integer):pointer;
begin
  result:=malloc(size);
end;

function dfree(blk:pointer):integer;
begin
  free(blk);
  result:=0;
end;

function drealloc(blk:pointer;newsize:integer):pointer;
begin
  result:=realloc(blk,newsize);
end;

var
  alp_memmgr:TMemoryManager;

begin
  alp_memmgr.GetMem:=dmalloc;
  alp_memmgr.FreeMem:=dfree;
  alp_memmgr.ReallocMem:=drealloc;
  SetMemoryManager(alp_memmgr);
end.
