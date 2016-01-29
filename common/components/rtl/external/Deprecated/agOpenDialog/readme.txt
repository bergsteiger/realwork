TAgOpenDialog and TAgSaveDialog are derived from TOpenDialog and TSaveDialog respectively. The new property "ShowPlacesbar" will show a bar on the left in Windows 2000. 

Source code is provided. (Compiles in Delphi 5, with and without the 5.01 patch.)

If you have any problems, you can write to us at shenoy@agnisoft.com.

NEW! Support for Windows ME has been added. Check out the IsWin2000 function. 

Thanks to the following people for their valuable inputs:
Jean-Fabien Connault <cycocrew@worldnet.fr>
Mark Carrington <mark@mutantpenguin.net> 
Petri Mustonen <weilo@hem.passagen.se>

Notes for CPP Builder users:
------------------------------
Thanks to Mark Carrington <mark@mutantpenguin.net> for this (I don't use CPP Builder myself)

When first installing the components on CPP Builder, the automatically generated header is incorrect.
In the .hpp file, change the function headers with problems to
inline BOOL __stdcall GetOpenFileNameEx(tagOFNA &OpenFile)
and
inline BOOL __stdcall GetSaveFileNameEx(tagOFNA &OpenFile)


Files
----------
1. Readme.txt - This file (duh)
2. AgFileOpener.DPK - Delphi 5 package file that installs the components.
3. AgOpenDialog.Pas - The component code.
4. Comptest.dpr, testingform.pas, testingform.dfm - Form that tests the functionality of the new dialog components. DO NOT USE UNTIL YOU HAVE INSTALLED AgFileOpener.Dpk.

License
----------
You may use TAgOpenDialog, TAgSaveDialog and the Source code FREE of charge, but you may NOT redistribute the source code without proper credit given to Agni Software.

You may include this entire archive for redistribution in a software catalog or library. 

IF YOU CHOOSE TO REDISTRIBUTE THIS FILE, AS IS OR WITH ANY MODIFICATIONS, IT WILL NOT BE UNDER THE "GNU GENERAL PUBLIC LICENSE" (GPL) AS GIVEN IN http://www.fsf.org/copyleft/gpl.html . Agni Software is against distributing any library or component with the GPL and will not allow any of its source code, however modified, to be redistributed under the GPL. If you cannot adhere to this condition, you may not use TAgOpenDialog and TAgSaveDialog.

(MPL, Public Domain and BSD are ok, and it would be nice if you can inform us at shenoy@agnisoft.com).

If this source code is distributed on any medium, this readme.txt, containing the license and disclaimer should necessarily be present. 

Disclaimer
----------
THIS SOFTWARE IS PROVIDED TO THE USER "AS IS."  AGNI SOFTWARE PRIVATE LIMITED MAKES NO 
WARRANTIES, EITHER EXPRESS OR IMPLIED, WITH RESPECT TO THIS SOFTWARE AND/OR ASSOCIATED 
MATERIALS PROVIDED TO THE USER, INCLUDING BUT NOT LIMITED TO ANY WARRANTY OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE OR AGAINST INFRINGEMENT. AGNI SOFTWARE PRIVATE LIMITED 
DOES NOT WARRANT THAT THE FUNCTIONS CONTAINED IN THE SOFTWARE WILL MEET YOUR REQUIREMENTS, 
OR THAT THE OPERATION OF THE SOFTWARE WILL BE UNINTERRUPTED OR ERROR-FREE, OR THAT DEFECTS 
IN THE SOFTWARE WILL BE CORRECTED.  FURTHERMORE, AGNI SOFTWARE PRIVATE LIMITED DOES NOT 
WARRANT OR MAKE ANY REPRESENTATIONS REGARDING THE USE OR THE RESULTS OF THE USE OF THE 
SOFTWARE OR ANY DOCUMENTATION PROVIDED HEREWITH IN TERMS OF THEIR CORRECTNESS, ACCURACY, 
RELIABILITY, OR OTHERWISE.  NO ORAL OR WRITTEN INFORMATION OR ADVICE GIVEN BY AGNI SOFTWARE 
PRIVATE LIMITED OR AN AGNI SOFTWARE PRIVATE LIMITED AUTHORIZED REPRESENTATIVE SHALL CREATE A 
WARRANTY OR IN ANY WAY INCREASE THE SCOPE OF THIS WARRANTY. 

LIMITATION OF LIABILITY -- AGNI SOFTWARE PRIVATE LIMITED AND ITS LICENSORS ARE NOT LIABLE FOR 
ANY CLAIMS OR DAMAGES WHATSOEVER, INCLUDING PROPERTY DAMAGE, PERSONAL INJURY, INTELLECTUAL PROPERTY 
INFRINGEMENT, LOSS OF PROFITS, OR INTERRUPTION OF BUSINESS, OR FOR ANY SPECIAL, CONSEQUENTIAL OR 
INCIDENTAL DAMAGES, HOWEVER CAUSED, WHETHER ARISING OUT OF BREACH OF WARRANTY, CONTRACT, 
TORT (INCLUDING NEGLIGENCE), STRICT LIABILITY, OR OTHERWISE.
 

Copyright (C) Agni Software Pvt. Ltd., 2000.
All Rights Reserved.
http://www.agnisoft.com
