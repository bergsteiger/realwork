unit NOT_FINISHED_ddServerTask;

// Модуль: "w:\common\components\rtl\Garant\cs\NOT_FINISHED_ddServerTask.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "ddServerTask" MUID: (52FA49C7022C)

{$Include w:\common\components\rtl\Garant\cs\CsDefine.inc}

interface

{$If NOT Defined(Nemesis)}
uses
 l3IntfUses
 , ddTaskItemPrim
 , dt_Types
 , Classes
;

type
 TddTaskClass = class of TddTaskItem;

 TddTaskItem = class(TddTaskItemPrim)
  protected
   procedure DoLoadFrom(aStream: TStream;
    aIsPipe: Boolean); virtual;
   function GetDescription: AnsiString; virtual;
  public
   procedure AssignFrom(P: TddTaskItem);
   constructor Create(aUserID: TUserID); reintroduce; virtual;
   procedure DoSaveTo(aStream: TStream;
    aIsPipe: Boolean); virtual;
 end;//TddTaskItem

procedure RegisterTaskClass;
{$IfEnd} // NOT Defined(Nemesis)

implementation

{$If NOT Defined(Nemesis)}
uses
 l3ImplUses
 , ddTaskClassManager
 , csTaskListening
;

procedure RegisterTaskClass;
//#UC START# *53B3D9E702BA_52FA49C7022C_var*
//#UC END# *53B3D9E702BA_52FA49C7022C_var*
begin
//#UC START# *53B3D9E702BA_52FA49C7022C_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B3D9E702BA_52FA49C7022C_impl*
end;//RegisterTaskClass

procedure TddTaskItem.AssignFrom(P: TddTaskItem);
//#UC START# *52FA510700F0_52FA49DF00EF_var*
//#UC END# *52FA510700F0_52FA49DF00EF_var*
begin
//#UC START# *52FA510700F0_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *52FA510700F0_52FA49DF00EF_impl*
end;//TddTaskItem.AssignFrom

constructor TddTaskItem.Create(aUserID: TUserID);
//#UC START# *53B3D8A8011F_52FA49DF00EF_var*
//#UC END# *53B3D8A8011F_52FA49DF00EF_var*
begin
//#UC START# *53B3D8A8011F_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53B3D8A8011F_52FA49DF00EF_impl*
end;//TddTaskItem.Create

procedure TddTaskItem.DoSaveTo(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481990243_52FA49DF00EF_var*
//#UC END# *53E481990243_52FA49DF00EF_var*
begin
//#UC START# *53E481990243_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E481990243_52FA49DF00EF_impl*
end;//TddTaskItem.DoSaveTo

procedure TddTaskItem.DoLoadFrom(aStream: TStream;
 aIsPipe: Boolean);
//#UC START# *53E481DF03D1_52FA49DF00EF_var*
//#UC END# *53E481DF03D1_52FA49DF00EF_var*
begin
//#UC START# *53E481DF03D1_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53E481DF03D1_52FA49DF00EF_impl*
end;//TddTaskItem.DoLoadFrom

function TddTaskItem.GetDescription: AnsiString;
//#UC START# *53FB28170339_52FA49DF00EF_var*
//#UC END# *53FB28170339_52FA49DF00EF_var*
begin
//#UC START# *53FB28170339_52FA49DF00EF_impl*
 !!! Needs to be implemented !!!
//#UC END# *53FB28170339_52FA49DF00EF_impl*
end;//TddTaskItem.GetDescription
{$IfEnd} // NOT Defined(Nemesis)

end.
