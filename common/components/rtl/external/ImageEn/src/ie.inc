// ie.inc

{$Include l3XE.inc}

{.$define IEDEBUG}

{$A+}
{$T-} 

// Specify the modules to include

{$define IEINCLUDEJPEG2000} 			// support for Jpeg2000
{$define IEINCLUDEPNG} 					// support for PNG
{$define IEINCLUDEVIDEOCAPTURE} 		// support for VFW video capture (TImageEnVideoCap and TImageEnVideoView)
{$define IEINCLUDEMULTIVIEW} 			// support for multi view/thumbnails (TImageEnMIO and TImageEnMView)
{$define IEINCLUDETWAIN} 				// support for TWain acquisition
{$define IEINCLUDEDB} 					// support for database components (TImageEnDBVect and TImageEnDBView)
{$define IEINCLUDETIMAGEEN} 			// support for TImageEn component
{$define IEINCLUDEDIALOGIP} 			// support for image processing dialog
{$define IEINCLUDEDIALOGIO} 			// support for input/output dialog (button "Advanced" in save dialog)
{$define IEINCLUDEOPENSAVEDIALOGS} 	// support for open/save dialogs
{$define IEINCLUDEPRINTDIALOGS} 		// support for print dialogs
{$define IEINCLUDEWIA}					// WIA support (requires IEINCLUDETWAIN)
{$define IEINCLUDEDIRECTSHOW}			// DirectShow support (requires IEINCLUDEWIA)

// supported languages

{$define IESUPPORTENGLISH}				// English
{.$define IESUPPORTITALIAN}				// Italian
{.$define IESUPPORTGERMAN}				// German
{.$define IESUPPORTSPANISH}				// Spanish
{.$define IESUPPORTFRENCH}				// French
{.$define IESUPPORTPORTUGUESE}			// Portuguese
{.$define IESUPPORTGREEK}				// Greek
{.$define IESUPPORTRUSSIAN}				// Russian
{.$define IESUPPORTDUTCH}				// Dutch
{.$define IESUPPORTSWEDISH}				// Swedish
{.$define IESUPPORTPOLISH}				// Polish
{.$define IESUPPORTUSER}					// User--

// components behavior

{$define IESINGLE_CLICK_SELECTION_REMOVE}	// single click out of a selection
{$define IETWAINTASKWINDOWS}					// enhances TWain compatibility
{.$define IEREGISTERTPICTUREFORMATS}		// register ImageEn file formats in the VCL



// detect Borland compiler version
// IEDCPPBUILDER = C++Builder (3,4,5,6...)
// IEDC3 = Delphi 3 or C++Builder 3
// IEDELPHI3 = Delphi 3
// IECPPBUILDER3 = C++Builder 3
// IEDC4 = Delphi 4 or C++Builder 4
// IEDELPHI4 = Delphi 4
// IECPPBUILDER4 = C++Builder 4
// IEDC5 = Delphi 5 or C++Builder 5
// IEDELPHI5 = Delphi 5
// IECPPBUILDER5 = C++Builder 5
// IEDC6 = Delphi 6 or C++Builder 6
// IEDELPHI6 = Delphi 6
// IECPPBUILDER6 = C++Builder 6
// IEDC7 = Delphi 7 or C++Builder 7 (??)
// IEDELPHI7 = Delphi 7
// IEKYLIX = Kylix 1,2,3
// IEDELPHI = Delphi or C++Builder

