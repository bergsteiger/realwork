{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcddes;

interface
{.$I dc.inc}
{$I dcprod.inc}

uses
  classes, dcrespic, dcsystem, dcfdes, vclstdreg, dcconsts
  {$IFDEF DREAMSCRIPTER},dcscdes{$ENDIF}
  ;

type
  TDreamDesigner = class(TDCLiteDesigner)
  end;

  {$IFDEF DREAMSCRIPTER}
  TDCScriptDsgn = class(TDCLiteScriptDsgn)
  end;

  {$IFDEF DREAMMEMO}
  TDCMemoScriptDsgn = class(TDCLiteMemoScriptDsgn)
  end;
  {$ENDIF}

  {$ENDIF}

implementation
uses
  dcreg;
end.
