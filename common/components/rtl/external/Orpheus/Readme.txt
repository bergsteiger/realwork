                  ================================
                  Last Minute News on Orpheus 2.17
                  ================================

This file describes changes, additions, and clarifications to Orpheus that do
not appear in the printed documentation. Please print and read this file
prior to using Orpheus, and save it for future reference. It includes the
following sections, which are organized according to the unit/utility to
which they apply:

   000. General Information
   050. Package Naming Convention
   100. Delphi 3/4 Notes
   200. Known Problems
   300. Virtual List Box
   700. Installing in C++Builder (Delphi Edition Owners)
   800. Miscellaneous
   900. Frequently asked questions
   999. Corrections to the Manual


000. General Information
=============================================================================
LICENSE.TXT, located in the product directory, is the licence agreement that
applies to this product.

Refer to the DEPLOY.TXT file in the \REDIST directory for information
concerning the deployment of packages.

Orpheus requires the TurboPower String Resource Manager, a tool for
simplifying internationalization of your application's string resources.
SETUP installs the TurboPower String Resource Manager in the C:\SRMGR
directory. You can specify a different directory, if desired. A Global
instance of the TpsStringResource class, "OrphStr", is automatically created
and is available for you to use. Refer to the README.TXT in the \SRMGR
directory for information about using the TpsStringResource class.


050. Package Naming Convention
======================================================================
To avoid version conflicts with applications using different versions of the
Orpheus packages, each new version of Orpheus will come with packages using
slightly different names.

The Orpheus packages have the following form:

  ONNNXXVV.DPL (or .BPL for Delphi 4 and C++Builder 3)

where the NNN is the version number of Orpheus (eg, 217 means version 2.17),
XX are product-specific characters, and VV is the version of VCL supported
(eg, 30 means VCL 3.0 as shipped with Delphi 3).



100. Delphi 3/4 Notes
======================================================================

Installation
------------
Orpheus help and the two design-time packages are automatically
installed into Delphi 3 or 4 if Orpheus is installed using the setup
program. If you are upgrading by using a patch or the installation
program simply failed to handle this properly, you will need to use
the "Install Packages" menu option to install the two Orpheus
design-time packages (OXxx_D30.DPL and OXxxBD30.DPL for Delphi 3,
OXxx_D40.BPL and OXxxBD40.BPL for Delphi 4 -- the Xxx is the
version number).  In order for the two run-time packages
(OXxx_R30.DPL and OXxxBR30.DPL for Delphi 3, OXxx_R40.DPL and
OXxxBR40.DPL for Delphi 4) to be "seen" by Delphi (and the design-
time packages) you need to copy them to the Windows system directory
(\System for Win95 or \System32 for NT) or add the Orpheus directory
to your path.  Another option is to copy the Orpheus DPL files to
the Delphi \BIN directory.

Be sure to alter Delphi's library path so that it includes the path
to the Orpheus source files (Tools|Environment Options - Library
Page) so that Delphi can find the Orpheus source files when required.
Or, add the Orpheus path to your system Path environment.

Help Installation
-----------------
To manually install the Orpheus help into Delphi 3, perform the
following steps:

  Edit the Delphi3.cnt file (in the Delphi Help directory) and add
the following line to the "index" section:

    :Index Orpheus Reference =orph32.hlp

The first time you attempt to access Orpheus help, Delphi/Windows
won't be able to locate the help file and will ask if you want to
find the file yourself.  Answer yes to this question and browse for
the Orpheus help file (ORPH32.HLP), which should be in the Orpheus
directory. This step will only be required the first time you access
Orpheus' help.

To install the help into Delphi 4, use the Help | Customize option
from the IDE. Please refer to your Delphi 4 documentation for details.


200. Known Problems
======================================================================

There appears to be a limit to the number of entries allowed in the
Delphi 1.0 and 2.0 DELPHI.HDX file. Merging the Orpheus keyword file
may exceed this limit and cause Delphi's context sensitive help to
stop working properly. We have found that the only solution to this
problem is to remove one or more keyword files from DELPHI.HDX.

Installing several component libraries into Delphi 2.0 may result in
a stack overflow during the link phase. Installing all components
from Orpheus and Async Professional for Delphi causes this problem.
We have been able to successfully build the component library by
pulling out just about any other component registration unit. That
makes it sound like some limit within Delphi 2.0 is being exceeded.

We also found that the command line compiler doesn't, for the moment,
exhibit this problem. To use this approach, you would need to
manually add the Orpheus and APD registration units (and such) to the
CMPLIB32.DPR file manually, as shown below. Compile with "DCC32
CMPLIB32", then rename CMPLIB32.DLL to CMPLIB32.DCL.

CMPLIB32.DPR:

