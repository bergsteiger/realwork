unit K517772970_TddRequestTask;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddRequestTask.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TddRequestTask" MUID: (53200AD70286)
// ��� ����: "TK517772970_TddRequestTask"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TddTaskItem
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TddRequestTask = class(TK517772970_TddTaskItem)
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
 end;//TK517772970_TddRequestTask
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csRequestTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TddRequestTask.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddRequestTask.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddRequestTask.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53200AD70286';
end;//TK517772970_TddRequestTask.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TddRequestTask.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53200AD70286_var*
//#UC END# *5320088202FB_53200AD70286_var*
begin
//#UC START# *5320088202FB_53200AD70286_impl*
 result := TddRequestTask;
//#UC END# *5320088202FB_53200AD70286_impl*
end;//TK517772970_TddRequestTask.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TddRequestTask.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
