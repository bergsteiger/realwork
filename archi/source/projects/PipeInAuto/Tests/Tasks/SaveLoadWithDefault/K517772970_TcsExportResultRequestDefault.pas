unit K517772970_TcsExportResultRequestDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsExportResultRequestDefault.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TcsExportResultRequestDefault" MUID: (5319728801FC)
// Имя типа: "TK517772970_TcsExportResultRequestDefault"

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
 TK517772970_TcsExportResultRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TcsExportResultRequestDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csExportResultRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *5319728801FCimpl_uses*
 //#UC END# *5319728801FCimpl_uses*
;

function TK517772970_TcsExportResultRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_5319728801FC_var*
//#UC END# *53170E4100CF_5319728801FC_var*
begin
//#UC START# *53170E4100CF_5319728801FC_impl*
 result := TcsExportResultRequest;
//#UC END# *53170E4100CF_5319728801FC_impl*
end;//TK517772970_TcsExportResultRequestDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TcsExportResultRequestDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TcsExportResultRequestDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsExportResultRequestDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '5319728801FC';
end;//TK517772970_TcsExportResultRequestDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TcsExportResultRequestDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