uses
  ...
  SampReg,
  apdreg,
  apdfreg,
  ovcreg,
  ovcregdb,
  ovcregtb,
  LibMain;
  ...
  {$R 'e:\Delphi2\Lib\SampReg.dcr'}
  {$R 'd:\apd\apdreg.dcr'}
  {$R 'd:\apd\apdfreg.dcr'}
  ...
  RegisterModule('SampReg', SampReg.Register);
  RegisterModule('ovcreg', ovcreg.Register);
  RegisterModule('ovcregdb', ovcregdb.Register);
  RegisterModule('ovcregtb', ovcregtb.Register);
  RegisterModule('apdreg', apdreg.Register);
  RegisterModule('apdfreg', apdfreg.Register);

Note: You can have Delphi save the default COMPLIB32.DPR after a
rebuild of the component library by selecting the "Save library
source code" option from the Library tab of the Environment Options
dialog.


300. Virtual List Box
======================================================================

When running or saving the example programs that use an Orpheus
virtual listbox, (ADDRBOOK, EXPIZZA, EXVLB, and ORDENTRY), ignore the
error that Delphi 1.0 displays by selecting the "NO" button.

This error is generated because of a bug in Delphi's handling of the
$IFDEF's within the GetItem event handler declaration. If you do not
use IFDEF's within a form's declaration in your own applications,
this should not be an issue.

Added SelectAll and DeselectAll methods.


700. Installing in C++Builder (Delphi Edition Owners)
======================================================================
Orpheus version 2.14 and later can be used with either Delphi or C++Builder.
The only difference between the Delphi Edition of Orpheus and the C++Builder
Edition is the printed manual. The Orpheus source files are the same in
either case. If you install the BCB help file and examples then you will find
the help file in the ORPHEUS\HELP\CBUILDER directory and the examples in
ORPHEUS\EXAMPLES\CBUILDER.

Header and object files for C++Builder 3.0 are installed by default. If you
have selected to install the C++Builder 1.0 example files and have not also
selected the C++Builder 3.0 example files, header and object files for
C++Builder 1.0 are installed. If you need to generate header and object
files to support the other C++Builder compiler, use the DCC32.EXE program to
compile the .pas files using -jphn as the command-line options.


Installing the Components
-------------------------
The installation process under BCB is the same as it is for Delphi 2.0.
You can refer to the manual for steps to install under Delphi 2.0 or
you can perform the following:

1. Choose Component | Install from the BCB main menu.

2. Click on the Add button and then the Browse button.

3. Navigate to the directory where you have installed Orpheus.

4. Locate the OVCREG.PAS file and click the Open button.

5. Repeat steps 2-4 to install OVCREGDB.PAS and OVCREGTB.PAS if desired.

6. Click the OK Button to rebuild the component library.


Installing Integrated Help
--------------------------
If you chose the option to install the BCB help file then the install
program copies the Orpheus help and contents files to the
\ORPHEUS\HELP\CBUILDER directory.

To install the integrated help files you must run the OpenHelp utility that
comes with C++Builder. You can run OpenHelp from the C++Builder folder or
find it in \PROGRAM FILES\COMMON FILES\BORLAND\OPENHELP. The C++Builder
installation program automatically adds this directory to the drive where
Windows is installed (this might not be the drive where you installed
C++Builder). To install the Orpheus help files in BCB follow these steps:

1. Run OPENHELP.EXE. The available help files are shown in a listbox at the
   bottom left. Click on the Add button below the listbox.

2. The File Open dialog is displayed. Navigate to the directory where you
   have Orpheus help installed. Select the ORPHBCB.HLP file and click OK.

3. ORPHBCB.HLP is added to the list of available help files. Click on
   ORPHBCB.HLP in the listbox and then click the ">" button. This adds the
   Orpheus help file to the "Selected Help Files" listbox on the right
   side of the window. Due to a bug in OpenHelp, you might have to click the
   ">" button twice. Be sure that ORPHBCB.HLP shows up in the "Selected Help
   Files" listbox before continuing.

4. Click Apply and then click OK to close OpenHelp. You must click on Apply
   first and then OK, due to a bug in OpenHelp.


800. Miscellaneous
======================================================================

Using Orpheus with both Delphi 1.0 and Delphi 2.0 or Delphi 1.0 and
Delphi 3.0:

Because these compiler versions use different DCU file formats,
switching from one compiler version to the other usually results in
Delphi reporting an error. Several users have ask us what is the best
way to handle this situation.

One solution is to install Orpheus twice (once for each compiler
version), using a different directory name for each. Another is do
insure that the Orpheus DCU files are deleted whenever you switch
from one compiler version to the other (this is the method most of us
here at TurboPower use).


TOvcController
--------------
The DelayNotify method and the OnDelayNotify event were added to the
TOvcController component. Calling DelayNotify posts a special message
to the controller. When the controller receives this message, it
calls the method assigned to the OnDelayNotify event.

This combination of method and event is provided so that you can
trigger an event _after_ any current messages have been processed.
For example, within a OnEnter or OnExit event handler you can not do
anything that would change the focus (since a focus change is
currently in progress). Calling DelayNotify and providing an event
handler for the OnDelayNotify event allows you to postpone changing
the focus until the OnDelayNotify event is fired.

