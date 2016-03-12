unit RegisteredTasksTest;

// Модуль: "w:\archi\source\projects\Archi\Tests\RegisteredTasksTest.pas"
// Стереотип: "TestCase"

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // NOT Defined(NotTunedDUnit)
;

type
 TRegisteredTasksTest = class(TBaseTest)
  protected
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
  published
   procedure DoIt;
 end;//TRegisteredTasksTest
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , ddServerTask
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , ddTaskClassManager
 {$IfEnd} // NOT Defined(Nemesis)
 , evdTaskTypes
 , TestFrameWork
 , l3Filer
 , SysUtils
 , TypInfo
 , k2Base
;

{$If NOT Defined(NotTunedDUnit)}
type
 RddTaskItemFriend = class of TddTaskItemFriend;

 TddTaskItemFriend = class(TddTaskItem)
 end;//TddTaskItemFriend

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
 {* Папка в которую входит тест }
begin
 Result := 'Registering';
end;//TRegisteredTasksTest.GetFolder

function TRegisteredTasksTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53BA8FB5015D';
end;//TRegisteredTasksTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TRegisteredTasksTest.Suite);
{$IfEnd} // NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest)
end.
