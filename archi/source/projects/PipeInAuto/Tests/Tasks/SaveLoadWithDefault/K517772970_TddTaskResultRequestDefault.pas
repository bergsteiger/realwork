unit K517772970_TddTaskResultRequestDefault;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TddTaskResultRequestDefault.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TddTaskResultRequestDefault" MUID: (53197CFA0365)
// ��� ����: "TK517772970_TddTaskResultRequestDefault"

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
 TK517772970_TddTaskResultRequestDefault = class(TK517772970_TCheckSaveToStreamDefault)
  {* [RequestLink:517772970] }
  protected
   function GetTaskClass: TddTaskClass; override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TddTaskResultRequestDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csTaskRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
 //#UC START# *53197CFA0365impl_uses*
 //#UC END# *53197CFA0365impl_uses*
;

function TK517772970_TddTaskResultRequestDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197CFA0365_var*
//#UC END# *53170E4100CF_53197CFA0365_var*
begin
//#UC START# *53170E4100CF_53197CFA0365_impl*
 result := TddTaskResultRequest;
//#UC END# *53170E4100CF_53197CFA0365_impl*
end;//TK517772970_TddTaskResultRequestDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TddTaskResultRequestDefault.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TddTaskResultRequestDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddTaskResultRequestDefault.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53197CFA0365';
end;//TK517772970_TddTaskResultRequestDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TddTaskResultRequestDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
