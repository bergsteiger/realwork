unit dsSynchroViewDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\List\dsSynchroViewDocument.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsSynchroViewDocument" MUID: (5024E60F00A6)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocument
 , nevTools
;

type
 TdsSynchroViewDocument = class(TdsDocument)
  protected
   function MakeContainer: InevDocumentContainer; override;
    {* Конструирует контейнер документа }
 end;//TdsSynchroViewDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsAACDocumentSynchroViewContainer
 , DocumentUnit
 //#UC START# *5024E60F00A6impl_uses*
 //#UC END# *5024E60F00A6impl_uses*
;

function TdsSynchroViewDocument.MakeContainer: InevDocumentContainer;
 {* Конструирует контейнер документа }
//#UC START# *4C6AB38800F3_5024E60F00A6_var*
//#UC END# *4C6AB38800F3_5024E60F00A6_var*
begin
//#UC START# *4C6AB38800F3_5024E60F00A6_impl*
 Case DocInfo.DocType of
  DT_ACTUAL_ANALYTICS,
  DT_ACTUAL_ANALYTICS_CONTENTS:
   Result := TnsAACDocumentSynchroViewContainer.Make(DocInfo);
  else
   Result := inherited MakeContainer;
 end;//Case DocInfo.DocType
//#UC END# *4C6AB38800F3_5024E60F00A6_impl*
end;//TdsSynchroViewDocument.MakeContainer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
