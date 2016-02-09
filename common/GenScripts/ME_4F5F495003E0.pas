unit EtalonsWorkingPack;

// Модуль: "w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas"
// Стереотип: "ScriptKeywordsPack"

{$Include seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwGlobalKeyWord
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , kwCheckOutputWithInput
 , kwCheckEtalon
 , kwTestResolveInputFilePath
 , l3EtalonsService
 , tfwScriptingTypes
 , SysUtils
;

type
 TkwEtalonNeeds64 = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeeds64
*Пример:*
[code]
 EtalonNeeds64
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEtalonNeeds64

 TkwEtalonNeedsComputerName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsComputerName
*Пример:*
[code]
 EtalonNeedsComputerName
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEtalonNeedsComputerName

 TkwEtalonNeedsOSName = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsOSName
*Пример:*
[code]
 EtalonNeedsOSName
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEtalonNeedsOSName

 TkwEtalonNeedsXE = {final} class(TtfwGlobalKeyWord)
  {* Слово скрипта EtalonNeedsXE
*Пример:*
[code]
 EtalonNeedsXE
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEtalonNeedsXE

procedure TkwEtalonNeeds64.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_60A242C872F7_var*
//#UC END# *4DAEEDE10285_60A242C872F7_var*
begin
//#UC START# *4DAEEDE10285_60A242C872F7_impl*
 Tl3EtalonsService.Instance.EtalonNeeds64 := true; 
//#UC END# *4DAEEDE10285_60A242C872F7_impl*
end;//TkwEtalonNeeds64.DoDoIt

class function TkwEtalonNeeds64.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeeds64';
end;//TkwEtalonNeeds64.GetWordNameForRegister

function TkwEtalonNeeds64.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_60A242C872F7_var*
//#UC END# *551544E2001A_60A242C872F7_var*
begin
//#UC START# *551544E2001A_60A242C872F7_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_60A242C872F7_impl*
end;//TkwEtalonNeeds64.GetResultTypeInfo

function TkwEtalonNeeds64.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEtalonNeeds64.GetAllParamsCount

procedure TkwEtalonNeedsComputerName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_116A432ADCB1_var*
//#UC END# *4DAEEDE10285_116A432ADCB1_var*
begin
//#UC START# *4DAEEDE10285_116A432ADCB1_impl*
 Tl3EtalonsService.Instance.EtalonNeedsComputerName := true;
//#UC END# *4DAEEDE10285_116A432ADCB1_impl*
end;//TkwEtalonNeedsComputerName.DoDoIt

class function TkwEtalonNeedsComputerName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsComputerName';
end;//TkwEtalonNeedsComputerName.GetWordNameForRegister

function TkwEtalonNeedsComputerName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_116A432ADCB1_var*
//#UC END# *551544E2001A_116A432ADCB1_var*
begin
//#UC START# *551544E2001A_116A432ADCB1_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_116A432ADCB1_impl*
end;//TkwEtalonNeedsComputerName.GetResultTypeInfo

function TkwEtalonNeedsComputerName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEtalonNeedsComputerName.GetAllParamsCount

procedure TkwEtalonNeedsOSName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A371D758055_var*
//#UC END# *4DAEEDE10285_4A371D758055_var*
begin
//#UC START# *4DAEEDE10285_4A371D758055_impl*
 Tl3EtalonsService.Instance.EtalonNeedsOSName := true;
//#UC END# *4DAEEDE10285_4A371D758055_impl*
end;//TkwEtalonNeedsOSName.DoDoIt

class function TkwEtalonNeedsOSName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsOSName';
end;//TkwEtalonNeedsOSName.GetWordNameForRegister

function TkwEtalonNeedsOSName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_4A371D758055_var*
//#UC END# *551544E2001A_4A371D758055_var*
begin
//#UC START# *551544E2001A_4A371D758055_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_4A371D758055_impl*
end;//TkwEtalonNeedsOSName.GetResultTypeInfo

function TkwEtalonNeedsOSName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEtalonNeedsOSName.GetAllParamsCount

procedure TkwEtalonNeedsXE.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_DECF86D5A261_var*
//#UC END# *4DAEEDE10285_DECF86D5A261_var*
begin
//#UC START# *4DAEEDE10285_DECF86D5A261_impl*
 {$IfDef XE}
 Tl3EtalonsService.Instance.EtalonNeedsXE := true;
 {$EndIf XE}
//#UC END# *4DAEEDE10285_DECF86D5A261_impl*
end;//TkwEtalonNeedsXE.DoDoIt

class function TkwEtalonNeedsXE.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsXE';
end;//TkwEtalonNeedsXE.GetWordNameForRegister

function TkwEtalonNeedsXE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
//#UC START# *551544E2001A_DECF86D5A261_var*
//#UC END# *551544E2001A_DECF86D5A261_var*
begin
//#UC START# *551544E2001A_DECF86D5A261_impl*
 !!! Needs to be implemented !!!
//#UC END# *551544E2001A_DECF86D5A261_impl*
end;//TkwEtalonNeedsXE.GetResultTypeInfo

function TkwEtalonNeedsXE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwEtalonNeedsXE.GetAllParamsCount

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
