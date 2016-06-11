{*******************************************************}
{                                                       }
{            Delphi Visual Component Library            }
{ Copyright(c) 2016 Embarcadero Technologies, Inc.      }
{              All rights reserved                      }
{                                                       }
{*******************************************************}

unit BluetoothReg;

interface

procedure Register;

implementation

uses
  DesignIntf, DesignEditors, DsnConst, System.Classes, System.Bluetooth.Components;

type
  TBluetoothSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

procedure Register;
begin
  RegisterComponents(srSystem, [TBluetoothLE]);
  RegisterSelectionEditor(TBluetoothLE, TBluetoothSelectionEditor);
  RegisterComponents(srSystem, [TBluetooth]);
  RegisterSelectionEditor(TBluetooth, TBluetoothSelectionEditor);
end;

{ TBluetoothSelectionEditor }

procedure TBluetoothSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
  inherited;
  Proc('System.Bluetooth');
end;

end.
