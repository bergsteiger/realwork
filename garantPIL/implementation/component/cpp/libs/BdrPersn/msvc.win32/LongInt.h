/******************************************************************************

$Author: yaroslav $
  
$Modtime$
$Revision: 1.1 $

Description: Interface and implementation of template class "CLongInt"
             (MFC template class for arithmetic with very long binaries. The
             length of the binaries can be preset with the template parameter.)

             The implementation of the member functions "Divide", "operator+",
             "operator-", and "operator*" is derived from "The C++ Answer Book"
             by Tony Hansen, copyright © 1990 by AT&T Bell Telephone
             Laboratories, Incorporated.

$Log: LongInt.h,v $
Revision 1.1  2002/07/16 08:19:00  yaroslav
Modify for 5.4


******************************************************************************/

/*** Definition of the template class "CLongInt" *****************************/

template<UINT bits> class CLongInt: public CObject
{
  public:
  // sizeof(LT) must be twice as sizeof(T) !!!
  typedef USHORT T;
  typedef ULONG LT;

  enum
  {
    T_BIT  = CHAR_BIT * sizeof(T),
    T_LEN  = bits / T_BIT + (bits % T_BIT != 0),
    T_SIZE = T_LEN * sizeof(T)
  };

  // Constructors
  CLongInt()                  {}
  CLongInt(const CLongInt& u) {*this = u;}
  CLongInt(int u)             {*this = static_cast<long>(u);}
  CLongInt(UINT u)            {*this = static_cast<ULONG>(u);}

  CLongInt(long u)
  {
    ASSERT(sizeof u % sizeof(T) == 0);
    memset(m_data, u < 0 ? ~0 : 0, T_SIZE - sizeof u);
    for (int i = 1; i <= sizeof u / sizeof(T); i++)
    {
      m_data[T_LEN-i] = static_cast<T>(u);
      u             >>= T_BIT;
    }
  }

  CLongInt(ULONG u)
  {
    ASSERT(sizeof u % sizeof(T) == 0);
    memset(m_data, 0, T_SIZE - sizeof u);
    for (int i = 1; i <= sizeof u / sizeof(T); i++)
    {
      m_data[T_LEN-i] = static_cast<T>(u);
      u             >>= T_BIT;
    }
  }

  CLongInt(LPCTSTR psz, UINT nBase = 10)
  {
    ASSERT(nBase > 1 && nBase <= 36);

    bool bNeg = false;

    while (_istspace(*psz)) psz++;  // skip white-space at start of string
    switch (*psz)
    {
      case _T('-'): bNeg = true;
                    /**/
      case _T('+'): psz++;
                    break;

      default     : break;
    }
    while (_istspace(*psz)) psz++;  // skip white-space after sign character

    UINT  nDigit;
    TCHAR c;
    *this = 0;
    while ((c = static_cast<TCHAR>(_totupper(*psz++))) != _T('\0'))
    {
      if (_istdigit(c))
        nDigit = c - _T('0');
      else if (_istalpha(c))
        nDigit = c - _T('A') + 10;
      else
        break;
      if (nDigit < nBase) *this = *this * nBase + nDigit; else break;
    }
    if (bNeg) *this = -*this;
  }

  // Comparison
  int Compare(const CLongInt& v) const
  {
    if (IsNeg())
      if (v.IsNeg())
        return Compare(m_data, v.m_data, T_LEN);
      else
        return -1;
    else
      if (v.IsNeg())
        return 1;
      else
        return Compare(m_data, v.m_data, T_LEN);
  }

  // Calculate quotient and remainder
  CLongInt Divide(CLongInt v, CLongInt* pRem = 0, bool bSigned = true) const
  {
    /*
     * Divide u[1..m+n] by v[1..n] to
     * form q[0..m] and r[1..n]
     *
     * Based on:
     *
     * The Art of Computer Programming, volume 2
     * D. Knuth, Section 4.3.1, Algorithm D and
     * exercise 16.
     */
    CLongInt u(*this);
    bool     bNegQuot = false;
    bool     bNegRem  = false;

    // Make u (the dividend) positive. The sign of the remainder will match the
    // sign of the dividend.
    if (bSigned)
      if (u.IsNeg())
	    {
  	    bNegRem = true;
	      u       = -u;
	    }

    // Make v (the divisor) positive. The sign of the quotient will be negative
    // if the sign of the divisor and dividend do not match, else positive.
    if (bSigned)
      if (v.IsNeg())
	    {
  	    bNegQuot = !bNegRem;
	      v        = -v;
	    }
      else
	      bNegQuot = bNegRem;

    // set local variables
    int m_n, uoffset;
    for (m_n = T_LEN, uoffset = 0; 
         uoffset < T_LEN && u.m_data[uoffset] == 0;
	       m_n--, uoffset++)
      ;

    int n, voffset;
    for (n = T_LEN, voffset = 0;
         voffset < T_LEN && v.m_data[voffset] == 0;
	       n--, voffset++)
  	  ;

    int m = m_n - n;

    // If n == 0, then division by zero
    if (n == 0)
    {
      if (pRem) *pRem = u;
	    return u;
	  }

    // For n == 1, use simpler algorithm
    else if (n == 1)
	  {
      // See exercise 16 after Section 4.3.1
      CLongInt q(0);
      LT       prevu = 0;
      T        v1    = v.m_data[T_LEN-1];

	    for (int r = uoffset; r < m_n + uoffset; r++)
	    {
        LT t    = u.m_data[r] + (prevu << T_BIT);
        T  tmpq = static_cast<T>(t / v1);

	      q.m_data[r] = tmpq;
	      prevu       = t - v1 * tmpq;
      }

      if (pRem)
      {
        *pRem = prevu;
        if (bNegRem) *pRem = -*pRem;
      }
      return bNegQuot ? -q : q;
	  }

    // Degenerate case of length(u) < length(v) i.e., m < 0,
    // implying that u < v
    else if (m_n < n)
	  {
      if (pRem) *pRem  = bNegRem ? -u : u;
  	  return 0;
	  }

    // Degenerate case of length(u) == length(v) i.e., m == 0, possibly implying
    // that u < v or u == v
    else if (m_n == n)
	  {
      int cmp = Compare(u.m_data + uoffset, v.m_data + voffset, m_n);

	    if (cmp < 0)	// u < v
      {
        if (pRem) *pRem = bNegRem ? -u : u;
	      return 0;
      }
	    else if (cmp == 0)	// u == v
	    {
	      if (pRem) *pRem = 0;
        return bNegQuot ? -1 : 1;
	    }
	  }

    /* Now call out all of the guns from Knuth */

    /* D1(a) [Normalize.]
	   *       set d <- b/(v1+1).
     */
    LT d = (1 << T_BIT) / (v.m_data[voffset] + 1);

    /*
	   * D1(b) [Normalize.]
	   *       set (u[0]u[1]...u[m+n]) to (u[1]u[2]...u[m+n]) * d
     */
    T uu[T_LEN+1];
    T k;

    if (d == 1)
	  {
	    // copy old value
	    uu[0] = 0;
      memcpy(uu + 1, u.m_data + uoffset, m_n * sizeof(T));
	  }
    else
	  {
  	  // multiply u by d
      int i = m_n;
	    k = 0;
	    for (int Oi = m_n - 1 + uoffset; i > 0; Oi--, i--)
      {
	      LT t = u.m_data[Oi] * d + k;

	      uu[i] = static_cast<T>(t & static_cast<T>(~0));
        k     = static_cast<T>(t >> T_BIT);
      }
	    uu[i] = k;
	  }

    /*
	   * D1(c) [Normalize.]
	   *       set (v[1]v[2]...v[n]) to (v[1]v[2]...v[n]) * d
     */
    T vv[T_LEN];

    if (d == 1)
  	  // copy old value
      memcpy(vv, v.m_data + voffset, n * sizeof(T));
    else
	  {
	    // multiply v by d
	    k = 0;
      for (int Oi = n - 1 + voffset, i = n - 1; i >= 0; Oi--, i--)
      {
        LT t = v.m_data[Oi] * d + k;

	      vv[i] = static_cast<T>(t & static_cast<T>(~0));
        k     = static_cast<T>(t >> T_BIT);
      }
	  }

    /*
	   * D2 [Initialize j]
	   *    set j <- 0
     *
	   * D7 [Loop on j]
	   *    increase j by 1
	   *    loop if j <= m
     */
    T qq[T_LEN+1];

    for (int j = 0; j <= m; j++)
	  {
  	  /*
	     * D3 [Calculate q^.]
		   *    if u[j] == v[1]
		   *      set q^ <- b - 1
		   *    else
		   *      set q^ <- (u[j] * b + u[j+1]) / v[1]
		   *    while v[2] * q^ > (u[j] * b + u[j+1] - q^ * v[1]) * b + u[j+2]
		   *      set q^ <- q^ - 1
	     */
	    LT q_hat;
      LT u_j_j1 = (static_cast<LT>(uu[j]) << T_BIT) + uu[j+1];

	    if (uu[j] == vv[0])
        q_hat = static_cast<T>(~0);
	    else
        q_hat = u_j_j1 / vv[0];

      // The following statements implement the while loop in the comment above
      // somewhat tricky. The reason is to recognize if the expression
      // "(u[j] * b + u[j+1] - q^ * v[1]) * b" will exceed the size of LT.
      for (;; q_hat--)
      {
        LT t = u_j_j1 - q_hat * vv[0];

        if (t >> T_BIT != 0) break;
        if (vv[1] * q_hat <= (t << T_BIT) + uu[j+2]) break;
      }

		  /*
       * D4 [Multiply and subtract.]
       *    replace u[j..j+n] by u[j..j+n] - q^ * v[1..n]
       */

		  // set nv <- q^ * (v[1..n])
		  T   nv[T_LEN+1];
      int dl = n;
	    k = 0;
	    for (int vl = n-1; vl >= 0; vl--)
	    {
	      LT t = vv[vl] * q_hat + k;

	      nv[dl--] = static_cast<T>(t & static_cast<T>(~0));
	      k        = static_cast<T>(t >> T_BIT);
      }
	    nv[0] = k;

  	  // subtract nv[0..n] from u[j..j+n]
	    T   borrow = 0;
	    int ul     = j + n;

	    for (dl = n; dl >= 0; dl--)
      {
	      LT t = uu[ul];
      
        t       -= nv[dl];
        t       -= borrow;
	      uu[ul--] = static_cast<T>(t & static_cast<T>(~0));
	      borrow   = (t >> T_BIT) != 0;
      }

	    /*
	     * D5 [Test remainder.]
		   *    set q[j] <- q^
		   *    if u[j] < 0, goto D6
       *
	     * D6 [Add back.]
		   *     add 0v[1..n] back to u[j..j+n]
		   *     decrease q[j] by 1
	     */
	    qq[j] = static_cast<T>(q_hat & static_cast<T>(~0));
  	  if (borrow != 0)
	    {
        int vl;
	      for (k = 0, ul = j + n, vl = n - 1; vl >= 0; vl--, ul--)
		    {
    		  LT t = uu[ul];
        
          t     += vv[vl];
          t     += k;
		      uu[ul] = static_cast<T>(t & static_cast<T>(~0));
          k      = static_cast<T>(t >> T_BIT);
		    }

	      uu[j] = static_cast<T>((uu[j] + k) & static_cast<T>(~0));
	      qq[j]--;
	    }
	  }

    /*
	   * D8 [Unnormalize]
	   *     q[0..m] is quotient
	   *     u[m+1..m+n] / d is remainder
     */
    CLongInt q(0);
    memcpy(q.m_data + T_LEN-1 - m, qq, (m+1) * sizeof(T));

    // divide u[m+1..m+n] by d
    if (pRem)
    {
      *pRem = 0;

      if (d == 1)		// nothing special to do
        memcpy(pRem->m_data + T_LEN - n, uu + m + 1, n * sizeof(T));
      else
	    {
  	    LT prevu = 0;

  	    // do division by single digit
	      for (int rl = T_LEN - n, ul = m + 1; ul <= m_n; ul++, rl++)
        {
	        LT t = uu[ul] + (prevu << T_BIT);

	        pRem->m_data[rl] = static_cast<T>(t / d);
	        prevu            = t - d * pRem->m_data[rl];
	      }
	    }

      if (bNegRem) *pRem = -*pRem;
    }

    return bNegQuot ? -q : q;;
  }

  // Convert to int
  int ToInt() const {return static_cast<int>(ToLong());}

  // Convert to long
  long ToLong() const
  {
    ASSERT(sizeof(long) % sizeof(T) == 0);
    long w = 0;
    for (int i = sizeof(long) / sizeof(T); i > 0; i--)
      w = (w << T_BIT) + m_data[T_LEN-i];
    return w;
  }

  // Convert to string
  CString ToString(UINT nBase = 10) const
  {
    ASSERT(nBase > 1 && nBase <= 36);

    if (Compare(0) == 0) return _T("0");

    CLongInt w(*this);
    bool     bSign = false;
    CString  str;

    if (nBase == 10 && w.IsNeg())
    {
      w     = -w;
      bSign = true;
    }

    while (w.Compare(0) != 0)
    {
      CLongInt rem;
      w = w.Divide(nBase, &rem, false);
      UINT nDigit = rem.ToUINT();

      if (nDigit < 10)
        str = static_cast<TCHAR>(nDigit + T('0')) + str;
      else
        str = static_cast<TCHAR>(nDigit - 10 + T('A')) + str;
    }
    if (bSign) str = _T('-') + str;

    return str;
  }

  // Convert to unsigned int
  UINT ToUINT() const {return static_cast<UINT>(ToLong());}

  // Convert to unsigned long
  ULONG ToULONG() const {return static_cast<ULONG>(ToLong());}

  // Unary operators
        bool      operator!() const {return Compare(0) == 0;}
  const CLongInt& operator+() const {return *this;}
        CLongInt  operator-() const {return ~*this + 1;}

  // 1's complement
  CLongInt operator~() const
  {
    CLongInt w;
    for (int i = 0; i < T_LEN; i++) w.m_data[i] = static_cast<T>(~m_data[i]);
    return w;
  }

  // Increment and decrement operators
  const CLongInt& operator++()    {return *this += 1;}
        CLongInt  operator++(int) {CLongInt w(*this); *this += 1; return w;}
  const CLongInt& operator--()    {return *this -= 1;}
        CLongInt  operator--(int) {CLongInt w(*this); *this -= 1; return w;}

  // Assignment operators
  CLongInt& operator=(const CLongInt& u)
  {
    if (u != this) memcpy(m_data, u.m_data, T_SIZE);
    return *this;
  }

  CLongInt& operator+= (const CLongInt& u) {return *this = *this + u;}
  CLongInt& operator-= (const CLongInt& u) {return *this = *this - u;}
  CLongInt& operator*= (const CLongInt& u) {return *this = *this * u;}
  CLongInt& operator/= (const CLongInt& u) {return *this = Divide(u);}
  CLongInt& operator%= (const CLongInt& u) {Divide(u, this); return *this;}
  CLongInt& operator<<=(int u)             {return *this = *this << u;}
  CLongInt& operator>>=(int u)             {return *this = *this >> u;}
  CLongInt& operator&= (const CLongInt& u) {return *this = *this & u;}
  CLongInt& operator|= (const CLongInt& u) {return *this = *this | u;}
  CLongInt& operator^= (const CLongInt& u) {return *this = *this ^ u;}

  // Binary operators

  // Addition
  CLongInt operator+(const CLongInt& v) const
  {
    /*
     * Add u[1..n] + v[1..n] to form w[0..n]
     *
     * Based on:
     *
     * The Art of Computer Programming, volume 2
     * D. Knuth, Section 4.3.1, Algorithm A
     *
     *  modified to ignore w[0]
     */
    CLongInt w;

    /*
	   * A1 [Initialize]
	   *    set j <- n
	   *  	k <- 0
     */
    T k = 0;
    for (int j = CLongInt<bits>::T_LEN-1;;)
	  {
	    /*
	     * A2(a) [Add digits]
		   *       set w[j] <- (u[j] + v[j] + k) mod b
	     */
      LT t = m_data[j];

	    t          += v.m_data[j];
	    t          += k;
      w.m_data[j] = static_cast<T>(t & static_cast<T>(~0));

	    /*
	     * A3 [Loop on j]
		   *    decrease j by one
	     */
	    if (--j < 0) break;

	    /*
	     *  A2(b)
		   *  set k <- (u[j] + v[j] + k) / b
	     */
      k = static_cast<T>(t >> T_BIT);
	  }

    return w;
  }

  // Subtraction
  CLongInt operator-(const CLongInt& v) const
  {
    /*
     * Subtract u[1..n] - v[1..n] to form w[0..n]
     *
     * The Art of Computer Programming, volume 2
     * D. Knuth, Section 4.3.1, Algorithm S
     */
    CLongInt w;

    /*
     * S1 [Initialize.]
	   *    set j <- n
	   *      	k <- 0
     */
    T k = 0;
    for (int j = T_LEN-1;;)
	  {
	    /*
	     * S2(a) [Subtract digits.]
		   *       set w[j] <- (u[j] - v[j] + k) mod b
	     */
	    LT t = m_data[j];

	    t          -= v.m_data[j];
	    t          -= k;
	    w.m_data[j] = static_cast<T>(t);

	    /*
	     * S3 [Loop on j.]
		   *    decrease j by one
	     */
	    if (--j < 0) break;

	    /*
	     * S2(b)
	     *       set k <- (u[j] - v[j] + k) / b
	     */
      k = (t >> T_BIT) != 0;
	  }

    return w;
  }

  // Multiplication
  CLongInt operator*(CLongInt v) const
  {
    /*
     * Multiply u[1..n] * v[1..m] to form w[0..m+n]
     *
     * Based on:
     *
     * The Art of Computer Programming, volume 2
     * D. Knuth, Section 4.3.1, Algorithm M
     *
     * modified to ignore w[0..m]
     */
    CLongInt u(*this);
    bool     bNegResult = false;

	  // Make u positive
    if (u.IsNeg())
	  {
	    bNegResult = !bNegResult;
	    u          = -u;
	  }

    // Make v positive
    if (v.IsNeg())
	  {
	    bNegResult = !bNegResult;
	    v          = -v;
	  }

    /*
	   * M1(a) [Initialize]
	   *       set w[m+1..m+n] <- 0
	   *       { modified: set w[0..n] <- 0 }
     */
    CLongInt w(0);

    /*
	   * M1(b) [Initialize]
	   *       set j <- m
	   * M6    [Loop on j]
	   *       decrease j by one
	   *       if j > 0, goto M2
     */
    for (int j = T_LEN-1; j >= 0; j--)
	  {
	    /*
	     * M2 [Zero multiplier?]
		   *    if v[j] == 0
		   *      set w[j] <- 0
		   *      goto M6
	     *    { modified: skip w[j] since 0<=j<m }
	     */
	    if (v.m_data[j] != 0)
      {
	      /*
		     * M3 [Initialize i]
		     *    set i <- n,
			   *        k <- 0
		     * M5(a) [Loop on i]
		     *       decrease i by one
		     *       if i > 0, goto M4
		     *       { modified: loop on i+j > 0, i+j<n }
	       */
        T k = 0;
        for (int i = T_LEN-1, iplusj = i + j - (T_LEN-1);
             iplusj >= 0;
             i--, iplusj--)
  		  {
		      /*
		       * M4 [multiply and add]
			     *    set t <- u[i] * v[j] + w[i+j] + k
			     *        w[i+j] <- t % b
			     *        k <- t / b
		       *    { modified: i+j tracks i }
		       */
          LT t =
            u.m_data[i] * static_cast<LT>(v.m_data[j]) + w.m_data[iplusj] + k;

          w.m_data[iplusj] = static_cast<T>(t & static_cast<T>(~0));
          k                = static_cast<T>(t >> T_BIT);
		    }

	      /*
		     * M5(b) [Loop on i]
		     *       if i <= 0,
			   *       set w[j] <- k
		     *       { modified: skip setting w[j], since j<m }
	       */
      }
	  }

    // restore sign
    return bNegResult ? -w : w;
  }

  // Division
  CLongInt operator/(const CLongInt& v) const {return Divide(v);}

  // Modulo
  CLongInt operator%(const CLongInt& v) const
  {
    CLongInt rem;
    Divide(v, &rem);
    return rem;
  }

  // Binary And
  CLongInt operator&(const CLongInt& v) const
  {
    CLongInt w;
    for (int i = 0; i < T_LEN; i++)
      w.m_data[i] = static_cast<T>(m_data[i] & v.m_data[i]);
    return w;
  }

  // Binary Or
  CLongInt operator|(const CLongInt& v) const
  {
    CLongInt w;
    for (int i = 0; i < T_LEN; i++)
      w.m_data[i] = static_cast<T>(m_data[i] | v.m_data[i]);
    return w;
  }

  // Binary Xor
  CLongInt operator^(const CLongInt& v) const
  {
    CLongInt w;
    for (int i = 0; i < T_LEN; i++)
      w.m_data[i] = static_cast<T>(m_data[i] ^ v.m_data[i]);
    return w;
  }

  // Left shift
  CLongInt operator<<(int n) const
  {
    if (n < 0)
      return *this >> -n;
    else if (n == 0)
      return *this;
    else if (n < bits)
    {
      CLongInt w;

      const int nb   = (bits - n) % T_BIT;
      const int nw   = (bits - n - 1) / T_BIT;
      const int off  = n / T_BIT;
            T   mask = 0;

      if (nb != 0) mask = static_cast<T>(static_cast<T>(~0) >> nb);

      n %= T_BIT;
      // copy full digits
      if (n != 0)
      {
        for (int i = -1; ++i < nw;)
          w.m_data[i] = 
            static_cast<T>((m_data[i + off] << n |
              m_data[i + off + 1] >> (T_BIT - n)) & static_cast<T>(~0));
        w.m_data[nw] =
          static_cast<T>((m_data[nw + off] << n) & static_cast<T>(~0));
      }
      else
        memcpy(w.m_data, m_data + off, (nw + 1) * sizeof(T));

      // merge copied partial last digit with zeroes
      if (nb != 0) w.m_data[nw] &= ~mask;

      // fill rest of number with zeroes
      memset(w.m_data + nw + 1, 0, (T_LEN - nw - 1) * sizeof(T));

      return w;
    }
    else
      return 0;
  }

  // Right shift
  CLongInt operator>>(int n) const
  {
    if (n < 0)
      return *this << -n;
    else if (n == 0)
      return *this;
    else if (n < bits)
    {
      CLongInt w;

            int p0  = n;
      const int nl  = (n - 1) / T_BIT;
      const int off = -nl - 1;

      p0 %= T_BIT;
      if (p0 == 0)
        // copy full digits
        memcpy(w.m_data + nl + 1, m_data, ((bits - n) / T_BIT) * sizeof(T));
      else
      {
        // copy full digits shifted by p0 bits
        for (int i = T_LEN-1; i > nl; i--)
          w.m_data[i] =
            static_cast<T>((m_data[i + off] << (T_BIT - p0) |
              m_data[i + off + 1] >> p0) & static_cast<T>(~0));

        // copy partial digit at start shifted by nDstIndex % T_BIT bits
        w.m_data[nl] = static_cast<T>(m_data[0] >> p0);
        if (IsNeg()) w.m_data[nl] |= ~0 << (T_BIT - p0);
      }

      // fill start of number with 0's or 1's
      memset(w.m_data, IsNeg() ? ~0 : 0, (n / T_BIT) * sizeof(T));

      return w;
    }
    else
      return IsNeg() ? ~0 : 0;
  }

  // Comparison operators
  bool operator< (const CLongInt& v) const {return Compare(v) <  0;}
  bool operator<=(const CLongInt& v) const {return Compare(v) <= 0;}
  bool operator==(const CLongInt& v) const {return Compare(v) == 0;}
  bool operator!=(const CLongInt& v) const {return Compare(v) != 0;}
  bool operator>=(const CLongInt& v) const {return Compare(v) >= 0;}
  bool operator> (const CLongInt& v) const {return Compare(v) >  0;}

  friend CLongInt operator+ (long  u, const CLongInt& v);
  friend CLongInt operator+ (ULONG u, const CLongInt& v);
  friend CLongInt operator- (long  u, const CLongInt& v);
  friend CLongInt operator- (ULONG u, const CLongInt& v);
  friend CLongInt operator* (long  u, const CLongInt& v);
  friend CLongInt operator* (ULONG u, const CLongInt& v);
  friend CLongInt operator/ (long  u, const CLongInt& v);
  friend CLongInt operator/ (ULONG u, const CLongInt& v);
  friend CLongInt operator% (long  u, const CLongInt& v);
  friend CLongInt operator% (ULONG u, const CLongInt& v);
  friend CLongInt operator& (long  u, const CLongInt& v);
  friend CLongInt operator& (ULONG u, const CLongInt& v);
  friend CLongInt operator| (long  u, const CLongInt& v);
  friend CLongInt operator| (ULONG u, const CLongInt& v);
  friend CLongInt operator^ (long  u, const CLongInt& v);
  friend CLongInt operator^ (ULONG u, const CLongInt& v);
  friend bool     operator< (long  u, const CLongInt& v);
  friend bool     operator< (ULONG u, const CLongInt& v);
  friend bool     operator<=(long  u, const CLongInt& v);
  friend bool     operator<=(ULONG u, const CLongInt& v);
  friend bool     operator==(long  u, const CLongInt& v);
  friend bool     operator==(ULONG u, const CLongInt& v);
  friend bool     operator!=(long  u, const CLongInt& v);
  friend bool     operator!=(ULONG u, const CLongInt& v);
  friend bool     operator>=(long  u, const CLongInt& v);
  friend bool     operator>=(ULONG u, const CLongInt& v);
  friend bool     operator> (long  u, const CLongInt& v);
  friend bool     operator> (ULONG u, const CLongInt& v);

  // Cast operators
  operator LPCVOID() const {return m_data;}
  operator LPVOID ()       {return m_data;}

  T m_data[T_LEN];

  private:
  static int Compare(const T* p1, const T* p2, int n)
  {
    if (p1 != p2)
      while (--n >= 0)
        if (*p1++ != *p2++) return p1[-1] > p2[-1] ? 1 : -1;

    return 0;
  }

  bool IsNeg() const {return (m_data[0] & 1 << (T_BIT - 1)) != 0;}
};

