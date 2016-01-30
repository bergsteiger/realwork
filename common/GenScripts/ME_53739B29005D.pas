{$IfNDef TaskSaver_imp}

// Модуль: "w:\archi\source\projects\PipeInAuto\Tests\TaskSaver.imp.pas"
// Стереотип: "Impurity"

{$Define TaskSaver_imp}

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
 _TaskSaver_ = {abstract} class(_TaskSaver_Parent_)
  protected
   procedure SaveTask(aTask: TddTaskItem;
    aPipe: Boolean;
    aAsEVD: Boolean = False);
 end;//_TaskSaver_

{$Else Defined(AppServerSide) AND Defined(InsiderTest)}

_TaskSaver_ = _TaskSaver_Parent_;

{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)
{$Else TaskSaver_imp}

{$IfNDef TaskSaver_imp_impl}

{$Define TaskSaver_imp_impl}

{$If Defined(AppServerSide) AND Defined(InsiderTest)}
procedure _TaskSaver_.SaveTask(aTask: TddTaskItem;
 aPipe: Boolean;
 aAsEVD: Boolean = False);
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
{$IfEnd} // Defined(AppServerSide) AND Defined(InsiderTest)

{$EndIf TaskSaver_imp_impl}

{$EndIf TaskSaver_imp}

