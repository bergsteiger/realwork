unit K517772970_TcsExportResultRequest;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsExportResultRequest.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TcsExportResultRequest" MUID: (532141560065)
// ��� ����: "TK517772970_TcsExportResultRequest"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

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
 TK517772970_TcsExportResultRequest = class(TK517772970_TddRequestTask)
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
 end;//TK517772970_TcsExportResultRequest
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
;

{$If Defined(nsTest)}
function TK517772970_TcsExportResultRequest.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsExportResultRequest.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsExportResultRequest.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '532141560065';
end;//TK517772970_TcsExportResultRequest.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TcsExportResultRequest.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_532141560065_var*
//#UC END# *5320088202FB_532141560065_var*
begin
//#UC START# *5320088202FB_532141560065_impl*
 result := TcsExportResultRequest; 
//#UC END# *5320088202FB_532141560065_impl*
end;//TK517772970_TcsExportResultRequest.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TcsExportResultRequest.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
