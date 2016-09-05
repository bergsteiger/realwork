unit K517772970_TalcuAutoSpellTaskDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAutoSpellTaskDefault.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuAutoSpellTaskDefault" MUID: (53196ED503A5)
// Имя типа: "TK517772970_TalcuAutoSpellTaskDefault"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStreamDefault
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TalcuAutoSpellTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
  protected
   function GetTaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TalcuAutoSpellTaskDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAutoSpell
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *53196ED503A5impl_uses*
 //#UC END# *53196ED503A5impl_uses*
;

function TK517772970_TalcuAutoSpellTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53196ED503A5_var*
//#UC END# *53170E4100CF_53196ED503A5_var*
begin
//#UC START# *53170E4100CF_53196ED503A5_impl*
 result := TalcuAutoSpellTask;
//#UC END# *53170E4100CF_53196ED503A5_impl*
end;//TK517772970_TalcuAutoSpellTaskDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuAutoSpellTaskDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TalcuAutoSpellTaskDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAutoSpellTaskDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53196ED503A5';
end;//TK517772970_TalcuAutoSpellTaskDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAutoSpellTaskDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
