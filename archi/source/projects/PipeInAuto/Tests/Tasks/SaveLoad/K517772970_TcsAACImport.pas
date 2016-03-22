unit K517772970_TcsAACImport;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TcsAACImport.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TcsAACImport" MUID: (53218B090017)
// ��� ����: "TK517772970_TcsAACImport"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TcsImportTaskItem
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TcsAACImport = class(TK517772970_TcsImportTaskItem)
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
 end;//TK517772970_TcsAACImport
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , csImport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , csAACImport
 {$IfEnd} // NOT Defined(Nemesis)
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest)}
function TK517772970_TcsAACImport.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsAACImport.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TcsAACImport.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53218B090017';
end;//TK517772970_TcsAACImport.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

function TK517772970_TcsAACImport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218B090017_var*
//#UC END# *5320088202FB_53218B090017_var*
begin
//#UC START# *5320088202FB_53218B090017_impl*
 Result := TcsAACImport;
//#UC END# *5320088202FB_53218B090017_impl*
end;//TK517772970_TcsAACImport.TaskClass

initialization
 TestFramework.RegisterTest(TK517772970_TcsAACImport.Suite);
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

end.
