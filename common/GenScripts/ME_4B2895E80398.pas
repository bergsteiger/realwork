unit nsEditionsUtils;

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\Business\Document\nsEditionsUtils.pas"
// Стереотип: "UtilityPack"

{$Include nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , l3TreeInterfaces
 {$If NOT Defined(NoVCL)}
 , ImgList
 {$IfEnd} // NOT Defined(NoVCL)
;

function nsCalcEditionImageIndex(const anEdition: Il3SimpleNode;
 var theImages: TCustomImageList;
 aForEditionsTree: Boolean): Integer;
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , DocumentRes
 , nsEditionNodes
 , DocumentUnit
 , SysUtils
 , SearchRes
;

function nsCalcEditionImageIndex(const anEdition: Il3SimpleNode;
 var theImages: TCustomImageList;
 aForEditionsTree: Boolean): Integer;
//#UC START# *4B2896B900F3_4B2895E80398_var*
var
 l_EditionNode : InsEditionNode;
//#UC END# *4B2896B900F3_4B2895E80398_var*
begin
//#UC START# *4B2896B900F3_4B2895E80398_impl*
 theImages := nsDocumentRes.DocumentItemsImageList;
 if Supports(anEdition, InsEditionNode, l_EditionNode) then
 begin
  if aForEditionsTree then
  begin
   theImages := nsSearchRes.SearchItemsImageList;
   case l_EditionNode.EditionType of
    RT_ACTUAL:
     Result := 12;
    RT_ACTUAL_ABOLISHED:
     Result := 12;
    RT_ACTUAL_PREACTIVE:
     Result := 14;
    RT_OLD:
     Result := 14;
    RT_NEW,
    RT_NEW_ABOLISHED,
    RT_NEW_PREACTIVE:
     Result := 10;
    else
    begin
     Assert(false);
     Result := 12;
    end;//else
   end;//case l_EditionNode.EditionType
   if (l_EditionNode.CheckType <> ns_enctUnchecked) then
    Inc(Result);
    // - квадратик с галочкой
  end///aForEditionsTree
  else
  begin
   case l_EditionNode.EditionType of
    RT_ACTUAL:
     Result := diilActualRedaction;
    RT_ACTUAL_ABOLISHED:
     Result := diilActualNoActiveRedaction;
    RT_ACTUAL_PREACTIVE:
     Result := diilActualPreActiveRedaction;
    RT_OLD:
     Result := diilNoActiveRedaction;
    RT_NEW,
    RT_NEW_ABOLISHED,
    RT_NEW_PREACTIVE:
     Result := diilPreActiveRedaction;
    else
    begin
     Assert(false);
     Result := diilActualRedaction;
    end;//else
   end//case l_EditionNode.EditionType
  end;//aForEditionsTree
 end//Supports(anEdition, InsEditionNode, l_EditionNode)
 else
  Result := diilActualRedaction;
//#UC END# *4B2896B900F3_4B2895E80398_impl*
end;//nsCalcEditionImageIndex
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
