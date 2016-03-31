unit nsMedicContentsTree;
 {* Документ Инфарма. См. [$121166984] }

// Модуль: "w:\garant6x\implementation\Garant\GbaNemesis\F1DocumentProcessing\nsMedicContentsTree.pas"
// Стереотип: "SimpleClass"
// Элемент модели: "TnsMedicContentsTree" MUID: (4909E96D01ED)

{$Include w:\garant6x\implementation\Garant\nsDefine.inc}

interface

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3IntfUses
 , nsContentsTree
 , afwInterfaces
;

type
 TnsMedicContentsTree = class(TnsContentsTree)
  {* Документ Инфарма. См. [$121166984] }
  protected
   function SettingsID: TafwSettingId; override;
 end;//TnsMedicContentsTree
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

implementation

{$If NOT Defined(Admin) AND NOT Defined(Monitorings)}
uses
 l3ImplUses
 , nsConst
;

function TnsMedicContentsTree.SettingsID: TafwSettingId;
//#UC START# *48FF56D003E6_4909E96D01ED_var*
//#UC END# *48FF56D003E6_4909E96D01ED_var*
begin
//#UC START# *48FF56D003E6_4909E96D01ED_impl*
  Result := gi_cpDrugContents;
//#UC END# *48FF56D003E6_4909E96D01ED_impl*
end;//TnsMedicContentsTree.SettingsID
{$IfEnd} // NOT Defined(Admin) AND NOT Defined(Monitorings)

end.
