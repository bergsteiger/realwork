{*******************************************************}
{                                                       }
{             Delphi LiveBindings Framework             }
{                                                       }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit Data.Bind.JSON;

interface

implementation

uses System.Bindings.EvalProtocol, System.Rtti, System.Bindings.Outputs,
  System.Classes, System.SysUtils, System.Bindings.Helper,
  System.JSON;

const
  sIDJSONToString = 'JSONToString';
  // Leave unit name blank so this unit will not be autmatically added to uses list (because we don't want a database dependency).
  sThisUnit = ''; // 'Data.Bind.JSON';

procedure RegisterOutputConversions;
begin
  // Support assignment of TJSONValue to string
  TValueRefConverterFactory.RegisterConversion(TypeInfo(TJSONValue), TypeInfo(string),
  TConverterDescription.Create(
      procedure(const InValue: TValue; var OutValue: TValue)
      var
        LOutString: string;
        LValue: TJSONValue;
      begin
        if InValue.IsEmpty then
          LOutString := ''
        else
        begin
          if not InValue.TryAsType<TJSONValue>(LValue) then
            LOutString := ''
          else
            if LValue is TJSONString then
              // Return string without quotes
              LOutString := TJSONString(LValue).Value
            else
              LOutString := LValue.ToString;
        end;
        OutValue := TValue.From<string>(LOutString);

      end,
    sIDJSONToString,
    sIDJSONToString,
    sThisUnit, True, '', nil)
  );
end;

procedure UnregisterOutputConversions;
begin
  TValueRefConverterFactory.UnRegisterConversion(
  TypeInfo(TJSONValue), TypeInfo(string));
end;


initialization
  RegisterOutputConversions;
finalization
  UnregisterOutputConversions;
end.
