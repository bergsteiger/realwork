{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcFDesReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes, Controls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcsystem, dcvcllib, dcfdes;

type
  TLimitControlProperty =  class(TLimitComponentProperty)
  public
    function AcceptComponent(AComponent : TComponent):boolean; override;
  end;

function TLimitControlProperty.AcceptComponent(AComponent : TComponent): boolean;
begin
  result := (AComponent is TControl) and (csAcceptsControls in TControl(AComponent).ControlStyle);
end;

{------------------------------------------------------------------}

procedure Register;
begin
  {$IFDEF DREAMTREE}
  RegisterVerbArray(VerbArray1);
  {$ENDIF}

  {$IFDEF DCEDIT}
  RegisterVerb('Designer.ScaleControls',DesignerGetVerbState,DesignerScaleControls); //don't resource
  {$ENDIF}
  RegisterComponents(SPalDreamDes,[TDCLiteDesigner{$IFDEF D3}, TDCChangesStore{$ENDIF}]);
  RegisterPropertyEditor(Typeinfo(TWinControl),TDCLiteDesigner,'LimitControl',TLimitControlProperty); //don't resource
  SafeRegisterClass(TDCOleControl);
end;

end.
