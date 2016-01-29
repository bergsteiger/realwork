unit evLabel;

interface

uses
 l3IntfUses
 , evControl
 , afwNavigation
 , evQueryCardInt
 , l3Interfaces
 , nevTools
 , nevBase
 , l3IID
;

type
 TevLabel = class(TevControl, IevMoniker, IevEditorControlLabel)
  {* Класс для надисей (названий реквизитов) }
  procedure RestoreCaption;
   {* Восстанавливает название метки. }
  function Caption: Il3CString;
   {* Текст метки.
У Димы - Get_Text/Set_Text. }
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
 end;//TevLabel
 
implementation

uses
 l3ImplUses
 , l3String
 , evQueryCardDropControlsInt
 , nevNavigation
 , SysUtils
 , l3Base
 , l3Chars
 , OvcConst
 , k2Tags
;

end.
