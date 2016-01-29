unit PrimTextLoad_Form;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , evCustomTextSource
 , evCustomEditor
 , evLoadDocumentManager
;

type
 TPrimTextLoadForm = class(TvcmEntityForm)
  procedure AfterLoad;
 end;//TPrimTextLoadForm
 
implementation

uses
 l3ImplUses
 , Forms
 , Controls
 , TtfwClassRef_Proxy
;

end.
