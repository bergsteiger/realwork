unit nevDocumentProvider4PDF;

// Модуль: "w:\common\components\gui\Garant\Everest\nevDocumentProvider4PDF.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevDocumentProvider4PDF" MUID: (541149B203E1)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , nevDocumentProviderEx
 , afwInterfaces
;

type
 TnevDocumentProvider4PDF = class(TnevDocumentProviderEx)
  protected
   function pm_GetCanProvideOriginalDocument: Boolean; override;
   function pm_GetPageSetup: IafwPageSetup; override;
 end;//TnevDocumentProvider4PDF

implementation

uses
 l3ImplUses
 //#UC START# *541149B203E1impl_uses*
 //#UC END# *541149B203E1impl_uses*
;

function TnevDocumentProvider4PDF.pm_GetCanProvideOriginalDocument: Boolean;
//#UC START# *4CB589C80045_541149B203E1get_var*
//#UC END# *4CB589C80045_541149B203E1get_var*
begin
//#UC START# *4CB589C80045_541149B203E1get_impl*
 Result := False;
//#UC END# *4CB589C80045_541149B203E1get_impl*
end;//TnevDocumentProvider4PDF.pm_GetCanProvideOriginalDocument

function TnevDocumentProvider4PDF.pm_GetPageSetup: IafwPageSetup;
//#UC START# *4D18832500B4_541149B203E1get_var*
//#UC END# *4D18832500B4_541149B203E1get_var*
begin
//#UC START# *4D18832500B4_541149B203E1get_impl*
 Result := Self;
//#UC END# *4D18832500B4_541149B203E1get_impl*
end;//TnevDocumentProvider4PDF.pm_GetPageSetup

end.
