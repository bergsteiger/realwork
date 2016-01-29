unit F1LikeTextLoad_Form;

interface

uses
 l3IntfUses
 , PrimTextLoad_Form
 , eeEditorExport
 , eeTextSourceExport
 , evCustomTextSource
 , evCustomEditor
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_F1LikeTextLoad
 
 F1LikeTextLoadFormDef = interface
  {* Идентификатор формы F1LikeTextLoad }
 end;//F1LikeTextLoadFormDef
 
 TF1LikeTextLoadForm = class(TPrimTextLoadForm, F1LikeTextLoadFormDef)
  function TextSource: TevCustomTextSource;
  function Text: TevCustomEditor;
 end;//TF1LikeTextLoadForm
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , l3MessageID
 , F1LikeTextLoadKeywordsPack
;

type
 Tkw_FormUserType_ut_F1LikeTextLoad = class(TtfwInteger)
  {* Слово словаря для типа формы ut_F1LikeTextLoad }
 end;//Tkw_FormUserType_ut_F1LikeTextLoad
 
end.
