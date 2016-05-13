unit archiEditorWindowWordsPack;

// ������: "w:\archi\source\projects\Everest\Lite\7.0\Express\EverestTestSupport\archiEditorWindowWordsPack.pas"
// ���������: "ScriptKeywordsPack"
// ������� ������: "archiEditorWindowWordsPack" MUID: (55B665AE01A8)

interface

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3IntfUses
;
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

implementation

{$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
uses
 l3ImplUses
 , EdWin
 , tfwClassLike
 , tfwScriptingInterfaces
 , TypInfo
 , tfwAxiomaticsResNameGetter
 , SysUtils
 , TtfwTypeRegistrator_Proxy
 , tfwScriptingTypes
;

type
 TkwIsNeedSaveDocument = {final} class(TtfwClassLike)
  {* ����� ������� IsNeedSaveDocument }
  private
   function IsNeedSaveDocument(const aCtx: TtfwContext;
    aEditor: TEditorWindow): Boolean;
    {* ���������� ����� ������� IsNeedSaveDocument }
  protected
   procedure DoDoIt(const aCtx: TtfwContext); override;
   class function GetWordNameForRegister: AnsiString; override;
  public
   function GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo; override;
   function GetAllParamsCount(const aCtx: TtfwContext): Integer; override;
   function ParamsTypes: PTypeInfoArray; override;
 end;//TkwIsNeedSaveDocument

 TarchiEditorWindowWordsPackResNameGetter = {final} class(TtfwAxiomaticsResNameGetter)
  {* ����������� ������������ ����������� }
  public
   class function ResName: AnsiString; override;
 end;//TarchiEditorWindowWordsPackResNameGetter

function TkwIsNeedSaveDocument.IsNeedSaveDocument(const aCtx: TtfwContext;
 aEditor: TEditorWindow): Boolean;
 {* ���������� ����� ������� IsNeedSaveDocument }
//#UC START# *55B665ED0380_BB6D8477DC61_var*
//#UC END# *55B665ED0380_BB6D8477DC61_var*
begin
//#UC START# *55B665ED0380_BB6D8477DC61_impl*
 Result := aEditor.IsNeedSaveDocument;
//#UC END# *55B665ED0380_BB6D8477DC61_impl*
end;//TkwIsNeedSaveDocument.IsNeedSaveDocument

procedure TkwIsNeedSaveDocument.DoDoIt(const aCtx: TtfwContext);
var l_aEditor: TEditorWindow;
begin
 try
  l_aEditor := TEditorWindow(aCtx.rEngine.PopObjAs(TEditorWindow));
 except
  on E: Exception do
  begin
   RunnerError('������ ��� ��������� ��������� aEditor: TEditorWindow : ' + E.Message, aCtx);
   Exit;
  end;//on E: Exception
 end;//try..except
 aCtx.rEngine.PushBool(IsNeedSaveDocument(aCtx, l_aEditor));
end;//TkwIsNeedSaveDocument.DoDoIt

class function TkwIsNeedSaveDocument.GetWordNameForRegister: AnsiString;
begin
 Result := 'IsNeedSaveDocument';
end;//TkwIsNeedSaveDocument.GetWordNameForRegister

function TkwIsNeedSaveDocument.GetResultTypeInfo(const aCtx: TtfwContext): PTypeInfo;
begin
 Result := TypeInfo(Boolean);
end;//TkwIsNeedSaveDocument.GetResultTypeInfo

function TkwIsNeedSaveDocument.GetAllParamsCount(const aCtx: TtfwContext): Integer;
begin
 Result := 1;
end;//TkwIsNeedSaveDocument.GetAllParamsCount

function TkwIsNeedSaveDocument.ParamsTypes: PTypeInfoArray;
begin
 Result := OpenTypesToTypes([TypeInfo(TEditorWindow)]);
end;//TkwIsNeedSaveDocument.ParamsTypes

class function TarchiEditorWindowWordsPackResNameGetter.ResName: AnsiString;
begin
 Result := 'archiEditorWindowWordsPack';
end;//TarchiEditorWindowWordsPackResNameGetter.ResName

 {$R archiEditorWindowWordsPack.res}

initialization
 TkwIsNeedSaveDocument.RegisterInEngine;
 {* ����������� IsNeedSaveDocument }
 TarchiEditorWindowWordsPackResNameGetter.Register;
 {* ����������� ������������ ����������� }
 TtfwTypeRegistrator.RegisterType(TypeInfo(TEditorWindow));
 {* ����������� ���� TEditorWindow }
 TtfwTypeRegistrator.RegisterType(TypeInfo(Boolean));
 {* ����������� ���� Boolean }
{$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)

end.
