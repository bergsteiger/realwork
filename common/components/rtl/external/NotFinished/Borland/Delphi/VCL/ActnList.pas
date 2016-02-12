unit ActnList;

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Vcl\ActnList.pas"
// Стереотип: "UtilityPack"

interface

{$If NOT Defined(NoVCL)}
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
  protected
   function IsCaptionLinked: Boolean; virtual;
   function IsCheckedLinked: Boolean; virtual;
   function IsEnabledLinked: Boolean; virtual;
   function IsGroupIndexLinked: Boolean; virtual;
   function IsHelpContextLinked: Boolean; virtual;
   function IsHelpLinked: Boolean; virtual;
   function IsHintLinked: Boolean; virtual;
   function IsImageIndexLinked: Boolean; virtual;
   function IsShortCutLinked: Boolean; virtual;
   function IsVisibleLinked: Boolean; virtual;
   procedure SetAutoCheck(Value: Boolean); virtual;
   procedure SetCaption(const Value: String); virtual;
   procedure SetChecked(Value: Boolean); virtual;
   procedure SetEnabled(Value: Boolean); virtual;
   procedure SetGroupIndex(Value: Integer); virtual;
   procedure SetHelpContext(Value: THelpContext); virtual;
   procedure SetHelpKeyword(const Value: AnsiString); virtual;
   procedure SetHelpType(Value: THelpType); virtual;
   procedure SetHint(const Value: AnsiString); virtual;
   procedure SetImageIndex(Value: Integer); virtual;
   procedure SetShortCut(Value: TShortCut); virtual;
   procedure SetVisible(Value: Boolean); virtual;
 end;//TActionLink

 TActionList = class(TCustomActionList)
 end;//TActionList
{$IfEnd} // NOT Defined(NoVCL)

implementation

{$If NOT Defined(NoVCL)}
uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , ContainedActionsWordspack
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , ActionListWordsPack
 {$IfEnd} // NOT Defined(NoScripts)
;

function TActionLink.IsCaptionLinked: Boolean;
//#UC START# *508F983B0344_508F9823023D_var*
//#UC END# *508F983B0344_508F9823023D_var*
begin
//#UC START# *508F983B0344_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F983B0344_508F9823023D_impl*
end;//TActionLink.IsCaptionLinked

function TActionLink.IsCheckedLinked: Boolean;
//#UC START# *508F984903AB_508F9823023D_var*
//#UC END# *508F984903AB_508F9823023D_var*
begin
//#UC START# *508F984903AB_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F984903AB_508F9823023D_impl*
end;//TActionLink.IsCheckedLinked

function TActionLink.IsEnabledLinked: Boolean;
//#UC START# *508F985802BC_508F9823023D_var*
//#UC END# *508F985802BC_508F9823023D_var*
begin
//#UC START# *508F985802BC_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F985802BC_508F9823023D_impl*
end;//TActionLink.IsEnabledLinked

function TActionLink.IsGroupIndexLinked: Boolean;
//#UC START# *508F986500A8_508F9823023D_var*
//#UC END# *508F986500A8_508F9823023D_var*
begin
//#UC START# *508F986500A8_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F986500A8_508F9823023D_impl*
end;//TActionLink.IsGroupIndexLinked

function TActionLink.IsHelpContextLinked: Boolean;
//#UC START# *508F98890136_508F9823023D_var*
//#UC END# *508F98890136_508F9823023D_var*
begin
//#UC START# *508F98890136_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98890136_508F9823023D_impl*
end;//TActionLink.IsHelpContextLinked

function TActionLink.IsHelpLinked: Boolean;
//#UC START# *508F98940186_508F9823023D_var*
//#UC END# *508F98940186_508F9823023D_var*
begin
//#UC START# *508F98940186_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98940186_508F9823023D_impl*
end;//TActionLink.IsHelpLinked

function TActionLink.IsHintLinked: Boolean;
//#UC START# *508F98A000B7_508F9823023D_var*
//#UC END# *508F98A000B7_508F9823023D_var*
begin
//#UC START# *508F98A000B7_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98A000B7_508F9823023D_impl*
end;//TActionLink.IsHintLinked

function TActionLink.IsImageIndexLinked: Boolean;
//#UC START# *508F98AD0210_508F9823023D_var*
//#UC END# *508F98AD0210_508F9823023D_var*
begin
//#UC START# *508F98AD0210_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98AD0210_508F9823023D_impl*
end;//TActionLink.IsImageIndexLinked

