{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine      		                                            }
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

{$IFDEF VER100}				// Delphi 3 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi3}
	{$DEFINE gtDelphi3Up}
{$ENDIF}

{$IFDEF VER110}				// C++ Builder 3 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtCBuilder3}
	{$DEFINE gtCBuilder3Up}
	{$ObjExportAll On}
{$ENDIF}

{$IFDEF VER120}				// Delphi 4 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi4}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
{$ENDIF}

{$IFDEF VER125}				// C++ Builder 4 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtCBuilder4}
	{$DEFINE gtCBuilder3Up}
	{$DEFINE gtCBuilder4Up}
	{$ObjExportAll On}
{$ENDIF}

{$IFDEF VER130}				// Delphi 5/C++ Builder 5 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$IFDEF BCB}				// C++ Builder 5 and up
		{$DEFINE gtCBuilder5}
		{$DEFINE gtCBuilder3Up}
		{$DEFINE gtCBuilder4Up}
		{$DEFINE gtCBuilder5Up}
		{$ObjExportAll On}
	{$ELSE}					// Delphi 5
		{$DEFINE gtDelphi5}
	{$ENDIF}
{$ENDIF}

{$IFDEF VER140}				// Delphi 6 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi6}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$IFDEF BCB}				// C++ Builder 6 and up
		{$DEFINE gtCBuilder6}
		{$DEFINE gtCBuilder3Up}
		{$DEFINE gtCBuilder4Up}
		{$DEFINE gtCBuilder5Up}
		{$DEFINE gtCBuilder6Up}
		{$ObjExportAll On}
	{$ELSE}					// Delphi 6
		{$DEFINE gtDelphi6}
	{$ENDIF}
{$ENDIF}

{$IFDEF VER150}				// Delphi 7 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi7}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
{$ENDIF}

{$IFDEF VER170}				// Delphi 2005 and up
	{$DEFINE gtCF}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
{$ENDIF}


{$IFDEF VER180}				// BDS 2006 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
{$ENDIF}

{$IFDEF VER200}				// BDS 2009 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
{$ENDIF}

{$IFDEF VER210}				// BDS 2010 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
{$ENDIF}

{$IFDEF VER220}				// BDS 2011 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
{$ENDIF}

{$IFDEF VER230}				// XE2 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
	{$DEFINE gtDelphiXE2Up}
{$ENDIF}

{$IFDEF VER240}				// XE3 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
	{$DEFINE gtDelphiXE2Up}
	{$DEFINE gtDelphiXE3Up}
{$ENDIF}

{$IFDEF VER250}				// XE4 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
	{$DEFINE gtDelphiXE2Up}
	{$DEFINE gtDelphiXE3Up}
	{$DEFINE gtDelphiXE4Up}	
{$ENDIF}

{$IFDEF VER260}				// XE5 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
	{$DEFINE gtDelphiXE2Up}
	{$DEFINE gtDelphiXE3Up}
	{$DEFINE gtDelphiXE4Up}	
	{$DEFINE gtDelphiXE5Up}	
{$ENDIF}

{$IFDEF VER270}				// XE6 and up
	{$DEFINE gtCF}
	{$DEFINE gtBDS2006}
	{$DEFINE gtDelphi2005}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
	{$DEFINE gtDelphiXEUp}
	{$DEFINE gtDelphiXE2Up}
	{$DEFINE gtDelphiXE3Up}
	{$DEFINE gtDelphiXE4Up}	
	{$DEFINE gtDelphiXE5Up}	
	{$DEFINE gtDelphiXE6Up}	
{$ENDIF}

// If none of the above, assume to be Delphi 6 or later
{$IFNDEF gtCF}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtBDS2006Up}
	{$DEFINE gtDelphi2009Up}
	{$DEFINE gtDelphi2010Up}
{$ENDIF}


