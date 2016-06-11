{*******************************************************}
{                                                       }
{             Delphi FireMonkey Platform                }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit FMX.SpellChecker;

interface

{$SCOPEDENUMS ON}

type
  IFMXSpellCheckerService = interface(IInterface)
    ['{A956ACEC-9CFA-4FEC-B631-A1AEB2FAAA79}']
    ///<summary>
    ///  Check for word spelling.
    ///</summary>
    function CheckSpelling(Word: string): TArray<string>;
    ///<summary>
    ///  Check for word completion.
    ///</summary>
    function GuessCompletions(Word: string): TArray<string>;
  end;
 
implementation

{$IF Defined(IOS)}
uses FMX.SpellChecker.iOS;
{$ELSEIF Defined(MACOS)}
uses FMX.SpellChecker.Mac;
{$ELSEIF Defined(ANDROID)}
uses FMX.SpellChecker.Android;
{$ENDIF}


end.
