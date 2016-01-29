Manual instruction to install Quick report 5 Export Interface
----------------------------------------------------------------

Please follow the manual instruction to install Quick report 5 Export Interface:
----------------------------------------------------------------------------------
1)Open (edoc engine Installation path) \Source \ gtExpIntf.inc file and enable the Quick Report 5 as per the instruction in the file and save the file
2)Ensure the LIB path of the reporting component is already set in the IDE.


IDE                                 <Run-time Package>           <Design-time Package>             <BPL file Name>
 
C++Builder 2010                     gtQR505Expd14.cbproj          DCLgtQR505Expd14.cbproj         gtQR505Expd14.bpl

C++Builder XE                       gtQRExpd15.cbproj            DCLgtQRExpd15.cbproj              gtQRExpd15.bpl

C++Builder XE2                      gtQRExpd16.cbproj            DCLgtQRExpd16.cbproj              gtQRExpd16.bpl

C++Builder XE3                      gtQRExpd17.cbproj            DCLgtQRExpd17.cbproj              gtQRExpd17.bpl

C++Builder XE4                      gtQRExpd18.cbproj            DCLgtQRExpd18.cbproj              gtQRExpd18.bpl

C++Builder XE5                      gtQRExpd19.cbproj            DCLgtQRExpd19.cbproj              gtQRExpd19.bpl

 
 

Please follow the following instructions to install export interface for Quick Report 5 :
 

1. Open "<eDocEngine InstallDir>\Source\QR_CB\<Run-time Package>" in C++ Builder.  

2. Right-click on <Run-time Package> in the Project Manager and choose "Build" from the popup menu. 

3. Do Not Close The IDE. 
 
4. Search For <BPL File Name> in your System and Copy the file to System 32 ((In case of windows 7(64 bit) use Syswow64 instead of System 32).  

5.Back to IDE

6. Open "<eDocEngine InstallDir>\Source\QR_CB\<Design-time Package>" in Delphi.  

7.Right-click on <Design-time Package> in the Project Manager and choose "Install" from the popup menu. 
 

A new tab named 'eDocEngine Additional' along with Gnostice Quick report Export Interface should now appear on the component palette!

 


