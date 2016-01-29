unit NOT_FINISHED_Editwin;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Библиотека "Main"
// Модуль: "w:/archi/source/projects/Archi/Main/NOT_FINISHED_Editwin.pas"
// Родные Delphi интерфейсы (.pas)
// Generated from UML model, root element: <<UtilityPack::Class>> archi::Main::MainWindows::Editwin
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
  dt_Types,
  F_ImageView
  ;

type
 TDocEditorWindow = class
 private
 // private fields
   f_PicImageViewer : TfrmImgViewer;
 public
 // public methods
   procedure SubNameEdit(aSubID: TSubID);
 end;//TDocEditorWindow

const
  { Номера вкладок }
 piName = 0;
 piAttr = 1;
 piText = 2;
 piPicture = 3;
 piSprv = 4;
 piAnno = 5;
 piClass = 6;
 piSrcImage = 7;
 piSub = 8;
 piResp = 9;
 piCoresp = 10;
 piVersion = 11;
 piJourn = 12;
 piMax = piJourn;
{$IfEnd} //AppClientSide

implementation

{$If defined(AppClientSide)}
uses
  InsDWin,
  arConst,
  evCommonUtils,
  evTableConverter
  {$If defined(InsiderTest) AND defined(nsTest) AND not defined(NoScripts)}
  ,
  archiDocEditorWindowWordsPack
  {$IfEnd} //InsiderTest AND nsTest AND not NoScripts
  ,
  arEditorDebugInfo,
  CustEditWin
  ;

// start class TDocEditorWindow

procedure TDocEditorWindow.SubNameEdit(aSubID: TSubID);
//#UC START# *4DFB4B4003B5_4DFB4B01001D_var*
//#UC END# *4DFB4B4003B5_4DFB4B01001D_var*
begin
//#UC START# *4DFB4B4003B5_4DFB4B01001D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFB4B4003B5_4DFB4B01001D_impl*
end;//TDocEditorWindow.SubNameEdit
{$IfEnd} //AppClientSide

end.