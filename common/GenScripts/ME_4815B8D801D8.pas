unit nevRootFormatInfo;

interface

uses
 l3IntfUses
 , nevDocumentFormatInfo
 , nevTools
 , nevBase
 , nevFormatPoolBase
 , l3Variant
;

type
 TnevRootFormatInfo = class(TnevDocumentFormatInfo, InevViewMetrics)
  procedure Create(const aView: InevView;
   aPool: TnevFormatPoolBase);
  function LimitWidth: TnevInch;
  function InfoCanvas: InevInfoCanvas;
   {* �������������� �������� ����������, ��� �������� ���� ������������� ���������. }
  function IsWebStyle: Boolean;
  function ShowDocumentParts: Boolean;
   {* ���������� �� ������� ��������� ���������? }
  function ShowSpecial: Boolean;
  function HiddenStyles: TnevStandardStyles;
  function Extent: TnevPoint;
  function ExcludeSuper: TevNormalSegLayerHandleSet;
   {* ����������� ��� ����������� ���� }
  function FormatCanvas: InevInfoCanvas;
   {* ����� ��� ��������������. [$157450362] }
  function AllowRubberTables: TnevRubberTablesMode;
   {* ��������� �� ��������� ������� }
  function IsTagCollapsed(aTag: Tl3Variant): Boolean;
  function Data: InevObjectPrim;
  function AACLike: TnevAACLikeMode;
  function NeedTotalRecalc: Boolean;
 end;//TnevRootFormatInfo
 
implementation

uses
 l3ImplUses
 , nevFacade
 , l3PrinterIC
 , k2Tags
 , evDocumentPart
 , l3Units
 , evTextStyle_Const
 , evParaTools
;

end.
