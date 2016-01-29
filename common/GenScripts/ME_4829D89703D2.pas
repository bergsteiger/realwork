unit evCustomEditor;

interface

uses
 l3IntfUses
 , evCustomEditorModelPart
 , evdTypes
 , evTypes
;

type
 TevCustomEditor = class(TevCustomEditorModelPart)
  {* Базовый класс окна редактора с кучей "полезных" функций. Рекомендуется для конечного пользователя (программиста). }
  function InTable: Boolean;
  function InsertPageBreak(NeedNewSection: Boolean;
   aPageOrientation: TevPageOrientation): Boolean;
  procedure DecIndent;
  procedure IncIndent;
  function DoSearchHyperLink(const anOption: TevSearchOptionSetEx): Boolean;
  function AllowAutoSelectByMouse: Boolean;
 end;//TevCustomEditor
 
implementation

uses
 l3ImplUses
 , evdInterfaces
 , TtfwClassRef_Proxy
 , TevCustomEditorWordsPack
;

end.
