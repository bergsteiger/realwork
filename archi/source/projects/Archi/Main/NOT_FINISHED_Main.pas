unit NOT_FINISHED_Main;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Main"
// Модуль: "w:/archi/source/projects/Archi/Main/NOT_FINISHED_Main.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Main::MainWindows::Main
//
//
// Все права принадлежат ООО НПП "Гарант-Сервис".
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ! Этот файл используется только для моделирования, а не для компиляции. !

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If defined(AppClientSide)}
uses
  SysUtils,
  dt_Types,
  DocIntf
  ;

type
 TNewDocParams = record
   rDocType : TDocType;
   rDocKind : Integer;
   rDocName : AnsiString;
   rAnalyseFile : TFileName;
   rDocAddr : TDocAddr;
   rAnalyseLog : Boolean;
 end;//TNewDocParams

 TMainForm = class
 public
 // public methods
   procedure CreateNewDocumentFromFile(const aParams: TNewDocParams);
 end;//TMainForm
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  InsDWin,
  VMailWin
  ;

// start class TMainForm

procedure TMainForm.CreateNewDocumentFromFile(const aParams: TNewDocParams);
//#UC START# *4E0AD05102F2_4DFB4D5E0084_var*
//#UC END# *4E0AD05102F2_4DFB4D5E0084_var*
begin
//#UC START# *4E0AD05102F2_4DFB4D5E0084_impl*
 !!! Needs to be implemented !!!
//#UC END# *4E0AD05102F2_4DFB4D5E0084_impl*
end;//TMainForm.CreateNewDocumentFromFile
{$IfEnd} //AppClientSide

end.