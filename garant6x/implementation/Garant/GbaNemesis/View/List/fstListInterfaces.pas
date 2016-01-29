unit fstListInterfaces;

interface
uses
 vcmInterfaces,
 vcmBaseTypes,

 SimpleListInterfaces,
 WorkWithListInterfaces,
 DocInfoFSInterfaces,

 bsTypes;

type
 IfstList = Interface(IfstDocInfo)
 ['{FEA7FB72-DA4E-489E-AB08-E415AEDC4BA4}']
  function pm_GetDisableAutoOpenAnnotation: Boolean;
  procedure pm_SetDisableAutoOpenAnnotation(aValue: Boolean);
  function pm_GetBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetBaloonWarningNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetListAnalizeNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetListAnalizeNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetTextBaloonWarningNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetTextBaloonWarningNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetFiltersNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetFiltersNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetAsIucpFilters: IucpFilters;
  function pm_GetCurrentSynchroForm: TList_SynchroView_Areas;
  procedure pm_SetCurrentSynchroForm(aValue: TList_SynchroView_Areas);
  function pm_GetCurrentSynchroFormNeedMakeDS: TvcmNeedMakeDS;
  procedure pm_SetCurrentSynchroFormNeedMakeDS(aValue: TvcmNeedMakeDS);
  function pm_GetDefaultSynchroForm: TList_SynchroView_Areas;
  procedure OpenDocument;
  {* Открывает ViewArea "Собственно документ" }
  procedure SetNeedMakeForFullCR(aListType: TlstCRType);
  // properties
  property DisableAutoOpenAnnotation: Boolean
   read pm_GetDisableAutoOpenAnnotation
   write pm_SetDisableAutoOpenAnnotation;
  property BaloonWarningNeedMakeDS: TvcmNeedMakeDS
   read pm_GetBaloonWarningNeedMakeDS
   write pm_SetBaloonWarningNeedMakeDS;
  property ListAnalizeNeedMakeDS: TvcmNeedMakeDS
   read pm_GetListAnalizeNeedMakeDS
   write pm_SetListAnalizeNeedMakeDS;
  property TextBaloonWarningNeedMakeDS: TvcmNeedMakeDS
   read pm_GetTextBaloonWarningNeedMakeDS
   write pm_SetTextBaloonWarningNeedMakeDS;
  property FiltersNeedMakeDS: TvcmNeedMakeDS
   read pm_GetFiltersNeedMakeDS
   write pm_SetFiltersNeedMakeDS;
  property AsIucpFilters: IucpFilters
   read pm_GetAsIucpFilters;
  property CurrentSynchroForm: TList_SynchroView_Areas
   read pm_GetCurrentSynchroForm
   write pm_SetCurrentSynchroForm;
  property CurrentSynchroFormNeedMakeDS: TvcmNeedMakeDS
   read pm_GetCurrentSynchroFormNeedMakeDS
   write pm_SetCurrentSynchroFormNeedMakeDS;
  property DefaultSynchroForm: TList_SynchroView_Areas
   read pm_GetDefaultSynchroForm;
 end;


implementation

end.