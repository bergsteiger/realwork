unit RegisteredRepliesTest;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/RegisteredRepliesTest.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<TestCase::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TasksRegistering::TRegisteredRepliesTest
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\archi\source\projects\PipeInAuto\alcuDefine.inc}

interface

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  Classes
  {$If defined(nsTest) AND not defined(NotTunedDUnit)}
  ,
  BaseTest
  {$IfEnd} //nsTest AND not NotTunedDUnit
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}
type
 TRegisteredRepliesTest = class(TBaseTest)
 protected
 // overridden protected methods
   {$If defined(nsTest)}
   function GetFolder: AnsiString; override;
     {* Папка в которую входит тест }
   {$IfEnd} //nsTest
   {$If defined(nsTest)}
   function GetModelElementGUID: AnsiString; override;
     {* Идентификатор элемента модели, который описывает тест }
   {$IfEnd} //nsTest
 published
 // published methods
   procedure DoIt;
 end;//TRegisteredRepliesTest
{$IfEnd} //AppServerSide AND InsiderTest

implementation

{$If defined(AppServerSide) AND defined(InsiderTest)}
uses
  SysUtils
  {$If defined(AppServerSide) AND not defined(Nemesis)}
  ,
  CsReplyProcedures
  {$IfEnd} //AppServerSide AND not Nemesis
  
  {$If defined(AppServerSide) AND not defined(Nemesis)}
  ,
  CsProcWithId
  {$IfEnd} //AppServerSide AND not Nemesis
  
  {$If not defined(Nemesis)}
  ,
  CsQueryTypes
  {$IfEnd} //not Nemesis
  ,
  l3Filer,
  TypInfo
  {$If defined(nsTest)}
  ,
  TestFrameWork
  {$IfEnd} //nsTest
  
  ;
{$IfEnd} //AppServerSide AND InsiderTest

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class TRegisteredRepliesTest

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

{$If defined(nsTest)}
function TRegisteredRepliesTest.GetFolder: AnsiString;
 {-}
begin
 Result := 'TasksRegistering';
end;//TRegisteredRepliesTest.GetFolder
{$IfEnd} //nsTest

{$If defined(nsTest)}
function TRegisteredRepliesTest.GetModelElementGUID: AnsiString;
 {-}
begin
 Result := '53BAA54900F6';
end;//TRegisteredRepliesTest.GetModelElementGUID
{$IfEnd} //nsTest

{$IfEnd} //AppServerSide AND InsiderTest

initialization
 TestFramework.RegisterTest(TRegisteredRepliesTest.Suite);

end.