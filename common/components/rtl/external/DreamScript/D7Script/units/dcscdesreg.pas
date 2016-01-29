{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcScDesReg;

interface

procedure Register;

implementation
{.$I dc.inc}
{$I dcprod.inc}
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

  dcconsts, dcscdes, dcscriptreg;

procedure Register;
begin
  RegisterComponents(SPalDreamDes ,[TDCLiteScriptDsgn{$IFDEF DREAMMEMO},TDCLiteMemoScriptDsgn{$ENDIF}]);
end;

end.
