unit nevControlPara;

interface

uses
 l3IntfUses
 , nevTextPara
 , nevTools
 , evQueryCardInt
 , l3Variant
 , l3Interfaces
 , evdTypes
 , nevBase
 , l3StringIDEx
;

type
 TnevControlPara = class(TnevTextPara, IevCommonControl, IevControl, IevControlFriend)
  function Make(aTag: Tl3Variant): IevControlFriend;
  function Enabled: Boolean;
   {* Доступность ввода. }
  function Checked: Boolean;
   {* кнопка нажата/отпущена. }
  function Flat: Boolean;
   {* доступность ввода. <?> ГЫ, это правильный комментарий? }
  function Name: Tl3WString;
   {* имя контрола. }
  function Text: Tl3WString;
   {* текст контрола. }
  function ControlType: TevControlType;
   {* тип контрола. }
  function Upper: Boolean;
   {* кнопка над мышью. }
  function Collapsed: Boolean;
  function GetControl: IevEditorControl;
   {* Получить контрол по ссылке. }
 end;//TnevControlPara
 
implementation

uses
 l3ImplUses
 , k2Tags
 , l3String
 , afwFacade
 , afwInterfaces
 , l3MessageID
;

end.
