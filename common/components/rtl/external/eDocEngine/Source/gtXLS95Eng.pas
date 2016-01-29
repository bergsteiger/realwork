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

unit gtXLS95Eng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math
{$IFDEF gtPro}
  , gtExXLS95Eng
{$ELSE}
  , gtCstXLS95Eng
{$ENDIF}
  ;
type

{$IFDEF gtPro}
  TgtXLSEngine = class(TgtExExcel95Engine)
{$ELSE}
  TgtXLSEngine = class(TgtCustomExcel95Engine)
{$ENDIF}
  end;

implementation

end.
