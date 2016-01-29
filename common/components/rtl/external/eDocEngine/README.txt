Gnostice eDocEngine 4.0.0 VCL
Copyright © 2002-2013 Gnostice Information Technologies Private Limited

Support	:	support@gnostice.com
Sales	:	sales@gnostice.com
Web	:	http://www.gnostice.com


Introduction
------------
Gnostice eDocEngine is a generic electronic document creation
component suite for Embarcadero Delphi™ and C++Builder™.
eDocEngine enables developers to deliver information straight
from the applications they develop, to over 20 popular
electronic document formats. Rich content can be easily
formatted to the precise look and feel required and delivered
directly to users’ web browsers, sent as email attachments or
saved to disk. eDocEngine currently supports the creation of
documents in PDF, RTF, HTML, XHTML, EXCEL, TEXT, CSV, Quattro
Pro, LOTUS 1-2-3, DIF, SYLK, TIFF, PNG, SVG (XML based vector
graphics), JPEG, GIF, BMP, EMF and WMF formats. Metafile, BMP,
DIFF, SYLK and Text can be directly output to the Windows®
Clipboard.

This ReadMe file contains late-breaking information that may not
be contained anywhere else. The ReadMe file also contains
information on where to start and get access to additional
resources to get the best out of Gnostice eDocEngine. We strongly
recommend that you read this ReadMe file before you get started.


Contents of ReadMe
==================
1. Installation and Getting Started
2. Known Issues
3. Important resources
4. Ordering
5. Uninstalling
6.Credits


1. Installation and Getting Started
-----------------------------------
Before installing eDocEngine, please ensure that the
computer meets minimum system requirements.

To install document-creation engine components of
eDocEngine,

Close all applications including the Delphi or C++Builder
IDE. Back up *.INC files of any existing installation of
eDocEngine and then uninstall existing version.

Launch the installation program of the new version and
follow the instructions displayed on the screen.

At the end of the installation, the installation program
will provide an option to install report-export interface
components. If these are required, select the option and
follow the instructions on the screen. Alternatively, run
the second installer later by launching it from the Windows
Start menu group for eDocEngine.

After the installation, a new "eDocEngine" tab will be
available on the component palette of the IDE. This tab
will contain all document-creation engine components of
eDocEngine. The report-export components, if installed,
will be available under a separate "eDocEngine
Additionals" tab.

A list of 3rd Party Reporting Tools, Editors & Grids
Supported is available at
<eDocEngine InstallDir>\Third_Party_Support.txt


2. Known Issues
---------------
The following is a list of features or functionality that 
was changed, not supported or has limitations in the final 
release of Gnostice eDocEngine 2.5. These limitations could
be due to the feature not being supported in the document 
format itself.

PDF Engine
* Hyperlinking of rotated text is not supported
* Some Annotation types require Adobe Acrobat Professional 
  to be installed to work
* Unicode in Form Fields not supported
* Embedding of Open Type Fonts with Post Script outlines not supported.


RTF Engine
* Image rotation is not supported
* Rotated text items are stored as images
* Arcs, Pies, and Chords are stored as images

HTML Engine
* Brush styles other than bsSolid and bsClear are not 
  supported
* Pen styles other then psSolid, psClear and psDash are not
  supported
* Image rotation is not supported
* Line spacing for paragraphs are not visible in viewers
  but can be noticed in FrontPage

Excel Engine
* Image rotation is not supported
* Frames for Images are not supported
* Rotation of frames is not supported
* Text rotation is not supported
* Unicode characters not supported

Quattro Pro Engine
* Images and Shapes are not supported
* Text rotation is not supported

DIF, SYLK and Lotus 1-2-3 Engines
* Font attribute and text rotation are not supported

SVG Engine
* Multi-byte character sets and non-ANSI characters are not 
  supported by viewers

All Graphic Engines
* Pen Style is always solid for pen widths greater than 1

Metafile rendering
* Clipping of regions not supported

Export Interfaces for C++Builder
* Export Interface installer for following IDEs and 
  Reporting Tools combination currently not supported:
  -C++Builder 6, 5 with all Reporting Tools.
  -C++Builder 2010, 2009, 2007 & QuickReport (Packages 
   provided for Manual installation).

