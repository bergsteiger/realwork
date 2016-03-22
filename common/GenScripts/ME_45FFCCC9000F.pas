unit FolderNotifier_i;

// ������: "w:\garant6x\implementation\Garant\tie\Garant\GblAdapterLib\FolderNotifier_i.pas"
// ���������: "SimpleClass"
// ������� ������: "FolderNotifier_i" MUID: (45FFCCC9000F)

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
   external_folders_change_notifier: IExternalFoldersChangeNotifier;
   done_notifier: IDoneNotifier;
  public
   constructor make; reintroduce; virtual;
   procedure send_notify(status: TNotifyStatus;
    folder_id: Cardinal); virtual;
   function ready: Boolean; virtual;
    {* ���������� true, ���� �������� ����� ������������ ����������� �� �������. }
   procedure set_external_folders_change_notifier(var notifier: IExternalFoldersChangeNotifier); virtual;
    {* ���������� ����������� ��������� }
 end;//FolderNotifier_i

implementation

uses
 l3ImplUses
 , ApplicationHelper
 , DoneNotifier_i
;

constructor FolderNotifier_i.make;
//#UC START# *45FFD1B40251_45FFCCC9000F_var*
//#UC END# *45FFD1B40251_45FFCCC9000F_var*
begin
//#UC START# *45FFD1B40251_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFD1B40251_45FFCCC9000F_impl*
end;//FolderNotifier_i.make

procedure FolderNotifier_i.send_notify(status: TNotifyStatus;
 folder_id: Cardinal);
//#UC START# *45FFD2C10203_45FFCCC9000F_var*
//#UC END# *45FFD2C10203_45FFCCC9000F_var*
begin
//#UC START# *45FFD2C10203_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *45FFD2C10203_45FFCCC9000F_impl*
end;//FolderNotifier_i.send_notify

function FolderNotifier_i.ready: Boolean;
 {* ���������� true, ���� �������� ����� ������������ ����������� �� �������. }
//#UC START# *49DEFD89010A_45FFCCC9000F_var*
//#UC END# *49DEFD89010A_45FFCCC9000F_var*
begin
//#UC START# *49DEFD89010A_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFD89010A_45FFCCC9000F_impl*
end;//FolderNotifier_i.ready

procedure FolderNotifier_i.set_external_folders_change_notifier(var notifier: IExternalFoldersChangeNotifier);
 {* ���������� ����������� ��������� }
//#UC START# *49DEFDAF0082_45FFCCC9000F_var*
//#UC END# *49DEFDAF0082_45FFCCC9000F_var*
begin
//#UC START# *49DEFDAF0082_45FFCCC9000F_impl*
 !!! Needs to be implemented !!!
//#UC END# *49DEFDAF0082_45FFCCC9000F_impl*
end;//FolderNotifier_i.set_external_folders_change_notifier

end.
