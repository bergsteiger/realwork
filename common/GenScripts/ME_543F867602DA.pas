unit m3FileRegion;

// Модуль: "w:\common\components\rtl\Garant\m3\m3FileRegion.pas"
// Стереотип: "UtilityPack"

{$Include m3Define.inc}

interface

uses
 l3IntfUses
;

type
 Tm3FileRegion = object
  public
   rPosition: Int64;
   rSize: Integer;
  public
   function EQ(const anOther: Tm3FileRegion): Boolean;
 end;//Tm3FileRegion

function Tm3FileRegion_C(aPosition: Int64;
 aSize: Integer): Tm3FileRegion;

implementation

uses
 l3ImplUses
;

function Tm3FileRegion_C(aPosition: Int64;
 aSize: Integer): Tm3FileRegion;
//#UC START# *543F86F900D9_543F8693032B_var*
//#UC END# *543F86F900D9_543F8693032B_var*
begin
//#UC START# *543F86F900D9_543F8693032B_impl*
 Assert(aPosition >= 0);
 Assert(aSize > 0);
 Result.rPosition := aPosition;
 Result.rSize := aSize;
//#UC END# *543F86F900D9_543F8693032B_impl*
end;//Tm3FileRegion_C

function Tm3FileRegion.EQ(const anOther: Tm3FileRegion): Boolean;
//#UC START# *543F86C70321_543F8693032B_var*
//#UC END# *543F86C70321_543F8693032B_var*
begin
//#UC START# *543F86C70321_543F8693032B_impl*
 Result := (Self.rPosition = anOther.rPosition) AND
           (Self.rSize = anOther.rSize);
//#UC END# *543F86C70321_543F8693032B_impl*
end;//Tm3FileRegion.EQ

end.
