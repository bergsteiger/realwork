unit NOT_FINISHED_eePara;

// Модуль: "w:\common\components\gui\Garant\Everest_Engine\NOT_FINISHED_eePara.pas"
// Стереотип: "UtilityPack"

{$Include eeDefine.inc}

interface

{$If Defined(Nemesis)}
uses
 l3IntfUses
 , eeTagEditorTool
 , eeInterfaces
 , k2Base
 , l3Variant
 , l3Interfaces
;

type
 TeePara = class(TeeTagEditorTool, IeePara)
  protected
   function Get_Document: IeeDocument;
   function Get_Parent: IeePara;
   function Get_Block: IeeBlock;
   function Get_Subs: IeeSubList;
   function Get_Markers: IeeSubList;
   function Get_Bookmarks: IeeSubList;
   function Get_Marks: IeeSubList;
   function Get_ID: Integer;
   function Get_IndexInParent: Integer;
   function Get_Prev: IeePara;
   function Get_Next: IeePara;
   function IsKindOf(aType: Tk2Type): Boolean;
   function IsSame(const aPara: IeePara): Boolean;
   function Delete: Boolean;
   function IsUserComment: Boolean;
   function AsObject: Tl3Variant;
 end;//TeePara

 TeeLeafPara = class(TeePara, IeeLeafPara)
 end;//TeeLeafPara

 TeeStyledLeafPara = class(TeeLeafPara, IeeStyledLeafPara)
  protected
   function IsComment: Boolean; overload;
   function IsComment(aType: TeeCommentType): Boolean; overload;
 end;//TeeStyledLeafPara

 TeeTextPara = class(TeeStyledLeafPara, IeeTextPara)
  protected
   function Get_Text: Il3CString;
 end;//TeeTextPara

 TeeParaList = class(TeePara)
 end;//TeeParaList

 TeeSBS = class(TeeParaList)
 end;//TeeSBS
{$IfEnd} // Defined(Nemesis)

implementation

{$If Defined(Nemesis)}
uses
 l3ImplUses
 , eeSubList
;

function TeePara.Get_Document: IeeDocument;
//#UC START# *54819A560264_49523F8B0208get_var*
//#UC END# *54819A560264_49523F8B0208get_var*
begin
//#UC START# *54819A560264_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A560264_49523F8B0208get_impl*
end;//TeePara.Get_Document

function TeePara.Get_Parent: IeePara;
//#UC START# *54819A630153_49523F8B0208get_var*
//#UC END# *54819A630153_49523F8B0208get_var*
begin
//#UC START# *54819A630153_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A630153_49523F8B0208get_impl*
end;//TeePara.Get_Parent

function TeePara.Get_Block: IeeBlock;
//#UC START# *54819A6D038B_49523F8B0208get_var*
//#UC END# *54819A6D038B_49523F8B0208get_var*
begin
//#UC START# *54819A6D038B_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A6D038B_49523F8B0208get_impl*
end;//TeePara.Get_Block

function TeePara.Get_Subs: IeeSubList;
//#UC START# *54819A760069_49523F8B0208get_var*
//#UC END# *54819A760069_49523F8B0208get_var*
begin
//#UC START# *54819A760069_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A760069_49523F8B0208get_impl*
end;//TeePara.Get_Subs

function TeePara.Get_Markers: IeeSubList;
//#UC START# *54819A830391_49523F8B0208get_var*
//#UC END# *54819A830391_49523F8B0208get_var*
begin
//#UC START# *54819A830391_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A830391_49523F8B0208get_impl*
end;//TeePara.Get_Markers

function TeePara.Get_Bookmarks: IeeSubList;
//#UC START# *54819A9600F5_49523F8B0208get_var*
//#UC END# *54819A9600F5_49523F8B0208get_var*
begin
//#UC START# *54819A9600F5_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819A9600F5_49523F8B0208get_impl*
end;//TeePara.Get_Bookmarks

function TeePara.Get_Marks: IeeSubList;
//#UC START# *54819AA3019D_49523F8B0208get_var*
//#UC END# *54819AA3019D_49523F8B0208get_var*
begin
//#UC START# *54819AA3019D_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819AA3019D_49523F8B0208get_impl*
end;//TeePara.Get_Marks

