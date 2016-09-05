unit K517772970_TalcuAnnotationTaskDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TalcuAnnotationTaskDefault.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TalcuAnnotationTaskDefault" MUID: (531722FE01D8)
// Имя типа: "TK517772970_TalcuAnnotationTaskDefault"

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
 TK517772970_TalcuAnnotationTaskDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TalcuAnnotationTaskDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(ServerTasks)}
 , alcuAnnotationTask
 {$IfEnd} // Defined(ServerTasks)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *531722FE01D8impl_uses*
 //#UC END# *531722FE01D8impl_uses*
;

function TK517772970_TalcuAnnotationTaskDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_531722FE01D8_var*
//#UC END# *53170E4100CF_531722FE01D8_var*
begin
//#UC START# *53170E4100CF_531722FE01D8_impl*
 result := TalcuAnnotationTask;
//#UC END# *53170E4100CF_531722FE01D8_impl*
end;//TK517772970_TalcuAnnotationTaskDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TalcuAnnotationTaskDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TalcuAnnotationTaskDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TalcuAnnotationTaskDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '531722FE01D8';
end;//TK517772970_TalcuAnnotationTaskDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TalcuAnnotationTaskDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
