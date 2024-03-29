grammar sos:translation:semantic:prolog;


attribute prolog<PrologTerm>, pcVar occurs on Term;

aspect production const
top::Term ::= name::QName
{
  top.prolog =
      constPrologTerm("constr___" ++ if name.isQualified
                                     then name.prolog
                                     else name.fullConstrName.prolog);

  top.pcVar = error("Cannot access pcVar on const");
}


aspect production var
top::Term ::= name::String
{
  top.prolog = varPrologTerm(name);

  top.pcVar = name;
}


aspect production num
top::Term ::= i::Integer
{
  top.prolog = integerPrologTerm(i);

  top.pcVar = error("Cannot access pcVar on num");
}


aspect production stringConst
top::Term ::= s::String
{
  top.prolog = stringPrologTerm(s);

  top.pcVar = error("Cannot access pcVar on stringConst");
}


aspect production appTerm
top::Term ::= constructor::QName args::TermList
{
  top.prolog =
      applicationTerm("constr___" ++
                      if constructor.isQualified
                      then constructor.prolog
                      else constructor.fullConstrName.prolog,
                      args.prolog);

  top.pcVar = error("Cannot access pcVar on appTerm");
}


aspect production tupleTerm
top::Term ::= contents::TermList
{
  top.prolog = tuplePrologTerm(contents.prolog);

  top.pcVar = error("Cannott access pcVar on tupleTerm");
}


aspect production nilTerm
top::Term ::=
{
  top.prolog = nilPrologTerm();
  top.pcVar = error("Cannot access pcVar on nilTerm");
}


aspect production consTerm
top::Term ::= hd::Term tl::Term
{
  top.prolog = consPrologTerm(hd.prolog, tl.prolog);
  top.pcVar = error("Cannot access pcVar on consTerm");
}


aspect production ascriptionTerm
top::Term ::= tm::Term ty::Type
{
  top.prolog = tm.prolog;

  top.pcVar = tm.pcVar;
}





attribute prolog<PrologTermList>, pcVar occurs on TermList;

aspect production nilTermList
top::TermList ::=
{
  top.prolog = nilPrologTermList();

  top.pcVar = error("pcVar cannot come from nilTermList");
}


aspect production consTermList
top::TermList ::= t::Term rest::TermList
{
  top.prolog = consPrologTermList(t.prolog, rest.prolog);

  top.pcVar =
      case top.expectedPC of
      | just(0) -> t.pcVar
      | _ -> rest.pcVar
      end;
}

