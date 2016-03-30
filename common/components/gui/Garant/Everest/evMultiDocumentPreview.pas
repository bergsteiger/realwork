unit evMultiDocumentPreview;
 {* ѕредварительный просмотр нескольких документов пачкой. }

// ћодуль: "w:\common\components\gui\Garant\Everest\evMultiDocumentPreview.pas"
// —тереотип: "SimpleClass"
// Ёлемент модели: "TevMultiDocumentPreview" MUID: (47FA06400313)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , afwMultiDocumentPreview
 , afwInterfaces
;

type
 TevMultiDocumentPreview = class(TafwMultiDocumentPreview)
  {* ѕредварительный просмотр нескольких документов пачкой. }
  protected
   function GetDocumentName: IafwCString; override;
 end;//TevMultiDocumentPreview

implementation

uses
 l3ImplUses
 , nevInterfaces
;

function TevMultiDocumentPreview.GetDocumentName: IafwCString;
//#UC START# *480DE6420179_47FA06400313_var*
//#UC END# *480DE6420179_47FA06400313_var*
begin
//#UC START# *480DE6420179_47FA06400313_impl*
 Result := str_nevpmDocumentList.AsCStr;
//#UC END# *480DE6420179_47FA06400313_impl*
end;//TevMultiDocumentPreview.GetDocumentName

end.
