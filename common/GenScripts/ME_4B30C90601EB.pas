unit TextLoad;

interface

uses
 l3IntfUses
 , TextViaEditorProcessorPrim
;

type
 TTextLoad = class(TTextViaEditorProcessorPrim)
  procedure LoadGK;
   {* �������� �� }
  procedure LoadBigTableFromTextEVD;
   {* �������� �������� ������� �� ���������� EVD }
  procedure K_172361288;
   {* ���� �� ������� [RequestLink:172361288]. }
 end;//TTextLoad
 
implementation

uses
 l3ImplUses
 , TextLoad_Form
 , TestFrameWork
 , k2Base
 , ddSectionRepair
 , k2DocumentBuffer
 , SysUtils
 , k2TagGen
 , l3Variant
;

end.
