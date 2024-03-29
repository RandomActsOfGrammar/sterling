grammar sos:testing:concConcreteSyntax;

imports sos:core:common:concreteSyntax;
imports sos:core:concreteDefs:concreteSyntax;
imports sos:testing:abstractSyntax;

terminal Error_t      'Error'      lexer classes {KEYWORD};
terminal Warning_t    'Warning'    lexer classes {KEYWORD};
terminal Expected_t   'Expected'   lexer classes {KEYWORD};
terminal LCurly_t     '{';
terminal RCurly_t     '}';

concrete productions top::TopDecl_c
| 'Error' EmptyNewlines 'Expected' EmptyNewlines s::String_t
  EmptyNewlines '{' EmptyNewlines decls::TopDeclList_c '}'
  { top.ast = errorExpectedConcreteDecls(
                 substring(1, length(s.lexeme) - 1, s.lexeme),
                 decls.ast, location=top.location); }
| 'Warning' EmptyNewlines 'Expected' EmptyNewlines s::String_t
  EmptyNewlines '{' EmptyNewlines decls::TopDeclList_c '}'
  { top.ast = warningExpectedConcreteDecls(
                 substring(1, length(s.lexeme) - 1, s.lexeme),
                 decls.ast, location=top.location); }
