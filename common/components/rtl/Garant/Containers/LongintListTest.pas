unit LongintListTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Containers"
// Модуль: "w:/common/components/rtl/Garant/Containers/LongintListTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Core Tests::Containers::Lists::TLongintListTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

interface

{$If defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}
type
 TLongintListTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TLongintListTest
{$IfEnd} //nsTest

implementation

{$If defined(nsTest)}
uses
  l3LongintList,
  SysUtils,
  l3Base,
  TestFrameWork
  ;
{$IfEnd} //nsTest

{$If defined(nsTest)}

// start class TLongintListTest

procedure TLongintListTest.DoIt;
//#UC START# *515D7BE60141_515D7BB10393_var*
const
 cEtalon : array [0..4] of Integer = (1, 2, 3, 4, 5);

 function DoItem(pItem : PInteger; anIndex : Integer) : Boolean;
 begin
  Result := true;
  assert(pItem^ = cEtalon[anIndex]);
 end;

var
 l_L : Tl3LongintList;
 l_I : Integer;
//#UC END# *515D7BE60141_515D7BB10393_var*
begin
//#UC START# *515D7BE60141_515D7BB10393_impl*
 l_L := Tl3LongintList.Create;
 try
  for l_I := Low(cEtalon) to High(cEtalon) do
   l_L.Add(cEtalon[l_I]);
  for l_I := Low(cEtalon) to High(cEtalon) do
   assert(l_L.Items[l_I] = cEtalon[l_I]);
  l_L.IterateAllF(l3L2IA(@DoItem));
  l_L.IterateBackF(l_L.Hi, l_L.Lo, l3L2IA(@DoItem));
 finally
  FreeAndNil(l_L);
 end;//try..finally
//#UC END# *515D7BE60141_515D7BB10393_impl*
end;//TLongintListTest.DoIt

function TLongintListTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Lists';
end;//TLongintListTest.GetFolder

function TLongintListTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '515D7BB10393';
end;//TLongintListTest.GetModelElementGUID

{$IfEnd} //nsTest

initialization
 TestFramework.RegisterTest(TLongintListTest.Suite);

end.