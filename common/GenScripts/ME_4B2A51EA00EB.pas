unit TestFilerReadLn;

interface

uses
 l3IntfUses
 , BaseTest
;

type
 TTestFilerReadLn = class(TBaseTest)
  procedure ReadViaDelphi;
  procedure DoIt;
  function ReadViaDelphiPrim(const aName: AnsiString): Longword;
  procedure ReadLnBadText;
   {* ���� ��� [RequestLink:175540286]. }
  procedure ReadLnBadUnicodeText;
   {* ���� ��� [RequestLink:175540286]. }
 end;//TTestFilerReadLn
 
implementation

uses
 l3ImplUses
 , TestGlobals
 , TestFrameWork
 , l3Filer
 , SysUtils
 , l3Types
;

end.