/*** Addition ****************************************************************/
template<UINT bits> CLongInt<bits> operator+(long u, const CLongInt<bits>& v)
{
  return v + u;
}

template<UINT bits> CLongInt<bits> operator+(ULONG u, const CLongInt<bits>& v)
{
  return v + u;
}

/*** Subtraction *************************************************************/
template<UINT bits> CLongInt<bits> operator-(long u, const CLongInt<bits>& v)
{
  CLongInt<bits> uv(u);
  return uv - v;
}

template<UINT bits> CLongInt<bits> operator-(ULONG u, const CLongInt<bits>& v)
{
  CLongInt<bits> uv(u);
  return uv - v;
}

/*** Multiplication **********************************************************/
template<UINT bits> CLongInt<bits> operator*(long u, const CLongInt<bits>& v)
{
  return v * u;
}

template<UINT bits> CLongInt<bits> operator*(ULONG u, const CLongInt<bits>& v)
{
  return v * u;
}

/*** Division ****************************************************************/
template<UINT bits> CLongInt<bits> operator/(long u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) / v;
}

template<UINT bits> CLongInt<bits> operator/(ULONG u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) / v;
}

/*** Modulo ******************************************************************/
template<UINT bits> CLongInt<bits> operator%(long u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) % v;
}

template<UINT bits> CLongInt<bits> operator%(ULONG u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) % v;
}