function TActionLink.IsShortCutLinked: Boolean;
//#UC START# *508F98B80325_508F9823023D_var*
//#UC END# *508F98B80325_508F9823023D_var*
begin
//#UC START# *508F98B80325_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98B80325_508F9823023D_impl*
end;//TActionLink.IsShortCutLinked

function TActionLink.IsVisibleLinked: Boolean;
//#UC START# *508F98C402D2_508F9823023D_var*
//#UC END# *508F98C402D2_508F9823023D_var*
begin
//#UC START# *508F98C402D2_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F98C402D2_508F9823023D_impl*
end;//TActionLink.IsVisibleLinked

procedure TActionLink.SetAutoCheck(Value: Boolean);
//#UC START# *508F990A01A7_508F9823023D_var*
//#UC END# *508F990A01A7_508F9823023D_var*
begin
//#UC START# *508F990A01A7_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F990A01A7_508F9823023D_impl*
end;//TActionLink.SetAutoCheck

procedure TActionLink.SetCaption(const Value: String);
//#UC START# *508F991B003B_508F9823023D_var*
//#UC END# *508F991B003B_508F9823023D_var*
begin
//#UC START# *508F991B003B_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F991B003B_508F9823023D_impl*
end;//TActionLink.SetCaption

procedure TActionLink.SetChecked(Value: Boolean);
//#UC START# *508F992700F4_508F9823023D_var*
//#UC END# *508F992700F4_508F9823023D_var*
begin
//#UC START# *508F992700F4_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F992700F4_508F9823023D_impl*
end;//TActionLink.SetChecked

procedure TActionLink.SetEnabled(Value: Boolean);
//#UC START# *508F99340058_508F9823023D_var*
//#UC END# *508F99340058_508F9823023D_var*
begin
//#UC START# *508F99340058_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F99340058_508F9823023D_impl*
end;//TActionLink.SetEnabled

procedure TActionLink.SetGroupIndex(Value: Integer);
//#UC START# *508F993F026A_508F9823023D_var*
//#UC END# *508F993F026A_508F9823023D_var*
begin
//#UC START# *508F993F026A_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F993F026A_508F9823023D_impl*
end;//TActionLink.SetGroupIndex

procedure TActionLink.SetHelpContext(Value: THelpContext);
//#UC START# *508F994C023C_508F9823023D_var*
//#UC END# *508F994C023C_508F9823023D_var*
begin
//#UC START# *508F994C023C_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F994C023C_508F9823023D_impl*
end;//TActionLink.SetHelpContext

procedure TActionLink.SetHelpKeyword(const Value: AnsiString);
//#UC START# *508F9958019E_508F9823023D_var*
//#UC END# *508F9958019E_508F9823023D_var*
begin
//#UC START# *508F9958019E_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F9958019E_508F9823023D_impl*
end;//TActionLink.SetHelpKeyword

procedure TActionLink.SetHelpType(Value: THelpType);
//#UC START# *508F99650101_508F9823023D_var*
//#UC END# *508F99650101_508F9823023D_var*
begin
//#UC START# *508F99650101_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F99650101_508F9823023D_impl*
end;//TActionLink.SetHelpType

procedure TActionLink.SetHint(const Value: AnsiString);
//#UC START# *508F99710030_508F9823023D_var*
//#UC END# *508F99710030_508F9823023D_var*
begin
//#UC START# *508F99710030_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F99710030_508F9823023D_impl*
end;//TActionLink.SetHint

procedure TActionLink.SetImageIndex(Value: Integer);
//#UC START# *508F997C0142_508F9823023D_var*
//#UC END# *508F997C0142_508F9823023D_var*
begin
//#UC START# *508F997C0142_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F997C0142_508F9823023D_impl*
end;//TActionLink.SetImageIndex

procedure TActionLink.SetShortCut(Value: TShortCut);
//#UC START# *508F998A00F3_508F9823023D_var*
//#UC END# *508F998A00F3_508F9823023D_var*
begin
//#UC START# *508F998A00F3_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F998A00F3_508F9823023D_impl*
end;//TActionLink.SetShortCut

procedure TActionLink.SetVisible(Value: Boolean);
//#UC START# *508F99970386_508F9823023D_var*
//#UC END# *508F99970386_508F9823023D_var*
begin
//#UC START# *508F99970386_508F9823023D_impl*
 !!! Needs to be implemented !!!
//#UC END# *508F99970386_508F9823023D_impl*
end;//TActionLink.SetVisible
{$IfEnd} // NOT Defined(NoVCL)

end.
