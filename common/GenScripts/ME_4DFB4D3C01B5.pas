unit NOT_FINISHED_Main;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_Main.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Main" MUID: (4DFB4D3C01B5)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , l3ClipboardSpy
 , dt_Types
 , SysUtils
 , DocIntf
;

type
 TNewDocParams = record
  rDocType: TDocType;
  rDocKind: Integer;
  rDocName: AnsiString;
  rAnalyseFile: TFileName;
  rDocAddr: TDocAddr;
  rAnalyseLog: Boolean;
 end;//TNewDocParams

 TMainForm = class(Il3ClipListner)
  protected
   procedure Change;
  public
   procedure CreateNewDocumentFromFile(const aParams: TNewDocParams);
 end;//TMainForm
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , InsDWin
 , VMailWin
 , l3ClipSpyService
 , vtClipSpyService
;

procedure TMainForm.CreateNewDocumentFromFile(const aParams: TNewDocParams);
//#UC START# *4E0AD05102F2_4DFB4D5E0084_var*
//#UC END# *4E0AD05102F2_4DFB4D5E0084_var*
begin
//#UC START# *4E0AD05102F2_4DFB4D5E0084_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0AD05102F2_4DFB4D5E0084_impl*
end;//TMainForm.CreateNewDocumentFromFile

procedure TMainForm.Change;
//#UC START# *57762C1A029F_4DFB4D5E0084_var*
//#UC END# *57762C1A029F_4DFB4D5E0084_var*
begin
//#UC START# *57762C1A029F_4DFB4D5E0084_impl*
 !!! Needs to be implemented !!!
//#UC END# *57762C1A029F_4DFB4D5E0084_impl*
end;//TMainForm.Change
{$IfEnd} // Defined(AppClientSide)

end.
