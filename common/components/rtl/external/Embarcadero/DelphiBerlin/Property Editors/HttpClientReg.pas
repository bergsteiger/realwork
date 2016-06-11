{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit HttpClientReg;

interface

procedure Register;

implementation

uses
  DesignIntf, DesignEditors, System.Classes, System.Net.HttpClientComponent;

type
  TNetHttpClientSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure Register;
begin
  RegisterComponents('Net', [TNetHttpClient, TNetHttpRequest]);
  RegisterSelectionEditor(TNetHttpClient, TNetHttpClientSelectionEditor);
  RegisterSelectionEditor(TNetHttpRequest, TNetHttpClientSelectionEditor);
end;

{ TNetHttpClientSelectionEditor }

procedure TNetHttpClientSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
//  Add needed used units to the uses clauses of the form where the component is located.
  Proc('System.Net.URLClient');
  Proc('System.Net.HttpClient');
  Proc('System.Net.HttpClientComponent');
end;

end.

