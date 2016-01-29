unit kwAttributeSearch;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "F1 Words"
// �����: ����� �.�.
// ������: "w:/garant6x/implementation/Garant/GbaNemesis/F1_Words/kwAttributeSearch.pas"
// �����: 20.04.2011 20:15
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeyword::Class>> F1 ��������� ������::F1 Words::Words::AttributeSearch
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\garant6x\implementation\Garant\GbaNemesis\nsDefine.inc}

interface

{$If not defined(NoScripts)}
uses
  tfwRegisterableWord,
  tfwScriptingInterfaces
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}
type
 _F1Test_Parent_ = TtfwRegisterableWord;
 {$Include ..\F1_Words\F1Test.imp.pas}
 TkwAttributeSearch = {scriptword} class(_F1Test_)
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 end;//TkwAttributeSearch
{$IfEnd} //not NoScripts

implementation

{$If not defined(NoScripts)}
uses
  Classes
  {$If not defined(NoVCM)}
  ,
  StdRes
  {$IfEnd} //not NoVCM
  
  {$If not defined(Admin)}
  ,
  nsQueryInterfaces
  {$IfEnd} //not Admin
  
  {$If not defined(NoVCM)}
  ,
  OfficeLike_Result_Controls
  {$IfEnd} //not NoVCM
  ,
  nsUtils,
  nsConst,
  bsTypesNew
  ;
{$IfEnd} //not NoScripts

{$If not defined(NoScripts)}

{$Include ..\F1_Words\F1Test.imp.pas}

// start class TkwAttributeSearch

procedure TkwAttributeSearch.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_4DAF069D0072_var*
//#UC END# *4DAEEDE10285_4DAF069D0072_var*
begin
//#UC START# *4DAEEDE10285_4DAF069D0072_impl*
 TdmStdRes.OpenQuery(lg_qtAttribute, nil, nil);
//#UC END# *4DAEEDE10285_4DAF069D0072_impl*
end;//TkwAttributeSearch.DoDoIt

class function TkwAttributeSearch.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := '���_Prim';
end;//TkwAttributeSearch.GetWordNameForRegister

{$IfEnd} //not NoScripts

initialization
{$If not defined(NoScripts)}
// ����������� AttributeSearch
 TkwAttributeSearch.RegisterInEngine;
{$IfEnd} //not NoScripts

end.