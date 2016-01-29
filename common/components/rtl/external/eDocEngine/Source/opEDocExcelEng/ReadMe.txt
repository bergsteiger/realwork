{ --------------------------------------------------------- }
{ OPUS eDoc Integration                                     }
{ Copyright (c) 1986-2011 by gs-soft AG                     }
{                                                           }
{ All rights reserved.                                      }
{ --------------------------------------------------------- }

opEDocExcelEngine is an additional component provided with eDocEngine 
with the permission of its developers, gs-soft AG. This component is an 
alternative for TgtExcelEngine.

"Gnostice will not provide any support for this component"

1. Installation and Getting Started :
-----------------------------------


Note: Before installing this component, eDocEngine must be installed 
	  in your system. 

During installation of eDocEngine all the Project Group, Run time and 
design time packages of opEDocExcelEngine gets copied to the location: 
<eDocEngine InstallDir>\Source\opEDocExcelEng\.

The table below lists project group and package libraries for 
opEDocExcelEngine. Replace the place holders in the instructions with 
appropriate names by referring this table.
 

Place holder	             Delphi 5	                     Delphi 6	                   Delphi 7	     	
<Folder Name>	               D5	                           D6	                         D7	                
<Project Group>	        opEDocExcelEngineD5.bpg	      opEDocExcelEngineD6.bpg	      opEDocExcelEngineD7.bpg     
<Run-time Package>      opEDocExcelEngD5.bpl	      opEDocExcelEngD6.bpl	      	  opEDocExcelEngD7.bpl     	
<Design-time Package>   DCLopEDocExcelEngD5.bpl    	  DCLopEDocExcelEngD6.bpl	  	  DCLopEDocExcelEngD7.bpl 	
 

Place holder	          Delphi 2005                      Delphi 2006							Delphi 2007
<Folder Name>	            RAD2005				             RAD2006							  RAD2007
<Project Group>	       opEDocExcelEngineD9.bdsgroup		opEDocExcelEngineD10.bdsgroup		opEDocExcelEngineD11.groupproj
<Run-time Package>	   opEDocExcelEngD9.bpl				opEDocExcelEngD10.bpl				opEDocExcelEngD11.bpl
<Design-time Package>  DCLopEDocExcelEngD9.bpl			DCLopEDocExcelEngD10.bpl			DCLopEDocExcelEngD11.bpl


Place holder	          Delphi 2009                      Delphi 2010							Delphi XE
<Folder Name>	            RAD2009				             RAD2010							  RADXE
<Project Group>	       opEDocExcelEngine12.groupproj	opEDocExcelEngineD14.groupproj		opEDocExcelEngineD15.groupproj
<Run-time Package>	   opEDocExcelEngD12.bpl			opEDocExcelEngD14.bpl				opEDocExcelEngD15.bpl
<Design-time Package>  DCLopEDocExcelEngD12.bpl			DCLopEDocExcelEngD14.bpl			DCLopEDocExcelEngD15.bpl


a.	Open "<eDocEngine InstallDir>\Source\opEDocExcelEng\<Project Group>" in Delphi. 
b.	Select "Project | Build All Projects" on the main menu.
c.  Copy op*.bpl files from "<eDocEngine InstallDir>\Lib\<Folder Name>\" 
    to System32 (SysWow64 in case of Win7/Vista 64 bit operating system). 
d.	Right-click <Design-time Package> in the Project Manager and choose 
    "Install" from the popup menu.

A new tab named 'eDocEngine Additional' along with opEDocExcelEngine should now appear on the component palette!	


2. Uninstalling :
---------------
To uninstall opEDocExcelEngine, perform these steps:

 1. Start the IDE and select "Components | Install Packages" option 
    from the main menu. This will display the "Project Options for ...." 
	dialog box.
 2. Select opEDocExcelEngine component in the "Design Packages" list 
    of the dialog box.
 3. Click on the "Remove" button. This will remove opEDocExcelEngine
    from "eDocEngine Additional" tab in the component palette.