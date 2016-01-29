unit K361038156;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Archi Tests"
// Автор: Люлин А.В.
// Модуль: "w:/common/components/rtl/Garant/Archi_Tests/K361038156.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> Shared Delphi Tests::Archi Tests::Storage::K361038156
//
// {RequestLink:361038156}
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Archi_Tests\TestDefine.inc.pas}

interface

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  ArchiStorageTest
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}
type
 TK361038156 = class(TArchiStorageTest)
  {* [RequestLink:361038156] }
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 end;//TK361038156
{$IfEnd} //nsTest AND not NoScripts

implementation

{$If defined(nsTest) AND not defined(NoScripts)}
uses
  TestFrameWork
  ;
{$IfEnd} //nsTest AND not NoScripts

{$If defined(nsTest) AND not defined(NoScripts)}

// start class TK361038156

function TK361038156.GetFolder: AnsiString;
 {-}
begin
 Result := 'Storage';
end;//TK361038156.GetFolder

function TK361038156.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '4FA138AB0003';
end;//TK361038156.GetModelElementGUID

{$IfEnd} //nsTest AND not NoScripts

initialization
 TestFramework.RegisterTest(TK361038156.Suite);

end.