/*** Binary And **************************************************************/
template<UINT bits> CLongInt<bits> operator&(long u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) & v;
}

template<UINT bits> CLongInt<bits> operator&(ULONG u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) & v;
}

/*** Binary Or ***************************************************************/
template<UINT bits> CLongInt<bits> operator|(long u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) | v;
}

template<UINT bits> CLongInt<bits> operator|(ULONG u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) | v;
}

/*** Binary Xor **************************************************************/
template<UINT bits> CLongInt<bits> operator^(long u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) ^ v;
}

template<UINT bits> CLongInt<bits> operator^(ULONG u, const CLongInt<bits>& v)
{
  return CLongInt<bits>(u) ^ v;
}

/*** Comparison operators ****************************************************/
template<UINT bits> bool operator<(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) > 0;
}

template<UINT bits> bool operator<(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) > 0;
}

template<UINT bits> bool operator<=(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) >= 0;
}

template<UINT bits> bool operator<=(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) >= 0;
}

template<UINT bits> bool operator==(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) == 0;
}

template<UINT bits> bool operator==(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) == 0;
}

template<UINT bits> bool operator!=(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) != 0;
}

template<UINT bits> bool operator!=(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) != 0;
}

template<UINT bits> bool operator>=(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) <= 0;
}

template<UINT bits> bool operator>=(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) <= 0;
}

template<UINT bits> bool operator>(long u, const CLongInt<bits>& v)
{
  return v.Compare(u) < 0;
}

template<UINT bits> bool operator>(ULONG u, const CLongInt<bits>& v)
{
  return v.Compare(u) < 0;
}
