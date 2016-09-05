unit FolderNotifier_i;

// Модуль: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FolderNotifier_i.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "FolderNotifier_i" MUID: (45FFCCC9000F)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
 l3IntfUses
 , FoldersUnit
;

type
 // NotifierStatusConvertor

 FolderNotifier_i = class
  private
   current_user: ;
   external_folders_change_notifier: ;
   done_notifier: ;
  public
   constructor Make; reintroduce; virtual; stdcall;
   procedure SendNotify(status: TNotifyStatus;
    folder_id: Cardinal); virtual; stdcall;
   function Ready: ByteBool; virtual; stdcall;
    {* Возвращает true, если нотифаер готов обрабатывать нотификацию от сервера. }
   procedure SetExternalFoldersChangeNotifier(var notifier: IExternalFoldersChangeNotifier); virtual; stdcall;
    {* Установить оболочечный нотифайер }
 end;//FolderNotifier_i

implementation

uses
 l3ImplUses
 , ApplicationHelper
 , DoneNotifier_i
 //#UC START# *45FFCCC9000Fimpl_uses*
 //#UC END# *45FFCCC9000Fimpl_uses*
;

constructor FolderNotifier_i.Make;
//#UC START# *45FFD1B40251_45FFCCC9000F_var*
//#UC END# *45FFD1B40251_45FFCCC9000F_var*
begin
//#UC START# *45FFD1B40251_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFD1B40251_45FFCCC9000F_impl*
end;//FolderNotifier_i.Make

procedure FolderNotifier_i.SendNotify(status: TNotifyStatus;
 folder_id: Cardinal);
//#UC START# *45FFD2C10203_45FFCCC9000F_var*
//#UC END# *45FFD2C10203_45FFCCC9000F_var*
begin
//#UC START# *45FFD2C10203_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFD2C10203_45FFCCC9000F_impl*
end;//FolderNotifier_i.SendNotify

function FolderNotifier_i.Ready: ByteBool;
 {* Возвращает true, если нотифаер готов обрабатывать нотификацию от сервера. }
//#UC START# *49DEFD89010A_45FFCCC9000F_var*
//#UC END# *49DEFD89010A_45FFCCC9000F_var*
begin
//#UC START# *49DEFD89010A_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFD89010A_45FFCCC9000F_impl*
end;//FolderNotifier_i.Ready

procedure FolderNotifier_i.SetExternalFoldersChangeNotifier(var notifier: IExternalFoldersChangeNotifier);
 {* Установить оболочечный нотифайер }
//#UC START# *49DEFDAF0082_45FFCCC9000F_var*
//#UC END# *49DEFDAF0082_45FFCCC9000F_var*
begin
//#UC START# *49DEFDAF0082_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFDAF0082_45FFCCC9000F_impl*
end;//FolderNotifier_i.SetExternalFoldersChangeNotifier

end.
