{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.SpellChecker.Android;

interface

{$SCOPEDENUMS ON}

implementation

uses
  System.SysUtils, FMX.SpellChecker, FMX.Platform, FMX.Types;

type
  TAndroidSpellCheckerService = class(TInterfacedObject, IFMXSpellCheckerService)
  private
    //FChecker: UITextChecker;
  public
    constructor Create;
    destructor Destroy; override;
    //IFMXSpellCheckerService
    function CheckSpelling(Word: string): TArray<string>;
    function GuessCompletions(Word: string): TArray<string>;
  end;

procedure RegisterSpellCheckerService;
begin
//  AndroidSpellCheckerService := TAndroidSpellCheckerService.Create;
//  TPlatformServices.Current.AddPlatformService(IFMXSpellCheckerService, AndroidSpellCheckerService);
end;

procedure UnregisterSpellCheckerService;
begin
//  TPlatformServices.Current.RemovePlatformService(IFMXSpellCheckerService);
//  FreeAndNil(AndroidSpellCheckerService);
end;


{ TCocoaSpellCheckerService }

function TAndroidSpellCheckerService.CheckSpelling(Word: string): TArray<string>;
{var
  I: Integer;
  SpellWords: NSArray;}
begin
{  Assert(Assigned(FChecker), 'Native bridge was not created');
  Result := nil;
  if FChecker.rangeOfMisspelledWordInString(NSSTR(Word), NSMakeRange(0, Word.Length), 0, False, NSSTR('en_US')).location <> NSNotFound then
  begin
    SpellWords := FChecker.guessesForWordRange(NSMakeRange(0, Word.Length), NSSTR(Word), NSSTR('en_US'));
    if SpellWords.count > 0 then
    begin
      SetLength(Result, SpellWords.count);
      for I := 0 to SpellWords.count - 1 do
        Result[I] := UTF8ToUnicodeString(TNSString.Wrap(SpellWords.objectAtIndex(I)).UTF8String);
    end;
  end;}
end;

constructor TAndroidSpellCheckerService.Create;
begin
  inherited;
  //FChecker := TUITextChecker.Create;
end;

destructor TAndroidSpellCheckerService.Destroy;
begin
  {if Assigned(FChecker) then
  begin
    FChecker.release;
    FChecker := nil;
  end;}
  inherited;
end;

function TAndroidSpellCheckerService.GuessCompletions(
  Word: string): TArray<string>;
{var
  I: Integer;
  Words: NSArray;}
begin
  {Assert(Assigned(FChecker), 'Native bridge was not created');
  Result := nil;
  Words := FChecker.completionsForPartialWordRange(NSMakeRange(0, Word.Length), NSSTR(Word), NSSTR('en_US'));
  if Words.count > 0 then
  begin
    SetLength(Result, Words.count);
    for I := 0 to Words.count - 1 do
      Result[I] := UTF8ToUnicodeString(TNSString.Wrap(Words.objectAtIndex(I)).UTF8String);
  end;}
end;


initialization
  RegisterSpellCheckerService;
end.
