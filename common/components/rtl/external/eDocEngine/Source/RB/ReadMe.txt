Manual instruction to install report builder 14 Export Interface
----------------------------------------------------------------

Please follow the manual instruction to install Report builder 14 Export Interface:
----------------------------------------------------------------------------------
1)Open (edoc engine Installation path) \Source \ gtExpIntf.inc file and enable the Report builder 14 as per the instruction in the file and save the file
2)Ensure the LIB path of the reporting component is already set in the IDE.


IDE                             <Run-time Package>         <Design-time Package>          <BPL file Name>
 
Delphi5                          gtRBExpD5.dpk                DCLgtRBExpD5.dpk               gtRBExpD5.bpl

Delphi6                          gtRBExpD6.dpk                DCLgtRBExpD6.dpk               gtRBExpD6.bpl

Delphi7					         gtRBExpD7.dpk                DCLgtRBExpD7.dpk               gtRBExpD7.bpl

Delphi 2005 		             gtRBExpD9.dpk                DCLgtRBExpD9.dpk               gtRBExpD9.bpl

Delphi 2006                      gtRBExpD10.dpk               DCLgtRBExpD10.dpk              gtRBExpD10.bpl

Delphi 2007                      gtRBExpD11.dpk               DCLgtRBExpD11.dpk              gtRBExpD11.bpl

Delphi 2009                      gtRBExpD12.dpk               DCLgtRBExpD12.dpk              gtRBExpD12.bpl

Delphi 2010                      gtRBExpD14.dpk               DCLgtRBExpD14.dpk              gtRBExpD14.bpl

Delphi XE                        gtRBExpD15.dpk               DCLgtRBExpD15.dpk              gtRBExpD15.bpl

Delphi XE2                       gtRBExpD16.dpk               DCLgtRBExpD16.dpk               gtRBExpD16.bpl

Delphi XE3                       gtRBExpD17.dpk               DCLgtRBExpD17.dpk               gtRBExpD17.bpl

 
 

Please follow the following instructions to install export interface for Report Builder 14 :
 

1. Open "<eDocEngine InstallDir>\Source\RB\<Run-time Package>" in Delphi.  

2. Right-click <Run-time Package> in the Project Manager and choose "Build" from the popup menu. 

3. Do Not Close The IDE. 
 
4. Search For <BPL File Name> in your System and Copy the file to System 32 ((In case of windows 7 use Syswow64 instead of System 32).  

5.Back to IDE

6. Open "<eDocEngine InstallDir>\Source\RB\<Design-time Package>" in Delphi.  

7.Right-click <Design-time Package> in the Project Manager and choose "Install" from the popup menu. 
 

A new tab named 'eDocEngine Additional' along with Gnostice ReportBuilder Export Interface should now appear on the component palette!

 


