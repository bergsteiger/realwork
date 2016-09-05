unit NOT_FINISHED_Editwin;

// Модуль: "w:\archi\source\projects\Archi\Main\NOT_FINISHED_Editwin.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "Editwin" MUID: (4DFB4AD800BA)

{$Include w:\archi\source\projects\Archi\arDefine.inc}

interface

{$If Defined(AppClientSide)}
uses
 l3IntfUses
 , F_ImageView
 , dt_Types
;

const
 {* Номера вкладок }
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

type
 TDocEditorWindow = class
  private
   f_PicImageViewer: TfrmImgViewer;
  public
   procedure SubNameEdit(aSubID: TSubID);
 end;//TDocEditorWindow
{$IfEnd} // Defined(AppClientSide)

implementation

{$If Defined(AppClientSide)}
uses
 l3ImplUses
 , arEditorDebugInfo
 , CustEditWin
 , InsDWin
 , arConst
 , evCommonUtils
 , evTableConverter
 {$If Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)}
 , archiDocEditorWindowWordsPack
 {$IfEnd} // Defined(nsTest) AND Defined(InsiderTest) AND NOT Defined(NoScripts)
 //#UC START# *4DFB4AD800BAimpl_uses*
 //#UC END# *4DFB4AD800BAimpl_uses*
;

procedure TDocEditorWindow.SubNameEdit(aSubID: TSubID);
//#UC START# *4DFB4B4003B5_4DFB4B01001D_var*
//#UC END# *4DFB4B4003B5_4DFB4B01001D_var*
begin
//#UC START# *4DFB4B4003B5_4DFB4B01001D_impl*
 !!! Needs to be implemented !!!
//#UC END# *4DFB4B4003B5_4DFB4B01001D_impl*
end;//TDocEditorWindow.SubNameEdit
{$IfEnd} // Defined(AppClientSide)

end.
