unit F1ShellDriver_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 26.10.2015 13:20:48 from Type Library described below.

// ************************************************************************  //
// Type Lib: W:\garant6x\implementation\Garant\GbaNemesis\integration\implementation\F1ShellDriver.tlb (1)
// LIBID: {E8EA0684-944C-4283-8D68-648A5343587D}
// LCID: 0
// Helpfile: 
// HelpString: F1ShellDriver Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  F1ShellDriverMajorVersion = 1;
  F1ShellDriverMinorVersion = 0;

  LIBID_F1ShellDriver: TGUID = '{E8EA0684-944C-4283-8D68-648A5343587D}';

  IID_IF1Shell: TGUID = '{3EA46910-656F-4C76-826B-C8485B9FA36E}';
  CLASS_F1Shell: TGUID = '{68F469E6-0D31-41FE-A9B6-95ADE76761F1}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IF1Shell = interface;
  IF1ShellDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  F1Shell = IF1Shell;


// *********************************************************************//
// Interface: IF1Shell
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3EA46910-656F-4C76-826B-C8485B9FA36E}
// *********************************************************************//
  IF1Shell = interface(IDispatch)
    ['{3EA46910-656F-4C76-826B-C8485B9FA36E}']
  end;

// *********************************************************************//
// DispIntf:  IF1ShellDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {3EA46910-656F-4C76-826B-C8485B9FA36E}
// *********************************************************************//
  IF1ShellDisp = dispinterface
    ['{3EA46910-656F-4C76-826B-C8485B9FA36E}']
  end;

// *********************************************************************//
// The Class CoF1Shell provides a Create and CreateRemote method to          
// create instances of the default interface IF1Shell exposed by              
// the CoClass F1Shell. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoF1Shell = class
    class function Create: IF1Shell;
    class function CreateRemote(const MachineName: string): IF1Shell;
  end;

implementation

uses ComObj;

class function CoF1Shell.Create: IF1Shell;
begin
  Result := CreateComObject(CLASS_F1Shell) as IF1Shell;
end;

class function CoF1Shell.CreateRemote(const MachineName: string): IF1Shell;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_F1Shell) as IF1Shell;
end;

end.
