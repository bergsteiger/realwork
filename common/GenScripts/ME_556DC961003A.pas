unit m3PluginSupport;

// Модуль: "w:\common\components\rtl\Garant\m3\m3PluginSupport.pas"
// Стереотип: "UtilityPack"

{$Include w:\common\components\rtl\Garant\m3\m3Define.inc}

interface

uses
 l3IntfUses
 , ActiveX
;

function _CoCreateInstance(const aCLSID: TCLSID;
 aUnknown: IUnknown;
 aContext: LongInt;
 const aIID: TIID;
 out aResult): hResult; stdcall;
function _CoInitialize(_unused: Pointer): hResult; stdcall;
procedure _CoTaskMemFree(APointer: Pointer); stdcall;
procedure _CoUninitialize; stdcall;
function _StgOpenStorage(aName: PWideChar;
 aPriority: IStorage;
 aStatStgMode: LongInt;
 aExclude: TSNB;
 _unused: LongInt;
 out AStorage: IStorage): hResult; stdcall;

implementation

uses
 l3ImplUses
 , SysUtils
 , Windows
 , m3StorageInterfaces
 , m3StgMgr
 , l3Chars
 , l3String
;

function _CoCreateInstance(const aCLSID: TCLSID;
 aUnknown: IUnknown;
 aContext: LongInt;
 const aIID: TIID;
 out aResult): hResult;
//#UC START# *556DC988009C_556DC961003A_var*
//#UC END# *556DC988009C_556DC961003A_var*
begin
//#UC START# *556DC988009C_556DC961003A_impl*
 Result := CoCreateInstance(aCLSID, aUnknown, aContext, aIID, aResult);
//#UC END# *556DC988009C_556DC961003A_impl*
end;//_CoCreateInstance

function _CoInitialize(_unused: Pointer): hResult;
//#UC START# *556DCAA400B2_556DC961003A_var*
//#UC END# *556DCAA400B2_556DC961003A_var*
begin
//#UC START# *556DCAA400B2_556DC961003A_impl*
 Result := CoInitialize(_unused);
//#UC END# *556DCAA400B2_556DC961003A_impl*
end;//_CoInitialize

procedure _CoTaskMemFree(APointer: Pointer);
//#UC START# *556DCAD40373_556DC961003A_var*
//#UC END# *556DCAD40373_556DC961003A_var*
begin
//#UC START# *556DCAD40373_556DC961003A_impl*
 CoTaskMemFree(APointer);
//#UC END# *556DCAD40373_556DC961003A_impl*
end;//_CoTaskMemFree

procedure _CoUninitialize;
//#UC START# *556DCAFC03A3_556DC961003A_var*
//#UC END# *556DCAFC03A3_556DC961003A_var*
begin
//#UC START# *556DCAFC03A3_556DC961003A_impl*
 CoUninitialize();
//#UC END# *556DCAFC03A3_556DC961003A_impl*
end;//_CoUninitialize

function _StgOpenStorage(aName: PWideChar;
 aPriority: IStorage;
 aStatStgMode: LongInt;
 aExclude: TSNB;
 _unused: LongInt;
 out AStorage: IStorage): hResult;
//#UC START# *556DCB240338_556DC961003A_var*
var
 l_Name : AnsiString;
 l_Ext : AnsiString;
 l_OrigExt : AnsiString;
 l_S : Im3IndexedStorage;
//#UC END# *556DCB240338_556DC961003A_var*
begin
//#UC START# *556DCB240338_556DC961003A_impl*
 if ((aPriority = nil) and (aExclude = nil) and (_unused = 0)) then
 begin
  l_Name := WideString(aName);
  l_OrigExt := ExtractFileExt(l_Name);

  if (l_OrigExt <> '') then
  begin
   l_Name := ChangeFileExt(l_Name, '');
   l_Ext := ExtractFileExt(l_Name);
   if (l_Ext <> '') then
   begin
    if (l_Ext[1] = '.') then
     System.Delete(l_Ext, 1, 1);
    if (Length(l_Ext) = 4) then
     if l3AllCharsInCharSet(l3PCharLen(l_Ext), cc_HexDigits) then
      l_Name := ChangeFileExt(l_Name, '');
   end;//l_Ext <> ''
  end;//l_OrigExt <> ''

  l_Name := l_Name + l_OrigExt;

  if ((aStatStgMode and $0000000f) = STGM_READ) then
   Result := Tm3ReadModeStorageManager.MakeSafeInterface(l_S, l_Name, m3_stPlugin)
  else
   Result := Tm3FullModeStorageManager.MakeSafeInterface(l_S, l_Name, m3_stPlugin);
   
  aStorage := l_S.As_IStorage;
 end//APriority = nil..
 else
  Result := STG_E_INVALIDPARAMETER;
//#UC END# *556DCB240338_556DC961003A_impl*
end;//_StgOpenStorage

end.
