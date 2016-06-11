{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

{$HPPEMIT LINKUNIT}
unit Fmx.Bind.DBEngExt;

interface

uses System.Classes, System.SysUtils, Data.Bind.Components, System.Bindings.Helper, System.Generics.Collections,
  FMX.Types, FMX.Controls, FMX.Graphics;


implementation

uses System.Bindings.EvalProtocol, System.Rtti, System.Bindings.Outputs, Fmx.Bind.Consts;



const
  sIDNilToTBitmap = 'NilToTBitmap';
  sThisUnit = 'Fmx.Bind.DBEngExt';

procedure RegisterOutputConversions;
begin
  // Assign nil to TBitmap clears picture
    TValueRefConverterFactory.RegisterConversion(nil, TypeInfo(TBitmap),
    TConverterDescription.Create(
        procedure(const InValue: TValue; var OutValue: TValue)
        var
          LOutObject: TObject;
        begin
          Assert(InValue.IsEmpty);
          LOutObject := OutValue.AsObject;
          Assert(LOutObject <> nil);
          Assert(LOutObject is TBitmap);
          TBitmap(LOutObject).Clear(0);
        end,
    sIDNilToTBitmap,
    sNilToTBitmap,
    sThisUnit, True, sNilToTBitmapDesc, FMX.Controls.TStyledControl)  // fmx only
  );
end;

procedure UnregisterOutputConversions;
begin
  TValueRefConverterFactory.UnRegisterConversion(
    nil, TypeInfo(TBitmap));
end;


initialization
  RegisterOutputConversions;
finalization
  UnregisterOutputConversions;
end.
