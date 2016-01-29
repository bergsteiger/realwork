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

unit gtScaleRichVwExpReg;

interface
uses
  gtScaleRichViewIntf, Classes;

procedure Register;

implementation

procedure Register;
begin
	RegisterComponents('eDocEngine Additional', [TgtScaleRichViewInterface]);
end;
end.
 