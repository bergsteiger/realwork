// **********************************************************************
//
// Copyright (c) 2001 MT Tools.
//
// All Rights Reserved
//
// MT_DORB is based in part on the product DORB,
// written by Shadrin Victor
//
// See Readme.txt for contact information
//
// **********************************************************************
unit version_int;

interface

// The mtdorb version, as string and as integer
//
// Format of version: ABBCCDD
//
// For regular releases (that is non-beta and non-alpha), A is the
// major version, BB the minor version, CC the patchlevel version, and
// DD is 00. Examples:
//
//                      ABBCCDD
// Version 3.2          3020000L
// Version 3.2.4        3020400L
// Version 4.0          4000000L
// Version 4.0.1        4000100L
//
// For alpha and beta releases, 1 must be substracted from ABBCC. For
// alpha releases, DD is then the alpha release number. For beta
// releases, DD is the beta release number plus 50. Examples:
//
//                         ABBCCDD
// Version 3.2a1           3019901L
// Version 3.2.4b2         3020352L
// Version 4.0b1           3999951L
// Version 4.0.1a1         4000001L

const
  ORBVersion = '1.0.1b1';
  ORBIntegerVersion = 1000151;
  
implementation

end.
