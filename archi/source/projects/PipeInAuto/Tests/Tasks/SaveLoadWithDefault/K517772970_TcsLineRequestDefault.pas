unit K517772970_TcsLineRequestDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TcsLineRequestDefault.pas"
// Стереотип: "TestCase"
// Элемент модели: "K517772970_TcsLineRequestDefault" MUID: (53197377004C)
// Имя типа: "TK517772970_TcsLineRequestDefault"

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
 TK517772970_TcsLineRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TcsLineRequestDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csLineRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *53197377004Cimpl_uses*
 //#UC END# *53197377004Cimpl_uses*
;

function TK517772970_TcsLineRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197377004C_var*
//#UC END# *53170E4100CF_53197377004C_var*
begin
//#UC START# *53170E4100CF_53197377004C_impl*
 result := TcsLineRequest;
//#UC END# *53170E4100CF_53197377004C_impl*
end;//TK517772970_TcsLineRequestDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TcsLineRequestDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TcsLineRequestDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsLineRequestDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53197377004C';
end;//TK517772970_TcsLineRequestDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TcsLineRequestDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
