unit K517772970_TCheckSaveToStreamDefault;
 {* [RequestLink:517772970] }

// ������: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoadWithDefault\Abstract\K517772970_TCheckSaveToStreamDefault.pas"
// ���������: "TestCase"
// ������� ������: "K517772970_TCheckSaveToStreamDefault" MUID: (53170DE90011)
// ��� ����: "TK517772970_TCheckSaveToStreamDefault"

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 , K517772970_TCheckSaveToStream
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 TK517772970_TCheckSaveToStreamDefault = {abstract} class(TK517772970_TCheckSaveToStream)
  {* [RequestLink:517772970] }
  protected
   function GetTaskClass: TddTaskClass; virtual; abstract;
   function TaskClass: TddTaskClass; override;
   procedure InitTask(Task: TddTaskItem); override;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* ����� � ������� ������ ���� }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* ������������� �������� ������, ������� ��������� ���� }
   {$IfEnd} // Defined(nsTest)
 end;//TK517772970_TCheckSaveToStreamDefault
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
 , l3Filer
 , SysUtils
;

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

{$If Defined(nsTest)}
function TK517772970_TCheckSaveToStreamDefault.GetFolder: AnsiString;
 {* ����� � ������� ������ ���� }
begin
 Result := 'AbstractTasksSaveLoadWithDefault';
end;//TK517772970_TCheckSaveToStreamDefault.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TCheckSaveToStreamDefault.GetModelElementGUID: AnsiString;
 {* ������������� �������� ������, ������� ��������� ���� }
begin
 Result := '53170DE90011';
end;//TK517772970_TCheckSaveToStreamDefault.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
