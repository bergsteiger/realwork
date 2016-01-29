{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit dcrespic;

interface

{.$I dc.inc}
{$I dcprod.inc}


implementation

{$IFDEF DREAMDESIGNER}
  {$R 'vclqrbmp.dcr'}
  {$R 'VCLDBBMP.DCR'}
  {$R 'vclstdbmp.DCR'}
  {$R 'vclsysbmp.dcr'}
  {$R 'vclwinbmp.dcr'}

  {$IFDEF D4}
    {$R 'vcl4bmp.dcr'}
  {$ENDIF}
{$ENDIF}

{$IFDEF DREAMLIB}
  {$R 'dcregbmp.dcr'}
  {$R 'dcfree.dcr'}
  {$R 'dccolorcombo.dcr'}
  {$R 'histed.dcr'}
{$ELSE}
  {$IFDEF DREAMINFOTREE}
    {$R 'dccolorcombo.dcr'}
  {$ENDIF}
{$ENDIF}

{$IFDEF DREAMTREE}
  {$R dcinfotree.dcr}
{$ELSE}
  {$IFDEF DREAMINFOTREE}
    {$R dcinfotree.dcr}
  {$ENDIF}
{$ENDIF}

end.
