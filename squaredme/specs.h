#if 0
* specs.h
* process specifications
* generated by FormCalc 9.9 (7 Jun 2021) on 30-Jul-2021 8:37
#endif

#undef FCVERSION
#define FCVERSION "FormCalc 9.9 (7 Jun 2021)"

#undef PROCNAME
#define PROCNAME "S1iS1iS1i"

#undef SQUAREDME_FUNC
#define SQUAREDME_FUNC SquaredME

#undef KIN
#define KIN "1to2.F"

#undef IDENTICALFACTOR
#define IDENTICALFACTOR 2

#undef DIRACFERMIONS
#define DIRACFERMIONS 0

#undef Compose
#define Compose(f,c,A,B,C) c(c(f(A,1,1),f(B,2,2)),f(C,3,2))

#undef Generic
#define Generic(f,c) Compose(f,c,SCALAR,SCALAR,SCALAR)

#undef Anti
#define Anti(f,c) Compose(f,c,1,1,1)

#undef Mass
#define Mass(f,c) Compose(f,c,Masshh(i),Masshh(j),Masshh(k))

