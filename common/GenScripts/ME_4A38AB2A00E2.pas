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
   {* ������ ����� ������� ��� aTagWrap. }
  procedure SetValue(Value: Integer;
   const Context: InevOp);
   {* ���������� ����� �������� ���������. }
  function CompareLevel(aTagWrap: Tl3Variant): Integer;
   {* �������� ������� ����������� ������� � ����. }
  function Compare(const aMarker: IevMarker): Integer;
   {* ���������� �������. }
  function Value: Integer;
   {* �������� ���������, ������������ ����� ������� ������. }
  function ClientValue: Integer;
   {* �������� ���������, ������������ ����� ������� �������. }
  function Level: Integer;
   {* ������� ����������� �������. }
  function Para: InevPara;
   {* ������ ��� �������� �������� ������ ������. }
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
