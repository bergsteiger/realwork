unit PictureEtalonsWorkingPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$L3"
// ������: "PictureEtalonsWorkingPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$L3::PictureEtalonsWorking::PictureEtalonsWorkingPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwScriptingInterfaces,
  tfwGlobalKeyWord
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  l3PicturePathService,
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwEnabledSaveRTFPictures = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� EnabledSaveRTFPictures
[panel]�������� ����� ���������� �������� ��� ������� �� RTF/DOC/DOCX. ����� �������� ����� ������ �������� �� RTF, �.�.���� ������������.[panel]
*������:*
[code]
 EnabledSaveRTFPictures
[code]  }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEnabledSaveRTFPictures

// start class TkwEnabledSaveRTFPictures

procedure TkwEnabledSaveRTFPictures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0624C398EE8C_var*
//#UC END# *4DAEEDE10285_0624C398EE8C_var*
begin
//#UC START# *4DAEEDE10285_0624C398EE8C_impl*
 Tl3PicturePathService.Instance.SetEnableSave(true);
//#UC END# *4DAEEDE10285_0624C398EE8C_impl*
end;//TkwEnabledSaveRTFPictures.DoDoIt

class function TkwEnabledSaveRTFPictures.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'EnabledSaveRTFPictures';
end;//TkwEnabledSaveRTFPictures.GetWordNameForRegister

function TkwEnabledSaveRTFPictures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwEnabledSaveRTFPictures.GetResultTypeInfo

function TkwEnabledSaveRTFPictures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0;
end;//TkwEnabledSaveRTFPictures.GetAllParamsCount

type
 TkwGeneratePDFForEtalon = {final scriptword} class(TtfwGlobalKeyWord)
  {* ����� ������� GeneratePDFForEtalon
[panel]*������*:
[code]
aFlag GeneratePDFForEtalon
[code]
��� aFlag - true ��� false.
��������/��������� ����� ��������� ���������� PDF, ������� ������ ������������ ��� ���������. ����� ���������� ��� ������ ��������, �.�.���� ������������ � False.[panel]
*������:*
[code]
 aValue GeneratePDFForEtalon
[code]  }
 private
 // private methods
   procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
    aValue: Boolean);
     {* ���������� ����� ������� GeneratePDFForEtalon }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratePDFForEtalon

// start class TkwGeneratePDFForEtalon

procedure TkwGeneratePDFForEtalon.GeneratePDFForEtalon(const aCtx: TtfwContext;
  aValue: Boolean);
//#UC START# *03229B3839D8_8682318410BD_var*
//#UC END# *03229B3839D8_8682318410BD_var*
begin
//#UC START# *03229B3839D8_8682318410BD_impl*
 Tl3PicturePathService.Instance.SetPDF4Etalon(aValue);
//#UC END# *03229B3839D8_8682318410BD_impl*
end;//TkwGeneratePDFForEtalon.GeneratePDFForEtalon

procedure TkwGeneratePDFForEtalon.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aValue : Boolean;
begin
 try
  l_aValue := aCtx.rEngine.PopBool;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aValue: Boolean : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 GeneratePDFForEtalon(aCtx, l_aValue);
end;//TkwGeneratePDFForEtalon.DoDoIt

class function TkwGeneratePDFForEtalon.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'GeneratePDFForEtalon';
end;//TkwGeneratePDFForEtalon.GetWordNameForRegister

function TkwGeneratePDFForEtalon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwGeneratePDFForEtalon.GetResultTypeInfo

function TkwGeneratePDFForEtalon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1;
end;//TkwGeneratePDFForEtalon.GetAllParamsCount

function TkwGeneratePDFForEtalon.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwGeneratePDFForEtalon.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� EnabledSaveRTFPictures
 TkwEnabledSaveRTFPictures.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� GeneratePDFForEtalon
 TkwGeneratePDFForEtalon.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Boolean
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
{$IfEnd} //not NoScripts

end.