{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit OInspectReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes, Controls, StdCtrls,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}

  dcconsts, dcstrled, oinspect;

procedure Register;
begin
  RegisterComponents(SPalDream,[TPropertyHelp,TObjectInspector]);
  RegisterPropertyEditor(TypeInfo(string), TComponent, 'Hint', THintPropertyEdit); //don't resource
  RegisterPropertyEditor(TypeInfo(TCaption), TCustomLabel, 'Caption', TCaptionPropertyEdit); //don't resource
end;

end.
