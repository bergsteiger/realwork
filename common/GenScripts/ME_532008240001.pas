unit K517772970_TCheckSaveToStream;
 {* [RequestLink:517772970] }

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\Tasks\SaveLoad\K517772970_TCheckSaveToStream.pas"
// Стереотип: "TestCase"

{$Include alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
;

type
 _TaskSaver_Parent_ = TBaseTest;
 {$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}
 TK517772970_TCheckSaveToStream = {abstract} class(_TaskSaver_)
  {* [RequestLink:517772970] }
  private
   function MakeTask: TddTaskItem;
   procedure CheckSave(aPiped: Boolean;
    aAsEVD: Boolean);
   procedure DoCheckLoad(aPiped: Boolean;
    aAsEVD: Boolean);
  protected
   function TaskClass: TddTaskClass; virtual; abstract;
   procedure InitTask(Task: TddTaskItem); virtual; abstract;
   function CreateTask(aUserID: LongWord): TddTaskItem; virtual;
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
  public
   procedure DoIt;
   procedure CheckLoad;
   procedure DoItPiped;
   procedure CheckLoadPiped;
   procedure CheckSaveToEVD;
   procedure CheckLoadEVD;
   procedure CheckSaveToEVDPiped;
 end;//TK517772970_TCheckSaveToStream
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 , l3Filer
 , l3Base
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , KTestRunner
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 , SysUtils
 , ddAppConfig
 , l3FileUtils
 , evdTaskTypes
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$Include w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas}

procedure TK517772970_TCheckSaveToStream.DoIt;
//#UC START# *5320084E020E_532008240001_var*
//#UC END# *5320084E020E_532008240001_var*
begin
//#UC START# *5320084E020E_532008240001_impl*
 CheckSave(false, false);
//#UC END# *5320084E020E_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.DoIt

procedure TK517772970_TCheckSaveToStream.CheckLoad;
//#UC START# *5320086A0278_532008240001_var*
//#UC END# *5320086A0278_532008240001_var*
begin
//#UC START# *5320086A0278_532008240001_impl*
 DoCheckLoad(false, false);
//#UC END# *5320086A0278_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckLoad

function TK517772970_TCheckSaveToStream.MakeTask: TddTaskItem;
//#UC START# *537382BA038D_532008240001_var*
const
 defaultUser = 65000;
var
 l_RootTaskFolder : String; 
 l_Fake : String;
//#UC END# *537382BA038D_532008240001_var*
begin
//#UC START# *537382BA038D_532008240001_impl*
 l_RootTaskFolder := ddAppConfiguration.AsString['RootTaskFolder'];
 PureDir(l_RootTaskFolder);
 Result := CreateTask(defaultUser);
 Result.TaskFolder := l_RootTaskFolder;
 l_Fake := Result.Description;
 InitTask(Result);
//#UC END# *537382BA038D_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.MakeTask

procedure TK517772970_TCheckSaveToStream.DoItPiped;
//#UC START# *537383380115_532008240001_var*
//#UC END# *537383380115_532008240001_var*
begin
//#UC START# *537383380115_532008240001_impl*
 CheckSave(true, false);
//#UC END# *537383380115_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.DoItPiped

procedure TK517772970_TCheckSaveToStream.CheckSave(aPiped: Boolean;
 aAsEVD: Boolean);
//#UC START# *5373834C015D_532008240001_var*
var
 l_Task: TddTaskItem;
//#UC END# *5373834C015D_532008240001_var*
begin
//#UC START# *5373834C015D_532008240001_impl*
 StartTimer;
 try
  l_Task := MakeTask;
  try
   SaveTask(l_Task, aPiped, aAsEVD);
  finally
   FreeAndNil(l_Task);
  end;//try..finally
 finally
  StopTimer;
 end;//try..finally
//#UC END# *5373834C015D_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckSave

procedure TK517772970_TCheckSaveToStream.DoCheckLoad(aPiped: Boolean;
 aAsEVD: Boolean);
