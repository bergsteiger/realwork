unit SysUtils;
 {* System Utilities Unit }

// Модуль: "w:\common\components\rtl\external\NotFinished\Borland\Delphi\Rtl\Sys\SysUtils.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "SysUtils" MUID: (47877EB202FB)

interface

uses
 l3IntfUses
;

type
 ExceptClass = class of Exception;

 TMultiReadExclusiveWriteSynchronizer = class
  {* TMultiReadExclusiveWriteSynchronizer protects memory in a multi-threaded application. }
 end;//TMultiReadExclusiveWriteSynchronizer

 TFileName = type AnsiString;
  {* TFileName is a string that represents a file name. }

 Exception = class(TObject)
  {* Base Exception. }
  private
   f_Message: AnsiString;
   f_HelpContext: Integer;
  public
   property Message: AnsiString
    read f_Message
    write f_Message;
   property HelpContext: Integer
    read f_HelpContext
    write f_HelpContext;
 end;//Exception

 EOSError = class(Exception)
 end;//EOSError

 TFormatSettings = record
  {* TFormatSettings defines a thread-safe string formatting context. }
 end;//TFormatSettings

 TProcedure = procedure;
  {* TProcedure is used as the type for generic procedures that do not have arguments. }

 EAbort = class
 end;//EAbort

 EAssertionFailed = class(Exception)
 end;//EAssertionFailed

 TSearchRec = record
  {* TSearchRec defines file information searched for by FindFirst or FindNext. }
 end;//TSearchRec

 EOutOfMemory = class
 end;//EOutOfMemory

procedure FreeAndNil;
procedure Supports; overload;
procedure IntToStr;
procedure CompareStr;
procedure ANSISameText;
procedure StrToInt;
procedure ExtractFilePath;
procedure Format;
procedure ChangeFileExt;
procedure IsEqualGUID;
procedure FileExists;
procedure GetClassName;
procedure Trim;
procedure AnsiStrLIComp;
procedure RenameFile;
procedure DeleteFile;
procedure StrToIntDef;
procedure FormatDateTime;
procedure Sleep;
procedure ForceDirectories;
procedure IntToHex;
procedure AllocMem;
procedure CompareMem;
function Supports(const Instance: IUnknown;
 const IID: TGUID;
 out Intf): Boolean; overload;

var DecimalSeparator: AnsiChar;

implementation

uses
 l3ImplUses
 {$If NOT Defined(NoScripts)}
 , TtfwTypeRegistrator_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 {$If NOT Defined(NoScripts)}
 , TtfwClassRef_Proxy
 {$IfEnd} // NOT Defined(NoScripts)
 //#UC START# *47877EB202FBimpl_uses*
 //#UC END# *47877EB202FBimpl_uses*
;

procedure FreeAndNil;
//#UC START# *4ADC58F703CF_47877EB202FB_var*
//#UC END# *4ADC58F703CF_47877EB202FB_var*
begin
//#UC START# *4ADC58F703CF_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADC58F703CF_47877EB202FB_impl*
end;//FreeAndNil

procedure Supports;
//#UC START# *4ADEE49C02DF_47877EB202FB_var*
//#UC END# *4ADEE49C02DF_47877EB202FB_var*
begin
//#UC START# *4ADEE49C02DF_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADEE49C02DF_47877EB202FB_impl*
end;//Supports

procedure IntToStr;
//#UC START# *4B2A12BA0288_47877EB202FB_var*
//#UC END# *4B2A12BA0288_47877EB202FB_var*
begin
//#UC START# *4B2A12BA0288_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2A12BA0288_47877EB202FB_impl*
end;//IntToStr

procedure CompareStr;
//#UC START# *4B2F575E03BA_47877EB202FB_var*
//#UC END# *4B2F575E03BA_47877EB202FB_var*
begin
//#UC START# *4B2F575E03BA_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4B2F575E03BA_47877EB202FB_impl*
end;//CompareStr

procedure ANSISameText;
//#UC START# *4BCED67800F1_47877EB202FB_var*
//#UC END# *4BCED67800F1_47877EB202FB_var*
begin
//#UC START# *4BCED67800F1_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4BCED67800F1_47877EB202FB_impl*
end;//ANSISameText

procedure StrToInt;
//#UC START# *4D6BC8D102C0_47877EB202FB_var*
//#UC END# *4D6BC8D102C0_47877EB202FB_var*
begin
//#UC START# *4D6BC8D102C0_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D6BC8D102C0_47877EB202FB_impl*
end;//StrToInt

procedure ExtractFilePath;
//#UC START# *4DDA4CFE00E8_47877EB202FB_var*
//#UC END# *4DDA4CFE00E8_47877EB202FB_var*
begin
//#UC START# *4DDA4CFE00E8_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DDA4CFE00E8_47877EB202FB_impl*
end;//ExtractFilePath

procedure Format;
//#UC START# *4DE89E560091_47877EB202FB_var*
//#UC END# *4DE89E560091_47877EB202FB_var*
begin
//#UC START# *4DE89E560091_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DE89E560091_47877EB202FB_impl*
end;//Format

