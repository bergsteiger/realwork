{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit TreeInspReg;

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

  dcconsts, treeinsp {$IFNDEF D3}, dcsystem, dcmenu, dctsrc{$ENDIF};

procedure Register;
begin
{$IFNDEF D3}
  if UnderDelphiIDE then
  begin
    RegisterPropertyEditor(TypeInfo(TCollection),TDCMenu,'',TModalCollectEdit);
    RegisterPropertyEditor(TypeInfo(TDCNamedItems),TPersistent,'',TModalCollectEdit);
    RegisterPropertyEditor(TypeInfo(TCollection),TDCMultiSource,'',TModalCollectEdit);
  end;
{$ENDIF}
end;

end.
