unit nscTreeComboWithHistory;

// Модуль: "w:\common\components\gui\Garant\Nemesis\nscTreeComboWithHistory.pas"
// Стереотип: "GuiControl"

{$Include w:\common\components\gui\Garant\Nemesis\nscDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , nscCustomTreeComboWithHistory
 , nscConst
 , Graphics
;

const
 cDefaultContextEmptyColor = nscConst.cDefaultContextEmptyColor;
 clWindowText = Graphics.clWindowText;
 clBlue = Graphics.clBlue;

type
 //#UC START# *4B97EE390310ci*
 //#UC END# *4B97EE390310ci*
 //#UC START# *4B97EE390310cit*
 //#UC END# *4B97EE390310cit*
 TnscTreeComboWithHistory = class(TnscCustomTreeComboWithHistory)
 //#UC START# *4B97EE390310publ*
  public
   property Button;
  published
   property Anchors;
   property Ctl3D;
   property EmptyHint;
   property EmptyHintColor default cDefaultContextEmptyColor;
   property Enabled;
   property Font;
   property ParentColor;
   property ParentCtl3D;
   property ParentFont;
   property ParentShowHint;
   property ShowHint;
   property TabOrder;
   property UseSystemMenu;
   property PopupMenu;
   property DropDownCount default 7;
   property PromptColor default clWindowText;
   property PromptStyle default [];
   property PromptBackColor default $02BDF9FF;
   property PromptViewOptions default [];
   property OnPastingString;
   property OnResize;
   property OnSelect;
   property CloseHyperLinkColor default clBlue;
 //#UC END# *4B97EE390310publ*
 end;//TnscTreeComboWithHistory
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
;

//#UC START# *4B97EE390310impl*
//#UC END# *4B97EE390310impl*

initialization
{$If NOT Defined(NoScripts)}
 TtfwClassRef.Register(TnscTreeComboWithHistory);
 {* Регистрация TnscTreeComboWithHistory }
{$IfEnd} // NOT Defined(NoScripts)
{$IfEnd} // Defined(Nemesis)

end.
