unit evMarker;

interface

uses
 l3IntfUses
 , k2TagTool
 , nevTools
 , nevBase
 , l3Variant
 , l3Interfaces
;

type
 RevMarker = class of TevMarker;
 
 TevMarker = class(Tk2TagTool, IevMarker)
  procedure SetClientValue(aValue: Integer;
   const aContext: InevOp);
  function DoGetClientValue: Integer;
  function DoGetValue: Integer;
  procedure DoSetValue(aValue: Integer;
   const Context: InevOp);
  procedure Create(const aView: InevView;
   aPara: Tl3Tag;
   aTag: LongInt;
   aStyle: TevParaMarkerStyle;
   const aHint: Il3CString);
  function MakeCopy(const aTagWrap: InevPara): IevMarker;
   {* делает копию маркера для aTagWrap. }
  procedure SetValue(Value: Integer;
   const Context: InevOp);
   {* установить новое значение параметра. }
  function CompareLevel(aTagWrap: Tl3Variant): Integer;
   {* сравнить уровени вложенности маркера и тега. }
  function Compare(const aMarker: IevMarker): Integer;
   {* сравнивает маркеры. }
  function Value: Integer;
   {* значение параметра, относительно левой границы бумаги. }
  function ClientValue: Integer;
   {* значение параметра, относительно левой границы объекта. }
  function Level: Integer;
   {* уровень вложенности маркера. }
  function Para: InevPara;
   {* объект для которого построен данный маркер. }
  function TagIndex: Integer;
  function Acc: Integer;
  function Style: TevParaMarkerStyle;
  function Hint: Il3CString;
  function View: InevView;
 end;//TevMarker
 
implementation

uses
 l3ImplUses
 , SysUtils
;

end.
