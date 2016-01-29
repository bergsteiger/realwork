unit ddNameFilter;

{ $Id: ddNameFilter.pas,v 1.2 2013/04/11 16:46:28 lulin Exp $ }

// $Log: ddNameFilter.pas,v $
// Revision 1.2  2013/04/11 16:46:28  lulin
// - отлаживаем под XE3.
//
// Revision 1.1  2005/03/04 16:08:50  narry
// - новинка: реализация импорта Пучин-нср
//

interface
Uses
 k2FileGenerator, k2Types,
 l3Base, l3Types;

type
 TddNameWriter = class(Tk2CustomFileGenerator)
 private
  f_Name: Tl3CustomString;
 protected
  procedure Cleanup; override;
 public
  procedure AddAtomEx(AtomIndex: Long; const aValue: Tk2Variant); override;
  procedure WriteName;
 end;

implementation

Uses
 k2Tags, ddNSRCConst,
 SysUtils;

procedure TddNameWriter.AddAtomEx(AtomIndex: Long; const aValue: Tk2Variant);
begin
 if AtomIndex = k2_tiName then
 begin
  if f_Name = nil then
   f_Name := Tl3String.Create;
  f_Name.Assign(aValue.AsString);
 end;
end;

procedure TddNameWriter.Cleanup;
begin
  l3Free(f_Name);
  inherited;
end;

procedure TddNameWriter.WriteName;
var
  S: AnsiString;
  i,j: Integer;
  l_Kwd : AnsiString;
begin
  if (f_Name = nil) or f_Name.Empty then
   exit;
  l_Kwd := kwdName;
  i:= 0;
  s:= '';
  j:= 0;
  f_Name.CodePage:= Filer.CodePage;
  f_Name.TrimEOL;
  i:= f_Name.FindChar(i, #9);
  while i <> -1 do
  begin
   f_Name.Ch[i]:= ' ';
   i:= f_Name.FindChar(i, #9);
  end; // while i <> -1
  i:= 0;
  if (f_Name.Len > 73) or (f_Name.FindChar(0, #13) <> -1) or
     (f_Name.FindChar(0, #10) <> -1) then
   while i < f_Name.Len do
   begin
    while (j < 73) and (i < f_Name.Len) and not (f_Name.Ch[i] in [#10, #13]) do
    begin
     S:= S + f_Name.Ch[i];
     inc(i); inc(j);
    end;

    if (f_Name.Ch[i] <> ' ') and (i < f_Name.Len) and not (f_Name.Ch[i] in [#10, #13]) then
    begin
     while (S[Length(S)] <> ' ') do
     begin
      dec(i);
      Delete(s, length(S), 1);
     end;
    end
    else
     inc(i);
    OutEOL;
    OutString(Format('!%s %s', [l_kwd, S]));
    S:= '';
    j:= 0;
  end
  else
  begin
   OutEOL;
   OutString(Format('!%s %s', [l_kwd, f_Name.AsString]));
  end;
end;

end.
