{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcButtonPanelReg;

interface

Procedure Register;

implementation

uses
  Classes,
  dcButtonPanel,
  dcconsts;

Procedure Register;
Begin
  RegisterComponents(SPalDream,[TDCButtonPanel]);
End;

end.
 
