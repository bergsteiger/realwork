unit F1LikeFormWithBS_Form;

interface

uses
 l3IntfUses
 , PrimTextLoad_Form
 , nscTreeComboWithHistoryAndOperations
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
 // ut_F1LikeFormWithBS
 
 F1LikeFormWithBSFormDef = interface
  {* Идентификатор формы F1LikeFormWithBS }
 end;//F1LikeFormWithBSFormDef
 
 TF1LikeFormWithBSForm = class(TPrimTextLoadForm, F1LikeFormWithBSFormDef)
  {* Форма с текстовым редактором с базовым поиском. }
  function TextSource: TevCustomTextSource;
  function Text: TevCustomEditor;
 end;//TF1LikeFormWithBSForm
 
implementation

uses
 l3ImplUses
 , Controls
 , Forms
 , TtfwClassRef_Proxy
 , l3MessageID
 , F1LikeFormWithBSKeywordsPack
;

type
 Tkw_FormUserType_ut_F1LikeFormWithBS = class(TtfwInteger)
  {* Слово словаря для типа формы ut_F1LikeFormWithBS }
 end;//Tkw_FormUserType_ut_F1LikeFormWithBS
 
end.
