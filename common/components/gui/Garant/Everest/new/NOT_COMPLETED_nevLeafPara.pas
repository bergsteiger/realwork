unit NOT_COMPLETED_nevLeafPara;
 {* Реализация инструмента InevLeafPara }

// Модуль: "w:\common\components\gui\Garant\Everest\new\NOT_COMPLETED_nevLeafPara.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnevLeafPara" MUID: (48D0F828032E)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

{$If Defined(k2ForEditor)}
uses
 l3IntfUses
 , nevPara
 , nevTools
 , l3Variant
 , nevBase
 , k2Interfaces
;

type
 TnevLeafPara = class(TnevPara, InevLeafPara)
  {* Реализация инструмента InevLeafPara }
  protected
   function GetIsHidden(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean; virtual;
   function TagIsHidden(aTag: Tl3Variant;
    aHiddenStyles: TnevStandardStyles): Boolean;
   function GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
    aHiddenStyles: TnevStandardStyles): Boolean; override;
   function GetAnchorID: Integer; override;
   function GetExcludeEvents: Tk2EventIDs; override;
  public
   class function Make(aTag: Tl3Variant): InevLeafPara; reintroduce;
 end;//TnevLeafPara
{$IfEnd} // Defined(k2ForEditor)

implementation

{$If Defined(k2ForEditor)}
uses
 l3ImplUses
 , k2Tags
 , evdStyles
 , l3String
 , evParaTools
 , CommentPara_Const
 , Block_Const
 , l3MinMax
 , TableCell_Const
;

class function TnevLeafPara.Make(aTag: Tl3Variant): InevLeafPara;
var
 l_Inst : TnevLeafPara;
begin
 l_Inst := Create(aTag);
 try
  Result := l_Inst;
 finally
  l_Inst.Free;
 end;//try..finally
end;//TnevLeafPara.Make

function TnevLeafPara.GetIsHidden(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48D0F8DF01AF_48D0F828032E_var*
//#UC END# *48D0F8DF01AF_48D0F828032E_var*
begin
//#UC START# *48D0F8DF01AF_48D0F828032E_impl*
 Result := TagIsHidden(TagInst, aHiddenStyles);
//#UC END# *48D0F8DF01AF_48D0F828032E_impl*
end;//TnevLeafPara.GetIsHidden

function TnevLeafPara.TagIsHidden(aTag: Tl3Variant;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48D0F8F402F3_48D0F828032E_var*
//#UC END# *48D0F8F402F3_48D0F828032E_var*
begin
//#UC START# *48D0F8F402F3_48D0F828032E_impl*
 Result := (aHiddenStyles <> []) AND
           (-aTag.IntA[k2_tiStyle] in aHiddenStyles);
//#UC END# *48D0F8F402F3_48D0F828032E_impl*
end;//TnevLeafPara.TagIsHidden

function TnevLeafPara.GetIsHiddenPrim(aMap: TnevFormatInfoPrim;
 aHiddenStyles: TnevStandardStyles): Boolean;
//#UC START# *48CFB1F5024F_48D0F828032E_var*
//#UC END# *48CFB1F5024F_48D0F828032E_var*
begin
//#UC START# *48CFB1F5024F_48D0F828032E_impl*
 Result := GetIsHidden(aMap, aHiddenStyles
                             {$IfDef evNeedCollapsedVersionComments}
                              - [-ev_saVersionInfo]
                             {$EndIf evNeedCollapsedVersionComments} 
                              );
//#UC END# *48CFB1F5024F_48D0F828032E_impl*
end;//TnevLeafPara.GetIsHiddenPrim

function TnevLeafPara.GetAnchorID: Integer;
//#UC START# *48D0EA69031F_48D0F828032E_var*
//#UC END# *48D0EA69031F_48D0F828032E_var*
begin
//#UC START# *48D0EA69031F_48D0F828032E_impl*
 Result := GetRedirect.IntA[k2_tiHandle];
//#UC END# *48D0EA69031F_48D0F828032E_impl*
end;//TnevLeafPara.GetAnchorID

function TnevLeafPara.GetExcludeEvents: Tk2EventIDs;
//#UC START# *48D0F4810330_48D0F828032E_var*
//#UC END# *48D0F4810330_48D0F828032E_var*
begin
//#UC START# *48D0F4810330_48D0F828032E_impl*
 Result := inherited GetExcludeEvents +
           [k2_eidChildrenInserted, k2_eidChildrenAdded, k2_eidChildrenDeleted];
//#UC END# *48D0F4810330_48D0F828032E_impl*
end;//TnevLeafPara.GetExcludeEvents
{$IfEnd} // Defined(k2ForEditor)

end.
