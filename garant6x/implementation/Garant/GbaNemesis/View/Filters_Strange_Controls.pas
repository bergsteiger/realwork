unit Filters_Strange_Controls;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\View\Filters_Strange_Controls.pas"
// Стереотип: "VCMControls"
// Элемент модели: "Strange" MUID: (4CCAAA9D00D6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 {$If NOT Defined(NoVCM)}
 , vcmExternalInterfaces
 {$IfEnd} // NOT Defined(NoVCM)
;

const
 en_Filter = 'Filter';
 en_capFilter = '';
 op_Activate = 'Activate';
 op_capActivate = '';
 op_Edit = 'Edit';
 op_capEdit = '';
 op_PersistentFilter = 'PersistentFilter';
 op_capPersistentFilter = '';
 op_RenameFilter = 'RenameFilter';
 op_capRenameFilter = 'Переименовать';
 en_Filters = 'Filters';
 en_capFilters = '';
 op_New = 'New';
 op_capNew = '';
 op_Refresh = 'Refresh';
 op_capRefresh = '';
 op_CreateFilter = 'CreateFilter';
 op_capCreateFilter = 'Добавить фильтр из сохраненных запросов';
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
