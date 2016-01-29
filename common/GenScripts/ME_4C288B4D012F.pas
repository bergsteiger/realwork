unit SearchAndReplacePrimTest;

interface

uses
 l3IntfUses
 , TextViaEditorProcessor
 , nevTools
 , evTypes
 , PrimTextLoad_Form
;

type
 TSearchAndReplacePrimTest = class(TTextViaEditorProcessor)
  {* ���� ������/������ }
  function Searcher: IevSearcher;
  function Replacer: IevReplacer;
  function Options: TevSearchOptionSet;
  procedure Process(aForm: TPrimTextLoadForm);
   {* ���������� ������� ��������� ������ }
 end;//TSearchAndReplacePrimTest
 
implementation

uses
 l3ImplUses
 , TestFrameWork
;

end.
