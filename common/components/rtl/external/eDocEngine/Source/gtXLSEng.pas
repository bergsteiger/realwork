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

unit gtXLSEng;

interface
uses
  Classes, Windows, Graphics, SysUtils, Math
{$IFDEF gtPro}
  , gtExXLSEng
{$ELSE}
  , gtCstXLSEng
{$ENDIF}
  ;
type

{$IFDEF gtPro}
  TgtExcelEngine = class(TgtExExcelEngine)
{$ELSE}
  TgtExcelEngine = class(TgtCustomExcelEngine)
{$ENDIF}
  end;

implementation

end.

















