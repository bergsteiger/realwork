unit main;

interface

uses
  orb_int,orb,req_int,code_int,imr,imr_int,env_int,except_int,types,
  stdstat,std_seq,poa,poa_int,value_int,classes,sequence_int, sequence;

type

  Tfoo_impl = class(Tfoo_stub)
    function bar(const s1: TS; var s2: TS; out s3: TS): TS; override;
    function bar2(const s1: TSSeq; var s2: TSSeq; out s3: TSSeq): TSSeq; override;
    procedure bar3(const s: TStringSeq); override;
  end;

  procedure mainproc;

implementation

uses
  ior,
  iior_int,
  sysutils,
  boa_int;

//***********************************************************
// foo_impl
//***********************************************************
function Tfoo_impl.bar(const s1: TS; var s2: TS; out s3: TS): TS;
var
  i,l : integer;
begin
  writeln('#4');
  writeln('ULong '+inttostr(s1.x));
  write('Sequence ');
  l := Length(s1.seq);
  for i := 0 to Pred(l) do
    write(inttostr(s1.seq[i])+' ');
  writeln;
  writeln;
  writeln('#5');
  writeln('ULong '+inttostr(s2.x));
  write('Sequence ');
  l := Length(s2.seq);
  for i := 0 to Pred(l) do
    write(inttostr(s2.seq[i])+' ');
  writeln;
  writeln;
  s2.x := 54321;
  setLength(s2.seq,0);

  s3 := s1;
  result := s1;
end;

function Tfoo_impl.bar2(const s1: TSSeq; var s2: TSSeq; out s3: TSSeq): TSSeq;
var
  i,l,j,l2 : integer;
begin
  writeln('#6');
  l := Length(s1);
  for i := 0 to Pred(l) do
    begin
      writeln('['+inttostr(i)+']');
      writeln('ULong '+inttostr(s1[i].x));
      write('Sequence ');
      l2 := Length(s1[i].seq);
      for j := 0 to Pred(l2) do
        write(inttostr(s1[i].seq[j])+' ');
      writeln;
      writeln;
    end;
  writeln;
  writeln('#7');
  l := Length(s2);
  for i := 0 to Pred(l) do
    begin
      writeln('['+inttostr(i)+']');
      writeln('ULong '+inttostr(s2[i].x));
      write('Sequence ');
      l2 := Length(s2[i].seq);
      for j := 0 to Pred(l2) do
        write(inttostr(s2[i].seq[j])+' ');
      writeln;
      writeln;
    end;
  writeln;
  setlength(s2,0);
  s3 := copy(s1);
  result := copy(s1);
end;

procedure Tfoo_impl.bar3(const s: TStringSeq);
var
  i: integer;
begin
  for i := 0 to Length(s)-1 do
    write(s[i]+' ');
 writeln;
 writeln;
end;

procedure mainproc;
var
  dorb : IORB;
  impl: Tfoo_impl;
  ref: AnsiString;
  obj: IORBObject;
  foo : Ifoo;
  boa: IBOA;
  fl : TStrings;
  s1,s2,s3,res : TS;
  i,l,l2,j : integer;
  seq1,seq2,seq3,seqres: TSSeq;
  sseq : TStringSeq;
begin
  dorb := ORB_Init(nil);
  boa := dorb.BOA_Init as IBOA;
  impl := Tfoo_impl.Create;
  if (ParamCount = 1) and (lowercase(ParamStr(1)) = 's') then
    begin
      fl := TStringList.Create;
      fl.Text := String(dorb.object_to_string(impl));
      fl.SaveToFile('server.objid');
      fl.free;
      dorb.run;
      exit;
    end
  else if (ParamCount = 1) and (lowercase(ParamStr(1)) = 'c') then
    begin
      fl := TStringList.Create;
      fl.LoadFromFile('server.objid');
      ref := AnsiString(fl.Text);
      fl.free;
    end
  else if (ParamCount >= 1)  then
    begin
      writeln('usage: '+ExtractFileName(ParamStr(0))+' s|c');
      exit;
    end
  else
    ref := dorb.object_to_string(impl);
  // client side
  obj := dorb.string_to_object(ref);
  foo := Tfoo._narrow(obj);
  s1.x := 42;
  setLength(s1.seq,3);
  s1.seq[0] := 11;
  s1.seq[1] := 22;
  s1.seq[2] := 33;

  s2.x := 11;
  setLength(s2.seq,1);
  s2.seq[0] := 55;

  res := foo.bar(s1,s2,s3);

  writeln('#1');
  writeln('ULong '+inttostr(s2.x));
  write('Sequence ');
  l := Length(s2.seq);
  for i := 0 to Pred(l) do
    write(inttostr(s2.seq[i])+' ');
  writeln;
  writeln;
  writeln('#2');
  writeln('ULong '+inttostr(s3.x));
  write('Sequence ');
  l := Length(s3.seq);
  for i := 0 to Pred(l) do
    write(inttostr(s3.seq[i])+' ');
  writeln;
  writeln;
  writeln('#3');
  writeln('ULong '+inttostr(res.x));
  write('Sequence ');
  l := Length(res.seq);
  for i := 0 to Pred(l) do
    write(inttostr(res.seq[i])+' ');
  writeln;
  writeln;

  setLength(seq1,1);
  seq1[0] := s1;

  setLength(seq2,1);
  seq2[0].x := 55;
  setLength(seq2[0].seq,2);
  seq2[0].seq[0] := 66;
  seq2[0].seq[1] := 77;

  seqres := foo.bar2(seq1,seq2,seq3);

  writeln('#8');
  l := Length(seq2);
  for i := 0 to Pred(l) do
    begin
      writeln('['+inttostr(i)+']');
      writeln('ULong '+inttostr(seq2[i].x));
      write('Sequence ');
      l2 := Length(seq2[i].seq);
      for j := 0 to Pred(l2) do
        write(inttostr(seq2[i].seq[j])+' ');
      writeln;
      writeln;
    end;
  writeln('#9');
  l := Length(seq3);
  for i := 0 to Pred(l) do
    begin
      writeln('['+inttostr(i)+']');
      writeln('ULong '+inttostr(seq3[i].x));
      write('Sequence ');
      l2 := Length(seq3[i].seq);
      for j := 0 to Pred(l2) do
        write(inttostr(seq3[i].seq[j])+' ');
      writeln;
      writeln;
    end;
  writeln;
  writeln('#10');
  l := Length(seqres);
  for i := 0 to Pred(l) do
    begin
      writeln('['+inttostr(i)+']');
      writeln('ULong '+inttostr(seqres[i].x));
      write('Sequence ');
      l2 := Length(seqres[i].seq);
      for j := 0 to Pred(l2) do
        write(inttostr(seqres[i].seq[j])+' ');
      writeln;
      writeln;
    end;
  writeln;
  setLength(sseq,2);
  sseq[0] := 'Hello';
  sseq[1] := 'World';
  foo.bar3(sseq);
end;
end.
