unit BaseDocumentFSInterfaces;

interface
uses
 vcmBaseTypes,
 vcmInterfaces;

type
 IfstBaseDocument = Interface(IvcmFormSet)
 ['{23FB6861-5CC8-4CEC-8379-1448D67BE621}']
  function pm_GetDocumentNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetDocumentNeedMakeDS(aValue: TvcmNeedMakeDS);
  property DocumentNeedMakeDS: TvcmNeedMakeDS
   read pm_GetDocumentNeedMakeDS
   write pm_SetDocumentNeedMakeDS;
 end;

implementation

end.