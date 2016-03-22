unit ItfwKeywordFinderWordsPack;

// ������: "w:\common\components\rtl\Garant\ScriptEngine\ItfwKeywordFinderWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "ItfwKeywordFinderWordsPack" MUID: (559BCED301F0)

{$Include w:\common\components\rtl\Garant\ScriptEngine\seDefine.inc}

interface

{$If NOT Defined(NoScripts)}
uses
 l3IntfUses
 , tfwScriptingInterfaces
;
{$IfEnd} // NOT Defined(NoScripts)

implementation

{$If NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwClassLike
 , l3Interfaces
 , TypInfo
 , tfwPropertyLike
 , tfwTypeInfo
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 TkwPopKeywordFinderKeywordByName = {final} class(TtfwClassLike)
  {* ����� ������� pop:KeywordFinder:KeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aKeywordFinder pop:KeywordFinder:KeywordByName >>> l_TtfwKeyWord
[code]  }
  private
   function KeywordByName(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder;
    const aName: Il3CString): TtfwKeyWord;
    {* ���������� ����� ������� pop:KeywordFinder:KeywordByName }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderKeywordByName

 TkwPopKeywordFinderParentFinder = {final} class(TtfwPropertyLike)
  {* ����� ������� pop:KeywordFinder:ParentFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aKeywordFinder pop:KeywordFinder:ParentFinder >>> l_TtfwKeywordFinder
[code]  }
  private
   function ParentFinder(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
    {* ���������� ����� ������� pop:KeywordFinder:ParentFinder }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   procedure SetValuePrim(const aValue: TtfwStackValue;
    const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderParentFinder

function TkwPopKeywordFinderKeywordByName.KeywordByName(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder;
 const aName: Il3CString): TtfwKeyWord;
 {* ���������� ����� ������� pop:KeywordFinder:KeywordByName }
//#UC START# *4BB40DD9D18E_D73628563892_var*
//#UC END# *4BB40DD9D18E_D73628563892_var*
begin
//#UC START# *4BB40DD9D18E_D73628563892_impl*
 Result := TtfwKeyWord(aKeywordFinder.KeywordByName(aName));
//#UC END# *4BB40DD9D18E_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.KeywordByName

procedure TkwPopKeywordFinderKeywordByName.DoDoIt(const aCtx: TtfwContext);
var l_aKeywordFinder: TtfwKeywordFinder;
var l_aName: Il3CString;
begin
 try
  l_aKeywordFinder := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := Il3CString(aCtx.rEngine.PopString);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(KeywordByName(aCtx, l_aKeywordFinder, l_aName));
end;//TkwPopKeywordFinderKeywordByName.DoDoIt

function TkwPopKeywordFinderKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopKeywordFinderKeywordByName.GetResultTypeInfo

function TkwPopKeywordFinderKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwPopKeywordFinderKeywordByName.GetAllParamsCount

function TkwPopKeywordFinderKeywordByName.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder), @tfw_tiString]);
end;//TkwPopKeywordFinderKeywordByName.ParamsTypes

class function TkwPopKeywordFinderKeywordByName.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:KeywordByName';
end;//TkwPopKeywordFinderKeywordByName.GetWordNameForRegister

function TkwPopKeywordFinderParentFinder.ParentFinder(const aCtx: TtfwContext;
 aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
 {* ���������� ����� ������� pop:KeywordFinder:ParentFinder }
//#UC START# *3D8B4028DC71_F60851FE16E3_var*
//#UC END# *3D8B4028DC71_F60851FE16E3_var*
begin
//#UC START# *3D8B4028DC71_F60851FE16E3_impl*
 Result := aKeywordFinder.ParentFinder;
//#UC END# *3D8B4028DC71_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.ParentFinder

procedure TkwPopKeywordFinderParentFinder.DoDoIt(const aCtx: TtfwContext);
var l_aKeywordFinder: TtfwKeywordFinder;
begin
 try
  l_aKeywordFinder := TtfwWord(aCtx.rEngine.PopObjAs(TtfwWord));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj(ParentFinder(aCtx, l_aKeywordFinder));
end;//TkwPopKeywordFinderParentFinder.DoDoIt

procedure TkwPopKeywordFinderParentFinder.SetValuePrim(const aValue: TtfwStackValue;
 const aCtx: TtfwContext);
begin
 RunnerError('������ ����������� �������� readonly �������� ParentFinder', aCtx);
end;//TkwPopKeywordFinderParentFinder.SetValuePrim

function TkwPopKeywordFinderParentFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopKeywordFinderParentFinder.GetResultTypeInfo

function TkwPopKeywordFinderParentFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwPopKeywordFinderParentFinder.GetAllParamsCount

function TkwPopKeywordFinderParentFinder.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder)]);
end;//TkwPopKeywordFinderParentFinder.ParamsTypes

class function TkwPopKeywordFinderParentFinder.GetWordNameForRegister: AnsiString;
begin
 Result := 'pop:KeywordFinder:ParentFinder';
end;//TkwPopKeywordFinderParentFinder.GetWordNameForRegister

initialization
 TkwPopKeywordFinderKeywordByName.RegisterInEngine;
 {* ����������� pop_KeywordFinder_KeywordByName }
 TkwPopKeywordFinderParentFinder.RegisterInEngine;
 {* ����������� pop_KeywordFinder_ParentFinder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
 {* ����������� ���� TtfwKeywordFinder }
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
 {* ����������� ���� Il3CString }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
 {* ����������� ���� TtfwKeyWord }
{$IfEnd} // NOT Defined(NoScripts)

end.
