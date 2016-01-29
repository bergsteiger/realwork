unit ItfwKeywordFinderWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "ScriptEngine$Axiomatics"
// ������: "ItfwKeywordFinderWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: ScriptKeywordsPack::Class Shared Delphi Low Level::ScriptEngine$Axiomatics::Basics::ItfwKeywordFinderWordsPack
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

{$Include ..\ScriptEngine\seDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  l3Interfaces,
  tfwScriptingInterfaces,
  tfwClassLike,
  tfwPropertyLike
  ;

{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwPopKeywordFinderKeywordByName = {final scriptword} class(TtfwClassLike)
  {* ����� ������� pop:KeywordFinder:KeywordByName
*��� ����������:* TtfwKeyWord
*������:*
[code]
OBJECT VAR l_TtfwKeyWord
 aName aKeywordFinder pop:KeywordFinder:KeywordByName >>> l_TtfwKeyWord
[code]  }
 private
 // private methods
   function KeywordByName(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder;
    const aName: Il3CString): TtfwKeyWord;
     {* ���������� ����� ������� pop:KeywordFinder:KeywordByName }
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
 end;//TkwPopKeywordFinderKeywordByName

// start class TkwPopKeywordFinderKeywordByName

function TkwPopKeywordFinderKeywordByName.KeywordByName(const aCtx: TtfwContext;
  aKeywordFinder: TtfwKeywordFinder;
  const aName: Il3CString): TtfwKeyWord;
//#UC START# *4BB40DD9D18E_D73628563892_var*
//#UC END# *4BB40DD9D18E_D73628563892_var*
begin
//#UC START# *4BB40DD9D18E_D73628563892_impl*
 Result := TtfwKeyWord(aKeywordFinder.KeywordByName(aName));
//#UC END# *4BB40DD9D18E_D73628563892_impl*
end;//TkwPopKeywordFinderKeywordByName.KeywordByName

procedure TkwPopKeywordFinderKeywordByName.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aKeywordFinder : TtfwKeywordFinder;
 l_aName : Il3CString;
begin
 try
  l_aKeywordFinder := TtfwKeywordFinder(aCtx.rEngine.PopObjAs(TtfwKeywordFinder));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_aName := aCtx.rEngine.PopString;
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aName: Il3CString : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((KeywordByName(aCtx, l_aKeywordFinder, l_aName)));
end;//TkwPopKeywordFinderKeywordByName.DoDoIt

class function TkwPopKeywordFinderKeywordByName.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:KeywordFinder:KeywordByName';
end;//TkwPopKeywordFinderKeywordByName.GetWordNameForRegister

function TkwPopKeywordFinderKeywordByName.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeyWord);
end;//TkwPopKeywordFinderKeywordByName.GetResultTypeInfo

function TkwPopKeywordFinderKeywordByName.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 1 + 1;
end;//TkwPopKeywordFinderKeywordByName.GetAllParamsCount

function TkwPopKeywordFinderKeywordByName.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder), @tfw_tiString]);
end;//TkwPopKeywordFinderKeywordByName.ParamsTypes

type
 TkwPopKeywordFinderParentFinder = {final scriptword} class(TtfwPropertyLike)
  {* ����� ������� pop:KeywordFinder:ParentFinder
*��� ����������:* TtfwKeywordFinder
*������:*
[code]
OBJECT VAR l_TtfwKeywordFinder
 aKeywordFinder pop:KeywordFinder:ParentFinder >>> l_TtfwKeywordFinder
[code]  }
 private
 // private methods
   function ParentFinder(const aCtx: TtfwContext;
    aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
     {* ���������� ����� ������� pop:KeywordFinder:ParentFinder }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   procedure SetValuePrim(const aValue: TtfwStackValue;
     const aCtx: TtfwContext); override;
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwPopKeywordFinderParentFinder

// start class TkwPopKeywordFinderParentFinder

function TkwPopKeywordFinderParentFinder.ParentFinder(const aCtx: TtfwContext;
  aKeywordFinder: TtfwKeywordFinder): TtfwKeywordFinder;
//#UC START# *3D8B4028DC71_F60851FE16E3_var*
//#UC END# *3D8B4028DC71_F60851FE16E3_var*
begin
//#UC START# *3D8B4028DC71_F60851FE16E3_impl*
 Result := aKeywordFinder.ParentFinder;
//#UC END# *3D8B4028DC71_F60851FE16E3_impl*
end;//TkwPopKeywordFinderParentFinder.ParentFinder

procedure TkwPopKeywordFinderParentFinder.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aKeywordFinder : TtfwKeywordFinder;
begin
 try
  l_aKeywordFinder := TtfwKeywordFinder(aCtx.rEngine.PopObjAs(TtfwKeywordFinder));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aKeywordFinder: TtfwKeywordFinder : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushObj((ParentFinder(aCtx, l_aKeywordFinder)));
end;//TkwPopKeywordFinderParentFinder.DoDoIt

class function TkwPopKeywordFinderParentFinder.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'pop:KeywordFinder:ParentFinder';
end;//TkwPopKeywordFinderParentFinder.GetWordNameForRegister

procedure TkwPopKeywordFinderParentFinder.SetValuePrim(const aValue: TtfwStackValue;
  const aCtx: TtfwContext);
 {-}
begin
 RunnerError('������ ����������� �������� readonly �������� ParentFinder', aCtx);
end;//TkwPopKeywordFinderParentFinder.SetValuePrim

function TkwPopKeywordFinderParentFinder.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := TypeInfo(TtfwKeywordFinder);
end;//TkwPopKeywordFinderParentFinder.GetResultTypeInfo

function TkwPopKeywordFinderParentFinder.GetAllParamsCount(const aCtx: TtfwContext): Integer;
 {-}
begin
 Result := 0 + 1;
end;//TkwPopKeywordFinderParentFinder.GetAllParamsCount

function TkwPopKeywordFinderParentFinder.ParamsTypes: PTypeInfoArray;
 {-}
begin
 Result := OpenTypesToTypes([TypeInfo(TtfwKeywordFinder)]);
end;//TkwPopKeywordFinderParentFinder.ParamsTypes
{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� pop_KeywordFinder_KeywordByName
 TkwPopKeywordFinderKeywordByName.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� pop_KeywordFinder_ParentFinder
 TkwPopKeywordFinderParentFinder.RegisterInEngine;
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeywordFinder
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeywordFinder));
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� Il3CString
 TtfwTypeRegistrator.RegisterType(@tfw_tiString);
{$IfEnd} //not NoScripts
{$If not defined(NoScripts)}
// ����������� ���� TtfwKeyWord
 TtfwTypeRegistrator.RegisterType(TypeInfo(TtfwKeyWord));
{$IfEnd} //not NoScripts

end.