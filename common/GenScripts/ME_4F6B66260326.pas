unit ParentAndChildPrim_Module;

interface

uses
 l3IntfUses
 , vcmMainForm
 , vcmEntityForm
 , PrimParent_Form
 , F1Like_FormDefinitions_Controls
 , PrimChild_Form
;

type
 TParentForm = class(TPrimParentForm, ParentFormDef)
 end;//TParentForm
 
 TChildForm = class(TPrimChildForm, ChildFormDef)
 end;//TChildForm
 
 TParentAndChildPrimModule = class
  procedure MakeChild(aMainForm: TvcmMainForm;
   anOwner: TvcmEntityForm);
  procedure MakeParent(aMainForm: TvcmMainForm);
 end;//TParentAndChildPrimModule
 
implementation

uses
 l3ImplUses
 , vcmBase
 , TtfwClassRef_Proxy
 , ParentKeywordsPack
 , ChildKeywordsPack
;

end.
