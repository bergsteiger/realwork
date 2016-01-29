{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine 		                                                  }
{                                                                           }
{  Copyright © 2002-2011 Gnostice Information Technologies Private Limited  }
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

unit gtHTMLEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math
{$IFDEF gtPro}
  , gtExHTMLEng
{$ELSE}
  , gtCstHTMLEng
{$ENDIF}
  ;
type

{$IFDEF gtPro}
  TgtHTMLEngine = class(TgtExHTMLEngine)
{$ELSE}
  TgtHTMLEngine = class(TgtCustomHTMLEngine)
{$ENDIF}
  end;

implementation

end.
