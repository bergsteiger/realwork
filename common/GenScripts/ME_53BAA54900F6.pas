unit RegisteredRepliesTest;

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\RegisteredRepliesTest.pas"
// Стереотип: "TestCase"
// Элемент модели: "TRegisteredRepliesTest" MUID: (53BAA54900F6)

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3IntfUses
 {$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 , BaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
;

type
 TRegisteredRepliesTest = class({$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
 TBaseTest
 {$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)
 )
  protected
   {$If Defined(nsTest)}
   function GetFolder: AnsiString; override;
    {* Папка в которую входит тест }
   {$IfEnd} // Defined(nsTest)
   {$If Defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
    {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} // Defined(nsTest)
  published
   procedure DoIt;
 end;//TRegisteredRepliesTest
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

implementation

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
uses
 l3ImplUses
 {$If NOT Defined(Nemesis)}
 , CsReplyProcedures
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsProcWithId
 {$IfEnd} // NOT Defined(Nemesis)
 {$If NOT Defined(Nemesis)}
 , CsQueryTypes
 {$IfEnd} // NOT Defined(Nemesis)
 , Classes
 , l3Filer
 , SysUtils
 , TypInfo
 {$If Defined(nsTest)}
 , TestFrameWork
 {$IfEnd} // Defined(nsTest)
;

{$If Defined(nsTest) AND NOT Defined(NotTunedDUnit)}
procedure TRegisteredRepliesTest.DoIt;
//#UC START# *53BAA563023C_53BAA54900F6_var*
var
 l_QT : TCsQueryId;
 l_File : Tl3CustomFiler;
 l_Proc : TCsReplyProc;
 l_M : TMethod absolute l_Proc;
 l_O : TObject;
//#UC END# *53BAA563023C_53BAA54900F6_var*
begin
//#UC START# *53BAA563023C_53BAA54900F6_impl*
 l_File := FilerForOutput;
 try
  l_File.Open;
  try
   for l_QT := Low(TCsQueryId) to High(TCsQueryId) do
   begin
    l_File.WriteLn(GetEnumName(TypeInfo(TCsQueryId), Ord(l_QT)));
    l_Proc := TCsReplyProcedures.Instance.ProcBy(l_QT);
    if Assigned(l_Proc) then
    begin
     l_File.WriteLn('Registered');
     l_O := TObject(l_M.Data);
     l_File.WriteLn(l_O.ClassName);
     l_File.WriteLn(l_O.MethodName(l_M.Code));
    end//Assigned(l_Proc)
    else
     l_File.WriteLn('NotRegistered');
    l_File.WriteLn('-----------');
   end;//for l_TT
  finally
   l_File.Close;
  end;//try..finally
 finally
  FreeAndNil(l_File);
 end;//try..finally
 CheckWithEtalon(FileForOutput, #0);
//#UC END# *53BAA563023C_53BAA54900F6_impl*
end;//TRegisteredRepliesTest.DoIt

function TRegisteredRepliesTest.GetFolder: AnsiString;
 {* Папка в которую входит тест }
begin
 Result := 'TasksRegistering';
end;//TRegisteredRepliesTest.GetFolder

function TRegisteredRepliesTest.GetModelElementGUID: AnsiString;
 {* Идентификатор элемента модели, который описывает тест }
begin
 Result := '53BAA54900F6';
end;//TRegisteredRepliesTest.GetModelElementGUID

initialization
 TestFramework.RegisterTest(TRegisteredRepliesTest.Suite);
{$IfEnd} // Defined(nsTest) AND NOT Defined(NotTunedDUnit)

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
end.
