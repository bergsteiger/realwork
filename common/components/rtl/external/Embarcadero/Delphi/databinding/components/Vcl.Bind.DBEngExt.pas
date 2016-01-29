{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2011-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

{$HPPEMIT '#pragma link "Vcl.Bind.DBEngExt"'}    {Do not Localize}
unit Vcl.Bind.DBEngExt;

// Bind Engine Extensions

interface

uses System.Classes, System.SysUtils, Data.DB, Data.Bind.Components, System.Bindings.Helper, System.Generics.Collections;



implementation

uses System.Bindings.EvalProtocol, System.Rtti, System.Bindings.Outputs, Vcl.Graphics, Vcl.Bind.Consts, VCL.Controls;



const
  sIDNilToTPicture = 'NilToTPicture';
  sThisUnit = 'Vcl.Bind.DBEngExt';


procedure RegisterOutputConversions;
begin

  // Register global conversion
  // Assign nil to TPicture clears picture
  TValueRefConverterFactory.RegisterConversion(
    nil, TypeInfo(TPicture),
        TConverterDescription.Create(
          procedure(const InValue: TValue; var OutValue: TValue)
          var
            LOutObject: TObject;
          begin
            Assert(InValue.IsEmpty);
            LOutObject := OutValue.AsObject;
            Assert(LOutObject <> nil);
            Assert(LOutObject is TPicture);
            TPicture(LOutObject).Graphic := nil;
          end,
          sIDNilToTPicture,
          sNilToTPicture,
          sThisUnit, True, sNilToTPictureDesc, VCL.Controls.TControl // vcl only
          ));

end;

procedure UnregisterOutputConversions;
begin
  TValueRefConverterFactory.UnRegisterConversion(
    nil, TypeInfo(TPicture));
end;


initialization
  RegisterOutputConversions;
finalization
  UnregisterOutputConversions;
end.
