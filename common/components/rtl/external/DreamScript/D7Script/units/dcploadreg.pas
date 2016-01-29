{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcPLoadReg;

interface

procedure Register;

implementation
{$I dc.inc}
uses
  Classes,
  dcconsts,
  dcpload;

procedure Register;
begin
  RegisterComponents(SPalDream,[TDCPackageLoader]);
end;

end.
