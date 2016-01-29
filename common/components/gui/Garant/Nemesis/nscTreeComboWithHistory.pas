unit nscTreeComboWithHistory;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Nemesis"
// Модуль: "w:/common/components/gui/Garant/Nemesis/nscTreeComboWithHistory.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<GuiControl::Class>> Shared Delphi For F1::Nemesis::Editor::TnscTreeComboWithHistory
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Полностью генерируется с модели. Править руками - нельзя. !

{$Include ..\Nemesis\nscDefine.inc}

interface

{$If defined(Nemesis)}
uses
  Graphics,
  nscCustomTreeComboWithHistory,
  nscConst
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}
const
  { TnscTreeComboWithHistory Default Values }
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
{$IfEnd} //Nemesis

implementation

{$If defined(Nemesis)}
uses
  Classes
  {$If not defined(NoScripts)}
  ,
  TtfwClassRef_Proxy
  {$IfEnd} //not NoScripts
  
  ;
{$IfEnd} //Nemesis

{$If defined(Nemesis)}


//#UC START# *4B97EE390310impl*
//#UC END# *4B97EE390310impl*

{$IfEnd} //Nemesis

initialization
{$If defined(Nemesis) AND not defined(NoScripts)}
// Регистрация TnscTreeComboWithHistory
 TtfwClassRef.Register(TnscTreeComboWithHistory);
{$IfEnd} //Nemesis AND not NoScripts

end.