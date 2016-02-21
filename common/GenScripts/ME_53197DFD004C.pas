unit K517772970_TGetDictEditQueryDefault;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\K517772970_TGetDictEditQueryDefault.pas"
// ���������: "TestCase"

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
 TK517772970_TGetDictEditQueryDefault = class(TK517772970_TCheckSaveToStreamDefault)
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
 end;//TK517772970_TGetDictEditQueryDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csServerTaskTypes
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
;

function TK517772970_TGetDictEditQueryDefault.GetTaskClass: TddTaskClass;
//#UC START# *53170E4100CF_53197DFD004C_var*
//#UC END# *53170E4100CF_53197DFD004C_var*
begin
//#UC START# *53170E4100CF_53197DFD004C_impl*
 result := TGetDictEditQuery;
//#UC END# *53170E4100CF_53197DFD004C_impl*
end;//TK517772970_TGetDictEditQueryDefault.GetTaskClass

{$If Defined(nsTest)}
function TK517772970_TGetDictEditQueryDefault.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TasksSaveLoadWithDefault';
end;//TK517772970_TGetDictEditQueryDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TGetDictEditQueryDefault.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53197DFD004C';
end;//TK517772970_TGetDictEditQueryDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

initialization
 TestFramework.RegisterTest(TK517772970_TGetDictEditQueryDefault.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