procedure DelayNotify(Sender : TObject; NotifyCode : Word);

DelayNotify starts the chain of events that will fire the
OnDelayNotify event.  Sender is intended to be the object where the
call takes place, but can be any data that you care to have passed to
the OnDelayNotify event. NotifyCode is intended to provide a value to
the OnDelayNotify event that will indicate the purpose of the
notification. After calling DelayNotify, a message is posted using
PostMessage (not sent using SendMessage or Perform) to the
controller.  (Posting allows other messages in the message queue to
be processed.)

property OnDelayNotify : TDelayNotifyEvent
TDelayNotifyEvent = procedure(Sender : TObject; NotifyCode : Word) of
object;

OnDelayNotify provides an event that is fired by callin the
DelayNotify method.


Added an OnIsSpecialControl event to the TOvcController calss that
can be used along with or instead of the "special button" properties.

  property OnIsSpecialControl : TIsSpecialControlEvent
  TIsSpecialControlEvent =
    procedure(Sender : TObject; Control : TWinControl; var Special : Boolean)
    of object;

Control is the control that is about to receive the focus. Set
Special to True to avoid performing validation on the field about to
loose the focus.


TOvcPictureLabel
----------------
ShowDateOrTime property was added to provide a choice of which part
of an associated TDateTimeField value should be displayed.

Possible values are ftShowDate or ftShowTime.


TOvcTimerPool
-------------
Added the AddOneShot method which is similar to the AddOneTime method
except that the handle returned as the function result can be ignored
and calling AddOneShot prior to the firing of the last one-shot
trigger will replace the existing trigger with the new settings.

function AddOneShot(OnTrigger : TTriggerEvent; Interval : Word) : Integer;


TOvcBaseEntryField
------------------
Added AfterEnter and AfterExit events that provide notification
"after" the focus has been received and "after" the focus has been
lost. This differs from the standard OnEnter and OnExit. In the
standard version of these events, the current focus change has not
yet completed and you can not do anything that would cause another
focus change such as displaying a dialog or setting a property that
causes RecreateWnd to be called. In AfterEnter and AfterExit the
focus change that triggered the event has completed and changing the
focus is allowed.

AfterEnter and AfterExit events were added for the following
components:

  TOvcViewer, TOvcTextFileViewer, TOvcVirtualListbox,
  TOvcSearchList, TOvcNotebook, TOvcDbColumnList, TOvcSimpleField,
  TOvcPictureField, TOvcNumericField, TOvcCalendar, TOvcEditor,
  TOvcTextFileEditor, TOvcDbCalendar, TOvcDbEditor, TOvcDbNumericField,
  TOvcDbPictureField, TOvcDbSimpleField, and TOvcButtonHeader


TOvcArrayEditor's
-----------------
Added WriteCellValue method that commits the cell's current value to
the associated data structure.

Added DisabledColors property


TOvcDbArrayEditor's
-------------------
Published the Align property.


TOvcDbColumnList
----------------
Published the Align property.


TOvcEF (all entry fields}
-------------------------
Added local popup menu similar to the one supplied by TEdit
Changed SelectedText property to a read/write property


TOvcDbTable
-----------
Added OnLeftColumnChanged event that is fired when the left column
changes

Added methods to support saving and restoring of column order and
widths:

    procedure GetColumnOrder(var Cols : array of string);
      {-obtain the field names for each of the table columns}
    procedure GetColumnWidths(var Cols : array of Integer);
      {-obtain the widths of the table columns}
    procedure SetColumnOrder(const Cols : array of string);
      {-set the order of the table columns using field names}
    procedure SetColumnWidths(const Cols : array of Integer);
      {-set the widths of the table columns}


TOvcEditor
----------
Note: Editors that are "attached" are detached as part of the process
invoked by calling the DeleteAll method.



900. Frequently asked questions
======================================================================

For a list of answers to frequently asked questions about Orpheus,
run WINHELP ORPFAQ.HLP from the Orpheus directory.


999. Corrections to the Manual
======================================================================

p.26
        The ValidateTheseEntryFields method is missing.
        function ValidateTheseEntryFields(Fields : array of TComponent) :
          TComponent;
        ValidateTheseEntryFields performs the same function as the
        ValidateEntryFields except that validation is only performed for the
        componets listed as the argument "Fields"
p.82
        "effect" should read "affect" in the Caution on this page
p.105
        AsBCD is missing the hourglass symbol to indicate that it is
        a run-time only property
p.108
        AsBCD should be marked as "run-time" in the reference header
p.630
        Delete the second to last paragraph.
p.635
        Delete the second to last paragraph.
p.704
        Add: The TOvcDbSearchEdit must be attached to a datasource with at
        least one index. If multiple indexes are available, changing the
        index will cause the TOvcDbSearchEdit to search the currently active
        index. TOvcDbSearchEdit does not support the use of expression
        indexes for DBase files.


On-Line Help
======================================================================
Many properties listed in the property lists incorrectly indicate that
the item is "run-time" only (the hourglass symbol).
