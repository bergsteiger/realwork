unit NOT_FINISHED_evSearch;
 {* Инструменты для поиска/замены. }

// Модуль: "w:\common\components\gui\Garant\Everest\NOT_FINISHED_evSearch.pas"
// Стереотип: "UtilityPack"
// Элемент модели: "evSearch" MUID: (47F1F94201F6)

{$Include w:\common\components\gui\Garant\Everest\evDefine.inc}

interface

uses
 l3IntfUses
 , l3ProtoObject
 , nevTools
 , evTypes
 , l3Variant
 , l3CustomString
 , nevBase
;

type
 TevSearchTool = class(Tl3ProtoObject, IevSearchTool)
  protected
   procedure Start;
    {* начало поиска. }
   procedure Finish(aCancel: Boolean;
    const aBlock: InevRange);
    {* конец поиска. }
   function pm_GetText: AnsiString;
   function pm_GetOptions: TevSearchOptionSet;
   procedure pm_SetOptions(aValue: TevSearchOptionSet);
 end;//TevSearchTool

 TevBaseSearcher = {abstract} class(TevSearchTool, IevSearcher)
  protected
   function Check(const aView: InevView;
    const aBlock: InevRange;
    out theStart: InevBasePoint;
    out theFinish: InevBasePoint;
    const PrevBlock: InevRange): Boolean;
    {* определяет критерий отбора параграфа (его фрагмента). }
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; virtual; abstract;
 end;//TevBaseSearcher

 TevParaByIDSearcher = class(TevBaseSearcher)
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevParaByIDSearcher

 TevStyleSearcher = class(TevBaseSearcher)
  protected
   function IsStyleFound(aStyle: Tl3Tag): Boolean; virtual;
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevStyleSearcher

 TevORSearcher = class(TevBaseSearcher)
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevORSearcher

 TevStylesSearcher = class(TevORSearcher)
 end;//TevStylesSearcher

 TevRegExpMultipartSearcher = class
 end;//TevRegExpMultipartSearcher

 TevTextReplacer = class
 end;//TevTextReplacer

 TevMorphologySearcher = class
 end;//TevMorphologySearcher

 TevTextSearcher = {abstract} class(TevBaseSearcher)
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevTextSearcher

 TevBMTextSearcher = class(TevBaseSearcher)
  {* Класс инструментов для поиска подстроки методом Боера-Мура }
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevBMTextSearcher

 TevBaseReplacer = {abstract} class(TevSearchTool, IevReplacer)
  protected
   function ReplaceFunc(const aView: InevView;
    const Container: InevOp;
    const aBlock: InevRange): Boolean; virtual; abstract;
   function Replace(const Container: InevOp;
    const aBlock: InevRange;
    const aConfirm: InevConfirm): Boolean;
   function NeedProgress: Boolean;
   function Get_Searcher: IevSearcher;
   procedure Set_Searcher(const aValue: IevSearcher);
   function Get_ReplaceCount: Integer;
 end;//TevBaseReplacer

 TevFakeSearcher = class(TevBaseSearcher)
  public
   function DoCheckText(aPara: Tl3Variant;
    aText: Tl3CustomString;
    const aSel: TevPair;
    out theSel: TevPair): Boolean; override;
 end;//TevFakeSearcher

 TevAnyParagraphSearcher = class(TevFakeSearcher)
  {* Класс для нахождения любого параграфа. }
 end;//TevAnyParagraphSearcher

implementation

uses
 l3ImplUses
 //#UC START# *47F1F94201F6impl_uses*
 //#UC END# *47F1F94201F6impl_uses*
;

procedure TevSearchTool.Start;
 {* начало поиска. }
//#UC START# *47C6CA6B01E9_4ADC811B0204_var*
//#UC END# *47C6CA6B01E9_4ADC811B0204_var*
begin
//#UC START# *47C6CA6B01E9_4ADC811B0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6CA6B01E9_4ADC811B0204_impl*
end;//TevSearchTool.Start

procedure TevSearchTool.Finish(aCancel: Boolean;
 const aBlock: InevRange);
 {* конец поиска. }
//#UC START# *47C6CA7A01CA_4ADC811B0204_var*
//#UC END# *47C6CA7A01CA_4ADC811B0204_var*
begin
//#UC START# *47C6CA7A01CA_4ADC811B0204_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6CA7A01CA_4ADC811B0204_impl*
end;//TevSearchTool.Finish

function TevSearchTool.pm_GetText: AnsiString;
//#UC START# *47C6CA9403C3_4ADC811B0204get_var*
//#UC END# *47C6CA9403C3_4ADC811B0204get_var*
begin
//#UC START# *47C6CA9403C3_4ADC811B0204get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6CA9403C3_4ADC811B0204get_impl*
end;//TevSearchTool.pm_GetText

function TevSearchTool.pm_GetOptions: TevSearchOptionSet;
//#UC START# *47C6CB7D00C9_4ADC811B0204get_var*
//#UC END# *47C6CB7D00C9_4ADC811B0204get_var*
begin
//#UC START# *47C6CB7D00C9_4ADC811B0204get_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6CB7D00C9_4ADC811B0204get_impl*
end;//TevSearchTool.pm_GetOptions

