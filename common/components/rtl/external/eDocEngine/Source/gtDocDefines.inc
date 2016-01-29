{***************************************************************************}
{                                                                           }
{  Gnostice eDocEngine      		                                            }
{                                                                           }
{  Copyright © 2002-2007 Gnostice Information Technologies Private Limited  }
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

// TO ENABLE: Remove the dot(.) before $DEFINE to look as {$DEFINE ...}
// TO DISABLE: Add a dot(.) before $DEFINE to look as {.$DEFINE ...}

// --- RichEdit98 Support ---
// ENABLE this switch if you need to use RichEdit98 for rendering RTF.
{.$DEFINE RichEdit98}

// --- JEDI RichEdit(JvRichEdit) Support ---
// ENABLE this switch if you need to use JEDI RichEdit(JvRichEdit) for rendering RTF.
{.$DEFINE JediRichEdit}

// --- GIF Support ---
// eDocEngine does not have an inbuilt support, but can use one of the
// third-party GIF libraries mentioned below. Please make sure you have
// the appropriate units installed first. Then ENABLE only one of the
// below switches to get support for GIF images.
// --- GIF by RxGIF unit (http://www.rxlib.com) ---
{.$DEFINE GIFByRx}
// --- GIF by Anders Melander's GIF unit (http://www.melander.dk) ---
{.$DEFINE GIFByAM}
// --- GIF by Anders Melander's  GIFImg.unit
{.$ DEFINE GIFIMG}
// --- GIF Support ---

// --- PNG Support ---
// ENABLE this switch if you need to use PNGDelphi from
// http://pngdelphi.sourceforge.net.
{.$DEFINE PNGDelphi}
// --- PNG Support ---

// --- E-Mail Support ---
// ENABLE this switch if you need to use FastNet for e-mail with eDocEngine
{.$DEFINE EMailWithFastNet}

// ENABLE EMailWithIndy switch if you need to use Indy for e-mail with
// eDocEngine.
//If you use Indy version
//Above 9.00 , ENABLE Indy900Up and DISABLE Indy1000Up .
//Above 10.00 , ENABLE Indy1000Up and DISABLE Indy900Up .
//Above 10.25 , ENABLE Indy1000Up & Indy1025Up and DISABLE Indy900Up .
{.$DEFINE EMailWithIndy}
{.$DEFINE Indy900Up}
{$DEFINE Indy1000Up}
{.$DEFINE Indy1025Up}
// --- E-Mail Support ---

// --- Use of GLOBAL variables ---
// Some of the eDocEngine Export Interface components, QuickReport Export and
// ReportBuilder Export, use global variables to manage property values.
// eDocEngine itself does not use any Global variables. ENABLE the below switch
// to configure eDocEngine to NOT use any global variables. It maybe required
// ONLY if there are problems using eDocEngine in threaded applications.
{.$DEFINE NOGlobalSettingsVar}
// --- Use of GLOBAL variables ---


// --- DO NOT CHANGE ANYTHING BELOW ---
{$IFDEF EMailWithFastNet}
  {$DEFINE EMailSupport}
  {$UNDEF EMailWithIndy}
  {$UNDEF Indy900Up}
  {$UNDEF Indy1000Up}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$DEFINE EMailSupport}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$UNDEF EMailWithFastNet}
{$ENDIF}
{$IFDEF EMailWithIndy}
  {$IFDEF Indy900Up}
    {$UNDEF Indy1000Up}
  {$ENDIF}
{$ENDIF}



{$IFDEF GIFByRx}
  {$DEFINE GIFSupport}
{$ENDIF}
{$IFDEF GIFByAM}
  {$DEFINE GIFSupport}
{$ENDIF}
{$IFDEF GIFIMG}
  {$DEFINE GIFSupport}
{$ENDIF}

// Switch determines whether Professional edition or Standard Edition
{.$DEFINE gtRE}
{$DEFINE gtPro}

// Switch determines whether Registered or Trial Version
{$DEFINE gtRegistered}

// Enable for FileMaker Build only
{.$DEFINE gtFileMaker}

// ENABLE this switch when building for Many2PDF
{.$DEFINE gtMany2PDFX}

// Switch determines whether ActiveX or VCL
{.$DEFINE gtActiveX}

// --- QRP Support for ActiveX ---
// ENABLE this switch if you need to export QRP
{.$DEFINE QuickReportX}

// --- DO NOT CHANGE ANYTHING BELOW ---
{$IFDEF gtFileMaker}
  {$IFNDEF gtActiveX}
    {$DEFINE gtPro}
  {$ENDIF}
  {$UNDEF gtRegistered}
{$ENDIF}
{$IFDEF gtPro}
  {$UNDEF gtRE}
{$ENDIF}
{$IFDEF gtRE}
  {$UNDEF gtPro}
{$ENDIF}
{$IFNDEF gtActiveX}
  {$UNDEF QuickReportX}
{$ENDIF}

