unit LongintListTest;

// Модуль: "w:\common\components\rtl\Garant\Containers\LongintListTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TLongintListTest" MUID: (515D7BB10393)

interface

{$If Defined(nsTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TLongintListTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TLongintListTest
{$IfEnd} // Defined(nsTest)

implementation

{$If Defined(nsTest)}
uses
 l3ImplUses
 , l3LongintList
 , SysUtils
 , l3Base
 , TestFrameWork
;

{$If NOT Defined(NotTunedDUnit)}
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
 {* Папка в которую входит тест }
begin
 Result := 'Lists';
end;//TLongintListTest.GetFolder

function TLongintListTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '515D7BB10393';
end;//TLongintListTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TLongintListTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest)
end.
