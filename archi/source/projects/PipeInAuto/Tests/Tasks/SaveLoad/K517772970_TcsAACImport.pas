unit K517772970_TcsAACImport;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoad/K517772970_TcsAACImport.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoad::K517772970_TcsAACImport
//
// {RequestLink:517772970}
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  K517772970_TcsImportTaskItem
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TcsAACImport = class(TK517772970_TcsImportTaskItem)
  {* [RequestLink:517772970] }
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* ����� � ������� ������ ���� }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} //nsTest
   function TaskClass: TddTaskClass; override;
 end;//TK517772970_TcsAACImport
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If not defined(Nemesis)}
  ,
  csImport
  {$IfEnd} //not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  csAACImport
  {$IfEnd} //not Nemesis
  
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TcsAACImport

{$If defined(nsTest)}
function TK517772970_TcsAACImport.GetFolder: AnsiString;
 {-}
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TcsAACImport.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TcsAACImport.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53218B090017';
end;//TK517772970_TcsAACImport.GetModelElementGUID
{$IfEnd} //nsTest

function TK517772970_TcsAACImport.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53218B090017_var*
//#UC END# *5320088202FB_53218B090017_var*
begin
//#UC START# *5320088202FB_53218B090017_impl*
 Result := TcsAACImport;
//#UC END# *5320088202FB_53218B090017_impl*
end;//TK517772970_TcsAACImport.TaskClass

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TK517772970_TcsAACImport.Suite);

end.