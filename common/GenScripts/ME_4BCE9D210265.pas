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
  {* ������������� ����� elCustomEdit }
 end;//elCustomEditFormDef
 
 TelCustomEditForm = class(TvcmEntityForm, elCustomEditFormDef)
  {* ����� ��� ������������ TelCustomEdit }
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
  {* ����� ������� ��� ���� ����� ut_elCustomEdit }
 end;//Tkw_FormUserType_ut_elCustomEdit
 
end.
