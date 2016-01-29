unit nscComboBox;

interface

uses
 l3IntfUses
 , vtComboTree
;

type
 TnscEdit = class(TnscComboBox)
 end;//TnscEdit
 
 TnscEditWithoutPlusMinusShortcut = class(TnscEdit)
 end;//TnscEditWithoutPlusMinusShortcut
 
 TnscComboBoxWithPwdChar = class(TnscEdit)
 end;//TnscComboBoxWithPwdChar
 
 TnscComboBox = class(TvtComboTree)
 end;//TnscComboBox
 
implementation

uses
 l3ImplUses
 , TtfwClassRef_Proxy
;

end.
