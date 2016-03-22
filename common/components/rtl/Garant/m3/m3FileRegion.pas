unit m3FileRegion;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "m3"
// Модуль: "w:/common/components/rtl/Garant/m3/m3FileRegion.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> Shared Delphi Low Level::m3::m3CoreObjects::m3FileRegion
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\m3\m3Define.inc}

interface

type
 Tm3FileRegion = {$IfDef XE4}record{$Else}object{$EndIf}
 public
   rPosition : Int64;
   rSize : Integer;
 public
    function EQ(const anOther: Tm3FileRegion): Boolean;
 end;//Tm3FileRegion

function Tm3FileRegion_C(aPosition: Int64;
     aSize: Integer): Tm3FileRegion;

implementation

// start class Tm3FileRegion

function Tm3FileRegion.EQ(const anOther: Tm3FileRegion): Boolean;
//#UC START# *543F86C70321_543F8693032B_var*
//#UC END# *543F86C70321_543F8693032B_var*
begin
//#UC START# *543F86C70321_543F8693032B_impl*
 Result := (Self.rPosition = anOther.rPosition) AND
           (Self.rSize = anOther.rSize);
//#UC END# *543F86C70321_543F8693032B_impl*
end;//Tm3FileRegion.EQ

function Tm3FileRegion_C(aPosition: Int64;
        aSize: Integer): Tm3FileRegion;
//#UC START# *543F86F900D9_543F8693032B_var*
//#UC END# *543F86F900D9_543F8693032B_var*
begin
 System.FillChar(Result, SizeOf(Result), 0);
//#UC START# *543F86F900D9_543F8693032B_impl*
 Assert(aPosition >= 0);
 Assert(aSize > 0);
 Result.rPosition := aPosition;
 Result.rSize := aSize;
//#UC END# *543F86F900D9_543F8693032B_impl*
end;//Tm3FileRegion.C

end.