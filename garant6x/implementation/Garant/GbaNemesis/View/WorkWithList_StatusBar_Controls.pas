unit WorkWithList_StatusBar_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/WorkWithList_StatusBar_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Работа с документом и списком документов::WorkWithList::View::StatusBar
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

(* Selection = operations
  {* Выделенные элементы }
   ['{D97C7564-6DFB-41DE-9383-048382A079B4}']
   operation Analize;
     {* Анализ списка... }
   operation CopyToNewList;
 end;//Selection*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Selection = 'Selection';
 en_capSelection = 'Выделенные элементы';
 op_Analize = 'Analize';
 op_capAnalize = 'Анализ списка...';
 op_CopyToNewList = 'CopyToNewList';
 op_capCopyToNewList = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.