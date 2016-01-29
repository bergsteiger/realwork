unit AttributeExplorerWordsPack;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// ���������� "Archi Insider Test Support"
// ������: "w:/archi/source/projects/Archi/Archi_Insider_Test_Support/AttributeExplorerWordsPack.pas"
// ������ Delphi ���������� (.pas)
// Generated from UML model, root element: <<ScriptKeywordsPack::Class>> archi$TestSupport::Archi Insider Test Support::CommonArchiWords::AttributeExplorerWordsPack
//
//
// ��� ����� ����������� ��� ��� "������-������".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! ��������� ������������ � ������. ������� ������ - ������. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  dt_AttrSchema,
  tfwScriptingInterfaces,
  F_AttrExplorer,
  tfwRegisterableWord
  ;

{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

implementation

{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
uses
  tfwScriptingTypes,
  TypInfo,
  SysUtils,
  tfwTypeRegistrator
  ;

type
 TkwAttrExplorerGotoOnAttrNode = {final scriptword} class(TtfwRegisterableWord)
  {* ����� ������� AttrExplorer:GotoOnAttrNode
[panel]������: aNumberAttribute aControl AttributeExplorer:GotoOnAttrNode
��� aNumberAttribute - ����� ��������, � aControl - ����� TAttrExplorer.
������:
[code]
TdtAttribute::atKeyWords "������� �� ����� [('otlAttributes')]- � ����" pop:Component:Owner AttributeExplorer:GotoOnAttrNode
[code][panel]
*������:*
[code]
 anAttrID aAttrExplorer AttrExplorer:GotoOnAttrNode
[code]  }
 private
 // private methods
   procedure GotoOnAttrNode(const aCtx: TtfwContext;
    aAttrExplorer: TAttrExplorer;
    anAttrID: TdtAttribute);
     {* ���������� ����� ������� AttrExplorer:GotoOnAttrNode }
 protected
 // realized methods
   procedure DoDoIt(const aCtx: TtfwContext); override;
 protected
 // overridden protected methods
   class function GetWordNameForRegister: AnsiString; override;
 public
 // overridden public methods
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
 end;//TkwAttrExplorerGotoOnAttrNode

// start class TkwAttrExplorerGotoOnAttrNode

procedure TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode(const aCtx: TtfwContext;
  aAttrExplorer: TAttrExplorer;
  anAttrID: TdtAttribute);
//#UC START# *986AD64514D6_50112451BECA_var*
//#UC END# *986AD64514D6_50112451BECA_var*
begin
//#UC START# *986AD64514D6_50112451BECA_impl*
 aAttrExplorer.GotoOnAttrNode(anAttrID);
//#UC END# *986AD64514D6_50112451BECA_impl*
end;//TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode

procedure TkwAttrExplorerGotoOnAttrNode.DoDoIt(const aCtx: TtfwContext);
 {-}
var
 l_aAttrExplorer : TAttrExplorer;
 l_anAttrID : TdtAttribute;
begin
 try
  l_aAttrExplorer := TAttrExplorer(aCtx.rEngine.PopObjAs(TAttrExplorer));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aAttrExplorer: TAttrExplorer : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 try
  l_anAttrID := TdtAttribute(aCtx.rEngine.PopInt);
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� anAttrID: TdtAttribute : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 GotoOnAttrNode(aCtx, l_aAttrExplorer, l_anAttrID);
end;//TkwAttrExplorerGotoOnAttrNode.DoDoIt

class function TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister: AnsiString;
 {-}
begin
 Result := 'AttrExplorer:GotoOnAttrNode';
end;//TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister

function TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
 {-}
begin
 Result := @tfw_tiVoid;
end;//TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

initialization
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� AttrExplorer_GotoOnAttrNode
 TkwAttrExplorerGotoOnAttrNode.RegisterInEngine;
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� ���� TtfwContext
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� ���� TAttrExplorer
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttrExplorer));
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts
{$If defined(AppClientSide) AND defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
// ����������� ���� TdtAttribute
 TtfwTypeRegistrator.RegisterType(TypeInfo(TdtAttribute));
{$IfEnd} //AppClientSide AND InsiderTest AND nsTest AND not NoScripts

end.