unit PrimParent_Form;

interface

uses
 l3IntfUses
 , vcmContainerForm
 , vtPanel
 , vcmInterfaces
 , l3StringIDEx
 , vcmUserControls
 , tfwInteger
;

type
 // ParentZone
 
 // utHistory
 
 TPrimParentForm = class(TvcmContainerForm)
 end;//TPrimParentForm
 
implementation

uses
 l3ImplUses
 , Windows
 , Graphics
 , SysUtils
 , Forms
 , Controls
 , l3MessageID
 , TtfwClassRef_Proxy
;

type
 Tkw_FormUserType_utHistory = class(TtfwInteger)
  {* Слово словаря для типа формы utHistory }
 end;//Tkw_FormUserType_utHistory
 
end.
