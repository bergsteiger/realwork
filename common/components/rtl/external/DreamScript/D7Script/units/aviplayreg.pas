{*******************************************************}
{                                                       }
{  Copyright (c) 1997-2001 Altium Limited               }
{                                                       }
{  http://www.dream-com.com                             }
{  contact@dream-com.com                                }
{                                                       }
{*******************************************************}
unit AviPlayReg;

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
  
  dcconsts, AviPlay,dcGenReg;

type
  { Property editor for filename property with AVI extension}
  TAVIFileNameEdit = class(TFileNameEdit)
    function  GetDefaultExtension : string; override;
    function  GetFilter : string; override;
  end;

function  TAVIFileNameEdit.GetDefaultExtension : string;
begin
  result := 'avi'; //don't resource
end;

{------------------------------------------------------------------}

function  TAVIFileNameEdit.GetFilter : string;
begin
  result := SAVIFilesFilter;
end;

{------------------------------------------------------------------}

procedure Register;
begin
  RegisterComponents(SPalDream,[TDCAVIPlay]);
  RegisterPropertyEditor(TypeInfo(string), TDCAVIPlay, 'FileName', TAVIFileNameEdit);//don't resource
end;

end.
