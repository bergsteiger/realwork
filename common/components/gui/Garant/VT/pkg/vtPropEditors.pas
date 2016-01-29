unit vtPropEditors;

interface

uses
  ImgList,
  DesignIntf,
  DesignEditors,

  evImageIndexProperty
  ;

type
  TvtStatusBarEditor = class(TDefaultEditor)
  protected
    procedure RunPropertyEditor(const Prop: IProperty);
  public
    procedure ExecuteVerb(Index : Integer); override;
    function GetVerb(Index : Integer): string; override;
    function GetVerbCount : Integer; override;
    procedure Edit; override;
  end;

(* TvtReminderImageIndexProperty = class(TevImageIndexProperty)
 protected
   function GetImages : TCustomImageList; override;
 end;*)


implementation

uses
  Dialogs, Windows, vtStatusBar, Classes, SysUtils, TypInfo
  //, vtReminder
  ;


{ TvtStatusBarEditor }

procedure TvtStatusBarEditor.Edit;
var
  Components: IDesignerSelections;
begin
  Components := CreateSelectionList;
  try
  	Components.Add(Component);
  	GetComponentProperties(Components, [tkClass], Designer, RunPropertyEditor);
  finally
  end;
end;

procedure TvtStatusBarEditor.RunPropertyEditor(const Prop: IProperty);
begin
  if UpperCase(Prop.GetName) = 'PANELS' then
    Prop.Edit;
end;

procedure TvtStatusBarEditor.ExecuteVerb(Index: Integer);
begin
  if Index <> 0 then Exit; { We only have one verb, so exit if this ain't it }
  Edit;  { Invoke the Edit function the same as if double click had happened }
end;


function TvtStatusBarEditor.GetVerb(Index: Integer): string;
begin
  Result := '&Panels Editor...';  { Menu item caption for context menu }
end;

function TvtStatusBarEditor.GetVerbCount: Integer;
begin
  Result := 1; // Just add one menu item.
end;


(*{ TvtReminderImageIndexProperty }

function TvtReminderImageIndexProperty.GetImages: TCustomImageList;
var
 l_Reminder : TvtReminder;
begin
 Result := nil;
 if GetComponent(0) is TvtReminder then
 begin
  l_Reminder := TvtReminder(GetComponent(0));
  Result := l_Reminder.Images;
 end;
end;*)

end.


