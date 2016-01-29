unit Filters_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Filters_Strange_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Основные прецеденты::Filters::View::Strange
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If not defined(Admin) AND not defined(Monitorings)}
uses
  vcmExternalInterfaces {a}
  ;

(* Filter = operations
   ['{0A49028E-37A2-47F7-A672-671C0DDE9E4E}']
   FormActivate Activate;
   operation Edit;
   operation PersistentFilter;
   operation RenameFilter;
     {* Переименовать }
 end;//Filter*)

(* Filters = operations
   ['{52910AE6-4E3E-4D9B-9BAB-64457B159AAE}']
   operation New;
   operation Refresh;
 end;//Filters*)

(* Filter = operations
   ['{FB296D10-6586-415F-A967-937CAAF7F8CA}']
   query CreateFilter;
     {* Добавить фильтр из сохраненных запросов }
 end;//Filter*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
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
{$IfEnd} //not Admin AND not Monitorings

implementation

end.