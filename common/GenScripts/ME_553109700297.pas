unit AttributeExplorerWordsPack;

// ������: "w:\archi\source\projects\Archi\Archi_Insider_Test_Support\AttributeExplorerWordsPack.pas"
// ���������: "ScriptKeywordsPack"

{$Include arDefine.inc}

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
 , F_AttrExplorer
 , dt_AttrSchema
 , tfwAxiomaticsResNameGetter
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , tfwScriptingTypes
 , tfwTypeRegistrator
 , SysUtils
;

type
 //#UC START# *83014FAE4406ci*
 //#UC END# *83014FAE4406ci*
 //#UC START# *83014FAE4406cit*
 //#UC END# *83014FAE4406cit*
 TAttributeExplorerWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 //#UC START# *83014FAE4406publ*
 //#UC END# *83014FAE4406publ*
 end;//TAttributeExplorerWordsPackResNameGetter

 TkwAttrExplorerGotoOnAttrNode = {final} class(TtfwClassLike)
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
   procedure GotoOnAttrNode(const aCtx: TtfwContext;
    aAttrExplorer: TAttrExplorer;
    anAttrID: TdtAttribute);
    {* ���������� ����� ������� AttrExplorer:GotoOnAttrNode }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwAttrExplorerGotoOnAttrNode

class function TAttributeExplorerWordsPackResNameGetter.ResName: AnsiString;
begin
  Result := 'AttributeExplorerWordsPack';
end;//TAttributeExplorerWordsPackResNameGetter.ResName

 {$R AttributeExplorerWordsPack.res}

procedure TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode(const aCtx: TtfwContext;
 aAttrExplorer: TAttrExplorer;
 anAttrID: TdtAttribute);
 {* ���������� ����� ������� AttrExplorer:GotoOnAttrNode }
//#UC START# *986AD64514D6_50112451BECA_var*
//#UC END# *986AD64514D6_50112451BECA_var*
begin
//#UC START# *986AD64514D6_50112451BECA_impl*
 aAttrExplorer.GotoOnAttrNode(anAttrID);
//#UC END# *986AD64514D6_50112451BECA_impl*
end;//TkwAttrExplorerGotoOnAttrNode.GotoOnAttrNode

procedure TkwAttrExplorerGotoOnAttrNode.DoDoIt(const aCtx: TtfwContext);
//#UC START# *4DAEEDE10285_50112451BECA_var*
//#UC END# *4DAEEDE10285_50112451BECA_var*
begin
//#UC START# *4DAEEDE10285_50112451BECA_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DAEEDE10285_50112451BECA_impl*
end;//TkwAttrExplorerGotoOnAttrNode.DoDoIt

class function TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister: AnsiString;
begin
 Result := 'AttrExplorer:GotoOnAttrNode';
end;//TkwAttrExplorerGotoOnAttrNode.GetWordNameForRegister

function TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := @tfw_tiVoid;
end;//TkwAttrExplorerGotoOnAttrNode.GetResultTypeInfo

function TkwAttrExplorerGotoOnAttrNode.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 2;
end;//TkwAttrExplorerGotoOnAttrNode.GetAllParamsCount

function TkwAttrExplorerGotoOnAttrNode.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TdtAttribute)]);
end;//TkwAttrExplorerGotoOnAttrNode.ParamsTypes

initialization
 TAttributeExplorerWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TkwAttrExplorerGotoOnAttrNode.RegisterInEngine;
 {* ����������� AttrExplorer_GotoOnAttrNode }
 TtfwTypeRegistrator.RegisterType(@tfw_tiStruct);
 {* ����������� ���� TtfwContext }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TAttrExplorer));
 {* ����������� ���� TAttrExplorer }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TdtAttribute));
 {* ����������� ���� TdtAttribute }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND Defined(AppClientSide) AND NOT Defined(NoScripts)

end.
