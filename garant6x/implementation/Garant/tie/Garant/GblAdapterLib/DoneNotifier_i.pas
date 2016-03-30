unit DoneNotifier_i;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\DoneNotifier_i.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "DoneNotifier_i" MUID: (45FFCBD60196)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , FoldersUnit
 , FolderNotifier_i
;

type
 DoneNotifier_i = {abstract} class(IDoneNotifier)
  private
   notify_data_list: NotifyDataList;
   fire_done: ByteBool;
   notifier: FolderNotifier_i;
   done_mutex: mutex;
  protected
   function Done: ByteBool; stdcall;
  public
   constructor Make(var servant: FolderNotifier_i); reintroduce; virtual; stdcall;
   procedure AddNotifyData(status: TNotifyStatus;
    folder_id: Cardinal); virtual; stdcall;
   procedure ClearCache; virtual; stdcall;
 end;//DoneNotifier_i

implementation

uses
 l3ImplUses
;

constructor DoneNotifier_i.Make(var servant: FolderNotifier_i);
//#UC START# *45FFCC7F0157_45FFCBD60196_var*
//#UC END# *45FFCC7F0157_45FFCBD60196_var*
begin
//#UC START# *45FFCC7F0157_45FFCBD60196_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFCC7F0157_45FFCBD60196_impl*
end;//DoneNotifier_i.Make

procedure DoneNotifier_i.AddNotifyData(status: TNotifyStatus;
 folder_id: Cardinal);
//#UC START# *45FFDBD202DE_45FFCBD60196_var*
//#UC END# *45FFDBD202DE_45FFCBD60196_var*
begin
//#UC START# *45FFDBD202DE_45FFCBD60196_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDBD202DE_45FFCBD60196_impl*
end;//DoneNotifier_i.AddNotifyData

procedure DoneNotifier_i.ClearCache;
//#UC START# *45FFDBFF01B5_45FFCBD60196_var*
//#UC END# *45FFDBFF01B5_45FFCBD60196_var*
begin
//#UC START# *45FFDBFF01B5_45FFCBD60196_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFDBFF01B5_45FFCBD60196_impl*
end;//DoneNotifier_i.ClearCache

function DoneNotifier_i.Done: ByteBool;
//#UC START# *45EEDB8B032F_45FFCBD60196_var*
//#UC END# *45EEDB8B032F_45FFCBD60196_var*
begin
//#UC START# *45EEDB8B032F_45FFCBD60196_impl*
 !!! Needs to be implemented !!!
//#UC END# *45EEDB8B032F_45FFCBD60196_impl*
end;//DoneNotifier_i.Done

end.
