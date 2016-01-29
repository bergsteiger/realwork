unit vcmMessageFormPrim;

interface

uses
 l3IntfUses
 , vcmEntityForm
 , Dialogs
 , vg_scene
 , Controls
 , StdCtrls
 , vgVisualObject
;

type
 TvcmMessageFormPrim = class(TvcmEntityForm)
  procedure CMDialogKey(var Message: TCMDialogKey);
 end;//TvcmMessageFormPrim
 
implementation

uses
 l3ImplUses
 , Windows
 , vg_controls
 , vtDialogsResEx
 , Forms
 , TtfwClassRef_Proxy
;

type
 TCustomCheckBoxHack = class(TCustomCheckBox)
 end;//TCustomCheckBoxHack
 
 TvgVisualObjectHack = class(TvgVisualObject)
 end;//TvgVisualObjectHack
 
end.
