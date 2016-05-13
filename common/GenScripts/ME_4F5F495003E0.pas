unit EtalonsWorkingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas"
// Стереотип: "ScriptKeywordsPack"
// Элемент модели: "EtalonsWorkingPack" MUID: (4F5F495003E0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwGlobalKeyWord
 , TypInfo
 , tfwScriptingInterfaces
 , kwCheckOutputWithInput
 , kwCheckEtalon
 , kwTestResolveInputFilePath
 , l3EtalonsService
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwEtalonNeeds64 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeeds64 }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEtalonNeeds64

 TkwEtalonNeedsComputerName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsComputerName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEtalonNeedsComputerName

 TkwEtalonNeedsOSName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsOSName }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEtalonNeedsOSName

 TkwEtalonNeedsXE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsXE }
  protected
   class function GetWordNameForRegister: AnsiString; override;
   procedure DoDoIt(const aCtx: TtfwContext); override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwEtalonNeedsXE

class function TkwEtalonNeeds64.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeeds64';
end;//TkwEtalonNeeds64.GetWordNameForRegister

function TkwEtalonNeeds64.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeeds64.GetResultTypeInfo

function TkwEtalonNeeds64.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeeds64.GetAllParamsCount

function TkwEtalonNeeds64.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEtalonNeeds64.ParamsTypes

procedure TkwEtalonNeeds64.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F531D0312_Word_var*
//#UC END# *4DAEEDE10285_555F531D0312_Word_var*
begin
//#UC START# *4DAEEDE10285_555F531D0312_Word_impl*
 Tl3EtalonsService.Instance.EtalonNeeds64 := true; 
//#UC END# *4DAEEDE10285_555F531D0312_Word_impl*
end;//TkwEtalonNeeds64.DoDoIt

class function TkwEtalonNeedsComputerName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsComputerName';
end;//TkwEtalonNeedsComputerName.GetWordNameForRegister

function TkwEtalonNeedsComputerName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsComputerName.GetResultTypeInfo

function TkwEtalonNeedsComputerName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsComputerName.GetAllParamsCount

function TkwEtalonNeedsComputerName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEtalonNeedsComputerName.ParamsTypes

procedure TkwEtalonNeedsComputerName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F53390367_Word_var*
//#UC END# *4DAEEDE10285_555F53390367_Word_var*
begin
//#UC START# *4DAEEDE10285_555F53390367_Word_impl*
 Tl3EtalonsService.Instance.EtalonNeedsComputerName := true;
//#UC END# *4DAEEDE10285_555F53390367_Word_impl*
end;//TkwEtalonNeedsComputerName.DoDoIt

class function TkwEtalonNeedsOSName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsOSName';
end;//TkwEtalonNeedsOSName.GetWordNameForRegister

function TkwEtalonNeedsOSName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsOSName.GetResultTypeInfo

function TkwEtalonNeedsOSName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsOSName.GetAllParamsCount

function TkwEtalonNeedsOSName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEtalonNeedsOSName.ParamsTypes

procedure TkwEtalonNeedsOSName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F534D01A0_Word_var*
//#UC END# *4DAEEDE10285_555F534D01A0_Word_var*
begin
//#UC START# *4DAEEDE10285_555F534D01A0_Word_impl*
 Tl3EtalonsService.Instance.EtalonNeedsOSName := true;
//#UC END# *4DAEEDE10285_555F534D01A0_Word_impl*
end;//TkwEtalonNeedsOSName.DoDoIt

class function TkwEtalonNeedsXE.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsXE';
end;//TkwEtalonNeedsXE.GetWordNameForRegister

function TkwEtalonNeedsXE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsXE.GetResultTypeInfo

function TkwEtalonNeedsXE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsXE.GetAllParamsCount

function TkwEtalonNeedsXE.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([]);
end;//TkwEtalonNeedsXE.ParamsTypes

procedure TkwEtalonNeedsXE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_555F535F00CE_Word_var*
//#UC END# *4DAEEDE10285_555F535F00CE_Word_var*
begin
//#UC START# *4DAEEDE10285_555F535F00CE_Word_impl*
 {$IfDef XE}
 Tl3EtalonsService.Instance.EtalonNeedsXE := true;
 {$EndIf XE}
//#UC END# *4DAEEDE10285_555F535F00CE_Word_impl*
end;//TkwEtalonNeedsXE.DoDoIt

initialization
 TkwEtalonNeeds64.RegisterInEngine;
 {* Регистрация EtalonNeeds64 }
 TkwEtalonNeedsComputerName.RegisterInEngine;
 {* Регистрация EtalonNeedsComputerName }
 TkwEtalonNeedsOSName.RegisterInEngine;
 {* Регистрация EtalonNeedsOSName }
 TkwEtalonNeedsXE.RegisterInEngine;
 {* Регистрация EtalonNeedsXE }
{$IfEnd} // NOT Defined(NoScripts)

end.
