{$IfNDef TaskSaver_imp}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Low Level Tests"
// Модуль: "w:/archi/source/projects/PipeInAuto/Tests/TaskSaver.imp.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<Impurity::Class>> archi$AutoPipeServer$Garant::Low Level Tests::TaskSaveLoadMixIns::TaskSaver
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Define TaskSaver_imp}
{$If defined(AppServerSide) AND defined(InsiderTest)}
 _TaskSaver_ = {abstract mixin} class(_TaskSaver_Parent_)
 protected
 // protected methods
   procedure SaveTask(aTask: TddTaskItem;
     aPipe: Boolean;
     aAsEVD: Boolean = false);
 end;//_TaskSaver_
{$Else}

 _TaskSaver_ = _TaskSaver_Parent_;

{$IfEnd} //AppServerSide AND InsiderTest

{$Else TaskSaver_imp}

{$If defined(AppServerSide) AND defined(InsiderTest)}

// start class _TaskSaver_

procedure _TaskSaver_.SaveTask(aTask: TddTaskItem;
  aPipe: Boolean;
  aAsEVD: Boolean = false);
//#UC START# *537383090350_53739B29005D_var*
var
 l_File: Tl3CustomDosFiler;
//#UC END# *537383090350_53739B29005D_var*
begin
//#UC START# *537383090350_53739B29005D_impl*
 l_File := FilerForOutput;
 try
  l_File.Open;
  try
   if aAsEVD then
    aTask.SaveToEVDEx(l_File.Stream, aPipe)
   else
    aTask.SaveTo(l_File.Stream, aPipe);
  finally
   l_File.Close;
  end;//try..finally
 finally
  FreeAndNil(l_File);
 end;//try..finally
 CheckWithEtalon(FileForOutput, #0);
//#UC END# *537383090350_53739B29005D_impl*
end;//_TaskSaver_.SaveTask

{$IfEnd} //AppServerSide AND InsiderTest

{$EndIf TaskSaver_imp}
