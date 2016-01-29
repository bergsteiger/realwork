{**********************************************************		}
{                                                          		}
{       Delphi                                    			}
{       InterBase EventAlerter components                  		}
{        Copyright(c) 1995,1999-2013 Embarcadero Technologies, Inc.        }
{                                                          		}
{       Written by:                                        		}
{         James Thorpe                                     		}
{         CSA Australasia                                  		}
{         Compuserve: 100035,2064                          		}
{         Internet:   csa@csaa.com.au                      		}
{                                                          		}
{**********************************************************		}

unit IBDemoReg;

interface

procedure Register;

implementation

uses SysUtils, DesignIntf, DesignEditors, IBEvnts, IBCtrls, Classes, DB,
  Controls, IBConst;

{ EventAlerter Events property Editor }

type
  TIBEventListProperty = class(TClassProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
  end;

function TIBEventListProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog] - [paSubProperties];
end;

procedure TIBEventListProperty.Edit;
var
  Events: TStrings;
begin
  Events := TStringList.Create;
  try
    Events.Assign( TStrings(GetOrdValue));
    if EditAlerterEvents( Events) then SetOrdValue( longint(Events));
  finally
    Events.Free;
  end;
end;

{ IBDatabase component editor }

procedure Register;
begin
  GroupDescendentsWith(TIBEventAlerter, Controls.TControl);
  RegisterComponents(srSamples, [TIBEventAlerter]);
  RegisterPropertyEditor(TypeInfo(TStrings), TIBEventAlerter, 'Events',
    TIBEventListProperty);
end;

end.
