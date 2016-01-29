unit vg_listbox;

interface

uses
 l3IntfUses
 , vg_controls
 , vg_scene
;

type
 TvgStringComboBox = class(TvgTextControl)
 end;//TvgStringComboBox
 
 TvgComboBox = class(TvgControl)
 end;//TvgComboBox
 
 TvgListBoxItem = class(TvgTextControl)
 end;//TvgListBoxItem
 
 TvgListBox = class
 end;//TvgListBox
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
 , VGComboBoxPack
;

end.
