unit evMultiSelectionDataFormatting;

interface

uses
 l3IntfUses
 , evMultiSelectionRange
 , nevTools
 , l3Variant
 , nevBase
 , l3Interfaces
;

type
 TevMultiSelectionDataFormatting = class(TevMultiSelectionRange, InevDataFormatting, InevDataFormattingModify)
  function GetFont(const aView: InevView;
   aMap: TnevFormatInfoPrim;
   Stop: PInteger): InevFontPrim;
  function GetStyle(Stop: PInteger): Tl3Variant;
  function Modify(const aView: InevView): InevDataFormattingModify;
  function SetAtom(const aView: InevView;
   anIndex: Cardinal;
   aValue: Tl3Variant;
   const anOp: InevOp): Boolean;
  function ChangeParam(const aView: InevView;
   const aMarker: IevMarker;
   aValue: Integer;
   const anOp: InevOp): Boolean;
  function DeleteHyperlink(const anOp: InevOp): Boolean;
  function DeleteSegments(const anOp: InevOp): Boolean;
   {* удаляет сегменты. }
  function AddIndentMarker(const aView: InevView;
   aValue: Integer;
   const anOpPack: InevOp): Boolean;
  function DeleteIndentMarker(const aView: InevView;
   const anOpPack: InevOp): Boolean;
  function GetFormatting: InevDataFormatting;
 end;//TevMultiSelectionDataFormatting
 
implementation

uses
 l3ImplUses
 , k2Base
 , nevFacade
 , afwFacade
;

end.