{$ifdef VER100}
   {$define IEDC3}
	{$define IEDELPHI3}	   // delphi 3
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER110}
   {$define IEDC3}
	{$define IECPPBUILDER3}	// c++builder3
   {$define IECPPBUILDER}
   {$ObjExportAll On}
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER120}
   {$define IEDC4}
	{$define IEDELPHI4}		// delphi 4
	{$define IEFIXPREVIEWS}
   {$define IESUPPORTDEFPARAMS}
   {$define IEHASINT64}
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER125}
   {$define IEDC4}
	{$define IECPPBUILDER4}		// c++builder4
   {$define IECPPBUILDER}
   {$ObjExportAll On}
 	{$define IEFIXPREVIEWS}
   {$define IESUPPORTDEFPARAMS}
   {$define IEHASINT64}
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER130}
   {$define IEDC5}
	{$ifdef VER130BCB}
		{$define IECPPBUILDER5}		// c++builder 5
		{$define IECPPBUILDER}
		{$ObjExportAll On}
      {$define IEHASINT64}
	{$else}
		{$define IEDELPHI5}		// delphi 5
      {$define IEHASINT64}
	{$endif}
	{$define IEFIXPREVIEWS}
   {$define IEFIXUPDATE}
   {$define IESUPPORTDEFPARAMS}
   {$define IESUPPORTANCHORS}
   {$define IEMOUSEWHEELEVENTS}
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER140}
   {$define IEDC6}
   {$ifdef VER140BCB}
   	{$define IECPPBUILDER6}    // c++builder 6
      {$define IECPPBUILDER}
      {$ObjExportAll On}
      {$define IEHASINT64}
   {$else}
		{$define IEDELPHI6}		// delphi 6
      {$define IEFIXDESIGNINT}
      {$define IEHASINT64}
   {$endif}
	{$define IEFIXPREVIEWS}
   {$define IEFIXUPDATE}
   {$define IEFIXOSDIALOGS}
   {$define IESUPPORTDEFPARAMS}
   {$define IESUPPORTANCHORS}
   {$define IEMOUSEWHEELEVENTS}
   {$ifndef WIN32}
   	{$define WIN32}
   {$endif}
{$endif}
{$ifdef VER150}
   {$define IEDC7}
	{$define IEDELPHI7}	// delphi 7
   {$define IEFIXPREVIEWS}
   {$define IEFIXUPDATE}
   {$define IEFIXOSDIALOGS}
   {$define IEFIXDESIGNINT}
   {$define IESUPPORTDEFPARAMS}
   {$define IESUPPORTANCHORS}
   {$define IEMOUSEWHEELEVENTS}
   {$define IEHASINT64}
{$endif}

{$ifdef XE}
   {$define IEDC7}
	{$define IEDELPHI7}	// delphi 7
   {$define IEFIXPREVIEWS}
   {$define IEFIXUPDATE}
   {$define IEFIXOSDIALOGS}
   {$define IEFIXDESIGNINT}
   {$define IESUPPORTDEFPARAMS}
   {$define IESUPPORTANCHORS}
   {$define IEMOUSEWHEELEVENTS}
   {$define IEHASINT64}
{$endif}

{$ifdef LINUX}
	{$define IEKYLIX}
   {$define IESUPPORTDEFPARAMS}
{$else}
	{$define IEDELPHI}
{$endif}


// under Linux we cannot implement following features

{$ifdef IEKYLIX}
{$define IEINCLUDESANE} // support for SANE (Linux scanner API)
{$undef IEINCLUDEJPEG2000}
{$undef IEINCLUDEVIDEOCAPTURE}
{$undef IEINCLUDEMULTIVIEW}
{$undef IEINCLUDETWAIN}
{$undef IEINCLUDEDB}
{$undef IEINCLUDETIMAGEEN}
{$undef IEINCLUDEDIALOGIP}
{$undef IEINCLUDEDIALOGIO}
{$undef IEINCLUDEOPENSAVEDIALOGS}
{$undef IEINCLUDEWIA}
{$undef IEINCLUDEDIRECTSHOW}
{$endif}

// disabled warnings

{$ifdef IEDELPHI7}
	{$WARN SYMBOL_PLATFORM OFF}
	{$WARN UNIT_PLATFORM OFF}
{$endif}

{$IfDef Nemesis}
	{$Define ImageEnNeedOvc}
{$EndIf Nemesis}


