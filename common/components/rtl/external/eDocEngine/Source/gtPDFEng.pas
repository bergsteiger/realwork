{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2013 Gnostice Information Technologies Private Limited  }
{  http://www.gnostice.com                                                  }
{                                                                           }
{***************************************************************************}

{------------------------------------}
{          Editor Options            }
{------------------------------------}
{                                    }
{ Tab Stops = 2                      }
{ Use Tab Character = True           }
{                                    }
{------------------------------------}

{$I gtDefines.inc}
{$I gtDocDefines.inc}

unit gtPDFEng;

interface
uses
  Windows, Classes, Graphics, SysUtils, gtCstPlnEng, gtCstDocEng,
  {$IFNDEF gtPro}
    gtCstPDFEng
  {$ELSE}
    gtExPDFEng
  {$ENDIF};
  
type
  {$IFNDEF gtPro}
  TgtPDFEngine = class(TgtCustomPDFEngine)
  {$ELSE}
  TgtPDFEngine = class(TgtExPDFEngine)
  {$ENDIF}
  end;
  
implementation

end.
