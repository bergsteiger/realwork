Conditions
-------
  1. <repeat name="Rows">
    For all rows

  2. <repeat name="Cols">  
    For all cols

  3. <repeat name="Header">


Loops
-----
  1. <if name="Header">
  2. <if name="Footer">
  3. <if name="NotLastCol">
  4. <if name="FileExist" offset="XX">
     checks whether output file exists. XX - offset in current file


Macros
------
  1. <macro name="Cell" width="XX">
    Cell contents. Optional parameter - width in pixels, or Auto (to calculate
    width automatically).
  2. <macro name="Row" width="XX">
    Line contents.  Optional parameter - width in pixels, or Auto (to calculate
    the largest width value automatically ).
  3. <macro name="CellHeader" width="auto">
    Header column contents. Optional parameter - width in pixels, or Auto (to calculate
    the largest width value automatically ).
  4. <macro name="FileName" offset="XX">
     returns the name of the file. XX - offset in the current file
  5. <macro name="FileNumb" offset="XX">
     Returns the number of the file. XX - offset in the current file
  6. <macro name="TotalFileNumb">
  7. <macro name="Separator" char="-" width="auto">

