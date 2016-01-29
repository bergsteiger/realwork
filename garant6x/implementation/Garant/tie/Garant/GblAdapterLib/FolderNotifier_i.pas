unit FolderNotifier_i;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "GblAdapterLib"
// Модуль: "w:/garant6x/implementation/Garant/tie/Garant/GblAdapterLib/FolderNotifier_i.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<SimpleClass::Class>> garant6x::GblAdapterLib::Folders_i::FolderNotifier_i
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

uses
  FoldersUnit
  ;

type
 FolderNotifier_i = class
 private
 // private fields
   current_user : ;
   external_folders_change_notifier : IExternalFoldersChangeNotifier;
   done_notifier : IDoneNotifier;
 public
 // public methods
   constructor Make; virtual;
   procedure SendNotify(status: TNotifyStatus;
    folder_id: Cardinal); virtual;
   function Ready: Boolean; virtual;
     {* Возвращает true, если нотифаер готов обрабатывать нотификацию от сервера. }
   procedure SetExternalFoldersChangeNotifier(var notifier: IExternalFoldersChangeNotifier); virtual;
     {* Установить оболочечный нотифайер }
 end;//FolderNotifier_i

implementation

uses
  ApplicationHelper,
  DoneNotifier_i
  ;

// start class FolderNotifier_i

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

function FolderNotifier_i.Ready: Boolean;
//#UC START# *49DEFD89010A_45FFCCC9000F_var*
//#UC END# *49DEFD89010A_45FFCCC9000F_var*
begin
//#UC START# *49DEFD89010A_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFD89010A_45FFCCC9000F_impl*
end;//FolderNotifier_i.Ready

procedure FolderNotifier_i.SetExternalFoldersChangeNotifier(var notifier: IExternalFoldersChangeNotifier);
//#UC START# *49DEFDAF0082_45FFCCC9000F_var*
//#UC END# *49DEFDAF0082_45FFCCC9000F_var*
begin
//#UC START# *49DEFDAF0082_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFDAF0082_45FFCCC9000F_impl*
end;//FolderNotifier_i.SetExternalFoldersChangeNotifier

end.