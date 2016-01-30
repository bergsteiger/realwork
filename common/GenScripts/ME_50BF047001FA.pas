unit seThreadSupport;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\seThreadSupport.pas"
// ���������: "UtilityPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , Classes
 , tfwScriptingInterfaces
 , l3ProtoDataContainer
 , l3Memory
 , l3Types
 , l3Interfaces
 , l3Core
 , l3Except
;

type
 TWordThread = class(TThread)
  private
   f_Context: TtfwContext;
   f_Word: TtfwWord;
  protected
   procedure Execute; override;
  public
   destructor Destroy; override;
 end;//TWordThread

 _ItemType_ = TWordThread;
 _l3ObjectPtrList_Parent_ = Tl3ProtoDataContainer;
 {$Define l3Items_IsProto}
 {$Include l3ObjectPtrList.imp.pas}
 TseWorkThreadList = class(_l3ObjectPtrList_)
  public
   procedure WaitForAllThreads;
   procedure AddAndResumeThread(const aContext: TtfwContext;
    const aWord: TtfwWord);
   class function Exists: Boolean;
    {* ��������� ������ ��������� ���������� ��� ��� }
   class function Instance: TseWorkThreadList;
    {* ����� ��������� ���������� ���������� TseWorkThreadList }
 end;//TseWorkThreadList
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , SysUtils
 , l3Base
 , l3MinMax
 , RTLConsts
;

var g_TseWorkThreadList: TseWorkThreadList = nil;
 {* ��������� ���������� TseWorkThreadList }

procedure TseWorkThreadListFree;
 {* ����� ������������ ���������� ���������� TseWorkThreadList }
begin
 l3Free(g_TseWorkThreadList);
end;//TseWorkThreadListFree

procedure TWordThread.Execute;
//#UC START# *4FFFDF740099_4FFFDE6C016C_var*
//#UC END# *4FFFDF740099_4FFFDE6C016C_var*
begin
//#UC START# *4FFFDF740099_4FFFDE6C016C_impl*
 f_Word.DoIt(f_Context);
//#UC END# *4FFFDF740099_4FFFDE6C016C_impl*
end;//TWordThread.Execute

destructor TWordThread.Destroy;
//#UC START# *48077504027E_4FFFDE6C016C_var*
//#UC END# *48077504027E_4FFFDE6C016C_var*
begin
//#UC START# *48077504027E_4FFFDE6C016C_impl*
 FreeAndNil(f_Word);
 Finalize(f_Context);
 inherited;
//#UC END# *48077504027E_4FFFDE6C016C_impl*
end;//TWordThread.Destroy

type _Instance_R_ = TseWorkThreadList;

{$Include l3ObjectPtrList.imp.pas}

procedure TseWorkThreadList.WaitForAllThreads;
//#UC START# *50BF1C6D0267_50BF049002DB_var*
var
 l_Thread : TWordThread;
//#UC END# *50BF1C6D0267_50BF049002DB_var*
begin
//#UC START# *50BF1C6D0267_50BF049002DB_impl*
 while (Count > 0) do
 begin
  try
   l_Thread := Items[0];
   try
    l_Thread.WaitFor;
   except
   end;//try..except 
   l_Thread.Free;
   Delete(0);
  except
  end;//try..except
 end; // for i := 0 to Count - 1 do
//#UC END# *50BF1C6D0267_50BF049002DB_impl*
end;//TseWorkThreadList.WaitForAllThreads

procedure TseWorkThreadList.AddAndResumeThread(const aContext: TtfwContext;
 const aWord: TtfwWord);
//#UC START# *50BF1E9C001F_50BF049002DB_var*
var
 l_Thread: TWordThread;
//#UC END# *50BF1E9C001F_50BF049002DB_var*
begin
//#UC START# *50BF1E9C001F_50BF049002DB_impl*
 l_Thread := TWordThread.Create(True);
 aWord.SetRefTo(l_Thread.f_Word);
 l_Thread.f_Context := aContext;
 l_Thread.f_Context.rEngine := l_Thread.f_Context.rEngine.Clone;
 Add(l_Thread);
 l_Thread.Resume;
//#UC END# *50BF1E9C001F_50BF049002DB_impl*
end;//TseWorkThreadList.AddAndResumeThread

class function TseWorkThreadList.Exists: Boolean;
 {* ��������� ������ ��������� ���������� ��� ��� }
begin
 Result := g_TseWorkThreadList <> nil;
end;//TseWorkThreadList.Exists

class function TseWorkThreadList.Instance: TseWorkThreadList;
 {* ����� ��������� ���������� ���������� TseWorkThreadList }
begin
 if (g_TseWorkThreadList = nil) then
 begin
  l3System.AddExitProc(TseWorkThreadListFree);
  g_TseWorkThreadList := Create;
 end;
 Result := g_TseWorkThreadList;
end;//TseWorkThreadList.Instance
{$IfEnd} // NOT Defined(NoScripts)

end.