procedure TevSearchTool.pm_SetOptions(aValue: TevSearchOptionSet);
//#UC START# *47C6CB7D00C9_4ADC811B0204set_var*
//#UC END# *47C6CB7D00C9_4ADC811B0204set_var*
begin
//#UC START# *47C6CB7D00C9_4ADC811B0204set_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C6CB7D00C9_4ADC811B0204set_impl*
end;//TevSearchTool.pm_SetOptions

function TevBaseSearcher.Check(const aView: InevView;
 const aBlock: InevRange;
 out theStart: InevBasePoint;
 out theFinish: InevBasePoint;
 const PrevBlock: InevRange): Boolean;
 {* определяет критерий отбора параграфа (его фрагмента). }
//#UC START# *47C7C6F8035C_4ADC80FF0104_var*
//#UC END# *47C7C6F8035C_4ADC80FF0104_var*
begin
//#UC START# *47C7C6F8035C_4ADC80FF0104_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7C6F8035C_4ADC80FF0104_impl*
end;//TevBaseSearcher.Check

function TevParaByIDSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_47F1F97F0328_var*
//#UC END# *50751B680376_47F1F97F0328_var*
begin
//#UC START# *50751B680376_47F1F97F0328_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_47F1F97F0328_impl*
end;//TevParaByIDSearcher.DoCheckText

function TevStyleSearcher.IsStyleFound(aStyle: Tl3Tag): Boolean;
//#UC START# *4ADC80DC013E_4ADC80C703AF_var*
//#UC END# *4ADC80DC013E_4ADC80C703AF_var*
begin
//#UC START# *4ADC80DC013E_4ADC80C703AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *4ADC80DC013E_4ADC80C703AF_impl*
end;//TevStyleSearcher.IsStyleFound

function TevStyleSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_4ADC80C703AF_var*
//#UC END# *50751B680376_4ADC80C703AF_var*
begin
//#UC START# *50751B680376_4ADC80C703AF_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_4ADC80C703AF_impl*
end;//TevStyleSearcher.DoCheckText

function TevORSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_4ADC8513030A_var*
//#UC END# *50751B680376_4ADC8513030A_var*
begin
//#UC START# *50751B680376_4ADC8513030A_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_4ADC8513030A_impl*
end;//TevORSearcher.DoCheckText

function TevTextSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_4D53D9910086_var*
//#UC END# *50751B680376_4D53D9910086_var*
begin
//#UC START# *50751B680376_4D53D9910086_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_4D53D9910086_impl*
end;//TevTextSearcher.DoCheckText

function TevBMTextSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_4D53D9B70153_var*
//#UC END# *50751B680376_4D53D9B70153_var*
begin
//#UC START# *50751B680376_4D53D9B70153_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_4D53D9B70153_impl*
end;//TevBMTextSearcher.DoCheckText

function TevBaseReplacer.Replace(const Container: InevOp;
 const aBlock: InevRange;
 const aConfirm: InevConfirm): Boolean;
//#UC START# *47C7C8240348_4D553A4A005D_var*
//#UC END# *47C7C8240348_4D553A4A005D_var*
begin
//#UC START# *47C7C8240348_4D553A4A005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7C8240348_4D553A4A005D_impl*
end;//TevBaseReplacer.Replace

function TevBaseReplacer.NeedProgress: Boolean;
//#UC START# *47C7C841004B_4D553A4A005D_var*
//#UC END# *47C7C841004B_4D553A4A005D_var*
begin
//#UC START# *47C7C841004B_4D553A4A005D_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7C841004B_4D553A4A005D_impl*
end;//TevBaseReplacer.NeedProgress

function TevBaseReplacer.Get_Searcher: IevSearcher;
//#UC START# *47C7C895023C_4D553A4A005Dget_var*
//#UC END# *47C7C895023C_4D553A4A005Dget_var*
begin
//#UC START# *47C7C895023C_4D553A4A005Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7C895023C_4D553A4A005Dget_impl*
end;//TevBaseReplacer.Get_Searcher

procedure TevBaseReplacer.Set_Searcher(const aValue: IevSearcher);
//#UC START# *47C7C895023C_4D553A4A005Dset_var*
//#UC END# *47C7C895023C_4D553A4A005Dset_var*
begin
//#UC START# *47C7C895023C_4D553A4A005Dset_impl*
 !!! Needs to be implemented !!!
//#UC END# *47C7C895023C_4D553A4A005Dset_impl*
end;//TevBaseReplacer.Set_Searcher

function TevBaseReplacer.Get_ReplaceCount: Integer;
//#UC START# *4D3EA8AD0147_4D553A4A005Dget_var*
//#UC END# *4D3EA8AD0147_4D553A4A005Dget_var*
begin
//#UC START# *4D3EA8AD0147_4D553A4A005Dget_impl*
 !!! Needs to be implemented !!!
//#UC END# *4D3EA8AD0147_4D553A4A005Dget_impl*
end;//TevBaseReplacer.Get_ReplaceCount

function TevFakeSearcher.DoCheckText(aPara: Tl3Variant;
 aText: Tl3CustomString;
 const aSel: TevPair;
 out theSel: TevPair): Boolean;
//#UC START# *50751B680376_50751A7C01BC_var*
//#UC END# *50751B680376_50751A7C01BC_var*
begin
//#UC START# *50751B680376_50751A7C01BC_impl*
 !!! Needs to be implemented !!!
//#UC END# *50751B680376_50751A7C01BC_impl*
end;//TevFakeSearcher.DoCheckText

end.
