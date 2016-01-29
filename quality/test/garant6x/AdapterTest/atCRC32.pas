unit atCRC32;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "AdapterTest"
// Модуль: "w:/quality/test/garant6x/AdapterTest/atCRC32.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> garant6x_test::AdapterTest::Common::atCRC32
//
// Расчет контрольной суммы CRC32
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

function ComputeCRC32(const Buf: Pointer;
  const BufLength: Longword): Longword;
procedure UpdateCRC32(Buf: PAnsiChar;
  const BufLength: Longword;
  var CRC32: Longword);

implementation

var CRC32Table : array of Longword;

// unit methods

procedure InitCRC32Table;
//#UC START# *4A4B93380119_4A4B91810237_var*
  var i, j, c : Longword;
//#UC END# *4A4B93380119_4A4B91810237_var*
begin
//#UC START# *4A4B93380119_4A4B91810237_impl*
  SetLength(CRC32Table, 256);
  for i := 0 to 255 do
  begin
    c := i;
    for j := 0 to 7 do
      if ((c and 1) = 0) then
        c := c shr 1
      else
        c := (c shr 1) xor $EDB88320;
    CRC32Table[i] := c;
  end;
//#UC END# *4A4B93380119_4A4B91810237_impl*
end;//InitCRC32Table

function ComputeCRC32(const Buf: Pointer;
  const BufLength: Longword): Longword;
//#UC START# *4A4B91EE0198_4A4B91810237_var*
//#UC END# *4A4B91EE0198_4A4B91810237_var*
begin
//#UC START# *4A4B91EE0198_4A4B91810237_impl*
  Result := $FFFFFFFF;
  UpdateCRC32(Buf, BufLength, Result);
  Result := not Result;
//#UC END# *4A4B91EE0198_4A4B91810237_impl*
end;//ComputeCRC32

procedure UpdateCRC32(Buf: PAnsiChar;
  const BufLength: Longword;
  var CRC32: Longword);
//#UC START# *4A4B91F8033D_4A4B91810237_var*
  var
    BufEnd : PChar;
//#UC END# *4A4B91F8033D_4A4B91810237_var*
begin
//#UC START# *4A4B91F8033D_4A4B91810237_impl*
  BufEnd := Buf + BufLength - 1;
  while (Buf <= BufEnd) do
  begin
    CRC32 := CRC32Table[(CRC32 xor Longword(Buf^)) and $FF] xor (CRC32 shr 8);
    Inc(Buf);
  end;
//#UC END# *4A4B91F8033D_4A4B91810237_impl*
end;//UpdateCRC32

initialization
//#UC START# *4A4B91E4031E*
  InitCRC32Table();
//#UC END# *4A4B91E4031E*

end.