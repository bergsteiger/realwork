unit K517772970_TcsLineRequest;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsLineRequest.pas"
// ���������: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddRequestTask
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TcsLineRequest = class(TK517772970_TddRequestTask)
  {* [RequestLink:517772970] }
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
   function TaskClass: TddTaskClass; override;
 end;//TK517772970_TcsLineRequest
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
;

{$If Defined(nsTest)}
function TK517772970_TcsLineRequest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsLineRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsLineRequest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '532141850386';
end;//TK517772970_TcsLineRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TcsLineRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532141850386_var*
//#UC END# *5320088202FB_532141850386_var*
begin
//#UC START# *5320088202FB_532141850386_impl*
 result := TcsLineRequest;
//#UC END# *5320088202FB_532141850386_impl*
end;//TK517772970_TcsLineRequest.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TcsLineRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
