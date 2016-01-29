unit DoneNotifier_i;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/DoneNotifier_i.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::DoneNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  FoldersUnit,
  FolderNotifier_i
  ;

type
 DoneNotifier_i = {abstract} class(, IDoneNotifier)
 private
 // private fields
   notify_data_list : NotifyDataList;
   fire_done : Boolean;
   notifier : FolderNotifier_i;
   done_mutex : mutex;
 protected
 // realized methods
   function Done: ByteBool; stdcall;
 public
 // public methods
   constructor Make(var servant: FolderNotifier_i); virtual;
   procedure AddNotifyData(status: TNotifyStatus;
    folder_id: Cardinal); virtual;
   procedure ClearCache; virtual;
 end;//DoneNotifier_i

implementation

// start class DoneNotifier_i

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