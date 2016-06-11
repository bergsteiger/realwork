{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}
unit BeaconReg;

interface

procedure Register;

implementation

uses
  DesignIntf, DesignEditors, DsnConst, System.Classes, System.Beacon.Components;

type
  TBeaconSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure Register;
begin
  RegisterComponents(srSystem, [TBeacon]);
  RegisterSelectionEditor(TBeacon, TBeaconSelectionEditor);
  RegisterComponents(srSystem, [TBeaconDevice]);
  RegisterSelectionEditor(TBeaconDevice, TBeaconSelectionEditor);
end;

{ TBeaconSelectionEditor }

procedure TBeaconSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('System.Beacon');
  Proc('System.Bluetooth');
end;

end.
