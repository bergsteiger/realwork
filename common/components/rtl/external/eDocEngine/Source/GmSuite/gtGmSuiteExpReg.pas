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

unit gtGmSuiteExpReg;

interface
uses
  gtGmSuiteIntf, Classes;

procedure Register;

implementation

{$R gtGmSuiteExpReg.DCR}

procedure Register;
begin
        RegisterComponents('eDocEngine Additional', [TgtGmSuiteInterface]);
end;
end.
 