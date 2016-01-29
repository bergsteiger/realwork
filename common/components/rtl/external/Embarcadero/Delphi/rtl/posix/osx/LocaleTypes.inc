{*******************************************************}
{                                                       }
{           CodeGear Delphi Runtime Library             }
{                                                       }
{ Copyright(c) 1995-2013 Embarcadero Technologies, Inc. }
{                                                       }
{*******************************************************}

type
{ Structure giving information about numeric and monetary notation.  }
    lconv = record
      { Numeric (non-monetary) information.  }

      decimal_point: MarshaledAString;      { Decimal point character.  }
      thousands_sep: MarshaledAString;      { Thousands separator.  }
      { Each element is the number of digits in each group;
         elements with higher indices are farther left.
         An element with value CHAR_MAX means that no further grouping is done.
         An element with value 0 means that the previous element is used
         for all groups farther left.  }
      grouping: MarshaledAString;

      { Monetary information.  }

      { First three chars are a currency symbol from ISO 4217.
         Fourth char is the separator.  Fifth char is '\0'.  }
      int_curr_symbol: MarshaledAString;
      currency_symbol: MarshaledAString;    { Local currency symbol.  }
      mon_decimal_point: MarshaledAString;  { Decimal point character.  }
      mon_thousands_sep: MarshaledAString;  { Thousands separator.  }
      mon_grouping: MarshaledAString;       { Like `grouping' element (above).  }
      positive_sign: MarshaledAString;      { Sign for positive values.  }
      negative_sign: MarshaledAString;      { Sign for negative values.  }
      int_frac_digits: Byte;                { Int'l fractional digits.  }
      frac_digits: Byte;                    { Local fractional digits.  }
      { 1 if currency_symbol precedes a positive value, 0 if succeeds.  }
      p_cs_precedes: Byte;
      { 1 iff a space separates currency_symbol from a positive value.  }
      p_sep_by_space: Byte;
      { 1 if currency_symbol precedes a negative value, 0 if succeeds.  }
      n_cs_precedes: Byte;
      { 1 iff a space separates currency_symbol from a negative value.  }
      n_sep_by_space: Byte;
      { Positive and negative sign positions:
         0 Parentheses surround the quantity and currency_symbol.
         1 The sign string precedes the quantity and currency_symbol.
         2 The sign string follows the quantity and currency_symbol.
         3 The sign string immediately precedes the currency_symbol.
         4 The sign string immediately follows the currency_symbol.  }
      p_sign_posn: Byte;
      n_sign_posn: Byte;

      { 1 if int_curr_symbol precedes a positive value, 0 if succeeds.  }
      int_p_cs_precedes: Byte;
      { 1 iff a space separates int_curr_symbol from a positive value.  }
      int_p_sep_by_space: Byte;
      { 1 if int_curr_symbol precedes a negative value, 0 if succeeds.  }
      int_n_cs_precedes: Byte;
      { 1 iff a space separates int_curr_symbol from a negative value.  }
      int_n_sep_by_space: Byte;
      { Positive and negative sign positions:
         0 Parentheses surround the quantity and int_curr_symbol.
         1 The sign string precedes the quantity and int_curr_symbol.
         2 The sign string follows the quantity and int_curr_symbol.
         3 The sign string immediately precedes the int_curr_symbol.
         4 The sign string immediately follows the int_curr_symbol.  }
      int_p_sign_posn: Byte;
      int_n_sign_posn: Byte;
    end;
    {$EXTERNALSYM lconv}
    locale_t = Pointer;
    {$EXTERNALSYM locale_t}
    Plconv = ^lconv;

const
  LC_ALL = 0;
  {$EXTERNALSYM LC_ALL}
  LC_COLLATE = 1;
  {$EXTERNALSYM LC_COLLATE}
  LC_CTYPE = 2;
  {$EXTERNALSYM LC_CTYPE}
  LC_MONETARY = 3;
  {$EXTERNALSYM LC_MONETARY}
  LC_NUMERIC = 4;
  {$EXTERNALSYM LC_NUMERIC}
  LC_TIME = 5;
  {$EXTERNALSYM LC_TIME}
  LC_COLLATE_MASK   = 1;
  {$EXTERNALSYM LC_COLLATE_MASK}
  LC_CTYPE_MASK     = 2;
  {$EXTERNALSYM LC_CTYPE_MASK}
  LC_MESSAGES_MASK  = 4;
  {$EXTERNALSYM LC_MESSAGES_MASK}
  LC_MONETARY_MASK  = 8;
  {$EXTERNALSYM LC_MONETARY_MASK}
  LC_NUMERIC_MASK   = 16;
  {$EXTERNALSYM LC_NUMERIC_MASK}
  LC_TIME_MASK      = 32;
  {$EXTERNALSYM LC_TIME_MASK}
  LC_ALL_MASK = LC_COLLATE_MASK or LC_CTYPE_MASK or LC_MESSAGES_MASK or
     LC_MONETARY_MASK or LC_NUMERIC_MASK or LC_TIME_MASK;
  {$EXTERNALSYM LC_ALL_MASK}
