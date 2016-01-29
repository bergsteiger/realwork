{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcDDesReg;

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

  dcconsts, dcddes;

procedure Register;
begin
  RegisterComponents(SPalDreamDes,[TDreamDesigner]);

  {$IFDEF DREAMSCRIPTER}
  RegisterComponents(SPalDreamDes ,
    [TDCScriptDsgn{$IFDEF DREAMMEMO},TDCMemoScriptDsgn{$ENDIF}]);
  {$ENDIF}
end;

end.
