unit PictureEtalonsWorkingPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\PictureEtalonsWorkingPack.pas"
// ���������: "ScriptKeywordsPack"

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
 , l3PicturePathService
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwEnabledSaveRTFPictures = {final} class(TtfwGlobalKeyWord)
  {* ����� ������� EnabledSaveRTFPictures
[panel]�������� ����� ���������� �������� ��� ������� �� RTF/DOC/DOCX. ����� �������� ����� ������ �������� �� RTF, �.�.���� ������������.[panel]
*������:*
[code]
 EnabledSaveRTFPictures
[code]  }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
 end;//TkwEnabledSaveRTFPictures

 TkwGeneratePDFForEtalon = {final} class(TtfwGlobalKeyWord)
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
   procedure GeneratePDFForEtalon(const aCtx: TtfwContext;
    aValue: Boolean);
    {* ���������� ����� ������� GeneratePDFForEtalon }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwGeneratePDFForEtalon

procedure TkwEnabledSaveRTFPictures.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_0624C398EE8C_var*
//#UC END# *4DAEEDE10285_0624C398EE8C_var*
begin
//#UC START# *4DAEEDE10285_0624C398EE8C_impl*
 Tl3PicturePathService.Instance.SetEnableSave(true);
//#UC END# *4DAEEDE10285_0624C398EE8C_impl*
end;//TkwEnabledSaveRTFPictures.DoDoIt

class function TkwEnabledSaveRTFPictures.GetWordNameForRegister: AnsiString;
begin
 Result := 'EnabledSaveRTFPictures';
end;//TkwEnabledSaveRTFPictures.GetWordNameForRegister

function TkwEnabledSaveRTFPictures.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwEnabledSaveRTFPictures.GetResultTypeInfo

function TkwEnabledSaveRTFPictures.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 0;
end;//TkwEnabledSaveRTFPictures.GetAllParamsCount

procedure TkwGeneratePDFForEtalon.GeneratePDFForEtalon(const aCtx: TtfwContext;
 aValue: Boolean);
 {* ���������� ����� ������� GeneratePDFForEtalon }
//#UC START# *03229B3839D8_8682318410BD_var*
//#UC END# *03229B3839D8_8682318410BD_var*
begin
//#UC START# *03229B3839D8_8682318410BD_impl*
 Tl3PicturePathService.Instance.SetPDF4Etalon(aValue);
//#UC END# *03229B3839D8_8682318410BD_impl*
end;//TkwGeneratePDFForEtalon.GeneratePDFForEtalon

procedure TkwGeneratePDFForEtalon.DoDoIt(const aCtx: TtfwContext);
var l_aValue: Boolean;
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
begin
 Result := 'GeneratePDFForEtalon';
end;//TkwGeneratePDFForEtalon.GetWordNameForRegister

function TkwGeneratePDFForEtalon.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwGeneratePDFForEtalon.GetResultTypeInfo

function TkwGeneratePDFForEtalon.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwGeneratePDFForEtalon.GetAllParamsCount

function TkwGeneratePDFForEtalon.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(Boolean)]);
end;//TkwGeneratePDFForEtalon.ParamsTypes

initialization
 TkwEnabledSaveRTFPictures.RegisterInEngine;
 {* ����������� EnabledSaveRTFPictures }
 TkwGeneratePDFForEtalon.RegisterInEngine;
 {* ����������� GeneratePDFForEtalon }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // NOT Defined(NoScripts)

end.
