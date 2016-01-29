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

unit gtDocProdReg;

interface
uses
  Classes, gtDocProducer;

procedure Register;

implementation

{$R gtDocProdReg.DCR}

procedure Register;
begin
	RegisterComponents('eDocEngine Additional', [TgtDocProducer]);
end;
end.

 