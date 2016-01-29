unit evButtonControl;

interface

uses
 l3IntfUses
 , evControl
 , evQueryCardInt
 , nevTools
 , nevBase
;

type
 TevButtonControl = class(TevControl, IevEditorControlButton, IevEditorStateButton)
  {* Класс кнопки }
  procedure IncButtonState;
   {* Изменяет состояние кнопки }
  function GetButtonType: TevButtonType;
  function StateCount: Integer;
   {* Количество состояний. }
  function CurrentIndex: Integer;
   {* Текущая картинка для отображения. }
  function ImageIndex: Integer;
   {* Начальный номер картинки. }
  function GetStateIndex: Integer;
   {* Собственно возвращает состояние кнопки от 0 до максимального. }
  function DoLMouseBtnUp(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean): Boolean;
  function DoLMouseBtnDown(const aView: InevControlView;
   const aTextPara: InevPara;
   const aPt: TnevPoint;
   const Keys: TevMouseState;
   anInPara: Boolean;
   const aMap: InevMap): Boolean;
 end;//TevButtonControl
 
implementation

uses
 l3ImplUses
 , k2Tags
 , evQueryCardDropControlsInt
 , evQueryCardConst
 , l3String
 , OvcConst
 , SysUtils
 , l3Units
 , l3Base
;

end.