//#UC START# *5374A4480241_532008240001_var*
var
 l_Task: TddTaskItem;
 l_File: Tl3CustomDosFiler;
 l_FileNameEtalon: string;
//#UC END# *5374A4480241_532008240001_var*
begin
//#UC START# *5374A4480241_532008240001_impl*
 l_Task := MakeTask;
 try
  if aAsEVD then
   l_FileNameEtalon := 'CheckSaveToEVD'
  else
   l_FileNameEtalon := 'DoIt';
  if aPiped then
   l_FileNameEtalon := l_FileNameEtalon + 'Piped'; 
  l_FileNameEtalon := ClassName + '_' + l_FileNameEtalon + '.out' + EtalonSuffix + '.out';
  StartTimer;
  try
   l_File := FilerForInput(l_FileNameEtalon);
   try
    l_File.Open;
    try
     l_File.Stream.Seek(0, 0);
     if aAsEVD then
      l_Task.LoadFromEVD(l_File.Stream, aPiped)
     else
      l_Task.LoadFrom(l_File.Stream, aPiped);
    finally
     l_File.Close;
    end;//try..finally
   finally
    FreeAndNil(l_File);
   end;//try..finally
   SaveTask(l_Task, aPiped, aAsEVD);
  finally
   StopTimer;
  end;//try..finally
 finally
  FreeAndNil(l_Task);
 end;//try..finally
//#UC END# *5374A4480241_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.DoCheckLoad

procedure TK517772970_TCheckSaveToStream.CheckLoadPiped;
//#UC START# *5374A4750344_532008240001_var*
//#UC END# *5374A4750344_532008240001_var*
begin
//#UC START# *5374A4750344_532008240001_impl*
 DoCheckLoad(true, false);
//#UC END# *5374A4750344_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckLoadPiped

function TK517772970_TCheckSaveToStream.CreateTask(aUserID: LongWord): TddTaskItem;
//#UC START# *5388508D03DE_532008240001_var*
const
 defaultDateTime = SomeFixedDate;
//#UC END# *5388508D03DE_532008240001_var*
begin
//#UC START# *5388508D03DE_532008240001_impl*
 Result := TaskClass.Create(aUserID, defaultDateTime);
//#UC END# *5388508D03DE_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CreateTask

procedure TK517772970_TCheckSaveToStream.CheckSaveToEVD;
//#UC START# *53AC2B1D0102_532008240001_var*
//#UC END# *53AC2B1D0102_532008240001_var*
begin
//#UC START# *53AC2B1D0102_532008240001_impl*
 CheckSave(false, true);
//#UC END# *53AC2B1D0102_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckSaveToEVD

procedure TK517772970_TCheckSaveToStream.CheckLoadEVD;
//#UC START# *53B5768B002F_532008240001_var*
//#UC END# *53B5768B002F_532008240001_var*
begin
//#UC START# *53B5768B002F_532008240001_impl*
 DoCheckLoad(false, true);
//#UC END# *53B5768B002F_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckLoadEVD

procedure TK517772970_TCheckSaveToStream.CheckSaveToEVDPiped;
//#UC START# *53C0122C003B_532008240001_var*
//#UC END# *53C0122C003B_532008240001_var*
begin
//#UC START# *53C0122C003B_532008240001_impl*
 CheckSave(true, true);
//#UC END# *53C0122C003B_532008240001_impl*
end;//TK517772970_TCheckSaveToStream.CheckSaveToEVDPiped

{$If Defined(nsTest)}
function TK517772970_TCheckSaveToStream.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TaskSaveLoad';
end;//TK517772970_TCheckSaveToStream.GetFolder
{$IfEnd} // Defined(nsTest)

{$If Defined(nsTest)}
function TK517772970_TCheckSaveToStream.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '532008240001';
end;//TK517772970_TCheckSaveToStream.GetModelElementGUID
{$IfEnd} // Defined(nsTest)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
