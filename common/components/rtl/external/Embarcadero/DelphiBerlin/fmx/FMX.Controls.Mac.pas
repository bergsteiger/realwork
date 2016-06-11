{*******************************************************}
{                                                       }
{              Delphi FireMonkey Platform               }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.Controls.Mac;

interface

{$SCOPEDENUMS ON}

implementation

uses System.Types, System.Classes, System.SysUtils, System.TypInfo,
{$IFDEF MACOS}
  Macapi.Appkit, Macapi.CocoaTypes, Macapi.ObjectiveC, Macapi.Foundation, Macapi.Helpers, FMX.Platform.Mac,
{$ENDIF}
  FMX.Types, FMX.Styles, FMX.Controls;

{$R *.res}

function OSXStyleSelection(const APlatform: TOSPlatform): string;
begin
  {$IFDEF WIN32}
  Result := 'osxstyle';
  {$ELSE}
  if TOSVersion.Check(10, 10) then
    Result := 'osxstyle'
  else
    Result := 'lionstyle';
  {$ENDIF}
end;

{$IFDEF MACOS}
type
  TOSXHint = class(THint)
  const
    InvalidToolTipHandle: NSToolTipTag = $FFFFFFFF;
  private
    FNativeView: NSView;
    FToolTipHandle: NSToolTipTag;
    FNativeDisplayingHintString: NSString;
  protected
    procedure SetEnabled(const Value: Boolean); override;
  public
    constructor Create(const AHandle: TWindowHandle); override;
    procedure SetHint(const AString: string); override;
  end;

{ TOSXHint }

constructor TOSXHint.Create(const AHandle: TWindowHandle);
begin
  inherited;

  FNativeView := TNSView.Wrap(WindowHandleToPlatform(AHandle).Wnd.contentView);
  FToolTipHandle := InvalidToolTipHandle;
end;

procedure TOSXHint.SetEnabled(const Value: Boolean);
begin
  if Value <> FEnabled then
  begin
    inherited;

    if FToolTipHandle <> InvalidToolTipHandle then
    begin
      FNativeView.removeToolTip(FToolTipHandle);
      FToolTipHandle := InvalidToolTipHandle;
    end;

    if Value and (FNativeView <> nil) and (FNativeDisplayingHintString <> nil) then
      FToolTipHandle := FNativeView.addToolTipRect(FNativeView.frame,
        (FNativeDisplayingHintString as ILocalObject).GetObjectID, nil);
  end;
end;

procedure TOSXHint.SetHint(const AString: string);
var
  LString: string;
begin
  if GetHint <> AString then
  begin
    inherited;
    LString := GetShortText;

    if FNativeDisplayingHintString <> nil then
      FNativeDisplayingHintString.release;
    if FToolTipHandle <> InvalidToolTipHandle then
    begin
      FNativeView.removeToolTip(FToolTipHandle);
      FToolTipHandle := InvalidToolTipHandle;
    end;

    if LString = string.Empty then
      FNativeDisplayingHintString := nil
    else
      FNativeDisplayingHintString := StrToNSStr(LString);

    if FNativeDisplayingHintString <> nil then
    begin
      FNativeDisplayingHintString.retain;
      FToolTipHandle := FNativeView.addToolTipRect(FNativeView.frame,
        (FNativeDisplayingHintString as ILocalObject).GetObjectID, nil);
    end;
  end
  else
    inherited;
end;

{$ENDIF}

initialization
{$IFDEF MACOS}
  THint.RegisterClass(TOSXHint);
{$ENDIF}

  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.OSX, 'osxstyle');
  TStyleManager.RegisterPlatformStyleResource(TOSPlatform.OSX, 'lionstyle');
  TStyleManager.RegisterPlatformStyleSelection(TOSPlatform.OSX, OSXStyleSelection);
end.