procedure ChangeFileExt;
//#UC START# *4DF870EA0062_47877EB202FB_var*
//#UC END# *4DF870EA0062_47877EB202FB_var*
begin
//#UC START# *4DF870EA0062_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DF870EA0062_47877EB202FB_impl*
end;//ChangeFileExt

procedure IsEqualGUID;
//#UC START# *4E1DDD650025_47877EB202FB_var*
//#UC END# *4E1DDD650025_47877EB202FB_var*
begin
//#UC START# *4E1DDD650025_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E1DDD650025_47877EB202FB_impl*
end;//IsEqualGUID

procedure FileExists;
//#UC START# *4E4A3ABD032F_47877EB202FB_var*
//#UC END# *4E4A3ABD032F_47877EB202FB_var*
begin
//#UC START# *4E4A3ABD032F_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E4A3ABD032F_47877EB202FB_impl*
end;//FileExists

procedure GetClassName;
//#UC START# *4F7957C203E7_47877EB202FB_var*
//#UC END# *4F7957C203E7_47877EB202FB_var*
begin
//#UC START# *4F7957C203E7_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4F7957C203E7_47877EB202FB_impl*
end;//GetClassName

procedure Trim;
//#UC START# *4FACFFF103DB_47877EB202FB_var*
//#UC END# *4FACFFF103DB_47877EB202FB_var*
begin
//#UC START# *4FACFFF103DB_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *4FACFFF103DB_47877EB202FB_impl*
end;//Trim

procedure AnsiStrLIComp;
//#UC START# *50195DC90360_47877EB202FB_var*
//#UC END# *50195DC90360_47877EB202FB_var*
begin
//#UC START# *50195DC90360_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *50195DC90360_47877EB202FB_impl*
end;//AnsiStrLIComp

procedure RenameFile;
//#UC START# *509116F601C3_47877EB202FB_var*
//#UC END# *509116F601C3_47877EB202FB_var*
begin
//#UC START# *509116F601C3_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *509116F601C3_47877EB202FB_impl*
end;//RenameFile

procedure DeleteFile;
//#UC START# *5091520A024F_47877EB202FB_var*
//#UC END# *5091520A024F_47877EB202FB_var*
begin
//#UC START# *5091520A024F_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5091520A024F_47877EB202FB_impl*
end;//DeleteFile

procedure StrToIntDef;
//#UC START# *51D299D903CE_47877EB202FB_var*
//#UC END# *51D299D903CE_47877EB202FB_var*
begin
//#UC START# *51D299D903CE_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *51D299D903CE_47877EB202FB_impl*
end;//StrToIntDef

procedure FormatDateTime;
//#UC START# *52F8DC08020F_47877EB202FB_var*
//#UC END# *52F8DC08020F_47877EB202FB_var*
begin
//#UC START# *52F8DC08020F_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8DC08020F_47877EB202FB_impl*
end;//FormatDateTime

procedure Sleep;
//#UC START# *52F8EEFA01C4_47877EB202FB_var*
//#UC END# *52F8EEFA01C4_47877EB202FB_var*
begin
//#UC START# *52F8EEFA01C4_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *52F8EEFA01C4_47877EB202FB_impl*
end;//Sleep

procedure ForceDirectories;
//#UC START# *549A76510063_47877EB202FB_var*
//#UC END# *549A76510063_47877EB202FB_var*
begin
//#UC START# *549A76510063_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *549A76510063_47877EB202FB_impl*
end;//ForceDirectories

procedure IntToHex;
//#UC START# *5511283A02C9_47877EB202FB_var*
//#UC END# *5511283A02C9_47877EB202FB_var*
begin
//#UC START# *5511283A02C9_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5511283A02C9_47877EB202FB_impl*
end;//IntToHex

procedure AllocMem;
//#UC START# *5559A8820011_47877EB202FB_var*
//#UC END# *5559A8820011_47877EB202FB_var*
begin
//#UC START# *5559A8820011_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5559A8820011_47877EB202FB_impl*
end;//AllocMem

procedure CompareMem;
//#UC START# *5721C96F0083_47877EB202FB_var*
//#UC END# *5721C96F0083_47877EB202FB_var*
begin
//#UC START# *5721C96F0083_47877EB202FB_impl*
 !!! Needs to be implemented !!!
//#UC END# *5721C96F0083_47877EB202FB_impl*
end;//CompareMem

function Supports(const Instance: IUnknown;
 const IID: TGUID;
 out Intf): Boolean;
//#UC START# *47877EF503B1_47877EB202FB_var*
//#UC END# *47877EF503B1_47877EB202FB_var*
begin
//#UC START# *47877EF503B1_47877EB202FB_impl*
 assert(false, 'Supports not implemented');
//#UC END# *47877EF503B1_47877EB202FB_impl*
end;//Supports

initialization
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(Exception));
 {* Регистрация типа Exception }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(@tfw_tiClassRef);
 {* Регистрация типа ExceptClass }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EOSError));
 {* Регистрация типа EOSError }
{$IfEnd} // NOT Defined(NoScripts)
{$If NOT Defined(NoScripts)}
 TtfwTypeRegistrator.RegisterType(TypeInfo(EAssertionFailed));
 {* Регистрация типа EAssertionFailed }
{$IfEnd} // NOT Defined(NoScripts)

end.
