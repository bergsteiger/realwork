unit K219122895;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "DailyTest"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Daily/K219122895.pas"
// Начат: 28.06.2010 21:13
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::DailyTest::7.6::K219122895
//
// {RequestLink:219122895}
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
 TK219122895 = class(TEVDtoEVDWriterTest)
  {* [RequestLink:219122895] }
 protected
 // overridden protected methods
   procedure SetFilters(var theGenerator: Ik2TagGenerator); override;
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK219122895
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ddMisspellCorrect,
  SysUtils,
  l3String,
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK219122895

procedure TK219122895.SetFilters(var theGenerator: Ik2TagGenerator);
//#UC START# *4C07BCBE01F2_4C28D831004B_var*
var
 l_F : TddMisspellCorrectFilter;
//#UC END# *4C07BCBE01F2_4C28D831004B_var*
begin
//#UC START# *4C07BCBE01F2_4C28D831004B_impl*
 l_F := TddMisspellCorrectFilter.Create;
 try
  ddAddOnePair(l3PCharLen('грод=город'), l_F);
  ddAddOnePair(l3PCharLen('ершилим=ершалаим'), l_F);
  ddAddOnePair(l3PCharLen('антониевой=Антониевой'), l_F);
  ddAddOnePair(l3PCharLen('сосредиземного=со средиземного'), l_F);
  ddAddOnePair(l3PCharLen('#{\d\d\d\d}{г\.}={1} {2}'), l_F);
  l_F.Generator := theGenerator;
  theGenerator := l_F;
 finally
  FreeAndNil(l_F);
 end;//try..finally
//#UC END# *4C07BCBE01F2_4C28D831004B_impl*
end;//TK219122895.SetFilters

function TK219122895.GetFolder: AnsiString;
 {-}
begin
 Result := '7.6';
end;//TK219122895.GetFolder

function TK219122895.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4C28D831004B';
end;//TK219122895.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK219122895.Suite);

end.