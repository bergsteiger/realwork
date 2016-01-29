{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit qrimp;

interface
{$I dc.inc}

{$IFNDEF SKIPVCLREG}
uses

{ 

  Files 
    *_D6.pas
    *_D5.pas
    *_D4.pas
    *_D3.pas
    *_C3.pas
    *_C4.pas
    *_C5.pas
  weren't included in registered version of Dream Scripter. You can get them
  automatically with \UTILS\UNITIMPORTER program or download any of the trial
  versions and extract these files from there. Alternatively you can comment
  out impreg from uses of main form of Instant Report, so Instant will be
  compiled without these "import" files.

  If you don't have Quick Report 2.0 or higher properly installed this unit may not compile.
  If this occurs just comment out define QREP in the dc.inc and recompile the project
}

{$IFDEF D6}
QRCTRLS_d6,
QRPRNTR_d6,
QUICKRPT_d6;
{$ELSE}

{$IFDEF CPB5}
QRCTRLS_c5,
QRPRNTR_c5,
QUICKRPT_c5;
{$ELSE}

{-------------------}

{$IFDEF D5}
QRCTRLS_d5,
QRPRNTR_d5,
QUICKRPT_d5;
{$ELSE}

{-------------------}

{$IFDEF D4}
QRCTRLS_d4,
QRPRNTR_d4,
QUICKRPT_d4;
{$ELSE}

{-------------------}

{$IFDEF CPB3}
QRCTRLS_c3,
QRPRNTR_c3,
QUICKRPT_c3;
{$ELSE}

{-------------------}

{$IFDEF D3}
QRCTRLS_d3,
QRPRNTR_d3,
QUICKRPT_d3;
{$ELSE}

{-------------------}

{$IFDEF CPB1}
QRCTRLS_c1,
QRPRNTR_c1,
QUICKRPT_c1;

{-------------------}

{$ELSE}
QRCTRLS_d2,
QRPRNTR_d2,
QUICKRPT_d2;
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}
{$ENDIF}

{$ENDIF}

implementation

end.
