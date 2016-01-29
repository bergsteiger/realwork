unit UnderControl_Strange_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/UnderControl_Strange_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Работа с документом и списком документов::UnderControl::View::Strange
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

(* ControlCenter = operations
   ['{B58388CB-B2A8-4471-9DDE-7E388FD17C09}']
   query Add;
   operation CreateList;
   operation Sort;
   operation ClearAllStatus;
 end;//ControlCenter*)

(* ControledObject = operations
   ['{BBA2768B-BC8D-4858-B9CA-94814702E1F9}']
   operation Open;
   operation ClearStatus;
 end;//ControledObject*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_ControlCenter = 'ControlCenter';
 en_capControlCenter = '';
 op_Add = 'Add';
 op_capAdd = '';
 op_CreateList = 'CreateList';
 op_capCreateList = '';
 op_Sort = 'Sort';
 op_capSort = '';
 op_ClearAllStatus = 'ClearAllStatus';
 op_capClearAllStatus = '';
 en_ControledObject = 'ControledObject';
 en_capControledObject = '';
 op_Open = 'Open';
 op_capOpen = '';
 op_ClearStatus = 'ClearStatus';
 op_capClearStatus = '';
{$IfEnd} //not Admin AND not Monitorings

implementation

end.