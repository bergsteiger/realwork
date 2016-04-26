unit EtalonsWorkingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\EtalonsWorkingPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "EtalonsWorkingPack" MUID: (4F5F495003E0)

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
 , tfwScriptingInterfaces
 , TypInfo
 , kwCheckOutputWithInput
 , kwCheckEtalon
 , kwTestResolveInputFilePath
 , l3EtalonsService
 , SysUtils
 , tfwTypeRegistrator
 , tfwScriptingTypes
;

type
 TkwEtalonNeeds64 = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� EtalonNeeds64
*������:*
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
  {* ����� ������� EtalonNeedsComputerName
*������:*
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
  {* ����� ������� EtalonNeedsOSName
*������:*
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
  {* ����� ������� EtalonNeedsXE
*������:*
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

function TkwEtalonNeeds64.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeeds64.GetResultTypeInfo

function TkwEtalonNeeds64.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeeds64.GetAllParamsCount

class function TkwEtalonNeeds64.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeeds64';
end;//TkwEtalonNeeds64.GetWordNameForRegister

procedure TkwEtalonNeedsComputerName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_116A432ADCB1_var*
//#UC END# *4DAEEDE10285_116A432ADCB1_var*
begin
//#UC START# *4DAEEDE10285_116A432ADCB1_impl*
 Tl3EtalonsService.Instance.EtalonNeedsComputerName := true;
//#UC END# *4DAEEDE10285_116A432ADCB1_impl*
end;//TkwEtalonNeedsComputerName.DoDoIt

function TkwEtalonNeedsComputerName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsComputerName.GetResultTypeInfo

function TkwEtalonNeedsComputerName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsComputerName.GetAllParamsCount

class function TkwEtalonNeedsComputerName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsComputerName';
end;//TkwEtalonNeedsComputerName.GetWordNameForRegister

procedure TkwEtalonNeedsOSName.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4A371D758055_var*
//#UC END# *4DAEEDE10285_4A371D758055_var*
begin
//#UC START# *4DAEEDE10285_4A371D758055_impl*
 Tl3EtalonsService.Instance.EtalonNeedsOSName := true;
//#UC END# *4DAEEDE10285_4A371D758055_impl*
end;//TkwEtalonNeedsOSName.DoDoIt

function TkwEtalonNeedsOSName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsOSName.GetResultTypeInfo

function TkwEtalonNeedsOSName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsOSName.GetAllParamsCount

class function TkwEtalonNeedsOSName.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsOSName';
end;//TkwEtalonNeedsOSName.GetWordNameForRegister

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

function TkwEtalonNeedsXE.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEtalonNeedsXE.GetResultTypeInfo

function TkwEtalonNeedsXE.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEtalonNeedsXE.GetAllParamsCount

class function TkwEtalonNeedsXE.GetWordNameForRegister: AnsiString;
begin
 Result := 'EtalonNeedsXE';
end;//TkwEtalonNeedsXE.GetWordNameForRegister

initialization
 TkwEtalonNeeds64.RegisterInEngine;
 {* ����������� EtalonNeeds64 }
 TkwEtalonNeedsComputerName.RegisterInEngine;
 {* ����������� EtalonNeedsComputerName }
 TkwEtalonNeedsOSName.RegisterInEngine;
 {* ����������� EtalonNeedsOSName }
 TkwEtalonNeedsXE.RegisterInEngine;
 {* ����������� EtalonNeedsXE }
{$IfEnd} // NOT Defined(NoScripts)

end.
