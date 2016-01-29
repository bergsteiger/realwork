unit FromWithPanel_Form;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , vtPanel
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
 , vcmInterfaces
;

type
 // ut_FromWithPanel
 
 FromWithPanelFormDef = interface
  {* Идентификатор формы FromWithPanel }
 end;//FromWithPanelFormDef
 
 TFromWithPanelForm = class(TvcmEntityForm, FromWithPanelFormDef)
 end;//TFromWithPanelForm
 
implementation

uses
 l3ImplUses
 , Controls
 , TtfwClassRef_Proxy
 , l3MessageID
 , FromWithPanelKeywordsPack
;

type
 Tkw_FormUserType_ut_FromWithPanel = class(TtfwInteger)
  {* Слово словаря для типа формы ut_FromWithPanel }
 end;//Tkw_FormUserType_ut_FromWithPanel
 
end.
