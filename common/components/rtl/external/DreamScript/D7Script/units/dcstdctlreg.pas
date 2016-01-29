{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcStdCtlReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes,

  {$IFDEF USEOWNDSGNSTUFF}
  dcdsgnstuff,
  {$ELSE}
    {$IFDEF D6}
    DesignIntf,DesignEditors,VCLEditors,
    {$ELSE}
    dsgnintf,
    {$ENDIF}
  {$ENDIF}
  
  dcconsts, dcstdctl, dccontrols, dcGen;

procedure Register;
begin
  RegisterVisualProperty(SVerbItemsEditor,TDCCheckListBox,'Items'); //don't resource

end;

end.