Export Interface for  Report builder 14 and Scalerichview

*Installation of Export Interfaces for Report builder 14 and Scalerichview  can be done 
  manually by following the instructions Provided in the following files

*For Report builder 14 
(eDoccEngine Installation path)\eDocEngine VCL\Source\RB\Readme.txt

*For ScaleRichView
(eDocEngine Installation path)\eDocEngine VCL\Source\ScaleRichVw\Readme.txt

* Manual instructions to install export interfaces for RADXE3 IDE is provided under
(eDocEngine Installation path)\eDocEngine VCL\Source \ ExportInterface_Manual_InstructionforDelphiXE3.txt     


3. Important Resources
----------------------
The following is a list of resources to helps you get
information on eDocEngine, fast:

* The eDocEngine web pages at www.gnostice.com always contain
the latest information please keep a watch here:
http://www.gnostice.com/eDocEngine_VCL.asp

* The FAQs on the eDocEngine web pages and the included help
file give you specific answers fast. Access the help file
on the Start menu at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Help

* The included code samples and demos are a practical way of
getting to know how to use eDocEngine. Open the sample
projects within Delphi or C++Builder from here:
For Delphi     : My Documents\Gnostice\eDocEngine VCL\Demos\Delphi\
For C++Builder : My Documents\Gnostice\eDocEngine VCL\Demos\CBuilder\

For compatibility with Windows Vista and upwards and due to the restriction on write access to the Program Files folder,
the demos have been moved to My Documents folder\Gnostice....

* To know about the current status of eDocEngine and what
specific features were added or addressed in a specific
version or update, you can access the eDocEngine History
page at www.gnostice.com. The page is located at:
http://www.gnostice.com/eDocEngine_VCL.asp?show=history

* If you have specific questions and can’t find answers
to them, do not wait any longer. Go to the support page at
www.gnostice.com and follow the instructions given to get
quick answers to your queries. The support page is
located at:
http://www.gnostice.com/support.asp


4. Ordering
-----------
The fastest way to order Gnostice eDocEngine and start
enjoying the benefits of the registered version is to
order it from our Secure Online Store (hosted on
Plimus). There may also be special offers and special
pricing available. To learn of the special offers and
to order online please go to:
http://www.gnostice.com/buynow.asp

You can also order Gnostice eDocEngine over phone, fax,
email or postal mail. Please see the included Order
Form for details. The Order Form can be accessed from
the Start menu at:
Start > Programs > Gnostice > eDocEngine VCL > eDocEngine Order Form

Gnostice eDocEngine is delivered electronically. As soon
as your payment is authorized you will receive an email
with details on how to get access to the registered
version.

IMPORTANT: When you submit your order please make
sure the email you have provided is valid and working.

Gnostice eDocEngine is also available for OEM Licensing.
Please send your enquiries about OEM licensing to
sales@gnostice.com.


5. Uninstalling
---------------
To uninstall eDocEngine, perform these steps:

 1. Start the IDE and select "Components | Install Packages"
    option from the main menu. This will display the "Project
    Options for ...." dialog box.
 2. Select all Gnostice eDocEngine export interface
    components in the "Design Packages" list of the dialog
    box.
 3. Click on the "Remove" button. This will remove the
    "eDocEngine Additionals" tab from the component palette.
 4. Select Gnostice eDocEngine from the "Design Packages"
    list.
 5. Click on the "Remove" button. This will remove
    eDocEngine tab from the component palette.
 6. Close the dialog box.
 7. Close the IDE.
 8. From the Windows Start menu, navigate to the Gnostice
    eDocEngine program group and select the "Uninstall
    eDocEngine" option
	
	
6.Credits
-----------
Lance Rasmussen  :
For inputs, code and patience in making eDocEngine's HTML and XHTML output 100% W3C compliant. 


====================================================================
Copyright © 2002-2010 Gnostice Information Technologies
Private Limited. All rights reserved.

All Gnostice brand and product names are trademarks or registered
trademarks of Gnostice Information Technologies Private Limited.
All other names and trademarks are the property of their
respective owners.
=====================================================================