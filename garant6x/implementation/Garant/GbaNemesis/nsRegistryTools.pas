unit nsRegistryTools;

interface

uses
  Windows
  ;

function GetStringFromRegistry(const aRootKey      : HKEY;
                               const aPathKey      : string;
                               const aValueName    : string;
                               const aDefaultValue : string = ''): string;
  {-}

implementation

uses
  Registry
  ;

function GetStringFromRegistry(const aRootKey: HKEY; const aPathKey: string; const aValueName: string; const aDefaultValue: string): string;
begin
 Result := aDefaultValue;
 try
  with TRegistry.Create do
   try
    RootKey := aRootKey;
    if OpenKey(aPathKey, False) then
     try
      if ValueExists(aValueName) then
       Result := ReadString(aValueName);
     finally
      CloseKey;
     end;
   finally
    Free;
   end;
 except
  on ERegistryException do;
 end;
end;

end.