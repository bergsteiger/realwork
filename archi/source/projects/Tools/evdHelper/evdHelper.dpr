program evdHelper;

{$APPTYPE CONSOLE}

uses
  Windows,
  ShellAPI,
  
  SysUtils,

  l3Base,
  
  evEvdHelper
  ;

var
 l_Helper : TevEvdHelper;
begin
 l_Helper := TevEvdHelper.Create('o:\');
 try
  ShellExecute(0, nil, PChar(l_Helper.Execute), nil, nil, SW_Show);
 finally
  l3Free(l_Helper);
 end;//try..finally
end.
