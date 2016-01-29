unit EVDtoEVDBlockNameAdderTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/EVDtoEVDBlockNameAdderTest.pas"
// Начат: 28.03.2011 18:45
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::EVD::EVDtoEVDBlockNameAdderTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Daily\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  EVDtoEVDWriterTest,
  l3Variant
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TEVDtoEVDBlockNameAdderTest = {abstract} class(TEVDtoEVDWriterTest)
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TEVDtoEVDBlockNameAdderTest
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  evdBlockNameAdder,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TEVDtoEVDBlockNameAdderTest

procedure TEVDtoEVDBlockNameAdderTest.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4D909F2701A6_var*
//#UC END# *4C07BCBE01F2_4D909F2701A6_var*
begin
//#UC START# *4C07BCBE01F2_4D909F2701A6_impl*
 TevdBlockNameAdder.SetTo(theGenerator);
//#UC END# *4C07BCBE01F2_4D909F2701A6_impl*
end;//TEVDtoEVDBlockNameAdderTest.SetFilters

function TEVDtoEVDBlockNameAdderTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'EVD';
end;//TEVDtoEVDBlockNameAdderTest.GetFolder

function TEVDtoEVDBlockNameAdderTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4D909F2701A6';
end;//TEVDtoEVDBlockNameAdderTest.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

end.