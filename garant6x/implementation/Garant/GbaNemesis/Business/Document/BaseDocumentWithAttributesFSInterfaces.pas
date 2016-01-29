unit BaseDocumentWithAttributesFSInterfaces;

interface
uses
 vcmBaseTypes,
 vcmInterfaces;

type
 IfstBaseDocumentWithAttributes = Interface(IvcmFormSet)
 ['{94F7F25C-37CC-4195-A024-C35BD4D973D8}']
   procedure OpenAttributes;
   function pm_GetAttributesNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetAttributesNeedMakeDS(aValue: TvcmNeedMakeDS);
   property AttributesNeedMakeDS: TvcmNeedMakeDS
    read pm_GetAttributesNeedMakeDS
    write pm_SetAttributesNeedMakeDS;
 end;

implementation

end.
