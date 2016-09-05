unit K517789752;
 {* [RequestLink:517789752] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\Import\K517789752.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517789752" MUID: (53736E900198)
// Имя типа: "TK517789752"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , alcuImportTest
;

type
 TK517789752 = class(TalcuImportTest)
  {* [RequestLink:517789752] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517789752
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *53736E900198impl_uses*
 //#UC END# *53736E900198impl_uses*
;

{$If Defined(nsTest)}
function TK517789752.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'ConcreteImportTasks';
end;//TK517789752.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517789752.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53736E900198';
end;//TK517789752.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517789752.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
