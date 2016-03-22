unit dsChildDocument;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\dsChildDocument.pas"
// Стереотип: "ViewAreaControllerImp"
// Элемент модели: "TdsChildDocument" MUID: (4958980300D5)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , dsDocument
 , afwInterfaces
;

type
 TdsChildDocument = class(TdsDocument)
  protected
   function DoMakeHAFMacroReplacer: IafwHAFMacroReplacer; override;
 end;//TdsChildDocument
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsDocInfoHAFMacroReplacer
 , nsChildDocInfoHAFMacroReplacer
 , WorkWithDocumentInterfaces
;

function TdsChildDocument.DoMakeHAFMacroReplacer: IafwHAFMacroReplacer;
//#UC START# *49589C6203A6_4958980300D5_var*
//#UC END# *49589C6203A6_4958980300D5_var*
begin
//#UC START# *49589C6203A6_4958980300D5_impl*
 Result := TnsChildDocInfoHAFMacroReplacer.Make(TnsDocInfoHAFMacroReplacer.Make(nil, ucc_BaseDocument.DocInfo), DocInfo)
//#UC END# *49589C6203A6_4958980300D5_impl*
end;//TdsChildDocument.DoMakeHAFMacroReplacer
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
