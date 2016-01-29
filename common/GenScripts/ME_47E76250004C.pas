unit ActnList;

interface

uses
 l3IntfUses
 , Classes
;

type
 TContainedAction = class(TBasicAction)
 end;//TContainedAction
 
 TCustomAction = class(TContainedAction)
 end;//TCustomAction
 
 TShortCutList = class
 end;//TShortCutList
 
 TAction = class(TCustomAction)
 end;//TAction
 
 TCustomActionList = class
 end;//TCustomActionList
 
 TActionLinkClass = class of TActionLink;
 
 TActionLink = class(TBasicActionLink)
  function IsCaptionLinked: Boolean;
  function IsCheckedLinked: Boolean;
  function IsEnabledLinked: Boolean;
  function IsGroupIndexLinked: Boolean;
  function IsHelpContextLinked: Boolean;
  function IsHelpLinked: Boolean;
  function IsHintLinked: Boolean;
  function IsImageIndexLinked: Boolean;
  function IsShortCutLinked: Boolean;
  function IsVisibleLinked: Boolean;
  procedure SetAutoCheck(Value: Boolean);
  procedure SetCaption(const Value: String);
  procedure SetChecked(Value: Boolean);
  procedure SetEnabled(Value: Boolean);
  procedure SetGroupIndex(Value: Integer);
  procedure SetHelpContext(Value: THelpContext);
  procedure SetHelpKeyword(const Value: AnsiString);
  procedure SetHelpType(Value: THelpType);
  procedure SetHint(const Value: AnsiString);
  procedure SetImageIndex(Value: Integer);
  procedure SetShortCut(Value: TShortCut);
  procedure SetVisible(Value: Boolean);
 end;//TActionLink
 
 TActionList = class(TCustomActionList)
 end;//TActionList
 
implementation

uses
 l3ImplUses
 , ContainedActionsWordspack
 , ActionListWordsPack
;

end.