function TeePara.Get_ID: Integer;
//#UC START# *54819AB403BD_49523F8B0208get_var*
//#UC END# *54819AB403BD_49523F8B0208get_var*
begin
//#UC START# *54819AB403BD_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819AB403BD_49523F8B0208get_impl*
end;//TeePara.Get_ID

function TeePara.Get_IndexInParent: Integer;
//#UC START# *54819ABD01B8_49523F8B0208get_var*
//#UC END# *54819ABD01B8_49523F8B0208get_var*
begin
//#UC START# *54819ABD01B8_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819ABD01B8_49523F8B0208get_impl*
end;//TeePara.Get_IndexInParent

function TeePara.Get_Prev: IeePara;
//#UC START# *54819AD20366_49523F8B0208get_var*
//#UC END# *54819AD20366_49523F8B0208get_var*
begin
//#UC START# *54819AD20366_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819AD20366_49523F8B0208get_impl*
end;//TeePara.Get_Prev

function TeePara.Get_Next: IeePara;
//#UC START# *54819B120216_49523F8B0208get_var*
//#UC END# *54819B120216_49523F8B0208get_var*
begin
//#UC START# *54819B120216_49523F8B0208get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819B120216_49523F8B0208get_impl*
end;//TeePara.Get_Next

function TeePara.IsKindOf(aType: Tk2Type): Boolean;
//#UC START# *54819B7C00EC_49523F8B0208_var*
//#UC END# *54819B7C00EC_49523F8B0208_var*
begin
//#UC START# *54819B7C00EC_49523F8B0208_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819B7C00EC_49523F8B0208_impl*
end;//TeePara.IsKindOf

function TeePara.IsSame(const aPara: IeePara): Boolean;
//#UC START# *54819B9003B8_49523F8B0208_var*
//#UC END# *54819B9003B8_49523F8B0208_var*
begin
//#UC START# *54819B9003B8_49523F8B0208_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819B9003B8_49523F8B0208_impl*
end;//TeePara.IsSame

function TeePara.Delete: Boolean;
//#UC START# *54819BA30185_49523F8B0208_var*
//#UC END# *54819BA30185_49523F8B0208_var*
begin
//#UC START# *54819BA30185_49523F8B0208_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819BA30185_49523F8B0208_impl*
end;//TeePara.Delete

function TeePara.IsUserComment: Boolean;
//#UC START# *54819BB50350_49523F8B0208_var*
//#UC END# *54819BB50350_49523F8B0208_var*
begin
//#UC START# *54819BB50350_49523F8B0208_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819BB50350_49523F8B0208_impl*
end;//TeePara.IsUserComment

function TeePara.AsObject: Tl3Variant;
//#UC START# *54819BCF02EB_49523F8B0208_var*
//#UC END# *54819BCF02EB_49523F8B0208_var*
begin
//#UC START# *54819BCF02EB_49523F8B0208_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819BCF02EB_49523F8B0208_impl*
end;//TeePara.AsObject

function TeeStyledLeafPara.IsComment: Boolean;
//#UC START# *54819C2E029C_54BE4D400054_var*
//#UC END# *54819C2E029C_54BE4D400054_var*
begin
//#UC START# *54819C2E029C_54BE4D400054_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819C2E029C_54BE4D400054_impl*
end;//TeeStyledLeafPara.IsComment

function TeeStyledLeafPara.IsComment(aType: TeeCommentType): Boolean;
//#UC START# *54819C4503A8_54BE4D400054_var*
//#UC END# *54819C4503A8_54BE4D400054_var*
begin
//#UC START# *54819C4503A8_54BE4D400054_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819C4503A8_54BE4D400054_impl*
end;//TeeStyledLeafPara.IsComment

function TeeTextPara.Get_Text: Il3CString;
//#UC START# *54819C8702E6_54BE4D4F02D1get_var*
//#UC END# *54819C8702E6_54BE4D4F02D1get_var*
begin
//#UC START# *54819C8702E6_54BE4D4F02D1get_impl*
 !!! Needs to be implemented !!!
//#UC END# *54819C8702E6_54BE4D4F02D1get_impl*
end;//TeeTextPara.Get_Text
{$IfEnd} // Defined(Nemesis)

end.
