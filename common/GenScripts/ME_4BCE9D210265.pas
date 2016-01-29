unit elCustomEdit_Form;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , elCustomEdit
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_elCustomEdit
 
 elCustomEditFormDef = interface
  {* Идентификатор формы elCustomEdit }
 end;//elCustomEditFormDef
 
 TelCustomEditForm = class(TvcmEntityForm, elCustomEditFormDef)
  {* Форма для тестирования TelCustomEdit }
 end;//TelCustomEditForm
 
implementation

uses
 l3ImplUses
 , Forms
 , TtfwClassRef_Proxy
 , l3MessageID
 , elCustomEditKeywordsPack
;

type
 Tkw_FormUserType_ut_elCustomEdit = class(TtfwInteger)
  {* Слово словаря для типа формы ut_elCustomEdit }
 end;//Tkw_FormUserType_ut_elCustomEdit
 
end.
