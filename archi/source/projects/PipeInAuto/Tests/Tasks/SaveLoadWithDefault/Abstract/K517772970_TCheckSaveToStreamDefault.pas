unit K517772970_TCheckSaveToStreamDefault;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Low Level Tests"
// ������: "w:/archi/source/projects/PipeInAuto/Tests/Tasks/SaveLoadWithDefault/Abstract/K517772970_TCheckSaveToStreamDefault.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::AbstractTasksSaveLoadWithDefault::K517772970_TCheckSaveToStreamDefault
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
  Classes
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  ,
  K517772970_TCheckSaveToStream
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TK517772970_TCheckSaveToStreamDefault = {abstract} class(TK517772970_TCheckSaveToStream)
  {* [RequestLink:517772970] }
 protected
 // realized methods
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
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
 protected
 // protected methods
   function GetTaskClass: TddTaskClass; virtual; abstract;
 end;//TK517772970_TCheckSaveToStreamDefault
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  SysUtils
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  ,
  l3Filer
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TK517772970_TCheckSaveToStreamDefault

function TK517772970_TCheckSaveToStreamDefault.TaskClass: TddTaskClass;
//#UC START# *5320088202FB_53170DE90011_var*
//#UC END# *5320088202FB_53170DE90011_var*
begin
//#UC START# *5320088202FB_53170DE90011_impl*
 Result := GetTaskClass;
//#UC END# *5320088202FB_53170DE90011_impl*
end;//TK517772970_TCheckSaveToStreamDefault.TaskClass

procedure TK517772970_TCheckSaveToStreamDefault.InitTask(Task: TddTaskItem);
//#UC START# *532008D203BA_53170DE90011_var*
//#UC END# *532008D203BA_53170DE90011_var*
begin
//#UC START# *532008D203BA_53170DE90011_impl*
 // - ������ �� ������
//#UC END# *532008D203BA_53170DE90011_impl*
end;//TK517772970_TCheckSaveToStreamDefault.InitTask

{$If defined(nsTest)}
function TK517772970_TCheckSaveToStreamDefault.GetFolder: AnsiString;
 {-}
begin
 Result := 'AbstractTasksSaveLoadWithDefault';
end;//TK517772970_TCheckSaveToStreamDefault.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TK517772970_TCheckSaveToStreamDefault.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53170DE90011';
end;//TK517772970_TCheckSaveToStreamDefault.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

end.