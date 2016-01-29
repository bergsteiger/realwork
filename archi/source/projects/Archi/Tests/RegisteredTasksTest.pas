unit RegisteredTasksTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Tasks"
// Модуль: "w:/archi/source/projects/Archi/Tests/RegisteredTasksTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$Test::Tasks::Registering::TRegisteredTasksTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  {$If not defined(Nemesis)}
  ,
  ddServerTask
  {$IfEnd} //not Nemesis
  
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}
type
 TRegisteredTasksTest = class(TBaseTest)
 protected
 // overridden protected methods
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
 published
 // published methods
   procedure DoIt;
 end;//TRegisteredTasksTest
{$IfEnd} //InsiderTest AND nsTest

implementation

{$If defined(InsiderTest) AND defined(nsTest)}
uses
  l3Filer,
  SysUtils,
  TypInfo,
  k2Base
  {$If not defined(Nemesis)}
  ,
  ddTaskClassManager
  {$IfEnd} //not Nemesis
  ,
  evdTaskTypes,
  TestFrameWork
  ;
{$IfEnd} //InsiderTest AND nsTest

{$If defined(InsiderTest) AND defined(nsTest)}

type
  TddTaskItemFriend = class(TddTaskItem)
  end;//TddTaskItemFriend

  RddTaskItemFriend = class of TddTaskItemFriend;

// start class TRegisteredTasksTest

procedure TRegisteredTasksTest.DoIt;
//#UC START# *53BA902B00C5_53BA8FB5015D_var*
var
 l_TT : TcsTaskType;
 l_File : Tl3CustomFiler;
 l_Class : TddTaskClass;
 l_Description : AnsiString;
//#UC END# *53BA902B00C5_53BA8FB5015D_var*
begin
//#UC START# *53BA902B00C5_53BA8FB5015D_impl*
 l_File := FilerForOutput;
 try
  l_File.Open;
  try
   for l_TT := Low(TcsTaskType) to High(TcsTaskType) do
   begin
    l_File.WriteLn(GetEnumName(TypeInfo(TcsTaskType), Ord(l_TT)));
    l_Class := TddTaskClassManager.Instance.GetClass(l_TT, l_Description);
    if (l_Class = nil) then
     l_File.WriteLn('NotRegistered')
    else
    begin
     l_File.WriteLn(l_Class.ClassName);
     l_File.WriteLn(RddTaskItemFriend(l_Class).GetTaggedDataType.AsString);
     l_File.WriteLn(l_Description);
    end;//l_Class = nil
    l_File.WriteLn('-----------');
   end;//for l_TT
  finally
   l_File.Close;
  end;//try..finally
 finally
  FreeAndNil(l_File);
 end;//try..finally
 CheckWithEtalon(FileForOutput, #0);
//#UC END# *53BA902B00C5_53BA8FB5015D_impl*
end;//TRegisteredTasksTest.DoIt

function TRegisteredTasksTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'Registering';
end;//TRegisteredTasksTest.GetFolder

function TRegisteredTasksTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53BA8FB5015D';
end;//TRegisteredTasksTest.GetModelElementGUID

{$IfEnd} //InsiderTest AND nsTest

initialization
 TestFramework.RegisterTest(TRegisteredTasksTest.Suite);

end.