unit K517772970_TRemoteDictEditQueryDefault;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TRemoteDictEditQueryDefault.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStreamDefault
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TRemoteDictEditQueryDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TRemoteDictEditQueryDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csServerTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

function TK517772970_TRemoteDictEditQueryDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197E5501B8_var*
//#UC END# *53170E4100CF_53197E5501B8_var*
begin
//#UC START# *53170E4100CF_53197E5501B8_impl*
 result := TRemoteDictEditQuery;
//#UC END# *53170E4100CF_53197E5501B8_impl*
end;//TK517772970_TRemoteDictEditQueryDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TRemoteDictEditQueryDefault.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TRemoteDictEditQueryDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TRemoteDictEditQueryDefault.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53197E5501B8';
end;//TK517772970_TRemoteDictEditQueryDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TRemoteDictEditQueryDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest) AND Defined(RemoteDict)

end.
