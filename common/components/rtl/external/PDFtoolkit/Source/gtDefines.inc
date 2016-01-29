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

{$IFDEF VER180}   // Delphi 2006 and 2007 (for Delphi 2007 specific VER185)
	{$DEFINE gtCF}
  {$DEFINE gtDelphi2007}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
  {$DEFINE gtDelphi2007Up}
{$ENDIF}
                        
{$IFDEF VER200} //Delphi 2009
	{$DEFINE gtCF}
	{$DEFINE gtDelphi2009}
  {$DEFINE gtDelphi2007Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
  {$DEFINE gtDelphi2007Up}
  {$DEFINE gtDelphi2009Up}
{$ENDIF}

{$IFDEF VER210} //Delphi 2010
	{$DEFINE gtCF}
    {$DEFINE gtDelphi2010}
	{$DEFINE gtDelphi2009Up}
    {$DEFINE gtDelphi2007Up}
	{$DEFINE gtDelphi2005Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
	{$DEFINE gtDelphi7Up}
	{$DEFINE gtDelphi2005Up}
  {$DEFINE gtDelphi2007Up}
  {$DEFINE gtDelphi2009Up}
  {$DEFINE gtDelphi2010Up}
{$ENDIF}

// If none of the above, assume to be Delphi 6 or later
{$IFNDEF gtCF}
	{$DEFINE gtDelphi3Up}
	{$DEFINE gtDelphi4Up}
	{$DEFINE gtDelphi5Up}
	{$DEFINE gtDelphi6Up}
{$ENDIF}

{.$DEFINE DEBUG}

// Switch that determines whether ProPlus Edition or not
{$DEFINE gtProPlus}

// Switch determines whether Professional edition or Standard Edition
{$DEFINE gtPro}

// Switch determines whether Registered or Trial Version
{$DEFINE gtRegistered}

{Switch determines whether to encrypt gtpdf32.dll}
{ON only when release buid is made}
{.$DEFINE COPYPROTECT}

{$IFDEF gtDelphi6Up}
  {$IFDEF gtPro}
    {$DEFINE gtUseSelection}
  {$ENDIF}
{$ENDIF}

// switch that determines whether its an ActiveX build or not
{.$DEFINE gtActiveX}

{.$DEFINE DLLIMPORT}

{.$DEFINE EXPOSEGDIINIT}

{$WARNINGS OFF}
{$HINTS OFF}