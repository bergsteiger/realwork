unit DocInfoFSInterfaces;

interface
uses
 vcmBaseTypes,
 vcmInterfaces,

 BaseDocumentWithAttributesFSInterfaces;

type
 IfstDocInfo = Interface(IfstBaseDocumentWithAttributes)
 ['{4CA7762E-2C91-4FF9-9E4D-38A30AF11368}']
   procedure OpenCorrespondents;
     {* корреспонденты }
   procedure OpenRespondents;
     {* респонденты }
   procedure OpenSimilar;
   procedure OpenRelated;
   procedure OpenAnnotation;
   function pm_GetCorrespondentsNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetCorrespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetRespondentsNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetRespondentsNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetRelatedDocNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetRelatedDocNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetUserCR1NeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetUserCR1NeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetUserCR2NeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetUserCR2NeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetDocumentWithFlashNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetDocumentWithFlashNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetAnnotationNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetAnnotationNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetTranslationNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetTranslationNeedMakeDS(aValue: TvcmNeedMakeDS);
   function pm_GetSimilarDocumentsNeedMakeDS: TvcmNeedMakeDS;
   procedure pm_SetSimilarDocumentsNeedMakeDS(aValue: TvcmNeedMakeDS);
   // properties
   property CorrespondentsNeedMakeDS: TvcmNeedMakeDS
    read pm_GetCorrespondentsNeedMakeDS
    write pm_SetCorrespondentsNeedMakeDS;
   property RespondentsNeedMakeDS: TvcmNeedMakeDS
    read pm_GetRespondentsNeedMakeDS
    write pm_SetRespondentsNeedMakeDS;
   property RelatedDocNeedMakeDS: TvcmNeedMakeDS
    read pm_GetRelatedDocNeedMakeDS
    write pm_SetRelatedDocNeedMakeDS;
   property UserCR1NeedMakeDS: TvcmNeedMakeDS
    read pm_GetUserCR1NeedMakeDS
    write pm_SetUserCR1NeedMakeDS;
   property UserCR2NeedMakeDS: TvcmNeedMakeDS
    read pm_GetUserCR2NeedMakeDS
    write pm_SetUserCR2NeedMakeDS;
   property DocumentWithFlashNeedMakeDS: TvcmNeedMakeDS
    read pm_GetDocumentWithFlashNeedMakeDS
    write pm_SetDocumentWithFlashNeedMakeDS;
   property AnnotationNeedMakeDS: TvcmNeedMakeDS
    read pm_GetAnnotationNeedMakeDS
    write pm_SetAnnotationNeedMakeDS;
   property TranslationNeedMakeDS: TvcmNeedMakeDS
    read pm_GetTranslationNeedMakeDS
    write pm_SetTranslationNeedMakeDS;
   property SimilarDocumentsNeedMakeDS: TvcmNeedMakeDS
    read pm_GetSimilarDocumentsNeedMakeDS
    write pm_SetSimilarDocumentsNeedMakeDS;
 end;

implementation

end.