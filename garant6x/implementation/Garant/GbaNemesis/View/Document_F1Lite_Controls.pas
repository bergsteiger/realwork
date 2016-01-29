unit Document_F1Lite_Controls;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "View"
// Модуль: "w:/garant6x/implementation/Garant/GbaNemesis/View/Document_F1Lite_Controls.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<VCMControls::Category>> F1 Работа с документом и списком документов::Document::View::F1Lite
//
// Урезанные "сущности" для таких форм как документ-схема
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

(* Edit = operations
  {* Правка }
   ['{C0AE3E2E-B0F6-461B-B870-3EF896F8AE35}']
   operation ToggleFoundWords;
     {* Подсвечивать найденный контекст }
 end;//Edit*)

(* Text = operations
   ['{14C12509-3670-43CD-ACD1-F3EB8F46DC3C}']
   operation AddToControl; has states;
     {* Поставить на контроль }
      RemoveFromControl = state
       { Снять с контроля }
      end;//RemoveFromControl
   operation AddToControl; has states;
 end;//Text*)

(* Selection = operations
   ['{7F3A0764-8FF9-4EF4-A641-1220243E8F57}']
   operation ShowCorrespondentListToPart;
   operation ShowRespondentListToPart;
 end;//Selection*)
{$IfEnd} //not Admin AND not Monitorings

{$If not defined(Admin) AND not defined(Monitorings)}
const
 en_Edit = 'Edit';
 en_capEdit = 'Правка';
 op_ToggleFoundWords = 'ToggleFoundWords';
 op_capToggleFoundWords = 'Подсвечивать найденный контекст';
 en_Text = 'Text';
 en_capText = '';
 op_AddToControl = 'AddToControl';
 op_capAddToControl = 'Поставить на контроль';
 en_Selection = 'Selection';
 en_capSelection = '';
 op_ShowCorrespondentListToPart = 'ShowCorrespondentListToPart';
 op_capShowCorrespondentListToPart = '';
 op_ShowRespondentListToPart = 'ShowRespondentListToPart';
 op_capShowRespondentListToPart = '';

// Состояния операций:
var st_user_Text_AddToControl_RemoveFromControl : TvcmOperationStateIndex = (rID : -1);
  // Text$ForDocument -> Поставить на контроль <-> Снять с контроля
{$IfEnd} //not Admin AND not Monitorings

implementation

end.