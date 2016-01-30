unit K517772970_TddBaseStatusRequest;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TddBaseStatusRequest.pas"
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
 TK517772970_TddBaseStatusRequest = class(TK517772970_TddRequestTask)
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
   procedure InitTask(Task: TddTaskItem); override;
 end;//TK517772970_TddBaseStatusRequest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csBaseStatusRequest
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TddBaseStatusRequest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TddBaseStatusRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TddBaseStatusRequest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53202365007E';
end;//TK517772970_TddBaseStatusRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TddBaseStatusRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53202365007E_var*
//#UC END# *5320088202FB_53202365007E_var*
begin
//#UC START# *5320088202FB_53202365007E_impl*
 result := TddBaseStatusRequest;
//#UC END# *5320088202FB_53202365007E_impl*
end;//TK517772970_TddBaseStatusRequest.TaskClass

procedure TK517772970_TddBaseStatusRequest.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53202365007E_var*
//#UC END# *532008D203BA_53202365007E_var*
begin
//#UC START# *532008D203BA_53202365007E_impl*
 inherited InitTask(Task);
 with (Task as TddBaseStatusRequest) do begin
  IsFree := true;
  Message := ClassName;
 end;
//#UC END# *532008D203BA_53202365007E_impl*
end;//TK517772970_TddBaseStatusRequest.InitTask

initialization
 TestFramework.RegisterTest(TK517772970_TddBaseStatusRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
